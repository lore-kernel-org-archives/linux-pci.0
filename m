Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37701 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbbLQSOv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 13:14:51 -0500
Date: Thu, 17 Dec 2015 12:14:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv6 5/7] x86/pci: Initial commit for new VMD device driver
Message-ID: <20151217181448.GF23549@localhost>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-6-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449523949-21898-6-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 07, 2015 at 02:32:27PM -0700, Keith Busch wrote:
> The Intel Volume Management Device (VMD) is an integrated endpoint on the
> platform's PCIe root complex that acts as a host bridge to a secondary
> PCIe domain. BIOS can reassign one or more root ports to appear within
> a VMD domain instead of the primary domain. The immediate benefit is
> that additional PCI-e domains allow more than 256 buses in a system by
> letting bus number be reused across different domains.

> +/*
> + * VMD h/w converts posted config writes to non-posted. The read-back in this
> + * function forces the completion so it returns only after the config space was
> + * written, as expected.

This comment sounds backwards:

  posted writes don't wait for completion
  non-posted writes do wait for completion

If the hardware converts to non-posted writes, you shouldn't need a
read-back.  It seems like you would need the read-back if the hardware
converted non-posted to posted.

> + */
> +static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
> +							int len, u32 value)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +	struct vmd_dev *vmd = vmd_from_bus(bus);
> +	char __iomem *addr = vmd->cfgbar + (bus->number << 20) +
> +						(devfn << 12) + reg;
> +
> +	if ((addr - vmd->cfgbar) + len >= resource_size(&vmd->dev->resource[0]))
> +		return -EFAULT;
> +
> +	spin_lock_irqsave(&vmd->cfg_lock, flags);
> +	switch (len) {
> +	case 1:
> +		writeb(value, addr);
> +		readb(addr);
> +		break;
> +	case 2:
> +		writew(value, addr);
> +		readw(addr);
> +		break;
> +	case 4:
> +		writel(value, addr);
> +		readl(addr);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
> +	return ret;
> +}

> +static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
> +{
> +	struct vmd_dev *vmd;
> +	int i, err;
> +
> +	if (resource_size(&dev->resource[0]) < (1 << 20))
> +		return -ENOMEM;
> +
> +	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
> +	if (!vmd)
> +		return -ENOMEM;
> +
> +	vmd->dev = dev;
> +	err = pcim_enable_device(dev);
> +	if (err < 0)
> +		return err;
> +
> +	vmd->cfgbar = pcim_iomap(dev, 0, 0);
> +	if (!vmd->cfgbar)
> +		return -ENOMEM;
> +
> +	pci_set_master(dev);
> +	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
> +	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
> +		return -ENODEV;
> +
> +	vmd->msix_count = pci_msix_vec_count(dev);
> +	if (vmd->msix_count < 0)
> +		return -ENODEV;
> +
> +	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
> +							GFP_KERNEL);
> +	if (!vmd->irqs)
> +		return -ENOMEM;
> +
> +	vmd->msix_entries = devm_kcalloc(&dev->dev, vmd->msix_count,
> +					sizeof(*vmd->msix_entries), GFP_KERNEL);
> +	if(!vmd->msix_entries)
> +		return -ENOMEM;
> +	for (i = 0; i < vmd->msix_count; i++)
> +		vmd->msix_entries[i].entry = i;
> +
> +	vmd->msix_count = pci_enable_msix_range(vmd->dev, vmd->msix_entries, 1,
> +							vmd->msix_count);
> +	if (vmd->msix_count < 0)
> +		return vmd->msix_count;
> +
> +	for (i = 0; i < vmd->msix_count; i++) {
> +		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> +		vmd->irqs[i].vmd_vector = vmd->msix_entries[i].vector;
> +		vmd->irqs[i].index = i;
> +
> +		err = devm_request_irq(&dev->dev, vmd->irqs[i].vmd_vector,
> +				vmd_irq, 0, "vmd", &vmd->irqs[i]);
> +		if (err)
> +			return err;
> +	}
> +	spin_lock_init(&vmd->cfg_lock);
> +	pci_set_drvdata(dev, vmd);

Seems like it might be nice to have something in dmesg that would connect
this PCI device to the new PCI domain.  It's a new, unusual topology and a
hint might help everybody understand what's going on.

> +	err = vmd_enable_domain(vmd);
> +	if (err)
> +		return err;
> +	return 0;
> +}

Bjorn
