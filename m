Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1492034124.7236.77.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@ml01.01.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>
Date: Thu, 13 Apr 2017 07:55:24 +1000
In-Reply-To: <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
         <1491974532.7236.43.camel@kernel.crashing.org>
         <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-04-12 at 11:09 -0600, Logan Gunthorpe wrote:
> 
> > Do you handle funky address translation too ? IE. the fact that the PCI
> > addresses aren't the same as the CPU physical addresses for a BAR ?
> 
> No, we use the CPU physical address of the BAR. If it's not mapped that
> way we can't use it.

Ok, you need to fix that or a bunch of architectures won't work. 

Look at pcibios_resource_to_bus() and pcibios_bus_to_resource(). They
will perform the conversion between the struct resource content (CPU
physical address) and the actual PCI bus side address.

When behind the same switch you need to use PCI addresses. If one tries
later to do P2P between host bridges (via the CPU fabric) things get
more complex and one will have to use either CPU addresses or something
else alltogether (probably would have to teach the arch DMA mapping
routines to work with those struct pages you create and return the
right thing).

> > > This will mean many setups that could likely
> > > work well will not be supported so that we can be more confident it
> > > will work and not place any responsibility on the user to understand
> > > their topology. (We've chosen to go this route based on feedback we
> > > received at LSF).
> > > 
> > > In order to enable this functionality we introduce a new p2pmem device
> > > which can be instantiated by PCI drivers. The device will register some
> > > PCI memory as ZONE_DEVICE and provide an genalloc based allocator for
> > > users of these devices to get buffers.
> > 
> > I don't completely understand this. This is actual memory on the PCI
> > bus ? Where does it come from ? Or are you just trying to create struct
> > pages that cover your PCIe DMA target ?
> 
> Yes, the memory is on the PCI bus in a BAR. For now we have a special
> PCI card for this, but in the future it would likely be the CMB in an
> NVMe card. These patches create struct pages to map these BAR addresses
> using ZONE_DEVICE.

Ok.

So ideally we'd want things like dma_map_* to be able to be fed those
struct pages and do the right thing which is ... tricky, especially
with the address translation I mentioned since the address will be
different whether the initiator is on the same host bridge as the
target or not.

> > So correct me if I'm wrong, you are trying to create struct page's that
> > map a PCIe BAR right ? I'm trying to understand how that interacts with
> > what Jerome is doing for HMM.
> 
> Yes, well we are using ZONE_DEVICE in the exact same way as the dax code
> is. These patches use the existing API with no modifications. As I
> understand it, HMM was using ZONE_DEVICE in a way that was quite
> different to how it was originally designed.

Sort-of. I don't see why there would be a conflict with the struct
pages use though. Jerome can you chime in ? Jerome: It looks like they
are just laying out struct page over a BAR which is the same thing I
think you should do when the BAR is "large enough" for the GPU memory.

The case where HMM uses "holes" in the address space for its struct
page is somewhat orthogonal but I also see no conflict here.

> > The reason is that the HMM currently creates the struct pages with
> > "fake" PFNs pointing to a hole in the address space rather than
> > covering the actual PCIe memory of the GPU. He does that to deal with
> > the fact that some GPUs have a smaller aperture on PCIe than their
> > total memory.
> 
> I'm aware of what HMM is trying to do and although I'm not familiar with
> the intimate details, I saw it as fairly orthogonal to what we are
> attempting to do.

Right.

> > However, I have asked him to only apply that policy if the aperture is
> > indeed smaller, and if not, create struct pages that directly cover the
> > PCIe BAR of the GPU instead, which will work better on systems or
> > architecture that don't have a "pinhole" window limitation.
> > However he was under the impression that this was going to collide with
> > what you guys are doing, so I'm trying to understand how. 
> 
> I'm not sure I understand how either. However, I suspect if you collide
> with these patches then you'd also be breaking dax too.

Possibly but as I said, I don't see why so I'll let Jerome chime in
since he was under the impression that there was a conflict here :-)

Cheers,
Ben.
