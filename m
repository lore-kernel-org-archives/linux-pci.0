Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34014 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbbFSC0Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 22:26:16 -0400
Received: by igboe5 with SMTP id oe5so5951042igb.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 19:26:16 -0700 (PDT)
Date: Thu, 18 Jun 2015 21:26:12 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: get correct bridge mmio size with old size checking
Message-ID: <20150619022612.GI7710@google.com>
References: <1434235142-2751-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434235142-2751-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 13, 2015 at 03:39:02PM -0700, Yinghai Lu wrote:
> Found allocation request too big size for must+optional during pci
> bus rescan via /sys/bus/pci/rescan, and fail with that size.
> 
> [ 1217.699800] pci 0000:85:02.0: bridge window [mem 0x00100000-0x001fffff] to [bus 86] add_size 100000 add_align 100000
> [ 1217.699821] pci 0000:85:03.0: bridge window [mem 0x00100000-0x001fffff] to [bus 87] add_size 100000 add_align 100000
> [ 1217.699907] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff] res_to_dev_res add_size 100000 min_align 100000
> [ 1217.699909] pci 0000:85:03.0: res[14]=[mem 0x00100000-0x001fffff] res_to_dev_res add_size 100000 min_align 100000
> [ 1217.699933] pci 0000:85:02.0: BAR 14: assigned [mem 0xedf00000-0xee0fffff]
> [ 1217.699936] pci 0000:85:03.0: BAR 14: no space for [mem size 0x00200000]
> [ 1217.699939] pci 0000:85:03.0: BAR 14: failed to assign [mem size 0x00200000]
> 
> After close look, for 85:02.0 only need 1M for must+optional.

I'm pretty sure this is fixing a bug, but I haven't figured out how it
works yet.  (Is there a bugzilla or URL for an email problem report?)

Please strip out timestamps unless they help understand the problem.

Are both 85:02.0 and 85:03.0 relevant to the problem?  If not, strip out
the one that doesn't matter.

I'll try to work through this more tomorrow and figure out what's going on.
But if you have any hints, or could walk me through an example, it might
save me some time :)

> It turns out that there is bug in calculate_memsize() with checking.
> We should compare size sum with old size at last instead of partial size.
> 
> Actually we have that correct in calculate_iosize(), with this patch
> we have mmio and io port size calculation consistent.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/setup-bus.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -857,9 +857,10 @@ static resource_size_t calculate_memsize
>  		size = min_size;
>  	if (old_size == 1)
>  		old_size = 0;
> +	size = ALIGN(size + size1, align);
>  	if (size < old_size)
>  		size = old_size;
> -	size = ALIGN(size + size1, align);
> +

Please don't add an extra blank line here; the extra line makes
calculate_memsize() look different from calculate_iosize() for no good
reason.

>  	return size;
>  }
>  
