Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:35029 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbbLMSUU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Dec 2015 13:20:20 -0500
Date: Sun, 13 Dec 2015 13:20:06 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Phil Edworthy <phil.edworthy@renesas.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH 07/10] drivers/pci: make host/pcie-rcar.c explicitly
 non-modular
Message-ID: <20151213182006.GC32362@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <1449970917-12633-8-git-send-email-paul.gortmaker@windriver.com>
 <CAMuHMdWF+g4hwzcCRGkTYM=TpiBmxOn3GYmr+zO8c0QJUgH1fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAMuHMdWF+g4hwzcCRGkTYM=TpiBmxOn3GYmr+zO8c0QJUgH1fg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH 07/10] drivers/pci: make host/pcie-rcar.c explicitly non-modular] On 13/12/2015 (Sun 11:58) Geert Uytterhoeven wrote:

> CC MODULE_AUTHOR

Yep, thanks -- I'll check for future sends to ensure get_maintainer.pl
hasn't omitted the module author.  Looks like it may emit the module
author if they have been actively committing, but that won't work in the
authored and then largely left it alone case.

P.
--

> 
> On Sun, Dec 13, 2015 at 2:41 AM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > The Kconfig currently controlling compilation of this code is:
> >
> > drivers/pci/host/Kconfig:config PCI_RCAR_GEN2_PCIE
> > drivers/pci/host/Kconfig:       bool "Renesas R-Car PCIe controller"
> >
> > ...meaning that it currently is not being built as a module by anyone.
> >
> > Lets remove the modular code that is essentially orphaned, so that
> > when reading the driver there is no doubt it is builtin-only.
> >
> > Since module_platform_driver() uses the same init level priority as
> > builtin_platform_driver() the init ordering remains unchanged with
> > this commit.
> >
> > We don't have to disallow a driver unbind, since that is already
> > done for us in this driver.
> >
> > Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> >
> > We also delete the MODULE_LICENSE tag etc. since all that information
> > was (or is now) contained at the top of the file in the comments.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-sh@vger.kernel.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  drivers/pci/host/pcie-rcar.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > index f4fa6c537448..2c619277d265 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -7,6 +7,8 @@
> >   *  arch/sh/drivers/pci/ops-sh7786.c
> >   *  Copyright (C) 2009 - 2011  Paul Mundt
> >   *
> > + * Module Author: Phil Edworthy <phil.edworthy@renesas.com>
> > + *
> >   * This file is licensed under the terms of the GNU General Public
> >   * License version 2.  This program is licensed "as is" without any
> >   * warranty of any kind, whether express or implied.
> > @@ -18,7 +20,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> > -#include <linux/module.h>
> > +#include <linux/init.h>
> >  #include <linux/msi.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> > @@ -921,7 +923,6 @@ static const struct of_device_id rcar_pcie_of_match[] = {
> >         { .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init },
> >         {},
> >  };
> > -MODULE_DEVICE_TABLE(of, rcar_pcie_of_match);
> >
> >  static int rcar_pcie_probe(struct platform_device *pdev)
> >  {
> > @@ -1007,8 +1008,4 @@ static struct platform_driver rcar_pcie_driver = {
> >         },
> >         .probe = rcar_pcie_probe,
> >  };
> > -module_platform_driver(rcar_pcie_driver);
> > -
> > -MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
> > -MODULE_DESCRIPTION("Renesas R-Car PCIe driver");
> > -MODULE_LICENSE("GPL v2");
> > +builtin_platform_driver(rcar_pcie_driver);
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
