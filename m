Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753970AbcINUyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 16:54:36 -0400
Date: Wed, 14 Sep 2016 15:54:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pcie-rcar: try setting PCIe speed to 5 GT/s at boot
Message-ID: <20160914205431.GC13189@localhost>
References: <6896977.DKiraAXap6@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6896977.DKiraAXap6@wasted.cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 07, 2016 at 11:22:14PM +0300, Sergei Shtylyov wrote:
> From: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
> 
> Initially, the PCIe link speed is set up only at 2.5 GT/s.
> For better performance,  we're trying to increase link speed to 5 GT/s.
> 
> [Sergei Shtylyov: indented the macro definitions with tabs, renamed the
> SPCHG register bits for consistency, renamed the link speed field/values,
> fixed too long lines, fixed redundancy in clearing the MACSR register bits,
> fixed grammar/typos in  the comments/messages, removed unrelated/useless
> changes, fixed bugs in rcar_rwm32() calls done to set the bits, removed
> unneeded braces, removed non-informative comment, reworded the patch
> summary/description.]
> 
> Signed-off-by: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo.
> 
>  drivers/pci/host/pcie-rcar.c |  103 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> Index: pci/drivers/pci/host/pcie-rcar.c
> ===================================================================
> --- pci.orig/drivers/pci/host/pcie-rcar.c
> +++ pci/drivers/pci/host/pcie-rcar.c
> @@ -48,6 +48,10 @@
>  #define  CFINIT			1
>  #define PCIETSTR		0x02004
>  #define  DATA_LINK_ACTIVE	1
> +#define PCIEINTR		0x02008
> +#define  PCIEINTMAC		(1 << 13)
> +#define PCIEINTER		0x0200C
> +#define  PCIEINTMACE		(1 << 13)
>  #define PCIEERRFR		0x02020
>  #define  UNSUPPORTED_REQUEST	(1 << 4)
>  #define PCIEMSIFR		0x02044
> @@ -84,8 +88,21 @@
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
> +#define MACINTENR		0x01106C
> +#define  SPCHGFINE		(1 << 4)
> +#define MACS2R			0x011078
> +#define MACCGSPSETR		0x011084
> +#define  SPCNGRSN		(1 << 31)
>  
>  /* R-Car H1 PHY */
>  #define H1_PCIEPHYADRR		0x04000c
> @@ -385,6 +402,51 @@ static int rcar_pcie_setup(struct list_h
>  	return 1;
>  }
>  
> +void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
> +{
> +	u32 macsr;
> +
> +	dev_info(pcie->dev, "Trying speed up to 5 GT/s\n");
> +
> +	if ((rcar_pci_read_reg(pcie, MACSR) & SPCHGFIN) ||
> +	    (rcar_pci_read_reg(pcie, MACCTLR) & SPEED_CHANGE)) {
> +		dev_err(pcie->dev, "Speed changing is in progress\n");

Are these messages all really errors?

> +		return;
> +	}
> +
> +	if ((rcar_pci_read_reg(pcie, MACSR) & LINK_SPEED) ==
> +	    LINK_SPEED_5_0GTS) {
> +		dev_err(pcie->dev, "Current link speed is already 5 GT/s\n");
> +		return;
> +	}
> +
> +	if ((rcar_pci_read_reg(pcie, MACS2R) & LINK_SPEED) !=
> +	    LINK_SPEED_5_0GTS) {
> +		dev_err(pcie->dev,
> +			"Current max support link speed not 5 GT/s\n");
> +		return;
> +	}
> +
> +	/* Set target link speed to 5.0 GT/s */
> +	rcar_rmw32(pcie, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
> +		   PCI_EXP_LNKSTA_CLS_5_0GB);
> +
> +	/* Set speed change reason as intentional factor */
> +	rcar_rmw32(pcie, MACCGSPSETR, SPCNGRSN, 0);
> +
> +	/* Clear SPCHGFIN, SPCHGSUC, and SPCHGFAIL */
> +	macsr = rcar_pci_read_reg(pcie, MACSR);
> +	if (macsr & (SPCHGFIN | SPCHGSUC | SPCHGFAIL))
> +		rcar_pci_write_reg(pcie, macsr, MACSR);
> +
> +	/* Enable interrupt */
> +	rcar_rmw32(pcie, MACINTENR, SPCHGFINE, SPCHGFINE);
> +	rcar_rmw32(pcie, PCIEINTER, PCIEINTMACE, PCIEINTMACE);
> +
> +	/* Start link speed change */
> +	rcar_rmw32(pcie, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
> +}
> +
>  static int rcar_pcie_enable(struct rcar_pcie *pcie)
>  {
>  	struct pci_bus *bus, *child;
> @@ -416,6 +478,9 @@ static int rcar_pcie_enable(struct rcar_
>  
>  	pci_bus_add_devices(bus);
>  
> +	/* Try setting 5 GT/s link speed */
> +	rcar_pcie_force_speedup(pcie);

I assume it's safe to change the link speed even while the downstream
devices are in use?  As soon as we call pci_bus_add_devices(), drivers
can claim the devices and start using them.

>  	return 0;
>  }
>  
> @@ -621,6 +686,44 @@ static irqreturn_t rcar_pcie_msi_irq(int
>  	struct rcar_msi *msi = &pcie->msi;
>  	unsigned long reg;
>  
> +	if (rcar_pci_read_reg(pcie, PCIEINTR) & PCIEINTMAC) {
> +		dev_dbg(pcie->dev, "MAC interrupt received\n");

I guess you don't need to write PCIEINTR or any other register to
acknowledge the interrupt?

> +
> +		rcar_rmw32(pcie, MACSR, SPCHGFIN, SPCHGFIN);
> +
> +		/* Disable this interrupt */
> +		rcar_rmw32(pcie, MACINTENR, SPCHGFINE, 0);
> +		rcar_rmw32(pcie, PCIEINTER, PCIEINTMACE, 0);
> +
> +		if (rcar_pci_read_reg(pcie, MACSR) & SPCHGFAIL) {
> +			dev_err(pcie->dev, "Speed change failed\n");
> +
> +			rcar_rmw32(pcie, MACSR, SPCHGFAIL, SPCHGFAIL);
> +			/*
> +			 * TODO: if speed change failed we need to enable
> +			 * "L0 enter" interrupt and set "speed change disabled"
> +			 * state. After L0 interrupt rising, we must clear it,
> +			 * wait for 200 ms and set "speed change enabled" state
> +			 * according to the R-Car Series, 2nd Generation User's
> +			 * Manual, section 50.3.9.
> +			 */
> +			return IRQ_HANDLED;
> +		}
> +
> +		if (rcar_pci_read_reg(pcie, MACSR) & SPCHGSUC)
> +			rcar_rmw32(pcie, MACSR, SPCHGSUC, SPCHGSUC);
> +
> +		/* Check speed */
> +		if ((rcar_pci_read_reg(pcie, MACSR) & LINK_SPEED) ==
> +		    LINK_SPEED_5_0GTS)
> +			dev_info(pcie->dev, "Current link speed now 5 GT/s\n");
> +		else
> +			dev_info(pcie->dev,
> +				 "Current link speed now 2.5 GT/s\n");
> +
> +		return IRQ_HANDLED;
> +	}
> +
>  	reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
>  
>  	/* MSI & INTx share an interrupt - we only handle MSI here */

Is this patch adding handling for INTx events?  If so, it looks like
this comment is now out of date, and possibly the code should be along
these lines in case both MSI and INTx signal an interrupt
simultaneously:

  irqreturn_t handled = IRQ_NONE;

  reg = rcar_pci_read_reg(pcie, PCIEINTR) & PCIEINTMAC;
  if (reg) {
    handled = IRQ_HANDLED;
    ...
  }

  reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
  while (reg) {
    handled = IRQ_HANDLED;
    ...
  }

  return handled;
