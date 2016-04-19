Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38419 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932713AbcDSVED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Apr 2016 17:04:03 -0400
Date: Tue, 19 Apr 2016 16:03:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/3] drivers: pci: host-generic: claim bus resources
 on PCI_PROBE_ONLY set-ups
Message-ID: <20160419210359.GB17863@localhost>
References: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1456843449-19393-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20160412044311.GB11361@localhost>
 <20160412154810.GA32109@red-moon>
 <20160415130803.GA2105@localhost>
 <20160418100154.GB2427@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160418100154.GB2427@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 18, 2016 at 11:01:54AM +0100, Lorenzo Pieralisi wrote:
> On Fri, Apr 15, 2016 at 08:08:03AM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 12, 2016 at 04:48:10PM +0100, Lorenzo Pieralisi wrote:
> 
> [...]
> 
> > > > The next patch removes the arm and arm64 pcibios_enable_device()
> > > > implementations, which implies that arm and arm64 only need the generic
> > > > version, which simply calls pci_enable_resources().  That assumes r->parent
> > > > is set.
> > > > 
> > > > After this patch, we'll call pci_bus_claim_resources() for the
> > > > PCI_PROBE_ONLY case, and that sets r->parent for all the resources.
> > > > 
> > > > Where does r->parent get set in the non-PCI_PROBE_ONLY case?  Obviously
> > > > that path *works*, because you're not changing anything there.  I'd just
> > > > like to have a hint that makes this change more obvious.
> > > 
> > > On all ARM/ARM64 PCI controllers drivers I am aware of (apart from the
> > > kvmtool PCI host controller which does require PCI_PROBE_ONLY, so we need
> > > this patch), resources are always reassigned and the core code reassigning
> > > them takes care of assigning their parent pointers too, to answer your
> > > question.
> > 
> > Here's what I find confusing.  Consider these three cases:
> > 
> >   1) Firmware programs no BARs and we reassign everything.  We call
> >   pci_bus_assign_resources(), and the pci_assign_resource() ...
> >   allocate_resource() path makes sure everything is claimed.  This is
> >   apparently the normal arm/arm64 path, and it already works.
> > 
> >   2) Firmware programs all BARs and we set PCI_PROBE_ONLY.  After this
> >   series, we'll claim the resources and remove the PCI_PROBE_ONLY
> >   special case in pcibios_enable_device().  This is great!
> > 
> >   3) Firmware programs all BARs but we don't set PCI_PROBE_ONLY.  We
> >   call pci_bus_assign_resources(), but I think it does nothing because
> >   everything is already assigned.  The resources are not claimed and
> >   pci_enable_resources() will fail.
> 
> I do not expect (1) and (3) to be different from a kernel resource
> allocation perspective.
> 
> If the core resource layer is asked to assign resources it will,
> regardless of what FW programmed in the BARs (the BAR regions size
> matters, that's it), I went through pci_bus_assign_resources() a couple
> of times and I have to add a bit of debugging so give me the benefit of
> the doubt please, but there is nothing that let me think it won't assign
> resources (and therefore assign a parent pointer) if the resources are
> already programmed correctly (actually I even think the kernel may
> change what FW programmed according to its resource alloc policy).

OK.  If you're saying that even if FW programmed the BARs, the core
will assign resources and set r->parent, that's all I'm looking for.
I *would* like a comment where we test PCI_PROBE_ONLY to the effect
that for PCI_PROBE_ONLY we call pci_bus_claim_resources(), and for
!PCI_PROBE_ONLY, we claim the resources in pci_bus_assign_resources().

Bjorn
