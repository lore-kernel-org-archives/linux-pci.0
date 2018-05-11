Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55934 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeEKGRf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 May 2018 02:17:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id a8-v6so913609wmg.5
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2018 23:17:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525998019-28634-10-git-send-email-shawn.guo@linaro.org>
References: <1525998019-28634-1-git-send-email-shawn.guo@linaro.org> <1525998019-28634-10-git-send-email-shawn.guo@linaro.org>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Fri, 11 May 2018 11:47:34 +0530
Message-ID: <CAHM4w1mP=L14=u5tQn2LOHgUkM8HJ9bXZu=gkNhe4uYod3ZgVQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] PCI: spear13xx: Drop unnecessary root_bus_nr setting
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 5:50 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Function dw_pcie_host_init() already initializes the root_bus_nr field
> of 'struct pcie_port', so the -1 assignment prior to calling
> dw_pcie_host_init() in platform specific driver is not really needed.
> Drop it.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

> ---
>  drivers/pci/dwc/pcie-spear13xx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
> index ecb58f7b7566..7d0cdfd8138b 100644
> --- a/drivers/pci/dwc/pcie-spear13xx.c
> +++ b/drivers/pci/dwc/pcie-spear13xx.c
> @@ -210,7 +210,6 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
>                 return ret;
>         }
>
> -       pp->root_bus_nr = -1;
>         pp->ops = &spear13xx_pcie_host_ops;
>
>         ret = dw_pcie_host_init(pp);
> --
> 1.9.1
>
