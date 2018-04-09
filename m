Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39462 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDIIIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 04:08:39 -0400
MIME-Version: 1.0
In-Reply-To: <20180408180431.17323-1-marek.vasut+renesas@gmail.com>
References: <20180408180431.17323-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 10:08:38 +0200
Message-ID: <CAMuHMdVd17nk9h_gJxdRdjDypWFyn3Mc_fXRvLg8cbs_rSJEjA@mail.gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Clean up the macros
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

On Sun, Apr 8, 2018 at 8:04 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> This patch replaces the (1 << n) with BIT(n) and cleans up whitespace,
> no functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
