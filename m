Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:40854 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeDIIHO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 04:07:14 -0400
MIME-Version: 1.0
In-Reply-To: <20180408130925.19088-1-marek.vasut+renesas@gmail.com>
References: <20180408130925.19088-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 10:07:13 +0200
Message-ID: <CAMuHMdVGBkEY2kE7auUwXBn2QSfX+yhxkFH--4tTw+XJ3WCk0w@mail.gmail.com>
Subject: Re: [PATCH V5] PCI: rcar: Use runtime PM to control controller clock
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek,

On Sun, Apr 8, 2018 at 3:09 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>
> The controller clock can be switched off during suspend/resume,
> let runtime PM take care of that.
>
> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---
> V2: - Reorder the fail path in rcar_pcie_probe() to cater for the
>       reordering of function calls in probe
>     - Dispose of fail_clk in rcar_pcie_get_resources()
> V3: - Fix up the failpath in probe function
> V4: - Rebase on recent linux-next
> V5: - Do not call pci_free_resource_list(&pcie->resources) if
>       rcar_pcie_parse_request_of_pci_ranges() fails, since that
>       functiona calls pci_free_resource_list() already.

Thanks for the update!

> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c

> @@ -1124,22 +1111,22 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         if (err)
>                 goto err_free_bridge;
>
> +       pm_runtime_enable(pcie->dev);
> +       err = pm_runtime_get_sync(pcie->dev);
> +       if (err < 0) {
> +               dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
> +               goto err_pm_disable;
> +       }
> +

As you moved the pm_runtime setup up...

>         err = rcar_pcie_get_resources(pcie);
>         if (err < 0) {
>                 dev_err(dev, "failed to request resources: %d\n", err);
> -               goto err_free_resource_list;
> +               goto err_pm_put;
>         }
>
>         err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
>         if (err)
> -               goto err_free_resource_list;
> -
> -       pm_runtime_enable(dev);
> -       err = pm_runtime_get_sync(dev);
> -       if (err < 0) {
> -               dev_err(dev, "pm_runtime_get_sync failed\n");
> -               goto err_pm_disable;
> -       }
> +               goto err_pm_put;
>
>         /* Failure to get a link might just be that no cards are inserted */
>         hw_init_fn = of_device_get_match_data(dev);
> @@ -1174,9 +1161,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>
>  err_pm_disable:
>         pm_runtime_disable(dev);

... shouldn't it be moved down here, for symmetry?

> -
> -err_free_resource_list:
>         pci_free_resource_list(&pcie->resources);
> +
>  err_free_bridge:
>         pci_free_host_bridge(bridge);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
