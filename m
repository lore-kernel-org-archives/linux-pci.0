Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbdIRV20 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Sep 2017 17:28:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170911200805.3363318-1-arnd@arndb.de>
References: <20170911200805.3363318-1-arnd@arndb.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 18 Sep 2017 16:28:04 -0500
Message-ID: <CAL_JsqLGhQQOt_Ads2+JpVW=gRDOi141iEh-aWLFmTkg9p62XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [RESEND] of: provide of_n_{addr,size}_cells wrappers
 for !CONFIG_OF
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <damm@opensource.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        SH-Linux <linux-sh@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 11, 2017 at 3:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The pci-rcar driver is enabled for compile tests, and this has
> shown that the driver cannot build without CONFIG_OF,
> following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
> interrupt mapping when possible":
>
> drivers/pci/host/pcie-rcar.c: In function 'pci_dma_range_parser_init':
> drivers/pci/host/pcie-rcar.c:1039:2: error: implicit declaration of function 'of_n_addr_cells' [-Werror=implicit-function-declaration]
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

Sorry, I keep missing this. It's a flaw in my mail filtering...

There's a patch series[1] to factor out pci_dma_range_parser_init of
the driver which should also fix this. I'd prefer not to take this
because ideally all address parsing should be within the DT core code.

Rob

[1] https://patchwork.kernel.org/patch/9927541/
