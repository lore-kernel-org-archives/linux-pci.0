Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54788 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932658AbbBBTLv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 14:11:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
Date: Mon, 02 Feb 2015 18:02:16 +0100
Message-ID: <4145359.V8A0ARGtXz@wuerfel>
In-Reply-To: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 28 January 2015 14:51:23 Marc Zyngier wrote:
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

I'm puzzled by this. Why is it even important what we write into
the config space? Isn't this just an interface between BIOS and
OS for systems that rely on the interrupt numbers to be statically
assigned before boot?

	Arnd
