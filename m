Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbeGaAUD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 20:20:03 -0400
Date: Mon, 30 Jul 2018 17:42:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, Milo Kim <milo.kim@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
Message-ID: <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc maintainers of possibly erroneous callers of request_threaded_irq()]

On Mon, Jul 30, 2018 at 04:30:28PM -0500, Bjorn Helgaas wrote:
> [+cc Thomas, Christoph, LKML]
> 
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

Possibly these other request_threaded_irq() callers are similarly
broken?  I can't tell for sure about tda998x_create(), but all the
others certainly call request_threaded_irq() with "handler == NULL"
and irqflags that do not contain IRQF_ONESHOT:

  max8997_muic_probe()
    request_threaded_irq(virq, NULL, ..., IRQF_NO_SUSPEND, ...)

  tda998x_create()
    request_threaded_irq(client->irq, NULL, ..., irqd_get_trigger_type(), ...)
    (I can't tell what irqd_get_trigger_type() does)

  ab8500_btemp_probe()
  ab8500_charger_probe()
    request_threaded_irq(irq, NULL, ..., IRQF_SHARED | IRQF_NO_SUSPEND, ...)

  lp8788_set_irqs()
    request_threaded_irq(virq, NULL, ..., 0, ...)

  max77686_rtc_probe()
    request_threaded_irq(info->virq, NULL, ..., 0, ...)

  wm8350_register_irq()
    request_threaded_irq(irq + wm8350->irq_base, NULL, ..., flags, ...)
    (I think all callers of wm8350_register_irq() supply 0 for "flags")

> > ---
> >  drivers/pci/irq.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
> > index 2a808e10..a1de501a 100644
> > --- a/drivers/pci/irq.c
> > +++ b/drivers/pci/irq.c
> > @@ -86,13 +86,17 @@ int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
> >  	va_list ap;
> >  	int ret;
> >  	char *devname;
> > +	unsigned long irqflags = IRQF_SHARED;
> > +
> > +	if (!handler)
> > +		irqflags |= IRQF_ONESHOT;
> >  
> >  	va_start(ap, fmt);
> >  	devname = kvasprintf(GFP_KERNEL, fmt, ap);
> >  	va_end(ap);
> >  
> >  	ret = request_threaded_irq(pci_irq_vector(dev, nr), handler, thread_fn,
> > -			IRQF_SHARED, devname, dev_id);
> > +				   irqflags, devname, dev_id);
> >  	if (ret)
> >  		kfree(devname);
> >  	return ret;
> > -- 
> > 2.18.0
> > 
