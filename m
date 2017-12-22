Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:46582 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdLVHkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Dec 2017 02:40:39 -0500
Subject: Re: [PATCH] PCI: designware: add a check of msi_desc in irqchip
To: Marc Zyngier <marc.zyngier@arm.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1513218083-5461-1-git-send-email-cao.zou@windriver.com>
 <1513218083-5461-2-git-send-email-cao.zou@windriver.com>
 <20171215161742.GA32131@red-moon>
 <ce3cd3e3-61df-2d09-b47e-95c23765e7da@arm.com>
 <23c45e02-e421-d27f-88ea-152cc17b8d2c@windriver.com>
 <20171219162027.GC21501@red-moon>
 <9f0e2186-08e3-3ef1-87d5-83589f960b4f@windriver.com>
 <591b95bb-edbc-6a57-2da0-17f831cb98f1@windriver.com>
From: Cao Zou <cao.zou@windriver.com>
Message-ID: <a76c0aef-8543-d99d-10bf-5d21f7dee094@windriver.com>
Date: Fri, 22 Dec 2017 15:39:27 +0800
MIME-Version: 1.0
In-Reply-To: <591b95bb-edbc-6a57-2da0-17f831cb98f1@windriver.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 12/22/2017 03:38 PM, Cao Zou wrote:
>
>
> On 12/22/2017 11:04 AM, Cao Zou wrote:
>>
>>
>> On 12/20/2017 12:20 AM, Lorenzo Pieralisi wrote:
>>> On Mon, Dec 18, 2017 at 10:02:20AM +0800, Cao Zou wrote:
>>>>
>>>> On 12/16/2017 01:20 AM, Marc Zyngier wrote:
>>>>> On 15/12/17 16:17, Lorenzo Pieralisi wrote:
>>>>>> [+Marc]
>>>>>>
>>>>>> On Thu, Dec 14, 2017 at 10:21:23AM +0800, cao.zou@windriver.com 
>>>>>> wrote:
>>>>>>> From: Zou Cao <cao.zou@windriver.com>
>>>>>>>
>>>>>>> When PCIE host setup, 32 MSI irq descriptions are created, but its
>>>>>>> msi_desc is NULL, msi_desc is bound in MSI irq requested by PCI 
>>>>>>> device,
>>>>>>> normally just part of MSI are used, for others not used MSI 
>>>>>>> irqs, its
>>>>>>> msi_desc is NULL, it is dangerous for MSI irq mask when MSI irq 
>>>>>>> mask use
>>>>>>> the msi_desc to mask irq without checking, normally not used MSI 
>>>>>>> irqs are
>>>>>>> never masked, it looks fine, but in some specified case, such as 
>>>>>>> kdump,
>>>>>>> machine_kexec_mask_interrupts will force to mask these not used 
>>>>>>> MSI irqs,
>>>>>>> than a crash will happen with NULL msi_desc. it is necessary to 
>>>>>>> add check
>>>>>>> of msi_desc in irqchip, if we still bind the msi_desc only in 
>>>>>>> irqs request
>>>>>>> and mask MSI irq by msi_desc.
>>>>>>>
>>>>>>> Add dwc_pci_msi_mask/unmask_irq, so we can get a chance to check 
>>>>>>> the
>>>>>>> msi_desc.
>>>>>>>
>>>>>>> here is reproduced crash log in IMX7-SABER board with Intel 1030 
>>>>>>> PCI,
>>>>>>> when running kdump by "echo c > /proc/sysrq-trigger":
>>>>>>>
>>>>>>> sysrq: SysRq : Trigger a crash
>>>>>>> Unable to handle kernel NULL pointer dereference at virtual 
>>>>>>> address 00000000
>>>>>>> pgd = 98ee1839
>>>>>>> [00000000] *pgd=00000000
>>>>>>> Internal error: Oops: 805 [#1] SMP ARM
>>>>>>> Modules linked in:
>>>>>>> CPU: 0 PID: 1370 Comm: sh Not tainted 4.15.0-rc3-00033-ga638349 #1
>>>>>>> Hardware name: Freescale i.MX7 Dual (Device Tree)
>>>>>>> PC is at sysrq_handle_crash+0x50/0x98
>>>>>>> LR is at sysrq_handle_crash+0x50/0x98
>>>>>>> <snip>
>>>>>>> Backtrace:
>>>>>>> [<c047a15c>] (msi_set_mask_bit) from [<c047a1f0>] 
>>>>>>> (pci_msi_mask_irq+0x14/0x18)
>>>>>>> [<c047a1dc>] (pci_msi_mask_irq) from [<c011142c>] 
>>>>>>> (machine_crash_shutdown+0xd8/0x190)
>>>>>>> [<c0111354>] (machine_crash_shutdown) from [<c01b2924>] 
>>>>>>> (__crash_kexec+0x5c/0xa0)
>>>>>>> [<c01b28c8>] (__crash_kexec) from [<c01b29dc>] 
>>>>>>> (crash_kexec+0x74/0x80)
>>>>>>> [<c01b2968>] (crash_kexec) from [<c010cfa4>] (die+0x220/0x358)
>>>>>>> [<c010cd84>] (die) from [<c01169f0>] 
>>>>>>> (__do_kernel_fault.part.0+0x5c/0x7c)
>>>>>>> [<c0116994>] (__do_kernel_fault.part.0) from [<c0116784>] 
>>>>>>> (do_page_fault+0x2cc/0x37c)
>>>>>>> [<c01164b8>] (do_page_fault) from [<c0116970>] 
>>>>>>> (do_translation_fault+0xb0/0xbc)
>>>>>>> [<c01168c0>] (do_translation_fault) from [<c010138c>] 
>>>>>>> (do_DataAbort+0x3c/0xbc)
>>>>>>> [<c0101350>] (do_DataAbort) from [<c010d944>] 
>>>>>>> (__dabt_svc+0x64/0xa0)
>>>>>>> Exception stack(0xec08bdf8 to 0xec08be40)
>>>>>>> bde0:                                                       
>>>>>>> 00000000 ec08be10
>>>>>>> be00: 00000000 00000000 00000000 00000001 00000063 00000000 
>>>>>>> 00000007 ec08a000
>>>>>>> be20: 00000000 ec08be5c ec08be48 ec08be48 c04c46b8 c04c46b8 
>>>>>>> 60060013 ffffffff
>>>>>>> [<c04c4668>] (sysrq_handle_crash) from [<c04c4900>] 
>>>>>>> (__handle_sysrq+0xe0/0x254)
>>>>>>> [<c04c4820>] (__handle_sysrq) from [<c04c4aec>] 
>>>>>>> (write_sysrq_trigger+0x78/0x90)
>>>>>>> [<c04c4a74>] (write_sysrq_trigger) from [<c029148c>] 
>>>>>>> (proc_reg_write+0x68/0x90)
>>>>>>> [<c0291424>] (proc_reg_write) from [<c0229ef8>] 
>>>>>>> (__vfs_write+0x34/0x12c)
>>>>>>> [<c0229ec4>] (__vfs_write) from [<c022a16c>] (vfs_write+0xa8/0x16c)
>>>>>>> [<c022a0c4>] (vfs_write) from [<c022a340>] (SyS_write+0x44/0x90)
>>>>>>> [<c022a2fc>] (SyS_write) from [<c0108220>] 
>>>>>>> (ret_fast_syscall+0x0/0x28)
>>>>>>>
>>>>>>> Signed-off-by: Zou Cao <cao.zou@windriver.com>
>>>>>>> ---
>>>>>>>   drivers/pci/dwc/pcie-designware-host.c | 24 
>>>>>>> ++++++++++++++++++++----
>>>>>>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/dwc/pcie-designware-host.c 
>>>>>>> b/drivers/pci/dwc/pcie-designware-host.c
>>>>>>> index 81e2157..485c4df 100644
>>>>>>> --- a/drivers/pci/dwc/pcie-designware-host.c
>>>>>>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>>>>>>> @@ -45,12 +45,28 @@ static int dw_pcie_wr_own_conf(struct 
>>>>>>> pcie_port *pp, int where, int size,
>>>>>>>       return dw_pcie_write(pci->dbi_base + where, size, val);
>>>>>>>   }
>>>>>>> +static void dwc_pci_msi_mask_irq(struct irq_data *data)
>>>>>>> +{
>>>>>>> +    struct msi_desc *desc = irq_data_get_msi_desc(data);
>>>>>>> +
>>>>>>> +    if (desc)
>>>>>>> +        pci_msi_mask_irq(data);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void dwc_pci_msi_unmask_irq(struct irq_data *data)
>>>>>>> +{
>>>>>>> +    struct msi_desc *desc = irq_data_get_msi_desc(data);
>>>>>>> +
>>>>>>> +    if (desc)
>>>>>>> +        pci_msi_unmask_irq(data);
>>>>>>> +}
>>>>>>> +
>>>>>>>   static struct irq_chip dw_msi_irq_chip = {
>>>>>>>       .name = "PCI-MSI",
>>>>>>> -    .irq_enable = pci_msi_unmask_irq,
>>>>>>> -    .irq_disable = pci_msi_mask_irq,
>>>>>>> -    .irq_mask = pci_msi_mask_irq,
>>>>>>> -    .irq_unmask = pci_msi_unmask_irq,
>>>>>>> +    .irq_enable = dwc_pci_msi_unmask_irq,
>>>>>>> +    .irq_disable = dwc_pci_msi_mask_irq,
>>>>>>> +    .irq_mask = dwc_pci_msi_mask_irq,
>>>>>>> +    .irq_unmask = dwc_pci_msi_unmask_irq,
>>>>>>>   };
>>>>>> You have to CC me next time please.
>>>>>>
>>>>>> CC'ed Marc since he knows this code ways better than me and will
>>>>>> help us find the right way of fixing it.
>>>>>>
>>>>>> I do not think that's a DWC-only problem - I see no reason why this
>>>>>> would not affect other host bridges still relying on
>>>>>> struct msi_controller (that we have to remove from the kernel).
>>>>>>
>>>>>> I do not think that this code is an actual fix but a plaster to
>>>>>> paper over the issue - I will have a look into this as soon as
>>>>>> possible to come up with an actual fix.
>>>>> Yeah, this looks mad. The problem is that this seems to allocate
>>>>> interrupts upfront, without being bound to an MSI. What could 
>>>>> possibly
>>>>> go wrong? And that's definitely not the only one (pci-tegra.c is one
>>>>> fine example too).
>>>>>
>>>>> Until we take msi_controller and co to the backyard, how about the
>>>>> following:
>>>>>
>>>>> >From b4aa5d20ee7b716795ac875e180f564fe0f52de6 Mon Sep 17 00:00:00 
>>>>> 2001
>>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>>> Date: Fri, 15 Dec 2017 17:10:14 +0000
>>>>> Subject: [PATCH] PCI/MSI: Don't try to mask/unmask an MSI that 
>>>>> doesn't have an
>>>>>   msi_desc
>>>>>
>>>>> There are a lot of MSI drivers out there that preallocate their
>>>>> interrupts but not the corresponding MSIs. That's a prettty
>>>>> naughty behaviour. On a kexec crash, we try to shut down all
>>>>> the interrupts by calling the disable/mask methods.
>>>>>
>>>>> On these drivers, pci_msi_mask_irq() is unconditionnaly called,
>>>>> leading to a crash. You wanted a crash kernel, right?
>>>>>
>>>>> So let's paper over the issue for the time being by detecting
>>>>> the NULL msi_desc in msi_set_mask_bit(). Eventually, these drivers
>>>>> will have to be fixed...
>>>>>
>>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>> ---
>>>>>   drivers/pci/msi.c | 3 +++
>>>>>   1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>>>>> index e06607167858..a5042cc8f3fc 100644
>>>>> --- a/drivers/pci/msi.c
>>>>> +++ b/drivers/pci/msi.c
>>>>> @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data 
>>>>> *data, u32 flag)
>>>>>   {
>>>>>       struct msi_desc *desc = irq_data_get_msi_desc(data);
>>>>> +    if (WARN_ONCE(!desc, "NULL MSI descriptor!"))
>>>>> +        return;
>>>>> +
>>>>>       if (desc->msi_attrib.is_msix) {
>>>>>           msix_mask_irq(desc, flag);
>>>>>           readl(desc->mask_base);        /* Flush write to device */
>>>> For "if (WARN_ONCE(!desc, "NULL MSI descriptor!")",  it is a good way,
>>>> just one problem. how to fix the kexec/kdump?  this WARN_ONCE can tell
>>>> the pci dirver to fix the MIS bound problem, but in kexec/kdump, it
>>>> will force to mask all MSI,  it means that there are a lot of WARNINGS
>>>> when running kexec/kdump.
>>> There will be one warning as Marc said. Mind testing Marc's patch
>>> and reporting the result on the mailing list please if you want
>>> the issue fixed ?
>>>
>>> Thanks,
>>> Lorenzo
>>>
>> Hi Lorenzo:
>>   Of course it can fix this issue, but  warning will be seen in 
>> every  time when running kdump
>>
>>
>> root@nxp-imx7:~# echo c > /proc/sysrandom: crng init done
>>
>> sys/           sysrq-trigger  sysvipc/
>> root@nxp-imx7:~# echo c > /proc/sysrq-trigger
>> sysrq: SysRq : Trigger a crash
>> Unable to handle kernel NULL pointer dereference at virtual address 
>> 00000000
>> pgd = a9470000
>> [00000000] *pgd=a9474835, *pte=00000000, *ppte=00000000
>> Internal error: Oops: 817 [#1] PREEMPT SMP ARM
>> Modules linked in:
>> CPU: 0 PID: 369 Comm: sh Not tainted 4.12.14-yocto-standard+ #98
>> Hardware name: Freescale i.MX7 Dual (Device Tree)
>> task: a86e5400 task.stack: a9438000
>> PC is at sysrq_handle_crash+0x30/0x3c
>> LR is at sysrq_handle_crash+0x2c/0x3c
>> pc : [<8059576c>]    lr : [<80595768>]    psr: 600e0013
>> sp : a9439eb8  ip : a9439eb8  fp : a9439ecc
>> r10: 00000000  r9 : a9438000  r8 : 00000001
>> r7 : 00000000  r6 : 00000063  r5 : 00000007  r4 : 00000001
>> r3 : 00000000  r2 : a9439ea0  r1 : ab615434  r0 : 00000063
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 10c5387d  Table: a947006a  DAC: 00000051
>> Process sh (pid: 369, stack limit = 0xa9438210)
>> Stack: (0xa9439eb8 to 0xa943a000)
>> 9ea0: 8059573c 8106f41c
>> 9ec0: a9439eec a9439ed0 80595968 80595748 00000002 a8451444 a8451400 
>> 00000000
>> 9ee0: a9439f04 a9439ef0 80595a78 805958c4 a9439f78 a8451444 a9439f2c 
>> a9439f08
>> 9f00: 802c570c 80595a1c 802c5698 00000000 00000002 001042a8 a9439f78 
>> 001042a8
>> 9f20: a9439f44 a9439f30 80268078 802c56a4 a9439f78 a901d6c0 a9439f74 
>> a9439f48
>> 9f40: 80269598 8026805c 80286cac 80286c1c 00000000 00000000 a901d6c0 
>> a901d6c0
>> 9f60: 00000002 001042a8 a9439fa4 a9439f78 8026982c 802694e4 00000000 
>> 00000000
>> 9f80: 00000002 001042a8 76f19da8 00000004 80107f68 00000000 00000000 
>> a9439fa8
>> 9fa0: 80107d60 802697ec 00000002 001042a8 00000001 001042a8 00000002 
>> 00000000
>> 9fc0: 00000002 001042a8 76f19da8 00000004 00000002 00000002 00000000 
>> 00000000
>> 9fe0: 00000444 7e9d4980 76e466f0 76e9e41c 600e0010 00000001 3dbfa0e8 
>> a39746c6
>> [<8059576c>] (sysrq_handle_crash) from [<80595968>] 
>> (__handle_sysrq+0xb0/0x158)
>> [<80595968>] (__handle_sysrq) from [<80595a78>] 
>> (write_sysrq_trigger+0x68/0x78)
>> [<80595a78>] (write_sysrq_trigger) from [<802c570c>] 
>> (proc_reg_write+0x74/0xa4)
>> [<802c570c>] (proc_reg_write) from [<80268078>] (__vfs_write+0x28/0x48)
>> [<80268078>] (__vfs_write) from [<80269598>] (vfs_write+0xc0/0x164)
>> [<80269598>] (vfs_write) from [<8026982c>] (SyS_write+0x4c/0x8c)
>> [<8026982c>] (SyS_write) from [<80107d60>] (ret_fast_syscall+0x0/0x3c)
>> Code: e5834000 f57ff04e ebee0bee e3a03000 (e5c34000)
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 369 at 
>> /export/disk1T/linux-yocto-4.12/drivers/pci/msi.c:230 
>> msi_set_mask_bit+0x50/0xb0
>> NULL MSI descriptor!
>> Modules linked in:
>> CPU: 0 PID: 369 Comm: sh Not tainted 4.12.14-yocto-standard+ #98
>> Hardware name: Freescale i.MX7 Dual (Device Tree)
>> [<80111a50>] (unwind_backtrace) from [<8010c110>] (show_stack+0x20/0x24)
>> [<8010c110>] (show_stack) from [<804cb3dc>] (dump_stack+0x80/0xa0)
>> [<804cb3dc>] (dump_stack) from [<8012a2f4>] (__warn+0xe4/0x114)
>> [<8012a2f4>] (__warn) from [<8012a3f4>] (warn_slowpath_fmt+0x48/0x50)
>> [<8012a3f4>] (warn_slowpath_fmt) from [<8052f380>] 
>> (msi_set_mask_bit+0x50/0xb0)
>> [<8052f380>] (msi_set_mask_bit) from [<8052f41c>] 
>> (pci_msi_mask_irq+0x1c/0x20)
>> [<8052f41c>] (pci_msi_mask_irq) from [<80110224>] 
>> (machine_crash_shutdown+0x108/0x174)
>> [<80110224>] (machine_crash_shutdown) from [<801a7244>] 
>> (__crash_kexec+0x88/0xac)
>> [<801a7244>] (__crash_kexec) from [<801a72d0>] (crash_kexec+0x68/0x78)
>> [<801a72d0>] (crash_kexec) from [<8010c46c>] (die+0x358/0x47c)
>> [<8010c46c>] (die) from [<8011ccbc>] 
>> (__do_kernel_fault.part.0+0x64/0x1f4)
>> [<8011ccbc>] (__do_kernel_fault.part.0) from [<80ade250>] 
>> (do_page_fault+0x348/0x3d4)
>> [<80ade250>] (do_page_fault) from [<801011f8>] (do_DataAbort+0x44/0xc4)
>> [<801011f8>] (do_DataAbort) from [<80add5b8>] (__dabt_svc+0x58/0x80)
>> Exception stack(0xa9439e68 to 0xa9439eb0)
>> 9e60:                   00000063 ab615434 a9439ea0 00000000 00000001 
>> 00000007
>> 9e80: 00000063 00000000 00000001 a9438000 00000000 a9439ecc a9439eb8 
>> a9439eb8
>> 9ea0: 80595768 8059576c 600e0013 ffffffff
>> [<80add5b8>] (__dabt_svc) from [<8059576c>] 
>> (sysrq_handle_crash+0x30/0x3c)
>> [<8059576c>] (sysrq_handle_crash) from [<80595968>] 
>> (__handle_sysrq+0xb0/0x158)
>> [<80595968>] (__handle_sysrq) from [<80595a78>] 
>> (write_sysrq_trigger+0x68/0x78)
>> [<80595a78>] (write_sysrq_trigger) from [<802c570c>] 
>> (proc_reg_write+0x74/0xa4)
>> [<802c570c>] (proc_reg_write) from [<80268078>] (__vfs_write+0x28/0x48)
>> [<80268078>] (__vfs_write) from [<80269598>] (vfs_write+0xc0/0x164)
>> [<80269598>] (vfs_write) from [<8026982c>] (SyS_write+0x4c/0x8c)
>> [<8026982c>] (SyS_write) from [<80107d60>] (ret_fast_syscall+0x0/0x3c)
>> ---[ end trace 7a853bb920d02801 ]---
>> Loading crashdump kernel...
>> Bye!
>> Booting Linux on physical CPU 0x0
>> Linux version 4.12.14-yocto-standard+ (czou@pek-czou-u14) (gcc 
>> version 4.7.3 20130226 (prerelease) (crosstool-NG 
>> linaro-1.13.1-4.7-2013.03-20130313 - Linaro GCC 2013.03) ) #98 SMP 
>> PREEMPT Fri Dec 22 10:59:43 CST7
>> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
>> CPU: div instructions available: patching division code
>> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>> OF: fdt: Machine model: Freescale i.MX7 SabreSD Board
>> OF: fdt: Ignoring memory range 0x80000000 - 0x88000000
>> Memory policy: Data cache writealloc
>> OF: reserved mem: failed to allocate memory for node 'linux,cma'
>> cma: Failed to reserve 320 MiB
>> percpu: Embedded 17 pages/cpu @8fc75000 s38016 r8192 d23424 u69632
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 
>> 64706
>> Kernel command line: console=ttymxc0,115200 root=/dev/nfs ip=dhcp 
>> nfsroot=128.224.162.234:/var/lib/tftp/nfs/rootfs_imx7wrl10,v3 
>> maxcpus=1 elfcorehdr=0x9cf00000 mem=261120K
>> PID hash table entries: 1024 (order: 0, 4096 bytes)
>> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
>> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
>> Memory: 241716K/261120K available (10240K kernel code, 778K rwdata, 
>> 2388K rodata, 1024K init, 364K bss, 19404K reserved, 0K cma-reserved, 
>> 0K highmem)
>> Virtual kernel memory layout:
>>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>>     vmalloc : 0x90000000 - 0xff800000   (1784 MB)
>>     lowmem  : 0x80000000 - 0x8ff00000   ( 255 MB)
>>     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
>>
>> Regards,
>> czou
>>
Add Marc.
> Hi Marc:
>   I have a better way to fix it, just use dynamic allocate the 
> irq_desc in MSI irq setup,
> remove the irq_desc allocate in dw_pcie_host_init, how do you think
>
> patch as follow:
> diff --git a/drivers/pci/dwc/pcie-designware-host.c 
> b/drivers/pci/dwc/pcie-designware-host.c
> index 5006d55..0426120 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -168,8 +168,12 @@ static int assign_irq(int no_irqs, struct 
> msi_desc *desc, int *pos)
>                 goto no_valid_irq;
>
>         irq = irq_find_mapping(pp->irq_domain, pos0);
> -       if (!irq)
> -               goto no_valid_irq;
> +
> +       if (!irq) {
> +               irq = irq_create_mapping(pp->irq_domain, pos0);
> +               if (!irq)
> +                       goto no_valid_irq;
> +       }
>
>         /*
>          * irq_create_mapping (called from dw_pcie_host_init) 
> pre-allocates
> @@ -408,9 +412,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                                 ret = -ENXIO;
>                                 goto error;
>                         }
> -
> -                       for (i = 0; i < MAX_MSI_IRQS; i++)
> - irq_create_mapping(pp->irq_domain, i);
>                 } else {
>                         ret = pp->ops->msi_host_init(pp, 
> &dw_pcie_msi_chip);
>                         if (ret < 0)
>
> Regards,
> czou
>
