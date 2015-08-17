Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 17 Aug 2015 18:54:16 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 13/51] PCI: Separate realloc list checking after
 allocation
Message-ID: <20150817235416.GS26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-14-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-14-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:31PM -0700, Yinghai Lu wrote:
> We check the realloc list, as list must be empty after allocation.
> 
> Separate the realloc list checking to another function.
> 
> Add checking that is missed in acpiphp driver.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/pci/hotplug/acpiphp_glue.c |  1 +
>  drivers/pci/pci.h                  |  1 +
>  drivers/pci/setup-bus.c            | 11 ++++++++---
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index ff53856..134caee 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -507,6 +507,7 @@ static void enable_slot(struct acpiphp_slot *slot)
>  		}
>  	}
>  	__pci_bus_assign_resources(bus, &add_list, NULL);
> +	__pci_bus_check_realloc(&add_list);
>  
>  	acpiphp_sanitize_bus(bus);
>  	pcie_bus_configure_settings(bus);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4ff0ff1..2b83977 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -235,6 +235,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus,
>  void __pci_bus_assign_resources(const struct pci_bus *bus,
>  				struct list_head *realloc_head,
>  				struct list_head *fail_head);
> +void __pci_bus_check_realloc(struct list_head *realloc_head);
>  bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
>  
>  void pci_reassigndev_resource_alignment(struct pci_dev *dev);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 06664db..f30225c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -350,6 +350,11 @@ out:
>  	}
>  }
>  
> +void __pci_bus_check_realloc(struct list_head *realloc_head)
> +{
> +	BUG_ON(!list_empty(realloc_head));

I don't think this really improves readability.  At least before, we could
see what we were looking for and we knew it might BUG().

> +}
> +
>  /**
>   * assign_requested_resources_sorted() - satisfy resource requests
>   *
> @@ -1861,7 +1866,7 @@ again:
>  	/* Depth last, allocate resources and update the hardware. */
>  	__pci_bus_assign_resources(bus, add_list, &fail_head);
>  	if (add_list)
> -		BUG_ON(!list_empty(add_list));
> +		__pci_bus_check_realloc(add_list);
>  	tried_times++;
>  
>  	/* any device complain? */
> @@ -1936,7 +1941,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>  again:
>  	__pci_bus_size_bridges(parent, &add_list);
>  	__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
> -	BUG_ON(!list_empty(&add_list));
> +	__pci_bus_check_realloc(&add_list);
>  	tried_times++;
>  
>  	if (list_empty(&fail_head))
> @@ -1995,6 +2000,6 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
>  							 &add_list);
>  	up_read(&pci_bus_sem);
>  	__pci_bus_assign_resources(bus, &add_list, NULL);
> -	BUG_ON(!list_empty(&add_list));
> +	__pci_bus_check_realloc(&add_list);
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
> -- 
> 1.8.4.5
> 
