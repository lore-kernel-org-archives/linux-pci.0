Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38867 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbcELOiR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2016 10:38:17 -0400
Date: Thu, 12 May 2016 07:38:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme/pci: Provide SR-IOV support
Message-ID: <20160512143810.GA23358@infradead.org>
References: <1463062410-10009-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463062410-10009-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 12, 2016 at 08:13:30AM -0600, Keith Busch wrote:
> This registers a standard boiler-plate sr-iov callback for nvme.

No real reason not to add it, but..


> +static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
> +{
> +	int ret = 0;
> +
> +	if (!pdev->is_physfn)
> +		return -EPERM;

pci_enable_sriov / pci_disable_sriov already check this.

> +	if (numvfs == 0) {
> +		if (pci_vfs_assigned(pdev)) {
> +			dev_warn(&pdev->dev,
> +				"Cannot disable SR-IOV VFs while assigned\n");
> +			return -EPERM;
> +		}

And pci_disable_sriov really should check this.

> +		pci_disable_sriov(pdev);
> +	} else
> +		ret = pci_enable_sriov(pdev, numvfs);

And these calls really should be done in common code.  At that point
there will be a whole lot less driver involvement with SR-IOV which
shouldn't exist, and we can split the callback into two for enable vs
disable instead of the overload that each driver then needs to
demultiplex.

I guess I can't just burden the second half on you, but at least
removing the first check and moving the second to the core would seem
like a good start.
