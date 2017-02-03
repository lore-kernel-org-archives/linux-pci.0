Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752286AbdBCUkq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 15:40:46 -0500
Date: Fri, 3 Feb 2017 14:40:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH 1/3] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
Message-ID: <20170203204042.GF10291@bhelgaas-glaptop.roam.corp.google.com>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
 <1484202504-96686-2-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484202504-96686-2-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 02:28:22PM +0800, Dongdong Liu wrote:
> The PCIe controller in Hip06/Hip07 SoCs is not completely
> ECAM-compliant. It is non-ECAM only for the RC bus config space; for
> any other bus underneath the root bus it does support ECAM access.
> This is to add the almost ECAM support in DT way.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

Applied to pci/host-hisi for v4.11, thanks!

> ---
>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 37 +++++++++++++++
>  drivers/pci/host/pcie-hisi.c                       | 54 ++++++++++++++++++++--
>  2 files changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> index 59c2f47..38e6dc3 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -42,3 +42,40 @@ Hip05 Example (note that Hip06 is the same except compatible):
>  				 0x0 0 0 4 &mbigen_pcie 4 13>;
>  		status = "ok";
>  	};
> +
> +HiSilicon Hip06/Hip07 PCIe host bridge DT (almost ecam) description
> +The properties and their meanings are identical to those described in
> +host-generic-pci.txt except as listed below.
> +
> +Properties of the host controller node that differ from
> +host-generic-pci.txt:
> +
> +- compatible     : Must be "hisilicon,pcie-almost-ecam"
> +
> +- reg            : Two entries: First the ECAM configuration space for any
> +		   other bus underneath the root bus. Second, the base
> +		   and size of the HiSilicon host bridge registers inculde
> +		   the RC itself config space.
> +
> +Example:
> +	pcie0: pcie@a0090000 {
> +		compatible = "hisilicon,pcie-almost-ecam";
> +		reg = <0 0xb0000000 0 0x2000000>,  /*  ECAM configuration space */
> +		      <0 0xa0090000 0 0x10000>; /* host bridge registers */
> +		bus-range = <0  31>;
> +		msi-map = <0x0000 &its_dsa 0x0000 0x2000>;
> +		msi-map-mask = <0xffff>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		dma-coherent;
> +		ranges = <0x02000000 0 0xb2000000 0x0 0xb2000000 0 0x5ff0000
> +			  0x01000000 0 0 0 0xb7ff0000 0 0x10000>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <0x0 0 0 1 &mbigen_pcie0 650 4
> +				 0x0 0 0 2 &mbigen_pcie0 650 4
> +				 0x0 0 0 3 &mbigen_pcie0 650 4
> +				 0x0 0 0 4 &mbigen_pcie0 650 4>;
> +		status = "ok";
> +	};
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> index a301a71..f37f5a2 100644
> --- a/drivers/pci/host/pcie-hisi.c
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -24,7 +24,7 @@
>  #include <linux/regmap.h>
>  #include "../pci.h"
>  
> -#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> +#if defined(CONFIG_PCI_HISI) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
>  
>  static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  				  int size, u32 *val)
> @@ -74,6 +74,8 @@ static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  		return pci_ecam_map_bus(bus, devfn, where);
>  }
>  
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> +
>  static int hisi_pcie_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev = cfg->parent;
> @@ -262,17 +264,23 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	struct resource *reg;
>  	struct device_driver *driver;
> +	struct pci_ecam_ops *ops;
>  	int ret;
>  
> +	driver = dev->driver;
> +	match = of_match_device(driver->of_match_table, dev);
> +	if (!strcmp(match->compatible, "hisilicon,pcie-almost-ecam")) {
> +		ops = (struct pci_ecam_ops *)match->data;
> +		return pci_host_common_probe(pdev, ops);
> +	}
> +
>  	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
>  	if (!hisi_pcie)
>  		return -ENOMEM;
>  
>  	pp = &hisi_pcie->pp;
>  	pp->dev = dev;
> -	driver = dev->driver;
>  
> -	match = of_match_device(driver->of_match_table, dev);
>  	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
>  
>  	hisi_pcie->subctrl =
> @@ -302,6 +310,40 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  		&hisi_pcie_link_up_hip06
>  };
>  
> +static int hisi_pcie_platform_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +	void __iomem *reg_base;
> +
> +	if (!dev->of_node)
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(dev, "missing \"reg[1]\"property\n");
> +		return -EINVAL;
> +	}
> +
> +	reg_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!reg_base)
> +		return -ENOMEM;
> +
> +	cfg->priv = reg_base;
> +	return 0;
> +}
> +
> +struct pci_ecam_ops hisi_pcie_platform_ops = {
> +	.bus_shift    = 20,
> +	.init         =  hisi_pcie_platform_init,
> +	.pci_ops      = {
> +		.map_bus    = hisi_pcie_map_bus,
> +		.read       = hisi_pcie_acpi_rd_conf,
> +		.write      = hisi_pcie_acpi_wr_conf,
> +	}
> +};
> +
>  static const struct of_device_id hisi_pcie_of_match[] = {
>  	{
>  			.compatible = "hisilicon,hip05-pcie",
> @@ -311,6 +353,11 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  			.compatible = "hisilicon,hip06-pcie",
>  			.data	    = (void *) &hip06_ops,
>  	},
> +
> +	{
> +			.compatible = "hisilicon,pcie-almost-ecam",
> +			.data	    = (void *) &hisi_pcie_platform_ops,
> +	},
>  	{},
>  };
>  
> @@ -324,3 +371,4 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  builtin_platform_driver(hisi_pcie_driver);
>  
>  #endif
> +#endif
> -- 
> 1.9.1
> 
