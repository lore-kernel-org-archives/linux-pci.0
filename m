Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47769 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab2LMKel convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2012 05:34:41 -0500
Date: Thu, 13 Dec 2012 10:34:12 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Michal Simek <monstr@monstr.eu>,
	Rob Herring <robherring2@gmail.com>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH] pci: Provide support for parsing PCI DT ranges property
Message-ID: <20121213103412.GA24453@arm.com>
References: <20121212163749.GA17371@arm.com>
 <20121213091333.GA14828@avionic-0098.adnet.avionic-design.de>
 <20121213094543.GA23446@arm.com>
 <20121213100318.GB13055@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
In-Reply-To: <20121213100318.GB13055@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 13, 2012 at 10:03:18AM +0000, Thierry Reding wrote:
> On Thu, Dec 13, 2012 at 09:45:43AM +0000, Andrew Murray wrote:
> > On Thu, Dec 13, 2012 at 09:13:33AM +0000, Thierry Reding wrote:
> > > Hi Andrew,
> > > 
> > > I don't like iterator interfaces too much, but I can live with that.
> > > Other than that the patch looks good to me and I'll try to work it into
> > > my Tegra PCIe patch series.
> > > 
> > > Just two minor comments below.
> > > 
> > > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > [...]
> > > > @@ -421,7 +472,7 @@ u64 __of_translate_address(struct device_node *dev, const __be32 *in_addr,
> > > >  		goto bail;
> > > >  	bus = of_match_bus(parent);
> > > >  
> > > > -	/* Cound address cells & copy address locally */
> > > > +	/* Count address cells & copy address locally */
> > > >  	bus->count_cells(dev, &na, &ns);
> > > >  	if (!OF_CHECK_COUNTS(na, ns)) {
> > > >  		printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
> > > 
> > > This is really minor, but it should still go into a separate patch.
> > > 
> > > > diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> > > > index 01b925a..4582b20 100644
> > > > --- a/include/linux/of_address.h
> > > > +++ b/include/linux/of_address.h
> > > > @@ -26,6 +26,8 @@ static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
> > > >  #define pci_address_to_pio pci_address_to_pio
> > > >  #endif
> > > >  
> > > > +const __be32 *of_pci_process_ranges(struct device_node *node,
> > > > +				    struct resource *res, const __be32 *from);
> > > >  #else /* CONFIG_OF_ADDRESS */
> > > >  static inline int of_address_to_resource(struct device_node *dev, int index,
> > > >  					 struct resource *r)
> > > > @@ -48,6 +50,11 @@ static inline const u32 *of_get_address(struct device_node *dev, int index,
> > > >  {
> > > >  	return NULL;
> > > >  }
> > > > +const __be32 *of_pci_process_ranges(struct device_node *node,
> > > 
> > > There should be a blank line to separate the above two lines.
> > > 
> > 
> > Thanks for the feedback.
> > 
> > I will send another patch for the typo and leave this patch with you for
> > working into your existing series.
> 
> I suppose you have your own series that uses this patch?

Not yet, it may be some time before I submit my PCI host bridge driver. Though
I am making changes else where (e.g. this patch) which I'm hoping to submit as
early as possible. I can rebase my work for these upstream dependencies.

I can re-spin this patch with your suggested changes if you prefer?

Andrew Murray


