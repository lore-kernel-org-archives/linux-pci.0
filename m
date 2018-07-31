Return-Path: <SRS0=Thfy=KP=lst.de=hch@kernel.org>
Return-Path: <SRS0=Thfy=KP=lst.de=hch@kernel.org>
Date: Tue, 31 Jul 2018 10:07:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common
	code
Message-ID: <20180731080723.GA23303@lst.de>
References: <20180730073842.16092-1-hch@lst.de> <20180730211713.GA45322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730211713.GA45322@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 04:17:13PM -0500, Bjorn Helgaas wrote:
> [+cc Joerg]
> 
> On Mon, Jul 30, 2018 at 09:38:42AM +0200, Christoph Hellwig wrote:
> > There is nothing arch specific about PCI or dma-debug, so move this
> > call to common code just after registering the bus type.
> 
> I assume that previously, even if the user set CONFIG_DMA_API_DEBUG=y
> we only got PCI DMA debug on powerpc, sh, and x86.  And after this
> patch, we'll get PCI DMA debug on *all* arches?

Yes.  Note that this only covers the actual bus related part, that
is warning about outstanding dma mappings on unload.  The rest of the
dma api debugging already is entirely generic.
