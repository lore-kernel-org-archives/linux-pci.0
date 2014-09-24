Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37967 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbaIXJqI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 05:46:08 -0400
Message-ID: <1411551962.2735.2.camel@pengutronix.de>
Subject: Re: [PATCH v2 5/5] PCI: imx6: add imx6sx pcie support
From: Lucas Stach <l.stach@pengutronix.de>
To: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
Cc: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>
Date: Wed, 24 Sep 2014 11:46:02 +0200
In-Reply-To: <6300241fd29146f78a46c40e2232c8aa@BY1PR0301MB0855.namprd03.prod.outlook.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	 <1411445498-20250-6-git-send-email-r65037@freescale.com>
	 <1411470006.3256.13.camel@pengutronix.de>
	 <6300241fd29146f78a46c40e2232c8aa@BY1PR0301MB0855.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 24.09.2014, 07:09 +0000 schrieb
Hong-Xing.Zhu@freescale.com:

[...]

> > > +	if (is_imx6sx_pcie(imx6_pcie)) {
> > > +		/* Force PCIe PHY reset */
> > > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> > > +				IMX6SX_GPR5_PCIE_BTNRST,
> > > +				IMX6SX_GPR5_PCIE_BTNRST);
> > > +
> > > +		regmap_update_bits(imx6_pcie->gpc_ips_reg, 0, 1 << 7, 1 << 7);
> > 
> > Magic values here. Also this is the only time we need to access gpc_ips_reg.
> > So if this is a prerequisite to enabling the ANATOP regulator, I would argue
> > it should be done in the regulator driver.
> [Richard]Magic values would be replaced.
> Yes, this is the only time we need to access gpc_ips_reg.
> It's a little complex to add the GPC manipulations in
>  ANATOP/regulator framework/driver codes.
> Since ANATOP regulator is common framework and driver, it's hard to manipulate
> GPC bits in ANATOP/regulator driver.
> In order to be easier, I add the GPC bits manipulation here directly.
> How do you think about that?

I still think it would be better to handle this in the regulator driver.
But as I don't yet have a reference manual for the imx6sx: can you
please describe what this bit does exactly? Maybe this helps me to
understand where the call should be placed.


> > 
> > > +		/* Power up PCIe PHY, ANATOP_REG_CORE offset 0x140, bit13-9 */
> > 
> > Oh so this is actually a PHY regulator, not feeding the whole core, but just
> > the PHY? You could remove the comment it is clear what you are doing from the
> > code and the offsets are of no interest in the PCIe driver.
> [Richard] yes, it is a PHY regulator, not used to feed the whole core.

Ok, so I expect this to be called "pcie-phy-supply" in the binding.

> > 
> > > +		regulator_set_voltage(imx6_pcie->pcie_regulator,
> > > +				1100000, 1100000);
> > > +		ret = regulator_enable(imx6_pcie->pcie_regulator);
> > > +		if (ret)
> > > +			dev_info(pp->dev, "failed to enable pcie regulator.\n");
> > > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > +				IMX6SX_GPR12_RX_EQ_MASK, IMX6SX_GPR12_RX_EQ_2);
> > > +	}
> > >
> > >  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > -			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> > > +			IMX6Q_GPR12_PCIE_CTL_2,
> > > +			IMX6Q_GPR12_PCIE_CTL_2_CLR);
> > >
> > >  	/* configure constant input signal to the pcie ctrl and phy */
> > >  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > >  			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
> > >  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > -			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
> > > +			IMX6Q_GPR12_LOS_LEVEL, IMX6Q_GPR12_LOS_LEVEL_9);
> > >
> > >  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> > >  			IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0); @@ -370,7 +435,8 @@ static

[...]

> > > +static void pci_imx_resume(void)
> > > +{
> > > +	struct pcie_port *pp = &imx6_pcie->pp;
> > > +
> > > +	if (is_imx6sx_pcie(imx6_pcie)) {
> > > +		/* reset iMX6SX PCIe */
> > > +		regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > > +				IOMUXC_GPR5, BIT(18), 1 << 18);
> > > +
> > > +		regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > > +				IOMUXC_GPR5, BIT(18), 0 << 18);
> > > +
> > 
> > Again magic numbers here. Please add defines for those.
> [Richard] Ok.
> > 
> > > +		/*
> > > +		 * controller maybe turn off, re-configure again
> > > +		 * Set the CLASS_REV of RC CFG header to
> > > +		 * PCI_CLASS_BRIDGE_PCI
> > > +		 */
> > > +		writel(readl(pp->dbi_base + PCI_CLASS_REVISION)
> > > +			| (PCI_CLASS_BRIDGE_PCI << 16),
> > > +			pp->dbi_base + PCI_CLASS_REVISION);
> > > +
> > 
> > Can't we just move the call to set this from dw_pcie_host_init() to
> > dw_pcie_setup_rc() so we don't need to do this ourselves? It seems to be the
> > more logical change.
> [Richard]dw_pcie_host_init contains the whole re-initialization and re-link-up
>  again of the pcie module. It's not proper to re-call dw_pcie_host_init().
> I find that the msi init should be re-configured again after resume back.
> So, the definitions of the "PCIE_MSI_ADDR_LO" and "PCIE_MSI_ADDR_HI" would be used
> here.
> 

I seems you misunderstood my comment here. I'm not saying we should call
dw_pcie_host_init() here, which would be clearly wrong.

What I'm saying is that the call to set up the CLASS_REV register is
currently done in dw_pcie_host_init(), but from a quick look at the code
I think it is safe to move this call to dw_pcie_setup_rc().
If you move it to this function there would no need to do it explicitly
from this resume hook again.

> BTW, do you know why the "/* Synopsis specific PCIE configuration registers */"
> is not defined in pcie-designware.h, but in pcie-designware.c?
> 

Most probably because the setup for the DW PCIe core should be handled
through pcie-designware.c and not through the individual SoC drivers.

> > 
> > > +		dw_pcie_setup_rc(pp);
> > > +	}
> > > +}
> > > +
> > > +static struct syscore_ops pci_imx_syscore_ops = {
> > > +	.suspend = pci_imx_suspend,
> > > +	.resume = pci_imx_resume,
> > > +};
> > > +#endif
> > > +
> > 
> > Why does this need to be syscore_ops instead of dev_pm_ops?
> [Richard] PM_TURN_OFF msg should be sent out at the end of the suspend of pcie subsystem.
> Resume and re-configure of rc controller should be done before the resume of pcie subsystem.
> So, syscore_ops is used here.

Ok, makes sense.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

