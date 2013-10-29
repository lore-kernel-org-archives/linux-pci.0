Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:46151 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab3J2TZ4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 15:25:56 -0400
Received: by mail-ie0-f173.google.com with SMTP id u16so555825iet.4
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2013 12:25:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPgLHd-M6y2VkZv_TWkOqugXnu=NgFuxyBVskd-2fQjy79u61g@mail.gmail.com>
References: <CAPgLHd-M6y2VkZv_TWkOqugXnu=NgFuxyBVskd-2fQjy79u61g@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 29 Oct 2013 13:25:35 -0600
Message-ID: <CAErSpo4cvHuTg9Shty12-zp762LBtHpQZuN6qATfB8S24Hc_bQ@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: imx6: remove redundant dev_err call in imx6_pcie_probe()
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	yongjun_wei@trendmicro.com.cn,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 12, 2013 at 12:11 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied with ack and reviewed-by to my pci/host-imx6 branch for v3.13, thanks!

Bjorn

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
>         pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
>         if (IS_ERR(pp->dbi_base)) {
> -               dev_err(&pdev->dev, "unable to remap dbi_base\n");
>                 ret = PTR_ERR(pp->dbi_base);
>                 goto err;
>         }
>
