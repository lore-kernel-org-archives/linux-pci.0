Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1437035476.27428.24.camel@tiscali.nl>
Subject: Re: [PATCH 5/5] PCI: Add host drivers for Cavium ThunderX
 processors.
From: Paul Bolle <pebolle@tiscali.nl>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@cavium.com>,
	David Daney <david.daney@cavium.com>
Date: Thu, 16 Jul 2015 10:31:16 +0200
In-Reply-To: <1436979285-8177-6-git-send-email-ddaney.cavm@gmail.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
	 <1436979285-8177-6-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On wo, 2015-07-15 at 09:54 -0700, David Daney wrote:
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig

> +config PCI_THUNDER_PEM
> +	bool

Do you expect other symbols to select this symbol in the future? Because
at this moment PCI_THUNDER_PEM is merely an alias for PCI_THUNDER.

> +config PCI_THUNDER
> +	bool "Thunder PCIe host controller"
> +	depends on ARM64 || COMPILE_TEST
> +	depends on OF_PCI
> +	select PCI_MSI
> +	select PCI_THUNDER_PEM
> +	help
> +	  Say Y here if you want internal PCI support on Thunder SoC.

> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile

> +obj-$(CONFIG_PCI_THUNDER) += pcie-thunder.o
> +obj-$(CONFIG_PCI_THUNDER_PEM) += pcie-thunder-pem.o

> --- /dev/null
> +++ b/drivers/pci/host/pcie-thunder-pem.c

> +#include <linux/module.h>

> +MODULE_DEVICE_TABLE(pci, thunder_pem_pci_table);

> +static int __init thunder_pcie_init(void)
> +{
> +	int ret;
> +
> +	ret = pci_register_driver(&thunder_pem_driver);
> +
> +	return ret;
> +}
> +module_init(thunder_pcie_init);
> +
> +static void __exit thunder_pcie_exit(void)
> +{
> +	pci_unregister_driver(&thunder_pem_driver);
> +}
> +module_exit(thunder_pcie_exit);

> --- /dev/null
> +++ b/drivers/pci/host/pcie-thunder.c

> +#include <linux/module.h>

> +MODULE_DEVICE_TABLE(of, thunder_pcie_of_match);
> +
> +static struct platform_driver thunder_pcie_driver = {
> +	.driver = {
> +		[...]
> +		.owner = THIS_MODULE,
> +		[...]
> +};
> +module_platform_driver(thunder_pcie_driver);

> +MODULE_AUTHOR("Sunil Goutham");
> +MODULE_DESCRIPTION("Cavium Thunder ECAM host controller driver");
> +MODULE_LICENSE("GPL v2");

This patch adds two bool Kconfig symbols and two files that can only be
built-in if these symbols are set, right?

But the code uses various constructs that are only useful for modular
code (MODULE_DEVICE_TABLE, __exit, module_exit, THIS_MODULE, and the
three MODULE_* macros) or have built-in alternatives (module_init and
module_platform_driver).

Was it your intention to make this code built-in or modular?

Thanks,


Paul Bolle
