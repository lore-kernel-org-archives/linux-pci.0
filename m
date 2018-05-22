Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:41480 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeEVPSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 11:18:16 -0400
MIME-Version: 1.0
In-Reply-To: <20180521131123.2009-3-marek.vasut+renesas@gmail.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com> <20180521131123.2009-3-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 May 2018 17:18:15 +0200
Message-ID: <CAMuHMdV9_-MRLDP98G5J5v1bojAUmRLvSkyf3Fhmn41t1rpn4g@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: rcar: Add missing irq_dispose_mapping() into failpath
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek,

On Mon, May 21, 2018 at 3:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> The rcar_pcie_get_resources() is another misnomer with a side effect.
> The function does not only get resources, but also maps MSI IRQs via
> irq_of_parse_and_map(). In case anything fails afterward, the IRQ
> mapping must be disposed through irq_dispose_mapping() which is not
> done.
>
> This patch handles irq_of_parse_and_map() failures in by disposing
> of the mapping in rcar_pcie_get_resources() as well as in probe.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -923,18 +923,25 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
>         i = irq_of_parse_and_map(dev->of_node, 0);
>         if (!i) {
>                 dev_err(dev, "cannot get platform resources for msi interrupt\n");
> -               return -ENOENT;
> +               err = -ENOENT;
> +               goto err_irq1;

You could have kept the return here.

>         }
>         pcie->msi.irq1 = i;
>
>         i = irq_of_parse_and_map(dev->of_node, 1);
>         if (!i) {
>                 dev_err(dev, "cannot get platform resources for msi interrupt\n");
> -               return -ENOENT;
> +               err = -ENOENT;
> +               goto err_irq2;
>         }
>         pcie->msi.irq2 = i;
>
>         return 0;
> +
> +err_irq2:
> +       irq_dispose_mapping(pcie->msi.irq1);
> +err_irq1:
> +       return err;
>  }
>
>  static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
