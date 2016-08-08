Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21249 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbcHHRF6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 13:05:58 -0400
Date: Mon, 8 Aug 2016 11:05:56 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] vmd: Fix infinite loop executing irq's
Message-ID: <20160808170556.GB1792@localhost.localdomain>
References: <1470671271-22465-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470671271-22465-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Seems fine and didn't grow the struct, which is always nice

Acked-by Jon Derrick: <jonathan.derrick@intel.com>

On Mon, Aug 08, 2016 at 09:47:51AM -0600, Keith Busch wrote:
> We can't initialize the list head on deletion as this causes the node
> to point to itself, looping infinitely if the vmd IRQ handler happened
> to be servicing that node.
> 
> The list initialization was trying fix a bug from multiple calls to
> disable the same IRQ. We can fix this instead by having the vmd driver
> track if the interrupt is enabled.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Cc: Jon Derrick <jonathan.derrick@intel.com>
> Reported-by: Grzegorz Koczot <grzegorz.koczot@intel.com>
> Tested-by: Miroslaw Drost <miroslaw.drost@intel.com>
> ---
> v1 -> v2:
> 
>   Removed check for poisioned list pointer. This is abusing knowledge
>   internal to the list api, so we need another way to know if the child
>   irq is enabled. This patch uses a driver controlled boolean for this.
> 
>   Added tags for the bug reporter and tester.
> 
>  arch/x86/pci/vmd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index e88b417..4b85837 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -41,6 +41,7 @@ static DEFINE_RAW_SPINLOCK(list_lock);
>   * @node:	list item for parent traversal.
>   * @rcu:	RCU callback item for freeing.
>   * @irq:	back pointer to parent.
> + * @enabled:	true if driver enabled irq
>   * @virq:	the virtual IRQ value provided to the requesting driver.
>   *
>   * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
> @@ -50,6 +51,7 @@ struct vmd_irq {
>  	struct list_head	node;
>  	struct rcu_head		rcu;
>  	struct vmd_irq_list	*irq;
> +	bool			enabled;
>  	unsigned int		virq;
>  };
>  
> @@ -122,7 +124,9 @@ static void vmd_irq_enable(struct irq_data *data)
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&list_lock, flags);
> +	WARN_ON(vmdirq->enabled);
>  	list_add_tail_rcu(&vmdirq->node, &vmdirq->irq->irq_list);
> +	vmdirq->enabled = true;
>  	raw_spin_unlock_irqrestore(&list_lock, flags);
>  
>  	data->chip->irq_unmask(data);
> @@ -136,8 +140,10 @@ static void vmd_irq_disable(struct irq_data *data)
>  	data->chip->irq_mask(data);
>  
>  	raw_spin_lock_irqsave(&list_lock, flags);
> -	list_del_rcu(&vmdirq->node);
> -	INIT_LIST_HEAD_RCU(&vmdirq->node);
> +	if (vmdirq->enabled) {
> +		list_del_rcu(&vmdirq->node);
> +		vmdirq->enabled = false;
> +	}
>  	raw_spin_unlock_irqrestore(&list_lock, flags);
>  }
>  
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
