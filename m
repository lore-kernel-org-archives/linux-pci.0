Return-Path: <SRS0=oJ2I=5V=nxp.com=hongxing.zhu@kernel.org>
Return-Path: <SRS0=oJ2I=5V=nxp.com=hongxing.zhu@kernel.org>
From: Richard Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Quentin Schulz
	<quentin.schulz@free-electrons.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: imx6: add regulator support
Date: Fri, 16 Jun 2017 00:49:40 +0000
Message-ID: <AM5PR0402MB28503902575D87F934F890E38CC10@AM5PR0402MB2850.eurprd04.prod.outlook.com>
References: <20170608080742.3910-1-quentin.schulz@free-electrons.com>
 <20170615210544.GE12735@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170615210544.GE12735@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Friday, June 16, 2017 5:06 AM
> To: Quentin Schulz <quentin.schulz@free-electrons.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> thomas.petazzoni@free-electrons.com; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] PCI: imx6: add regulator support
>=20
> On Thu, Jun 08, 2017 at 10:07:42AM +0200, Quentin Schulz wrote:
> > Some boards might require to control a regulator to power the PCIe port=
.
> >
> > This adds support for an optional regulator defined in Device Tree
> > linked in the PCIe controller under `vpcie-supply`. If present, the
> > regulator will be disabled and then enabled as part of the PCIe host
> > initialization process and will be disabled when shutting down.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>=20
> Waiting for ack from Richard or Lucas.
[Zhu hongxing] Sorry to replay late.
This patch is okay for me.
Thanks.
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> > ---
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  4 +++
> >  drivers/pci/dwc/pci-imx6.c                         | 34 ++++++++++++++=
+++++++-
> >  2 files changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > index e3d5680875b1..cf92d3ba5a26 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > @@ -33,6 +33,10 @@ Optional properties:
> >  - reset-gpio-active-high: If present then the reset sequence using the
> GPIO
> >    specified in the "reset-gpio" property is reversed (H=3Dreset state,
> >    L=3Doperation state).
> > +- vpcie-supply: Should specify the regulator in charge of PCIe port po=
wer.
> > +  The regulator will be enabled when initializing the PCIe host and
> > +  disabled either as part of the init process or when shutting down
> > +the
> > +  host.
> >
> >  Additional required properties for imx6sx-pcie:
> >  - clock names: Must include the following additional entries:
> > diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> > index 19a289b8cc94..f9b7500c9aff 100644
> > --- a/drivers/pci/dwc/pci-imx6.c
> > +++ b/drivers/pci/dwc/pci-imx6.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/resource.h>
> >  #include <linux/signal.h>
> >  #include <linux/types.h>
> > @@ -59,6 +60,7 @@ struct imx6_pcie {
> >  	u32			tx_swing_full;
> >  	u32			tx_swing_low;
> >  	int			link_gen;
> > +	struct regulator	*vpcie;
> >  };
> >
> >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */ @@
> > -310,6 +312,13 @@ static void imx6_pcie_assert_core_reset(struct
> imx6_pcie *imx6_pcie)
> >  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> >  		break;
> >  	}
> > +
> > +	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> {
> > +		int ret =3D regulator_disable(imx6_pcie->vpcie);
> > +
> > +		if (ret)
> > +			pr_err("failed to disable vpcie regulator: %d\n", ret);
> > +	}
> >  }
> >
> >  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie) @@
> > -376,10 +385,19 @@ static void imx6_pcie_deassert_core_reset(struct
> imx6_pcie *imx6_pcie)
> >  	struct device *dev =3D pci->dev;
> >  	int ret;
> >
> > +	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> > +		ret =3D regulator_enable(imx6_pcie->vpcie);
> > +		if (ret) {
> > +			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> > +				ret);
> > +			return;
> > +		}
> > +	}
> > +
> >  	ret =3D clk_prepare_enable(imx6_pcie->pcie_phy);
> >  	if (ret) {
> >  		dev_err(dev, "unable to enable pcie_phy clock\n");
> > -		return;
> > +		goto err_pcie_phy;
> >  	}
> >
> >  	ret =3D clk_prepare_enable(imx6_pcie->pcie_bus);
> > @@ -439,6 +457,13 @@ static void imx6_pcie_deassert_core_reset(struct
> imx6_pcie *imx6_pcie)
> >  	clk_disable_unprepare(imx6_pcie->pcie_bus);
> >  err_pcie_bus:
> >  	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +err_pcie_phy:
> > +	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> {
> > +		ret =3D regulator_disable(imx6_pcie->vpcie);
> > +		if (ret)
> > +			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> > +				ret);
> > +	}
> >  }
> >
> >  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie) @@ -802,6
> > +827,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		imx6_pcie->link_gen =3D 1;
> >
> > +	imx6_pcie->vpcie =3D devm_regulator_get_optional(&pdev->dev,
> "vpcie");
> > +	if (IS_ERR(imx6_pcie->vpcie)) {
> > +		if (PTR_ERR(imx6_pcie->vpcie) =3D=3D -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +		imx6_pcie->vpcie =3D NULL;
> > +	}
> > +
> >  	platform_set_drvdata(pdev, imx6_pcie);
> >
> >  	ret =3D imx6_add_pcie_port(imx6_pcie, pdev);
> > --
> > 2.11.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
