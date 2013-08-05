Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:46259 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab3HETvy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 15:51:54 -0400
Received: by mail-qc0-f169.google.com with SMTP id m15so1958280qcq.28
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2013 12:51:53 -0700 (PDT)
Date: Mon, 5 Aug 2013 13:51:49 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130805195149.GA19127@google.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
 <CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 05, 2013 at 12:05:03PM -0700, Yinghai Lu wrote:
> On Mon, Aug 5, 2013 at 10:58 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > [+cc Yinghai]
> >
> > After the loop we have this (added by Yinghai in fd5913411):
> >
> >     if (min_align > io_align)
> >         min_align = io_align;
> >
> > I don't understand this.  There are three cases:
> >
> > 1) No downstream bridges: min_align <= 256 because I/O BARs are
> > limited to 256 bytes.
> > 2) All downstream bridges have 1K extension: min_align = 1024.
> > 3) At least one downstream bridge requires 4K alignment: min_align = 4096.
> >
> > "io_align" is the minimum alignment enforced by the bridge.  This is
> > independent of any devices below the bridge, so "io_align >= 1024" in
> > all cases.
> >
> > Therefore, the "min_align = io_align" assignment only happens in case
> > 3, when a downstream bridge requires 4K alignment and *this* bridge
> > supports the 1K extension.  But that seems wrong.  The downstream
> > bridge's 4K requirement also applies to all bridges all the way
> > upstream.
> >
> > It looks to me like this test should instead be:
> >
> >     if (min_align < io_align)
> >         min_align = io_align;
> 
> before my change, min_align always set to 4096.
> in the loop to get min_align, dev resource could have size bigger than
> 4k, those resource will have SIZEALIGN, so final min_align could be
> more than 4096.
> so at last we cap it to 4096 again.

To make sure I understand this, I think (correct me if I'm wrong):

  - Every device BAR resource will have IORESOURCE_SIZEALIGN set since it
    must be naturally aligned on its size (sec 6.2.5.1 of PCI spec r3.0).

  - Bridge window resources will have IORESOURCE_STARTALIGN set and
    res->start contains the required alignment, i.e., 1MB for MEM windows,
    4K for architected I/O windows, 1K for bridges with 1K extension, or
    larger values for arch-specific requirements.

> But according to your findings: "I/O BARs are limited to 256 bytes"
> we should not worry about that.

This is also per sec 6.2.5.1 of PCI spec r3.0: "Devices that map control
functions into I/O Space must not consume more than 256 bytes per I/O Base
Address register."

> So we should just drop io_align and checking like attached patch.
> (min_align is already set to 1k or 4k before the looping.)
> 
> and that should solve Wei Yang's problem.

[I inlined your patch for commenting.  You're welcome :)]

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 64a7de2..edaa9e8 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -816,12 +816,12 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
>  	unsigned long size = 0, size0 = 0, size1 = 0;
>  	resource_size_t children_add_size = 0;
> -	resource_size_t min_align, io_align, align;
> +	resource_size_t min_align, align;
>  
>  	if (!b_res)
>   		return;
>  
> -	io_align = min_align = window_alignment(bus, IORESOURCE_IO);
> +	min_align = window_alignment(bus, IORESOURCE_IO);

I like this change.

>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		int i;
>  
> @@ -848,8 +848,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  		}
>  	}
>  
> -	if (min_align > io_align)
> -		min_align = io_align;
> +	if (min_align > PCI_P2P_DEFAULT_IO_ALIGN)
> +		min_align = PCI_P2P_DEFAULT_IO_ALIGN;

But I still don't understand this one.  As far as I can tell,
"min_align > 4096" can happen only for arch-specific I/O window
requirements.  It can never happen because of a large device I/O BAR.

Let's assume "min_align = window_alignment(bus, IORESOURCE_IO)" above set
min_align to 16KB because that's what pnv_pci_window_alignment() returned.
Why would we cap it to 4KB here?  I think we should set this:

    b_res->start = 16384;
    b_res->end = b_res->start + size0 - 1;
    b_res->flags |= IORESOURCE_STARTALIGN;

to indicate that the bridge needs a 16KB-aligned I/O window.

In what case do we need to cap min_align to 4KB?

>  	size0 = calculate_iosize(size, min_size, size1,
>  			resource_size(b_res), min_align);
