Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:14444 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbEZAfR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2015 20:35:17 -0400
Message-ID: <5563BFD3.5050902@broadcom.com>
Date: Mon, 25 May 2015 17:35:31 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>, <zajec5@gmail.com>
Subject: Re: [PATCH 2/2] PCI: iproc: free resource list after registration
References: <1432499823-27369-1-git-send-email-hauke@hauke-m.de> <1432499823-27369-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1432499823-27369-2-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hauke,

On 15-05-24 01:37 PM, Hauke Mehrtens wrote:
> The resource list is only used in the setup process and was never
> freed. pci_add_resource() allocates a memory area to store the list
> item. This patch fixes the memory leak.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   drivers/pci/host/pcie-iproc-bcma.c     | 8 ++++----
>   drivers/pci/host/pcie-iproc-platform.c | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
> index f96b39e..2e4f2d6 100644
> --- a/drivers/pci/host/pcie-iproc-bcma.c
> +++ b/drivers/pci/host/pcie-iproc-bcma.c
> @@ -65,12 +65,12 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>   	pcie->map_irq = iproc_pcie_bcma_map_irq;
>
>   	ret = iproc_pcie_setup(pcie, &res);
> -	if (ret) {
> +	if (ret)
>   		dev_err(pcie->dev, "PCIe controller setup failed\n");
> -		return ret;
> -	}
>
> -	return 0;
> +	pci_free_resource_list(&res);
> +
> +	return ret;
>   }
>
>   static void iproc_pcie_bcma_remove(struct bcma_device *bdev)
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index c5fe4c1..9aedc8e 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -72,12 +72,12 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>   	pcie->map_irq = of_irq_parse_and_map_pci;
>
>   	ret = iproc_pcie_setup(pcie, &res);
> -	if (ret) {
> +	if (ret)
>   		dev_err(pcie->dev, "PCIe controller setup failed\n");
> -		return ret;
> -	}
>
> -	return 0;
> +	pci_free_resource_list(&res);
> +
> +	return ret;
>   }
>
>   static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
>

This looks good to me and I sanity tested it on a BCM958300K Cygnus 
combo board.

Thanks,

Reviewed-by: Ray Jui <rjui@broadcom.com>
Tested-by: Ray Jui <rjui@broadcom.com>
