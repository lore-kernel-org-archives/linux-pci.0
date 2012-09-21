Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52791 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab2IUFPQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Sep 2012 01:15:16 -0400
Message-ID: <1348204513.23395.23.camel@yhuang-dev>
Subject: Re: [PATCH v4 5/5] PCI/AER: free pci_bus_ops_list and remove
 pci_bus_ops_pop
From: Huang Ying <ying.huang@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, jiang.liu@huawei.com,
	Hanjun Guo <guohanjun@huawei.com>, linux-pci@vger.kernel.org
Date: Fri, 21 Sep 2012 13:15:13 +0800
In-Reply-To: <1348199056-7696-6-git-send-email-wangyijing@huawei.com>
References: <1348199056-7696-1-git-send-email-wangyijing@huawei.com>
	 <1348199056-7696-6-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2012-09-21 at 11:44 +0800, Yijing Wang wrote:
> Rewrite pci_bus_ops_list release code for simplification, and clean
> no used function pci_bus_ops_pop().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Huang Ying <ying.huang@intel.com>

Please remove my signed-off.

Reviewed-by: Huang Ying <ying.huang@intel.com>

> ---
>  drivers/pci/pcie/aer/aer_inject.c |   25 ++++++-------------------
>  1 files changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
> index a5fd393..4c9268a 100644
> --- a/drivers/pci/pcie/aer/aer_inject.c
> +++ b/drivers/pci/pcie/aer/aer_inject.c
> @@ -145,23 +145,6 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
>  	return __find_pci_bus_ops_parent(bus);
>  }
>  
> -static struct pci_bus_ops *pci_bus_ops_pop(void)
> -{
> -	unsigned long flags;
> -	struct pci_bus_ops *bus_ops = NULL;
> -
> -	spin_lock_irqsave(&inject_lock, flags);
> -	if (list_empty(&pci_bus_ops_list))
> -		bus_ops = NULL;
> -	else {
> -		struct list_head *lh = pci_bus_ops_list.next;
> -		list_del(lh);
> -		bus_ops = list_entry(lh, struct pci_bus_ops, list);
> -	}
> -	spin_unlock_irqrestore(&inject_lock, flags);
> -	return bus_ops;
> -}
> -
>  static struct pci_bus_ops *pci_bus_ops_get(struct pci_bus_ops *from)
>  {
>  	struct pci_bus_ops *bus_ops = NULL;
> @@ -622,7 +605,7 @@ static void __exit aer_inject_exit(void)
>  {
>  	struct aer_error *err, *err_next;
>  	unsigned long flags;
> -	struct pci_bus_ops *bus_ops = NULL;
> +	struct pci_bus_ops *bus_ops = NULL, *tmp_ops;
>  
>  	bus_unregister_notifier(&pci_bus_type, &aerinj_hp_notifier);
>  	misc_deregister(&aer_inject_device);
> @@ -631,8 +614,12 @@ static void __exit aer_inject_exit(void)
>  		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
>  
>  	clean_untracked_pci_ops_aer();
> -	while ((bus_ops = pci_bus_ops_pop()))
> +
> +	/* free pci_bus_ops_list */
> +	list_for_each_entry_safe(bus_ops, tmp_ops, &pci_bus_ops_list, list) {
> +		list_del(&bus_ops->list);
>  		kfree(bus_ops);
> +	}
>  
>  	spin_lock_irqsave(&inject_lock, flags);
>  	list_for_each_entry_safe(err, err_next, &einjected, list) {


