Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
To: Tomasz Nowicki <tn@semihalf.com>, <helgaas@kernel.org>, <arnd@arndb.de>,
        <will.deacon@arm.com>, <catalin.marinas@arm.com>, <rafael@kernel.org>,
        <hanjun.guo@linaro.org>, <Lorenzo.Pieralisi@arm.com>,
        <okaya@codeaurora.org>, <jchandra@broadcom.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
CC: <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
        <Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
        <wangyijing@huawei.com>, <Suravee.Suthikulpanit@amd.com>,
        <msalter@redhat.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linaro-acpi@lists.linaro.org>,
        <jcm@redhat.com>, <andrea.gallo@linaro.org>, <dhdang@apm.com>,
        <jeremy.linton@arm.com>, <cov@codeaurora.org>,
        Linuxarm
	<linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <5742E893.1060004@huawei.com>
Date: Mon, 23 May 2016 19:25:07 +0800
MIME-Version: 1.0
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="gbk"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



ÔÚ 2016/5/10 23:19, Tomasz Nowicki Ð´µÀ:
>>From the functionality point of view this series may be split into the
> following logic parts:
> 1. New ECAM API and update for users of the pci-host-common API
> 2. Necessary fixes as the preparation for using driver on ARM64.
> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
>
> Patches has been built on top of 4.6-rc7 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v7)
>
> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.
>

Based on the patchset (with ECAM fix-up quirk added) and added the patch(Add ACPI support for HiSilicon PCIe Host Controllers).
Tested on the HiSilicon ARM64 D02 board.
It can work ok with Intel 82599 networking card.
This is the bootup log which contains PCIe host and Intel 82599 networking card part.

Tested-by: Dongdong Liu <liudongdong3@huawei.com>

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
GMAC ExitBootServicesEvent
SMMU ExitBootServicesEvent
[    0.000000] Booting Linux on physical CPU 0x20000
[    0.000000] Linux version 4.6.0-rc1+ (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #43 SMP PREEMPT Thu May 19 17:15:30 CST 2016
[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] earlycon: uart8250 at MMIO32 0x0000000080300000 (options '')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] EFI v2.50 by EDK II
[    0.000000] efi:  SMBIOS=0x7a650000  SMBIOS 3.0=0x7a630000  ACPI=0x7aba0000  ACPI 2.0=0x7aba0014
[    0.000000] cma: Reserved 16 MiB at 0x000000007e800000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007ABA0014 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x000000007A7000E8 000064 (v01 HISI   HISI-D02 20140727      01000013)
[    0.000000] ACPI: FACP 0x000000007A5F0000 00010C (v05 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: DSDT 0x000000007A5A0000 001656 (v01 HISI   HISI-D02 20140727 INTL 20150619)
[    0.000000] ACPI: DBG2 0x000000007A610000 00005A (v00 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: GTDT 0x000000007A5E0000 000060 (v02 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: APIC 0x000000007A5D0000 000554 (v01 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: MCFG 0x000000007A5C0000 00004C (v01 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: SPCR 0x000000007A5B0000 000050 (v02 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: IORT 0x000000007A590000 0001FC (v00 INTEL  TEMPLATE 00000000 INTL 20150619)
[    0.000000] ACPI: SSDT 0x000000007A580000 00046E (v01 HISI   SAS0     20140727 INTL 20150619)
[    0.000000] ACPI: SPCR: console: uart,mmio,0x80300000,115200
[    0.000000] psci: probing for conduit method from ACPI.
NOTICE:  [psci_smc_handler]:[347L] PSCI_VERSION CALL
NOTICE:  [psci_version]:[99L] PSCI_MAJOR_VER: 10000: PSCI_MINOR_VER: 0

0808?844
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs

0808?844
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.

0808?844

0808?844
[    0.000000] percpu: Embedded 20 pages/cpu @ffffffd1ffe7e000 s43008 r8192 d30720 u81920
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 832075
[    0.000000] CPU features: enabling workaround for ARM erratum 834220
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2063376
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon=uart8250,mmio32,0x80300000 initrd=filesystem.cpio.gz acpi=force pcie_aspm=off
[    0.000000] PCIe ASPM is disabled
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 61440 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 131072 bytes
[    0.000000] early log buf free: 12988(79%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] software IO TLB [mem 0x764e0000-0x7a4e0000] (64MB) mapped at [ffffffc0764e0000-ffffffc07a4dffff]
[    0.000000] Memory: 8110296K/8384512K available (7240K kernel code, 632K rwdata, 3028K rodata, 840K init, 247K bss, 257832K reserved, 16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffffff8008000000 - 0xffffffbdbfff0000   (   246 GB)
[    0.000000]       .text : 0xffffff8008080000 - 0xffffff8008790000   (  7232 KB)
[    0.000000]     .rodata : 0xffffff8008790000 - 0xffffff8008a89000   (  3044 KB)
[    0.000000]       .init : 0xffffff8008a89000 - 0xffffff8008b5b000   (   840 KB)
[    0.000000]       .data : 0xffffff8008b5b000 - 0xffffff8008bf9200   (   633 KB)
[    0.000000]     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
[    0.000000]               0xffffffbdc0000000 - 0xffffffbe08000000   (  1152 MB actual)
[    0.000000]     fixed   : 0xffffffbffe7fd000 - 0xffffffbffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffffffbffee00000 - 0xffffffbfffe00000   (    16 MB)
[    0.000000]     memory  : 0xffffffc000000000 - 0xffffffd200000000   ( 73728 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=16
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] ITS@0x8c000000
[    0.000000] ITS: allocated 65536 Devices @11f6c80000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Virtual CPUs @11f6c0f000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Interrupt Collections @11f6c20000 (psz 4K, shr 1)
[    0.000000] ITS@0xc6000000
[    0.000000] ITS: allocated 65536 Devices @11f6d00000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Virtual CPUs @11f6c21000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Interrupt Collections @11f6c22000 (psz 4K, shr 1)
[    0.000000] ITS@0xa3000000
[    0.000000] ITS: allocated 65536 Devices @11f6d80000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Virtual CPUs @11f6c24000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Interrupt Collections @11f6c25000 (psz 4K, shr 1)
[    0.000000] ITS@0xb7000000
[    0.000000] ITS: allocated 65536 Devices @11f6e00000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Virtual CPUs @11f6c26000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Interrupt Collections @11f6c27000 (psz 4K, shr 1)
[    0.000000] GIC: using LPI property table @0x00000011f6c60000
[    0.000000] ITS: Allocated 1792 chunks for LPIs
[    0.000000] CPU0: found redistributor 20000 region 0:0x000000008d100000
[    0.000000] CPU0: using LPI pending table @0x00000011f6c70000
[    0.000000] Unable to get hardware information used for virtualization
[    0.000000] GTDT: No Platform Timer structures.
[    0.000000] arch_timer: Can't find GT Block.
[    0.000000] Architected cp15 and mmio timer(s) running at 50.00MHz (phys/phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000001] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.008025] Console: colour dummy device 80x25
[    0.012459] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.022850] pid_max: default: 32768 minimum: 301
[    0.027450] ACPI: Core revision 20160108
[    0.032284] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.038617]
[    0.040126] Security Framework initialized
[    0.044213] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.051053] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.058747] ASID allocator initialised with 65536 entries
[    0.064393] PCI/MSI: ITS@0x8c000000 domain created
[    0.069162] PCI/MSI: ITS@0xc6000000 domain created
[    0.073927] PCI/MSI: ITS@0xa3000000 domain created
[    0.078693] PCI/MSI: ITS@0xb7000000 domain created
[    0.083463] Platform MSI: irqchip@000000008c000000 domain created
[    0.089525] Platform MSI: irqchip@00000000c6000000 domain created
[    0.095586] Platform MSI: irqchip@00000000a3000000 domain created
[    0.101648] Platform MSI: irqchip@00000000b7000000 domain created
[    0.107753] Remapping and enabling EFI services.
[    0.112370]   EFI remap 0x000000007a4e0000 => 0000000020000000
[    0.118185]   EFI remap 0x000000007a530000 => 0000000020050000
[    0.124008]   EFI remap 0x000000007a620000 => 00000000200a0000
[    0.129822]   EFI remap 0x000000007a6b0000 => 0000000020130000
[    0.135636]   EFI remap 0x000000007a710000 => 0000000020180000
[    0.141454]   EFI remap 0x000000007a760000 => 00000000201d0000
[    0.147269]   EFI remap 0x000000007a7b0000 => 0000000020220000
[    0.153083]   EFI remap 0x000000007a800000 => 0000000020270000
[    0.158897]   EFI remap 0x000000007a850000 => 00000000202c0000
[    0.164711]   EFI remap 0x000000007a8a0000 => 0000000020310000
[    0.170525]   EFI remap 0x000000007a8f0000 => 0000000020360000
[    0.176339]   EFI remap 0x000000007a940000 => 00000000203b0000
[    0.182160]   EFI remap 0x000000007a990000 => 0000000020400000
[    0.187974]   EFI remap 0x000000007aa00000 => 0000000020470000
[    0.193788]   EFI remap 0x000000007aa50000 => 00000000204c0000
[    0.199602]   EFI remap 0x000000007aaa0000 => 0000000020510000
[    0.205417]   EFI remap 0x000000007aaf0000 => 0000000020560000
[    0.211230]   EFI remap 0x000000007ab40000 => 00000000205b0000
[    0.217043]   EFI remap 0x000000007fbb0000 => 0000000020600000
[    0.222849]   EFI remap 0x0000000080300000 => 0000000020630000
[    0.228654]   EFI remap 0x00000000a00f0000 => 0000000020640000
[    0.234457]   EFI remap 0x00000000a4000000 => 0000000020800000
[    0.240266]   EFI remap 0x00000000a6000000 => 0000000021800000
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20001 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x1


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c080
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d190
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20002 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x1


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c100
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d3a0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20003 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x1


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c180
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d5b0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20100 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x3


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c200
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d7c0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20101 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x3


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c280
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d9d0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20102 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x3


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c300
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3dbe0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20103 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x3


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c380
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3ddf0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20200 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x7


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c400
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e000
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20201 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x7


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c480
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e210
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20202 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x7


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c500
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e420
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20203 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x7


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c580
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e630
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20300 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0xf


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c600
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e840
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20301 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0xf

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0xf


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c680
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3ea50
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20302 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0xf

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0xf


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c700
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3ec60
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20303 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0xf

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0xf


0808?8AB44
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c780
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3ee70
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
[    0.288031] Detected PIPT I-cache on CPU1
[    0.288043] CPU1: found redistributor 20001 region 1:0x000000008d130000
[    0.288064] CPU1: using LPI pending table @0x00000011f6410000
[    0.288122] CPU1: Booted secondary processor [411fd071]
[    0.331143] Detected PIPT I-cache on CPU2
[    0.331150] CPU2: found redistributor 20002 region 2:0x000000008d160000
[    0.331170] CPU2: using LPI pending table @0x00000011f6440000
[    0.331218] CPU2: Booted secondary processor [411fd071]
[    0.374257] Detected PIPT I-cache on CPU3
[    0.374263] CPU3: found redistributor 20003 region 3:0x000000008d190000
[    0.374283] CPU3: using LPI pending table @0x00000011f6480000
[    0.374328] CPU3: Booted secondary processor [411fd071]
[    0.417372] Detected PIPT I-cache on CPU4
[    0.417380] CPU4: found redistributor 20100 region 4:0x000000008d1c0000
[    0.417400] CPU4: using LPI pending table @0x00000011f64c0000
[    0.417447] CPU4: Booted secondary processor [411fd071]
[    0.460484] Detected PIPT I-cache on CPU5
[    0.460491] CPU5: found redistributor 20101 region 5:0x000000008d1f0000
[    0.460511] CPU5: using LPI pending table @0x00000011f64f0000
[    0.460558] CPU5: Booted secondary processor [411fd071]
[    0.503598] Detected PIPT I-cache on CPU6
[    0.503605] CPU6: found redistributor 20102 region 6:0x000000008d220000
[    0.503625] CPU6: using LPI pending table @0x00000011f6530000
[    0.503669] CPU6: Booted secondary processor [411fd071]
[    0.546711] Detected PIPT I-cache on CPU7
[    0.546718] CPU7: found redistributor 20103 region 7:0x000000008d250000
[    0.546738] CPU7: using LPI pending table @0x00000011f6560000
[    0.546783] CPU7: Booted secondary processor [411fd071]
[    0.589826] Detected PIPT I-cache on CPU8
[    0.589835] CPU8: found redistributor 20200 region 8:0x000000008d280000
[    0.589857] CPU8: using LPI pending table @0x00000011f65a0000
[    0.589910] CPU8: Booted secondary processor [411fd071]
[    0.632939] Detected PIPT I-cache on CPU9
[    0.632946] CPU9: found redistributor 20201 region 9:0x000000008d2b0000
[    0.632967] CPU9: using LPI pending table @0x00000011f65e0000
[    0.633014] CPU9: Booted secondary processor [411fd071]
[    0.676052] Detected PIPT I-cache on CPU10
[    0.676060] CPU10: found redistributor 20202 region 10:0x000000008d2e0000
[    0.676081] CPU10: using LPI pending table @0x00000011f6610000
[    0.676126] CPU10: Booted secondary processor [411fd071]
[    0.719166] Detected PIPT I-cache on CPU11
[    0.719173] CPU11: found redistributor 20203 region 11:0x000000008d310000
[    0.719195] CPU11: using LPI pending table @0x00000011f6650000
[    0.719240] CPU11: Booted secondary processor [411fd071]
[    0.762280] Detected PIPT I-cache on CPU12
[    0.762289] CPU12: found redistributor 20300 region 12:0x000000008d340000
[    0.762311] CPU12: using LPI pending table @0x00000011f6680000
[    0.762360] CPU12: Booted secondary processor [411fd071]
[    0.805392] Detected PIPT I-cache on CPU13
[    0.805400] CPU13: found redistributor 20301 region 13:0x000000008d370000
[    0.805421] CPU13: using LPI pending table @0x00000011f66c0000
[    0.805466] CPU13: Booted secondary processor [411fd071]
[    0.848506] Detected PIPT I-cache on CPU14
[    0.848513] CPU14: found redistributor 20302 region 14:0x000000008d3a0000
[    0.848534] CPU14: using LPI pending table @0x00000011f6700000
[    0.848579] CPU14: Booted secondary processor [411fd071]
[    0.891620] Detected PIPT I-cache on CPU15
[    0.891628] CPU15: found redistributor 20303 region 15:0x000000008d3d0000
[    0.891648] CPU15: using LPI pending table @0x00000011f6750000
[    0.891693] CPU15: Booted secondary processor [411fd071]
[    0.891723] Brought up 16 CPUs
[    1.220754] SMP: Total of 16 processors activated.
[    1.225520] CPU features: detected feature: GIC system register CPU interface
[    1.232620] CPU: All CPU(s) started at EL2
[    1.236718] alternatives: patching kernel code
[    1.243905] devtmpfs: initialized
[    1.247446] SMBIOS 3.0.0 present.
[    1.250851] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.260790] pinctrl core: initialized pinctrl subsystem
[    1.266365] NET: Registered protocol family 16
[    1.282800] cpuidle: using governor menu
[    1.286747] vdso: 2 pages (1 code @ ffffff8008796000, 1 data @ ffffff8008b60000)
[    1.294122] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    1.301211] DMA: preallocated 256 KiB pool for atomic allocations
[    1.307340] ACPI: bus type PCI registered
[    1.311388] Serial: AMBA PL011 UART driver
[    1.331638] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.338373] ACPI: Added _OSI(Module Device)
[    1.342562] ACPI: Added _OSI(Processor Device)
[    1.346984] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.351664] ACPI: Added _OSI(Processor Aggregator Device)
[    1.358469] ACPI: Interpreter enabled
[    1.362116] ACPI: Using GIC for interrupt routing
[    1.366815] ACPI: MCFG table loaded, 2 entries detected
[    1.375180] Hisilicon MBIGEN-V1 HISI0151:00: Allocated 256 MSIs
[    1.381158] Hisilicon MBIGEN-V1 HISI0151:01: Allocated 640 MSIs
[    1.387123] Hisilicon MBIGEN-V1 HISI0151:02: Allocated 256 MSIs
[    1.393091] Hisilicon MBIGEN-V1 HISI0151:03: Allocated 640 MSIs
[    1.399213] ACPI: IORT: can't find node related to (null) device
[    1.405292] ACPI: IORT: can't find node related to (null) device
[    1.411324] ACPI: IORT: can't find node related to (null) device
[    1.417348] ACPI: IORT: can't find node related to (null) device
[    1.423370] ACPI: IORT: can't find node related to (null) device
[    1.429391] ACPI: IORT: can't find node related to (null) device
[    1.436634] ACPI: IORT: can't find node related to (null) device
[    1.442681] ACPI: IORT: can't find node related to (null) device
[    1.448698] ACPI: IORT: can't find node related to (null) device
[    1.454712] ACPI: IORT: can't find node related to (null) device
[    1.460724] ACPI: IORT: can't find node related to (null) device
[    1.466764] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus 40-7f])
[    1.472918] acpi HISI0080:00: _OSC: OS supports [ExtendedConfig Segments MSI]
[    1.480025] acpi HISI0080:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.486771] acpi HISI0080:00: ECAM at [mem 0x22004000000-0x22007ffffff] for [bus 40-7f]
[    1.494762] Remapped I/O 0x000002200fff0000 to [io  0x0000-0xffff window]
[    1.501592] PCI host bridge to bus 0001:40
[    1.505671] pci_bus 0001:40: root bus resource [mem 0x22008000000-0x2200ffeffff window] (bus address [0xb0000000-0xb7feffff])
[    1.516919] pci_bus 0001:40: root bus resource [io  0x0000-0xffff window]
[    1.523675] pci_bus 0001:40: root bus resource [bus 40-7f]
[    1.534090] pci 0001:41:00.0: VF(n) BAR0 space: [mem 0x22008e08000-0x22008f07fff 64bit pref] (contains BAR0 for 64 VFs)
[    1.545323] pci 0001:41:00.0: VF(n) BAR3 space: [mem 0x22008f08000-0x22009007fff 64bit pref] (contains BAR3 for 64 VFs)
[    1.568223] pci 0001:41:00.1: VF(n) BAR0 space: [mem 0x22008c04000-0x22008d03fff 64bit pref] (contains BAR0 for 64 VFs)
[    1.579460] pci 0001:41:00.1: VF(n) BAR3 space: [mem 0x22008d04000-0x22008e03fff 64bit pref] (contains BAR3 for 64 VFs)
[    1.597823] pci 0001:40:00.0: BAR 15: assigned [mem 0x22008000000-0x220095fffff pref]
[    1.605616] pci 0001:40:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    1.611771] pci 0001:41:00.0: BAR 0: assigned [mem 0x22008000000-0x220083fffff 64bit pref]
[    1.620245] pci 0001:41:00.0: BAR 6: assigned [mem 0x22008400000-0x220087fffff pref]
[    1.627952] pci 0001:41:00.1: BAR 0: assigned [mem 0x22008800000-0x22008bfffff 64bit pref]
[    1.636430] pci 0001:41:00.1: BAR 6: assigned [mem 0x22008c00000-0x22008ffffff pref]
[    1.644138] pci 0001:41:00.0: BAR 4: assigned [mem 0x22009000000-0x22009003fff 64bit pref]
[    1.652610] pci 0001:41:00.0: BAR 7: assigned [mem 0x22009004000-0x22009103fff 64bit pref]
[    1.661083] pci 0001:41:00.0: BAR 10: assigned [mem 0x22009104000-0x22009203fff 64bit pref]
[    1.669640] pci 0001:41:00.1: BAR 4: assigned [mem 0x22009204000-0x22009207fff 64bit pref]
[    1.678115] pci 0001:41:00.1: BAR 7: assigned [mem 0x22009208000-0x22009307fff 64bit pref]
[    1.686591] pci 0001:41:00.1: BAR 10: assigned [mem 0x22009308000-0x22009407fff 64bit pref]
[    1.695148] pci 0001:41:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    1.701285] pci 0001:41:00.1: BAR 2: assigned [io  0x1020-0x103f]
[    1.707421] pci 0001:40:00.0: PCI bridge to [bus 41-42]
[    1.712621] pci 0001:40:00.0:   bridge window [io  0x1000-0x1fff]
[    1.718685] pci 0001:40:00.0:   bridge window [mem 0x22008000000-0x220095fffff pref]
[    1.726434] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-bf])
[    1.732594] acpi HISI0080:01: _OSC: OS supports [ExtendedConfig Segments MSI]
[    1.739696] acpi HISI0080:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.746425] acpi HISI0080:01: link status is down
[    1.751106] acpi HISI0080:01: ECAM at [mem 0x24008000000-0x2400bffffff] for [bus 80-bf]
[    1.759090] Remapped I/O 0x000002400fff0000 to [io  0x10000-0x1ffff window]
[    1.766086] PCI host bridge to bus 0002:80
[    1.770172] pci_bus 0002:80: root bus resource [mem 0x2400c000000-0x2400ffeffff window] (bus address [0xc0000000-0xc3feffff])
[    1.781422] pci_bus 0002:80: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
[    1.790940] pci_bus 0002:80: root bus resource [bus 80-bf]
[    1.796414] pci 0002:80:00.0: ignoring class 0x000000 (doesn't match header type 01)
[    1.804311] pci 0002:80:00.0: not setting up bridge for bus 0002:81
[    1.810956] ACPI: IORT: can't find node related to (null) device
[    1.817228] ACPI: IORT: can't find node related to (null) device
[    1.823453] vgaarb: loaded
[    1.826246] SCSI subsystem initialized
[    1.830103] ACPI: bus type USB registered
[    1.834130] usbcore: registered new interface driver usbfs
[    1.839606] usbcore: registered new interface driver hub
[    1.844933] usbcore: registered new device driver usb
[    1.850014] pps_core: LinuxPPS API ver. 1 registered
[    1.854953] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.864048] PTP clock support registered
[    1.868069] Advanced Linux Sound Architecture Driver Initialized.
[    1.874376] clocksource: Switched to clocksource arch_sys_counter
[    1.880489] VFS: Disk quotas dquot_6.6.0
[    1.884414] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.891385] pnp: PnP ACPI init
[    1.894570] system 00:00: [mem 0xb0080000-0xb008ffff] has been reserved
[    1.901209] system 00:01: [mem 0xb0090000-0xb009ffff] has been reserved
[    1.907813] pnp: PnP ACPI: found 2 devices
[    1.914467] NET: Registered protocol family 2
[    1.919030] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    1.926352] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.933333] TCP: Hash tables configured (established 65536 bind 65536)
[    1.939876] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.945968] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.952576] NET: Registered protocol family 1
[    1.957013] RPC: Registered named UNIX socket transport module.
[    1.962905] RPC: Registered udp transport module.
[    1.967586] RPC: Registered tcp transport module.
[    1.972266] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.978872] Unpacking initramfs...
[    2.340835] Freeing initrd memory: 27492K (ffffffc01e520000 - ffffffc01fff9000)
[    2.348645] kvm [1]: 8-bit VMID
[    2.351776] kvm [1]: Hyp mode initialized successfully
[    2.356892] kvm [1]: error: KVM vGIC probing failed
[    2.361790] kvm [1]: virtual timer IRQ3
[    2.366650] ACPI: IORT: can't find node related to (null) device
[    2.373057] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    2.379403] audit: initializing netlink subsys (disabled)
[    2.384813] audit: type=2000 audit(1.864:1): initialized
[    2.390302] workingset: timestamp_bits=44 max_order=21 bucket_order=0
[    2.400222] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.406342] NFS: Registering the id_resolver key type
[    2.411393] Key type id_resolver registered
[    2.415557] Key type id_legacy registered
[    2.419609] fuse init (API version 7.24)
[    2.423687] 9p: Installing v9fs 9p2000 file system support
[    2.429982] io scheduler noop registered
[    2.433946] io scheduler cfq registered (default)
[    2.439027] pcieport 0001:40:00.0: can't derive routing for PCI INT A
[    2.445438] pcieport 0001:40:00.0: PCI INT A: no GSI
[    2.451126] xenfs: not registering filesystem on non-xen platform
[    2.458262] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.465049] console [ttyS0] disabled
[    2.468627] APMC0D08:00: ttyS0 at MMIO 0x80300000 (irq = 5, base_baud = 12500000) is a 16550A
[    2.477133] console [ttyS0] enabled
[    2.477133] console [ttyS0] enabled
[    2.484137] bootconsole [uart8250] disabled
[    2.484137] bootconsole [uart8250] disabled
[    2.492728] SuperH (H)SCI(F) driver initialized
[    2.497322] msm_serial: driver initialized
[    2.501649] Failed to find cpu0 device node
[    2.505852] Unable to detect cache hierarchy from DT for CPU 0
[    2.514093] loop: module loaded
[    2.517694] tun: Universal TUN/TAP device driver, 1.6
[    2.522771] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.529079] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.534939] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.540908] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
[    2.547900] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.553518] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.0.2-k
[    2.561382] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    2.567350] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.2.1-k
[    2.575039] ixgbe: Copyright (c) 1999-2015 Intel Corporation.
[    2.580854] pcieport 0001:40:00.0: can't derive routing for PCI INT A
[    2.587326] ixgbe 0001:41:00.0: PCI INT A: no GSI
[    2.592178] ixgbe 0001:41:00.0: enabling device (0000 -> 0002)
[    2.753716] ixgbe 0001:41:00.0: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
[    2.762393] ixgbe 0001:41:00.0: PCI Express bandwidth of 32GT/s available
[    2.769213] ixgbe 0001:41:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    2.776457] ixgbe 0001:41:00.0: MAC: 2, PHY: 17, SFP+: 5, PBA No: FFFFFF-0FF
[    2.783537] ixgbe 0001:41:00.0: 68:a8:28:2e:c9:10
[    2.792732] ixgbe 0001:41:00.0: Intel(R) 10 Gigabit Network Connection
[    2.799312] pcieport 0001:40:00.0: can't derive routing for PCI INT B
[    2.805783] ixgbe 0001:41:00.1: PCI INT B: no GSI
[    2.810598] ixgbe 0001:41:00.1: enabling device (0000 -> 0002)
[    3.949697] ixgbe 0001:41:00.1: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
[    3.958365] ixgbe 0001:41:00.1: PCI Express bandwidth of 32GT/s available
[    3.965185] ixgbe 0001:41:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    3.972427] ixgbe 0001:41:00.1: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
[    3.978634] ixgbe 0001:41:00.1: 68:a8:28:2e:c9:11
[    3.987790] ixgbe 0001:41:00.1: Intel(R) 10 Gigabit Network Connection
[    3.994388] sky2: driver version 1.30
[    3.998201] VFIO - User Level meta-driver version: 0.3
[    4.003889] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.010459] ehci-pci: EHCI PCI platform driver
[    4.014944] ehci-platform: EHCI generic platform driver
[    4.020226] ehci-platform PNP0D20:00: EHCI Host Controller
[    4.025745] ehci-platform PNP0D20:00: new USB bus registered, assigned bus number 1
[    4.033572] ehci-platform PNP0D20:00: irq 6, io mem 0xa1000000
[    4.050387] ehci-platform PNP0D20:00: USB 2.0 started, EHCI 1.00
[    4.056652] hub 1-0:1.0: USB hub found
[    4.060428] hub 1-0:1.0: 1 port detected
[    4.064517] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    4.070137] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.076351] ohci-pci: OHCI PCI platform driver
[    4.080834] ohci-platform: OHCI generic platform driver
[    4.086166] usbcore: registered new interface driver usb-storage
[    4.092427] mousedev: PS/2 mouse device common for all mice
[    4.161533] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    4.168513] i2c /dev entries driver
[    4.172251] sdhci: Secure Digital Host Controller Interface driver
[    4.178458] sdhci: Copyright(c) Pierre Ossman
[    4.182850] Synopsys Designware Multimedia Card Interface Driver
[    4.188933] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.194701] ledtrig-cpu: registered to indicate activity on CPUs
[    4.200950] usbcore: registered new interface driver usbhid
[    4.206549] usbhid: USB HID core driver
[    4.210569] ACPI: IORT: can't find node related to (null) device
[    4.216837] NET: Registered protocol family 17
[    4.221334] 9pnet: Installing 9P2000 support
[    4.225652] Key type dns_resolver registered
[    4.230166] registered taskstats version 1
[    4.297850] rtc-efi rtc-efi: hctosys: unable to read the hardware clock
[    4.304576] ALSA device list:
[    4.307561]   No soundcards found.
[    4.311063] ttyS0 - failed to request DMA
[    4.315348] Freeing unused kernel memory: 840K (ffffff8008a89000 - ffffff8008b5b000)
root@(none)$ ifconfig eth0 192.168.20.188
[   15.679957] ixgbe 0001:41:00.0: registered PHC device on eth0
root@(none)$ [   15.851142] ixgbe 0001:41:00.0 eth0: detected SFP+: 5
[   15.990419] ixgbe 0001:41:00.0 eth0: NIC Link is Up 10 Gbps, Flow Control: RX/TX

root@(none)$ ping 192.168.20.188
PING 192.168.20.4 (192.168.20.4): 56 data bytes
64 bytes from 192.168.20.4: seq=14 ttl=128 time=1.465 ms
64 bytes from 192.168.20.4: seq=15 ttl=128 time=0.616 ms
64 bytes from 192.168.20.4: seq=16 ttl=128 time=0.391 ms
64 bytes from 192.168.20.4: seq=17 ttl=128 time=0.698 ms
64 bytes from 192.168.20.4: seq=18 ttl=128 time=0.676 ms
64 bytes from 192.168.20.4: seq=19 ttl=128 time=0.524 ms
64 bytes from 192.168.20.4: seq=20 ttl=128 time=0.301 ms
64 bytes from 192.168.20.4: seq=21 ttl=128 time=0.248 ms
64 bytes from 192.168.20.4: seq=22 ttl=128 time=0.403 ms
