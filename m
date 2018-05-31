Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:21439 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755155AbeEaN0h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 May 2018 09:26:37 -0400
Subject: Re: [RESEND PATCH 2/4] PCI: cadence: Add generic PHY support to host
 and EP drivers
To: Alan Douglas <adouglas@cadence.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>
References: <1526995626-9333-1-git-send-email-adouglas@cadence.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.com>,
        <cyrille.pitchen@free-electrons.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d701937d-f33b-d801-a803-56ac76a7119b@ti.com>
Date: Thu, 31 May 2018 18:56:26 +0530
MIME-Version: 1.0
In-Reply-To: <1526995626-9333-1-git-send-email-adouglas@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 22 May 2018 06:57 PM, Alan Douglas wrote:
> If PHYs are present, they will be initialized and enabled in driver probe,
> and disabled in driver shutdown.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  drivers/pci/cadence/pcie-cadence-ep.c   | 14 ++++-
>  drivers/pci/cadence/pcie-cadence-host.c | 31 +++++++++++
>  drivers/pci/cadence/pcie-cadence.c      | 93 +++++++++++++++++++++++++++++++++
>  drivers/pci/cadence/pcie-cadence.h      |  7 +++
>  4 files changed, 144 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> index 3d8283e..2581caf 100644
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
> @@ -535,7 +547,7 @@ static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
>  
>  	pm_runtime_disable(dev);
>  
> -	/* The PCIe controller can't be disabled. */
> +	cdns_pcie_disable_phy(pcie);
>  }
>  
>  static struct platform_driver cdns_pcie_ep_driver = {
> diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/pcie-cadence-host.c
> index a4ebbd3..7536926a 100644
> --- a/drivers/pci/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/cadence/pcie-cadence-host.c
> @@ -58,6 +58,9 @@ static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>  
>  		return pcie->reg_base + (where & 0xfff);
>  	}
> +	/* Check that the link is up */
> +	if (!(cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
> +		return NULL;
>  
>  	/* Update Output registers for AXI region 0. */
>  	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
> @@ -239,6 +242,7 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  	struct cdns_pcie *pcie;
>  	struct resource *res;
>  	int ret;
> +	int phy_count;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
>  	if (!bridge)
> @@ -290,6 +294,13 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
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
> @@ -322,15 +333,35 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
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

shutdown callback can be added in a separate patch.

> +
> +
spurious blank line.
>  static struct platform_driver cdns_pcie_host_driver = {
>  	.driver = {
>  		.name = "cdns-pcie-host",
>  		.of_match_table = cdns_pcie_host_of_match,
>  	},
>  	.probe = cdns_pcie_host_probe,
> +	.shutdown = cdns_pcie_shutdown,
>  };
>  builtin_platform_driver(cdns_pcie_host_driver);
> diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-cadence.c
> index 138d113..681609a 100644
> --- a/drivers/pci/cadence/pcie-cadence.c
> +++ b/drivers/pci/cadence/pcie-cadence.c
> @@ -124,3 +124,96 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
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

It's preferable to have num-lanes property, which can be used to configure the
number of lanes supported in a platform even if it doesn't populate PHYs property.
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

For optional PHYs, devm_phy_optional_get() should be used.

Thanks
Kishon
