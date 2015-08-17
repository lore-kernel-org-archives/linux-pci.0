Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Aug 2015 18:52:36 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/51] PCI: Reorder resources list for must/optional
 resources
Message-ID: <20150817235236.GQ26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-8-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-8-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:25PM -0700, Yinghai Lu wrote:
> After we update size and alignment for must+optional resource, we
> reorder them with new alignment, but this is only for STARTALIGN.
> 
> For SIZEALIGN type resource, after add back add_size, the alignment
> get changed, so need to do the sorting like STARTALIGN type resources.
> 
> Also we need to reorder the sorting back after we restore
> resource to must only when must+optional fail to allocate for all.
> 
> So move out the reordering code from the loop to separated function,
> and call it two times accordingly.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 62 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 7346bbf..6f2d508 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -287,6 +287,31 @@ static inline void reset_resource(struct resource *res)
>  	res->flags = 0;
>  }
>  
> +static void __sort_resources(struct list_head *head)

Why did you add "__" before the function name?

> +{
> +	struct pci_dev_resource *res1, *tmp_res, *res2;
> +
> +	list_for_each_entry_safe(res1, tmp_res, head, list) {
> +		resource_size_t align1, size1, align2, size2;
> +
> +		align1 = pci_resource_alignment(res1->dev, res1->res);
> +		size1 = resource_size(res1->res);
> +
> +		/* reorder it */
> +		list_for_each_entry(res2, head, list) {
> +			if (res2 == res1)
> +				break;
> +
> +			align2 = pci_resource_alignment(res2->dev, res2->res);
> +			size2 = resource_size(res2->res);
> +			if (is_before(align1, size1, align2, size2)) {
> +				list_move_tail(&res1->list, &res2->list);
> +				break;
> +			}
> +		}
> +	}
> +}
