Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35378 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbbHQXxM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2015 19:53:12 -0400
Received: by pdob1 with SMTP id b1so5494420pdo.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2015 16:53:11 -0700 (PDT)
Date: Mon, 17 Aug 2015 18:53:07 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/51] PCI: Rename pdev_sort_resources to
 pdev_check_resources
Message-ID: <20150817235307.GR26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-10-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-10-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:27PM -0700, Yinghai Lu wrote:
> We don't do sorting in those functions anymore, so change "sort" to "check"
> instead.

What *do* we do in those functions?  "Check" doesn't tell me anything.

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 6642a60..292f2a5 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -206,8 +206,8 @@ static resource_size_t __pci_resource_alignment(
>  	return r_align;
>  }
>  
> -/* Sort resources by alignment */
> -static void pdev_sort_resources(struct pci_dev *dev,
> +/* check resources and save to the list */
> +static void pdev_check_resources(struct pci_dev *dev,
>  				 struct list_head *realloc_head,
>  				 struct list_head *head)
>  {
> @@ -243,7 +243,7 @@ static void pdev_sort_resources(struct pci_dev *dev,
>  	}
>  }
>  
> -static void __dev_sort_resources(struct pci_dev *dev,
> +static void __dev_check_resources(struct pci_dev *dev,
>  				 struct list_head *realloc_head,
>  				 struct list_head *head)
>  {
> @@ -261,7 +261,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
>  			return;
>  	}
>  
> -	pdev_sort_resources(dev, realloc_head, head);
> +	pdev_check_resources(dev, realloc_head, head);
>  }
>  
>  static inline void reset_resource(struct resource *res)
> @@ -561,7 +561,7 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
>  {
>  	LIST_HEAD(head);
>  
> -	__dev_sort_resources(dev, add_head, &head);
> +	__dev_check_resources(dev, add_head, &head);
>  	__assign_resources_sorted(&head, add_head, fail_head);
>  
>  }
> @@ -574,7 +574,7 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
>  	LIST_HEAD(head);
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list)
> -		__dev_sort_resources(dev, realloc_head, &head);
> +		__dev_check_resources(dev, realloc_head, &head);
>  
>  	__assign_resources_sorted(&head, realloc_head, fail_head);
>  }
> -- 
> 1.8.4.5
> 
