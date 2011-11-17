Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:37998 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab1KQACg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2011 19:02:36 -0500
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <dwg@au1.ibm.com>;
	Wed, 16 Nov 2011 23:50:40 +1000
Date: Thu, 17 Nov 2011 11:02:18 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
Message-ID: <20111117000218.GB5411@truffala.fritz.box>
References: <20111103195452.21259.93021.stgit@bling.home>
 <20111115063431.GA4921@truffala.fritz.box>
 <1321380088.17169.282.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321380088.17169.282.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 15, 2011 at 11:01:28AM -0700, Alex Williamson wrote:
> On Tue, 2011-11-15 at 17:34 +1100, David Gibson wrote:
> > On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
> > > diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> > > new file mode 100644
> > > index 0000000..5866896
> > > --- /dev/null
> > > +++ b/Documentation/vfio.txt
> > > @@ -0,0 +1,304 @@
> > > +VFIO - "Virtual Function I/O"[1]
> > > +-------------------------------------------------------------------------------
> > > +Many modern system now provide DMA and interrupt remapping facilities
> > > +to help ensure I/O devices behave within the boundaries they've been
> > > +allotted.  This includes x86 hardware with AMD-Vi and Intel VT-d as
> > > +well as POWER systems with Partitionable Endpoints (PEs) and even
> > > +embedded powerpc systems (technology name unknown).  The VFIO driver
> > > +is an IOMMU/device agnostic framework for exposing direct device
> > > +access to userspace, in a secure, IOMMU protected environment.  In
> > > +other words, this allows safe, non-privileged, userspace drivers.
> > 
> > It's perhaps worth emphasisng that "safe" depends on the hardware
> > being sufficiently well behaved.  BenH, I know, thinks there are a
> > *lot* of cards that, e.g. have debug registers that allow a backdoor
> > to their own config space via MMIO, which would bypass vfio's
> > filtering of config space access.  And that's before we even get into
> > the varying degrees of completeness in the isolation provided by
> > different IOMMUs.
> 
> Fair enough.  I know Tom had emphasized "well behaved" in the original
> doc.  Virtual functions are probably the best indicator of well behaved.
> 
> > > +Why do we want that?  Virtual machines often make use of direct device
> > > +access ("device assignment") when configured for the highest possible
> > > +I/O performance.  From a device and host perspective, this simply turns
> > > +the VM into a userspace driver, with the benefits of significantly
> > > +reduced latency, higher bandwidth, and direct use of bare-metal device
> > > +drivers[2].
> > > +
> > > +Some applications, particularly in the high performance computing
> > > +field, also benefit from low-overhead, direct device access from
> > > +userspace.  Examples include network adapters (often non-TCP/IP based)
> > > +and compute accelerators.  Previous to VFIO, these drivers needed to
> > 
> > s/Previous/Prior/  although that may be a .us vs .au usage thing.
> 
> Same difference, AFAICT.
> 
> > > +go through the full development cycle to become proper upstream driver,
> > > +be maintained out of tree, or make use of the UIO framework, which
> > > +has no notion of IOMMU protection, limited interrupt support, and
> > > +requires root privileges to access things like PCI configuration space.
> > > +
> > > +The VFIO driver framework intends to unify these, replacing both the
> > > +KVM PCI specific device assignment currently used as well as provide
> > > +a more secure, more featureful userspace driver environment than UIO.
> > > +
> > > +Groups, Devices, IOMMUs, oh my
> > > +-------------------------------------------------------------------------------
> > > +
> > > +A fundamental component of VFIO is the notion of IOMMU groups.  IOMMUs
> > > +can't always distinguish transactions from each individual device in
> > > +the system.  Sometimes this is because of the IOMMU design, such as with
> > > +PEs, other times it's caused by the I/O topology, for instance a
> > > +PCIe-to-PCI bridge masking all devices behind it.  We call the sets of
> > > +devices created by these restictions IOMMU groups (or just "groups" for
> > > +this document).
> > > +
> > > +The IOMMU cannot distiguish transactions between the individual devices
> > > +within the group, therefore the group is the basic unit of ownership for
> > > +a userspace process.  Because of this, groups are also the primary
> > > +interface to both devices and IOMMU domains in VFIO.
> > > +
> > > +The VFIO representation of groups is created as devices are added into
> > > +the framework by a VFIO bus driver.  The vfio-pci module is an example
> > > +of a bus driver.  This module registers devices along with a set of bus
> > > +specific callbacks with the VFIO core.  These callbacks provide the
> > > +interfaces later used for device access.  As each new group is created,
> > > +as determined by iommu_device_group(), VFIO creates a /dev/vfio/$GROUP
> > > +character device.
> > 
> > Ok.. so, the fact that it's called "vfio-pci" suggests that the VFIO
> > bus driver is per bus type, not per bus instance.   But grouping
> > constraints could be per bus instance, if you have a couple of
> > different models of PCI host bridge with IOMMUs of different
> > capabilities built in, for example.
> 
> Yes, vfio-pci manages devices on the pci_bus_type; per type, not per bus
> instance.

Ok, how can that work.  vfio-pci is responsible for generating the
groupings, yes?  For which it needs to know the iommu/host bridge's
isolation capabilities, which vary depending on the type of host
bridge.

>  IOMMUs also register drivers per bus type, not per bus
> instance.  The IOMMU driver is free to impose any constraints it wants.
> 
> > > +In addition to the device enumeration and callbacks, the VFIO bus driver
> > > +also provides a traditional device driver and is able to bind to devices
> > > +on it's bus.  When a device is bound to the bus driver it's available to
> > > +VFIO.  When all the devices within a group are bound to their bus drivers,
> > > +the group becomes "viable" and a user with sufficient access to the VFIO
> > > +group chardev can obtain exclusive access to the set of group devices.
> > > +
> > > +As documented in linux/vfio.h, several ioctls are provided on the
> > > +group chardev:
> > > +
> > > +#define VFIO_GROUP_GET_FLAGS            _IOR(';', 100, __u64)
> > > + #define VFIO_GROUP_FLAGS_VIABLE        (1 << 0)
> > > + #define VFIO_GROUP_FLAGS_MM_LOCKED     (1 << 1)
> > > +#define VFIO_GROUP_MERGE                _IOW(';', 101, int)
> > > +#define VFIO_GROUP_UNMERGE              _IOW(';', 102, int)
> > > +#define VFIO_GROUP_GET_IOMMU_FD         _IO(';', 103)
> > > +#define VFIO_GROUP_GET_DEVICE_FD        _IOW(';', 104, char *)
> > > +
> > > +The last two ioctls return new file descriptors for accessing
> > > +individual devices within the group and programming the IOMMU.  Each of
> > > +these new file descriptors provide their own set of file interfaces.
> > > +These ioctls will fail if any of the devices within the group are not
> > > +bound to their VFIO bus driver.  Additionally, when either of these
> > > +interfaces are used, the group is then bound to the struct_mm of the
> > > +caller.  The GET_FLAGS ioctl can be used to view the state of the group.
> > > +
> > > +When either the GET_IOMMU_FD or GET_DEVICE_FD ioctls are invoked, a
> > > +new IOMMU domain is created and all of the devices in the group are
> > > +attached to it.  This is the only way to ensure full IOMMU isolation
> > > +of the group, but potentially wastes resources and cycles if the user
> > > +intends to manage multiple groups with the same set of IOMMU mappings.
> > > +VFIO therefore provides a group MERGE and UNMERGE interface, which
> > > +allows multiple groups to share an IOMMU domain.  Not all IOMMUs allow
> > > +arbitrary groups to be merged, so the user should assume merging is
> > > +opportunistic.
> > 
> > I do not think "opportunistic" means what you think it means..
> > 
> > >  A new group, with no open device or IOMMU file
> > > +descriptors, can be merged into an existing, in-use, group using the
> > > +MERGE ioctl.  A merged group can be unmerged using the UNMERGE ioctl
> > > +once all of the device file descriptors for the group being merged
> > > +"out" are closed.
> > > +
> > > +When groups are merged, the GET_IOMMU_FD and GET_DEVICE_FD ioctls are
> > > +essentially fungible between group file descriptors (ie. if device
> > > A
> > 
> > IDNT "fungible" MWYTIM, either.
> 
> Hmm, feel free to suggest.  Maybe we're hitting .us vs .au connotation.

In any case, I don't think it's a word whose meaning is unambiguous
enough to use here.

> > > +is in group X, and X is merged with Y, a file descriptor for A can be
> > > +retrieved using GET_DEVICE_FD on Y.  Likewise, GET_IOMMU_FD returns a
> > > +file descriptor referencing the same internal IOMMU object from either
> > > +X or Y).  Merged groups can be dissolved either explictly with UNMERGE
> > > +or automatically when ALL file descriptors for the merged group are
> > > +closed (all IOMMUs, all devices, all groups).
> > 
> > Blech.  I'm really not liking this merge/unmerge API as it stands,
> > it's horribly confusing.  At the very least, we need some better
> > terminology.  We need some term for the metagroups; supergroups; iommu
> > domains or-at-least-they-will-be-once-we-open-the-iommu or
> > whathaveyous.
> > 
> > The first confusing thing about this interface is that each open group
> > handle actually refers to two different things; the original group you
> > opened and the metagroup it's a part of.  For the GET_IOMMU_FD and
> > GET_DEVICE_FD operations, you're using the metagroup and two "merged"
> > group handles are interchangeable.
> 
> Fungible, even ;)
> 
> > For other MERGE and especially
> > UNMERGE operations, it matters which is the original group.
> 
> If I stick two LEGO blocks together, I need to identify the individual
> block I want to remove to pull them back apart...

Yeah, I'm starting to get my head around the model, but the current
description of it doesn't help very much.  In particular the terms
"merge" and "unmerge" lead one to the wrong mental model, I think.

> > The semantics of "merge" and "unmerge" under those names are really
> > non-obvious.  Merge kind of has to merge two whole metagroups, but
> > it's unclear if unmerge reverses one merge, or just takes out one
> > (atom) group.  These operations need better names, at least.
> 
> Christian suggested a change to UNMERGE that we do not need to
> specify a group to unmerge "from".  This makes it more like a list
> implementation except there's no defined list_head.  Any member of the
> list can pull in a new entry.  Calling UNMERGE on any member extracts
> that member.

I think that's a good idea, but "unmerge" is not a good word for it.

> > Then it's unclear what order you can do various operations, and which
> > order you can open and close various things.  You can kind of figure
> > it out but it takes far more thinking than it should.
> > 
> > 
> > So at the _very_ least, we need to invent new terminology and find a
> > much better way of describing this API's semantics.  I still think an
> > entirely different interface, where metagroups are created from
> > outside with a lifetime that's not tied to an fd would be a better
> > idea.
> 
> As we've discussed previously, configfs provides part of this, but has
> no ioctl support.  It doesn't make sense to me to go play with groups in
> configfs, but then still interact with them via a char dev.

Why not?  You configure, say, loopback devices with losetup, then use
them as a block device.  Similar with nbd.  You can configure serial
devices with setserial, then use them as a char dev.

>  It also
> splits the ownership model 

I'm not even sure what that means.

> and makes it harder to enforce who gets to
> interact with the devices vs who gets to manipulate groups.

How so.

>  The current
> model really isn't that complicated, imho.  As always, feel free to
> suggest specific models.  If you have a specific terminology other than
> MERGE, please suggest.
> 
> > Now, you specify that you can't use a group as the second argument of
> > a merge if it already has an open iommu, but it's not clear from the
> > doc if you can merge things into a group with an open iommu.
> 
> >From above:
> 
>         A new group, with no open device or IOMMU file descriptors, can
>         be merged into an existing, in-use, group using the MERGE ioctl.
>                                  ^^^^^^
> 
> > Banning
> > this would make life simpler, because the IOMMU's effective
> > capabilities may change if you add more devices to the domain.  That's
> > yet another non-obvious constraint in the interface ordering, though.
> 
> Banning this would prevent using merged groups with hotplug, which I
> consider to be a primary use case.

Yeah, fair enough, based on your later comments w.r.t. only combining
feature compatible groups.

> > > +The IOMMU file descriptor provides this set of ioctls:
> > > +
> > > +#define VFIO_IOMMU_GET_FLAGS            _IOR(';', 105, __u64)
> > > + #define VFIO_IOMMU_FLAGS_MAP_ANY       (1 << 0)
> > > +#define VFIO_IOMMU_MAP_DMA              _IOWR(';', 106, struct vfio_dma_map)
> > > +#define VFIO_IOMMU_UNMAP_DMA            _IOWR(';', 107, struct vfio_dma_map)
> > > +
> > > +The GET_FLAGS ioctl returns basic information about the IOMMU domain.
> > > +We currently only support IOMMU domains that are able to map any
> > > +virtual address to any IOVA.  This is indicated by the MAP_ANY
> > > flag.
> > 
> > So.  I tend to think of an IOMMU mapping IOVAs to memory pages, rather
> > than memory pages to IOVAs.  
> 
> I do too, not sure why I wrote it that way, will fix.
> 
> > The IOMMU itself, of course maps to
> > physical addresses, and the meaning of "virtual address" in this
> > context is not really clear.  I think you would be better off saying
> > the IOMMU can map any IOVA to any memory page.  From a hardware POV
> > that means any physical address, but of course for a VFIO user a page
> > is specified by its process virtual address.
> 
> Will fix.
> 
> > I think we need to pin exactly what "MAP_ANY" means down better.  Now,
> > VFIO is pretty much a lost cause if you can't map any normal process
> > memory page into the IOMMU, so I think the only thing that is really
> > covered is IOVAs.  But saying "can map any IOVA" is not clear, because
> > if you can't map it, it's not a (valid) IOVA.  Better to say that
> > IOVAs can be any 64-bit value, which I think is what you really mean
> > here.
> 
> ok
> 
> > Of course, since POWER is a platform where this is *not* true, I'd
> > prefer to have something giving the range of valid IOVAs in the core
> > to start with.
> 
> Since iommu_ops does not yet have any concept of this (nudge, nudge), I
> figured this would be added later.  A possible implementation would be
> that such an iommu would not set MAP_ANY, would add a new flag for
> MAP_RANGE, and provide a new VFIO_IOMMU_GET_RANGE_INFO ioctl to describe
> it.  I'm guaranteed to get it wrong if I try to predict all your needs.

Hrm.  "ANY" just really bothers me because "any iova" is not as clear
a concept as it first appears.  For starters it's actually "any page
aligned" at the very least.  But then it's only any 64-bit address for
busses which have full 64-bit addressing (and I do wonder if there are
any north bridges out there that forgot to implement some of the upper
PCI address bits properly, given that 64-bit CPUs rarely actually
implement more than 40-something physical address bits in practice).

I'd prefer to see at least something to advertise min and max IOVA and
IOVA alignment.  That's enough to cover x86 and POWER, including
possible variants with an IOMMU page size different to the system page
size (note that POWER kernels can have 64k pages as a config option,
which means a TCE page size different to the system page size is quite
common).

Obviously there could be more complex constraints that we would need
to advertise with option bits.

> > > +
> > > +The (UN)MAP_DMA commands make use of struct vfio_dma_map for mapping
> > > +and unmapping IOVAs to process virtual addresses:
> > > +
> > > +struct vfio_dma_map {
> > > +        __u64   len;            /* length of structure */
> > 
> > Thanks for adding these structure length fields.  But I think they
> > should be called something other than 'len', which is likely to be
> > confused with size (or some other length that's actually related to
> > the operation's parameters).  Better to call it 'structlen' or
> > 'argslen' or something.
> 
> Ok.  As Scott noted, I've failed to implement these in a way that
> actually allows extension, but I'll work on it.

Right.  I had failed to realise quite how the encoding of structure
size into the ioctl worked.  With that in place, arguably we don't
really need the size in the structure itself, because we can still
have multiple sized versions of the ioctl.  Still, whichever.

> 
> > > +        __u64   vaddr;          /* process virtual addr */
> > > +        __u64   dmaaddr;        /* desired and/or returned dma address */
> > > +        __u64   size;           /* size in bytes */
> > > +        __u64   flags;
> > > +#define VFIO_DMA_MAP_FLAG_WRITE         (1 << 0) /* req writeable DMA mem */
> > 
> > Make it independent READ and WRITE flags from the start.  Not all
> > combinations will be be valid on all hardware, but that way we have
> > the possibilities covered without having to use strange encodings
> > later.
> 
> Ok.
> 
> > > +};
> > > +
> > > +Current users of VFIO use relatively static DMA mappings, not requiring
> > > +high frequency turnover.  As new users are added, it's expected that the
> > > +IOMMU file descriptor will evolve to support new mapping interfaces, this
> > > +will be reflected in the flags and may present new ioctls and file
> > > +interfaces.
> > > +
> > > +The device GET_FLAGS ioctl is intended to return basic device type and
> > > +indicate support for optional capabilities.  Flags currently include whether
> > > +the device is PCI or described by Device Tree, and whether the RESET ioctl
> > > +is supported:
> > > +
> > > +#define VFIO_DEVICE_GET_FLAGS           _IOR(';', 108, __u64)
> > > + #define VFIO_DEVICE_FLAGS_PCI          (1 << 0)
> > > + #define VFIO_DEVICE_FLAGS_DT           (1 << 1)
> > 
> > TBH, I don't think the VFIO for DT stuff is mature enough yet to be in
> > an initial infrastructure patch, though we should certainly be
> > discussing it as an add-on patch.
> 
> I agree for DT, and PCI should be added with vfio-pci, not the initial
> core.
> 
> > > + #define VFIO_DEVICE_FLAGS_RESET        (1 << 2)
> > > +
> > > +The MMIO and IOP resources used by a device are described by regions.
> > > +The GET_NUM_REGIONS ioctl tells us how many regions the device supports:
> > > +
> > > +#define VFIO_DEVICE_GET_NUM_REGIONS     _IOR(';', 109, int)
> > > +
> > > +Regions are described by a struct vfio_region_info, which is retrieved by
> > > +using the GET_REGION_INFO ioctl with vfio_region_info.index field set to
> > > +the desired region (0 based index).  Note that devices may implement zero
> > > +sized regions (vfio-pci does this to provide a 1:1 BAR to region index
> > > +mapping).
> > 
> > So, I think you're saying that a zero-sized region is used to encode a
> > NOP region, that is, to basically put a "no region here" in between
> > valid region indices.  You should spell that out.
> 
> Ok.
> 
> > [Incidentally, any chance you could borrow one of RH's tech writers
> > for this?  I'm afraid you seem to lack the knack for clear and easily
> > read documentation]
> 
> Thanks for the encouragement :-\  It's no wonder there isn't more
> content in Documentation.

Sigh.  Alas, yes.

> > > +struct vfio_region_info {
> > > +        __u32   len;            /* length of structure */
> > > +        __u32   index;          /* region number */
> > > +        __u64   size;           /* size in bytes of region */
> > > +        __u64   offset;         /* start offset of region */
> > > +        __u64   flags;
> > > +#define VFIO_REGION_INFO_FLAG_MMAP              (1 << 0)
> > > +#define VFIO_REGION_INFO_FLAG_RO                (1 << 1)
> > 
> > Again having separate read and write bits from the start will save
> > strange encodings later.
> 
> Seems highly unlikely, but we have bits to waste...
> 
> > > +#define VFIO_REGION_INFO_FLAG_PHYS_VALID        (1 << 2)
> > > +        __u64   phys;           /* physical address of region */
> > > +};
> > 
> > I notice there is no field for "type" e.g. MMIO vs. PIO vs. config
> > space for PCI.  If you added that having a NONE type might be a
> > clearer way of encoding a non-region than just having size==0.
> 
> I thought there was some resistance to including MMIO and PIO bits in
> the flags.  If that's passed, I can add it, but PCI can determine this
> through config space (and vfio-pci exposes config space at a fixed
> index).  Having a regions w/ size == 0, MMIO and PIO flags unset seems a
> little redundant if that's the only reason for having them.  A NONE flag
> doesn't make sense to me.  Config space isn't NONE, but neither is it
> MMIO nor PIO; and someone would probably be offended about even
> mentioning PIO in the specification.

No, my concept was that NONE would be used for the indexes where there
is no valid BAR.  I'll buy your argument on why not to include the PCI
(or whatever) address space type here.

What I'm just a bit concerned by is whether we could have a case (not
for PCI) of a real resource that still has size 0 - e.g. maybe some
sort of doorbell that can't be read or written, but can be triggered
some other way.  I guess that's probably unlikely though.

> 
> > > +
> > > +#define VFIO_DEVICE_GET_REGION_INFO     _IOWR(';', 110, struct vfio_region_info)
> > > +
> > > +The offset indicates the offset into the device file descriptor which
> > > +accesses the given range (for read/write/mmap/seek).  Flags indicate the
> > > +available access types and validity of optional fields.  For instance
> > > +the phys field may only be valid for certain devices types.
> > > +
> > > +Interrupts are described using a similar interface.  GET_NUM_IRQS
> > > +reports the number or IRQ indexes for the device.
> > > +
> > > +#define VFIO_DEVICE_GET_NUM_IRQS        _IOR(';', 111, int)
> > > +
> > > +struct vfio_irq_info {
> > > +        __u32   len;            /* length of structure */
> > > +        __u32   index;          /* IRQ number */
> > > +        __u32   count;          /* number of individual IRQs */
> > 
> > Is there a reason for allowing irqs in batches like this, rather than
> > having each MSI be reflected by a separate irq_info?
> 
> Yes, bus drivers like vfio-pci can define index 1 as the MSI info
> structure and index 2 as MSI-X.  There's really no need to expose 57
> individual MSI interrupts and try to map them to the correct device
> specific MSI type if they can only logically be enabled in two distinct
> groups.  Bus drivers with individually controllable MSI vectors are free
> to expose them separately.  I assume device tree paths would help
> associate an index to a specific interrupt.

Ok, fair enough.

> > > +        __u64   flags;
> > > +#define VFIO_IRQ_INFO_FLAG_LEVEL                (1 << 0)
> > > +};
> > > +
> > > +Again, zero count entries are allowed (vfio-pci uses a static interrupt
> > > +type to index mapping).
> > 
> > I know what you mean, but you need a clearer way to express it.
> 
> I'll work on it.
> 
> > > +Information about each index can be retrieved using the GET_IRQ_INFO
> > > +ioctl, used much like GET_REGION_INFO.
> > > +
> > > +#define VFIO_DEVICE_GET_IRQ_INFO        _IOWR(';', 112, struct vfio_irq_info)
> > > +
> > > +Individual indexes can describe single or sets of IRQs.  This provides the
> > > +flexibility to describe PCI INTx, MSI, and MSI-X using a single interface.
> > > +
> > > +All VFIO interrupts are signaled to userspace via eventfds.  Integer arrays,
> > > +as shown below, are used to pass the IRQ info index, the number of eventfds,
> > > +and each eventfd to be signaled.  Using a count of 0 disables the interrupt.
> > > +
> > > +/* Set IRQ eventfds, arg[0] = index, arg[1] = count, arg[2-n] = eventfds */
> > > +#define VFIO_DEVICE_SET_IRQ_EVENTFDS    _IOW(';', 113, int)
> > > +
> > > +When a level triggered interrupt is signaled, the interrupt is masked
> > > +on the host.  This prevents an unresponsive userspace driver from
> > > +continuing to interrupt the host system.  After servicing the interrupt,
> > > +UNMASK_IRQ is used to allow the interrupt to retrigger.  Note that level
> > > +triggered interrupts implicitly have a count of 1 per index.
> > 
> > This is a silly restriction.  Even PCI devices can have up to 4 LSIs
> > on a function in theory, though no-one ever does.  Embedded devices
> > can and do have multiple level interrupts.
> 
> Per the PCI spec, an individual PCI function can only ever have, at
> most, a single INTx line.  A multi-function *device* can have up to 4
> INTx lines, but what we're exposing here is a struct device, ie. a PCI
> function.

Ah, my mistake.

> Other devices could certainly have multiple level interrupts, and if
> grouping them as we do with MSI on PCI makes sense, please let me know.
> I just didn't see the value in making the unmask operations handle
> sub-indexes if it's not needed.

I don't know of anything off hand.  But I can't see any consideration
that would make it unlikely either.  I generally don't trust anything
*not* to exist in embedded space.

> > > +
> > > +/* Unmask IRQ index, arg[0] = index */
> > > +#define VFIO_DEVICE_UNMASK_IRQ          _IOW(';', 114, int)
> > > +
> > > +Level triggered interrupts can also be unmasked using an irqfd.  Use
> > > +SET_UNMASK_IRQ_EVENTFD to set the file descriptor for this.
> > > +
> > > +/* Set unmask eventfd, arg[0] = index, arg[1] = eventfd */
> > > +#define VFIO_DEVICE_SET_UNMASK_IRQ_EVENTFD      _IOW(';', 115, int)
> > > +
> > > +When supported, as indicated by the device flags, reset the device.
> > > +
> > > +#define VFIO_DEVICE_RESET               _IO(';', 116)
> > > +
> > > +Device tree devices also invlude ioctls for further defining the
> > > +device tree properties of the device:
> > > +
> > > +struct vfio_dtpath {
> > > +        __u32   len;            /* length of structure */
> > > +        __u32   index;
> > > +        __u64   flags;
> > > +#define VFIO_DTPATH_FLAGS_REGION        (1 << 0)
> > > +#define VFIO_DTPATH_FLAGS_IRQ           (1 << 1)
> > > +        char    *path;
> > > +};
> > > +#define VFIO_DEVICE_GET_DTPATH          _IOWR(';', 117, struct vfio_dtpath)
> > > +
> > > +struct vfio_dtindex {
> > > +        __u32   len;            /* length of structure */
> > > +        __u32   index;
> > > +        __u32   prop_type;
> > > +        __u32   prop_index;
> > > +        __u64   flags;
> > > +#define VFIO_DTINDEX_FLAGS_REGION       (1 << 0)
> > > +#define VFIO_DTINDEX_FLAGS_IRQ          (1 << 1)
> > > +};
> > > +#define VFIO_DEVICE_GET_DTINDEX         _IOWR(';', 118, struct vfio_dtindex)
> > > +
> > > +
> > > +VFIO bus driver API
> > > +-------------------------------------------------------------------------------
> > > +
> > > +Bus drivers, such as PCI, have three jobs:
> > > + 1) Add/remove devices from vfio
> > > + 2) Provide vfio_device_ops for device access
> > > + 3) Device binding and unbinding
> > > +
> > > +When initialized, the bus driver should enumerate the devices on it's
> > 
> > s/it's/its/
> 
> Noted.
> 
> <snip>
> > > +/* Unmap DMA region */
> > > +/* dgate must be held */
> > > +static int __vfio_dma_unmap(struct vfio_iommu *iommu, unsigned long iova,
> > > +			    int npage, int rdwr)
> > 
> > Use of "read" and "write" in DMA can often be confusing, since it's
> > not always clear if you're talking from the perspective of the CPU or
> > the device (_writing_ data to a device will usually involve it doing
> > DMA _reads_ from memory).  It's often best to express things as DMA
> > direction, 'to device', and 'from device' instead.
> 
> Good point.

This, of course, potentially affects many areas of the code and doco.

> > > +{
> > > +	int i, unlocked = 0;
> > > +
> > > +	for (i = 0; i < npage; i++, iova += PAGE_SIZE) {
> > > +		unsigned long pfn;
> > > +
> > > +		pfn = iommu_iova_to_phys(iommu->domain, iova) >> PAGE_SHIFT;
> > > +		if (pfn) {
> > > +			iommu_unmap(iommu->domain, iova, 0);
> > > +			unlocked += put_pfn(pfn, rdwr);
> > > +		}
> > > +	}
> > > +	return unlocked;
> > > +}
> > > +
> > > +static void vfio_dma_unmap(struct vfio_iommu *iommu, unsigned long iova,
> > > +			   unsigned long npage, int rdwr)
> > > +{
> > > +	int unlocked;
> > > +
> > > +	unlocked = __vfio_dma_unmap(iommu, iova, npage, rdwr);
> > > +	vfio_lock_acct(-unlocked);
> > 
> > Have you checked that your accounting will work out if the user maps
> > the same memory page to multiple IOVAs?
> 
> Hmm, it probably doesn't.  We potentially over-penalize the user process
> here.

Ok.

> > > +}
> > > +
> > > +/* Unmap ALL DMA regions */
> > > +void vfio_iommu_unmapall(struct vfio_iommu *iommu)
> > > +{
> > > +	struct list_head *pos, *pos2;
> > > +	struct dma_map_page *mlp;
> > > +
> > > +	mutex_lock(&iommu->dgate);
> > > +	list_for_each_safe(pos, pos2, &iommu->dm_list) {
> > > +		mlp = list_entry(pos, struct dma_map_page, list);
> > > +		vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> > > +		list_del(&mlp->list);
> > > +		kfree(mlp);
> > > +	}
> > > +	mutex_unlock(&iommu->dgate);
> > 
> > Ouch, no good at all.  Keeping track of every DMA map is no good on
> > POWER or other systems where IOMMU operations are a hot path.  I think
> > you'll need an iommu specific hook for this instead, which uses
> > whatever data structures are natural for the IOMMU.  For example a
> > 1-level pagetable, like we use on POWER will just zero every entry.
> 
> It's already been noted in the docs that current users have relatively
> static mappings and a performance interface is TBD for dynamically
> backing streaming DMA.  The current vfio_iommu exposes iommu_ops, POWER
> will need to come up with something to expose instead.

Right, but I'm not just talking about the current map/unmap calls
themselves.  This infrastructure for tracking it looks like it's
intended to be generic for all mapping methods.  If not, I can't see
the reason for it, because I don't think the current interface
requires such tracking inherently.

> > > +}
> > > +
> > > +static int vaddr_get_pfn(unsigned long vaddr, int rdwr, unsigned long *pfn)
> > > +{
> > > +	struct page *page[1];
> > > +	struct vm_area_struct *vma;
> > > +	int ret = -EFAULT;
> > > +
> > > +	if (get_user_pages_fast(vaddr, 1, rdwr, page) == 1) {
> > > +		*pfn = page_to_pfn(page[0]);
> > > +		return 0;
> > > +	}
> > > +
> > > +	down_read(&current->mm->mmap_sem);
> > > +
> > > +	vma = find_vma_intersection(current->mm, vaddr, vaddr + 1);
> > > +
> > > +	if (vma && vma->vm_flags & VM_PFNMAP) {
> > > +		*pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
> > > +		if (is_invalid_reserved_pfn(*pfn))
> > > +			ret = 0;
> > > +	}
> > 
> > It's kind of nasty that you take gup_fast(), already designed to grab
> > pointers for multiple user pages, then just use it one page at a time,
> > even for a big map.
> 
> Yep, this needs work, but shouldn't really change the API.

Yes, this could be a later optimization.

> > > +	up_read(&current->mm->mmap_sem);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/* Map DMA region */
> > > +/* dgate must be held */
> > > +static int vfio_dma_map(struct vfio_iommu *iommu, unsigned long iova,
> > > +			unsigned long vaddr, int npage, int rdwr)
> > 
> > iova should be a dma_addr_t.  Bus address size need not match virtual
> > address size, and may not fit in an unsigned long.
> 
> ok.

Again, same consideratoin in many places of course.

> > > +{
> > > +	unsigned long start = iova;
> > > +	int i, ret, locked = 0, prot = IOMMU_READ;
> > > +
> > > +	/* Verify pages are not already mapped */
> > > +	for (i = 0; i < npage; i++, iova += PAGE_SIZE)
> > > +		if (iommu_iova_to_phys(iommu->domain, iova))
> > > +			return -EBUSY;
> > > +
> > > +	iova = start;
> > > +
> > > +	if (rdwr)
> > > +		prot |= IOMMU_WRITE;
> > > +	if (iommu->cache)
> > > +		prot |= IOMMU_CACHE;
> > > +
> > > +	for (i = 0; i < npage; i++, iova += PAGE_SIZE, vaddr += PAGE_SIZE) {
> > > +		unsigned long pfn = 0;
> > > +
> > > +		ret = vaddr_get_pfn(vaddr, rdwr, &pfn);
> > > +		if (ret) {
> > > +			__vfio_dma_unmap(iommu, start, i, rdwr);
> > > +			return ret;
> > > +		}
> > > +
> > > +		/* Only add actual locked pages to accounting */
> > > +		if (!is_invalid_reserved_pfn(pfn))
> > > +			locked++;
> > > +
> > > +		ret = iommu_map(iommu->domain, iova,
> > > +				(phys_addr_t)pfn << PAGE_SHIFT, 0, prot);
> > > +		if (ret) {
> > > +			/* Back out mappings on error */
> > > +			put_pfn(pfn, rdwr);
> > > +			__vfio_dma_unmap(iommu, start, i, rdwr);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +	vfio_lock_acct(locked);
> > > +	return 0;
> > > +}
> > > +
> > > +static inline int ranges_overlap(unsigned long start1, size_t size1,
> > > +				 unsigned long start2, size_t size2)
> > > +{
> > > +	return !(start1 + size1 <= start2 || start2 + size2 <= start1);
> > 
> > Needs overflow safety.
> 
> Yep.
> 
> > > +}
> > > +
> > > +static struct dma_map_page *vfio_find_dma(struct vfio_iommu *iommu,
> > > +					  dma_addr_t start, size_t size)
> > > +{
> > > +	struct list_head *pos;
> > > +	struct dma_map_page *mlp;
> > > +
> > > +	list_for_each(pos, &iommu->dm_list) {
> > > +		mlp = list_entry(pos, struct dma_map_page, list);
> > > +		if (ranges_overlap(mlp->daddr, NPAGE_TO_SIZE(mlp->npage),
> > > +				   start, size))
> > > +			return mlp;
> > > +	}
> > > +	return NULL;
> > > +}
> > 
> > Again, keeping track of each dma map operation is no good for
> > performance.
> 
> This is not the performance interface you're looking for.
> 
> > > +
> > > +int vfio_remove_dma_overlap(struct vfio_iommu *iommu, dma_addr_t start,
> > > +			    size_t size, struct dma_map_page *mlp)
> > > +{
> > > +	struct dma_map_page *split;
> > > +	int npage_lo, npage_hi;
> > > +
> > > +	/* Existing dma region is completely covered, unmap all */
> > > +	if (start <= mlp->daddr &&
> > > +	    start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> > > +		vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> > > +		list_del(&mlp->list);
> > > +		npage_lo = mlp->npage;
> > > +		kfree(mlp);
> > > +		return npage_lo;
> > > +	}
> > > +
> > > +	/* Overlap low address of existing range */
> > > +	if (start <= mlp->daddr) {
> > > +		size_t overlap;
> > > +
> > > +		overlap = start + size - mlp->daddr;
> > > +		npage_lo = overlap >> PAGE_SHIFT;
> > > +		npage_hi = mlp->npage - npage_lo;
> > > +
> > > +		vfio_dma_unmap(iommu, mlp->daddr, npage_lo, mlp->rdwr);
> > > +		mlp->daddr += overlap;
> > > +		mlp->vaddr += overlap;
> > > +		mlp->npage -= npage_lo;
> > > +		return npage_lo;
> > > +	}
> > > +
> > > +	/* Overlap high address of existing range */
> > > +	if (start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> > > +		size_t overlap;
> > > +
> > > +		overlap = mlp->daddr + NPAGE_TO_SIZE(mlp->npage) - start;
> > > +		npage_hi = overlap >> PAGE_SHIFT;
> > > +		npage_lo = mlp->npage - npage_hi;
> > > +
> > > +		vfio_dma_unmap(iommu, start, npage_hi, mlp->rdwr);
> > > +		mlp->npage -= npage_hi;
> > > +		return npage_hi;
> > > +	}
> > > +
> > > +	/* Split existing */
> > > +	npage_lo = (start - mlp->daddr) >> PAGE_SHIFT;
> > > +	npage_hi = mlp->npage - (size >> PAGE_SHIFT) - npage_lo;
> > > +
> > > +	split = kzalloc(sizeof *split, GFP_KERNEL);
> > > +	if (!split)
> > > +		return -ENOMEM;
> > > +
> > > +	vfio_dma_unmap(iommu, start, size >> PAGE_SHIFT, mlp->rdwr);
> > > +
> > > +	mlp->npage = npage_lo;
> > > +
> > > +	split->npage = npage_hi;
> > > +	split->daddr = start + size;
> > > +	split->vaddr = mlp->vaddr + NPAGE_TO_SIZE(npage_lo) + size;
> > > +	split->rdwr = mlp->rdwr;
> > > +	list_add(&split->list, &iommu->dm_list);
> > > +	return size >> PAGE_SHIFT;
> > > +}
> > > +
> > > +int vfio_dma_unmap_dm(struct vfio_iommu *iommu, struct vfio_dma_map *dmp)
> > > +{
> > > +	int ret = 0;
> > > +	size_t npage = dmp->size >> PAGE_SHIFT;
> > > +	struct list_head *pos, *n;
> > > +
> > > +	if (dmp->dmaaddr & ~PAGE_MASK)
> > > +		return -EINVAL;
> > > +	if (dmp->size & ~PAGE_MASK)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&iommu->dgate);
> > > +
> > > +	list_for_each_safe(pos, n, &iommu->dm_list) {
> > > +		struct dma_map_page *mlp;
> > > +
> > > +		mlp = list_entry(pos, struct dma_map_page, list);
> > > +		if (ranges_overlap(mlp->daddr, NPAGE_TO_SIZE(mlp->npage),
> > > +				   dmp->dmaaddr, dmp->size)) {
> > > +			ret = vfio_remove_dma_overlap(iommu, dmp->dmaaddr,
> > > +						      dmp->size, mlp);
> > > +			if (ret > 0)
> > > +				npage -= NPAGE_TO_SIZE(ret);
> > > +			if (ret < 0 || npage == 0)
> > > +				break;
> > > +		}
> > > +	}
> > > +	mutex_unlock(&iommu->dgate);
> > > +	return ret > 0 ? 0 : ret;
> > > +}
> > > +
> > > +int vfio_dma_map_dm(struct vfio_iommu *iommu, struct vfio_dma_map *dmp)
> > > +{
> > > +	int npage;
> > > +	struct dma_map_page *mlp, *mmlp = NULL;
> > > +	dma_addr_t daddr = dmp->dmaaddr;
> > > +	unsigned long locked, lock_limit, vaddr = dmp->vaddr;
> > > +	size_t size = dmp->size;
> > > +	int ret = 0, rdwr = dmp->flags & VFIO_DMA_MAP_FLAG_WRITE;
> > > +
> > > +	if (vaddr & (PAGE_SIZE-1))
> > > +		return -EINVAL;
> > > +	if (daddr & (PAGE_SIZE-1))
> > > +		return -EINVAL;
> > > +	if (size & (PAGE_SIZE-1))
> > > +		return -EINVAL;
> > > +
> > > +	npage = size >> PAGE_SHIFT;
> > > +	if (!npage)
> > > +		return -EINVAL;
> > > +
> > > +	if (!iommu)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&iommu->dgate);
> > > +
> > > +	if (vfio_find_dma(iommu, daddr, size)) {
> > > +		ret = -EBUSY;
> > > +		goto out_lock;
> > > +	}
> > > +
> > > +	/* account for locked pages */
> > > +	locked = current->mm->locked_vm + npage;
> > > +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> > > +		printk(KERN_WARNING "%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
> > > +			__func__, rlimit(RLIMIT_MEMLOCK));
> > > +		ret = -ENOMEM;
> > > +		goto out_lock;
> > > +	}
> > > +
> > > +	ret = vfio_dma_map(iommu, daddr, vaddr, npage, rdwr);
> > > +	if (ret)
> > > +		goto out_lock;
> > > +
> > > +	/* Check if we abut a region below */
> > > +	if (daddr) {
> > > +		mlp = vfio_find_dma(iommu, daddr - 1, 1);
> > > +		if (mlp && mlp->rdwr == rdwr &&
> > > +		    mlp->vaddr + NPAGE_TO_SIZE(mlp->npage) == vaddr) {
> > > +
> > > +			mlp->npage += npage;
> > > +			daddr = mlp->daddr;
> > > +			vaddr = mlp->vaddr;
> > > +			npage = mlp->npage;
> > > +			size = NPAGE_TO_SIZE(npage);
> > > +
> > > +			mmlp = mlp;
> > > +		}
> > > +	}
> > > +
> > > +	if (daddr + size) {
> > > +		mlp = vfio_find_dma(iommu, daddr + size, 1);
> > > +		if (mlp && mlp->rdwr == rdwr && mlp->vaddr == vaddr + size) {
> > > +
> > > +			mlp->npage += npage;
> > > +			mlp->daddr = daddr;
> > > +			mlp->vaddr = vaddr;
> > > +
> > > +			/* If merged above and below, remove previously
> > > +			 * merged entry.  New entry covers it.  */
> > > +			if (mmlp) {
> > > +				list_del(&mmlp->list);
> > > +				kfree(mmlp);
> > > +			}
> > > +			mmlp = mlp;
> > > +		}
> > > +	}
> > > +
> > > +	if (!mmlp) {
> > > +		mlp = kzalloc(sizeof *mlp, GFP_KERNEL);
> > > +		if (!mlp) {
> > > +			ret = -ENOMEM;
> > > +			vfio_dma_unmap(iommu, daddr, npage, rdwr);
> > > +			goto out_lock;
> > > +		}
> > > +
> > > +		mlp->npage = npage;
> > > +		mlp->daddr = daddr;
> > > +		mlp->vaddr = vaddr;
> > > +		mlp->rdwr = rdwr;
> > > +		list_add(&mlp->list, &iommu->dm_list);
> > > +	}
> > > +
> > > +out_lock:
> > > +	mutex_unlock(&iommu->dgate);
> > > +	return ret;
> > > +}
> > 
> > This whole tracking infrastructure is way too complex to impose on
> > every IOMMU.  We absolutely don't want to do all this when just
> > updating a 1-level pagetable.
> 
> If only POWER implemented an iommu_ops so we had something on which we
> could base an alternate iommu model and pluggable iommu registration...

Yeah, yeah.  I'm having to find gaps of time between fighting various
fires to work on vfio-ish infrastructure stuff.

> > > +static int vfio_iommu_release(struct inode *inode, struct file *filep)
> > > +{
> > > +	struct vfio_iommu *iommu = filep->private_data;
> > > +
> > > +	vfio_release_iommu(iommu);
> > > +	return 0;
> > > +}
> > > +
> > > +static long vfio_iommu_unl_ioctl(struct file *filep,
> > > +				 unsigned int cmd, unsigned long arg)
> > > +{
> > > +	struct vfio_iommu *iommu = filep->private_data;
> > > +	int ret = -ENOSYS;
> > > +
> > > +        if (cmd == VFIO_IOMMU_GET_FLAGS) {
> > > +                u64 flags = VFIO_IOMMU_FLAGS_MAP_ANY;
> > > +
> > > +                ret = put_user(flags, (u64 __user *)arg);
> > 
> > Um.. flags surely have to come from the IOMMU driver.
> 
> This vfio_iommu object is backed by iommu_ops, which supports this
> mapping.
> 
> > > +        } else if (cmd == VFIO_IOMMU_MAP_DMA) {
> > > +		struct vfio_dma_map dm;
> > > +
> > > +		if (copy_from_user(&dm, (void __user *)arg, sizeof dm))
> > > +			return -EFAULT;
> > > +
> > > +		ret = vfio_dma_map_dm(iommu, &dm);
> > > +
> > > +		if (!ret && copy_to_user((void __user *)arg, &dm, sizeof dm))
> > > +			ret = -EFAULT;
> > > +
> > > +	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
> > > +		struct vfio_dma_map dm;
> > > +
> > > +		if (copy_from_user(&dm, (void __user *)arg, sizeof dm))
> > > +			return -EFAULT;
> > > +
> > > +		ret = vfio_dma_unmap_dm(iommu, &dm);
> > > +
> > > +		if (!ret && copy_to_user((void __user *)arg, &dm, sizeof dm))
> > > +			ret = -EFAULT;
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +#ifdef CONFIG_COMPAT
> > > +static long vfio_iommu_compat_ioctl(struct file *filep,
> > > +				    unsigned int cmd, unsigned long arg)
> > > +{
> > > +	arg = (unsigned long)compat_ptr(arg);
> > > +	return vfio_iommu_unl_ioctl(filep, cmd, arg);
> > 
> > Um, this only works if the structures are exactly compatible between
> > 32-bit and 64-bit ABIs.  I don't think that is always true.
> 
> I think all our structure sizes are independent of host width.  If I'm
> missing something, let me know.

Ah, for structures, that might be true.  I was seeing the bunch of
ioctl()s that take ints.

> > > +}
> > > +#endif	/* CONFIG_COMPAT */
> > > +
> > > +const struct file_operations vfio_iommu_fops = {
> > > +	.owner		= THIS_MODULE,
> > > +	.release	= vfio_iommu_release,
> > > +	.unlocked_ioctl	= vfio_iommu_unl_ioctl,
> > > +#ifdef CONFIG_COMPAT
> > > +	.compat_ioctl	= vfio_iommu_compat_ioctl,
> > > +#endif
> > > +};
> > > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > > new file mode 100644
> > > index 0000000..6169356
> > > --- /dev/null
> > > +++ b/drivers/vfio/vfio_main.c
> > > @@ -0,0 +1,1151 @@
> > > +/*
> > > + * VFIO framework
> > > + *
> > > + * Copyright (C) 2011 Red Hat, Inc.  All rights reserved.
> > > + *     Author: Alex Williamson <alex.williamson@redhat.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * Derived from original vfio:
> > > + * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
> > > + * Author: Tom Lyon, pugs@cisco.com
> > > + */
> > > +
> > > +#include <linux/cdev.h>
> > > +#include <linux/compat.h>
> > > +#include <linux/device.h>
> > > +#include <linux/file.h>
> > > +#include <linux/anon_inodes.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/idr.h>
> > > +#include <linux/iommu.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/module.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > > +#include <linux/uaccess.h>
> > > +#include <linux/vfio.h>
> > > +#include <linux/wait.h>
> > > +
> > > +#include "vfio_private.h"
> > > +
> > > +#define DRIVER_VERSION	"0.2"
> > > +#define DRIVER_AUTHOR	"Alex Williamson <alex.williamson@redhat.com>"
> > > +#define DRIVER_DESC	"VFIO - User Level meta-driver"
> > > +
> > > +static int allow_unsafe_intrs;
> > > +module_param(allow_unsafe_intrs, int, 0);
> > > +MODULE_PARM_DESC(allow_unsafe_intrs,
> > > +        "Allow use of IOMMUs which do not support interrupt remapping");
> > 
> > This should not be a global option, but part of the AMD/Intel IOMMU
> > specific code.  In general it's a question of how strict the IOMMU
> > driver is about isolation when it determines what the groups are, and
> > only the IOMMU driver can know what the possibilities are for its
> > class of hardware.
> 
> I agree this should probably be tied more closely to the iommu driver,
> but again, we only have iommu_ops right now.
> 
> <snip>
> > > +
> > > +/* Attempt to merge the group pointed to by fd into group.  The merge-ee
> > > + * group must not have an iommu or any devices open because we cannot
> > > + * maintain that context across the merge.  The merge-er group can be
> > > + * in use. */
> > 
> > Yeah, so merge-er group in use still has its problems, because it
> > could affect what the IOMMU is capable of.
> 
> As seen below, we deny merging if the iommu domains are not exactly
> compatible.  Our notion of what compatible means depends on what
> iommu_ops exposes though.

Ok.

> > > +static int vfio_group_merge(struct vfio_group *group, int fd)
> > > +{
> > > +	struct vfio_group *new;
> > > +	struct vfio_iommu *old_iommu;
> > > +	struct file *file;
> > > +	int ret = 0;
> > > +	bool opened = false;
> > > +
> > > +	mutex_lock(&vfio.lock);
> > > +
> > > +	file = fget(fd);
> > > +	if (!file) {
> > > +		ret = -EBADF;
> > > +		goto out_noput;
> > > +	}
> > > +
> > > +	/* Sanity check, is this really our fd? */
> > > +	if (file->f_op != &vfio_group_fops) {
> > 
> > This should be a WARN_ON or BUG_ON rather than just an error return, surely.
> 
> No, I don't think so.  We're passed a file descriptor that could be for
> anything.  If the user passed a file descriptor for something that's not
> a vfio group, that's a user error, not an internal consistency error of
> vfio.

Sorry, I was mixing up which of the fd arguments was which.

> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > > +	new = file->private_data;
> > > +
> > > +	if (!new || new == group || !new->iommu ||
> > > +	    new->iommu->domain || new->bus != group->bus) {
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > > +	/* We need to attach all the devices to each domain separately
> > > +	 * in order to validate that the capabilities match for both.  */
> > > +	ret = __vfio_open_iommu(new->iommu);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	if (!group->iommu->domain) {
> > > +		ret = __vfio_open_iommu(group->iommu);
> > > +		if (ret)
> > > +			goto out;
> > > +		opened = true;
> > > +	}
> > > +
> > > +	/* If cache coherency doesn't match we'd potentialy need to
> > > +	 * remap existing iommu mappings in the merge-er domain.
> > > +	 * Poor return to bother trying to allow this currently. */
> > > +	if (iommu_domain_has_cap(group->iommu->domain,
> > > +				 IOMMU_CAP_CACHE_COHERENCY) !=
> > > +	    iommu_domain_has_cap(new->iommu->domain,
> > > +				 IOMMU_CAP_CACHE_COHERENCY)) {
> > > +		__vfio_close_iommu(new->iommu);
> > > +		if (opened)
> > > +			__vfio_close_iommu(group->iommu);
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > > +	/* Close the iommu for the merge-ee and attach all its devices
> > > +	 * to the merge-er iommu. */
> > > +	__vfio_close_iommu(new->iommu);
> > > +
> > > +	ret = __vfio_iommu_attach_group(group->iommu, new);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	/* set_iommu unlinks new from the iommu, so save a pointer to it */
> > > +	old_iommu = new->iommu;
> > > +	__vfio_group_set_iommu(new, group->iommu);
> > > +	kfree(old_iommu);
> > > +
> > > +out:
> > > +	fput(file);
> > > +out_noput:
> > > +	mutex_unlock(&vfio.lock);
> > > +	return ret;
> > > +}
> > > +
> > > +/* Unmerge the group pointed to by fd from group. */
> > > +static int vfio_group_unmerge(struct vfio_group *group, int fd)
> > > +{
> > > +	struct vfio_group *new;
> > > +	struct vfio_iommu *new_iommu;
> > > +	struct file *file;
> > > +	int ret = 0;
> > > +
> > > +	/* Since the merge-out group is already opened, it needs to
> > > +	 * have an iommu struct associated with it. */
> > > +	new_iommu = kzalloc(sizeof(*new_iommu), GFP_KERNEL);
> > > +	if (!new_iommu)
> > > +		return -ENOMEM;
> > > +
> > > +	INIT_LIST_HEAD(&new_iommu->group_list);
> > > +	INIT_LIST_HEAD(&new_iommu->dm_list);
> > > +	mutex_init(&new_iommu->dgate);
> > > +	new_iommu->bus = group->bus;
> > > +
> > > +	mutex_lock(&vfio.lock);
> > > +
> > > +	file = fget(fd);
> > > +	if (!file) {
> > > +		ret = -EBADF;
> > > +		goto out_noput;
> > > +	}
> > > +
> > > +	/* Sanity check, is this really our fd? */
> > > +	if (file->f_op != &vfio_group_fops) {
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > > +	new = file->private_data;
> > > +	if (!new || new == group || new->iommu != group->iommu) {
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > > +	/* We can't merge-out a group with devices still in use. */
> > > +	if (__vfio_group_devs_inuse(new)) {
> > > +		ret = -EBUSY;
> > > +		goto out;
> > > +	}
> > > +
> > > +	__vfio_iommu_detach_group(group->iommu, new);
> > > +	__vfio_group_set_iommu(new, new_iommu);
> > > +
> > > +out:
> > > +	fput(file);
> > > +out_noput:
> > > +	if (ret)
> > > +		kfree(new_iommu);
> > > +	mutex_unlock(&vfio.lock);
> > > +	return ret;
> > > +}
> > > +
> > > +/* Get a new iommu file descriptor.  This will open the iommu, setting
> > > + * the current->mm ownership if it's not already set. */
> > 
> > I know I've had this explained to me several times before, but I've
> > forgotten again.  Why do we need to wire the iommu to an mm?
> 
> We're mapping process virtual addresses into the IOMMU, so it makes
> sense to restrict ourselves to a single virtual address space.  It also
> enforces the ownership, that only a single mm is in control of the
> group.

Neither of those seems conclusive to me, but I remember that I saw a
strong reason earlier, even if I can't remember it now.

> > > +static int vfio_group_get_iommu_fd(struct vfio_group *group)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	mutex_lock(&vfio.lock);
> > > +
> > > +	if (!group->iommu->domain) {
> > > +		ret = __vfio_open_iommu(group->iommu);
> > > +		if (ret)
> > > +			goto out;
> > > +	}
> > > +
> > > +	ret = anon_inode_getfd("[vfio-iommu]", &vfio_iommu_fops,
> > > +			       group->iommu, O_RDWR);
> > > +	if (ret < 0)
> > > +		goto out;
> > > +
> > > +	group->iommu->refcnt++;
> > > +out:
> > > +	mutex_unlock(&vfio.lock);
> > > +	return ret;
> > > +}
> > > +
> > > +/* Get a new device file descriptor.  This will open the iommu, setting
> > > + * the current->mm ownership if it's not already set.  It's difficult to
> > > + * specify the requirements for matching a user supplied buffer to a
> > > + * device, so we use a vfio driver callback to test for a match.  For
> > > + * PCI, dev_name(dev) is unique, but other drivers may require including
> > > + * a parent device string. */
> > 
> > At some point we probably want an interface to enumerate the devices
> > too, but that can probably wait.
> 
> That's what I decided as well.  I also haven't been able to come up with
> an interface for it that doesn't make me want to vomit.

Ok.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

