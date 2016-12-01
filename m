Return-Path: <SRS0=z0wH=XQ=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=z0wH=XQ=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
To: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <d3f1a4ca-99e6-f0a5-d20b-d2753058d93d@huawei.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni
	<gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya
	<okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <8f4a67d4-549a-34e9-8ef7-ec99961d60e5@huawei.com>
Date: Thu, 1 Dec 2016 22:04:48 +0800
MIME-Version: 1.0
In-Reply-To: <d3f1a4ca-99e6-f0a5-d20b-d2753058d93d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



在 2016/12/1 21:02, Dongdong Liu 写道:
> Hi Bjorn
>
> Thank you for reworking the patchset.
> I found some complie errors and can fix the errors by the below modification.
>
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index cdceaf5..c84330a 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -53,7 +53,7 @@ struct mcfg_fixup {
>  /*     { OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
>
>  #define QCOM_ECAM32(seg) \
> -   { "QCOM  ", "QDF2432 ", 1, seg, MCFG_BUS_ANY, &pci_32b_ops },
> + { "QCOM  ", "QDF2432 ", 1, seg, MCFG_BUS_ANY, &pci_32b_ops }
>         QCOM_ECAM32(0),
>         QCOM_ECAM32(1),
>         QCOM_ECAM32(2),
> @@ -96,7 +96,7 @@ struct mcfg_fixup {
>
>  #define THUNDER_ECAM_QUIRK(rev, node)                                  \
>         { "CAVIUM", "THUNDERX", rev, node, MCFG_BUS_ANY,                \
> -   &pci_thunder_ecam_ops },
> + &pci_thunder_ecam_ops }
>         /* SoC pass1.x */
>         THUNDER_PEM_QUIRK(2,  0),       /* off-chip devices */
>         THUNDER_PEM_QUIRK(2,  1),       /* off-chip devices */
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index 7b03939..2066410 100644
> --- a/drivers/pci/host/pci-thunder-pem.c
> +++ b/drivers/pci/host/pci-thunder-pem.c
> @@ -21,6 +21,7 @@
>  #include <linux/pci-acpi.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
> +#include "../pci.h"
>
>  #if defined(CONFIG_PCI_HOST_THUNDER_PEM) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
>
> @@ -324,6 +325,11 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
>         struct acpi_device *adev = to_acpi_device(dev);
>         struct acpi_pci_root *root = acpi_driver_data(adev);
>         struct resource *res_pem;
> + int ret;
> +
> + res_pem = devm_kzalloc(&adev->dev, sizeof(*res_pem), GFP_KERNEL);
> + if (!res_pem)
> +         return -ENOMEM;
>
>         ret = acpi_get_rc_resources("THRX0002", root->segment, res_pem);
>         if (ret) {
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> index ee378c2..6b39939 100644
> --- a/drivers/pci/host/pcie-hisi.c
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -22,6 +22,7 @@
>  #include <linux/pci-acpi.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/regmap.h>
> +#include "../pci.h"
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>
> @@ -80,15 +81,20 @@ static int hisi_pcie_init(struct pci_config_window *cfg)
>         struct acpi_pci_root *root = acpi_driver_data(adev);
>         struct resource *res;
>         void __iomem *reg_base;
> + int ret;
> +
> + res = devm_kzalloc(&adev->dev, sizeof(*res), GFP_KERNEL);
> + if (!res)
> +         return -ENOMEM;
>
>         /*
>          * Retrieve RC base and size from a HISI0081 device with _UID
>          * matching our segment.
>          */
> -   res = acpi_get_rc_resources("HISI0081", root->segment);
> -   if (!res) {
> -           dev_err(dev, "can't get rc base address\n");
> -           return -ENOMEM;
> + ret = acpi_get_rc_resources("HISI0081", root->segment, res);
> + if (ret) {
> +         dev_err(&adev->dev, "can't get rc base address");
> +         return ret;
>         }
>
>         reg_base = devm_ioremap(dev, res->start, resource_size(res));
>
>
> Thanks,
> Dongdong

Aftet fixing the compile errors. I tested on HiSilicon D03 board. It works ok.
The dmesg is as below

root@(none)$ dmesg
[    0.000000] Booting Linux on physical CPU 0x10000
[    0.000000] Linux version 4.9.0-rc1-gaf05ef2-dirty (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #257 SMP PREEMPT Thu Dec 1 22:13:05 CST 2016
[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] earlycon: hisilpcuart0 at MMIO 0x00000000a01b0000 (options '0,0x2f8')
[    0.000000] bootconsole [hisilpcuart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS=0x3f110000  SMBIOS 3.0=0x39ce0000  ACPI=0x39db0000  ACPI 2.0=0x39db0014  MEMATTR=0x3c945018
[    0.000000] cma: Reserved 16 MiB at 0x000000003e000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000039DB0014 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x0000000039DA00E8 00004C (v01 HISI   HIP06    00000000      01000013)
[    0.000000] ACPI: FACP 0x0000000039CA0000 00010C (v05 HISI   HIP06    00000000 INTL 20151124)
[    0.000000] ACPI: DSDT 0x0000000039C60000 0038CE (v01 HISI   HIP06    00000000 INTL 20150619)
[    0.000000] ACPI: MCFG 0x0000000039CC0000 00005C (v01 HISI   HIP06    00000000 INTL 20151124)
[    0.000000] ACPI: GTDT 0x0000000039C90000 000098 (v02 HISI   HIP06    00000000 INTL 20151124)
[    0.000000] ACPI: APIC 0x0000000039C80000 000518 (v01 HISI   HIP06    00000000 INTL 20151124)
[    0.000000] ACPI: IORT 0x0000000039C70000 0002E8 (v00 HISI   HIP06    00000000 INTL 20150619)
[    0.000000] ACPI: NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000027ffffffff]
[    0.000000] NUMA: Adding memblock [0x0 - 0x257ff] on node 0
[    0.000000] NUMA: Adding memblock [0x25800 - 0x319fffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31a00000 - 0x31a6ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31a70000 - 0x31b5ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b60000 - 0x31b6ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b70000 - 0x31b7dfff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b7e000 - 0x31b81fff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b82000 - 0x39c0ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x39c10000 - 0x3a11ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x3a120000 - 0x3f10ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x3f110000 - 0x3f13ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x3f140000 - 0x3fbfffff] on node 0
[    0.000000] NUMA: Adding memblock [0x2040000000 - 0x27ffffffff] on node 0
[    0.000000] NUMA: Initmem setup node 0 [mem 0x00000000-0x27ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x27fffef500-0x27ffff0fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000027ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000000024fff]
[    0.000000]   node   0: [mem 0x0000000000026000-0x00000000319fffff]
[    0.000000]   node   0: [mem 0x0000000031a00000-0x0000000031a6ffff]
[    0.000000]   node   0: [mem 0x0000000031a70000-0x0000000031b5ffff]
[    0.000000]   node   0: [mem 0x0000000031b60000-0x0000000031b6ffff]
[    0.000000]   node   0: [mem 0x0000000031b70000-0x0000000031b7dfff]
[    0.000000]   node   0: [mem 0x0000000031b7e000-0x0000000031b81fff]
[    0.000000]   node   0: [mem 0x0000000031b82000-0x0000000039c0ffff]
[    0.000000]   node   0: [mem 0x0000000039c10000-0x000000003a11ffff]
[    0.000000]   node   0: [mem 0x000000003a120000-0x000000003f10ffff]
[    0.000000]   node   0: [mem 0x000000003f110000-0x000000003f13ffff]
[    0.000000]   node   0: [mem 0x000000003f140000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000002040000000-0x00000027ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000027ffffffff]
[    0.000000] On node 0 totalpages: 8387583
[    0.000000]   DMA zone: 4080 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 261119 pages, LIFO batch:31
[    0.000000]   Normal zone: 126976 pages used for memmap
[    0.000000]   Normal zone: 8126464 pages, LIFO batch:31
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] percpu: Embedded 21 pages/cpu @ffff8027ffe6c000 s48000 r8192 d29824 u86016
[    0.000000] pcpu-alloc: s48000 r8192 d29824 u86016 alloc=21*4096
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07
[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 832075
[    0.000000] CPU features: enabling workaround for ARM erratum 834220
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 8256527
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: earlycon=hisilpcuart,mmio,0xa01b0000,0,0x2f8 console=ttyS0,115200 initrd=filesystem.cpio.gz acpi=force pcie_aspm=off pci=pcie_bus_perf
[    0.000000] PCIe ASPM is disabled
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 61440 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 131072 bytes
[    0.000000] early log buf free: 10700(65%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] software IO TLB [mem 0x35c10000-0x39c10000] (64MB) mapped at [ffff800035c10000-ffff800039c0ffff]
[    0.000000] Memory: 32894040K/33550332K available (8380K kernel code, 864K rwdata, 3680K rodata, 1024K init, 286K bss, 639908K reserved, 16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff0000088b0000   (  8384 KB)
[    0.000000]     .rodata : 0xffff0000088b0000 - 0xffff000008c50000   (  3712 KB)
[    0.000000]       .init : 0xffff000008c50000 - 0xffff000008d50000   (  1024 KB)
[    0.000000]       .data : 0xffff000008d50000 - 0xffff000008e28200   (   865 KB)
[    0.000000]        .bss : 0xffff000008e28200 - 0xffff000008e6fdc0   (   287 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e00a0000000   (  2560 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff802800000000   (163840 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=16
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] ITS [mem 0xc6000000-0xc601ffff]
[    0.000000] ITS@0x00000000c6000000: allocated 524288 Devices @27df400000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 2048 Virtual CPUs @27df814000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 512 Interrupt Collections @27df811000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] GIC: using LPI property table @0x00000027df830000
[    0.000000] ITS: Allocated 1792 chunks for LPIs
[    0.000000] GICv3: CPU0: found redistributor 10000 region 0:0x000000004d100000
[    0.000000] CPU0: using LPI pending table @0x00000027df840000
[    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000002] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.009100] Console: colour dummy device 80x25
[    0.014154] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.025976] pid_max: default: 32768 minimum: 301
[    0.031197] ACPI: Core revision 20160831
[    0.036669] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.045562] Security Framework initialized
[    0.054566] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.075798] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.089463] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.097298] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.106386] ASID allocator initialised with 65536 entries
[    0.144537] PCI/MSI: ITS@0xc6000000 domain created
[    0.149957] Platform MSI: ITS@0xc6000000 domain created
[    0.155909] Remapping and enabling EFI services.
[    0.161174]   EFI remap 0x0000000031a00000 => 0000000020000000
[    0.167801]   EFI remap 0x0000000031b60000 => 0000000020070000
[    0.174434]   EFI remap 0x0000000039c10000 => 0000000020080000
[    0.181083]   EFI remap 0x0000000039c50000 => 00000000200c0000
[    0.187715]   EFI remap 0x0000000039cd0000 => 00000000200d0000
[    0.194361]   EFI remap 0x0000000039d50000 => 0000000020150000
[    0.200988]   EFI remap 0x0000000039dc0000 => 00000000201a0000
[    0.207641]   EFI remap 0x0000000039e10000 => 00000000201f0000
[    0.214262]   EFI remap 0x0000000039f20000 => 0000000020300000
[    0.220894]   EFI remap 0x0000000039f90000 => 0000000020370000
[    0.227539]   EFI remap 0x0000000039fe0000 => 00000000203c0000
[    0.234165]   EFI remap 0x000000003a030000 => 0000000020410000
[    0.240800]   EFI remap 0x000000003a080000 => 0000000020460000
[    0.247436]   EFI remap 0x000000003a0d0000 => 00000000204b0000
[    0.254075]   EFI remap 0x000000003f110000 => 0000000020500000
[    0.260717]   EFI remap 0x0000000078000000 => 0000000020530000
[    0.267344]   EFI remap 0x00000000a4000000 => 0000000020600000
[    0.273936]   EFI remap 0x00000000a6000000 => 0000000021600000
[    0.280556]   EFI remap 0x00000000d00e0000 => 0000000021610000
[    0.387646] Detected PIPT I-cache on CPU1
[    0.387662] GICv3: CPU1: found redistributor 10001 region 1:0x000000004d130000
[    0.387693] CPU1: using LPI pending table @0x00000027dc300000
[    0.387709] CPU1: Booted secondary processor [411fd071]
[    0.468326] Detected PIPT I-cache on CPU2
[    0.468334] GICv3: CPU2: found redistributor 10002 region 2:0x000000004d160000
[    0.468363] CPU2: using LPI pending table @0x00000027dc330000
[    0.468374] CPU2: Booted secondary processor [411fd071]
[    0.549016] Detected PIPT I-cache on CPU3
[    0.549024] GICv3: CPU3: found redistributor 10003 region 3:0x000000004d190000
[    0.549054] CPU3: using LPI pending table @0x00000027dc370000
[    0.549064] CPU3: Booted secondary processor [411fd071]
[    0.629722] Detected PIPT I-cache on CPU4
[    0.629735] GICv3: CPU4: found redistributor 10100 region 4:0x000000004d1c0000
[    0.629765] CPU4: using LPI pending table @0x00000027dc3a0000
[    0.629779] CPU4: Booted secondary processor [411fd071]
[    0.710402] Detected PIPT I-cache on CPU5
[    0.710410] GICv3: CPU5: found redistributor 10101 region 5:0x000000004d1f0000
[    0.710439] CPU5: using LPI pending table @0x00000027dc3d0000
[    0.710449] CPU5: Booted secondary processor [411fd071]
[    0.791125] Detected PIPT I-cache on CPU6
[    0.791133] GICv3: CPU6: found redistributor 10102 region 6:0x000000004d220000
[    0.791162] CPU6: using LPI pending table @0x00000027dbc20000
[    0.791172] CPU6: Booted secondary processor [411fd071]
[    0.871819] Detected PIPT I-cache on CPU7
[    0.871827] GICv3: CPU7: found redistributor 10103 region 7:0x000000004d250000
[    0.871856] CPU7: using LPI pending table @0x00000027dbc50000
[    0.871866] CPU7: Booted secondary processor [411fd071]
[    0.952607] Detected PIPT I-cache on CPU8
[    0.952620] GICv3: CPU8: found redistributor 10200 region 8:0x000000004d280000
[    0.952652] CPU8: using LPI pending table @0x00000027dbc80000
[    0.952666] CPU8: Booted secondary processor [411fd071]
[    1.033263] Detected PIPT I-cache on CPU9
[    1.033271] GICv3: CPU9: found redistributor 10201 region 9:0x000000004d2b0000
[    1.033301] CPU9: using LPI pending table @0x00000027dbcc0000
[    1.033311] CPU9: Booted secondary processor [411fd071]
[    1.113992] Detected PIPT I-cache on CPU10
[    1.114000] GICv3: CPU10: found redistributor 10202 region 10:0x000000004d2e0000
[    1.114030] CPU10: using LPI pending table @0x00000027dbcf0000
[    1.114040] CPU10: Booted secondary processor [411fd071]
[    1.194677] Detected PIPT I-cache on CPU11
[    1.194685] GICv3: CPU11: found redistributor 10203 region 11:0x000000004d310000
[    1.194716] CPU11: using LPI pending table @0x00000027dbd30000
[    1.194726] CPU11: Booted secondary processor [411fd071]
[    1.275373] Detected PIPT I-cache on CPU12
[    1.275387] GICv3: CPU12: found redistributor 10300 region 12:0x000000004d340000
[    1.275418] CPU12: using LPI pending table @0x00000027dbd60000
[    1.275431] CPU12: Booted secondary processor [411fd071]
[    1.356063] Detected PIPT I-cache on CPU13
[    1.356072] GICv3: CPU13: found redistributor 10301 region 13:0x000000004d370000
[    1.356102] CPU13: using LPI pending table @0x00000027dbdb0000
[    1.356111] CPU13: Booted secondary processor [411fd071]
[    1.436757] Detected PIPT I-cache on CPU14
[    1.436766] GICv3: CPU14: found redistributor 10302 region 14:0x000000004d3a0000
[    1.436796] CPU14: using LPI pending table @0x00000027dbde0000
[    1.436806] CPU14: Booted secondary processor [411fd071]
[    1.517449] Detected PIPT I-cache on CPU15
[    1.517458] GICv3: CPU15: found redistributor 10303 region 15:0x000000004d3d0000
[    1.517489] CPU15: using LPI pending table @0x00000027dbe10000
[    1.517499] CPU15: Booted secondary processor [411fd071]
[    1.517538] Brought up 16 CPUs
[    1.899942] SMP: Total of 16 processors activated.
[    1.905353] CPU features: detected feature: GIC system register CPU interface
[    1.913415] CPU features: detected feature: 32-bit EL0 Support
[    1.920062] CPU: All CPU(s) started at EL2
[    1.924754] alternatives: patching kernel code
[    1.934743] devtmpfs: initialized
[    1.938851] SMBIOS 3.0.0 present.
[    1.942710] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.953985] pinctrl core: initialized pinctrl subsystem
[    1.960338] NET: Registered protocol family 16
[    1.998505] cpuidle: using governor menu
[    2.003034] vdso: 2 pages (1 code @ ffff0000088b7000, 1 data @ ffff000008d54000)
[    2.011473] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    2.019756] DMA: preallocated 256 KiB pool for atomic allocations
[    2.026887] ACPI: bus type PCI registered
[    2.031550] Serial: AMBA PL011 UART driver
[    2.068489] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.076311] ACPI: Added _OSI(Module Device)
[    2.081138] ACPI: Added _OSI(Processor Device)
[    2.086243] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.091662] ACPI: Added _OSI(Processor Aggregator Device)
[    2.099799] ACPI: Interpreter enabled
[    2.104019] ACPI: Using GIC for interrupt routing
[    2.109466] ACPI: MCFG table detected, 3 entries
[    2.132280] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    2.139416] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.147563] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    2.155225] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f] with hisi_pcie_ops
[    2.167558] acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0xb0000000-0xb1ffffff] not reserved in ACPI namespace
[    2.179629] acpi PNP0A08:00: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f]
[    2.188199] Remapped I/O 0x00000000b7ff0000 to [io  0x0000-0xffff window]
[    2.196013] PCI host bridge to bus 0000:00
[    2.200679] pci_bus 0000:00: root bus resource [mem 0xb2000000-0xb7feffff window]
[    2.209233] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    2.216972] pci_bus 0000:00: root bus resource [bus 00-1f]
[    2.223225] pci 0000:00:00.0: [19e5:1610] type 01 class 0x060400
[    2.223236] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[    2.223273] pci 0000:00:00.0: supports D1 D2
[    2.223275] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    2.274630] pci 0000:00:00.0: BAR 0: assigned [mem 0xb2000000-0xb200ffff]
[    2.282374] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.288051] pci 0000:00:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.297714] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus e0-ff])
[    2.304770] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.312841] acpi PNP0A08:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    2.320388] acpi PNP0A08:01: MCFG quirk: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff] with hisi_pcie_ops
[    2.332547] acpi PNP0A08:01: [Firmware Bug]: ECAM area [mem 0xbe000000-0xbfffffff] not reserved in ACPI namespace
[    2.344507] acpi PNP0A08:01: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff]
[    2.352952] Remapped I/O 0x00000000bdff0000 to [io  0x10000-0x1ffff window]
[    2.360942] PCI host bridge to bus 0001:e0
[    2.365614] pci_bus 0001:e0: root bus resource [mem 0xb8000000-0xbdfeffff window]
[    2.374118] pci_bus 0001:e0: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
[    2.385041] pci_bus 0001:e0: root bus resource [bus e0-ff]
[    2.391302] pci 0001:e0:00.0: [19e5:1610] type 01 class 0x060400
[    2.391310] pci 0001:e0:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    2.391318] pci 0001:e0:00.0: reg 0x38: [mem 0xfffe0000-0xffffffff pref]
[    2.391345] pci 0001:e0:00.0: supports D1 D2
[    2.391347] pci 0001:e0:00.0: PME# supported from D0 D1 D3hot
[    2.391476] pci 0001:e1:00.0: [1000:005d] type 00 class 0x010400
[    2.391484] pci 0001:e1:00.0: reg 0x10: [io  0x10000-0x100ff]
[    2.391492] pci 0001:e1:00.0: reg 0x14: [mem 0xb8100000-0xb810ffff 64bit]
[    2.391499] pci 0001:e1:00.0: reg 0x1c: [mem 0xb8000000-0xb80fffff 64bit]
[    2.391506] pci 0001:e1:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
[    2.391556] pci 0001:e1:00.0: supports D1 D2
[    2.391637] pci 0001:e0:00.0: BAR 14: assigned [mem 0xb8000000-0xb82fffff]
[    2.399463] pci 0001:e0:00.0: BAR 6: assigned [mem 0xb8300000-0xb831ffff pref]
[    2.407702] pci 0001:e0:00.0: BAR 0: assigned [mem 0xb8320000-0xb8320fff]
[    2.415444] pci 0001:e0:00.0: BAR 13: assigned [io  0x10000-0x10fff]
[    2.422698] pci 0001:e1:00.0: BAR 3: assigned [mem 0xb8000000-0xb80fffff 64bit]
[    2.431020] pci 0001:e1:00.0: BAR 6: assigned [mem 0xb8100000-0xb81fffff pref]
[    2.439262] pci 0001:e1:00.0: BAR 1: assigned [mem 0xb8200000-0xb820ffff 64bit]
[    2.447623] pci 0001:e1:00.0: BAR 0: assigned [io  0x10000-0x100ff]
[    2.454741] pci 0001:e0:00.0: PCI bridge to [bus e1]
[    2.460383] pci 0001:e0:00.0:   bridge window [io  0x10000-0x10fff]
[    2.467533] pci 0001:e0:00.0:   bridge window [mem 0xb8000000-0xb82fffff]
[    2.475289] pci 0001:e0:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.484916] pci 0001:e1:00.0: Max Payload Size set to  512/4096 (was  128), Max Read Rq  512
[    2.494568] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-9f])
[    2.501617] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.509658] acpi PNP0A08:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    2.517222] acpi PNP0A08:02: MCFG quirk: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f] with hisi_pcie_ops
[    2.529349] acpi PNP0A08:02: [Firmware Bug]: ECAM area [mem 0xa8000000-0xa9ffffff] not reserved in ACPI namespace
[    2.541330] acpi PNP0A08:02: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f]
[    2.549806] Remapped I/O 0x00000000afff0000 to [io  0x20000-0x2ffff window]
[    2.557801] PCI host bridge to bus 0002:80
[    2.562472] pci_bus 0002:80: root bus resource [mem 0xaa000000-0xaffeffff window]
[    2.570987] pci_bus 0002:80: root bus resource [io  0x20000-0x2ffff window] (bus address [0x0000-0xffff])
[    2.581895] pci_bus 0002:80: root bus resource [bus 80-9f]
[    2.588173] pci 0002:80:00.0: [19e5:1610] type 01 class 0x060400
[    2.588181] pci 0002:80:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[    2.588210] pci 0002:80:00.0: supports D1 D2
[    2.588212] pci 0002:80:00.0: PME# supported from D0 D1 D3hot
[    2.588342] pci 0002:81:00.0: [10b5:8725] type 01 class 0x060400
[    2.588353] pci 0002:81:00.0: reg 0x10: [mem 0xaa200000-0xaa23ffff]
[    2.588425] pci 0002:81:00.0: PME# supported from D0 D3hot D3cold
[    2.588574] pci 0002:82:00.0: [10b5:8725] type 01 class 0x060400
[    2.588655] pci 0002:82:00.0: PME# supported from D0 D3hot D3cold
[    2.588751] pci 0002:82:01.0: [10b5:8725] type 01 class 0x060400
[    2.588832] pci 0002:82:01.0: PME# supported from D0 D3hot D3cold
[    2.588931] pci 0002:82:02.0: [10b5:8725] type 01 class 0x060400
[    2.589012] pci 0002:82:02.0: PME# supported from D0 D3hot D3cold
[    2.589111] pci 0002:82:08.0: [10b5:8725] type 01 class 0x060400
[    2.589192] pci 0002:82:08.0: PME# supported from D0 D3hot D3cold
[    2.589405] pci 0002:84:00.0: [19e5:1711] type 00 class 0x030000
[    2.589423] pci 0002:84:00.0: reg 0x10: [mem 0xac000000-0xadffffff pref]
[    2.589433] pci 0002:84:00.0: reg 0x14: [mem 0xaa000000-0xaa1fffff]
[    2.589533] pci 0002:84:00.0: supports D1
[    2.589535] pci 0002:84:00.0: PME# supported from D0 D1 D3hot
[    2.589762] pci 0002:80:00.0: BAR 14: assigned [mem 0xaa000000-0xae7fffff]
[    2.597573] pci 0002:80:00.0: BAR 15: assigned [mem 0xae800000-0xaebfffff 64bit pref]
[    2.606517] pci 0002:80:00.0: BAR 0: assigned [mem 0xaec00000-0xaec0ffff]
[    2.614273] pci 0002:80:00.0: BAR 13: assigned [io  0x20000-0x21fff]
[    2.621528] pci 0002:81:00.0: BAR 14: assigned [mem 0xaa000000-0xadffffff]
[    2.629351] pci 0002:81:00.0: BAR 15: assigned [mem 0xae800000-0xaebfffff 64bit pref]
[    2.638284] pci 0002:81:00.0: BAR 0: assigned [mem 0xae000000-0xae03ffff]
[    2.646020] pci 0002:81:00.0: BAR 13: assigned [io  0x20000-0x21fff]
[    2.653254] pci 0002:82:01.0: BAR 14: assigned [mem 0xaa000000-0xacffffff]
[    2.661085] pci 0002:82:00.0: BAR 14: assigned [mem 0xad000000-0xad1fffff]
[    2.668915] pci 0002:82:00.0: BAR 15: assigned [mem 0xae800000-0xae9fffff 64bit pref]
[    2.677838] pci 0002:82:01.0: BAR 15: assigned [mem 0xaea00000-0xaebfffff 64bit pref]
[    2.686772] pci 0002:82:00.0: BAR 13: assigned [io  0x20000-0x20fff]
[    2.693990] pci 0002:82:01.0: BAR 13: assigned [io  0x21000-0x21fff]
[    2.701240] pci 0002:82:00.0: PCI bridge to [bus 83]
[    2.706889] pci 0002:82:00.0:   bridge window [io  0x20000-0x20fff]
[    2.714036] pci 0002:82:00.0:   bridge window [mem 0xad000000-0xad1fffff]
[    2.721785] pci 0002:82:00.0:   bridge window [mem 0xae800000-0xae9fffff 64bit pref]
[    2.730622] pci 0002:84:00.0: BAR 0: assigned [mem 0xaa000000-0xabffffff pref]
[    2.738866] pci 0002:84:00.0: BAR 1: assigned [mem 0xac000000-0xac1fffff]
[    2.746601] pci 0002:82:01.0: PCI bridge to [bus 84]
[    2.752263] pci 0002:82:01.0:   bridge window [io  0x21000-0x21fff]
[    2.759402] pci 0002:82:01.0:   bridge window [mem 0xaa000000-0xacffffff]
[    2.767128] pci 0002:82:01.0:   bridge window [mem 0xaea00000-0xaebfffff 64bit pref]
[    2.775953] pci 0002:82:02.0: PCI bridge to [bus 85]
[    2.781617] pci 0002:82:08.0: PCI bridge to [bus 86]
[    2.787270] pci 0002:81:00.0: PCI bridge to [bus 82-86]
[    2.793225] pci 0002:81:00.0:   bridge window [io  0x20000-0x21fff]
[    2.800360] pci 0002:81:00.0:   bridge window [mem 0xaa000000-0xadffffff]
[    2.808112] pci 0002:81:00.0:   bridge window [mem 0xae800000-0xaebfffff 64bit pref]
[    2.816952] pci 0002:80:00.0: PCI bridge to [bus 81-86]
[    2.822902] pci 0002:80:00.0:   bridge window [io  0x20000-0x21fff]
[    2.830045] pci 0002:80:00.0:   bridge window [mem 0xaa000000-0xae7fffff]
[    2.837753] pci 0002:80:00.0:   bridge window [mem 0xae800000-0xaebfffff 64bit pref]
[    2.846608] pci 0002:80:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.856245] pci 0002:81:00.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.865870] pci 0002:82:00.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.875504] pci 0002:82:01.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.885114] pci 0002:84:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
[    2.894747] pci 0002:82:02.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.904377] pci 0002:82:08.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.914432] vgaarb: device added: PCI:0002:84:00.0,decodes=io+mem,owns=none,locks=none
[    2.923379] vgaarb: loaded
[    2.926430] vgaarb: bridge control possible 0002:84:00.0
[    2.932577] SCSI subsystem initialized
[    2.936899] libata version 3.00 loaded.
[    2.936975] ACPI: bus type USB registered
[    2.941550] usbcore: registered new interface driver usbfs
[    2.947775] usbcore: registered new interface driver hub
[    2.953827] usbcore: registered new device driver usb
[    2.959651] pps_core: LinuxPPS API ver. 1 registered
[    2.965259] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.975584] PTP clock support registered
[    2.980084] Registered efivars operations
[    2.984816] Advanced Linux Sound Architecture Driver Initialized.
[    2.992097] clocksource: Switched to clocksource arch_sys_counter
[    2.999063] VFS: Disk quotas dquot_6.6.0
[    3.003527] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.011433] pnp: PnP ACPI init
[    3.015076] system 00:00: [mem 0xa0090000-0xa009ffff] has been reserved
[    3.022595] system 00:00: [mem 0xb0000000-0xb01fffff] could not be reserved
[    3.030505] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.030567] system 00:01: [mem 0xa0200000-0xa020ffff] has been reserved
[    3.038058] system 00:01: [mem 0xbe000000-0xbe1fffff] could not be reserved
[    3.045967] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.046031] system 00:02: [mem 0xa00a0000-0xa00affff] has been reserved
[    3.053529] system 00:02: [mem 0xa8000000-0xa81fffff] could not be reserved
[    3.061424] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.061431] pnp: PnP ACPI: found 3 devices
[    3.068917] NET: Registered protocol family 2
[    3.074383] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    3.083534] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    3.091504] TCP: Hash tables configured (established 262144 bind 65536)
[    3.099135] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    3.106382] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    3.114144] NET: Registered protocol family 1
[    3.119275] RPC: Registered named UNIX socket transport module.
[    3.125985] RPC: Registered udp transport module.
[    3.131334] RPC: Registered tcp transport module.
[    3.136676] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.144004] pci 0001:e1:00.0: [Firmware Bug]: VPD access disabled
[    3.150929] PCI: CLS 0 bytes, default 128
[    3.151018] Unpacking initramfs...
[    3.537707] Freeing initrd memory: 27492K (ffff80001e520000 - ffff80001fff9000)
[    3.546265] kvm [1]: 8-bit VMID
[    3.549831] kvm [1]: IDMAP page: 89f000
[    3.554178] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    3.561314] kvm [1]: Hyp mode initialized successfully
[    3.567168] kvm [1]: vgic-v2@fe020000
[    3.571353] kvm [1]: GIC system register CPU interface enabled
[    3.578148] kvm [1]: vgic interrupt IRQ1
[    3.582627] kvm [1]: virtual timer IRQ4
[    3.588653] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    3.595882] audit: initializing netlink subsys (disabled)
[    3.602047] audit: type=2000 audit(2.956:1): initialized
[    3.608314] workingset: timestamp_bits=44 max_order=23 bucket_order=0
[    3.619690] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.626680] NFS: Registering the id_resolver key type
[    3.632403] Key type id_resolver registered
[    3.637128] Key type id_legacy registered
[    3.641661] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    3.649298] 9p: Installing v9fs 9p2000 file system support
[    3.656725] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    3.665084] io scheduler noop registered
[    3.669570] io scheduler cfq registered (default)
[    3.675102] libphy: mdio_driver_register: phy-bcm-ns2-pci
[    3.681559] pcieport 0000:00:00.0: can't derive routing for PCI INT A
[    3.688840] pcieport 0000:00:00.0: PCI INT A: no GSI
[    3.694505] pcieport 0001:e0:00.0: can't derive routing for PCI INT A
[    3.701786] pcieport 0001:e0:00.0: PCI INT A: no GSI
[    3.707428] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.714707] pcieport 0002:80:00.0: PCI INT A: no GSI
[    3.720344] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.727624] pcieport 0002:81:00.0: PCI INT A: no GSI
[    3.733413] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.740694] pcieport 0002:82:00.0: PCI INT A: no GSI
[    3.746451] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.753735] pcieport 0002:82:01.0: PCI INT A: no GSI
[    3.759489] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.766772] pcieport 0002:82:02.0: PCI INT A: no GSI
[    3.772524] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.779807] pcieport 0002:82:08.0: PCI INT A: no GSI
[    3.785778] ipmi message handler version 39.2
[    3.790706] ipmi device interface
[    3.794487] IPMI System Interface driver.
[    3.799069] ipmi_si: probing via SMBIOS
[    3.803403] ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1 irq 0
[    3.809993] ipmi_si: Adding SMBIOS-specified bt state machine
[    3.816501] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
[    3.884142] IPMI BT: using default values
[    3.888667] IPMI BT: req2rsp=5 secs retries=2
[    4.100235] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0007db, prod_id: 0x0001, dev_id: 0x01)
[    4.110025] ipmi_si ipmi_si.0: IPMI bt interface initialized
[    4.117260] xenfs: not registering filesystem on non-xen platform
[    4.125541] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    4.133352] console [ttyS0] disabled
[    4.158766] serial8250.10: ttyS0 at I/O 0x2f8 (irq = 0, base_baud = 115200) is a 16550A
[    4.167898] console [ttyS0] enabled
[    4.175338] bootconsole [hisilpcuart0] disabled
[    4.185185] SuperH (H)SCI(F) driver initialized
[    4.189785] msm_serial: driver initialized
[    4.194110] Failed to find cpu0 device node
[    4.198295] Unable to detect cache hierarchy from DT for CPU 0
[    4.207123] loop: module loaded
[    4.210478] hisi_sas: driver version v1.6
[    4.348649] scsi host0: hisi_sas
[    4.484723] scsi host1: hisi_sas
[    4.620658] scsi host2: hisi_sas
[    4.625341] libphy: Fixed MDIO Bus: probed
[    4.629582] tun: Universal TUN/TAP device driver, 1.6
[    4.634629] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    4.720102] libphy: Hisilicon MII Bus: probed
[    5.600184] netif_napi_add() called with weight 256 on device eth%d
[    5.696720] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    5.702548] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    5.708498] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    5.715445] igb: Copyright (c) 2007-2014 Intel Corporation.
[    5.721036] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    5.728847] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    5.734778] sky2: driver version 1.30
[    5.738625] VFIO - User Level meta-driver version: 0.3
[    5.744591] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.751111] ehci-pci: EHCI PCI platform driver
[    5.755572] ehci-platform: EHCI generic platform driver
[    5.760845] ehci-platform PNP0D20:00: EHCI Host Controller
[    5.766332] ehci-platform PNP0D20:00: new USB bus registered, assigned bus number 1
[    5.774080] ehci-platform PNP0D20:00: irq 6, io mem 0xa7020000
[    5.792104] ehci-platform PNP0D20:00: USB 2.0 started, EHCI 1.00
[    5.798407] hub 1-0:1.0: USB hub found
[    5.802169] hub 1-0:1.0: 2 ports detected
[    5.806398] ehci-exynos: EHCI EXYNOS driver
[    5.810612] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    5.816197] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.822371] ohci-pci: OHCI PCI platform driver
[    5.826836] ohci-platform: OHCI generic platform driver
[    5.832073] ohci-exynos: OHCI EXYNOS driver
[    5.836366] usbcore: registered new interface driver usb-storage
[    5.842629] mousedev: PS/2 mouse device common for all mice
[    5.974335] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    5.980559] i2c /dev entries driver
[    5.984504] sdhci: Secure Digital Host Controller Interface driver
[    5.990672] sdhci: Copyright(c) Pierre Ossman
[    5.995083] Synopsys Designware Multimedia Card Interface Driver
[    6.001153] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.007096] ledtrig-cpu: registered to indicate activity on CPUs
[    6.013424] usbcore: registered new interface driver usbhid
[    6.018991] usbhid: USB HID core driver
[    6.023298] NET: Registered protocol family 17
[    6.027786] 9pnet: Installing 9P2000 support
[    6.032082] Key type dns_resolver registered
[    6.036587] registered taskstats version 1
[    6.104037] rtc-efi rtc-efi: setting system clock to 2016-12-01 22:00:02 UTC (1480629602)
[    6.112251] ALSA device list:
[    6.115221]   No soundcards found.
[    6.119269] Freeing unused kernel memory: 1024K (ffff800000c50000 - ffff800000d50000)
[    6.160105] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    6.312719] hub 1-1:1.0: USB hub found
[    6.316542] hub 1-1:1.0: 4 ports detected
[    6.440100] usb 1-2: new high-speed USB device number 3 using ehci-platform
[    6.592714] hub 1-2:1.0: USB hub found
[    6.596542] hub 1-2:1.0: 4 ports detected
[    6.888098] usb 1-2.1: new full-speed USB device number 4 using ehci-platform
[    7.004739] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/PNP0D20:00/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input0
[    7.076340] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-PNP0D20:00-2.1/input0
[    7.089213] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/PNP0D20:00/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input1
[    7.101270] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 Mouse [Keyboard/Mouse KVM 1.1.0] on usb-PNP0D20:00-2.1/input1
