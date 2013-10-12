Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:38236
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750711Ab3JLILF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Oct 2013 04:11:05 -0400
Date: Sat, 12 Oct 2013 16:11:32 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: <bhelgaas@google.com>, <grant.likely@linaro.org>,
	<rob.herring@calxeda.com>, <xobs@kosagi.com>,
	<s.hauer@pengutronix.de>, <yongjun_wei@trendmicro.com.cn>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH -next] PCI: imx6: remove redundant dev_err call in
 imx6_pcie_probe()
Message-ID: <20131012081130.GG21305@S2101-09.ap.freescale.net>
References: <CAPgLHd-M6y2VkZv_TWkOqugXnu=NgFuxyBVskd-2fQjy79u61g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAPgLHd-M6y2VkZv_TWkOqugXnu=NgFuxyBVskd-2fQjy79u61g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 12, 2013 at 02:11:02PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/pci/host/pci-imx6.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 5afa922..51338ac 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -439,7 +439,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  
>  	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
>  	if (IS_ERR(pp->dbi_base)) {
> -		dev_err(&pdev->dev, "unable to remap dbi_base\n");
>  		ret = PTR_ERR(pp->dbi_base);
>  		goto err;
>  	}
> 

