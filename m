Return-Path: <SRS0=hMXE=DK=bombadil.srs.infradead.org=BATV+30cbe128c006e9007863+5226+infradead.org+hch@kernel.org>
Return-Path: <SRS0=hMXE=DK=bombadil.srs.infradead.org=BATV+30cbe128c006e9007863+5226+infradead.org+hch@kernel.org>
Date: Thu, 14 Dec 2017 04:52:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Govinda Tatti <Govinda.Tatti@Oracle.COM>, jgross@suse.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	JBeulich@suse.com, bhelgaas@google.com,
	xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
	roger.pau@citrix.com, Christoph Hellwig <hch@infradead.org>
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
Message-ID: <20171214125206.GA24958@infradead.org>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 13, 2017 at 03:24:21PM -0600, Bjorn Helgaas wrote:
> Prior to a60a2b73ba69, we had
> 
>   int pcie_flr(struct pci_dev *dev, int probe);
> 
> like all the other reset methods.  AFAICT, the addition of
> pcie_has_flr() was to optimize the path slightly because when drivers
> call pcie_flr(), they should already know that their hardware supports
> FLR.  But I don't think that optimization is worth the extra code
> complexity.  If we do need to optimize it, we can check this in the
> core during enumeration and set PCI_DEV_FLAGS_NO_FLR_RESET
> accordingly.
> 
> Christoph, chime in if I'm missing something here.

Didn't we just have that discussion in another thread a few days
ago?  I think that the pcie_has_flr was a mistake in retrospective but I
think the bool probe API was an even bigger mistake.  The only use
of it is to hide the reset attribute in sysfs.  I'd much rather always
have it and have it return EOPNOTSUPP if no reset method is supported.

I can send a patch for that if it sounds fine to you.
