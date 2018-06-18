org 0x7c00
jmp hanzi

keyin db '00000000000000'

first db '1111111111111'
	  db '0000001000000'
	  db '0000001000000'
	  db '1111111111111'
	  db '0000001000000'
	  db '0000001000000'
	  db '1111111111111'
	  
	  
;/***************************************************************************/
keike:

	mov ax,0xb800      ;指向文本模式的显示缓存区  80X25
	mov es,ax

	mov ax,0x00
	mov ds,ax
	
	mov DI,0000
	mov SI,0000
	mov bx,first 
   m:	mov al,[ds:bx]
	mov byte[es:0x00+SI],al
	mov byte[es:0x01+SI],0x0c
	inc bx
	add SI,2
	cmp SI,40
	jb m
	jmp $
         


hanzi:
	mov AL,0x13			;VGA320(列)x200x8bit显示模式  显卡里有字模库 输入字符会对应字模库地址
	mov AH,0x00			;图形模式
	INT 0x10
	
	mov si,0000
	mov di,6140
	mov ax,0x0a000      ;往显存（0x0a0000开始）中放入点数据
	mov es,ax			;cs(代码段的段地址)不能用，ds/es/ss可用
	
	mov ax,0x00 ;+6140
	mov ds,ax
	
	mov bx,first
  i:mov al,[ds:bx]
    inc di
	inc bx
	inc si
	cmp si,14
	jb star_
	call star
	star_:
 	cmp al,'1'
	jne i
	mov byte[es:0x00+di],0x0c
	
	
	cmp di,8073
	jb i
	jmp $
star:
	add di,307
	mov si,1
	ret
	
	
	
	
	
	
	