Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54942 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080AbcBDWEy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 17:04:54 -0500
Date: Thu, 4 Feb 2016 16:04:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geliang Tang <geliangtang@163.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Use list_first_entry_or_null() to simplify code
Message-ID: <20160204220450.GD7031@localhost>
References: <50073d35dca3c0ef34dddce4e6e2bf4bda6fdfe5.1453474124.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50073d35dca3c0ef34dddce4e6e2bf4bda6fdfe5.1453474124.git.geliangtang@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 22, 2016 at 10:50:19PM +0800, Geliang Tang wrote:
> Use list_first_entry_or_null() instead of list_empty() + list_entry()
> to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied to pci/aer for v4.6, thanks, Geliang!

> ---
>  drivers/pci/pcie/aer/aer_inject.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
> index 20db790..f5a245f 100644
> --- a/drivers/pci/pcie/aer/aer_inject.c
> +++ b/drivers/pci/pcie/aer/aer_inject.c
> @@ -124,16 +124,13 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
>  static struct pci_bus_ops *pci_bus_ops_pop(void)
>  {
>  	unsigned long flags;
> -	struct pci_bus_ops *bus_ops = NULL;
> +	struct pci_bus_ops *bus_ops;
>  
>  	spin_lock_irqsave(&inject_lock, flags);
> -	if (list_empty(&pci_bus_ops_list))
> -		bus_ops = NULL;
> -	else {
> -		struct list_head *lh = pci_bus_ops_list.next;
> -		list_del(lh);
> -		bus_ops = list_entry(lh, struct pci_bus_ops, list);
> -	}
> +	bus_ops = list_first_entry_or_null(&pci_bus_ops_list,
> +					   struct pci_bus_ops, list);
> +	if (bus_ops)
> +		list_del(&bus_ops->list);
>  	spin_unlock_irqrestore(&inject_lock, flags);
>  	return bus_ops;
>  }
> -- 
> 2.5.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
