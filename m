Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754757AbeF0RQ0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jun 2018 13:16:26 -0400
Date: Wed, 27 Jun 2018 18:18:11 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>
Subject: Re: [PATCH v4 5/6] PCI: aardvark: Introduce an
 advk_pcie_valid_device() helper
Message-ID: <20180627171811.GB8243@red-moon>
References: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
 <20180406145536.19637-6-thomas.petazzoni@bootlin.com>
 <20180627165124.GA8243@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627165124.GA8243@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 27, 2018 at 05:51:24PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Apr 06, 2018 at 04:55:35PM +0200, Thomas Petazzoni wrote:
> > In other to mimic other PCIe host controller drivers, introduce an
> > advk_pcie_valid_device() helper, used in the configuration read/write
> > functions.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > ---
> > Changes since v4:
> >  - Move later into the series, so that it doesn't need to be pushed as
> >    a fix for stable.
> > Changes since v3:
> >  - Make the new helper return a bool instead of int
> > Changes since v2:
> >  - New patch
> > ---
> >  drivers/pci/host/pci-aardvark.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> Hi Thomas,
> 
> please rebase patch 5 (this patch) and 6 and resend, I will apply them
> straight away, sorry for the delay.

Never mind, I handled the host->controller dir move myself, applied both
to pci/aardvark for v4.19, thanks.

Lorenzo

> Thanks,
> Lorenzo
> 
> > diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> > index 9abf549631b4..69c4fd50947e 100644
> > --- a/drivers/pci/host/pci-aardvark.c
> > +++ b/drivers/pci/host/pci-aardvark.c
> > @@ -431,6 +431,15 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
> >  	return -ETIMEDOUT;
> >  }
> >  
> > +static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> > +				  int devfn)
> > +{
> > +	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> >  			     int where, int size, u32 *val)
> >  {
> > @@ -438,7 +447,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> >  	u32 reg;
> >  	int ret;
> >  
> > -	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0) {
> > +	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
> >  		*val = 0xffffffff;
> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> >  	}
> > @@ -492,7 +501,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> >  	int offset;
> >  	int ret;
> >  
> > -	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
> > +	if (!advk_pcie_valid_device(pcie, bus, devfn))
> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> >  
> >  	if (where % size)
> > -- 
> > 2.14.3
> > 
