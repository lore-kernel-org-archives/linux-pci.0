Return-Path: <SRS0=nHQg=KP=linaro.org=lee.jones@kernel.org>
Return-Path: <SRS0=nHQg=KP=linaro.org=lee.jones@kernel.org>
Date: Tue, 31 Jul 2018 08:29:45 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Russell King <linux@armlinux.org.uk>,
	Sebastian Reichel <sre@kernel.org>, Milo Kim <milo.kim@ti.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
Message-ID: <20180731072945.GF4662@dell>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
 <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1807310047320.1725@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.DEB.2.21.1807310047320.1725@nanos.tec.linutronix.de>
List-ID: <linux-pci.vger.kernel.org>

On Tue, 31 Jul 2018, Thomas Gleixner wrote:

> On Mon, 30 Jul 2018, Bjorn Helgaas wrote:
> 
> > [+cc maintainers of possibly erroneous callers of request_threaded_irq()]
> > 
> > On Mon, Jul 30, 2018 at 04:30:28PM -0500, Bjorn Helgaas wrote:
> > > [+cc Thomas, Christoph, LKML]
> > > 
> > > On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
> > > > If we have a threaded interrupt with the handler being NULL, then
> > > > request_threaded_irq() -> __setup_irq() will complain and bail out
> > > > if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
> > > > being NULL and set IRQF_ONESHOT in this case.
> > > > 
> > > > This change is needed to migrate the mei_me driver to
> > > > pci_alloc_irq_vectors() and pci_request_irq().
> > > > 
> > > > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > 
> > > I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> > > usage isn't mentioned in the request_threaded_irq() function doc or
> > > Documentation/
> > 
> > Possibly these other request_threaded_irq() callers are similarly
> > broken?  I can't tell for sure about tda998x_create(), but all the
> > others certainly call request_threaded_irq() with "handler == NULL"
> > and irqflags that do not contain IRQF_ONESHOT:
> > 
> >   max8997_muic_probe()
> >     request_threaded_irq(virq, NULL, ..., IRQF_NO_SUSPEND, ...)
> > 
> >   tda998x_create()
> >     request_threaded_irq(client->irq, NULL, ..., irqd_get_trigger_type(), ...)
> >     (I can't tell what irqd_get_trigger_type() does)
> 
> It reads the trigger type back from the irq chip (level/edge/polarity) but
> does not return with the ONESHOT bit set.
> 
> >   ab8500_btemp_probe()
> >   ab8500_charger_probe()
> >     request_threaded_irq(irq, NULL, ..., IRQF_SHARED | IRQF_NO_SUSPEND, ...)
> 
> SHARED is interesting ....
> 
> >   lp8788_set_irqs()
> >     request_threaded_irq(virq, NULL, ..., 0, ...)
> > 
> >   max77686_rtc_probe()
> >     request_threaded_irq(info->virq, NULL, ..., 0, ...)
> > 
> >   wm8350_register_irq()
> >     request_threaded_irq(irq + wm8350->irq_base, NULL, ..., flags, ...)
> >     (I think all callers of wm8350_register_irq() supply 0 for "flags")
> 
> Indeed. This all looks pretty much wrong. No idea why nobody ever noticed.

I guess not many people (myself included) know the intricacies well
enough to have noticed.  This probably coupled with insufficient
checking/warning about such practices in the IRQ subsystem.

There are quite a few different devices here, so my assumption would
be that interrupt handling still works in these cases.

If we know certain configurations are incorrect or incompatible, might
I suggest we add some form of alert to bring these to the attention of
unknowing contributors?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
