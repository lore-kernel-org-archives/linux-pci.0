Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16072 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab3KSHFm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 02:05:42 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWI00EQF1116JM0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 19 Nov 2013 16:05:41 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wei Yongjun' <weiyj.lk@gmail.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Valentine Barshak' <valentine.barshak@cogentembedded.com>,
	yongjun_wei@trendmicro.com.cn, linux-pci@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <CAPgLHd-XTnQXdK7H2uLbGW1ftxNB_nHwzcNCoiCjpXsB5X3HnA@mail.gmail.com>
In-reply-to: <CAPgLHd-XTnQXdK7H2uLbGW1ftxNB_nHwzcNCoiCjpXsB5X3HnA@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: fix return value check in rcar_pci_probe()
Date: Tue, 19 Nov 2013 16:05:41 +0900
Message-id: <000401cee4f5$c206d070$46147150$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 19, 2013 12:40 PM, Wei Yongjun wrote:
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

It looks good.
Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

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

