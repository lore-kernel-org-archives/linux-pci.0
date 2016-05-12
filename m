Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38592 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbcELHDx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2016 03:03:53 -0400
Date: Thu, 12 May 2016 00:03:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] NVMe: Only release requested regions
Message-ID: <20160512070352.GB20802@infradead.org>
References: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>  static void nvme_dev_unmap(struct nvme_dev *dev)
>  {
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	int bars;
> +
>  	if (dev->bar)
>  		iounmap(dev->bar);
> -	pci_release_regions(to_pci_dev(dev->dev));
> +
> +	bars = pci_select_bars(pdev, IORESOURCE_MEM);
> +	pci_release_selected_regions(pdev, bars);

This looks fine, but I really hate this API.

Can someone add these two nice helpers to pci.h:

static inline int
pci_request_mem_regions(struct pci_dev *pdev, const char *name)
{
	return pci_request_selected_regions(pdev,
			pci_select_bars(pdev, IORESOURCE_MEM), name);
}

static inline void
pci_release_mem_regions(struct pci_dev *pdev)
{
	return pci_release_selected_regions(pdev,
			pci_select_bars(pdev, IORESOURCE_MEM));
}

But for now this should do it:

Reviewed-by: Christoph Hellwig <hch@lst.de>
