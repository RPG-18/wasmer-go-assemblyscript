package wasmer_go_assemblyscript

import (
	"fmt"
	"log"

	"github.com/wasmerio/wasmer-go/wasmer"
)

func Log(memory *wasmer.Memory, args []wasmer.Value) ([]wasmer.Value, error) {
	ptr := int64(args[0].I32())
	print(ToString(memory, ptr))
	return nil, nil
}

func Abort(memory *wasmer.Memory, args []wasmer.Value) ([]wasmer.Value, error) {
	var (
		msg      string
		fileName string
	)
	if msgPtr := int64(args[0].I32()); msgPtr != 0 {
		msg = ToString(memory, msgPtr)
	}
	if fileNamePtr := int64(args[1].I32()); fileNamePtr != 0 {
		fileName = ToString(memory, fileNamePtr)
	}

	line := int(args[2].I32())
	column := int(args[3].I32())
	log.Printf("abort msgL: %s, file: %s, line:%d, column: %d", msg, fileName, line, column)
	return nil, fmt.Errorf("abort msgL: %s, file: %s, line:%d, column: %d", msg, fileName, line, column)
}
