Function Sinicize-Number {
  param(
    [Switch]$EchoInput,
    $Inputs = $(Read-Host '输入16位以内阿拉伯数字(或由其组成的数列)')
  )

  $Bitname = '千','百','十','万','千','百','十','亿','千','百','十','万','千','百','十',''
  $Arabic_to_Chs = @{ '0'='零'; '1'='一'; '2'='二'; '3'='三'; '4'='四'; '5'='五'; '6'='六'; '7'='七'; '8'='八'; '9'='九'}
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
    $String_Output = $String_Output -replace "零(?:千|百|十)", '零'
    $String_Output = $String_Output -replace "零+", "零"
    $String_Output = $String_Output -replace "零(亿|万)", '$1'
    $String_Output = $String_Output -replace "亿万零?", '亿零'
    $String_Output = $String_Output -replace "(.)零+$", '$1'
    $String_Output = $String_Output -replace "^一十", '十'
    $String_Output
  }
}

<# Usage

  Fisrt, dot-source this script in a PowerShell:

    $ . Path\to\Arabic-num-to-Chinese.ps1

  Then use function Sinicize-Number to convert a Arabic number to a Chinese one:

    $ Sinicize-Number -EchoInput 1003045, 2403, 529202941
    1003045
    一百万三千零四十五
    2403
    二千四百零三
    529202941
    五亿二千九百二十万二千九百四十一

#>
