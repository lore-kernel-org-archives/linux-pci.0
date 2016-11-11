Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934727AbcKKVne (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 16:43:34 -0500
Date: Fri, 11 Nov 2016 15:43:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: hisi: Remove redundant dev_err call in
 hisi_pcie_probe()
Message-ID: <20161111214330.GK9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476716210-31532-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476716210-31532-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 02:56:50PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied to pci/host-hisi for v4.10, thanks!

> ---
>  drivers/pci/host/pcie-hisi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> index 56154c2..a77b9bda 100644
> --- a/drivers/pci/host/pcie-hisi.c
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -185,10 +185,8 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  
>  	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
>  	pp->dbi_base = devm_ioremap_resource(dev, reg);
> -	if (IS_ERR(pp->dbi_base)) {
> -		dev_err(dev, "cannot get rc_dbi base\n");
> +	if (IS_ERR(pp->dbi_base))
>  		return PTR_ERR(pp->dbi_base);
> -	}
>  
>  	ret = hisi_add_pcie_port(hisi_pcie, pdev);
>  	if (ret)
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
