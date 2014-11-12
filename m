Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53669 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbaKLQai (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 11:30:38 -0500
Received: by mail-lb0-f174.google.com with SMTP id w7so946011lbi.5
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:30:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <002801cffe28$43176f70$c9464e50$%han@samsung.com>
References: <002801cffe28$43176f70$c9464e50$%han@samsung.com>
Date: Wed, 12 Nov 2014 22:00:37 +0530
Message-ID: <CA+mB=1+pMxfeqVRbAvDz8RHDg5mEjx=m3+-UL8rrS2wrJ2EkMQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Use tabs for indentation
From: Srikanth Thokala <sriku.linux@gmail.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 8:55 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> This patch fixes the following checkpatch error.
>
>   ERROR: code indent should use tabs where possible
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pci/host/pci-imx6.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Srikanth Thokala <sriku.linux@gmail.com>

- Srikanth

>
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 233fe8a..8a7530b 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -526,8 +526,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>                 }
>
>                 ret = devm_request_irq(&pdev->dev, pp->msi_irq,
> -                                      imx6_pcie_msi_handler,
> -                                      IRQF_SHARED, "mx6-pcie-msi", pp);
> +                                      imx6_pcie_msi_handler,
> +                                      IRQF_SHARED, "mx6-pcie-msi", pp);
>                 if (ret) {
>                         dev_err(&pdev->dev, "failed to request MSI irq\n");
>                         return -ENODEV;
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
