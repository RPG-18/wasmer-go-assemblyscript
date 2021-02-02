package wasmer_go_assemblyscript

import (
	"bytes"
	"encoding/binary"
	"unicode/utf16"

	"github.com/wasmerio/wasmer-go/wasmer"
)

var (
	LE = binary.LittleEndian
)

const (
	SizeOffset = -4
)

// ToString read string by pointer
// https://www.assemblyscript.org/memory.html#internals
func ToString(memory *wasmer.Memory, ptr int64) string {
	data := memory.Data()
	len := LE.Uint32(data[ptr+SizeOffset:]) >> 1
	buf := bytes.NewReader(data[ptr:])

	tmp := make([]uint16, 0, len)
	for i := uint32(0); i < len; i++ {
		var j uint16
		_ = binary.Read(buf, LE, &j)
		tmp = append(tmp, j)
	}
	return string(utf16.Decode(tmp))
}
