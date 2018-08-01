Return-Path: <SRS0=c4e6=KQ=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=c4e6=KQ=gmail.com=hkallweit1@kernel.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 LKML <linux-kernel@vger.kernel.org>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1807310015170.1725@nanos.tec.linutronix.de>
 <86d0v4x75x.wl-marc.zyngier@arm.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0799ea22-70ed-3be6-cb80-449f53fef819@gmail.com>
Date: Wed, 1 Aug 2018 21:51:10 +0200
MIME-Version: 1.0
In-Reply-To: <86d0v4x75x.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 31.07.2018 08:15, Marc Zyngier wrote:
> On Mon, 30 Jul 2018 23:36:57 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Mon, 30 Jul 2018, Bjorn Helgaas wrote:
>>
>>> [+cc Thomas, Christoph, LKML]
>>
>> + Marc
>>
>>> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
>>>> If we have a threaded interrupt with the handler being NULL, then
>>>> request_threaded_irq() -> __setup_irq() will complain and bail out
>>>> if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
>>>> being NULL and set IRQF_ONESHOT in this case.
>>>>
>>>> This change is needed to migrate the mei_me driver to
>>>> pci_alloc_irq_vectors() and pci_request_irq().
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>
>>> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
>>> usage isn't mentioned in the request_threaded_irq() function doc or
>>> Documentation/
>>
>> Right. The documentation really needs some love and care. :(
>>
>> Yes, request for pure threaded interrupts are rejected if the oneshot flag
>> is not set. The reason is that this would be deadly especially with level
>> triggered interrupts because the primary default handler just wakes the
>> thread and then reenables interrupts, which will make the interrupt come
>> back immediately and the thread won't have a chance to actually shut it up
>> in the device.
>>
>> That made me look into that code again and I found that we added a flag for
>> irq chips to tell the core that the interrupt is one shot safe, i.e. that
>> it can be requested w/o IRQF_ONESHOT. That was initially added to optimize
>> MSI based interrupts which are oneshot safe by implementation.
>>
>>   dc9b229a58dc ("genirq: Allow irq chips to mark themself oneshot safe")
>>
>> The original patch added that flag to the x86 MSI irqchip code, but that
>> part was not applied for reasons which slipped from memory. It might be
>> worthwhile to revisit that in order to avoid the mask/unmask overhead for
>> such cases.
> 
> Yup, that would actually be beneficial to a range of interrupt
> controllers (only an obscure GPIO driver makes use of this flag).
> 

I'm not an expert on that area, but if MSI is oneshot-safe in general,
then we could do the following in the framework instead of touching
every MSI irq_chip. Opinions?
I tested on X86 and at least my system is still running.

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4ca2fd46..ba6da943 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -289,6 +289,9 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
        if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
                msi_domain_update_chip_ops(info);

+       /* MSI is oneshot-safe in general */
+       info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
+
        domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
                                             fwnode, &msi_domain_ops, info);

--
2.18.0

> We could also consider extending this to support interrupt
> hierarchies, as __setup_irq() seems only concerned with the top of the
> stack (an IRQ provided by a generic MSI stack and backed by an irqchip
> providing IRQCHIP_ONESHOT_SAFE would go unnoticed).
> 

Would it be sufficient if one irq_chip in the hierarchy is oneshot-safe?
Or what do we have to check for?

> 	M.
> 

Heiner
