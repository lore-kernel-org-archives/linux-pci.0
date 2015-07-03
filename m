Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55967A3A.7000907@ti.com>
Date: Fri, 3 Jul 2015 15:04:10 +0300
From: Grygorii Strashko <grygorii.strashko@ti.com>
MIME-Version: 1.0
To: Kishon Vijay Abraham I <kishon@ti.com>, <bhelgaas@google.com>,
	<jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nsekhar@ti.com>
Subject: Re: [PATCH 3/3] PCI: host: pci-dra7xx: add pm support to pci dra7xx
References: <1435921425-15121-1-git-send-email-kishon@ti.com> <1435921425-15121-4-git-send-email-kishon@ti.com>
In-Reply-To: <1435921425-15121-4-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On 07/03/2015 02:03 PM, Kishon Vijay Abraham I wrote:
> Add PM support to pci-dra7xx so that PCI clocks can be disabled
> during suspend and enabled back during resume without affecting
> PCI functionality.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/pci/host/pci-dra7xx.c |   74 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)
>
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index d8b6d66..1f5c039 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -433,6 +433,79 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_PM_SLEEP

[...]

> +
> +static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
> +	.suspend_noirq = dra7xx_pcie_suspend_noirq,
> +	.suspend = dra7xx_pcie_suspend,
> +	.resume_noirq = dra7xx_pcie_resume_noirq,
> +	.resume = dra7xx_pcie_resume,

Could you use here SET_SYSTEM_SLEEP_PM_OPS()
and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() macro, pls?

> +};
> +#define DEV_PM_OPS	(&dra7xx_pcie_pm_ops)
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif
> +
>   static const struct of_device_id of_dra7xx_pcie_match[] = {
>   	{ .compatible = "ti,dra7-pcie", },
>   	{},
> @@ -444,6 +517,7 @@ static struct platform_driver dra7xx_pcie_driver = {
>   	.driver = {
>   		.name	= "dra7-pcie",
>   		.of_match_table = of_dra7xx_pcie_match,
> +		.pm	= DEV_PM_OPS,
>   	},
>   };
>
>


-- 
regards,
-grygorii
