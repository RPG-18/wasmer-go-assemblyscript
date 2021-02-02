package main

import (
	"encoding/binary"
	"fmt"
	"io/ioutil"
	"runtime"
	"time"
	helpers "wasmer-go-assemblyscript"

	"github.com/wasmerio/wasmer-go/wasmer"
)

func main() {
	var globalInstane *wasmer.Instance
	wasmBytes, err := ioutil.ReadFile("examples/wasm/optimized.wasm")
	if err != nil {
		panic(err)
	}

	engine := wasmer.NewEngine()
	store := wasmer.NewStore(engine)

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
	handler, err := instance.Exports.GetRawFunction("infinityLoop")
	if err != nil {
		panic(fmt.Sprintln("failed to get raw function:", err))
	}

	go func() {
		time.Sleep(time.Millisecond * 100)
		memory, err := globalInstane.Exports.GetMemory("memory")
		if err != nil {
			panic(err)
		}
		fmt.Println("canceling")
		binary.LittleEndian.PutUint64(memory.Data(), 1)
	}()
	infinityLoop := handler.Native()
	tm := time.Now()
	_, err = infinityLoop()
	if err != nil {
		panic(err)
	}
	runtime.KeepAlive(log)
	fmt.Println("exit", time.Since(tm))
}
