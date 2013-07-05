Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:57929 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab3GEVvb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2013 17:51:31 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so3337822obq.7
        for <linux-pci@vger.kernel.org>; Fri, 05 Jul 2013 14:51:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372686136-1370-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-5-git-send-email-thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Jul 2013 15:51:10 -0600
Message-ID: <CAErSpo4aodspFnC0uR87yYAgswQQdmU48uoX5NA43UZjbCpOuw@mail.gmail.com>
Subject: Re: [PATCHv4 04/11] PCI: Introduce new MSI chip infrastructure
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 1, 2013 at 7:42 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> From: Thierry Reding <thierry.reding@avionic-design.de>
>
> The new struct msi_chip is used to associated an MSI controller with a
> PCI bus. It is automatically handed down from the root to its children
> during bus enumeration.
>
> This patch provides default (weak) implementations for the architecture-
> specific MSI functions (arch_setup_msi_irq(), arch_teardown_msi_irq()
> and arch_msi_check_device()) which check if a PCI device's bus has an
> attached MSI chip and forward the call appropriately.
>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I'm OK with this patch in principle, but I do have a couple comments below.

> ---
>  drivers/pci/msi.c   | 22 ++++++++++++++++++++++
>  drivers/pci/probe.c |  1 +
>  include/linux/msi.h | 11 +++++++++++
>  include/linux/pci.h |  1 +
>  4 files changed, 35 insertions(+)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 289fbfd..62eb3d5 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -32,15 +32,37 @@ static int pci_msi_enable = 1;
>
>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
> +       struct msi_chip *chip = dev->bus->msi;
> +
> +       if (chip && chip->setup_irq) {
> +               int err;
> +
> +               err = chip->setup_irq(chip, dev, desc);
> +               if (err < 0)
> +                       return err;
> +
> +               irq_set_chip_data(desc->irq, chip);
> +               return err;
> +       }
> +
>         return -EINVAL;

It's sub-optimal to indent the whole body of a function like this.  I
think this is a bit more readable:

    if (!chip || !chip->setup_irq)
        return -EINVAL

    err = chip->setup_irq(...);
    ...
    return err;

The return value of ->setup_irq() (and hence of arch_setup_msi_irq())
is a bit unclear.  Apparently it can return negative values (errors)
or positive values (not sure what they mean), or zero (again, not
sure).  A comment would clear this up.

It might even be worth introducing a no-op chip with pointers to no-op
functions so we don't have to do these checks ("if (chip &&
chip->xxx)" everywhere.  I'm not sure if there's a Linux consensus on
that -- certainly there are many examples of code that *does* make
these checks everywhere -- so I'll ack it either way.

>  }
>
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
> +       struct msi_chip *chip = irq_get_chip_data(irq);
> +
> +       if (chip && chip->teardown_irq)
> +               chip->teardown_irq(chip, irq);
>  }
>
>  int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>  {
> +       struct msi_chip *chip = dev->bus->msi;
> +
> +       if (chip && chip->check_device)
> +               return chip->check_device(chip, dev, nvec, type);
> +

These functions are poorly named.  They give no clue what
"check_device" means.  Are we checking that it exists, that it
supports some property, that it's enabled, ... ?

>         return 0;
>  }
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 70f10fa..c8591e4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -634,6 +634,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>
>         child->parent = parent;
>         child->ops = parent->ops;
> +       child->msi = parent->msi;
>         child->sysdata = parent->sysdata;
>         child->bus_flags = parent->bus_flags;
>
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index c82ff8d..5b357d92 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -63,4 +63,15 @@ void arch_restore_msi_irqs(struct pci_dev *dev, int irq);
>
>  void default_teardown_msi_irqs(struct pci_dev *dev);
>
> +struct msi_chip {
> +       struct module *owner;
> +       struct device *dev;
> +
> +       int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
> +                        struct msi_desc *desc);
> +       void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
> +       int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
> +                           int nvec, int type);
> +};
> +
>  #endif /* LINUX_MSI_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3a24e4f..7ffc012 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -432,6 +432,7 @@ struct pci_bus {
>         struct resource busn_res;       /* bus numbers routed to this bus */
>
>         struct pci_ops  *ops;           /* configuration access functions */
> +       struct msi_chip *msi;           /* MSI controller */
>         void            *sysdata;       /* hook for sys-specific extension */
>         struct proc_dir_entry *procdir; /* directory entry in /proc/bus/pci */
>
> --
> 1.8.1.2
>
