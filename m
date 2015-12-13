Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:32853 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbLMK7I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Dec 2015 05:59:08 -0500
MIME-Version: 1.0
In-Reply-To: <1449970917-12633-6-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
	<1449970917-12633-6-git-send-email-paul.gortmaker@windriver.com>
Date: Sun, 13 Dec 2015 11:59:08 +0100
Message-ID: <CAMuHMdUJzRMaRosLSUhH=_1Li+u4eWeqjee6iUoeWfac_2G3wA@mail.gmail.com>
Subject: Re: [PATCH 05/10] drivers/pci: make host/pci-rcar-gen2.c explicitly non-modular
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC MODULE_AUTHOR

On Sun, Dec 13, 2015 at 2:41 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> The Kconfig currently controlling compilation of this code is:
>
> drivers/pci/host/Kconfig:config PCI_RCAR_GEN2
> drivers/pci/host/Kconfig:       bool "Renesas R-Car Gen2 Internal PCI controller"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> We don't have to disallow a driver unbind, since that is already
> done for us in this driver.
>
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
>
> We don't replace module.h with init.h since the file already has that.
>
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/pci/host/pci-rcar-gen2.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index c4f64bfee551..81dda40c7a9f 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -4,6 +4,8 @@
>   * Copyright (C) 2013 Renesas Solutions Corp.
>   * Copyright (C) 2013 Cogent Embedded, Inc.
>   *
> + * Module Author: Valentine Barshak <valentine.barshak@cogentembedded.com>
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> @@ -14,7 +16,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> @@ -366,8 +367,6 @@ static struct of_device_id rcar_pci_of_match[] = {
>         { },
>  };
>
> -MODULE_DEVICE_TABLE(of, rcar_pci_of_match);
> -
>  static struct platform_driver rcar_pci_driver = {
>         .driver = {
>                 .name = "pci-rcar-gen2",
> @@ -376,9 +375,4 @@ static struct platform_driver rcar_pci_driver = {
>         },
>         .probe = rcar_pci_probe,
>  };
> -
> -module_platform_driver(rcar_pci_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("Renesas R-Car Gen2 internal PCI");
> -MODULE_AUTHOR("Valentine Barshak <valentine.barshak@cogentembedded.com>");
> +builtin_platform_driver(rcar_pci_driver);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
