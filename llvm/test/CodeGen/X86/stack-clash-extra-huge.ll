; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --no_x86_scrub_sp
; RUN: llc -mtriple=x86_64-linux-android -verify-machineinstrs < %s | FileCheck -check-prefix=CHECK-X64 %s
; RUN: llc -mtriple=i686-linux-android -verify-machineinstrs < %s | FileCheck -check-prefix=CHECK-X86 %s
; RUN: llc -mtriple=x86_64-linux-gnux32 -verify-machineinstrs < %s | FileCheck -check-prefix=CHECK-X32 %s

define i32 @foo() local_unnamed_addr #0 {
; CHECK-X64-LABEL: foo:
; CHECK-X64:       # %bb.0:
; CHECK-X64-NEXT:    movabsq $-4799995904, %r11 # imm = 0xFFFFFFFEE1E5E000
; CHECK-X64-NEXT:    addq %rsp, %r11
; CHECK-X64-NEXT:    .cfi_def_cfa_register %r11
; CHECK-X64-NEXT:    .cfi_adjust_cfa_offset 4799995904
; CHECK-X64-NEXT:  .LBB0_1: # =>This Inner Loop Header: Depth=1
; CHECK-X64-NEXT:    subq $4096, %rsp # imm = 0x1000
; CHECK-X64-NEXT:    movq $0, (%rsp)
; CHECK-X64-NEXT:    cmpq %r11, %rsp
; CHECK-X64-NEXT:    jne .LBB0_1
; CHECK-X64-NEXT:  # %bb.2:
; CHECK-X64-NEXT:    subq $3976, %rsp # imm = 0xF88
; CHECK-X64-NEXT:    .cfi_def_cfa_register %rsp
; CHECK-X64-NEXT:    .cfi_def_cfa_offset 4799999888
; CHECK-X64-NEXT:    movl $1, 264(%rsp)
; CHECK-X64-NEXT:    movl $1, 28664(%rsp)
; CHECK-X64-NEXT:    movl -128(%rsp), %eax
; CHECK-X64-NEXT:    movabsq $4799999880, %rcx # imm = 0x11E1A2F88
; CHECK-X64-NEXT:    addq %rcx, %rsp
; CHECK-X64-NEXT:    .cfi_def_cfa_offset 8
; CHECK-X64-NEXT:    retq
;
; CHECK-X86-LABEL: foo:
; CHECK-X86:       # %bb.0:
; CHECK-X86-NEXT:    ud2
; CHECK-X86-NEXT:    .cfi_def_cfa_offset 4800000016
; CHECK-X86-NEXT:    movl $1, 392(%esp)
; CHECK-X86-NEXT:    movl $1, 28792(%esp)
; CHECK-X86-NEXT:    movl (%esp), %eax
; CHECK-X86-NEXT:    ud2
; CHECK-X86-NEXT:    .cfi_def_cfa_offset 4
; CHECK-X86-NEXT:    retl
;
; CHECK-X32-LABEL: foo:
; CHECK-X32:       # %bb.0:
; CHECK-X32-NEXT:    ud2
; CHECK-X32-NEXT:    .cfi_def_cfa_offset 4799999888
; CHECK-X32-NEXT:    movl $1, 264(%esp)
; CHECK-X32-NEXT:    movl $1, 28664(%esp)
; CHECK-X32-NEXT:    movl -128(%esp), %eax
; CHECK-X32-NEXT:    ud2
; CHECK-X32-NEXT:    .cfi_def_cfa_offset 8
; CHECK-X32-NEXT:    retq
  %a = alloca i32, i64 1200000000, align 16
  %b0 = getelementptr inbounds i32, ptr %a, i64 98
  %b1 = getelementptr inbounds i32, ptr %a, i64 7198
  store volatile i32 1, ptr %b0
  store volatile i32 1, ptr %b1
  %c = load volatile i32, ptr %a
  ret i32 %c
}

attributes #0 =  {"probe-stack"="inline-asm"}
