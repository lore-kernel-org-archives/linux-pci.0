Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55A5CE68.90007@huawei.com>
Date: Wed, 15 Jul 2015 11:07:20 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>
CC: Andrew Morton <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/36] PCI: Add support for more than two alt_size under
 same bridge
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org> <1436225966-27247-18-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-18-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/7/7 7:39, Yinghai Lu wrote:
> Need to increase size to make sure it could fit all alt entries.
> 
> In the patch, we first select one big size, and then keep reducing
> the size and retrying to get the minimum value for alt_size.
> 
> Example:
> two bridges: one have 8M/8M, and 1M/1M children res.
> 	     one have 4M/4M, and 1M/1M children res.
> 
> Then we have child pridges alt_align/alt_size: 8M/9M, 4M/5M.
> Before this patch, parent bridge alt_align/alt_size is 8M/14M
> that is wrong.
> With this patch	parent bridge alt_align/alt_size: 8M/17M.
> 
> At same time, child bridges must align/size: 4M/12M, 2M/6M.
> and prarent bridge must align/size: 4M/20M.
> 
> So at last, we use 8M/17M as parent bridge alt_align/alt_size.

Tested-by: Yijing Wang <wangyijing@huawei.com>

Hi Yinghai, does this patch depend on the previous items in this patchset ?
Could you provide another version of this patch for stable branch, eg. 3.10 stable ?

Thanks!
Yijing.

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=100451
> Reported-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0090d4..9427baa 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1304,6 +1304,47 @@ out:
>  	return good_align;
>  }
>  
> +static resource_size_t calculate_mem_alt_size(struct list_head *head,
> +				resource_size_t max_align, resource_size_t size,
> +				resource_size_t align_low)
> +{
> +	struct align_test_res *p;
> +	resource_size_t tmp;
> +	resource_size_t good_size, bad_size;
> +	int count = 0, order;
> +
> +	good_size = ALIGN(size, align_low);
> +
> +	list_for_each_entry(p, head, list)
> +		count++;
> +
> +	if (count <= 1)
> +		goto out;
> +
> +	__sort_align_test(head);
> +
> +	tmp = max(size, max_align);
> +	order = __fls(count);
> +	if ((1ULL << order) < count)
> +		order++;
> +	good_size = ALIGN((tmp << order), align_low);
> +	bad_size = ALIGN(size, align_low) - align_low;
> +	size = good_size;
> +	while (size > bad_size) {
> +		/* check if align/size fit all entries */
> +		if (is_align_size_good(head, max_align, size, 0))
> +			good_size = size;
> +		else
> +			bad_size = size;
> +
> +		size = bad_size + ((good_size - bad_size) >> 1);
> +		size = round_down(size, align_low);
> +	}
> +
> +out:
> +	return good_size;
> +}
> +
>  static inline bool is_optional(int i)
>  {
>  
> @@ -1350,6 +1391,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  					mask | IORESOURCE_PREFETCH, type);
>  	LIST_HEAD(align_test_list);
>  	LIST_HEAD(align_test_add_list);
> +	LIST_HEAD(align_test_alt_list);
>  	resource_size_t alt_size = 0, alt_align = 0;
>  	resource_size_t window_align;
>  
> @@ -1418,6 +1460,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  
>  				dev_res = res_to_dev_res(realloc_head, r);
>  				if (dev_res && dev_res->alt_size) {
> +					add_to_align_test_list(
> +						&align_test_alt_list,
> +						dev_res->alt_align,
> +						dev_res->alt_size);
>  					alt_size += dev_res->alt_size;
>  					if (alt_align < dev_res->alt_align)
>  						alt_align = dev_res->alt_align;
> @@ -1440,6 +1486,12 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  			alt_align = max_align;
>  			alt_size = calculate_memsize(size, min_size,
>  						     0, window_align);
> +		} else  {
> +			/* need to increase size to fit more alt */
> +			alt_align = max(alt_align, window_align);
> +			alt_size = calculate_mem_alt_size(&align_test_alt_list,
> +							  alt_align, alt_size,
> +							  window_align);
>  		}
>  		/* must is better ? */
>  		if (alt_size >= size0) {
> @@ -1447,6 +1499,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  			alt_size = size0;
>  		}
>  	}
> +	free_align_test_list(&align_test_alt_list);
>  
>  	if (sum_add_size == size)
>  		sum_add_size = add_size;
> 


-- 
Thanks!
Yijing

