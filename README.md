# wasmer-go-assemblyscript
Examples wasmer-go with AssemblyScript

### hello
Implementation host function and read AssemblyScript

### string_args
Copy Go string to AssemblyScript through [reserved memory](https://www.assemblyscript.org/memory.html#importing-memory)

### overhead
Cost on call function
```
BenchmarkIncr-12              	  999562	      1155 ns/op
BenchmarkEmptyFunction-12     	 1000000	      1147 ns/op
BenchmarkEmptyCFunction-12    	37699389	        31.8 ns/op
```

### mandelbrot
Benchmark calculate mandlebrot(1920x1080) 
![mandelbrot](mandelbrot-g16.png)
```
enchmarkNaive-12       	       7	 143808614 ns/op	       0 B/op	       0 allocs/op
BenchmarkAssembly-12    	      10	 107641327 ns/op	     457 B/op	      16 allocs/op
```

GCCGO on Ryzen 3600
```
$ go test -compiler=gccgo -gccgoflags='-O3 -march=native' -bench=.
goos: linux
goarch: amd64
pkg: wasmer-go-assemblyscript/examples/mandelbrot
BenchmarkNaive-12       	       9	 114855350 ns/op
BenchmarkAssembly-12    	      10	 107259428 ns/op
```