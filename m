Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1438158927.5106.20.camel@tiscali.nl>
Subject: Re: [PATCH 3/6] pci:host: Add Altera PCIe host controller driver
From: Paul Bolle <pebolle@tiscali.nl>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, lftan.linux@gmail.com,
	Rob Herring <robh+dt@kernel.org>
Date: Wed, 29 Jul 2015 10:35:27 +0200
In-Reply-To: <1438080345-7233-4-git-send-email-lftan@altera.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
	 <1438080345-7233-4-git-send-email-lftan@altera.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On di, 2015-07-28 at 18:45 +0800, Ley Foon Tan wrote:
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig

> +config PCIE_ALTERA
> +	bool "Altera PCIe controller"
> +	depends on ARCH_SOCFPGA
> +	depends on OF
> +	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
> +	help
> +	  Say Y here if you want to enable PCIe controller support for Altera
> +	  SoCFPGA family of SoCs.

> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile

> +obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o

> --- /dev/null
> +++ b/drivers/pci/host/pcie-altera.c

> +#include <linux/module.h>

> +static const struct of_device_id altera_pcie_of_match[] = {
> +	{ .compatible = "altr,pcie-root-port-1.0", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, altera_pcie_of_match);


> +static struct platform_driver altera_pcie_driver = {
> +	[...]
> +		.owner	= THIS_MODULE,
> +	]...]
> +};
> +
> +module_platform_driver(altera_pcie_driver);
> +
> +MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
> +MODULE_DESCRIPTION("Altera PCIe host controller driver");
> +MODULE_LICENSE("GPL v2");

PCIE_ALTERA is a bool symbol. So pcie-altera.o is built-in only. Yet
pcie-altera.c uses a number of module-specific constructs. Should
PCIE_ALTERA perhaps be tristate?

Likewise for PCIE_ALTERA_MSI in 4/6.

Thanks,


Paul Bolle
