Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37331 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbbETJQV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 May 2015 05:16:21 -0400
Date: Wed, 20 May 2015 10:16:15 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
	Jayachandran C <jchandra@broadcom.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [RFC/RFT PATCH 2/2] ARM64: kernel: pci: implement PCI device
 resources claiming
Message-ID: <20150520091615.GD29274@red-moon>
References: <1431614537-16136-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1431614537-16136-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20150519232531.GZ31666@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150519232531.GZ31666@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wed, May 20, 2015 at 12:25:31AM +0100, Bjorn Helgaas wrote:
> Hi Lorenzo,
> 
> On Thu, May 14, 2015 at 03:42:16PM +0100, Lorenzo Pieralisi wrote:
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
> 
> Seems like Suravee proposed a tweak?  Can you post a v2 with that
> incorporated if necessary?

I can post a v2, but I am not happy about that tweak, I want to
understand why pci_read_bridge_bases has to be executed only on
PCI_PROBE_ONLY systems and why it can't be done in generic code in the
first place - ie pci_scan_child_bus(), I guess as I mentioned that in
some archs this can trigger regressions, if you have an opinion please
let me know, when we agree I will drop a v2 on the lists.

Thanks,
Lorenzo

> Bjorn
> 
> > ---
> >  arch/arm64/kernel/pci.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 4095379..c0a88ca 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -43,8 +43,18 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >   */
> >  int pcibios_add_device(struct pci_dev *dev)
> >  {
> > +	struct resource *res;
> > +	int i;
> > +
> >  	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> >  
> > +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > +		res = &dev->resource[i];
> > +		if (res->parent || !res->flags)
> > +			continue;
> > +		pci_claim_resource(dev, i);
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.2.1
> > 
> 
