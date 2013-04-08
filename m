Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:47541 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762266Ab3DHW3S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 18:29:18 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so6863874oag.36
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2013 15:29:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364316746-8702-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-9-git-send-email-thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 8 Apr 2013 16:28:58 -0600
Message-ID: <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
Subject: Re: [RFCv1 08/11] PCI: Introduce new MSI chip infrastructure
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 26, 2013 at 10:52 AM, Thomas Petazzoni
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
> ---
>  drivers/pci/msi.c   |   35 +++++++++++++++++++++++++++++++----
>  drivers/pci/probe.c |    1 +
>  include/linux/msi.h |   10 ++++++++++
>  include/linux/pci.h |    1 +
>  4 files changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 00cc78c..fce3549 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -26,14 +26,41 @@
>
>  static int pci_msi_enable = 1;
>
> -/* Arch hooks */
> +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +{
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
> +       return -EINVAL;
> +}
>
> -#ifndef arch_msi_check_device
> -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> +void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
> +       struct msi_chip *chip = irq_get_chip_data(irq);
> +
> +       if (chip && chip->teardown_irq)
> +               chip->teardown_irq(chip, irq);
> +}
> +
> +int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)

I like the replacement of "#ifndef arch_msi_check_device()" with a
weak implementation here, but this only does half the job -- shouldn't
we remove the powerpc "#define arch_msi_check_device
arch_msi_check_device" at the same time?

And since we're touching all the check_device() implementations, maybe
we could come up with a better name.  "check_device()" conveys
absolutely no information about what we're checking or what the sense
of the result is.  arch_msi_supported()?  pcibios_msi_supported()?  I
guess it should be consistent with the other arch interfaces, so
arch_*() is probably better.

Maybe the ugly #ifdef-ery around arch_setup_msi_irqs,
arch_teardown_msi_irqs, and arch_restore_msi_irqs could be cleaned up
similarly?  Somebody worked pretty hard to obfuscate all that,
probably before weak functions were available.

> +{
> +       struct msi_chip *chip = dev->bus->msi;
> +
> +       if (chip && chip->check_device)
> +               return chip->check_device(chip, dev, nvec, type);
> +
>         return 0;
>  }
> -#endif
>
>  #ifndef arch_setup_msi_irqs
>  # define arch_setup_msi_irqs default_setup_msi_irqs
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b494066..9307550 100644
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
> index ce93a34..ea4a5be 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -58,5 +58,15 @@ extern int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
>  extern void arch_teardown_msi_irqs(struct pci_dev *dev);
>  extern int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
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

If we do end up adding interfaces like this (I'm not sure it will work
-- see below), I think it would be better to pass just the pci_dev,
not the "msi_chip, pci_dev" pair.  Passing both pointers avoids a
cheap lookup in the caller, but it adds a way that two inseparable
things can get out of sync.

> +};
>
>  #endif /* LINUX_MSI_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2461033a..6aca43ea 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -416,6 +416,7 @@ struct pci_bus {
>         struct resource busn_res;       /* bus numbers routed to this bus */
>
>         struct pci_ops  *ops;           /* configuration access functions */
> +       struct msi_chip *msi;           /* MSI controller */

"msi" seems like a too-generic name here; it suggests an interrupt or
IRQ, not a controller.

I'm not sure this is the correct place for it.  Having it in the
struct pci_bus means you need arch code to fill it in, e.g., you added
it in mvebu_pcie_scan_bus() in patch 09/11.  There's no good way to do
that for arches that use pci_scan_root_bus(), which is the direction
I'd like to go.

I think it probably should go in sysdata instead.  That would mean you
can't really do generic weak setup/tear-down functions, because they
wouldn't know how to pull the MSI controller info out of the
arch-specific sysdata.  But there are so many levels of weak-ness
going on there, maybe it would be a good thing to get rid of one :)

Bjorn

>         void            *sysdata;       /* hook for sys-specific extension */
>         struct proc_dir_entry *procdir; /* directory entry in /proc/bus/pci */
>
> --
> 1.7.9.5
>
