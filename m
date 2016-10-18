Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33561 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbcJRCWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 22:22:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id l131so93744lfl.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2016 19:22:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1476716173-31310-1-git-send-email-weiyj.lk@gmail.com>
References: <1476716173-31310-1-git-send-email-weiyj.lk@gmail.com>
From: Ley Foon Tan <lftan@altera.com>
Date: Tue, 18 Oct 2016 10:22:30 +0800
Message-ID: <CAFiDJ5_K0wK6QH6=adSDm_2PbqnyaVWCyJZtX3DPSZQkHd-QKg@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: altera: Remove redundant dev_err call in altera_pcie_parse_dt()
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Rocketboard Maillist <rfi@lists.rocketboards.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 10:56 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/host/pcie-altera.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index b0ac4df..8be45a8 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -550,10 +550,8 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>
>         cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
>         pcie->cra_base = devm_ioremap_resource(dev, cra);
> -       if (IS_ERR(pcie->cra_base)) {
> -               dev_err(dev, "failed to map cra memory\n");
> +       if (IS_ERR(pcie->cra_base))
>                 return PTR_ERR(pcie->cra_base);
> -       }
>
>         /* setup IRQ */
>         pcie->irq = platform_get_irq(pdev, 0);
>
Acked-by: Ley Foon Tan <lftan@altera.com>
