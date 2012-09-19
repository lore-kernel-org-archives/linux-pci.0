Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57543 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981Ab2ISFw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Sep 2012 01:52:56 -0400
Message-ID: <1348033973.8212.132.camel@yhuang-dev>
Subject: Re: [PATCH 2/6] PCI/AER: introduce pci_bus_ops_get() function to
 avoid a small race condition window
From: Huang Ying <ying.huang@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, jiang.liu@huawei.com,
	Hanjun Guo <guohanjun@huawei.com>, linux-pci@vger.kernel.org
Date: Wed, 19 Sep 2012 13:52:53 +0800
In-Reply-To: <1348022442-7816-3-git-send-email-wangyijing@huawei.com>
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
	 <1348022442-7816-3-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-09-19 at 10:40 +0800, Yijing Wang wrote:
> When we rmmod aer_inject module, there is a race condition window between pci_bus_ops_pop()
> and pci_bus_set_ops() in aer_inject_exit, eg. pci_read_aer/pci_write_aer was called between
> them. So introduce pci_bus_ops_get() to avoid this.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/pcie/aer/aer_inject.c |   21 ++++++++++++++++++---
>  1 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
> index 0f00a27..442147b 100644
> --- a/drivers/pci/pcie/aer/aer_inject.c
> +++ b/drivers/pci/pcie/aer/aer_inject.c
> @@ -67,6 +67,8 @@ struct pci_bus_ops {
>  	struct pci_ops *ops;
>  };
>  
> +#define to_pci_bus_ops(n) container_of(n, struct pci_bus_ops, list)
> +
>  static LIST_HEAD(einjected);
>  
>  static LIST_HEAD(pci_bus_ops_list);
> @@ -160,6 +162,18 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
>  	return bus_ops;
>  }
>  
> +static struct pci_bus_ops *pci_bus_ops_get(struct pci_bus_ops *from)
> +{
> +	struct pci_bus_ops *bus_ops = NULL;
> +	struct list_head *n;
> +
> +	n = from ? from->list.next : pci_bus_ops_list.next;
> +	if (n != &pci_bus_ops_list)
> +		bus_ops = to_pci_bus_ops(n);
> +
> +	return bus_ops;
> +}
> +
>  static u32 *find_pci_config_dword(struct aer_error *err, int where,
>  				  int *prw1cs)
>  {
> @@ -540,14 +554,15 @@ static void __exit aer_inject_exit(void)
>  {
>  	struct aer_error *err, *err_next;
>  	unsigned long flags;
> -	struct pci_bus_ops *bus_ops;
> +	struct pci_bus_ops *bus_ops = NULL;
>  
>  	misc_deregister(&aer_inject_device);
>  
> -	while ((bus_ops = pci_bus_ops_pop())) {
> +	while ((bus_ops = pci_bus_ops_get(bus_ops)))
>  		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);

In fact, this is

list_for_each_entry(&pci_bus_ops_list)
	pci_bus_set_ops()

Because we are in module exit path, there will be no new user of
pci_bus_ops_list, it appears safe to do that without lock.

But the bus_ops may be deleted from the list when accessed via
pci_ops_aer.  So It may be better to wait for all pci_ops_aer functions
return before delete them.  synchronize_rcu() should be sufficient for
that, because all pci_ops_aer functions are called with spinlock held.

Best Regards,
Huang Ying

> +
> +	while ((bus_ops = pci_bus_ops_pop()))
>  		kfree(bus_ops);
> -	}
>  
>  	spin_lock_irqsave(&inject_lock, flags);
>  	list_for_each_entry_safe(err, err_next, &einjected, list) {


