Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64987 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab2IMB30 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Sep 2012 21:29:26 -0400
Message-ID: <1347499761.30040.138.camel@yhuang-dev>
Subject: Re: [PATCH v2 4/4] PCI/AER: fix a small race condition window when
 rmmod aer_inject
From: Huang Ying <ying.huang@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, jiang.liu@huawei.com,
	Hanjun Guo <guohanjun@huawei.com>, linux-pci@vger.kernel.org
Date: Thu, 13 Sep 2012 09:29:21 +0800
In-Reply-To: <1347453225-7704-4-git-send-email-wangyijing@huawei.com>
References: <1347453225-7704-1-git-send-email-wangyijing@huawei.com>
	 <1347453225-7704-4-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-09-12 at 20:33 +0800, Yijing Wang wrote:
> Fix a small race condition window between pci_bus_ops_pop() and
> pci_bus_set_ops() functions.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
>  drivers/pci/pcie/aer/aer_inject.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
> index bd043db..69c2d77 100644
> --- a/drivers/pci/pcie/aer/aer_inject.c
> +++ b/drivers/pci/pcie/aer/aer_inject.c
> @@ -141,12 +141,11 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
>  	return NULL;
>  }
>  
> +/* inject_lock must be held before calling */
>  static struct pci_bus_ops *pci_bus_ops_pop(void)
>  {
> -	unsigned long flags;
>  	struct pci_bus_ops *bus_ops = NULL;
>  
> -	spin_lock_irqsave(&inject_lock, flags);
>  	if (list_empty(&pci_bus_ops_list))
>  		bus_ops = NULL;
>  	else {
> @@ -154,7 +153,6 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
>  		list_del(lh);
>  		bus_ops = list_entry(lh, struct pci_bus_ops, list);
>  	}
> -	spin_unlock_irqrestore(&inject_lock, flags);
>  	return bus_ops;
>  }
>  
> @@ -610,14 +608,12 @@ static void __exit aer_inject_exit(void)
>  	bus_unregister_notifier(&pci_bus_type, &aerinj_hp_notifier);
>  	misc_deregister(&aer_inject_device);
>  
> +	spin_lock_irqsave(&inject_lock, flags);
>  	while ((bus_ops = pci_bus_ops_pop())) {
>  		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
>  		kfree(bus_ops);
>  	}
>  	
> -	clean_untracked_pci_aer_ops();
> -
> -	spin_lock_irqsave(&inject_lock, flags);
>  	list_for_each_entry_safe(err, err_next, &einjected, list) {
>  		list_del(&err->list);
>  		kfree(err);

This may trigger a AB BA dead lock.  In aer_inject_exit, the lock
sequence is:

inject_lock -> pci_lock

In pci config read/write path, the lock sequence is:

pci_lock -> inject_lock

With lockdep enabled, you may found warning on that.

Best Regards,
Huang YIng


