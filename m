Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:45698 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab3FJO33 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2013 10:29:29 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so9917220obb.39
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2013 07:29:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370864113-17895-14-git-send-email-tushar.behera@linaro.org>
References: <1370864113-17895-1-git-send-email-tushar.behera@linaro.org>
	<1370864113-17895-14-git-send-email-tushar.behera@linaro.org>
Date: Mon, 10 Jun 2013 19:59:28 +0530
Message-ID: <CAK9yfHzcw071CfssSdFjmN1qXOp732NOaud2G0Dcd_8KZBFbgQ@mail.gmail.com>
Subject: Re: [PATCH 13/15] pci: mvebu: Convert to use devm_ioremap_resource
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
	patches@linaro.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10 June 2013 17:05, Tushar Behera <tushar.behera@linaro.org> wrote:
> Commit 75096579c3ac ("lib: devres: Introduce devm_ioremap_resource()")
> introduced devm_ioremap_resource() and deprecated the use of
> devm_request_and_ioremap().
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> CC: linux-pci@vger.kernel.org
> CC: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-mvebu.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 13a633b..e714876 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -752,7 +752,7 @@ mvebu_pcie_map_registers(struct platform_device *pdev,
>         if (ret)
>                 return NULL;
>
> -       return devm_request_and_ioremap(&pdev->dev, &regs);
> +       return devm_ioremap_resource(&pdev->dev, &regs);
>  }
>
>  static int __init mvebu_pcie_probe(struct platform_device *pdev)
> @@ -842,9 +842,10 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
>                         continue;
>
>                 port->base = mvebu_pcie_map_registers(pdev, child, port);
> -               if (!port->base) {
> +               if (IS_ERR(port->base)) {
>                         dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
>                                 port->port, port->lane);

This error message is redundant.

> +                       port->base = NULL;
Probably this is also not needed.

>                         continue;
>                 }
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With warm regards,
Sachin
