Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756158AbeASS5l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jan 2018 13:57:41 -0500
Date: Fri, 19 Jan 2018 12:57:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>, arnd@arndb.de,
        kishon@ti.com, Niklas Cassel <niklass@axis.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add dummy pci_irqd_intx_xlate() for CONFIG_PCI=n
 build
Message-ID: <20180119185739.GA5317@bhelgaas-glaptop.roam.corp.google.com>
References: <20180119093906.27670-1-niklas.cassel@axis.com>
 <20180119111859.GA24300@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119111859.GA24300@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 19, 2018 at 11:18:59AM +0000, Lorenzo Pieralisi wrote:
> On Fri, Jan 19, 2018 at 10:39:06AM +0100, Niklas Cassel wrote:
> > If CONFIG_PCI=n and CONFIG_PCI_DRA7XX_EP=y, the build fails with:
> > 
> >   drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate'
> >   undeclared here (not in a function)
> > 
> > When building drivers/pci/dwc/pci-dra7xx.c without CONFIG_PCI,
> > gcc is usually smart enough to realize that RC specific code
> > is unreachable and can thus be eliminated.
> > 
> > However, gcc cannot do this if there is a function that isn't
> > even declared.
> > 
> > Hence fix the issue by introducing a dummy for pci_irqd_intx_xlate().
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> 
> Thanks for the patch.
> 
> I think the commit log should be rewritten (when you write it think at
> someone reading it in some time - what you wrote won't probably make
> any sense) but first, Bjorn are you picking this up ? It does not make
> much sense to squash it in one of my pci/dwc branch commits - therefore
> I am asking, just let me know.

This build problem is in my "next" branch (not in Linus' tree yet),
and I will pick this up in some form for the v4.16 merge window, but
I'm not 100% sure about the approach yet.  

We compile pci-dra7xx.c if either CONFIG_PCI_DRA7XX_HOST or
CONFIG_PCI_DRA7XX_EP (or both) are set.  There's actually quite a bit
of code there that is specific to either _HOST or _EP.  The reference
to pci_irqd_intx_xlate() is a small piece of that.

So we compile the whole file when only one of _HOST and _EP is set,
and I guess we implicitly rely on gcc to eliminate the unused code.

I wonder if there would be anything to be gained by instead adding
"#ifdef CONFIG_PCI_DRA7XX_HOST" and "#ifdef CONFIG_PCI_DRA7XX_EP"
around the appropriate pieces.  That's a little bit ugly, but the
ugliness does have some value in that it makes it more explicit which
pieces go where, and it might be an incentive to group the
host-related pieces and the endpoint-related pieces.

I don't know if that avenue would be fruitful, and even if it were,
there's probably not time to do it before the v4.16 merge window, so I
guess I'll probably merge this patch as-is.  It does have the
disadvantage that we export pci_irqd_intx_xlate() to the world, most
of which doesn't need it.

> > ---
> >  include/linux/pci.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 83299833a6ce..41c676a011f4 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1675,6 +1675,13 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
> >  #define dev_is_pf(d) (false)
> >  static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
> >  { return false; }
> > +static inline int pci_irqd_intx_xlate(struct irq_domain *d,
> > +				      struct device_node *node,
> > +				      const u32 *intspec,
> > +				      unsigned int intsize,
> > +				      unsigned long *out_hwirq,
> > +				      unsigned int *out_type)
> > +{ return -EINVAL; }
> >  #endif /* CONFIG_PCI */
> >  
> >  /* Include architecture-dependent settings and functions */
> > -- 
> > 2.14.2
> > 
