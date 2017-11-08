Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:47165 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdKHJg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 04:36:59 -0500
MIME-Version: 1.0
In-Reply-To: <20171108091956.8537-1-marek.vasut+renesas@gmail.com>
References: <20171108091956.8537-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Nov 2017 10:36:58 +0100
Message-ID: <CAMuHMdWQG+rC_HsH6MDowtNvZAvhRZESirk2+7GgcmDR3stvaw@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Use runtime PM to control controller clock
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek,

On Wed, Nov 8, 2017 at 10:19 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>
> The controller clock can be switched off during suspend/resume,
> let runtime PM take care of that.
>
> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c

> @@ -1126,6 +1115,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>
>         rcar_pcie_parse_request_of_pci_ranges(pcie);
>
> +       pm_runtime_enable(pcie->dev);
> +       err = pm_runtime_get_sync(pcie->dev);
> +       if (err < 0) {
> +               dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
> +               goto err_pm_disable;
> +       }
> +
>         err = rcar_pcie_get_resources(pcie);
>         if (err < 0) {
>                 dev_err(dev, "failed to request resources: %d\n", err);
> @@ -1136,13 +1132,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         if (err)
>                 goto err_free_bridge;
>
> -       pm_runtime_enable(dev);
> -       err = pm_runtime_get_sync(dev);
> -       if (err < 0) {
> -               dev_err(dev, "pm_runtime_get_sync failed\n");
> -               goto err_pm_disable;
> -       }
> -
>         /* Failure to get a link might just be that no cards are inserted */
>         hw_init_fn = of_device_get_match_data(dev);
>         err = hw_init_fn(pcie);

As you changed initialization order, cleanup order for error handling below
should be updated, too.

Apart from that, this patch looks good to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
