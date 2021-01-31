package mandelbrot

import (
	"fmt"
	"image"
	"image/png"
	"os"
	"testing"
	"time"
)

func TestNaive(t *testing.T) {
	img := image.NewGray16(image.Rect(0, 0, 1920, 1080))
	for i := 0; i < 10; i++ {
		tm := time.Now()
		Naive(1920, 1080, 40, img.Pix)
		fmt.Println(i, "naive duration", time.Since(tm))
	}

	if err := savePNG("naive-g16.png", img); err != nil {
		panic(err)
	}
}

func TestAssembly(t *testing.T) {
	img := image.NewGray16(image.Rect(0, 0, 1920, 1080))
	for i := 0; i < 10; i++ {
		tm := time.Now()
		Assembly(1920, 1080, 40, img.Pix)
		fmt.Println(i, "assembly duration", time.Since(tm))
	}

	if err := savePNG("assembly-g16.png", img); err != nil {
		panic(err)
	}
}

func savePNG(fn string, m image.Image) error {
	f, err := os.Create(fn)
	if err != nil {
		return err
	}
	defer f.Close()

	return png.Encode(f, m)
}

func BenchmarkNaive(b *testing.B) {
	buff := make([]byte, 4147200)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		Naive(1920, 1080, 40, buff)
	}
}

func BenchmarkAssembly(b *testing.B) {
	buff := make([]byte, 4147200)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		Assembly(1920, 1080, 40, buff)
	}
}
