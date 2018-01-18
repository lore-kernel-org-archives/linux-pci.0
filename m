Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59574 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755657AbeARSgM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jan 2018 13:36:12 -0500
Date: Thu, 18 Jan 2018 18:36:00 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: dra7xx: add back CONFIG_PCI dependency for
 endpoint
Message-ID: <20180118183546.GA8492@e107981-ln.cambridge.arm.com>
References: <20180118131612.871559-1-arnd@arndb.de>
 <20180118150357.GA7544@axis.com>
 <CAK8P3a1w1HTvNaqtrQq+FmnARrr=cs+iqQFNJEC2y3L0OX_aTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a1w1HTvNaqtrQq+FmnARrr=cs+iqQFNJEC2y3L0OX_aTg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 18, 2018 at 05:39:02PM +0100, Arnd Bergmann wrote:

[...]

> > However, since pci_irqd_intx_xlate is only defined inside
> > CONFIG_PCI, even 489f8fe6aa71 will not help.
> >
> > Not completely sure about this, but perhaps a better fix is:
> >
> > +++ b/include/linux/pci.h
> > @@ -1686,6 +1686,12 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
> >  #define dev_is_pf(d) (false)
> >  static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
> >  { return false; }
> > +static inline int pci_irqd_intx_xlate(struct irq_domain *d,
> > +                                     struct device_node *node,
> > +                                     const u32 *intspec,
> > +                                     unsigned int intsize,
> > +                                     unsigned long *out_hwirq,
> > +                                     unsigned int *out_type) { return 0; }
> >  #endif /* CONFIG_PCI */
> >
> >  /* Include architecture-dependent settings and functions */
> >
> >
> > And a 'Fixes:' tag that references 524d59f6e30a
> 
> Looks fine to me, but I'd put the '{ return 0; }' in a new line for consistency
> with the other functions here, and maybe return -EINVAL instead of
> zero.
> 
> Can you submit that as a proper patch and add my
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

You can add my:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

too but I am a bit dubious about the Fixes: tag (it will be merged via
a separate branch and I do not think we really need it), I would omit it.

Please send it as soon as possible or I can do it, please let me
know.

Thanks,
Lorenzo
