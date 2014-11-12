Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:56829 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaKLOO1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 09:14:27 -0500
Date: Wed, 12 Nov 2014 14:14:29 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH v2] drivers: pci: move PCI domain assignment to
 generic PCI code
Message-ID: <20141112141429.GF6759@red-moon>
References: <1415637706-2195-1-git-send-email-lorenzo.pieralisi@arm.com>
 <176983067.8qgFVmI6qY@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <176983067.8qgFVmI6qY@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 10:39:17AM +0000, Arnd Bergmann wrote:
> On Monday 10 November 2014 16:41:46 Lorenzo Pieralisi wrote:
> > The current logic used for PCI domain assignment in arm64
> > pci_bus_assign_domain_nr() is flawed in that, depending on the host
> > controllers configuration for a platform and the respective initialization
> > sequence, core code may end up allocating PCI domain numbers from both DT and
> > the core code generic domain counter, which would result in PCI domain
> > allocation aliases/errors.
> > 
> > This patch fixes the logic behind the PCI domain number assignment and
> > moves the resulting code to generic PCI core code so that the same domain
> > allocation logic is used on all platforms selecting
> > 
> > CONFIG_PCI_DOMAINS_GENERIC
> > 
> > instead of resorting to an arch specific implementation that might end up
> > duplicating the PCI domain assignment logic wrongly.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> The general approach seems good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I would suggest one simplification:
> 
> > +
> > +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> > +
> > +void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> > +{
> > +	static int use_dt_domains = -1;
> > +	int domain = of_get_pci_domain_nr(parent->of_node);
> > +
> > +	/*
> > +	 * Check DT domain and use_dt_domains values.
> > +	 *
> > +	 * If DT domain property is valid (domain >= 0) and
> > +	 * use_dt_domains != 0, the DT assignment is valid since this means
> > +	 * we have not previously allocated a domain number by using
> > +	 * pci_get_new_domain_nr(); we should also update use_dt_domains to
> > +	 * 1, to indicate that we have just assigned a domain number from
> > +	 * DT.
> > +	 *
> > +	 * If DT domain property value is not valid (ie domain < 0), and we
> > +	 * have not previously assigned a domain number from DT
> > +	 * (use_dt_domains != 1) we should assign a domain number by
> > +	 * using the:
> > +	 *
> > +	 * pci_get_new_domain_nr()
> > +	 *
> > +	 * API and update the use_dt_domains value to keep track of method we
> > +	 * are using to assign domain numbers (use_dt_domains = 0).
> > +	 *
> > +	 * All other combinations imply we have a platform that is trying
> > +	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
> > +	 * which is a recipe for domain mishandling and it is prevented by
> > +	 * invalidating the domain value (domain = -1) and printing a
> > +	 * corresponding error.
> > +	 */
> > +	if (domain >= 0 && use_dt_domains) {
> > +		use_dt_domains = 1;
> > +	} else if (domain < 0 && use_dt_domains != 1) {
> > +		use_dt_domains = 0;
> > +		domain = pci_get_new_domain_nr();
> > +	} else {
> > +		dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
> > +			parent->of_node->full_name);
> > +		domain = -1;
> > +	}
> > +
> > +	bus->domain_nr = domain;
> > +}
> > +#endif
> >  #endif
> >  
> 
> Since this is now in the file in which it gets called, you can mark the
> function itself as 'static' and remove the extern declaration and inline
> wrapper from the header file. You can also avoid the #ifdef by doing

It is not, it is in driver/pci/pci.c, it is called in probe.c.

Maybe I can move the function to probe.c, but this would leave the
domain handling in two separate files.

I can't remove the #ifdeffery in that domain_nr in pci_bus is #ifdeffed
too, unless I remove that #ifdef and I compile it in all the time.

Thanks all for the review,
Lorenzo
