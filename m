Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:57028 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdLAFOB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Dec 2017 00:14:01 -0500
Subject: Re: [PATCH] pci: dwc: pci-dra7xx: Make shutdown handler static
To: Vignesh R <vigneshr@ti.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171201050652.13998-1-vigneshr@ti.com>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <12f94b3d-5192-d53a-8390-812fe9b7b229@ti.com>
Date: Fri, 1 Dec 2017 10:43:53 +0530
MIME-Version: 1.0
In-Reply-To: <20171201050652.13998-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Friday 01 December 2017 10:36 AM, Vignesh R wrote:
> Declare dra7xx_pcie_shutdown() as a static function as its not used
> elsewhere.

Seems like the below version that had static version was not taken:

https://patchwork.kernel.org/patch/10052579/

So for this patch:

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 59e8de34cec6..b9db442af793 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -815,7 +815,7 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
>  }
>  #endif
>  
> -void dra7xx_pcie_shutdown(struct platform_device *pdev)
> +static void dra7xx_pcie_shutdown(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> 
