TITLE ATM Managemwnt System

INCLUDE Irvine32.inc

.data
first BYTE "CHOOSE AN OPTION[1-2]           1- User        2- ADMIN ", 0
correctPassword BYTE "123",0
newpass BYTE 20 DUP(?)
inputPassword BYTE 20 DUP(?)
adm byte "CHOOSE AN OPTION    1- Change Password       2- Open Cash Box      3- Exit   ",0
cb byte "              Cash Box Opened         ",0
np byte "      Enter new password[max 20 letter]        ",0
npc byte "       New password is set     ",0
admpass_inp BYTE "Enter passwordto login as admin: ", 0
welcomeMsg BYTE "            Welcome, admin!", 0
accessDeniedMsg BYTE "   Wrong Password!! Access denied.", 0
msgwelcome byte "                         Welcome To ATM System                  ",0
ASKUSER byte "CHOOSE AN OPTION[1-3]   1- New User        2- for Existing customer      3- to exit",0
err1 byte "Invalid choice",0
INPUTUSER byte "Enter user",0
PASS_INP byte "Enter Password:",0
erruser byte "Incorrect Details",0
errneg byte "You can not input negative amount.",0
user1 byte 20 dup (?)
amount1 byte 20 dup (?)
amountsize1 dword ?
filehandle dword ?
money2 byte 20 dup (?)
amountsize2 dword ?
count dword ?
moneyfile byte "moneyfile.txt",0
temp dword ?
amount2 byte 20 dup (?)
amount dword ?
customer byte"Customer:   ",0
amount12 byte "amount:    ",0
usersize1 dword ?
passsize1 dword ?
STR_ACTION byte "Choose any options[1-4]     "
byte " 1-  Deposit     2- Withdrawal      3-  Display Amount    4- Display details and Quit",0
pass1 byte 20 dup (?)
DEP byte "Amount Deposited",0
WITH byte "Amount Withdrawed",0
ERR_MONEY byte "Not enough money",0
userfile byte "user.txt",0
passfile byte "password.txt",0
trans_msg byte "             Choose any transaction    ",0
user2 byte 20 dup (?)
first_amnt byte "Enter Your Opening Amount",0
pass2 byte 20 dup (?)
usersize2 dword ?
passsize2 dword ?
msg12 byte "User Created",0
msgwithdrawal byte " Enter Amount to Withdraw: ",0
msgdeposit byte " Enter  Amount to Deposit: ",0


.code

main PROC

mov eax,red+(BLACK*16)
call settextcolor

mov edx,offset msgwelcome
call writestring
call crlf

label_start:

call crlf
mov edx,offset first
call writestring
call crlf
call readint
cmp eax,1
je loop_askuser
cmp eax,2
je   ret2
mov edx,offset err1
call writestring
call crlf
call crlf
jmp label_start
ret2:
 mov edx, OFFSET admpass_inp     ; Display the admpass_inp
    call WriteString

    mov edx, OFFSET inputPassword  ; Address to store input
    mov ecx, 20                   ; Maximum characters to read
    call ReadString               ; Read input password

    ; Compare the entered password with the correct password
    mov esi, OFFSET correctPassword
    mov edi, OFFSET inputPassword

    mov ecx, lengthof correctPassword  ; Initialize counter
    repe cmpsb  ; Compare byte by byte
    jz correctPasswordMatch ; If zero, passwords match

    ; If passwords don't match
    mov edx, OFFSET accessDeniedMsg
    call WriteString
    JMP label_start

correctPasswordMatch:
    ; If passwords match
    mov edx, OFFSET welcomeMsg
    call WriteString
    jmp adminfunc
                  ;               USER 
loop_askuser:

call crlf
call crlf

mov edx,offset ASKUSER
call writestring
call crlf

call crlf

call readdec

cmp eax,2

je loop_existtuser

cmp eax,1

je loop_newtuser

cmp eax,3

je label_exit

call crlf
call crlf

mov edx,offset err1
call writestring
call crlf
call crlf

jmp loop_askuser

label_exit:
exit

loop_existtuser:
mov count,1
call crlf
call crlf

mov edx,offset INPUTUSER
call writestring
call crlf
call crlf

mov edx,offset user1
mov ecx,sizeof user1
call readstring
call crlf
call crlf

mov edx,offset PASS_INP
call writestring
call crlf
call crlf

mov edx,offset pass1
mov ecx,sizeof pass1
call readstring

mov edx,offset userfile
call openinputfile

mov edx,offset user2
mov ecx,lengthof user2
call readfromfile

mov edx,offset passfile
call openinputfile

mov edx,offset pass2
mov ecx,lengthof pass2
call readfromfile

mov edx,offset user1
mov ecx,lengthof user1
mov esi,0

l2:

cmp user1[esi],0

je l3

inc esi

loop l2

l3:

mov eax,lengthof user1
sub eax,ecx
mov usersize1,eax

mov edx,offset user2
mov ecx,lengthof user2
mov esi,0

l4:

cmp user2[esi],0

je l5

inc esi

loop l4

l5:

mov eax,lengthof user2
sub eax,ecx
mov usersize2,eax

mov edx,offset pass1
mov ecx,lengthof pass1
mov esi,0

l6:

cmp pass1[esi],0

je l7

inc esi

loop l6

l7:

mov eax,lengthof pass1
sub eax,ecx
mov passsize1,eax

mov edx,offset pass2
mov ecx,lengthof pass2
mov esi,0

l8:

cmp pass2[esi],0

je l9

inc esi

loop l8

l9:

mov eax,lengthof pass2
sub eax,ecx
mov passsize2,eax


mov ecx,usersize1
cmp ecx,usersize2

jne loop_existtuser2

mov esi,0

loop_existtuser0:

mov al,user1[esi]
cmp al,user2[esi]

jne loop_existtuser2

inc esi

loop loop_existtuser0


mov ecx,passsize1
cmp ecx,passsize2

jne loop_existtuser2

mov esi,0

loop_existtuser3:

mov al,pass1[esi]
cmp al,pass2[esi]

jne loop_existtuser2

inc esi

loop loop_existtuser3


jmp loop_existtuser6

loop_existtuser2:

call crlf
call crlf

mov edx,offset erruser
call writestring
call crlf
call crlf

jmp loop_askuser


loop_newtuser:

call crlf
call crlf

mov edx,offset INPUTUSER
call writestring
call crlf
call crlf

mov edx,offset user1
mov ecx,sizeof user1
call readstring
call crlf
call crlf

mov edx,offset PASS_INP
call writestring
call crlf
call crlf

mov edx,offset pass1
mov ecx,sizeof pass1
call readstring
call crlf
call crlf

mov edx, OFFSET userfile
call CreateOutputFile

mov edx,offset user1
mov ecx,lengthof user1
call writetofile


mov edx, OFFSET passfile
call CreateOutputFile

mov edx,offset pass1
mov ebx,0
mov ecx,lengthof pass1
call writetofile


mov edx,offset msg12
call writestring
call crlf
call crlf


mov edx,offset first_amnt
call writestring
call crlf
call crlf


mov edx,offset amount1
mov ecx,sizeof amount1
call readstring


jmp l89


loop_existtuser6:

mov edx,offset moneyfile
call openinputfile

mov filehandle,eax

mov edx,offset amount1
mov ecx,lengthof amount1

call readfromfile

mov eax,filehandle
call closefile

l89:

mov esi,0
mov ecx,lengthof amount1

l25:

mov al,amount1[esi]
cmp al,0

je l26

inc esi

loop l25

l26:

mov eax,lengthof amount1

sub eax,ecx

mov amountsize1,eax

mov eax,0
mov esi,0

mov ecx,amountsize1

l31:

movzx ebx,amount1[esi]

sub ebx,'0'

mov edx,10

mul edx

add eax,ebx

inc esi

loop l31

mov amount,eax

mov edx,offset trans_msg
call writestring
call crlf
call crlf

label_ret_useropt:

mov edx,offset STR_ACTION
call writestring
call crlf
call crlf

call readdec

cmp eax,1
je label_deposit

cmp eax,2
je labeL_withdraw

cmp eax,3
je labeL_display_amount

cmp eax,4
je labeL_display_info

        ;                     DEPOSIT
label_deposit:

mov edx,offset msgdeposit
call writestring
call crlf
call crlf

call readint
test eax,eax 
js negvalue

add amount,eax

jmp label_ret_useropt


          ;                    NEG VALUE
negvalue:
mov edx,offset errneg
call writestring
call crlf
call crlf

jmp label_ret_useropt
  ;                              NOT ENOUGH MONEY
label_drained:
mov edx,offset ERR_MONEY
call writestring
call crlf
call crlf

jmp label_ret_useropt


            ;                       WITHDRAW
labeL_withdraw:
mov edx,offset msgwithdrawal
call writestring
call crlf
call crlf
call readint
test eax,eax 
js negvalue
cmp eax,amount
          
jnbe label_drained

sub amount,eax

mov edx,offset WITH

call writestring


call crlf
call crlf
jmp label_ret_useropt

             ;                Display_amount
labeL_display_amount:
mov eax,amount
call writedec
call crlf
call crlf
jmp label_ret_useropt

             ;                Display_ Information
labeL_display_info:
mov edx,offset customer
call writestring
mov edx,offset user1
call writestring
call crlf

mov edx,offset amount12
call writestring
mov eax,amount
call writedec
call crlf


mov esi,0
mov eax,amount

l71:

mov edx,0
mov ebx,10
div ebx

add edx,0
mov temp,edx

mov dl,byte ptr temp
add dl,'0'
mov amount1[esi],dl

cmp eax,0

je l72

inc esi


loop l71

l72:
	

mov esi,0
mov ecx,lengthof amount1

l73:

mov al,amount1[esi]
cmp al,0

je l74

inc esi

loop l73

l74:

mov eax,lengthof amount1
sub eax,ecx
mov amountsize1,eax


mov esi,0
mov ecx,amountsize1


mov edx,amountsize1
sub edx,1


l76:


mov al,amount1[esi]

mov amount2[edx],al


inc esi

dec edx

loop l76



mov edx,offset moneyfile
call createoutputfile
mov filehandle,eax

mov edx,offset amount2
mov ecx,lengthof amount2

call writetofile
call closefile
                      ;ADMIN
adminfunc:
ret1:
call crlf
mov edx,offset adm
call writestring
call crlf
call readint
cmp eax,2
je openc
cmp eax,1
je newp
cmp eax,3
je exit1
mov edx,offset err1
call writestring
call crlf
call crlf
jmp ret1


;                      New password
newp:
mov edx,offset np
call writestring
call crlf
mov edx,offset newpass
mov ecx,sizeof newpass
call readstring
    mov esi, OFFSET newpass
    mov edi, OFFSET correctPassword
    mov ecx, LENGTHOF newpass  
    rep movsb  
mov edx,offset npc
call writestring
call crlf
jmp ret2


      ;               OPEN CASH BOX
openc:
mov edx,offset cb
call writestring
call crlf
jmp ret2


          ;               EXIT
exit1:
exit
main ENDP
END main