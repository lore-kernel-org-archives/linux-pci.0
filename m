Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60512 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497AbbERRi1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 May 2015 13:38:27 -0400
Date: Mon, 18 May 2015 18:38:18 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <Will.Deacon@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Russell King <linux@arm.linux.org.uk>,
	Lucas Stach <l.stach@pengutronix.de>,
	Simon Horman <horms@verge.net.au>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [RFC/RFT PATCH 2/2] ARM64: kernel: pci: implement PCI device
 resources claiming
Message-ID: <20150518173818.GA20028@red-moon>
References: <1431614537-16136-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1431614537-16136-2-git-send-email-lorenzo.pieralisi@arm.com>
 <5555553F.9070608@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5555553F.9070608@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Suravee,

On Fri, May 15, 2015 at 03:09:03AM +0100, Suravee Suthikulanit wrote:
> On 5/14/2015 9:42 AM, Lorenzo Pieralisi wrote:
> > When a device is scanned and added to the PCI bus, its resources
> > should be claimed to validate the BARs configuration and to assign
> > them a parent resource so that the resource hierarchy can be sanity
> > checked.
> >
> > This patch adds code that carries out PCI device resources claiming to
> > the ARM64 pcibios_add_device implementation so that device resources
> > are claimed by the core PCI layer upon PCI device initialization on
> > ARM64 systems.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   arch/arm64/kernel/pci.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 4095379..c0a88ca 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -43,8 +43,18 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >    */
> >   int pcibios_add_device(struct pci_dev *dev)
> >   {
> > +	struct resource *res;
> > +	int i;
> > +
> >   	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> >
> > +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > +		res = &dev->resource[i];
> > +		if (res->parent || !res->flags)
> > +			continue;
> > +		pci_claim_resource(dev, i);
> > +	}
> > +
> >   	return 0;
> >   }
> >
> >
> 
> Lorenzo/Bjorn,
> 
> I have tested this patch on top of Jayachandran's V2 patch series 
> (http://www.spinics.net/lists/linux-pci/msg40811.html) on AMD Seattle 
> (w/ PROBE_ONLY and non-PROBE_ONLY mode), and your changes here works 
> with additional changes below.
> 
> It seems that when booting w/ PROBE_ONLY case, we need to call 
> pci_read_bridge_bases() at some point before claiming the resources of 
> devices underneath the bridge. This is needed to determine the bridge 
> bases (i.e. bridge io, mmio and mmio_pref bases), and update bridge 
> resources accordingly.

Thanks for testing, I will give it a go on Seattle, if you can drop
the log you get on PROBE_ONLY (without your patch below) that would be
great so that I can have a look at the issue.

Thanks,
Lorenzo

> ---- BEGIN PATCH -----
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index c0a88ca..57be6aa 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -48,6 +48,11 @@ int pcibios_add_device(struct pci_dev *dev)
> 
>          dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> 
> +       if (pci_has_flag(PCI_PROBE_ONLY) &&
> +           !pci_is_root_bus(dev->bus) &&
> +           !pci_bridge_bases_is_read(dev->bus))
> +               pci_read_bridge_bases(dev->bus);
> +
>          for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>                  res = &dev->resource[i];
>                  if (res->parent || !res->flags)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6675a7a..6cab8be 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -447,6 +447,13 @@ static void pci_read_bridge_mmio_pref(struct 
> pci_bus *child)
>          }
>   }
> 
> +bool pci_bridge_bases_is_read(struct pci_bus *bus)
> +{
> +       return (bus->resource[0]->start ||
> +               bus->resource[1]->start ||
> +               bus->resource[2]->start);
> +}
> +
>   void pci_read_bridge_bases(struct pci_bus *child)
>   {
>          struct pci_dev *dev = child->self;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 353db8d..11c674d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -798,6 +798,7 @@ void pci_device_add(struct pci_dev *dev, struct 
> pci_bus *bus);
>   unsigned int pci_scan_child_bus(struct pci_bus *bus);
>   void pci_bus_add_device(struct pci_dev *dev);
>   void pci_read_bridge_bases(struct pci_bus *child);
> +bool pci_bridge_bases_is_read(struct pci_bus *bus);
>   struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>                                            struct resource *res);
>   u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
> ---- END PATCH -----
> 
> I'm not sure if this is the best place to be reading the bridge bases. 
> I guess we should be able to do this when adding bridge devices.
> 
> Thanks,
> 
> Suravee
> 
> 
