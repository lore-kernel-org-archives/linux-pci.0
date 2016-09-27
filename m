Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:48968 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933012AbcI0MKO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2016 08:10:14 -0400
Date: Tue, 27 Sep 2016 14:10:07 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] pcie-rcar: try setting PCIe speed to 5 GT/s at boot
Message-ID: <20160927121007.GA9498@verge.net.au>
References: <3386780.3qrqUfW7i7@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3386780.3qrqUfW7i7@wasted.cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 22, 2016 at 11:20:18PM +0300, Sergei Shtylyov wrote:
> Initially, the PCIe link speed is set up only  at 2.5 GT/s.
> For better performance,  we're trying to increase link speed to 5 GT/s.
> 
> Based on the original patch by Grigory Kletsko
> <grigory.kletsko@cogentembedded.com>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo.

Minor comment below, that not withstanding.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> Changes in version 2:
> - switched from the interrupt based speed change algorithm to polling with
>   1-second timeout, got rid  of the now unneeded register/bit #define's;
> - made rcar_pcie_force_speedup() *static*;
> - moved the speed capability check to the start of rcar_pcie_force_speedup();
> - adjusted the speed change in-progress check and the error message;
> - read MACSR ony once during the speed change setup;
> - print current link speed after any speed change outcome and when the speed
>   is already 5 GT/s;
> - removed the TODO comment;
> - moved rcar_pcie_force_speedup() call to the start of rcar_pcie_enable();
> - changed the patch authorship, updated the patch description accordingly.
> 
>  drivers/pci/host/pcie-rcar.c |   70 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> Index: pci/drivers/pci/host/pcie-rcar.c
> ===================================================================
> --- pci.orig/drivers/pci/host/pcie-rcar.c
> +++ pci/drivers/pci/host/pcie-rcar.c
> @@ -84,8 +84,19 @@
>  #define IDSETR1			0x011004
>  #define TLCTLR			0x011048
>  #define MACSR			0x011054
> +#define  SPCHG			(1 << 5)
> +#define  SPCHGFIN		(1 << 4)
> +#define  SPCHGSUC		(1 << 7)
> +#define  SPCHGFAIL		(1 << 6)
> +#define  LINK_SPEED		(0xf << 16)
> +#define  LINK_SPEED_2_5GTS	(1 << 16)
> +#define  LINK_SPEED_5_0GTS	(2 << 16)
>  #define MACCTLR			0x011058
> +#define  SPEED_CHANGE		(1 << 24)
>  #define  SCRAMBLE_DISABLE	(1 << 27)
> +#define MACS2R			0x011078
> +#define MACCGSPSETR		0x011084
> +#define  SPCNGRSN		(1 << 31)
>  
>  /* R-Car H1 PHY */
>  #define H1_PCIEPHYADRR		0x04000c
> @@ -385,11 +396,70 @@ static int rcar_pcie_setup(struct list_h
>  	return 1;
>  }
>  
> +static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
> +{
> +	unsigned int timeout = 1000;
> +	u32 macsr;
> +
> +	if ((rcar_pci_read_reg(pcie, MACS2R) & LINK_SPEED) != LINK_SPEED_5_0GTS)
> +		return;
> +
> +	dev_info(pcie->dev, "Trying speed up to 5 GT/s\n");

The above is a little too noisy for my taste.

> +
> +	if (rcar_pci_read_reg(pcie, MACCTLR) & SPEED_CHANGE) {
> +		dev_err(pcie->dev, "Speed change is in progress\n");
> +		return;
> +	}
> +
> +	macsr = rcar_pci_read_reg(pcie, MACSR);
> +	if ((macsr & LINK_SPEED) == LINK_SPEED_5_0GTS)
> +		goto done;
> +
> +	/* Set target link speed to 5.0 GT/s */
> +	rcar_rmw32(pcie, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
> +		   PCI_EXP_LNKSTA_CLS_5_0GB);
> +
> +	/* Set speed change reason as intentional factor */
> +	rcar_rmw32(pcie, MACCGSPSETR, SPCNGRSN, 0);
> +
> +	/* Clear SPCHGFIN, SPCHGSUC, and SPCHGFAIL */
> +	if (macsr & (SPCHGFIN | SPCHGSUC | SPCHGFAIL))
> +		rcar_pci_write_reg(pcie, macsr, MACSR);
> +
> +	/* Start link speed change */
> +	rcar_rmw32(pcie, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
> +
> +	while (timeout--) {
> +		macsr = rcar_pci_read_reg(pcie, MACSR);
> +		if (macsr & SPCHGFIN) {
> +			/* Clear the interrupt bits */
> +			rcar_pci_write_reg(pcie, macsr, MACSR);
> +
> +			if (macsr & SPCHGFAIL)
> +				dev_err(pcie->dev, "Speed change failed\n");
> +
> +			goto done;
> +		}
> +
> +		msleep(1);
> +	};
> +
> +	dev_err(pcie->dev, "Speed change timed out\n");
> +
> +done:
> +	/* Check speed */
> +	dev_info(pcie->dev, "Current link speed is %s GT/s\n",
> +		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
> +}
> +
>  static int rcar_pcie_enable(struct rcar_pcie *pcie)
>  {
>  	struct pci_bus *bus, *child;
>  	LIST_HEAD(res);
>  
> +	/* Try setting 5 GT/s link speed */
> +	rcar_pcie_force_speedup(pcie);
> +
>  	rcar_pcie_setup(&res, pcie);
>  
>  	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
> 
