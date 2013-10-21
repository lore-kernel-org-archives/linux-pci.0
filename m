Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46050 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab3JUK0E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2013 06:26:04 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV000KOMKZ39VY0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 21 Oct 2013 19:26:02 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Sachin Kamat' <sachin.kamat@linaro.org>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
 <1382346403-29576-3-git-send-email-sachin.kamat@linaro.org>
In-reply-to: <1382346403-29576-3-git-send-email-sachin.kamat@linaro.org>
Subject: Re: [PATCH 3/3] PCI: exynos: Remove redundant of_match_ptr
Date: Mon, 21 Oct 2013 19:26:01 +0900
Message-id: <007501cece47$f0ae07a0$d20a16e0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> This driver is DT only. Hence of_match_ptr is not required.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Jingoo Han <jg1.han@samsung.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

It looks good.
Thank you for sending the patch. :)

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pci-exynos.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index ee692c2..c4798fb 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -647,7 +647,7 @@ static struct platform_driver exynos_pcie_driver = {
>  	.driver = {
>  		.name	= "exynos-pcie",
>  		.owner	= THIS_MODULE,
> -		.of_match_table = of_match_ptr(exynos_pcie_of_match),
> +		.of_match_table = exynos_pcie_of_match,
>  	},
>  };
> 
> --
> 1.7.9.5

