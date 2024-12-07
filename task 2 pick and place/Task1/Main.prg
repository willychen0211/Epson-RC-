Integer Tokens
Integer Blocks
Double TokenHeight
Double BlockHeight

Function button
    ' 監控按鈕，啟動和暫停主程式
    Do
        ' 啟動程式邏輯
        If Sw(1) = On Then  ' 如果綠色按鈕（Sw(0）被按下）
            Print "Start Signal Detected"
            Call main  ' 呼叫主程式
        EndIf


        ' 暫停程式邏輯
        If Sw(4) = On Then  ' 如果紅色按鈕（Sw(1）被按下）
            Print "Pause Signal Detected. Program Paused."
            Pause  ' 呼叫暫停處理函數
            Print "Program Resumed."
        EndIf
        Wait .1  ' 每 0.1 秒檢查一次按鈕狀態
    Loop
Fend

Function main

Motor On
Power High
Speed 30
Accel 30, 30
SpeedS 500
AccelS 5000
Tool 1

Tokens = 2
Blocks = 2
TokenHeight = 6.0
BlockHeight = 6.0
Integer TokenID
Integer BlockID


Go Retract_Safe


For TokenID = Tokens To 0 Step -1
	Pick_Infeed_Token()
	'Alignment_Token()
	Place_Tray_Token()
Next TokenID


For BlockID = Blocks To 0 Step -1
	Pick_Infeed_Block()
	'Alignment_Block()
	Place_Tray_Block()
Next BlockID

Go Retract_Safe

Fend

Function Pick_Infeed_Token
	'Pick Token from Infeed
	Print "Picking Token from Infeed. Token ID = ", Tokens
	On 11
	Go Infeed_Token +Z(50 + (Tokens * TokenHeight)) CP
	Move Infeed_Token +Z(Tokens * TokenHeight)
	Wait .5
	Off 11
	Move Infeed_Token +X(-1) +Z(50 + (Tokens * TokenHeight)) CP
Fend

Function Pick_Infeed_Block
	'Pick Block from Infeed
	Print "Picking Block from Infeed. Block ID = ", Blocks
	On 11
	Go Infeed_Block +Z(50 + (Blocks * BlockHeight)) CP
	Move Infeed_Block +Z(Blocks * BlockHeight)
	Wait .5
	Off 11
	Move Infeed_Block +X(-1) +Y(1) +Z(50 + (Blocks * BlockHeight)) CP
Fend

Function Alignment_Token
	'Alignment Token
	Print "Aligning Token. Token ID = ", Tokens
	Go Align_Token +Z(20) CP
	Move Align_Token
	Off 11
	Move Align_Token +X(5)
	Move Align_Token +X(5) +Z(5) CP
	Go Align_Token +Z(5) CP
	Move Align_Token
	On 11
	Wait .5
	Move Align_Token +Z(20) CP
Fend

Function Alignment_Block
	'Alignment Block
	Print "Aligning Block. Block ID = ", Blocks
	Go Align_Block +Z(20) CP
	Move Align_Block
	Off 11
	Move Align_Block +Y(-5)
	Move Align_Block +X(5) +Y(-6) CP
	Move Align_Block +X(5) +Y(-6) +Z(5) CP
	Go Align_Block +Z(5) CP
	Move Align_Block
	On 11
	Wait .5
	Move Align_Block +Z(20) CP
Fend

Function Place_Tray_Token
    ' Tray Token
    Print "Placing Token in Tray. Token ID = ", Tokens

    If Tokens = 2 Then
        Go token_1 +Z(20) CP
        Move token_1
    ElseIf Tokens = 1 Then
        Go token_2 +Z(20) CP
        Move token_2
    ElseIf Tokens = 0 Then
        Go token_3 +Z(20) CP
        Move token_3
    Else
        Print "Error: Invalid Token ID"
        Return
    EndIf

    ' 放下物料操作
    On 11
    Wait .5
    If Tokens = 2 Then
        Move token_1 +Z(50) CP
    ElseIf Tokens = 1 Then
        Move token_2 +Z(50) CP
    ElseIf Tokens = 0 Then
        Move token_3 +Z(50) CP
    EndIf

    ' 更新 Tokens 
    Tokens = Tokens - 1
Fend


Function Place_Tray_Block
    ' Tray Block
    Print "Placing Block in Tray. Block ID = ", Blocks

    If Blocks = 2 Then
        Go block_1 +Z(20) CP
        Move block_1
    ElseIf Blocks = 1 Then
        Go block_2 +Z(20) CP
        Move block_2
    ElseIf Blocks = 0 Then
        Go block_3 +Z(20) CP
        Move block_3
    Else
        Print "Error: Invalid Block ID"
        Return
    EndIf


    ' 放下物料操作
    On 11
    Wait .5
    If Blocks = 2 Then
        Move block_1 +Z(50) CP
    ElseIf Blocks = 1 Then
        Move block_2 +Z(50) CP
    ElseIf Blocks = 0 Then
        Move block_3 +Z(50) CP
    EndIf

    ' 更新 Blocks 
    Blocks = Blocks - 1
Fend



