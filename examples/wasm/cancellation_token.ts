import {console} from "../../assemblyscript/go";

function isCanceled(): boolean{
    let register = load<u64>(0)
    return register != 0
}

export function infinityLoop(): void{
    let i = 0
    while (!isCanceled()) {
        i++
        console.log("iteration:" + i.toString()+"\n")
    }
}