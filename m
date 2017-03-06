Return-Path: <SRS0=j2gr=2P=8bytes.org=joro@kernel.org>
Return-Path: <SRS0=j2gr=2P=8bytes.org=joro@kernel.org>
Date: Mon, 6 Mar 2017 12:04:39 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	iommu@lists.linux-foundation.org
Subject: Re: Partial BAR Address Allocation
Message-ID: <20170306110439.GC27724@8bytes.org>
References: <35c6bec9-58e8-a1f7-5a85-d80c23480d32@codeaurora.org>
 <20170222184440.GA2132@bhelgaas-glaptop.roam.corp.google.com>
 <43c1ff36-fc50-8ea4-02fe-7b1d573a1efd@codeaurora.org>
 <20170222233944.GB4359@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170222233944.GB4359@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 22, 2017 at 05:39:44PM -0600, Bjorn Helgaas wrote:
> [+cc Joerg, iommu list]
> 
> On Wed, Feb 22, 2017 at 03:44:53PM -0500, Sinan Kaya wrote:
> > On 2/22/2017 1:44 PM, Bjorn Helgaas wrote:
> > > There is no way for a driver to say "I only need this memory BAR and
> > > not the other ones."  The reason is because the PCI_COMMAND_MEMORY bit
> > > enables *all* the memory BARs; there's no way to enable memory BARs
> > > selectively.  If we enable memory BARs and one of them is unassigned,
> > > that unassigned BAR is enabled, and the device will respond at
> > > whatever address the register happens to contain, and that may cause
> > > conflicts.

Hmm, maybe I am missing something, but isn't this only a problem if the
'unassigned' BAR as an address configured that also falls into the
Bridge-Window of the parent bridge? Otherwise no requests should be
routed to the BAR anyway, right?

> > The problem is that according to PCI specification BAR addresses and
> > DMA addresses cannot overlap.
> > 
> > From PCI-to-PCI Bridge Arch. spec.: "A bridge forwards PCI memory
> > transactions from its primary interface to its secondary interface
> > (downstream) if a memory address is in the range defined by the
> > Memory Base and Memory Limit registers (when the base is less than
> > or equal to the limit) as illustrated in Figure 4-3. Conversely, a
> > memory transaction on the secondary interface that is within this
> > address range will not be forwarded upstream to the primary
> > interface."
> > 
> > To be specific, if your DMA address happens to be in
> > [0x80000000-0xffffffff] and root port's aperture includes this
> > range; the DMA will never make to the system memory.

If there is no translation by an IOMMU this shouldn't be a problem, as
long as the bridge windows don't overlap with system ram. With
translation the IOMMU driver has to take care of that, which they
usually do.

> Hmmm.  I guess SWIOTLB assumes there's no address translation in the
> DMA direction, right?  If there's no address translation in the PIO
> direction, PCI bus BAR addresses are identical to the CPU-side
> addresses.  In that case, there's no conflict because we already have
> to assign BARs so they never look like a system memory address.

Yes, SWIOTLB assumes that IOVA == PA.

> But if there *is* address translation in the PIO direction, we can
> have conflicts because the bridge can translate CPU-side PIO accesses
> to arbitrary PCI bus addresses.

I am not aware of any hardware that does translation on the PIO space.
The IOMMUs I know of don't care about PIO at all.



	Joerg
