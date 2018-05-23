Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39425 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932391AbeEWLMb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 07:12:31 -0400
MIME-Version: 1.0
In-Reply-To: <20180523105220.25518-1-marek.vasut+renesas@gmail.com>
References: <20180523105220.25518-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 13:12:29 +0200
Message-ID: <CAMuHMdXAgeat-vL0Cvh-w9+Fnvru_WW5g1qYu=ewM_b7fcJ8iQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Remove IRQ mappings in rcar_pcie_enable_msi failpath
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

On Wed, May 23, 2018 at 12:52 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> The rcar_pcie_enable_msi() creates IRQ mappings using irq_create_mapping()
> before requesting the IRQs using devm_request_irq(). If devm_request_irq()
> fails for some reason, rcar_pcie_enable_msi() does not remove the mapping.
>
> Pull out the code for disposing IRQ mappings from rcar_pcie_teardown_msi()
> into a separate function and call it from both rcar_pcie_teardown_msi()
> and rcar_pcie_enable_msi() failpath to remove the mappings correctly.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks a lot!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
