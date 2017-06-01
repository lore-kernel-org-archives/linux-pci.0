Return-Path: <SRS0=mIG0=5G=lst.de=hch@kernel.org>
Return-Path: <SRS0=mIG0=5G=lst.de=hch@kernel.org>
Date: Thu, 1 Jun 2017 12:46:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, rakesh@tuxera.com,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: ensure the PCI device is locked over
	->reset_notify calls
Message-ID: <20170601104601.GA22620@lst.de>
References: <20170523054202.7985-1-hch@lst.de> <20170523054202.7985-2-hch@lst.de> <20170530222844.GE14896@bhelgaas-glaptop.roam.corp.google.com> <20170531045848.GA4001@lst.de> <20170531165131.GA4496@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531165131.GA4496@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 31, 2017 at 11:51:31AM -0500, Bjorn Helgaas wrote:
> Do you have any thoughts on whether the paths I mentioned above are
> also susceptible?

At least in theory ever method call that doesn't have the device
locked is susceptible, so yes.
