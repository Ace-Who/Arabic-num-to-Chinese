Function Sinicize-Number {
  param(
    [Switch]$EchoInput,
    $Inputs = $(Read-Host '����16λ���ڰ���������(��������ɵ�����)')
  )

  $Bitname = 'ǧ','��','ʮ','��','ǧ','��','ʮ','��','ǧ','��','ʮ','��','ǧ','��','ʮ',''
  $Arabic_to_Chs = @{ '0'='��'; '1'='һ'; '2'='��'; '3'='��'; '4'='��'; '5'='��'; '6'='��'; '7'='��'; '8'='��'; '9'='��'}
  Foreach ($Num_Input in $Inputs) {

    $String_Input = "$Num_Input" -replace '\D', '' -replace '^0+(.)', '$1'
    $Array_Input = [Char[]]$String_Input
    $Array_Output = Foreach (
      $i in ($Bitname.Count..1 -le $String_Input.Length)
    ) {
      $Arabic_to_Chs.[String]($Array_Input[-$i]) + $Bitname[-$i]
    }
    If ($EchoInput) { $Num_Input }

    $String_Output = [String]::Join("", $Array_Output)
    $String_Output = $String_Output -replace "��(?:ǧ|��|ʮ)", '��'
    $String_Output = $String_Output -replace "��+", "��"
    $String_Output = $String_Output -replace "��(��|��)", '$1'
    $String_Output = $String_Output -replace "������?", '����'
    $String_Output = $String_Output -replace "(.)��+$", '$1'
    $String_Output = $String_Output -replace "^һʮ", 'ʮ'
    $String_Output
  }
}

<# Usage

  Fisrt, dot-source this script in a PowerShell:

    $ . Path\to\Arabic-num-to-Chinese.ps1

  Then use function Sinicize-Number to convert a Arabic number to a Chinese one:

    $ Sinicize-Number -EchoInput 1003045, 2403, 529202941
    1003045
    һ������ǧ����ʮ��
    2403
    ��ǧ�İ�����
    529202941
    ���ڶ�ǧ�Űٶ�ʮ���ǧ�Ű���ʮһ

#>
