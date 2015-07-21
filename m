Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jul 2015 16:30:29 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v4 05/19] PCI/MSI: of: Add support for OF-provided
 msi_domain
Message-ID: <20150721213029.GJ21967@google.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
 <1436962613-17359-6-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436962613-17359-6-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 15, 2015 at 01:16:39PM +0100, Marc Zyngier wrote:
> In order to populate the PHB msi_domain, use the "msi-parent"
> attribute to lookup a corresponding irq domain. If found,
> this is our MSI domain.
> 
> This gets plugged into the core PCI code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pci/of.c    | 19 +++++++++++++++++++
>  drivers/pci/probe.c |  1 +
>  include/linux/pci.h |  2 ++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index f092993..09df465 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -9,6 +9,7 @@
>   * 2 of the License, or (at your option) any later version.
>   */
>  
> +#include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/of.h>
> @@ -59,3 +60,21 @@ struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
>  		return of_node_get(bus->bridge->parent->of_node);
>  	return NULL;
>  }
> +
> +void pci_set_phb_of_msi_domain(struct pci_bus *bus)
> +{
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +	struct device_node *np;
> +	struct irq_domain *d;
> +
> +	if (!bus->dev.of_node)
> +		return;
> +	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
> +	if (!np)
> +		return;
> +	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
> +	if (!d)
> +		d = irq_find_host(np);
> +	dev_set_msi_domain(&bus->dev, d);
> +#endif
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 376f6fa..c80626f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -663,6 +663,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
>  
>  void __weak pcibios_set_host_bridge_msi_domain(struct pci_bus *bus)
>  {
> +	pci_set_phb_of_msi_domain(bus);

The code itself is OK with me, but "phb" is an abbreviation that we haven't
really been using in the PCI core, so I'd prefer something else.  Maybe
"pci_set_host_of_msi_domain()"?  Or even (for symmetry with the pcibios
function), "pci_set_host_bridge_of_msi_domain()", although that is getting
pretty wordy?
