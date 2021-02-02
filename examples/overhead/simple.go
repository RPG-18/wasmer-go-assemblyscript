package overhead

import (
	"fmt"
	"io/ioutil"
	helpers "wasmer-go-assemblyscript"

	"github.com/wasmerio/wasmer-go/wasmer"
)

var (
	globalInstane *wasmer.Instance
	engine        *wasmer.Engine
	store         *wasmer.Store
	module        *wasmer.Module
)

func init() {
	wasmBytes, err := ioutil.ReadFile("../wasm/optimized.wasm")
	if err != nil {
		panic(err)
	}

	engine = wasmer.NewNativeEngine()
	store = wasmer.NewStore(engine)

	fmt.Println("Compiling module...")
	module, err = wasmer.NewModule(store, wasmBytes)
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
}

func EmptyFunction() {
	handler, err := globalInstane.Exports.GetRawFunction("empty")
	if err != nil {
		panic(fmt.Sprintln("failed to get raw function:", err))
	}
	_, err = handler.Call()
	if err != nil {
		panic(fmt.Sprintln("failed to call the `update` function natively:", err))
	}
}

func Incr() {
	handler, err := globalInstane.Exports.GetRawFunction("increment")
	if err != nil {
		panic(fmt.Sprintln("failed to get raw function:", err))
	}
	_, err = handler.Call()
	if err != nil {
		panic(fmt.Sprintln("failed to call the `update` function natively:", err))
	}
}

func PrintCount() {
	handler, err := globalInstane.Exports.GetRawFunction("printCount")
	if err != nil {
		panic(fmt.Sprintln("failed to get raw function:", err))
	}
	_, err = handler.Call()
	if err != nil {
		panic(fmt.Sprintln("failed to call the `update` function natively:", err))
	}
}
