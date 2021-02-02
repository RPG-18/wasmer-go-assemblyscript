(module
 (type $none_=>_none (func))
 (type $i32_=>_i32 (func (param i32) (result i32)))
 (type $i32_=>_none (func (param i32)))
 (type $i32_i32_=>_i32 (func (param i32 i32) (result i32)))
 (type $i32_i32_i32_=>_none (func (param i32 i32 i32)))
 (type $f64_=>_f64 (func (param f64) (result f64)))
 (type $i64_=>_none (func (param i64)))
 (import "go" "console.log" (func $../../assemblyscript/go/console.log (param i32)))
 (memory $0 64)
 (data (i32.const 4147212) "\1c\00\00\00\01\00\00\00\00\00\00\00\01\00\00\00\02\00\00\000")
 (data (i32.const 4147244) "\\\00\00\00\01\00\00\00\00\00\00\00\01\00\00\00H\00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z")
 (data (i32.const 4147340) ",\00\00\00\01\00\00\00\00\00\00\00\01\00\00\00\18\00\00\00H\00e\00l\00l\00o\00 \00W\00o\00r\00l\00d\00!")
 (data (i32.const 4147388) ",\00\00\00\01\00\00\00\00\00\00\00\01\00\00\00\14\00\00\00i\00t\00e\00r\00a\00t\00i\00o\00n\00:")
 (data (i32.const 4147436) "\1c\00\00\00\01\00\00\00\00\00\00\00\01\00\00\00\08\00\00\00n\00u\00l\00l")
 (data (i32.const 4147468) "\1c\00\00\00\01\00\00\00\00\00\00\00\01")
 (data (i32.const 4147500) "\1c\00\00\00\01\00\00\00\00\00\00\00\01\00\00\00\02\00\00\00\n")
 (data (i32.const 4147536) "\03\00\00\00 \00\00\00\00\00\00\00 \00\00\00\00\00\00\00 ")
 (global $~lib/rt/stub/startOffset (mut i32) (i32.const 0))
 (global $~lib/rt/stub/offset (mut i32) (i32.const 0))
 (global $overhead/cnt (mut i32) (i32.const 0))
 (global $~lib/rt/__rtti_base i32 (i32.const 4147536))
 (export "memory" (memory $0))
 (export "__new" (func $~lib/rt/stub/__new))
 (export "__renew" (func $~lib/rt/stub/__renew))
 (export "__retain" (func $~lib/rt/stub/__retain))
 (export "__release" (func $~lib/rt/stub/__release))
 (export "__collect" (func $~lib/rt/stub/__collect))
 (export "__reset" (func $~lib/rt/stub/__reset))
 (export "__rtti_base" (global $~lib/rt/__rtti_base))
 (export "empty" (func $~lib/rt/stub/__collect))
 (export "increment" (func $overhead/increment))
 (export "printCount" (func $overhead/printCount))
 (export "update" (func $mandelbrot/update))
 (export "hello" (func $hello/hello))
 (export "say" (func $string_args/say))
 (export "infinityLoop" (func $cancellation_token/infinityLoop))
 (start $~start)
 (func $~lib/rt/stub/computeSize (param $0 i32) (result i32)
  local.get $0
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
 )
 (func $~lib/rt/stub/maybeGrowMemory (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  memory.size
  local.tee $2
  i32.const 16
  i32.shl
  i32.const 15
  i32.add
  i32.const -16
  i32.and
  local.tee $1
  i32.gt_u
  if
   local.get $2
   local.get $0
   local.get $1
   i32.sub
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.tee $1
   local.get $1
   local.get $2
   i32.lt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $1
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
  end
  local.get $0
  global.set $~lib/rt/stub/offset
 )
 (func $~lib/rt/stub/__alloc (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  i32.const 1073741820
  i32.gt_u
  if
   unreachable
  end
  global.get $~lib/rt/stub/offset
  global.get $~lib/rt/stub/offset
  i32.const 4
  i32.add
  local.tee $2
  local.get $0
  call $~lib/rt/stub/computeSize
  local.tee $0
  i32.add
  call $~lib/rt/stub/maybeGrowMemory
  local.get $0
  i32.store
  local.get $2
 )
 (func $~lib/rt/stub/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.const 1073741804
  i32.gt_u
  if
   unreachable
  end
  local.get $0
  i32.const 16
  i32.add
  call $~lib/rt/stub/__alloc
  local.tee $3
  i32.const 4
  i32.sub
  local.tee $2
  i32.const 0
  i32.store offset=4
  local.get $2
  i32.const 0
  i32.store offset=8
  local.get $2
  local.get $1
  i32.store offset=12
  local.get $2
  local.get $0
  i32.store offset=16
  local.get $3
  i32.const 16
  i32.add
 )
 (func $~lib/memory/memory.copy (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  block $~lib/util/memory/memmove|inlined.0
   local.get $2
   local.set $4
   local.get $0
   local.get $1
   i32.eq
   br_if $~lib/util/memory/memmove|inlined.0
   local.get $0
   local.get $1
   i32.lt_u
   if
    local.get $1
    i32.const 7
    i32.and
    local.get $0
    i32.const 7
    i32.and
    i32.eq
    if
     loop $while-continue|0
      local.get $0
      i32.const 7
      i32.and
      if
       local.get $4
       i32.eqz
       br_if $~lib/util/memory/memmove|inlined.0
       local.get $4
       i32.const 1
       i32.sub
       local.set $4
       local.get $0
       local.tee $2
       i32.const 1
       i32.add
       local.set $0
       local.get $1
       local.tee $3
       i32.const 1
       i32.add
       local.set $1
       local.get $2
       local.get $3
       i32.load8_u
       i32.store8
       br $while-continue|0
      end
     end
     loop $while-continue|1
      local.get $4
      i32.const 8
      i32.ge_u
      if
       local.get $0
       local.get $1
       i64.load
       i64.store
       local.get $4
       i32.const 8
       i32.sub
       local.set $4
       local.get $0
       i32.const 8
       i32.add
       local.set $0
       local.get $1
       i32.const 8
       i32.add
       local.set $1
       br $while-continue|1
      end
     end
    end
    loop $while-continue|2
     local.get $4
     if
      local.get $0
      local.tee $2
      i32.const 1
      i32.add
      local.set $0
      local.get $1
      local.tee $3
      i32.const 1
      i32.add
      local.set $1
      local.get $2
      local.get $3
      i32.load8_u
      i32.store8
      local.get $4
      i32.const 1
      i32.sub
      local.set $4
      br $while-continue|2
     end
    end
   else
    local.get $1
    i32.const 7
    i32.and
    local.get $0
    i32.const 7
    i32.and
    i32.eq
    if
     loop $while-continue|3
      local.get $0
      local.get $4
      i32.add
      i32.const 7
      i32.and
      if
       local.get $4
       i32.eqz
       br_if $~lib/util/memory/memmove|inlined.0
       local.get $4
       i32.const 1
       i32.sub
       local.tee $4
       local.get $0
       i32.add
       local.get $1
       local.get $4
       i32.add
       i32.load8_u
       i32.store8
       br $while-continue|3
      end
     end
     loop $while-continue|4
      local.get $4
      i32.const 8
      i32.ge_u
      if
       local.get $4
       i32.const 8
       i32.sub
       local.tee $4
       local.get $0
       i32.add
       local.get $1
       local.get $4
       i32.add
       i64.load
       i64.store
       br $while-continue|4
      end
     end
    end
    loop $while-continue|5
     local.get $4
     if
      local.get $4
      i32.const 1
      i32.sub
      local.tee $4
      local.get $0
      i32.add
      local.get $1
      local.get $4
      i32.add
      i32.load8_u
      i32.store8
      br $while-continue|5
     end
    end
   end
  end
 )
 (func $~lib/rt/stub/__renew (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $1
  i32.const 1073741804
  i32.gt_u
  if
   unreachable
  end
  local.get $1
  i32.const 16
  i32.add
  local.set $3
  local.get $0
  i32.const 16
  i32.sub
  local.tee $0
  i32.const 15
  i32.and
  i32.eqz
  i32.const 0
  local.get $0
  select
  i32.eqz
  if
   unreachable
  end
  global.get $~lib/rt/stub/offset
  local.get $0
  local.get $0
  i32.const 4
  i32.sub
  local.tee $5
  i32.load
  local.tee $4
  i32.add
  i32.eq
  local.set $6
  local.get $3
  call $~lib/rt/stub/computeSize
  local.set $2
  local.get $3
  local.get $4
  i32.gt_u
  if
   local.get $6
   if
    local.get $3
    i32.const 1073741820
    i32.gt_u
    if
     unreachable
    end
    local.get $0
    local.get $2
    i32.add
    call $~lib/rt/stub/maybeGrowMemory
    local.get $5
    local.get $2
    i32.store
   else
    local.get $2
    local.get $4
    i32.const 1
    i32.shl
    local.tee $3
    local.get $2
    local.get $3
    i32.gt_u
    select
    call $~lib/rt/stub/__alloc
    local.tee $2
    local.get $0
    local.get $4
    call $~lib/memory/memory.copy
    local.get $2
    local.set $0
   end
  else
   local.get $6
   if
    local.get $0
    local.get $2
    i32.add
    global.set $~lib/rt/stub/offset
    local.get $5
    local.get $2
    i32.store
   end
  end
  local.get $0
  i32.const 4
  i32.sub
  local.get $1
  i32.store offset=16
  local.get $0
  i32.const 16
  i32.add
 )
 (func $~lib/rt/stub/__retain (param $0 i32) (result i32)
  local.get $0
 )
 (func $~lib/rt/stub/__release (param $0 i32)
  nop
 )
 (func $~lib/rt/stub/__collect
  nop
 )
 (func $~lib/rt/stub/__reset
  global.get $~lib/rt/stub/startOffset
  global.set $~lib/rt/stub/offset
 )
 (func $overhead/increment
  global.get $overhead/cnt
  i32.const 1
  i32.add
  global.set $overhead/cnt
 )
 (func $~lib/util/number/itoa32 (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.eqz
  if
   i32.const 4147232
   return
  end
  i32.const 0
  local.get $0
  i32.sub
  local.get $0
  local.get $0
  i32.const 31
  i32.shr_u
  local.tee $2
  select
  local.tee $0
  i32.const 10
  i32.ge_u
  i32.const 1
  i32.add
  local.get $0
  i32.const 10000
  i32.ge_u
  i32.const 3
  i32.add
  local.get $0
  i32.const 1000
  i32.ge_u
  i32.add
  local.get $0
  i32.const 100
  i32.lt_u
  select
  local.get $0
  i32.const 1000000
  i32.ge_u
  i32.const 6
  i32.add
  local.get $0
  i32.const 1000000000
  i32.ge_u
  i32.const 8
  i32.add
  local.get $0
  i32.const 100000000
  i32.ge_u
  i32.add
  local.get $0
  i32.const 10000000
  i32.lt_u
  select
  local.get $0
  i32.const 100000
  i32.lt_u
  select
  local.get $2
  i32.add
  local.tee $1
  i32.const 1
  i32.shl
  i32.const 1
  call $~lib/rt/stub/__new
  local.tee $3
  local.set $4
  loop $do-continue|0
   local.get $4
   local.get $1
   i32.const 1
   i32.sub
   local.tee $1
   i32.const 1
   i32.shl
   i32.add
   local.get $0
   i32.const 10
   i32.rem_u
   i32.const 48
   i32.add
   i32.store16
   local.get $0
   i32.const 10
   i32.div_u
   local.tee $0
   br_if $do-continue|0
  end
  local.get $2
  if
   local.get $3
   i32.const 45
   i32.store16
  end
  local.get $3
 )
 (func $overhead/printCount
  global.get $overhead/cnt
  call $~lib/util/number/itoa32
  call $../../assemblyscript/go/console.log
 )
 (func $~lib/math/NativeMath.log (param $0 f64) (result f64)
  (local $1 i32)
  (local $2 i64)
  (local $3 f64)
  (local $4 f64)
  (local $5 i32)
  i32.const 1
  local.get $0
  i64.reinterpret_f64
  local.tee $2
  i64.const 32
  i64.shr_u
  i32.wrap_i64
  local.tee $1
  i32.const 31
  i32.shr_u
  local.get $1
  i32.const 1048576
  i32.lt_u
  select
  if
   local.get $2
   i64.const 1
   i64.shl
   i64.eqz
   if
    f64.const -1
    local.get $0
    local.get $0
    f64.mul
    f64.div
    return
   end
   local.get $1
   i32.const 31
   i32.shr_u
   if
    local.get $0
    local.get $0
    f64.sub
    f64.const 0
    f64.div
    return
   end
   i32.const -54
   local.set $5
   local.get $0
   f64.const 18014398509481984
   f64.mul
   i64.reinterpret_f64
   local.tee $2
   i64.const 32
   i64.shr_u
   i32.wrap_i64
   local.set $1
  else
   local.get $1
   i32.const 2146435072
   i32.ge_u
   if
    local.get $0
    return
   else
    local.get $2
    i64.const 32
    i64.shl
    i64.eqz
    i32.const 0
    local.get $1
    i32.const 1072693248
    i32.eq
    select
    if
     f64.const 0
     return
    end
   end
  end
  local.get $2
  i64.const 4294967295
  i64.and
  local.get $1
  i32.const 614242
  i32.add
  local.tee $1
  i32.const 1048575
  i32.and
  i32.const 1072079006
  i32.add
  i64.extend_i32_u
  i64.const 32
  i64.shl
  i64.or
  f64.reinterpret_i64
  f64.const 1
  f64.sub
  local.tee $3
  local.get $3
  f64.const 2
  f64.add
  f64.div
  local.tee $4
  local.get $4
  f64.mul
  local.set $0
  local.get $4
  local.get $3
  f64.const 0.5
  f64.mul
  local.get $3
  f64.mul
  local.tee $4
  local.get $0
  local.get $0
  local.get $0
  f64.mul
  local.tee $0
  local.get $0
  local.get $0
  f64.const 0.14798198605116586
  f64.mul
  f64.const 0.1818357216161805
  f64.add
  f64.mul
  f64.const 0.2857142874366239
  f64.add
  f64.mul
  f64.const 0.6666666666666735
  f64.add
  f64.mul
  local.get $0
  local.get $0
  local.get $0
  f64.const 0.15313837699209373
  f64.mul
  f64.const 0.22222198432149784
  f64.add
  f64.mul
  f64.const 0.3999999999940942
  f64.add
  f64.mul
  f64.add
  f64.add
  f64.mul
  local.get $5
  local.get $1
  i32.const 20
  i32.shr_s
  i32.const 1023
  i32.sub
  i32.add
  f64.convert_i32_s
  local.tee $0
  f64.const 1.9082149292705877e-10
  f64.mul
  f64.add
  local.get $4
  f64.sub
  local.get $3
  f64.add
  local.get $0
  f64.const 0.6931471803691238
  f64.mul
  f64.add
 )
 (func $~lib/math/NativeMath.log2 (param $0 f64) (result f64)
  (local $1 i32)
  (local $2 i64)
  (local $3 f64)
  (local $4 f64)
  (local $5 f64)
  (local $6 f64)
  (local $7 f64)
  (local $8 i32)
  (local $9 f64)
  (local $10 f64)
  i32.const 1
  local.get $0
  i64.reinterpret_f64
  local.tee $2
  i64.const 32
  i64.shr_u
  i32.wrap_i64
  local.tee $1
  i32.const 31
  i32.shr_u
  local.get $1
  i32.const 1048576
  i32.lt_u
  select
  if
   local.get $2
   i64.const 1
   i64.shl
   i64.eqz
   if
    f64.const -1
    local.get $0
    local.get $0
    f64.mul
    f64.div
    return
   end
   local.get $1
   i32.const 31
   i32.shr_u
   if
    local.get $0
    local.get $0
    f64.sub
    f64.const 0
    f64.div
    return
   end
   i32.const -54
   local.set $8
   local.get $0
   f64.const 18014398509481984
   f64.mul
   i64.reinterpret_f64
   local.tee $2
   i64.const 32
   i64.shr_u
   i32.wrap_i64
   local.set $1
  else
   local.get $1
   i32.const 2146435072
   i32.ge_u
   if
    local.get $0
    return
   else
    local.get $2
    i64.const 32
    i64.shl
    i64.eqz
    i32.const 0
    local.get $1
    i32.const 1072693248
    i32.eq
    select
    if
     f64.const 0
     return
    end
   end
  end
  local.get $2
  i64.const 4294967295
  i64.and
  local.get $1
  i32.const 614242
  i32.add
  local.tee $1
  i32.const 1048575
  i32.and
  i32.const 1072079006
  i32.add
  i64.extend_i32_u
  i64.const 32
  i64.shl
  i64.or
  f64.reinterpret_i64
  f64.const 1
  f64.sub
  local.tee $0
  local.get $0
  f64.const 2
  f64.add
  f64.div
  local.tee $4
  local.get $4
  f64.mul
  local.set $3
  local.get $8
  local.get $1
  i32.const 20
  i32.shr_u
  i32.const 1023
  i32.sub
  i32.add
  f64.convert_i32_s
  local.tee $9
  local.get $0
  local.get $0
  f64.const 0.5
  f64.mul
  local.get $0
  f64.mul
  local.tee $5
  f64.sub
  i64.reinterpret_f64
  i64.const -4294967296
  i64.and
  f64.reinterpret_i64
  local.tee $6
  f64.const 1.4426950407214463
  f64.mul
  local.tee $10
  f64.add
  local.set $7
  local.get $0
  local.get $6
  f64.sub
  local.get $5
  f64.sub
  local.get $4
  local.get $5
  local.get $3
  local.get $3
  local.get $3
  f64.mul
  local.tee $0
  local.get $0
  local.get $0
  f64.const 0.14798198605116586
  f64.mul
  f64.const 0.1818357216161805
  f64.add
  f64.mul
  f64.const 0.2857142874366239
  f64.add
  f64.mul
  f64.const 0.6666666666666735
  f64.add
  f64.mul
  local.get $0
  local.get $0
  local.get $0
  f64.const 0.15313837699209373
  f64.mul
  f64.const 0.22222198432149784
  f64.add
  f64.mul
  f64.const 0.3999999999940942
  f64.add
  f64.mul
  f64.add
  f64.add
  f64.mul
  f64.add
  local.tee $0
  local.get $6
  f64.add
  f64.const 1.6751713164886512e-10
  f64.mul
  local.get $0
  f64.const 1.4426950407214463
  f64.mul
  f64.add
  local.get $9
  local.get $7
  f64.sub
  local.get $10
  f64.add
  f64.add
  local.get $7
  f64.add
 )
 (func $mandelbrot/update (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 f64)
  (local $4 f64)
  (local $5 f64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 f64)
  (local $12 f64)
  (local $13 f64)
  (local $14 f64)
  (local $15 f64)
  (local $16 f64)
  (local $17 f64)
  local.get $1
  f64.convert_i32_u
  f64.const 0.5
  f64.mul
  local.set $14
  local.get $0
  f64.convert_i32_u
  f64.const 0.625
  f64.mul
  f64.const 10
  local.get $0
  i32.const 3
  i32.mul
  local.tee $9
  local.get $1
  i32.const 2
  i32.shl
  local.tee $10
  local.get $9
  local.get $10
  i32.lt_s
  select
  f64.convert_i32_s
  f64.div
  local.tee $11
  f64.mul
  local.set $15
  f64.const 1
  local.get $2
  f64.convert_i32_u
  f64.div
  local.set $16
  i32.const 8
  local.get $2
  local.get $2
  i32.const 8
  i32.gt_u
  select
  local.set $9
  loop $for-loop|0
   local.get $1
   local.get $7
   i32.gt_u
   if
    local.get $7
    f64.convert_i32_u
    local.get $14
    f64.sub
    local.get $11
    f64.mul
    local.set $12
    local.get $0
    local.get $7
    i32.mul
    i32.const 1
    i32.shl
    local.set $10
    i32.const 0
    local.set $8
    loop $for-loop|1
     local.get $0
     local.get $8
     i32.gt_u
     if
      local.get $8
      f64.convert_i32_u
      local.get $11
      f64.mul
      local.get $15
      f64.sub
      local.set $13
      f64.const 0
      local.set $3
      f64.const 0
      local.set $5
      i32.const 0
      local.set $6
      loop $while-continue|2
       local.get $3
       local.get $3
       f64.mul
       local.tee $17
       local.get $5
       local.get $5
       f64.mul
       local.tee $4
       f64.add
       f64.const 4
       f64.le
       if
        block $while-break|2
         local.get $3
         local.get $3
         f64.add
         local.get $5
         f64.mul
         local.get $12
         f64.add
         local.set $5
         local.get $17
         local.get $4
         f64.sub
         local.get $13
         f64.add
         local.set $3
         local.get $2
         local.get $6
         i32.le_u
         br_if $while-break|2
         local.get $6
         i32.const 1
         i32.add
         local.set $6
         br $while-continue|2
        end
       end
      end
      loop $while-continue|3
       local.get $6
       local.get $9
       i32.lt_u
       if
        local.get $3
        local.get $3
        f64.mul
        local.get $5
        local.get $5
        f64.mul
        f64.sub
        local.get $13
        f64.add
        local.get $3
        local.get $3
        f64.add
        local.get $5
        f64.mul
        local.get $12
        f64.add
        local.set $5
        local.set $3
        local.get $6
        i32.const 1
        i32.add
        local.set $6
        br $while-continue|3
       end
      end
      local.get $10
      local.get $8
      i32.const 1
      i32.shl
      i32.add
      local.get $3
      local.get $3
      f64.mul
      local.get $5
      local.get $5
      f64.mul
      f64.add
      local.tee $4
      f64.const 1
      f64.gt
      if (result i32)
       local.get $6
       i32.const 1
       i32.add
       f64.convert_i32_u
       local.get $4
       call $~lib/math/NativeMath.log
       f64.const 0.5
       f64.mul
       call $~lib/math/NativeMath.log2
       f64.sub
       local.get $16
       f64.mul
       f64.const 0
       f64.max
       f64.const 1
       f64.min
       f64.const 2047
       f64.mul
       i32.trunc_f64_u
      else
       i32.const 2047
      end
      i32.store16
      local.get $8
      i32.const 1
      i32.add
      local.set $8
      br $for-loop|1
     end
    end
    local.get $7
    i32.const 1
    i32.add
    local.set $7
    br $for-loop|0
   end
  end
 )
 (func $hello/hello
  i32.const 4147360
  call $../../assemblyscript/go/console.log
 )
 (func $string_args/say (param $0 i64)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  i64.const 4294967295
  i64.and
  i32.wrap_i64
  i32.const -2
  i32.and
  local.tee $1
  i32.const 1
  call $~lib/rt/stub/__new
  local.tee $2
  local.get $0
  i64.const 32
  i64.shr_u
  i32.wrap_i64
  local.get $1
  call $~lib/memory/memory.copy
  local.get $2
  call $../../assemblyscript/go/console.log
 )
 (func $~lib/string/String#concat (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $1
  i32.const 4147456
  local.get $1
  select
  local.tee $3
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.const 1
  i32.shl
  local.tee $4
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.const 1
  i32.shl
  local.tee $1
  i32.add
  local.tee $2
  i32.eqz
  if
   i32.const 4147488
   return
  end
  local.get $2
  i32.const 1
  call $~lib/rt/stub/__new
  local.tee $2
  local.get $0
  local.get $1
  call $~lib/memory/memory.copy
  local.get $1
  local.get $2
  i32.add
  local.get $3
  local.get $4
  call $~lib/memory/memory.copy
  local.get $2
 )
 (func $cancellation_token/infinityLoop
  (local $0 i32)
  (local $1 i32)
  loop $while-continue|0
   i32.const 0
   i64.load
   i64.eqz
   if
    i32.const 4147408
    local.get $0
    i32.const 1
    i32.add
    local.tee $0
    call $~lib/util/number/itoa32
    call $~lib/string/String#concat
    local.tee $1
    i32.const 4147456
    local.get $1
    select
    i32.const 4147520
    call $~lib/string/String#concat
    call $../../assemblyscript/go/console.log
    br $while-continue|0
   end
  end
 )
 (func $~start
  i32.const 4147564
  global.set $~lib/rt/stub/startOffset
  i32.const 4147564
  global.set $~lib/rt/stub/offset
 )
)
