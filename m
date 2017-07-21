Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:10328 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbdGUHPb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2017 03:15:31 -0400
Subject: Re: [PATCH] PCI: hisi: remove unused variable driver
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1500600366-181656-1-git-send-email-shawn.lin@rock-chips.com>
CC: <linux-pci@vger.kernel.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5971A941.2000804@hisilicon.com>
Date: Fri, 21 Jul 2017 15:12:01 +0800
MIME-Version: 1.0
In-Reply-To: <1500600366-181656-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/7/21 9:26, Shawn Lin wrote:
> It was never used and also introduce a warning
> 
> drivers/pci/dwc/pcie-hisi.c: In function 'hisi_pcie_probe':
> drivers/pci/dwc/pcie-hisi.c:271:24: warning: variable 'driver' set but
> not used [-Wunused-but-set-variable]
> 
> Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks,
Zhou

> ---
> 
>  drivers/pci/dwc/pcie-hisi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index e51acee..6631654 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -268,7 +268,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	struct hisi_pcie *hisi_pcie;
>  	struct resource *reg;
> -	struct device_driver *driver;
>  	int ret;
>  
>  	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
> @@ -282,8 +281,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> -	driver = dev->driver;
> -
>  	hisi_pcie->pci = pci;
>  
>  	hisi_pcie->soc_ops = of_device_get_match_data(dev);
> 
