Return-Path: <SRS0=q3r5=EF=lst.de=hch@kernel.org>
Return-Path: <SRS0=q3r5=EF=lst.de=hch@kernel.org>
Date: Wed, 10 Jan 2018 09:14:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-pci@vger.kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pci-dma-compat: remove handling of NULL pdev
	arguments
Message-ID: <20180110081426.GC9659@lst.de>
References: <20180109203939.5930-1-hch@lst.de> <20180109203939.5930-4-hch@lst.de> <20180110002544.GA157182@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180110002544.GA157182@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 09, 2018 at 06:25:44PM -0600, Bjorn Helgaas wrote:
> It looks like "pci_free_consistent(NULL" is still used in
> drivers/net/ethernet/tundra/tsi108_eth.c.

Yikes.  That one needs to pass the device is the platform dev to
the dma_map_* routines to start with, and mixing that with PCI
is pretty horrible.  I'll add a conversion of that driver to the
next resend.

> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> With Mauro's ack on the media/ttusb-dev patches, I could merge the
> whole series via the PCI tree?

Fine with me.
