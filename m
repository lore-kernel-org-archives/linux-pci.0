Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 03/14] PCI: designware-plat: make it explicitly
 non-modular
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	<linux-kernel@vger.kernel.org>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
 <20160702231334.26684-4-paul.gortmaker@windriver.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <8c2d52da-8bfc-026c-cde6-e8cb61cb8a1b@synopsys.com>
Date: Mon, 4 Jul 2016 10:09:44 +0100
MIME-Version: 1.0
In-Reply-To: <20160702231334.26684-4-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Paul,

On 7/3/2016 12:13 AM, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/host/Kconfig:config PCIE_DW_PLAT
> drivers/pci/host/Kconfig:       bool "Platform bus based DesignWare PCIe Controller"
> 

(snip...)

> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/pci/host/pcie-designware-plat.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
> index b3500994d08a..c8079dc81c10 100644
> --- a/drivers/pci/host/pcie-designware-plat.c
> +++ b/drivers/pci/host/pcie-designware-plat.c
> @@ -14,7 +14,7 @@
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> @@ -121,7 +121,6 @@ static const struct of_device_id dw_plat_pcie_of_match[] = {
>  	{ .compatible = "snps,dw-pcie", },
>  	{},
>  };
> -MODULE_DEVICE_TABLE(of, dw_plat_pcie_of_match);
>  
>  static struct platform_driver dw_plat_pcie_driver = {
>  	.driver = {
> @@ -130,9 +129,4 @@ static struct platform_driver dw_plat_pcie_driver = {
>  	},
>  	.probe = dw_plat_pcie_probe,
>  };
> -
> -module_platform_driver(dw_plat_pcie_driver);
> -
> -MODULE_AUTHOR("Joao Pinto <Joao.Pinto@synopsys.com>");
> -MODULE_DESCRIPTION("Synopsys PCIe host controller glue platform driver");
> -MODULE_LICENSE("GPL v2");
> +builtin_platform_driver(dw_plat_pcie_driver);
> 

Makes totally sense! Thanks!

Acked-by: Joao Pinto <jpinto@synopsys.com>
