Return-Path: <SRS0=sViI=5T=ginzinger.com=Stefan.Schoefegger@kernel.org>
Return-Path: <SRS0=sViI=5T=ginzinger.com=Stefan.Schoefegger@kernel.org>
From: =?iso-8859-1?Q?Sch=F6fegger_Stefan?= <Stefan.Schoefegger@ginzinger.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Richard Zhu
	<hongxing.zhu@nxp.com>, Arnd Bergmann <arnd@arndb.de>, open list
	<linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
	Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 1/1] PCI: imx6: Add pcie compliance test option
Date: Wed, 14 Jun 2017 05:52:58 +0000
Message-ID: <1923573.HjpiSnITgW@en-pc05>
References: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
 <2668097.SlerkO2uVy@en-pc05>
 <20170613135847.GA7128@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170613135847.GA7128@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, June 13, 2017 8:58:47 AM CEST Bjorn Helgaas wrote:
> On Tue, Jun 13, 2017 at 05:43:14AM +0000, Sch=F6fegger Stefan wrote:
> > On Monday, June 12, 2017 6:49:24 PM CEST Bjorn Helgaas wrote:
> > > On Wed, Jun 07, 2017 at 01:36:11PM +0200, Stefan Schoefegger wrote:
> > > > Link speed must not be limited to gen1 during link test for complia=
nce
> > > > tests
> > > >=20
> > > > Signed-off-by: Stefan Schoefegger <stefan.schoefegger@ginzinger.com=
>
> > > > ---
> > > >=20
> > > > Changes since v1:
> > > >  - pci-imx6.c moved to dwc directory
> > > > =20
> > > >  drivers/pci/dwc/Kconfig    | 10 ++++++++++
> > > >  drivers/pci/dwc/pci-imx6.c | 21 ++++++++++++---------
> > > >  2 files changed, 22 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> > > > index b7e15526d676..b6e9ced5a45d 100644
> > > > --- a/drivers/pci/dwc/Kconfig
> > > > +++ b/drivers/pci/dwc/Kconfig
> > > > @@ -77,6 +77,16 @@ config PCI_IMX6
> > > >=20
> > > >  	select PCIEPORTBUS
> > > >  	select PCIE_DW_HOST
> > > >=20
> > > > +config PCI_IMX6_COMPLIANCE_TEST
> > > > +	bool "Enable pcie compliance tests on imx6"
> > > > +	depends on PCI_IMX6
> > > > +	default n
> > > > +	help
> > > > +	  Enables support for pcie compliance test on FSL iMX SoCs.
> > > > +	  The link speed wouldn't be limited to gen1 when enabled.
> > > > +	  Enable only during compliance tests, otherwise
> > > > +	  link detection will fail on some peripherals.
> > >=20
> > > I'm puzzled about why we would want to merge this patch.  It looks
> > > like we're trying to game the system to make the device pass
> > > compliance testing when it isn't really compliant.  Is this config
> > > option useful to users, or is it only useful during internal
> > > development of iMX SoCs?
> >=20
> > It's not for passing compliance tests, it is necessary to do the
> > compliance
> > tests. Without this patch only gen 1 speed is possible to test. Also i.=
mx6
> > is not fully gen2 compliant (withour external clk) we should have the
> > option to do gen2 tests. Switching from gen1 to gen2 is done with a
> > 100MHz (1ms) clk pulse on the receiver. Without this patch link speed i=
s
> > forced to gen1 afterwards.
>=20
> I don't understand the purpose of this yet, so maybe all we need is a
> better description.

This patch enabled compliance tests for pcie gen2 published by pci-sig.=20
(Signal level, signal timing, jitter and rise/fall times on tx lines). Spec=
ial=20
hardware is needed to do this tests (compliance load board, oszilloscope wi=
th=20
about 10GHz bandwith). The pcie phy switches in a complinace test state whe=
re=20
the phy outputs a special test pattern (without having a real link to a=20
device). The bitrate and de-emphasis must be switched. The driver (without=
=20
this patches) does not allow to switch to gen2 because it falls back to gen=
1.=20
It is impossible to generate the gen2 test pattern.
The patch now removes the forced gen1 start to allow generating gen2 test=20
pattern. gen1 / gen2 switch is done through signals generated on the=20
compliance load board (which triggers switching in the phy).
>=20
> "It's not for passing compliance testing, it is necessary to do the
> compliance tests" doesn't make sense to me -- it seems
> self-contradictory.
>=20
> The Kconfig text says "enable only for testing because it makes link
> detection fail."  To me that means this option is not useful for
> users.  We need some justification for why it should be in the
> mainline kernel, where users and distros may enable it.

It use useless for users and distros. Only board designer want this option.=
 If=20
this is not a reason for applying it's ok for me.
>=20
> If you can only support gen2 in certain board configurations, maybe
> you should add a config option that can always be enabled for those
> boards.
>=20
> > Yes it is only useful for board setup, it is comparable to
> > CONFIG_USB_EHSET_TEST_FIXTURE for usb (ok, this is more general and not
> > host specific).
>=20
> USB_EHSET_TEST_FIXTURE (added by 1353aa53851e ("usb: misc: EHSET Test
> Fixture device driver for host compliance")) looks like just another
> driver in the sense that it's always safe to enable it and it doesn't
> hurt anything if you enable it without having the hardware.
>=20
> This patch doesn't seem comparable to USB_EHSET_TEST_FIXTURE because
> this new option apparently breaks link detection in some cases.

This depends on the point of view (Black box vs. white box) :-) Both are fo=
r=20
doing compliance tests on signal level. But I think we don't need to discus=
s=20
this further.
>=20
> > > >  config PCIE_SPEAR13XX
> > > > =20
> > > >  	bool "STMicroelectronics SPEAr PCIe controller"
> > > >  	depends on PCI
> > > >=20
> > > > diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.=
c
> > > > index 19a289b8cc94..b0fbe52e25b0 100644
> > > > --- a/drivers/pci/dwc/pci-imx6.c
> > > > +++ b/drivers/pci/dwc/pci-imx6.c
> > > > @@ -533,15 +533,18 @@ static int imx6_pcie_establish_link(struct
> > > > imx6_pcie
> > > > *imx6_pcie)>
> > > >=20
> > > >  	u32 tmp;
> > > >  	int ret;
> > > >=20
> > > > -	/*
> > > > -	 * Force Gen1 operation when starting the link.  In case the link=
 is
> > > > -	 * started in Gen2 mode, there is a possibility the devices on th=
e
> > > > -	 * bus will not be detected at all.  This happens with PCIe
> > > > switches.
> > > > -	 */
> > > > -	tmp =3D dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
> > > > -	tmp &=3D ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> > > > -	tmp |=3D PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> > > > -	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
> > > > +	if (!IS_ENABLED(CONFIG_PCI_IMX6_COMPLIANCE_TEST)) {
> > > > +		/*
> > > > +		 * Force Gen1 operation when starting the link.  In case the
> > > > +		 * link is started in Gen2 mode, there is a possibility the
> > > > +		 * devices on the bus will not be detected at all.  This
> > > > +		 * happens with PCIe switches.
> > > > +		 */
> > > > +		tmp =3D dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
> > > > +		tmp &=3D ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> > > > +		tmp |=3D PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> > > > +		dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
> > > > +	}
> > > >=20
> > > >  	/* Start LTSSM. */
> > > >  	if (imx6_pcie->variant =3D=3D IMX7D)
