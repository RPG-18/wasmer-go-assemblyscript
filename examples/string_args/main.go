package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"time"
	helpers "wasmer-go-assemblyscript"

	"github.com/wasmerio/wasmer-go/wasmer"
)

var callCount int

func init() {
	flag.IntVar(&callCount, "call", 1, "number of calls")
	flag.Parse()
}

func main() {
	var globalInstane *wasmer.Instance
	wasmBytes, err := ioutil.ReadFile("examples/wasm/optimized.wasm")
	if err != nil {
		panic(err)
	}

	engine := wasmer.NewEngine()
	store := wasmer.NewStore(engine)

	fmt.Println("Compiling module...")
	module, err := wasmer.NewModule(store, wasmBytes)
	if err != nil {
		panic(fmt.Sprintln("failed to compile module:", err))
	}

	log := wasmer.NewFunction(store,
		wasmer.NewFunctionType(wasmer.NewValueTypes(wasmer.I32), wasmer.NewValueTypes()),
		func(args []wasmer.Value) ([]wasmer.Value, error) {
			memory, err := globalInstane.Exports.GetMemory("memory")
			if err != nil {
				panic(fmt.Sprintln("failed get memory:", err))
			}
			return helpers.Log(memory, args)
		},
	)

	importObject := wasmer.NewImportObject()
	importObject.Register("go",
		map[string]wasmer.IntoExtern{
			"console.log": log,
		})

	fmt.Println("instantiating module...")
	instance, err := wasmer.NewInstance(module, importObject)
	if err != nil {
		panic(fmt.Sprintln("failed to instantiate the module:", err))
	}

	globalInstane = instance
	memory, err := globalInstane.Exports.GetMemory("memory")
	if err != nil {
		panic(fmt.Sprintf("failed get memory: %v", err))
	}

	shm, err := helpers.NewSharedMemory(memory.Data(), 4096)
	if err != nil {
		panic(err)
	}

	handler, err := instance.Exports.GetRawFunction("say")
	if err != nil {
		panic(fmt.Sprintln("failed to get raw function:", err))
	}

	say := handler.Native()

	fmt.Println("Calling `say` function...")
	for i := 0; i < callCount; i++ {
		ts := time.Now()
		shm.Reset()
		ptr, _ := shm.WriteString(fmt.Sprintf("%d: Hello World!", i))
		_, err = say(ptr)
		fmt.Println("call duration", time.Since(ts))
		if err != nil {
			panic(fmt.Sprintln("Failed to call the `say` function:", err))
		}
	}
}
