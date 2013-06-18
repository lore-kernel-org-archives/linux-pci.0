Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37171 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933482Ab3FRWqf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2013 18:46:35 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so11653313iec.22
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2013 15:46:35 -0700 (PDT)
Date: Tue, 18 Jun 2013 16:46:31 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: Re: [PATCH v2 1/8] PCI: Introduce new MSI chip infrastructure
Message-ID: <20130618224631.GB16134@google.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370536888-8871-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 06, 2013 at 06:41:21PM +0200, Thomas Petazzoni wrote:
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
> ---
>  drivers/pci/msi.c   | 34 +++++++++++++++++++++++++++++++---
>  drivers/pci/probe.c |  1 +
>  include/linux/msi.h | 11 +++++++++++
>  include/linux/pci.h |  1 +
>  4 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 2c10752..4dafac6 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -29,13 +29,41 @@ static int pci_msi_enable = 1;
>  
>  
>  /* Arch hooks */
> +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +{
> +	struct msi_chip *chip = dev->bus->msi;
> +
> +	if (chip && chip->setup_irq) {
> +		int err;
> +
> +		err = chip->setup_irq(chip, dev, desc);
> +		if (err < 0)
> +			return err;
> +
> +		irq_set_chip_data(desc->irq, chip);
> +		return err;
> +	}
> +
> +	return -EINVAL;
> +}
>  
> -#ifndef arch_msi_check_device
> -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> +void __weak arch_teardown_msi_irq(unsigned int irq)

Please make a separate patch before this one for the conversion from the
"#define arch_msi_check_device" strategy to the weak function.  I think
it's a good idea to use a weak function rather than the #define, but we
need to remove the #define from arch/powerpc/include/asm/pci.h at the same
time.

I don't think these patches touch arch_setup_msi_irqs() or
arch_teardown_msi_irqs(), but I'd like to do the same with them just so we
consistently use the same strategy to solve the same problem.

>  {
> +	struct msi_chip *chip = irq_get_chip_data(irq);
> +
> +	if (chip && chip->teardown_irq)
> +		chip->teardown_irq(chip, irq);
> +}
> +
> +int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> +{
> +	struct msi_chip *chip = dev->bus->msi;
> +
> +	if (chip && chip->check_device)
> +		return chip->check_device(chip, dev, nvec, type);
> +
>  	return 0;
>  }
> -#endif
>  
>  #ifndef arch_setup_msi_irqs
>  # define arch_setup_msi_irqs default_setup_msi_irqs
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 70f10fa..c8591e4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -634,6 +634,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  
>  	child->parent = parent;
>  	child->ops = parent->ops;
> +	child->msi = parent->msi;
>  	child->sysdata = parent->sysdata;
>  	child->bus_flags = parent->bus_flags;
>  
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 20c2d6d..4633529 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -58,4 +58,15 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
>  void arch_teardown_msi_irqs(struct pci_dev *dev);
>  int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
>  
> +struct msi_chip {
> +	struct module *owner;

Can the MSI chip driver be a loadable module?  Does it need to be?

> +	struct device *dev;
> +
> +	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
> +			 struct msi_desc *desc);
> +	void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
> +	int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
> +			    int nvec, int type);
> +};
> +
>  #endif /* LINUX_MSI_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3a24e4f..7ffc012 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -432,6 +432,7 @@ struct pci_bus {
>  	struct resource busn_res;	/* bus numbers routed to this bus */
>  
>  	struct pci_ops	*ops;		/* configuration access functions */
> +	struct msi_chip	*msi;		/* MSI controller */
>  	void		*sysdata;	/* hook for sys-specific extension */
>  	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci */
>  
> -- 
> 1.8.1.2
> 
