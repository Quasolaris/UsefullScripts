
# encodes given file to Base64
function EncodeToBase64($filePath) {
    $fileBytes = [System.IO.File]::ReadAllBytes($filePath)
    $base64String = [System.Convert]::ToBase64String($fileBytes)
    $fileName = Split-Path $filePath -Leaf
    $outputFileName = $fileName + "_encoded.txt"
    Set-Content -Path $outputFileName -Value $base64String
    Write-Host "Encoded file and saved as: $outputFileName"
}

# decodes given file form Base64 and saves with given extension
function DecodeToBase64($filePath, $fileExtension) {
    $base64String = Get-Content $filePath -Raw
    $fileBytes = [System.Convert]::FromBase64String($base64String)
    $fileName = Split-Path $filePath -Leaf
    $outputFileName = $fileName + "_decoded." + $fileExtension
    Set-Content -Path $outputFileName -Value $fileBytes -Encoding Byte
    Write-Host "Decoded file and saved as: $outputFileName"
}

# decoding if encode or decode
$flag = $args[0]

if ($flag -eq "-e") {
    $filePath = $args[1]
    EncodeToBase64 $filePath
}

if ($flag -eq "-d") {
    $filePath = $args[1]
    $fileExtension = $args[2]
    DecodeToBase64 $filePath $fileExtension
}

if ($flag -eq "-h") {
    Write-Host ""
    Write-Host "================= Base64 Encoding and Decoding ================="
    Write-Host ""
    Write-Host "Base64_encodeDecode.ps1 [OPTION] [FILEPATH] [EXTENSION]"
    Write-Host "" 
    Write-Host "-h    Display help menu"
    Write-Host "-e    Encode"
    Write-Host "-d    Decode"
    Write-Host ""
    Write-Host "Example  for encoding: encodeDecode.ps1 -e fileToEncode.pdf          Encodes given file and saves it as FILENAME_encoded.txt"        
    Write-Host "Example for decoding:  encodeDecode.ps1 -d fileToDecode.txt pdf      Decodes file and saves it into a .pdf file as FILENAME_decoded-pdf"
    Write-Host ""
    Write-Host "================================================================="
    Write-Host ""
}

