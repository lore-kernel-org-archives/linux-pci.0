Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
Subject: Re: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
To: Tomasz Nowicki <tn@semihalf.com>, <helgaas@kernel.org>, <arnd@arndb.de>,
        <will.deacon@arm.com>, <catalin.marinas@arm.com>, <rafael@kernel.org>,
        <hanjun.guo@linaro.org>, <Lorenzo.Pieralisi@arm.com>,
        <okaya@codeaurora.org>, <jchandra@broadcom.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
CC: <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
        <Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
        <wangyijing@huawei.com>, <Suravee.Suthikulpanit@amd.com>,
        <msalter@redhat.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linaro-acpi@lists.linaro.org>,
        <jcm@redhat.com>, <andrea.gallo@linaro.org>, <dhdang@apm.com>,
        <jeremy.linton@arm.com>, <cov@codeaurora.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <5757E34E.1060401@huawei.com>
Date: Wed, 8 Jun 2016 17:20:14 +0800
MIME-Version: 1.0
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="gbk"; format=flowed
List-ID: <linux-pci.vger.kernel.org>


ÔÚ 2016/5/30 23:14, Tomasz Nowicki Ð´µÀ:
>>From the functionality point of view this series may be split into the
> following logic parts:
> 1. Export ECAM API and add parent device to pci_config_window
> 2. Add IO resources handling to PCI core code
> 3. Support for generic domain assignment based on ACPI
> 4. New MCFG driver
> 5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64/


Based on the patchset (with "[RFC PATCH 0/3] ECAM quirks handling for ARM64 platforms" added)
Tested on the HiSilicon ARM64 D02 board.
It worked ok with Intel 82599 networking card.
This is the bootup log which contains PCIe host and Intel 82599 networking card part.

Tested-by: Dongdong Liu <liudongdong3@huawei.com>

Loading driver at 0x0006D473000 EntryPoint=0x0006DE80100
Loading driver at 0x0006D473000 EntryPoint=0x0006DE80100
EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
GMAC ExitBootServicesEvent
SMMU ExitBootServicesEvent
[    0.000000] Booting Linux on physical CPU 0x20000
[    0.000000] Linux version 4.6.0-rc1+ (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #54 SMP PREEMPT Mon Jun 6 16:47:28 CST 2016
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
[    0.012456] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.022849] pid_max: default: 32768 minimum: 301
[    0.027449] ACPI: Core revision 20160108
[    0.032291] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.038623]
[    0.040133] Security Framework initialized
[    0.044221] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.051061] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.058750] ASID allocator initialised with 65536 entries
[    0.064391] PCI/MSI: ITS@0x8c000000 domain created
[    0.069169] PCI/MSI: ITS@0xc6000000 domain created
[    0.073935] PCI/MSI: ITS@0xa3000000 domain created
[    0.078700] PCI/MSI: ITS@0xb7000000 domain created
[    0.083471] Platform MSI: irqchip@000000008c000000 domain created
[    0.089533] Platform MSI: irqchip@00000000c6000000 domain created
[    0.095603] Platform MSI: irqchip@00000000a3000000 domain created
[    0.101673] Platform MSI: irqchip@00000000b7000000 domain created
[    0.107778] Remapping and enabling EFI services.
[    0.112396]   EFI remap 0x000000007a4e0000 => 0000000020000000
[    0.118212]   EFI remap 0x000000007a530000 => 0000000020050000
[    0.124035]   EFI remap 0x000000007a620000 => 00000000200a0000
[    0.129850]   EFI remap 0x000000007a6b0000 => 0000000020130000
[    0.135664]   EFI remap 0x000000007a710000 => 0000000020180000
[    0.141491]   EFI remap 0x000000007a760000 => 00000000201d0000
[    0.147306]   EFI remap 0x000000007a7b0000 => 0000000020220000
[    0.153120]   EFI remap 0x000000007a800000 => 0000000020270000
[    0.158934]   EFI remap 0x000000007a850000 => 00000000202c0000
[    0.164748]   EFI remap 0x000000007a8a0000 => 0000000020310000
[    0.170571]   EFI remap 0x000000007a8f0000 => 0000000020360000
[    0.176385]   EFI remap 0x000000007a940000 => 00000000203b0000
[    0.182207]   EFI remap 0x000000007a990000 => 0000000020400000
[    0.188022]   EFI remap 0x000000007aa00000 => 0000000020470000
[    0.193837]   EFI remap 0x000000007aa50000 => 00000000204c0000
[    0.199651]   EFI remap 0x000000007aaa0000 => 0000000020510000
[    0.205466]   EFI remap 0x000000007aaf0000 => 0000000020560000
[    0.211280]   EFI remap 0x000000007ab40000 => 00000000205b0000
[    0.217093]   EFI remap 0x000000007fbb0000 => 0000000020600000
[    0.222899]   EFI remap 0x0000000080300000 => 0000000020630000
[    0.228712]   EFI remap 0x00000000a00f0000 => 0000000020640000
[    0.234516]   EFI remap 0x00000000a4000000 => 0000000020800000
[    0.240324]   EFI remap 0x00000000a6000000 => 0000000021800000
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
[    0.288086] Detected PIPT I-cache on CPU1
[    0.288098] CPU1: found redistributor 20001 region 1:0x000000008d130000
[    0.288118] CPU1: using LPI pending table @0x00000011f6410000
[    0.288178] CPU1: Booted secondary processor [411fd071]
[    0.331198] Detected PIPT I-cache on CPU2
[    0.331204] CPU2: found redistributor 20002 region 2:0x000000008d160000
[    0.331225] CPU2: using LPI pending table @0x00000011f6440000
[    0.331272] CPU2: Booted secondary processor [411fd071]
[    0.374311] Detected PIPT I-cache on CPU3
[    0.374318] CPU3: found redistributor 20003 region 3:0x000000008d190000
[    0.374338] CPU3: using LPI pending table @0x00000011f6480000
[    0.374383] CPU3: Booted secondary processor [411fd071]
[    0.417427] Detected PIPT I-cache on CPU4
[    0.417435] CPU4: found redistributor 20100 region 4:0x000000008d1c0000
[    0.417455] CPU4: using LPI pending table @0x00000011f64c0000
[    0.417502] CPU4: Booted secondary processor [411fd071]
[    0.460539] Detected PIPT I-cache on CPU5
[    0.460546] CPU5: found redistributor 20101 region 5:0x000000008d1f0000
[    0.460565] CPU5: using LPI pending table @0x00000011f64f0000
[    0.460612] CPU5: Booted secondary processor [411fd071]
[    0.503653] Detected PIPT I-cache on CPU6
[    0.503660] CPU6: found redistributor 20102 region 6:0x000000008d220000
[    0.503679] CPU6: using LPI pending table @0x00000011f6530000
[    0.503726] CPU6: Booted secondary processor [411fd071]
[    0.546766] Detected PIPT I-cache on CPU7
[    0.546773] CPU7: found redistributor 20103 region 7:0x000000008d250000
[    0.546793] CPU7: using LPI pending table @0x00000011f6560000
[    0.546838] CPU7: Booted secondary processor [411fd071]
[    0.589881] Detected PIPT I-cache on CPU8
[    0.589890] CPU8: found redistributor 20200 region 8:0x000000008d280000
[    0.589911] CPU8: using LPI pending table @0x00000011f65a0000
[    0.589963] CPU8: Booted secondary processor [411fd071]
[    0.632994] Detected PIPT I-cache on CPU9
[    0.633001] CPU9: found redistributor 20201 region 9:0x000000008d2b0000
[    0.633021] CPU9: using LPI pending table @0x00000011f65e0000
[    0.633068] CPU9: Booted secondary processor [411fd071]
[    0.676107] Detected PIPT I-cache on CPU10
[    0.676114] CPU10: found redistributor 20202 region 10:0x000000008d2e0000
[    0.676136] CPU10: using LPI pending table @0x00000011f6610000
[    0.676182] CPU10: Booted secondary processor [411fd071]
[    0.719221] Detected PIPT I-cache on CPU11
[    0.719228] CPU11: found redistributor 20203 region 11:0x000000008d310000
[    0.719249] CPU11: using LPI pending table @0x00000011f6650000
[    0.719295] CPU11: Booted secondary processor [411fd071]
[    0.762335] Detected PIPT I-cache on CPU12
[    0.762344] CPU12: found redistributor 20300 region 12:0x000000008d340000
[    0.762365] CPU12: using LPI pending table @0x00000011f6680000
[    0.762414] CPU12: Booted secondary processor [411fd071]
[    0.805447] Detected PIPT I-cache on CPU13
[    0.805454] CPU13: found redistributor 20301 region 13:0x000000008d370000
[    0.805475] CPU13: using LPI pending table @0x00000011f66c0000
[    0.805521] CPU13: Booted secondary processor [411fd071]
[    0.848561] Detected PIPT I-cache on CPU14
[    0.848568] CPU14: found redistributor 20302 region 14:0x000000008d3a0000
[    0.848588] CPU14: using LPI pending table @0x00000011f6700000
[    0.848633] CPU14: Booted secondary processor [411fd071]
[    0.891674] Detected PIPT I-cache on CPU15
[    0.891682] CPU15: found redistributor 20303 region 15:0x000000008d3d0000
[    0.891702] CPU15: using LPI pending table @0x00000011f6750000
[    0.891747] CPU15: Booted secondary processor [411fd071]
[    0.891777] Brought up 16 CPUs
[    1.220819] SMP: Total of 16 processors activated.
[    1.225585] CPU features: detected feature: GIC system register CPU interface
[    1.232685] CPU: All CPU(s) started at EL2
[    1.236783] alternatives: patching kernel code
[    1.244033] devtmpfs: initialized
[    1.247592] SMBIOS 3.0.0 present.
[    1.251009] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.260957] pinctrl core: initialized pinctrl subsystem
[    1.266535] NET: Registered protocol family 16
[    1.286979] cpuidle: using governor menu
[    1.290926] vdso: 2 pages (1 code @ ffffff8008796000, 1 data @ ffffff8008b60000)
[    1.298337] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    1.305478] DMA: preallocated 256 KiB pool for atomic allocations
[    1.311614] ACPI: bus type PCI registered
[    1.315661] Serial: AMBA PL011 UART driver
[    1.335915] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.342641] ACPI: Added _OSI(Module Device)
[    1.346823] ACPI: Added _OSI(Processor Device)
[    1.351261] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.355978] ACPI: Added _OSI(Processor Aggregator Device)
[    1.362839] ACPI: Interpreter enabled
[    1.366483] ACPI: Using GIC for interrupt routing
[    1.371216] ACPI: MCFG table detected, 2 entries
[    1.378990] Hisilicon MBIGEN-V1 HISI0151:00: Allocated 256 MSIs
[    1.384979] Hisilicon MBIGEN-V1 HISI0151:01: Allocated 640 MSIs
[    1.390943] Hisilicon MBIGEN-V1 HISI0151:02: Allocated 256 MSIs
[    1.396936] Hisilicon MBIGEN-V1 HISI0151:03: Allocated 640 MSIs
[    1.403099] ACPI: IORT: can't find node related to (null) device
[    1.409175] ACPI: IORT: can't find node related to (null) device
[    1.415242] ACPI: IORT: can't find node related to (null) device
[    1.421301] ACPI: IORT: can't find node related to (null) device
[    1.427347] ACPI: IORT: can't find node related to (null) device
[    1.433371] ACPI: IORT: can't find node related to (null) device
[    1.440631] ACPI: IORT: can't find node related to (null) device
[    1.446670] ACPI: IORT: can't find node related to (null) device
[    1.452704] ACPI: IORT: can't find node related to (null) device
[    1.458734] ACPI: IORT: can't find node related to (null) device
[    1.464747] ACPI: IORT: can't find node related to (null) device
[    1.470788] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus 40-7f])
[    1.476960] acpi HISI0080:00: _OSC: OS supports [ExtendedConfig Segments MSI]
[    1.484125] acpi HISI0080:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.490913] acpi HISI0080:00: ECAM at [mem 0x22004000000-0x22007ffffff] for [bus 40-7f]
[    1.498924] Remapped I/O 0x000002200fff0000 to [io  0x0000-0xffff window]
[    1.505769] PCI host bridge to bus 0001:40
[    1.509866] pci_bus 0001:40: root bus resource [mem 0x22008000000-0x2200ffeffff window] (bus address [0xb0000000-0xb7feffff])
[    1.521157] pci_bus 0001:40: root bus resource [io  0x0000-0xffff window]
[    1.527929] pci_bus 0001:40: root bus resource [bus 40-7f]
[    1.538205] pci 0001:41:00.0: VF(n) BAR0 space: [mem 0x22008e08000-0x22008f07fff 64bit pref] (contains BAR0 for 64 VFs)
[    1.549469] pci 0001:41:00.0: VF(n) BAR3 space: [mem 0x22008f08000-0x22009007fff 64bit pref] (contains BAR3 for 64 VFs)
[    1.572065] pci 0001:41:00.1: VF(n) BAR0 space: [mem 0x22008c04000-0x22008d03fff 64bit pref] (contains BAR0 for 64 VFs)
[    1.583295] pci 0001:41:00.1: VF(n) BAR3 space: [mem 0x22008d04000-0x22008e03fff 64bit pref] (contains BAR3 for 64 VFs)
[    1.601438] pci 0001:40:00.0: BAR 15: assigned [mem 0x22008000000-0x220095fffff pref]
[    1.609249] pci 0001:40:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    1.615446] pci 0001:41:00.0: BAR 0: assigned [mem 0x22008000000-0x220083fffff 64bit pref]
[    1.623961] pci 0001:41:00.0: BAR 6: assigned [mem 0x22008400000-0x220087fffff pref]
[    1.631668] pci 0001:41:00.1: BAR 0: assigned [mem 0x22008800000-0x22008bfffff 64bit pref]
[    1.640185] pci 0001:41:00.1: BAR 6: assigned [mem 0x22008c00000-0x22008ffffff pref]
[    1.647909] pci 0001:41:00.0: BAR 4: assigned [mem 0x22009000000-0x22009003fff 64bit pref]
[    1.656391] pci 0001:41:00.0: BAR 7: assigned [mem 0x22009004000-0x22009103fff 64bit pref]
[    1.664881] pci 0001:41:00.0: BAR 10: assigned [mem 0x22009104000-0x22009203fff 64bit pref]
[    1.673471] pci 0001:41:00.1: BAR 4: assigned [mem 0x22009204000-0x22009207fff 64bit pref]
[    1.681961] pci 0001:41:00.1: BAR 7: assigned [mem 0x22009208000-0x22009307fff 64bit pref]
[    1.690469] pci 0001:41:00.1: BAR 10: assigned [mem 0x22009308000-0x22009407fff 64bit pref]
[    1.699054] pci 0001:41:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    1.705205] pci 0001:41:00.1: BAR 2: assigned [io  0x1020-0x103f]
[    1.711341] pci 0001:40:00.0: PCI bridge to [bus 41-42]
[    1.716550] pci 0001:40:00.0:   bridge window [io  0x1000-0x1fff]
[    1.722622] pci 0001:40:00.0:   bridge window [mem 0x22008000000-0x220095fffff pref]
[    1.730413] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-bf])
[    1.736573] acpi HISI0080:01: _OSC: OS supports [ExtendedConfig Segments MSI]
[    1.743744] acpi HISI0080:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.750498] acpi HISI0080:01: ECAM at [mem 0x24008000000-0x2400bffffff] for [bus 80-bf]
[    1.758501] Remapped I/O 0x000002400fff0000 to [io  0x10000-0x1ffff window]
[    1.765498] PCI host bridge to bus 0002:80
[    1.769603] pci_bus 0002:80: root bus resource [mem 0x2400c000000-0x2400ffeffff window] (bus address [0xc0000000-0xc3feffff])
[    1.780955] pci_bus 0002:80: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
[    1.790543] pci_bus 0002:80: root bus resource [bus 80-bf]
[    1.800721] pci 0002:81:00.0: VF(n) BAR0 space: [mem 0x2400ce08000-0x2400cf07fff 64bit pref] (contains BAR0 for 64 VFs)
[    1.811963] pci 0002:81:00.0: VF(n) BAR3 space: [mem 0x2400cf08000-0x2400d007fff 64bit pref] (contains BAR3 for 64 VFs)
[    1.834499] pci 0002:81:00.1: VF(n) BAR0 space: [mem 0x2400cc04000-0x2400cd03fff 64bit pref] (contains BAR0 for 64 VFs)
[    1.845746] pci 0002:81:00.1: VF(n) BAR3 space: [mem 0x2400cd04000-0x2400ce03fff 64bit pref] (contains BAR3 for 64 VFs)
[    1.863882] pci 0002:80:00.0: BAR 15: assigned [mem 0x2400c000000-0x2400d5fffff pref]
[    1.871683] pci 0002:80:00.0: BAR 13: assigned [io  0x10000-0x10fff]
[    1.878053] pci 0002:81:00.0: BAR 0: assigned [mem 0x2400c000000-0x2400c3fffff 64bit pref]
[    1.886586] pci 0002:81:00.0: BAR 6: assigned [mem 0x2400c400000-0x2400c7fffff pref]
[    1.894303] pci 0002:81:00.1: BAR 0: assigned [mem 0x2400c800000-0x2400cbfffff 64bit pref]
[    1.902845] pci 0002:81:00.1: BAR 6: assigned [mem 0x2400cc00000-0x2400cffffff pref]
[    1.910553] pci 0002:81:00.0: BAR 4: assigned [mem 0x2400d000000-0x2400d003fff 64bit pref]
[    1.919017] pci 0002:81:00.0: BAR 7: assigned [mem 0x2400d004000-0x2400d103fff 64bit pref]
[    1.927491] pci 0002:81:00.0: BAR 10: assigned [mem 0x2400d104000-0x2400d203fff 64bit pref]
[    1.936070] pci 0002:81:00.1: BAR 4: assigned [mem 0x2400d204000-0x2400d207fff 64bit pref]
[    1.944577] pci 0002:81:00.1: BAR 7: assigned [mem 0x2400d208000-0x2400d307fff 64bit pref]
[    1.953050] pci 0002:81:00.1: BAR 10: assigned [mem 0x2400d308000-0x2400d407fff 64bit pref]
[    1.961616] pci 0002:81:00.0: BAR 2: assigned [io  0x10000-0x1001f]
[    1.967931] pci 0002:81:00.1: BAR 2: assigned [io  0x10020-0x1003f]
[    1.974247] pci 0002:80:00.0: PCI bridge to [bus 81-82]
[    1.979455] pci 0002:80:00.0:   bridge window [io  0x10000-0x10fff]
[    1.985752] pci 0002:80:00.0:   bridge window [mem 0x2400c000000-0x2400d5fffff pref]
[    1.993935] ACPI: IORT: can't find node related to (null) device
[    2.000280] ACPI: IORT: can't find node related to (null) device
[    2.006518] vgaarb: loaded
[    2.009305] SCSI subsystem initialized
[    2.013165] ACPI: bus type USB registered
[    2.017216] usbcore: registered new interface driver usbfs
[    2.022710] usbcore: registered new interface driver hub
[    2.028036] usbcore: registered new device driver usb
[    2.033133] pps_core: LinuxPPS API ver. 1 registered
[    2.038081] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.047210] PTP clock support registered
[    2.051242] Advanced Linux Sound Architecture Driver Initialized.
[    2.057588] clocksource: Switched to clocksource arch_sys_counter
[    2.063718] VFS: Disk quotas dquot_6.6.0
[    2.067668] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.074641] pnp: PnP ACPI init
[    2.077840] system 00:00: [mem 0xb0080000-0xb008ffff] has been reserved
[    2.084508] system 00:01: [mem 0xb0090000-0xb009ffff] has been reserved
[    2.091147] pnp: PnP ACPI: found 2 devices
[    2.097821] NET: Registered protocol family 2
[    2.102391] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    2.109728] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.116726] TCP: Hash tables configured (established 65536 bind 65536)
[    2.123285] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    2.129420] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    2.136046] NET: Registered protocol family 1
[    2.140531] RPC: Registered named UNIX socket transport module.
[    2.146432] RPC: Registered udp transport module.
[    2.151156] RPC: Registered tcp transport module.
[    2.155853] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.162588] Unpacking initramfs...
[    2.524222] Freeing initrd memory: 27492K (ffffffc01e520000 - ffffffc01fff9000)
[    2.532046] kvm [1]: 8-bit VMID
[    2.535185] kvm [1]: Hyp mode initialized successfully
[    2.540318] kvm [1]: error: KVM vGIC probing failed
[    2.545231] kvm [1]: virtual timer IRQ3
[    2.550055] ACPI: IORT: can't find node related to (null) device
[    2.556473] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    2.562819] audit: initializing netlink subsys (disabled)
[    2.568241] audit: type=2000 audit(2.048:1): initialized
[    2.573809] workingset: timestamp_bits=44 max_order=21 bucket_order=0
[    2.583793] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.589908] NFS: Registering the id_resolver key type
[    2.594986] Key type id_resolver registered
[    2.599192] Key type id_legacy registered
[    2.603280] fuse init (API version 7.24)
[    2.607352] 9p: Installing v9fs 9p2000 file system support
[    2.613675] io scheduler noop registered
[    2.617652] io scheduler cfq registered (default)
[    2.622760] pcieport 0001:40:00.0: can't derive routing for PCI INT A
[    2.629188] pcieport 0001:40:00.0: PCI INT A: no GSI
[    2.634240] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    2.640674] pcieport 0002:80:00.0: PCI INT A: no GSI
[    2.646398] xenfs: not registering filesystem on non-xen platform
[    2.653568] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.660401] console [ttyS0] disabled
[    2.663979] APMC0D08:00: ttyS0 at MMIO 0x80300000 (irq = 5, base_baud = 12500000) is a 16550A
[    2.672570] console [ttyS0] enabled
[    2.672570] console [ttyS0] enabled
[    2.679571] bootconsole [uart8250] disabled
[    2.679571] bootconsole [uart8250] disabled
[    2.688167] SuperH (H)SCI(F) driver initialized
[    2.692759] msm_serial: driver initialized
[    2.697087] Failed to find cpu0 device node
[    2.701290] Unable to detect cache hierarchy from DT for CPU 0
[    2.709537] loop: module loaded
[    2.713143] tun: Universal TUN/TAP device driver, 1.6
[    2.718221] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.724530] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.730390] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.736361] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
[    2.743353] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.748974] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.0.2-k
[    2.756838] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    2.762804] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.2.1-k
[    2.770493] ixgbe: Copyright (c) 1999-2015 Intel Corporation.
[    2.776311] pcieport 0001:40:00.0: can't derive routing for PCI INT A
[    2.782783] ixgbe 0001:41:00.0: PCI INT A: no GSI
[    2.787630] ixgbe 0001:41:00.0: enabling device (0000 -> 0002)
[    2.949048] ixgbe 0001:41:00.0: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
[    2.957721] ixgbe 0001:41:00.0: PCI Express bandwidth of 32GT/s available
[    2.964541] ixgbe 0001:41:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    2.971785] ixgbe 0001:41:00.0: MAC: 2, PHY: 17, SFP+: 5, PBA No: FFFFFF-0FF
[    2.978864] ixgbe 0001:41:00.0: 68:a8:28:2e:c9:10
[    2.988081] ixgbe 0001:41:00.0: Intel(R) 10 Gigabit Network Connection
[    2.994671] pcieport 0001:40:00.0: can't derive routing for PCI INT B
[    3.001142] ixgbe 0001:41:00.1: PCI INT B: no GSI
[    3.005959] ixgbe 0001:41:00.1: enabling device (0000 -> 0002)
[    4.145034] ixgbe 0001:41:00.1: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
[    4.153704] ixgbe 0001:41:00.1: PCI Express bandwidth of 32GT/s available
[    4.160523] ixgbe 0001:41:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    4.167767] ixgbe 0001:41:00.1: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
[    4.173973] ixgbe 0001:41:00.1: 68:a8:28:2e:c9:11
[    4.183147] ixgbe 0001:41:00.1: Intel(R) 10 Gigabit Network Connection
[    4.189727] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    4.196197] ixgbe 0002:81:00.0: PCI INT A: no GSI
[    4.201010] ixgbe 0002:81:00.0: enabling device (0000 -> 0002)
[    5.341097] ixgbe 0002:81:00.0: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
[    5.349767] ixgbe 0002:81:00.0: PCI Express bandwidth of 32GT/s available
[    5.356587] ixgbe 0002:81:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    5.363830] ixgbe 0002:81:00.0: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
[    5.370036] ixgbe 0002:81:00.0: 9c:37:f4:90:cd:23
[    5.379230] ixgbe 0002:81:00.0: Intel(R) 10 Gigabit Network Connection
[    5.385810] pcieport 0002:80:00.0: can't derive routing for PCI INT B
[    5.392282] ixgbe 0002:81:00.1: PCI INT B: no GSI
[    5.397094] ixgbe 0002:81:00.1: enabling device (0000 -> 0002)
[    6.537144] ixgbe 0002:81:00.1: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
[    6.545814] ixgbe 0002:81:00.1: PCI Express bandwidth of 32GT/s available
[    6.552635] ixgbe 0002:81:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    6.559879] ixgbe 0002:81:00.1: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
[    6.566087] ixgbe 0002:81:00.1: 9c:37:f4:90:cd:24
[    6.575284] ixgbe 0002:81:00.1: Intel(R) 10 Gigabit Network Connection
[    6.581876] sky2: driver version 1.30
[    6.585704] VFIO - User Level meta-driver version: 0.3
[    6.591381] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.597943] ehci-pci: EHCI PCI platform driver
[    6.602426] ehci-platform: EHCI generic platform driver
[    6.607706] ehci-platform PNP0D20:00: EHCI Host Controller
[    6.613226] ehci-platform PNP0D20:00: new USB bus registered, assigned bus number 1
[    6.621049] ehci-platform PNP0D20:00: irq 6, io mem 0xa1000000
[    6.637594] ehci-platform PNP0D20:00: USB 2.0 started, EHCI 1.00
[    6.643858] hub 1-0:1.0: USB hub found
[    6.647634] hub 1-0:1.0: 1 port detected
[    6.651722] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    6.657341] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.663555] ohci-pci: OHCI PCI platform driver
[    6.668038] ohci-platform: OHCI generic platform driver
[    6.673371] usbcore: registered new interface driver usb-storage
[    6.679628] mousedev: PS/2 mouse device common for all mice
[    6.748745] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    6.754943] i2c /dev entries driver
[    6.758679] sdhci: Secure Digital Host Controller Interface driver
[    6.764887] sdhci: Copyright(c) Pierre Ossman
[    6.769279] Synopsys Designware Multimedia Card Interface Driver
[    6.775364] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.781131] ledtrig-cpu: registered to indicate activity on CPUs
[    6.787381] usbcore: registered new interface driver usbhid
[    6.792980] usbhid: USB HID core driver
[    6.797007] ACPI: IORT: can't find node related to (null) device
[    6.803269] NET: Registered protocol family 17
[    6.807771] 9pnet: Installing 9P2000 support
[    6.812084] Key type dns_resolver registered
[    6.816588] registered taskstats version 1
[    6.884354] rtc-efi rtc-efi: hctosys: unable to read the hardware clock
[    6.891089] ALSA device list:
[    6.894072]   No soundcards found.
[    6.897571] ttyS0 - failed to request DMA
[    6.901858] Freeing unused kernel memory: 840K (ffffff8008a89000 - ffffff8008b5b000)
root@(none)$ ifconfig -a
eth0      Link encap:Ethernet  HWaddr 68:a8:28:2e:c9:10
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth1      Link encap:Ethernet  HWaddr 68:a8:28:2e:c9:11
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth2      Link encap:Ethernet  HWaddr 9c:37:f4:90:cd:23
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth3      Link encap:Ethernet  HWaddr 9c:37:f4:90:cd:24
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
           collisions:0 txqueuelen:1
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@(none)$ ifconfig eth0 192.168.20.188
[   87.949144] ixgbe 0001:41:00.0: registered PHC device on eth0
root@(none)$ [   88.122426] ixgbe 0001:41:00.0 eth0: detected SFP+: 5
[   88.361631] ixgbe 0001:41:00.0 eth0: NIC Link is Up 10 Gbps, Flow Control: RX/TX

root@(none)$ ping 192.168.20.4 188
PING 192.168.20.4 (192.168.20.4): 56 data bytes
64 bytes from 192.168.20.4: seq=6 ttl=128 time=1.434 ms
64 bytes from 192.168.20.4: seq=7 ttl=128 time=0.296 ms
64 bytes from 192.168.20.4: seq=8 ttl=128 time=0.232 ms
64 bytes from 192.168.20.4: seq=9 ttl=128 time=0.615 ms
64 bytes from 192.168.20.4: seq=10 ttl=128 time=1.197 ms
64 bytes from 192.168.20.4: seq=11 ttl=128 time=1.204 ms
64 bytes from 192.168.20.4: seq=12 ttl=128 time=0.305 ms
64 bytes from 192.168.20.4: seq=13 ttl=128 time=0.379 ms
64 bytes from 192.168.20.4: seq=14 ttl=128 time=0.256 ms
64 bytes from 192.168.20.4: seq=15 ttl=128 time=0.288 ms
64 bytes from 192.168.20.4: seq=16 ttl=128 time=0.343 ms
64 bytes from 192.168.20.4: seq=17 ttl=128 time=0.326 ms
64 bytes from 192.168.20.4: seq=18 ttl=128 time=0.350 ms
64 bytes from 192.168.20.4: seq=19 ttl=128 time=0.427 ms
64 bytes from 192.168.20.4: seq=20 ttl=128 time=0.313 ms
64 bytes from 192.168.20.4: seq=21 ttl=128 time=0.261 ms
64 bytes from 192.168.20.4: seq=22 ttl=128 time=0.376 ms
64 bytes from 192.168.20.4: seq=23 ttl=128 time=0.360 ms
64 bytes from 192.168.20.4: seq=24 ttl=128 time=0.263 ms
64 bytes from 192.168.20.4: seq=25 ttl=128 time=0.380 ms
64 bytes from 192.168.20.4: seq=26 ttl=128 time=0.294 ms
64 bytes from 192.168.20.4: seq=27 ttl=128 time=0.538 ms
64 bytes from 192.168.20.4: seq=28 ttl=128 time=0.321 ms
64 bytes from 192.168.20.4: seq=29 ttl=128 time=0.472 ms
64 bytes from 192.168.20.4: seq=30 ttl=128 time=0.288 ms
64 bytes from 192.168.20.4: seq=31 ttl=128 time=0.268 ms
64 bytes from 192.168.20.4: seq=32 ttl=128 time=0.335 ms
64 bytes from 192.168.20.4: seq=33 ttl=128 time=0.305 ms
64 bytes from 192.168.20.4: seq=34 ttl=128 time=0.697 ms
64 bytes from 192.168.20.4: seq=35 ttl=128 time=0.329 ms
64 bytes from 192.168.20.4: seq=36 ttl=128 time=0.304 ms
64 bytes from 192.168.20.4: seq=37 ttl=128 time=0.773 ms
64 bytes from 192.168.20.4: seq=38 ttl=128 time=0.340 ms
64 bytes from 192.168.20.4: seq=39 ttl=128 time=0.306 ms
64 bytes from 192.168.20.4: seq=40 ttl=128 time=0.821 ms
64 bytes from 192.168.20.4: seq=41 ttl=128 time=0.408 ms
64 bytes from 192.168.20.4: seq=42 ttl=128 time=0.235 ms
64 bytes from 192.168.20.4: seq=43 ttl=128 time=0.954 ms
64 bytes from 192.168.20.4: seq=44 ttl=128 time=0.294 ms
64 bytes from 192.168.20.4: seq=45 ttl=128 time=0.921 ms
64 bytes from 192.168.20.4: seq=46 ttl=128 time=0.974 ms
64 bytes from 192.168.20.4: seq=47 ttl=128 time=0.409 ms
64 bytes from 192.168.20.4: seq=48 ttl=128 time=0.990 ms
64 bytes from 192.168.20.4: seq=49 ttl=128 time=0.306 ms
64 bytes from 192.168.20.4: seq=50 ttl=128 time=1.021 ms
64 bytes from 192.168.20.4: seq=51 ttl=128 time=0.290 ms
64 bytes from 192.168.20.4: seq=52 ttl=128 time=0.304 ms
64 bytes from 192.168.20.4: seq=53 ttl=128 time=0.323 ms
64 bytes from 192.168.20.4: seq=54 ttl=128 time=0.305 ms
64 bytes from 192.168.20.4: seq=55 ttl=128 time=0.371 ms
64 bytes from 192.168.20.4: seq=56 ttl=128 time=0.329 ms
64 bytes from 192.168.20.4: seq=57 ttl=128 time=0.322 ms
64 bytes from 192.168.20.4: seq=58 ttl=128 time=0.320 ms
64 bytes
