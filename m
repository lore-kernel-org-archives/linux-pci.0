Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34450 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbbHRENG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 00:13:06 -0400
Received: by pdbfa8 with SMTP id fa8so63166672pdb.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2015 21:13:05 -0700 (PDT)
Date: Mon, 17 Aug 2015 23:13:00 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 28/51] PCI: Unifiy calculate_size for io port and mmio
Message-ID: <20150818041300.GX26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-29-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-29-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:46PM -0700, Yinghai Lu wrote:
> We should check size+size1 with min_size for io port.
> For example, when hotplug bridge has two children bridges,
> every child bridge will need 0x1000, so size1 will be 0x2000
> and size is 0. The min_size for the hotplug bridge is 0x100.

A min_size of 0x100?  Is that a typo?

> with old version calculate_iosize, we get 0x3000 for final
> size because we are using size to compare with min_size. That is
> not right, we should use 0x2000 instead.

If this fixes a bug, please make one patch that *only* fixes the bug,
and a separate one that unifies but doesn't change the behavior.

> After this change, calculate_memsize and calculate_iosize
> is the same.
> 
> Change them to calculate_size.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 3db2838..aeed716 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1116,23 +1116,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
>  	return NULL;
>  }
>  
> -static resource_size_t calculate_iosize(resource_size_t size,
> -		resource_size_t min_size,
> -		resource_size_t size1,
> -		resource_size_t old_size,
> -		resource_size_t align)
> -{
> -	if (size < min_size)
> -		size = min_size;
> -	if (old_size == 1)
> -		old_size = 0;
> -	size = ALIGN(size + size1, align);
> -	if (size < old_size)
> -		size = old_size;
> -	return size;
> -}
> -
> -static resource_size_t calculate_memsize(resource_size_t size,
> +static resource_size_t calculate_size(resource_size_t size,
>  		resource_size_t min_size,
>  		resource_size_t old_size,
>  		resource_size_t align)
> @@ -1257,14 +1241,15 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  	}
>  
>  	size = size_aligned_for_isa(size);
> -	size0 = calculate_iosize(size, min_size, size1,
> +	size += size1;
> +	size0 = calculate_size(size, min_size,
>  			resource_size(b_res), min_align);
>  	sum_add_size = size_aligned_for_isa(sum_add_size);
>  	sum_add_size += sum_add_size1;
>  	if (sum_add_size < min_sum_size)
>  		sum_add_size = min_sum_size;
>  	size1 = !realloc_head ? size0 :
> -		calculate_iosize(sum_add_size, min_size, 0,
> +		calculate_size(sum_add_size, min_size,
>  			resource_size(b_res), min_align);
>  	if (!size0 && !size1) {
>  		if (b_res->start || b_res->end)
> @@ -1617,7 +1602,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	if (size || min_size) {
>  		min_align = calculate_mem_align(&align_test_list, max_align,
>  						size, window_align);
> -		size0 = calculate_memsize(size, min_size,
> +		size0 = calculate_size(size, min_size,
>  				  resource_size(b_res), min_align);
>  	}
>  	free_align_test_list(&align_test_list);
> @@ -1642,7 +1627,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  		min_add_align = calculate_mem_align(&align_test_add_list,
>  					max_add_align, sum_add_size,
>  					window_align);
> -		size1 = calculate_memsize(sum_add_size, min_size,
> +		size1 = calculate_size(sum_add_size, min_size,
>  				 resource_size(b_res), min_add_align);
>  	}
>  	free_align_test_list(&align_test_add_list);
> -- 
> 1.8.4.5
> 
