Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34625 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbdFGHTv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2017 03:19:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170606230007.19101-7-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-7-palmer@dabbelt.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jun 2017 09:19:49 +0200
Message-ID: <CAMuHMdUiuqB3vPYkAJfP5+qotcH=o1gJnH8Mosr9VSKxAQGJMQ@mail.gmail.com>
Subject: Re: [PATCH 06/17] pci: Add generic pcibios_{fixup_bus,align_resource}
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        albert@sifive.com, patches@groups.riscv.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC pci folks

On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> While upstreaming the RISC-V port, it was pointed out that multiple
> architectures (arc, arm64, cris, microblaze, sh, tile) have copied the
> mostly empty versions of at least one of these functions.  This defines
> weakly bound versions of the common functions so other architetures can
> use them.
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  drivers/pci/Makefile |  2 +-
>  drivers/pci/bios.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/bios.c
>
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index a29d9ec05d13..fa7040915194 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -4,7 +4,7 @@
>
>  obj-y          += access.o bus.o probe.o host-bridge.o remove.o pci.o \
>                         pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
> -                       irq.o vpd.o setup-bus.o vc.o mmap.o
> +                       irq.o vpd.o setup-bus.o vc.o mmap.o bios.o
>  obj-$(CONFIG_PROC_FS) += proc.o
>  obj-$(CONFIG_SYSFS) += slot.o
>
> diff --git a/drivers/pci/bios.c b/drivers/pci/bios.c
> new file mode 100644
> index 000000000000..ffe34c024aa8
> --- /dev/null
> +++ b/drivers/pci/bios.c
> @@ -0,0 +1,42 @@
> +/*
> + * Code borrowed from arch/arm64/kernel/pci.c
> + *   which borrowed from powerpc/kernel/pci-common.c
> + *   which borrowed from arch/alpha/kernel/pci.c
> + *
> + * Extruded from code written by
> + *      Dave Rusling (david.rusling@reo.mts.dec.com)
> + *      David Mosberger (davidm@cs.arizona.edu)
> + * Copyright (C) 1999 Andrea Arcangeli <andrea@suse.de>
> + * Copyright (C) 2000 Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> + * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
> + * Copyright (C) 2014 ARM Ltd.
> + * Copyright (C) 2017 SiFive
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + */
> +
> +/* This file contains weakly bound functions that implement pcibios functions
> + * that some architectures have copied verbatim.
> + */
> +
> +#include <linux/pci.h>
> +
> +/*
> + * Called after each bus is probed, but before its children are examined
> + */
> +__attribute__ ((weak))
> +void pcibios_fixup_bus(struct pci_bus *bus)
> +{
> +       /* nothing to do, expected to be removed in the future */
> +}
> +/*
> + * We don't have to worry about legacy ISA devices, so nothing to do here
> + */
> +__attribute__ ((weak))
> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> +                                      resource_size_t size, resource_size_t align)
> +{
> +       return res->start;
> +}
> --
> 2.13.0
