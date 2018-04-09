Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55298 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDILYT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 07:24:19 -0400
Date: Mon, 9 Apr 2018 13:24:15 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/4] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
Message-ID: <20180409112415.5sxuumczgluu7iea@verge.net.au>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
 <35e8fb4a-4b43-dac9-7a6f-cc7083c06453@cogentembedded.com>
 <20180409105415.h4rstrzzan4k6neq@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409105415.h4rstrzzan4k6neq@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 12:54:18PM +0200, Simon Horman wrote:
> On Fri, Apr 06, 2018 at 02:02:52PM +0300, Sergei Shtylyov wrote:
> > In  all the R-Car gen1/2/3 manuals, we are instructed to poll PCIEPHYSR
> > for PHYRDY=1  at  an early stage of the PCIEC initialization -- while
> > the driver only does this on R-Car H1 (polling a PHY specific register).
> 
> Is the R-Car H1 specific code still needed with this patch in place?
> 
> If so can we consider a helper. rcar_pcie_wait_for_phyrdy() looks
> very similar to that R-Car H1 code.
> 
> > Add the PHYRDY polling to rcar_pcie_hw_init(). Note that without the
> > special PHY driver on the R-Car V3H the PCIEC initialization just freezes
> > the kernel --  adding the PHYRDY polling allows the init code to exit
> > gracefully on timeout (PHY starts powered down after reset on this SoC).
> 
> How widely has this been exercised? I assume it affects Rcar Gen 1, 2 and 3.
> 
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > ---
> >  drivers/pci/host/pcie-rcar.c |   20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > Index: pci/drivers/pci/host/pcie-rcar.c
> > ===================================================================
> > --- pci.orig/drivers/pci/host/pcie-rcar.c
> > +++ pci/drivers/pci/host/pcie-rcar.c
> > @@ -36,6 +36,8 @@
> >  #define PCIECDR			0x000020
> >  #define PCIEMSR			0x000028
> >  #define PCIEINTXR		0x000400
> > +#define PCIEPHYSR		0x0007f0
> > +#define  PHYRDY			1
> 
> Can we start using the BIT() macro in this driver?

I see this is handled by

[PATCH V3] PCI: rcar: Clean up the macros

> 
> >  #define PCIEMSITXR		0x000840
> >  
> >  /* Transfer control */
> > @@ -527,6 +529,20 @@ static void phy_write_reg(struct rcar_pc
> >  	phy_wait_for_ack(pcie);
> >  }
> >  
> > +static int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
> > +{
> > +	unsigned int timeout = 10;
> > +
> > +	while (timeout--) {
> > +		if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
> > +			return 0;
> > +
> > +		msleep(5);
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> >  static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
> >  {
> >  	unsigned int timeout = 10;
> > @@ -551,6 +567,10 @@ static int rcar_pcie_hw_init(struct rcar
> >  	/* Set mode */
> >  	rcar_pci_write_reg(pcie, 1, PCIEMSR);
> >  
> > +	err = rcar_pcie_wait_for_phyrdy(pcie);
> > +	if (err)
> > +		return err;
> > +
> >  	/*
> >  	 * Initial header for port config space is type 1, set the device
> >  	 * class to match. Hardware takes care of propagating the IDSETR
> > 
> 
