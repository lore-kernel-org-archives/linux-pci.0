Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v3 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
 <4ae78ed8c3d866446f8322c1df4a19c2ca4fef58.1526363896.git.jan.kiszka@siemens.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <c4272d78-780b-ab9e-8ecb-0de4983bb757@mentor.com>
Date: Tue, 15 May 2018 10:54:03 +0300
MIME-Version: 1.0
In-Reply-To: <4ae78ed8c3d866446f8322c1df4a19c2ca4fef58.1526363896.git.jan.kiszka@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jan,

On 05/15/2018 08:58 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, convert the
> existing function to a managed version.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

[snip]

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 4f21514cb4e4..00f42389aa56 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -244,7 +244,8 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>  
>  #if defined(CONFIG_OF_ADDRESS)
>  /**
> - * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
> + * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
> + *                                           host bridge resources from DT
>   * @dev: host bridge device
>   * @busno: bus number associated with the bridge root bus
>   * @bus_max: maximum number of buses for this bridge
> @@ -253,8 +254,6 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>   * address for the start of the I/O range. Can be NULL if the caller doesn't
>   * expect I/O ranges to be present in the device tree.
>   *
> - * It is the caller's job to free the @resources list.
> - *
>   * This function will parse the "ranges" property of a PCI host bridge device
>   * node and setup the resource mapping based on its content. It is expected
>   * that the property conforms with the Power ePAPR document.
> @@ -262,12 +261,11 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>   * It returns zero if the range parsing has been successful or a standard error
>   * value if it failed.
>   */
> -int of_pci_get_host_bridge_resources(struct device *dev,
> +int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base)
>  {
>  	struct device_node *dev_node = dev->of_node;
> -	struct resource_entry *window;
>  	struct resource *res;
>  	struct resource *bus_range;
>  	struct of_pci_range range;
> @@ -278,7 +276,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
>  	if (io_base)
>  		*io_base = (resource_size_t)OF_BAD_ADDR;
>  
> -	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
> +	bus_range = devm_kzalloc(dev, sizeof(*bus_range), GFP_KERNEL);
>  	if (!bus_range)
>  		return -ENOMEM;
>  
> @@ -300,7 +298,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
>  	/* Check for ranges property */
>  	err = of_pci_range_parser_init(&parser, dev_node);
>  	if (err)
> -		goto parse_failed;
> +		return err;

In my opinion allocated by pci_add_resource() and pci_add_resource_offset()
resource entries are leaked on error paths, and pci_free_resource_list() should
be called.

>  
>  	dev_dbg(dev, "Parsing ranges property...\n");
>  	for_each_of_pci_range(&parser, &range) {
> @@ -322,15 +320,13 @@ int of_pci_get_host_bridge_resources(struct device *dev,
>  		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
>  			continue;
>  
> -		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> -		if (!res) {
> -			err = -ENOMEM;
> -			goto parse_failed;
> -		}
> +		res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> +		if (!res)
> +			return -ENOMEM;

Same as above.

>  
>  		err = of_pci_range_to_resource(&range, dev_node, res);
>  		if (err) {
> -			kfree(res);
> +			devm_kfree(dev, res);
>  			continue;
>  		}
>  
> @@ -339,8 +335,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
>  				dev_err(dev,
>  					"I/O range found for %pOF. Please provide an io_base pointer to save CPU base address\n",
>  					dev_node);
> -				err = -EINVAL;
> -				goto conversion_failed;
> +				return -EINVAL;

Same as above.

>  			}
>  			if (*io_base != (resource_size_t)OF_BAD_ADDR)
>  				dev_warn(dev,
> @@ -353,16 +348,8 @@ int of_pci_get_host_bridge_resources(struct device *dev,
>  	}
>  
>  	return 0;
> -
> -conversion_failed:
> -	kfree(res);
> -parse_failed:
> -	resource_list_for_each_entry(window, resources)
> -		kfree(window->res);
> -	pci_free_resource_list(resources);
> -	return err;
>  }
> -EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
> +EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
>  #endif /* CONFIG_OF_ADDRESS */
>  
>  /**
> @@ -606,7 +593,7 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
>  	struct resource_entry *win, *tmp;
>  
>  	INIT_LIST_HEAD(resources);
> -	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
>  						    &iobase);
>  	if (err)
>  		return err;

--
With best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
