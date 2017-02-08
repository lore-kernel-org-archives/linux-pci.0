Return-Path: <SRS0=SnmU=ZV=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=SnmU=ZV=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V3] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1486362304-56261-1-git-send-email-liudongdong3@huawei.com>
 <20170206224041.GB27899@bhelgaas-glaptop.roam.corp.google.com>
 <89c7b769-f410-1526-b147-b3361b4fa9d7@huawei.com>
 <20170207144754.GA11769@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <16bf01d2-2d8e-e44d-d1b0-fcb3cbff5fba@huawei.com>
Date: Wed, 8 Feb 2017 10:39:48 +0800
MIME-Version: 1.0
In-Reply-To: <20170207144754.GA11769@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

在 2017/2/7 22:47, Bjorn Helgaas 写道:
> On Tue, Feb 07, 2017 at 09:34:43AM +0800, Dongdong Liu wrote:
>> Hi Bjorn
>>
>> 在 2017/2/7 6:40, Bjorn Helgaas 写道:
>>> On Mon, Feb 06, 2017 at 02:25:04PM +0800, Dongdong Liu wrote:
>>>> The PCIe controller in Hip06/Hip07 SoCs is not completely
>>>> ECAM-compliant. It is non-ECAM only for the RC bus config space; for
>>>> any other bus underneath the root bus it does support ECAM access.
>>>> This is to add the almost ECAM support in DT way.
>>>>
>>>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>>>> Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>>> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
>>>
>>> Applied to pci/host-hisi for v4.11, thanks!
>>
>> Thanks for applying this patch.
>>
>>>
>>>> -#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>>>> +#if defined(CONFIG_PCI_HISI) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
>>>>
>>>> static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>>>> 				  int size, u32 *val)
>>>
>>> These "_acpi_" accessors are now used for both the ACPI and the DT
>>> model, and the accessors aren't ACPI-specific anyway.  So these are
>>> slight misnomers.
>>
>> Yes, It is better to change hisi_pcie_acpi_rd_conf()/ hisi_pcie_acpi_wr_conf() to hisi_pcie_rd_conf()/hisi_pcie_wr_conf().
>
> I added a trivial patch to do this rename.

Thanks for doing that. The patch looks good to me.

>
>>>> +static int hisi_pcie_platform_init(struct pci_config_window *cfg)
>>>> +{
>>>> +	struct device *dev = cfg->parent;
>>>> +	struct platform_device *pdev = to_platform_device(dev);
>>>> +	struct resource *res;
>>>> +	void __iomem *reg_base;
>>>> +
>>>> +	if (!dev->of_node)
>>>> +		return -EINVAL;
>>>
>>> What's the point of testing dev->of_node here?  There's no obvious
>>> dependency on of_node in this code.  Could we just drop this test?
>>
>> Yes, only DT driver will call this function, we should drop this test.
>> Thanks for pointing this.
>
> I dropped this test.
>
> Please check out
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-hisi
> to make sure it looks OK.

I tested the patchset on HiSilicon D05 board. It works ok.

>
> I haven't applied the IRQ patch yet, but am looking at that next.

Thanks for looking at that.

Thanks,
Dongdong

Tested-by: Dongdong Liu <liudongdong3@huawei.com>

[    0.000000] Booting Linux on physical CPU 0x10000
[    0.000000] Linux version 4.10.0-rc1-g64503ab-dirty (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #320 SMP PREEMPT Wed Feb 8 10:24:56 CST 2017
[    0.000000] Boot CPU: AArch64 Processor [410fd082]
[    0.000000] earlycon: pl11 at MMIO 0x00000000602b0000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS=0x3f110000  SMBIOS 3.0=0x39c80000  ACPI=0x39d50000  ACPI 2.0=0x39d50014  MEMATTR=0x3c956018
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
[    0.008208] Console: colour dummy device 80x25
[    0.012726] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.023279] pid_max: default: 65536 minimum: 512
[    0.027987] Security Framework initialized
[    0.040593] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.075227] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.094217] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.101478] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.137068] ASID allocator initialised with 65536 entries
[    0.162557] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@4c000000 domain created
[    0.171444] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@6c000000 domain created
[    0.180328] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@c6000000 domain created
[    0.189210] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@8,c6000000 domain created
[    0.198268] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@400,4c000000 domain created
[    0.207501] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@400,6c000000 domain created
[    0.216735] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@400,c6000000 domain created
[    0.225967] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@408,c6000000 domain created
[    0.235219] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@4c000000 domain created
[    0.244541] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@6c000000 domain created
[    0.253861] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@c6000000 domain created
[    0.263183] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@8,c6000000 domain created
[    0.272680] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@400,4c000000 domain created
[    0.282352] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@400,6c000000 domain created
[    0.292025] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@400,c6000000 domain created
[    0.301699] Platform MSI: /interrupt-controller@4d000000/interrupt-controller@408,c6000000 domain created
[    0.311523] Remapping and enabling EFI services.
[    0.316210]   EFI remap 0x00000000319c0000 => 0000000020000000
[    0.322108]   EFI remap 0x0000000031b10000 => 0000000020070000
[    0.328005]   EFI remap 0x0000000039b90000 => 0000000020080000
[    0.333902]   EFI remap 0x0000000039bd0000 => 00000000200c0000
[    0.339799]   EFI remap 0x0000000039c70000 => 00000000200d0000
[    0.345696]   EFI remap 0x0000000039cf0000 => 0000000020150000
[    0.351593]   EFI remap 0x0000000039d60000 => 00000000201a0000
[    0.357496]   EFI remap 0x0000000039db0000 => 00000000201f0000
[    0.363393]   EFI remap 0x0000000039e00000 => 0000000020240000
[    0.369291]   EFI remap 0x0000000039e50000 => 0000000020290000
[    0.375188]   EFI remap 0x0000000039f20000 => 0000000020360000
[    0.381091]   EFI remap 0x0000000039f90000 => 00000000203d0000
[    0.386988]   EFI remap 0x0000000039fe0000 => 0000000020420000
[    0.392885]   EFI remap 0x000000003a030000 => 0000000020470000
[    0.398782]   EFI remap 0x000000003a080000 => 00000000204c0000
[    0.404679]   EFI remap 0x000000003a0d0000 => 0000000020510000
[    0.410577]   EFI remap 0x000000003f110000 => 0000000020560000
[    0.416474]   EFI remap 0x0000000078000000 => 0000000020590000
[    0.422371]   EFI remap 0x00000000a4000000 => 0000000020600000
[    0.428272]   EFI remap 0x00000000a6000000 => 0000000021600000
[    0.434169]   EFI remap 0x00000000d00e0000 => 0000000021610000
[    0.456074] smp: Bringing up secondary CPUs ...
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
[    0.535005] Detected PIPT I-cache on CPU1
[    0.535014] GICv3: CPU1: found redistributor 10001 region 0:0x000000004d140000
[    0.535055] CPU1: using LPI pending table @0x00000417b29b0000
[    0.535634] CPU1: Booted secondary processor [410fd082]
[    0.609378] Detected PIPT I-cache on CPU2
[    0.609384] GICv3: CPU2: found redistributor 10002 region 0:0x000000004d180000
[    0.609425] CPU2: using LPI pending table @0x00000417b29e0000
[    0.610006] CPU2: Booted secondary processor [410fd082]
[    0.683753] Detected PIPT I-cache on CPU3
[    0.683759] GICv3: CPU3: found redistributor 10003 region 0:0x000000004d1c0000
[    0.683798] CPU3: using LPI pending table @0x00000417b2a30000
[    0.684376] CPU3: Booted secondary processor [410fd082]
[    0.758130] Detected PIPT I-cache on CPU4
[    0.758138] GICv3: CPU4: found redistributor 10100 region 0:0x000000004d200000
[    0.758178] CPU4: using LPI pending table @0x00000417b2a50000
[    0.758757] CPU4: Booted secondary processor [410fd082]
[    0.832506] Detected PIPT I-cache on CPU5
[    0.832512] GICv3: CPU5: found redistributor 10101 region 0:0x000000004d240000
[    0.832553] CPU5: using LPI pending table @0x00000417b2a90000
[    0.833133] CPU5: Booted secondary processor [410fd082]
[    0.906882] Detected PIPT I-cache on CPU6
[    0.906888] GICv3: CPU6: found redistributor 10102 region 0:0x000000004d280000
[    0.906928] CPU6: using LPI pending table @0x00000417b2ac0000
[    0.907507] CPU6: Booted secondary processor [410fd082]
[    0.981259] Detected PIPT I-cache on CPU7
[    0.981265] GICv3: CPU7: found redistributor 10103 region 0:0x000000004d2c0000
[    0.981306] CPU7: using LPI pending table @0x00000417b2af0000
[    0.981884] CPU7: Booted secondary processor [410fd082]
[    1.055636] Detected PIPT I-cache on CPU8
[    1.055644] GICv3: CPU8: found redistributor 10200 region 0:0x000000004d300000
[    1.055684] CPU8: using LPI pending table @0x00000417b2b30000
[    1.056263] CPU8: Booted secondary processor [410fd082]
[    1.130012] Detected PIPT I-cache on CPU9
[    1.130019] GICv3: CPU9: found redistributor 10201 region 0:0x000000004d340000
[    1.130059] CPU9: using LPI pending table @0x00000417b2b60000
[    1.130635] CPU9: Booted secondary processor [410fd082]
[    1.204389] Detected PIPT I-cache on CPU10
[    1.204395] GICv3: CPU10: found redistributor 10202 region 0:0x000000004d380000
[    1.204435] CPU10: using LPI pending table @0x00000417b2b90000
[    1.205016] CPU10: Booted secondary processor [410fd082]
[    1.278765] Detected PIPT I-cache on CPU11
[    1.278772] GICv3: CPU11: found redistributor 10203 region 0:0x000000004d3c0000
[    1.278812] CPU11: using LPI pending table @0x00000417b2bd0000
[    1.279390] CPU11: Booted secondary processor [410fd082]
[    1.353143] Detected PIPT I-cache on CPU12
[    1.353151] GICv3: CPU12: found redistributor 10300 region 0:0x000000004d400000
[    1.353193] CPU12: using LPI pending table @0x00000417b2bf0000
[    1.353775] CPU12: Booted secondary processor [410fd082]
[    1.427518] Detected PIPT I-cache on CPU13
[    1.427525] GICv3: CPU13: found redistributor 10301 region 0:0x000000004d440000
[    1.427564] CPU13: using LPI pending table @0x00000417b2430000
[    1.428143] CPU13: Booted secondary processor [410fd082]
[    1.501894] Detected PIPT I-cache on CPU14
[    1.501901] GICv3: CPU14: found redistributor 10302 region 0:0x000000004d480000
[    1.501938] CPU14: using LPI pending table @0x00000417b2460000
[    1.502520] CPU14: Booted secondary processor [410fd082]
[    1.576270] Detected PIPT I-cache on CPU15
[    1.576277] GICv3: CPU15: found redistributor 10303 region 0:0x000000004d4c0000
[    1.576317] CPU15: using LPI pending table @0x00000417b24a0000
[    1.576895] CPU15: Booted secondary processor [410fd082]
[    1.650304] Detected PIPT I-cache on CPU16
[    1.650315] GICv3: CPU16: found redistributor 30000 region 1:0x000000006d100000
[    1.650357] CPU16: using LPI pending table @0x00000417b24d0000
[    1.650996] CPU16: Booted secondary processor [410fd082]
[    1.724684] Detected PIPT I-cache on CPU17
[    1.724691] GICv3: CPU17: found redistributor 30001 region 1:0x000000006d140000
[    1.724733] CPU17: using LPI pending table @0x00000417b2500000
[    1.725368] CPU17: Booted secondary processor [410fd082]
[    1.799068] Detected PIPT I-cache on CPU18
[    1.799075] GICv3: CPU18: found redistributor 30002 region 1:0x000000006d180000
[    1.799119] CPU18: using LPI pending table @0x00000417b2540000
[    1.799755] CPU18: Booted secondary processor [410fd082]
[    1.873450] Detected PIPT I-cache on CPU19
[    1.873458] GICv3: CPU19: found redistributor 30003 region 1:0x000000006d1c0000
[    1.873500] CPU19: using LPI pending table @0x00000417b2560000
[    1.874134] CPU19: Booted secondary processor [410fd082]
[    1.947835] Detected PIPT I-cache on CPU20
[    1.947847] GICv3: CPU20: found redistributor 30100 region 1:0x000000006d200000
[    1.947890] CPU20: using LPI pending table @0x00000417b25a0000
[    1.948528] CPU20: Booted secondary processor [410fd082]
[    2.022219] Detected PIPT I-cache on CPU21
[    2.022227] GICv3: CPU21: found redistributor 30101 region 1:0x000000006d240000
[    2.022269] CPU21: using LPI pending table @0x00000417b25d0000
[    2.022905] CPU21: Booted secondary processor [410fd082]
[    2.096601] Detected PIPT I-cache on CPU22
[    2.096609] GICv3: CPU22: found redistributor 30102 region 1:0x000000006d280000
[    2.096650] CPU22: using LPI pending table @0x00000417b2600000
[    2.097287] CPU22: Booted secondary processor [410fd082]
[    2.170987] Detected PIPT I-cache on CPU23
[    2.170995] GICv3: CPU23: found redistributor 30103 region 1:0x000000006d2c0000
[    2.171037] CPU23: using LPI pending table @0x00000417b2650000
[    2.171672] CPU23: Booted secondary processor [410fd082]
[    2.245372] Detected PIPT I-cache on CPU24
[    2.245383] GICv3: CPU24: found redistributor 30200 region 1:0x000000006d300000
[    2.245424] CPU24: using LPI pending table @0x00000417b2670000
[    2.246063] CPU24: Booted secondary processor [410fd082]
[    2.319755] Detected PIPT I-cache on CPU25
[    2.319763] GICv3: CPU25: found redistributor 30201 region 1:0x000000006d340000
[    2.319804] CPU25: using LPI pending table @0x00000417b26b0000
[    2.320440] CPU25: Booted secondary processor [410fd082]
[    2.394138] Detected PIPT I-cache on CPU26
[    2.394147] GICv3: CPU26: found redistributor 30202 region 1:0x000000006d380000
[    2.394188] CPU26: using LPI pending table @0x00000417b26e0000
[    2.394826] CPU26: Booted secondary processor [410fd082]
[    2.468524] Detected PIPT I-cache on CPU27
[    2.468532] GICv3: CPU27: found redistributor 30203 region 1:0x000000006d3c0000
[    2.468575] CPU27: using LPI pending table @0x00000417b2710000
[    2.469212] CPU27: Booted secondary processor [410fd082]
[    2.542910] Detected PIPT I-cache on CPU28
[    2.542921] GICv3: CPU28: found redistributor 30300 region 1:0x000000006d400000
[    2.542963] CPU28: using LPI pending table @0x00000417b2750000
[    2.543602] CPU28: Booted secondary processor [410fd082]
[    2.617294] Detected PIPT I-cache on CPU29
[    2.617302] GICv3: CPU29: found redistributor 30301 region 1:0x000000006d440000
[    2.617345] CPU29: using LPI pending table @0x00000417b2780000
[    2.617980] CPU29: Booted secondary processor [410fd082]
[    2.691676] Detected PIPT I-cache on CPU30
[    2.691684] GICv3: CPU30: found redistributor 30302 region 1:0x000000006d480000
[    2.691726] CPU30: using LPI pending table @0x00000417b27c0000
[    2.692363] CPU30: Booted secondary processor [410fd082]
[    2.766063] Detected PIPT I-cache on CPU31
[    2.766071] GICv3: CPU31: found redistributor 30303 region 1:0x000000006d4c0000
[    2.766113] CPU31: using LPI pending table @0x00000417b27f0000
[    2.766748] CPU31: Booted secondary processor [410fd082]
[    2.840122] Detected PIPT I-cache on CPU32
[    2.840152] GICv3: CPU32: found redistributor 50000 region 2:0x000004004d100000
[    2.840185] CPU32: using LPI pending table @0x00000417b2010000
[    2.840504] CPU32: Booted secondary processor [410fd082]
[    2.914497] Detected PIPT I-cache on CPU33
[    2.914513] GICv3: CPU33: found redistributor 50001 region 2:0x000004004d140000
[    2.914540] CPU33: using LPI pending table @0x00000417b2060000
[    2.914854] CPU33: Booted secondary processor [410fd082]
[    2.988883] Detected PIPT I-cache on CPU34
[    2.988899] GICv3: CPU34: found redistributor 50002 region 2:0x000004004d180000
[    2.988928] CPU34: using LPI pending table @0x00000417b2080000
[    2.989234] CPU34: Booted secondary processor [410fd082]
[    3.063273] Detected PIPT I-cache on CPU35
[    3.063289] GICv3: CPU35: found redistributor 50003 region 2:0x000004004d1c0000
[    3.063316] CPU35: using LPI pending table @0x00000417b20c0000
[    3.063619] CPU35: Booted secondary processor [410fd082]
[    3.137661] Detected PIPT I-cache on CPU36
[    3.137679] GICv3: CPU36: found redistributor 50100 region 2:0x000004004d200000
[    3.137706] CPU36: using LPI pending table @0x00000417b20f0000
[    3.138015] CPU36: Booted secondary processor [410fd082]
[    3.212050] Detected PIPT I-cache on CPU37
[    3.212067] GICv3: CPU37: found redistributor 50101 region 2:0x000004004d240000
[    3.212095] CPU37: using LPI pending table @0x00000417b2120000
[    3.212408] CPU37: Booted secondary processor [410fd082]
[    3.286439] Detected PIPT I-cache on CPU38
[    3.286455] GICv3: CPU38: found redistributor 50102 region 2:0x000004004d280000
[    3.286482] CPU38: using LPI pending table @0x00000417b2160000
[    3.286792] CPU38: Booted secondary processor [410fd082]
[    3.360829] Detected PIPT I-cache on CPU39
[    3.360845] GICv3: CPU39: found redistributor 50103 region 2:0x000004004d2c0000
[    3.360873] CPU39: using LPI pending table @0x00000417b2190000
[    3.361180] CPU39: Booted secondary processor [410fd082]
[    3.435217] Detected PIPT I-cache on CPU40
[    3.435235] GICv3: CPU40: found redistributor 50200 region 2:0x000004004d300000
[    3.435263] CPU40: using LPI pending table @0x00000417b21c0000
[    3.435572] CPU40: Booted secondary processor [410fd082]
[    3.509606] Detected PIPT I-cache on CPU41
[    3.509623] GICv3: CPU41: found redistributor 50201 region 2:0x000004004d340000
[    3.509650] CPU41: using LPI pending table @0x00000417b2200000
[    3.509956] CPU41: Booted secondary processor [410fd082]
[    3.583994] Detected PIPT I-cache on CPU42
[    3.584010] GICv3: CPU42: found redistributor 50202 region 2:0x000004004d380000
[    3.584038] CPU42: using LPI pending table @0x00000417b2220000
[    3.584349] CPU42: Booted secondary processor [410fd082]
[    3.658385] Detected PIPT I-cache on CPU43
[    3.658402] GICv3: CPU43: found redistributor 50203 region 2:0x000004004d3c0000
[    3.658429] CPU43: using LPI pending table @0x00000417b2260000
[    3.658734] CPU43: Booted secondary processor [410fd082]
[    3.732773] Detected PIPT I-cache on CPU44
[    3.732791] GICv3: CPU44: found redistributor 50300 region 2:0x000004004d400000
[    3.732819] CPU44: using LPI pending table @0x00000417b22a0000
[    3.733130] CPU44: Booted secondary processor [410fd082]
[    3.807162] Detected PIPT I-cache on CPU45
[    3.807179] GICv3: CPU45: found redistributor 50301 region 2:0x000004004d440000
[    3.807206] CPU45: using LPI pending table @0x00000417b22d0000
[    3.807509] CPU45: Booted secondary processor [410fd082]
[    3.881550] Detected PIPT I-cache on CPU46
[    3.881567] GICv3: CPU46: found redistributor 50302 region 2:0x000004004d480000
[    3.881595] CPU46: using LPI pending table @0x00000417b2300000
[    3.881898] CPU46: Booted secondary processor [410fd082]
[    3.955940] Detected PIPT I-cache on CPU47
[    3.955957] GICv3: CPU47: found redistributor 50303 region 2:0x000004004d4c0000
[    3.955985] CPU47: using LPI pending table @0x00000417b2330000
[    3.956292] CPU47: Booted secondary processor [410fd082]
[    4.029984] Detected PIPT I-cache on CPU48
[    4.030005] GICv3: CPU48: found redistributor 70000 region 3:0x000004006d100000
[    4.030029] CPU48: using LPI pending table @0x00000417b2390000
[    4.030304] CPU48: Booted secondary processor [410fd082]
[    4.104375] Detected PIPT I-cache on CPU49
[    4.104393] GICv3: CPU49: found redistributor 70001 region 3:0x000004006d140000
[    4.104416] CPU49: using LPI pending table @0x00000417b23c0000
[    4.104689] CPU49: Booted secondary processor [410fd082]
[    4.178762] Detected PIPT I-cache on CPU50
[    4.178780] GICv3: CPU50: found redistributor 70002 region 3:0x000004006d180000
[    4.178804] CPU50: using LPI pending table @0x00000417b1c00000
[    4.179078] CPU50: Booted secondary processor [410fd082]
[    4.253154] Detected PIPT I-cache on CPU51
[    4.253172] GICv3: CPU51: found redistributor 70003 region 3:0x000004006d1c0000
[    4.253195] CPU51: using LPI pending table @0x00000417b1c30000
[    4.253467] CPU51: Booted secondary processor [410fd082]
[    4.327544] Detected PIPT I-cache on CPU52
[    4.327565] GICv3: CPU52: found redistributor 70100 region 3:0x000004006d200000
[    4.327589] CPU52: using LPI pending table @0x00000417b1c60000
[    4.327861] CPU52: Booted secondary processor [410fd082]
[    4.401933] Detected PIPT I-cache on CPU53
[    4.401951] GICv3: CPU53: found redistributor 70101 region 3:0x000004006d240000
[    4.401974] CPU53: using LPI pending table @0x00000417b1ca0000
[    4.402243] CPU53: Booted secondary processor [410fd082]
[    4.476322] Detected PIPT I-cache on CPU54
[    4.476341] GICv3: CPU54: found redistributor 70102 region 3:0x000004006d280000
[    4.476364] CPU54: using LPI pending table @0x00000417b1cc0000
[    4.476646] CPU54: Booted secondary processor [410fd082]
[    4.550714] Detected PIPT I-cache on CPU55
[    4.550733] GICv3: CPU55: found redistributor 70103 region 3:0x000004006d2c0000
[    4.550754] CPU55: using LPI pending table @0x00000417b1d00000
[    4.551019] CPU55: Booted secondary processor [410fd082]
[    4.625105] Detected PIPT I-cache on CPU56
[    4.625126] GICv3: CPU56: found redistributor 70200 region 3:0x000004006d300000
[    4.625149] CPU56: using LPI pending table @0x00000417b1d30000
[    4.625425] CPU56: Booted secondary processor [410fd082]
[    4.699494] Detected PIPT I-cache on CPU57
[    4.699513] GICv3: CPU57: found redistributor 70201 region 3:0x000004006d340000
[    4.699535] CPU57: using LPI pending table @0x00000417b1d60000
[    4.699805] CPU57: Booted secondary processor [410fd082]
[    4.773882] Detected PIPT I-cache on CPU58
[    4.773901] GICv3: CPU58: found redistributor 70202 region 3:0x000004006d380000
[    4.773923] CPU58: using LPI pending table @0x00000417b1da0000
[    4.774194] CPU58: Booted secondary processor [410fd082]
[    4.848274] Detected PIPT I-cache on CPU59
[    4.848293] GICv3: CPU59: found redistributor 70203 region 3:0x000004006d3c0000
[    4.848316] CPU59: using LPI pending table @0x00000417b1dd0000
[    4.848592] CPU59: Booted secondary processor [410fd082]
[    4.922665] Detected PIPT I-cache on CPU60
[    4.922686] GICv3: CPU60: found redistributor 70300 region 3:0x000004006d400000
[    4.922709] CPU60: using LPI pending table @0x00000417b1e10000
[    4.922988] CPU60: Booted secondary processor [410fd082]
[    4.997055] Detected PIPT I-cache on CPU61
[    4.997074] GICv3: CPU61: found redistributor 70301 region 3:0x000004006d440000
[    4.997096] CPU61: using LPI pending table @0x00000417b1e40000
[    4.997376] CPU61: Booted secondary processor [410fd082]
[    5.071443] Detected PIPT I-cache on CPU62
[    5.071462] GICv3: CPU62: found redistributor 70302 region 3:0x000004006d480000
[    5.071485] CPU62: using LPI pending table @0x00000417b1e70000
[    5.071753] CPU62: Booted secondary processor [410fd082]
[    5.145834] Detected PIPT I-cache on CPU63
[    5.145853] GICv3: CPU63: found redistributor 70303 region 3:0x000004006d4c0000
[    5.145876] CPU63: using LPI pending table @0x00000417b1eb0000
[    5.146148] CPU63: Booted secondary processor [410fd082]
[    5.146212] smp: Brought up 1 node, 64 CPUs
[    6.583554] SMP: Total of 64 processors activated.
[    6.588394] CPU features: detected feature: GIC system register CPU interface
[    6.595606] CPU features: detected feature: 32-bit EL0 Support
[    6.601707] CPU: All CPU(s) started at EL2
[    6.606434] devtmpfs: initialized
[    6.611501] SMBIOS 3.0.0 present.
[    6.614851] DMI: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 UEFI 16.08 RC1 12/07/2016
[    6.623187] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    6.633499] pinctrl core: initialized pinctrl subsystem
[    6.639258] NET: Registered protocol family 16
[    6.657686] cpuidle: using governor menu
[    6.661806] vdso: 2 pages (1 code @ ffff000008917000, 1 data @ ffff000008df5000)
[    6.669374] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    6.677283] DMA: preallocated 256 KiB pool for atomic allocations
[    6.683624] Serial: AMBA PL011 UART driver
[    6.688251] irq: no irq domain found for /interrupt-controller@60080000/uart_intc !
[    6.696125] irq: no irq domain found for /interrupt-controller@a0080000/intc_usb !
[    6.703885] irq: no irq domain found for /interrupt-controller@a0080000/intc_usb !
[    6.731883] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    6.739172] ACPI: Interpreter disabled.
[    6.743301] vgaarb: loaded
[    6.746124] SCSI subsystem initialized
[    6.750186] usbcore: registered new interface driver usbfs
[    6.755789] usbcore: registered new interface driver hub
[    6.761375] usbcore: registered new device driver usb
[    6.766605] pps_core: LinuxPPS API ver. 1 registered
[    6.771658] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    6.780964] PTP clock support registered
[    6.785025] Registered efivars operations
[    6.789259] Advanced Linux Sound Architecture Driver Initialized.
[    6.795920] clocksource: Switched to clocksource arch_sys_counter
[    6.802293] VFS: Disk quotas dquot_6.6.0
[    6.806278] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    6.813341] pnp: PnP ACPI: disabled
[    6.820275] NET: Registered protocol family 2
[    6.825692] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    6.834844] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    6.842007] TCP: Hash tables configured (established 524288 bind 65536)
[    6.848902] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    6.855723] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    6.863120] NET: Registered protocol family 1
[    6.867842] RPC: Registered named UNIX socket transport module.
[    6.873844] RPC: Registered udp transport module.
[    6.878595] RPC: Registered tcp transport module.
[    6.883347] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    6.889943] Unpacking initramfs...
[    7.225326] Freeing initrd memory: 28108K
[    7.231107] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
[    7.239646] kvm [1]: 8-bit VMID
[    7.242845] kvm [1]: IDMAP page: 900000
[    7.246750] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    7.253403] kvm [1]: Hyp mode initialized successfully
[    7.258736] kvm [1]: vgic-v2@fe020000
[    7.262546] kvm [1]: GIC system register CPU interface enabled
[    7.269045] kvm [1]: vgic interrupt IRQ1
[    7.273041] genirq: Flags mismatch irq 4. 00004408 (kvm guest timer) vs. 00004408 (arch_timer)
[    7.281818] kvm [1]: kvm_arch_timer: can't request interrupt 4 (-16)
[    7.291181] futex hash table entries: 16384 (order: 9, 2097152 bytes)
[    7.298167] audit: initializing netlink subsys (disabled)
[    7.303726] audit: type=2000 audit(5.536:1): initialized
[    7.304143] workingset: timestamp_bits=44 max_order=24 bucket_order=0
[    7.307367] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.307709] NFS: Registering the id_resolver key type
[    7.307718] Key type id_resolver registered
[    7.307719] Key type id_legacy registered
[    7.307722] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.307776] 9p: Installing v9fs 9p2000 file system support
[    7.309029] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    7.309030] io scheduler noop registered
[    7.309116] io scheduler cfq registered (default)
[    7.316935] OF: PCI: host bridge /soc/pcie@a00a0000 ranges:
[    7.316942] OF: PCI:   MEM 0xa8800000..0xaffeffff -> 0xa8800000
[    7.316945] OF: PCI:    IO 0xafff0000..0xafffffff -> 0x00000000
[    7.316975] hisi-pcie a8000000.pcie: ECAM at [mem 0xa8000000-0xa87fffff] for [bus 80-87]
[    7.317019] hisi-pcie a8000000.pcie: PCI host bridge to bus 0000:80
[    7.317021] pci_bus 0000:80: root bus resource [bus 80-87]
[    7.317023] pci_bus 0000:80: root bus resource [mem 0xa8800000-0xaffeffff]
[    7.317024] pci_bus 0000:80: root bus resource [io  0x0000-0xffff]
[    7.317048] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.317053] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.317059] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.317063] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.317066] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.317071] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    7.317089] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x52 may corrupt adjacent RW1C bits
[    7.317117] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x44 may corrupt adjacent RW1C bits
[    7.317191] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    7.317195] pci_bus 0000:80: 2-byte config write to 0000:80:00.0 offset 0x3e may corrupt adjacent RW1C bits
[    7.317384] pci 0000:81:00.0: VF(n) BAR0 space: [mem 0xa9608000-0xa9707fff 64bit pref] (contains BAR0 for 64 VFs)
[    7.317400] pci 0000:81:00.0: VF(n) BAR3 space: [mem 0xa9708000-0xa9807fff 64bit pref] (contains BAR3 for 64 VFs)
[    7.317793] pci 0000:81:00.1: VF(n) BAR0 space: [mem 0xa9404000-0xa9503fff 64bit pref] (contains BAR0 for 64 VFs)
[    7.317809] pci 0000:81:00.1: VF(n) BAR3 space: [mem 0xa9504000-0xa9603fff 64bit pref] (contains BAR3 for 64 VFs)
[    7.318148] pci 0000:80:00.0: BAR 14: assigned [mem 0xa8800000-0xa8ffffff]
[    7.318150] pci 0000:80:00.0: BAR 15: assigned [mem 0xa9000000-0xa9dfffff 64bit pref]
[    7.318152] pci 0000:80:00.0: BAR 0: assigned [mem 0xa9e00000-0xa9e0ffff]
[    7.318155] pci 0000:80:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    7.318160] pci 0000:81:00.0: BAR 0: assigned [mem 0xa9000000-0xa93fffff 64bit pref]
[    7.318168] pci 0000:81:00.0: BAR 6: assigned [mem 0xa8800000-0xa8bfffff pref]
[    7.318169] pci 0000:81:00.1: BAR 0: assigned [mem 0xa9400000-0xa97fffff 64bit pref]
[    7.318177] pci 0000:81:00.1: BAR 6: assigned [mem 0xa8c00000-0xa8ffffff pref]
[    7.318179] pci 0000:81:00.0: BAR 4: assigned [mem 0xa9800000-0xa9803fff 64bit pref]
[    7.318186] pci 0000:81:00.0: BAR 7: assigned [mem 0xa9804000-0xa9903fff 64bit pref]
[    7.318190] pci 0000:81:00.0: BAR 10: assigned [mem 0xa9904000-0xa9a03fff 64bit pref]
[    7.318194] pci 0000:81:00.1: BAR 4: assigned [mem 0xa9a04000-0xa9a07fff 64bit pref]
[    7.318201] pci 0000:81:00.1: BAR 7: assigned [mem 0xa9a08000-0xa9b07fff 64bit pref]
[    7.318205] pci 0000:81:00.1: BAR 10: assigned [mem 0xa9b08000-0xa9c07fff 64bit pref]
[    7.318209] pci 0000:81:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    7.318212] pci 0000:81:00.1: BAR 2: assigned [io  0x1020-0x103f]
[    7.318217] pci 0000:80:00.0: PCI bridge to [bus 81]
[    7.318220] pci 0000:80:00.0:   bridge window [io  0x1000-0x1fff]
[    7.318223] pci 0000:80:00.0:   bridge window [mem 0xa8800000-0xa8ffffff]
[    7.318225] pci 0000:80:00.0:   bridge window [mem 0xa9000000-0xa9dfffff 64bit pref]
[    7.318307] pcieport 0000:80:00.0: Signaling PME with IRQ 7
[    7.318343] pcieport 0000:80:00.0: AER enabled with IRQ 7
[    7.318390] Error: Driver 'hisi-pcie' is already registered, aborting...
[    7.318440] ipmi message handler version 39.2
[    7.318444] ipmi device interface
[    7.318471] IPMI System Interface driver.
[    7.318489] ipmi_si: probing via SMBIOS
[    7.318490] ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1 irq 0
[    7.318492] ipmi_si: Adding SMBIOS-specified bt state machine
[    7.318494] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
[    7.318502] ipmi_si ipmi_si.0: Interface detection failed
[    7.384650] xenfs: not registering filesystem on non-xen platform
[    7.386090] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.386503] no indirect ISA port I/O for Hisilicon LPC uart
[    7.386655] SuperH (H)SCI(F) driver initialized
[    7.386758] msm_serial: driver initialized
[    7.402694] loop: module loaded
[    7.402950] hisi_sas: driver version v1.6
[    7.403466] libphy: Fixed MDIO Bus: probed
[    7.403581] tun: Universal TUN/TAP device driver, 1.6
[    7.403582] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    7.403784] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    7.403784] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    7.403804] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    7.403804] igb: Copyright (c) 2007-2014 Intel Corporation.
[    7.403820] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    7.403821] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    7.403836] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.4.0-k
[    7.403836] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    7.403924] ixgbe 0000:81:00.0: enabling device (0000 -> 0002)
[    8.596990] ixgbe 0000:81:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[    8.605720] ixgbe 0000:81:00.0: PCI Express bandwidth of 32GT/s available
[    8.612636] ixgbe 0000:81:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    8.619986] ixgbe 0000:81:00.0: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
[    8.626281] ixgbe 0000:81:00.0: 9c:37:f4:90:cd:23
[    8.635630] ixgbe 0000:81:00.0: Intel(R) 10 Gigabit Network Connection
[    8.642374] ixgbe 0000:81:00.1: enabling device (0000 -> 0002)
[    8.808976] ixgbe 0000:81:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[    8.817702] ixgbe 0000:81:00.1: PCI Express bandwidth of 32GT/s available
[    8.824620] ixgbe 0000:81:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[    8.831971] ixgbe 0000:81:00.1: MAC: 2, PHY: 15, SFP+: 6, PBA No: FFFFFF-0FF
[    8.839150] ixgbe 0000:81:00.1: 9c:37:f4:90:cd:24
[    8.848576] ixgbe 0000:81:00.1: Intel(R) 10 Gigabit Network Connection
[    8.855254] sky2: driver version 1.30
[    8.859112] VFIO - User Level meta-driver version: 0.3
[    8.865037] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    8.871687] ehci-pci: EHCI PCI platform driver
[    8.876223] ehci-platform: EHCI generic platform driver
[    8.881607] ehci-platform a7020000.ehci: EHCI Host Controller
[    8.887467] ehci-platform a7020000.ehci: new USB bus registered, assigned bus number 1
[    8.895736] ehci-platform a7020000.ehci: irq 136, io mem 0xa7020000
[    8.915896] ehci-platform a7020000.ehci: USB 2.0 started, EHCI 1.00
[    8.922490] hub 1-0:1.0: USB hub found
[    8.926322] hub 1-0:1.0: 2 ports detected
[    8.930529] ehci-exynos: EHCI EXYNOS driver
[    8.934810] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    8.940507] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    8.946839] ohci-pci: OHCI PCI platform driver
[    8.951376] ohci-platform: OHCI generic platform driver
[    8.956755] ohci-platform a7030000.ohci: Generic Platform OHCI controller
[    8.963675] ohci-platform a7030000.ohci: new USB bus registered, assigned bus number 2
[    8.971827] ohci-platform a7030000.ohci: irq 137, io mem 0xa7030000
[    9.040076] hub 2-0:1.0: USB hub found
[    9.043904] hub 2-0:1.0: 2 ports detected
[    9.048084] ohci-exynos: OHCI EXYNOS driver
[    9.052453] usbcore: registered new interface driver usb-storage
[    9.058784] mousedev: PS/2 mouse device common for all mice
[    9.190475] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    9.196807] i2c /dev entries driver
[    9.200822] sdhci: Secure Digital Host Controller Interface driver
[    9.207118] sdhci: Copyright(c) Pierre Ossman
[    9.211611] Synopsys Designware Multimedia Card Interface Driver
[    9.217845] sdhci-pltfm: SDHCI platform and OF driver helper
[    9.224328] ledtrig-cpu: registered to indicate activity on CPUs
[    9.230685] usbcore: registered new interface driver usbhid
[    9.236359] usbhid: USB HID core driver
[    9.240737] NET: Registered protocol family 17
[    9.245303] 9pnet: Installing 9P2000 support
[    9.249678] Key type dns_resolver registered
[    9.254185] registered taskstats version 1
[    9.258532] 602b0000.uart: ttyAMA0 at MMIO 0x602b0000 (irq = 138, base_baud = 0) is a SBSA
[    9.266969] console [ttyAMA0] enabled
[    9.266969] console [ttyAMA0] enabled
[    9.274347] bootconsole [pl11] disabled
[    9.274347] bootconsole [pl11] disabled
[    9.307900] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    9.345101] rtc-efi rtc-efi: setting system clock to 2015-02-26 16:40:35 UTC (1424968835)
[    9.353307] ALSA device list:
[    9.356267]   No soundcards found.
[    9.360282] Freeing unused kernel memory: 1024K
root@(none)$ [    9.460502] hub 1-1:1.0: USB hub found
[    9.464343] hub 1-1:1.0: 4 ports detected
[    9.587900] usb 1-2: new high-speed USB device number 3 using ehci-platform
[    9.740378] hub 1-2:1.0: USB hub found
[    9.744218] hub 1-2:1.0: 4 ports detected
[   10.035898] usb 1-2.1: new full-speed USB device number 4 using ehci-platform
[   10.152243] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/soc/a7020000.ehci/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input0
[   10.224107] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-a7020000.ehci-2.1/input0
[   10.236823] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/soc/a7020000.ehci/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input1
[   10.249487] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 Mouse [Keyboard/Mouse KVM 1.1.0] on usb-a7020000.ehci-2.1/input1

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

root@(none)$ ifconfi[   16.586515] random: fast init done
g eth1 192.168.20.188
[   23.537596] ixgbe 0000:81:00.1: registered PHC device on eth1
root@(none)$ [   23.719912] ixgbe 0000:81:00.1 eth1: detected SFP+: 6
[   23.860016] ixgbe 0000:81:00.1 eth1: NIC Link is Up 10 Gbps, Flow Control: RX/TX
--- 192.168.20.4 ping statistics ---
12 packets transmitted, 0 packets received, 100% packet loss
root@(none)$ ping 192.168.20.4 12
PING 192.168.20.12 (192.168.20.12): 56 data bytes
64 bytes from 192.168.20.12: seq=8 ttl=128 time=1.003 ms
64 bytes from 192.168.20.12: seq=9 ttl=128 time=0.557 ms
64 bytes from 192.168.20.12: seq=10 ttl=128 time=0.676 ms
64 bytes from 192.168.20.12: seq=11 ttl=128 time=0.425 ms
64 bytes from 192.168.20.12: seq=12 ttl=128 time=2.170 ms
64 bytes from 192.168.20.12: seq=13 ttl=128 time=0.693 ms
64 bytes from 192.168.20.12: seq=14 ttl=128 time=0.589 ms
64 bytes from 192.168.20.12: seq=15 ttl=128 time=0.684 ms
64 bytes from 192.168.20.12: seq=16 ttl=128 time=0.786 ms
64 bytes from 192.168.20.12: seq=17 ttl=128 time=0.425 ms
64 bytes from 192.168.20.12: seq=18 ttl=128 time=0.787 ms
64 bytes from 192.168.20.12: seq=19 ttl=128 time=0.653 ms
64 bytes from 192.168.20.12: seq=20 ttl=128 time=0.432 ms
64 bytes from 192.168.20.12: seq=21 ttl=128 time=0.692 ms
64 bytes from 192.168.20.12: seq=22 ttl=128 time=0.429 ms
64 bytes from 192.168.20.12: seq=23 ttl=128 time=0.556 ms
64 bytes from 192.168.20.12: seq=24 ttl=128 time=0.715 ms
64 bytes from 192.168.20.12: seq=25 ttl=128 time=0.499 ms

>
> Bjorn
>
> .
>
