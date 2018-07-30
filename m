Return-Path: <SRS0=6kc1=KO=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=6kc1=KO=linutronix.de=tglx@kernel.org>
Date: Tue, 31 Jul 2018 00:36:57 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Heiner Kallweit <hkallweit1@gmail.com>,
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
    Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>,
    Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
In-Reply-To: <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807310015170.1725@nanos.tec.linutronix.de>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com> <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 30 Jul 2018, Bjorn Helgaas wrote:

> [+cc Thomas, Christoph, LKML]

+ Marc

> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
> > If we have a threaded interrupt with the handler being NULL, then
> > request_threaded_irq() -> __setup_irq() will complain and bail out
> > if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
> > being NULL and set IRQF_ONESHOT in this case.
> > 
> > This change is needed to migrate the mei_me driver to
> > pci_alloc_irq_vectors() and pci_request_irq().
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> usage isn't mentioned in the request_threaded_irq() function doc or
> Documentation/

Right. The documentation really needs some love and care. :(

Yes, request for pure threaded interrupts are rejected if the oneshot flag
is not set. The reason is that this would be deadly especially with level
triggered interrupts because the primary default handler just wakes the
thread and then reenables interrupts, which will make the interrupt come
back immediately and the thread won't have a chance to actually shut it up
in the device.

That made me look into that code again and I found that we added a flag for
irq chips to tell the core that the interrupt is one shot safe, i.e. that
it can be requested w/o IRQF_ONESHOT. That was initially added to optimize
MSI based interrupts which are oneshot safe by implementation.

  dc9b229a58dc ("genirq: Allow irq chips to mark themself oneshot safe")

The original patch added that flag to the x86 MSI irqchip code, but that
part was not applied for reasons which slipped from memory. It might be
worthwhile to revisit that in order to avoid the mask/unmask overhead for
such cases.

Anyway for the patch in question:

       Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
