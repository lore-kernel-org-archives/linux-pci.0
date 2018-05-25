Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44599 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967811AbeEYT1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2018 15:27:44 -0400
MIME-Version: 1.0
In-Reply-To: <20180525183326.5245-1-marek.vasut+renesas@gmail.com>
References: <20180525183326.5245-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 May 2018 21:27:42 +0200
Message-ID: <CAMuHMdUi2uFNOhYB0Y_SH20xfYzqbrBqgn=LgMv4=j+TqyjqWg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Clean up PHY init on failure
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC Sergei

On Fri, May 25, 2018 at 8:33 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> If the Gen3 PHY fails to power up, the code does not undo the
> initialization caused by phy_init(). Add the missing failure
> handling to the rcar_pcie_phy_init_gen3() function.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> Fixes: 517ca93a7159 ("PCI: rcar: Add R-Car gen3 PHY support")

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/pci/host/pcie-rcar.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 695781934f0a..477bf40cc031 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -678,7 +678,11 @@ static int rcar_pcie_phy_init_gen3(struct rcar_pcie *pcie)
>         if (err)
>                 return err;
>
> -       return phy_power_on(pcie->phy);
> +       err = phy_power_on(pcie->phy);
> +       if (err)
> +               phy_exit(pcie->phy);
> +
> +       return err;
>  }
>
>  static int rcar_msi_alloc(struct rcar_msi *chip)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
