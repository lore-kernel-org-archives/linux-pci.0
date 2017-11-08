Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:49606 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdKHJ3E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 04:29:04 -0500
MIME-Version: 1.0
In-Reply-To: <20171108091521.8423-1-marek.vasut+renesas@gmail.com>
References: <20171108091521.8423-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Nov 2017 10:29:02 +0100
Message-ID: <CAMuHMdV=SHkjpBqCXPzcEnunhWRNLdw+1GwLAS7nbkfQQz3zyA@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Add compatible string for r8a7796
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek,

On Wed, Nov 8, 2017 at 10:15 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
>
> Add compatible string for the RCar M3 R8A7796 SoC.
>
> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

This patch is not needed, as the DT bindings specify that the DTS should use
both "renesas,pcie-r8a7796" and "renesas,pcie-rcar-gen3", and the driver
already matches against the latter.

> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1062,6 +1062,7 @@ static const struct of_device_id rcar_pcie_of_match[] = {
>         { .compatible = "renesas,pcie-rcar-gen2",
>           .data = rcar_pcie_hw_init_gen2 },
>         { .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
> +       { .compatible = "renesas,pcie-r8a7796", .data = rcar_pcie_hw_init },
>         { .compatible = "renesas,pcie-rcar-gen3", .data = rcar_pcie_hw_init },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
