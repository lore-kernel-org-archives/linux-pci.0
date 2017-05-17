Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 17 May 2017 16:08:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, toshi.kani@hpe.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        bhelgaas@google.com, dtor@chromium.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v5] of/pci: Fix memory leak in
 of_pci_get_host_bridge_resources
Message-ID: <20170517210841.GH31462@bhelgaas-glaptop.roam.corp.google.com>
References: <1491359303-1385-1-git-send-email-jeffy.chen@rock-chips.com>
 <1491359303-1385-2-git-send-email-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491359303-1385-2-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 05, 2017 at 10:28:22AM +0800, Jeffy Chen wrote:
> Currently we only free the allocated resource struct when error.
> This would cause memory leak after pci_free_resource_list.

I think I see the problem here.  The release path is this:

  pci_release_host_bridge_dev
    pci_free_resource_list
      resource_list_free
	list_for_each_entry_safe(entry, tmp, head, node)
	  resource_list_destroy_entry
	    resource_list_del
	    resource_list_free_entry
	      kfree(entry)

but that frees only the struct resource_entry, not the struct resource
pointed to by entry->res.  Is that right?

And this patch solves it for of_pci_get_host_bridge_resources() by
always making entry->res point to entry->__res, which is an element in
struct resource_entry, so it's sufficient to free the resource_entry.

The memory management here is pretty tangled.  I wonder if there's
some way to simplify it so it's easier to make sure everybody does it
correctly.  For example, could we remove the entry->res pointer
completely and force everybody to use entry->__res?

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5:
> Fix some careless compile errors.
> 
> Changes in v4:
> Use IORESOURCE_AUTO to mark struct resources which could be copied.
> 
> Changes in v3:
> Add some comments.
> 
> Changes in v2:
> Don't change the resource_list_create_entry's behavior.
> 
>  drivers/of/of_pci.c | 51 ++++++++++++++++++---------------------------------
>  drivers/pci/bus.c   |  7 ++++++-
>  2 files changed, 24 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 0ee42c3..49233bf 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -189,9 +189,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base)
>  {
> -	struct resource_entry *window;
> -	struct resource *res;
> -	struct resource *bus_range;
> +	struct resource res;
>  	struct of_pci_range range;
>  	struct of_pci_range_parser parser;
>  	char range_type[4];
> @@ -200,24 +198,21 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  	if (io_base)
>  		*io_base = (resource_size_t)OF_BAD_ADDR;
>  
> -	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
> -	if (!bus_range)
> -		return -ENOMEM;
> -
>  	pr_info("host bridge %s ranges:\n", dev->full_name);
>  
> -	err = of_pci_parse_bus_range(dev, bus_range);
> +	err = of_pci_parse_bus_range(dev, &res);
>  	if (err) {
> -		bus_range->start = busno;
> -		bus_range->end = bus_max;
> -		bus_range->flags = IORESOURCE_BUS;
> -		pr_info("  No bus range found for %s, using %pR\n",
> -			dev->full_name, bus_range);
> +		res.start = busno;
> +		res.end = bus_max;
> +		res.flags = IORESOURCE_BUS;
> +		pr_info("  No bus range found for %s\n", dev->full_name);
>  	} else {
> -		if (bus_range->end > bus_range->start + bus_max)
> -			bus_range->end = bus_range->start + bus_max;
> +		if (res.end > res.start + bus_max)
> +			res.end = res.start + bus_max;
>  	}
> -	pci_add_resource(resources, bus_range);
> +
> +	res.flags |= IORESOURCE_AUTO;
> +	pci_add_resource(resources, &res);
>  
>  	/* Check for ranges property */
>  	err = of_pci_range_parser_init(&parser, dev);
> @@ -244,24 +239,16 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
>  			continue;
>  
> -		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> -		if (!res) {
> -			err = -ENOMEM;
> -			goto parse_failed;
> -		}
> -
> -		err = of_pci_range_to_resource(&range, dev, res);
> -		if (err) {
> -			kfree(res);
> +		err = of_pci_range_to_resource(&range, dev, &res);
> +		if (err)
>  			continue;
> -		}
>  
> -		if (resource_type(res) == IORESOURCE_IO) {
> +		if (resource_type(&res) == IORESOURCE_IO) {
>  			if (!io_base) {
>  				pr_err("I/O range found for %s. Please provide an io_base pointer to save CPU base address\n",
>  					dev->full_name);
>  				err = -EINVAL;
> -				goto conversion_failed;
> +				goto parse_failed;
>  			}
>  			if (*io_base != (resource_size_t)OF_BAD_ADDR)
>  				pr_warn("More than one I/O resource converted for %s. CPU base address for old range lost!\n",
> @@ -269,16 +256,14 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  			*io_base = range.cpu_addr;
>  		}
>  
> -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> +		res.flags |= IORESOURCE_AUTO;
> +		pci_add_resource_offset(resources, &res,
> +					res.start - range.pci_addr);
>  	}
>  
>  	return 0;
>  
> -conversion_failed:
> -	kfree(res);
>  parse_failed:
> -	resource_list_for_each_entry(window, resources)
> -		kfree(window->res);
>  	pci_free_resource_list(resources);
>  	return err;
>  }
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index bc56cf1..3dbcb95 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -22,12 +22,17 @@ void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>  {
>  	struct resource_entry *entry;
>  
> -	entry = resource_list_create_entry(res, 0);
> +	entry = resource_list_create_entry(NULL, 0);

If we make this change, there are no callers of
resource_list_create_entry() that supply a non-NULL "res", so 
we could remove that argument completely.

>  	if (!entry) {
>  		printk(KERN_ERR "PCI: can't add host bridge window %pR\n", res);
>  		return;
>  	}
>  
> +	if (res->flags & IORESOURCE_AUTO)
> +		*entry->res = *res;
> +	else
> +		entry->res = res;
> +
>  	entry->offset = offset;
>  	resource_list_add_tail(entry, resources);
>  }
> -- 
> 2.1.4
> 
> 
