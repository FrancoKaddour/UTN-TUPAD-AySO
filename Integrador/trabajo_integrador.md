# Universidad Tecnológica Nacional
## Regional Venado Tuerto

---

# Seguridad en los Sistemas Operativos
### Amenazas, mecanismos de protección y buenas prácticas

---

**Materia:** Arquitectura y Sistemas Operativos
**Comisión:** 11
**Integrantes:** Franco Kaddour — Gonzalo Isaias
**Año:** 2026

---

## Índice

1. Introducción
2. ¿Qué es la seguridad en sistemas operativos?
3. Caso de estudio: WannaCry
4. Principales amenazas
5. Seguridad en Linux
6. Seguridad en Windows
7. Comparativa: Linux vs. Windows
8. Buenas prácticas
9. Demostración práctica
10. Conclusión
11. Bibliografía

---

## 1. Introducción

El sistema operativo es el núcleo sobre el que corre todo el software de una computadora. Cuando es vulnerado, todo lo que depende de él queda expuesto: datos, aplicaciones y usuarios.

La seguridad informática dejó de ser una preocupación exclusiva de grandes empresas o gobiernos. En la actualidad, cualquier dispositivo conectado a internet representa un blanco potencial. Los ataques son automatizados, globales y cada vez más accesibles para quien quiera ejecutarlos.

Este trabajo tiene como objetivos:

- Analizar las principales amenazas que enfrentan los sistemas operativos modernos.
- Comprender los mecanismos de defensa disponibles en Linux y Windows.
- Conocer las buenas prácticas que todo administrador y usuario debe aplicar.
- Demostrar, de forma práctica, cómo se configuran estas protecciones en un sistema real.

---

## 2. ¿Qué es la seguridad en sistemas operativos?

La seguridad en sistemas operativos es el conjunto de mecanismos, políticas y prácticas diseñados para proteger los recursos del sistema frente a accesos no autorizados, modificaciones indebidas o destrucción de información.

### 2.1 La Tríada CIA

Todo sistema seguro debe garantizar tres propiedades fundamentales, conocidas como la **Tríada CIA**:

| Propiedad | Descripción | Ejemplo práctico |
|---|---|---|
| **Confidencialidad** | Solo usuarios autorizados acceden a la información | Permisos de archivo, cifrado de disco |
| **Integridad** | La información no puede ser alterada sin autorización | Hashes, control de permisos de escritura |
| **Disponibilidad** | El sistema funciona cuando se lo necesita | Backups, protección contra ataques DoS |

### 2.2 Principio de mínimo privilegio

Cada usuario o proceso debe contar con **solo los permisos necesarios** para cumplir su función, y no más. Este principio es fundamental porque limita el daño potencial cuando una cuenta o proceso es comprometido: si un atacante accede a una cuenta con permisos bajos, no podrá afectar al resto del sistema fácilmente.

---

## 3. Caso de estudio: WannaCry (2017)

### 3.1 Contexto

En mayo de 2017, el ransomware **WannaCry** infectó más de **200.000 sistemas en 150 países** en menos de 24 horas. El ataque paralizó hospitales del Reino Unido, empresas de telecomunicaciones, bancos y organismos gubernamentales. El costo económico global estimado superó los **4.000 millones de dólares**.

### 3.2 ¿Cómo funcionó?

El ataque siguió una secuencia completamente automatizada:

| Etapa | Acción |
|---|---|
| **1. Escaneo** | Buscaba equipos con el puerto 445 abierto (protocolo SMB de Windows) |
| **2. Explotación** | Utilizaba *EternalBlue*, una vulnerabilidad crítica de Windows aún sin parchar |
| **3. Instalación** | Instalaba un backdoor con control total sobre el sistema comprometido |
| **4. Cifrado** | Cifraba todos los archivos del usuario y los renombraba con extensión `.WNCRY` |
| **5. Extorsión** | Mostraba un mensaje exigiendo 300 USD en Bitcoin para recuperar los datos |
| **6. Propagación** | Se replicaba automáticamente hacia otros equipos de la misma red |

### 3.3 La lección más importante

Microsoft había publicado el parche de seguridad correspondiente (**MS17-010**) dos meses antes del ataque. Los sistemas infectados simplemente **no estaban actualizados**.

WannaCry no explotó una vulnerabilidad desconocida ni requirió técnicas avanzadas. Explotó la negligencia. Este caso demuestra que muchos de los incidentes más graves de la historia no ocurrieron por falta de tecnología disponible, sino por falta de aplicación de medidas básicas.

---

## 4. Principales amenazas

### 4.1 Por tipo de ataque

| Amenaza | Descripción |
|---|---|
| **Malware** | Software malicioso diseñado para dañar, robar o espiar (virus, troyanos, spyware) |
| **Ransomware** | Variante de malware que cifra los datos del sistema y exige un pago para recuperarlos |
| **Phishing** | Correos electrónicos o páginas web falsas creadas para robar credenciales |
| **Fuerza bruta** | Intentos automatizados y masivos de adivinar contraseñas hasta dar con la correcta |
| **Rootkit** | Malware que opera a nivel kernel del sistema, haciéndose invisible para el antivirus |
| **Escalada de privilegios** | Técnica por la cual un atacante con acceso limitado logra obtener control total del sistema |

### 4.2 Por capa del sistema atacada

Los ataques no ocurren todos de la misma forma. Clasificarlos según la capa del sistema que comprometen ayuda a entender dónde aplicar las defensas:

| Capa | Ejemplos de ataques |
|---|---|
| **Red** | Escaneo de puertos, fuerza bruta SSH, denegación de servicio (DoS) |
| **Usuario** | Phishing, ingeniería social, malware ejecutado por el usuario |
| **Aplicación** | Exploits de software, inyección de código, desbordamiento de buffer |
| **Kernel** | Rootkits, vulnerabilidades del núcleo del sistema operativo |

---

## 5. Seguridad en Linux

### 5.1 Filosofía de seguridad

Linux fue diseñado como un sistema multiusuario con separación estricta de privilegios. El principio de mínimo privilegio no es una capa agregada sobre el sistema: es parte de su diseño original. Esto explica por qué Linux tiene, de base, una superficie de ataque menor que otros sistemas.

### 5.2 Modelo de permisos Unix

Linux asigna permisos a tres niveles: **propietario**, **grupo** y **otros**. Cada nivel puede tener tres tipos de acceso: **lectura (r)**, **escritura (w)** y **ejecución (x)**.

**Cómo leer los permisos de un archivo:**

```
-rwxr-xr--   script.sh
 |||└──┘└──┘
 |||  |   └── Otros      → solo lectura
 |||  └─────── Grupo      → lectura y ejecución
 ||└────────── Propietario → lectura, escritura y ejecución
 |└─────────── Tipo: - archivo | d directorio | l enlace
```

**Notación numérica (la más utilizada en la práctica):**

| Número | Permisos | Uso típico |
|---|---|---|
| `777` | rwxrwxrwx | Todos pueden hacer todo — **INSEGURO** |
| `755` | rwxr-xr-x | Scripts y binarios ejecutables |
| `644` | rw-r--r-- | Archivos de configuración |
| `600` | rw------- | Archivos sensibles (claves SSH, contraseñas) |

**Comandos principales:**

```bash
ls -la                          # Ver permisos de todos los archivos del directorio
chmod 600 archivo_sensible.txt  # Solo el propietario puede leer y escribir
chmod 755 script.sh             # Ejecutable por todos, editable solo por el dueño
chown usuario:grupo archivo.txt # Cambiar propietario y grupo del archivo
```

### 5.3 root vs. sudo

`root` es el superusuario de Linux: tiene acceso irrestricto a todo el sistema. Trabajar directamente como root es una mala práctica porque cualquier error, o cualquier malware ejecutado en esa sesión, tiene consecuencias sobre todo el sistema.

`sudo` es la alternativa segura: permite ejecutar comandos con privilegios de forma puntual, controlada y **auditada**.

```bash
sudo apt update       # Ejecutar un comando con privilegios sin iniciar sesión como root
sudo -l               # Ver qué comandos puede ejecutar el usuario actual con sudo
```

Cada comando ejecutado con `sudo` queda registrado en `/var/log/auth.log`. Esto permite auditar exactamente qué se hizo y cuándo, lo cual es fundamental en entornos de producción o ante un incidente de seguridad.

### 5.4 Firewall con ufw

`ufw` (Uncomplicated Firewall) es la herramienta recomendada para gestionar el firewall en sistemas basados en Ubuntu o Debian. Permite definir qué tráfico de red se acepta y qué se rechaza.

```bash
sudo ufw enable                   # Activar el firewall
sudo ufw default deny incoming    # Rechazar todo el tráfico entrante por defecto
sudo ufw default allow outgoing   # Permitir todo el tráfico saliente
sudo ufw allow 22                 # Permitir conexiones SSH
sudo ufw allow 80/tcp             # Permitir tráfico HTTP
sudo ufw deny 23                  # Bloquear Telnet (protocolo sin cifrado, inseguro)
sudo ufw status verbose           # Ver el estado y las reglas activas
```

La regla más importante es `default deny incoming`: si no se permite explícitamente un tipo de tráfico, el sistema lo rechaza. Esto reduce drásticamente la superficie de ataque expuesta a internet.

### 5.5 Protección contra fuerza bruta: fail2ban

`fail2ban` monitorea los registros del sistema y bloquea automáticamente las direcciones IP que muestran comportamiento malicioso, como múltiples intentos de login fallidos.

**Flujo de acción ante un ataque de fuerza bruta:**

```
El atacante intenta 5 logins SSH fallidos en menos de 10 minutos
                        ↓
fail2ban detecta el patrón leyendo /var/log/auth.log
                        ↓
Agrega una regla automática en iptables bloqueando esa IP por 1 hora
                        ↓
El atacante recibe "Connection refused" y no puede seguir intentando
```

### 5.6 Monitoreo y auditoría

El monitoreo continuo permite detectar actividad anómala antes de que se convierta en un incidente:

```bash
# Ver intentos de login fallidos (evidencia de fuerza bruta)
sudo grep "Failed password" /var/log/auth.log | tail -20

# Ver usuarios actualmente conectados al sistema
who

# Ver todos los puertos en escucha (servicios expuestos a la red)
sudo ss -tulpn

# Buscar archivos con permisos SUID (posible vector de escalada de privilegios)
find /usr/bin -perm -4000 -type f
```

---

## 6. Seguridad en Windows

### 6.1 Control de Cuentas de Usuario (UAC)

El **UAC** (User Account Control) es el mecanismo que solicita confirmación al usuario cada vez que una aplicación intenta realizar cambios que requieren privilegios administrativos.

**Sin UAC:** cualquier programa ejecutado por el usuario hereda automáticamente todos sus privilegios, incluido el acceso administrativo.

**Con UAC:** los programas corren con privilegios reducidos por defecto. Solo cuando el usuario aprueba explícitamente la solicitud, se les otorga la elevación necesaria.

Esto impide que malware instalado sin conocimiento del usuario actúe en silencio con permisos totales sobre el sistema.

### 6.2 Windows Defender

Windows Defender es la suite de seguridad integrada en Windows 10 y 11. No requiere instalación adicional y ofrece protección activa desde el inicio del sistema.

| Componente | Función |
|---|---|
| **Antivirus** | Detección y eliminación de malware en tiempo real |
| **Firewall** | Control del tráfico de red entrante y saliente |
| **SmartScreen** | Bloquea la ejecución de software no reconocido o potencialmente peligroso |
| **Exploit Guard** | Protección adicional contra vulnerabilidades en aplicaciones instaladas |

```powershell
# Ver el estado actual del antivirus
Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled

# Ver amenazas detectadas recientemente
Get-MpThreatDetection | Select-Object ThreatName, ActionSuccess, DetectionTime
```

### 6.3 BitLocker — Cifrado de disco completo

BitLocker cifra la totalidad del disco. Si alguien sustrae físicamente la computadora y extrae el disco, **no puede acceder a los datos** sin la clave de recuperación.

Activación: `Panel de Control → Sistema y Seguridad → Cifrado de Unidad BitLocker`

Es especialmente relevante en equipos portátiles o en entornos donde el acceso físico al hardware no puede garantizarse completamente.

### 6.4 Visor de Eventos

El Visor de Eventos (`eventvwr.msc`) registra toda la actividad relevante del sistema. Para seguridad, los eventos más importantes son:

| ID de evento | Significado |
|---|---|
| `4624` | Inicio de sesión exitoso |
| `4625` | Intento de inicio de sesión fallido |
| `4720` | Se creó una nueva cuenta de usuario |
| `4732` | Un usuario fue agregado a un grupo con privilegios |

Detectar múltiples eventos **4625** provenientes de la misma dirección IP es una señal clara de un ataque de fuerza bruta en curso.

### 6.5 Windows Update

WannaCry demostró de manera contundente que no aplicar actualizaciones es una de las decisiones más riesgosas en administración de sistemas. Windows Update distribuye parches de seguridad que corrigen vulnerabilidades conocidas públicamente.

Cada vulnerabilidad publicada es también un manual de instrucciones para los atacantes. Cuanto más tiempo pasa sin aplicar un parche, mayor es la ventana de exposición.

---

## 7. Comparativa: Linux vs. Windows

| Aspecto | Linux | Windows |
|---|---|---|
| **Malware existente** | Cantidad reducida | Enorme volumen de amenazas activas |
| **Modelo de privilegios** | root/sudo — integrado desde el diseño | UAC — incorporado a partir de Vista (2007) |
| **Firewall** | iptables / ufw — integrado en el kernel | Windows Defender Firewall |
| **Actualizaciones** | Gestionadas por el administrador | Automatizadas por Microsoft |
| **Uso en servidores** | Dominante (más del 70% del mercado) | Relevante en entornos corporativos |
| **Configurabilidad** | Muy alta — control total del sistema | Moderada — algunas políticas son fijas |
| **Curva de aprendizaje** | Mayor — requiere conocimiento de terminal | Menor — interfaz gráfica completa |

**Conclusión de la comparativa:** ninguno de los dos sistemas es inherentemente más seguro en términos absolutos. La seguridad real depende de la configuración, el mantenimiento y las prácticas del administrador. Un sistema Linux mal configurado puede ser más vulnerable que un Windows correctamente mantenido, y viceversa.

---

## 8. Buenas prácticas

### 8.1 Contraseñas seguras

| Contraseña | Tiempo estimado para crackear |
|---|---|
| `123456` | Instantáneo |
| `Contraseña1` | Menos de un segundo |
| `Xk#9mP$vL2qN` | Cientos de años |
| `caballo-bateria-grapa-luz` (passphrase) | Cientos de años — y fácil de recordar |

Se recomienda utilizar un **gestor de contraseñas** (Bitwarden, KeePassXC) para generar y almacenar contraseñas únicas para cada servicio, sin necesidad de memorizarlas todas.

### 8.2 Autenticación Multifactor (MFA)

La MFA agrega una segunda capa de verificación además de la contraseña. Aunque un atacante obtenga las credenciales, no puede acceder al sistema sin el segundo factor.

> Microsoft reportó que la autenticación multifactor bloquea el **99,9% de los ataques automatizados** sobre cuentas.

**Tipos de segundo factor (de menor a mayor seguridad):**

1. SMS — código por mensaje de texto (vulnerable a SIM swapping)
2. App TOTP — Google Authenticator, Authy (código renovado cada 30 segundos)
3. Llave de seguridad física — YubiKey (resistente a phishing)

### 8.3 Regla de backups 3-2-1

| Número | Significado |
|---|---|
| **3** | Tres copias de los datos |
| **2** | En dos soportes de almacenamiento distintos (ej: disco local y nube) |
| **1** | Una copia almacenada fuera del sitio físico |

Con un backup reciente y bien resguardado, un ataque de ransomware se convierte en un inconveniente temporal. Sin backup, es una pérdida total e irreversible.

### 8.4 Actualizaciones de seguridad

Aplicar parches de seguridad dentro de los **30 días** de su publicación es una práctica estándar en administración de sistemas. Las vulnerabilidades se publican con detalle técnico, y los atacantes automatizan su explotación a las pocas horas de la divulgación.

---

## 9. Demostración práctica

### 9.1 En Linux

**Gestión de permisos — proteger un archivo sensible:**

```bash
# Crear un archivo con información sensible
echo "Clave de acceso: SuperSecreta123" > credenciales.txt

# Verificar permisos actuales (por defecto, otros usuarios pueden leerlo)
ls -la credenciales.txt

# Aplicar permisos restrictivos: solo el propietario puede leer y escribir
chmod 600 credenciales.txt
ls -la credenciales.txt
# Resultado esperado: -rw------- 1 franco franco ...
```

**Configuración del firewall:**

```bash
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22
sudo ufw status verbose
```

**Verificar intentos de acceso no autorizado:**

```bash
# Ver las últimas 10 líneas con intentos fallidos de login
sudo grep "Failed password" /var/log/auth.log | tail -10
```

### 9.2 En Windows

**Estado de Windows Defender:**

```powershell
Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled, AntivirusSignatureLastUpdated
```

**Revisar intentos de login fallidos:**

```powershell
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 10 |
    Select-Object TimeCreated, Message |
    Format-Table -AutoSize
```

**Verificar política de contraseñas actual:**

```powershell
net accounts
```

---

## 10. Conclusión

La seguridad en sistemas operativos no es un estado que se alcanza: es un **proceso continuo** de configuración, monitoreo y actualización.

El caso WannaCry es el ejemplo más claro de esto: el ataque más devastador de 2017 se habría evitado con una actualización que llevaba dos meses disponible. La tecnología existía. La práctica, no.

La mayoría de los incidentes de seguridad no responden a ataques extremadamente sofisticados. Responden a descuidos prevenibles: contraseñas débiles, sistemas desactualizados, servicios expuestos sin necesidad, permisos más amplios de lo necesario.

Las herramientas para proteger un sistema —tanto en Linux como en Windows— están disponibles, son gratuitas en su mayoría y, en muchos casos, vienen integradas de fábrica. La diferencia entre un sistema seguro y uno vulnerable no es el presupuesto: es el conocimiento y la disciplina para aplicarlo.

Comprender estos conceptos no es solo un requisito académico. Es una competencia fundamental para cualquier persona que trabaje con tecnología, ya sea como administrador de sistemas, desarrollador o usuario avanzado.

---

## 11. Bibliografía

1. NIST — *Cybersecurity Framework* (2024). National Institute of Standards and Technology. https://www.nist.gov/cyberframework

2. MITRE — *CVE-2017-0144: EternalBlue vulnerability*. https://cve.mitre.org

3. National Cyber Security Centre UK — *WannaCry ransomware attack* (2017). https://www.ncsc.gov.uk

4. Shotts, W. (2019). *The Linux Command Line: A Complete Introduction*. No Starch Press.

5. Stallings, W. (2018). *Operating Systems: Internals and Design Principles* (9.ª ed.). Pearson Education.

6. INCIBE — *Guías de ciberseguridad para usuarios y empresas*. Instituto Nacional de Ciberseguridad de España. https://www.incibe.es

7. Microsoft Learn — *Windows Security documentation*. https://learn.microsoft.com/en-us/windows/security
