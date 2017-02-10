Return-Path: <SRS0=I8Kf=ZX=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=I8Kf=ZX=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V3] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1486362304-56261-1-git-send-email-liudongdong3@huawei.com>
 <20170206224041.GB27899@bhelgaas-glaptop.roam.corp.google.com>
 <89c7b769-f410-1526-b147-b3361b4fa9d7@huawei.com>
 <20170207144754.GA11769@bhelgaas-glaptop.roam.corp.google.com>
 <16bf01d2-2d8e-e44d-d1b0-fcb3cbff5fba@huawei.com>
 <61310008-2f25-e4c3-a5ea-b534262a2abf@huawei.com>
 <20170209151433.GB11905@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        <charles.chenxin@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <e3c10e49-6381-9f09-a555-1ffb150998bb@huawei.com>
Date: Fri, 10 Feb 2017 10:24:54 +0800
MIME-Version: 1.0
In-Reply-To: <20170209151433.GB11905@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

在 2017/2/9 23:14, Bjorn Helgaas 写道:
> On Thu, Feb 09, 2017 at 11:45:00AM +0800, Dongdong Liu wrote:
>> Hi Bjorn
>>
>> I found the dmesg log had an error information.
>> [    7.318390] Error: Driver 'hisi-pcie' is already registered, aborting...
>>
>> The below modification can resolve the bug, could you help to merge it to this patch.
>> I am sorry to bother you.
>
> No problem, I folded it in and re-pushed the pci/host-hisi branch.
> Can you make sure it fixes the problem?
>
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-hisi
>
It fixes the problem. The below is boot log.

Thanks,
Dongdong

EFI stub: Booting Linux Kernel...
SmiGraphicsOutputQueryMode +
SmiGraphicsOutputQueryMode -
EFI stub: Using DTB from command line
EFI stub: Exiting boot services and installing virtual address map...
SAS ExitBootServicesEvent
GMAC ExitBootServicesEvent
GMAC ExitBootServicesEvent
GMAC ExitBootServicesEvent
GMAC ExitBootServicesEvent
OHCI ExitBootServicesEvent
IPMI ExitBootService Event
TransferSmbiosToBMC EVENT.
Transfer Smbios Table To iBMC Success.
GetVariable Status : Not Found.
[    0.000000] Booting Linux on physical CPU 0x10000
[    0.000000] Linux version 4.10.0-rc1-ga01ca1a-dirty (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #322 SMP PREEMPT Fri Feb 10 10:29:43 CST 2017
[    0.000000] Boot CPU: AArch64 Processor [410fd082]
[    0.000000] earlycon: pl11 at MMIO 0x00000000602b0000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS=0x3f110000  SMBIOS 3.0=0x39c80000  ACPI=0x39d50000  ACPI 2.0=0x39d50014  MEMATTR=0x3c954018
[    0.000000] cma: Reserved 16 MiB at 0x000000003e000000
[    0.000000] NUMA: Adding memblock [0x0 - 0x3fffffff] on node 0
[    0.000000] OF: NUMA: parsing numa-distance-map-v1
[    0.000000] NUMA: Warning: invalid memblk node 4 [mem 0x1040000000-0x13fbffffff]
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000417fbffffff]
[    0.000000] NUMA: Adding memblock [0x0 - 0x257ff] on node 0
[    0.000000] NUMA: Adding memblock [0x25800 - 0x319bffff] on node 0
[    0.000000] NUMA: Adding memblock [0x319c0000 - 0x31a2ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31a30000 - 0x31b0ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b10000 - 0x31b23fff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b24000 - 0x39b8ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x39b90000 - 0x3a11ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x3a120000 - 0x3f10ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x3f110000 - 0x3f13ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x3f140000 - 0x3fbfffff] on node 0
[    0.000000] NUMA: Adding memblock [0x1040000000 - 0x13fbffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x1400000000 - 0x17fbffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x41000000000 - 0x413fbffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x41400000000 - 0x417fbffffff] on node 0
[    0.000000] NUMA: Initmem setup node 0 [mem 0x00000000-0x417fbffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x417fbfc7d80-0x417fbfc987f]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000417fbffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000000024fff]
[    0.000000]   node   0: [mem 0x0000000000026000-0x00000000319bffff]
[    0.000000]   node   0: [mem 0x00000000319c0000-0x0000000031a2ffff]
[    0.000000]   node   0: [mem 0x0000000031a30000-0x0000000031b0ffff]
[    0.000000]   node   0: [mem 0x0000000031b10000-0x0000000031b23fff]
[    0.000000]   node   0: [mem 0x0000000031b24000-0x0000000039b8ffff]
[    0.000000]   node   0: [mem 0x0000000039b90000-0x000000003a11ffff]
[    0.000000]   node   0: [mem 0x000000003a120000-0x000000003f10ffff]
[    0.000000]   node   0: [mem 0x000000003f110000-0x000000003f13ffff]
[    0.000000]   node   0: [mem 0x000000003f140000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000001040000000-0x00000013fbffffff]
[    0.000000]   node   0: [mem 0x0000001400000000-0x00000017fbffffff]
[    0.000000]   node   0: [mem 0x0000041000000000-0x00000413fbffffff]
[    0.000000]   node   0: [mem 0x0000041400000000-0x00000417fbffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000417fbffffff]
[    0.000000] psci: probing for conduit method from DT.
NOTICE:  [psci_smc_handler]:[347L] PSCI_VERSION CALL
NOTICE:  [psci_version]:[99L] PSCI_MAJOR_VER: 10000: PSCI_MINOR_VER: 0

0808?464
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs

0808?464
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.

0808?464

0808?464
[    0.000000] percpu: Embedded 21 pages/cpu @ffff8417bb6c0000 s48128 r8192 d29696 u86016
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 16449551
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: dtb=hip07-d05.dtb earlycon=pl011,mmio,0x602B0000 console=ttyAMA0,115200, initrd=filesystem.cpio.gz
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 258048 bytes
[    0.000000] log_buf_len min size: 131072 bytes
[    0.000000] log_buf_len: 524288 bytes
[    0.000000] early log buf free: 125640(95%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] software IO TLB [mem 0x35b90000-0x39b90000] (64MB) mapped at [ffff800035b90000-ffff800039b8ffff]
[    0.000000] Memory: 65655680K/66842620K available (8764K kernel code, 948K rwdata, 3920K rodata, 1024K init, 399K bss, 1170556K reserved, 16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008910000   (  8768 KB)
[    0.000000]     .rodata : 0xffff000008910000 - 0xffff000008cf0000   (  3968 KB)
[    0.000000]       .init : 0xffff000008cf0000 - 0xffff000008df0000   (  1024 KB)
[    0.000000]       .data : 0xffff000008df0000 - 0xffff000008edd200   (   949 KB)
[    0.000000]        .bss : 0xffff000008edd200 - 0xffff000008f40e50   (   400 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e105ff00000   ( 67071 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff8417fc000000   (4292544 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=64, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] ITS [mem 0x4c000000-0x4c03ffff]
[    0.000000] ITS@0x000000004c000000: allocated 524288 Devices @417bac00000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x000000004c000000: allocated 2048 Virtual CPUs @417bb02c000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x000000004c000000: allocated 512 Interrupt Collections @417bb029000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x6c000000-0x6c03ffff]
[    0.000000] ITS@0x000000006c000000: allocated 524288 Devices @417ba800000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x000000006c000000: allocated 2048 Virtual CPUs @417bb050000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x000000006c000000: allocated 512 Interrupt Collections @417bb02b000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0xc6000000-0xc603ffff]
[    0.000000] ITS@0x00000000c6000000: allocated 524288 Devices @417ba400000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 2048 Virtual CPUs @417bb054000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 512 Interrupt Collections @417bb058000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x8c6000000-0x8c603ffff]
[    0.000000] ITS@0x00000008c6000000: allocated 524288 Devices @417ba000000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000008c6000000: allocated 2048 Virtual CPUs @417bb05c000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000008c6000000: allocated 512 Interrupt Collections @417bb059000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x4004c000000-0x4004c03ffff]
[    0.000000] ITS@0x000004004c000000: allocated 524288 Devices @417b9c00000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x000004004c000000: allocated 2048 Virtual CPUs @417bb090000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x000004004c000000: allocated 512 Interrupt Collections @417bb05a000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x4006c000000-0x4006c03ffff]
[    0.000000] ITS@0x000004006c000000: allocated 524288 Devices @417b9800000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x000004006c000000: allocated 2048 Virtual CPUs @417bb094000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x000004006c000000: allocated 512 Interrupt Collections @417bb098000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x400c6000000-0x400c603ffff]
[    0.000000] ITS@0x00000400c6000000: allocated 524288 Devices @417b9400000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000400c6000000: allocated 2048 Virtual CPUs @417bb09c000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000400c6000000: allocated 512 Interrupt Collections @417bb099000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x408c6000000-0x408c603ffff]
[    0.000000] ITS@0x00000408c6000000: allocated 524288 Devices @417b9000000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000408c6000000: allocated 2048 Virtual CPUs @417bb0d0000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000408c6000000: allocated 512 Interrupt Collections @417bb09a000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] GIC: using LPI property table @0x00000417bb0e0000
[    0.000000] ITS: Allocated 1792 chunks for LPIs
[    0.000000] GICv3: CPU0: found redistributor 10000 region 0:0x000000004d100000
[    0.000000] CPU0: using LPI pending table @0x00000417bb0f0000
[    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000001] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.008200] Console: colour dummy device 80x25
[    0.012719] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.023271] pid_max: default: 65536 minimum: 512
[    0.027980] Security Framework initialized
[    0.040613] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.075303] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.094309] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.101570] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.137160] ASID allocator initialised with 65536 entries
[    0.162648] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@4c000000 domain created
[    0.171536] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@6c000000 domain created
[    0.180421] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@c6000000 domain created
[    0.189302] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@8,c6000000 domain created
[    0.198360] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@400,4c000000 domain created
[    0.207594] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@400,6c000000 domain created
[    0.216828] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@400,c6000000 domain created
[    0.226060] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@408,c6000000 domain created
[    0.235312] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@4c000000 domain created
[    0.244634] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@6c000000 domain created
[    0.253955] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@c6000000 domain created
[    0.263276] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@8,c6000000 domain created
[    0.272773] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@400,4c000000 domain created
[    0.282446] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@400,6c000000 domain created
[    0.292119] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@400,c6000000 domain created
[    0.301793] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@408,c6000000 domain created
[    0.311615] Remapping and enabling EFI services.
[    0.316301]   EFI remap 0x00000000319c0000 => 0000000020000000
[    0.322198]   EFI remap 0x0000000031b10000 => 0000000020070000
[    0.328096]   EFI remap 0x0000000039b90000 => 0000000020080000
[    0.333992]   EFI remap 0x0000000039bd0000 => 00000000200c0000
[    0.339889]   EFI remap 0x0000000039c70000 => 00000000200d0000
[    0.345786]   EFI remap 0x0000000039cf0000 => 0000000020150000
[    0.351683]   EFI remap 0x0000000039d60000 => 00000000201a0000
[    0.357586]   EFI remap 0x0000000039db0000 => 00000000201f0000
[    0.363483]   EFI remap 0x0000000039e00000 => 0000000020240000
[    0.369380]   EFI remap 0x0000000039e50000 => 0000000020290000
[    0.375277]   EFI remap 0x0000000039f20000 => 0000000020360000
[    0.381180]   EFI remap 0x0000000039f90000 => 00000000203d0000
[    0.387077]   EFI remap 0x0000000039fe0000 => 0000000020420000
[    0.392974]   EFI remap 0x000000003a030000 => 0000000020470000
[    0.398872]   EFI remap 0x000000003a080000 => 00000000204c0000
[    0.404769]   EFI remap 0x000000003a0d0000 => 0000000020510000
[    0.410666]   EFI remap 0x000000003f110000 => 0000000020560000
[    0.416563]   EFI remap 0x0000000078000000 => 0000000020590000
[    0.422460]   EFI remap 0x00000000a4000000 => 0000000020600000
[    0.428361]   EFI remap 0x00000000a6000000 => 0000000021600000
[    0.434258]   EFI remap 0x00000000d00e0000 => 0000000021610000
[    0.456164] smp: Bringing up secondary CPUs ...
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10001 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5e880
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc7f190
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10002 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5e900
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc7f3a0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10003 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5e980
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc7f5b0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10100 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ea00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc7f7c0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10101 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ea80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc7f9d0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10102 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5eb00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc7fbe0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10103 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5eb80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc7fdf0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10200 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ec00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc80000
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10201 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ec80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc80210
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10202 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ed00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc80420
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10203 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ed80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc80630
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10300 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ee00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc80840
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10301 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ee80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc80a50
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10302 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ef00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc80c60
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x10303 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ef80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc80e70
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30000 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x0

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5f800
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc83180
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30001 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5f880
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc83390
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30002 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5f900
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc835a0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30003 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5f980
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc837b0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30100 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fa00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc839c0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30101 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fa80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc83bd0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30102 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fb00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc83de0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30103 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fb80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc83ff0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30200 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fc00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc84200
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30201 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fc80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc84410
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30202 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fd00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc84620
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30203 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fd80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc84830
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30300 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fe00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc84a40
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30301 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5fe80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc84c50
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30302 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ff00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc84e60
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x30303 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc5ff80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc85070
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50000 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x0

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60800
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc87380
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50001 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60880
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc87590
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50002 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60900
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc877a0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50003 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60980
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc879b0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50100 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60a00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc87bc0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50101 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60a80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc87dd0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50102 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60b00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc87fe0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50103 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60b80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc881f0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50200 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60c00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc88400
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50201 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60c80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc88610
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50202 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60d00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc88820
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50203 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60d80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc88a30
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50300 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60e00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc88c40
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50301 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60e80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc88e50
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50302 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60f00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc89060
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x50303 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc60f80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc89270
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70000 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x0

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61800
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8b580
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70001 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61880
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8b790
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70002 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61900
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8b9a0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70003 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x10000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61980
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8bbb0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70100 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x10000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61a00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8bdc0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70101 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61a80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8bfd0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70102 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61b00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8c1e0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70103 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x30000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61b80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8c3f0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70200 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x30000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61c00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8c600
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70201 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61c80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8c810
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70202 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61d00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8ca20
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70203 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0x70000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61d80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8cc30
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70300 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0x70000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61e00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8ce40
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70301 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61e80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8d050
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70302 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61f00
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8d260
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x70303 x2=0x905190 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[120L] domain_cluster=0xf0000

NOTICE:  [scpi_set_css_power_state]:[143L] domain_cluster=0xf0000


0808?464
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 3fc61f80
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 3fc8d470
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00905190
[    0.535096] Detected PIPT I-cache on CPU1
[    0.535105] GICv3: CPU1: found redistributor 10001 region 0:0x000000004d140000
[    0.535144] CPU1: using LPI pending table @0x00000417b29b0000
[    0.535725] CPU1: Booted secondary processor [410fd082]
[    0.609469] Detected PIPT I-cache on CPU2
[    0.609475] GICv3: CPU2: found redistributor 10002 region 0:0x000000004d180000
[    0.609515] CPU2: using LPI pending table @0x00000417b29e0000
[    0.610097] CPU2: Booted secondary processor [410fd082]
[    0.683845] Detected PIPT I-cache on CPU3
[    0.683851] GICv3: CPU3: found redistributor 10003 region 0:0x000000004d1c0000
[    0.683889] CPU3: using LPI pending table @0x00000417b2a30000
[    0.684470] CPU3: Booted secondary processor [410fd082]
[    0.758222] Detected PIPT I-cache on CPU4
[    0.758230] GICv3: CPU4: found redistributor 10100 region 0:0x000000004d200000
[    0.758272] CPU4: using LPI pending table @0x00000417b2a50000
[    0.758854] CPU4: Booted secondary processor [410fd082]
[    0.832598] Detected PIPT I-cache on CPU5
[    0.832604] GICv3: CPU5: found redistributor 10101 region 0:0x000000004d240000
[    0.832643] CPU5: using LPI pending table @0x00000417b2a90000
[    0.833223] CPU5: Booted secondary processor [410fd082]
[    0.906975] Detected PIPT I-cache on CPU6
[    0.906982] GICv3: CPU6: found redistributor 10102 region 0:0x000000004d280000
[    0.907022] CPU6: using LPI pending table @0x00000417b2ac0000
[    0.907603] CPU6: Booted secondary processor [410fd082]
[    0.981351] Detected PIPT I-cache on CPU7
[    0.981358] GICv3: CPU7: found redistributor 10103 region 0:0x000000004d2c0000
[    0.981397] CPU7: using LPI pending table @0x00000417b2af0000
[    0.981977] CPU7: Booted secondary processor [410fd082]
[    1.055728] Detected PIPT I-cache on CPU8
[    1.055736] GICv3: CPU8: found redistributor 10200 region 0:0x000000004d300000
[    1.055777] CPU8: using LPI pending table @0x00000417b2b30000
[    1.056358] CPU8: Booted secondary processor [410fd082]
[    1.130103] Detected PIPT I-cache on CPU9
[    1.130109] GICv3: CPU9: found redistributor 10201 region 0:0x000000004d340000
[    1.130149] CPU9: using LPI pending table @0x00000417b2b60000
[    1.130730] CPU9: Booted secondary processor [410fd082]
[    1.204480] Detected PIPT I-cache on CPU10
[    1.204486] GICv3: CPU10: found redistributor 10202 region 0:0x000000004d380000
[    1.204524] CPU10: using LPI pending table @0x00000417b2b90000
[    1.205105] CPU10: Booted secondary processor [410fd082]
[    1.278856] Detected PIPT I-cache on CPU11
[    1.278863] GICv3: CPU11: found redistributor 10203 region 0:0x000000004d3c0000
[    1.278903] CPU11: using LPI pending table @0x00000417b2bd0000
[    1.279480] CPU11: Booted secondary processor [410fd082]
[    1.353232] Detected PIPT I-cache on CPU12
[    1.353240] GICv3: CPU12: found redistributor 10300 region 0:0x000000004d400000
[    1.353280] CPU12: using LPI pending table @0x00000417b2bf0000
[    1.353860] CPU12: Booted secondary processor [410fd082]
[    1.427607] Detected PIPT I-cache on CPU13
[    1.427614] GICv3: CPU13: found redistributor 10301 region 0:0x000000004d440000
[    1.427653] CPU13: using LPI pending table @0x00000417b2430000
[    1.428232] CPU13: Booted secondary processor [410fd082]
[    1.501984] Detected PIPT I-cache on CPU14
[    1.501990] GICv3: CPU14: found redistributor 10302 region 0:0x000000004d480000
[    1.502028] CPU14: using LPI pending table @0x00000417b2460000
[    1.502609] CPU14: Booted secondary processor [410fd082]
[    1.576360] Detected PIPT I-cache on CPU15
[    1.576367] GICv3: CPU15: found redistributor 10303 region 0:0x000000004d4c0000
[    1.576406] CPU15: using LPI pending table @0x00000417b24a0000
[    1.576986] CPU15: Booted secondary processor [410fd082]
[    1.650393] Detected PIPT I-cache on CPU16
[    1.650404] GICv3: CPU16: found redistributor 30000 region 1:0x000000006d100000
[    1.650447] CPU16: using LPI pending table @0x00000417b24d0000
[    1.651085] CPU16: Booted secondary processor [410fd082]
[    1.724775] Detected PIPT I-cache on CPU17
[    1.724782] GICv3: CPU17: found redistributor 30001 region 1:0x000000006d140000
[    1.724825] CPU17: using LPI pending table @0x00000417b2500000
[    1.725463] CPU17: Booted secondary processor [410fd082]
[    1.799157] Detected PIPT I-cache on CPU18
[    1.799164] GICv3: CPU18: found redistributor 30002 region 1:0x000000006d180000
[    1.799208] CPU18: using LPI pending table @0x00000417b2540000
[    1.799846] CPU18: Booted secondary processor [410fd082]
[    1.873541] Detected PIPT I-cache on CPU19
[    1.873548] GICv3: CPU19: found redistributor 30003 region 1:0x000000006d1c0000
[    1.873594] CPU19: using LPI pending table @0x00000417b2560000
[    1.874229] CPU19: Booted secondary processor [410fd082]
[    1.947926] Detected PIPT I-cache on CPU20
[    1.947937] GICv3: CPU20: found redistributor 30100 region 1:0x000000006d200000
[    1.947981] CPU20: using LPI pending table @0x00000417b25a0000
[    1.948619] CPU20: Booted secondary processor [410fd082]
[    2.022310] Detected PIPT I-cache on CPU21
[    2.022318] GICv3: CPU21: found redistributor 30101 region 1:0x000000006d240000
[    2.022359] CPU21: using LPI pending table @0x00000417b25d0000
[    2.022995] CPU21: Booted secondary processor [410fd082]
[    2.096692] Detected PIPT I-cache on CPU22
[    2.096700] GICv3: CPU22: found redistributor 30102 region 1:0x000000006d280000
[    2.096742] CPU22: using LPI pending table @0x00000417b2600000
[    2.097377] CPU22: Booted secondary processor [410fd082]
[    2.171078] Detected PIPT I-cache on CPU23
[    2.171086] GICv3: CPU23: found redistributor 30103 region 1:0x000000006d2c0000
[    2.171129] CPU23: using LPI pending table @0x00000417b2650000
[    2.171763] CPU23: Booted secondary processor [410fd082]
[    2.245463] Detected PIPT I-cache on CPU24
[    2.245474] GICv3: CPU24: found redistributor 30200 region 1:0x000000006d300000
[    2.245517] CPU24: using LPI pending table @0x00000417b2670000
[    2.246156] CPU24: Booted secondary processor [410fd082]
[    2.319846] Detected PIPT I-cache on CPU25
[    2.319854] GICv3: CPU25: found redistributor 30201 region 1:0x000000006d340000
[    2.319895] CPU25: using LPI pending table @0x00000417b26b0000
[    2.320531] CPU25: Booted secondary processor [410fd082]
[    2.394229] Detected PIPT I-cache on CPU26
[    2.394237] GICv3: CPU26: found redistributor 30202 region 1:0x000000006d380000
[    2.394279] CPU26: using LPI pending table @0x00000417b26e0000
[    2.394919] CPU26: Booted secondary processor [410fd082]
[    2.468616] Detected PIPT I-cache on CPU27
[    2.468624] GICv3: CPU27: found redistributor 30203 region 1:0x000000006d3c0000
[    2.468667] CPU27: using LPI pending table @0x00000417b2710000
[    2.469304] CPU27: Booted secondary processor [410fd082]
[    2.543001] Detected PIPT I-cache on CPU28
[    2.543013] GICv3: CPU28: found redistributor 30300 region 1:0x000000006d400000
[    2.543055] CPU28: using LPI pending table @0x00000417b2750000
[    2.543694] CPU28: Booted secondary processor [410fd082]
[    2.617385] Detected PIPT I-cache on CPU29
[    2.617393] GICv3: CPU29: found redistributor 30301 region 1:0x000000006d440000
[    2.617435] CPU29: using LPI pending table @0x00000417b2780000
[    2.618073] CPU29: Booted secondary processor [410fd082]
[    2.691768] Detected PIPT I-cache on CPU30
[    2.691776] GICv3: CPU30: found redistributor 30302 region 1:0x000000006d480000
[    2.691820] CPU30: using LPI pending table @0x00000417b27c0000
[    2.692458] CPU30: Booted secondary processor [410fd082]
[    2.766154] Detected PIPT I-cache on CPU31
[    2.766162] GICv3: CPU31: found redistributor 30303 region 1:0x000000006d4c0000
[    2.766204] CPU31: using LPI pending table @0x00000417b27f0000
[    2.766839] CPU31: Booted secondary processor [410fd082]
[    2.840214] Detected PIPT I-cache on CPU32
[    2.840244] GICv3: CPU32: found redistributor 50000 region 2:0x000004004d100000
[    2.840277] CPU32: using LPI pending table @0x00000417b2010000
[    2.840596] CPU32: Booted secondary processor [410fd082]
[    2.914588] Detected PIPT I-cache on CPU33
[    2.914604] GICv3: CPU33: found redistributor 50001 region 2:0x000004004d140000
[    2.914632] CPU33: using LPI pending table @0x00000417b2060000
[    2.914947] CPU33: Booted secondary processor [410fd082]
[    2.988975] Detected PIPT I-cache on CPU34
[    2.988991] GICv3: CPU34: found redistributor 50002 region 2:0x000004004d180000
[    2.989021] CPU34: using LPI pending table @0x00000417b2080000
[    2.989328] CPU34: Booted secondary processor [410fd082]
[    3.063365] Detected PIPT I-cache on CPU35
[    3.063381] GICv3: CPU35: found redistributor 50003 region 2:0x000004004d1c0000
[    3.063409] CPU35: using LPI pending table @0x00000417b20c0000
[    3.063714] CPU35: Booted secondary processor [410fd082]
[    3.137753] Detected PIPT I-cache on CPU36
[    3.137771] GICv3: CPU36: found redistributor 50100 region 2:0x000004004d200000
[    3.137798] CPU36: using LPI pending table @0x00000417b20f0000
[    3.138110] CPU36: Booted secondary processor [410fd082]
[    3.212142] Detected PIPT I-cache on CPU37
[    3.212159] GICv3: CPU37: found redistributor 50101 region 2:0x000004004d240000
[    3.212187] CPU37: using LPI pending table @0x00000417b2120000
[    3.212503] CPU37: Booted secondary processor [410fd082]
[    3.286530] Detected PIPT I-cache on CPU38
[    3.286546] GICv3: CPU38: found redistributor 50102 region 2:0x000004004d280000
[    3.286574] CPU38: using LPI pending table @0x00000417b2160000
[    3.286888] CPU38: Booted secondary processor [410fd082]
[    3.360920] Detected PIPT I-cache on CPU39
[    3.360937] GICv3: CPU39: found redistributor 50103 region 2:0x000004004d2c0000
[    3.360964] CPU39: using LPI pending table @0x00000417b2190000
[    3.361270] CPU39: Booted secondary processor [410fd082]
[    3.435308] Detected PIPT I-cache on CPU40
[    3.435326] GICv3: CPU40: found redistributor 50200 region 2:0x000004004d300000
[    3.435355] CPU40: using LPI pending table @0x00000417b21c0000
[    3.435663] CPU40: Booted secondary processor [410fd082]
[    3.509697] Detected PIPT I-cache on CPU41
[    3.509714] GICv3: CPU41: found redistributor 50201 region 2:0x000004004d340000
[    3.509742] CPU41: using LPI pending table @0x00000417b2200000
[    3.510052] CPU41: Booted secondary processor [410fd082]
[    3.584086] Detected PIPT I-cache on CPU42
[    3.584102] GICv3: CPU42: found redistributor 50202 region 2:0x000004004d380000
[    3.584131] CPU42: using LPI pending table @0x00000417b2220000
[    3.584440] CPU42: Booted secondary processor [410fd082]
[    3.658476] Detected PIPT I-cache on CPU43
[    3.658493] GICv3: CPU43: found redistributor 50203 region 2:0x000004004d3c0000
[    3.658521] CPU43: using LPI pending table @0x00000417b2260000
[    3.658827] CPU43: Booted secondary processor [410fd082]
[    3.732864] Detected PIPT I-cache on CPU44
[    3.732882] GICv3: CPU44: found redistributor 50300 region 2:0x000004004d400000
[    3.732910] CPU44: using LPI pending table @0x00000417b22a0000
[    3.733222] CPU44: Booted secondary processor [410fd082]
[    3.807253] Detected PIPT I-cache on CPU45
[    3.807270] GICv3: CPU45: found redistributor 50301 region 2:0x000004004d440000
[    3.807298] CPU45: using LPI pending table @0x00000417b22d0000
[    3.807602] CPU45: Booted secondary processor [410fd082]
[    3.881642] Detected PIPT I-cache on CPU46
[    3.881659] GICv3: CPU46: found redistributor 50302 region 2:0x000004004d480000
[    3.881687] CPU46: using LPI pending table @0x00000417b2300000
[    3.881994] CPU46: Booted secondary processor [410fd082]
[    3.956031] Detected PIPT I-cache on CPU47
[    3.956048] GICv3: CPU47: found redistributor 50303 region 2:0x000004004d4c0000
[    3.956076] CPU47: using LPI pending table @0x00000417b2330000
[    3.956385] CPU47: Booted secondary processor [410fd082]
[    4.030074] Detected PIPT I-cache on CPU48
[    4.030094] GICv3: CPU48: found redistributor 70000 region 3:0x000004006d100000
[    4.030117] CPU48: using LPI pending table @0x00000417b2390000
[    4.030390] CPU48: Booted secondary processor [410fd082]
[    4.104464] Detected PIPT I-cache on CPU49
[    4.104482] GICv3: CPU49: found redistributor 70001 region 3:0x000004006d140000
[    4.104506] CPU49: using LPI pending table @0x00000417b23c0000
[    4.104781] CPU49: Booted secondary processor [410fd082]
[    4.178853] Detected PIPT I-cache on CPU50
[    4.178872] GICv3: CPU50: found redistributor 70002 region 3:0x000004006d180000
[    4.178896] CPU50: using LPI pending table @0x00000417b1c00000
[    4.179169] CPU50: Booted secondary processor [410fd082]
[    4.253245] Detected PIPT I-cache on CPU51
[    4.253263] GICv3: CPU51: found redistributor 70003 region 3:0x000004006d1c0000
[    4.253286] CPU51: using LPI pending table @0x00000417b1c30000
[    4.253556] CPU51: Booted secondary processor [410fd082]
[    4.327635] Detected PIPT I-cache on CPU52
[    4.327656] GICv3: CPU52: found redistributor 70100 region 3:0x000004006d200000
[    4.327680] CPU52: using LPI pending table @0x00000417b1c60000
[    4.327956] CPU52: Booted secondary processor [410fd082]
[    4.402025] Detected PIPT I-cache on CPU53
[    4.402043] GICv3: CPU53: found redistributor 70101 region 3:0x000004006d240000
[    4.402066] CPU53: using LPI pending table @0x00000417b1ca0000
[    4.402335] CPU53: Booted secondary processor [410fd082]
[    4.476414] Detected PIPT I-cache on CPU54
[    4.476433] GICv3: CPU54: found redistributor 70102 region 3:0x000004006d280000
[    4.476456] CPU54: using LPI pending table @0x00000417b1cc0000
[    4.476733] CPU54: Booted secondary processor [410fd082]
[    4.550806] Detected PIPT I-cache on CPU55
[    4.550825] GICv3: CPU55: found redistributor 70103 region 3:0x000004006d2c0000
[    4.550847] CPU55: using LPI pending table @0x00000417b1d00000
[    4.551114] CPU55: Booted secondary processor [410fd082]
[    4.625197] Detected PIPT I-cache on CPU56
[    4.625219] GICv3: CPU56: found redistributor 70200 region 3:0x000004006d300000
[    4.625242] CPU56: using LPI pending table @0x00000417b1d30000
[    4.625516] CPU56: Booted secondary processor [410fd082]
[    4.699587] Detected PIPT I-cache on CPU57
[    4.699606] GICv3: CPU57: found redistributor 70201 region 3:0x000004006d340000
[    4.699629] CPU57: using LPI pending table @0x00000417b1d60000
[    4.699899] CPU57: Booted secondary processor [410fd082]
[    4.773975] Detected PIPT I-cache on CPU58
[    4.773994] GICv3: CPU58: found redistributor 70202 region 3:0x000004006d380000
[    4.774017] CPU58: using LPI pending table @0x00000417b1da0000
[    4.774288] CPU58: Booted secondary processor [410fd082]
[    4.848368] Detected PIPT I-cache on CPU59
[    4.848387] GICv3: CPU59: found redistributor 70203 region 3:0x000004006d3c0000
[    4.848410] CPU59: using LPI pending table @0x00000417b1dd0000
[    4.848686] CPU59: Booted secondary processor [410fd082]
[    4.922759] Detected PIPT I-cache on CPU60
[    4.922780] GICv3: CPU60: found redistributor 70300 region 3:0x000004006d400000
[    4.922804] CPU60: using LPI pending table @0x00000417b1e10000
[    4.923085] CPU60: Booted secondary processor [410fd082]
[    4.997148] Detected PIPT I-cache on CPU61
[    4.997167] GICv3: CPU61: found redistributor 70301 region 3:0x000004006d440000
[    4.997189] CPU61: using LPI pending table @0x00000417b1e40000
[    4.997467] CPU61: Booted secondary processor [410fd082]
[    5.071536] Detected PIPT I-cache on CPU62
[    5.071555] GICv3: CPU62: found redistributor 70302 region 3:0x000004006d480000
[    5.071579] CPU62: using LPI pending table @0x00000417b1e70000
[    5.071848] CPU62: Booted secondary processor [410fd082]
[    5.145929] Detected PIPT I-cache on CPU63
[    5.145949] GICv3: CPU63: found redistributor 70303 region 3:0x000004006d4c0000
[    5.145971] CPU63: using LPI pending table @0x00000417b1eb0000
[    5.146244] CPU63: Booted secondary processor [410fd082]
[    5.146307] smp: Brought up 1 node, 64 CPUs
[    6.583651] SMP: Total of 64 processors activated.
[    6.588491] CPU features: detected feature: GIC system register CPU interface
[    6.595704] CPU features: detected feature: 32-bit EL0 Support
[    6.601807] CPU: All CPU(s) started at EL2
[    6.606545] devtmpfs: initialized
[    6.611623] SMBIOS 3.0.0 present.
[    6.614974] DMI: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 UEFI 16.08 RC1 12/07/2016
[    6.623306] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    6.633628] pinctrl core: initialized pinctrl subsystem
[    6.639378] NET: Registered protocol family 16
[    6.657775] cpuidle: using governor menu
[    6.661898] vdso: 2 pages (1 code @ ffff000008917000, 1 data @ ffff000008df5000)
[    6.669467] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    6.677382] DMA: preallocated 256 KiB pool for atomic allocations
[    6.683733] Serial: AMBA PL011 UART driver
[    6.688382] irq: no irq domain found for /interrupt-controller@60080000/uart_intc !
[    6.696265] irq: no irq domain found for /interrupt-controller@a0080000/intc_usb !
[    6.704027] irq: no irq domain found for /interrupt-controller@a0080000/intc_usb !
[    6.732042] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    6.739318] ACPI: Interpreter disabled.
[    6.743432] vgaarb: loaded
[    6.746258] SCSI subsystem initialized
[    6.750318] usbcore: registered new interface driver usbfs
[    6.755926] usbcore: registered new interface driver hub
[    6.761507] usbcore: registered new device driver usb
[    6.766734] pps_core: LinuxPPS API ver. 1 registered
[    6.771789] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    6.781102] PTP clock support registered
[    6.785163] Registered efivars operations
[    6.789400] Advanced Linux Sound Architecture Driver Initialized.
[    6.796081] clocksource: Switched to clocksource arch_sys_counter
[    6.802447] VFS: Disk quotas dquot_6.6.0
[    6.806434] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    6.813497] pnp: PnP ACPI: disabled
[    6.819908] NET: Registered protocol family 2
[    6.825354] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    6.834500] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    6.841654] TCP: Hash tables configured (established 524288 bind 65536)
[    6.848557] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    6.855376] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    6.862764] NET: Registered protocol family 1
[    6.867505] RPC: Registered named UNIX socket transport module.
[    6.873493] RPC: Registered udp transport module.
[    6.878249] RPC: Registered tcp transport module.
[    6.883008] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    6.889575] Unpacking initramfs...
[    7.223501] Freeing initrd memory: 28108K
[    7.229107] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
[    7.237666] kvm [1]: 8-bit VMID
[    7.240867] kvm [1]: IDMAP page: 900000
[    7.244769] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    7.251413] kvm [1]: Hyp mode initialized successfully
[    7.256746] kvm [1]: vgic-v2@fe020000
[    7.260555] kvm [1]: GIC system register CPU interface enabled
[    7.267049] kvm [1]: vgic interrupt IRQ1
[    7.271049] genirq: Flags mismatch irq 4. 00004408 (kvm guest timer) vs. 00004408 (arch_timer)
[    7.279822] kvm [1]: kvm_arch_timer: can't request interrupt 4 (-16)
[    7.289216] futex hash table entries: 16384 (order: 9, 2097152 bytes)
[    7.296214] audit: initializing netlink subsys (disabled)
[    7.301744] audit: type=2000 audit(5.536:1): initialized
[    7.302170] workingset: timestamp_bits=44 max_order=24 bucket_order=0
[    7.305424] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.305780] NFS: Registering the id_resolver key type
[    7.305792] Key type id_resolver registered
[    7.305792] Key type id_legacy registered
[    7.305796] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.305855] 9p: Installing v9fs 9p2000 file system support
[    7.307052] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    7.307054] io scheduler noop registered
[    7.307132] io scheduler cfq registered (default)
[    7.314856] OF: PCI: host bridge /soc/pcie@a00a0000 ranges:
[    7.314863] OF: PCI:   MEM 0xa8800000..0xaffeffff -> 0xa8800000
[    7.314866] OF: PCI:    IO 0xafff0000..0xafffffff -> 0x00000000
[    7.314896] hisi-pcie-almost-ecam a8000000.pcie: ECAM at [mem 0xa8000000-0xa87fffff] for [bus 80-87]
[    7.314942] hisi-pcie-almost-ecam a8000000.pcie: PCI host bridge to bus 0000:80
[    7.314945] pci_bus 0000:80: root bus resource [bus 80-87]
[    7.314947] pci_bus 0000:80: root bus resource [mem 0xa8800000-0xaffeffff]
[    7.314948] pci_bus 0000:80: root bus resource [io  0x0000-0xffff]
[    7.314974] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.314979] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.314984] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.314989] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.314992] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.314996] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.315016] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x52 may corrupt adjacent RW1C bits
[    7.315043] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x44 may corrupt adjacent RW1C bits
[    7.315119] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    7.315123] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    7.315316] pci 0000:81:00.0: VF(n) BAR0 space: [mem 0xa9608000-0xa9707fff 64bit pref] (contains BAR0 for 64 VFs)
[    7.315332] pci 0000:81:00.0: VF(n) BAR3 space: [mem 0xa9708000-0xa9807fff 64bit pref] (contains BAR3 for 64 VFs)
[    7.315727] pci 0000:81:00.1: VF(n) BAR0 space: [mem 0xa9404000-0xa9503fff 64bit pref] (contains BAR0 for 64 VFs)
[    7.315743] pci 0000:81:00.1: VF(n) BAR3 space: [mem 0xa9504000-0xa9603fff 64bit pref] (contains BAR3 for 64 VFs)
[    7.316023] pci 0000:80:00.0: BAR 14: assigned [mem 0xa8800000-0xa8ffffff]
[    7.316026] pci 0000:80:00.0: BAR 15: assigned [mem 0xa9000000-0xa9dfffff 64bit pref]
[    7.316027] pci 0000:80:00.0: BAR 0: assigned [mem 0xa9e00000-0xa9e0ffff]
[    7.316030] pci 0000:80:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    7.316034] pci 0000:81:00.0: BAR 0: assigned [mem 0xa9000000-0xa93fffff 64bit pref]
[    7.316042] pci 0000:81:00.0: BAR 6: assigned [mem 0xa8800000-0xa8bfffff pref]
[    7.316044] pci 0000:81:00.1: BAR 0: assigned [mem 0xa9400000-0xa97fffff 64bit pref]
[    7.316051] pci 0000:81:00.1: BAR 6: assigned [mem 0xa8c00000-0xa8ffffff pref]
[    7.316063] pci 0000:81:00.0: BAR 4: assigned [mem 0xa9800000-0xa9803fff 64bit pref]
[    7.316070] pci 0000:81:00.0: BAR 7: assigned [mem 0xa9804000-0xa9903fff 64bit pref]
[    7.316074] pci 0000:81:00.0: BAR 10: assigned [mem 0xa9904000-0xa9a03fff 64bit pref]
[    7.316078] pci 0000:81:00.1: BAR 4: assigned [mem 0xa9a04000-0xa9a07fff 64bit pref]
[    7.316085] pci 0000:81:00.1: BAR 7: assigned [mem 0xa9a08000-0xa9b07fff 64bit pref]
[    7.316089] pci 0000:81:00.1: BAR 10: assigned [mem 0xa9b08000-0xa9c07fff 64bit pref]
[    7.316092] pci 0000:81:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    7.316096] pci 0000:81:00.1: BAR 2: assigned [io  0x1020-0x103f]
[    7.316100] pci 0000:80:00.0: PCI bridge to [bus 81]
[    7.316103] pci 0000:80:00.0:   bridge window [io  0x1000-0x1fff]
[    7.316106] pci 0000:80:00.0:   bridge window [mem 0xa8800000-0xa8ffffff]
[    7.316108] pci 0000:80:00.0:   bridge window [mem 0xa9000000-0xa9dfffff 64bit pref]
[    7.316227] pcieport 0000:80:00.0: Signaling PME with IRQ 7
[    7.316269] pcieport 0000:80:00.0: AER enabled with IRQ 7
[    7.316375] ipmi message handler version 39.2
[    7.316379] ipmi device interface
[    7.316406] IPMI System Interface driver.
[    7.316425] ipmi_si: probing via SMBIOS
[    7.316427] ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1 irq 0
[    7.316429] ipmi_si: Adding SMBIOS-specified bt state machine
[    7.316431] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
[    7.316439] ipmi_si ipmi_si.0: Interface detection failed
[    7.380827] xenfs: not registering filesystem on non-xen platform
[    7.382180] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.382599] no indirect ISA port I/O for Hisilicon LPC uart
[    7.382747] SuperH (H)SCI(F) driver initialized
[    7.382850] msm_serial: driver initialized
[    7.393933] loop: module loaded
[    7.394193] hisi_sas: driver version v1.6
[    7.394714] libphy: Fixed MDIO Bus: probed
[    7.394840] tun: Universal TUN/TAP device driver, 1.6
[    7.394841] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    7.395157] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    7.395157] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    7.395207] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    7.395208] igb: Copyright (c) 2007-2014 Intel Corporation.
[    7.395251] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    7.395252] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    7.395293] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.4.0-k
[    7.395294] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    7.395365] ixgbe 0000:81:00.0: enabling device (0000 -> 0002)
[    8.581205] ixgbe 0000:81:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[    8.589934] ixgbe 0000:81:00.0: PCI Express bandwidth of 32GT/s available
[    8.596856] ixgbe 0000:81:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    8.604212] ixgbe 0000:81:00.0: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
[    8.610513] ixgbe 0000:81:00.0: 9c:37:f4:90:cd:23
[    8.619899] ixgbe 0000:81:00.0: Intel(R) 10 Gigabit Network Connection
[    8.626647] ixgbe 0000:81:00.1: enabling device (0000 -> 0002)
[    8.793147] ixgbe 0000:81:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[    8.801880] ixgbe 0000:81:00.1: PCI Express bandwidth of 32GT/s available
[    8.808798] ixgbe 0000:81:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    8.816157] ixgbe 0000:81:00.1: MAC: 2, PHY: 15, SFP+: 6, PBA No: FFFFFF-0FF
[    8.823344] ixgbe 0000:81:00.1: 9c:37:f4:90:cd:24
[    8.832667] ixgbe 0000:81:00.1: Intel(R) 10 Gigabit Network Connection
[    8.839353] sky2: driver version 1.30
[    8.843214] VFIO - User Level meta-driver version: 0.3
[    8.849153] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    8.855810] ehci-pci: EHCI PCI platform driver
[    8.860352] ehci-platform: EHCI generic platform driver
[    8.865734] ehci-platform a7020000.ehci: EHCI Host Controller
[    8.871601] ehci-platform a7020000.ehci: new USB bus registered, assigned bus number 1
[    8.879878] ehci-platform a7020000.ehci: irq 136, io mem 0xa7020000
[    8.900060] ehci-platform a7020000.ehci: USB 2.0 started, EHCI 1.00
[    8.906619] hub 1-0:1.0: USB hub found
[    8.910413] hub 1-0:1.0: 2 ports detected
[    8.914608] ehci-exynos: EHCI EXYNOS driver
[    8.918896] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    8.924547] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    8.930799] ohci-pci: OHCI PCI platform driver
[    8.935332] ohci-platform: OHCI generic platform driver
[    8.940701] ohci-platform a7030000.ohci: Generic Platform OHCI controller
[    8.947567] ohci-platform a7030000.ohci: new USB bus registered, assigned bus number 2
[    8.955620] ohci-platform a7030000.ohci: irq 137, io mem 0xa7030000
[    9.028294] hub 2-0:1.0: USB hub found
[    9.032131] hub 2-0:1.0: 2 ports detected
[    9.036341] ohci-exynos: OHCI EXYNOS driver
[    9.040717] usbcore: registered new interface driver usb-storage
[    9.047057] mousedev: PS/2 mouse device common for all mice
[    9.178743] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    9.185090] i2c /dev entries driver
[    9.189105] sdhci: Secure Digital Host Controller Interface driver
[    9.195410] sdhci: Copyright(c) Pierre Ossman
[    9.199902] Synopsys Designware Multimedia Card Interface Driver
[    9.206132] sdhci-pltfm: SDHCI platform and OF driver helper
[    9.212602] ledtrig-cpu: registered to indicate activity on CPUs
[    9.218975] usbcore: registered new interface driver usbhid
[    9.224658] usbhid: USB HID core driver
[    9.229030] NET: Registered protocol family 17
[    9.233607] 9pnet: Installing 9P2000 support
[    9.237985] Key type dns_resolver registered
[    9.242491] registered taskstats version 1
[    9.244064] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    9.253961] 602b0000.uart: ttyAMA0 at MMIO 0x602b0000 (irq = 138, base_baud = 0) is a SBSA
[    9.262406] console [ttyAMA0] enabled
[    9.262406] console [ttyAMA0] enabled
[    9.269788] bootconsole [pl11] disabled
[    9.269788] bootconsole [pl11] disabled
[    9.340538] rtc-efi rtc-efi: setting system clock to 2015-02-28 16:34:13 UTC (1425141253)
[    9.348743] ALSA device list:
[    9.351699]   No soundcards found.
[    9.355719] Freeing unused kernel memory: 1024K
root@(none)$ [    9.400640] hub 1-1:1.0: USB hub found
[    9.404478] hub 1-1:1.0: 4 ports detected
[    9.536061] usb 1-2: new high-speed USB device number 3 using ehci-platform
[    9.688517] hub 1-2:1.0: USB hub found
[    9.692353] hub 1-2:1.0: 4 ports detected
[    9.984060] usb 1-2.1: new full-speed USB device number 4 using ehci-platform
[   10.100404] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/soc/a7020000.ehci/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input0
[   10.172247] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-a7020000.ehci-2.1/input0
[   10.184954] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/soc/a7020000.ehci/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input1
[   10.197620] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 Mouse [Keyboard/Mouse KVM 1.1.0] on usb-a7020000.ehci-2.1/input1

root@(none)$ ifconfig -a
eth0      Link encap:Ethernet  HWaddr 9c:37:f4:90:cd:23
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth1      Link encap:Ethernet  HWaddr 9c:37:f4:90:cd:24
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:65536  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@(none)$ ifconfi[   57.933641] random: fast init done
g eth1 192.168.20.188
[   65.705981] ixgbe 0000:81:00.1: registered PHC device on eth1
root@(none)$ [   65.888072] ixgbe 0000:81:00.1 eth1: detected SFP+: 6
[   66.028176] ixgbe 0000:81:00.1 eth1: NIC Link is Up 10 Gbps, Flow Control: RX/TX

root@(none)$ ping 192.168.20.[   74.304291] random: crng init done
12
PING 192.168.20.12 (192.168.20.12): 56 data bytes
64 bytes from 192.168.20.12: seq=16 ttl=128 time=2039.223 ms
64 bytes from 192.168.20.12: seq=17 ttl=128 time=1039.241 ms
64 bytes from 192.168.20.12: seq=18 ttl=128 time=39.234 ms
64 bytes from 192.168.20.12: seq=19 ttl=128 time=0.776 ms
64 bytes from 192.168.20.12: seq=20 ttl=128 time=0.774 ms
64 bytes from 192.168.20.12: seq=21 ttl=128 time=0.545 ms
64 bytes from 192.168.20.12: seq=22 ttl=128 time=0.823 ms
64 bytes from 192.168.20.12: seq=23 ttl=128 time=0.759 ms
64 bytes from 192.168.20.12: seq=24 ttl=128 time=0.384 ms
64 bytes from 192.168.20.12: seq=25 ttl=128 time=0.790 ms
64 bytes from 192.168.20.12: seq=26 ttl=128 time=0.766 ms
64 bytes from 192.168.20.12: seq=27 ttl=128 time=0.604 ms
64 bytes from 192.168.20.12: seq=28 ttl=128 time=0.741 ms
64 bytes from 192.168.20.12: seq=29 ttl=128 time=0.769 ms
64 bytes from 192.168.20.12: seq=30 ttl=128 time=0.455 ms
64 bytes from 192.168.20.12: seq=31 ttl=128 time=0.632 ms
64 bytes from 192.168.20.12: seq=32 ttl=128 time=0.735 ms
64 bytes from 192.168.20.12: seq=33 ttl=128 time=0.458 ms
64 bytes from 192.168.20.12: seq=34 ttl=128 time=0.777 ms
64 bytes from 192.168.20.12: seq=35 ttl=128 time=0.493 ms
64 bytes from 192.168.20.12: seq=36 ttl=128 time=0.712 ms
64 bytes from 192.168.20.12: seq=37 ttl=128 time=0.756 ms
64 bytes from 192.168.20.12: seq=38 ttl=128 time=0.464 ms
64 bytes from 192.168.20.12: seq=39 ttl=128 time=0.751 ms
64 bytes from 192.168.20.12: seq=40 ttl=128 time=0.572 ms
64 bytes from 192.168.20.12: seq=41 ttl=128 time=0.439 ms
64 bytes from 192.168.20.12: seq=42 ttl=128 time=0.769 ms
64 bytes from 192.168.20.12: seq=43 ttl=128 time=0.431 ms
64 bytes from 192.168.20.12: seq=44 ttl=128 time=0.715 ms
64 bytes from 192.168.20.12: seq=45 ttl=128 time=0.694 ms
64 bytes from 192.168.20.12: seq=46 ttl=128 time=0.403 ms
64 bytes from 192.168.20.12: seq=47 ttl=128 time=0.688 ms
64 bytes from 192.168.20.12: seq=48 ttl=128 time=0.741 ms
64 bytes from 192.168.20.12: seq=49 ttl=128 time=0.487 ms
64 bytes from 192.168.20.12: seq=50 ttl=128 time=0.789 ms
64 bytes from 192.168.20.12: seq=51 ttl=128 time=0.824 ms
64 bytes from 192.168.20.12: seq=52 ttl=128 time=0.534 ms
64 bytes from 192.168.20.12: seq=53 ttl=128 time=0.749 ms
64 bytes from 192.168.20.12: seq=54 ttl=128 time=0.794 ms
64 bytes from 192.168.20.12: seq=55 ttl=128 time=0.475 ms
64 bytes from 192.168.20.12: seq=56 ttl=128 time=0.847 ms
64 bytes from 192.168.20.12: seq=57 ttl=128 time=0.755 ms
64 bytes from 192.168.20.12: seq=58 ttl=128 time=0.431 ms
64 bytes from 192.168.20.12: seq=59 ttl=128 time=0.712 ms
64 bytes from 192.168.20.12: seq=60 ttl=128 time=0.759 ms
64 bytes from 192.168.20.12: seq=61 ttl=128 time=0.539 ms
64 bytes from 192.168.20.12: seq=62 ttl=128 time=0.769 ms
64 bytes from 192.168.20.12: seq=63 ttl=128 time=0.841 ms
64 bytes from 192.168.20.12: seq=64 ttl=128 time=0.490 ms
64 bytes from 192.168.20.12: seq=65 ttl=128 time=0.721 ms
64 bytes from 192.168.20.12: seq=66 ttl=128 time=0.655 ms
64 bytes from 192.168.20.12: seq=67 ttl=128 time=0.603 ms
64 bytes from 192.168.20.12: seq=68 ttl=128 time=0.715 ms
64 bytes from 192.168.20.12: seq=69 ttl=128 time=0.707 ms
64 bytes from 192.168.20.12: seq=70 ttl=128 time=0.538 ms
64 bytes from 192.168.20.12: seq=71 ttl=128 time=0.608 ms
64 bytes from 192.168.20.12: seq=72 ttl=128 time=0.770 ms
64 bytes from 192.168.20.12: seq=73 ttl=128 time=0.606 ms
64 bytes from 192.168.20.12: seq=74 ttl=128 time=0.676 ms
64 bytes from 192.168.20.12: seq=75 ttl=128 time=0.707 ms
64 bytes from 192.168.20.12: seq=76 ttl=128 time=0.486 ms
64 bytes from 192.168.20.12: seq=77 ttl=128 time=0.630 ms
64 bytes from 192.168.20.12: seq=78 ttl=128 time=0.721 ms
64 bytes from 192.168.20.12: seq=79 ttl=128 time=0.511 ms
64 bytes from 192.168.20.12: seq=80 ttl=128 time=0.672 ms
64 bytes from 192.168.20.12: seq=81 ttl=128 time=0.742 ms
64 bytes from 192.168.20.12: seq=82 ttl=128 time=0.431 ms
64 bytes from 192.168.20.12: seq=83 ttl=128 time=0.673 ms
64 bytes from 192.168.20.12: seq=84 ttl=128 time=0.547 ms
64 bytes from 192.168.20.12: seq=85 ttl=128 time=0.579 ms
64 bytes from 192.168.20.12: seq=86 ttl=128 time=0.666 ms
64 bytes from 192.168.20.12: seq=87 ttl=128 time=0.536 ms
64 bytes from 192.168.20.12: seq=88 ttl=128 time=0.477 ms
64 bytes from 192.168.20.12: seq=89 ttl=128 time=0.673 ms
64 bytes from 192.168.20.12: seq=90 ttl=128 time=0.695 ms
64 bytes from 192.168.20.12: seq=91 ttl=128 time=0.479 ms
64 bytes from 192.168.20.12: seq=92 ttl=128 time=0.654 ms
64 bytes from 192.168.20.12: seq=93 ttl=128 time=0.673 ms
64 bytes from 192.168.20.12: seq=94 ttl=128 time=0.433 ms
64 bytes from 192.168.20.12: seq=95 ttl=128 time=0.646 ms
64 bytes from 192.168.20.12: seq=96 ttl=128 time=0.675 ms
64 bytes from 192.168.20.12: seq=97 ttl=128 time=0.436 ms
64 bytes from 192.168.20.12: seq=98 ttl=128 time=0.858 ms
64 bytes from 192.168.20.12: seq=99 ttl=128 time=0.660 ms
64 bytes from 192.168.20.12: seq=100 ttl=128 time=0.488 ms
64 bytes from 192.168.20.12: seq=101 ttl=128 time=0.621 ms
64 bytes from 192.168.20.12: seq=102 ttl=128 time=0.666 ms
64 bytes from 192.168.20.12: seq=103 ttl=128 time=0.431 ms
64 bytes from 192.168.20.12: seq=104 ttl=128 time=0.608 ms
64 bytes from 192.168.20.12: seq=105 ttl=128 time=0.622 ms
64 bytes from 192.168.20.12: seq=106 ttl=128 time=0.412 ms

> Thanks!
>
>> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
>> index 9fb8357..02a4d66 100644
>> --- a/drivers/pci/host/pcie-hisi.c
>> +++ b/drivers/pci/host/pcie-hisi.c
>> @@ -374,7 +374,7 @@ struct pci_ecam_ops hisi_pcie_platform_ops = {
>>  static struct platform_driver hisi_pcie_almost_ecam_driver = {
>>         .probe  = hisi_pcie_almost_ecam_probe,
>>         .driver = {
>> -              .name = "hisi-pcie",
>> +            .name = "hisi-pcie-almost-ecam",
>>                    .of_match_table = hisi_pcie_almost_ecam_of_match,
>>         },
>>  };
>>
>> Thanks,
>> Dongdong
