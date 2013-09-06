Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f175.google.com ([209.85.213.175]:60135 "EHLO
	mail-ye0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab3IFXTM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 19:19:12 -0400
Received: by mail-ye0-f175.google.com with SMTP id q8so1224802yen.20
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 16:19:11 -0700 (PDT)
Date: Fri, 6 Sep 2013 17:19:08 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] PCI: Pass full info for window alignment
Message-ID: <20130906231908.GE12956@google.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1378431958-7874-3-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378431958-7874-3-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Gavin]

On Fri, Sep 06, 2013 at 09:45:58AM +0800, Wei Yang wrote:
> When calculating the window_alignment(), type information like IORESOURCE_MEM
> and IORESOURCE_PREFETCH is not enough for some platform.
> 
> As on powernv platform, one prefetchable window could be IORESOURCE_MEM_64 or
> not. The platform will calculate the alignment based on this information.
> 
> This patch passes the full info for window alignment.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-bus.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 989de3c..8781eb1 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -980,7 +980,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	}
>  
>  	min_align = calculate_mem_align(aligns, max_order);
> -	min_align = max(min_align, window_alignment(bus, b_res->flags & mask));
> +	min_align = max(min_align, window_alignment(bus, b_res->flags));

This makes sense to me, but since Gavin added this window_alignment()
call recently with the mask, I'd like him to ack this before I apply it.

>  	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
>  	if (children_add_size > add_size)
>  		add_size = children_add_size;
> -- 
> 1.7.1
> 
