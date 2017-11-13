Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:50376 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbdKMIO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2017 03:14:29 -0500
MIME-Version: 1.0
In-Reply-To: <20171110215411.31912-1-marek.vasut+renesas@gmail.com>
References: <20171110215411.31912-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Nov 2017 09:14:27 +0100
Message-ID: <CAMuHMdU-nxv9WAgi2sD9CAwTG3yBD=H_uPtousLYxHScoK=k3g@mail.gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Use runtime PM to control controller clock
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 10:54 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>
> The controller clock can be switched off during suspend/resume,
> let runtime PM take care of that.
>
> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
