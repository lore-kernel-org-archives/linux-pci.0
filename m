Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:9373 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbcDZJNH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2016 05:13:07 -0400
Subject: Re: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
To: Tomasz Nowicki <tn@semihalf.com>, <helgaas@kernel.org>,
	<arnd@arndb.de>, <will.deacon@arm.com>, <catalin.marinas@arm.com>,
	<rafael@kernel.org>, <hanjun.guo@linaro.org>,
	<Lorenzo.Pieralisi@arm.com>, <okaya@codeaurora.org>,
	<jiang.liu@linux.intel.com>, <jchandra@broadcom.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
CC: <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
	<Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
	<wangyijing@huawei.com>, <Suravee.Suthikulpanit@amd.com>,
	<msalter@redhat.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <jcm@redhat.com>
From: "liudongdong (C)" <liudongdong3@huawei.com>
Message-ID: <571F2FDD.2050709@huawei.com>
Date: Tue, 26 Apr 2016 17:07:41 +0800
MIME-Version: 1.0
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Based on the patchset and add the patch(Add ACPI support for HiSilicon PCIe Host Controllers).
Tested on the HiSilicon ARM64 D02 board.
it can work ok with Intel 82599 networking card.
This is the bootup log which contains PCIe host and Intel 82599 networking card part.

Tested-by: Dongdong Liu <liudongdong3@huawei.com>

Loading driver at 0x0006D771000 EntryPoint=0x0006E17E100
Loading driver at 0x0006D771000 EntryPoint=0x0006E17E100
EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
GMAC ExitBootServicesEvent
SMMU ExitBootServicesEvent
[    0.000000] Booting Linux on physical CPU 0x20000
[    0.000000] Linux version 4.6.0-rc1+ (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #27 SMP PREEMPT Tue Apr 26 16:24:06 CST 2016
[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] earlycon: uart8250 at MMIO32 0x0000000080300000 (options '')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] EFI v2.50 by EDK II
[    0.000000] efi:  SMBIOS=0x7a650000  SMBIOS 3.0=0x7a630000  ACPI=0x7aba0000  ACPI 2.0=0x7aba0014
[    0.000000] cma: Reserved 16 MiB at 0x000000007e800000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007ABA0014 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x000000007A7000E8 00005C (v01 HISI   HISI-D02 20140727      01000013)
[    0.000000] ACPI: FACP 0x000000007A5F0000 00010C (v05 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: DSDT 0x000000007A5A0000 001694 (v01 HISI   HISI-D02 20140727 INTL 20150619)
[    0.000000] ACPI: DBG2 0x000000007A610000 00005A (v00 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: GTDT 0x000000007A5E0000 000060 (v02 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: APIC 0x000000007A5D0000 000564 (v01 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: MCFG 0x000000007A5C0000 00004C (v01 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: SPCR 0x000000007A5B0000 000050 (v02 HISI   HISI-D02 20140727 HISI 00000099)
[    0.000000] ACPI: IORT 0x000000007A590000 0001FC (v00 INTEL  TEMPLATE 00000000 INTL 20150619)
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
[    0.000000] early log buf free: 13088(79%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] software IO TLB [mem 0x764f0000-0x7a4f0000] (64MB) mapped at [ffffffc0764f0000-ffffffc07a4effff]
[    0.000000] Memory: 8110360K/8384512K available (7240K kernel code, 632K rwdata, 3028K rodata, 840K init, 247K bss, 257768K reserved, 16384K cma-reserved)
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
[    0.000000] ITS: allocated 512 Virtual CPUs @11f6c0c000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Interrupt Collections @11f6c0d000 (psz 4K, shr 1)
[    0.000000] ITS@0xc6000000
[    0.000000] ITS: allocated 65536 Devices @11f6d00000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Virtual CPUs @11f6c0e000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Interrupt Collections @11f6c0f000 (psz 4K, shr 1)
[    0.000000] ITS@0xa3000000
[    0.000000] ITS: allocated 65536 Devices @11f6d80000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Virtual CPUs @11f6c31000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Interrupt Collections @11f6c32000 (psz 4K, shr 1)
[    0.000000] ITS@0xb7000000
[    0.000000] ITS: allocated 65536 Devices @11f6e00000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Virtual CPUs @11f6c33000 (psz 4K, shr 1)
[    0.000000] ITS: allocated 512 Interrupt Collections @11f6c34000 (psz 4K, shr 1)
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
[    0.008027] Console: colour dummy device 80x25
[    0.012461] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.022853] pid_max: default: 32768 minimum: 301
[    0.027463] ACPI: Core revision 20160108
[    0.032014] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.038345]
[    0.039856] Security Framework initialized
[    0.043942] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.050782] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.058482] ASID allocator initialised with 65536 entries
[    0.064125] PCI/MSI: ITS@0x8c000000 domain created
[    0.068894] PCI/MSI: ITS@0xc6000000 domain created
[    0.073660] PCI/MSI: ITS@0xa3000000 domain created
[    0.078425] PCI/MSI: ITS@0xb7000000 domain created
[    0.083196] Platform MSI: irqchip@000000008c000000 domain created
[    0.089258] Platform MSI: irqchip@00000000c6000000 domain created
[    0.095319] Platform MSI: irqchip@00000000a3000000 domain created
[    0.101381] Platform MSI: irqchip@00000000b7000000 domain created
[    0.107485] Remapping and enabling EFI services.
[    0.112101]   EFI remap 0x000000007a4f0000 => 0000000020000000
[    0.117917]   EFI remap 0x000000007a540000 => 0000000020050000
[    0.123740]   EFI remap 0x000000007a620000 => 00000000200a0000
[    0.129555]   EFI remap 0x000000007a6b0000 => 0000000020130000
[    0.135369]   EFI remap 0x000000007a710000 => 0000000020180000
[    0.141187]   EFI remap 0x000000007a760000 => 00000000201d0000
[    0.147002]   EFI remap 0x000000007a7b0000 => 0000000020220000
[    0.152816]   EFI remap 0x000000007a800000 => 0000000020270000
[    0.158630]   EFI remap 0x000000007a850000 => 00000000202c0000
[    0.164445]   EFI remap 0x000000007a8a0000 => 0000000020310000
[    0.170259]   EFI remap 0x000000007a8f0000 => 0000000020360000
[    0.176073]   EFI remap 0x000000007a940000 => 00000000203b0000
[    0.181904]   EFI remap 0x000000007a990000 => 0000000020400000
[    0.187718]   EFI remap 0x000000007aa00000 => 0000000020470000
[    0.193533]   EFI remap 0x000000007aa50000 => 00000000204c0000
[    0.199347]   EFI remap 0x000000007aaa0000 => 0000000020510000
[    0.205162]   EFI remap 0x000000007aaf0000 => 0000000020560000
[    0.210976]   EFI remap 0x000000007ab40000 => 00000000205b0000
[    0.216789]   EFI remap 0x000000007fbb0000 => 0000000020600000
[    0.222595]   EFI remap 0x0000000080300000 => 0000000020630000
[    0.228409]   EFI remap 0x00000000a00f0000 => 0000000020640000
[    0.234213]   EFI remap 0x00000000a4000000 => 0000000020800000
[    0.240022]   EFI remap 0x00000000a6000000 => 0000000021800000
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20001 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x1


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c080
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d190
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20002 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x1


0808?8A4B4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c100
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d3a0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20003 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x1


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c180
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d5b0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20100 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x1

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x3


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c200
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d7c0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20101 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x3


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c280
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3d9d0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20102 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x3


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c300
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3dbe0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20103 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x3


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c380
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3ddf0
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20200 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x3

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x7


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c400
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e000
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20201 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x7


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c480
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e210
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20202 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x7


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c500
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e420
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20203 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0x7


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c580
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e630
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20300 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0x7

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0xf


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c600
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3e840
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20301 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0xf

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0xf


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c680
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3ea50
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20302 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0xf

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0xf


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c700
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3ec60
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
NOTICE:  [psci_smc_handler]:[408L] PSCI_CPU_ON_AARCH64 CALL
NOTICE:  [psci_smc_handler]:[409L] x1=0x20303 x2=0x82870 x3=0x0
NOTICE:  [scpi_set_css_power_state]:[85L] domain_cluster=0xf

NOTICE:  [scpi_set_css_power_state]:[93L] domain_cluster=0xf


0808?84AB4
NOTICE:  [psci_afflvl_power_on_finish]:[504L]
NOTICE:  [cm_prepare_el3_exit]:[262L] read_tpidr_el3 = 7fc3c780
NOTICE:  [cm_prepare_el3_exit]:[319L] ctx add = 7fc3ee70
NOTICE:  [psci_afflvl_power_on_finish]:[562L]

00082870
[    0.287781] Detected PIPT I-cache on CPU1
[    0.287793] CPU1: found redistributor 20001 region 0:0x000000008d130000
[    0.287813] CPU1: using LPI pending table @0x00000011f6410000
[    0.287871] CPU1: Booted secondary processor [411fd071]
[    0.330893] Detected PIPT I-cache on CPU2
[    0.330899] CPU2: found redistributor 20002 region 0:0x000000008d160000
[    0.330919] CPU2: using LPI pending table @0x00000011f6440000
[    0.330966] CPU2: Booted secondary processor [411fd071]
[    0.374006] Detected PIPT I-cache on CPU3
[    0.374013] CPU3: found redistributor 20003 region 0:0x000000008d190000
[    0.374033] CPU3: using LPI pending table @0x00000011f6480000
[    0.374077] CPU3: Booted secondary processor [411fd071]
[    0.417121] Detected PIPT I-cache on CPU4
[    0.417129] CPU4: found redistributor 20100 region 0:0x000000008d1c0000
[    0.417149] CPU4: using LPI pending table @0x00000011f64c0000
[    0.417197] CPU4: Booted secondary processor [411fd071]
[    0.460234] Detected PIPT I-cache on CPU5
[    0.460241] CPU5: found redistributor 20101 region 0:0x000000008d1f0000
[    0.460260] CPU5: using LPI pending table @0x00000011f64f0000
[    0.460307] CPU5: Booted secondary processor [411fd071]
[    0.503347] Detected PIPT I-cache on CPU6
[    0.503354] CPU6: found redistributor 20102 region 0:0x000000008d220000
[    0.503374] CPU6: using LPI pending table @0x00000011f6530000
[    0.503419] CPU6: Booted secondary processor [411fd071]
[    0.546461] Detected PIPT I-cache on CPU7
[    0.546468] CPU7: found redistributor 20103 region 0:0x000000008d250000
[    0.546488] CPU7: using LPI pending table @0x00000011f6560000
[    0.546533] CPU7: Booted secondary processor [411fd071]
[    0.589576] Detected PIPT I-cache on CPU8
[    0.589585] CPU8: found redistributor 20200 region 0:0x000000008d280000
[    0.589606] CPU8: using LPI pending table @0x00000011f65a0000
[    0.589657] CPU8: Booted secondary processor [411fd071]
[    0.632688] Detected PIPT I-cache on CPU9
[    0.632695] CPU9: found redistributor 20201 region 0:0x000000008d2b0000
[    0.632716] CPU9: using LPI pending table @0x00000011f65e0000
[    0.632763] CPU9: Booted secondary processor [411fd071]
[    0.675802] Detected PIPT I-cache on CPU10
[    0.675809] CPU10: found redistributor 20202 region 0:0x000000008d2e0000
[    0.675830] CPU10: using LPI pending table @0x00000011f6610000
[    0.675875] CPU10: Booted secondary processor [411fd071]
[    0.718915] Detected PIPT I-cache on CPU11
[    0.718922] CPU11: found redistributor 20203 region 0:0x000000008d310000
[    0.718943] CPU11: using LPI pending table @0x00000011f6650000
[    0.718988] CPU11: Booted secondary processor [411fd071]
[    0.762029] Detected PIPT I-cache on CPU12
[    0.762038] CPU12: found redistributor 20300 region 0:0x000000008d340000
[    0.762060] CPU12: using LPI pending table @0x00000011f6680000
[    0.762110] CPU12: Booted secondary processor [411fd071]
[    0.805142] Detected PIPT I-cache on CPU13
[    0.805149] CPU13: found redistributor 20301 region 0:0x000000008d370000
[    0.805169] CPU13: using LPI pending table @0x00000011f66c0000
[    0.805215] CPU13: Booted secondary processor [411fd071]
[    0.848255] Detected PIPT I-cache on CPU14
[    0.848262] CPU14: found redistributor 20302 region 0:0x000000008d3a0000
[    0.848282] CPU14: using LPI pending table @0x00000011f6700000
[    0.848327] CPU14: Booted secondary processor [411fd071]
[    0.891369] Detected PIPT I-cache on CPU15
[    0.891376] CPU15: found redistributor 20303 region 0:0x000000008d3d0000
[    0.891396] CPU15: using LPI pending table @0x00000011f6730000
[    0.891443] CPU15: Booted secondary processor [411fd071]
[    0.891474] Brought up 16 CPUs
[    1.220030] SMP: Total of 16 processors activated.
[    1.224797] CPU features: detected feature: GIC system register CPU interface
[    1.231896] CPU: All CPU(s) started at EL2
[    1.235995] alternatives: patching kernel code
[    1.243242] devtmpfs: initialized
[    1.246777] SMBIOS 3.0.0 present.
[    1.250186] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.260128] pinctrl core: initialized pinctrl subsystem
[    1.265705] NET: Registered protocol family 16
[    1.282139] cpuidle: using governor menu
[    1.286084] vdso: 2 pages (1 code @ ffffff8008796000, 1 data @ ffffff8008b60000)
[    1.293459] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    1.300550] DMA: preallocated 256 KiB pool for atomic allocations
[    1.306685] ACPI: bus type PCI registered
[    1.310732] Serial: AMBA PL011 UART driver
[    1.326982] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.333704] ACPI: Added _OSI(Module Device)
[    1.337868] ACPI: Added _OSI(Processor Device)
[    1.342288] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.346969] ACPI: Added _OSI(Processor Aggregator Device)
[    1.353554] ACPI: Interpreter enabled
[    1.357201] ACPI: Using GIC for interrupt routing
[    1.361902] ACPI: MCFG entry for domain 0001 [bus 40-7f] (base 0x0000022004000000)
[    1.369435] ACPI: MCFG entry for domain 0002 [bus 80-bf] (base 0x0000024008000000)
[    1.376974] ACPI: MCFG table loaded, 2 entries
[    1.384442] Hisilicon MBIGEN-V1 HISI0151:00: Allocated 256 MSIs
[    1.390414] Hisilicon MBIGEN-V1 HISI0151:01: Allocated 640 MSIs
[    1.396377] Hisilicon MBIGEN-V1 HISI0151:02: Allocated 256 MSIs
[    1.402342] Hisilicon MBIGEN-V1 HISI0151:03: Allocated 640 MSIs
[    1.408462] ACPI: IORT: can't find node related to (null) device
[    1.414536] ACPI: IORT: can't find node related to (null) device
[    1.420572] ACPI: IORT: can't find node related to (null) device
[    1.426595] ACPI: IORT: can't find node related to (null) device
[    1.432626] ACPI: IORT: can't find node related to (null) device
[    1.438897] ACPI: IORT: can't find node related to (null) device
[    1.445175] ACPI: IORT: can't find node related to (null) device
[    1.451211] ACPI: IORT: can't find node related to (null) device
[    1.459089] ACPI: IORT: can't find node related to (null) device
[    1.465123] ACPI: IORT: can't find node related to (null) device
[    1.471138] ACPI: IORT: can't find node related to (null) device
[    1.477150] ACPI: IORT: can't find node related to (null) device
[    1.483165] ACPI: IORT: can't find node related to (null) device
[    1.489205] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus 40-7f])
[    1.495360] acpi HISI0080:00: _OSC: OS supports [ExtendedConfig Segments MSI]
[    1.502464] acpi HISI0080:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.509180] Remapped I/O 0x000002200fff0000 to [io  0x0000-0xffff window]
[    1.516016] acpi HISI0080:00: PCI host bridge to bus 0001:40
[    1.521651] pci_bus 0001:40: root bus resource [mem 0x22008000000-0x2200ffeffff window] (bus address [0xb0000000-0xb7feffff])
[    1.532906] pci_bus 0001:40: root bus resource [io  0x0000-0xffff window]
[    1.539661] pci_bus 0001:40: root bus resource [bus 40-7f]
[    1.545136] pci 0001:40:00.0: ignoring class 0x000000 (doesn't match header type 01)
[    1.553059] pci 0001:40:00.0: not setting up bridge for bus 0001:41
[    1.559335] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-bf])
[    1.565488] acpi HISI0080:01: _OSC: OS supports [ExtendedConfig Segments MSI]
[    1.572591] acpi HISI0080:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.579299] Remapped I/O 0x000002400fff0000 to [io  0x10000-0x1ffff window]
[    1.586302] acpi HISI0080:01: PCI host bridge to bus 0002:80
[    1.591936] pci_bus 0002:80: root bus resource [mem 0x2400c000000-0x2400ffeffff window] (bus address [0xc0000000-0xc3feffff])
[    1.603183] pci_bus 0002:80: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
[    1.612703] pci_bus 0002:80: root bus resource [bus 80-bf]
[    1.623076] pci 0002:81:00.0: VF(n) BAR0 space: [mem 0x2400ce08000-0x2400cf07fff 64bit pref] (contains BAR0 for 64 VFs)
[    1.634312] pci 0002:81:00.0: VF(n) BAR3 space: [mem 0x2400cf08000-0x2400d007fff 64bit pref] (contains BAR3 for 64 VFs)
[    1.657152] pci 0002:81:00.1: VF(n) BAR0 space: [mem 0x2400cc04000-0x2400cd03fff 64bit pref] (contains BAR0 for 64 VFs)
[    1.668374] pci 0002:81:00.1: VF(n) BAR3 space: [mem 0x2400cd04000-0x2400ce03fff 64bit pref] (contains BAR3 for 64 VFs)
[    1.686652] pci 0002:80:00.0: BAR 15: assigned [mem 0x2400c000000-0x2400d5fffff pref]
[    1.694447] pci 0002:80:00.0: BAR 13: assigned [io  0x10000-0x10fff]
[    1.700775] pci 0002:81:00.0: BAR 0: assigned [mem 0x2400c000000-0x2400c3fffff 64bit pref]
[    1.709249] pci 0002:81:00.0: BAR 6: assigned [mem 0x2400c400000-0x2400c7fffff pref]
[    1.716956] pci 0002:81:00.1: BAR 0: assigned [mem 0x2400c800000-0x2400cbfffff 64bit pref]
[    1.725425] pci 0002:81:00.1: BAR 6: assigned [mem 0x2400cc00000-0x2400cffffff pref]
[    1.733133] pci 0002:81:00.0: BAR 4: assigned [mem 0x2400d000000-0x2400d003fff 64bit pref]
[    1.741611] pci 0002:81:00.0: BAR 7: assigned [mem 0x2400d004000-0x2400d103fff 64bit pref]
[    1.750081] pci 0002:81:00.0: BAR 10: assigned [mem 0x2400d104000-0x2400d203fff 64bit pref]
[    1.758639] pci 0002:81:00.1: BAR 4: assigned [mem 0x2400d204000-0x2400d207fff 64bit pref]
[    1.767109] pci 0002:81:00.1: BAR 7: assigned [mem 0x2400d208000-0x2400d307fff 64bit pref]
[    1.775578] pci 0002:81:00.1: BAR 10: assigned [mem 0x2400d308000-0x2400d407fff 64bit pref]
[    1.784133] pci 0002:81:00.0: BAR 2: assigned [io  0x10000-0x1001f]
[    1.790443] pci 0002:81:00.1: BAR 2: assigned [io  0x10020-0x1003f]
[    1.796753] pci 0002:80:00.0: PCI bridge to [bus 81-82]
[    1.801953] pci 0002:80:00.0:   bridge window [io  0x10000-0x10fff]
[    1.808224] pci 0002:80:00.0:   bridge window [mem 0x2400c000000-0x2400d5fffff pref]
[    1.816152] vgaarb: loaded
[    1.818950] SCSI subsystem initialized
[    1.822813] ACPI: bus type USB registered
[    1.826841] usbcore: registered new interface driver usbfs
[    1.832316] usbcore: registered new interface driver hub
[    1.837642] usbcore: registered new device driver usb
[    1.842725] pps_core: LinuxPPS API ver. 1 registered
[    1.847666] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.856759] PTP clock support registered
[    1.860780] Advanced Linux Sound Architecture Driver Initialized.
[    1.867087] clocksource: Switched to clocksource arch_sys_counter
[    1.873199] VFS: Disk quotas dquot_6.6.0
[    1.877120] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.884093] pnp: PnP ACPI init
[    1.887279] system 00:00: [mem 0xb0080000-0xb008ffff] has been reserved
[    1.893917] system 00:01: [mem 0xb0090000-0xb009ffff] has been reserved
[    1.900506] pnp: PnP ACPI: found 2 devices
[    1.907077] NET: Registered protocol family 2
[    1.911636] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    1.918961] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.925949] TCP: Hash tables configured (established 65536 bind 65536)
[    1.932596] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.938726] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.945437] NET: Registered protocol family 1
[    1.949937] RPC: Registered named UNIX socket transport module.
[    1.955918] RPC: Registered udp transport module.
[    1.960668] RPC: Registered tcp transport module.
[    1.965431] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.972119] Unpacking initramfs...
[    2.337992] Freeing initrd memory: 27492K (ffffffc01e520000 - ffffffc01fff9000)
[    2.345883] kvm [1]: 8-bit VMID
[    2.349049] kvm [1]: Hyp mode initialized successfully
[    2.354260] kvm [1]: error: KVM vGIC probing failed
[    2.359209] kvm [1]: virtual timer IRQ3
[    2.364173] ACPI: IORT: can't find node related to (null) device
[    2.370636] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    2.377097] audit: initializing netlink subsys (disabled)
[    2.382570] audit: type=2000 audit(1.864:1): initialized
[    2.388157] workingset: timestamp_bits=44 max_order=21 bucket_order=0
[    2.398177] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.404332] NFS: Registering the id_resolver key type
[    2.409442] Key type id_resolver registered
[    2.413657] Key type id_legacy registered
[    2.417776] fuse init (API version 7.24)
[    2.421909] 9p: Installing v9fs 9p2000 file system support
[    2.428256] io scheduler noop registered
[    2.432295] io scheduler cfq registered (default)
[    2.437480] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    2.443970] pcieport 0002:80:00.0: PCI INT A: no GSI
[    2.449726] xenfs: not registering filesystem on non-xen platform
[    2.456932] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.463834] console [ttyS0] disabled
[    2.467457] APMC0D08:00: ttyS0 at MMIO 0x80300000 (irq = 5, base_baud = 12500000) is a 16550A
[    2.476041] console [ttyS0] enabled
[    2.476041] console [ttyS0] enabled
[    2.483090] bootconsole [uart8250] disabled
[    2.483090] bootconsole [uart8250] disabled
[    2.491669] SuperH (H)SCI(F) driver initialized
[    2.496261] msm_serial: driver initialized
[    2.500585] Failed to find cpu0 device node
[    2.504787] Unable to detect cache hierarchy from DT for CPU 0
[    2.513098] loop: module loaded
[    2.516658] tun: Universal TUN/TAP device driver, 1.6
[    2.521735] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.528048] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.533908] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.539879] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
[    2.546871] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.552493] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.0.2-k
[    2.560358] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    2.566323] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.2.1-k
[    2.574013] ixgbe: Copyright (c) 1999-2015 Intel Corporation.
[    2.579828] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    2.586299] ixgbe 0002:81:00.0: PCI INT A: no GSI
[    2.591152] ixgbe 0002:81:00.0: enabling device (0000 -> 0002)
[    3.730644] ixgbe 0002:81:00.0: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
[    3.739317] ixgbe 0002:81:00.0: PCI Express bandwidth of 32GT/s available
[    3.746137] ixgbe 0002:81:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    3.753381] ixgbe 0002:81:00.0: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
[    3.759590] ixgbe 0002:81:00.0: 68:a8:28:2e:c9:10
[    3.768837] ixgbe 0002:81:00.0: Intel(R) 10 Gigabit Network Connection
[    3.775419] pcieport 0002:80:00.0: can't derive routing for PCI INT B
[    3.781891] ixgbe 0002:81:00.1: PCI INT B: no GSI
[    3.786709] ixgbe 0002:81:00.1: enabling device (0000 -> 0002)
[    3.950600] ixgbe 0002:81:00.1: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
[    3.959271] ixgbe 0002:81:00.1: PCI Express bandwidth of 32GT/s available
[    3.966092] ixgbe 0002:81:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    3.973337] ixgbe 0002:81:00.1: MAC: 2, PHY: 17, SFP+: 6, PBA No: FFFFFF-0FF
[    3.980416] ixgbe 0002:81:00.1: 68:a8:28:2e:c9:11
[    3.989652] ixgbe 0002:81:00.1: Intel(R) 10 Gigabit Network Connection
[    3.996242] sky2: driver version 1.30
[    4.000065] VFIO - User Level meta-driver version: 0.3
[    4.005749] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.012310] ehci-pci: EHCI PCI platform driver
[    4.016791] ehci-platform: EHCI generic platform driver
[    4.022075] ehci-platform PNP0D20:00: EHCI Host Controller
[    4.027594] ehci-platform PNP0D20:00: new USB bus registered, assigned bus number 1
[    4.035417] ehci-platform PNP0D20:00: irq 6, io mem 0xa1000000
[    4.051095] ehci-platform PNP0D20:00: USB 2.0 started, EHCI 1.00
[    4.057361] hub 1-0:1.0: USB hub found
[    4.061137] hub 1-0:1.0: 1 port detected
[    4.065225] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    4.070846] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.077058] ohci-pci: OHCI PCI platform driver
[    4.081542] ohci-platform: OHCI generic platform driver
[    4.086870] usbcore: registered new interface driver usb-storage
[    4.093131] mousedev: PS/2 mouse device common for all mice
[    4.162242] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    4.169358] i2c /dev entries driver
[    4.173098] sdhci: Secure Digital Host Controller Interface driver
[    4.179305] sdhci: Copyright(c) Pierre Ossman
[    4.183696] Synopsys Designware Multimedia Card Interface Driver
[    4.189782] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.195546] ledtrig-cpu: registered to indicate activity on CPUs
[    4.201794] usbcore: registered new interface driver usbhid
[    4.207392] usbhid: USB HID core driver
[    4.211413] ACPI: IORT: can't find node related to (null) device
[    4.217683] NET: Registered protocol family 17
[    4.222183] 9pnet: Installing 9P2000 support
[    4.226502] Key type dns_resolver registered
[    4.231001] registered taskstats version 1
[    4.298696] rtc-efi rtc-efi: setting system clock to 2100-01-04 02:55:42 UTC (4102714542)
[    4.307002] ALSA device list:
[    4.309987]   No soundcards found.
[    4.313486] ttyS0 - failed to request DMA
[    4.317789] Freeing unused kernel memory: 840K (ffffff8008a89000 - ffffff8008b5b000)
root@(none)$ ifconfig eh th1 192.168.20.188
[   27.272687] ixgbe 0002:81:00.1: registered PHC device on eth1
root@(none)$ [   27.443193] ixgbe 0002:81:00.1 eth1: detected SFP+: 6
[   27.683130] ixgbe 0002:81:00.1 eth1: NIC Link is Up 10 Gbps, Flow Control: RX/TX

root@(none)$ ping 192.168.20.4
PING 192.168.20.4 (192.168.20.4): 56 data bytes

--IPOP Time:2016/4/26_16:54:51--
64 bytes from 192.168.20.4: seq=19 ttl=128 time=999.570 ms
64 bytes from 192.168.20.4: seq=20 ttl=128 time=0.278 ms
64 bytes from 192.168.20.4: seq=21 ttl=128 time=0.304 ms
64 bytes from 192.168.20.4: seq=22 ttl=128 time=0.311 ms
64 bytes from 192.168.20.4: seq=23 ttl=128 time=0.287 ms
64 bytes from 192.168.20.4: seq=24 ttl=128 time=0.282 ms
64 bytes from 192.168.20.4: seq=25 ttl=128 time=0.312 ms
64 bytes from 192.168.20.4: seq=26 ttl=128 time=0.295 ms
64 bytes from 192.168.20.4: seq=27 ttl=128 time=0.334 ms
64 bytes from 192.168.20.4: seq=28 ttl=128 time=0.306 ms
64 bytes from 192.168.20.4: seq=29 ttl=128 time=0.254 ms
64 bytes from 192.168.20.4: seq=30 ttl=128 time=0.297 ms
64 bytes from 192.168.20.4: seq=31 ttl=128 time=0.307 ms
[   67.963287] random: nonblocking pool is initialized
64 bytes from 192.168.20.4: seq=32 ttl=128 time=0.302 ms
64 bytes from 192.168.20.4: seq=33 ttl=128 time=0.327 ms
64 bytes from 192.168.20.4: seq=34 ttl=128 time=0.283 ms
64 bytes from 192.168.20.4: seq=35 ttl=128 time=0.325 ms
64 bytes from 192.168.20.4: seq=36 ttl=128 time=0.308 ms
64 bytes from 192.168.20.4: seq=37 ttl=128 time=0.336 ms
64 bytes from 192.168.20.4: seq=38 ttl=128 time=0.243 ms
64 bytes from 192.168.20.4: seq=39 ttl=128 time=0.239 ms
64 bytes from 192.168.20.4: seq=40 ttl=128 time=0.261 ms
64 bytes from 192.168.20.4: seq=41 ttl=128 time=0.298 ms
64 bytes from 192.168.20.4: seq=42 ttl=128 time=0.340 ms
64 bytes from 192.168.20.4: seq=43 ttl=128 time=0.283 ms
64 bytes from 192.168.20.4: seq=44 ttl=128 time=0.341 ms
64 bytes from 192.168.20.4: seq=45 ttl=128 time=0.368 ms
64 bytes from 192.168.20.4: seq=46 ttl=128 time=0.336 ms
64 bytes from 192.168.20.4: seq=47 ttl=128 time=0.373 ms
64 bytes from 192.168.20.4: seq=48 ttl=128 time=0.373 ms
64 bytes from 192.168.20.4: seq=49 ttl=128 time=0.361 ms
64 bytes from 192.168.20.4: seq=50 ttl=128 time=0.404 ms
64 bytes from 192.168.20.4: seq=51 ttl=128 time=0.357 ms
64 bytes from 192.168.20.4: seq=52 ttl=128 time=0.348 ms
64 bytes from 192.168.20.4: seq=53 ttl=128 time=0.362 ms
64 bytes from 192.168.20.4: seq=54 ttl=128 time=0.323 ms
64 bytes from 192.168.20.4: seq=55 ttl=128 time=0.309 ms
64 bytes from 192.168.20.4: seq=56 ttl=128 time=0.340 ms
64 bytes from 192.168.20.4: seq=57 ttl=128 time=0.325 ms
64 bytes from 192.168.20.4: seq=58 ttl=128 time=0.313 ms
64 bytes from 192.168.20.4: seq=59 ttl=128 time=0.327 ms

ÔÚ 2016/4/16 1:06, Tomasz Nowicki Ð´µÀ:
>>From the functionality point of view this series might be split into the
> following logic parts:
> 1. Necessary fixes as the preparation for using driver on ARM64.
> 2. New ECAM API and update for users of the pci-host-common API
> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
>
> Patches has been built on top of 4.6-rc2 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v6)
>
> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.
>
> v5 -> v6
> - dropped idea of x86 MMCONFIG code refactoring
> - integrated JC's patches which introduce new ECAM API:
>    https://lkml.org/lkml/2016/4/11/907
>    git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
> - integrated Sinan's fix for releasing IO resources, see patch [06/13]
> - added ACPI support for ThunderX ECAM and PEM drivers
> - rebased to 4.6-rc2
>
> v4 -> v5
> - dropped MCFG refactoring group patches 1-6 from series v4 and integrated Jayachandran's patch
>    https://patchwork.ozlabs.org/patch/575525/
> - rewrite PCI legacy IRQs allocation
> - squashed two patches 11 and 12 from series v4, fixed bisection issue
> - changelog improvements
> - rebased to 4.5-rc3
>
> v3 -> v4
> - dropped Jiang's fix http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04318.html
> - added Lorenzo's fix patch 19/24
> - ACPI PCI bus domain number assigning cleanup
> - changed resource management, we now claim and reassign resources
> - improvements for applying quirks
> - dropped Matthew's http://www.spinics.net/lists/linux-pci/msg45950.html dependency
> - rebased to 4.5-rc1
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
>
> v1 -> v2
> - moved non-arch specific piece of code to dirver/acpi/ directory
> - fixed IO resource handling
> - introduced PCI config accessors quirks matching
> - moved ACPI_COMPANION_SET to generic code
>
> v1 - https://lkml.org/lkml/2015/10/27/504
> v2 - https://lkml.org/lkml/2015/12/16/246
> v3 - http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04308.html
> v4 - https://lkml.org/lkml/2016/2/4/646
> v5 - https://lkml.org/lkml/2016/2/16/426
>
> Jayachandran C (2):
>    PCI: Provide common functions for ECAM mapping
>    PCI: generic, thunder: update to use generic ECAM API
>
> Tomasz Nowicki (11):
>    pci, acpi, x86, ia64: Move ACPI host bridge device companion
>      assignment to core code.
>    pci, acpi: Provide generic way to assign bus domain number.
>    x86, ia64: Include acpi_pci_{add|remove}_bus to the default
>      pcibios_{add|remove}_bus implementation.
>    pci, of: Move the PCI I/O space management to PCI core code.
>    acpi, pci: Support IO resources when parsing PCI host bridge
>      resources.
>    arm64, pci, acpi: ACPI support for legacy IRQs parsing and
>      consolidation with DT code.
>    pci, acpi: Support for ACPI based generic PCI host controller
>    arm64, pci, acpi: Start using ACPI based PCI host controller driver
>      for ARM64.
>    pci, acpi: Match PCI config space accessors against platfrom specific
>      quirks.
>    pci, pci-thunder-ecam: Add ACPI support for ThunderX ECAM.
>    pci, pci-thunder-pem: Add ACPI support for ThunderX PEM.
>
>   arch/arm64/Kconfig                  |  15 +++
>   arch/arm64/include/asm/cpufeature.h |   3 +-
>   arch/arm64/kernel/cpu_errata.c      |   8 ++
>   arch/arm64/kernel/pci.c             |  35 ++---
>   arch/ia64/hp/common/sba_iommu.c     |   2 +-
>   arch/ia64/include/asm/pci.h         |   1 -
>   arch/ia64/pci/pci.c                 |  26 ----
>   arch/ia64/sn/kernel/io_acpi_init.c  |   4 +-
>   arch/x86/include/asm/pci.h          |   3 -
>   arch/x86/pci/acpi.c                 |  17 ---
>   arch/x86/pci/common.c               |  10 --
>   drivers/acpi/Kconfig                |   8 ++
>   drivers/acpi/Makefile               |   1 +
>   drivers/acpi/bus.c                  |   1 +
>   drivers/acpi/pci_gen_host.c         | 259 ++++++++++++++++++++++++++++++++++++
>   drivers/acpi/pci_root.c             |  58 +++++++-
>   drivers/of/address.c                | 116 +---------------
>   drivers/pci/Kconfig                 |   3 +
>   drivers/pci/Makefile                |   2 +
>   drivers/pci/ecam.c                  | 137 +++++++++++++++++++
>   drivers/pci/ecam.h                  |  66 +++++++++
>   drivers/pci/host/Kconfig            |   1 +
>   drivers/pci/host/pci-host-common.c  | 119 ++++++++---------
>   drivers/pci/host/pci-host-common.h  |  47 -------
>   drivers/pci/host/pci-host-generic.c |  52 ++------
>   drivers/pci/host/pci-thunder-ecam.c |  70 ++++++----
>   drivers/pci/host/pci-thunder-pem.c  | 215 ++++++++++++++++++++++--------
>   drivers/pci/pci.c                   | 150 ++++++++++++++++++++-
>   drivers/pci/probe.c                 |   5 +
>   include/asm-generic/vmlinux.lds.h   |   7 +
>   include/linux/of_address.h          |   9 --
>   include/linux/pci-acpi.h            |  20 +++
>   include/linux/pci.h                 |  12 ++
>   33 files changed, 1029 insertions(+), 453 deletions(-)
>   create mode 100644 drivers/acpi/pci_gen_host.c
>   create mode 100644 drivers/pci/ecam.c
>   create mode 100644 drivers/pci/ecam.h
>   delete mode 100644 drivers/pci/host/pci-host-common.h
>

