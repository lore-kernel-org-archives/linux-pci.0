Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40565 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967160Ab3HIF7w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Aug 2013 01:59:52 -0400
Message-ID: <1376027943.32100.12.camel@pasglop>
Subject: Re: [PATCHv8 04/10] of: pci: add registry of MSI chips
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 09 Aug 2013 15:59:03 +1000
In-Reply-To: <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> This commit adds a very basic registry of msi_chip structures, so that
> an IRQ controller driver can register an msi_chip, and a PCIe host
> controller can find it, based on a 'struct device_node'.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/of/of_pci.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/msi.h    |  2 ++
>  include/linux/of_pci.h | 12 ++++++++++++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 42c687a..e5ca008 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -89,3 +89,48 @@ int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
> +
> +#ifdef CONFIG_PCI_MSI
> +
> +static LIST_HEAD(of_pci_msi_chip_list);
> +static DEFINE_MUTEX(of_pci_msi_chip_mutex);
> +
> +int of_pci_msi_chip_add(struct msi_chip *chip)
> +{
> +	if (!of_property_read_bool(chip->of_node, "msi-controller"))
> +		return -EINVAL;
> +
> +	mutex_lock(&of_pci_msi_chip_mutex);
> +	list_add(&chip->list, &of_pci_msi_chip_list);
> +	mutex_unlock(&of_pci_msi_chip_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_msi_chip_add);
> +
> +void of_pci_msi_chip_remove(struct msi_chip *chip)
> +{
> +	mutex_lock(&of_pci_msi_chip_mutex);
> +	list_del(&chip->list);
> +	mutex_unlock(&of_pci_msi_chip_mutex);
> +}
> +EXPORT_SYMBOL_GPL(of_pci_msi_chip_remove);
> +
> +struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node *of_node)
> +{
> +	struct msi_chip *c;
> +
> +	mutex_lock(&of_pci_msi_chip_mutex);
> +	list_for_each_entry(c, &of_pci_msi_chip_list, list) {
> +		if (c->of_node == of_node) {
> +			mutex_unlock(&of_pci_msi_chip_mutex);
> +			return c;
> +		}
> +	}
> +	mutex_unlock(&of_pci_msi_chip_mutex);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_find_msi_chip_by_node);
> +
> +#endif /* CONFIG_PCI_MSI */
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 090ddad..b17ead8 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -68,6 +68,8 @@ void default_restore_msi_irqs(struct pci_dev *dev, int irq);
>  struct msi_chip {
>  	struct module *owner;
>  	struct device *dev;
> +	struct device_node *of_node;
> +	struct list_head list;
>  
>  	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
>  			 struct msi_desc *desc);
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 7a04826..29631eb 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -2,6 +2,7 @@
>  #define __OF_PCI_H
>  
>  #include <linux/pci.h>
> +#include <linux/msi.h>
>  
>  struct pci_dev;
>  struct of_irq;
> @@ -13,4 +14,15 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
>  int of_pci_get_devfn(struct device_node *np);
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>  
> +#if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> +int of_pci_msi_chip_add(struct msi_chip *chip);
> +void of_pci_msi_chip_remove(struct msi_chip *chip);
> +struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node *of_node);
> +#else
> +static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return -EINVAL; }
> +static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }
> +static inline struct msi_chip *
> +of_pci_find_msi_chip_by_node(struct device_node *of_node) { return NULL };
> +#endif
> +
>  #endif


