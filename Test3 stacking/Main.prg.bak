Integer Tokens
Integer Blocks
Double TokenHeight
Double BlockHeight
Function main

Motor On
Power High
Speed 30
Accel 30, 30
SpeedS 500
AccelS 5000
Tool 1

Tokens = 9
Blocks = 9
TokenHeight = 6.0
BlockHeight = 6.0
Double CurrentHeight
Integer ID

CurrentHeight = 0  ' 初始化堆疊高度

Go Retract_Safe

' Loop to alternately pick and align Tokens and Blocks
For ID = Tokens To 0 Step -1
    ' Process Block
    Pick_Infeed_Block(ID)
    Alignment_Block(ID, CurrentHeight)
    CurrentHeight = CurrentHeight + BlockHeight  ' 更新堆疊高度

    ' Process Token
    Pick_Infeed_Token(ID)
    Alignment_Token(ID, CurrentHeight)
    CurrentHeight = CurrentHeight + TokenHeight  ' 更新堆疊高度
Next ID

Go Retract_Safe

Fend

Function Pick_Infeed_Token(TokenID As Integer)
    'Pick Token from Infeed
    Print "Picking Token from Infeed. Token ID = ", TokenID
    Go Infeed_Token +Z(50 + (TokenID * TokenHeight)) CP
    Move Infeed_Token +Z(TokenID * TokenHeight) CP
    On 8
    Wait .5
    Move Infeed_Token +X(-1) +Z(50 + (TokenID * TokenHeight)) CP
Fend

Function Pick_Infeed_Block(BlockID As Integer)
    'Pick Block from Infeed
    Print "Picking Block from Infeed. Block ID = ", BlockID
    Go Infeed_Block +Z(50 + (BlockID * BlockHeight)) CP
    Move Infeed_Block +Z(BlockID * BlockHeight) CP
    On 8
    Wait .5
    Move Infeed_Block +X(-1) +Y(1) +Z(50 + (BlockID * BlockHeight)) CP
Fend

Function Alignment_Token(TokenID As Integer, StackHeight As Double)
    'Align Token
    Print "Aligning Token. Token ID = ", TokenID
    Go Align_Token +Z(20 + StackHeight) CP
    Move Align_Token +Z(StackHeight) CP
    Off 8
    Wait .5
    Move Align_Token +Z(20 + StackHeight) CP
Fend

Function Alignment_Block(BlockID As Integer, StackHeight As Double)
    'Align Block
    Print "Aligning Block. Block ID = ", BlockID
    Go Align_Block +Z(20 + StackHeight) CP
    Move Align_Block +Z(StackHeight) CP
    Off 8
    Wait .5
    Move Align_Block +Z(20 + StackHeight) CP
Fend

