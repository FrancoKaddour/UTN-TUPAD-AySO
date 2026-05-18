# ============================================================
# TRABAJO INTEGRADOR – Arquitectura y Sistemas Operativos
# Demostración práctica: Seguridad en Windows
# EJECUTAR como Administrador en PowerShell
# ============================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DEMO DE SEGURIDAD EN WINDOWS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# ------------------------------------------------------------
# 1. ESTADO DE WINDOWS DEFENDER
# ------------------------------------------------------------
Write-Host "`n=== 1. WINDOWS DEFENDER ===" -ForegroundColor Yellow

$defender = Get-MpComputerStatus
Write-Host "Antivirus habilitado:         $($defender.AntivirusEnabled)"
Write-Host "Protección en tiempo real:    $($defender.RealTimeProtectionEnabled)"
Write-Host "Antispyware habilitado:       $($defender.AntispywareEnabled)"
Write-Host "Firewall habilitado:          $($defender.NISEnabled)"
Write-Host "Definiciones al día:          $($defender.AntivirusSignatureLastUpdated)"

# ------------------------------------------------------------
# 2. AMENAZAS DETECTADAS RECIENTEMENTE
# ------------------------------------------------------------
Write-Host "`n=== 2. AMENAZAS DETECTADAS RECIENTEMENTE ===" -ForegroundColor Yellow

$threats = Get-MpThreatDetection | Select-Object -First 5
if ($threats) {
    $threats | Format-Table ThreatName, ActionSuccess, DetectionTime -AutoSize
} else {
    Write-Host "No se encontraron amenazas recientes (buena señal)."
}

# ------------------------------------------------------------
# 3. ESTADO DEL FIREWALL DE WINDOWS
# ------------------------------------------------------------
Write-Host "`n=== 3. FIREWALL DE WINDOWS ===" -ForegroundColor Yellow

$profiles = Get-NetFirewallProfile
foreach ($profile in $profiles) {
    Write-Host "Perfil: $($profile.Name) | Habilitado: $($profile.Enabled) | Acción predeterminada entrante: $($profile.DefaultInboundAction)"
}

# ------------------------------------------------------------
# 4. PUERTOS ABIERTOS Y CONEXIONES ACTIVAS
# ------------------------------------------------------------
Write-Host "`n=== 4. PUERTOS EN ESCUCHA (SUPERFICIE DE ATAQUE) ===" -ForegroundColor Yellow
Write-Host "Servicios escuchando en la red:"

Get-NetTCPConnection -State Listen |
    Select-Object LocalAddress, LocalPort, OwningProcess |
    Sort-Object LocalPort |
    Select-Object -First 15 |
    Format-Table -AutoSize

# ------------------------------------------------------------
# 5. ÚLTIMOS INTENTOS DE LOGIN FALLIDOS (VISOR DE EVENTOS)
# ------------------------------------------------------------
Write-Host "`n=== 5. INTENTOS DE LOGIN FALLIDOS (últimos 10) ===" -ForegroundColor Yellow
Write-Host "Buscando eventos ID 4625 en el registro de seguridad..."

try {
    $failedLogins = Get-WinEvent -FilterHashtable @{
        LogName = 'Security'
        Id = 4625
    } -MaxEvents 10 -ErrorAction Stop

    foreach ($event in $failedLogins) {
        Write-Host "  $($event.TimeCreated) - $($event.Message.Split("`n")[0])"
    }
} catch {
    Write-Host "  No se encontraron intentos fallidos recientes o no hay permisos suficientes."
    Write-Host "  Tip: ejecutar PowerShell como Administrador para ver estos eventos."
}

# ------------------------------------------------------------
# 6. USUARIOS DEL SISTEMA
# ------------------------------------------------------------
Write-Host "`n=== 6. USUARIOS DEL SISTEMA ===" -ForegroundColor Yellow

$usuarios = Get-LocalUser | Select-Object Name, Enabled, LastLogon, PasswordExpires
$usuarios | Format-Table -AutoSize

# ------------------------------------------------------------
# 7. ACTUALIZACIONES PENDIENTES
# ------------------------------------------------------------
Write-Host "`n=== 7. ACTUALIZACIONES DE SEGURIDAD ===" -ForegroundColor Yellow
Write-Host "Para verificar actualizaciones pendientes:"
Write-Host "  Ejecutar: Get-WindowsUpdate (requiere módulo PSWindowsUpdate)"
Write-Host "  O ir a: Configuracion > Windows Update > Buscar actualizaciones"

# Ver las últimas actualizaciones instaladas
Write-Host "`nÚltimas 5 actualizaciones instaladas:"
Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 5 | Format-Table HotFixID, Description, InstalledOn -AutoSize

# ------------------------------------------------------------
# 8. POLÍTICA DE CONTRASEÑAS
# ------------------------------------------------------------
Write-Host "`n=== 8. POLITICA DE CONTRASEÑAS ACTUAL ===" -ForegroundColor Yellow

$policy = net accounts 2>&1
Write-Host $policy

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  FIN DE LA DEMOSTRACIÓN" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
