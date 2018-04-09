Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:38684 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeDIIes (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 04:34:48 -0400
MIME-Version: 1.0
In-Reply-To: <4462b4d1-1e56-d6d2-ad38-8f02405d1d96@cogentembedded.com>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com> <4462b4d1-1e56-d6d2-ad38-8f02405d1d96@cogentembedded.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 10:34:47 +0200
Message-ID: <CAMuHMdX=Hd3c4m0cWt1wz3umP2XmhSg2s1dNizjvPdueVEd7JA@mail.gmail.com>
Subject: Re: [PATCH 4/4] pcie-rcar: factor out rcar_pcie_hw_init() call
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 6, 2018 at 1:10 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> We now have rcar_pcie_hw_init_{h1|gen2|gen3}() differing only in the PCIe
> PHY init code and all ending with a call to rcar_pcie_hw_init(), thus it
> makes  sense to move that call into the driver's probe() method and then
> rename those functions to rcar_pcie_phy_init_{h1|gen2|gen3}() -- doing
> this saves 48 bytes of object code (AArch64 gcc 4.8.5)...
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
