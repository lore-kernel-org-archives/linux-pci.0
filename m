Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44050 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaGVHtP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jul 2014 03:49:15 -0400
Message-ID: <1406015239.4667.5.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v2] PCI: imx6: fix boot hang when link already enabled
From: Lucas Stach <l.stach@pengutronix.de>
To: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>,
	Shawn Guo <Shawn.Guo@freescale.com>,
	Marek Vasut <marex@denx.de>,
	"d.mueller@elsoft.ch" <d.mueller@elsoft.ch>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Date: Tue, 22 Jul 2014 09:47:19 +0200
In-Reply-To: <1d83254966df448ea71a08830ad00713@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1405966635-7455-1-git-send-email-l.stach@pengutronix.de>
	 <1d83254966df448ea71a08830ad00713@DM2PR0301MB0862.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

Am Dienstag, den 22.07.2014, 07:24 +0000 schrieb
Hong-Xing.Zhu@freescale.com:
> Hi Lucas:
> Thanks for your help on this case firstly.
> See my comments marked by Richard below.
> Best Regards
> Richard Zhu
> 
> 
> > -----Original Message-----
> > From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> > On Behalf Of Lucas Stach
> > Sent: Tuesday, July 22, 2014 2:17 AM
> > To: bhelgaas@google.com
> > Cc: linux-pci@vger.kernel.org; Estevam Fabio-R49496; Guo Shawn-R65073; Marek
> > Vasut; d.mueller@elsoft.ch; Zhu Richard-R65037; tharvey@gateworks.com;
> > kernel@pengutronix.de; linux-arm-kernel@lists.infradead.org
> > Subject: [PATCH v2] PCI: imx6: fix boot hang when link already enabled
> > 
> > This fixes a boot hang observed when the bootloader already enabled the PCIe
> > link for it's own use. The fundamental problem is that Freescale forgot to
> > wire up the core reset, so software doesn't have a sane way to get the core
> > into a defined state.
> > 
> > According to the DW PCIe core reference manual configuration of the core may
> > only happen when the LTSSM is disabled, so this is one of the first things we
> > need to do. Apparently this isn't safe to do when the LTSSM is in any other
> > state than "detect" as we observe an instant machine hang when trying to do so
> > while the link is already up.
> > 
> > As a workaround force LTSSM into detect state right before hitting the disable
> > switch.
> > 
> > Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > v2: messed up the first submission by omitting a chunk
> > 
> > Fabios delay workaround worked because of the following
> > conditions:
> > 1. The driver gets probed and pulls the peripheral reset GPIO 2. Peripheral is
> > held in reset, so won't answer any link negotiation requests 3. The LTSSM
> > times out and falls back into detect state after 24ms (that's why a 30ms delay
> > helps) 4. After LTSSM entered detect state it's safe to hit the disable switch
> > ---
> >  drivers/pci/host/pci-imx6.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c index
> > a568efaa331c..1c4b4b81fe15 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -49,6 +49,9 @@ struct imx6_pcie {
> > 
> >  /* PCIe Port Logic registers (memory-mapped) */  #define PL_OFFSET 0x700
> > +#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
> > +#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
> > +#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
> >  #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)  #define PCIE_PHY_DEBUG_R1
> > (PL_OFFSET + 0x2c)
> >  #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
> > @@ -214,7 +217,15 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
> > static int imx6_pcie_assert_core_reset(struct pcie_port *pp)  {
> >  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> > +	u32 val;
> > +
> > +	val = readl(pp->dbi_base + PCIE_PL_PFLR);
> > +	val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> > +	val |= PCIE_PL_PFLR_FORCE_LINK;
> > +	writel(val, pp->dbi_base + PCIE_PL_PFLR);
> [Richard] At this point, the port logic register access are relied on the
> pcie clks enable in uboot. Otherwise, kernel would be hang, if the pcie is not enabled
> in uboot ever.

You are right, I'll fix this to check if the LTSSEM and REF_SSP are
enabled in the IOMUX GPR registers. This should give a good indication
whether the bootloader enabled PCIe or not.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

