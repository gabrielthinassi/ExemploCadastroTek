object frmConfigDatabase: TfrmConfigDatabase
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#227'o da base de dados'
  ClientHeight = 314
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lstDatabase: TValueListEditor
    Left = 0
    Top = 0
    Width = 468
    Height = 264
    Align = alClient
    Color = clWhite
    DrawingStyle = gdsGradient
    FixedColor = clSkyBlue
    GradientEndColor = clSilver
    Strings.Strings = (
      '')
    TabOrder = 0
    TitleCaptions.Strings = (
      'Campo'
      'Valor')
    ColWidths = (
      150
      312)
  end
  object Panel1: TPanel
    Left = 0
    Top = 264
    Width = 468
    Height = 50
    Align = alBottom
    BevelOuter = bvLowered
    Color = 8421440
    DoubleBuffered = False
    ParentBackground = False
    ParentDoubleBuffered = False
    TabOrder = 1
    object btnGravar: TSpeedButton
      Left = 368
      Top = 7
      Width = 92
      Height = 35
      Caption = 'Gravar'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000130B0000130B00000000000000000001FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAE3E3E3CECECE
        C0C0C0BABABABABABABEBEBECBCBCBD7D7D7F7F7F7FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDDFDFDFB2
        BEB173BA713CBA3919BA1408B90208B90213B90D34B93064B961A7BCA6D7D7D7
        FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFA
        FAC6CAC669BB6813BA1108BA0611C40F1BCD181FD21D1FD21D1CCE1A14C61108
        BA060CBA0A54BA52B9C3B8F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFCFCFCB9C5B934BB3508BB0919CA1A1EC61F1CBD1D1BB71C1BB51C1BB5
        1C1BB61C1CBC1D1DC41E1ECE1F08BB0921BB22A6BFA6F5F5F5FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFC5CEC628BE2C08BB091DC6231BB8201BB7201BB720
        1BB7201BB7201BB7201BB7201BB7201BB7201BB8201DC22209BE0F17BE1CAAC4
        ABFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFEBEBEB3EBE4608BC121CBF251BB8241B
        B8241BB9241ED0281FD92A1FD72A1ECC281BBB241BB9241BB8241BB8241BB824
        1CBC250ABD1426BE2FD4DDD5FFFFFFFFFFFFFFFFFFFFFFFF8EC59307C0171BBE
        291ABA281ABA281ABB281DD22D1FE030FFFFFFFFFFFF24DE341DCF2C1ABD281A
        BC281ABB281ABA281ABA281ABC2807BD1765BF6DFAFAFAFFFFFFFFFFFFF0F0F0
        27C2380FB8211ABC2C1ABC2C1ABE2D1DD4321EDC34FFFFFFFFFFFFFFFFFFFFFF
        FF23DE391DD1311ABE2D1ABE2D1ABD2C1ABC2C1ABC2C16BB2810C224D4E1D5FF
        FFFFFFFFFFB2DAB707BC201ABE311ABE311AC0311DD6381EDE3AFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF1EE03A1DD3371AC0321AC0321ABF311ABE311ABE
        3106B81F81CD8CFFFFFFFFFFFF75CE8405B02319C03619C2361BD43C1CDD3FFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1DE2401BD53C19C237
        19C23719C03619C0360BB32848C75EFFFFFFFFFFFF4FC7670AB32C19C33B19C4
        3C1ACF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF1DE4461BD74219C43C19C43B19C23B12BB3426BE46FFFFFFFFFFFF41C45F
        0DB93419C64119C64119C641FFFFFFFFFFFFFFFFFFFFFFFF19C64119C641FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF1DE74C1BDA4719C64119C64114BF3B1CBA40FF
        FFFFFFFFFF48C5670CBB3919C84619C94619C84619C846FFFFFFFFFFFF20CA4C
        19C84619C84619C846FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1DE6501BD94C19C8
        4614C3411EB945FFFFFFFFFFFF64D18307BC3A18CD4B18CC4B18CB4B18CB4B18
        CB4B18CB4B18CB4B18CB4B18CB4B18CB4B18CB4BFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF1ADB5018CD4B0EC34139C361FFFFFFFFFFFFA3E7B904BC3D19D05118CF
        5118CD4B18CD5018CD5018CD5018CD5018CD5018CD5018CD5018CD5018CD50FF
        FFFFFFFFFFFFFFFFFFFFFF18D15219D15105BD3E73D692FFFFFFFFFFFFEDFBF2
        09C14718D35619D25618D05518CF5518CF5518CF5518CF5518CF5518CF5518CF
        5518CF5518CF5518CF55FFFFFFFFFFFF18D15619D35619D55704C143C7F2D5FF
        FFFFFFFFFFFFFFFF62D88C03C44718D75B17D35A17D25917D15917D15917D159
        17D15917D15917D15917D15917D15917D15917D25917D35A18D55A18D75C09CB
        4E32CD69FFFFFFFFFFFFFFFFFFFFFFFFE4F9EC0ECA560DD05618D96118D55F17
        D35E17D35E17D25E17D25E17D25E17D25E17D25E17D25E17D35E17D45F18D660
        18D96114D85E03C94EC4F2D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB2F0CA03CD
        5312D86018DB6518D76317D66317D56317D56217D56217D56217D56317D56317
        D66318D96418DC6619E06703CD5382E6AAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF91EBB606D2590CD65E18DF6918DC6818DA6718D96618D96618D9
        6618DA6718DB6718DE6918E16A12DF6603D15765E398FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8F3D115D86803D35B16E26C18E26D
        18E16D18E06D18E16D18E26D19E46E18E66F04D55C09D76091EDB8FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FDF676
        EBA911DB6902D86002D65F04D86107DB6302D75F02D86008DB6561E89CE1FAEC
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF9FEFBBBF6D59AF1C170ECA867EBA39AF1C1B2F5D0ED
        FCF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = btnGravarClick
    end
  end
end
