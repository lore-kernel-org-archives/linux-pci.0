Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31069 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab2IUFIm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Sep 2012 01:08:42 -0400
Message-ID: <1348204119.23395.21.camel@yhuang-dev>
Subject: Re: [PATCH v4 2/5] PCI/AER: introduce pci_bus_ops_get() to avoid a
 small race condition window
From: Huang Ying <ying.huang@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, jiang.liu@huawei.com,
	Hanjun Guo <guohanjun@huawei.com>, linux-pci@vger.kernel.org
Date: Fri, 21 Sep 2012 13:08:39 +0800
In-Reply-To: <1348199056-7696-3-git-send-email-wangyijing@huawei.com>
References: <1348199056-7696-1-git-send-email-wangyijing@huawei.com>
	 <1348199056-7696-3-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2012-09-21 at 11:44 +0800, Yijing Wang wrote:
> When we rmmod aer_inject module, there is a small race condition window between pci_bus_ops_pop()
> and pci_bus_set_ops() in aer_inject_exit, eg. pci_read_aer/pci_write_aer was called between
> them. So introduce pci_bus_ops_get() to avoid this.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Huang Ying <ying.huang@intel.com>

Please don't add my signed-off.

> ---
>  drivers/pci/pcie/aer/aer_inject.c |   21 ++++++++++++++++++---
>  1 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
> index fdab3bb..0123120 100644
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
> @@ -539,14 +553,15 @@ static void __exit aer_inject_exit(void)
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

Why not just use

	list_for_each_entry(&pci_bus_ops_list) {
		pci_bus_set_ops();
	}

Best Regards,
Huang Ying

> +
> +	while ((bus_ops = pci_bus_ops_pop()))
>  		kfree(bus_ops);
> -	}
>  
>  	spin_lock_irqsave(&inject_lock, flags);
>  	list_for_each_entry_safe(err, err_next, &einjected, list) {


