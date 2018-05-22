Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41094 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeEVJm2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 05:42:28 -0400
MIME-Version: 1.0
In-Reply-To: <20180521210522.29346-1-marek.vasut+renesas@gmail.com>
References: <20180521210522.29346-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 May 2018 11:42:27 +0200
Message-ID: <CAMuHMdVkeSEsO-jRCzh-_9VkzZ+4X-VAN1KZOA2wB7bUQTrRYg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
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

On Mon, May 21, 2018 at 11:05 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> The data link active signal usually takes ~20 uSec to be asserted,
> poll the bit more often to avoid useless delays in this function.
> Use udelay() instead of usleep() for such a small delay as suggested
> by the timer documentation and because this will be used in atomic
> context later on when the suspend/resume patches land.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -529,13 +529,13 @@ static void phy_write_reg(struct rcar_pcie *pcie,
>
>  static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
>  {
> -       unsigned int timeout = 10;
> +       unsigned int timeout = 10000;
>
>         while (timeout--) {
>                 if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
>                         return 0;
>
> -               msleep(5);
> +               udelay(5);

+ cpu_relax()?

>         }

if this ever happens, it will have blocked for more than 50 ms...

>         return -ETIMEDOUT;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
