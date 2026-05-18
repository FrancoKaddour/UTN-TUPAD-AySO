#!/bin/bash
# ============================================================
# TRABAJO INTEGRADOR – Arquitectura y Sistemas Operativos
# Demostración práctica: Seguridad en Linux
# ============================================================

echo "========================================"
echo "  DEMO DE SEGURIDAD EN LINUX"
echo "========================================"

# ------------------------------------------------------------
# 1. VER PERMISOS DE ARCHIVOS
# ------------------------------------------------------------
echo ""
echo "=== 1. PERMISOS DE ARCHIVOS ==="

# Crear un archivo de ejemplo
echo "Datos sensibles del sistema" > archivo_sensible.txt

# Permisos por defecto (inseguros para datos sensibles)
echo "Permisos actuales (por defecto):"
ls -la archivo_sensible.txt

# Aplicar permisos restrictivos: solo el propietario puede leer/escribir
chmod 600 archivo_sensible.txt
echo "Permisos después de chmod 600 (solo propietario):"
ls -la archivo_sensible.txt

# Crear un script ejecutable con permisos correctos
echo '#!/bin/bash\necho "script seguro"' > mi_script.sh
chmod 755 mi_script.sh
echo "Script con chmod 755 (propietario todo, resto solo leer/ejecutar):"
ls -la mi_script.sh

# ------------------------------------------------------------
# 2. GESTIÓN DE USUARIOS Y GRUPOS
# ------------------------------------------------------------
echo ""
echo "=== 2. USUARIOS Y GRUPOS ==="

# Ver el usuario actual y sus grupos
echo "Usuario actual:"
whoami

echo "Grupos del usuario actual:"
groups

echo "ID del usuario y grupos (detallado):"
id

# Ver todos los usuarios del sistema
echo "Usuarios del sistema (primeras 5 líneas de /etc/passwd):"
head -5 /etc/passwd

# ------------------------------------------------------------
# 3. FIREWALL CON UFW
# ------------------------------------------------------------
echo ""
echo "=== 3. FIREWALL (UFW) ==="
echo "Estado actual del firewall:"
sudo ufw status verbose 2>/dev/null || echo "[Requiere sudo para ver el estado del firewall]"

echo ""
echo "Comandos de ejemplo para configurar el firewall:"
echo "  sudo ufw enable                  # Activar"
echo "  sudo ufw default deny incoming   # Denegar todo entrante por defecto"
echo "  sudo ufw default allow outgoing  # Permitir todo saliente"
echo "  sudo ufw allow ssh               # Permitir SSH (puerto 22)"
echo "  sudo ufw allow 80/tcp            # Permitir HTTP"
echo "  sudo ufw allow 443/tcp           # Permitir HTTPS"
echo "  sudo ufw deny 23                 # Bloquear Telnet (inseguro)"

# ------------------------------------------------------------
# 4. VER INTENTOS DE ACCESO FALLIDOS
# ------------------------------------------------------------
echo ""
echo "=== 4. INTENTOS DE LOGIN FALLIDOS ==="
echo "Últimos intentos fallidos de autenticación:"
sudo grep "Failed password" /var/log/auth.log 2>/dev/null | tail -10 \
  || sudo grep "Failed password" /var/log/secure 2>/dev/null | tail -10 \
  || echo "[No se encontraron intentos fallidos o no hay permisos para ver el log]"

# ------------------------------------------------------------
# 5. CONEXIONES DE RED ACTIVAS
# ------------------------------------------------------------
echo ""
echo "=== 5. CONEXIONES DE RED ACTIVAS ==="
echo "Puertos en escucha (servicios expuestos):"
sudo ss -tulpn 2>/dev/null || sudo netstat -tulpn 2>/dev/null || echo "[Requiere sudo]"

# ------------------------------------------------------------
# 6. ARCHIVOS CON PERMISOS SUID (POTENCIALMENTE PELIGROSOS)
# ------------------------------------------------------------
echo ""
echo "=== 6. ARCHIVOS CON BIT SUID ==="
echo "Buscando archivos SUID en /usr/bin (se ejecutan con permisos del propietario):"
find /usr/bin -perm -4000 -type f 2>/dev/null | head -10

# ------------------------------------------------------------
# 7. VERIFICAR ACTUALIZACIONES DE SEGURIDAD
# ------------------------------------------------------------
echo ""
echo "=== 7. ACTUALIZACIONES DISPONIBLES ==="
echo "Para verificar actualizaciones de seguridad pendientes:"
echo "  sudo apt update && sudo apt list --upgradable 2>/dev/null | grep -i security"

# ------------------------------------------------------------
# LIMPIEZA
# ------------------------------------------------------------
rm -f archivo_sensible.txt mi_script.sh

echo ""
echo "========================================"
echo "  FIN DE LA DEMOSTRACIÓN"
echo "========================================"
