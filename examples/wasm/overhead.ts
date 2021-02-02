import {console} from "../../assemblyscript/go";

export function empty(): void {
}

let cnt = 0

export function increment(): void{
    cnt++
}

export function printCount(): void {
    console.log(cnt.toString())
}