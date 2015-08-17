Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Aug 2015 18:00:41 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/51] PCI: Use correct align for optional only
 resources during sorting
Message-ID: <20150817230041.GO26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-4-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-4-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:21PM -0700, Yinghai Lu wrote:
> During sorting before assign, we only put resource with non-zero align
> in the sorted list, so for optional resources that must size is 0 and only
> have addon parts, we need to have correct align.
> 
> While treating SRIOV as optional resources, we always read alignment for
> SRIOV bars, so they are ok.
> Hotplug bridge resources are using STARTALIGN so it is ok when size is 0
> if we have correct start for them.
> 
> Later we want to treat the ROM BAR as optional resource, and it has
> have SIZEALIGN, we need to find a way to get align for them.

Are you saying we have a ROM resource where the ROM BAR is of non-zero
size, but the resource structure says it's zero size?

> We can use addon resource align instead in that case, and it will
> be ok for SRIOV path and hotplug bridge resource path.
> 
> Sorted list will contain must resource align/size to 0/0 to hold spot for
> optional resources.
> 
> We need to pass realloc_head from sizing stage to sorting stage, and
> get entry from realloc list and calculate align from the entry.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431

Apparently this fixes a problem?  What is the problem?  What is the
symptom of the problem?

> Reported-by: TJ <linux@iam.tj>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 50 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 247d8fe..27cb0f0 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -145,9 +145,43 @@ static resource_size_t get_res_add_align(struct list_head *head,
>  	return dev_res->min_align;
>  }
>  
> +static resource_size_t __pci_resource_alignment(

I don't like creating new function names by adding "__" to the
beginning of an existing function name.  It doesn't give enough of a
clue about what how the functions are different.  I don't really
understand what's going on here, but this might be a clue that this
could be refactored differently.

> +				struct pci_dev *dev,
> +				struct resource *r,
> +				struct list_head *realloc_head)
> +{
> +	resource_size_t r_align = pci_resource_alignment(dev, r);
> +	resource_size_t orig_start, orig_end;
> +	struct pci_dev_resource *dev_res;
> +
> +	if (r_align || !realloc_head)
> +		return r_align;
> +
> +	dev_res = res_to_dev_res(realloc_head, r);
> +	if (!dev_res || !dev_res->add_size)
> +		return r_align;
> +
> +	orig_start = r->start;
> +	orig_end = r->end;
> +	r->end += dev_res->add_size;
> +	if ((r->flags & IORESOURCE_STARTALIGN)) {
> +		resource_size_t r_size = resource_size(r);
> +		resource_size_t add_align = dev_res->min_align;
> +
> +		r->start = add_align;
> +		r->end = add_align + r_size - 1;

I think this would be slightly shorter and more obvious as:

  resource_size_t r_size = resource_size(r);

  r->start = dev_res->min_align;
  r->end = r->start + r_size - 1;

> +	}
> +	r_align = pci_resource_alignment(dev, r);
> +	r->start = orig_start;
> +	r->end = orig_end;
> +
> +	return r_align;
> +}
>  
>  /* Sort resources by alignment */
> -static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
> +static void pdev_sort_resources(struct pci_dev *dev,
> +				 struct list_head *realloc_head,
> +				 struct list_head *head)
>  {
>  	int i;
>  
> @@ -165,7 +199,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>  		if (!(r->flags) || r->parent)
>  			continue;
>  
> -		r_align = pci_resource_alignment(dev, r);
> +		r_align = __pci_resource_alignment(dev, r, realloc_head);
>  		if (!r_align) {
>  			dev_warn(&dev->dev, "BAR %d: %pR has bogus alignment\n",
>  				 i, r);
> @@ -183,8 +217,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>  		list_for_each_entry(dev_res, head, list) {
>  			resource_size_t align;
>  
> -			align = pci_resource_alignment(dev_res->dev,
> -							 dev_res->res);
> +			align = __pci_resource_alignment(dev_res->dev,
> +							 dev_res->res,
> +							 realloc_head);
>  
>  			if (r_align > align) {
>  				n = &dev_res->list;
> @@ -197,6 +232,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>  }
>  
>  static void __dev_sort_resources(struct pci_dev *dev,
> +				 struct list_head *realloc_head,
>  				 struct list_head *head)
>  {
>  	u16 class = dev->class >> 8;
> @@ -213,7 +249,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
>  			return;
>  	}
>  
> -	pdev_sort_resources(dev, head);
> +	pdev_sort_resources(dev, realloc_head, head);
>  }
>  
>  static inline void reset_resource(struct resource *res)
> @@ -501,7 +537,7 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
>  {
>  	LIST_HEAD(head);
>  
> -	__dev_sort_resources(dev, &head);
> +	__dev_sort_resources(dev, add_head, &head);
>  	__assign_resources_sorted(&head, add_head, fail_head);
>  
>  }
> @@ -514,7 +550,7 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
>  	LIST_HEAD(head);
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list)
> -		__dev_sort_resources(dev, &head);
> +		__dev_sort_resources(dev, realloc_head, &head);
>  
>  	__assign_resources_sorted(&head, realloc_head, fail_head);
>  }
> -- 
> 1.8.4.5
> 
