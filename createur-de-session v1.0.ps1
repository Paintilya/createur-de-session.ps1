$nomSession = Read-Host "Entrer le nom de la session (Ex: Saison - Annee)"
$outputPath = Read-Host "Entrer le chemin ou creer le dossier de la session (entrer '.\' pour creer les dossiers dans le meme repertoire que le script)"

try {
    New-Item -Path $outputPath\$nomSession -ItemType Directory -ErrorAction Stop | Out-Null
}
catch {
    Write-Host
    $reponse = Read-Host "Il existe deja un dossier pour cette session. Souhaitez-vous le recreer ? (O/n)"
    switch ($reponse) {
        "n" {
            Exit
        }
        Default {
            Remove-Item -Path $outputPath\$nomSession -Recurse
            New-Item -Path $outputPath\$nomSession -ItemType Directory | Out-Null
        }
    }
}

do {
    Write-Host
    $nombreCours = Read-Host "Entrer le nombre de cours"
    try {
        [int]$nombreCours = $nombreCours
    }
    catch {
        Write-Host Vous devez entrer un nombre...
    }
} while ($nombreCours -isnot [int])

Write-Host

$listeCours = @()

for ($i = 1;$i -le $nombreCours; $i++) {
    $listeCours+= Read-Host "Entrer le nom du cours numero $i"
}

Write-Host

foreach ($cours in $listeCours) {
    New-Item -Path $outputPath\$nomSession\$cours -ItemType Directory | Out-Null
    Write-Host [x] $cours
}

foreach ($cours in Get-ChildItem $outputPath\$nomSession) {
    $i = 1
    while ($i -lt 16) {
        New-Item -Path $outputPath\$nomSession\$cours\"Semaine $i" -ItemType Directory | Out-Null
        $i++
    }
    New-Item -Path $outputPath\$nomSession\$cours\"Projets et TPs" -ItemType Directory | Out-Null
    New-Item -Path $outputPath\$nomSession\$cours\Examens -ItemType Directory | Out-Null
}

Write-Host
Write-Host Appuyer sur une touche pour quitter...
Read-Host