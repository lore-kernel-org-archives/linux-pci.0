Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43799 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbaIHSaS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Sep 2014 14:30:18 -0400
Message-ID: <1410200876.3945.2.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: fix occasional link failure
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tim Harvey <tharvey@gateworks.com>,
	Fabio Estevam <festevam@gmail.com>, shawn.guo@freescale.com,
	marex@denx.de, linux-pci@vger.kernel.org
Date: Mon, 08 Sep 2014 20:27:56 +0200
In-Reply-To: <20140905173216.GB8080@google.com>
References: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
	 <1409717077-26662-1-git-send-email-tharvey@gateworks.com>
	 <20140905173216.GB8080@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 05.09.2014, 11:32 -0600 schrieb Bjorn Helgaas:
> On Tue, Sep 02, 2014 at 09:04:37PM -0700, Tim Harvey wrote:
> > According to the IMX6 reference manuals, REF_SSP_EN (Reference clock enable
> > for SS function) must remain deasserted until the reference clock is running
> > at the appropriate frequency.
> > 
> > Without this patch we find a high link failure rate (>5%) on certain
> > IMX6 boards at various temperatures.
> > 
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Tested-by: Fabio Estevam <festevam@gmail.com>
> > Acked-by: Marek Vasut <marex@denx.de>
> 
> I'm looking for the comment update requested by Richard, and an ack from
> Richard and/or Lucas.  Also, please add the stable tag if you want it
> (see Documentation/stable_kernel_rules.txt for details).
> 
We already have a comment some line above regarding clock stabilization,
so I don't think another one is strictly needed. Especially as this
initialization order is clearly defined by the reference manual.

So with or without the comment added:
Acked-by: Lucas Stach <l.stach@pengutronix.de>

> Bjorn
> 
> > ---
> > 
> > v2:
> >  - added Tested-by Fabio Estevam
> >  - added Acked-by Marek Vasut
> > 
> > ---
> >  drivers/pci/host/pci-imx6.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index 1be6073..9b6bab9 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -256,11 +256,6 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
> >  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> >  	int ret;
> >  
> > -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> > -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> > -
> >  	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> >  	if (ret) {
> >  		dev_err(pp->dev, "unable to enable pcie_phy clock\n");
> > @@ -282,6 +277,12 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
> >  	/* allow the clocks to stabilize */
> >  	usleep_range(200, 500);
> >  
> > +	/* power up core phy and enable ref clock */
> > +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > +			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> > +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > +			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> > +
> >  	/* Some boards don't have PCIe reset GPIO. */
> >  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> >  		gpio_set_value(imx6_pcie->reset_gpio, 0);
> > -- 
> > 1.8.3.2
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

