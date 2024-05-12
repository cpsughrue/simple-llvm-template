define dso_local noundef signext i8 @foo(i8 noundef signext %a, i8 noundef signext %b, i8 noundef signext %c, i8 noundef signext %d) local_unnamed_addr #0 {
entry:
  %add5 = add i8 %b, %a
  %add = add i8 %add5, %c
  %add9 = add i8 %add, %d
  ret i8 %add9
}

; RUN: opt -load-pass-plugin %shlibdir/libMBAAdd%shlibext -passes=mba-add -S < %s | FileCheck %s

; CHECK: define dso_local noundef signext i8 @foo(i8 noundef signext %a, i8 noundef signext %b, i8 noundef signext %c, i8 noundef signext %d) local_unnamed_addr {
; CHECK-NEXT: entry:
; CHECK-NEXT:   %0 = and i8 %b, %a
; CHECK-NEXT:   %1 = mul i8 2, %0
; CHECK-NEXT:   %2 = xor i8 %b, %a
; CHECK-NEXT:   %3 = add i8 %2, %1
; CHECK-NEXT:   %4 = mul i8 39, %3
; CHECK-NEXT:   %5 = add i8 23, %4
; CHECK-NEXT:   %6 = mul i8 -105, %5
; CHECK-NEXT:   %add5 = add i8 111, %6
; CHECK-NEXT:   %7 = and i8 %add5, %c
; CHECK-NEXT:   %8 = mul i8 2, %7
; CHECK-NEXT:   %9 = xor i8 %add5, %c
; CHECK-NEXT:   %10 = add i8 %9, %8
; CHECK-NEXT:   %11 = mul i8 39, %10
; CHECK-NEXT:   %12 = add i8 23, %11
; CHECK-NEXT:   %13 = mul i8 -105, %12
; CHECK-NEXT:   %add = add i8 111, %13
; CHECK-NEXT:   %14 = and i8 %add, %d
; CHECK-NEXT:   %15 = mul i8 2, %14
; CHECK-NEXT:   %16 = xor i8 %add, %d
; CHECK-NEXT:   %17 = add i8 %16, %15
; CHECK-NEXT:   %18 = mul i8 39, %17
; CHECK-NEXT:   %19 = add i8 23, %18
; CHECK-NEXT:   %20 = mul i8 -105, %19
; CHECK-NEXT:   %add9 = add i8 111, %20
; CHECK-NEXT:   ret i8 %add9
; CHECK-NEXT: }
