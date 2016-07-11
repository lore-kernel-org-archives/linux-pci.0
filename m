Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:38579 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750779AbcGKIj0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jul 2016 04:39:26 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [RFC] pci: Provide a domain limited version of pdev_fixup_irq
Date: Mon, 11 Jul 2016 08:39:20 +0000
Message-ID: <HK2PR0601MB139310D5AF6ECA1817FA4ADBF53F0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1467978595-25386-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1467978595-25386-1-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Note that kbuild test failed because domain_nr is only available when we
have CONFIG_PCI_DOMAINS_GENERIC defined, so the patch will definitely
have to change.

Phil

On 08 July 2016 12:50, Phil Edworthy wrote:
> Hi Bjorn,
> 
> I've marked this as RFC as I guess there might be a better way to do
> this, but I'm not sure how. I would appreciate your thoughts on this.
> 
> Thanks
> Phil
> 
> ---
> pdev_fixup_irq() performs interrupt swizzling on all PCI devices,
> no matter that the device may be on a completely unrelated PCI
> Host controller.
> 
> When you have multiple PCI Host controllers, pdev_fixup_irq() can
> clobber the dev->irq of devices it should not be changing.
> This has been seen when performing suspend/resume on boards with
> two R-Car PCIe Host controllers, resulting in a NULL ptr access
> in __pci_restore_msi_state. This happens because dev->irq has been
> overwritten with 0, and irq_get_msi_desc(dev->irq) returns NULL.
> 
> This patch introduces a new function, pci_fixup_irqs_local(), that
> performs the same operation as pdev_fixup_irq(), but only changes
> the dev->irq of device on the same domain.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  drivers/pci/setup-irq.c | 25 ++++++++++++++++++++++---
>  include/linux/pci.h     |  3 +++
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> index 95c225b..90ea8fa 100644
> --- a/drivers/pci/setup-irq.c
> +++ b/drivers/pci/setup-irq.c
> @@ -22,7 +22,8 @@ void __weak pcibios_update_irq(struct pci_dev *dev, int
> irq)
>  	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
>  }
> 
> -static void pdev_fixup_irq(struct pci_dev *dev,
> +static void pdev_fixup_irq(int domain_nr,
> +			   struct pci_dev *dev,
>  			   u8 (*swizzle)(struct pci_dev *, u8 *),
>  			   int (*map_irq)(const struct pci_dev *, u8, u8))
>  {
> @@ -48,8 +49,15 @@ static void pdev_fixup_irq(struct pci_dev *dev,
>  		if (irq == -1)
>  			irq = 0;
>  	}
> -	dev->irq = irq;
> +	/* Since pci_fixup_irqs() can be called more than once due to multiple
> +	 * host controllers, and we scan all PCI devices, not just those
> +	 * attached to this controller, make sure we don't clobber dev->irq
> +	 * that has nothing to do with this domain.
> +	 */
> +	if (domain_nr >= 0 && dev->bus->domain_nr != domain_nr)
> +		return;
> 
> +	dev->irq = irq;
>  	dev_dbg(&dev->dev, "fixup irq: got %d\n", dev->irq);
> 
>  	/* Always tell the device, so the driver knows what is
> @@ -63,6 +71,17 @@ void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
>  	struct pci_dev *dev = NULL;
> 
>  	for_each_pci_dev(dev)
> -		pdev_fixup_irq(dev, swizzle, map_irq);
> +		pdev_fixup_irq(-1, dev, swizzle, map_irq);
>  }
>  EXPORT_SYMBOL_GPL(pci_fixup_irqs);
> +
> +void pci_fixup_irqs_local(struct pci_bus *bus,
> +		    u8 (*swizzle)(struct pci_dev *, u8 *),
> +		    int (*map_irq)(const struct pci_dev *, u8, u8))
> +{
> +	struct pci_dev *dev = NULL;
> +
> +	for_each_pci_dev(dev)
> +		pdev_fixup_irq(bus->domain_nr, dev, swizzle, map_irq);
> +}
> +EXPORT_SYMBOL_GPL(pci_fixup_irqs_local);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8badb66..37a97df 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1134,6 +1134,9 @@ void pdev_enable_device(struct pci_dev *);
>  int pci_enable_resources(struct pci_dev *, int mask);
>  void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
>  		    int (*)(const struct pci_dev *, u8, u8));
> +void pci_fixup_irqs_local(struct pci_bus *,
> +		    u8 (*)(struct pci_dev *, u8 *),
> +		    int (*)(const struct pci_dev *, u8, u8));
>  #define HAVE_PCI_REQ_REGIONS	2
>  int __must_check pci_request_regions(struct pci_dev *, const char *);
>  int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
> --
> 2.5.0

