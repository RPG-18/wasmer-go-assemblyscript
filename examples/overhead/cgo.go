package overhead

//static void emptyFunction() {
//
//}
import "C"

func EmptyCFunction() {
	C.emptyFunction()
}
