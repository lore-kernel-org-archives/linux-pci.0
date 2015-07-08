Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36565 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbbGHKsn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2015 06:48:43 -0400
Date: Wed, 8 Jul 2015 12:48:34 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 09/15] irqchip: gicv3-its: Split PCI/MSI code from
 the core ITS driver
In-Reply-To: <1436289485-28230-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.11.1507081245120.5134@nanos>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com> <1436289485-28230-10-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 7 Jul 2015, Marc Zyngier wrote:
> +static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
> +			       int nvec, msi_alloc_info_t *info)
> +{
> +	struct pci_dev *pdev;
> +	struct its_pci_alias dev_alias;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +	dev_alias.pdev = pdev;
> +	dev_alias.count = nvec;
> +
> +	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
> +
> +	return its_msi_prepare(domain, dev_alias.dev_id, dev_alias.count, info);

I don't think you need its_msi_prepare() exposed to child
drivers. Something like

  domain->parent->ops->msi_prepare()

should do the trick.

Thanks,

	tglx
