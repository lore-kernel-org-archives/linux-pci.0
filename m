Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:62652 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbbBBP6G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 10:58:06 -0500
Received: by mail-qc0-f171.google.com with SMTP id s11so30796352qcv.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2015 07:58:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Feb 2015 09:57:45 -0600
Message-ID: <CAErSpo5=NhPZ5RNbBeGqKuLbKdOyTD1m+ijWM2SzQFWuKLTJfg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 28, 2015 at 8:51 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> pcibios_update_irq writes an irq number into the config space
> of a given PCI device, but ignores the fact that this number
> is a virtual interrupt number, which might be a very different
> value from what the underlying hardware is using.
>
> The obvious fix is to fetch the HW interrupt number from the
> corresponding irq_data structure. This is slightly complicated
> by the fact that this interrupt might be services by a stacked
> domain.
>
> This has been tested on KVM with kvmtool.
>
> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Jiang, are you OK with this patch as-is now, since it isn't used on x86?

Marc, Lorenzo, I assume this actually fixes a bug.  Can we get any
more details about what happens when you hit the bug, and how you
reproduced it (what platform, driver, etc.)?

Bjorn

> ---
>  drivers/pci/setup-irq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> index 4e2d595..828cbc9 100644
> --- a/drivers/pci/setup-irq.c
> +++ b/drivers/pci/setup-irq.c
> @@ -15,11 +15,19 @@
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
>  #include <linux/cache.h>
> +#include <linux/irq.h>
>
>  void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
>  {
> -       dev_dbg(&dev->dev, "assigning IRQ %02d\n", irq);
> -       pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
> +       struct irq_data *d;
> +
> +       d = irq_get_irq_data(irq);
> +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
> +       while (d->parent_data)
> +               d = d->parent_data;
> +#endif
> +       dev_dbg(&dev->dev, "assigning IRQ %02ld\n", d->hwirq);
> +       pci_write_config_byte(dev, PCI_INTERRUPT_LINE, d->hwirq);
>  }
>
>  static void pdev_fixup_irq(struct pci_dev *dev,
> --
> 2.1.4
>
