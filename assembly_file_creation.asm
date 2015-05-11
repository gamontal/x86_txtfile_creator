
.model small

.stack 100h

.data 

	border1 db 50 dup("_"),'$' 

	border2 db "³", '$'

	border3 db "±", '$'
	
	header db "  File creation  ", '$'

	notif db "New form? Press [s] Exit without saving? Press [n]", '$'

	c db ?

	fn db 150 dup(?), "$"

        msg1 db "Enter the file name :", "$"

	msg2 db "File has been created successfully.", "$"


.code

	main proc

        mov  ax,@data
  	mov  ds,ax


	mov c, 2
              

	mov ah, 6 
	mov al, 0 
	mov ch, 0                 
	mov cl, 0                 
	mov dh, 25                
	mov dl, 80                
	mov bh, 00000111b  
	INT 10h  
        
	
	; header attributes       
	
	mov ah, 6 
	mov al, 0 
	mov ch, 0               
	mov cl, 0                
	mov dh, 0              
	mov dl, 79             
	mov bh, 00010000b  
	INT 10h
	
	mov ah, 2 
	mov dh, 0
	mov dl, 0
	mov bh, 0 
	INT 10h 

    	mov  ah,9
        mov  dx,offset header
    	int  21h
  

	; right-shadow

	mov ah, 6 
	mov al, 0 
	mov ch, 3     
	mov cl, 65            
	mov dh, 21          
	mov dl, 65       
	mov bh, 10000000b  
	INT 10h

	; bottom-shadow

	mov ah, 6 
	mov al, 0 
	mov ch, 24    
	mov cl, 16           
	mov dh, 22          
	mov dl, 65       
	mov bh, 10000000b  
	INT 10h



	;set-borders
					     
	mov ah, 2                            
	mov dh, 1
	mov dl, 15
	mov bh, 0 
	INT 10h 

    	mov  ah,9
        mov  dx,offset border1
    	int  21h

	mov ah, 2 
	mov dh, 21
	mov dl, 15
	mov bh, 0 
	INT 10h 

    	mov  ah,9
        mov  dx,offset border1
    	int  21h


	mov cx, 20
	

	mov cx, 20
	VERRIGHT:

	mov ah, 2 
	mov dh, c
	mov dl, 64
	mov bh, 0 
	INT 10h 

	add c, 1

    	mov  ah,9
        mov  dx,offset border3
    	int  21h
	
	loop VERRIGHT

	;borders [end]



	mov ah, 6 
	mov al, 0 
	mov ch, 2    
	mov cl, 15           
	mov dh, 21          
	mov dl, 63    
	mov bh, 00010000b  
	INT 10h  

	print macro arg
	mov dx, offset arg
	mov ah, 09h
	int 21h
	
	endm

.startup


	mov ah, 2 
	mov dh, 8
	mov dl, 19
	mov bh, 0 
	INT 10h


	print msg1
	mov di, offset fn

	mov ah, 2 
	mov dh, 8
	mov dl, 40
	mov bh, 0 
	INT 10h

	read:

	mov ah, 01h
	int 21h

	cmp al, 13
	je crte

	mov [di], al
	inc di
	jmp read
	

	crte:

	mov cx, 0
	mov dx, offset fn
	mov ah, 3ch
	int 21h

	mov ah, 2 
	mov dh, 13
	mov dl, 19
	mov bh, 0 
	INT 10h


	print msg2

.exit


main endp


end main


