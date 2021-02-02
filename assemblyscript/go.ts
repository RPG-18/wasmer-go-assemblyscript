export declare namespace console {
    export function log(s: string): void
}

export namespace Go {
    export function toString(ptr: i64): string {
        let len = ptr & 0xFFFFFFFF
        ptr = ptr >>> 32
        return String.UTF16.decodeUnsafe(<usize>ptr, <usize>len)
    }
}