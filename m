Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759215AbeD0WY3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 18:24:29 -0400
Date: Fri, 27 Apr 2018 17:24:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] PCI: Introduce devm_of_pci_get_host_bridge_resources
Message-ID: <20180427222427.GB73638@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
 <e387d04ea235c9a4879a897bb730adc383a96635.1524582822.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e387d04ea235c9a4879a897bb730adc383a96635.1524582822.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 24, 2018 at 05:13:39PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> of_pci_get_host_bridge_resources allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, introduce a
> managed version of that service. This differs API-wise only in taking a
> reference to the associated device, rather than to the device tree node.
> 
> As of_pci_get_host_bridge_resources is an exported interface, we cannot
> simply drop it at this point. After converting all in-tree users to the
> new API, we could phase out the unmanaged one over some grace period.

It looks like it might be possible to split this into three or four
patches:

  1) Factor __of_pci_get_host_bridge_resources() out of
     of_pci_get_host_bridge_resources()

  2) Add struct device * argument

  3) Convert pr_info() to dev_info()

  4) Add devm_of_pci_get_host_bridge_resources()

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/pci/of.c       | 89 ++++++++++++++++++++++++++++++++------------------
>  include/linux/of_pci.h | 14 ++++++--
>  2 files changed, 70 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a28355c273ae..6eab0bde2ab3 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -243,26 +243,8 @@ void of_pci_check_probe_only(void)
>  EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>  
>  #if defined(CONFIG_OF_ADDRESS)
> -/**
> - * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
> - * @dev: device node of the host bridge having the range property
> - * @busno: bus number associated with the bridge root bus
> - * @bus_max: maximum number of buses for this bridge
> - * @resources: list where the range of resources will be added after DT parsing
> - * @io_base: pointer to a variable that will contain on return the physical
> - * address for the start of the I/O range. Can be NULL if the caller doesn't
> - * expect I/O ranges to be present in the device tree.
> - *
> - * It is the caller's job to free the @resources list.
> - *
> - * This function will parse the "ranges" property of a PCI host bridge device
> - * node and setup the resource mapping based on its content. It is expected
> - * that the property conforms with the Power ePAPR document.
> - *
> - * It returns zero if the range parsing has been successful or a standard error
> - * value if it failed.
> - */
> -int of_pci_get_host_bridge_resources(struct device_node *dev,
> +static int __of_pci_get_host_bridge_resources(struct device *dev,
> +			struct device_node *dev_node,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base)
>  {
> @@ -277,19 +259,22 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  	if (io_base)
>  		*io_base = (resource_size_t)OF_BAD_ADDR;
>  
> -	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
> +	if (dev)
> +		bus_range = devm_kzalloc(dev,sizeof(*bus_range), GFP_KERNEL);
> +	else
> +		bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
>  	if (!bus_range)
>  		return -ENOMEM;
>  
> -	pr_info("host bridge %pOF ranges:\n", dev);
> +	pr_info("host bridge %pOF ranges:\n", dev_node);

Since you now have a struct device *, maybe convert these to dev_info()?
It looks like __dev_printk() does something sensible if "dev" is NULL.

>  
> -	err = of_pci_parse_bus_range(dev, bus_range);
> +	err = of_pci_parse_bus_range(dev_node, bus_range);
>  	if (err) {
>  		bus_range->start = busno;
>  		bus_range->end = bus_max;
>  		bus_range->flags = IORESOURCE_BUS;
>  		pr_info("  No bus range found for %pOF, using %pR\n",
> -			dev, bus_range);
> +			dev_node, bus_range);
>  	} else {
>  		if (bus_range->end > bus_range->start + bus_max)
>  			bus_range->end = bus_range->start + bus_max;
> @@ -297,7 +282,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  	pci_add_resource(resources, bus_range);
>  
>  	/* Check for ranges property */
> -	err = of_pci_range_parser_init(&parser, dev);
> +	err = of_pci_range_parser_init(&parser, dev_node);
>  	if (err)
>  		goto parse_failed;
>  
> @@ -321,13 +306,17 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
>  			continue;
>  
> -		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +		if (dev)
> +			res = devm_kzalloc(dev, sizeof(struct resource),
> +					   GFP_KERNEL);
> +		else
> +			res = kzalloc(sizeof(struct resource), GFP_KERNEL);
>  		if (!res) {
>  			err = -ENOMEM;
>  			goto parse_failed;
>  		}
>  
> -		err = of_pci_range_to_resource(&range, dev, res);
> +		err = of_pci_range_to_resource(&range, dev_node, res);
>  		if (err) {
>  			kfree(res);
>  			continue;
> @@ -336,13 +325,13 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  		if (resource_type(res) == IORESOURCE_IO) {
>  			if (!io_base) {
>  				pr_err("I/O range found for %pOF. Please provide an io_base pointer to save CPU base address\n",
> -					dev);
> +					dev_node);
>  				err = -EINVAL;
>  				goto conversion_failed;
>  			}
>  			if (*io_base != (resource_size_t)OF_BAD_ADDR)
>  				pr_warn("More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
> -					dev);
> +					dev_node);
>  			*io_base = range.cpu_addr;
>  		}
>  
> @@ -354,12 +343,50 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  conversion_failed:
>  	kfree(res);
>  parse_failed:
> -	resource_list_for_each_entry(window, resources)
> -		kfree(window->res);
> +	if (!dev);
> +		resource_list_for_each_entry(window, resources)
> +			kfree(window->res);
>  	pci_free_resource_list(resources);
>  	return err;
>  }
> +
> +/**
> + * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
> + * @dev: device node of the host bridge having the range property
> + * @busno: bus number associated with the bridge root bus
> + * @bus_max: maximum number of buses for this bridge
> + * @resources: list where the range of resources will be added after DT parsing
> + * @io_base: pointer to a variable that will contain on return the physical
> + * address for the start of the I/O range. Can be NULL if the caller doesn't
> + * expect I/O ranges to be present in the device tree.
> + *
> + * It is the caller's job to free the @resources list.
> + *
> + * This function will parse the "ranges" property of a PCI host bridge device
> + * node and setup the resource mapping based on its content. It is expected
> + * that the property conforms with the Power ePAPR document.
> + *
> + * It returns zero if the range parsing has been successful or a standard error
> + * value if it failed.
> + */
> +int of_pci_get_host_bridge_resources(struct device_node *dev_node,
> +			unsigned char busno, unsigned char bus_max,
> +			struct list_head *resources, resource_size_t *io_base)
> +{
> +	return __of_pci_get_host_bridge_resources(NULL, dev_node, busno,
> +						  bus_max, resources, io_base);
> +}
>  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
> +
> +int devm_of_pci_get_host_bridge_resources(struct device *dev,
> +			unsigned char busno, unsigned char bus_max,
> +			struct list_head *resources, resource_size_t *io_base)
> +{
> +	return __of_pci_get_host_bridge_resources(dev, dev->of_node, busno,
> +						  bus_max, resources, io_base);
> +}
> +EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
> +
>  #endif /* CONFIG_OF_ADDRESS */
>  
>  /**
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 091033a6b836..08b8f02426a5 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -71,11 +71,21 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>  #endif
>  
>  #if defined(CONFIG_OF_ADDRESS)
> -int of_pci_get_host_bridge_resources(struct device_node *dev,
> +int of_pci_get_host_bridge_resources(struct device_node *dev_node,
> +			unsigned char busno, unsigned char bus_max,
> +			struct list_head *resources, resource_size_t *io_base);
> +int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base);
>  #else
> -static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
> +static inline int of_pci_get_host_bridge_resources(struct device_node *dev_node,
> +			unsigned char busno, unsigned char bus_max,
> +			struct list_head *resources, resource_size_t *io_base)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base)
>  {
> -- 
> 2.13.6
> 
