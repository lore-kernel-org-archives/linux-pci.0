Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:52241 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbLMSPd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Dec 2015 13:15:33 -0500
Date: Sun, 13 Dec 2015 13:15:17 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Valentine Barshak <valentine.barshak@cogentembedded.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Joe Perches <joe@perches.com>
Subject: Re: [PATCH 05/10] drivers/pci: make host/pci-rcar-gen2.c explicitly
 non-modular
Message-ID: <20151213181517.GB32362@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <1449970917-12633-6-git-send-email-paul.gortmaker@windriver.com>
 <CAMuHMdUJzRMaRosLSUhH=_1Li+u4eWeqjee6iUoeWfac_2G3wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAMuHMdUJzRMaRosLSUhH=_1Li+u4eWeqjee6iUoeWfac_2G3wA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH 05/10] drivers/pci: make host/pci-rcar-gen2.c explicitly non-modular] On 13/12/2015 (Sun 11:59) Geert Uytterhoeven wrote:

> CC MODULE_AUTHOR

Thanks, I just assumed get-maintainer.pl would have automatically
collected that up with the other names it emits.  Apparently not.

Joe: is there a reason it doesn't use the module author field?

Paul.
--

> 
> On Sun, Dec 13, 2015 at 2:41 AM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > The Kconfig currently controlling compilation of this code is:
> >
> > drivers/pci/host/Kconfig:config PCI_RCAR_GEN2
> > drivers/pci/host/Kconfig:       bool "Renesas R-Car Gen2 Internal PCI controller"
> >
> > ...meaning that it currently is not being built as a module by anyone.
> >
> > Lets remove the modular code that is essentially orphaned, so that
> > when reading the driver there is no doubt it is builtin-only.
> >
> > We don't have to disallow a driver unbind, since that is already
> > done for us in this driver.
> >
> > Since module_platform_driver() uses the same init level priority as
> > builtin_platform_driver() the init ordering remains unchanged with
> > this commit.
> >
> > We don't replace module.h with init.h since the file already has that.
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
> >  drivers/pci/host/pci-rcar-gen2.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> > index c4f64bfee551..81dda40c7a9f 100644
> > --- a/drivers/pci/host/pci-rcar-gen2.c
> > +++ b/drivers/pci/host/pci-rcar-gen2.c
> > @@ -4,6 +4,8 @@
> >   * Copyright (C) 2013 Renesas Solutions Corp.
> >   * Copyright (C) 2013 Cogent Embedded, Inc.
> >   *
> > + * Module Author: Valentine Barshak <valentine.barshak@cogentembedded.com>
> > + *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> > @@ -14,7 +16,6 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> > -#include <linux/module.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> > @@ -366,8 +367,6 @@ static struct of_device_id rcar_pci_of_match[] = {
> >         { },
> >  };
> >
> > -MODULE_DEVICE_TABLE(of, rcar_pci_of_match);
> > -
> >  static struct platform_driver rcar_pci_driver = {
> >         .driver = {
> >                 .name = "pci-rcar-gen2",
> > @@ -376,9 +375,4 @@ static struct platform_driver rcar_pci_driver = {
> >         },
> >         .probe = rcar_pci_probe,
> >  };
> > -
> > -module_platform_driver(rcar_pci_driver);
> > -
> > -MODULE_LICENSE("GPL v2");
> > -MODULE_DESCRIPTION("Renesas R-Car Gen2 internal PCI");
> > -MODULE_AUTHOR("Valentine Barshak <valentine.barshak@cogentembedded.com>");
> > +builtin_platform_driver(rcar_pci_driver);
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
