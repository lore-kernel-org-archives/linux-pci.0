Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35574 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbcC2Gu4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 02:50:56 -0400
MIME-Version: 1.0
In-Reply-To: <1459222998-2855-1-git-send-email-horms+renesas@verge.net.au>
References: <1459222998-2855-1-git-send-email-horms+renesas@verge.net.au>
Date: Tue, 29 Mar 2016 08:50:55 +0200
Message-ID: <CAMuHMdUYUFGho2jN-mxa143MnGLZWtrx+Rg5Ba4W_BG4iJu4zg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 29, 2016 at 5:43 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> It appears that Gen2 is a misnomer for the R-Car PCIE driver
> which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
> from the help text and Kconfig symbol.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Bjorn, if this patch is acceptable I would like to request that we
> co-ordinate things so that I can queue-up corresponding updates for
> arm and arm64 defconfigs in the same release. From my point of view
> v4.7 would make sense.
> ---
>  drivers/pci/host/Kconfig  | 4 ++--
>  drivers/pci/host/Makefile | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 7a0780d56d2d..9109c6c5298c 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -69,11 +69,11 @@ config PCI_RCAR_GEN2
>           There are 3 internal PCI controllers available with a single
>           built-in EHCI/OHCI host controller present on each one.
>
> -config PCI_RCAR_GEN2_PCIE
> +config PCI_RCAR_PCIE

Following the pattern in drivers/pci/host/Kconfig, I think this symbol should
be called PCIE_RCAR.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
