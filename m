Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:19040
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750915AbeFDQN6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jun 2018 12:13:58 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>
Subject: RE: [RESEND PATCH 2/4] PCI: cadence: Add generic PHY support to host
 and EP drivers
Date: Mon, 4 Jun 2018 16:13:56 +0000
Message-ID: <SN6PR07MB4512DD9CD2FE6A8C8A2BE3C6D8670@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <1526995626-9333-1-git-send-email-adouglas@cadence.com>
 <d701937d-f33b-d801-a803-56ac76a7119b@ti.com>
In-Reply-To: <d701937d-f33b-d801-a803-56ac76a7119b@ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31 May 2018 14:26, Kishon Vijay Abraham I wrote:
> On Tuesday 22 May 2018 06:57 PM, Alan Douglas wrote:
> > If PHYs are present, they will be initialized and enabled in driver pro=
be,
> > and disabled in driver shutdown.
> >
> > Signed-off-by: Alan Douglas <adouglas@cadence.com>
> > ---
> >  drivers/pci/cadence/pcie-cadence-ep.c   | 14 ++++-
> >  drivers/pci/cadence/pcie-cadence-host.c | 31 +++++++++++
> >  drivers/pci/cadence/pcie-cadence.c      | 93 +++++++++++++++++++++++++=
++++++++
> >  drivers/pci/cadence/pcie-cadence.h      |  7 +++
> >  4 files changed, 144 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadenc=
e/pcie-cadence-ep.c
> > index 3d8283e..2581caf 100644
> > --- a/drivers/pci/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> > @@ -439,6 +439,7 @@ static int cdns_pcie_ep_probe(struct platform_devic=
e *pdev)
> >  	struct pci_epc *epc;
> >  	struct resource *res;
> >  	int ret;
> > +	int phy_count;
> >
> >  	ep =3D devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> >  	if (!ep)
> > @@ -472,6 +473,12 @@ static int cdns_pcie_ep_probe(struct platform_devi=
ce *pdev)
> >  	if (!ep->ob_addr)
> >  		return -ENOMEM;
> >
> > +	ret =3D cdns_pcie_init_phy(dev, pcie);
> > +	if (ret) {
> > +		dev_err(dev, "failed to init phy\n");
> > +		return ret;
> > +	}
> > +	platform_set_drvdata(pdev, pcie);
> >  	pm_runtime_enable(dev);
> >  	ret =3D pm_runtime_get_sync(dev);
> >  	if (ret < 0) {
> > @@ -520,6 +527,10 @@ static int cdns_pcie_ep_probe(struct platform_devi=
ce *pdev)
> >
> >   err_get_sync:
> >  	pm_runtime_disable(dev);
> > +	cdns_pcie_disable_phy(pcie);
> > +	phy_count =3D pcie->phy_count;
> > +	while (phy_count--)
> > +		device_link_del(pcie->link[phy_count]);
> >
> >  	return ret;
> >  }
> > @@ -527,6 +538,7 @@ static int cdns_pcie_ep_probe(struct platform_devic=
e *pdev)
> >  static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> > +	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
> >  	int ret;
> >
> >  	ret =3D pm_runtime_put_sync(dev);
> > @@ -535,7 +547,7 @@ static void cdns_pcie_ep_shutdown(struct platform_d=
evice *pdev)
> >
> >  	pm_runtime_disable(dev);
> >
> > -	/* The PCIe controller can't be disabled. */
> > +	cdns_pcie_disable_phy(pcie);
> >  }
> >
> >  static struct platform_driver cdns_pcie_ep_driver =3D {
> > diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cade=
nce/pcie-cadence-host.c
> > index a4ebbd3..7536926a 100644
> > --- a/drivers/pci/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/cadence/pcie-cadence-host.c
> > @@ -58,6 +58,9 @@ static void __iomem *cdns_pci_map_bus(struct pci_bus =
*bus, unsigned int devfn,
> >
> >  		return pcie->reg_base + (where & 0xfff);
> >  	}
> > +	/* Check that the link is up */
> > +	if (!(cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
> > +		return NULL;
> >
> >  	/* Update Output registers for AXI region 0. */
> >  	addr0 =3D CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
> > @@ -239,6 +242,7 @@ static int cdns_pcie_host_probe(struct platform_dev=
ice *pdev)
> >  	struct cdns_pcie *pcie;
> >  	struct resource *res;
> >  	int ret;
> > +	int phy_count;
> >
> >  	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> >  	if (!bridge)
> > @@ -290,6 +294,13 @@ static int cdns_pcie_host_probe(struct platform_de=
vice *pdev)
> >  	}
> >  	pcie->mem_res =3D res;
> >
> > +	ret =3D cdns_pcie_init_phy(dev, pcie);
> > +	if (ret) {
> > +		dev_err(dev, "failed to init phy\n");
> > +		return ret;
> > +	}
> > +	platform_set_drvdata(pdev, pcie);
> > +
> >  	pm_runtime_enable(dev);
> >  	ret =3D pm_runtime_get_sync(dev);
> >  	if (ret < 0) {
> > @@ -322,15 +333,35 @@ static int cdns_pcie_host_probe(struct platform_d=
evice *pdev)
> >
> >   err_get_sync:
> >  	pm_runtime_disable(dev);
> > +	cdns_pcie_disable_phy(pcie);
> > +	phy_count =3D pcie->phy_count;
> > +	while (phy_count--)
> > +		device_link_del(pcie->link[phy_count]);
> >
> >  	return ret;
> >  }
> >
> > +static void cdns_pcie_shutdown(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret =3D pm_runtime_put_sync(dev);
> > +	if (ret < 0)
> > +		dev_dbg(dev, "pm_runtime_put_sync failed\n");
> > +
> > +	pm_runtime_disable(dev);
> > +	cdns_pcie_disable_phy(pcie);
> > +}
>=20
> shutdown callback can be added in a separate patch.
>=20
Will move to a separate patch in v3

> > +
> > +
> spurious blank line.
Will remove in v3

> >  static struct platform_driver cdns_pcie_host_driver =3D {
> >  	.driver =3D {
> >  		.name =3D "cdns-pcie-host",
> >  		.of_match_table =3D cdns_pcie_host_of_match,
> >  	},
> >  	.probe =3D cdns_pcie_host_probe,
> > +	.shutdown =3D cdns_pcie_shutdown,
> >  };
> >  builtin_platform_driver(cdns_pcie_host_driver);
> > diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/p=
cie-cadence.c
> > index 138d113..681609a 100644
> > --- a/drivers/pci/cadence/pcie-cadence.c
> > +++ b/drivers/pci/cadence/pcie-cadence.c
> > @@ -124,3 +124,96 @@ void cdns_pcie_reset_outbound_region(struct cdns_p=
cie *pcie, u32 r)
> >  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), 0);
> >  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
> >  }
> > +
> > +void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
> > +{
> > +	int i =3D pcie->phy_count;
> > +
> > +	while (i--) {
> > +		phy_power_off(pcie->phy[i]);
> > +		phy_exit(pcie->phy[i]);
> > +	}
> > +}
> > +
> > +int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
> > +{
> > +	int ret;
> > +	int i;
> > +
> > +	for (i =3D 0; i < pcie->phy_count; i++) {
> > +		ret =3D phy_init(pcie->phy[i]);
> > +		if (ret < 0)
> > +			goto err_phy;
> > +
> > +		ret =3D phy_power_on(pcie->phy[i]);
> > +		if (ret < 0) {
> > +			phy_exit(pcie->phy[i]);
> > +			goto err_phy;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +err_phy:
> > +	while (--i >=3D 0) {
> > +		phy_power_off(pcie->phy[i]);
> > +		phy_exit(pcie->phy[i]);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
> > +{
> > +	struct device_node *np =3D dev->of_node;
> > +	int phy_count;
> > +	struct phy **phy;
> > +	struct device_link **link;
> > +	int i;
> > +	int ret;
> > +	const char *name;
> > +
> > +	phy_count =3D of_property_count_strings(np, "phy-names");
>=20
> It's preferable to have num-lanes property, which can be used to configur=
e the
> number of lanes supported in a platform even if it doesn't populate PHYs =
property.
There is no suitable register in the core IP to configure num-lanes, this i=
s
configured externally to the IP, and so can be read from an IP register.

> > +	if (phy_count < 1) {
> > +		dev_err(dev, "no phy-names.  PHY will not be initialized\n");
> > +		pcie->phy_count =3D 0;
> > +		return 0;
> > +	}
> > +
> > +	phy =3D devm_kzalloc(dev, sizeof(*phy) * phy_count, GFP_KERNEL);
> > +	if (!phy)
> > +		return -ENOMEM;
> > +
> > +	link =3D devm_kzalloc(dev, sizeof(*link) * phy_count, GFP_KERNEL);
> > +	if (!link)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < phy_count; i++) {
> > +		of_property_read_string_index(np, "phy-names", i, &name);
> > +		phy[i] =3D devm_phy_get(dev, name);
>=20
> For optional PHYs, devm_phy_optional_get() should be used.
>=20
I'll prepare a v3 using devm_phy_optional_get()

Thanks,
Alan
