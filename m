Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37954 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab2IMBnY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Sep 2012 21:43:24 -0400
Message-ID: <1347500602.30040.142.camel@yhuang-dev>
Subject: Re: [PATCH v2 2/4] PCI/AER: clean all untracked pci_ops_aer when
 rmmod aer_inject
From: Huang Ying <ying.huang@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, jiang.liu@huawei.com,
	Hanjun Guo <guohanjun@huawei.com>, linux-pci@vger.kernel.org
Date: Thu, 13 Sep 2012 09:43:22 +0800
In-Reply-To: <1347453225-7704-2-git-send-email-wangyijing@huawei.com>
References: <1347453225-7704-1-git-send-email-wangyijing@huawei.com>
	 <1347453225-7704-2-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-09-12 at 20:33 +0800, Yijing Wang wrote:
> Since hot plug for pci devices while doing aer inject, some newly created child buses'
> pci_ops will be assigned to pci_ops_aer. Aer_inject does not track these pci_ops_aer(not
> list in pci_bus_ops_list),we should clean all of these when rmmod aer_inject module.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/pcie/aer/aer_inject.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
> index 0816483..9d195ae 100644
> --- a/drivers/pci/pcie/aer/aer_inject.c
> +++ b/drivers/pci/pcie/aer/aer_inject.c
> @@ -283,6 +283,28 @@ static void pci_bus_ops_init(struct pci_bus_ops *bus_ops,
>  	bus_ops->ops = ops;
>  }
>  
> +static void pci_clean_child_aer_ops(struct pci_bus *bus)
> +{
> +	struct pci_bus *child;
> +
> +	list_for_each_entry(child, &bus->children, node) {
> +		if (child->ops == &pci_ops_aer)
> +			pci_bus_set_ops(child, bus->ops);
> +		pci_clean_child_aer_ops(child);
> +	}
> +}
> +
> +/* find pci_ops_aer from root bus, and replace it by parent bus's pci_ops.
> + * pci_ops of root bus won't be pci_ops_aer here*/

Why scan all pci buses?  Is it possible just to check buses in
pci_bus_ops_list.

Best Regards,
Huang Ying

> +static void clean_untracked_pci_ops_aer(void)
> +{
> +	struct pci_bus *bus = NULL;
> +
> +	while ((bus = pci_find_next_bus(bus)) != NULL)
> +		pci_clean_child_aer_ops(bus);
> +}
> +
> +
>  static int pci_bus_set_aer_ops(struct pci_bus *bus)
>  {
>  	struct pci_ops *ops;
> @@ -546,6 +568,8 @@ static void __exit aer_inject_exit(void)
>  		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
>  		kfree(bus_ops);
>  	}
> +
> +	clean_untracked_pci_aer_ops();
>  
>  	spin_lock_irqsave(&inject_lock, flags);
>  	list_for_each_entry_safe(err, err_next, &einjected, list) {
> @@ -553,6 +577,14 @@ static void __exit aer_inject_exit(void)
>  		kfree(err);
>  	}
>  	spin_unlock_irqrestore(&inject_lock, flags);
> +
> +	/* Inject aer errors and hotplug the same pcie device
> +	 * maybe assign some newly created buses' pci_ops pci_ops_aer.
> +	 * Since these pci_ops_aer are not tracked in pci_bus_ops_list,
> +	 * we need to find and clean untracked pci_ops_aer before aer_inject
> +	 * module exit
> +	 */
> +	clean_untracked_pci_ops_aer();
>  }
>  
>  module_init(aer_inject_init);


