package wasmer_go_assemblyscript

import (
	"errors"
	"fmt"
	"unicode/utf16"
)

var (
	ErrInvalidMemorySize = errors.New("invalid memory size")
	ErrNotEnoughMemory   = errors.New("not enough memory")
)

// Helper for read/write to reserved memory
//
// https://www.assemblyscript.org/memory.html#memory-regions
type SharedMemory struct {
	mem    []byte
	size   int
	offset int64
}

// WriteString write string and return pointer
func (s *SharedMemory) WriteString(str string) (ptr int64, err error) {
	size := len(str) * 2
	need := int(s.offset) + size
	if need > s.size {
		return 0, fmt.Errorf("need %d, available %d, all %d :%w",
			need,
			int64(s.size)-s.offset,
			s.size,
			ErrNotEnoughMemory)
	}

	data := utf16.Encode([]rune(str))
	pair := make([]byte, 2)
	ptr = s.offset<<32 | int64(size)
	for _, rune := range data {
		LE.PutUint16(pair, rune)
		copy(s.mem[s.offset:], pair)
		s.offset += 2
	}

	return
}

// NewSharedMemory create wrapper from vm.Memory
func NewSharedMemory(memory []byte, size int) (*SharedMemory, error) {
	if size > len(memory) {
		return nil, fmt.Errorf("size %d, actual size %d: %w", size, len(memory), ErrInvalidMemorySize)
	}

	return &SharedMemory{
		mem:  memory,
		size: size,
	}, nil
}

func (s *SharedMemory) Reset() {
	s.offset = 0
}
