function Get-WorkProgress
{
    Param(
        [datetime]$BeginTime = (Get-Date "07:30"),
        [datetime]$EndTime = (Get-Date "17:00"),
        [int]$Precision = 5,
        [switch]$AsNumber
    )
    $now = Get-Date

    $totalTime = $EndTime - $BeginTime
    $elapsedTime = $now - $BeginTime

    $fraction = $elapsedTime.totalSeconds / $totalTime.totalSeconds

    if ($Precision -le 15)
    {
        $fraction = [math]::Round($fraction, $Precision)
    }

    if ($asNumber)
    {
        return $fraction
    }
    return "$($fraction * 100)%"

}
