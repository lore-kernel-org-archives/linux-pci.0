Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47470 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab2GaUHf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2012 16:07:35 -0400
Message-ID: <50183B03.2090809@gmail.com>
Date: Tue, 31 Jul 2012 15:07:31 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Colin Cross <ccross@android.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 09/10] of: Add of_pci_parse_ranges()
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de> <1343332512-28762-10-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1343332512-28762-10-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/26/2012 02:55 PM, Thierry Reding wrote:
> This new function parses the ranges property of PCI device nodes into
> an array of struct resource elements. It is useful in multiple-port PCI
> host controller drivers to collect information about the ranges that it
> needs to forward to the respective ports.

It seems to me that some of the DT PCI code in arch/powerpc/kernel/pci*
like pci_process_bridge_OF_ranges() should apply for ARM as well.

Each arch defining their own pci controller structs complicates this,
but I would think at least the DT parsing can be common.

> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v3:
> - new patch
> 
>  drivers/of/of_pci.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/of_pci.h |  2 ++
>  2 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 13e37e2..bcff301 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -1,7 +1,8 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
> -#include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/slab.h>
>  #include <asm/prom.h>
>  
>  static inline int __of_pci_pci_compare(struct device_node *node,
> @@ -40,3 +41,84 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_find_child_device);
> +
> +struct resource *of_pci_parse_ranges(struct device_node *node,
> +				     unsigned int *countp)
> +{
> +	unsigned int count, i = 0;
> +	struct resource *ranges;

I think res or pci_res would be clearer than ranges that this is a
struct resource.

> +	const __be32 *values;
> +	int len, pna, np;
> +
> +	values = of_get_property(node, "ranges", &len);
> +	if (!values)
> +		return NULL;
> +
> +	pna = of_n_addr_cells(node);
> +	np = pna + 5;
> +
> +	count = len / (np * sizeof(*values));
> +
> +	ranges = kzalloc(sizeof(*ranges) * count, GFP_KERNEL);
> +	if (!ranges)
> +		return NULL;
> +
> +	pr_debug("PCI ranges:\n");
> +
> +	while ((len -= np * sizeof(*values)) >= 0) {
> +		u64 addr = of_translate_address(node, values + 3);
> +		u64 size = of_read_number(values + 3 + pna, 2);
> +		u32 type = be32_to_cpup(values);
> +		const char *suffix = "";
> +		struct resource range;

Same here.

Rob

> +
> +		memset(&range, 0, sizeof(range));
> +		range.start = addr;
> +		range.end = addr + size - 1;
> +
> +		switch ((type >> 24) & 0x3) {
> +		case 0:
> +			range.flags = IORESOURCE_MEM | IORESOURCE_PCI_CS;
> +			pr_debug("  CS  %#x-%#x\n", range.start, range.end);
> +			break;
> +
> +		case 1:
> +			range.flags = IORESOURCE_IO;
> +			pr_debug("  IO  %#x-%#x\n", range.start, range.end);
> +			break;
> +
> +		case 2:
> +			range.flags = IORESOURCE_MEM;
> +
> +			if (type & 0x40000000) {
> +				range.flags |= IORESOURCE_PREFETCH;
> +				suffix = "prefetch";
> +			}
> +
> +			pr_debug("  MEM %#x-%#x %s\n", range.start, range.end,
> +				 suffix);
> +			break;
> +
> +		case 3:
> +			range.flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
> +
> +			if (type & 0x40000000) {
> +				range.flags |= IORESOURCE_PREFETCH;
> +				suffix = "prefetch";
> +			}
> +
> +			pr_debug("  MEM %#x-%#x 64-bit %s\n", range.start,
> +				 range.end, suffix);
> +			break;
> +		}
> +
> +		memcpy(&ranges[i++], &range, sizeof(range));
> +		values += np;
> +	}
> +
> +	if (countp)
> +		*countp = count;
> +
> +	return ranges;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_parse_ranges);
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index bb115de..c0db6ea 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -10,5 +10,7 @@ int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq);
>  struct device_node;
>  struct device_node *of_pci_find_child_device(struct device_node *parent,
>  					     unsigned int devfn);
> +struct resource *of_pci_parse_ranges(struct device_node *node,
> +				     unsigned int *countp);
>  
>  #endif
> 


