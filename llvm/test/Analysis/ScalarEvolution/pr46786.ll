; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -analyze -enable-new-pm=0 -scalar-evolution | FileCheck %s

source_filename = "input.cpp"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"

; Function Attrs: nofree
define i8* @FSE_decompress_usingDTable(i8* %arg, i32 %arg1, i32 %arg2, i32 %arg3) local_unnamed_addr #0 {
; CHECK-LABEL: 'FSE_decompress_usingDTable'
; CHECK-NEXT:  Classifying expressions for: @FSE_decompress_usingDTable
; CHECK-NEXT:    %i = getelementptr inbounds i8, i8* %arg, i32 %arg2
; CHECK-NEXT:    --> (%arg2 + %arg)<nsw> U: full-set S: full-set
; CHECK-NEXT:    %i4 = sub nsw i32 0, %arg1
; CHECK-NEXT:    --> (-1 * %arg1) U: full-set S: full-set
; CHECK-NEXT:    %i5 = getelementptr inbounds i8, i8* %i, i32 %i4
; CHECK-NEXT:    --> ((-1 * %arg1) + %arg2 + %arg) U: full-set S: full-set
; CHECK-NEXT:    %i7 = select i1 %i6, i32 %arg2, i32 %arg1
; CHECK-NEXT:    --> ((-1 * %arg) + (((-1 * %arg1) + %arg2 + %arg) umin %arg) + %arg1) U: full-set S: full-set
; CHECK-NEXT:    %i8 = sub i32 %arg3, %i7
; CHECK-NEXT:    --> ((-1 * (((-1 * %arg1) + %arg2 + %arg) umin %arg)) + (-1 * %arg1) + %arg3 + %arg) U: full-set S: full-set
; CHECK-NEXT:    %i9 = getelementptr inbounds i8, i8* %arg, i32 %i8
; CHECK-NEXT:    --> ((2 * %arg) + (-1 * (((-1 * %arg1) + %arg2 + %arg) umin %arg)) + (-1 * %arg1) + %arg3) U: full-set S: full-set
; CHECK-NEXT:  Determining loop execution counts for: @FSE_decompress_usingDTable
;
bb:
  %i = getelementptr inbounds i8, i8* %arg, i32 %arg2
  %i4 = sub nsw i32 0, %arg1
  %i5 = getelementptr inbounds i8, i8* %i, i32 %i4
  %i6 = icmp ult i8* %i5, %arg
  %i7 = select i1 %i6, i32 %arg2, i32 %arg1
  %i8 = sub i32 %arg3, %i7
  %i9 = getelementptr inbounds i8, i8* %arg, i32 %i8
  ret i8* %i9
}

attributes #0 = { nofree }
