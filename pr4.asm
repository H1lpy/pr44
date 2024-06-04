data segment
S dw ? ; Peremennaya dlya hraneniya rezul'tata S (dvojnoe slovo, 16 bit)
N dw ? ; Peremennaya dlya hraneniya vvedyonnogo znacheniya N (dvojnoe slovo, 16 bit) 
F dw ? ; 
perenos db 13,10,"$" ; Simvoly perevoda stroki (CR i LF) i simvol konca stroki dlya DOS
vvod_N db 13,10,"Vvedite N=$" ; Soobshchenie priglasheniya dlya vvoda N, okanchivayushcheesya simvolom konca stroki
vivod_S db "S=$" ; Soobshchenie dlya vyvoda znacheniya S
ends
stack segment
dw 128 dup(0) ; Opredelenie steka razmerom 128 slov, inicializiruetsya nulyami
ends
code segment
start:
; Ustanovka segmentnyh registrov:
mov ax, data ; Zagruzka segmenta dannyh v AX
mov ds, ax ; Ustanovka segmenta dannyh
mov es, ax ; Ustanovka dopolnitel'nogo segmenta
xor ax, ax ; Obnulenie registra AX
mov dx, offset vvod_N ; Zagruzka adresa stroki priglasheniya dlya vvoda N v DX
mov ah, 9 ; Ustanovka funkcii DOS dlya vyvoda stroki
int 21h ; Vyzov DOS dlya vyvoda stroki
mov ah, 1 ; Ustanovka funkcii DOS dlya vvoda simvola s klaviatury
int 21h ; Vyzov DOS
sub al, 30h ; Preobrazovanie ASCII koda cifry v chislovoe znachenie
cbw ; Rasshirenie znaka AL v AX (AX=AL dlya mladshego bajta i nulya dlya starshego) 
mov N, ax
mov cx, N ; 
mov ax, 0 ; 
mov bx, 3 ; 

@repeat: ; Nachalo cikla 
add ax, bx ; 
mov dx, bx ;umnojenie na 3
add bx,dx ;
add bx,dx ; 
loop @repeat ; 

mov S, ax ; 
mov dx, offset perenos; Zagruzka adresa stroki perevoda stroki v DX
mov ah, 9 ; Ustanovka funkcii DOS dlya vyvoda stroki
int 21h ; Vyzov DOS dlya vyvoda stroki
mov dx, offset vivod_S; Zagruzka adresa stroki "S=$" v DX
mov ah, 9 ; Ustanovka funkcii DOS dlya vyvoda stroki
int 21h ; Vyzov DOS dlya vyvoda stroki
mov ax, S ; Zagruzka znacheniya S v AX     

Lower: ;Vyvod mnogoznachnogo chisla na ekran 
push -1 ; Metka nachala vyvoda chisla, pomeshchaem marker v stek
mov cx, 10 ; Ustanovka delitelya 10 v CX  

L1:  
mov dx, 0 ; Obnulenie DX (starshaya chast' delimogo dlya DIV)
div cx ; Delenie AX na 10, rezul'tat v AX, ostatok v DX
push dx ; Pomeshchenie ostatka v stek (cifra chisla)
cmp ax, 0 ; Proverka, raven li rezul'tat deleniya 0
jne L1 ; Perekhod k L1, esli rezul'tat ne 0
mov ah, 2 ; Ustanovka funkcii DOS dlya vyvoda simvola 

L2:   
pop dx ; Izvlechenie cifry iz steka
cmp dx, -1 ; Proverka, dostigli li markera
je sled8 ; Perekhod k sled8, esli dostigli markera
add dl, 30h ; Preobrazovanie chisla v ASCII kod
int 21h ; Vyzov DOS dlya vyvoda simvola
jmp L2 ; Perekhod k L2 dlya sleduyushchej cifry
sled8:  

mov dx, offset perenos; Zagruzka adresa stroki perevoda stroki v DX
mov ah, 9 ; Ustanovka funkcii DOS dlya vyvoda stroki
int 21h ; Vyzov DOS dlya vyvoda stroki
mov ah, 1 ; Ustanovka funkcii DOS dlya ozhidaniya nazhatiya klavishi
int 21h ; Vyzov DOS dlya ozhidaniya nazhatiya klavishi
mov ax, 4c00h ; Ustanovka funkcii DOS dlya vyhoda iz programmy
int 21h ; Vyzov DOS dlya zaversheniya programmy

ends 

end start