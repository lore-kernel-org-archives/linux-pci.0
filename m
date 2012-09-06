Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33912 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755019Ab2IFXV0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2012 19:21:26 -0400
Received: by lagy9 with SMTP id y9so1477200lag.19
        for <linux-pci@vger.kernel.org>; Thu, 06 Sep 2012 16:21:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1345470395-17295-6-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com> <1345470395-17295-6-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 6 Sep 2012 17:21:04 -0600
Message-ID: <CAErSpo6ZcM-C47kuE5hZ_4c6QiQ-MPPfxiV+XUe8FXfX07=FsA@mail.gmail.com>
Subject: Re: [PATCH 5/8] pci: resource assignment based on p2p alignment
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com, yinghai@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2012 at 7:46 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> The patch changes function pbus_size_io() and pbus_size_mem() to
> do resource (I/O, memory and prefetchable memory) reassignment
> based on the minimal alignments for the p2p bridge, which was
> retrieved by function window_alignment().
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-bus.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 826a4f3..bb2eade 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -741,7 +741,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>         struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
>         unsigned long size = 0, size0 = 0, size1 = 0;
>         resource_size_t children_add_size = 0;
> -       resource_size_t min_align = 4096, align;
> +       resource_size_t io_align, min_align, align;
>
>         if (!b_res)
>                 return;
> @@ -750,8 +750,14 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>          * Per spec, I/O windows are 4K-aligned, but some bridges have an
>          * extension to support 1K alignment.
>          */
> -       if (bus->self->io_window_1k)
> +       if (bus->self->io_window_1k) {
> +               io_align = 4096;

Why is io_align 4K instead of 1K here?

>                 min_align = 1024;
> +       } else {
> +               io_align = window_alignment(bus, IORESOURCE_IO);

This doesn't seem right.  Only the non-1k path uses
window_alignment(), so there's no way for the platform to influence
the alignment of bridges that support 1k windows.  I think the
io_window_1k checking needs to be moved from pbus_size_io() to
window_alignment().

Maybe you can then make the min_align handling in pbus_size_io() more
similar to that in pbus_size_mem(), e.g.,

    min_align = 0;
    ...
    min_align = max(min_align, window_alignment(bus, b_res->flags & mask));

> +               min_align = io_align;
> +       }
> +
>         list_for_each_entry(dev, &bus->devices, bus_list) {
>                 int i;
>
> @@ -778,8 +784,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>                 }
>         }
>
> -       if (min_align > 4096)
> -               min_align = 4096;
> +       if (min_align > io_align)
> +               min_align = io_align;
>
>         size0 = calculate_iosize(size, min_size, size1,
>                         resource_size(b_res), min_align);
> @@ -901,6 +907,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>                         min_align = align1 >> 1;
>                 align += aligns[order];
>         }
> +
> +       min_align = max(min_align, window_alignment(bus, b_res->flags & mask));
>         size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
>         if (children_add_size > add_size)
>                 add_size = children_add_size;
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
