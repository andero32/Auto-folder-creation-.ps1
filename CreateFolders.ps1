$ROOT = //INSERT FILE LOCATION
$YEAR = 2025
$START = '1/1'
$END = '12/31'

$SUBFOLDERS = @(
    'ACH Requests',
    'Bank Confirms',
    'CB10s',
    'CB15s',
    'Next Day ACH',
    'Prior Day ACH',
    'INVESTMENT SWEEP'
)

function Get-FolderPath ([datetime]$date) {
    
    $yearFolderName = "$($date.ToString("yyyy")) Daily Business"
    $monthFolderName = $date.ToString("MM - MMMM")
    $dayFolderName = "$($date.ToString("yyyy.MM.dd")) Daily"

    return "$ROOT\$yearFolderName\$monthFolderName\$dayFolderName"
}

$startDate = Get-Date "$START/$YEAR"
$endDate = Get-Date "$END/$YEAR"

$currentDate = $startDate
while ($currentDate -le $endDate){

    if ($currentDate.dayOfWeek -in "Saturday", "Sunday"){
        $currentDate = $currentDate.AddDays(1)
        continue
    }

    $dayFolderPath = Get-FolderPath $currentDate
    foreach($folder in $SUBFOLDERS){
        New-Item  -Path $dayFolderPath -Name $folder -ItemType Directory -Force
    }

    $currentDate = $currentDate.addDays(1)
}
