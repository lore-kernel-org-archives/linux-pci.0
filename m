Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:34291 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752720AbdK2MBt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Nov 2017 07:01:49 -0500
Subject: Re: [PATCH V2 7/9] PCI: tegra: Add loadable kernel module support
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, rjw@rjwysocki.net,
        tglx@linutronix.de
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
 <1511638333-22951-8-git-send-email-mmaddireddy@nvidia.com>
Cc: vidyas@nvidia.com, kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <e49cb27d-6803-2ca5-6ee6-2bb862968451@kapsi.fi>
Date: Wed, 29 Nov 2017 14:01:47 +0200
MIME-Version: 1.0
In-Reply-To: <1511638333-22951-8-git-send-email-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25.11.2017 21:32, Manikanta Maddireddy wrote:
> Implement remove callback function for Tegra PCIe driver to add
> loadable kernel module support. Change PCI_TEGRA config to tristate to
> allow pci-tegra driver to be build as a module.
>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * no change in this patch
>
>  drivers/pci/host/Kconfig     |  2 +-
>  drivers/pci/host/pci-tegra.c | 31 ++++++++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 38d12980db0f..6fd2a5937804 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -34,7 +34,7 @@ config PCI_FTPCI100
>  	default ARCH_GEMINI
>
>  config PCI_TEGRA
> -	bool "NVIDIA Tegra PCIe controller"
> +	tristate "NVIDIA Tegra PCIe controller"
>  	depends on ARCH_TEGRA
>  	help
>  	  Say Y here if you want support for the PCIe host controller found
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 7f7b8c9c1e84..bbc2807bcd4a 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -35,6 +35,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -2720,6 +2721,12 @@ static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
>  	return -ENOMEM;
>  }
>
> +static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
> +{
> +	debugfs_remove_recursive(pcie->debugfs);
> +	pcie->debugfs = NULL;
> +}
> +

I think it's unnecessary to have a helper function for this - just 
inline it in the remove function.

>  static int tegra_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -2734,6 +2741,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>
>  	pcie = pci_host_bridge_priv(host);
> +	platform_set_drvdata(pdev, pcie);
>
>  	pcie->soc = of_device_get_match_data(dev);
>  	INIT_LIST_HEAD(&pcie->buses);
> @@ -2816,6 +2824,25 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>
> +static int tegra_pcie_remove(struct platform_device *pdev)
> +{
> +	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_FS))
> +		tegra_pcie_debugfs_exit(pcie);
> +	pci_stop_root_bus(host->bus);
> +	pci_remove_root_bus(host->bus);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		tegra_pcie_disable_msi(pcie);
> +	tegra_pcie_disable_ports(pcie);
> +	tegra_pcie_free_resources(pcie);
> +	tegra_pcie_disable_controller(pcie);
> +	tegra_pcie_put_resources(pcie);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver tegra_pcie_driver = {
>  	.driver = {
>  		.name = "tegra-pcie",
> @@ -2823,5 +2850,7 @@ static struct platform_driver tegra_pcie_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe = tegra_pcie_probe,
> +	.remove = tegra_pcie_remove,
>  };
> -builtin_platform_driver(tegra_pcie_driver);
> +module_platform_driver(tegra_pcie_driver);
> +MODULE_LICENSE("GPL");
>
