Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdHCV7w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 17:59:52 -0400
Date: Thu, 3 Aug 2017 16:59:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH] PCI: hisi: remove unused variable driver
Message-ID: <20170803215949.GI20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1500600366-181656-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500600366-181656-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 21, 2017 at 09:26:06AM +0800, Shawn Lin wrote:
> It was never used and also introduce a warning
> 
> drivers/pci/dwc/pcie-hisi.c: In function 'hisi_pcie_probe':
> drivers/pci/dwc/pcie-hisi.c:271:24: warning: variable 'driver' set but
> not used [-Wunused-but-set-variable]
> 
> Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-hisi for v4.14 with acks from Zhou and Gabriele, thanks!

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
> -- 
> 1.9.1
> 
> 
