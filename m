Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 15 Oct 2015 15:10:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/8] PCI/MSI: Use of_msi_get_domain instead of
 open-coded "msi-parent" parsing
Message-ID: <20151015201050.GC10442@localhost>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
 <1444151043-31084-4-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444151043-31084-4-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 06, 2015 at 06:03:58PM +0100, Marc Zyngier wrote:
> Now that we have a function that implements the complexity of the
> "msi-parent" property parsing, switch to that.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/of.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 2e99a50..e112da1 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include "pci.h"
>  
> @@ -64,27 +65,25 @@ struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
>  struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
>  {
>  #ifdef CONFIG_IRQ_DOMAIN
> -	struct device_node *np;
>  	struct irq_domain *d;
>  
>  	if (!bus->dev.of_node)
>  		return NULL;
>  
>  	/* Start looking for a phandle to an MSI controller. */
> -	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
> +	d = of_msi_get_domain(&bus->dev, bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
> +	if (d)
> +		return d;
>  
>  	/*
>  	 * If we don't have an msi-parent property, look for a domain
>  	 * directly attached to the host bridge.
>  	 */
> -	if (!np)
> -		np = bus->dev.of_node;
> -
> -	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
> +	d = irq_find_matching_host(bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
>  	if (d)
>  		return d;
>  
> -	return irq_find_host(np);
> +	return irq_find_host(bus->dev.of_node);
>  #else
>  	return NULL;
>  #endif
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
