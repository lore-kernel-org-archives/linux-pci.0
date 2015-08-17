Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35345 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbHQX4H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2015 19:56:07 -0400
Received: by pacgr6 with SMTP id gr6so118544152pac.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2015 16:56:06 -0700 (PDT)
Date: Mon, 17 Aug 2015 18:56:00 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/51] PCI: Skip must+optional if there is no optional
 addon
Message-ID: <20150817235600.GT26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-21-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-21-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:38PM -0700, Yinghai Lu wrote:
> If the bridge does not support hotplug or no child with sriov support
> we could get out early and don't try must+optional allocation.

You mention non-hotplug bridges and non-SR-IOV devices, but I can't figure
out how the patch itself relates to those.  How can I connect them?

> Also in the loop that update res with optional add info, skip resource
> that add_size is 0.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index d1f9e19..64ef516 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -450,6 +450,24 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
>  	return false;	/* should not get here */
>  }
>  
> +static bool __has_addon(struct list_head *head,
> +			struct list_head *realloc_head)

Why does this have a "__" prefix?

> +{
> +	int add_count = 0;
> +	struct pci_dev_resource *dev_res, *tmp_res;
> +
> +	/* check if we have add really */
> +	list_for_each_entry(dev_res, head, list) {
> +		tmp_res = res_to_dev_res(realloc_head, dev_res->res);
> +		if (!tmp_res || !tmp_res->add_size)
> +			continue;
> +
> +		add_count++;
> +	}
> +
> +	return add_count != 0;
> +}
> +
>  static bool save_resources(struct list_head *head,
>  			   struct list_head *save_head)
>  {
> @@ -481,16 +499,24 @@ static bool __assign_resources_must_add_sorted(struct list_head *head,
>  	struct pci_dev_resource *save_res;
>  	struct pci_dev_resource *dev_res, *tmp_res;
>  	unsigned long fail_type;
> -	resource_size_t add_align;
> +	resource_size_t add_align, add_size;
>  	struct resource *res;
>  
> +	if (!__has_addon(head, realloc_head))
> +		return false;
> +
>  	if (!save_resources(head, &save_head))
>  		return false;
>  
>  	/* Update res in head list with add_size in realloc_head list */
>  	list_for_each_entry(dev_res, head, list) {
>  		res = dev_res->res;
> -		res->end += get_res_add_size(realloc_head, res);
> +		add_size = get_res_add_size(realloc_head, res);
> +
> +		if (!add_size)
> +			continue;
> +
> +		res->end += add_size;
>  
>  		/*
>  		 * There are two kinds of additional resources in the list:
> @@ -578,7 +604,7 @@ static void __assign_resources_sorted(struct list_head *head,
>  	 */
>  
>  	/* Check must+optional add */
> -	if (realloc_head && !list_empty(realloc_head) &&
> +	if (realloc_head &&

Why are you dropping the !list_empty() test?

>  	    __assign_resources_must_add_sorted(head, realloc_head))
>  		return;
>  
> -- 
> 1.8.4.5
> 
