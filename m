Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbdJTWbv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 18:31:51 -0400
Date: Fri, 20 Oct 2017 17:31:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Fabio Estevam <festevam@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mason <slash.tmp@free.fr>
Subject: Re: [PATCH 4/5] PCI: tango: Fix platform_get_irq() error handling
Message-ID: <20171020223149.GU6332@bhelgaas-glaptop.roam.corp.google.com>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com>
 <1508018851-9272-4-git-send-email-festevam@gmail.com>
 <169eac7a-4dd1-f164-6342-9bac8b7dbf3a@sigmadesigns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <169eac7a-4dd1-f164-6342-9bac8b7dbf3a@sigmadesigns.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 16, 2017 at 11:09:15AM +0200, Marc Gonzalez wrote:
> + gkh, maz, tglx, linus w
> 
> On 15/10/2017 00:07, Fabio Estevam wrote:
> 
> > When platform_get_irq() fails we should propagate the real error value
> > instead of always returning -ENXIO.
> > 
> > Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > ---
> >  drivers/pci/host/pcie-tango.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
> > index e23f738..5196583 100644
> > --- a/drivers/pci/host/pcie-tango.c
> > +++ b/drivers/pci/host/pcie-tango.c
> > @@ -272,9 +272,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
> >  		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
> >  
> >  	virq = platform_get_irq(pdev, 1);
> > -	if (virq <= 0) {
> > +	if (virq < 0) {
> >  		dev_err(dev, "Failed to map IRQ\n");
> > -		return -ENXIO;
> > +		return virq;
> >  	}
> >  
> >  	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
> 
> Hello Fabio,
> 
> I don't think this patch is correct.
> 
> AFAIU, on all but legacy platforms, when platform_get_irq() returns 0,
> it is to signal an error condition.
> 
> Marc Z pointed out this discussion:
> http://yarchive.net/comp/linux/zero.html
> 
> Looking more closely at the platform_get_irq implementation, and ignoring
> the CONFIG_SPARC special-case, the return value is either:
> 
> * a valid virq > 0, or
> * -EPROBE_DEFER, or
> * some error code < 0, in the ACPI case, or
> * -ENXIO, or
> * res->start (an unsigned type, so >= 0)
> 
> 
> I suppose it would be slightly nicer to write:
> 
> 	virq = platform_get_irq(pdev, 1);
> 	if (virq <= 0)
> 		return virq ? virq : -ENODEV;

All these return values end up getting returned by the driver probe()
functions.  I don't think there's much value in returning the exact
error we got from platform_get_irq() vs a generic error like -ENXIO or
-ENODEV, so my $0.02 is that the above is more complicated than it's
worth.

I think existing code that looks like:

  irq = platform_get_irq(pdev, 0);
  if (irq <= 0)
    return -ENODEV;

is fine and there's no reason to change it.  For code that doesn't
check the platform_get_irq() return value, I'd say it's worth adding a
check for "irq <= 0".  Maybe somebody will point out an arch that can
return 0 as a legitimate IRQ, and then we'll have to rethink.

Bjorn
