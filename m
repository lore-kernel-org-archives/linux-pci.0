Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:56813 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754599AbcGFT2p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jul 2016 15:28:45 -0400
Subject: Re: [PATCH 06/14] PCI: keystone: make it explicitly non-modular
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	<linux-kernel@vger.kernel.org>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
 <20160702231334.26684-7-paul.gortmaker@windriver.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <577D5BF2.6040501@ti.com>
Date: Wed, 6 Jul 2016 15:28:50 -0400
MIME-Version: 1.0
In-Reply-To: <20160702231334.26684-7-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/02/2016 07:13 PM, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/host/Kconfig:config PCI_KEYSTONE
> drivers/pci/host/Kconfig:       bool "TI Keystone PCIe controller"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple instances of modular code usage, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/pci/host/pci-keystone.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 6b8301ef21ca..8ba28834d470 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -17,7 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
>  #include <linux/msi.h>
>  #include <linux/of_irq.h>
>  #include <linux/of.h>
> @@ -360,7 +360,6 @@ static const struct of_device_id ks_pcie_of_match[] = {
>  	},
>  	{ },
>  };
> -MODULE_DEVICE_TABLE(of, ks_pcie_of_match);
>  
>  static int __exit ks_pcie_remove(struct platform_device *pdev)
>  {
> @@ -439,9 +438,4 @@ static struct platform_driver ks_pcie_driver __refdata = {
>  		.of_match_table = of_match_ptr(ks_pcie_of_match),
>  	},
>  };
> -
> -module_platform_driver(ks_pcie_driver);
> -
> -MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
> -MODULE_DESCRIPTION("Keystone PCIe host controller driver");
> -MODULE_LICENSE("GPL v2");
> +builtin_platform_driver(ks_pcie_driver);
> 
Paul,

It make sense as this driver can't be used as a module at present and we build it
statically for Keystone. 

Tested-By: Murali Karicheri <m-karicheri2@ti.com>

