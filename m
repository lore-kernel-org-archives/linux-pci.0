Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36797 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbcBYIEq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Feb 2016 03:04:46 -0500
MIME-Version: 1.0
In-Reply-To: <1456361156-16798-1-git-send-email-horms+renesas@verge.net.au>
References: <1456361156-16798-1-git-send-email-horms+renesas@verge.net.au>
Date: Thu, 25 Feb 2016 09:04:45 +0100
Message-ID: <CAMuHMdUW=3Vx7M2tTHguF2Gs8BAWWcPOVNDPizdPTWyawy8vHg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar, rcar-gen2: Use ARCH_RENESAS
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Simon Horman <horms+renesas@verge.net.au>,
	Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 25, 2016 at 1:45 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig

> @@ -49,7 +49,7 @@ config PCI_RCAR_GEN2
>
>  config PCI_RCAR_GEN2_PCIE
>         bool "Renesas R-Car PCIe controller"
> -       depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> +       depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
>         help
>           Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.

BTW, this looks like a misnomer: the driver supports a compatible value for
R-Car H1, too ("renesas,pcie-r8a7779"), but it's not used in r8a7779.dtsi.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
