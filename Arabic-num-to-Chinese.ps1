Function Sinicize-Numbers {
  param(
    [Switch]$EchoInput,
    $Inputs = $(Read-Host '����16λ���ڰ���������(��������ɵ�����)')
  )

  $Bitname = @(
    'ǧ', '��', 'ʮ', '��',
    'ǧ', '��', 'ʮ', '��',
    'ǧ', '��', 'ʮ', '��',
    'ǧ', '��', 'ʮ', ''
  )
  $Arabic_to_Chs = @{
    '0'='��';
    '1'='һ';
    '2'='��';
    '3'='��';
    '4'='��';
    '5'='��';
    '6'='��';
    '7'='��';
    '8'='��';
    '9'='��';
  }

  Foreach ($Num_Input in $Inputs) {

    # Remove characters in input numbers that are not Arabic numerals.
    # Remove leading zeros unless the given number is a single 0.
    $String_Input = "$Num_Input" -replace '\D', '' -replace '^0+(.)', '$1'

    # Split the number into single numerals and convert them respectively.
    $Array_Input = [Char[]]$String_Input
    $Array_Output = Foreach (
      $i in ($Bitname.Count..1 -le $String_Input.Length)
    ) {
      $Arabic_to_Chs.[String]($Array_Input[-$i]) + $Bitname[-$i]
    }

    # Handle edge cases, most of which are about zeros.
    $String_Output = [String]::Join("", $Array_Output) `
      -replace "��(?:ǧ|��|ʮ)", '��' `
      -replace "��+", "��" `
      -replace "��(��|��)", '$1' `
      -replace "������?", '����' `
      -replace "(.)��+$", '$1' `
      -replace "^һʮ", 'ʮ'

    # Return/Output
    If ($EchoInput) { $Num_Input }
    $String_Output
  }
}

<# Usage

  Fisrt, dot-source this script in a PowerShell:

    $ . Path\to\Arabic-num-to-Chinese.ps1

  Then use function Sinicize-Numbers to convert a Arabic number to a Chinese one:

    $ Sinicize-Numbers -EchoInput 1003045, 2403, 529202941
    1003045
    һ������ǧ����ʮ��
    2403
    ��ǧ�İ�����
    529202941
    ���ڶ�ǧ�Űٶ�ʮ���ǧ�Ű���ʮһ

#>
