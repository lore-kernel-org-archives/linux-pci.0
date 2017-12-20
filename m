Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754785AbdLTMNw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Dec 2017 07:13:52 -0500
Date: Wed, 20 Dec 2017 12:14:38 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Fabio Estevam <festevam@gmail.com>, kdinh@apm.com
Cc: bhelgaas@google.com, dhdang@apm.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Fix the error return code
Message-ID: <20171220121438.GB1709@red-moon>
References: <1513730309-18831-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513730309-18831-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+ Khuong Dinh]

On Tue, Dec 19, 2017 at 10:38:29PM -0200, Fabio Estevam wrote:
> In the case of IS_ERR() error, we should return PTR_ERR().
> 
> Fix the error return code.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/pci/host/pci-xgene-msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I am about to apply this patch, please let me know if you see
any issue with that.

Thanks,
Lorenzo

> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
> index 1f42a20..4a1fb01 100644
> --- a/drivers/pci/host/pci-xgene-msi.c
> +++ b/drivers/pci/host/pci-xgene-msi.c
> @@ -465,7 +465,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
>  	xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(xgene_msi->msi_regs)) {
>  		dev_err(&pdev->dev, "no reg space\n");
> -		rc = -EINVAL;
> +		rc = PTR_ERR(xgene_msi->msi_regs);
>  		goto error;
>  	}
>  	xgene_msi->msi_addr = res->start;
> -- 
> 2.7.4
> 
