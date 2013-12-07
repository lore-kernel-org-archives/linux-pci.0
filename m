Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:56567 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab3LGWuS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 17:50:18 -0500
Received: by mail-yh0-f52.google.com with SMTP id i72so1567689yha.11
        for <linux-pci@vger.kernel.org>; Sat, 07 Dec 2013 14:50:18 -0800 (PST)
Date: Sat, 7 Dec 2013 15:50:12 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: valentine.barshak@cogentembedded.com,
	yongjun_wei@trendmicro.com.cn, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: fix return value check in rcar_pci_probe()
Message-ID: <20131207225012.GC7901@google.com>
References: <CAPgLHd-XTnQXdK7H2uLbGW1ftxNB_nHwzcNCoiCjpXsB5X3HnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPgLHd-XTnQXdK7H2uLbGW1ftxNB_nHwzcNCoiCjpXsB5X3HnA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 19, 2013 at 11:40:28AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied with Jingoo's reviewed-by to pci/host-rcar for v3.14, thanks!

For drivers/pci/host/*, I normally look for an ack from the responsible
person,  but this patch is trivial enough that I'm fine taking it without
that.  But for more significant changes, I don't have any notes about who
should own pci-rcar-gen2.c.  Valentine could be a candidate since he added
it in the first place?  Or Jingoo?

Bjorn

> ---
>  drivers/pci/host/pci-rcar-gen2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index cbaa5c4..96d1182 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -276,8 +276,8 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
>  
>  	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	reg = devm_ioremap_resource(&pdev->dev, cfg_res);
> -	if (!reg)
> -		return -ENODEV;
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
>  
>  	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	if (!mem_res || !mem_res->start)
> 
