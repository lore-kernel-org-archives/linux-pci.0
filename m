Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34641 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbcDUNii (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2016 09:38:38 -0400
MIME-Version: 1.0
In-Reply-To: <1461210715-29304-1-git-send-email-horms+renesas@verge.net.au>
References: <1461210715-29304-1-git-send-email-horms+renesas@verge.net.au>
Date: Thu, 21 Apr 2016 15:38:35 +0200
Message-ID: <CAMuHMdXtVvNERECxbp1EtJ1SNOQG-j_xtV3NpsGqgyDLmc7cOg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 21, 2016 at 5:51 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> It appears that Gen2 is a misnomer for the R-Car PCIE driver
> which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
> from the help text and Kconfig symbol.
>
> Also, re-arange the Kconfig symbol name to use PCIE as the prefix.
> This appears to be in keeping with other PCIE Kconfig symbols.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
