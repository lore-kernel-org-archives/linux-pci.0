Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Tomasz Nowicki <tn@semihalf.com>, <bhelgaas@google.com>,
	<arnd@arndb.de>, <will.deacon@arm.com>, <catalin.marinas@arm.com>,
	<rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<Lorenzo.Pieralisi@arm.com>, <okaya@codeaurora.org>,
	<jiang.liu@linux.intel.com>, <Stefano.Stabellini@eu.citrix.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
CC: <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
	<Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
	<tglx@linutronix.de>, <wangyijing@huawei.com>,
	<Suravee.Suthikulpanit@amd.com>, <msalter@redhat.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <jchandra@broadcom.com>,
	<jcm@redhat.com>, <liudongdong3@huawei.com>
From: "liudongdong (C)" <liudongdong3@huawei.com>
Message-ID: <56AB0A12.8080600@huawei.com>
Date: Fri, 29 Jan 2016 14:43:30 +0800
MIME-Version: 1.0
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



ÔÚ 2016/1/13 21:20, Tomasz Nowicki Ð´µÀ:
>>From the functionality point of view this series might be split into the
> following logic parts:
> 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
>     PCI config regions and used when necessary.
> 2. Move non-arch specific bits to the core code.
> 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
>
> Patches has been built on top of 4.4 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
>
> NOTE, this patch set depends on Matthew's patches:
> http://www.spinics.net/lists/linux-pci/msg45950.html
> https://github.com/Vality/linux/tree/pci-fixes
>
> This has been tested on Cavium ThunderX server and QEMU.
> Any help in reviewing and testing is very appreciated.
>
> v2 -> v3
> - fix legacy IRQ assigning and IO ports registration
> - remove reference to arch specific companion device for ia64
> - move ACPI PCI host controller driver to pci_root.c
> - drop generic domain assignment for x86 and ia64 as I am not
>    able to run all necessary test variants
> - drop patch which cleaned legacy IRQ assignment since it belongs to
>    Mathew's series:
>    https://patchwork.ozlabs.org/patch/557504/
> - extend MCFG quirk code
> - rebased to 4.4

Based on the patchset and add the Hip05 ACPI specific quirks.
Tested on the HiSilicon ARM64 D02 board.
I made a test based on Intel 82599 networking card,it can work ok.
this is the bootup log which contains PCIe host and Intel 82599 networking card part.

Tested-by: Dongdong Liu <liudongdong3@huawei.com>

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from command line
EFI stub: Exiting boot services and installing virtual address map...
GMAC ExitBootServicesEvent
SMMU ExitBootServicesEvent
Booting Linux on physical CPU 0x20000
Initializing cgroup subsys cpu
Linux version 4.4.0-rc2+ (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #194 SMP PREEMPT Thu Jan 28 09:51:15 CST 2016
Boot CPU: AArch64 Processor [411fd071]
earlycon: Early serial console at MMIO32 0x80300000 (options '')
bootconsole [uart0] enabled
efi: Getting EFI parameters from FDT:
EFI v2.50 by ARM Versatile Express EFI Jan 13 2016 20:43:10
efi:  SMBIOS=0x7aae0000  SMBIOS 3.0=0x7aac0000  ACPI=0x7ab20000  ACPI 2.0=0x7ab20014
cma: Reserved 16 MiB at 0x000000007e800000
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x000000007AB20014 000024 (v02 HISI  )
ACPI: XSDT 0x000000007AB100E8 00006C (v01 HISI   HISI-D02 20140727      01000013)
ACPI: FACP 0x000000007AA80000 00010C (v05 HISI   HISI-D02 20140727 HISI 00000099)
ACPI: Override [DSDT-HISI-D02], this is unsafe: tainting kernel
Disabling lock debugging due to kernel taint
ACPI: DSDT 0x000000007AA10000 Logical table override, new table: 0xFFFFFFC0009CB8B8
ACPI: DSDT 0xFFFFFFC0009CB8B8 0015B5 (v01 HISI   HISI-D02 20140727 INTL 20150619)
ACPI: DBG2 0x000000007AAA0000 00005A (v00 HISI   HISI-D02 20140727 HISI 00000099)
ACPI: GTDT 0x000000007AA70000 000060 (v02 HISI   HISI-D02 20140727 HISI 00000099)
ACPI: APIC 0x000000007AA60000 000564 (v01 HISI   HISI-D02 20140727 HISI 00000099)
ACPI: MCFG 0x000000007AA50000 00004C (v01 HISI   HISI-D02 20140727 HISI 00000099)
ACPI: SLIT 0x000000007AA40000 0001BC (v01 HISI   HISI-D02 20140727 HISI 00000099)
ACPI: SPCR 0x000000007AA30000 000050 (v02 HISI   HISI-D02 20140727 HISI 00000099)
ACPI: SRAT 0x000000007AA20000 0001B0 (v03 HISI   HISI-D02 20140727 HISI 00000099)
ACPI: IORT 0x000000007AA00000 0001FC (v00 INTEL  TEMPLATE 00000000 INTL 20150619)
psci: probing for conduit method from ACPI.
NOTICE:  [psci_smc_handler]:[349L] PSCI_VERSION CALL
NOTICE:  [psci_version]:[101L] PSCI_MAJOR_VER: 10000: PSCI_MINOR_VER: 0

0008;<54
psci: PSCIv1.0 detected in firmware.
psci: Using standard PSCI v0.2 function IDs

0008;<54
psci: MIGRATE_INFO_TYPE not supported.

0008;<54

0008;<54
PERCPU: Embedded 15 pages/cpu @ffffffd1ffedb000 s24576 r8192 d28672 u61440
Detected PIPT I-cache on CPU0
CPU features: enabling workaround for ARM erratum 832075
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2063376
Kernel command line: dtb=hip05-d02.dtb console=ttyS0,115200 earlycon=uart8250,mmio32,0x80300000 initrd=filesystem.cpio.gz acpi=force
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 61440 bytes
log_buf_len min size: 16384 bytes
log_buf_len: 131072 bytes
early log buf free: 12732(77%)
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
software IO TLB [mem 0x76a00000-0x7aa00000] (64MB) mapped at [ffffffc076a00000-ffffffc07a9fffff]
Memory: 8052312K/8384512K available (6074K kernel code, 519K rwdata, 2556K rodata, 572K init, 212K bss, 315816K reserved, 16384K cma-reserved)
Virtual kernel memory layout:
     vmalloc : 0xffffff8000000000 - 0xffffffbdbfff0000   (   246 GB)
     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
               0xffffffbdc0000000 - 0xffffffbe08000000   (  1152 MB actual)
     fixed   : 0xffffffbffa7fd000 - 0xffffffbffac00000   (  4108 KB)
     PCI I/O : 0xffffffbffae00000 - 0xffffffbffbe00000   (    16 MB)
     modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)
     memory  : 0xffffffc000000000 - 0xffffffd200000000   ( 73728 MB)
       .init : 0xffffffc0008f0000 - 0xffffffc00097f000   (   572 KB)
       .text : 0xffffffc000080000 - 0xffffffc0008efa34   (  8639 KB)
       .data : 0xffffffc000994000 - 0xffffffc000a15c00   (   519 KB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
Preemptible hierarchical RCU implementation.
	Build-time adjustment of leaf fanout to 64.
	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=16
NR_IRQS:64 nr_irqs:64 0
GIC: Using split EOI/Deactivate mode
ITS@0x8c000000
ITS: allocated 65536 Devices @11f6c80000 (psz 4K, shr 1)
ITS: allocated 512 Virtual CPUs @11f6c0d000 (psz 4K, shr 1)
ITS: allocated 512 Interrupt Collections @11f6c0e000 (psz 4K, shr 1)
ITS@0xc6000000
ITS: allocated 65536 Devices @11f6d00000 (psz 4K, shr 1)
ITS: allocated 512 Virtual CPUs @11f6c0f000 (psz 4K, shr 1)
ITS: allocated 512 Interrupt Collections @11f6c30000 (psz 4K, shr 1)
ITS@0xa3000000
ITS: allocated 65536 Devices @11f6d80000 (psz 4K, shr 1)
ITS: allocated 512 Virtual CPUs @11f6c33000 (psz 4K, shr 1)
ITS: allocated 512 Interrupt Collections @11f6c34000 (psz 4K, shr 1)
ITS@0xb7000000
ITS: allocated 65536 Devices @11f6e00000 (psz 4K, shr 1)
ITS: allocated 512 Virtual CPUs @11f6c35000 (psz 4K, shr 1)
ITS: allocated 512 Interrupt Collections @11f6c36000 (psz 4K, shr 1)
GIC: using LPI property table @0x00000011f6c60000
ITS: Allocated 1792 chunks for LPIs
CPU0: found redistributor 20000 region 0:0x000000008d100000
CPU0: using LPI pending table @0x00000011f6c70000
Architected cp15 timer(s) running at 50.00MHz (phys).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
Console: colour dummy device 80x25
Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
pid_max: default: 32768 minimum: 301
ACPI: Core revision 20150930
ACPI: 1 ACPI AML tables successfully acquired and loaded
Security Framework initialized
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
Initializing cgroup subsys memory
Initializing cgroup subsys hugetlb
Remapping and enabling EFI services.
   EFI remap 0x000000007aab0000 => 0000000040000000
   EFI remap 0x000000007aaf0000 => 0000000040040000
   EFI remap 0x000000007ab00000 => 0000000040050000
   EFI remap 0x000000007ab30000 => 0000000040060000
   EFI remap 0x000000007ab70000 => 00000000400a0000
   EFI remap 0x000000007aba0000 => 00000000400c0000
   EFI remap 0x000000007fb90000 => 00000000400d0000
   EFI remap 0x000000007fbb0000 => 00000000400e0000
   EFI remap 0x0000000080300000 => 0000000040110000
   EFI remap 0x00000000a00f0000 => 0000000040120000
ASID allocator initialised with 65536 entries
PCI/MSI: ITS@0x8c000000 domain created
PCI/MSI: ITS@0xc6000000 domain created
PCI/MSI: ITS@0xa3000000 domain created
PCI/MSI: ITS@0xb7000000 domain created
Platform MSI: irqchip@000000008c000000 domain created
Platform MSI: irqchip@00000000c6000000 domain created
Platform MSI: irqchip@00000000a3000000 domain created
Platform MSI: irqchip@00000000b7000000 domain created
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20001 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x1


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c080
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3d190
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20002 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x1


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c100
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3d3a0
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20003 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x1


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c180
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3d5b0
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20100 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x3


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c200
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3d7c0
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20101 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x3


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c280
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3d9d0
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20102 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x3


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c300
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3dbe0
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20103 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x3


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c380
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3ddf0
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20200 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x7


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c400
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3e000
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20201 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x7


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c480
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3e210
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20202 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x7


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c500
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3e420
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20203 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0x7


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c580
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3e630
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20300 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0xf


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c600
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3e840
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20301 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0xf

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0xf


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c680
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3ea50
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20302 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0xf

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0xf


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c700
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3ec60
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
NOTICE:  [psci_smc_handler]:[410L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[411L] x1=0x20303 x2=0x827d0 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[89L] domain_cluster=0xf

NOTICE:  [scpi_set_css_power_state]:[97L] domain_cluster=0xf


0008;<AB54
NOTICE:  [psci_afflvl_power_on_finish]:[508L]
NOTICE:  [cm_prepare_el3_exit]:[266L] read_tpidr_el3 = 7fc3c780
NOTICE:  [cm_prepare_el3_exit]:[321L] ctx add = 7fc3ee70
NOTICE:  [psci_afflvl_power_on_finish]:[566L]

000827=0
Detected PIPT I-cache on CPU1
CPU1: found redistributor 20001 region 0:0x000000008d130000
CPU1: using LPI pending table @0x00000011f6400000
CPU1: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU2
CPU2: found redistributor 20002 region 0:0x000000008d160000
CPU2: using LPI pending table @0x00000011f6430000
CPU2: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU3
CPU3: found redistributor 20003 region 0:0x000000008d190000
CPU3: using LPI pending table @0x00000011f6460000
CPU3: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU4
CPU4: found redistributor 20100 region 0:0x000000008d1c0000
CPU4: using LPI pending table @0x00000011f64a0000
CPU4: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU5
CPU5: found redistributor 20101 region 0:0x000000008d1f0000
CPU5: using LPI pending table @0x00000011f64d0000
CPU5: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU6
CPU6: found redistributor 20102 region 0:0x000000008d220000
CPU6: using LPI pending table @0x00000011f6500000
CPU6: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU7
CPU7: found redistributor 20103 region 0:0x000000008d250000
CPU7: using LPI pending table @0x00000011f6540000
CPU7: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU8
CPU8: found redistributor 20200 region 0:0x000000008d280000
CPU8: using LPI pending table @0x00000011f6560000
CPU8: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU9
CPU9: found redistributor 20201 region 0:0x000000008d2b0000
CPU9: using LPI pending table @0x00000011f65a0000
CPU9: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU10
CPU10: found redistributor 20202 region 0:0x000000008d2e0000
CPU10: using LPI pending table @0x00000011f65d0000
CPU10: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU11
CPU11: found redistributor 20203 region 0:0x000000008d310000
CPU11: using LPI pending table @0x00000011f6600000
CPU11: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU12
CPU12: found redistributor 20300 region 0:0x000000008d340000
CPU12: using LPI pending table @0x00000011f6630000
CPU12: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU13
CPU13: found redistributor 20301 region 0:0x000000008d370000
CPU13: using LPI pending table @0x00000011f6670000
CPU13: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU14
CPU14: found redistributor 20302 region 0:0x000000008d3a0000
CPU14: using LPI pending table @0x00000011f66a0000
CPU14: Booted secondary processor [411fd071]
Detected PIPT I-cache on CPU15
CPU15: found redistributor 20303 region 0:0x000000008d3d0000
CPU15: using LPI pending table @0x00000011f66d0000
CPU15: Booted secondary processor [411fd071]
Brought up 16 CPUs
SMP: Total of 16 processors activated.
CPU features: detected feature: GIC system register CPU interface
CPU: All CPU(s) started at EL2
alternatives: patching kernel code
devtmpfs: initialized
SMBIOS 3.0.0 present.
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
cpuidle: using governor ladder
cpuidle: using governor menu
vdso: 2 pages (1 code @ ffffffc000999000, 1 data @ ffffffc000998000)
hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
DMA: preallocated 256 KiB pool for atomic allocations
ACPI: bus type PCI registered
Serial: AMBA PL011 UART driver
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Interpreter enabled
ACPI: Using GIC for interrupt routing
PCI: MMCONFIG for domain 0001 [bus 00-3f] at [mem 0x22000000000-0x22003ffffff] (base 0x22000000000)
PCI: MMCONFIG for domain 0002 [bus 40-7f] at [mem 0x24004000000-0x24007ffffff] (base 0x24000000000)
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: IORT: can't find node related to (null) device
ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus 00-3f])
acpi HISI0080:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi HISI0080:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
acpi HISI0080:00: PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [mem 0x22004000000-0x2200ffeffff window] (bus address [0xb0000000-0xbbfeffff])
pci_bus 0001:00: root bus resource [io  0x0000-0xffff window]
pci_bus 0001:00: root bus resource [bus 00-3f]
pci 0001:00:00.0: of_irq_parse_pci() failed with rc=-22
pci 0001:00:00.0: of_irq_parse_pci() failed with rc=-22
pci 0001:00:00.0: BAR 8: assigned [mem 0x22004000000-0x220041fffff]
pci 0001:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0001:01:00.0: BAR 6: assigned [mem 0x22004000000-0x220040fffff pref]
pci 0001:01:00.0: BAR 1: assigned [mem 0x22004100000-0x2200410ffff 64bit]
pci 0001:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
pci 0001:00:00.0: PCI bridge to [bus 01]
pci 0001:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0001:00:00.0:   bridge window [mem 0x22004000000-0x220041fffff]
ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 40-7f])
acpi HISI0080:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi HISI0080:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
acpi HISI0080:01: PCI host bridge to bus 0002:40
pci_bus 0002:40: root bus resource [mem 0x24008000000-0x2400ffeffff window] (bus address [0xc0000000-0xc7feffff])
pci_bus 0002:40: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
pci_bus 0002:40: root bus resource [bus 40-7f]
pci 0002:40:00.0: of_irq_parse_pci() failed with rc=-22
pci 0002:40:00.0: Primary bus is hard wired to 0
pci 0002:40:00.0: bridge configuration invalid ([bus 01-01]), reconfiguring
pci 0002:40:00.0: of_irq_parse_pci() failed with rc=-22
pci 0002:40:00.0: of_irq_parse_pci() failed with rc=-22
pci 0002:40:00.0: BAR 8: assigned [mem 0x24008000000-0x240087fffff]
pci 0002:40:00.0: BAR 9: assigned [mem 0x24008800000-0x240091fffff 64bit pref]
pci 0002:40:00.0: BAR 7: assigned [io  0x10000-0x10fff]
pci 0002:41:00.0: BAR 0: assigned [mem 0x24008800000-0x24008bfffff 64bit pref]
pci 0002:41:00.0: BAR 6: assigned [mem 0x24008000000-0x240083fffff pref]
pci 0002:41:00.1: BAR 0: assigned [mem 0x24008c00000-0x24008ffffff 64bit pref]
pci 0002:41:00.1: BAR 6: assigned [mem 0x24008400000-0x240087fffff pref]
pci 0002:41:00.0: BAR 4: assigned [mem 0x24009000000-0x24009003fff 64bit pref]
pci 0002:41:00.1: BAR 4: assigned [mem 0x24009004000-0x24009007fff 64bit pref]
pci 0002:41:00.0: BAR 2: assigned [io  0x10000-0x1001f]
pci 0002:41:00.1: BAR 2: assigned [io  0x10020-0x1003f]
pci 0002:40:00.0: PCI bridge to [bus 41]
pci 0002:40:00.0:   bridge window [io  0x10000-0x10fff]
pci 0002:40:00.0:   bridge window [mem 0x24008000000-0x240087fffff]
pci 0002:40:00.0:   bridge window [mem 0x24008800000-0x240091fffff 64bit pref]
vgaarb: loaded
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
clocksource: Switched to clocksource arch_sys_counter
pnp: PnP ACPI init
pnp: PnP ACPI: found 0 devices
NET: Registered protocol family 2
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
UDP hash table entries: 4096 (order: 5, 131072 bytes)
UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Unpacking initramfs...
Freeing initrd memory: 27492K (ffffffc01e520000 - ffffffc01fff9000)
kvm [1]: error: no compatible GIC node found
kvm [1]: error initializing Hyp mode: -19
ACPI: IORT: can't find node related to (null) device
futex hash table entries: 4096 (order: 7, 524288 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1.720:1): initialized
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
fuse init (API version 7.23)
9p: Installing v9fs 9p2000 file system support
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler noop registered
io scheduler cfq registered (default)
pcieport 0001:00:00.0: can't derive routing for PCI INT A
pcieport 0001:00:00.0: PCI INT A: no GSI
pcieport 0002:40:00.0: can't derive routing for PCI INT A
pcieport 0002:40:00.0: PCI INT A: no GSI
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
console [ttyS0] disabled
APMC0D08:00: ttyS0 at MMIO 0x80300000 (irq = 5, base_baud = 12500000) is a 16550A
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [uart0] disabled
bootconsole [uart0] disabled
msm_serial: driver initialized
Failed to find cpu0 device node
Unable to detect cache hierarchy from DT for CPU 0
loop: module loaded
hisi_sas: driver version v1.0
scsi host0: hisi_sas
scsi host1: hisi_sas
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
libphy: Hisilicon MII Bus: probed
hisi_sas_v1_hw HISI0161:01: phyup: phy7 link_rate=10
scsi 1:0:0:0: Direct-Access     SEAGATE  ST9500620SS      AS02 PQ: 0 ANSI: 5
sd 1:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 1:0:0:0: [sda] Attached SCSI disk
hns-nic HISI00C1:00: No valid mac, use random mac da:3a:ad:09:a3:14
netif_napi_add() called with weight 256 on device eth%d
hns-nic HISI00C1:01: No valid mac, use random mac ea:58:90:0b:08:bc
hns-nic HISI00C1:02: No valid mac, use random mac 2a:ef:14:d5:0f:41
hns-nic HISI00C1:03: No valid mac, use random mac 7a:77:63:4e:57:89
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.2.1-k
ixgbe: Copyright (c) 1999-2015 Intel Corporation.
pcieport 0002:40:00.0: can't derive routing for PCI INT A
ixgbe 0002:41:00.0: PCI INT A: no GSI
ixgbe 0002:41:00.0: enabling device (0000 -> 0002)
ixgbe 0002:41:00.0: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
ixgbe 0002:41:00.0: PCI Express bandwidth of 32GT/s available
ixgbe 0002:41:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 0002:41:00.0: MAC: 2, PHY: 17, SFP+: 5, PBA No: FFFFFF-0FF
ixgbe 0002:41:00.0: 68:a8:28:2e:c9:10
ixgbe 0002:41:00.0: Intel(R) 10 Gigabit Network Connection
pcieport 0002:40:00.0: can't derive routing for PCI INT B
ixgbe 0002:41:00.1: PCI INT B: no GSI
ixgbe 0002:41:00.1: enabling device (0000 -> 0002)
ixgbe 0002:41:00.1: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
ixgbe 0002:41:00.1: PCI Express bandwidth of 32GT/s available
ixgbe 0002:41:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 0002:41:00.1: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
ixgbe 0002:41:00.1: 68:a8:28:2e:c9:11
ixgbe 0002:41:00.1: Intel(R) 10 Gigabit Network Connection
sky2: driver version 1.30
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ehci-platform PNP0D20:00: EHCI Host Controller
ehci-platform PNP0D20:00: new USB bus registered, assigned bus number 1
ehci-platform PNP0D20:00: irq 6, io mem 0xa1000000
ehci-platform PNP0D20:00: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-platform: OHCI generic platform driver
usbcore: registered new interface driver usb-storage
mousedev: PS/2 mouse device common for all mice
rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
Synopsys Designware Multimedia Card Interface Driver
sdhci-pltfm: SDHCI platform and OF driver helper
ledtrig-cpu: registered to indicate activity on CPUs
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
NET: Registered protocol family 17
9pnet: Installing 9P2000 support
Key type dns_resolver registered
registered taskstats version 1
rtc-efi rtc-efi: setting system clock to 2100-01-01 00:02:52 UTC (4102444972)
ttyS0 - failed to request DMA
Freeing unused kernel memory: 572K (ffffffc0008f0000 - ffffffc00097f000)
Freeing alternatives memory: 60K (ffffffc00097f000 - ffffffc00098e000)
root@(none)$ ifconfig eth4 192.168.20.188
ixgbe 0002:41:00.0: registered PHC device on eth4
root@(none)$ ixgbe 0002:41:00.0 eth4: detected SFP+: 5
ixgbe 0002:41:00.0 eth4: NIC Link is Up 10 Gbps, Flow Control: RX/TX

root@(none)$ ping 192.168.20.4
PING 192.168.20.4 (192.168.20.4): 56 data bytes
64 bytes from 192.168.20.4: seq=21 ttl=128 time=0.368 ms
64 bytes from 192.168.20.4: seq=22 ttl=128 time=0.257 ms
64 bytes from 192.168.20.4: seq=23 ttl=128 time=0.316 ms
64 bytes from 192.168.20.4: seq=24 ttl=128 time=0.355 ms
64 bytes from 192.168.20.4: seq=25 ttl=128 time=0.257 ms
64 bytes from 192.168.20.4: seq=26 ttl=128 time=0.305 ms
64 bytes from 192.168.20.4: seq=27 ttl=128 time=0.290 ms
64 bytes from 192.168.20.4: seq=28 ttl=128 time=0.227 ms
64 bytes from 192.168.20.4: seq=29 ttl=128 time=3.865 ms
64 bytes from 192.168.20.4: seq=30 ttl=128 time=0.297 ms
