Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35278 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaETAhn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 20:37:43 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so9974737qga.6
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 17:37:43 -0700 (PDT)
Received: from isis.dartmouth.edu (isis.dartmouth.edu. [129.170.26.100])
        by mx.google.com with ESMTPSA id m7sm30080781qao.20.2014.05.19.17.37.41
        for <linux-pci@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 May 2014 17:37:42 -0700 (PDT)
From: Micah Dombrowski <mpdwibble@gmail.com>
Content-Type: multipart/mixed; boundary="Apple-Mail=_17E23EA4-CF61-42DB-B001-F37022CBD6BC"
Subject: Frustrating PCI x ACPI x APIC(?) interaction/bug
Message-Id: <EF1232FA-308B-4261-82E6-6E3B932181E2@gmail.com>
Date: Mon, 19 May 2014 20:37:40 -0400
To: linux-pci@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Apple-Mail=_17E23EA4-CF61-42DB-B001-F37022CBD6BC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello All,

Not sure what list this is most appropriate to=85guess I=92ll start with =
-pci.  The short, short version: Strange DMA(?) bug only occurs with a =
specific card x laptop combination, is maybe fixed by passing =93acpi=3Dof=
f noapic=94 to the kernel, but this also slows the system down to an =
unusable crawl.

This is under kernels 3.11.0 (Mint 16 stock) and 3.13.2 (custom =
compiled, have tried fiddling with/disabling various clock settings, =
acpi/power-saving stuff, etc. to no avail).  Will attach cpuinfo, lspci =
-v, and lshw output.

Long version: My research group has hit a dead end with getting two =
pieces of hardware to work together, and I=92m asking around here =
because it seems like this might be, if not a Linux bug, then perhaps a =
hardware bug/oddity that Linux could work around if I had the right =
settings or=85something.

We=92re trying to use a PCI analog-to-digital sampler (a Measurement =
Computing PCI-DAS4020/12) with a comedi Linux driver, plugged into a =
Magma Corp. PCI->PCIe enclosure, connected to the expresscard slot in a =
Lenovo T530 laptop.  The 4020 card, enclosure, cabling, and expresscard =
have all been tested by plugging into a desktop pc with an =
expresscard->pcie adapter, and it works just as well as when the 4020 is =
plugged directly into a PCI slot on the same pc.  The expresscard slot =
on the laptop has been tested by Lenovo support and by us (with a usb =
3.0 -> expresscard adapter), and it is capable of well over the 80 MBps =
acquisition rate that we require.  We=92ve also tested a usb 2.0 PCI =
card in the Magma enclosure, and seemed to get reasonable rates through =
that as well.

After weeks of fiddling around, it seems that perhaps there's something =
going wrong when the driver copies from the onboard buffer to the comedi =
driver buffer.  The card can just barely work with 1 channel at 10 MSps =
(20 MBps, as each =92sample=92 is 2 bytes).  Any attempt to go to 1 =
channel at 20 MSps (or 2x10 MSps) fails, and the symptom I've found is =
that the comedi buffer takes longer to fill than it should, and there =
are gaps in the data that does come across (i.e. waveforms are broken).  =
For example, a 20 MBps should take approximately 210 ms to acquire 4MB, =
and it properly averages to that, but a 40 MBps mode should then take =
105 ms, and instead comedi_get_buffer_contents() takes over 160 ms to =
reach 4MB.  To reiterate: these numbers all make perfect sense when this =
is done on a PC, the issue only occurs on these laptops.

I was close to giving up, after getting baffled shrugs from the Comedi =
mailing list, Magma, and Lenovo (Measurement Computing hears =91Linux=92 =
and nopes out the door); however, while trying out limiting the RAM to 2 =
GB to test for 64-bit addressing issues, I also decided to play around =
with some random kernel command line parameters, and I found something =
that seems to make 40 MBps modes kinda work: the combination "acpi=3Doff =
noapic".  At a guess, the issue seems to be the ACPI (noapic by itself =
does nothing), but disabling ACPI alone yields an error (perhaps because =
the card is getting assigned interrupt 18?)  Unfortunately this creates =
the issue that this 'fix' seems to slow the system down quite a bit: we =
can't even try to test top-speed 80 MBps modes because the code can't =
keep up and the comedi buffer overflows.  =46rom watching the comedi =
buffer status, it seems like the system is just barely keeping up with =
40 MBps.

Under previous suggestions from Magma, we've disabled all of the =
CPU/PCIe power saving stuff in the laptop=92s BIOS, but I don't know if =
the Linux ACPI system can overrule that, or if it's something else.  =
I've tried the obvious combinations I could find of acpi=3Dht,strict,noirq=
 and pci=3Dnoacpi, but only the complete acpi=3Doff parameter shows the =
improvement in dma->buffer timing.

I=92ll take any suggestions on things to try (or different MLs to ask), =
and will try to provide any additional info that could help.

Thanks,
Micah P. Dombrowski
Dartmouth College Physics and Astronomy Dept.


--Apple-Mail=_17E23EA4-CF61-42DB-B001-F37022CBD6BC
Content-Disposition: attachment;
	filename=cpuinfo.out
Content-Type: application/octet-stream;
	name="cpuinfo.out"
Content-Transfer-Encoding: 7bit

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i5-3230M CPU @ 2.60GHz
stepping	: 9
microcode	: 0x17
cpu MHz		: 2594.125
cache size	: 3072 KB
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips	: 5190.42
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:


--Apple-Mail=_17E23EA4-CF61-42DB-B001-F37022CBD6BC
Content-Disposition: attachment;
	filename=lshw.out
Content-Type: application/octet-stream;
	name="lshw.out"
Content-Transfer-Encoding: 7bit

thelonious
    description: Notebook
    product: 2359CTO (LENOVO_MT_2359)
    vendor: LENOVO
    version: ThinkPad T530
    serial: PK1F9VD
    width: 64 bits
    capabilities: smbios-2.7 dmi-2.7 vsyscall32
    configuration: administrator_password=disabled chassis=notebook family=ThinkPad T530 power-on_password=disabled sku=LENOVO_MT_2359 uuid=81812836-DF52-CB11-A588-BB1EE300966F
  *-core
       description: Motherboard
       product: 2359CTO
       vendor: LENOVO
       physical id: 0
       version: Win8 STD MBR TPG
       serial: 1ZSF331P4A0
       slot: Not Available
     *-cpu
          description: CPU
          product: Intel(R) Core(TM) i5-3230M CPU @ 2.60GHz
          vendor: Intel Corp.
          physical id: 1
          bus info: cpu@0
          version: Intel(R) Core(TM) i5-3230M CPU @ 2.60GHz
          serial: None
          slot: CPU Socket - U3E1
          size: 2600MHz
          capacity: 2600MHz
          width: 64 bits
          clock: 100MHz
          capabilities: x86-64 fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp constant_tsc arch_perfmon pebs bts rep_good nopl nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
          configuration: cores=2 enabledcores=2 threads=4
        *-cache:0
             description: L1 cache
             physical id: 3
             slot: L1-Cache
             size: 32KiB
             capacity: 32KiB
             capabilities: internal write-through instruction
        *-cache:1
             description: L2 cache
             physical id: 4
             slot: L2-Cache
             size: 256KiB
             capacity: 256KiB
             capabilities: internal write-through unified
        *-cache:2
             description: L3 cache
             physical id: 5
             slot: L3-Cache
             size: 3MiB
             capacity: 3MiB
             capabilities: internal write-back unified
     *-cache
          description: L1 cache
          physical id: 2
          slot: L1-Cache
          size: 32KiB
          capacity: 32KiB
          capabilities: internal write-through data
     *-memory
          description: System Memory
          physical id: 7
          slot: System board or motherboard
          size: 6GiB
        *-bank:0
             description: SODIMM DDR3 Synchronous 1600 MHz (0.6 ns)
             product: RMT3170EB68E9W1600
             vendor: Fujitsu
             physical id: 0
             serial: 4403BB08
             slot: ChannelA-DIMM0
             size: 4GiB
             width: 64 bits
             clock: 1600MHz (0.6ns)
        *-bank:1
             description: SODIMM DDR3 Synchronous 1600 MHz (0.6 ns)
             product: F3-12800CL9-2GBSQ
             vendor: Fujitsu
             physical id: 1
             serial: 00000000
             slot: ChannelB-DIMM0
             size: 2GiB
             width: 64 bits
             clock: 1600MHz (0.6ns)
     *-firmware
          description: BIOS
          vendor: LENOVO
          physical id: b
          version: G4ET94WW (2.54 )
          date: 05/23/2013
          size: 128KiB
          capacity: 11MiB
          capabilities: pci pnp upgrade shadowing cdboot bootselect edd int13floppy720 int5printscreen int9keyboard int14serial int17printer int10video acpi usb biosbootspecification uefi
     *-pci
          description: Host bridge
          product: 3rd Gen Core processor DRAM Controller
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 09
          width: 32 bits
          clock: 33MHz
        *-display
             description: VGA compatible controller
             product: 3rd Gen Core processor Graphics Controller
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@0000:00:02.0
             version: 09
             width: 64 bits
             clock: 33MHz
             capabilities: msi pm vga_controller bus_master cap_list rom
             configuration: driver=i915 latency=0
             resources: irq:40 memory:f0000000-f03fffff memory:e0000000-efffffff ioport:6000(size=64)
        *-usb:0
             description: USB controller
             product: 7 Series/C210 Series Chipset Family USB xHCI Host Controller
             vendor: Intel Corporation
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi xhci bus_master cap_list
             configuration: driver=xhci_hcd latency=0
             resources: irq:43 memory:f2520000-f252ffff
        *-communication
             description: Communication controller
             product: 7 Series/C210 Series Chipset Family MEI Controller #1
             vendor: Intel Corporation
             physical id: 16
             bus info: pci@0000:00:16.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=mei_me latency=0
             resources: irq:41 memory:f2535000-f253500f
        *-network
             description: Ethernet interface
             product: 82579LM Gigabit Network Connection
             vendor: Intel Corporation
             physical id: 19
             bus info: pci@0000:00:19.0
             logical name: eth1
             version: 04
             serial: 3c:97:0e:70:64:b8
             size: 1Gbit/s
             capacity: 1Gbit/s
             width: 32 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
             configuration: autonegotiation=on broadcast=yes driver=e1000e driverversion=2.3.2-k duplex=full firmware=0.13-3 ip=10.170.27.180 latency=0 link=yes multicast=yes port=twisted pair speed=1Gbit/s
             resources: irq:44 memory:f2500000-f251ffff memory:f253b000-f253bfff ioport:6080(size=32)
        *-usb:1
             description: USB controller
             product: 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #2
             vendor: Intel Corporation
             physical id: 1a
             bus info: pci@0000:00:1a.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=0
             resources: irq:16 memory:f253a000-f253a3ff
        *-multimedia
             description: Audio device
             product: 7 Series/C210 Series Chipset Family High Definition Audio Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@0000:00:1b.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress bus_master cap_list
             configuration: driver=snd_hda_intel latency=0
             resources: irq:45 memory:f2530000-f2533fff
        *-pci:0
             description: PCI bridge
             product: 7 Series/C210 Series Chipset Family PCI Express Root Port 1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: c4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 ioport:5000(size=4096) memory:f1d00000-f24fffff ioport:f0400000(size=8388608)
           *-generic UNCLAIMED
                description: System peripheral
                product: PCIe SDXC/MMC Host Controller
                vendor: Ricoh Co Ltd
                physical id: 0
                bus info: pci@0000:02:00.0
                version: 04
                width: 32 bits
                clock: 33MHz
                capabilities: msi pm pciexpress bus_master cap_list
                configuration: latency=0
                resources: memory:f1d00000-f1d000ff
        *-pci:1
             description: PCI bridge
             product: 7 Series/C210 Series Chipset Family PCI Express Root Port 2
             vendor: Intel Corporation
             physical id: 1c.1
             bus info: pci@0000:00:1c.1
             version: c4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:17 ioport:4000(size=4096) memory:f1c00000-f1cfffff
           *-network
                description: Ethernet interface
                product: RTL8188CE 802.11b/g/n WiFi Adapter
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0
                bus info: pci@0000:03:00.0
                logical name: wlan0
                version: 01
                serial: b8:76:3f:d4:08:ef
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list ethernet physical
                configuration: broadcast=yes driver=rtl8192ce driverversion=3.13.2 firmware=N/A latency=0 link=no multicast=yes
                resources: irq:17 ioport:4000(size=256) memory:f1c00000-f1c03fff
        *-pci:2
             description: PCI bridge
             product: 7 Series/C210 Series Chipset Family PCI Express Root Port 3
             vendor: Intel Corporation
             physical id: 1c.2
             bus info: pci@0000:00:1c.2
             version: c4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:18 ioport:3000(size=4096) memory:f1400000-f1bfffff ioport:f0c00000(size=8388608)
           *-pci
                description: PCI bridge
                product: XIO2000(A)/XIO2200A PCI Express-to-PCI Bridge
                vendor: Texas Instruments
                physical id: 0
                bus info: pci@0000:04:00.0
                logical name: /dev/fb0
                version: 03
                width: 64 bits
                clock: 33MHz
                capabilities: pci pm msi pciexpress normal_decode bus_master cap_list fb
                configuration: depth=32 mode=1600x900 visual=truecolor xres=1600 yres=900
                resources: iomemory:28031310-2803130f ioport:3000(size=4096) memory:f1400000-f14fffff ioport:f0c00000(size=1048576)
              *-pci
                   description: PCI bridge
                   product: PCI to PCI Bridge
                   vendor: Pericom Semiconductor
                   physical id: 4
                   bus info: pci@0000:05:04.0
                   version: 02
                   slot: 0, chassis 0
                   width: 32 bits
                   clock: 33MHz
                   capabilities: pci pm slotid normal_decode bus_master cap_list
                   resources: ioport:3000(size=4096) memory:f1400000-f14fffff ioport:f0c00000(size=1048576)
                 *-generic
                      description: Unassigned class
                      product: PCI-DAS4020/12
                      vendor: Measurement Computing
                      physical id: 4
                      bus info: pci@0000:06:04.0
                      version: 02
                      width: 32 bits
                      clock: 33MHz
                      capabilities: bus_master rom
                      configuration: driver=cb_pcidas64 latency=32 maxlatency=255 mingnt=255
                      resources: irq:18 memory:f1402000-f14020ff ioport:3000(size=256) memory:f1401000-f1401fff memory:f1400000-f1400fff memory:f0c00000-f0c007ff
        *-usb:2
             description: USB controller
             product: 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #1
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@0000:00:1d.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=0
             resources: irq:23 memory:f2539000-f25393ff
        *-isa
             description: ISA bridge
             product: QM77 Express Chipset LPC Controller
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master cap_list
             configuration: driver=lpc_ich latency=0
             resources: irq:0
        *-storage
             description: SATA controller
             product: 7 Series Chipset Family 6-port SATA Controller [AHCI mode]
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@0000:00:1f.2
             version: 04
             width: 32 bits
             clock: 66MHz
             capabilities: storage msi pm ahci_1.0 bus_master cap_list
             configuration: driver=ahci latency=0
             resources: irq:42 ioport:60a8(size=8) ioport:60b4(size=4) ioport:60a0(size=8) ioport:60b0(size=4) ioport:6060(size=32) memory:f2538000-f25387ff
        *-serial
             description: SMBus
             product: 7 Series/C210 Series Chipset Family SMBus Controller
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@0000:00:1f.3
             version: 04
             width: 64 bits
             clock: 33MHz
             configuration: driver=i801_smbus latency=0
             resources: irq:18 memory:f2534000-f25340ff ioport:efa0(size=32)
     *-scsi:0
          physical id: 0
          logical name: scsi0
          capabilities: emulated
        *-disk
             description: ATA Disk
             product: SAMSUNG MZ7TD128
             physical id: 0.0.0
             bus info: scsi@0:0.0.0
             logical name: /dev/sda
             version: DXT0
             serial: S14TNSAD902294
             size: 119GiB (128GB)
             capabilities: partitioned partitioned:dos
             configuration: ansiversion=5 sectorsize=512 signature=2d6eb287
           *-volume:0
                description: Linux filesystem partition
                vendor: Linux
                physical id: 1
                bus info: scsi@0:0.0.0,1
                logical name: /dev/sda1
                logical name: /boot
                version: 1.0
                serial: a588abc9-226e-4ea7-892c-7aede9cb8960
                size: 243MiB
                capacity: 243MiB
                capabilities: primary bootable extended_attributes ext2 initialized
                configuration: filesystem=ext2 modified=2014-05-14 13:02:16 mount.fstype=ext2 mount.options=rw,relatime,errors=continue state=mounted
           *-volume:1
                description: Extended partition
                physical id: 2
                bus info: scsi@0:0.0.0,2
                logical name: /dev/sda2
                size: 119GiB
                capacity: 119GiB
                capabilities: primary extended partitioned partitioned:extended
              *-logicalvolume
                   description: Linux LVM Physical Volume partition
                   physical id: 5
                   logical name: /dev/sda5
                   serial: JJthG0-uLGU-dL17-7FE9-IMmf-4y8g-bEooag
                   size: 119GiB
                   capacity: 119GiB
                   capabilities: multi lvm2
     *-scsi:1
          physical id: 3
          logical name: scsi1
          capabilities: emulated
        *-cdrom
             description: DVD-RAM writer
             product: DVDRAM GT80N
             vendor: HL-DT-ST
             physical id: 0.0.0
             bus info: scsi@1:0.0.0
             logical name: /dev/cdrom
             logical name: /dev/sr0
             version: LT20
             capabilities: removable audio cd-r cd-rw dvd dvd-r dvd-ram
             configuration: ansiversion=5 status=nodisc
  *-battery
       product: 45N1005
       vendor: LGC
       physical id: 1
       slot: Rear
       capacity: 56160mWh
       configuration: voltage=10.8V

--Apple-Mail=_17E23EA4-CF61-42DB-B001-F37022CBD6BC
Content-Disposition: attachment;
	filename=lspci-v.out
Content-Type: application/octet-stream;
	name="lspci-v.out"
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller (rev 09)
	Subsystem: Lenovo Device 21f6
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 21f6
	Flags: bus master, fast devsel, latency 0, IRQ 40
	Memory at f0000000 (64-bit, non-prefetchable) [size=4M]
	Memory at e0000000 (64-bit, prefetchable) [size=256M]
	I/O ports at 6000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [d0] Power Management version 2
	Capabilities: [a4] PCI Advanced Features
	Kernel driver in use: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
	Subsystem: Lenovo Device 21f6
	Flags: bus master, medium devsel, latency 0, IRQ 43
	Memory at f2520000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
	Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series Chipset Family MEI Controller #1 (rev 04)
	Subsystem: Lenovo Device 21f6
	Flags: bus master, fast devsel, latency 0, IRQ 41
	Memory at f2535000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Kernel driver in use: mei_me

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)
	Subsystem: Lenovo Device 21f3
	Flags: bus master, fast devsel, latency 0, IRQ 44
	Memory at f2500000 (32-bit, non-prefetchable) [size=128K]
	Memory at f253b000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 6080 [size=32]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [e0] PCI Advanced Features
	Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21f6
	Flags: bus master, medium devsel, latency 0, IRQ 16
	Memory at f253a000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
	Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)
	Subsystem: Lenovo Device 21f6
	Flags: bus master, fast devsel, latency 0, IRQ 45
	Memory at f2530000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Root Complex Link
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: f1d00000-f24fffff
	Prefetchable memory behind bridge: 00000000f0400000-00000000f0bfffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Lenovo Device 21f6
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f1c00000-f1cfffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Lenovo Device 21f6
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 3 (rev c4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=0b, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f1400000-f1bfffff
	Prefetchable memory behind bridge: 00000000f0c00000-00000000f13fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Lenovo Device 21f6
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21f6
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at f2539000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation QM77 Express Chipset LPC Controller (rev 04)
	Subsystem: Lenovo Device 21f6
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: Lenovo Device 21f6
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 42
	I/O ports at 60a8 [size=8]
	I/O ports at 60b4 [size=4]
	I/O ports at 60a0 [size=8]
	I/O ports at 60b0 [size=4]
	I/O ports at 6060 [size=32]
	Memory at f2538000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [70] Power Management version 3
	Capabilities: [a8] SATA HBA v1.0
	Capabilities: [b0] PCI Advanced Features
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SMBus Controller (rev 04)
	Subsystem: Lenovo Device 21f6
	Flags: medium devsel, IRQ 18
	Memory at f2534000 (64-bit, non-prefetchable) [size=256]
	I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus

02:00.0 System peripheral: Ricoh Co Ltd PCIe SDXC/MMC Host Controller (rev 04) (prog-if 01)
	Subsystem: Lenovo Device 21f6
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at f1d00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [800] Advanced Error Reporting

03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8188CE 802.11b/g/n WiFi Adapter (rev 01)
	Subsystem: Realtek Semiconductor Co., Ltd. Device 8195
	Flags: bus master, fast devsel, latency 0, IRQ 17
	I/O ports at 4000 [size=256]
	Memory at f1c00000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [160] Device Serial Number 01-91-81-fe-ff-4c-e0-00
	Kernel driver in use: rtl8192ce

04:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200A PCI Express-to-PCI Bridge (rev 03) (prog-if 00 [Normal decode])
	Physical Slot: 1
	Flags: bus master, fast devsel, latency 0
	Bus: primary=04, secondary=05, subordinate=06, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f1400000-f14fffff
	Prefetchable memory behind bridge: 00000000f0c00000-00000000f0cfffff
	Capabilities: [50] Power Management version 2
	Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
	Capabilities: [80] Subsystem: Device 0000:0000
	Capabilities: [90] Express PCI/PCI-X Bridge, MSI 00
	Capabilities: [100] Advanced Error Reporting

05:04.0 PCI bridge: Pericom Semiconductor PCI to PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=05, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f1400000-f14fffff
	Prefetchable memory behind bridge: 00000000f0c00000-00000000f0cfffff
	Capabilities: [dc] Power Management version 1
	Capabilities: [b0] Slot ID: 0 slots, First-, chassis 00

06:04.0 Unassigned class [ffff]: Measurement Computing PCI-DAS4020/12 (rev 02) (prog-if ff)
	Subsystem: Measurement Computing Device 0000
	Flags: bus master, medium devsel, latency 32, IRQ 18
	Memory at f1402000 (32-bit, non-prefetchable) [size=256]
	I/O ports at 3000 [size=256]
	Memory at f1401000 (32-bit, non-prefetchable) [size=4K]
	Memory at f1400000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at f0c00000 [disabled] [size=2K]
	Kernel driver in use: cb_pcidas64


--Apple-Mail=_17E23EA4-CF61-42DB-B001-F37022CBD6BC--
