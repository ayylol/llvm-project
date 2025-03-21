; RUN: opt -aa-pipeline=basic-aa -passes=licm -S < %s
; PR9931

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"

define void @func_20(i1 %arg) nounwind {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond2, %entry
  br i1 %arg, label %for.cond2, label %for.end22

for.cond2:                                        ; preds = %for.body5, %for.cond
  br i1 false, label %for.body5, label %for.cond

for.body5:                                        ; preds = %for.cond2
  %tmp7 = load i64, ptr undef, align 8
  %arrayidx9 = getelementptr inbounds [2 x i64], ptr undef, i32 0, i64 undef
  %tmp10 = load i64, ptr %arrayidx9, align 8
  br label %for.cond2

for.end22:                                        ; preds = %for.cond
  ret void
}
