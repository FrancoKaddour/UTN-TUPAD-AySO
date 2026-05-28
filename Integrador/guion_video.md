# Guión — Video Explicativo
## Seguridad en los Sistemas Operativos
### Arquitectura y Sistemas Operativos — Comisión 11
### Franco Kaddour y Gonzalo Isaias

---

> **Duración estimada:** 12-14 minutos
> **Formato:** Cámara encendida para la presentación inicial, luego pueden apagarla.
> **[F]** = habla Franco | **[G]** = habla Gonzalo | **[AMBOS]** = los dos en cámara

---

## PARTE 1 — PRESENTACIÓN (cámara encendida) — ~1 min

**[AMBOS en cámara]**

**[F]:** "Buenas, mi nombre es Franco Kaddour, soy alumno de la Tecnicatura Universitaria en Programación a Distancia en UTN, Comisión 11."

**[G]:** "Y yo soy Gonzalo Isaias, también de la Comisión 11 de UTN TUPAD."

**[F]:** "El tema que elegimos para nuestro Trabajo Integrador de Arquitectura y Sistemas Operativos es **Seguridad en los Sistemas Operativos**: amenazas, mecanismos de protección y buenas prácticas."

**[G]:** "A lo largo del video vamos a ver qué es la seguridad en sistemas operativos, cuáles son las principales amenazas que existen hoy, cómo se protegen Linux y Windows, y vamos a hacer una demostración práctica con comandos reales."

**[F]:** "Arrancamos."

---

## PARTE 2 — INTRODUCCIÓN (Slide 4) — ~1 min

*[Pueden apagar cámara a partir de acá]*

**[F]:** "El sistema operativo es la capa de software más importante de una computadora. Gestiona el hardware, los procesos, la memoria, y sobre todo: controla quién puede acceder a qué."

"Cuando el sistema operativo es comprometido, todo lo que corre sobre él queda expuesto. No solo los archivos del usuario, sino las aplicaciones, las credenciales almacenadas, los servicios activos."

"Por eso decimos que el SO actúa como la **primera línea de defensa**. Si esa línea cae, no hay antivirus ni firewall que alcance."

"Hoy, cualquier dispositivo conectado a internet es un blanco potencial. Los ataques son automatizados, masivos y cada vez más accesibles. Ya no hace falta ser un experto para lanzar un ataque: existen herramientas que lo hacen por vos."

---

## PARTE 3 — TRÍADA CIA (Slide 5) — ~1.5 min

**[F]:** "Antes de entrar en herramientas concretas, necesitamos establecer la base teórica. Todo sistema seguro se construye sobre tres pilares fundamentales que se conocen como la **Tríada CIA**: Confidencialidad, Integridad y Disponibilidad."

"**Confidencialidad** significa que solo las personas autorizadas pueden acceder a la información. Un archivo con permisos `600` en Linux, por ejemplo, solo puede leerlo el propietario. Un disco cifrado con BitLocker en Windows solo puede leerse con la clave correcta."

"**Integridad** significa que los datos no pueden ser modificados sin autorización. Si alguien altera un archivo de configuración del sistema sin que nos demos cuenta, el sistema puede comportarse de formas inesperadas o peligrosas."

"**Disponibilidad** significa que el sistema funciona cuando lo necesitamos. Un ataque de ransomware no roba tus datos, te los bloquea. Viola la disponibilidad. Por eso los backups son tan importantes."

"Estos tres pilares no son independientes. Un buen sistema de seguridad los protege a todos al mismo tiempo."

---

## PARTE 4 — WANNACRY (Slides 6 y 7) — ~2 min

**[F]:** "Para entender por qué todo esto importa, les voy a contar el caso de **WannaCry**, el ataque de ransomware más devastador de la historia."

"En mayo de 2017, en menos de 24 horas, WannaCry infectó más de 200.000 computadoras en 150 países. Paralizó hospitales del sistema de salud del Reino Unido. Detuvo líneas de producción de Renault. Afectó al Banco Central de Rusia. Las pérdidas económicas globales superaron los 4.000 millones de dólares."

"¿Cómo funcionó? El ataque seguía una secuencia automatizada. Primero, escaneaba internet buscando equipos con el **puerto 445 abierto**, que es el puerto del protocolo SMB de Windows, usado para compartir archivos en red."

"Cuando encontraba uno, explotaba una vulnerabilidad llamada **EternalBlue**, catalogada como CVE-2017-0144. Esta vulnerabilidad permitía ejecutar código de forma remota en el sistema sin necesidad de que el usuario hiciera nada — sin abrir un mail, sin hacer click en ningún link."

"Una vez dentro, cifraba todos los archivos del usuario con el algoritmo **RSA-2048** y mostraba un mensaje exigiendo entre 300 y 600 dólares en Bitcoin para recuperarlos."

"Y lo más grave: **se propagaba solo**. Escaneaba la red local y repetía el proceso en cada equipo vulnerable que encontraba."

"Ahora la pregunta clave: ¿cuál fue el error? Microsoft había publicado el parche que corregía esta vulnerabilidad **dos meses antes del ataque**. Los sistemas infectados simplemente no estaban actualizados."

"WannaCry no fue un ataque sofisticado. Fue el resultado de no aplicar una actualización disponible. La tecnología para prevenirlo existía. La práctica, no."

---

## PARTE 5 — AMENAZAS (Slides 8 y 9) — ~1.5 min

**[G]:** "WannaCry es un ejemplo de ransomware, pero es solo uno de los tipos de amenazas que enfrentan los sistemas operativos. Vamos a ver los principales."

"El **malware** es el término general para cualquier software malicioso: virus, troyanos, spyware. Su objetivo puede ser dañar el sistema, robar información, o establecer una puerta trasera para el atacante."

"El **phishing** es una técnica de engaño: correos o sitios web falsos que imitan a entidades legítimas para robar las credenciales del usuario. Es el vector de ataque más común a nivel mundial."

"Los ataques de **fuerza bruta** consisten en intentar millones de combinaciones de contraseñas de forma automatizada hasta encontrar la correcta. Por eso las contraseñas débiles son tan peligrosas."

"Los **rootkits** son especialmente peligrosos porque operan a nivel del kernel del sistema operativo. Se ocultan de los antivirus convencionales porque tienen acceso al mismo nivel que el propio sistema."

"Y la **escalada de privilegios** es la técnica por la que un atacante que ya tiene acceso limitado a un sistema logra obtener permisos de administrador. Muchos ataques combinan varias de estas técnicas: entran por phishing, instalan un malware, y luego escalan privilegios para tomar control total."

---

## PARTE 6 — SEGURIDAD EN LINUX (Slides 10, 11, 12, 13) — ~2.5 min

**[F]:** "Vamos a ver ahora cómo Linux aborda la seguridad. Linux fue diseñado desde el principio como un sistema multiusuario, con separación estricta de privilegios. El principio de mínimo privilegio no es algo que se agregó después: está en el ADN del sistema."

"El mecanismo más básico y fundamental es el **modelo de permisos Unix**. Cada archivo tiene tres niveles de acceso: propietario, grupo y otros. Y en cada nivel se puede asignar permiso de lectura, escritura y ejecución."

"Cuando ejecutamos `ls -la` en una terminal, vemos algo como `-rw-r--r--`. Ese string de 10 caracteres nos dice todo: el primer carácter es el tipo de archivo, los siguientes tres son los permisos del propietario, los tres siguientes del grupo, y los últimos tres para el resto del mundo."

"Para modificar permisos usamos `chmod` con notación octal: 7 es lectura, escritura y ejecución. 6 es solo lectura y escritura. 4 es solo lectura. Así, `chmod 600 archivo` deja el archivo accesible únicamente para el propietario."

"Otro pilar de la seguridad en Linux es la distinción entre **root y sudo**. Root tiene poder absoluto sobre el sistema. Si trabajamos siempre como root y cometemos un error, o si un malware se ejecuta en esa sesión, tiene consecuencias sobre todo el sistema."

"`sudo` es la alternativa correcta: ejecuta un comando puntual con privilegios elevados, lo registra en el log `/var/log/auth.log`, y luego vuelve al nivel de permisos normal. Podés auditar exactamente quién ejecutó qué y cuándo."

"Para la gestión de red, Linux tiene **ufw** — Uncomplicated Firewall. Con tres comandos podés tener una política sólida: activar el firewall, denegar todo el tráfico entrante por defecto, y permitir solo los puertos que necesitás. Si algo no está explícitamente permitido, se rechaza."

"Y para la protección contra ataques de fuerza bruta, existe **fail2ban**: monitorea los logs del sistema, detecta patrones de intentos fallidos de login, y bloquea automáticamente la dirección IP atacante por un período configurable. Funciona sin intervención manual."

---

## PARTE 7 — SEGURIDAD EN WINDOWS (Slide 14) — ~2 min

**[G]:** "Windows tiene su propio conjunto de herramientas de seguridad, todas integradas en el sistema sin necesidad de instalación adicional."

"El primero es **UAC** — Control de Cuentas de Usuario. Cada vez que una aplicación intenta hacer cambios que requieren privilegios administrativos, Windows muestra una ventana de confirmación. Sin UAC, cualquier programa ejecutado por el usuario heredaría automáticamente todos sus permisos. Con UAC, los programas corren con privilegios reducidos por defecto, y solo escalan cuando el usuario aprueba explícitamente."

"**Windows Defender** es la suite de seguridad nativa de Windows 10 y 11. Tiene cuatro componentes principales: el antivirus en tiempo real, el firewall, SmartScreen — que bloquea software no reconocido o potencialmente peligroso — y Exploit Guard, que agrega protección adicional contra vulnerabilidades en aplicaciones."

"Desde PowerShell podemos ver el estado completo con `Get-MpComputerStatus`. Nos dice si el antivirus está activo, si la protección en tiempo real está habilitada, y cuándo se actualizaron por última vez las firmas de virus."

"**BitLocker** es el mecanismo de cifrado de disco completo de Windows. Si alguien roba una laptop y extrae el disco físicamente, no puede acceder a los datos sin la clave de recuperación. Es especialmente importante en equipos portátiles."

"Y el **Visor de Eventos** es la herramienta de auditoría. Registra toda la actividad del sistema con códigos numéricos. Para seguridad, los más importantes son el 4624 — inicio de sesión exitoso — y el 4625 — intento fallido. Si vemos muchos eventos 4625 en poco tiempo desde la misma IP, es un indicador claro de un ataque de fuerza bruta en curso."

---

## PARTE 8 — COMPARATIVA LINUX vs WINDOWS (Slide 15) — ~1 min

**[G]:** "La pregunta que siempre surge es: ¿cuál es más seguro, Linux o Windows?"

"La respuesta honesta es que **ninguno es inherentemente más seguro en términos absolutos**. Depende de cómo esté configurado y mantenido."

"Linux tiene menos malware porque tiene menos usuarios domésticos — los atacantes van donde está el volumen. Su modelo de permisos y código abierto lo hacen más transparente y auditable. Windows tiene herramientas gráficas muy accesibles y una gestión de actualizaciones más automatizada para el usuario común."

"Un Linux mal configurado puede ser mucho más vulnerable que un Windows correctamente mantenido. Y viceversa. La variable más importante en seguridad no es el sistema operativo: es el administrador."

---

## PARTE 9 — BUENAS PRÁCTICAS (Slide 16) — ~1 min

**[G]:** "Independientemente del sistema que usemos, hay cuatro prácticas que marcan la diferencia en seguridad."

"**Contraseñas fuertes**: una contraseña de 8 caracteres simples se crackea en segundos con hardware moderno. Una passphrase de cuatro palabras al azar, como `caballo-bateria-grapa-luz`, tarda cientos de años y es más fácil de recordar. Un gestor de contraseñas como Bitwarden o KeePassXC resuelve el problema de tener contraseñas únicas para cada servicio."

"**Autenticación multifactor**: Microsoft reportó que el MFA bloquea el 99.9% de los ataques automatizados sobre cuentas. Si alguien obtiene tu contraseña, sin el segundo factor no puede entrar."

"**Regla 3-2-1 de backups**: tres copias de los datos, en dos soportes distintos, con una copia fuera del sitio físico. Si tenés un buen backup, un ransomware es un inconveniente temporal, no una catástrofe."

"**Actualizaciones**: WannaCry demostró lo que pasa cuando no se aplican. El parche existía, los sistemas no lo tenían. Aplicar actualizaciones dentro de los 30 días de su publicación es el estándar en administración de sistemas."

---

## PARTE 10 — DEMOSTRACIÓN PRÁCTICA EN VIVO — ~2 min

> *Abrir terminal Linux (o WSL) y PowerShell. Compartir pantalla.*

**[F]:** "Ahora vamos a ver en vivo cómo se aplican estas herramientas. Arranco yo con Linux."

**[F]:** "Creo un archivo con contenido sensible y muestro los permisos por defecto:"

```bash
echo "Datos confidenciales" > credenciales.txt
ls -la credenciales.txt
```

**[F]:** "Ven que tiene permisos `rw-r--r--` — cualquier usuario del sistema puede leerlo. Con un comando lo corrijo:"

```bash
chmod 600 credenciales.txt
ls -la credenciales.txt
```

**[F]:** "Ahora es `rw-------`. Solo el propietario puede acceder. Eso es el principio de mínimo privilegio aplicado en dos segundos."

**[F]:** "También reviso si hay intentos de login fallidos registrados en el sistema:"

```bash
sudo grep "Failed password" /var/log/auth.log | tail -5
```

**[G]:** "Desde Windows, muestro el estado de seguridad con PowerShell:"

```powershell
Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled
```

**[G]:** "Antivirus activo, protección en tiempo real habilitada. También reviso intentos de login fallidos:"

```powershell
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 5 |
    Select-Object TimeCreated, Message | Format-Table -AutoSize
```

**[G]:** "Y la política de contraseñas del sistema:"

```powershell
net accounts
```

---

## PARTE 11 — CONCLUSIÓN (Slide 17) — ~30 seg

**[F]:** "Para cerrar: la seguridad no es una configuración que se hace una vez y se olvida. Es un proceso continuo."

"WannaCry lo demostró: la tecnología para prevenirlo existía. Lo que faltó fue aplicarla."

"Las herramientas que vimos hoy están disponibles, son gratuitas en su mayoría, y en muchos casos vienen integradas de fábrica. La diferencia entre un sistema seguro y uno vulnerable no es el presupuesto. Es el conocimiento y la disciplina para aplicarlo."

"Como dijo Bruce Schneier: **la seguridad no es un producto, es un proceso.**"

**[G]:** "Muchas gracias."
**[F]:** "Gracias."

---

## NOTAS PARA EL DÍA DE GRABACIÓN

- Grabar en un lugar con buena luz y sin ruido de fondo.
- Para la intro (Parte 1): cámara del celular o la notebook, fondo limpio.
- Para la demo: compartir pantalla o grabar con OBS Studio (gratuito).
- Practicar la demo al menos una vez antes de grabar.
- Si algo falla en la demo, no cortar — explicar en voz alta qué debería pasar.
- Tiempo total objetivo: 12-13 minutos.
