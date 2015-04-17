Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:54557 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932239AbbDQMhh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 08:37:37 -0400
Received: by obbfy7 with SMTP id fy7so67942508obb.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2015 05:37:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5530DD9D.9020808@arm.com>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>
 <cover.1428564115.git.dhdang@apm.com> <7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>
 <55280665.9020603@arm.com> <CADaLNDkrqwnEOX1HgQ7V3-1o4cDJnG4dW1=U4ujod7fUW_PQ0w@mail.gmail.com>
 <7a739a984c1b849ae92cb3bb3edc92f2@www.loen.fr> <CADaLNDmxrpJ-t6fR=DVBzB1q_jp58H94oZnRrxZYtCvDCWJpog@mail.gmail.com>
 <20150415091655.02361cdc@arm.com> <CADaLNDkuXpMVanyPD1oMOK-uvdt+vK2+UabgUxvaK9bBZDmdKg@mail.gmail.com>
 <5530DD9D.9020808@arm.com>
From: Duc Dang <dhdang@apm.com>
Date: Fri, 17 Apr 2015 05:37:05 -0700
Message-ID: <CADaLNDkAu4o6YQkw528+1npWAa_CeX-ZfFED0zWRsz+WAfwf6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Feng Kan <fkan@apm.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Loc Ho <lho@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 17, 2015 at 3:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 17/04/15 11:00, Duc Dang wrote:
>> On Wed, Apr 15, 2015 at 1:16 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On Tue, 14 Apr 2015 19:20:19 +0100
>>> Duc Dang <dhdang@apm.com> wrote:
>>>
>>>> On Sat, Apr 11, 2015 at 5:06 AM, Marc Zyngier <marc.zyngier@arm.com>
>>>> wrote:
>>>>> On 2015-04-11 00:42, Duc Dang wrote:
>>>>>>
>>>>>> On Fri, Apr 10, 2015 at 10:20 AM, Marc Zyngier
>>>>>> <marc.zyngier@arm.com> wrote:
>>>>>>>
>>>>>>> On 09/04/15 18:05, Duc Dang wrote:
>>>>>>>>
>>>>>>>> X-Gene v1 SoC supports total 2688 MSI/MSIX vectors coalesced into
>>>>>>>> 16 HW IRQ lines.
>>>>>>>>
>>>>>>>> Signed-off-by: Duc Dang <dhdang@apm.com>
>>>>>>>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>>>>>>>> ---
>>>>>>>>  drivers/pci/host/Kconfig         |   6 +
>>>>>>>>  drivers/pci/host/Makefile        |   1 +
>>>>>>>>  drivers/pci/host/pci-xgene-msi.c | 407
>>>>>>>> +++++++++++++++++++++++++++++++++++++++
>>>>>>>>  drivers/pci/host/pci-xgene.c     |  21 ++
>>>>>>>>  4 files changed, 435 insertions(+)
>>>>>>>>  create mode 100644 drivers/pci/host/pci-xgene-msi.c
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>>>>>>>> index 7b892a9..c9b61fa 100644
>>>>>>>> --- a/drivers/pci/host/Kconfig
>>>>>>>> +++ b/drivers/pci/host/Kconfig
>>>>>>>> @@ -89,11 +89,17 @@ config PCI_XGENE
>>>>>>>>         depends on ARCH_XGENE
>>>>>>>>         depends on OF
>>>>>>>>         select PCIEPORTBUS
>>>>>>>> +       select PCI_MSI_IRQ_DOMAIN if PCI_MSI
>>>>>>>> +       select PCI_XGENE_MSI if PCI_MSI
>>>>>>>>         help
>>>>>>>>           Say Y here if you want internal PCI support on APM
>>>>>>>> X-Gene SoC. There are 5 internal PCIe ports available. Each port
>>>>>>>> is GEN3 capable
>>>>>>>>           and have varied lanes from x1 to x8.
>>>>>>>>
>>>>>>>> +config PCI_XGENE_MSI
>>>>>>>> +       bool "X-Gene v1 PCIe MSI feature"
>>>>>>>> +       depends on PCI_XGENE && PCI_MSI
>>>>>>>> +
>>>>>>>>  config PCI_LAYERSCAPE
>>>>>>>>         bool "Freescale Layerscape PCIe controller"
>>>>>>>>         depends on OF && ARM
>>>>>>>> diff --git a/drivers/pci/host/Makefile
>>>>>>>> b/drivers/pci/host/Makefile index e61d91c..f39bde3 100644
>>>>>>>> --- a/drivers/pci/host/Makefile
>>>>>>>> +++ b/drivers/pci/host/Makefile
>>>>>>>> @@ -11,5 +11,6 @@ obj-$(CONFIG_PCIE_SPEAR13XX) +=
>>>>>>>> pcie-spear13xx.o obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o
>>>>>>>> pci-keystone.o obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>>>>>>>>  obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
>>>>>>>> +obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>>>>>>>>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>>>>>>>>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>>>>>>>> diff --git a/drivers/pci/host/pci-xgene-msi.c
>>>>>>>> b/drivers/pci/host/pci-xgene-msi.c
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..4f0ff42
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/pci/host/pci-xgene-msi.c
>>>>>>>> @@ -0,0 +1,407 @@
>>>>>>>> +/*
>>>>>>>> + * APM X-Gene MSI Driver
>>>>>>>> + *
>>>>>>>> + * Copyright (c) 2014, Applied Micro Circuits Corporation
>>>>>>>> + * Author: Tanmay Inamdar <tinamdar@apm.com>
>>>>>>>> + *        Duc Dang <dhdang@apm.com>
>>>>>>>> + *
>>>>>>>> + * This program is free software; you can redistribute  it
>>>>>>>> and/or modify it
>>>>>>>> + * under  the terms of  the GNU General  Public License as
>>>>>>>> published by the
>>>>>>>> + * Free Software Foundation;  either version 2 of the  License,
>>>>>>>> or (at your
>>>>>>>> + * option) any later version.
>>>>>>>> + *
>>>>>>>> + * This program is distributed in the hope that it will be
>>>>>>>> useful,
>>>>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty
>>>>>>>> of
>>>>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>>>> + * GNU General Public License for more details.
>>>>>>>> + */
>>>>>>>> +#include <linux/interrupt.h>
>>>>>>>> +#include <linux/module.h>
>>>>>>>> +#include <linux/msi.h>
>>>>>>>> +#include <linux/of_irq.h>
>>>>>>>> +#include <linux/pci.h>
>>>>>>>> +#include <linux/platform_device.h>
>>>>>>>> +#include <linux/of_pci.h>
>>>>>>>> +
>>>>>>>> +#define MSI_INDEX0             0x000000
>>>>>>>> +#define MSI_INT0               0x800000
>>>>>>>> +
>>>>>>>> +struct xgene_msi_settings {
>>>>>>>> +       u32     index_per_group;
>>>>>>>> +       u32     irqs_per_index;
>>>>>>>> +       u32     nr_msi_vec;
>>>>>>>> +       u32     nr_hw_irqs;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +struct xgene_msi {
>>>>>>>> +       struct device_node              *node;
>>>>>>>> +       struct msi_controller           mchip;
>>>>>>>> +       struct irq_domain               *domain;
>>>>>>>> +       struct xgene_msi_settings       *settings;
>>>>>>>> +       u32                             msi_addr_lo;
>>>>>>>> +       u32                             msi_addr_hi;
>>>>>>>
>>>>>>>
>>>>>>> I'd rather see the mailbox address directly, and only do the
>>>>>>> split when assigning it to the message (you seem to play all kind
>>>>>>> of tricks on the address anyway).
>>>>>>
>>>>>>
>>>>>> msi_addr_lo and msi_addr_hi store the physical base address of MSI
>>>>>> controller registers. I will add comment to clarify this.
>>>>>
>>>>>
>>>>> What I mean is that there is no point in keeping this around as a
>>>>> pair of 32bit variables. You'd better keep it as a single 64bit,
>>>>> and do the split when assigning it the the MSI message.
>>>>
>>>> Hi Marc,
>>>>
>>>> These came from device-tree (which describes 64-bit address number as
>>>> 2 32-bit words).
>>>
>>> ... and converted to a resource as a 64bit word, on which you apply
>>> {upper,lower}_32_bit(). So much for DT...
>>>
>>>> If I store them this way, I don't need CPU cycles to do the split
>>>> every time assigning them to the MSI message. Please let me know what
>>>> do you think about it.
>>>
>>> This is getting absolutely silly.
>>>
>>> How many cycles does it take to execute "lsr x1, x0, #32" on X-Gene? If
>>> it takes so long that it is considered to be a bottleneck, I suggest
>>> you go and design a better CPU (hint: the answer is probably 1 cycle
>>> absolutely everywhere).
>>>
>>> How often are you configuring MSIs in the face of what is happening in
>>> the rest of the kernel? Almost never!
>>>
>>> So, given that "never" times 1 is still never,  I'll consider that
>>> readability of the code trumps it anytime (I can't believe we're having
>>> that kind of conversation...).
>>>
>> I changed to use u64 for msi_addr and split it when composing MSI messages.
>> The change is in v4 of the patch set that I just posted.
>>>>>
>>>>> [...]
>>>>>
>>>>>>>> +static int xgene_msi_set_affinity(struct irq_data *irq_data,
>>>>>>>> +                                 const struct cpumask *mask,
>>>>>>>> bool force)
>>>>>>>> +{
>>>>>>>> +       struct xgene_msi *msi =
>>>>>>>> irq_data_get_irq_chip_data(irq_data);
>>>>>>>> +       unsigned int gic_irq;
>>>>>>>> +       int ret;
>>>>>>>> +
>>>>>>>> +       gic_irq = msi->msi_virqs[irq_data->hwirq %
>>>>>>>> msi->settings->nr_hw_irqs];
>>>>>>>> +       ret = irq_set_affinity(gic_irq, mask);
>>>>>>>
>>>>>>>
>>>>>>> Erm... This as the effect of moving *all* the MSIs hanging off
>>>>>>> this interrupt to another CPU. I'm not sure that's an acceptable
>>>>>>> effect... What if another MSI requires a different affinity?
>>>>>>
>>>>>>
>>>>>> We have 16 'real' hardware IRQs. Each of these has multiple MSIs
>>>>>> attached to it.
>>>>>> So this will move all MSIs handing off this interrupt to another
>>>>>> CPU; and we don't support different affinity settings for
>>>>>> different MSIs that are attached to the same hardware IRQ.
>>>>>
>>>>>
>>>>> Well, that's a significant departure from the expected behaviour.
>>>>> In other words, I wonder how useful this is. Could you instead
>>>>> reconfigure the MSI itself to hit the right CPU (assuming you don't
>>>>> have more than 16 CPUs and if
>>>>> that's only for XGene-1, this will only be 8 at most)? This would
>>>>> reduce your number of possible MSIs, but at least the semantics of
>>>>> set_afinity would be preserved.
>>>>
>>>> X-Gene-1 supports 2688 MSIs that are divided into 16 groups, each
>>>> group has 168 MSIs that are mapped to 1 hardware GIC IRQ (so we have
>>>> 16 hardware GIC IRQs for 2688 MSIs).
>>>
>>> We've already established that.
>>>
>>>> Setting affinity of single MSI to deliver it to a target CPU will move
>>>> all the MSIs mapped to the same GIC IRQ to that CPU as well. This is
>>>> not a standard behavior, but limiting the total number of MSIs will
>>>> cause a lot of devices to fall back to INTx (with huge performance
>>>> penalty) or even fail to load their driver as these devices request
>>>> more than 16 MSIs during driver initialization.
>>>
>>> No, I think you got it wrong. If you have 168 MSIs per GIC IRQ, and
>>> provided that you have 8 CPUs (XGene-1), you end up with 336 MSIs per
>>> CPU (having statically assigned 2 IRQs per CPU).
>>>
>>> Assuming you adopt my scheme, you still have a grand total of 336 MSIs
>>> that can be freely moved around without breaking any userspace
>>> expectations.
>>>
>> Thanks Marc. This is a very good idea.
>>
>> But to  move MSIs around, I need to change MSI termination address and data
>> and write them to device configuration space. This may cause problems
>> if the device
>> fires an interrupt at the same time when I do the config write?
>>
>> What is your opinion here?
>
> There is an inherent race when changing the affinity of any interrupt,
> whether that's an MSI or not. The kernel is perfectly prepared to handle
> such a situation (to be honest, the kernel doesn't really care).
>
> The write to the config space shouldn't be a concern. You will either
> hit the old *or* the new CPU, but that race is only during the write
> itself (you can read back from the config space if you're really
> paranoid).  By the time you return from this read/write, the device will
> be reconfigured.
>
>>> I think that 336 MSIs is a fair number (nowhere near the 16 you claim).
>>> Most platforms are doing quite well with that kind of numbers. Also,
>>> you don't have to allocate all the MSIs a device can possibly claim (up
>>> to 2048 MSI-X per device), as they are all perfectly capable of using
>>> less MSI without having to fallback to INTx).
>>>
>>>> I can document the limitation in affinity setting of X-Gene-1 MSI in
>>>> the driver to hopefully not make people surprise and hope to keep the
>>>> total number of supported MSI as 2688 so that we can support as many
>>>> cards that require MSI/MSI-X as possible.
>>>
>>> I don't think this is a valid approach. This breaks userspace (think of
>>> things like irqbalance), and breaks the SMP affinity model that Linux
>>> uses. No amount of documentation is going to solve it, so I think you
>>> just have to admit that the HW is mis-designed and do the best you can
>>> to make it work like Linux expect it to work.
>>>
>>> The alternative would to disable affinity setting altogether instead of
>>> introducing these horrible side effects.
>>>
>> I have it disabled (set_affinity does nothing) in my v4 patch.
>
> It would be good if you could try the above approach. It shouldn't be
> hard to write, and it would be a lot better than just ignoring the problem.
>
Yes. I am working on this change.

> I'll try to review the patches soon(-ish)...
>
>         M.
> --
> Jazz is not dead. It just smells funny...
Regards,
Duc Dang.
