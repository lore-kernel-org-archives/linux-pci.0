Return-Path: <SRS0=PqzH=5S=ginzinger.com=Stefan.Schoefegger@kernel.org>
Return-Path: <SRS0=PqzH=5S=ginzinger.com=Stefan.Schoefegger@kernel.org>
From: =?iso-8859-1?Q?Sch=F6fegger_Stefan?= <Stefan.Schoefegger@ginzinger.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, open list
	<linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
	Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 1/1] PCI: imx6: Add pcie compliance test option
Date: Tue, 13 Jun 2017 05:55:09 +0000
Message-ID: <1782110.RW4F1b4ZIY@en-pc05>
References: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
 <20170612234924.GE4379@bhelgaas-glaptop.roam.corp.google.com>
 <AM5PR0402MB285053130F4B1FCBF67C31998CC20@AM5PR0402MB2850.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0402MB285053130F4B1FCBF67C31998CC20@AM5PR0402MB2850.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, June 13, 2017 2:00:16 AM CEST Richard Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Tuesday, June 13, 2017 7:49 AM
> > To: Stefan Schoefegger <stefan.schoefegger@ginzinger.com>
> > Cc: linux-pci@vger.kernel.org; Richard Zhu <hongxing.zhu@nxp.com>; Arnd
> > Bergmann <arnd@arndb.de>; open list <linux-kernel@vger.kernel.org>;
> > Kishon Vijay Abraham I <kishon@ti.com>; Jingoo Han
> > <jingoohan1@gmail.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > moderated list:PCI DRIVER FOR IMX6 <linux-arm-kernel@lists.infradead.or=
g>;
> > Lucas Stach <l.stach@pengutronix.de>
> > Subject: Re: [PATCH v2 1/1] PCI: imx6: Add pcie compliance test option
> >=20
> > On Wed, Jun 07, 2017 at 01:36:11PM +0200, Stefan Schoefegger wrote:
> > > Link speed must not be limited to gen1 during link test for complianc=
e
> > > tests
> > >=20
> > > Signed-off-by: Stefan Schoefegger <stefan.schoefegger@ginzinger.com>
> > > ---
> > >=20
> > > Changes since v1:
> > >  - pci-imx6.c moved to dwc directory
> > > =20
> > >  drivers/pci/dwc/Kconfig    | 10 ++++++++++
> > >  drivers/pci/dwc/pci-imx6.c | 21 ++++++++++++---------
> > >  2 files changed, 22 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig index
> > > b7e15526d676..b6e9ced5a45d 100644
> > > --- a/drivers/pci/dwc/Kconfig
> > > +++ b/drivers/pci/dwc/Kconfig
> > > @@ -77,6 +77,16 @@ config PCI_IMX6
> > >=20
> > >  	select PCIEPORTBUS
> > >  	select PCIE_DW_HOST
> > >=20
> > > +config PCI_IMX6_COMPLIANCE_TEST
> > > +	bool "Enable pcie compliance tests on imx6"
> > > +	depends on PCI_IMX6
> > > +	default n
> > > +	help
> > > +	  Enables support for pcie compliance test on FSL iMX SoCs.
> > > +	  The link speed wouldn't be limited to gen1 when enabled.
> > > +	  Enable only during compliance tests, otherwise
> > > +	  link detection will fail on some peripherals.
> >=20
> > I'm puzzled about why we would want to merge this patch.  It looks like
> > we're trying to game the system to make the device pass compliance test=
ing
> > when it isn't really compliant.  Is this config option useful to users,=
 or
> > is it only useful during internal development of iMX SoCs?
>=20
> [Zhu hongxing] Agree with Bjorn. These modifications shouldn't be merged.
> They are used for the boards used to pass the PCIe RC certification, when
> one Standalone external OSC is used as PCIe reference clock source in the
> boards design.
Yes, passing gen2 compliance test is only possible with external clk. But t=
his=20
is a errata of imx6 pci phy of PCIe clk jitter. Why should we not be able t=
o=20
do gen2 tests? I think it is useful to do other gen2 tests (signal integrit=
y)=20
during board design.
> > >  config PCIE_SPEAR13XX
> > > =20
> > >  	bool "STMicroelectronics SPEAr PCIe controller"
> > >  	depends on PCI
> > >=20
> > > diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> > > index 19a289b8cc94..b0fbe52e25b0 100644
> > > --- a/drivers/pci/dwc/pci-imx6.c
> > > +++ b/drivers/pci/dwc/pci-imx6.c
> > > @@ -533,15 +533,18 @@ static int imx6_pcie_establish_link(struct
> >=20
> > imx6_pcie *imx6_pcie)
> >=20
> > >  	u32 tmp;
> > >  	int ret;
> > >=20
> > > -	/*
> > > -	 * Force Gen1 operation when starting the link.  In case the link i=
s
> > > -	 * started in Gen2 mode, there is a possibility the devices on the
> > > -	 * bus will not be detected at all.  This happens with PCIe switche=
s.
> > > -	 */
> > > -	tmp =3D dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
> > > -	tmp &=3D ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> > > -	tmp |=3D PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> > > -	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
> > > +	if (!IS_ENABLED(CONFIG_PCI_IMX6_COMPLIANCE_TEST)) {
> > > +		/*
> > > +		 * Force Gen1 operation when starting the link.  In case the
> > > +		 * link is started in Gen2 mode, there is a possibility the
> > > +		 * devices on the bus will not be detected at all.  This
> > > +		 * happens with PCIe switches.
> > > +		 */
> > > +		tmp =3D dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
> > > +		tmp &=3D ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> > > +		tmp |=3D PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> > > +		dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
> > > +	}
> > >=20
> > >  	/* Start LTSSM. */
> > >  	if (imx6_pcie->variant =3D=3D IMX7D)
> > >=20
> > > --
> > > 2.11.0
> > >=20
> > >=20
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
