Integer Tokens
Integer Blocks
Double TokenHeight
Double BlockHeight


Function button
    ' �ʱ����s�A�ҰʩM�Ȱ��D�{��
    Do
        ' �Ұʵ{���޿�
        If Sw(1) = On Then   ' �p�G�����s�]Sw(1�^�Q���U�^
            Print "Start Signal Detected"
            Call main  ' �I�s�D�{��
        EndIf
    Loop
Fend



Function main
    ' �D�{��
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


    Print "Program Started"
    Go Retract_Safe


    ' Token �B�z�j��
    For TokenID = Tokens To 0 Step -1
        Pick_Infeed_Token(TokenID)
        'Alignment_Token(TokenID)
        Place_Tray_Token(TokenID)
    Next TokenID


    ' Block �B�z�j��
    For BlockID = Blocks To 0 Step -1
        Pick_Infeed_Block(BlockID)
        'Alignment_Block(BlockID)
        Place_Tray_Block(BlockID)
    Next BlockID


    Print "Program Finished"
    Go Retract_Safe
Fend

Function Pick_Infeed_Token(TokenID As Integer)
    ' Pick Token from Infeed
    Print "Picking Token from Infeed. Token ID = ", TokenID
    On 11
    Go Infeed_Token +Z(50 + (TokenID * TokenHeight)) CP
    Move Infeed_Token +Z(TokenID * TokenHeight)
    Wait .5
    Off 11
    Move Infeed_Token +X(-1) +Z(50 + (TokenID * TokenHeight)) CP
Fend


Function Pick_Infeed_Block(BlockID As Integer)
    ' Pick Block from Infeed
    Print "Picking Block from Infeed. Block ID = ", BlockID
    On 11
    Go Infeed_Block +Z(50 + (BlockID * BlockHeight)) CP
    Move Infeed_Block +Z(BlockID * BlockHeight)
    Wait .5
    Off 11
    Move Infeed_Block +X(-1) +Y(1) +Z(50 + (BlockID * BlockHeight)) CP
Fend


Function Alignment_Token(TokenID As Integer)
    ' Alignment Token
    Print "Aligning Token. Token ID = ", TokenID
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


Function Alignment_Block(BlockID As Integer)
    ' Alignment Block
    Print "Aligning Block. Block ID = ", BlockID
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


Function Place_Tray_Token(TokenID As Integer)
    ' Tray Token
    Print "Placing Token in Tray. Token ID = ", TokenID
    Go Tray_Token +X(-.05 * TokenID) +Y(-30. * TokenID) +Z(20) CP
    Move Tray_Token +X(-.05 * TokenID) +Y(-30. * TokenID)
    On 11
    Wait .5
    
    Move Tray_Token +X(-.05 * TokenID) +Y(-30. * TokenID) +Z(50) CP
Fend


Function Place_Tray_Block(BlockID As Integer)
    ' Tray Block
    Print "Placing Block in Tray. Block ID = ", BlockID
    Go Tray_Block +X(-.05 * BlockID) +Y(-30. * BlockID) +Z(20) CP
    Move Tray_Block +X(-.05 * BlockID) +Y(-30. * BlockID)
    On 11
    Wait .5
    Move Tray_Block +X(-.05 * BlockID) +Y(-30. * BlockID) +Z(50) CP
    On 10
    Wait .5
    Off 10
Fend