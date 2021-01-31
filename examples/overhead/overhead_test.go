package overhead

import "testing"

func BenchmarkIncr(b *testing.B) {
	for i := 0; i < 10; i++ {
		Incr()
	}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		Incr()
	}
	b.StopTimer()
}

func BenchmarkEmptyFunction(b *testing.B) {
	for i := 0; i < 10; i++ {
		EmptyFunction()
	}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		EmptyFunction()
	}
}

func BenchmarkEmptyCFunction(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		EmptyCFunction()
	}
}
