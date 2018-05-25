Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36166 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935638AbeEYKJ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2018 06:09:28 -0400
MIME-Version: 1.0
In-Reply-To: <20180524143624.26718-7-marek.vasut+renesas@gmail.com>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com> <20180524143624.26718-7-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 May 2018 12:09:27 +0200
Message-ID: <CAMuHMdV7Tg3pnxZ7jNhWziwQMXSEt2SihtbM_9RQbqQJc=o2Nw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] PCI: rcar: Shut the PHY down in failpath
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
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

On Thu, May 24, 2018 at 4:36 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> If anything fails past phy_init_fn() and the system is a Gen3 with
> a PHY, the PHY will be left on and inited. This is caused by the
> phy_init_fn, which is in fact a pointer to rcar_pcie_phy_init_gen3()
> function, which starts the PHY, yet has no counterpart in the failpath.
> Add that counterpart.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Note that there's another unhandled failure mode: rcar_pcie_phy_init_gen3()
doesn't call phy_exit() if phy_power_on() fails.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
