; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips2 | FileCheck %s -check-prefix=MIPS
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32 | FileCheck %s -check-prefix=MIPS
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r2 | FileCheck %s \
; RUN:    -check-prefix=MIPS32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r3 | FileCheck %s \
; RUN:    -check-prefix=MIPS32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r5 | FileCheck %s \
; RUN:    -check-prefix=MIPS32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r6 | FileCheck %s \
; RUN:    -check-prefix=MIPS32R6
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips3 | FileCheck %s \
; RUN:    -check-prefix=MIPS64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips4 | FileCheck %s \
; RUN:    -check-prefix=MIPS64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64 | FileCheck %s \
; RUN:    -check-prefix=MIPS64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r2 | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r3 | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r5 | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r6 | FileCheck %s \
; RUN:    -check-prefix=MIPS64R6
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r3 -mattr=+micromips | FileCheck %s \
; RUN:    -check-prefix=MM32R3
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r6 -mattr=+micromips | FileCheck %s \
; RUN:    -check-prefix=MM32R6

define signext i1 @xor_i1(i1 signext %a, i1 signext %b) {
; MIPS-LABEL: xor_i1:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    xor $2, $4, $5
;
; MIPS32R2-LABEL: xor_i1:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    xor $2, $4, $5
;
; MIPS32R6-LABEL: xor_i1:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    xor $2, $4, $5
;
; MIPS64-LABEL: xor_i1:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    xor $1, $4, $5
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    sll $2, $1, 0
;
; MIPS64R2-LABEL: xor_i1:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    xor $1, $4, $5
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    sll $2, $1, 0
;
; MIPS64R6-LABEL: xor_i1:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    xor $1, $4, $5
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    sll $2, $1, 0
;
; MM32R3-LABEL: xor_i1:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    xor16 $4, $5
; MM32R3-NEXT:    move $2, $4
; MM32R3-NEXT:    jrc $ra
;
; MM32R6-LABEL: xor_i1:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xor $2, $4, $5
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i1 %a, %b
  ret i1 %r
}

define signext i8 @xor_i8(i8 signext %a, i8 signext %b) {
; MIPS-LABEL: xor_i8:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    xor $2, $4, $5
;
; MIPS32R2-LABEL: xor_i8:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    xor $2, $4, $5
;
; MIPS32R6-LABEL: xor_i8:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    xor $2, $4, $5
;
; MIPS64-LABEL: xor_i8:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    xor $1, $4, $5
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    sll $2, $1, 0
;
; MIPS64R2-LABEL: xor_i8:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    xor $1, $4, $5
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    sll $2, $1, 0
;
; MIPS64R6-LABEL: xor_i8:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    xor $1, $4, $5
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    sll $2, $1, 0
;
; MM32R3-LABEL: xor_i8:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    xor16 $4, $5
; MM32R3-NEXT:    move $2, $4
; MM32R3-NEXT:    jrc $ra
;
; MM32R6-LABEL: xor_i8:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xor $2, $4, $5
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i8 %a, %b
  ret i8 %r
}

define signext i16 @xor_i16(i16 signext %a, i16 signext %b) {
; MIPS-LABEL: xor_i16:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    xor $2, $4, $5
;
; MIPS32R2-LABEL: xor_i16:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    xor $2, $4, $5
;
; MIPS32R6-LABEL: xor_i16:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    xor $2, $4, $5
;
; MIPS64-LABEL: xor_i16:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    xor $1, $4, $5
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    sll $2, $1, 0
;
; MIPS64R2-LABEL: xor_i16:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    xor $1, $4, $5
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    sll $2, $1, 0
;
; MIPS64R6-LABEL: xor_i16:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    xor $1, $4, $5
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    sll $2, $1, 0
;
; MM32R3-LABEL: xor_i16:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    xor16 $4, $5
; MM32R3-NEXT:    move $2, $4
; MM32R3-NEXT:    jrc $ra
;
; MM32R6-LABEL: xor_i16:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xor $2, $4, $5
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i16 %a, %b
  ret i16 %r
}

define signext i32 @xor_i32(i32 signext %a, i32 signext %b) {
; MIPS-LABEL: xor_i32:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    xor $2, $4, $5
;
; MIPS32R2-LABEL: xor_i32:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    xor $2, $4, $5
;
; MIPS32R6-LABEL: xor_i32:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    xor $2, $4, $5
;
; MIPS64-LABEL: xor_i32:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    xor $2, $4, $5
;
; MIPS64R2-LABEL: xor_i32:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    xor $2, $4, $5
;
; MIPS64R6-LABEL: xor_i32:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    xor $2, $4, $5
;
; MM32R3-LABEL: xor_i32:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    xor16 $4, $5
; MM32R3-NEXT:    move $2, $4
; MM32R3-NEXT:    jrc $ra
;
; MM32R6-LABEL: xor_i32:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xor $2, $4, $5
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i32 %a, %b
  ret i32 %r
}

define signext i64 @xor_i64(i64 signext %a, i64 signext %b) {
; MIPS-LABEL: xor_i64:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    xor $2, $4, $6
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    xor $3, $5, $7
;
; MIPS32R2-LABEL: xor_i64:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    xor $2, $4, $6
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    xor $3, $5, $7
;
; MIPS32R6-LABEL: xor_i64:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    xor $2, $4, $6
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    xor $3, $5, $7
;
; MIPS64-LABEL: xor_i64:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    xor $2, $4, $5
;
; MIPS64R2-LABEL: xor_i64:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    xor $2, $4, $5
;
; MIPS64R6-LABEL: xor_i64:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    xor $2, $4, $5
;
; MM32R3-LABEL: xor_i64:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    xor16 $4, $6
; MM32R3-NEXT:    xor16 $5, $7
; MM32R3-NEXT:    move $2, $4
; MM32R3-NEXT:    move $3, $5
; MM32R3-NEXT:    jrc $ra
;
; MM32R6-LABEL: xor_i64:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xor $2, $4, $6
; MM32R6-NEXT:    xor $3, $5, $7
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i64 %a, %b
  ret i64 %r
}

define signext i128 @xor_i128(i128 signext %a, i128 signext %b) {
; MIPS-LABEL: xor_i128:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    lw $1, 20($sp)
; MIPS-NEXT:    lw $2, 16($sp)
; MIPS-NEXT:    xor $2, $4, $2
; MIPS-NEXT:    xor $3, $5, $1
; MIPS-NEXT:    lw $1, 24($sp)
; MIPS-NEXT:    xor $4, $6, $1
; MIPS-NEXT:    lw $1, 28($sp)
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    xor $5, $7, $1
;
; MIPS32R2-LABEL: xor_i128:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    lw $1, 20($sp)
; MIPS32R2-NEXT:    lw $2, 16($sp)
; MIPS32R2-NEXT:    xor $2, $4, $2
; MIPS32R2-NEXT:    xor $3, $5, $1
; MIPS32R2-NEXT:    lw $1, 24($sp)
; MIPS32R2-NEXT:    xor $4, $6, $1
; MIPS32R2-NEXT:    lw $1, 28($sp)
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    xor $5, $7, $1
;
; MIPS32R6-LABEL: xor_i128:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    lw $1, 20($sp)
; MIPS32R6-NEXT:    lw $2, 16($sp)
; MIPS32R6-NEXT:    xor $2, $4, $2
; MIPS32R6-NEXT:    xor $3, $5, $1
; MIPS32R6-NEXT:    lw $1, 24($sp)
; MIPS32R6-NEXT:    xor $4, $6, $1
; MIPS32R6-NEXT:    lw $1, 28($sp)
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    xor $5, $7, $1
;
; MIPS64-LABEL: xor_i128:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    xor $2, $4, $6
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    xor $3, $5, $7
;
; MIPS64R2-LABEL: xor_i128:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    xor $2, $4, $6
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    xor $3, $5, $7
;
; MIPS64R6-LABEL: xor_i128:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    xor $2, $4, $6
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    xor $3, $5, $7
;
; MM32R3-LABEL: xor_i128:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    lwp $2, 16($sp)
; MM32R3-NEXT:    xor16 $2, $4
; MM32R3-NEXT:    xor16 $3, $5
; MM32R3-NEXT:    lw $4, 24($sp)
; MM32R3-NEXT:    xor16 $4, $6
; MM32R3-NEXT:    lw $5, 28($sp)
; MM32R3-NEXT:    xor16 $5, $7
; MM32R3-NEXT:    jrc $ra
;
; MM32R6-LABEL: xor_i128:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    lw $1, 20($sp)
; MM32R6-NEXT:    lw $2, 16($sp)
; MM32R6-NEXT:    xor $2, $4, $2
; MM32R6-NEXT:    xor $3, $5, $1
; MM32R6-NEXT:    lw $1, 24($sp)
; MM32R6-NEXT:    xor $4, $6, $1
; MM32R6-NEXT:    lw $1, 28($sp)
; MM32R6-NEXT:    xor $5, $7, $1
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i128 %a, %b
  ret i128 %r
}

define signext i1 @xor_i1_4(i1 signext %b) {
; MIPS-LABEL: xor_i1_4:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    move $2, $4
;
; MIPS32R2-LABEL: xor_i1_4:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    move $2, $4
;
; MIPS32R6-LABEL: xor_i1_4:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    move $2, $4
;
; MIPS64-LABEL: xor_i1_4:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    move $2, $4
;
; MIPS64R2-LABEL: xor_i1_4:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    move $2, $4
;
; MIPS64R6-LABEL: xor_i1_4:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    move $2, $4
;
; MM32R3-LABEL: xor_i1_4:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    move $2, $4
; MM32R3-NEXT:    jrc $ra
;
; MM32R6-LABEL: xor_i1_4:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    move $2, $4
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i1 4, %b
  ret i1 %r
}

define signext i8 @xor_i8_4(i8 signext %b) {
; MIPS-LABEL: xor_i8_4:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    xori $2, $4, 4
;
; MIPS32R2-LABEL: xor_i8_4:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    xori $2, $4, 4
;
; MIPS32R6-LABEL: xor_i8_4:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    xori $2, $4, 4
;
; MIPS64-LABEL: xor_i8_4:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    xori $2, $4, 4
;
; MIPS64R2-LABEL: xor_i8_4:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    xori $2, $4, 4
;
; MIPS64R6-LABEL: xor_i8_4:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    xori $2, $4, 4
;
; MM32R3-LABEL: xor_i8_4:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    jr $ra
; MM32R3-NEXT:    xori $2, $4, 4
;
; MM32R6-LABEL: xor_i8_4:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xori $2, $4, 4
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i8 4, %b
  ret i8 %r
}

define signext i16 @xor_i16_4(i16 signext %b) {
; MIPS-LABEL: xor_i16_4:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    xori $2, $4, 4
;
; MIPS32R2-LABEL: xor_i16_4:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    xori $2, $4, 4
;
; MIPS32R6-LABEL: xor_i16_4:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    xori $2, $4, 4
;
; MIPS64-LABEL: xor_i16_4:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    xori $2, $4, 4
;
; MIPS64R2-LABEL: xor_i16_4:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    xori $2, $4, 4
;
; MIPS64R6-LABEL: xor_i16_4:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    xori $2, $4, 4
;
; MM32R3-LABEL: xor_i16_4:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    jr $ra
; MM32R3-NEXT:    xori $2, $4, 4
;
; MM32R6-LABEL: xor_i16_4:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xori $2, $4, 4
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i16 4, %b
  ret i16 %r
}

define signext i32 @xor_i32_4(i32 signext %b) {
; MIPS-LABEL: xor_i32_4:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    xori $2, $4, 4
;
; MIPS32R2-LABEL: xor_i32_4:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    xori $2, $4, 4
;
; MIPS32R6-LABEL: xor_i32_4:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    xori $2, $4, 4
;
; MIPS64-LABEL: xor_i32_4:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    xori $2, $4, 4
;
; MIPS64R2-LABEL: xor_i32_4:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    xori $2, $4, 4
;
; MIPS64R6-LABEL: xor_i32_4:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    xori $2, $4, 4
;
; MM32R3-LABEL: xor_i32_4:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    jr $ra
; MM32R3-NEXT:    xori $2, $4, 4
;
; MM32R6-LABEL: xor_i32_4:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xori $2, $4, 4
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i32 4, %b
  ret i32 %r
}

define signext i64 @xor_i64_4(i64 signext %b) {
; MIPS-LABEL: xor_i64_4:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    xori $3, $5, 4
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    move $2, $4
;
; MIPS32R2-LABEL: xor_i64_4:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    xori $3, $5, 4
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    move $2, $4
;
; MIPS32R6-LABEL: xor_i64_4:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    xori $3, $5, 4
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    move $2, $4
;
; MIPS64-LABEL: xor_i64_4:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    xori $2, $4, 4
;
; MIPS64R2-LABEL: xor_i64_4:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    xori $2, $4, 4
;
; MIPS64R6-LABEL: xor_i64_4:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    xori $2, $4, 4
;
; MM32R3-LABEL: xor_i64_4:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    xori $3, $5, 4
; MM32R3-NEXT:    move $2, $4
; MM32R3-NEXT:    jrc $ra
;
; MM32R6-LABEL: xor_i64_4:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xori $3, $5, 4
; MM32R6-NEXT:    move $2, $4
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i64 4, %b
  ret i64 %r
}

define signext i128 @xor_i128_4(i128 signext %b) {
; MIPS-LABEL: xor_i128_4:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    xori $1, $7, 4
; MIPS-NEXT:    move $2, $4
; MIPS-NEXT:    move $3, $5
; MIPS-NEXT:    move $4, $6
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    move $5, $1
;
; MIPS32R2-LABEL: xor_i128_4:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    xori $1, $7, 4
; MIPS32R2-NEXT:    move $2, $4
; MIPS32R2-NEXT:    move $3, $5
; MIPS32R2-NEXT:    move $4, $6
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    move $5, $1
;
; MIPS32R6-LABEL: xor_i128_4:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    xori $1, $7, 4
; MIPS32R6-NEXT:    move $2, $4
; MIPS32R6-NEXT:    move $3, $5
; MIPS32R6-NEXT:    move $4, $6
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    move $5, $1
;
; MIPS64-LABEL: xor_i128_4:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    xori $3, $5, 4
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    move $2, $4
;
; MIPS64R2-LABEL: xor_i128_4:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    xori $3, $5, 4
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    move $2, $4
;
; MIPS64R6-LABEL: xor_i128_4:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    xori $3, $5, 4
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    move $2, $4
;
; MM32R3-LABEL: xor_i128_4:
; MM32R3:       # %bb.0: # %entry
; MM32R3-NEXT:    xori $1, $7, 4
; MM32R3-NEXT:    move $2, $4
; MM32R3-NEXT:    move $3, $5
; MM32R3-NEXT:    move $4, $6
; MM32R3-NEXT:    move $5, $1
; MM32R3-NEXT:    jrc $ra
;
; MM32R6-LABEL: xor_i128_4:
; MM32R6:       # %bb.0: # %entry
; MM32R6-NEXT:    xori $1, $7, 4
; MM32R6-NEXT:    move $2, $4
; MM32R6-NEXT:    move $3, $5
; MM32R6-NEXT:    move $4, $6
; MM32R6-NEXT:    move $5, $1
; MM32R6-NEXT:    jrc $ra
entry:
  %r = xor i128 4, %b
  ret i128 %r
}
