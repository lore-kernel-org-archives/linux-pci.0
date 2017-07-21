Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33087 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbdGUU5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2017 16:57:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170721202012.3360244-1-arnd@arndb.de>
References: <20170721202012.3360244-1-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Jul 2017 22:57:09 +0200
Message-ID: <CAMuHMdV3Gm6S52kZ095MiJAbBMw1fr_bn1Z2TRBoDevQuhyavQ@mail.gmail.com>
Subject: Re: [PATCH] of: provide of_n_{addr,size}_cells wrappers for !CONFIG_OF
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <damm@opensource.se>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Alan Tull <atull@opensource.altera.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Richard Fitzgerald <rf@opensource.wolfsonmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Fri, Jul 21, 2017 at 10:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The pci-rcar driver is enabled for compile tests, and this has
> now shown that the driver cannot build without CONFIG_OF,
> following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
> interrupt mapping when possible":

That commit is for pci-rcar-gen2.c, not pcie-rcar.c.

> ../drivers/pci/host/pcie-rcar.c: In function 'pci_dma_range_parser_init':
> ../drivers/pci/host/pcie-rcar.c:856:2: error: implicit declaration of function 'of_n_addr_cells' [-Werror=implicit-function-declaration]

The line number has changed to 1039 during the last 3 years?

>   parser->pna = of_n_addr_cells(node);
>   ^
> As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
> supposed to build fine, which we can achieve if we make the
> declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
> and provide an empty inline function otherwise, as we do for
> a lot of other of interfaces.
>
> This lets us build the rcar_pci driver again without CONFIG_OF
> for build testing. All platforms using this driver select OF,
> so this doesn't change anything for the users.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Magnus Damm <damm@opensource.se>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org

Apart from that, for the actual change:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
