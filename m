Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36369 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbbEETHd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2015 15:07:33 -0400
Received: by iebrs15 with SMTP id rs15so153349500ieb.3
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2015 12:07:32 -0700 (PDT)
Date: Tue, 5 May 2015 14:07:29 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Yijing Wang <wangyijing@huawei.com>,
	PCI <linux-pci@vger.kernel.org>,
	"Herui (Ray)" <Ray.herui@huawei.com>
Subject: Re: Assign mem resource fail after remove and rescan
Message-ID: <20150505190729.GA24643@google.com>
References: <55167C1C.6010001@huawei.com>
 <CAE9FiQWWNmJA1qKDaumuc8+EOj7E+fhbaZaNzTVyaDzbX4j9Hg@mail.gmail.com>
 <551A40E8.4080708@huawei.com>
 <CAE9FiQUQ_Kz8sNzu9RmOfoe4xEwfZ3atGcfQ39UAp4dRz2rRFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUQ_Kz8sNzu9RmOfoe4xEwfZ3atGcfQ39UAp4dRz2rRFA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 01, 2015 at 03:21:38PM -0700, Yinghai Lu wrote:
> On Mon, Mar 30, 2015 at 11:38 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> > On 2015/3/29 14:18, Yinghai Lu wrote:
> >> On Sat, Mar 28, 2015 at 3:02 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> >>> ...
> >>>
> >>> I compared above log and found after we did remove and rescan, the bridge requested resource size extended to 0x06000000,
> >>> and when system boot up, it requested only 0x4800000.
> >>>
> >    I tested it, remove and rescan 05:19.0 device is ok now, but
> > if do the operations for the parent device of 05:19.0, the result is
> > still fail.
> 
> Found the problem, attached patch should fix the problem.
> 
> Thanks
> 
> Yinghai

> Subject: [PATCH] PCI: Optimize bus mem sizing to small size
> 
> Current code try to get min_align as possible and use that to
> align final size.
> 
> That could cause generate wrong align/size or too big size in some case.
> 
>  when we have align/size: 16M/64M
>  min_align/size0 will be 8M/64M, that is wrong, align must be 16M.
> 
>  when we have align/size: 1M/1M, 64M/64M,
>  min_align/size0 will be 32M/96M, that is way too big for sum size 65M.
> 
> That will cuase allocation fails.
> 
> The patch introduce max_align/size0_max, and size0_max is just
> sum of all children resource.
> 
> Prefer small size instead of small align. Only use min_align when
> two size is the same.
> 
> The new size will only need to be aligned to bus window alignment.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

I'm sorry, I can't make any sense out of this.  I can't understand
what you're trying to say.

A specific simple example might help.

Is this a regression?  Should it be marked for stable?  If so, how far
back?

It doesn't apply on v4.1-rc2 (I would apply it manually if I could
understand the changelog and comments, but you might as well refresh it at
the same time as you rewrite those).

Please include a link to the problem report.

Please include the patch inline in the message.  It is a significant hassle
for me to deal with attachments, and you are the only major contributor who
uses them.

Bjorn

> ---
>  drivers/pci/setup-bus.c |   50 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -882,12 +882,14 @@ static void pbus_size_io(struct pci_bus
>  	}
>  
>  	size0 = calculate_iosize(size, min_size, size1,
> -			resource_size(b_res), min_align);
> +				 resource_size(b_res),
> +				 window_alignment(bus, IORESOURCE_IO));
>  	if (children_add_size > add_size)
>  		add_size = children_add_size;
>  	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
>  		calculate_iosize(size, min_size, add_size + size1,
> -			resource_size(b_res), min_align);
> +				 resource_size(b_res),
> +				 window_alignment(bus, IORESOURCE_IO));
>  	if (!size0 && !size1) {
>  		if (b_res->start || b_res->end)
>  			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
> @@ -962,6 +964,8 @@ static int pbus_size_mem(struct pci_bus
>  	struct resource *b_res = find_free_bus_resource(bus,
>  					mask | IORESOURCE_PREFETCH, type);
>  	resource_size_t children_add_size = 0;
> +	resource_size_t max_align = 0, size0_max;
> +	int count = 0;
>  
>  	if (!b_res)
>  		return -ENOSPC;
> @@ -1016,19 +1020,59 @@ static int pbus_size_mem(struct pci_bus
>  			if (order > max_order)
>  				max_order = order;
>  
> +			count++;
> +			if (align > max_align)
> +				max_align = align;
> +
>  			if (realloc_head)
>  				children_add_size += get_res_add_size(realloc_head, r);
>  		}
>  	}
>  
> +	/*
> +	 * New rule: Prefer to small size instead of small align,
> +	 * when we have align/size: 1M/1M, 2M/2M,
> +	 *  min_align/size0: 1M/3M, max_align/size0_max: 2M/3M
> +	 *  pick 1M/3M.
> +	 * when we have align/size: 1M/1M, 64M/64M,
> +	 *  min_align/size0: 32M/96M, max_align/size0_max: 64M/65M
> +	 *  pick 64M/65M.
> +	 * when we have align/size: 1M/1M, 16M/64M,
> +	 *  min_align/size0: 8M/72M, max_align/size0_max: 16M/65M
> +	 *  pick 16M/65M.
> +	 * when we have align/size: 32M/64M, 128M/512M
> +	 *  min_align/size0: 64M/576M, max_align/size0_max: 128M/576M
> +	 *  pick 64M/576M.
> +	 * when we have align/size: 16M/32M, 128M/512M
> +	 *  min_align/size0: 64M/576M, max_align/size0_max: 128M/554M
> +	 *  pick 128M/554M.
> +	 * when we have align/size: 16M/64M
> +	 *  min_align/size0: 8M/64M, max_align/size0_max: 16M/64M
> +	 *  have to use 16M/64M.
> +	 */
>  	min_align = calculate_mem_align(aligns, max_order);
>  	min_align = max(min_align, window_alignment(bus, b_res->flags));
> +	max_align = max(max_align, window_alignment(bus, b_res->flags));
> +	if (count == 1)
> +		min_align = max_align;
> +
>  	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
> +	size0_max = calculate_memsize(size, min_size, 0, resource_size(b_res),
> +					window_alignment(bus, b_res->flags));
> +
> +	if (size0_max < size0) {
> +		size0 = size0_max;
> +		min_align = max_align;
> +		max_align--; /* to use small align for size1 calculation */
> +	}
> +
>  	if (children_add_size > add_size)
>  		add_size = children_add_size;
>  	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
>  		calculate_memsize(size, min_size, add_size,
> -				resource_size(b_res), min_align);
> +				resource_size(b_res),
> +				min_align <= max_align ? min_align :
> +					window_alignment(bus, b_res->flags));
>  	if (!size0 && !size1) {
>  		if (b_res->start || b_res->end)
>  			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",

