Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Mon, 13 Jun 2016 17:28:10 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
Message-ID: <20160613212810.GG12766@localhost.localdomain>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <20160613211411.GC18747@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160613211411.GC18747@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 13, 2016 at 04:14:11PM -0500, Bjorn Helgaas wrote:
> On Tue, May 17, 2016 at 03:39:58PM -0600, Keith Busch wrote:
> > Every sriov capable driver has to check if any guest is using a virtual
> > function prior to disabling, so let's make it common code.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> If I understand the discussion correctly, this is still racy but
> nobody objects to adding this until we have a better, non-racy
> solution.

My understanding as well: there's a potential race, but no different
than what exists with today.
 
> However, you added this in common code and took advantage of it in
> nvme.  Good so far.  But we have about a dozen other drivers that call
> pci_vfs_assigned().  I assume some of those places could be changed so
> they take advantage of this check in the core instead?

> Can we do that at the same time?  If we add good new stuff and only
> use it one place, there's not as much overall goodness as there would
> be if we updated everybody to do it similarly.

Sounds good, I'll send a series taking advantage of this for all the
other PF drivers duplicating this check in their sriov_configure.
