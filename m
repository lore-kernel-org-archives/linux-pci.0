Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754459AbdLOAYg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 19:24:36 -0500
Date: Thu, 14 Dec 2017 18:24:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Govinda Tatti <Govinda.Tatti@Oracle.COM>, jgross@suse.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        JBeulich@suse.com, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
        roger.pau@citrix.com
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
Message-ID: <20171215002430.GS30595@bhelgaas-glaptop.roam.corp.google.com>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
 <20171214125206.GA24958@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214125206.GA24958@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 04:52:06AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 13, 2017 at 03:24:21PM -0600, Bjorn Helgaas wrote:
> > Prior to a60a2b73ba69, we had
> > 
> >   int pcie_flr(struct pci_dev *dev, int probe);
> > 
> > like all the other reset methods.  AFAICT, the addition of
> > pcie_has_flr() was to optimize the path slightly because when drivers
> > call pcie_flr(), they should already know that their hardware supports
> > FLR.  But I don't think that optimization is worth the extra code
> > complexity.  If we do need to optimize it, we can check this in the
> > core during enumeration and set PCI_DEV_FLAGS_NO_FLR_RESET
> > accordingly.
> > 
> > Christoph, chime in if I'm missing something here.
> 
> Didn't we just have that discussion in another thread a few days
> ago?

Probably, but I didn't have a clear picture of what you were suggesting.

> I think that the pcie_has_flr was a mistake in retrospective but I
> think the bool probe API was an even bigger mistake.  The only use
> of it is to hide the reset attribute in sysfs.  I'd much rather always
> have it and have it return EOPNOTSUPP if no reset method is supported.
> 
> I can send a patch for that if it sounds fine to you.

If you can get rid of the whole probe infrastructure, that sounds
good to me.

Bjorn
