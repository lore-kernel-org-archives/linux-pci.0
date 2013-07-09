Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38314 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab3GINnh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2013 09:43:37 -0400
Received: by mail-qa0-f53.google.com with SMTP id g10so2891901qah.5
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2013 06:43:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Tue, 9 Jul 2013 08:43:36 -0500
Message-ID: <CAL_Jsq+h=y5SNo4qO5-5u_w8rW++9MKDZK8rASNjhtVcjh-iyQ@mail.gmail.com>
Subject: Re: [PATCHv4 05/11] of: pci: add registry of MSI chips
From: Rob Herring <robherring2@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 1, 2013 at 8:42 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> This commit adds a very basic registry of msi_chip structures, so that
> an IRQ controller driver can register an msi_chip, and a PCIe host
> controller can find it, based on a 'struct device_node'.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/of/of_pci.c    | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/msi.h    |  2 ++
>  include/linux/of_pci.h | 12 ++++++++++++
>  3 files changed, 54 insertions(+)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 42c687a..f516632 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -89,3 +89,43 @@ int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
> +
> +#ifdef CONFIG_PCI_MSI
> +
> +static LIST_HEAD(msi_chip_list);
> +static DEFINE_MUTEX(msi_chip_mutex);
> +
> +int of_msi_chip_add(struct msi_chip *chip)

Perhaps of_pci_msi_chip_add instead.

> +{
> +       if (! of_property_read_bool(chip->of_node, "msi-controller"))
> +               return -EINVAL;
> +
> +       mutex_lock(&msi_chip_mutex);
> +       list_add(&chip->list, &msi_chip_list);
> +       mutex_unlock(&msi_chip_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_msi_chip_add);
> +
> +void of_msi_chip_remove(struct msi_chip *chip)

ditto

> +{
> +       mutex_lock(&msi_chip_mutex);
> +       list_del(&chip->list);
> +       mutex_unlock(&msi_chip_mutex);
> +}
> +EXPORT_SYMBOL_GPL(of_msi_chip_remove);
> +
> +struct msi_chip *of_find_msi_chip_by_node(struct device_node *of_node)

ditto.

> +{
> +       struct msi_chip *c;
> +       list_for_each_entry(c, &msi_chip_list, list) {

Need the safe variant here?

Rob

> +               if (c->of_node == of_node)
> +                       return c;
> +       }
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_find_msi_chip_by_node);
> +
> +#endif /* CONFIG_PCI_MSI */
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 5b357d92..9e1a44b 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -66,6 +66,8 @@ void default_teardown_msi_irqs(struct pci_dev *dev);
>  struct msi_chip {
>         struct module *owner;
>         struct device *dev;
> +       struct device_node *of_node;
> +       struct list_head list;
>
>         int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
>                          struct msi_desc *desc);
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 7a04826..99e4361 100644
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
> +int of_msi_chip_add(struct msi_chip *chip);
> +void of_msi_chip_remove(struct msi_chip *chip);
> +struct msi_chip *of_find_msi_chip_by_node(struct device_node *of_node);
> +#else
> +static inline int of_msi_chip_add(struct msi_chip *chip) { return -EINVAL; }
> +static inline void of_msi_chip_remove(struct msi_chip *chip) { }
> +static inline struct msi_chip *
> +of_find_msi_chip_by_node(struct device_node *of_node) { return NULL };
> +#endif
> +
>  #endif
> --
> 1.8.1.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
