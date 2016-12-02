Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36781 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbcLBLow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2016 06:44:52 -0500
MIME-Version: 1.0
In-Reply-To: <1480675020-26346-2-git-send-email-horms+renesas@verge.net.au>
References: <1480675020-26346-1-git-send-email-horms+renesas@verge.net.au> <1480675020-26346-2-git-send-email-horms+renesas@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 Dec 2016 12:44:50 +0100
Message-ID: <CAMuHMdWXqZz6doeo4M6cWsLdNCX2wTO12bkwP4RY_epQDVN8EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3 pci/next] PCI: rcar-gen2: Use gen2 fallback
 compatibility last
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

On Fri, Dec 2, 2016 at 11:36 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Fallback compatibility strings should be used only if more specific ones
> are matched and the order of compatibility strings in the corresponding
> struct of_device_id should implement this.
>
> This does not have a run-time effect as current all relevant compatibility
> strings result in the same initialisation.
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
