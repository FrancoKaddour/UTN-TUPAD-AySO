# TP Redes - Semana 1 · Checklist completo

## ESTRUCTURA DE CARPETA
```
TP_Redes_Semana1/
├── TP_Redes_Semana1.html   ← entrega final
├── CHECKLIST.md            ← esta guía
└── capturas/               ← acá guardás todas las fotos/screenshots
```

---

## PASO A PASO — TODO LO QUE TENÉS QUE HACER

---

### PARTE 1 — Packet Tracer: Armar la red

**[ ] 1.** Abrir Cisco Packet Tracer

**[ ] 2.** Agregar estos dispositivos al área de trabajo:
- 3x PC (PC0, PC1, PC2)
- 1x Switch (2960 o cualquiera)
- 1x Router (1841 o cualquiera)

**[ ] 3.** Conectar con cables:
- PC0 → Switch (cable directo / straight-through)
- PC1 → Switch (cable directo)
- PC2 → Switch (cable directo)
- Switch → Router (cable directo)

**[ ] 4.** Configurar IP en PC0:
- Clic en PC0 → Desktop → IP Configuration
- IP: 192.168.1.10 | Mask: 255.255.255.0 | Gateway: 192.168.1.1

**[ ] 5.** Configurar IP en PC1:
- IP: 192.168.1.11 | Mask: 255.255.255.0 | Gateway: 192.168.1.1

**[ ] 6.** Configurar IP en PC2:
- IP: 192.168.1.12 | Mask: 255.255.255.0 | Gateway: 192.168.1.1

**[ ] 7.** Configurar IP en el Router:
- Clic en Router → CLI → escribir:
```
enable
configure terminal
interface gigabitEthernet 0/0
ip address 192.168.1.1 255.255.255.0
no shutdown
exit
```

**[ ] 8.** 📸 CAPTURA: screenshot de la topología completa en Packet Tracer
- Guardar como: `capturas/01_topologia.png`

**[ ] 9.** 📸 CAPTURA: IP Configuration de PC0 (Desktop → IP Configuration)
- Guardar como: `capturas/02_ip_pc0.png`

---

### PARTE 2 — Packet Tracer: Comandos en PC0

**[ ] 10.** Abrir terminal de PC0: clic en PC0 → Desktop → Command Prompt

**[ ] 11.** Ejecutar `arp -a` ANTES del ping:
- Va a decir "No ARP Entries Found"
- 📸 CAPTURA → `capturas/03_arp_antes.png`

**[ ] 12.** Ejecutar `ping 192.168.1.11`:
- Tiene que responder 4 veces con éxito
- 📸 CAPTURA → `capturas/04_ping_pc1.png`

**[ ] 13.** Ejecutar `ping 192.168.1.12`:
- Tiene que responder 4 veces con éxito
- 📸 CAPTURA → `capturas/05_ping_pc2.png`

**[ ] 14.** Ejecutar `ping 192.168.1.1` (el router/gateway):
- El TP pide que PC0 se comunique "con el puente"
- 📸 CAPTURA → `capturas/06_ping_router.png`

**[ ] 15.** Ejecutar `arp -a` DESPUÉS del ping:
- Ahora va a mostrar las MACs de PC1, PC2 y el Router
- 📸 CAPTURA → `capturas/07_arp_despues.png`

---

### PARTE 3 — Tu PC real: CMD de Windows

**[ ] 16.** Abrir CMD en tu computadora (Win + R → cmd → Enter)

**[ ] 17.** Ejecutar: `tracert www.google.com`
- Esperar que termine (puede tardar 1-2 minutos)
- 📸 CAPTURA de toda la salida → `capturas/08_tracert.png`

---

### ARMADO FINAL DEL HTML

**[ ] 18.** Reemplazar en el HTML los outputs simulados con los reales:
- `ipconfig` de PC0 (de la captura 02)
- `arp -a` antes del ping (captura 03)
- `ping 192.168.1.11` (captura 04)
- `ping 192.168.1.12` (captura 05)
- `ping 192.168.1.1` (captura 06) ← agregar esta sección
- `arp -a` después del ping (captura 07)
- `tracert` (captura 08)

**[ ] 19.** Abrir el HTML en Chrome → Ctrl+P → Guardar como PDF

**[ ] 20.** Entregar el PDF

---

## RESUMEN DE CAPTURAS A SACAR (8 en total)

| # | Archivo | Qué capturar |
|---|---------|--------------|
| 01 | `01_topologia.png` | Vista general de la red en Packet Tracer |
| 02 | `02_ip_pc0.png` | IP Configuration de PC0 |
| 03 | `03_arp_antes.png` | `arp -a` en PC0 antes del ping |
| 04 | `04_ping_pc1.png` | `ping 192.168.1.11` desde PC0 |
| 05 | `05_ping_pc2.png` | `ping 192.168.1.12` desde PC0 |
| 06 | `06_ping_router.png` | `ping 192.168.1.1` desde PC0 |
| 07 | `07_arp_despues.png` | `arp -a` en PC0 después de los pings |
| 08 | `08_tracert.png` | `tracert www.google.com` en tu PC real |
