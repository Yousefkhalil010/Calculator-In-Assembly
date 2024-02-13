dosseg
.model small
.stack 100
.data
num dw ?
num1 dw ?
num2 dw ?
msg db 'Enter 1st number:','$'
msg2 db 'Enter 2nd number:','$'
msg3 db 'Choose operation(+ - * /):','$'
msg4 db 10,13,"Thank you for using our calculator.","$"
msg5 db "You cant divide on zero,Try Again.","$"
msg6 db "Out of range","$"
ress db 10,13,"result = ","$"
modd db "  mod = ","$"
.code
main:
mov ax,@data
mov ds,ax

mov ah,9
mov dx, offset msg
int 21h


call enternumber
mov ax,num
mov num1,ax


mov ah,9
mov dx, offset msg2
int 21h


call enternumber
mov ax,num
mov num2,ax

mov ah,9
mov dx, offset msg3
int 21h

mov ah,1
int 21h

mov ah,9
mov dx,offset ress
int 21h

cmp al,2bh
je addd
cmp al,2dh
je subb
cmp al,2ah
je mulll
cmp al,2fh
je divv

addd:
mov ax,num1
add ax,num2
jc rangeout
call contoperation
jmp ex

subb:
mov ax,num1
sub ax,num2
cmp ax,0
jge a
call mino
a:

call contoperation

jmp ex

mulll:
mov ax,num1
mov bx,num2
mul bx
jo rangeout
call contoperation
jmp ex

divv:
mov ax,num1
mov bx,num2
cmp bx,0
je zerodivition
mov dx,0
div bx
call divition
jmp ex

rangeout:
mov ah,9
mov dx,offset msg6
int 21h
jmp ex

divition PROC NEAR
push dx
push cx
push bx
push ax
mov cx,0
mov bx,10
backk:
mov dx,0
div bx
push dx
inc cx
or ax,ax
jnz backk

mov ah,02h
displayy:
pop dx
add dl,30h
int 21h
loop displayy
pop ax
pop bx
pop cx
mov ah,9
mov dx,offset modd
int 21h
mov ah,2
pop dx
add dl,30h
int 21h
ret
endp



enternumber PROC NEAR
push cx
push bx
push ax

mov cx,10
mov bx,0

back1:
mov ah,1
int 21h
cmp al,30h
jb skip
cmp al,39h
ja skip
sub al,30h
push ax
mov ax,bx
mul cx
mov bx,ax
pop ax
mov ah,00h
add bx,ax
jmp back1
skip:
mov num,bx
pop ax
pop bx
pop cx
ret
endp


zerodivition:
mov ah,9
mov dx,offset msg5
int 21h
jmp ex

contoperation PROC NEAR
push dx
push cx
push bx
push ax
mov cx,0
mov bx,10
back:
mov dx,0
div bx
push dx
inc cx
or ax,ax
jnz back

mov ah,02h
disp:
pop dx
add dl,30h
int 21h
loop disp
pop ax
pop bx
pop cx
pop dx
ret
endp


mino:
not ax
add ax,1h
push dx
push cx
push bx
push ax
mov cx,0
mov bx,10
back2:
mov dx,0
div bx
push dx
inc cx
or ax,ax
jnz back2
mov ah,02h
mov dl,'-'
int 21h
mov ah,02h
disp2:
pop dx
and dl,00h
add dl,30h
int 21h
loop disp2
pop ax
pop bx
pop cx
pop dx
ret
endp

ex:
mov ah,9
mov dx,offset msg4
int 21h
mov ah,4ch
int 21h
end main
