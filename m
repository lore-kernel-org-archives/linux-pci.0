Return-Path: <SRS0=zoTz=ER=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=zoTz=ER=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 22 Jan 2018 10:53:27 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
	Bjorn Helgaas <bhelgaas@google.com>, arnd@arndb.de, kishon@ti.com,
	Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add dummy pci_irqd_intx_xlate() for CONFIG_PCI=n
 build
Message-ID: <20180122105327.GA31766@red-moon>
References: <20180119093906.27670-1-niklas.cassel@axis.com>
 <20180119111859.GA24300@red-moon>
 <20180120024005.GC160618@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180120024005.GC160618@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 19, 2018 at 08:40:05PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 19, 2018 at 11:18:59AM +0000, Lorenzo Pieralisi wrote:
> > On Fri, Jan 19, 2018 at 10:39:06AM +0100, Niklas Cassel wrote:
> > > If CONFIG_PCI=n and CONFIG_PCI_DRA7XX_EP=y, the build fails with:
> > > 
> > >   drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate'
> > >   undeclared here (not in a function)
> > > 
> > > When building drivers/pci/dwc/pci-dra7xx.c without CONFIG_PCI,
> > > gcc is usually smart enough to realize that RC specific code
> > > is unreachable and can thus be eliminated.
> > > 
> > > However, gcc cannot do this if there is a function that isn't
> > > even declared.
> > > 
> > > Hence fix the issue by introducing a dummy for pci_irqd_intx_xlate().
> > > 
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > 
> > Thanks for the patch.
> > 
> > I think the commit log should be rewritten (when you write it think at
> > someone reading it in some time - what you wrote won't probably make
> > any sense) but first, Bjorn are you picking this up ? It does not make
> > much sense to squash it in one of my pci/dwc branch commits - therefore
> > I am asking, just let me know.
> 
> I did apply this, as follows.  I don't know if the commit log makes
> any more sense; a lot of the sense is in the eye of the author :)
> 
> But anyway, I put this on pci/misc and re-merged my "next" branch so
> this is applied before the dra7xx changes, so there shouldn't be any
> bisection issue.

Thank you, I just wanted to say that it was better to provide a general
description/introduction of the issue (like you did) instead of
referring to a specific driver.

Anyway - thanks for the patch - I think that after the merge window
we can rework the code and remove it.

Thanks,
Lorenzo

> commit 80db6f08b7af93eddc9487535e6150b220262637
> Author: Niklas Cassel <niklas.cassel@axis.com>
> Date:   Fri Jan 19 10:39:06 2018 +0100
> 
>     PCI: Add dummy pci_irqd_intx_xlate() for CONFIG_PCI=n build
>     
>     Some hardware can operate in either "host" or "endpoint" mode, which means
>     there can be both a host bridge driver and an endpoint driver for the same
>     device.  Those drivers share a lot of code, so sometimes they live in the
>     same source file.
>     
>     The host bridge driver requires CONFIG_PCI=y because it enumerates PCI
>     devices below the bridge using the PCI core.  The endpoint driver does not
>     require CONFIG_PCI=y because it runs in an embedded kernel on the other
>     side of the device, e.g., on an adapter card.
>     
>     pci-dra7xx.c contains both host and endpoint drivers.  If we select only
>     the endpoint driver (CONFIG_PCI=n and CONFIG_PCI_DRA7XX_EP=y), the unneeded
>     host driver is still compiled.  It references pci_irqd_intx_xlate(), which
>     is not present when CONFIG_PCI=n, which causes this error:
>     
>       drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate' undeclared here (not in a function)
>     
>     Add a dummy pci_irqd_intx_xlate() for the CONFIG_PCI=n case.
>     
>     [bhelgaas: changelog]
>     Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Arnd Bergmann <arnd@arndb.de>
>     Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6079ab46191f..febe7f653689 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1686,6 +1686,13 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  #define dev_is_pf(d) (false)
>  static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
>  { return false; }
> +static inline int pci_irqd_intx_xlate(struct irq_domain *d,
> +				      struct device_node *node,
> +				      const u32 *intspec,
> +				      unsigned int intsize,
> +				      unsigned long *out_hwirq,
> +				      unsigned int *out_type)
> +{ return -EINVAL; }
>  #endif /* CONFIG_PCI */
>  
>  /* Include architecture-dependent settings and functions */
