Return-Path: <SRS0=ei1Y=KS=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=ei1Y=KS=linutronix.de=tglx@kernel.org>
Date: Fri, 3 Aug 2018 21:40:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
cc: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
    Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
In-Reply-To: <420d6476-8ea4-0b37-e94a-f5842b7b0ff7@gmail.com>
Message-ID: <alpine.DEB.2.21.1808032136490.1658@nanos.tec.linutronix.de>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com> <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.21.1807310015170.1725@nanos.tec.linutronix.de> <86d0v4x75x.wl-marc.zyngier@arm.com> <0799ea22-70ed-3be6-cb80-449f53fef819@gmail.com>
 <alpine.DEB.2.21.1808031605160.1745@nanos.tec.linutronix.de> <420d6476-8ea4-0b37-e94a-f5842b7b0ff7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Fri, 3 Aug 2018, Heiner Kallweit wrote:
> On 03.08.2018 16:09, Thomas Gleixner wrote:
> > On Wed, 1 Aug 2018, Heiner Kallweit wrote:
> >> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> >> index 4ca2fd46..ba6da943 100644
> >> --- a/kernel/irq/msi.c
> >> +++ b/kernel/irq/msi.c
> >> @@ -289,6 +289,9 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
> >>         if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
> >>                 msi_domain_update_chip_ops(info);
> >>
> >> +       /* MSI is oneshot-safe in general */
> >> +       info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> >> +
> >>         domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
> > 
> > Looks about right, though there might be dragons. MSI is not always as sane
> > as it should be...
> > 
> When saying "MSI isn't always sane", are you referring to the hardware or
> the controller driver implementation? Basically for me the question is
> whether we would be able to fix the issue if we meet such a dragon,
> or whether we would have to revert the change.

It's hardware unfortunately, so it might be a revert. PCI-MSI should be
safe, but the wild MSI variants in SoCs might be the actual dragon caves.

> Do you think the chance of a dragon is low enough? Or better add the
> flag only to the X86 PCI MSI irqchip for now?

I think PCI-MSI in general would be not too risky. Famous last words.

Thanks,

	tglx
