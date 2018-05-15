Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:60812 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeEOHyr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 May 2018 03:54:47 -0400
Subject: Re: [PATCH v3 4/8] PCI: Replace dev_node parameter of
 of_pci_get_host_bridge_resources with device
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
 <5f2226585c6af9920b266d0503e32042d4c9e440.1526363896.git.jan.kiszka@siemens.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <f74386a1-48b5-ebe0-1b6c-dbef1847cda8@mentor.com>
Date: Tue, 15 May 2018 10:54:33 +0300
MIME-Version: 1.0
In-Reply-To: <5f2226585c6af9920b266d0503e32042d4c9e440.1526363896.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jan,

On 05/15/2018 08:58 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Another step towards a managed version of
> of_pci_get_host_bridge_resources(): Feed in the underlying device,
> rather than just the OF node. This will allow to use managed resource
> allocation internally later on.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

[snip]

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 8d4778ef5806..ac97491ba377 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -245,7 +245,7 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>  #if defined(CONFIG_OF_ADDRESS)
>  /**
>   * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
> - * @dev_node: device node of the host bridge having the range property
> + * @dev: host bridge device
>   * @busno: bus number associated with the bridge root bus
>   * @bus_max: maximum number of buses for this bridge
>   * @resources: list where the range of resources will be added after DT parsing
> @@ -262,10 +262,11 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>   * It returns zero if the range parsing has been successful or a standard error
>   * value if it failed.
>   */
> -int of_pci_get_host_bridge_resources(struct device_node *dev_node,
> +int of_pci_get_host_bridge_resources(struct device *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base)
>  {
> +	struct device_node *dev_node = dev->of_node;
>  	struct resource_entry *window;
>  	struct resource *res;
>  	struct resource *bus_range;
> @@ -599,12 +600,12 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
>  				    struct resource **bus_range)
>  {
>  	int err, res_valid = 0;
> -	struct device_node *np = dev->of_node;
>  	resource_size_t iobase;
>  	struct resource_entry *win, *tmp;
>  
>  	INIT_LIST_HEAD(resources);
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
> +	err = of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
> +						    &iobase);

just a note, it's a funny selected indentation style across this change
to avoid indentation issues in v3 6/8. It seems to be innocent though.

>  	if (err)
>  		return err;
>  
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 74eec1943ad2..e6684c68cb94 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -71,11 +71,11 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>  #endif
>  
>  #if defined(CONFIG_OF_ADDRESS)
> -int of_pci_get_host_bridge_resources(struct device_node *dev_node,
> +int of_pci_get_host_bridge_resources(struct device *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base);
>  #else
> -static inline int of_pci_get_host_bridge_resources(struct device_node *dev_node,
> +static inline int of_pci_get_host_bridge_resources(struct device *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base)
>  {
> 

Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
