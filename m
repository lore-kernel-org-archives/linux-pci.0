Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:53952 "EHLO
	resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753218AbbAFVbO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jan 2015 16:31:14 -0500
Message-ID: <54AC5420.9040701@nwtrail.com>
Date: Tue, 06 Jan 2015 13:31:12 -0800
From: Paul Johnson <pjay@nwtrail.com>
Reply-To: pjay@nwtrail.com
MIME-Version: 1.0
To: linux-pci <linux-pci@vger.kernel.org>
Subject: Problem: mpt2sas not loaded with LSISAS2008 card
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[1.] One line summary of the problem:
mpt2sas not loaded with LSISAS2008 card

[2.] Full description of the problem/report:
During boot the LSISAS2008 card is found but
mpt2sas fails to successfully load. If pci=realloc=off
is added to the linux command line, mpt2sas is
successfully loaded.
[3.] Keywords

[4.] Kernel version
Linux version 3.19.0-031900rc2-generic (apw@tangerine) (gcc version 
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201412290135 SMP Mon Dec 29 
01:36:54 UTC 2014

[7.] Environment
Description:    Ubuntu 14.04.1 LTS
Release:    14.04

[7.1] Software

[7.2] Processor information
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1197.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi 
flexpriority ept vpid
bugs        :
bogomips    : 5595.99
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1197.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi 
flexpriority ept vpid
bugs        :
bogomips    : 5595.99
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1197.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi 
flexpriority ept vpid
bugs        :
bogomips    : 5595.99
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 2794.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 6
initial apicid    : 6
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi 
flexpriority ept vpid
bugs        :
bogomips    : 5595.99
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 4
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1197.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi 
flexpriority ept vpid
bugs        :
bogomips    : 5595.99
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 5
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 2794.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi 
flexpriority ept vpid
bugs        :
bogomips    : 5595.99
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 6
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1197.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 5
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi 
flexpriority ept vpid
bugs        :
bogomips    : 5595.99
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 7
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping    : 5
microcode    : 0x4
cpu MHz        : 1197.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 7
initial apicid    : 7
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi 
flexpriority ept vpid
bugs        :
bogomips    : 5595.99
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:


[7.3] Module information
rfcomm 75100 4 - Live 0xffffffffc0668000
bnep 23980 2 - Live 0xffffffffc0444000
bluetooth 510653 10 rfcomm,bnep, Live 0xffffffffc05ea000
snd_hda_codec_realtek 80490 1 - Live 0xffffffffc05d5000
snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0xffffffffc05bc000
snd_hda_intel 30824 3 - Live 0xffffffffc05ac000
snd_hda_controller 36330 1 snd_hda_intel, Live 0xffffffffc0577000
snd_hda_codec 144641 4 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0xffffffffc0587000
snd_hwdep 17709 1 snd_hda_codec, Live 0xffffffffc053a000
snd_pcm 106365 3 snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 
0xffffffffc0550000
snd_seq_midi 13564 0 - Live 0xffffffffc054b000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0xffffffffc04fd000
snd_rawmidi 31197 1 snd_seq_midi, Live 0xffffffffc0542000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffc0529000
snd_seq_device 14875 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0xffffffffc04f8000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0xffffffffc056e000
coretemp 13638 0 - Live 0xffffffffc04db000
kvm_intel 154139 0 - Live 0xffffffffc0502000
snd 84025 16 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0xffffffffc04e2000
soundcore 15091 2 snd_hda_codec,snd, Live 0xffffffffc03fc000
serio_raw 13483 0 - Live 0xffffffffc04d6000
i7core_edac 24582 0 - Live 0xffffffffc043c000
kvm 480978 1 kvm_intel, Live 0xffffffffc045f000
edac_core 52405 2 i7core_edac, Live 0xffffffffc0425000
gpio_ich 13636 0 - Live 0xffffffffc03f7000
8250_fintek 12924 0 - Live 0xffffffffc0402000
mac_hid 13275 0 - Live 0xffffffffc03f2000
lpc_ich 21176 0 - Live 0xffffffffc0435000
parport_pc 32909 1 - Live 0xffffffffc03c9000
ppdev 17711 0 - Live 0xffffffffc0349000
lp 17799 0 - Live 0xffffffffc034f000
parport 42481 3 parport_pc,ppdev,lp, Live 0xffffffffc033d000
pata_acpi 13053 0 - Live 0xffffffffc0389000
hid_generic 12559 0 - Live 0xffffffffc03ed000
usbhid 53155 0 - Live 0xffffffffc038f000
hid 110572 2 hid_generic,usbhid, Live 0xffffffffc0409000
r8169 87016 0 - Live 0xffffffffc03d6000
pata_jmicron 12775 0 - Live 0xffffffffc0375000
mpt2sas 167025 0 - Live 0xffffffffc039f000
ahci 34220 2 - Live 0xffffffffc037f000
mii 13981 1 r8169, Live 0xffffffffc037a000
libahci 32353 1 ahci, Live 0xffffffffc036c000
raid_class 13554 1 mpt2sas, Live 0xffffffffc0364000
scsi_transport_sas 41028 1 mpt2sas, Live 0xffffffffc0358000

[7.4.] Loaded driver and hardware information
0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0061-0061 : PNP0800:00
   0064-0064 : keyboard
   0070-0073 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : PNP0C04:00
     00f0-00ff : fpu
   0290-029f : pnp 00:00
     0290-0294 : pnp 00:00
   0378-037a : parport0
   03c0-03df : vesafb
   03f8-03ff : serial
   0400-0403 : ACPI PM1a_EVT_BLK
   0404-0405 : ACPI PM1a_CNT_BLK
   0408-040b : ACPI PM_TMR
   0410-0415 : ACPI CPU throttle
   0420-042f : ACPI GPE0_BLK
   0430-0433 : iTCO_wdt
   0450-0450 : ACPI PM2_CNT_BLK
   0460-047f : iTCO_wdt
   04d0-04d1 : pnp 00:00
   0500-051f : 0000:00:1f.3
   0580-05ff : gpio_ich
     0580-05ff : pnp 00:05
       0580-05af : gpio_ich
       05b0-05bf : gpio_ich
       05c0-05cf : gpio_ich
   0800-087f : pnp 00:00
   0880-088f : pnp 00:00
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   c000-cfff : PCI Bus 0000:01
     ce00-ceff : 0000:01:00.0
   d000-dfff : PCI Bus 0000:03
     de00-deff : 0000:03:00.0
       de00-deff : r8169
   e000-efff : PCI Bus 0000:02
     eb00-eb0f : 0000:02:00.1
       eb00-eb0f : pata_jmicron
     ec00-ec03 : 0000:02:00.1
       ec00-ec03 : pata_jmicron
     ed00-ed07 : 0000:02:00.1
       ed00-ed07 : pata_jmicron
     ee00-ee03 : 0000:02:00.1
       ee00-ee03 : pata_jmicron
     ef00-ef07 : 0000:02:00.1
       ef00-ef07 : pata_jmicron
   f400-f41f : 0000:00:1f.2
     f400-f41f : ahci
   f500-f503 : 0000:00:1f.2
     f500-f503 : ahci
   f600-f607 : 0000:00:1f.2
     f600-f607 : ahci
   f700-f703 : 0000:00:1f.2
     f700-f703 : ahci
   f800-f807 : 0000:00:1f.2
     f800-f807 : ahci
   f900-f91f : 0000:00:1d.3
     f900-f91f : uhci_hcd
   fa00-fa1f : 0000:00:1d.2
     fa00-fa1f : uhci_hcd
   fb00-fb1f : 0000:00:1d.1
     fb00-fb1f : uhci_hcd
   fc00-fc1f : 0000:00:1d.0
     fc00-fc1f : uhci_hcd
   fd00-fd1f : 0000:00:1a.2
     fd00-fd1f : uhci_hcd
   fe00-fe1f : 0000:00:1a.1
     fe00-fe1f : uhci_hcd
   ff00-ff1f : 0000:00:1a.0
     ff00-ff1f : uhci_hcd
00000000-00000fff : reserved
00001000-0009c7ff : System RAM
0009c800-0009f7ff : RAM buffer
0009f800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000dffff : PCI Bus 0000:00
   000c0000-000c7fff : Video ROM
   000cb000-000d0dff : Adapter ROM
000f0000-000fffff : reserved
   000f0000-000fffff : System ROM
00100000-ef7dffff : System RAM
   01000000-017d6c83 : Kernel code
   017d6c84-01d24bbf : Kernel data
   01e8d000-01fcffff : Kernel bss
ef7e0000-ef7e1fff : ACPI Non-volatile Storage
ef7e2000-ef7effff : ACPI Tables
ef7f0000-ef7fffff : reserved
   ef7f0000-ef7fffff : pnp 00:07
ef800000-febfffff : PCI Bus 0000:00
   ef800000-ef9fffff : PCI Bus 0000:02
   efa00000-efffffff : PCI Bus 0000:01
     efa00000-efa7ffff : 0000:01:00.0
     efa80000-efabffff : 0000:01:00.0
     efac0000-efebffff : 0000:01:00.0
     efec0000-efec3fff : 0000:01:00.0
     efec4000-eff03fff : 0000:01:00.0
   f4000000-f7ffffff : PCI MMCONFIG 0000 [bus 00-3f]
     f4000000-f7ffffff : reserved
       f4000000-f7ffffff : pnp 00:06
   f9000000-f9ffffff : PCI Bus 0000:04
     f9000000-f9ffffff : 0000:04:04.0
       f9000000-f92fffff : vesafb
   fa800000-fb7fffff : PCI Bus 0000:04
     fa800000-faffffff : 0000:04:04.0
     fb000000-fb00ffff : 0000:04:04.0
     fb7fc000-fb7fffff : 0000:04:04.0
   fbb00000-fbbfffff : PCI Bus 0000:03
     fbb00000-fbb1ffff : 0000:03:00.0
   fbc00000-fbcfffff : PCI Bus 0000:02
     fbcfe000-fbcfffff : 0000:02:00.0
       fbcfe000-fbcfffff : ahci
   fbe00000-fbefffff : PCI Bus 0000:03
     fbef8000-fbefbfff : 0000:03:00.0
       fbef8000-fbefbfff : r8169
     fbeff000-fbefffff : 0000:03:00.0
       fbeff000-fbefffff : r8169
   fbff8000-fbffbfff : 0000:00:1b.0
     fbff8000-fbffbfff : ICH HD audio
   fbffc000-fbffc0ff : 0000:00:1f.3
   fbffd000-fbffd7ff : 0000:00:1f.2
     fbffd000-fbffd7ff : ahci
   fbffe000-fbffe3ff : 0000:00:1d.7
     fbffe000-fbffe3ff : ehci_hcd
   fbfff000-fbfff3ff : 0000:00:1a.7
     fbfff000-fbfff3ff : ehci_hcd
fec00000-ffffffff : reserved
   fec00000-fec003ff : IOAPIC 0
   fed00000-fed003ff : HPET 0
     fed00000-fed003ff : PNP0103:00
   fed10000-fed1dfff : pnp 00:07
   fed1f410-fed1f414 : iTCO_wdt
   fed20000-fed8ffff : pnp 00:07
   fee00000-fee00fff : Local APIC
     fee00000-fee00fff : pnp 00:07
   ffb00000-ffb7ffff : pnp 00:07
   ffb80000-ffbfffff : INT0800:00
   fff00000-ffffffff : pnp 00:07
100000000-40fffffff : System RAM

[7.5.] PCI information
00:00.0 Host bridge: Intel Corporation Core Processor DMI (rev 11)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Capabilities: [40] #00 [0000]

00:03.0 PCI bridge: Intel Corporation Core Processor PCI Express Root 
Port 1 (rev 11) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 0000c000-0000cfff
     Memory behind bridge: efa00000-efffffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Subsystem: Gigabyte Technology Co., Ltd Device 5001
     Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
         Address: 00000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 256 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #3, PowerLimit 0.000W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible+
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF 
Not Supported ARIFwd+
         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd+
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [e0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
     Capabilities: [150 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
     Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0 
Len=00c <?>
     Kernel driver in use: pcieport

00:08.0 System peripheral: Intel Corporation Core Processor System 
Management Registers (rev 11)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, 
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
     Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0 
Len=000 <?>

00:08.1 System peripheral: Intel Corporation Core Processor Semaphore 
and Scratchpad Registers (rev 11)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, 
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
     Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0 
Len=000 <?>

00:08.2 System peripheral: Intel Corporation Core Processor System 
Control and Status Registers (rev 11)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, 
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
     Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0 
Len=000 <?>

00:08.3 System peripheral: Intel Corporation Core Processor 
Miscellaneous Registers (rev 11)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:10.0 System peripheral: Intel Corporation Core Processor QPI Link 
(rev 11)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:10.1 System peripheral: Intel Corporation Core Processor QPI Routing 
and Protocol Registers (rev 11)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset 
USB Universal Host Controller (rev 05) (prog-if 00 [UHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5004
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     Region 4: I/O ports at ff00 [size=32]
     Capabilities: [50] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 5 Series/3400 Series Chipset 
USB Universal Host Controller (rev 05) (prog-if 00 [UHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5004
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 21
     Region 4: I/O ports at fe00 [size=32]
     Capabilities: [50] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: uhci_hcd

00:1a.2 USB controller: Intel Corporation 5 Series/3400 Series Chipset 
USB Universal Host Controller (rev 05) (prog-if 00 [UHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5004
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 18
     Region 4: I/O ports at fd00 [size=32]
     Capabilities: [50] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 5 Series/3400 Series Chipset 
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5006
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 18
     Region 0: Memory at fbfff000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset 
High Definition Audio (rev 05)
     Subsystem: Gigabyte Technology Co., Ltd Device a002
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 31
     Region 0: Memory at fbff8000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000feeff00c  Data: 4123
     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=2 ArbSelect=Fixed TC/VC=04
             Status:    NegoPending- InProgress-
     Capabilities: [130 v1] Root Complex Link
         Desc:    PortNumber=0f ComponentID=00 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI 
Express Root Port 1 (rev 05) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: 0000e000-0000efff
     Memory behind bridge: fbc00000-fbcfffff
     Prefetchable memory behind bridge: 00000000ef800000-00000000ef9fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Exit 
Latency L0s <256ns, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #16, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF 
Not Supported ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI 
Express Root Port 2 (rev 05) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: 0000d000-0000dfff
     Memory behind bridge: fbb00000-fbbfffff
     Prefetchable memory behind bridge: 00000000fbe00000-00000000fbefffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s, Exit 
Latency L0s <256ns, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #17, PowerLimit 10.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF 
Not Supported ARIFwd-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset 
USB Universal Host Controller (rev 05) (prog-if 00 [UHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5004
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 23
     Region 4: I/O ports at fc00 [size=32]
     Capabilities: [50] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 5 Series/3400 Series Chipset 
USB Universal Host Controller (rev 05) (prog-if 00 [UHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5004
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 19
     Region 4: I/O ports at fb00 [size=32]
     Capabilities: [50] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 5 Series/3400 Series Chipset 
USB Universal Host Controller (rev 05) (prog-if 00 [UHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5004
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 18
     Region 4: I/O ports at fa00 [size=32]
     Capabilities: [50] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: uhci_hcd

00:1d.3 USB controller: Intel Corporation 5 Series/3400 Series Chipset 
USB Universal Host Controller (rev 05) (prog-if 00 [UHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5004
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin D routed to IRQ 16
     Region 4: I/O ports at f900 [size=32]
     Capabilities: [50] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 5 Series/3400 Series Chipset 
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5006
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 23
     Region 0: Memory at fbffe000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5) (prog-if 
01 [Subtractive decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: fa800000-fb7fffff
     Prefetchable memory behind bridge: 00000000f9000000-00000000f9ffffff
     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Subsystem: Gigabyte Technology Co., Ltd Motherboard

00:1f.0 ISA bridge: Intel Corporation 5 Series Chipset LPC Interface 
Controller (rev 05)
     Subsystem: Gigabyte Technology Co., Ltd Device 5001
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=10 <?>
     Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset 
6 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
     Subsystem: Gigabyte Technology Co., Ltd Device b005
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 29
     Region 0: I/O ports at f800 [size=8]
     Region 1: I/O ports at f700 [size=4]
     Region 2: I/O ports at f600 [size=8]
     Region 3: I/O ports at f500 [size=4]
     Region 4: I/O ports at f400 [size=32]
     Region 5: Memory at fbffd000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee4400c  Data: 41c2
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
     Capabilities: [b0] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus 
Controller (rev 05)
     Subsystem: Gigabyte Technology Co., Ltd Device 5001
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 9
     Region 0: Memory at fbffc000 (64-bit, non-prefetchable) [size=256]
     Region 4: I/O ports at 0500 [size=32]

01:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic 
SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon] (rev 03)
     Subsystem: LSI Logic / Symbios Logic Device 3020
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 0
     Region 0: I/O ports at ce00 [size=256]
     Region 1: Memory at efec0000 (64-bit, non-prefetchable) [size=16K]
     Region 3: Memory at efa80000 (64-bit, non-prefetchable) [size=256K]
     [virtual] Expansion ROM at efa00000 [disabled] [size=512K]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [68] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 4096 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x8, ASPM L0s, Exit 
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF 
Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [d0] Vital Product Data
         Unknown small resource type 00, will not decode more.
     Capabilities: [a8] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [c0] MSI-X: Enable- Count=15 Masked-
         Vector table: BAR=1 offset=00002000
         PBA: BAR=1 offset=00003800
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [150 v1] Single Root I/O Virtualization (SR-IOV)
         IOVCap:    Migration-, Interrupt Message Number: 000
         IOVCtl:    Enable- Migration- Interrupt- MSE- ARIHierarchy+
         IOVSta:    Migration-
         Initial VFs: 16, Total VFs: 16, Number of VFs: 0, Function 
Dependency Link: 00
         VF offset: 1, stride: 1, Device ID: 0072
         Supported Page Size: 00000553, System Page Size: 00000001
         Region 0: Memory at 00000000efec4000 (64-bit, non-prefetchable)
         Region 2: Memory at 00000000efac0000 (64-bit, non-prefetchable)
         VF Migration: offset: 00000000, BIR: 0
     Capabilities: [190 v1] Alternative Routing-ID Interpretation (ARI)
         ARICap:    MFVC- ACS-, Next Function: 0
         ARICtl:    MFVC- ACS-, Function Group: 0

02:00.0 SATA controller: JMicron Technology Corp. JMB363 SATA/IDE 
Controller (rev 02) (prog-if 01 [AHCI 1.0])
     Subsystem: Gigabyte Technology Co., Ltd Motherboard
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 16
     Region 5: Memory at fbcfe000 (32-bit, non-prefetchable) [size=8K]
     Capabilities: [68] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] Express (v1) Legacy Endpoint, MSI 01
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Exit 
Latency L0s unlimited, L1 unlimited
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
     Kernel driver in use: ahci

02:00.1 IDE interface: JMicron Technology Corp. JMB363 SATA/IDE 
Controller (rev 02) (prog-if 85 [Master SecO PriO])
     Subsystem: Gigabyte Technology Co., Ltd Motherboard
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 17
     Region 0: I/O ports at ef00 [size=8]
     Region 1: I/O ports at ee00 [size=4]
     Region 2: I/O ports at ed00 [size=8]
     Region 3: I/O ports at ec00 [size=4]
     Region 4: I/O ports at eb00 [size=16]
     Capabilities: [68] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pata_jmicron

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 03)
     Subsystem: Gigabyte Technology Co., Ltd Motherboard
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 30
     Region 0: I/O ports at de00 [size=256]
     Region 2: Memory at fbeff000 (64-bit, prefetchable) [size=4K]
     Region 4: Memory at fbef8000 (64-bit, prefetchable) [size=16K]
     [virtual] Expansion ROM at fbb00000 [disabled] [size=128K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0100c  Data: 41d2
     Capabilities: [70] Express (v2) Endpoint, MSI 01
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 4096 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [ac] MSI-X: Enable- Count=4 Masked-
         Vector table: BAR=4 offset=00000000
         PBA: BAR=4 offset=00000800
     Capabilities: [cc] Vital Product Data
         Unknown small resource type 00, will not decode more.
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [140 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [160 v1] Device Serial Number 03-00-00-00-68-4c-e0-00
     Kernel driver in use: r8169

04:04.0 VGA compatible controller: Matrox Electronics Systems Ltd. MGA 
2164W [Millennium II] (prog-if 00 [VGA controller])
     Subsystem: Matrox Electronics Systems Ltd. Device 0000
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32
     Interrupt: pin A routed to IRQ 10
     Region 0: Memory at f9000000 (32-bit, prefetchable) [size=16M]
     Region 1: Memory at fb7fc000 (32-bit, non-prefetchable) [size=16K]
     Region 2: Memory at fa800000 (32-bit, non-prefetchable) [size=8M]
     [virtual] Expansion ROM at fb000000 [disabled] [size=64K]

3f:00.0 Host bridge: Intel Corporation Core Processor QuickPath 
Architecture Generic Non-Core Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:00.1 Host bridge: Intel Corporation Core Processor QuickPath 
Architecture System Address Decoder (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Kernel driver in use: i7core_edac

3f:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0 
(rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:03.0 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:03.1 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Target Address Decoder (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:03.4 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Test Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:04.0 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Channel 0 Control Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:04.1 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Channel 0 Address Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:04.2 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Channel 0 Rank Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:04.3 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Channel 0 Thermal Control Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:05.0 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Channel 1 Control Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:05.1 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Channel 1 Address Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:05.2 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Channel 1 Rank Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

3f:05.3 Host bridge: Intel Corporation Core Processor Integrated Memory 
Controller Channel 1 Thermal Control Registers (rev 04)
     Subsystem: Gigabyte Technology Co., Ltd Device 5000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0


[7.6.] SCSI information
Attached devices:
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD2000FYYZ-0 Rev: 1K03
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Hitachi HDT72101 Rev: A31B
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD1200AAJS-0 Rev: 1B01
   Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.] Other information
ls /proc
1
10
1000
101
1015
102
1021
1026
106
107
1096
11
1178
1187
1190
12
1203
1223
1257
1258
126
127
13
1326
14
15
1541
1542
1590
16
1683
17
1715
1722
1726
18
181
182
183
184
185
1858
186
1865
187
188
1882
1884
1886
189
19
190
191
192
193
194
195
1956
196
197
1973
1976
198
1980
1983
1984
1986
1989
199
1993
2
20
200
2001
2004
2006
201
2010
2012
2013
2014
2017
202
2023
2025
2027
203
2033
2037
204
2040
2045
2048
205
2050
2052
206
2061
207
2072
2076
2079
208
2081
2084
209
21
210
211
212
22
2214
2215
2231
2235
2257
2261
2264
2270
2276
23
2302
2306
2316
232
24
2401
2405
2420
2421
2422
2434
25
26
27
28
29
3
30
31
32
33
34
35
36
37
370
38
39
390
4
40
41
42
43
44
45
46
467
47
48
49
5
50
51
52
53
54
55
550
552
56
57
58
59
6
60
609
61
62
620
63
64
65
66
67
68
69
693
7
70
706
71
72
73
74
749
75
76
768
77
78
79
799
8
80
81
82
83
830
836
84
840
846
847
85
850
87
879
88
89
9
940
948
956
973
978
979
982
acpi
asound
buddyinfo
bus
cgroups
cmdline
consoles
cpuinfo
crypto
devices
diskstats
dma
driver
execdomains
fb
filesystems
fs
interrupts
iomem
ioports
irq
kallsyms
kcore
keys
key-users
kmsg
kpagecount
kpageflags
loadavg
locks
mdstat
meminfo
misc
modules
mounts
mtrr
net
pagetypeinfo
partitions
sched_debug
schedstat
scsi
self
slabinfo
softirqs
stat
swaps
sys
sysrq-trigger
sysvipc
thread-self
timer_list
timer_stats
tty
uptime
version
vmallocinfo
vmstat
zoneinfo

[X.] Other notes, patches, fixes, workarounds:
mpt2sas is loaded if the linux command line has:
pci=realloc=off
launchpad bug report:
https://bugs.launchpad.net/ubuntu/utopic/+source/linux/+bug/1363313

dmesg section:
...
[    0.956167] input: AT Translated Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input2
[    0.961006] systemd-udevd[151]: starting version 204
[    0.978430] ahci 0000:00:1f.2: version 3.0
[    0.978582] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.979613] mpt2sas version 18.100.00.00 loaded
[    0.980613] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    0.980623] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have 
ASPM control
[    0.980751] mpt2sas0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, total 
mem (16424516 kB)
[    0.980760] mpt2sas0: sending diag reset !!
[    0.981052] r8169 0000:03:00.0 eth0: RTL8168d/8111d at 
0xffffc90005b7e000, 00:24:1d:d9:29:dd, XID 083000c0 IRQ 30
[    0.981054] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 
bytes, tx checksumming: ko]
[    0.981563] scsi host1: pata_jmicron
[    0.981731] scsi host2: pata_jmicron
[    0.981792] ata1: PATA max UDMA/100 cmd 0xef00 ctl 0xee00 bmdma 
0xeb00 irq 17
[    0.981794] ata2: PATA max UDMA/100 cmd 0xed00 ctl 0xec00 bmdma 
0xeb08 irq 17
[    0.991940] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 
0x3f impl SATA mode
[    0.991945] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo 
pmp pio slum part ems apst
[    1.032964] scsi host3: ahci
[    1.033483] scsi host4: ahci
[    1.033959] scsi host5: ahci
[    1.034243] scsi host6: ahci
[    1.034715] scsi host7: ahci
[    1.035109] scsi host8: ahci
[    1.035217] ata3: SATA max UDMA/133 abar m2048@0xfbffd000 port 
0xfbffd100 irq 29
[    1.035222] ata4: SATA max UDMA/133 abar m2048@0xfbffd000 port 
0xfbffd180 irq 29
[    1.035225] ata5: SATA max UDMA/133 abar m2048@0xfbffd000 port 
0xfbffd200 irq 29
[    1.035229] ata6: SATA max UDMA/133 abar m2048@0xfbffd000 port 
0xfbffd280 irq 29
[    1.035232] ata7: SATA max UDMA/133 abar m2048@0xfbffd000 port 
0xfbffd300 irq 29
[    1.035236] ata8: SATA max UDMA/133 abar m2048@0xfbffd000 port 
0xfbffd380 irq 29
[    1.047966] ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 
0x3 impl SATA mode
[    1.047973] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio 
slum part
[    1.048493] scsi host9: ahci
[    1.048878] scsi host10: ahci
[    1.048935] ata9: SATA max UDMA/133 abar m8192@0xfbcfe000 port 
0xfbcfe100 irq 16
[    1.048938] ata10: SATA max UDMA/133 abar m8192@0xfbcfe000 port 
0xfbcfe180 irq 16
[    1.140055] mpt2sas0: diag reset: FAILED
[    1.140933] mpt2sas0: _base_get_ioc_facts: failed getting to correct 
state
[    1.142527] mpt2sas0: failure at 
/home/apw/COD/linux/drivers/scsi/mpt2sas/mpt2sas_scsih.c:8192/_scsih_probe()!
[    1.368028] ata9: SATA link down (SStatus 0 SControl 300)
[    1.368068] ata10: SATA link down (SStatus 0 SControl 300)
...

