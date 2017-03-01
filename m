Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51962 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbdCAPVs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Mar 2017 10:21:48 -0500
Date: Wed, 1 Mar 2017 16:20:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] PCI/MSI: Only disable affinity settings if pre and
        post vector count is equal to max_vecs and not min_vecs
Message-ID: <20170301152056.GA12708@lst.de>
References: <1487883699-3528-1-git-send-email-himanshu.madhani@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487883699-3528-1-git-send-email-himanshu.madhani@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> @@ -1206,16 +1228,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
>  			affd = &msi_default_affd;
> -
> -		if (affd->pre_vectors + affd->post_vectors > min_vecs)
> -			return -EINVAL;

Actually I think we can leave this check here.

> -
> -		/*
> -		 * If there aren't any vectors left after applying the pre/post
> -		 * vectors don't bother with assigning affinity.
> -		 */
> -		if (affd->pre_vectors + affd->post_vectors == min_vecs)
> -			affd = NULL;

And only move this one down into the allocator helpers.
