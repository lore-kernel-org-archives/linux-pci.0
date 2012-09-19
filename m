Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27283 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab2ISGD4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Sep 2012 02:03:56 -0400
Message-ID: <1348034627.8212.136.camel@yhuang-dev>
Subject: Re: [PATCH 5/6] PCI/AER: introduce pci_bus_ops_free to free
 pci_bus_ops
From: Huang Ying <ying.huang@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, jiang.liu@huawei.com,
	Hanjun Guo <guohanjun@huawei.com>, linux-pci@vger.kernel.org
Date: Wed, 19 Sep 2012 14:03:47 +0800
In-Reply-To: <1348022442-7816-6-git-send-email-wangyijing@huawei.com>
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
	 <1348022442-7816-6-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-09-19 at 10:40 +0800, Yijing Wang wrote:
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/pcie/aer/aer_inject.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
> index 0a12ac7..79b611d 100644
> --- a/drivers/pci/pcie/aer/aer_inject.c
> +++ b/drivers/pci/pcie/aer/aer_inject.c
> @@ -162,6 +162,16 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
>  	return bus_ops;
>  }
>  
> +static void pci_bus_ops_free(void)
> +{
> +	struct pci_bus_ops *bus_ops, *tmp_ops;
> +
> +	list_for_each_entry_safe(bus_ops, tmp_ops, &pci_bus_ops_list, list) {
> +		list_del(&bus_ops->list);
> +		kfree(bus_ops);
> +	}
> +}

IMHO, this can be inlined into aer_inject_exit

>  static struct pci_bus_ops *pci_bus_ops_get(struct pci_bus_ops *from)
>  {
>  	struct pci_bus_ops *bus_ops = NULL;
> @@ -641,9 +651,7 @@ static void __exit aer_inject_exit(void)
>  	 * module exit
>  	 */
>  	clean_untracked_pci_ops_aer();
> -
> -	while ((bus_ops = pci_bus_ops_pop()))

You can remove pci_bus_ops_pop now.

Best Regards,
Huang Ying

> -		kfree(bus_ops);
> +	pci_bus_ops_free();
>  
>  	spin_lock_irqsave(&inject_lock, flags);
>  	list_for_each_entry_safe(err, err_next, &einjected, list) {


