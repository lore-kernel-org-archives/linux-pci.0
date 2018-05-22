Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44167 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeEVKx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 06:53:59 -0400
MIME-Version: 1.0
In-Reply-To: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 May 2018 12:53:57 +0200
Message-ID: <CAMuHMdXVXTtmbEHEgzjVg0Wp3c5nc5_pBhndoqH6y6jgmxUnKw@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: rcar: Rename rcar_pcie_parse_request_of_pci_ranges()
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

On Mon, May 21, 2018 at 3:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> The function name is just too confusing, rename it, no functional change.
> Rename the function to rcar_pcie_alloc_and_parse_pci_resource_list() as
> it's matching failpath function is pci_free_resource_list() so the names
> align much better and the new name also describes what the function does
> much better.
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
