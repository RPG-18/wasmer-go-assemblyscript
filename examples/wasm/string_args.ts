import {console, Go} from "../../assemblyscript/go";

export function say(ptr: i64): void{
    console.log(Go.toString(ptr))
}

