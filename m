Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42782 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754664AbdLVJcT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Dec 2017 04:32:19 -0500
Subject: Re: [PATCH] PCI: designware: add a check of msi_desc in irqchip
To: Cao Zou <cao.zou@windriver.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: jingoohan1@gmail.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1513218083-5461-1-git-send-email-cao.zou@windriver.com>
 <1513218083-5461-2-git-send-email-cao.zou@windriver.com>
 <20171215161742.GA32131@red-moon>
 <ce3cd3e3-61df-2d09-b47e-95c23765e7da@arm.com>
 <23c45e02-e421-d27f-88ea-152cc17b8d2c@windriver.com>
 <20171219162027.GC21501@red-moon>
 <9f0e2186-08e3-3ef1-87d5-83589f960b4f@windriver.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <2a864f2a-2d1e-1bb0-a501-bef6f1a9c74b@arm.com>
Date: Fri, 22 Dec 2017 09:32:14 +0000
MIME-Version: 1.0
In-Reply-To: <9f0e2186-08e3-3ef1-87d5-83589f960b4f@windriver.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 22/12/17 03:04, Cao Zou wrote:
> 
> 
> On 12/20/2017 12:20 AM, Lorenzo Pieralisi wrote:
>> On Mon, Dec 18, 2017 at 10:02:20AM +0800, Cao Zou wrote:
>>>
>>> On 12/16/2017 01:20 AM, Marc Zyngier wrote:
>>>> On 15/12/17 16:17, Lorenzo Pieralisi wrote:
>>>>> [+Marc]
>>>>>
>>>>> On Thu, Dec 14, 2017 at 10:21:23AM +0800, cao.zou@windriver.com wrote:
>>>>>> From: Zou Cao <cao.zou@windriver.com>
>>>>>>
>>>>>> When PCIE host setup, 32 MSI irq descriptions are created, but its
>>>>>> msi_desc is NULL, msi_desc is bound in MSI irq requested by PCI device,
>>>>>> normally just part of MSI are used, for others not used MSI irqs, its
>>>>>> msi_desc is NULL, it is dangerous for MSI irq mask when MSI irq mask use
>>>>>> the msi_desc to mask irq without checking, normally not used MSI irqs are
>>>>>> never masked, it looks fine, but in some specified case, such as kdump,
>>>>>> machine_kexec_mask_interrupts will force to mask these not used MSI irqs,
>>>>>> than a crash will happen with NULL msi_desc. it is necessary to add check
>>>>>> of msi_desc in irqchip, if we still bind the msi_desc only in irqs request
>>>>>> and mask MSI irq by msi_desc.
>>>>>>
>>>>>> Add dwc_pci_msi_mask/unmask_irq, so we can get a chance to check the
>>>>>> msi_desc.
>>>>>>
>>>>>> here is reproduced crash log in IMX7-SABER board with Intel 1030 PCI,
>>>>>> when running kdump by "echo c > /proc/sysrq-trigger":
>>>>>>
>>>>>> sysrq: SysRq : Trigger a crash
>>>>>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>>>>> pgd = 98ee1839
>>>>>> [00000000] *pgd=00000000
>>>>>> Internal error: Oops: 805 [#1] SMP ARM
>>>>>> Modules linked in:
>>>>>> CPU: 0 PID: 1370 Comm: sh Not tainted 4.15.0-rc3-00033-ga638349 #1
>>>>>> Hardware name: Freescale i.MX7 Dual (Device Tree)
>>>>>> PC is at sysrq_handle_crash+0x50/0x98
>>>>>> LR is at sysrq_handle_crash+0x50/0x98
>>>>>> <snip>
>>>>>> Backtrace:
>>>>>> [<c047a15c>] (msi_set_mask_bit) from [<c047a1f0>] (pci_msi_mask_irq+0x14/0x18)
>>>>>> [<c047a1dc>] (pci_msi_mask_irq) from [<c011142c>] (machine_crash_shutdown+0xd8/0x190)
>>>>>> [<c0111354>] (machine_crash_shutdown) from [<c01b2924>] (__crash_kexec+0x5c/0xa0)
>>>>>> [<c01b28c8>] (__crash_kexec) from [<c01b29dc>] (crash_kexec+0x74/0x80)
>>>>>> [<c01b2968>] (crash_kexec) from [<c010cfa4>] (die+0x220/0x358)
>>>>>> [<c010cd84>] (die) from [<c01169f0>] (__do_kernel_fault.part.0+0x5c/0x7c)
>>>>>> [<c0116994>] (__do_kernel_fault.part.0) from [<c0116784>] (do_page_fault+0x2cc/0x37c)
>>>>>> [<c01164b8>] (do_page_fault) from [<c0116970>] (do_translation_fault+0xb0/0xbc)
>>>>>> [<c01168c0>] (do_translation_fault) from [<c010138c>] (do_DataAbort+0x3c/0xbc)
>>>>>> [<c0101350>] (do_DataAbort) from [<c010d944>] (__dabt_svc+0x64/0xa0)
>>>>>> Exception stack(0xec08bdf8 to 0xec08be40)
>>>>>> bde0:                                                       00000000 ec08be10
>>>>>> be00: 00000000 00000000 00000000 00000001 00000063 00000000 00000007 ec08a000
>>>>>> be20: 00000000 ec08be5c ec08be48 ec08be48 c04c46b8 c04c46b8 60060013 ffffffff
>>>>>> [<c04c4668>] (sysrq_handle_crash) from [<c04c4900>] (__handle_sysrq+0xe0/0x254)
>>>>>> [<c04c4820>] (__handle_sysrq) from [<c04c4aec>] (write_sysrq_trigger+0x78/0x90)
>>>>>> [<c04c4a74>] (write_sysrq_trigger) from [<c029148c>] (proc_reg_write+0x68/0x90)
>>>>>> [<c0291424>] (proc_reg_write) from [<c0229ef8>] (__vfs_write+0x34/0x12c)
>>>>>> [<c0229ec4>] (__vfs_write) from [<c022a16c>] (vfs_write+0xa8/0x16c)
>>>>>> [<c022a0c4>] (vfs_write) from [<c022a340>] (SyS_write+0x44/0x90)
>>>>>> [<c022a2fc>] (SyS_write) from [<c0108220>] (ret_fast_syscall+0x0/0x28)
>>>>>>
>>>>>> Signed-off-by: Zou Cao <cao.zou@windriver.com>
>>>>>> ---
>>>>>>   drivers/pci/dwc/pcie-designware-host.c | 24 ++++++++++++++++++++----
>>>>>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>>>>>> index 81e2157..485c4df 100644
>>>>>> --- a/drivers/pci/dwc/pcie-designware-host.c
>>>>>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>>>>>> @@ -45,12 +45,28 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>>>>>>   	return dw_pcie_write(pci->dbi_base + where, size, val);
>>>>>>   }
>>>>>> +static void dwc_pci_msi_mask_irq(struct irq_data *data)
>>>>>> +{
>>>>>> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
>>>>>> +
>>>>>> +	if (desc)
>>>>>> +		pci_msi_mask_irq(data);
>>>>>> +}
>>>>>> +
>>>>>> +static void dwc_pci_msi_unmask_irq(struct irq_data *data)
>>>>>> +{
>>>>>> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
>>>>>> +
>>>>>> +	if (desc)
>>>>>> +		pci_msi_unmask_irq(data);
>>>>>> +}
>>>>>> +
>>>>>>   static struct irq_chip dw_msi_irq_chip = {
>>>>>>   	.name = "PCI-MSI",
>>>>>> -	.irq_enable = pci_msi_unmask_irq,
>>>>>> -	.irq_disable = pci_msi_mask_irq,
>>>>>> -	.irq_mask = pci_msi_mask_irq,
>>>>>> -	.irq_unmask = pci_msi_unmask_irq,
>>>>>> +	.irq_enable = dwc_pci_msi_unmask_irq,
>>>>>> +	.irq_disable = dwc_pci_msi_mask_irq,
>>>>>> +	.irq_mask = dwc_pci_msi_mask_irq,
>>>>>> +	.irq_unmask = dwc_pci_msi_unmask_irq,
>>>>>>   };
>>>>> You have to CC me next time please.
>>>>>
>>>>> CC'ed Marc since he knows this code ways better than me and will
>>>>> help us find the right way of fixing it.
>>>>>
>>>>> I do not think that's a DWC-only problem - I see no reason why this
>>>>> would not affect other host bridges still relying on
>>>>> struct msi_controller (that we have to remove from the kernel).
>>>>>
>>>>> I do not think that this code is an actual fix but a plaster to
>>>>> paper over the issue - I will have a look into this as soon as
>>>>> possible to come up with an actual fix.
>>>> Yeah, this looks mad. The problem is that this seems to allocate
>>>> interrupts upfront, without being bound to an MSI. What could possibly
>>>> go wrong? And that's definitely not the only one (pci-tegra.c is one
>>>> fine example too).
>>>>
>>>> Until we take msi_controller and co to the backyard, how about the
>>>> following:
>>>>
>>>> >From b4aa5d20ee7b716795ac875e180f564fe0f52de6 Mon Sep 17 00:00:00 2001
>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>> Date: Fri, 15 Dec 2017 17:10:14 +0000
>>>> Subject: [PATCH] PCI/MSI: Don't try to mask/unmask an MSI that doesn't have an
>>>>   msi_desc
>>>>
>>>> There are a lot of MSI drivers out there that preallocate their
>>>> interrupts but not the corresponding MSIs. That's a prettty
>>>> naughty behaviour. On a kexec crash, we try to shut down all
>>>> the interrupts by calling the disable/mask methods.
>>>>
>>>> On these drivers, pci_msi_mask_irq() is unconditionnaly called,
>>>> leading to a crash. You wanted a crash kernel, right?
>>>>
>>>> So let's paper over the issue for the time being by detecting
>>>> the NULL msi_desc in msi_set_mask_bit(). Eventually, these drivers
>>>> will have to be fixed...
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>   drivers/pci/msi.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>>>> index e06607167858..a5042cc8f3fc 100644
>>>> --- a/drivers/pci/msi.c
>>>> +++ b/drivers/pci/msi.c
>>>> @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
>>>>   {
>>>>   	struct msi_desc *desc = irq_data_get_msi_desc(data);
>>>> +	if (WARN_ONCE(!desc, "NULL MSI descriptor!"))
>>>> +		return;
>>>> +
>>>>   	if (desc->msi_attrib.is_msix) {
>>>>   		msix_mask_irq(desc, flag);
>>>>   		readl(desc->mask_base);		/* Flush write to device */
>>> For "if (WARN_ONCE(!desc, "NULL MSI descriptor!")",  it is a good way,
>>> just one problem. how to fix the kexec/kdump?  this WARN_ONCE can tell
>>> the pci dirver to fix the MIS bound problem, but in kexec/kdump, it
>>> will force to mask all MSI,  it means that there are a lot of WARNINGS
>>> when running kexec/kdump.
>> There will be one warning as Marc said. Mind testing Marc's patch
>> and reporting the result on the mailing list please if you want
>> the issue fixed ?
>>
>> Thanks,
>> Lorenzo
>>
> Hi Lorenzo:
>    Of course it can fix this issue, but  warning will be seen in every  
> time when running kdump

[...]

And that's a *good* thing. Too many of the MSI drivers in the tree are
broken. Do you really think we should be silent about it? Out of sight,
out of mind. If you don't want the warning, please help fixing the
drivers by migrating them over to the generic MSI infrastructure.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
