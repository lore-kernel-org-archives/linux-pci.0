Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48762 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbaHOJ7g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Aug 2014 05:59:36 -0400
Message-ID: <1408096649.5850.13.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx6: fix boot hang when link already enabled
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Shawn Guo <Shawn.Guo@freescale.com>, kernel@pengutronix.de
Date: Fri, 15 Aug 2014 11:57:29 +0200
In-Reply-To: <20140814202248.GA2071@google.com>
References: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
	 <1406830565-23450-3-git-send-email-l.stach@pengutronix.de>
	 <20140814202248.GA2071@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 14.08.2014, 14:22 -0600 schrieb Bjorn Helgaas:
> On Thu, Jul 31, 2014 at 08:16:05PM +0200, Lucas Stach wrote:
> > This fixes a boot hang observed when the bootloader
> > already enabled the PCIe link for it's own use. The
> > fundamental problem is that Freescale forgot to wire
> > up the core reset, so software doesn't have a sane way
> > to get the core into a defined state.
> > 
> > According to the DW PCIe core reference manual configuration
> > of the core may only happen when the LTSSM is disabled, so
> > this is one of the first things we need to do. Apparently
> > this isn't safe to do when the LTSSM is in any other state
> > than "detect" as we observe an instant machine hang when
> > trying to do so while the link is already up.
> > 
> > As a workaround force LTSSM into detect state right before
> > hitting the disable switch.
> 
> I don't know anything about this hardware, but from the description, this
> sounds racy.  As I understand it, LTSSM is a hardware-managed state
> machine.  What prevents the hardware from transitioning out of the "Detect"
> state after you force it into "Detect" but before you hit the disable
> switch?
> 
There is indeed a small race window here, but I don't see how we could
avoid it. Getting the core back into a sane state without a proper
hardware reset isn't an easy task. Initially I thought the LinkDisable
bit in the Link Control Register might do the trick, but this also shows
lockups. I'm still investigating if we can make this more safe.

But for the time being I would rather accept this small race window in
this workaround than hanging the machine every time someone enabled the
PCIe link before jumping into the kernel.
 
> > Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v2: - messed up the first submission by omitting a chunk
> > v3: - check if bootloader actually enabled link before
> >       touching any core registers
> >     - add a comment to explain things a bit
> >     - add shutdown hook to clean state on reboot
> > 
> > Fabios delay workaround worked because of the following
> > conditions:
> > 1. The driver gets probed and pulls the peripheral reset GPIO
> > 2. Peripheral is held in reset, so won't answer any link
> > negotiation requests
> > 3. The LTSSM times out and falls back into detect state
> > after 24ms (that's why a 30ms delay helps)
> > 4. After LTSSM entered detect state it's safe to hit the
> > disable switch
> > ---
> >  drivers/pci/host/pci-imx6.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index a568efaa331c..1be607360988 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -49,6 +49,9 @@ struct imx6_pcie {
> >  
> >  /* PCIe Port Logic registers (memory-mapped) */
> >  #define PL_OFFSET 0x700
> > +#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
> > +#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
> > +#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
> >  #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
> >  #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
> >  #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
> > @@ -214,6 +217,31 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
> >  static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
> >  {
> >  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> > +	u32 val, gpr1, gpr12;
> > +
> > +	/*
> > +	 * If the bootloader already enabled the link we need some special
> > +	 * handling to get the core back into a state where it is safe to
> > +	 * touch it for configuration. As there is no dedicated reset signal
> > +	 * wired up for MX6QDL, we need to manually force LTSSM into "detect"
> > +	 * state before completely disabling LTSSM, which is a prerequisite
> > +	 * for core configuration.
> > +	 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
> > +	 * indication that the bootloader activated the link.
> > +	 */
> > +	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> > +	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> > +
> > +	if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> > +	    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> > +		val = readl(pp->dbi_base + PCIE_PL_PFLR);
> > +		val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> > +		val |= PCIE_PL_PFLR_FORCE_LINK;
> > +		writel(val, pp->dbi_base + PCIE_PL_PFLR);
> > +
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> > +	}
> >  
> >  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> >  			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> > @@ -589,6 +617,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static void imx6_pcie_shutdown(struct platform_device *pdev)
> > +{
> > +	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
> > +
> > +	/* bring down link, so bootloader gets clean state in case of reboot */
> > +	imx6_pcie_assert_core_reset(&imx6_pcie->pp);
> > +}
> > +
> >  static const struct of_device_id imx6_pcie_of_match[] = {
> >  	{ .compatible = "fsl,imx6q-pcie", },
> >  	{},
> > @@ -601,6 +637,7 @@ static struct platform_driver imx6_pcie_driver = {
> >  		.owner	= THIS_MODULE,
> >  		.of_match_table = imx6_pcie_of_match,
> >  	},
> > +	.shutdown = imx6_pcie_shutdown,
> >  };
> >  
> >  /* Freescale PCIe driver does not allow module unload */
> > -- 
> > 2.0.1
> > 

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

