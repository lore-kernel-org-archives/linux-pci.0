Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60466 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425AbcEPTjd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 May 2016 15:39:33 -0400
Date: Mon, 16 May 2016 14:39:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: agordeev@redhat.com, pjw@netapp.com, axboe@fb.com,
	keith.busch@intel.com, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
Message-ID: <20160516193929.GA20759@localhost>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
 <1462457096-19795-2-git-send-email-hch@lst.de>
 <20160509224631.GB18501@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160509224631.GB18501@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 09, 2016 at 05:46:31PM -0500, Bjorn Helgaas wrote:
> On Thu, May 05, 2016 at 04:04:55PM +0200, Christoph Hellwig wrote:
> > Add a new pci_alloc_irq_vectors helper that allocates MSI-X or multi-MSI
> > vectors for PCI device while isolating the driver from the arcane details.
> > 
> > This include handling both MSI-X, MSI and legacy interrupt fallbacks
> > transparently, automatic capping to the available vectors as well as storing
> > the information needed for request_irq in the PCI device itself so that
> > a lot of boiler plate code in the driver can be removed.
> > 
> > In the future this will also allow us to automatically set up spreading
> > for interrupt vectors without having to duplicate it in all the drivers.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks, I applied this to pci/msi for v4.7.

Given the subsequent discussion, it seems a little premature to merge
this for v4.7, so I'm dropping this for now.

Bjorn
