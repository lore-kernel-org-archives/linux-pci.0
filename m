Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36618 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933383AbaKMR4c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 12:56:32 -0500
Received: by mail-pa0-f52.google.com with SMTP id fa1so15601784pad.25
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 09:56:31 -0800 (PST)
Date: Thu, 13 Nov 2014 10:56:27 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>,
	'Pratyush Anand' <pratyush.anand@st.com>
Subject: Re: [PATCH] PCI: spear: Remove unnecessary OOM message
Message-ID: <20141113175627.GQ5064@google.com>
References: <002d01cffe28$ce2f5870$6a8e0950$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002d01cffe28$ce2f5870$6a8e0950$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 12:29:02PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. This patch
> fixes the following checkpatch warning.
> 
>   WARNING: Possible unnecessary 'out of memory' message
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied with Viresh's ack to pci/host-spear for v3.19, thanks!

> ---
>  drivers/pci/host/pcie-spear13xx.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 85f594e..4647b62 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -308,10 +308,8 @@ static int __init spear13xx_pcie_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	spear13xx_pcie = devm_kzalloc(dev, sizeof(*spear13xx_pcie), GFP_KERNEL);
> -	if (!spear13xx_pcie) {
> -		dev_err(dev, "no memory for SPEAr13xx pcie\n");
> +	if (!spear13xx_pcie)
>  		return -ENOMEM;
> -	}
>  
>  	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
>  	if (IS_ERR(spear13xx_pcie->phy)) {
> -- 
> 1.7.9.5
> 
> 
