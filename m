Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36318 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbcGKUvP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jul 2016 16:51:15 -0400
Date: Mon, 11 Jul 2016 22:51:11 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] pci: spread interrupt vectors in
 pci_alloc_irq_vectors
Message-ID: <20160711205110.GA23915@dhcp-27-118.brq.redhat.com>
References: <1468151866-7776-1-git-send-email-hch@lst.de>
 <1468151866-7776-6-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468151866-7776-6-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 10, 2016 at 08:57:46PM +0900, Christoph Hellwig wrote:
> @@ -1028,19 +1038,8 @@ int pci_msi_enabled(void)
>  }
>  EXPORT_SYMBOL(pci_msi_enabled);
>  
> -/**
> - * pci_enable_msi_range - configure device's MSI capability structure
> - * @dev: device to configure
> - * @minvec: minimal number of interrupts to configure
> - * @maxvec: maximum number of interrupts to configure
> - *
> - * This function tries to allocate a maximum possible number of interrupts in a
> - * range between @minvec and @maxvec. It returns a negative errno if an error
> - * occurs. If it succeeds, it returns the actual number of interrupts allocated
> - * and updates the @dev's irq member to the lowest new interrupt number;
> - * the other interrupt numbers allocated to this device are consecutive.
> - **/
> -int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
> +static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> +		unsigned int flags)
>  {
>  	int nvec;
>  	int rc;
> @@ -1068,21 +1067,78 @@ int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
>  	else if (nvec > maxvec)
>  		nvec = maxvec;
>  
> -	do {
> +	for (;;) {
> +		if (!(flags & PCI_IRQ_NOAFFINITY)) {
> +			dev->irq_affinity = irq_create_affinity_mask(&nvec);
> +			if (nvec < minvec)
> +				return -ERANGE;

				return -ENOSPC;

> +		}
> +
>  		rc = msi_capability_init(dev, nvec);
> -		if (rc < 0) {
> +		if (rc == 0)
> +			return nvec;
> +
> +		kfree(dev->irq_affinity);
> +		dev->irq_affinity = NULL;
> +
> +		if (rc < 0)
>  			return rc;
> -		} else if (rc > 0) {
> -			if (rc < minvec)
> -				return -ENOSPC;
> -			nvec = rc;
> -		}
> -	} while (rc);
> +		if (rc < minvec)

		else if (rc < minvec)

> +			return -ENOSPC;
> +		nvec = rc;
> +	}
> +}
>  
> -	return nvec;
> +/**
> + * pci_enable_msi_range - configure device's MSI capability structure
> + * @dev: device to configure
> + * @minvec: minimal number of interrupts to configure
> + * @maxvec: maximum number of interrupts to configure
> + *
> + * This function tries to allocate a maximum possible number of interrupts in a
> + * range between @minvec and @maxvec. It returns a negative errno if an error
> + * occurs. If it succeeds, it returns the actual number of interrupts allocated
> + * and updates the @dev's irq member to the lowest new interrupt number;
> + * the other interrupt numbers allocated to this device are consecutive.
> + **/
> +int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
> +{
> +	return __pci_enable_msi_range(dev, minvec, maxvec, PCI_IRQ_NOAFFINITY);
>  }
>  EXPORT_SYMBOL(pci_enable_msi_range);

As a one-liner pci_enable_msi_range() appears rather as a static inline
in linux/pci.h, but we do not want __pci_enable_msi*_range() to show up
in a public header, right?

> +static int __pci_enable_msix_range(struct pci_dev *dev,
> +		struct msix_entry *entries, int minvec, int maxvec,
> +		unsigned int flags)
> +{
> +	int nvec = maxvec;
> +	int rc;
> +
> +	if (maxvec < minvec)
> +		return -ERANGE;
> +
> +	for (;;) {
> +		if (!(flags & PCI_IRQ_NOAFFINITY)) {
> +			dev->irq_affinity = irq_create_affinity_mask(&nvec);
> +			if (nvec < minvec)
> +				return -ERANGE;

				return -ENOSPC;

> +		}
> +
> +		rc = pci_enable_msix(dev, entries, nvec);
> +		if (rc == 0)
> +			return nvec;
> +
> +		kfree(dev->irq_affinity);
> +		dev->irq_affinity = NULL;
> +
> +		if (rc < 0)
> +			return rc;
> +		if (rc < minvec)

		else if (rc < minvec)

> +			return -ENOSPC;
> +		nvec = rc;
> +	}
> +}
> +
>  /**
>   * pci_enable_msix_range - configure device's MSI-X capability structure
>   * @dev: pointer to the pci_dev data structure of MSI-X device function
