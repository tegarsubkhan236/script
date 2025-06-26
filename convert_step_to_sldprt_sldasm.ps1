param (
    [string]$InputFolder = "C:\Convert\Input",
    [string]$OutputFolder = "C:\Convert\Output"
)

# Initialize SOLIDWORKS
$swApp = New-Object -ComObject SldWorks.Application
$swApp.Visible = $false

# Create output folder if it doesn't exist
if (!(Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

# Document type constants
$swDocPART     = 1
$swDocASSEMBLY = 2

# Loop through all .STEP files in the input folder
Get-ChildItem -Path $InputFolder -Filter *.step | ForEach-Object {
    $inputFile = $_.FullName
    $fileName  = $_.BaseName

    Write-Host "Opening: $inputFile"

    # Load the STEP file
    $modelDoc = $swApp.LoadFile4($inputFile, "", "", 0)

    if ($modelDoc -ne $null) {
        try {
            $docType = $modelDoc.GetType()
            $outputPath = $null

            if ($docType -eq $swDocPART) {
                $outputPath = Join-Path $OutputFolder ($fileName + ".sldprt")
                Write-Host "Detected as PART → $outputPath"
            } elseif ($docType -eq $swDocASSEMBLY) {
                $outputPath = Join-Path $OutputFolder ($fileName + ".sldasm")
                Write-Host "Detected as ASSEMBLY → $outputPath"
            } else {
                Write-Warning "Unsupported document type for: $inputFile"
                $modelDoc.Quit()
                return
            }

            # Rebuild and save
            $modelDoc.ForceRebuild3($true)
            $modelDoc.SaveAs($outputPath)
            Write-Host "Successfully saved: $outputPath"
        } catch {
            Write-Warning "Failed to save file: $inputFile"
        } finally {
            # Close the document
            $modelDoc.Quit()
        }
    } else {
        Write-Warning "Failed to open file: $inputFile"
    }
}

# Exit SOLIDWORKS
$swApp.ExitApp()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($swApp) | Out-Null

Write-Host "`nBatch conversion completed with automatic Part / Assembly detection."

