Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42513 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaHKI0Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Aug 2014 04:26:16 -0400
Message-ID: <1407745453.4660.7.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx6: fix boot hang when link already enabled
From: Lucas Stach <l.stach@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <Shawn.Guo@freescale.com>,
	Sascha Hauer <kernel@pengutronix.de>
Date: Mon, 11 Aug 2014 10:24:13 +0200
In-Reply-To: <CAJ+vNU0vT2Fot6V=pn7HKDctNHrWMDiudghVTtAojv8mPDXhBw@mail.gmail.com>
References: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
	 <1406830565-23450-3-git-send-email-l.stach@pengutronix.de>
	 <CAJ+vNU0vT2Fot6V=pn7HKDctNHrWMDiudghVTtAojv8mPDXhBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim,

Am Samstag, den 09.08.2014, 10:49 -0700 schrieb Tim Harvey:
[...]

> i/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index a568efaa331c..1be607360988 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -49,6 +49,9 @@ struct imx6_pcie {
> >
> >  /* PCIe Port Logic registers (memory-mapped) */
> >  #define PL_OFFSET 0x700
> > +#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
> > +#define PCIE_PL_PFLR_LINK_STATE_MASK           (0x3f << 16)
> > +#define PCIE_PL_PFLR_FORCE_LINK                        (1 << 15)
> >  #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
> >  #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
> >  #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING        (1 << 29)
> > @@ -214,6 +217,31 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
> >  static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
> >  {
> >         struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> > +       u32 val, gpr1, gpr12;
> > +
> > +       /*
> > +        * If the bootloader already enabled the link we need some special
> > +        * handling to get the core back into a state where it is safe to
> > +        * touch it for configuration. As there is no dedicated reset signal
> > +        * wired up for MX6QDL, we need to manually force LTSSM into "detect"
> > +        * state before completely disabling LTSSM, which is a prerequisite
> > +        * for core configuration.
> > +        * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
> > +        * indication that the bootloader activated the link.
> > +        */
> > +       regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> > +       regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> > +
> > +       if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> > +           (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> > +               val = readl(pp->dbi_base + PCIE_PL_PFLR);
> > +               val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> > +               val |= PCIE_PL_PFLR_FORCE_LINK;
> > +               writel(val, pp->dbi_base + PCIE_PL_PFLR);
> 
> Lucas,
> 
> I hate to delay this patch any longer as I believe its critical that
> this gets in the current kernel. I did however encounter an issue when
> I backported this to another (older 3.10 kernel I use). The access
> above to dbi_base to force the link down assumes that PCIe clock is
> enabled (or it will hang the system). This obviously must be the case
> for the current kernel (the bootloader enables it and I guess the
> clock setup for imx6 doesn't disturb it), but on the particular kernel
> I was backporting to there must be enough differences in the clock
> tree that the clock setup disabled the PCIe clocks. Thus I had to
> enable them early, right before the access to dbi_base above in that
> kernel.
> 
> I wonder if we should at least put a comment before the dbi_base
> access above about the assumption that the bootloader also enabled
> PCIe clock and the clock config left it as such so we don't get burned
> later on if the clock config changes and causes a hang here.
> 

What clock are we talking about here exactly? If it's just the register
clock "pcie" we may as well enable it early to make things robust. Other
clocks may be a bit more problematic.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

