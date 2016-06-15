Return-Path: <BATV+aeca86be1910f2be2f7c+4679+infradead.org+hch@bombadil.srs.infradead.org>
Return-Path: <BATV+aeca86be1910f2be2f7c+4679+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 15 Jun 2016 03:26:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
Message-ID: <20160615102659.GB32253@infradead.org>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <20160613211411.GC18747@localhost>
 <20160613212810.GG12766@localhost.localdomain>
 <20160613215736.GH12766@localhost.localdomain>
 <20160613222630.GD18747@localhost>
 <20160613223551.GJ12766@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160613223551.GJ12766@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 13, 2016 at 06:35:52PM -0400, Keith Busch wrote:
> On Mon, Jun 13, 2016 at 05:26:30PM -0500, Bjorn Helgaas wrote:
> > My take on that is, "it's a pretty trival check; just put it directly
> > in nvme and don't bother doing anything in the PCI core."  Maybe
> > someday we'll come up with a way to make things more common.  It
> > doesn't really seem worth it to add something that only helps three
> > drivers.
> 
> Fair enough. Will withdraw the check in pci and resend nvme.

Sorry for leading you down this path..
