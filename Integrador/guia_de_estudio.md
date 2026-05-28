# Guía de Estudio — División Franco / Gonzalo
## Trabajo Integrador — Seguridad en Sistemas Operativos

---

> Qué tiene que saber cada uno para explicar su parte del video con confianza.
> No es memorizar — es entender para poder responder si el corrector pregunta algo.

---

## FRANCO — Lo que vos dominás

### Tríada CIA (Slides 4 y 5)

**Entender con ejemplos propios:**
- **Confidencialidad**: solo quien debe ver algo, lo ve. Ejemplo: `chmod 600` en tu clave SSH — nadie más puede leerla.
- **Integridad**: los datos no se modifican sin autorización. Ejemplo: si alguien cambia un script de arranque, puede tomar control del sistema.
- **Disponibilidad**: el sistema funciona cuando lo necesitás. Ejemplo: un backup te salva si un ransomware te cifra todo.

**Pregunta tipo:**
> "Si un ransomware cifra tus archivos pero no los filtra, ¿qué pilar de la CIA viola?"
> **Disponibilidad** (no podés acceder). Si los exfiltró antes de cifrar, también **Confidencialidad**.

---

### WannaCry (Slides 6 y 7)

**Lo que tenés que poder decir de memoria:**
- Explotaba el **protocolo SMB** en el **puerto 445** de Windows
- Vulnerabilidad: **CVE-2017-0144** (EternalBlue) — parche: **MS17-010**
- Cifrado: **RSA-2048** (sin la clave privada del atacante, no podés descifrar)
- Se propagaba como **gusano** — sin intervención del usuario
- El parche existía **2 meses antes** del ataque
- **200.000 equipos en 150 países** en menos de 24 horas

**Pregunta tipo:**
> "¿Por qué fue tan masivo si el parche existía?"
> Muchas organizaciones no actualizaban — hospitales con sistemas críticos que no se podían reiniciar, empresas con sistemas legacy.

---

### Seguridad en Linux (Slides 10, 11, 12, 13)

**Leer permisos — saber esto de memoria:**
```
-rwxr-xr--  archivo.sh
```
- Caracteres 2-4: permisos del **propietario** (rwx = 7)
- Caracteres 5-7: permisos del **grupo** (r-x = 5)
- Caracteres 8-10: permisos de **otros** (r-- = 4)

**Tabla octal:**
| Octal | Permisos | Uso |
|---|---|---|
| 600 | rw------- | Archivos sensibles (claves, contraseñas) |
| 644 | rw-r--r-- | Archivos de configuración |
| 755 | rwxr-xr-x | Scripts ejecutables |
| 777 | rwxrwxrwx | Inseguro — nunca en producción |

**Comandos que ejecutás en la demo:**
```bash
ls -la credenciales.txt          # Ver permisos actuales
chmod 600 credenciales.txt       # Restringir acceso
sudo grep "Failed password" /var/log/auth.log | tail -5  # Ver intentos fallidos
sudo ss -tulpn                   # Ver puertos abiertos
find /usr/bin -perm -4000 -type f 2>/dev/null  # Buscar SUID
```

**root vs sudo — la diferencia clave:**
- Root: poder absoluto, sin registro
- Sudo: comando puntual con privilegios + queda en `/var/log/auth.log`
- En producción nunca se trabaja como root directo

**ufw — reglas de oro:**
```bash
sudo ufw enable
sudo ufw default deny incoming   # Todo lo no permitido se bloquea
sudo ufw allow 22                # SSH habilitado explícitamente
sudo ufw status verbose
```

**fail2ban — el flujo:**
1. Atacante falla 5 logins SSH
2. fail2ban lee `/var/log/auth.log`
3. Bloquea la IP con una regla en iptables
4. El atacante recibe "Connection refused"

**Bit SUID — qué es:**
Archivos que se ejecutan con permisos del dueño (no del usuario que los corre). Si root es dueño y tiene vulnerabilidad, un atacante puede escalar privilegios. Por eso se auditan.

---

## GONZALO — Lo que tiene que dominar

### Amenazas (Slides 8 y 9)

**Definir con sus palabras:**
- **Malware**: cualquier software diseñado para hacer daño sin consentimiento
- **Ransomware**: malware que cifra archivos y pide rescate — subconjunto de malware
- **Phishing**: engaño por correo o sitio falso para robar credenciales
- **Fuerza bruta**: automatizar millones de intentos de login hasta acertar
- **Rootkit**: malware que se oculta en el kernel, invisible para antivirus convencionales
- **Escalada de privilegios**: pasar de usuario normal a admin sin autorización

**Pregunta tipo:**
> "¿Cuál es la diferencia entre malware y ransomware?"
> Ransomware ES malware. La diferencia es específica: cifra y extorsiona.

---

### Seguridad en Windows (Slide 14)

**UAC:**
- Sin UAC: cualquier programa hereda TUS privilegios (incluido admin si sos admin)
- Con UAC: programas arrancan con privilegios reducidos, escalan solo con aprobación explícita
- Impide que malware corra en silencio con permisos totales

**Windows Defender — cuatro componentes:**
1. **Antivirus**: detecta y elimina malware en tiempo real
2. **Firewall**: controla tráfico de red
3. **SmartScreen**: bloquea software no reconocido
4. **Exploit Guard**: protección adicional contra vulnerabilidades

**Comandos PowerShell de la demo:**
```powershell
Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 5
net accounts
```

**IDs del Visor de Eventos — de memoria:**
| ID | Significado |
|---|---|
| 4624 | Login exitoso |
| 4625 | Login fallido |
| 4720 | Se creó cuenta de usuario |
| 4732 | Usuario agregado a grupo con privilegios |

**BitLocker:**
Cuando alguien roba el equipo y extrae el disco. Sin BitLocker, conectan el disco a otra máquina y ven todo. Con BitLocker, sin la clave de recuperación, no pueden leer nada.

---

### Comparativa Linux vs Windows (Slide 15)

**Respuesta automática a "¿cuál es más seguro?":**
> "Ninguno en términos absolutos. La seguridad depende de la configuración y el mantenimiento. La variable más importante no es el sistema operativo: es el administrador."

**Diferencias clave:**
- Linux: código abierto, permisos Unix desde el diseño, parches frecuentes de la comunidad
- Windows: código cerrado, UAC desde Vista (2007), Patch Tuesday (ciclo mensual)

---

### Buenas Prácticas (Slide 16)

**Cuatro prácticas con su justificación:**

1. **Contraseñas fuertes**: una contraseña de 8 caracteres simples se crackea en segundos. Una passphrase de 4 palabras al azar tarda cientos de años y es más fácil de recordar.

2. **MFA**: Microsoft reportó que bloquea el 99.9% de los ataques automatizados. Si te roban la contraseña, sin el segundo factor no entran.

3. **Backups 3-2-1**: 3 copias, 2 soportes distintos, 1 fuera del sitio. Con backup, el ransomware es un inconveniente. Sin backup, es una pérdida total.

4. **Actualizaciones**: WannaCry = parche disponible 2 meses antes, nadie lo aplicó. Cada día sin parchear es una ventana abierta para el atacante.

---

## Qué slide le toca a quién

| Slide | Tema | Quién |
|---|---|---|
| 1 | Portada | Ambos (cámara encendida) |
| 2-3 | Índice | Gonzalo |
| 4 | Introducción | Franco |
| 5 | Tríada CIA | Franco |
| 6-7 | WannaCry | Franco |
| 8-9 | Amenazas | Gonzalo |
| 10-13 | Seguridad Linux | Franco |
| 14 | Seguridad Windows | Gonzalo |
| 15 | Comparativa | Gonzalo |
| 16 | Buenas Prácticas | Gonzalo |
| Demo | Scripts en vivo | Franco (Linux) + Gonzalo (Windows) |
| 17 | Conclusión | Franco |
| 18 | Bibliografía | Gonzalo (mención breve) |

---

## Plan para la reunión de hoy

1. **15 min** — Franco explica a Gonzalo: Tríada CIA + WannaCry. Gonzalo pregunta.
2. **15 min** — Franco explica Linux. Ejecutan `demo_linux.sh` juntos.
3. **15 min** — Gonzalo explica amenazas + Windows. Ejecutan `demo_windows.ps1` juntos.
4. **10 min** — Gonzalo explica comparativa + buenas prácticas.
5. **10 min** — Practicar el guión del video de principio a fin mirando las slides.
6. **5 min** — Acordar día y hora para grabar.

**Checkpoint:** si cada uno puede explicar su parte sin mirar los apuntes, están listos.

---

## Checklist de entrega

- [x] Documento completo (`trabajo_integrador.md`)
- [x] Scripts de demostración (`codigo/demo_linux.sh`, `codigo/demo_windows.ps1`)
- [x] Presentación (`PDF/Diapositiva_Integrador.pdf`)
- [ ] Agregar nombre del profesor en la portada
- [ ] Capturas de pantalla de los scripts corriendo (Anexos A y B)
- [ ] Subir repo a GitHub y agregar el link en el documento
- [ ] **GRABAR EL VIDEO** (10-15 min)
- [ ] Exportar documento a PDF
- [ ] Entregar en plataforma antes del 25/06/2026
