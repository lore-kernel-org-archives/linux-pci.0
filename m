Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33422 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbbLNITb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 03:19:31 -0500
MIME-Version: 1.0
In-Reply-To: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
Date: Mon, 14 Dec 2015 09:19:30 +0100
Message-ID: <CAMuHMdXr=ErCO3R2LB+wBJh3JSiFkH5q3-FLSTOwdGT87fXz3A@mail.gmail.com>
Subject: Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular host/pci*
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Simon Horman <horms@verge.net.au>, linux-tegra@vger.kernel.org,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	rfi@lists.rocketboards.org, Ley Foon Tan <lftan@altera.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Paul,

On Sun, Dec 13, 2015 at 2:41 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> This series of commits is a slice of a larger project to ensure
> people don't have dead code for module removal in non-modular
> drivers.  Overall there was roughly 5k lines of dead code in the
> kernel due to this.  So far we've fixed several areas, like tty,
> x86, net, etc. and we continue to work on other areas.
>
> There are several reasons to not use module_init for code that can
> never be built as a module, but the big ones are:
>
>  (1) it is easy to accidentally code up unused module_exit and remove code
>  (2) it can be misleading when reading the source, thinking it can be
>       modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else.
>
> Here we convert some module_init() calls into device_initcall() and delete
> any module_exit and remove code that gets orphaned in the process, for
> an overall net code reduction, which is always welcome.
>
> The use of device_initcall ensures that the init function ordering
> remains unchanged, but one could argue that PCI host code might be more
> appropriate to be handled under subsys_initcall.  Fortunately we can
> revisit making this extra change at a later date if desired; it does
> not need to happen now, and we reduce the risk of introducing
> regressions at this point in time by separating the two changes.
>
> Over half of the drivers changed here already explicitly disallowed any
> unbind operations.  For the rest we make them the same, since there is
> not really any sensible use case to unbind any built-in bus support that
> I can think of.

Personally, I think all of these should become tristate, so distro kernels
don't have to build in PCI(e) support for all SoCs. multi_v7_defconfig kernels
are becoming too big.

That does not preclude making these modules un-unloadable, though.

> Paul Gortmaker (10):
>   drivers/pci: make host/pci-imx6.c driver explicitly non-modular
>   drivers/pci: make host/pcie-spear13xx.c driver explicitly non-modular
>   drivers/pci: make host/pci-mvebu.c explicitly non-modular
>   drivers/pci: make host/pci-dra7xx.c explicitly non-modular
>   drivers/pci: make host/pci-rcar-gen2.c explicitly non-modular
>   drivers/pci: make host/pci-tegra.c explicitly non-modular
>   drivers/pci: make host/pcie-rcar.c explicitly non-modular
>   drivers/pci: make host/pcie-xilinx.c explicitly non-modular
>   drivers/pci: make host/pci-keystone.c explicitly non-modular
>   drivers/pci: make host/pcie-altera.c explicitly non-modular

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
