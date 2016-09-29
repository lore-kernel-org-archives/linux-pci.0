Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57979 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcI2Smx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 14:42:53 -0400
Date: Thu, 29 Sep 2016 11:42:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] vfio_pci: use pci_irq_allocate_vectors
Message-ID: <20160929184251.GA16811@infradead.org>
References: <1473600688-24043-1-git-send-email-hch@lst.de>
 <1473600688-24043-5-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473600688-24043-5-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 11, 2016 at 03:31:26PM +0200, Christoph Hellwig wrote:
> Simply the interrupt setup by using the new PCI layer helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Any chance to get a review for this one?  Vfio seems to be actively
maintained, so the silence seems odd.  I'm still hoping to get rid
of the pci_enable_msi_range interface for 4.9.
