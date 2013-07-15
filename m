Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f179.google.com ([209.85.161.179]:35660 "EHLO
	mail-gg0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272Ab3GOQMs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2013 12:12:48 -0400
Received: by mail-gg0-f179.google.com with SMTP id c2so3995523ggn.10
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2013 09:12:48 -0700 (PDT)
Message-ID: <51E41F7A.4010502@gmail.com>
Date: Mon, 15 Jul 2013 11:12:42 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv5 05/11] of: pci: add registry of MSI chips
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com> <1373889167-27878-6-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1373889167-27878-6-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/15/2013 06:52 AM, Thomas Petazzoni wrote:
> This commit adds a very basic registry of msi_chip structures, so that
> an IRQ controller driver can register an msi_chip, and a PCIe host
> controller can find it, based on a 'struct device_node'.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>


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
> index cbf5d05..80900e0 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -67,6 +67,8 @@ void default_teardown_msi_irqs(struct pci_dev *dev);
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
> 

