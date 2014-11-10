Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:55517 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbaKJNwf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 08:52:35 -0500
Date: Mon, 10 Nov 2014 13:52:32 +0000
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
Subject: Re: [RFC PATCH] drivers: of: move PCI domain assignment to generic
 OF code
Message-ID: <20141110135232.GC15484@red-moon>
References: <1415622368-14612-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1459907.RIyEjnM4cg@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459907.RIyEjnM4cg@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 10, 2014 at 12:51:19PM +0000, Arnd Bergmann wrote:
> On Monday 10 November 2014 12:26:08 Lorenzo Pieralisi wrote:
> > ---
> >  arch/arm64/kernel/pci.c | 14 +++--------
> >  drivers/of/of_pci.c     | 66 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/of_pci.h  |  7 +++---
> >  3 files changed, 71 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index ce5836c..5e21c1c 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -49,20 +49,14 @@ int pcibios_add_device(struct pci_dev *dev)
> >  
> >  
> >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > -static bool dt_domain_found = false;
> >  
> >  void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> >  {
> > -	int domain = of_get_pci_domain_nr(parent->of_node);
> > +	int domain = of_assign_pci_domain_nr(parent->of_node);
> >  
> > -	if (domain >= 0) {
> > -		dt_domain_found = true;
> > -	} else if (dt_domain_found == true) {
> > -		dev_err(parent, "Node %s is missing \"linux,pci-domain\" property in DT\n",
> > -			parent->of_node->full_name);
> > -		return;
> > -	} else {
> > -		domain = pci_get_new_domain_nr();
> > +	if (domain < 0) {
> > +		dev_err(parent, "PCI domain assignment failed\n");
> > +		domain = -1;
> >  	}
> >  
> >  	bus->domain_nr = domain;
> 
> Is there a need to still keep this in architecture specific code? Why
> not move it to drivers/pci and let other firmware infrastructure
> hook in there directly.

Ok, I can move the function to drivers/pci/pci.c, I did not want to add
OF code in there but if it is ok with Bjorn I will move the generic

pci_bus_assign_domain_nr()

there and be done with this.

> >  {
> > @@ -45,10 +45,9 @@ of_pci_parse_bus_range(struct device_node *node, struct resource *res)
> >  	return -EINVAL;
> >  }
> >  
> > -static inline int
> > -of_get_pci_domain_nr(struct device_node *node)
> > +static inline int of_assign_pci_domain_nr(struct device_node *node)
> >  {
> > -	return -1;
> > +	return pci_get_new_domain_nr();
> >  }
> >  #endif
> 
> This gets a bit tricky otherwise once we add ACPI in the mix, with all
> combinations of OF and ACPI at compile time and at runtime.

I definitely agree, that's why it is an RFC, basically wanted to
understand what we want to do with the generic implementation and where
to move it.

Thanks,
Lorenzo
