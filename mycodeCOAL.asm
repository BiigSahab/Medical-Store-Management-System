org 100h

jmp start

; --- Data Section ---
; Added leading spaces to center the text
titleMsg  db '          ==============================', 13, 10
          db '                TIC TAC TOE - 8086      ', 13, 10
          db '          ==============================', 13, 10, '$'

board     db '1','2','3','4','5','6','7','8','9'
turn      db 'X'
lastPos   db 'None$'
moveMsg   db 13,10,'          Last Move Played: Position $'

msg1      db 13,10,'          Player $'
msg2      db ' turn (1-9): $'
msgWin    db 13,10, 13, 10, '          CONGRATULATIONS! Player $'
msgWin2   db ' wins! $'
msgDraw   db 13,10, 13, 10, '          GAME DRAW! $'
clearLine db '                                        $', 

; -------------------------
start:
    mov ax, 03h ; Clear screen
    int 10h

game_loop:
    call reset_cursor  
    call display_ui
    
    call input
    call check_win
    cmp al, 1
    je win

    call check_draw
    cmp al, 1
    je draw

    call switch
    jmp game_loop

; --- UI Functions ---

reset_cursor:
    mov ah, 02h    
    mov bh, 00h    
    mov dh, 00h    
    mov dl, 00h    
    int 10h
    ret

display_ui:
    mov dx, offset titleMsg
    mov ah, 9
    int 21h

    mov dx, offset moveMsg
    mov ah, 9
    int 21h
    
    mov dl, lastPos
    mov ah, 2
    int 21h
    
    call display_board
    ret

display_board:
    mov ah, 2
    
    ; Row 1
    call print_newline
    call print_board_padding
    mov dl, board[0]
    int 21h
    call print_vbar
    mov dl, board[1]
    int 21h
    call print_vbar
    mov dl, board[2]
    int 21h

    ; Divider
    call print_newline
    call print_board_padding
    mov dl, '-'
    int 21h
    mov dl, '+'
    int 21h
    mov dl, '-'
    int 21h
    mov dl, '+'
    int 21h
    mov dl, '-'
    int 21h

    ; Row 2
    call print_newline
    call print_board_padding
    mov dl, board[3]
    int 21h
    call print_vbar
    mov dl, board[4]
    int 21h
    call print_vbar
    mov dl, board[5]
    int 21h

    ; Divider
    call print_newline
    call print_board_padding
    mov dl, '-'
    int 21h
    mov dl, '+'
    int 21h
    mov dl, '-'
    int 21h
    mov dl, '+'
    int 21h
    mov dl, '-'
    int 21h

    ; Row 3
    call print_newline
    call print_board_padding
    mov dl, board[6]
    int 21h
    call print_vbar
    mov dl, board[7]
    int 21h
    call print_vbar
    mov dl, board[8]
    int 21h
    call print_newline
    ret

print_vbar:
    mov dl, '|'
    int 21h
    ret

print_board_padding:
    ; Pushes the board to the center (approx col 20)
    mov cx, 20
p_loop:
    mov dl, ' '
    mov ah, 2
    int 21h
    loop p_loop
    ret

print_newline:
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    ret

; --- Input Logic ---

input:
again:
    ; Wipe the input line area specifically
    mov dx, offset msg1
    mov ah, 9
    int 21h
    mov dx, offset clearLine ; Clear previous input chars
    int 21h

    ; Move cursor back to input position
    mov ah, 02h
    mov bh, 00h
    mov dh, 12 ; Fixed Row for input (Close to board)
    mov dl, 00h
    int 10h

    mov dx, offset msg1
    mov ah, 9
    int 21h
    mov dl, turn
    mov ah, 2
    int 21h
    mov dx, offset msg2
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    
    mov lastPos, al 

    sub al, '1'
    cmp al, 8
    ja again
    
    mov bh, 0
    mov bl, al
    mov al, board[bx]
    cmp al, 'X'
    je again
    cmp al, 'O'
    je again

    mov al, turn
    mov board[bx], al
    ret

switch:
    cmp turn, 'X'
    je makeO
    mov turn, 'X'
    ret
makeO:
    mov turn, 'O'
    ret

check_win:
    ; Row 1
    mov al,board[0]
    cmp al,board[1]
    jne r2
    cmp al,board[2]
    je yes
r2:
    mov al,board[3]
    cmp al,board[4]
    jne r3
    cmp al,board[5]
    je yes
r3:
    mov al,board[6]
    cmp al,board[7]
    jne c1
    cmp al,board[8]
    je yes
c1:
    mov al,board[0]
    cmp al,board[3]
    jne c2
    cmp al,board[6]
    je yes
c2:
    mov al,board[1]
    cmp al,board[4]
    jne c3
    cmp al,board[7]
    je yes
c3:
    mov al,board[2]
    cmp al,board[5]
    jne d1
    cmp al,board[8]
    je yes
d1:
    mov al,board[0]
    cmp al,board[4]
    jne d2
    cmp al,board[8]
    je yes
d2:
    mov al,board[2]
    cmp al,board[4]
    jne no
    cmp al,board[6]
    je yes
no:
    mov al, 0
    ret
yes:
    mov al, 1
    ret

check_draw:
    mov cx, 9
    mov si, 0
loop1:
    mov al, board[si]
    cmp al, 'X'
    je next
    cmp al, 'O'
    je next
    mov al, 0
    ret
next:
    inc si
    loop loop1
    mov al, 1
    ret

win:
    call reset_cursor
    call display_ui
    mov dx, offset msgWin
    mov ah, 9
    int 21h
    mov dl, turn
    mov ah, 2
    int 21h
    mov dx, offset msgWin2
    mov ah, 9
    int 21h
    jmp exit

draw:
    call reset_cursor
    call display_ui
    mov dx, offset msgDraw
    mov ah, 9
    int 21h
    jmp exit

exit:
    mov ah, 4ch
    int 21h
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    