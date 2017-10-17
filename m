Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0049.outbound.protection.outlook.com ([104.47.41.49]:2657
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757981AbdJQIzm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 04:55:42 -0400
Subject: Re: [PATCH 5/5] PCI: xilinx-nwl: Fix platform_get_irq() error
 handling
To: Fabio Estevam <festevam@gmail.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com>
 <1508018851-9272-5-git-send-email-festevam@gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <c30d003a-0b6d-175f-3bd2-fdd5a9ec0f5a@xilinx.com>
Date: Tue, 17 Oct 2017 10:55:26 +0200
MIME-Version: 1.0
In-Reply-To: <1508018851-9272-5-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15.10.2017 00:07, Fabio Estevam wrote:
> When platform_get_irq() fails we should propagate the real error value
> instead of always returning -EINVAL.
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index 65dea98..b896167 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -591,7 +591,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>  	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
>  	if (msi->irq_msi1 < 0) {
>  		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi1);
> -		ret = -EINVAL;
> +		ret = msi->irq_msi1;
>  		goto err;
>  	}
>  
> @@ -602,7 +602,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>  	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
>  	if (msi->irq_msi0 < 0) {
>  		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi0);
> -		ret = -EINVAL;
> +		ret = msi->irq_msi0;
>  		goto err;
>  	}
>  
> @@ -735,7 +735,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  	if (pcie->irq_misc < 0) {
>  		dev_err(dev, "failed to get misc IRQ %d\n",
>  			pcie->irq_misc);
> -		return -EINVAL;
> +		return pcie->irq_misc;
>  	}
>  
>  	err = devm_request_irq(dev, pcie->irq_misc,
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
