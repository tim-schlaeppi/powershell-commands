function Get-Xkcd1017 {
    Param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $Fraction,
        [switch]$Reverse
    )
    if ($Fraction -is [string])
    {
        if ($Fraction[-1] -eq "%")
        {
            $Fraction = [int]::Parse($Fraction.Replace("%", "")) / 100
        }
        else
        {
            $Fraction = [int]::Parse($Fraction)
        }
    }

    if ($Fraction -lt 0 -or 1 -lt $Fraction)
    {
        throw "Number must be between 0 and 1 or 0% and 100%"
    }

    if ($reverse)
    {
        $Fraction = 1 - $Fraction
    }

    $now = Get-Date
    $years = [math]::Exp(20.3444 * [math]::Pow($Fraction, 3) + 3) - [math]::Exp(3)

    if ($years -lt 2020)
    {
        $resultDate = $now.AddMinutes(-$years * 60 * 24 * 365.2425)
        $result = "$($resultDate.Day).$($resultDate.Month).$($resultDate.Year)"
    }
    elseif ($years -lt 4020)
    {
        $resultDate = $now.AddMinutes(-($years - 2000) * 60 * 24 * 365.2425)
        $result = "$($resultDate.Day).$($resultDate.Month).$([math]::Abs($resultDate.Year - 2000))"
        if ($resultDate.Year - 2000 -lt 0)
        {
            $result += " BC"
        }
    }
    elseif ($years -lt 1e6)
    {
        $result = "$([int]$years) years ago"
    }
    elseif ($years -lt 1e9)
    {
        $result = ( -join "$(-($now.Year - [int64]$years) / 1e6)"[0..4]) + " million years ago"
    }
    else
    {
        $result = ( -join "$(-($now.Year - [int64]$years) / 1e9)"[0..4]) + " billion years ago"
    }

    return $result
}
