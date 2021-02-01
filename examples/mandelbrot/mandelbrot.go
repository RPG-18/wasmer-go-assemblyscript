package mandelbrot

import (
	"fmt"
	"io/ioutil"
	"math"
	helpers "wasmer-go-assemblyscript"

	"github.com/wasmerio/wasmer-go/wasmer"
)

const (
	NumColors = 2048
)

var (
	globalInstane *wasmer.Instance
)

func init() {
	wasmBytes, err := ioutil.ReadFile("../wasm/optimized.wasm")
	if err != nil {
		panic(err)
	}

	engine := wasmer.NewNativeEngine()
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
}

func min(a, b uint32) uint32 {
	if a < b {
		return a
	}
	return b
}

func fmin(a, b float64) float64 {
	if a < b {
		return a
	}
	return b
}

func fmax(a, b float64) float64 {
	if a > b {
		return a
	}
	return b
}

func fclam(value, minValue, maxValue float64) float64 {
	return fmin(fmax(value, minValue), maxValue)
}

//go:noinline
func Naive(width, height, limit uint32, out []byte) {
	translateX := float64(width) * (1.0 / 1.6)
	translateY := float64(height) * (1.0 / 2.0)
	scale := 10.0 / float64(min(3*width, 4*height))
	realOffset := translateX * scale
	invLimit := 1.0 / float64(limit)

	minIterations := min(8, limit)
	for y := uint32(0); y < height; y++ {
		imaginary := (float64(y) - translateY) * scale
		yOffset := (y * width) << 1

		for x := uint32(0); x < width; x++ {
			real := float64(x)*scale - realOffset

			ix := 0.0
			iy := 0.0
			var ixSq, iySq float64
			iteration := uint32(0)
			for ixSq+iySq <= 4.0 {
				iy = 2.0*ix*iy + imaginary
				ix = ixSq - iySq + real
				if iteration >= limit {
					break
				}
				ixSq = ix * ix
				iySq = iy * iy
				iteration++
			}

			for iteration < minIterations {
				ixNew := ix*ix - iy*iy + real
				iy = 2.0*ix*iy + imaginary
				ix = ixNew
				iteration++
			}

			colorIndex := uint16(NumColors - 1)
			distanceSq := ix*ix + iy*iy
			if distanceSq > 1.0 {
				fraction := math.Log2(0.5 * math.Log(distanceSq))
				colorIndex = uint16((NumColors - 1) * fclam((float64(iteration)+1-fraction)*invLimit, 0.0, 1.0))
			}
			offset := yOffset + (x << 1)
			out[offset] = byte(colorIndex & 0xFFFF)
			out[offset+1] = byte(colorIndex >> 8)
		}
	}
}

//go:noinline
func Assembly(width, height, limit int32, out []byte) {
	handler, err := globalInstane.Exports.GetRawFunction("update")
	if err != nil {
		panic(fmt.Sprintln("failed to get raw function:", err))
	}
	_, err = handler.Call(width, height, limit)
	if err != nil {
		panic(fmt.Sprintln("Failed to call the `update` function natively:", err))
	}
	memory, err := globalInstane.Exports.GetMemory("memory")
	if err != nil {
		panic(fmt.Sprintf("failed get memory: %v", err))
	}
	copy(out, memory.Data()[0:4147200])
}
