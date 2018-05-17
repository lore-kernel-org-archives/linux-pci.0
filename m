Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbeEQRF5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 May 2018 13:05:57 -0400
Date: Thu, 17 May 2018 18:05:53 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Alan Douglas <adouglas@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH] pci: cadence: Host and EP driver updates for PHY and
 power management
Message-ID: <20180517170553.GB3173@e107981-ln.cambridge.arm.com>
References: <SN6PR07MB451229DF639238CD7F15FDCFD8920@SN6PR07MB4512.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SN6PR07MB451229DF639238CD7F15FDCFD8920@SN6PR07MB4512.namprd07.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 16, 2018 at 01:06:05PM +0000, Alan Douglas wrote:
> From: Alan Douglas <adouglas@cadence.com>
> 
> This patch is based on next branch in Bjorn Helgaas' linux-pci git repository.
This sentence does not belong in a commit log and you should not be
basing patches on top of Bjorn's next branch, use v4.17-rc1, that is
an immutable commit.

> Allow optional list of generic PHYs to be provided via DTS for cadence
> RP and EP drivers.  Added power management ops which will
> enable/disable these PHYs.  Corrected parameters for cdns_pcie_writel
> function, value to be written had too small width.

Too many things at once. Each patch must solve one logical problem
and one only - it is easier to understand why if you think that
a patch may need to be reverted - if many changes are lumped together
this becomes complicated, that's one of the reasons.

So, please split this patch and send a v2, thank you.

Lorenzo

> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |    4 +
>  .../bindings/pci/cdns,cdns-pcie-host.txt           |    5 +
>  drivers/pci/cadence/pcie-cadence-ep.c              |   15 +++-
>  drivers/pci/cadence/pcie-cadence-host.c            |   36 ++++++-
>  drivers/pci/cadence/pcie-cadence.c                 |  123 ++++++++++++++++++++
>  drivers/pci/cadence/pcie-cadence.h                 |   13 ++-
>  6 files changed, 193 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> index 9a30523..e40c635 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> @@ -9,6 +9,8 @@ Required properties:
>  
>  Optional properties:
>  - max-functions: Maximum number of functions that can be configured (default 1).
> +- phys: From PHY bindings: List of Generic PHY phandles.
> +- phy-names:  List of names to identify the PHY.
>  
>  Example:
>  
> @@ -19,4 +21,6 @@ pcie@fc000000 {
>  	reg-names = "reg", "mem";
>  	cdns,max-outbound-regions = <16>;
>  	max-functions = /bits/ 8 <8>;
> +	phys = <&ep_phy0 &ep_phy1>;
> +	phy-names = "pcie-lane0","pcie-lane1";
>  };
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> index 20a33f3..13be218 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> @@ -24,6 +24,8 @@ Optional properties:
>    translations (default 32)
>  - vendor-id: The PCI vendor ID (16 bits, default is design dependent)
>  - device-id: The PCI device ID (16 bits, default is design dependent)
> +- phys: From PHY bindings: List of Generic PHY phandles.
> +- phy-names:  List of names to identify the PHY.
>  
>  Example:
>  
> @@ -57,4 +59,7 @@ pcie@fb000000 {
>  	interrupt-map-mask = <0x0 0x0 0x0  0x7>;
>  
>  	msi-parent = <&its_pci>;
> +
> +	phys = <&pcie_phy0>;
> +	phy-names = "pcie-phy";
>  };
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> index 3d8283e..e74b8a4 100644
> --- a/drivers/pci/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -439,6 +439,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>  	struct pci_epc *epc;
>  	struct resource *res;
>  	int ret;
> +	int phy_count;
>  
>  	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
>  	if (!ep)
> @@ -472,6 +473,12 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>  	if (!ep->ob_addr)
>  		return -ENOMEM;
>  
> +	ret = cdns_pcie_init_phy(dev, pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to init phy\n");
> +		return ret;
> +	}
> +	platform_set_drvdata(pdev, pcie);
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
> @@ -520,6 +527,10 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>  
>   err_get_sync:
>  	pm_runtime_disable(dev);
> +	cdns_pcie_disable_phy(pcie);
> +	phy_count = pcie->phy_count;
> +	while (phy_count--)
> +		device_link_del(pcie->link[phy_count]);
>  
>  	return ret;
>  }
> @@ -527,6 +538,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>  static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct cdns_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  
>  	ret = pm_runtime_put_sync(dev);
> @@ -535,13 +547,14 @@ static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
>  
>  	pm_runtime_disable(dev);
>  
> -	/* The PCIe controller can't be disabled. */
> +	cdns_pcie_disable_phy(pcie);
>  }
>  
>  static struct platform_driver cdns_pcie_ep_driver = {
>  	.driver = {
>  		.name = "cdns-pcie-ep",
>  		.of_match_table = cdns_pcie_ep_of_match,
> +		.pm	= &cdns_pcie_pm_ops,
>  	},
>  	.probe = cdns_pcie_ep_probe,
>  	.shutdown = cdns_pcie_ep_shutdown,
> diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/pcie-cadence-host.c
> index a4ebbd3..992ebe2 100644
> --- a/drivers/pci/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/cadence/pcie-cadence-host.c
> @@ -37,7 +37,6 @@ struct cdns_pcie_rc {
>  	u16			vendor_id;
>  	u16			device_id;
>  };
> -
>  static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>  				      int where)
>  {
> @@ -46,6 +45,7 @@ struct cdns_pcie_rc {
>  	struct cdns_pcie *pcie = &rc->pcie;
>  	unsigned int busn = bus->number;
>  	u32 addr0, desc0;
> +	u32 link_status;
>  
>  	if (busn == rc->bus_range->start) {
>  		/*
> @@ -58,6 +58,11 @@ struct cdns_pcie_rc {
>  
>  		return pcie->reg_base + (where & 0xfff);
>  	}
> +	/* Check that the link is up. Clear AXI link-down status  */
> +	link_status = cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
> +	if (!(link_status & 0x1))
> +		return NULL;
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
>  
>  	/* Update Output registers for AXI region 0. */
>  	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
> @@ -239,6 +244,7 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  	struct cdns_pcie *pcie;
>  	struct resource *res;
>  	int ret;
> +	int phy_count;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
>  	if (!bridge)
> @@ -290,6 +296,13 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  	}
>  	pcie->mem_res = res;
>  
> +	ret = cdns_pcie_init_phy(dev, pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to init phy\n");
> +		return ret;
> +	}
> +	platform_set_drvdata(pdev, pcie);
> +
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
> @@ -322,15 +335,36 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  
>   err_get_sync:
>  	pm_runtime_disable(dev);
> +	cdns_pcie_disable_phy(pcie);
> +	phy_count = pcie->phy_count;
> +	while (phy_count--)
> +		device_link_del(pcie->link[phy_count]);
>  
>  	return ret;
>  }
>  
> +static void cdns_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cdns_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret < 0)
> +		dev_dbg(dev, "pm_runtime_put_sync failed\n");
> +
> +	pm_runtime_disable(dev);
> +	cdns_pcie_disable_phy(pcie);
> +}
> +
> +
>  static struct platform_driver cdns_pcie_host_driver = {
>  	.driver = {
>  		.name = "cdns-pcie-host",
>  		.of_match_table = cdns_pcie_host_of_match,
> +		.pm	= &cdns_pcie_pm_ops,
>  	},
>  	.probe = cdns_pcie_host_probe,
> +	.shutdown = cdns_pcie_shutdown,
>  };
>  builtin_platform_driver(cdns_pcie_host_driver);
> diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-cadence.c
> index 138d113..7a34780 100644
> --- a/drivers/pci/cadence/pcie-cadence.c
> +++ b/drivers/pci/cadence/pcie-cadence.c
> @@ -124,3 +124,126 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), 0);
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
>  }
> +
> +void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
> +{
> +	int i = pcie->phy_count;
> +
> +	while (i--) {
> +		phy_power_off(pcie->phy[i]);
> +		phy_exit(pcie->phy[i]);
> +	}
> +}
> +
> +int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < pcie->phy_count; i++) {
> +		ret = phy_init(pcie->phy[i]);
> +		if (ret < 0)
> +			goto err_phy;
> +
> +		ret = phy_power_on(pcie->phy[i]);
> +		if (ret < 0) {
> +			phy_exit(pcie->phy[i]);
> +			goto err_phy;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_phy:
> +	while (--i >= 0) {
> +		phy_power_off(pcie->phy[i]);
> +		phy_exit(pcie->phy[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
> +{
> +	struct device_node *np = dev->of_node;
> +	int phy_count;
> +	struct phy **phy;
> +	struct device_link **link;
> +	int i;
> +	int ret;
> +	const char *name;
> +
> +	phy_count = of_property_count_strings(np, "phy-names");
> +	if (phy_count < 1) {
> +		dev_err(dev, "no phy-names.  PHY will not be initialized\n");
> +		pcie->phy_count = 0;
> +		return 0;
> +	}
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy) * phy_count, GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	link = devm_kzalloc(dev, sizeof(*link) * phy_count, GFP_KERNEL);
> +	if (!link)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < phy_count; i++) {
> +		of_property_read_string_index(np, "phy-names", i, &name);
> +		phy[i] = devm_phy_get(dev, name);
> +		if (IS_ERR(phy))
> +			return PTR_ERR(phy);
> +
> +		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> +		if (!link[i]) {
> +			ret = -EINVAL;
> +			goto err_link;
> +		}
> +	}
> +
> +	pcie->phy_count = phy_count;
> +	pcie->phy = phy;
> +	pcie->link = link;
> +
> +	ret =  cdns_pcie_enable_phy(pcie);
> +	if (ret)
> +		goto err_link;
> +
> +	return 0;
> +
> +err_link:
> +	while (--i >= 0)
> +		device_link_del(link[i]);
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cdns_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct cdns_pcie *pcie = dev_get_drvdata(dev);
> +
> +	cdns_pcie_disable_phy(pcie);
> +
> +	return 0;
> +}
> +
> +static int cdns_pcie_resume_noirq(struct device *dev)
> +{
> +	struct cdns_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = cdns_pcie_enable_phy(pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to enable phy\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +const struct dev_pm_ops cdns_pcie_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
> +				      cdns_pcie_resume_noirq)
> +};
> diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-cadence.h
> index 4bb2733..ae6bf2a 100644
> --- a/drivers/pci/cadence/pcie-cadence.h
> +++ b/drivers/pci/cadence/pcie-cadence.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> +#include <linux/phy/phy.h>
>  
>  /*
>   * Local Management Registers
> @@ -165,6 +166,9 @@
>  #define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
>  	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
>  
> +/* AXI link down register */
> +#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
> +
>  enum cdns_pcie_rp_bar {
>  	RP_BAR0,
>  	RP_BAR1,
> @@ -229,6 +233,9 @@ struct cdns_pcie {
>  	struct resource		*mem_res;
>  	bool			is_rc;
>  	u8			bus;
> +	int			phy_count;
> +	struct phy		**phy;
> +	struct device_link	**link;
>  };
>  
>  /* Register access */
> @@ -279,7 +286,7 @@ static inline void cdns_pcie_ep_fn_writew(struct cdns_pcie *pcie, u8 fn,
>  }
>  
>  static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
> -					  u32 reg, u16 value)
> +					  u32 reg, u32 value)
>  {
>  	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
>  }
> @@ -307,5 +314,9 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u8 fn,
>  						  u32 r, u64 cpu_addr);
>  
>  void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
> +void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
> +int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
> +int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
> +extern const struct dev_pm_ops cdns_pcie_pm_ops;
>  
>  #endif /* _PCIE_CADENCE_H */
> -- 
> 1.7.1
> 
