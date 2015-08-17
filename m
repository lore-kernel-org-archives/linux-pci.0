Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Aug 2015 17:50:41 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/51] PCI: Cleanup res_to_dev_res() printout for
 addon resources
Message-ID: <20150817225041.GN26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-2-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-2-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:19PM -0700, Yinghai Lu wrote:
> Now get_res_add_size and get_res_add_align all have same printout
> from res_to_dev_res(), and it is confusing.
> 
> Move out debug messages printout from res_to_dev_res(),
> and later we will reuse res_to_dev_res() in other functions.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 508cc56..f0fa705 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -104,19 +104,9 @@ static struct pci_dev_resource *res_to_dev_res(struct list_head *head,
>  {
>  	struct pci_dev_resource *dev_res;
>  
> -	list_for_each_entry(dev_res, head, list) {
> -		if (dev_res->res == res) {
> -			int idx = res - &dev_res->dev->resource[0];
> -
> -			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
> -				 "res[%d]=%pR res_to_dev_res add_size %llx min_align %llx\n",
> -				 idx, dev_res->res,
> -				 (unsigned long long)dev_res->add_size,
> -				 (unsigned long long)dev_res->min_align);
> -
> +	list_for_each_entry(dev_res, head, list)
> +		if (dev_res->res == res)
>  			return dev_res;
> -		}
> -	}
>  
>  	return NULL;
>  }
> @@ -127,7 +117,15 @@ static resource_size_t get_res_add_size(struct list_head *head,
>  	struct pci_dev_resource *dev_res;
>  
>  	dev_res = res_to_dev_res(head, res);
> -	return dev_res ? dev_res->add_size : 0;
> +	if (!dev_res || !dev_res->add_size)
> +		return 0;
> +
> +	dev_printk(KERN_DEBUG, &dev_res->dev->dev,
> +		   "BAR %d: %pR get_res_add_size add_size   %llx\n",
> +		   (int)(res - &dev_res->dev->resource[0]),
> +		   res, (unsigned long long)dev_res->add_size);
> +
> +	return dev_res->add_size;
>  }
>  
>  static resource_size_t get_res_add_align(struct list_head *head,
> @@ -136,7 +134,15 @@ static resource_size_t get_res_add_align(struct list_head *head,
>  	struct pci_dev_resource *dev_res;
>  
>  	dev_res = res_to_dev_res(head, res);
> -	return dev_res ? dev_res->min_align : 0;
> +	if (!dev_res || !dev_res->min_align)
> +		return 0;
> +
> +	dev_printk(KERN_DEBUG, &dev_res->dev->dev,
> +		   "BAR %d: %pR get_res_add_align min_align %llx\n",
> +		   (int)(res - &dev_res->dev->resource[0]),
> +		   res, (unsigned long long)dev_res->min_align);

Please use %#llx so we have a "0x" prefix like other hex numbers.

> +
> +	return dev_res->min_align;
>  }
>  
>  
> -- 
> 1.8.4.5
> 
