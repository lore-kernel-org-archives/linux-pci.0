Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:63448 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbbLQKxz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2015 05:53:55 -0500
Message-ID: <567293F3.6020004@hisilicon.com>
Date: Thu, 17 Dec 2015 18:52:35 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
	Dongdong Liu <liudongdong3@huawei.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<gabriele.paoloni@huawei.com>, <qiujiang@huawei.com>,
	<zhangjukuo@huawei.com>, <haifeng.wei@huawei.com>,
	<yisen.zhuang@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>
Subject: Re: [PATCH] PCI: hisi: fix the hisi_pcie_cfg_read bug when size=4
References: <1448600280-83695-1-git-send-email-liudongdong3@huawei.com> <20151204224334.GL20125@localhost> <20151209161643.GE31930@localhost> <566890D5.2020007@hisilicon.com>
In-Reply-To: <566890D5.2020007@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/12/10 4:36, Zhou Wang wrote:
> On 2015/12/10 0:16, Bjorn Helgaas wrote:
>> On Fri, Dec 04, 2015 at 04:43:34PM -0600, Bjorn Helgaas wrote:
>>> On Fri, Nov 27, 2015 at 12:58:00PM +0800, Dongdong Liu wrote:
>>>> Current hisi_pcie_cfg_read code read the RC configuration space,
>>>> this has a problem that the output parameter "*val" have not been
>>>> assigned when size=4, so we fix the bug by "*val = reg_val" when size=4.
>>>>
>>>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>>>
>>> Wow, that's a pretty egregious bug.  Was the hisi driver ever tested
>>> at all?  We use dword reads in pci_bus_read_dev_vendor_id() to
>>> enumerate devices, so if those didn't return valid data, nothing at
>>> all should have worked.
>>>
>>> I tentatively put this on my for-linus branch for v4.4, but I wonder
>>> whether it might be smarter to revert the driver completely until I
>>> have more confidence in it.
>>>
>>> What sort of testing have you done on this driver?
>>
>> Since I haven't heard anything about whether this driver was ever
>> tested, I dropped this patch from my for-linus branch and I reverted
>> the entire hisi driver.
>>
>> Let me know when you have some testing results, and I'll take another
>> look at it.
>>
>> Bjorn
>>
> 
> Hi Bjorn,
> 
> Very sorry for late, I am on business trip at the moment so I have restricted
> access to emails and my replies can be late.
> 
> The driver has been tested extensively based on internal version, but I did this
> mistake when upstreaming :(. I will send a test log ASAP.
>

Hi Bjorn,

I made a test based on Intel 82599 networking card, this is the bootup log which
contains PCIe host and Intel 82599 networking card parts.


[ESL_Start_OS]:[74L] Start to boot Linux
GMAC ExitBootServicesEvent
SMMU ExitBootServicesEvent
CPUECTLR_EL1 = 0x1B00000040
[ESL_Start_OS]:[144L] Start to jump Linux kernel
Booting Linux on physical CPU 0x20000
Initializing cgroup subsys cpu
Linux version 4.4.0-rc2+ (wangzhou@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05) ) #76 SMP PREEMPT Thu Dec 17 18:08:03 CST 2015
Boot CPU: AArch64 Processor [411fd071]
earlycon: Early serial console at MMIO32 0x80300000 (options '')
bootconsole [uart0] enabled
efi: Getting EFI parameters from FDT:
efi: UEFI not found.
cma: Reserved 16 MiB at 0x000000007ec00000
psci: probing for conduit method from DT.
NOTICE:  [psci_smc_handler]:[349L] PSCI_VERSION CALL
NOTICE:  [psci_version]:[101L] PSCI_MAJOR_VER: 10000: PSCI_MINOR_VER: 0

0008;<54
psci: PSCIv1.0 detected in firmware.
psci: Using standard PSCI v0.2 function IDs

0008;<54
psci: MIGRATE_INFO_TYPE not supported.

0008;<54

0008;<54
PERCPU: Embedded 15 pages/cpu @ffffffd1ffecd000 s24576 r8192 d28672 u61440
Detected PIPT I-cache on CPU0
CPU features: enabling workaround for ARM erratum 832075
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2047248
Kernel command line: earlycon=uart8250,mmio32,0x80300000 console=ttyS0,115200 initrd=0x7000000,350M
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 61440 bytes
log_buf_len min size: 16384 bytes
log_buf_len: 131072 bytes
early log buf free: 14324(87%)
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
software IO TLB [mem 0x7abff000-0x7ebff000] (64MB) mapped at [ffffffc07abff000-ffffffc07ebfefff]
Memory: 7723780K/8318976K available (5874K kernel code, 519K rwdata, 2432K rodata, 548K init, 210K bss, 578812K reserved, 16384K cma-reserved)
Virtual kernel memory layout:
    vmalloc : 0xffffff8000000000 - 0xffffffbdbfff0000   (   246 GB)
    vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
              0xffffffbdc0000000 - 0xffffffbe08000000   (  1152 MB actual)
    fixed   : 0xffffffbffa7fd000 - 0xffffffbffac00000   (  4108 KB)
    PCI I/O : 0xffffffbffae00000 - 0xffffffbffbe00000   (    16 MB)
    modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)
    memory  : 0xffffffc000000000 - 0xffffffd200000000   ( 73728 MB)
      .init : 0xffffffc00089f000 - 0xffffffc000928000   (   548 KB)
      .text : 0xffffffc000080000 - 0xffffffc00089ea54   (  8315 KB)
      .data : 0xffffffc000939000 - 0xffffffc0009bac00   (   519 KB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
Preemptible hierarchical RCU implementation.
	Build-time adjustment of leaf fanout to 64.
	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=16
NR_IRQS:64 nr_irqs:64 0
GIC: Using split EOI/Deactivate mode
ITS@0x8c000000
ITS: allocated 65536 Devices @11f6c80000 (psz 4K, shr 1)
ITS: allocated 512 Virtual CPUs @11f6c0e000 (psz 4K, shr 1)
ITS: allocated 512 Interrupt Collections @11f6c0f000 (psz 4K, shr 1)
ITS@0xc6000000
ITS: allocated 65536 Devices @11f6d00000 (psz 4K, shr 1)
ITS: allocated 512 Virtual CPUs @11f6c30000 (psz 4K, shr 1)
ITS: allocated 512 Interrupt Collections @11f6c31000 (psz 4K, shr 1)
ITS@0xa3000000
ITS: allocated 65536 Devices @11f6d80000 (psz 4K, shr 1)
ITS: allocated 512 Virtual CPUs @11f6c32000 (psz 4K, shr 1)
ITS: allocated 512 Interrupt Collections @11f6c33000 (psz 4K, shr 1)
ITS@0xb7000000
ITS: allocated 65536 Devices @11f6e00000 (psz 4K, shr 1)
ITS: allocated 512 Virtual CPUs @11f6c34000 (psz 4K, shr 1)
ITS: allocated 512 Interrupt Collections @11f6c35000 (psz 4K, shr 1)
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
Security Framework initialized
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
Initializing cgroup subsys memory
Initializing cgroup subsys hugetlb
EFI services will not be available.
ASID allocator initialised with 65536 entries
PCI/MSI: /interrupt-controller@8d000000/interrupt-controller@8c000000 domain created
PCI/MSI: /interrupt-controller@8d000000/interrupt-controller@c6000000 domain created
PCI/MSI: /interrupt-controller@8d000000/interrupt-controller@a3000000 domain created
PCI/MSI: /interrupt-controller@8d000000/interrupt-controller@b7000000 domain created
Platform MSI: /interrupt-controller@8d000000/interrupt-controller@8c000000 domain created
Platform MSI: /interrupt-controller@8d000000/interrupt-controller@c6000000 domain created
Platform MSI: /interrupt-controller@8d000000/interrupt-controller@a3000000 domain created
Platform MSI: /interrupt-controller@8d000000/interrupt-controller@b7000000 domain created
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
DMI not present or invalid.
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
cpuidle: using governor ladder
cpuidle: using governor menu
vdso: 2 pages (1 code @ ffffffc000941000, 1 data @ ffffffc000940000)
hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
DMA: preallocated 256 KiB pool for atomic allocations
Serial: AMBA PL011 UART driver
hisi-smmu 80040000.smmu_pc: registered 0 master devices
hisi-smmu 80040000.smmu_pc: probing hardware configuration...
hisi-smmu 80040000.smmu_pc:     nested translation
hisi-smmu 80040000.smmu_pc:     coherent table walk
hisi-smmu 80040000.smmu_pc:     39-bit VA, 39-bit IPA, 48-bit PA
hisi-smmu c0040000.smmu_dsa: registered 0 master devices
hisi-smmu c0040000.smmu_dsa: probing hardware configuration...
hisi-smmu c0040000.smmu_dsa:    nested translation
hisi-smmu c0040000.smmu_dsa:    coherent table walk
hisi-smmu c0040000.smmu_dsa:    39-bit VA, 39-bit IPA, 48-bit PA
hisi-smmu a0040000.smmu_m3: registered 0 master devices
hisi-smmu a0040000.smmu_m3: probing hardware configuration...
hisi-smmu a0040000.smmu_m3:     nested translation
hisi-smmu a0040000.smmu_m3:     coherent table walk
hisi-smmu a0040000.smmu_m3:     39-bit VA, 39-bit IPA, 48-bit PA
hisi-smmu b0040000.smmu_pcie: registered 0 master devices
hisi-smmu b0040000.smmu_pcie: probing hardware configuration...
hisi-smmu b0040000.smmu_pcie:   nested translation
hisi-smmu b0040000.smmu_pcie:   coherent table walk
hisi-smmu b0040000.smmu_pcie:   39-bit VA, 39-bit IPA, 48-bit PA
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
dmi: Firmware registration failed.
clocksource: Switched to clocksource arch_sys_counter
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
Initramfs unpacking failed: junk in compressed archive
Freeing initrd memory: 358400K (ffffffc007000000 - ffffffc01ce00000)
hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
kvm [1]: interrupt-controller@fe020000 IRQ5
kvm [1]: timer IRQ3
kvm [1]: Hyp mode initialized successfully
futex hash table entries: 4096 (order: 7, 524288 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(2.280:1): initialized
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
PCI host bridge /soc/pcie@0xb0080000 ranges:
  MEM 0x22001000000..0x2200fffffff -> 0xb0000000
   IO 0x22000010000..0x2200001ffff -> 0x00000000
hisi-pcie b0080000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-7f]
pci_bus 0000:00: root bus resource [mem 0x22001000000-0x2200fffffff] (bus address [0xb0000000-0xbeffffff])
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22
pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22
pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22
pci 0000:00:00.0: BAR 8: assigned [mem 0x22001000000-0x220017fffff]
pci 0000:00:00.0: BAR 9: assigned [mem 0x22001800000-0x220021fffff 64bit pref]
pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0x22001800000-0x22001bfffff 64bit pref]
pci 0000:01:00.0: BAR 6: assigned [mem 0x22001000000-0x220013fffff pref]
pci 0000:01:00.1: BAR 0: assigned [mem 0x22001c00000-0x22001ffffff 64bit pref]
pci 0000:01:00.1: BAR 6: assigned [mem 0x22001400000-0x220017fffff pref]
pci 0000:01:00.0: BAR 4: assigned [mem 0x22002000000-0x22002003fff 64bit pref]
pci 0000:01:00.1: BAR 4: assigned [mem 0x22002004000-0x22002007fff 64bit pref]
pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
pci 0000:01:00.1: BAR 2: assigned [io  0x1020-0x103f]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x22001000000-0x220017fffff]
pci 0000:00:00.0:   bridge window [mem 0x22001800000-0x220021fffff 64bit pref]
pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
pci 0000:01:00.1: Signaling PME through PCIe PME interrupt
hisi-pcie b0080000.pcie: only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
console [ttyS0] disabled
80300000.uart: ttyS0 at MMIO 0x80300000 (irq = 11, base_baud = 12500000) is a 16550A
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [uart0] disabled
bootconsole [uart0] disabled
msm_serial: driver initialized
Unable to detect cache hierarchy from DT for CPU 0
loop: module loaded
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
igb: Copyright (c) 2007-2014 Intel Corporation.
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.2.1-k
ixgbe: Copyright (c) 1999-2015 Intel Corporation.
ixgbe 0000:01:00.0: enabling device (0000 -> 0002)
ixgbe 0000:01:00.0: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
ixgbe 0000:01:00.0: PCI Express bandwidth of 32GT/s available
ixgbe 0000:01:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 0000:01:00.0: MAC: 2, PHY: 17, SFP+: 13, PBA No: FFFFFF-0FF
ixgbe 0000:01:00.0: 9c:37:f4:90:cd:23
ixgbe 0000:01:00.0: Intel(R) 10 Gigabit Network Connection
ixgbe 0000:01:00.1: enabling device (0000 -> 0002)
ixgbe 0000:01:00.1: Multiqueue Enabled: Rx Queue count = 16, Tx Queue count = 16
ixgbe 0000:01:00.1: PCI Express bandwidth of 32GT/s available
ixgbe 0000:01:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 0000:01:00.1: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
ixgbe 0000:01:00.1: 9c:37:f4:90:cd:24
ixgbe 0000:01:00.1: Intel(R) 10 Gigabit Network Connection
sky2: driver version 1.30
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-platform: OHCI generic platform driver
usbcore: registered new interface driver usb-storage
mousedev: PS/2 mouse device common for all mice
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
hctosys: unable to open rtc device (rtc0)
ttyS0 - failed to request DMA
Freeing unused kernel memory: 548K (ffffffc00089f000 - ffffffc000928000)
Freeing alternatives memory: 48K (ffffffc000928000 - ffffffc000934000)
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
          LOOPBACK  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@(none)$ ifconfig eth0 192.168.10.103
ixgbe 0000:01:00.0: registered PHC device on eth0
root@(none)$ ixgbe 0000:01:00.0 eth0: detected SFP+: 13
ixgbe 0000:01:00.0 eth0: NIC Link is Up 1 Gbps, Flow Control: None

root@(none)$ ping -I eth0 192.168.10.25
PING 192.168.10.25 (192.168.10.25): 56 data bytes
64 bytes from 192.168.10.25: seq=0 ttl=128 time=0.569 ms
64 bytes from 192.168.10.25: seq=1 ttl=128 time=0.330 ms
64 bytes from 192.168.10.25: seq=2 ttl=128 time=0.385 ms
64 bytes from 192.168.10.25: seq=3 ttl=128 time=0.425 ms
64 bytes from 192.168.10.25: seq=4 ttl=128 time=0.386 ms
64 bytes from 192.168.10.25: seq=5 ttl=128 time=0.383 ms
64 bytes from 192.168.10.25: seq=6 ttl=128 time=0.393 ms
64 bytes from 192.168.10.25: seq=7 ttl=128 time=0.383 ms
64 bytes from 192.168.10.25: seq=8 ttl=128 time=0.354 ms
64 bytes from 192.168.10.25: seq=9 ttl=128 time=0.820 ms
64 bytes from 192.168.10.25: seq=10 ttl=128 time=0.371 ms
64 bytes from 192.168.10.25: seq=11 ttl=128 time=0.380 ms
^C
--- 192.168.10.25 ping statistics ---
12 packets transmitted, 12 packets received, 0% packet loss
round-trip min/avg/max = 0.330/0.431/0.820 ms
root@(none)$


>From above log, we can see Intel 82599 networking card work well based
on HiSilicon PCIe host.

Another thing is that our PCIe driver still can't support INTx interrupt
from log "pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22". We
will try to fix this up later.

Very sorry for late.

Many thanks,
Zhou

> Many Thanks,
> Zhou
> 
>>>> ---
>>>>  drivers/pci/host/pcie-hisi.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
>>>> index 35457ec..da677b1 100644
>>>> --- a/drivers/pci/host/pcie-hisi.c
>>>> +++ b/drivers/pci/host/pcie-hisi.c
>>>> @@ -61,7 +61,9 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
>>>>  		*val = *(u8 __force *) walker;
>>>>  	else if (size == 2)
>>>>  		*val = *(u16 __force *) walker;
>>>> -	else if (size != 4)
>>>> +	else if (size == 4)
>>>> +		*val = reg_val;
>>>> +	else
>>>>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>>  
>>>>  	return PCIBIOS_SUCCESSFUL;
>>>> -- 
>>>> 1.9.1
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> .
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


