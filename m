Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36552 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759584AbcLBLoS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2016 06:44:18 -0500
MIME-Version: 1.0
In-Reply-To: <1480675020-26346-4-git-send-email-horms+renesas@verge.net.au>
References: <1480675020-26346-1-git-send-email-horms+renesas@verge.net.au> <1480675020-26346-4-git-send-email-horms+renesas@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 Dec 2016 12:44:16 +0100
Message-ID: <CAMuHMdW6-qF46EoJPKOXy_P4-JMc0kS7i53sDv4UHshcTFZnRw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3 pci/next] PCI: rcar: Add gen3 fallback
 compatibility string for pcie-rcar
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 2, 2016 at 11:37 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add fallback compatibility string for the  R-Car Gen 3 family.  This is in
> keeping with the both the existing fallback compatibility string for the
> R-Car Gen 2 family and the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
