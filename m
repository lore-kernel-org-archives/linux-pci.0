Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci: dwc: dra7xx: Add shutdown handler to cleanly turn
 off clocks
To: Keerthy <j-keerthy@ti.com>, <bhelgaas@google.com>
References: <1504694351-32358-1-git-send-email-j-keerthy@ti.com>
CC: <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ab942ae4-5152-e041-4084-825a20d732be@ti.com>
Date: Wed, 6 Sep 2017 16:23:39 +0530
MIME-Version: 1.0
In-Reply-To: <1504694351-32358-1-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Keerthy,

On Wednesday 06 September 2017 04:09 PM, Keerthy wrote:
> Add shutdown handler to cleanly turn off clocks.

one minor comment below.. with that fixed you can add my

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index d4e98f3..66d1cfe 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -874,6 +874,19 @@ static int dra7xx_pcie_suspend_noirq(struct device *dev)
>  	return 0;
>  }
>  
> +void dra7xx_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct dra7xx_pcie *dra7xx = dev_get_drvdata(&pdev->dev);

Use struct device *dev = &pdev->dev, instead of de-referencing device pointer
multiple times.

Thanks
Kishon
