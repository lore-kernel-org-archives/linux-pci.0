Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:48896 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933771AbaKMRsA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 12:48:00 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn18so80585igb.15
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 09:48:00 -0800 (PST)
Date: Thu, 13 Nov 2014 10:47:56 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org,
	'Murali Karicheri' <m-karicheri2@ti.com>,
	'Santosh Shilimkar' <ssantosh@kernel.org>
Subject: Re: [PATCH] PCI: keystone: Remove unnecessary OOM message
Message-ID: <20141113174756.GL5064@google.com>
References: <002601cffe27$f7bca9f0$e735fdd0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002601cffe27$f7bca9f0$e735fdd0$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 12:22:56PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. This patch
> fixes the following checkpatch warning.
> 
>   WARNING: Possible unnecessary 'out of memory' message
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/host-keystone for v3.19, thanks!

Murali, let me know if you object.  I'm trying to clear the easy stuff out
of my queue.

> ---
>  drivers/pci/host/pci-keystone.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 1b893bc..62b9454 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -353,10 +353,9 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  
>  	ks_pcie = devm_kzalloc(&pdev->dev, sizeof(*ks_pcie),
>  				GFP_KERNEL);
> -	if (!ks_pcie) {
> -		dev_err(dev, "no memory for keystone pcie\n");
> +	if (!ks_pcie)
>  		return -ENOMEM;
> -	}
> +
>  	pp = &ks_pcie->pp;
>  
>  	/* initialize SerDes Phy if present */
> -- 
> 1.7.9.5
> 
> 
