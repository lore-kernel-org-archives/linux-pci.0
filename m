Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:15939 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686AbaGDD4W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 23:56:22 -0400
Message-ID: <53B625D9.9080500@huawei.com>
Date: Fri, 4 Jul 2014 11:56:09 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Ilia Mirkin <imirkin@alum.mit.edu>
CC: Brian Becker <brian.johnathan.b@gmail.com>,
	<linux-pci@vger.kernel.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>
Subject: Re: How to check for proper MSI support?
References: <CAKb7UviGCtebGwyHbXRLZhDOiDAez+eKkxPe9jz5kc-3R1kUvQ@mail.gmail.com>	<53B4F0F7.9020403@huawei.com>	<CALhae2jRz8hL0bwySAbP7r+vJGOG5aif4GA_Yjp0inGAwz5JEA@mail.gmail.com>	<53B612FE.4080105@huawei.com>	<CAKb7UviVFQYwYdp_dgxK7jJ5Ny9yG1y8LATydxtVtkzRh+aOKw@mail.gmail.com>	<53B61B03.3070308@huawei.com> <CAKb7UvjFuu4Hm1pfmY-NMFORfv-+fx4oYeJicRoE8UTL_4Wp4A@mail.gmail.com>
In-Reply-To: <CAKb7UvjFuu4Hm1pfmY-NMFORfv-+fx4oYeJicRoE8UTL_4Wp4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/7/4 11:30, Ilia Mirkin wrote:
> On Thu, Jul 3, 2014 at 11:09 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> On 2014/7/4 10:43, Ilia Mirkin wrote:
>>> On Thu, Jul 3, 2014 at 10:35 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>>> Hi Brian,
>>>>    From your 01:00.0 VGA compatible controller PCI config register, it supports 1 MSI vector, so I think this
>>>> card has no problem. But you didn't answer what's the pci_enable_msi() return during it enable MSI fail.
>>>>
>>>> You can check PCI bus whether support MSI like:
>>>>
>>>> cat /sys/bus/pci/devices/00:0e.0/msi_bus
>>>>
>>>> Other, do you call pci_enable_device() before pci_enable_msi() ?
>>>
>>> Yes, the device is enabled. nouveau does generally work for most
>>> people :) And it works fine here if MSI is forced off.
>>>
>>> The problem here is that pci_enable_msi() succeeds, but it probably
>>
>> It's some strange, pci_enable_msi() succeeds, but there is nothing in MSI address and data register
>>
>>         Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
>>                 Address: 0000000000000000  Data: 0000
>> Because the address and data is invalid, so MSI can not work.
>>
>> Because you said pci_enable_msi() return 0 which indicates success, so I guess the device
>> current power state is not D0, because checking code in __write_msi_msi.
>>
>> void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>> {
>>     if (entry->dev->current_state != PCI_D0) {
>>         /* Don't touch the hardware now */
>>     } else if (entry->msi_attrib.is_msix) {
>>         void __iomem *base;
>>         base = entry->mask_base +
>>             entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
>>
>>         writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
>>         writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
>>         writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
>>     ......
>>
>>> shouldn't. I don't know all the details about MSI, but doesn't the CPU
>>> or (L)APIC have to support it? In this case, it's a P200MMX on a 430FX
>>> chipset board. Both quite ancient...
>>
>> MSI in x86 always send to specific interrupt address(0xfeexxxx), most x86 CPU
>> should support MSI, but I am not sure, I don't know hardware much.
> 
> To put things in perspective, P200MMX was released in early 1997. It
> looks like the PCI 2.2 spec, which defines MSI, was released in late
> 1998. The 430FX chipset only supports PCI 2.0.

Maybe you are right, the chipset can not support MSI...

But why after your call pci_enable_msi(), the MSI address and data register is nothing initialized.


> 
>>
>>>
>>> So given that the PCI device itself supports MSI, how do we tell that
>>> it shouldn't actually get turned on?
>>
>> Generally, some message in dmesg like:
>> [   17.322311] ahci 0000:00:1f.2: irq 119 for MSI/MSI-X
>> [   17.322319] ahci 0000:00:1f.2: irq 120 for MSI/MSI-X
>> [   17.322326] ahci 0000:00:1f.2: irq 121 for MSI/MSI-X
>> [   17.322333] ahci 0000:00:1f.2: irq 122 for MSI/MSI-X
>> [   17.322339] ahci 0000:00:1f.2: irq 123 for MSI/MSI-X
>>
>> Also you can check /proc/interrupts I think.
> 
> I must not have made my question clear. Let me try again:
> 
> There is a NVIDIA G96 GPU (which is PCIe only) hanging off of a PCIe
> <-> PCI bridge (all on one card), which is plugged into a motherboard
> with the 430FX chipset (PCI 2.0 supported).
> 
> The GPU PCI device, of course, has full support for MSI. However my
> understanding is that MSI won't actually work here. This is confirmed
> by the fact that if we let nouveau enable MSI, the device doesn't work
> (presumably due to lack of interrupt delivery, although I admit to not
> having debugged it that far). How do I, as a nouveau driver developer,
> know not to call pci_enable_msi? Or alternatively how can
> pci_enable_msi be taught not to succeed in this case?

You can set bus_flags or global pci_msi_enable flag by add quirk function.
You can refer to examples in drivers/pci/quirk.c

Linux support some broken chipsets or devices to disable msi during device initialization by add quirk.

> 
> Thanks,
> 
>   -ilia
> 
> .
> 


-- 
Thanks!
Yijing

