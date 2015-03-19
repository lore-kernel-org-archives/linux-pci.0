Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bernhard Thaler <bernhard.thaler@wvnet.at>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [Debug 0/2] Fix regressions caused by commit 593669c2ac0f
Date: Thu, 19 Mar 2015 12:27:07 +0100
Message-ID: <4317184.19IeWuljky@vostro.rjw.lan>
In-Reply-To: <550A7674.6070306@wvnet.at>
References: <550A7674.6070306@wvnet.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, March 19, 2015 08:10:44 AM Bernhard Thaler wrote:
> This is a multi-part message in MIME format.
> --------------000809080900050004000900
> Content-Type: text/plain; charset=windows-1252
> Content-Transfer-Encoding: 7bit
> 
> Hi,
> 
> I think this regression is not yet solved.

First off, it is good to CC the commit author too (CCed now).

> I encounter this or a similar problem with an PC Engines APU.1C device
> (see: http://pcengines.ch/apu.htm). It has 3 network interfaces each
> requiring the r8169 kernel module.
> 
> With 4.0.0-rc4 I get this error message at boot (for each of the 3 devices):
> 
> [    3.562301] r8169 0000:01:00.0 (unnamed net_device) (uninitialized):
> rtl_chipcmd_cond == 1 (loop: 100, delay: 100).
> 
> "ifconfig -a" shows ff:ff:ff:ff:ff:ff as MAC address for each of the
> interfaces (see eth0 as example):
> 
> eth0      Link encap:Ethernet  HWaddr ff:ff:ff:ff:ff:ff
>           BROADCAST PROMISC MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> 
> The network interfaces cannot be brought up/used.
> 
> The same device and setup did work with a previously used 3.18.0-rc5
> kernel. When I boot it with this 3.18.0-rc5 kernel everything i OK,
> interfaces come up and work.

Second, it is not entirely clear to me that what you're seeing is actually
the same regression.  Have you tested 4.0.0-rc4 with commit 593669c2ac0f
reverted?

> Please find attached:
> -> dmesg output when starting device with kernel 4.0.0-rc4
> -> dmesg output when starting device with kernel 3.18.0-rc5
> -> lspci of the device
> 
> I am happy to assist with testing and try to provide any information needed.
> 
> Regards,
> Bernhard
> 
> 
> --------------000809080900050004000900
> Content-Type: text/plain; charset=windows-1252;
>  name="dmesg_3.18.0-rc5.txt"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: attachment;
>  filename="dmesg_3.18.0-rc5.txt"
> 
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.18.0-rc5-ecknn+ (root@kali) (gcc version 4.7.2 (Debian 4.7.2-5) ) #2 SMP Sat Nov 29 17:41:14 CET 2014
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.18.0-rc5-ecknn+ root=UUID=0a8a0627-f77c-4195-b43b-e6f6d879a3b1 ro console=ttyS0,115200n8 console=ttyS0,115200n8 quiet
> [    0.000000] tseg: 0000000000
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007e16ebff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007e16ec00-0x000000007efffbff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000f8ffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.7 present.
> [    0.000000] DMI: PC Engines APU, BIOS unknown 12/24/2013
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] AGP: No AGP bridge found
> [    0.000000] e820: last_pfn = 0x7e16e max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-FFFFF write-back
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 000000000 mask F80000000 write-back
> [    0.000000]   1 base 07F000000 mask FFF000000 uncachable
> [    0.000000]   2 disabled
> [    0.000000]   3 disabled
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 base 0FFE00000 mask FFFE00000 write-protect
> [    0.000000]   7 disabled
> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
> [    0.000000] found SMP MP-table at [mem 0x000fda10-0x000fda1f] mapped at [ffff8800000fda10]
> [    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
> [    0.000000] Using GB pages for direct mapping
> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> [    0.000000] BRK [0x01a99000, 0x01a99fff] PGTABLE
> [    0.000000] BRK [0x01a9a000, 0x01a9afff] PGTABLE
> [    0.000000] BRK [0x01a9b000, 0x01a9bfff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x7de00000-0x7dffffff]
> [    0.000000]  [mem 0x7de00000-0x7dffffff] page 2M
> [    0.000000] BRK [0x01a9c000, 0x01a9cfff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x7c000000-0x7ddfffff]
> [    0.000000]  [mem 0x7c000000-0x7ddfffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x00100000-0x7bffffff]
> [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
> [    0.000000]  [mem 0x00200000-0x7bffffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x7e000000-0x7e16dfff]
> [    0.000000]  [mem 0x7e000000-0x7e16dfff] page 4k
> [    0.000000] BRK [0x01a9d000, 0x01a9dfff] PGTABLE
> [    0.000000] RAMDISK: [mem 0x362dc000-0x37165fff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000FD9F0 000014 (v00 CORE  )
> [    0.000000] ACPI: RSDT 0x000000007E171024 000040 (v01 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: FACP 0x000000007E173A20 0000F4 (v04 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: DSDT 0x000000007E1710C8 002915 (v02 PCENG  APU      00010001 INTL 20121114)
> [    0.000000] ACPI: FACS 0x000000007E1739E0 000040
> [    0.000000] ACPI: HPET 0x000000007E173B18 000038 (v01 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: APIC 0x000000007E173B50 00005C (v01 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: HEST 0x000000007E173BB0 000198 (v01 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: SSDT 0x000000007E173D50 00168E (v02 AMD    ALIB     00000001 MSFT 04000000)
> [    0.000000] ACPI: SSDT 0x000000007E1753E0 00030C (v01 AMD    POWERNOW 00000001 AMD  00000001)
> [    0.000000] ACPI: SSDT 0x000000007E1756F0 000045 (v02 CORE   COREBOOT 0000002A CORE 0000002A)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000007e16dfff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x7e16a000-0x7e16dfff]
> [    0.000000]  [ffffea0000000000-ffffea0001bfffff] PMD -> [ffff88007b800000-ffff88007d3fffff] on node 0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
> [    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x00001000-0x0009efff]
> [    0.000000]   node   0: [mem 0x00100000-0x7e16dfff]
> [    0.000000] Initmem setup node 0 [mem 0x00001000-0x7e16dfff]
> [    0.000000] On node 0 totalpages: 516364
> [    0.000000]   DMA zone: 56 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3998 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 7006 pages used for memmap
> [    0.000000]   DMA32 zone: 512366 pages, LIFO batch:31
> [    0.000000] ACPI: PM-Timer IO Port: 0x808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x43538210 base: 0xfed00000
> [    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> [    0.000000] e820: [mem 0x7efffc00-0xf7ffffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 30 pages/cpu @ffff88007de00000 s86016 r8192 d28672 u1048576
> [    0.000000] pcpu-alloc: s86016 r8192 d28672 u1048576 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 0 1 
> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 509281
> [    0.000000] Policy zone: DMA32
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.18.0-rc5-ecknn+ root=UUID=0a8a0627-f77c-4195-b43b-e6f6d879a3b1 ro console=ttyS0,115200n8 console=ttyS0,115200n8 quiet
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] AGP: Checking aperture...
> [    0.000000] AGP: No AGP bridge found
> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [    0.000000] Memory: 2010428K/2065456K available (5230K kernel code, 765K rwdata, 1728K rodata, 1020K init, 840K bss, 55028K reserved)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=2.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> [    0.000000] NR_IRQS:33024 nr_irqs:440 0
> [    0.000000] spurious 8259A interrupt: IRQ7.
> [    0.000000] Console: colour dummy device 80x25
> [    0.000000] console [ttyS0] enabled
> [    0.000000] allocated 8388608 bytes of page_cgroup
> [    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
> [    0.000000] hpet clockevent registered
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 1000.094 MHz processor
> [    0.000077] Calibrating delay loop (skipped), value calculated using timer frequency.. 2000.18 BogoMIPS (lpj=4000376)
> [    0.000086] pid_max: default: 32768 minimum: 301
> [    0.000115] ACPI: Core revision 20140926
> [    0.008581] ACPI: All ACPI Tables successfully acquired
> [    0.008684] Security Framework initialized
> [    0.008697] AppArmor: AppArmor disabled by boot time parameter
> [    0.008701] Yama: becoming mindful.
> [    0.009157] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.011167] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> [    0.012175] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.012193] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.012864] Initializing cgroup subsys memory
> [    0.012892] Initializing cgroup subsys devices
> [    0.012905] Initializing cgroup subsys freezer
> [    0.012914] Initializing cgroup subsys net_cls
> [    0.012923] Initializing cgroup subsys blkio
> [    0.012934] Initializing cgroup subsys perf_event
> [    0.013002] CPU: Physical Processor ID: 0
> [    0.013006] CPU: Processor Core ID: 0
> [    0.013011] mce: CPU supports 6 MCE banks
> [    0.013035] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 4
> [    0.013035] Last level dTLB entries: 4KB 512, 2MB 8, 4MB 4, 1GB 0
> [    0.013318] Freeing SMP alternatives memory: 20K (ffffffff819c0000 - ffffffff819c5000)
> [    0.017370] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
> [    0.057075] smpboot: CPU0: AMD G-T40E Processor (fam: 14, model: 02, stepping: 00)
> [    0.161929] Performance Events: AMD PMU driver.
> [    0.161942] ... version:                0
> [    0.161947] ... bit width:              48
> [    0.161950] ... generic registers:      4
> [    0.161954] ... value mask:             0000ffffffffffff
> [    0.161958] ... max period:             00007fffffffffff
> [    0.161961] ... fixed-purpose events:   0
> [    0.161965] ... event mask:             000000000000000f
> [    0.162864] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> [    0.163183] x86: Booting SMP configuration:
> [    0.163190] .... node  #0, CPUs:      #1
> [    0.176378] x86: Booted up 1 node, 2 CPUs
> [    0.176386] smpboot: Total of 2 processors activated (4000.37 BogoMIPS)
> [    0.177727] devtmpfs: initialized
> [    0.191773] pinctrl core: initialized pinctrl subsystem
> [    0.192246] NET: Registered protocol family 16
> [    0.204678] cpuidle: using governor ladder
> [    0.214164] cpuidle: using governor menu
> [    0.214559] ACPI: bus type PCI registered
> [    0.214567] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.214922] PCI: Using configuration type 1 for base access
> [    0.214927] PCI: Using configuration type 1 for extended access
> [    0.230874] ACPI: Added _OSI(Module Device)
> [    0.230885] ACPI: Added _OSI(Processor Device)
> [    0.230890] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.230895] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.234219] ACPI: Executed 2 blocks of module-level executable AML code
> [    0.241654] ACPI: Interpreter enabled
> [    0.241721] ACPI: (supports S0 S1 S2 S3 S4 S5)
> [    0.241727] ACPI: Using IOAPIC for interrupt routing
> [    0.241779] HEST: Table parsing has been initialized.
> [    0.241788] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.263268] acpi LNXCPU:01: Invalid PBLK length [0]
> [    0.268517] ACPI: PCI Interrupt Link [INTA] (IRQs 3 4 5 7 10 11 12 15) *0, disabled.
> [    0.268783] ACPI: PCI Interrupt Link [INTB] (IRQs 3 4 5 7 10 11 12 15) *0, disabled.
> [    0.269041] ACPI: PCI Interrupt Link [INTC] (IRQs 3 4 5 7 10 11 12 15) *0, disabled.
> [    0.269297] ACPI: PCI Interrupt Link [INTD] (IRQs 3 4 5 7 10 11 12 15) *0, disabled.
> [    0.269551] ACPI: PCI Interrupt Link [INTE] (IRQs 3 4 5 7 10 11 12 15) *0, disabled.
> [    0.269806] ACPI: PCI Interrupt Link [INTF] (IRQs 9) *0, disabled.
> [    0.270054] ACPI: PCI Interrupt Link [INTG] (IRQs 3 4 5 7 10 11 12 15) *0, disabled.
> [    0.270307] ACPI: PCI Interrupt Link [INTH] (IRQs 3 4 5 7 10 11 12 15) *0, disabled.
> [    0.270527] acpi PNP0A03:00: [Firmware Bug]: no secondary bus range in _CRS
> [    0.270553] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.270569] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.270805] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> [    0.271744] PCI host bridge to bus 0000:00
> [    0.271754] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.271762] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
> [    0.271769] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
> [    0.271776] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
> [    0.271783] pci_bus 0000:00: root bus resource [mem 0x7f000000-0xffffffff]
> [    0.271805] pci 0000:00:00.0: [1022:1510] type 00 class 0x060000
> [    0.272164] pci 0000:00:04.0: [1022:1512] type 01 class 0x060400
> [    0.272282] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
> [    0.272442] pci 0000:00:04.0: System wakeup disabled by ACPI
> [    0.272578] pci 0000:00:05.0: [1022:1513] type 01 class 0x060400
> [    0.272691] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
> [    0.272840] pci 0000:00:05.0: System wakeup disabled by ACPI
> [    0.272973] pci 0000:00:06.0: [1022:1514] type 01 class 0x060400
> [    0.273086] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
> [    0.273230] pci 0000:00:06.0: System wakeup disabled by ACPI
> [    0.273430] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
> [    0.273465] pci 0000:00:11.0: reg 0x10: [io  0x4020-0x4027]
> [    0.273483] pci 0000:00:11.0: reg 0x14: [io  0x4040-0x4043]
> [    0.273501] pci 0000:00:11.0: reg 0x18: [io  0x4028-0x402f]
> [    0.273519] pci 0000:00:11.0: reg 0x1c: [io  0x4044-0x4047]
> [    0.273537] pci 0000:00:11.0: reg 0x20: [io  0x4000-0x400f]
> [    0.273555] pci 0000:00:11.0: reg 0x24: [mem 0xfeb04000-0xfeb043ff]
> [    0.273910] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
> [    0.273937] pci 0000:00:12.0: reg 0x10: [mem 0xfeb00000-0xfeb00fff]
> [    0.274159] pci 0000:00:12.0: System wakeup disabled by ACPI
> [    0.274345] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
> [    0.274379] pci 0000:00:12.2: reg 0x10: [mem 0xfeb04400-0xfeb044ff]
> [    0.274516] pci 0000:00:12.2: supports D1 D2
> [    0.274522] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
> [    0.274662] pci 0000:00:12.2: System wakeup disabled by ACPI
> [    0.274845] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
> [    0.274870] pci 0000:00:13.0: reg 0x10: [mem 0xfeb01000-0xfeb01fff]
> [    0.275092] pci 0000:00:13.0: System wakeup disabled by ACPI
> [    0.275276] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
> [    0.275310] pci 0000:00:13.2: reg 0x10: [mem 0xfeb04500-0xfeb045ff]
> [    0.275446] pci 0000:00:13.2: supports D1 D2
> [    0.275452] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
> [    0.275599] pci 0000:00:13.2: System wakeup disabled by ACPI
> [    0.275784] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
> [    0.276162] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
> [    0.276188] pci 0000:00:14.1: reg 0x10: [io  0x4030-0x4037]
> [    0.276206] pci 0000:00:14.1: reg 0x14: [io  0x4048-0x404b]
> [    0.276224] pci 0000:00:14.1: reg 0x18: [io  0x4038-0x403f]
> [    0.276241] pci 0000:00:14.1: reg 0x1c: [io  0x404c-0x404f]
> [    0.276259] pci 0000:00:14.1: reg 0x20: [io  0x4010-0x401f]
> [    0.276293] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [    0.276299] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    0.276305] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [    0.276310] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    0.276615] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
> [    0.276995] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
> [    0.277193] pci 0000:00:14.4: System wakeup disabled by ACPI
> [    0.277372] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
> [    0.277397] pci 0000:00:14.5: reg 0x10: [mem 0xfeb02000-0xfeb02fff]
> [    0.277621] pci 0000:00:14.5: System wakeup disabled by ACPI
> [    0.277812] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
> [    0.277954] pci 0000:00:15.0: supports D1 D2
> [    0.278101] pci 0000:00:15.0: System wakeup disabled by ACPI
> [    0.278276] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
> [    0.278302] pci 0000:00:16.0: reg 0x10: [mem 0xfeb03000-0xfeb03fff]
> [    0.278522] pci 0000:00:16.0: System wakeup disabled by ACPI
> [    0.278709] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
> [    0.278742] pci 0000:00:16.2: reg 0x10: [mem 0xfeb04600-0xfeb046ff]
> [    0.278879] pci 0000:00:16.2: supports D1 D2
> [    0.278885] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
> [    0.279029] pci 0000:00:16.2: System wakeup disabled by ACPI
> [    0.279217] pci 0000:00:18.0: [1022:1700] type 00 class 0x060000
> [    0.279491] pci 0000:00:18.1: [1022:1701] type 00 class 0x060000
> [    0.279758] pci 0000:00:18.2: [1022:1702] type 00 class 0x060000
> [    0.280026] pci 0000:00:18.3: [1022:1703] type 00 class 0x060000
> [    0.280311] pci 0000:00:18.4: [1022:1704] type 00 class 0x060000
> [    0.280589] pci 0000:00:18.5: [1022:1718] type 00 class 0x060000
> [    0.280853] pci 0000:00:18.6: [1022:1716] type 00 class 0x060000
> [    0.281116] pci 0000:00:18.7: [1022:1719] type 00 class 0x060000
> [    0.281586] pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000
> [    0.281615] pci 0000:01:00.0: reg 0x10: [io  0x1000-0x10ff]
> [    0.281653] pci 0000:01:00.0: reg 0x18: [mem 0xfe600000-0xfe600fff 64bit]
> [    0.281678] pci 0000:01:00.0: reg 0x20: [mem 0xfe500000-0xfe503fff 64bit pref]
> [    0.281807] pci 0000:01:00.0: supports D1 D2
> [    0.281813] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.292657] pci 0000:00:04.0: PCI bridge to [bus 01]
> [    0.292681] pci 0000:00:04.0:   bridge window [io  0x1000-0x1fff]
> [    0.292691] pci 0000:00:04.0:   bridge window [mem 0xfe600000-0xfe6fffff]
> [    0.292703] pci 0000:00:04.0:   bridge window [mem 0xfe500000-0xfe5fffff 64bit pref]
> [    0.292913] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
> [    0.292947] pci 0000:02:00.0: reg 0x10: [io  0x2000-0x20ff]
> [    0.292985] pci 0000:02:00.0: reg 0x18: [mem 0xfe800000-0xfe800fff 64bit]
> [    0.293011] pci 0000:02:00.0: reg 0x20: [mem 0xfe700000-0xfe703fff 64bit pref]
> [    0.293158] pci 0000:02:00.0: supports D1 D2
> [    0.293165] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.300657] pci 0000:00:05.0: PCI bridge to [bus 02]
> [    0.300681] pci 0000:00:05.0:   bridge window [io  0x2000-0x2fff]
> [    0.300691] pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe8fffff]
> [    0.300703] pci 0000:00:05.0:   bridge window [mem 0xfe700000-0xfe7fffff 64bit pref]
> [    0.300925] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
> [    0.300959] pci 0000:03:00.0: reg 0x10: [io  0x3000-0x30ff]
> [    0.300997] pci 0000:03:00.0: reg 0x18: [mem 0xfea00000-0xfea00fff 64bit]
> [    0.301023] pci 0000:03:00.0: reg 0x20: [mem 0xfe900000-0xfe903fff 64bit pref]
> [    0.301169] pci 0000:03:00.0: supports D1 D2
> [    0.301176] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.308657] pci 0000:00:06.0: PCI bridge to [bus 03]
> [    0.308680] pci 0000:00:06.0:   bridge window [io  0x3000-0x3fff]
> [    0.308690] pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
> [    0.308703] pci 0000:00:06.0:   bridge window [mem 0xfe900000-0xfe9fffff 64bit pref]
> [    0.308766] pci 0000:00:14.4: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.309034] pci 0000:00:15.0: PCI bridge to [bus 04]
> [    0.309283] pci 0000:00:14.4: PCI bridge to [bus 05-ff] (subtractive decode)
> [    0.309298] pci 0000:00:14.4:   bridge window [mem 0x00000000-0x000fffff]
> [    0.309308] pci 0000:00:14.4:   bridge window [mem 0x00000000-0x000fffff pref]
> [    0.309316] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
> [    0.309323] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
> [    0.309330] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
> [    0.309336] pci 0000:00:14.4:   bridge window [mem 0x7f000000-0xffffffff] (subtractive decode)
> [    0.309345] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
> [    0.310574] ACPI: Enabled 6 GPEs in block 00 to 1F
> [    0.311197] vgaarb: loaded
> [    0.311659] PCI: Using ACPI for IRQ routing
> [    0.311675] PCI: pci_cache_line_size set to 64 bytes
> [    0.311851] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> [    0.311859] e820: reserve RAM buffer [mem 0x7e16ec00-0x7fffffff]
> [    0.312386] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.312399] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [    0.314640] Switched to clocksource hpet
> [    0.321635] pnp: PnP ACPI init
> [    0.322628] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.322784] pnp: PnP ACPI: found 1 devices
> [    0.341831] pci 0000:00:04.0: PCI bridge to [bus 01]
> [    0.341848] pci 0000:00:04.0:   bridge window [io  0x1000-0x1fff]
> [    0.341860] pci 0000:00:04.0:   bridge window [mem 0xfe600000-0xfe6fffff]
> [    0.341870] pci 0000:00:04.0:   bridge window [mem 0xfe500000-0xfe5fffff 64bit pref]
> [    0.341881] pci 0000:00:05.0: PCI bridge to [bus 02]
> [    0.341889] pci 0000:00:05.0:   bridge window [io  0x2000-0x2fff]
> [    0.341899] pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe8fffff]
> [    0.341908] pci 0000:00:05.0:   bridge window [mem 0xfe700000-0xfe7fffff 64bit pref]
> [    0.341918] pci 0000:00:06.0: PCI bridge to [bus 03]
> [    0.341925] pci 0000:00:06.0:   bridge window [io  0x3000-0x3fff]
> [    0.341935] pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
> [    0.341943] pci 0000:00:06.0:   bridge window [mem 0xfe900000-0xfe9fffff 64bit pref]
> [    0.341954] pci 0000:00:14.4: PCI bridge to [bus 05]
> [    0.342021] pci 0000:00:15.0: PCI bridge to [bus 04]
> [    0.342044] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
> [    0.342050] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
> [    0.342056] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
> [    0.342063] pci_bus 0000:00: resource 7 [mem 0x7f000000-0xffffffff]
> [    0.342069] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> [    0.342076] pci_bus 0000:01: resource 1 [mem 0xfe600000-0xfe6fffff]
> [    0.342082] pci_bus 0000:01: resource 2 [mem 0xfe500000-0xfe5fffff 64bit pref]
> [    0.342089] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
> [    0.342095] pci_bus 0000:02: resource 1 [mem 0xfe800000-0xfe8fffff]
> [    0.342102] pci_bus 0000:02: resource 2 [mem 0xfe700000-0xfe7fffff 64bit pref]
> [    0.342108] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
> [    0.342114] pci_bus 0000:03: resource 1 [mem 0xfea00000-0xfeafffff]
> [    0.342121] pci_bus 0000:03: resource 2 [mem 0xfe900000-0xfe9fffff 64bit pref]
> [    0.342128] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
> [    0.342134] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
> [    0.342139] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
> [    0.342145] pci_bus 0000:05: resource 7 [mem 0x7f000000-0xffffffff]
> [    0.342340] NET: Registered protocol family 2
> [    0.342975] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> [    0.343184] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
> [    0.343362] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.343477] TCP: reno registered
> [    0.343497] UDP hash table entries: 1024 (order: 3, 32768 bytes)
> [    0.343534] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
> [    0.343858] NET: Registered protocol family 1
> [    0.348156] PCI: CLS 64 bytes, default 64
> [    0.348316] Unpacking initramfs...
> [    1.224861] Freeing initrd memory: 14888K (ffff8800362dc000 - ffff880037166000)
> [    1.225788] microcode: CPU0: patch_level=0x05000101
> [    1.225816] microcode: CPU1: patch_level=0x05000101
> [    1.226220] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
> [    1.226247] LVT offset 0 assigned for vector 0x400
> [    1.226371] perf: AMD IBS detected (0x000000ff)
> [    1.227466] futex hash table entries: 512 (order: 3, 32768 bytes)
> [    1.227597] audit: initializing netlink subsys (disabled)
> [    1.227651] audit: type=2000 audit(1426720387.124:1): initialized
> [    1.228722] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    1.229569] VFS: Disk quotas dquot_6.5.2
> [    1.229685] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    1.229927] msgmni has been set to 3955
> [    1.231900] alg: No test for stdrng (krng)
> [    1.232080] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
> [    1.232243] io scheduler noop registered
> [    1.232253] io scheduler deadline registered
> [    1.232289] io scheduler cfq registered (default)
> [    1.232947] pcieport 0000:00:04.0: irq 24 for MSI/MSI-X
> [    1.233367] pcieport 0000:00:05.0: irq 25 for MSI/MSI-X
> [    1.233760] pcieport 0000:00:06.0: irq 26 for MSI/MSI-X
> [    1.234249] pcieport 0000:00:15.0: irq 27 for MSI/MSI-X
> [    1.234545] pcieport 0000:00:04.0: Signaling PME through PCIe PME interrupt
> [    1.234553] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    1.234563] pcie_pme 0000:00:04.0:pcie01: service driver pcie_pme loaded
> [    1.234608] pcieport 0000:00:05.0: Signaling PME through PCIe PME interrupt
> [    1.234615] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
> [    1.234624] pcie_pme 0000:00:05.0:pcie01: service driver pcie_pme loaded
> [    1.234764] pcieport 0000:00:06.0: Signaling PME through PCIe PME interrupt
> [    1.234771] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
> [    1.234780] pcie_pme 0000:00:06.0:pcie01: service driver pcie_pme loaded
> [    1.234874] pcieport 0000:00:15.0: Signaling PME through PCIe PME interrupt
> [    1.234885] pcie_pme 0000:00:15.0:pcie01: service driver pcie_pme loaded
> [    1.234945] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    1.235003] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    1.235296] GHES: Failed to enable APEI firmware first mode.
> [    1.235754] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    1.256510] platform serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    1.277429] platform serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [    1.279179] Linux agpgart interface v0.103
> [    1.279537] i8042: PNP: No PS/2 controller found. Probing ports directly.
> [    2.222762] tsc: Refined TSC clocksource calibration: 999.999 MHz
> [    3.186350] i8042: No controller found
> [    3.190725] mousedev: PS/2 mouse device common for all mice
> [    3.190873] rtc_cmos 00:00: RTC can wake from S4
> [    3.191382] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
> [    3.191492] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram, hpet irqs
> [    3.191559] AMD IOMMUv2 driver by Joerg Roedel <joerg.roedel@amd.com>
> [    3.191563] AMD IOMMUv2 functionality not available on this system
> [    3.191865] TCP: cubic registered
> [    3.192043] NET: Registered protocol family 10
> [    3.192849] mip6: Mobile IPv6
> [    3.192862] NET: Registered protocol family 17
> [    3.192881] mpls_gso: MPLS GSO support
> [    3.194404] registered taskstats version 1
> [    3.195813] rtc_cmos 00:00: setting system clock to 2015-03-18 23:13:09 UTC (1426720389)
> [    3.195994] PM: Hibernation image not present or could not be loaded.
> [    3.199265] Freeing unused kernel memory: 1020K (ffffffff818c1000 - ffffffff819c0000)
> [    3.199278] Write protecting the kernel read-only data: 8192k
> [    3.207069] Freeing unused kernel memory: 904K (ffff88000151e000 - ffff880001600000)
> [    3.209719] Freeing unused kernel memory: 320K (ffff8800017b0000 - ffff880001800000)
> [    3.222989] Switched to clocksource tsc
> [    3.454462] udevd[64]: starting version 175
> [    3.512851] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    3.513260] r8169 0000:01:00.0: irq 28 for MSI/MSI-X
> [    3.513764] r8169 0000:01:00.0 eth0: RTL8168e/8111e at 0xffffc90000002000, 00:0d:b9:33:09:88, XID 0c200000 IRQ 28
> [    3.513774] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [    3.558350] ACPI: bus type USB registered
> [    3.558450] usbcore: registered new interface driver usbfs
> [    3.558492] usbcore: registered new interface driver hub
> [    3.560978] SCSI subsystem initialized
> [    3.567251] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    3.567688] r8169 0000:02:00.0: irq 29 for MSI/MSI-X
> [    3.568252] r8169 0000:02:00.0 eth1: RTL8168e/8111e at 0xffffc90000324000, 00:0d:b9:33:09:89, XID 0c200000 IRQ 29
> [    3.568261] r8169 0000:02:00.0 eth1: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [    3.568311] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    3.568593] r8169 0000:03:00.0: irq 30 for MSI/MSI-X
> [    3.569012] r8169 0000:03:00.0 eth2: RTL8168e/8111e at 0xffffc900003a6000, 00:0d:b9:33:09:8a, XID 0c200000 IRQ 30
> [    3.569021] r8169 0000:03:00.0 eth2: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [    3.581041] usbcore: registered new device driver usb
> [    3.582374] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    3.582992] ehci-pci: EHCI PCI platform driver
> [    3.583499] QUIRK: Enable AMD PLL fix
> [    3.583609] ehci-pci 0000:00:12.2: EHCI Host Controller
> [    3.583635] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
> [    3.583653] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    3.583721] ehci-pci 0000:00:12.2: debug port 1
> [    3.583816] ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb04400
> [    3.585179] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    3.585669] ohci-pci: OHCI PCI platform driver
> [    3.594797] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
> [    3.594947] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.594955] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.594962] usb usb1: Product: EHCI Host Controller
> [    3.594968] usb usb1: Manufacturer: Linux 3.18.0-rc5-ecknn+ ehci_hcd
> [    3.594975] usb usb1: SerialNumber: 0000:00:12.2
> [    3.595462] hub 1-0:1.0: USB hub found
> [    3.595490] hub 1-0:1.0: 5 ports detected
> [    3.596524] ehci-pci 0000:00:13.2: EHCI Host Controller
> [    3.596546] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
> [    3.596564] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    3.596632] ehci-pci 0000:00:13.2: debug port 1
> [    3.596698] ehci-pci 0000:00:13.2: irq 17, io mem 0xfeb04500
> [    3.606767] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
> [    3.606902] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.606911] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.606917] usb usb2: Product: EHCI Host Controller
> [    3.606923] usb usb2: Manufacturer: Linux 3.18.0-rc5-ecknn+ ehci_hcd
> [    3.606929] usb usb2: SerialNumber: 0000:00:13.2
> [    3.607452] hub 2-0:1.0: USB hub found
> [    3.607489] hub 2-0:1.0: 5 ports detected
> [    3.608482] ehci-pci 0000:00:16.2: EHCI Host Controller
> [    3.608504] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 3
> [    3.608522] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    3.608590] ehci-pci 0000:00:16.2: debug port 1
> [    3.608661] ehci-pci 0000:00:16.2: irq 17, io mem 0xfeb04600
> [    3.608790] libata version 3.00 loaded.
> [    3.618954] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
> [    3.619121] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.619130] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.619138] usb usb3: Product: EHCI Host Controller
> [    3.619144] usb usb3: Manufacturer: Linux 3.18.0-rc5-ecknn+ ehci_hcd
> [    3.619151] usb usb3: SerialNumber: 0000:00:16.2
> [    3.619554] hub 3-0:1.0: USB hub found
> [    3.619586] hub 3-0:1.0: 4 ports detected
> [    3.620539] ohci-pci 0000:00:12.0: OHCI PCI host controller
> [    3.620565] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
> [    3.620764] ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb00000
> [    3.679415] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.679429] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.679436] usb usb4: Product: OHCI PCI host controller
> [    3.679443] usb usb4: Manufacturer: Linux 3.18.0-rc5-ecknn+ ohci_hcd
> [    3.679449] usb usb4: SerialNumber: 0000:00:12.0
> [    3.680155] hub 4-0:1.0: USB hub found
> [    3.680233] hub 4-0:1.0: 5 ports detected
> [    3.681213] ohci-pci 0000:00:13.0: OHCI PCI host controller
> [    3.681235] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
> [    3.681356] ohci-pci 0000:00:13.0: irq 18, io mem 0xfeb01000
> [    3.738957] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.738971] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.738978] usb usb5: Product: OHCI PCI host controller
> [    3.738984] usb usb5: Manufacturer: Linux 3.18.0-rc5-ecknn+ ohci_hcd
> [    3.738990] usb usb5: SerialNumber: 0000:00:13.0
> [    3.739663] hub 5-0:1.0: USB hub found
> [    3.739746] hub 5-0:1.0: 5 ports detected
> [    3.740692] ohci-pci 0000:00:14.5: OHCI PCI host controller
> [    3.740713] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
> [    3.740837] ohci-pci 0000:00:14.5: irq 18, io mem 0xfeb02000
> [    3.799124] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.799138] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.799146] usb usb6: Product: OHCI PCI host controller
> [    3.799152] usb usb6: Manufacturer: Linux 3.18.0-rc5-ecknn+ ohci_hcd
> [    3.799158] usb usb6: SerialNumber: 0000:00:14.5
> [    3.799838] hub 6-0:1.0: USB hub found
> [    3.799880] hub 6-0:1.0: 2 ports detected
> [    3.800698] ohci-pci 0000:00:16.0: OHCI PCI host controller
> [    3.800723] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
> [    3.800839] ohci-pci 0000:00:16.0: irq 18, io mem 0xfeb03000
> [    3.859094] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.859108] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.859115] usb usb7: Product: OHCI PCI host controller
> [    3.859122] usb usb7: Manufacturer: Linux 3.18.0-rc5-ecknn+ ohci_hcd
> [    3.859128] usb usb7: SerialNumber: 0000:00:16.0
> [    3.859827] hub 7-0:1.0: USB hub found
> [    3.859911] hub 7-0:1.0: 4 ports detected
> [    3.864347] scsi host0: pata_atiixp
> [    3.864674] scsi host1: pata_atiixp
> [    3.864825] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4010 irq 14
> [    3.864833] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x4018 irq 15
> [    3.864914] ahci 0000:00:11.0: version 3.0
> [    3.865617] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
> [    3.865628] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led clo pmp pio slum part 
> [    3.869627] scsi host2: ahci
> [    3.869945] scsi host3: ahci
> [    3.870203] scsi host4: ahci
> [    3.873498] scsi host5: ahci
> [    3.873794] ata3: SATA max UDMA/133 abar m1024@0xfeb04000 port 0xfeb04100 irq 19
> [    3.873803] ata4: SATA max UDMA/133 abar m1024@0xfeb04000 port 0xfeb04180 irq 19
> [    3.873811] ata5: SATA max UDMA/133 abar m1024@0xfeb04000 port 0xfeb04200 irq 19
> [    3.873818] ata6: SATA max UDMA/133 abar m1024@0xfeb04000 port 0xfeb04280 irq 19
> [    3.906984] usb 1-2: new high-speed USB device number 2 using ehci-pci
> [    3.930926] usb 3-1: new high-speed USB device number 2 using ehci-pci
> [    4.066150] usb 3-1: New USB device found, idVendor=058f, idProduct=6366
> [    4.066166] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    4.066175] usb 3-1: Product: Flash Card Reader/Writer
> [    4.066182] usb 3-1: Manufacturer: Generic
> [    4.066190] usb 3-1: SerialNumber: 058F63666485
> [    4.074619] usb-storage 3-1:1.0: USB Mass Storage device detected
> [    4.075328] scsi host6: usb-storage 3-1:1.0
> [    4.075600] usbcore: registered new interface driver usb-storage
> [    4.129494] usb 1-2: New USB device found, idVendor=413c, idProduct=8147
> [    4.129512] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    4.129519] usb 1-2: Product: Dell Wireless 5530 HSPA Mobile Broadband Minicard Device
> [    4.129526] usb 1-2: Manufacturer: Dell
> [    4.129531] usb 1-2: SerialNumber: 3558620263894800
> [    4.194804] ata5: SATA link down (SStatus 0 SControl 300)
> [    4.194878] ata4: SATA link down (SStatus 0 SControl 300)
> [    4.198716] ata6: SATA link down (SStatus 0 SControl 300)
> [    4.362945] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    4.378379] ata3.00: ATA-8: KINGSTON SMS200S330G, 524ABBF0, max UDMA/133
> [    4.378392] ata3.00: 58626288 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
> [    4.389434] ata3.00: configured for UDMA/133
> [    4.390114] scsi 2:0:0:0: Direct-Access     ATA      KINGSTON SMS200S BBF0 PQ: 0 ANSI: 5
> [    4.405962] sd 2:0:0:0: [sda] 58626288 512-byte logical blocks: (30.0 GB/27.9 GiB)
> [    4.406235] sd 2:0:0:0: [sda] Write Protect is off
> [    4.406244] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    4.406309] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    4.407464]  sda: sda1 sda2 < sda5 >
> [    4.409236] sd 2:0:0:0: [sda] Attached SCSI disk
> [    4.414501] sd 2:0:0:0: Attached scsi generic sg0 type 0
> [    4.518154] device-mapper: uevent: version 1.0.3
> [    4.518402] device-mapper: ioctl: 4.28.0-ioctl (2014-09-17) initialised: dm-devel@redhat.com
> [    4.554220] PM: Starting manual resume from disk
> [    4.554235] PM: Hibernation image partition 8:5 present
> [    4.554239] PM: Looking for hibernation image.
> [    4.554869] PM: Image not found (code -22)
> [    4.554880] PM: Hibernation image not present or could not be loaded.
> [    4.581868] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
> [    5.076201] scsi 6:0:0:0: Direct-Access     Multiple Card  Reader     1.00 PQ: 0 ANSI: 4
> [    5.077055] sd 6:0:0:0: Attached scsi generic sg1 type 0
> [    5.079682] sd 6:0:0:0: [sdb] Attached SCSI removable disk
> [    5.247164] udevd[381]: starting version 175
> [    5.416864] ACPI: acpi_idle registered with cpuidle
> [    5.422612] acpi-cpufreq: overriding BIOS provided _PSD data
> [    5.434449] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    5.434468] ACPI: Power Button [PWRB]
> [    5.438763] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> [    5.438781] ACPI: Power Button [PWRF]
> [    5.664499] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
> [    5.664629] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
> [    5.682154] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> [    5.682332] sp5100_tco: PCI Revision ID: 0x42
> [    5.682440] sp5100_tco: Using 0xfed80b00 for watchdog MMIO address
> [    5.682456] sp5100_tco: Last reboot was not triggered by watchdog.
> [    5.683916] sp5100_tco: initialized (0xffffc900003acb00). heartbeat=60 sec (nowayout=0)
> [    5.795509] kvm: Nested Virtualization enabled
> [    5.795526] kvm: Nested Paging enabled
> [    5.831177] cdc_wdm 1-2:1.5: cdc-wdm0: USB WDM device
> [    5.837977] cdc_wdm 1-2:1.6: cdc-wdm1: USB WDM device
> [    5.839706] usbcore: registered new interface driver cdc_wdm
> [    5.847848] cdc_acm 1-2:1.1: ttyACM0: USB ACM device
> [    5.855668] cdc_acm 1-2:1.3: ttyACM1: USB ACM device
> [    5.859287] cdc_acm 1-2:1.9: ttyACM2: USB ACM device
> [    5.861256] usbcore: registered new interface driver cdc_acm
> [    5.861266] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> [    5.878982] cdc_ether 1-2:1.7 wwan0: register 'cdc_ether' at usb-0000:00:12.2-2, Mobile Broadband Network Device, 02:80:37:ec:02:00
> [    5.879070] usbcore: registered new interface driver cdc_ether
> [    6.930838] Adding 1239036k swap on /dev/sda5.  Priority:-1 extents:1 across:1239036k SS
> [    6.985588] EXT4-fs (sda1): re-mounted. Opts: (null)
> [    7.105269] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
> [    7.426984] loop: module loaded
> [    7.439217] random: vgscan urandom read with 34 bits of entropy available
> [   10.262511] r8169 0000:02:00.0 eth1: link down
> [   10.262777] r8169 0000:02:00.0 eth1: link down
> [   10.265512] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
> [   11.159247] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   11.189846] ip6_tables: (C) 2000-2006 Netfilter Core Team
> [   11.220361] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
> [   11.227647] Bridge firewalling registered
> [   11.263297] device eth0 entered promiscuous mode
> [   11.268487] device eth2 entered promiscuous mode
> [   11.418374] r8169 0000:01:00.0 eth0: link down
> [   11.418461] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   11.562493] r8169 0000:03:00.0 eth2: link down
> [   11.562579] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
> [   11.566241] IPv6: ADDRCONF(NETDEV_UP): br0: link is not ready
> [   12.605804] r8169 0000:02:00.0 eth1: link up
> [   12.605832] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> 
> --------------000809080900050004000900
> Content-Type: text/plain; charset=windows-1252;
>  name="dmesg_4.0.0-rc4.txt"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: attachment;
>  filename="dmesg_4.0.0-rc4.txt"
> 
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 4.0.0-rc4 (root@kalipool07) (gcc version 4.7.2 (Debian 4.7.2-5) ) #1 SMP Wed Mar 18 23:48:21 CET 2015
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.0.0-rc4 root=UUID=0a8a0627-f77c-4195-b43b-e6f6d879a3b1 ro console=ttyS0,115200n8 console=ttyS0,115200n8 quiet
> [    0.000000] tseg: 0000000000
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007e16ebff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007e16ec00-0x000000007efffbff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000f8ffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.7 present.
> [    0.000000] DMI: PC Engines APU, BIOS unknown 12/24/2013
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] AGP: No AGP bridge found
> [    0.000000] e820: last_pfn = 0x7e16e max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-FFFFF write-back
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 000000000 mask F80000000 write-back
> [    0.000000]   1 base 07F000000 mask FFF000000 uncachable
> [    0.000000]   2 disabled
> [    0.000000]   3 disabled
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 base 0FFE00000 mask FFFE00000 write-protect
> [    0.000000]   7 disabled
> [    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
> [    0.000000] found SMP MP-table at [mem 0x000fda10-0x000fda1f] mapped at [ffff8800000fda10]
> [    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
> [    0.000000] Using GB pages for direct mapping
> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> [    0.000000] BRK [0x01a8a000, 0x01a8afff] PGTABLE
> [    0.000000] BRK [0x01a8b000, 0x01a8bfff] PGTABLE
> [    0.000000] BRK [0x01a8c000, 0x01a8cfff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x7de00000-0x7dffffff]
> [    0.000000]  [mem 0x7de00000-0x7dffffff] page 2M
> [    0.000000] BRK [0x01a8d000, 0x01a8dfff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x60000000-0x7ddfffff]
> [    0.000000]  [mem 0x60000000-0x7ddfffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x40000000-0x5fffffff]
> [    0.000000]  [mem 0x40000000-0x5fffffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x00100000-0x3fffffff]
> [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
> [    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x7e000000-0x7e16dfff]
> [    0.000000]  [mem 0x7e000000-0x7e16dfff] page 4k
> [    0.000000] BRK [0x01a8e000, 0x01a8efff] PGTABLE
> [    0.000000] RAMDISK: [mem 0x3631a000-0x37184fff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000FD9F0 000014 (v00 CORE  )
> [    0.000000] ACPI: RSDT 0x000000007E171024 000040 (v01 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: FACP 0x000000007E173A20 0000F4 (v04 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: DSDT 0x000000007E1710C8 002915 (v02 PCENG  APU      00010001 INTL 20121114)
> [    0.000000] ACPI: FACS 0x000000007E1739E0 000040
> [    0.000000] ACPI: HPET 0x000000007E173B18 000038 (v01 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: APIC 0x000000007E173B50 00005C (v01 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: HEST 0x000000007E173BB0 000198 (v01 CORE   COREBOOT 00000000 CORE 00000000)
> [    0.000000] ACPI: SSDT 0x000000007E173D50 00168E (v02 AMD    ALIB     00000001 MSFT 04000000)
> [    0.000000] ACPI: SSDT 0x000000007E1753E0 00030C (v01 AMD    POWERNOW 00000001 AMD  00000001)
> [    0.000000] ACPI: SSDT 0x000000007E1756F0 000045 (v02 CORE   COREBOOT 0000002A CORE 0000002A)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000007e16dfff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x7e16a000-0x7e16dfff]
> [    0.000000]  [ffffea0000000000-ffffea0001ffffff] PMD -> [ffff88007b800000-ffff88007d7fffff] on node 0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x000000007e16dfff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000007e16dfff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007e16dfff]
> [    0.000000] On node 0 totalpages: 516364
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3998 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 8006 pages used for memmap
> [    0.000000]   DMA32 zone: 512366 pages, LIFO batch:31
> [    0.000000] ACPI: PM-Timer IO Port: 0x808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x43538210 base: 0xfed00000
> [    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> [    0.000000] e820: [mem 0x7efffc00-0xf7ffffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 31 pages/cpu @ffff88007de00000 s86040 r8192 d32744 u1048576
> [    0.000000] pcpu-alloc: s86040 r8192 d32744 u1048576 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 0 1 
> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 508273
> [    0.000000] Policy zone: DMA32
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.0.0-rc4 root=UUID=0a8a0627-f77c-4195-b43b-e6f6d879a3b1 ro console=ttyS0,115200n8 console=ttyS0,115200n8 quiet
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] AGP: Checking aperture...
> [    0.000000] AGP: No AGP bridge found
> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [    0.000000] Memory: 2006508K/2065456K available (5266K kernel code, 740K rwdata, 1760K rodata, 1020K init, 808K bss, 58948K reserved, 0K cma-reserved)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=2.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> [    0.000000] NR_IRQS:33024 nr_irqs:440 16
> [    0.000000] spurious 8259A interrupt: IRQ7.
> [    0.000000] Console: colour dummy device 80x25
> [    0.000000] console [ttyS0] enabled
> [    0.000000] hpet clockevent registered
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 1000.039 MHz processor
> [    0.000073] Calibrating delay loop (skipped), value calculated using timer frequency.. 2000.07 BogoMIPS (lpj=4000156)
> [    0.000082] pid_max: default: 32768 minimum: 301
> [    0.000106] ACPI: Core revision 20150204
> [    0.008589] ACPI: All ACPI Tables successfully acquired
> [    0.008689] Security Framework initialized
> [    0.008701] AppArmor: AppArmor disabled by boot time parameter
> [    0.008705] Yama: becoming mindful.
> [    0.009174] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.011321] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> [    0.012275] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.012293] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.012987] Initializing cgroup subsys blkio
> [    0.013004] Initializing cgroup subsys memory
> [    0.013034] Initializing cgroup subsys devices
> [    0.013043] Initializing cgroup subsys freezer
> [    0.013052] Initializing cgroup subsys net_cls
> [    0.013063] Initializing cgroup subsys perf_event
> [    0.013129] CPU: Physical Processor ID: 0
> [    0.013133] CPU: Processor Core ID: 0
> [    0.013138] mce: CPU supports 6 MCE banks
> [    0.013162] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 4
> [    0.013166] Last level dTLB entries: 4KB 512, 2MB 8, 4MB 4, 1GB 0
> [    0.013437] Freeing SMP alternatives memory: 20K (ffffffff819b9000 - ffffffff819be000)
> [    0.017455] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
> [    0.161902] smpboot: CPU0: AMD G-T40E Processor (fam: 14, model: 02, stepping: 00)
> [    0.161970] Performance Events: AMD PMU driver.
> [    0.161984] ... version:                0
> [    0.161988] ... bit width:              48
> [    0.161992] ... generic registers:      4
> [    0.161996] ... value mask:             0000ffffffffffff
> [    0.162000] ... max period:             00007fffffffffff
> [    0.162003] ... fixed-purpose events:   0
> [    0.162007] ... event mask:             000000000000000f
> [    0.162735] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> [    0.163051] x86: Booting SMP configuration:
> [    0.163057] .... node  #0, CPUs:      #1
> [    0.176236] x86: Booted up 1 node, 2 CPUs
> [    0.176244] smpboot: Total of 2 processors activated (4000.15 BogoMIPS)
> [    0.177475] devtmpfs: initialized
> [    0.192959] NET: Registered protocol family 16
> [    0.204538] cpuidle: using governor ladder
> [    0.214182] cpuidle: using governor menu
> [    0.214565] ACPI: bus type PCI registered
> [    0.214573] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.214935] PCI: Using configuration type 1 for base access
> [    0.214940] PCI: Using configuration type 1 for extended access
> [    0.230492] ACPI: Added _OSI(Module Device)
> [    0.230504] ACPI: Added _OSI(Processor Device)
> [    0.230509] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.230514] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.233872] ACPI: Executed 2 blocks of module-level executable AML code
> [    0.241333] ACPI: Interpreter enabled
> [    0.241401] ACPI: (supports S0 S1 S2 S3 S4 S5)
> [    0.241407] ACPI: Using IOAPIC for interrupt routing
> [    0.241463] HEST: Table parsing has been initialized.
> [    0.241472] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.252959] acpi LNXCPU:01: Invalid PBLK length [0]
> [    0.258233] ACPI: PCI Interrupt Link [INTA] (IRQs 3 4 5 7 10 11 12 15) *0
> [    0.258498] ACPI: PCI Interrupt Link [INTB] (IRQs 3 4 5 7 10 11 12 15) *0
> [    0.258755] ACPI: PCI Interrupt Link [INTC] (IRQs 3 4 5 7 10 11 12 15) *0
> [    0.259010] ACPI: PCI Interrupt Link [INTD] (IRQs 3 4 5 7 10 11 12 15) *0
> [    0.259263] ACPI: PCI Interrupt Link [INTE] (IRQs 3 4 5 7 10 11 12 15) *0
> [    0.259517] ACPI: PCI Interrupt Link [INTF] (IRQs 9) *0
> [    0.259763] ACPI: PCI Interrupt Link [INTG] (IRQs 3 4 5 7 10 11 12 15) *0
> [    0.260015] ACPI: PCI Interrupt Link [INTH] (IRQs 3 4 5 7 10 11 12 15) *0
> [    0.260240] acpi PNP0A03:00: [Firmware Bug]: no secondary bus range in _CRS
> [    0.260267] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.260283] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.260523] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> [    0.261381] PCI host bridge to bus 0000:00
> [    0.261392] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.261400] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.261407] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.261429] pci 0000:00:00.0: [1022:1510] type 00 class 0x060000
> [    0.261803] pci 0000:00:04.0: [1022:1512] type 01 class 0x060400
> [    0.261933] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
> [    0.262087] pci 0000:00:04.0: System wakeup disabled by ACPI
> [    0.262237] pci 0000:00:05.0: [1022:1513] type 01 class 0x060400
> [    0.262350] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
> [    0.262497] pci 0000:00:05.0: System wakeup disabled by ACPI
> [    0.262641] pci 0000:00:06.0: [1022:1514] type 01 class 0x060400
> [    0.262754] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
> [    0.262901] pci 0000:00:06.0: System wakeup disabled by ACPI
> [    0.263110] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
> [    0.263145] pci 0000:00:11.0: reg 0x10: [io  0x4020-0x4027]
> [    0.263164] pci 0000:00:11.0: reg 0x14: [io  0x4040-0x4043]
> [    0.263182] pci 0000:00:11.0: reg 0x18: [io  0x4028-0x402f]
> [    0.263199] pci 0000:00:11.0: reg 0x1c: [io  0x4044-0x4047]
> [    0.263217] pci 0000:00:11.0: reg 0x20: [io  0x4000-0x400f]
> [    0.263236] pci 0000:00:11.0: reg 0x24: [mem 0xfeb08000-0xfeb083ff]
> [    0.263602] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
> [    0.263628] pci 0000:00:12.0: reg 0x10: [mem 0xfeb04000-0xfeb04fff]
> [    0.263853] pci 0000:00:12.0: System wakeup disabled by ACPI
> [    0.264048] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
> [    0.264082] pci 0000:00:12.2: reg 0x10: [mem 0xfeb08400-0xfeb084ff]
> [    0.264220] pci 0000:00:12.2: supports D1 D2
> [    0.264226] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
> [    0.264370] pci 0000:00:12.2: System wakeup disabled by ACPI
> [    0.264565] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
> [    0.264590] pci 0000:00:13.0: reg 0x10: [mem 0xfeb05000-0xfeb05fff]
> [    0.264815] pci 0000:00:13.0: System wakeup disabled by ACPI
> [    0.265012] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
> [    0.265045] pci 0000:00:13.2: reg 0x10: [mem 0xfeb08500-0xfeb085ff]
> [    0.265182] pci 0000:00:13.2: supports D1 D2
> [    0.265188] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
> [    0.265337] pci 0000:00:13.2: System wakeup disabled by ACPI
> [    0.265529] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
> [    0.265929] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
> [    0.265955] pci 0000:00:14.1: reg 0x10: [io  0x4030-0x4037]
> [    0.265973] pci 0000:00:14.1: reg 0x14: [io  0x4048-0x404b]
> [    0.265991] pci 0000:00:14.1: reg 0x18: [io  0x4038-0x403f]
> [    0.266008] pci 0000:00:14.1: reg 0x1c: [io  0x404c-0x404f]
> [    0.266026] pci 0000:00:14.1: reg 0x20: [io  0x4010-0x401f]
> [    0.266060] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [    0.266066] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    0.266072] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [    0.266078] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    0.266434] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
> [    0.266829] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
> [    0.267026] pci 0000:00:14.4: System wakeup disabled by ACPI
> [    0.267210] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
> [    0.267235] pci 0000:00:14.5: reg 0x10: [mem 0xfeb06000-0xfeb06fff]
> [    0.267467] pci 0000:00:14.5: System wakeup disabled by ACPI
> [    0.267664] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
> [    0.267805] pci 0000:00:15.0: supports D1 D2
> [    0.267955] pci 0000:00:15.0: System wakeup disabled by ACPI
> [    0.268139] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
> [    0.268165] pci 0000:00:16.0: reg 0x10: [mem 0xfeb07000-0xfeb07fff]
> [    0.268391] pci 0000:00:16.0: System wakeup disabled by ACPI
> [    0.268588] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
> [    0.268622] pci 0000:00:16.2: reg 0x10: [mem 0xfeb08600-0xfeb086ff]
> [    0.268759] pci 0000:00:16.2: supports D1 D2
> [    0.268765] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
> [    0.268909] pci 0000:00:16.2: System wakeup disabled by ACPI
> [    0.269107] pci 0000:00:18.0: [1022:1700] type 00 class 0x060000
> [    0.269393] pci 0000:00:18.1: [1022:1701] type 00 class 0x060000
> [    0.269672] pci 0000:00:18.2: [1022:1702] type 00 class 0x060000
> [    0.269965] pci 0000:00:18.3: [1022:1703] type 00 class 0x060000
> [    0.270262] pci 0000:00:18.4: [1022:1704] type 00 class 0x060000
> [    0.270543] pci 0000:00:18.5: [1022:1718] type 00 class 0x060000
> [    0.270820] pci 0000:00:18.6: [1022:1716] type 00 class 0x060000
> [    0.271094] pci 0000:00:18.7: [1022:1719] type 00 class 0x060000
> [    0.271583] pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000
> [    0.271613] pci 0000:01:00.0: reg 0x10: [io  0x1000-0x10ff]
> [    0.271651] pci 0000:01:00.0: reg 0x18: [mem 0xfe600000-0xfe600fff 64bit]
> [    0.271676] pci 0000:01:00.0: reg 0x20: [mem 0xfe500000-0xfe503fff 64bit pref]
> [    0.271806] pci 0000:01:00.0: supports D1 D2
> [    0.271813] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.278150] pci 0000:00:04.0: PCI bridge to [bus 01]
> [    0.278172] pci 0000:00:04.0:   bridge window [io  0x1000-0x1fff]
> [    0.278182] pci 0000:00:04.0:   bridge window [mem 0xfe600000-0xfe6fffff]
> [    0.278195] pci 0000:00:04.0:   bridge window [mem 0xfe500000-0xfe5fffff 64bit pref]
> [    0.278421] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
> [    0.278455] pci 0000:02:00.0: reg 0x10: [io  0x2000-0x20ff]
> [    0.278493] pci 0000:02:00.0: reg 0x18: [mem 0xfe800000-0xfe800fff 64bit]
> [    0.278519] pci 0000:02:00.0: reg 0x20: [mem 0xfe700000-0xfe703fff 64bit pref]
> [    0.278670] pci 0000:02:00.0: supports D1 D2
> [    0.278677] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.286149] pci 0000:00:05.0: PCI bridge to [bus 02]
> [    0.286172] pci 0000:00:05.0:   bridge window [io  0x2000-0x2fff]
> [    0.286182] pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe8fffff]
> [    0.286195] pci 0000:00:05.0:   bridge window [mem 0xfe700000-0xfe7fffff 64bit pref]
> [    0.286421] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
> [    0.286455] pci 0000:03:00.0: reg 0x10: [io  0x3000-0x30ff]
> [    0.286493] pci 0000:03:00.0: reg 0x18: [mem 0xfea00000-0xfea00fff 64bit]
> [    0.286519] pci 0000:03:00.0: reg 0x20: [mem 0xfe900000-0xfe903fff 64bit pref]
> [    0.286670] pci 0000:03:00.0: supports D1 D2
> [    0.286677] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.294149] pci 0000:00:06.0: PCI bridge to [bus 03]
> [    0.294171] pci 0000:00:06.0:   bridge window [io  0x3000-0x3fff]
> [    0.294181] pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
> [    0.294194] pci 0000:00:06.0:   bridge window [mem 0xfe900000-0xfe9fffff 64bit pref]
> [    0.294257] pci 0000:00:14.4: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.294529] pci 0000:00:15.0: PCI bridge to [bus 04]
> [    0.294780] pci 0000:00:14.4: PCI bridge to [bus 05-ff] (subtractive decode)
> [    0.294794] pci 0000:00:14.4:   bridge window [mem 0x00000000-0x000fffff]
> [    0.294804] pci 0000:00:14.4:   bridge window [mem 0x00000000-0x000fffff pref]
> [    0.294812] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
> [    0.294819] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
> [    0.294827] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
> [    0.296048] ACPI: Enabled 6 GPEs in block 00 to 1F
> [    0.296671] vgaarb: loaded
> [    0.297149] PCI: Using ACPI for IRQ routing
> [    0.297165] PCI: pci_cache_line_size set to 64 bytes
> [    0.297182] pci 0000:00:04.0: can't claim BAR 14 [mem 0xfe600000-0xfe6fffff]: no compatible bridge window
> [    0.297192] pci 0000:00:04.0: can't claim BAR 15 [mem 0xfe500000-0xfe5fffff 64bit pref]: no compatible bridge window
> [    0.297202] pci 0000:00:05.0: can't claim BAR 14 [mem 0xfe800000-0xfe8fffff]: no compatible bridge window
> [    0.297210] pci 0000:00:05.0: can't claim BAR 15 [mem 0xfe700000-0xfe7fffff 64bit pref]: no compatible bridge window
> [    0.297218] pci 0000:00:06.0: can't claim BAR 14 [mem 0xfea00000-0xfeafffff]: no compatible bridge window
> [    0.297226] pci 0000:00:06.0: can't claim BAR 15 [mem 0xfe900000-0xfe9fffff 64bit pref]: no compatible bridge window
> [    0.297243] pci 0000:01:00.0: can't claim BAR 2 [mem 0xfe600000-0xfe600fff 64bit]: no compatible bridge window
> [    0.297253] pci 0000:01:00.0: can't claim BAR 4 [mem 0xfe500000-0xfe503fff 64bit pref]: no compatible bridge window
> [    0.297265] pci 0000:02:00.0: can't claim BAR 2 [mem 0xfe800000-0xfe800fff 64bit]: no compatible bridge window
> [    0.297273] pci 0000:02:00.0: can't claim BAR 4 [mem 0xfe700000-0xfe703fff 64bit pref]: no compatible bridge window
> [    0.297285] pci 0000:03:00.0: can't claim BAR 2 [mem 0xfea00000-0xfea00fff 64bit]: no compatible bridge window
> [    0.297296] pci 0000:03:00.0: can't claim BAR 4 [mem 0xfe900000-0xfe903fff 64bit pref]: no compatible bridge window
> [    0.297355] pci 0000:00:11.0: can't claim BAR 5 [mem 0xfeb08000-0xfeb083ff]: no compatible bridge window
> [    0.297365] pci 0000:00:12.0: can't claim BAR 0 [mem 0xfeb04000-0xfeb04fff]: no compatible bridge window
> [    0.297376] pci 0000:00:12.2: can't claim BAR 0 [mem 0xfeb08400-0xfeb084ff]: no compatible bridge window
> [    0.297386] pci 0000:00:13.0: can't claim BAR 0 [mem 0xfeb05000-0xfeb05fff]: no compatible bridge window
> [    0.297396] pci 0000:00:13.2: can't claim BAR 0 [mem 0xfeb08500-0xfeb085ff]: no compatible bridge window
> [    0.297419] pci 0000:00:14.5: can't claim BAR 0 [mem 0xfeb06000-0xfeb06fff]: no compatible bridge window
> [    0.297432] pci 0000:00:16.0: can't claim BAR 0 [mem 0xfeb07000-0xfeb07fff]: no compatible bridge window
> [    0.297443] pci 0000:00:16.2: can't claim BAR 0 [mem 0xfeb08600-0xfeb086ff]: no compatible bridge window
> [    0.297508] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> [    0.297515] e820: reserve RAM buffer [mem 0x7e16ec00-0x7fffffff]
> [    0.298086] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.298098] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [    0.300395] Switched to clocksource hpet
> [    0.307246] pnp: PnP ACPI init
> [    0.308354] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.308427] pnp: PnP ACPI: found 1 devices
> [    0.327676] pci 0000:00:04.0: BAR 14: no space for [mem size 0x00100000]
> [    0.327693] pci 0000:00:04.0: BAR 14: failed to assign [mem size 0x00100000]
> [    0.327703] pci 0000:00:04.0: BAR 15: no space for [mem size 0x00100000 64bit pref]
> [    0.327711] pci 0000:00:04.0: BAR 15: failed to assign [mem size 0x00100000 64bit pref]
> [    0.327719] pci 0000:00:05.0: BAR 14: no space for [mem size 0x00100000]
> [    0.327726] pci 0000:00:05.0: BAR 14: failed to assign [mem size 0x00100000]
> [    0.327734] pci 0000:00:05.0: BAR 15: no space for [mem size 0x00100000 64bit pref]
> [    0.327741] pci 0000:00:05.0: BAR 15: failed to assign [mem size 0x00100000 64bit pref]
> [    0.327749] pci 0000:00:06.0: BAR 14: no space for [mem size 0x00100000]
> [    0.327755] pci 0000:00:06.0: BAR 14: failed to assign [mem size 0x00100000]
> [    0.327763] pci 0000:00:06.0: BAR 15: no space for [mem size 0x00100000 64bit pref]
> [    0.327769] pci 0000:00:06.0: BAR 15: failed to assign [mem size 0x00100000 64bit pref]
> [    0.327777] pci 0000:00:12.0: BAR 0: no space for [mem size 0x00001000]
> [    0.327784] pci 0000:00:12.0: BAR 0: trying firmware assignment [mem size 0x00001000]
> [    0.327793] pci 0000:00:12.0: BAR 0: assigned [mem 0xfeb04000-0xfeb04fff]
> [    0.327852] pci 0000:00:13.0: BAR 0: no space for [mem size 0x00001000]
> [    0.327859] pci 0000:00:13.0: BAR 0: trying firmware assignment [mem size 0x00001000]
> [    0.327865] pci 0000:00:13.0: BAR 0: assigned [mem 0xfeb05000-0xfeb05fff]
> [    0.327876] pci 0000:00:14.5: BAR 0: no space for [mem size 0x00001000]
> [    0.327882] pci 0000:00:14.5: BAR 0: trying firmware assignment [mem size 0x00001000]
> [    0.327889] pci 0000:00:14.5: BAR 0: assigned [mem 0xfeb06000-0xfeb06fff]
> [    0.327900] pci 0000:00:16.0: BAR 0: no space for [mem size 0x00001000]
> [    0.327906] pci 0000:00:16.0: BAR 0: trying firmware assignment [mem size 0x00001000]
> [    0.327912] pci 0000:00:16.0: BAR 0: assigned [mem 0xfeb07000-0xfeb07fff]
> [    0.327923] pci 0000:00:11.0: BAR 5: no space for [mem size 0x00000400]
> [    0.327929] pci 0000:00:11.0: BAR 5: trying firmware assignment [mem size 0x00000400]
> [    0.327936] pci 0000:00:11.0: BAR 5: assigned [mem 0xfeb08000-0xfeb083ff]
> [    0.327947] pci 0000:00:12.2: BAR 0: no space for [mem size 0x00000100]
> [    0.327953] pci 0000:00:12.2: BAR 0: trying firmware assignment [mem size 0x00000100]
> [    0.327959] pci 0000:00:12.2: BAR 0: assigned [mem 0xfeb08400-0xfeb084ff]
> [    0.327970] pci 0000:00:13.2: BAR 0: no space for [mem size 0x00000100]
> [    0.327976] pci 0000:00:13.2: BAR 0: trying firmware assignment [mem size 0x00000100]
> [    0.327982] pci 0000:00:13.2: BAR 0: assigned [mem 0xfeb08500-0xfeb085ff]
> [    0.327993] pci 0000:00:16.2: BAR 0: no space for [mem size 0x00000100]
> [    0.328000] pci 0000:00:16.2: BAR 0: trying firmware assignment [mem size 0x00000100]
> [    0.328006] pci 0000:00:16.2: BAR 0: assigned [mem 0xfeb08600-0xfeb086ff]
> [    0.328021] pci 0000:01:00.0: BAR 4: no space for [mem size 0x00004000 64bit pref]
> [    0.328028] pci 0000:01:00.0: BAR 4: trying firmware assignment [mem size 0x00004000 64bit pref]
> [    0.328035] pci 0000:01:00.0: BAR 4: assigned [mem 0xfe500000-0xfe503fff 64bit pref]
> [    0.328054] pci 0000:01:00.0: BAR 2: no space for [mem size 0x00001000 64bit]
> [    0.328061] pci 0000:01:00.0: BAR 2: trying firmware assignment [mem size 0x00001000 64bit]
> [    0.328067] pci 0000:01:00.0: BAR 2: assigned [mem 0xfe600000-0xfe600fff 64bit]
> [    0.328087] pci 0000:00:04.0: PCI bridge to [bus 01]
> [    0.328095] pci 0000:00:04.0:   bridge window [io  0x1000-0x1fff]
> [    0.328115] pci 0000:02:00.0: BAR 4: no space for [mem size 0x00004000 64bit pref]
> [    0.328122] pci 0000:02:00.0: BAR 4: trying firmware assignment [mem size 0x00004000 64bit pref]
> [    0.328129] pci 0000:02:00.0: BAR 4: assigned [mem 0xfe700000-0xfe703fff 64bit pref]
> [    0.328148] pci 0000:02:00.0: BAR 2: no space for [mem size 0x00001000 64bit]
> [    0.328154] pci 0000:02:00.0: BAR 2: trying firmware assignment [mem size 0x00001000 64bit]
> [    0.328161] pci 0000:02:00.0: BAR 2: assigned [mem 0xfe800000-0xfe800fff 64bit]
> [    0.328179] pci 0000:00:05.0: PCI bridge to [bus 02]
> [    0.328186] pci 0000:00:05.0:   bridge window [io  0x2000-0x2fff]
> [    0.328205] pci 0000:03:00.0: BAR 4: no space for [mem size 0x00004000 64bit pref]
> [    0.328212] pci 0000:03:00.0: BAR 4: trying firmware assignment [mem size 0x00004000 64bit pref]
> [    0.328218] pci 0000:03:00.0: BAR 4: assigned [mem 0xfe900000-0xfe903fff 64bit pref]
> [    0.328237] pci 0000:03:00.0: BAR 2: no space for [mem size 0x00001000 64bit]
> [    0.328244] pci 0000:03:00.0: BAR 2: trying firmware assignment [mem size 0x00001000 64bit]
> [    0.328250] pci 0000:03:00.0: BAR 2: assigned [mem 0xfea00000-0xfea00fff 64bit]
> [    0.328328] pci 0000:00:06.0: PCI bridge to [bus 03]
> [    0.328336] pci 0000:00:06.0:   bridge window [io  0x3000-0x3fff]
> [    0.328353] pci 0000:00:14.4: PCI bridge to [bus 05]
> [    0.328375] pci 0000:00:15.0: PCI bridge to [bus 04]
> [    0.328396] pci_bus 0000:00: Some PCI device resources are unassigned, try booting with pci=realloc
> [    0.328404] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.328410] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.328417] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> [    0.328423] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
> [    0.328430] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
> [    0.328437] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7 window]
> [    0.328443] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff window]
> [    0.328658] NET: Registered protocol family 2
> [    0.329181] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> [    0.329351] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
> [    0.329541] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.329660] TCP: reno registered
> [    0.329682] UDP hash table entries: 1024 (order: 3, 32768 bytes)
> [    0.329726] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
> [    0.330065] NET: Registered protocol family 1
> [    0.332601] PCI: CLS 64 bytes, default 64
> [    0.332769] Unpacking initramfs...
> [    1.207463] Freeing initrd memory: 14764K (ffff88003631a000 - ffff880037185000)
> [    1.208453] microcode: CPU0: patch_level=0x05000101
> [    1.208482] microcode: CPU1: patch_level=0x05000101
> [    1.208793] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
> [    1.208818] LVT offset 0 assigned for vector 0x400
> [    1.208946] perf: AMD IBS detected (0x000000ff)
> [    1.210286] futex hash table entries: 512 (order: 3, 32768 bytes)
> [    1.210467] audit: initializing netlink subsys (disabled)
> [    1.210532] audit: type=2000 audit(1426719194.104:1): initialized
> [    1.211808] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    1.212576] VFS: Disk quotas dquot_6.5.2
> [    1.212692] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    1.214563] alg: No test for stdrng (krng)
> [    1.214667] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
> [    1.214812] io scheduler noop registered
> [    1.214822] io scheduler deadline registered
> [    1.214855] io scheduler cfq registered (default)
> [    1.217141] pcieport 0000:00:04.0: Signaling PME through PCIe PME interrupt
> [    1.217149] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    1.217160] pcie_pme 0000:00:04.0:pcie01: service driver pcie_pme loaded
> [    1.217215] pcieport 0000:00:05.0: Signaling PME through PCIe PME interrupt
> [    1.217222] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
> [    1.217231] pcie_pme 0000:00:05.0:pcie01: service driver pcie_pme loaded
> [    1.217274] pcieport 0000:00:06.0: Signaling PME through PCIe PME interrupt
> [    1.217280] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
> [    1.217289] pcie_pme 0000:00:06.0:pcie01: service driver pcie_pme loaded
> [    1.217382] pcieport 0000:00:15.0: Signaling PME through PCIe PME interrupt
> [    1.217392] pcie_pme 0000:00:15.0:pcie01: service driver pcie_pme loaded
> [    1.217419] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    1.217482] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    1.217684] GHES: Failed to enable APEI firmware first mode.
> [    1.218013] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    1.238736] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    1.259769] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [    1.261525] Linux agpgart interface v0.103
> [    1.261766] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [    1.261771] AMD IOMMUv2 functionality not available on this system
> [    1.261954] i8042: PNP: No PS/2 controller found. Probing ports directly.
> [    2.204419] tsc: Refined TSC clocksource calibration: 999.999 MHz
> [    3.205323] i8042: No controller found
> [    3.209117] Switched to clocksource tsc
> [    3.209596] mousedev: PS/2 mouse device common for all mice
> [    3.209744] rtc_cmos 00:00: RTC can wake from S4
> [    3.210136] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
> [    3.210236] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram, hpet irqs
> [    3.210429] TCP: cubic registered
> [    3.210545] NET: Registered protocol family 10
> [    3.211325] mip6: Mobile IPv6
> [    3.211344] NET: Registered protocol family 17
> [    3.211360] mpls_gso: MPLS GSO support
> [    3.212572] registered taskstats version 1
> [    3.213725] rtc_cmos 00:00: setting system clock to 2015-03-18 22:53:16 UTC (1426719196)
> [    3.213831] PM: Hibernation image not present or could not be loaded.
> [    3.215018] Freeing unused kernel memory: 1020K (ffffffff818ba000 - ffffffff819b9000)
> [    3.215030] Write protecting the kernel read-only data: 8192k
> [    3.216174] Freeing unused kernel memory: 868K (ffff880001527000 - ffff880001600000)
> [    3.216639] Freeing unused kernel memory: 288K (ffff8800017b8000 - ffff880001800000)
> [    3.455783] udevd[64]: starting version 175
> [    3.522897] ACPI: bus type USB registered
> [    3.523006] usbcore: registered new interface driver usbfs
> [    3.523046] usbcore: registered new interface driver hub
> [    3.526771] SCSI subsystem initialized
> [    3.533232] usbcore: registered new device driver usb
> [    3.534513] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    3.535446] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    3.536131] ohci-pci: OHCI PCI platform driver
> [    3.536243] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    3.536253] QUIRK: Enable AMD PLL fix
> [    3.537141] ehci-pci: EHCI PCI platform driver
> [    3.537256] ohci-pci 0000:00:12.0: OHCI PCI host controller
> [    3.537278] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 1
> [    3.537475] ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb04000
> [    3.547535] r8169 0000:01:00.0 (unnamed net_device) (uninitialized): unknown MAC, using family default
> [    3.562301] r8169 0000:01:00.0 (unnamed net_device) (uninitialized): rtl_chipcmd_cond == 1 (loop: 100, delay: 100).
> [    3.563380] libata version 3.00 loaded.
> [    3.596901] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.596915] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.596923] usb usb1: Product: OHCI PCI host controller
> [    3.596930] usb usb1: Manufacturer: Linux 4.0.0-rc4 ohci_hcd
> [    3.596936] usb usb1: SerialNumber: 0000:00:12.0
> [    3.597486] hub 1-0:1.0: USB hub found
> [    3.597569] hub 1-0:1.0: 5 ports detected
> [    3.598621] ehci-pci 0000:00:12.2: EHCI Host Controller
> [    3.598642] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 2
> [    3.598659] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    3.598727] ehci-pci 0000:00:12.2: debug port 1
> [    3.598821] ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb08400
> [    3.608379] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
> [    3.608525] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.608535] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.608542] usb usb2: Product: EHCI Host Controller
> [    3.608548] usb usb2: Manufacturer: Linux 4.0.0-rc4 ehci_hcd
> [    3.608554] usb usb2: SerialNumber: 0000:00:12.2
> [    3.608992] hub 2-0:1.0: USB hub found
> [    3.609017] hub 2-0:1.0: 5 ports detected
> [    3.629427] r8169 0000:01:00.0 eth0: RTL8168b/8111b at 0xffffc90000324000, ff:ff:ff:ff:ff:ff, XID 9cf0f8ff IRQ 28
> [    3.629441] r8169 0000:01:00.0 eth0: jumbo features [frames: 4080 bytes, tx checksumming: ko]
> [    3.629514] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    3.629809] r8169 0000:02:00.0 (unnamed net_device) (uninitialized): unknown MAC, using family default
> [    3.644577] r8169 0000:02:00.0 (unnamed net_device) (uninitialized): rtl_chipcmd_cond == 1 (loop: 100, delay: 100).
> [    3.684636] hub 1-0:1.0: USB hub found
> [    3.684719] hub 1-0:1.0: 5 ports detected
> [    3.685278] ehci-pci 0000:00:13.2: EHCI Host Controller
> [    3.685299] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 3
> [    3.685316] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    3.685384] ehci-pci 0000:00:13.2: debug port 1
> [    3.685450] ehci-pci 0000:00:13.2: irq 17, io mem 0xfeb08500
> [    3.696412] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
> [    3.696543] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.696551] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.696558] usb usb3: Product: EHCI Host Controller
> [    3.696564] usb usb3: Manufacturer: Linux 4.0.0-rc4 ehci_hcd
> [    3.696570] usb usb3: SerialNumber: 0000:00:13.2
> [    3.697002] hub 3-0:1.0: USB hub found
> [    3.697029] hub 3-0:1.0: 5 ports detected
> [    3.697681] ehci-pci 0000:00:16.2: EHCI Host Controller
> [    3.697704] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 4
> [    3.697720] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
> [    3.697787] ehci-pci 0000:00:16.2: debug port 1
> [    3.697851] ehci-pci 0000:00:16.2: irq 17, io mem 0xfeb08600
> [    3.706721] r8169 0000:02:00.0 eth1: RTL8168b/8111b at 0xffffc900003b4000, ff:ff:ff:ff:ff:ff, XID 9cf0f8ff IRQ 29
> [    3.706736] r8169 0000:02:00.0 eth1: jumbo features [frames: 4080 bytes, tx checksumming: ko]
> [    3.706799] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    3.707087] r8169 0000:03:00.0 (unnamed net_device) (uninitialized): unknown MAC, using family default
> [    3.721569] r8169 0000:03:00.0 (unnamed net_device) (uninitialized): rtl_chipcmd_cond == 1 (loop: 100, delay: 100).
> [    3.732215] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
> [    3.732329] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.732336] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.732343] usb usb4: Product: EHCI Host Controller
> [    3.732349] usb usb4: Manufacturer: Linux 4.0.0-rc4 ehci_hcd
> [    3.732355] usb usb4: SerialNumber: 0000:00:16.2
> [    3.732788] hub 4-0:1.0: USB hub found
> [    3.732814] hub 4-0:1.0: 4 ports detected
> [    3.734124] ohci-pci 0000:00:13.0: OHCI PCI host controller
> [    3.734149] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
> [    3.734265] ohci-pci 0000:00:13.0: irq 18, io mem 0xfeb05000
> [    3.736070] r8169 0000:03:00.0 eth2: RTL8168b/8111b at 0xffffc90000418000, ff:ff:ff:ff:ff:ff, XID 9cf0f8ff IRQ 30
> [    3.736083] r8169 0000:03:00.0 eth2: jumbo features [frames: 4080 bytes, tx checksumming: ko]
> [    3.792729] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.792743] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.792750] usb usb5: Product: OHCI PCI host controller
> [    3.792756] usb usb5: Manufacturer: Linux 4.0.0-rc4 ohci_hcd
> [    3.792762] usb usb5: SerialNumber: 0000:00:13.0
> [    3.793465] hub 5-0:1.0: USB hub found
> [    3.793546] hub 5-0:1.0: 5 ports detected
> [    3.797752] scsi host0: pata_atiixp
> [    3.798207] scsi host1: pata_atiixp
> [    3.798379] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4010 irq 14
> [    3.798385] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x4018 irq 15
> [    3.798455] ahci 0000:00:11.0: version 3.0
> [    3.799145] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
> [    3.799156] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led clo pmp pio slum part 
> [    3.801501] scsi host2: ahci
> [    3.802169] scsi host3: ahci
> [    3.802671] scsi host4: ahci
> [    3.803093] scsi host5: ahci
> [    3.803294] ata3: SATA max UDMA/133 abar m1024@0xfeb08000 port 0xfeb08100 irq 19
> [    3.803303] ata4: SATA max UDMA/133 abar m1024@0xfeb08000 port 0xfeb08180 irq 19
> [    3.803310] ata5: SATA max UDMA/133 abar m1024@0xfeb08000 port 0xfeb08200 irq 19
> [    3.803318] ata6: SATA max UDMA/133 abar m1024@0xfeb08000 port 0xfeb08280 irq 19
> [    3.803613] ohci-pci 0000:00:14.5: OHCI PCI host controller
> [    3.803633] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
> [    3.804368] ohci-pci 0000:00:14.5: irq 18, io mem 0xfeb06000
> [    3.864715] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.864728] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.864736] usb usb6: Product: OHCI PCI host controller
> [    3.864742] usb usb6: Manufacturer: Linux 4.0.0-rc4 ohci_hcd
> [    3.864748] usb usb6: SerialNumber: 0000:00:14.5
> [    3.865483] hub 6-0:1.0: USB hub found
> [    3.865565] hub 6-0:1.0: 2 ports detected
> [    3.866057] ohci-pci 0000:00:16.0: OHCI PCI host controller
> [    3.866077] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
> [    3.866197] ohci-pci 0000:00:16.0: irq 18, io mem 0xfeb07000
> [    3.924720] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.924734] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.924742] usb usb7: Product: OHCI PCI host controller
> [    3.924748] usb usb7: Manufacturer: Linux 4.0.0-rc4 ohci_hcd
> [    3.924754] usb usb7: SerialNumber: 0000:00:16.0
> [    3.925498] hub 7-0:1.0: USB hub found
> [    3.925580] hub 7-0:1.0: 4 ports detected
> [    3.940427] usb 2-2: new high-speed USB device number 2 using ehci-pci
> [    4.044593] usb 4-1: new high-speed USB device number 2 using ehci-pci
> [    4.120342] ata6: SATA link down (SStatus 0 SControl 300)
> [    4.120425] ata4: SATA link down (SStatus 0 SControl 300)
> [    4.124579] ata5: SATA link down (SStatus 0 SControl 300)
> [    4.157871] usb 2-2: New USB device found, idVendor=413c, idProduct=8147
> [    4.157888] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    4.157896] usb 2-2: Product: Dell Wireless 5530 HSPA Mobile Broadband Minicard Device
> [    4.157902] usb 2-2: Manufacturer: Dell
> [    4.157908] usb 2-2: SerialNumber: 3558620263894800
> [    4.179966] usb 4-1: New USB device found, idVendor=058f, idProduct=6366
> [    4.179983] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    4.179992] usb 4-1: Product: Flash Card Reader/Writer
> [    4.179999] usb 4-1: Manufacturer: Generic
> [    4.180007] usb 4-1: SerialNumber: 058F63666485
> [    4.188669] usb-storage 4-1:1.0: USB Mass Storage device detected
> [    4.189222] scsi host6: usb-storage 4-1:1.0
> [    4.189502] usbcore: registered new interface driver usb-storage
> [    4.292573] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    4.308084] ata3.00: ATA-8: KINGSTON SMS200S330G, 524ABBF0, max UDMA/133
> [    4.308097] ata3.00: 58626288 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
> [    4.318759] ata3.00: configured for UDMA/133
> [    4.319429] scsi 2:0:0:0: Direct-Access     ATA      KINGSTON SMS200S BBF0 PQ: 0 ANSI: 5
> [    4.334582] sd 2:0:0:0: [sda] 58626288 512-byte logical blocks: (30.0 GB/27.9 GiB)
> [    4.334974] sd 2:0:0:0: [sda] Write Protect is off
> [    4.334993] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    4.335059] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    4.336525]  sda: sda1 sda2 < sda5 >
> [    4.337966] sd 2:0:0:0: [sda] Attached SCSI disk
> [    4.343430] sd 2:0:0:0: Attached scsi generic sg0 type 0
> [    4.447464] device-mapper: uevent: version 1.0.3
> [    4.447690] device-mapper: ioctl: 4.30.0-ioctl (2014-12-22) initialised: dm-devel@redhat.com
> [    4.479402] PM: Starting manual resume from disk
> [    4.479418] PM: Hibernation image partition 8:5 present
> [    4.479422] PM: Looking for hibernation image.
> [    4.480214] PM: Image not found (code -22)
> [    4.480226] PM: Hibernation image not present or could not be loaded.
> [    4.506652] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
> [    5.030219] udevd[393]: starting version 175
> [    5.189785] scsi 6:0:0:0: Direct-Access     Multiple Card  Reader     1.00 PQ: 0 ANSI: 4
> [    5.192342] sd 6:0:0:0: Attached scsi generic sg1 type 0
> [    5.195006] sd 6:0:0:0: [sdb] Attached SCSI removable disk
> [    5.239569] ACPI: acpi_idle registered with cpuidle
> [    5.243090] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    5.243108] ACPI: Power Button [PWRB]
> [    5.244453] acpi-cpufreq: overriding BIOS provided _PSD data
> [    5.249457] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> [    5.249475] ACPI: Power Button [PWRF]
> [    5.484106] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
> [    5.490025] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
> [    5.499979] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> [    5.500146] sp5100_tco: PCI Revision ID: 0x42
> [    5.500251] sp5100_tco: Using 0xfed80b00 for watchdog MMIO address
> [    5.500373] sp5100_tco: Last reboot was not triggered by watchdog.
> [    5.505115] sp5100_tco: initialized (0xffffc900003b0b00). heartbeat=60 sec (nowayout=0)
> [    5.578150] kvm: Nested Virtualization enabled
> [    5.578167] kvm: Nested Paging enabled
> [    5.580615] cdc_wdm 2-2:1.5: cdc-wdm0: USB WDM device
> [    5.580774] cdc_wdm 2-2:1.6: cdc-wdm1: USB WDM device
> [    5.580837] usbcore: registered new interface driver cdc_wdm
> [    5.582337] cdc_acm 2-2:1.1: ttyACM0: USB ACM device
> [    5.583380] cdc_acm 2-2:1.3: ttyACM1: USB ACM device
> [    5.584829] cdc_acm 2-2:1.9: ttyACM2: USB ACM device
> [    5.585961] usbcore: registered new interface driver cdc_acm
> [    5.585972] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> [    5.624990] cdc_ether 2-2:1.7 wwan0: register 'cdc_ether' at usb-0000:00:12.2-2, Mobile Broadband Network Device, 02:80:37:ec:02:00
> [    5.625096] usbcore: registered new interface driver cdc_ether
> [    6.711926] Adding 1239036k swap on /dev/sda5.  Priority:-1 extents:1 across:1239036k SS
> [    6.765958] EXT4-fs (sda1): re-mounted. Opts: (null)
> [    6.875075] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
> [    7.172956] loop: module loaded
> [    7.189581] random: vgscan urandom read with 35 bits of entropy available
> [   10.540648] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   10.569052] ip6_tables: (C) 2000-2006 Netfilter Core Team
> [   10.603131] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
> [   10.612636] Bridge firewalling registered
> [   10.652079] device eth0 entered promiscuous mode
> [   10.655679] device eth2 entered promiscuous mode
> [  222.938623] random: nonblocking pool is initialized
> 
> --------------000809080900050004000900
> Content-Type: text/plain; charset=windows-1252;
>  name="lspci.txt"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: attachment;
>  filename="lspci.txt"
> 
> 00:00.0 Host bridge: Advanced Micro Devices [AMD] Family 14h Processor Root Complex
> 00:04.0 PCI bridge: Advanced Micro Devices [AMD] Family 14h Processor Root Port
> 00:05.0 PCI bridge: Advanced Micro Devices [AMD] Family 14h Processor Root Port
> 00:06.0 PCI bridge: Advanced Micro Devices [AMD] Family 14h Processor Root Port
> 00:11.0 SATA controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
> 00:12.0 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
> 00:12.2 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller
> 00:13.0 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
> 00:13.2 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller
> 00:14.0 SMBus: Advanced Micro Devices [AMD] nee ATI SBx00 SMBus Controller (rev 42)
> 00:14.1 IDE interface: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 IDE Controller (rev 40)
> 00:14.3 ISA bridge: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)
> 00:14.4 PCI bridge: Advanced Micro Devices [AMD] nee ATI SBx00 PCI to PCI Bridge (rev 40)
> 00:14.5 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
> 00:15.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0)
> 00:16.0 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
> 00:16.2 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 0 (rev 43)
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 1
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 2
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 3
> 00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 4
> 00:18.5 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 6
> 00:18.6 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 5
> 00:18.7 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 7
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 06)
> 02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 06)
> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 06)
> 
> --------------000809080900050004000900--
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
