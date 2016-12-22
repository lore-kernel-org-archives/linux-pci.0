Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 22 Dec 2016 14:28:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, rwright@hpe.com,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: possible dmar_init_reserved_ranges() error
Message-ID: <20161222202803.GA16855@bhelgaas-glaptop.roam.corp.google.com>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
 <20161222162713.GF17255@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161222162713.GF17255@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 22, 2016 at 05:27:14PM +0100, Joerg Roedel wrote:
> Hi Bjorn,
> 
> On Mon, Dec 19, 2016 at 03:20:44PM -0600, Bjorn Helgaas wrote:
> > I have some questions about dmar_init_reserved_ranges().  On systems
> > where CPU physical address space is not identity-mapped to PCI bus
> > address space, e.g., where the PCI host bridge windows have _TRA
> > offsets, I'm not sure we're doing the right thing.
> > 
> > Assume we have a PCI host bridge with _TRA that maps CPU addresses
> > 0x80000000-0x9fffffff to PCI bus addresses 0x00000000-0x1fffffff, with
> > two PCI devices below it:
> > 
> >   PCI host bridge domain 0000 [bus 00-3f]
> >   PCI host bridge window [mem 0x80000000-0x9fffffff] (bus 0x00000000-0x1fffffff]
> >   00:00.0: BAR 0 [mem 0x80000000-0x8ffffffff] (0x00000000-0x0fffffff on bus)
> >   00:01.0: BAR 0 [mem 0x90000000-0x9ffffffff] (0x10000000-0x1fffffff on bus)
> > 
> > The IOMMU init code in dmar_init_reserved_ranges() reserves the PCI
> > MMIO space for all devices:
> > 
> >   pci_iommu_init()
> >     intel_iommu_init()
> >       dmar_init_reserved_ranges()
> >         reserve_iova(0x80000000-0x8ffffffff)
> >         reserve_iova(0x90000000-0x9ffffffff)
> > 
> > This looks odd because we're reserving CPU physical addresses, but
> > the IOVA space contains *PCI bus* addresses.  On most x86 systems they
> > would be the same, but not on all.
> 
> Interesting, I wasn't aware of that. Looks like we are not doing the
> right thing in dmar_init_reserved_ranges(). How is that handled without
> an IOMMU, when the bus-addresses overlap with ram addresses?

I don't know enough about these systems to answer that.  One way would
be to avoid overlaps, e.g., by using bus addresses
0x80000000-0xffffffff and not putting RAM at those addresses.  Or
maybe the host bridge could apply a constant offset to bus addresses
before forwarding transactions up to the sytem bus.

> > Assume the driver for 00:00.0 maps a page of main memory for DMA.  It
> > may receive a dma_addr_t of 0x10000000:
> > 
> >   00:00.0: intel_map_page() returns dma_addr_t 0x10000000
> >   00:00.0: issues DMA to 0x10000000
> > 
> > What happens here?  The DMA access should go to main memory.  In
> > conventional PCI it would be a peer-to-peer access to device 00:01.0.
> > Is there enough PCIe smarts (ACS or something?) to do otherwise?
> 
> If there is a bridge doing ACS between the devices, the IOMMU will see
> the request and re-map it to its RAM address.
> 
> > The dmar_init_reserved_ranges() comment says "Reserve all PCI MMIO to
> > avoid peer-to-peer access."  Without _TRA, CPU addresses and PCI bus
> > addresses would be identical, and I think these reserve_iova() calls
> > *would* prevent this situation.  So maybe we're just missing a
> > pcibios_resource_to_bus() here?
> 
> I'll have a look, the AMD IOMMU driver implements this too, so it needs
> also be fixed there. Do you know which x86 systems are configured like
> this?

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b4873931cc8c
added this support, and I'm pretty sure it was tested, but I don't
know what machines it was for.  I know many large ia64 systems use
this _TRA support, but I don't have first-hand knowledge of x86
systems that do.

The untested patch below is what I was thinking for the Intel IOMMU
driver.

Bjorn


commit 529a6db0b0b2ff37a0cdb49d11eee4eb6f960a48
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Dec 20 11:08:09 2016 -0600

    iommu/vt-d: Reserve IOVA space for bus address, not CPU address
    
    IOVA space contains bus addresses, not CPU addresses.  On many systems they
    are identical, but PCI host bridges in some systems do apply an address
    offset when forwarding CPU MMIO transactions to PCI.  In ACPI, this is
    expressed as a _TRA offset in the window descriptor.
    
    Convert the PCI resource CPU addresses to PCI bus addresses before
    reserving them in the IOVA space.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c66c273..be78ab7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1865,6 +1865,7 @@ static struct lock_class_key reserved_rbtree_key;
 static int dmar_init_reserved_ranges(void)
 {
 	struct pci_dev *pdev = NULL;
+	struct pci_bus_region region;
 	struct iova *iova;
 	int i;
 
@@ -1890,9 +1891,11 @@ static int dmar_init_reserved_ranges(void)
 			r = &pdev->resource[i];
 			if (!r->flags || !(r->flags & IORESOURCE_MEM))
 				continue;
+
+			pcibios_resource_to_bus(pdev->bus, &region, r);
 			iova = reserve_iova(&reserved_iova_list,
-					    IOVA_PFN(r->start),
-					    IOVA_PFN(r->end));
+					    IOVA_PFN(region.start),
+					    IOVA_PFN(region.end));
 			if (!iova) {
 				pr_err("Reserve iova failed\n");
 				return -ENODEV;
