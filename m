Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:38211 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeENQX5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 12:23:57 -0400
Subject: Re: [PATCH 2/4] PCI: dwc: Add support for EP mode
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <cover.1526314398.git.gustavo.pimentel@synopsys.com>
 <dbfaccc9902e43b659584e4638a26549a363292a.1526314398.git.gustavo.pimentel@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <6a0efa0b-a724-4617-439c-f9f876c1db6a@synopsys.com>
Date: Mon, 14 May 2018 17:23:48 +0100
MIME-Version: 1.0
In-Reply-To: <dbfaccc9902e43b659584e4638a26549a363292a.1526314398.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Às 5:17 PM de 5/14/2018, Gustavo Pimentel escreveu:
> The PCIe controller dual mode is capable of operating in RC mode as well
> as EP mode by configuration option. Till now only RC mode was supported,
> with this patch is add EP support to the DesignWare driver.
> 
> Add new property on pci_epc structure which allow to configure
> pci_epf_test driver accordingly to the controller specific requirements.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/Kconfig                       |  41 +++++--
>  drivers/pci/dwc/pcie-designware-ep.c          |   3 +
>  drivers/pci/dwc/pcie-designware-plat.c        | 149 ++++++++++++++++++++++++--
>  drivers/pci/endpoint/functions/pci-epf-test.c |   7 ++
>  include/linux/pci-epc.h                       |   8 ++
>  5 files changed, 187 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index 2f3f5c5..62f7cdf 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -7,8 +7,7 @@ config PCIE_DW
>  
>  config PCIE_DW_HOST
>          bool
> -	depends on PCI
> -	depends on PCI_MSI_IRQ_DOMAIN
> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
>          select PCIE_DW
>  
>  config PCIE_DW_EP
> @@ -51,17 +50,37 @@ config PCI_DRA7XX_EP
>  	  This uses the DesignWare core.
>  
>  config PCIE_DW_PLAT
> -	bool "Platform bus based DesignWare PCIe Controller"
> -	depends on PCI
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIE_DW_HOST
> -	---help---
> -	 This selects the DesignWare PCIe controller support. Select this if
> -	 you have a PCIe controller on Platform bus.
> +	bool
>  
> -	 If you have a controller with this interface, say Y or M here.
> +config PCIE_DW_PLAT_HOST
> +	bool "Platform bus based DesignWare PCIe Controller - Host mode"
> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	select PCIE_DW_PLAT
> +	default y
> +	help
> +	  Enables support for the PCIe controller in the Designware IP to
> +	  work in host mode. There are two instances of PCIe controller in
> +	  Designware IP.
> +	  This controller can work either as EP or RC. In order to enable
> +	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
> +	  order to enable device-specific features PCI_DW_PLAT_EP must be
> +	  selected.
>  
> -	 If unsure, say N.
> +config PCIE_DW_PLAT_EP
> +	bool "Platform bus based DesignWare PCIe Controller - Endpoint mode"
> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PCIE_DW_PLAT
> +	help
> +	  Enables support for the PCIe controller in the Designware IP to
> +	  work in endpoint mode. There are two instances of PCIe controller
> +	  in Designware IP.
> +	  This controller can work either as EP or RC. In order to enable
> +	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
> +	  order to enable device-specific features PCI_DW_PLAT_EP must be
> +	  selected.
>  
>  config PCI_EXYNOS
>  	bool "Samsung Exynos PCIe controller"
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index f07678b..2c05a08 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -411,6 +411,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -ENOMEM;
>  	}
>  
> +	epc->features = EPC_FEATURE_NO_LINKUP_NOTIFIER;
> +	EPC_FEATURE_SET_BAR(epc->features, BAR0);
> +
>  	ep->epc = epc;
>  	epc_set_drvdata(epc, ep);
>  	dw_pcie_setup(pci);
> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
> index 5416aa8..efc315c 100644
> --- a/drivers/pci/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/dwc/pcie-designware-plat.c
> @@ -12,19 +12,29 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/resource.h>
>  #include <linux/signal.h>
>  #include <linux/types.h>
> +#include <linux/regmap.h>
>  
>  #include "pcie-designware.h"
>  
>  struct dw_plat_pcie {
> -	struct dw_pcie		*pci;
> +	struct dw_pcie			*pci;
> +	struct regmap			*regmap;
> +	enum dw_pcie_device_mode	mode;
>  };
>  
> +struct dw_plat_pcie_of_data {
> +	enum dw_pcie_device_mode	mode;
> +};
> +
> +static const struct of_device_id dw_plat_pcie_of_match[];
> +
>  static int dw_plat_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -42,9 +52,53 @@ static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
>  	.host_init = dw_plat_pcie_host_init,
>  };
>  
> -static int dw_plat_add_pcie_port(struct pcie_port *pp,
> +static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
> +{
> +	return 0;
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = dw_plat_pcie_establish_link,
> +};
> +
> +static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;
> +
> +	for (bar = BAR_0; bar <= BAR_5; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +}
> +
> +static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				     enum pci_epc_irq_type type,
> +				     u8 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
> +		return -EINVAL;
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.ep_init = dw_plat_pcie_ep_init,
> +	.raise_irq = dw_plat_pcie_ep_raise_irq,
> +};
> +
> +static int dw_plat_add_pcie_port(struct dw_plat_pcie *dw_plat_pcie,
>  				 struct platform_device *pdev)
>  {
> +	struct dw_pcie *pci = dw_plat_pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
>  	struct device *dev = &pdev->dev;
>  	int ret;
>  
> @@ -63,15 +117,44 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
>  
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> +		dev_err(dev, "Failed to initialize host\n");
>  		return ret;
>  	}
>  
>  	return 0;
>  }
>  
> -static const struct dw_pcie_ops dw_pcie_ops = {
> -};
> +static int dw_plat_add_pcie_ep(struct dw_plat_pcie *dw_plat_pcie,
> +			       struct platform_device *pdev)
> +{
> +	int ret;
> +	struct dw_pcie_ep *ep;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie *pci = dw_plat_pcie->pci;
> +
> +	ep = &pci->ep;
> +	ep->ops = &pcie_ep_ops;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
> +	pci->dbi_base2 = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pci->dbi_base2))
> +		return PTR_ERR(pci->dbi_base2);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> +	if (!res)
> +		return -EINVAL;
> +
> +	ep->phys_base = res->start;
> +	ep->addr_size = resource_size(res);
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize endpoint\n");
> +		return ret;
> +	}
> +	return 0;
> +}
>  
>  static int dw_plat_pcie_probe(struct platform_device *pdev)
>  {
> @@ -80,6 +163,16 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	struct resource *res;  /* Resource from DT */
>  	int ret;
> +	const struct of_device_id *match;
> +	const struct dw_plat_pcie_of_data *data;
> +	enum dw_pcie_device_mode mode;
> +
> +	match = of_match_device(dw_plat_pcie_of_match, dev);
> +	if (!match)
> +		return -EINVAL;
> +
> +	data = (struct dw_plat_pcie_of_data *)match->data;
> +	mode = (enum dw_pcie_device_mode)data->mode;
>  
>  	dw_plat_pcie = devm_kzalloc(dev, sizeof(*dw_plat_pcie), GFP_KERNEL);
>  	if (!dw_plat_pcie)
> @@ -93,23 +186,59 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>  	pci->ops = &dw_pcie_ops;
>  
>  	dw_plat_pcie->pci = pci;
> +	dw_plat_pcie->mode = mode;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	if (!res)
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pci->dbi_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
>  
>  	platform_set_drvdata(pdev, dw_plat_pcie);
>  
> -	ret = dw_plat_add_pcie_port(&pci->pp, pdev);
> -	if (ret < 0)
> -		return ret;
> +	switch (dw_plat_pcie->mode) {
> +	case DW_PCIE_RC_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_DW_PLAT_HOST))
> +			return -ENODEV;
> +
> +		ret = dw_plat_add_pcie_port(dw_plat_pcie, pdev);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case DW_PCIE_EP_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_DW_PLAT_EP))
> +			return -ENODEV;
> +
> +		ret = dw_plat_add_pcie_ep(dw_plat_pcie, pdev);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
> +		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
> +	}
>  
>  	return 0;
>  }
>  
> +static const struct dw_plat_pcie_of_data dw_plat_pcie_rc_of_data = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct dw_plat_pcie_of_data dw_plat_pcie_ep_of_data = {
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
>  static const struct of_device_id dw_plat_pcie_of_match[] = {
> -	{ .compatible = "snps,dw-pcie", },
> +	{
> +		.compatible = "snps,dw-pcie",
> +		.data = &dw_plat_pcie_rc_of_data,
> +	},
> +	{
> +		.compatible = "snps,dw-pcie-ep",
> +		.data = &dw_plat_pcie_ep_of_data,
> +	},
>  	{},
>  };
>  
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7cef851..bee401d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -435,6 +435,13 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (WARN_ON_ONCE(!epc))
>  		return -EINVAL;
>  
> +	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
> +		epf_test->linkup_notifier = false;
> +	else
> +		epf_test->linkup_notifier = true;
> +
> +	epf_test->test_reg_bar = EPC_FEATURE_GET_BAR(epc->features);
> +
>  	ret = pci_epc_write_header(epc, epf->func_no, header);
>  	if (ret) {
>  		dev_err(dev, "configuration header write failed\n");
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index af657ca..243eaa5 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -90,8 +90,16 @@ struct pci_epc {
>  	struct config_group		*group;
>  	/* spinlock to protect against concurrent access of EP controller */
>  	spinlock_t			lock;
> +	unsigned int			features;
>  };
>  
> +#define EPC_FEATURE_NO_LINKUP_NOTIFIER		BIT(0)
> +#define EPC_FEATURE_BAR_MASK			(BIT(1) | BIT(2) | BIT(3))
> +#define EPC_FEATURE_SET_BAR(features, bar)	\
> +		(features |= (EPC_FEATURE_BAR_MASK & (bar << 1)))
> +#define EPC_FEATURE_GET_BAR(features)		\
> +		((features & EPC_FEATURE_BAR_MASK) >> 1)
> +
>  #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
>  
>  #define pci_epc_create(dev, ops)    \
> 


Acked-by: Joao Pinto <jpinto@synopsys.com>
