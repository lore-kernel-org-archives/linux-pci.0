Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49234 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753660AbcGKLmO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jul 2016 07:42:14 -0400
Date: Mon, 11 Jul 2016 13:47:14 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] pci: Provide sensible irq vector alloc/free routines
Message-ID: <20160711114713.GD21169@agordeev.lab.eng.brq.redhat.com>
References: <1468151866-7776-1-git-send-email-hch@lst.de>
 <1468151866-7776-5-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468151866-7776-5-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 10, 2016 at 08:57:45PM +0900, Christoph Hellwig wrote:
> +/**
> + * pci_irq_vector - return Linux IRQ number of a device vector
> + * @dev: PCI device to operate on
> + * @nr: device-relative interrupt vector index (0-based).
> + */
> +int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
> +{
> +	if (dev->msix_enabled) {
> +		struct msi_desc *entry;
> +		int i = 0;
> +
> +		for_each_pci_msi_entry(entry, dev) {
> +			if (i == nr)
> +				return entry->irq;
> +			i++;
> +		}
> +		WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
> +
> +	if (WARN_ON_ONCE(!dev->msi_enabled && nr > 0))
> +		return -EINVAL;

Something like this is also needed here:

	if (WARN_ON_ONCE(nr >= msi_desc::nvec_used))
		return -EINVAL;

> +	return dev->irq + nr;
> +}
> +EXPORT_SYMBOL(pci_irq_vector);
