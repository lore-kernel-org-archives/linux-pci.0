Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:57043 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758851AbcAKLmH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jan 2016 06:42:07 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] PCI: rcar: Support runtime PM link state L1
 handling in pcie-rcar
Date: Mon, 11 Jan 2016 11:42:01 +0000
Message-ID: <HK2PR0601MB1393C12999D6E781695297C7F5C90@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
 <1451998831-27705-3-git-send-email-phil.edworthy@renesas.com>
 <20160108213136.GM5354@localhost>
In-Reply-To: <20160108213136.GM5354@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 08 January 2016 21:32, Bjorn Helgaas wrote:
> Hi Phil,
> 
> On Tue, Jan 05, 2016 at 01:00:29PM +0000, Phil Edworthy wrote:
> > The R-Car PCIe host controller does not handle L1 ASPM. Instead, the
> > hardware needs assistance to transition to L1. When the controller
> > has received a PM_ENTER_L1 DLLP, we can't access a card's config regs
> > until we have got it out of L1 link state. The host controller will
> > handle this as long as it has also been transitioned to L1 link state.
> >
> > So, when attempting a config access, check to see if the card has gone
> > into L1, and if so, do the same for the host controller.
> 
> I don't understand what's going on here.
> 
> For one thing, this sounds like a workaround for an R-Car hardware
> defect.  ASPM is supposed to be an autonomous, hardware-based
> mechanism (spec sec 5.10), so software shouldn't need to be involved
> in the transitions.  Bugs are a fact of life, so it's not a problem to
> have workarounds, but if it *is* a hardware erratum, it would help the
> reader to mention that in a comment.
>From what I understand, ASPM L1 support is optional. The R-Car hardware
can support it with some software help.

> Beyond that, I'm confused about how this really does any good.  It
> looks like you'd have this scenario:
> 
>   - downstream device wants to enter L1, so it sends PM_ENTER_L1 DLLP
>     upstream to host controller
> 
>   - host controller can't enter L1 by itself
> 
>   - ... some arbitrary time elapses ...
> 
>   - driver performs config access to downstream device
> 
>   - rcar_pcie_config_access() notices downstream device wants to enter
>     L1, so it helps host controller transition link from L0 to L1
> 
>   - rcar_pcie_config_access() issues config access
> 
>   - config access causes link to transition from L1 to L0
> 
> So it seems like the link would only be in L1 for the tiny amount of
> time between your write of L1_INIT and the actual config access.  I
> must be missing something.
What you say makes complete sense. Either the R-Car should not advertise
L1 support, or the hardware actually enters L1 ok, but doesn't come back
out without this bit of code. I'll ask the HW people what it does.

Thanks
Phil

> > This is based on a patch by Hien Dang <hien.dang.eb@rvc.renesas.com>
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v2:
> >  - Use readl_poll_timeout_atomic when waiting until we are in L1.
> > ---
> >  drivers/pci/host/pcie-rcar.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > index c72c0ae..31ad93a 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> > @@ -83,6 +84,14 @@
> >  #define MACSR			0x011054
> >  #define MACCTLR			0x011058
> >  #define  SCRAMBLE_DISABLE	(1 << 27)
> > +#define PMSR			0x01105c
> > +#define  L1FAEG			(1 << 31)
> > +#define  PM_ENTER_L1RX		(1 << 23)
> > +#define  PMSTATE		(7 << 16)
> > +#define  PMSTATE_L1		(3 << 16)
> > +#define PMCTLR			0x011060
> > +#define  L1_INIT		(1 << 31)
> > +
> >
> >  /* R-Car H1 PHY */
> >  #define H1_PCIEPHYADRR		0x04000c
> > @@ -175,6 +184,8 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
> >  		unsigned int devfn, int where, u32 *data)
> >  {
> >  	int dev, func, reg, index;
> > +	u32 val;
> > +	int err;
> >
> >  	dev = PCI_SLOT(devfn);
> >  	func = PCI_FUNC(devfn);
> > @@ -216,6 +227,26 @@ static int rcar_pcie_config_access(struct rcar_pcie
> *pcie,
> >  	if (pcie->root_bus_nr < 0)
> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> >
> > +	/*
> > +	 * If we are not in L1 link state but have received PM_ENTER_L1 DLLP,
> > +	 * transition to L1 link state. The HW will handle coming out of L1.
> > +	 */
> > +	val = rcar_pci_read_reg(pcie, PMSR);
> > +	if ((val & PM_ENTER_L1RX) && ((val & PMSTATE) != PMSTATE_L1)) {
> > +		rcar_pci_write_reg(pcie, L1_INIT, PMCTLR);
> > +
> > +		/* Wait until we are in L1 */
> > +		err = readl_poll_timeout_atomic(pcie->base + PMSR,
> > +			val, (val & L1FAEG), 5, 1000000);
> > +		if (err) {
> > +			dev_err(pcie->dev, "poll for L1 state timed out\n");
> > +			return PCIBIOS_DEVICE_NOT_FOUND;
> > +		}
> > +
> > +		/* Clear flags indicating link has transitioned to L1 */
> > +		rcar_pci_write_reg(pcie, L1FAEG | PM_ENTER_L1RX, PMSR);
> > +	}
> > +
> >  	/* Clear errors */
> >  	rcar_pci_write_reg(pcie, rcar_pci_read_reg(pcie, PCIEERRFR),
> PCIEERRFR);
> >
> > --
> > 2.5.0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
