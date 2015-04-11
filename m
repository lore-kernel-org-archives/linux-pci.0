Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX  termination driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sat, 11 Apr 2015 13:06:46 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
Cc: Feng Kan <fkan@apm.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux-pci@vger.kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	<linux-kernel@vger.kernel.org>, <grant.likely@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-arm-kernel@lists.infradead.org>, Loc Ho <lho@apm.com>
In-Reply-To: <CADaLNDkrqwnEOX1HgQ7V3-1o4cDJnG4dW1=U4ujod7fUW_PQ0w@mail.gmail.com>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>
 <cover.1428564115.git.dhdang@apm.com>
 <7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>
 <55280665.9020603@arm.com>
 <CADaLNDkrqwnEOX1HgQ7V3-1o4cDJnG4dW1=U4ujod7fUW_PQ0w@mail.gmail.com>
Message-ID: <7a739a984c1b849ae92cb3bb3edc92f2@www.loen.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015-04-11 00:42, Duc Dang wrote:
> On Fri, Apr 10, 2015 at 10:20 AM, Marc Zyngier <marc.zyngier@arm.com> 
> wrote:
>> On 09/04/15 18:05, Duc Dang wrote:
>>> X-Gene v1 SoC supports total 2688 MSI/MSIX vectors coalesced into
>>> 16 HW IRQ lines.
>>>
>>> Signed-off-by: Duc Dang <dhdang@apm.com>
>>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>>> ---
>>>  drivers/pci/host/Kconfig         |   6 +
>>>  drivers/pci/host/Makefile        |   1 +
>>>  drivers/pci/host/pci-xgene-msi.c | 407 
>>> +++++++++++++++++++++++++++++++++++++++
>>>  drivers/pci/host/pci-xgene.c     |  21 ++
>>>  4 files changed, 435 insertions(+)
>>>  create mode 100644 drivers/pci/host/pci-xgene-msi.c
>>>
>>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>>> index 7b892a9..c9b61fa 100644
>>> --- a/drivers/pci/host/Kconfig
>>> +++ b/drivers/pci/host/Kconfig
>>> @@ -89,11 +89,17 @@ config PCI_XGENE
>>>         depends on ARCH_XGENE
>>>         depends on OF
>>>         select PCIEPORTBUS
>>> +       select PCI_MSI_IRQ_DOMAIN if PCI_MSI
>>> +       select PCI_XGENE_MSI if PCI_MSI
>>>         help
>>>           Say Y here if you want internal PCI support on APM X-Gene 
>>> SoC.
>>>           There are 5 internal PCIe ports available. Each port is 
>>> GEN3 capable
>>>           and have varied lanes from x1 to x8.
>>>
>>> +config PCI_XGENE_MSI
>>> +       bool "X-Gene v1 PCIe MSI feature"
>>> +       depends on PCI_XGENE && PCI_MSI
>>> +
>>>  config PCI_LAYERSCAPE
>>>         bool "Freescale Layerscape PCIe controller"
>>>         depends on OF && ARM
>>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>>> index e61d91c..f39bde3 100644
>>> --- a/drivers/pci/host/Makefile
>>> +++ b/drivers/pci/host/Makefile
>>> @@ -11,5 +11,6 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>>>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>>>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>>>  obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
>>> +obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>>>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>>>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>>> diff --git a/drivers/pci/host/pci-xgene-msi.c 
>>> b/drivers/pci/host/pci-xgene-msi.c
>>> new file mode 100644
>>> index 0000000..4f0ff42
>>> --- /dev/null
>>> +++ b/drivers/pci/host/pci-xgene-msi.c
>>> @@ -0,0 +1,407 @@
>>> +/*
>>> + * APM X-Gene MSI Driver
>>> + *
>>> + * Copyright (c) 2014, Applied Micro Circuits Corporation
>>> + * Author: Tanmay Inamdar <tinamdar@apm.com>
>>> + *        Duc Dang <dhdang@apm.com>
>>> + *
>>> + * This program is free software; you can redistribute  it and/or 
>>> modify it
>>> + * under  the terms of  the GNU General  Public License as 
>>> published by the
>>> + * Free Software Foundation;  either version 2 of the  License, or 
>>> (at your
>>> + * option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +#include <linux/interrupt.h>
>>> +#include <linux/module.h>
>>> +#include <linux/msi.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/of_pci.h>
>>> +
>>> +#define MSI_INDEX0             0x000000
>>> +#define MSI_INT0               0x800000
>>> +
>>> +struct xgene_msi_settings {
>>> +       u32     index_per_group;
>>> +       u32     irqs_per_index;
>>> +       u32     nr_msi_vec;
>>> +       u32     nr_hw_irqs;
>>> +};
>>> +
>>> +struct xgene_msi {
>>> +       struct device_node              *node;
>>> +       struct msi_controller           mchip;
>>> +       struct irq_domain               *domain;
>>> +       struct xgene_msi_settings       *settings;
>>> +       u32                             msi_addr_lo;
>>> +       u32                             msi_addr_hi;
>>
>> I'd rather see the mailbox address directly, and only do the split 
>> when
>> assigning it to the message (you seem to play all kind of tricks on 
>> the
>> address anyway).
>
> msi_addr_lo and msi_addr_hi store the physical base address of MSI
> controller registers. I will add comment to clarify this.

What I mean is that there is no point in keeping this around as a pair
of 32bit variables. You'd better keep it as a single 64bit, and do the
split when assigning it the the MSI message.

[...]

>>> +static int xgene_msi_set_affinity(struct irq_data *irq_data,
>>> +                                 const struct cpumask *mask, bool 
>>> force)
>>> +{
>>> +       struct xgene_msi *msi = 
>>> irq_data_get_irq_chip_data(irq_data);
>>> +       unsigned int gic_irq;
>>> +       int ret;
>>> +
>>> +       gic_irq = msi->msi_virqs[irq_data->hwirq % 
>>> msi->settings->nr_hw_irqs];
>>> +       ret = irq_set_affinity(gic_irq, mask);
>>
>> Erm... This as the effect of moving *all* the MSIs hanging off this
>> interrupt to another CPU. I'm not sure that's an acceptable 
>> effect...
>> What if another MSI requires a different affinity?
>
> We have 16 'real' hardware IRQs. Each of these has multiple MSIs
> attached to it.
> So this will move all MSIs handing off this interrupt to another CPU;
> and we don't support different affinity settings for different MSIs
> that are attached to the same hardware IRQ.

Well, that's a significant departure from the expected behaviour. In 
other
words, I wonder how useful this is. Could you instead reconfigure the 
MSI
itself to hit the right CPU (assuming you don't have more than 16 CPUs 
and if
that's only for XGene-1, this will only be 8 at most)? This would 
reduce
your number of possible MSIs, but at least the semantics of set_afinity
would be preserved.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
