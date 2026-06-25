# ============================================================
#  TRABAJO INTEGRADOR - Arquitectura y Sistemas Operativos
#  Demostracion practica: Seguridad en Windows
#  Integrantes: Franco Kaddour - Gonzalo Isaias
# ============================================================
#
#  NOTA: varios comandos (Visor de Eventos, politica de
#  contrasenas) requieren ejecutar PowerShell COMO
#  ADMINISTRADOR. El script avisa si no tiene privilegios.
# ============================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   DEMO DE SEGURIDAD EN WINDOWS"          -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# ------------------------------------------------------------
# Verificar si se esta ejecutando como Administrador
# ------------------------------------------------------------
$esAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $esAdmin) {
    Write-Host "`n[ADVERTENCIA] No se ejecuta como Administrador." -ForegroundColor Yellow
    Write-Host "Algunos comandos (eventos de seguridad, net accounts) pueden fallar.`n" -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 1. ESTADO DE WINDOWS DEFENDER
# ------------------------------------------------------------
Write-Host "`n=== 1. ESTADO DE WINDOWS DEFENDER ===" -ForegroundColor Green
try {
    Get-MpComputerStatus |
        Select-Object AntivirusEnabled, RealTimeProtectionEnabled, AntivirusSignatureLastUpdated |
        Format-List
} catch {
    Write-Host "[No se pudo consultar Windows Defender en este equipo]" -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 2. AMENAZAS DETECTADAS RECIENTEMENTE
# ------------------------------------------------------------
Write-Host "`n=== 2. AMENAZAS DETECTADAS ===" -ForegroundColor Green
try {
    $amenazas = Get-MpThreatDetection -ErrorAction Stop |
        Select-Object ThreatID, ActionSuccess, InitialDetectionTime
    if ($amenazas) { $amenazas | Format-Table -AutoSize }
    else { Write-Host "Sin amenazas registradas. Sistema limpio." }
} catch {
    Write-Host "Sin amenazas registradas o sin permisos para consultarlas."
}

# ------------------------------------------------------------
# 3. ESTADO DEL FIREWALL DE WINDOWS
# ------------------------------------------------------------
Write-Host "`n=== 3. FIREWALL DE WINDOWS ===" -ForegroundColor Green
try {
    Get-NetFirewallProfile | Select-Object Name, Enabled | Format-Table -AutoSize
} catch {
    Write-Host "[No se pudo consultar el estado del firewall]" -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 4. INTENTOS DE INICIO DE SESION FALLIDOS (Evento 4625)
# ------------------------------------------------------------
Write-Host "`n=== 4. INTENTOS DE LOGIN FALLIDOS (ID 4625) ===" -ForegroundColor Green
try {
    Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 10 -ErrorAction Stop |
        Select-Object TimeCreated, Id, @{N='Mensaje';E={ ($_.Message -split "`n")[0] }} |
        Format-Table -AutoSize
} catch {
    Write-Host "[Requiere privilegios de Administrador o no hay eventos 4625 registrados]" -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 5. CUENTAS DE USUARIO LOCALES
# ------------------------------------------------------------
Write-Host "`n=== 5. CUENTAS DE USUARIO LOCALES ===" -ForegroundColor Green
try {
    Get-LocalUser | Select-Object Name, Enabled, LastLogon | Format-Table -AutoSize
} catch {
    Write-Host "[No se pudieron listar las cuentas locales]" -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 6. POLITICA DE CONTRASENAS DEL SISTEMA
# ------------------------------------------------------------
Write-Host "`n=== 6. POLITICA DE CONTRASENAS (net accounts) ===" -ForegroundColor Green
net accounts

# ------------------------------------------------------------
# 7. PUERTOS EN ESCUCHA (servicios expuestos)
# ------------------------------------------------------------
Write-Host "`n=== 7. PUERTOS EN ESCUCHA ===" -ForegroundColor Green
netstat -an | Select-String "LISTENING" | Select-Object -First 15

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "   FIN DE LA DEMOSTRACION"                 -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
