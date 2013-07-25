Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:62810 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab3GYU0n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 16:26:43 -0400
Received: by mail-ob0-f173.google.com with SMTP id er7so2537959obc.4
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 13:26:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1373889167-27878-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-5-git-send-email-thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Jul 2013 14:26:22 -0600
Message-ID: <CAErSpo45xs-A8wCwVGtdn0NEUq1-j96=+h2jdKB8xdRoe0YAvg@mail.gmail.com>
Subject: Re: [PATCHv5 04/11] PCI: Introduce new MSI chip infrastructure
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

On Mon, Jul 15, 2013 at 5:52 AM, Thomas Petazzoni
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

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi.c   | 27 +++++++++++++++++++++++++--
>  drivers/pci/probe.c |  1 +
>  include/linux/msi.h | 11 +++++++++++
>  include/linux/pci.h |  1 +
>  4 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index aa2f697..d5b6378 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -32,16 +32,39 @@ static int pci_msi_enable = 1;
>
>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
> -       return -EINVAL;
> +       struct msi_chip *chip = dev->bus->msi;
> +       int err;
> +
> +       if (!chip || !chip->setup_irq)
> +               return -EINVAL;
> +
> +       err = chip->setup_irq(chip, dev, desc);
> +       if (err < 0)
> +               return err;
> +
> +       irq_set_chip_data(desc->irq, chip);
> +
> +       return 0;
>  }
>
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
> +       struct msi_chip *chip = irq_get_chip_data(irq);
> +
> +       if (!chip || !chip->teardown_irq)
> +               return;
> +
> +       chip->teardown_irq(chip, irq);
>  }
>
>  int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>  {
> -       return 0;
> +       struct msi_chip *chip = dev->bus->msi;
> +
> +       if (!chip || !chip->check_device)
> +               return 0;
> +
> +       return chip->check_device(chip, dev, nvec, type);
>  }
>
>  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 46ada5c..b8eaa81 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -666,6 +666,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>
>         child->parent = parent;
>         child->ops = parent->ops;
> +       child->msi = parent->msi;
>         child->sysdata = parent->sysdata;
>         child->bus_flags = parent->bus_flags;
>
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 18870b0..cbf5d05 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -64,4 +64,15 @@ void arch_restore_msi_irqs(struct pci_dev *dev, int irq);
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
> index 0fd1f15..4044e3c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -433,6 +433,7 @@ struct pci_bus {
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
