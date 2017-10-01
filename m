Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59410 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbdJAHzP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Oct 2017 03:55:15 -0400
Date: Sun, 1 Oct 2017 09:55:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Govindarajulu Varadarajan <gvaradar@cisco.com>
Cc: benve@cisco.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com, peterz@infradead.org, okaya@codeaurora.org
Subject: Re: [PATCH V2] PCI: AER: fix deadlock in do_recovery
Message-ID: <20171001075514.GA11554@lst.de>
References: <20170930054938.43271-1-gvaradar@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930054938.43271-1-gvaradar@cisco.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Can you please start with an explanation of the problem in text and
cut down the cycle of involved functions to those actually relevant?

That'll make reviewing the patch a bit easier..

>  2 files changed, 48 insertions(+), 2 deletions(-)

> diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
> index d51e4a57b190..f6d8761dc656 100644
> --- a/drivers/pci/pcie/aer/aerdrv.h
> +++ b/drivers/pci/pcie/aer/aerdrv.h
> @@ -105,6 +105,11 @@ static inline pci_ers_result_t merge_result(enum pci_ers_result orig,
>  	return orig;
>  }
>  
> +struct aer_device_list {
> +	struct device *dev;
> +	struct hlist_node node;
> +};
> +
>  extern struct bus_type pcie_port_bus_type;
>  void aer_isr(struct work_struct *work);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 890efcc574cb..d524f2c2c288 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -346,6 +346,47 @@ static int report_resume(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> +int aer_get_pci_dev(struct pci_dev *pdev, void *data)
> +{
> +	struct hlist_head *hhead = (struct hlist_head *)data;
> +	struct device *dev = &pdev->dev;
> +	struct aer_device_list *entry;
> +
> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		/* continue with other devices, lets not return error */
> +		return 0;
> +
> +	entry->dev = get_device(dev);
> +	hlist_add_head(&entry->node, hhead);
> +
> +	return 0;

Can we just embedded the list_head in the pci_dev?  Or is there a way
we can have multiple chains like this pending at the same time?

> +static void aer_pci_walk_bus(struct pci_bus *top,
> +			     int (*cb)(struct pci_dev *, void *),
> +			     struct aer_broadcast_data *result)
> +{
> +	HLIST_HEAD(dev_hlist);
> +	struct hlist_node *tmp;
> +	struct aer_device_list *entry;

Do we want to offer this as generic PCIe functionality?  If not we can
probably hardcode the callback and callback data to simplify this a lot.
