Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39529 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeEVPLd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 11:11:33 -0400
MIME-Version: 1.0
In-Reply-To: <20180521131123.2009-2-marek.vasut+renesas@gmail.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com> <20180521131123.2009-2-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 May 2018 17:11:31 +0200
Message-ID: <CAMuHMdX8_EDhn1+ySeo_eK4eJETGs8ZXS736n92xfv0oNAX4zw@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: rcar: Pull bus clock enable/disable from rcar_pcie_get_resources()
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
> The function does not only get resources, but also enables/disables bus
> clock. This is forgotten in the probe() function though and if anything
> in probe() fails after rcar_pcie_get_resources() is called, the bus
> clock are never disabled.
>
> This patch pulls the clock handling out of the rcar_pcie_get_resources()
> and enables clock after all the resources were requested. Moreover, this
> patch also always disables the clock in case of failure.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
