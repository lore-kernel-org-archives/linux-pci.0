Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:19720 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932143AbdJJHTc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2017 03:19:32 -0400
Subject: Re: [PATCH 1/2] PCI: dwc: dra7xx: Create functional dependency
 between PCIe and PHY
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
References: <20171009090338.26033-1-kishon@ti.com>
 <20171009090338.26033-2-kishon@ti.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <f258c2f0-11a2-60ac-3919-dcc0badfa870@ti.com>
Date: Tue, 10 Oct 2017 10:19:28 +0300
MIME-Version: 1.0
In-Reply-To: <20171009090338.26033-2-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 09/10/17 12:03, Kishon Vijay Abraham I wrote:
> PCI core access configuration space registers in resume_noirq callbacks.
> In the case of dra7xx, PIPE3 PHY connected to PCIe controller has to be
> enabled before accessing configuration space registers. Since
> PIPE3 PHY is enabled by only configuring control module registers, no
> aborts has been observed so far (though during noirq stage, interface
> clock of PIPE3 PHY is not enabled).
>=20
> With new TRM updates, PIPE3 PHY has to be initialized (PIPE3 PHY
> registers has to be accessed) as well which requires the interface
> clock of PIPE3 PHY to be enabled. The interface clock of PIPE3 PHY is
> derived from OCP2SCP and hence PCIe PHY is modeled as a child of
> OCP2SCP. Since pm_runtime is not enabled during noirq stage,
> pm_runtime_get_sync done in phy_init doesn't enable
> OCP2SCP clocks resulting in abort when PIPE3 PHY registers are
> accessed.

This could be the case not only with PCIe but even with USB and SATA?
Maybe today it doesn't complain because USB/SATA is being resumed (by chanc=
e) after PHY?

>=20
> Create a function dependency between PCIe and PHY here to make
> sure PCIe is suspended before PCIe PHY/OCP2SCP and resumed after
> PCIe PHY/OCP2SCP.
>=20
> Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 34427a6a15af..362607f727ee 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -11,6 +11,7 @@
>   */
> =20
>  #include <linux/delay.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -594,6 +595,7 @@ static int __init dra7xx_pcie_probe(struct platform_d=
evice *pdev)
>  	int i;
>  	int phy_count;
>  	struct phy **phy;
> +	struct device_link **link;
>  	void __iomem *base;
>  	struct resource *res;
>  	struct dw_pcie *pci;
> @@ -649,11 +651,21 @@ static int __init dra7xx_pcie_probe(struct platform=
_device *pdev)
>  	if (!phy)
>  		return -ENOMEM;
> =20
> +	link =3D devm_kzalloc(dev, sizeof(*link) * phy_count, GFP_KERNEL);
> +	if (!link)
> +		return -ENOMEM;
> +
>  	for (i =3D 0; i < phy_count; i++) {
>  		snprintf(name, sizeof(name), "pcie-phy%d", i);
>  		phy[i] =3D devm_phy_get(dev, name);
>  		if (IS_ERR(phy[i]))
>  			return PTR_ERR(phy[i]);
> +
> +		link[i] =3D device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> +		if (!link[i]) {
> +			ret =3D -EINVAL;
> +			goto err_link;
> +		}
>  	}
> =20
>  	dra7xx->base =3D base;
> @@ -732,6 +744,10 @@ static int __init dra7xx_pcie_probe(struct platform_=
device *pdev)
>  	pm_runtime_disable(dev);
>  	dra7xx_pcie_disable_phy(dra7xx);
> =20
> +err_link:
> +	while (--i >=3D 0)
> +		device_link_del(link[i]);
> +
>  	return ret;
>  }
> =20
>=20

--=20
cheers,
-roger
