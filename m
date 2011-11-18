Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab1KRUdZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Nov 2011 15:33:25 -0500
Message-ID: <1321648376.26410.238.camel@bling.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <dwg@au1.ibm.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Date: Fri, 18 Nov 2011 13:32:56 -0700
In-Reply-To: <20111117000218.GB5411@truffala.fritz.box>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <20111115063431.GA4921@truffala.fritz.box>
	 <1321380088.17169.282.camel@bling.home>
	 <20111117000218.GB5411@truffala.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2011-11-17 at 11:02 +1100, David Gibson wrote:
> On Tue, Nov 15, 2011 at 11:01:28AM -0700, Alex Williamson wrote:
> > On Tue, 2011-11-15 at 17:34 +1100, David Gibson wrote:
> > > On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
<snip>
> > > > +Groups, Devices, IOMMUs, oh my
> > > > +-------------------------------------------------------------------------------
> > > > +
> > > > +A fundamental component of VFIO is the notion of IOMMU groups.  IOMMUs
> > > > +can't always distinguish transactions from each individual device in
> > > > +the system.  Sometimes this is because of the IOMMU design, such as with
> > > > +PEs, other times it's caused by the I/O topology, for instance a
> > > > +PCIe-to-PCI bridge masking all devices behind it.  We call the sets of
> > > > +devices created by these restictions IOMMU groups (or just "groups" for
> > > > +this document).
> > > > +
> > > > +The IOMMU cannot distiguish transactions between the individual devices
> > > > +within the group, therefore the group is the basic unit of ownership for
> > > > +a userspace process.  Because of this, groups are also the primary
> > > > +interface to both devices and IOMMU domains in VFIO.
> > > > +
> > > > +The VFIO representation of groups is created as devices are added into
> > > > +the framework by a VFIO bus driver.  The vfio-pci module is an example
> > > > +of a bus driver.  This module registers devices along with a set of bus
> > > > +specific callbacks with the VFIO core.  These callbacks provide the
> > > > +interfaces later used for device access.  As each new group is created,
> > > > +as determined by iommu_device_group(), VFIO creates a /dev/vfio/$GROUP
> > > > +character device.
> > > 
> > > Ok.. so, the fact that it's called "vfio-pci" suggests that the VFIO
> > > bus driver is per bus type, not per bus instance.   But grouping
> > > constraints could be per bus instance, if you have a couple of
> > > different models of PCI host bridge with IOMMUs of different
> > > capabilities built in, for example.
> > 
> > Yes, vfio-pci manages devices on the pci_bus_type; per type, not per bus
> > instance.
> 
> Ok, how can that work.  vfio-pci is responsible for generating the
> groupings, yes?  For which it needs to know the iommu/host bridge's
> isolation capabilities, which vary depending on the type of host
> bridge.

No, grouping is done at the iommu driver level.  vfio gets groupings via
iomm_device_group(), which uses the iommu_ops for the bus_type of the
requested device.  I'll attempt to clarify where groups come from in the
documentation.

> >  IOMMUs also register drivers per bus type, not per bus
> > instance.  The IOMMU driver is free to impose any constraints it wants.
> > 
> > > > +In addition to the device enumeration and callbacks, the VFIO bus driver
> > > > +also provides a traditional device driver and is able to bind to devices
> > > > +on it's bus.  When a device is bound to the bus driver it's available to
> > > > +VFIO.  When all the devices within a group are bound to their bus drivers,
> > > > +the group becomes "viable" and a user with sufficient access to the VFIO
> > > > +group chardev can obtain exclusive access to the set of group devices.
> > > > +
> > > > +As documented in linux/vfio.h, several ioctls are provided on the
> > > > +group chardev:
> > > > +
> > > > +#define VFIO_GROUP_GET_FLAGS            _IOR(';', 100, __u64)
> > > > + #define VFIO_GROUP_FLAGS_VIABLE        (1 << 0)
> > > > + #define VFIO_GROUP_FLAGS_MM_LOCKED     (1 << 1)
> > > > +#define VFIO_GROUP_MERGE                _IOW(';', 101, int)
> > > > +#define VFIO_GROUP_UNMERGE              _IOW(';', 102, int)
> > > > +#define VFIO_GROUP_GET_IOMMU_FD         _IO(';', 103)
> > > > +#define VFIO_GROUP_GET_DEVICE_FD        _IOW(';', 104, char *)
> > > > +
> > > > +The last two ioctls return new file descriptors for accessing
> > > > +individual devices within the group and programming the IOMMU.  Each of
> > > > +these new file descriptors provide their own set of file interfaces.
> > > > +These ioctls will fail if any of the devices within the group are not
> > > > +bound to their VFIO bus driver.  Additionally, when either of these
> > > > +interfaces are used, the group is then bound to the struct_mm of the
> > > > +caller.  The GET_FLAGS ioctl can be used to view the state of the group.
> > > > +
> > > > +When either the GET_IOMMU_FD or GET_DEVICE_FD ioctls are invoked, a
> > > > +new IOMMU domain is created and all of the devices in the group are
> > > > +attached to it.  This is the only way to ensure full IOMMU isolation
> > > > +of the group, but potentially wastes resources and cycles if the user
> > > > +intends to manage multiple groups with the same set of IOMMU mappings.
> > > > +VFIO therefore provides a group MERGE and UNMERGE interface, which
> > > > +allows multiple groups to share an IOMMU domain.  Not all IOMMUs allow
> > > > +arbitrary groups to be merged, so the user should assume merging is
> > > > +opportunistic.
> > > 
> > > I do not think "opportunistic" means what you think it means..
> > > 
> > > >  A new group, with no open device or IOMMU file
> > > > +descriptors, can be merged into an existing, in-use, group using the
> > > > +MERGE ioctl.  A merged group can be unmerged using the UNMERGE ioctl
> > > > +once all of the device file descriptors for the group being merged
> > > > +"out" are closed.
> > > > +
> > > > +When groups are merged, the GET_IOMMU_FD and GET_DEVICE_FD ioctls are
> > > > +essentially fungible between group file descriptors (ie. if device
> > > > A
> > > 
> > > IDNT "fungible" MWYTIM, either.
> > 
> > Hmm, feel free to suggest.  Maybe we're hitting .us vs .au connotation.
> 
> In any case, I don't think it's a word whose meaning is unambiguous
> enough to use here.
> 
> > > > +is in group X, and X is merged with Y, a file descriptor for A can be
> > > > +retrieved using GET_DEVICE_FD on Y.  Likewise, GET_IOMMU_FD returns a
> > > > +file descriptor referencing the same internal IOMMU object from either
> > > > +X or Y).  Merged groups can be dissolved either explictly with UNMERGE
> > > > +or automatically when ALL file descriptors for the merged group are
> > > > +closed (all IOMMUs, all devices, all groups).
> > > 
> > > Blech.  I'm really not liking this merge/unmerge API as it stands,
> > > it's horribly confusing.  At the very least, we need some better
> > > terminology.  We need some term for the metagroups; supergroups; iommu
> > > domains or-at-least-they-will-be-once-we-open-the-iommu or
> > > whathaveyous.
> > > 
> > > The first confusing thing about this interface is that each open group
> > > handle actually refers to two different things; the original group you
> > > opened and the metagroup it's a part of.  For the GET_IOMMU_FD and
> > > GET_DEVICE_FD operations, you're using the metagroup and two "merged"
> > > group handles are interchangeable.
> > 
> > Fungible, even ;)
> > 
> > > For other MERGE and especially
> > > UNMERGE operations, it matters which is the original group.
> > 
> > If I stick two LEGO blocks together, I need to identify the individual
> > block I want to remove to pull them back apart...
> 
> Yeah, I'm starting to get my head around the model, but the current
> description of it doesn't help very much.  In particular the terms
> "merge" and "unmerge" lead one to the wrong mental model, I think.
> 
> > > The semantics of "merge" and "unmerge" under those names are really
> > > non-obvious.  Merge kind of has to merge two whole metagroups, but
> > > it's unclear if unmerge reverses one merge, or just takes out one
> > > (atom) group.  These operations need better names, at least.
> > 
> > Christian suggested a change to UNMERGE that we do not need to
> > specify a group to unmerge "from".  This makes it more like a list
> > implementation except there's no defined list_head.  Any member of the
> > list can pull in a new entry.  Calling UNMERGE on any member extracts
> > that member.
> 
> I think that's a good idea, but "unmerge" is not a good word for it.

I can't think of better, if you can, please suggest.

> > > Then it's unclear what order you can do various operations, and which
> > > order you can open and close various things.  You can kind of figure
> > > it out but it takes far more thinking than it should.
> > > 
> > > 
> > > So at the _very_ least, we need to invent new terminology and find a
> > > much better way of describing this API's semantics.  I still think an
> > > entirely different interface, where metagroups are created from
> > > outside with a lifetime that's not tied to an fd would be a better
> > > idea.
> > 
> > As we've discussed previously, configfs provides part of this, but has
> > no ioctl support.  It doesn't make sense to me to go play with groups in
> > configfs, but then still interact with them via a char dev.
> 
> Why not?  You configure, say, loopback devices with losetup, then use
> them as a block device.  Similar with nbd.  You can configure serial
> devices with setserial, then use them as a char dev.
> 
> >  It also
> > splits the ownership model 
> 
> I'm not even sure what that means.
> 
> > and makes it harder to enforce who gets to
> > interact with the devices vs who gets to manipulate groups.
> 
> How so.

Let's map out what a configfs interface would look like, maybe I'll
convince myself it's on the table.  We'd probably start with

/config/vfio/$bus_type.name/

That would probably be pre-populated with a bunch of $groupid files,
matching /dev/vfio/$bus_type.name/$groupid char dev files (assuming
configfs can pre-populate files).  To make a user defined group, we
might then do:

mkdir /config/vfio/$bus_type.name/my_group

That would generate a /dev/vfio/$bus_type.name/my_group char dev.  To
add groups to the new my_group "super group", we'd need to do something
like:

ln -s /config/vfio/$bus_type.name/$groupidA /config/vfio/$bus_type.name/my_group/nic_group

I might then add a second group as:

ln -s /config/vfio/$bus_type.name/$groupidB /config/vfio/$bus_type.name/my_group/hba_group

Either link could fail if the target group is not viable, the group is
already in use, or the second link could fail if the iommu domains were
incompatible.

Do these links cause /dev/vfio/$bus_type.name/{$groupidA,$groupidB} to
disappear?  If not, do we allow them to be opened?  Linking would also
have to fail if we later tried to link one of these groupids to a
different super group.

Now we want to give my_group to a user, so we have to go back to /dev
and

chown $user /dev/vfio/$bus_type.name/my_group

At this point my_group would have the existing set of group ioctls sans
{UN}MERGE, of course.

So $user can use the super group, but not manipulate it's members.  Do
we then allow:

chown $user /config/vfio/$bus_type.name/my_group

If so, what does it imply about the user then doing:

ln -s /config/vfio/$bus_type.name/$groupidC /config/vfio/$bus_type.name/my_group/stolen_group

Would we instead need to chown the configfs groups as well as the super
group?

chown $user /config/vfio/$bus_type.name/my_group
chown $user /config/vfio/$bus_type.name/$groupidA
chown $user /config/vfio/$bus_type.name/$groupidB

ie:

# chown $user:$user /config/vfio/$bus_type.name/$groupC
$ ln -s /config/vfio/$bus_type.name/$groupidC /config/vfio/$bus_type.name/my_group/given_group

(linking has to look at the permissions of the target as well as the
link name)

Now we've introduced that we have ownership of configfs entries, what
does that imply about the char dev entries?  For instance, can $userA
own /dev/vfio/$bus_type.name/$groupidA, but $userB own the configfs
file?  We also have another security consideration that an exploit on
the host might allow a 3rd party to insert a device into a group.

This is where I start to get lost in the complexity versus simply giving
the user permissions for the char dev and allowing them to stick groups
together so long as the have permissions for the group.

We also add an entire filesystem to the interface that already spans
sysfs, dev, eventfds and potentially netlink.

If terminology is the complaint against the {UN}MERGE ioctl interface,
I'm still not sold that configfs is the answer.  /me goes to the
thesaurus... amalgamate? blend? combine? cement? unite? join?

> >  The current
> > model really isn't that complicated, imho.  As always, feel free to
> > suggest specific models.  If you have a specific terminology other than
> > MERGE, please suggest.
> > 
> > > Now, you specify that you can't use a group as the second argument of
> > > a merge if it already has an open iommu, but it's not clear from the
> > > doc if you can merge things into a group with an open iommu.
> > 
> > >From above:
> > 
> >         A new group, with no open device or IOMMU file descriptors, can
> >         be merged into an existing, in-use, group using the MERGE ioctl.
> >                                  ^^^^^^
> > 
> > > Banning
> > > this would make life simpler, because the IOMMU's effective
> > > capabilities may change if you add more devices to the domain.  That's
> > > yet another non-obvious constraint in the interface ordering, though.
> > 
> > Banning this would prevent using merged groups with hotplug, which I
> > consider to be a primary use case.
> 
> Yeah, fair enough, based on your later comments w.r.t. only combining
> feature compatible groups.
> 
> > > > +The IOMMU file descriptor provides this set of ioctls:
> > > > +
> > > > +#define VFIO_IOMMU_GET_FLAGS            _IOR(';', 105, __u64)
> > > > + #define VFIO_IOMMU_FLAGS_MAP_ANY       (1 << 0)
> > > > +#define VFIO_IOMMU_MAP_DMA              _IOWR(';', 106, struct vfio_dma_map)
> > > > +#define VFIO_IOMMU_UNMAP_DMA            _IOWR(';', 107, struct vfio_dma_map)
> > > > +
> > > > +The GET_FLAGS ioctl returns basic information about the IOMMU domain.
> > > > +We currently only support IOMMU domains that are able to map any
> > > > +virtual address to any IOVA.  This is indicated by the MAP_ANY
> > > > flag.
> > > 
> > > So.  I tend to think of an IOMMU mapping IOVAs to memory pages, rather
> > > than memory pages to IOVAs.  
> > 
> > I do too, not sure why I wrote it that way, will fix.
> > 
> > > The IOMMU itself, of course maps to
> > > physical addresses, and the meaning of "virtual address" in this
> > > context is not really clear.  I think you would be better off saying
> > > the IOMMU can map any IOVA to any memory page.  From a hardware POV
> > > that means any physical address, but of course for a VFIO user a page
> > > is specified by its process virtual address.
> > 
> > Will fix.
> > 
> > > I think we need to pin exactly what "MAP_ANY" means down better.  Now,
> > > VFIO is pretty much a lost cause if you can't map any normal process
> > > memory page into the IOMMU, so I think the only thing that is really
> > > covered is IOVAs.  But saying "can map any IOVA" is not clear, because
> > > if you can't map it, it's not a (valid) IOVA.  Better to say that
> > > IOVAs can be any 64-bit value, which I think is what you really mean
> > > here.
> > 
> > ok
> > 
> > > Of course, since POWER is a platform where this is *not* true, I'd
> > > prefer to have something giving the range of valid IOVAs in the core
> > > to start with.
> > 
> > Since iommu_ops does not yet have any concept of this (nudge, nudge), I
> > figured this would be added later.  A possible implementation would be
> > that such an iommu would not set MAP_ANY, would add a new flag for
> > MAP_RANGE, and provide a new VFIO_IOMMU_GET_RANGE_INFO ioctl to describe
> > it.  I'm guaranteed to get it wrong if I try to predict all your needs.
> 
> Hrm.  "ANY" just really bothers me because "any iova" is not as clear
> a concept as it first appears.  For starters it's actually "any page
> aligned" at the very least.  But then it's only any 64-bit address for
> busses which have full 64-bit addressing (and I do wonder if there are
> any north bridges out there that forgot to implement some of the upper
> PCI address bits properly, given that 64-bit CPUs rarely actually
> implement more than 40-something physical address bits in practice).
> 
> I'd prefer to see at least something to advertise min and max IOVA and
> IOVA alignment.  That's enough to cover x86 and POWER, including
> possible variants with an IOMMU page size different to the system page
> size (note that POWER kernels can have 64k pages as a config option,
> which means a TCE page size different to the system page size is quite
> common).
> 
> Obviously there could be more complex constraints that we would need
> to advertise with option bits.

x86 has limitations as well.   I don't think most x86 IOMMUs support a
full 64bit IOVA space, so point take.

struct vfio_iommu_info {
	__u64	len;	/* or structlen/arglen */
	__u64	flags;	/* replaces VFIO_IOMMU_GET_FLAGS, none defined yet */
	__u64	iova_max;
	__u64	iova_min;
	__u64	granularity;
};
	
#define VFIO_IOMMU_GET_INFO              _IOR(';', xxx, struct vfio_iommu_info)

Is granularity the minimum granularity, typically PAGE_SIZE barring
special configurations noted above, or is it a bitmap of supported
granularities?  Ex. If we support 4k normal pages and 2M large pages, we
might set bits 12 and 21.

> > > > +
> > > > +The (UN)MAP_DMA commands make use of struct vfio_dma_map for mapping
> > > > +and unmapping IOVAs to process virtual addresses:
> > > > +
> > > > +struct vfio_dma_map {
> > > > +        __u64   len;            /* length of structure */
> > > 
> > > Thanks for adding these structure length fields.  But I think they
> > > should be called something other than 'len', which is likely to be
> > > confused with size (or some other length that's actually related to
> > > the operation's parameters).  Better to call it 'structlen' or
> > > 'argslen' or something.
> > 
> > Ok.  As Scott noted, I've failed to implement these in a way that
> > actually allows extension, but I'll work on it.
> 
> Right.  I had failed to realise quite how the encoding of structure
> size into the ioctl worked.  With that in place, arguably we don't
> really need the size in the structure itself, because we can still
> have multiple sized versions of the ioctl.  Still, whichever.

Hmm, that might be cleaner than eliminating the size with just using
_IO().  So we might have something like:

#define VFIO_IOMMU_MAP_DMA              _IOWR(';', 106, struct vfio_dma_map)
#define VFIO_IOMMU_MAP_DMA_V2           _IOWR(';', 106, struct vfio_dma_map_v2)

For which the driver might do:

case VFIO_IOMMU_MAP_DMA:
case VFIO_IOMMU_MAP_DMA_V2:
{
	struct vfio_dma_map map;

	/* We don't care about the extra v2 bits */
	if (copy_from_user(&map, (void __user *)arg, sizeof map))
		return -EFAULT;
...

That presumes v2 is compatible other than extra fields.  Any objections
(this gets rid of length from all ioctl passed structs)?

> > > > +        __u64   vaddr;          /* process virtual addr */
> > > > +        __u64   dmaaddr;        /* desired and/or returned dma address */
> > > > +        __u64   size;           /* size in bytes */
> > > > +        __u64   flags;
> > > > +#define VFIO_DMA_MAP_FLAG_WRITE         (1 << 0) /* req writeable DMA mem */
> > > 
> > > Make it independent READ and WRITE flags from the start.  Not all
> > > combinations will be be valid on all hardware, but that way we have
> > > the possibilities covered without having to use strange encodings
> > > later.
> > 
> > Ok.
> > 
> > > > +};
> > > > +
> > > > +Current users of VFIO use relatively static DMA mappings, not requiring
> > > > +high frequency turnover.  As new users are added, it's expected that the
> > > > +IOMMU file descriptor will evolve to support new mapping interfaces, this
> > > > +will be reflected in the flags and may present new ioctls and file
> > > > +interfaces.
> > > > +
> > > > +The device GET_FLAGS ioctl is intended to return basic device type and
> > > > +indicate support for optional capabilities.  Flags currently include whether
> > > > +the device is PCI or described by Device Tree, and whether the RESET ioctl
> > > > +is supported:
> > > > +
> > > > +#define VFIO_DEVICE_GET_FLAGS           _IOR(';', 108, __u64)
> > > > + #define VFIO_DEVICE_FLAGS_PCI          (1 << 0)
> > > > + #define VFIO_DEVICE_FLAGS_DT           (1 << 1)
> > > 
> > > TBH, I don't think the VFIO for DT stuff is mature enough yet to be in
> > > an initial infrastructure patch, though we should certainly be
> > > discussing it as an add-on patch.
> > 
> > I agree for DT, and PCI should be added with vfio-pci, not the initial
> > core.
> > 
> > > > + #define VFIO_DEVICE_FLAGS_RESET        (1 << 2)
> > > > +
> > > > +The MMIO and IOP resources used by a device are described by regions.
> > > > +The GET_NUM_REGIONS ioctl tells us how many regions the device supports:
> > > > +
> > > > +#define VFIO_DEVICE_GET_NUM_REGIONS     _IOR(';', 109, int)
> > > > +
> > > > +Regions are described by a struct vfio_region_info, which is retrieved by
> > > > +using the GET_REGION_INFO ioctl with vfio_region_info.index field set to
> > > > +the desired region (0 based index).  Note that devices may implement zero
> > > > +sized regions (vfio-pci does this to provide a 1:1 BAR to region index
> > > > +mapping).
> > > 
> > > So, I think you're saying that a zero-sized region is used to encode a
> > > NOP region, that is, to basically put a "no region here" in between
> > > valid region indices.  You should spell that out.
> > 
> > Ok.
> > 
> > > [Incidentally, any chance you could borrow one of RH's tech writers
> > > for this?  I'm afraid you seem to lack the knack for clear and easily
> > > read documentation]
> > 
> > Thanks for the encouragement :-\  It's no wonder there isn't more
> > content in Documentation.
> 
> Sigh.  Alas, yes.
> 
> > > > +struct vfio_region_info {
> > > > +        __u32   len;            /* length of structure */
> > > > +        __u32   index;          /* region number */
> > > > +        __u64   size;           /* size in bytes of region */
> > > > +        __u64   offset;         /* start offset of region */
> > > > +        __u64   flags;
> > > > +#define VFIO_REGION_INFO_FLAG_MMAP              (1 << 0)
> > > > +#define VFIO_REGION_INFO_FLAG_RO                (1 << 1)
> > > 
> > > Again having separate read and write bits from the start will save
> > > strange encodings later.
> > 
> > Seems highly unlikely, but we have bits to waste...
> > 
> > > > +#define VFIO_REGION_INFO_FLAG_PHYS_VALID        (1 << 2)
> > > > +        __u64   phys;           /* physical address of region */
> > > > +};
> > > 
> > > I notice there is no field for "type" e.g. MMIO vs. PIO vs. config
> > > space for PCI.  If you added that having a NONE type might be a
> > > clearer way of encoding a non-region than just having size==0.
> > 
> > I thought there was some resistance to including MMIO and PIO bits in
> > the flags.  If that's passed, I can add it, but PCI can determine this
> > through config space (and vfio-pci exposes config space at a fixed
> > index).  Having a regions w/ size == 0, MMIO and PIO flags unset seems a
> > little redundant if that's the only reason for having them.  A NONE flag
> > doesn't make sense to me.  Config space isn't NONE, but neither is it
> > MMIO nor PIO; and someone would probably be offended about even
> > mentioning PIO in the specification.
> 
> No, my concept was that NONE would be used for the indexes where there
> is no valid BAR.  I'll buy your argument on why not to include the PCI
> (or whatever) address space type here.
> 
> What I'm just a bit concerned by is whether we could have a case (not
> for PCI) of a real resource that still has size 0 - e.g. maybe some
> sort of doorbell that can't be read or written, but can be triggered
> some other way.  I guess that's probably unlikely though.

Right, and if somehow you had such a region where the size is zero, but
allowed some kind of operation on it, we could define a flag for it.

> > > > +
> > > > +#define VFIO_DEVICE_GET_REGION_INFO     _IOWR(';', 110, struct vfio_region_info)
> > > > +
> > > > +The offset indicates the offset into the device file descriptor which
> > > > +accesses the given range (for read/write/mmap/seek).  Flags indicate the
> > > > +available access types and validity of optional fields.  For instance
> > > > +the phys field may only be valid for certain devices types.
> > > > +
> > > > +Interrupts are described using a similar interface.  GET_NUM_IRQS
> > > > +reports the number or IRQ indexes for the device.
> > > > +
> > > > +#define VFIO_DEVICE_GET_NUM_IRQS        _IOR(';', 111, int)
> > > > +
> > > > +struct vfio_irq_info {
> > > > +        __u32   len;            /* length of structure */
> > > > +        __u32   index;          /* IRQ number */
> > > > +        __u32   count;          /* number of individual IRQs */
> > > 
> > > Is there a reason for allowing irqs in batches like this, rather than
> > > having each MSI be reflected by a separate irq_info?
> > 
> > Yes, bus drivers like vfio-pci can define index 1 as the MSI info
> > structure and index 2 as MSI-X.  There's really no need to expose 57
> > individual MSI interrupts and try to map them to the correct device
> > specific MSI type if they can only logically be enabled in two distinct
> > groups.  Bus drivers with individually controllable MSI vectors are free
> > to expose them separately.  I assume device tree paths would help
> > associate an index to a specific interrupt.
> 
> Ok, fair enough.
> 
> > > > +        __u64   flags;
> > > > +#define VFIO_IRQ_INFO_FLAG_LEVEL                (1 << 0)
> > > > +};
> > > > +
> > > > +Again, zero count entries are allowed (vfio-pci uses a static interrupt
> > > > +type to index mapping).
> > > 
> > > I know what you mean, but you need a clearer way to express it.
> > 
> > I'll work on it.
> > 
> > > > +Information about each index can be retrieved using the GET_IRQ_INFO
> > > > +ioctl, used much like GET_REGION_INFO.
> > > > +
> > > > +#define VFIO_DEVICE_GET_IRQ_INFO        _IOWR(';', 112, struct vfio_irq_info)
> > > > +
> > > > +Individual indexes can describe single or sets of IRQs.  This provides the
> > > > +flexibility to describe PCI INTx, MSI, and MSI-X using a single interface.
> > > > +
> > > > +All VFIO interrupts are signaled to userspace via eventfds.  Integer arrays,
> > > > +as shown below, are used to pass the IRQ info index, the number of eventfds,
> > > > +and each eventfd to be signaled.  Using a count of 0 disables the interrupt.
> > > > +
> > > > +/* Set IRQ eventfds, arg[0] = index, arg[1] = count, arg[2-n] = eventfds */
> > > > +#define VFIO_DEVICE_SET_IRQ_EVENTFDS    _IOW(';', 113, int)
> > > > +
> > > > +When a level triggered interrupt is signaled, the interrupt is masked
> > > > +on the host.  This prevents an unresponsive userspace driver from
> > > > +continuing to interrupt the host system.  After servicing the interrupt,
> > > > +UNMASK_IRQ is used to allow the interrupt to retrigger.  Note that level
> > > > +triggered interrupts implicitly have a count of 1 per index.
> > > 
> > > This is a silly restriction.  Even PCI devices can have up to 4 LSIs
> > > on a function in theory, though no-one ever does.  Embedded devices
> > > can and do have multiple level interrupts.
> > 
> > Per the PCI spec, an individual PCI function can only ever have, at
> > most, a single INTx line.  A multi-function *device* can have up to 4
> > INTx lines, but what we're exposing here is a struct device, ie. a PCI
> > function.
> 
> Ah, my mistake.
> 
> > Other devices could certainly have multiple level interrupts, and if
> > grouping them as we do with MSI on PCI makes sense, please let me know.
> > I just didn't see the value in making the unmask operations handle
> > sub-indexes if it's not needed.
> 
> I don't know of anything off hand.  But I can't see any consideration
> that would make it unlikely either.  I generally don't trust anything
> *not* to exist in embedded space.

Fair enough.  Level IRQs are still triggered individually, so unmasking
is too, which means UNMASK_IRQ takes something like { int index; int
subindex }.

SET_UNMASK_IRQ_EVENTFDS should follow SET_IRQ_EVENTFDS and take { int
index; int count; int fds[] }.

> > > > +
> > > > +/* Unmask IRQ index, arg[0] = index */
> > > > +#define VFIO_DEVICE_UNMASK_IRQ          _IOW(';', 114, int)
> > > > +
> > > > +Level triggered interrupts can also be unmasked using an irqfd.  Use
> > > > +SET_UNMASK_IRQ_EVENTFD to set the file descriptor for this.
> > > > +
> > > > +/* Set unmask eventfd, arg[0] = index, arg[1] = eventfd */
> > > > +#define VFIO_DEVICE_SET_UNMASK_IRQ_EVENTFD      _IOW(';', 115, int)
> > > > +
> > > > +When supported, as indicated by the device flags, reset the device.
> > > > +
> > > > +#define VFIO_DEVICE_RESET               _IO(';', 116)
> > > > +
> > > > +Device tree devices also invlude ioctls for further defining the
> > > > +device tree properties of the device:
> > > > +
> > > > +struct vfio_dtpath {
> > > > +        __u32   len;            /* length of structure */
> > > > +        __u32   index;
> > > > +        __u64   flags;
> > > > +#define VFIO_DTPATH_FLAGS_REGION        (1 << 0)
> > > > +#define VFIO_DTPATH_FLAGS_IRQ           (1 << 1)
> > > > +        char    *path;
> > > > +};
> > > > +#define VFIO_DEVICE_GET_DTPATH          _IOWR(';', 117, struct vfio_dtpath)
> > > > +
> > > > +struct vfio_dtindex {
> > > > +        __u32   len;            /* length of structure */
> > > > +        __u32   index;
> > > > +        __u32   prop_type;
> > > > +        __u32   prop_index;
> > > > +        __u64   flags;
> > > > +#define VFIO_DTINDEX_FLAGS_REGION       (1 << 0)
> > > > +#define VFIO_DTINDEX_FLAGS_IRQ          (1 << 1)
> > > > +};
> > > > +#define VFIO_DEVICE_GET_DTINDEX         _IOWR(';', 118, struct vfio_dtindex)
> > > > +
> > > > +
> > > > +VFIO bus driver API
> > > > +-------------------------------------------------------------------------------
> > > > +
> > > > +Bus drivers, such as PCI, have three jobs:
> > > > + 1) Add/remove devices from vfio
> > > > + 2) Provide vfio_device_ops for device access
> > > > + 3) Device binding and unbinding
> > > > +
> > > > +When initialized, the bus driver should enumerate the devices on it's
> > > 
> > > s/it's/its/
> > 
> > Noted.
> > 
> > <snip>
> > > > +/* Unmap DMA region */
> > > > +/* dgate must be held */
> > > > +static int __vfio_dma_unmap(struct vfio_iommu *iommu, unsigned long iova,
> > > > +			    int npage, int rdwr)
> > > 
> > > Use of "read" and "write" in DMA can often be confusing, since it's
> > > not always clear if you're talking from the perspective of the CPU or
> > > the device (_writing_ data to a device will usually involve it doing
> > > DMA _reads_ from memory).  It's often best to express things as DMA
> > > direction, 'to device', and 'from device' instead.
> > 
> > Good point.
> 
> This, of course, potentially affects many areas of the code and doco.

I've changed vfio_iommu to use <linux/dma-direction.h> definitions
internally.  For the ioctl I've so far simply included WRITE and READ
flags, which I can clarify are from the device perspective.  Flags like
VFIO_DMA_MAP_FLAG_TO_DEVICE/FROM_DEVICE are actually more confusing to
me at this interface level.  We also have IOMMU_READ/IOMMU_WRITE which
makes me question using dma-direction.h and if we shouldn't just define
everything as from the device perspective.

> > > > +{
> > > > +	int i, unlocked = 0;
> > > > +
> > > > +	for (i = 0; i < npage; i++, iova += PAGE_SIZE) {
> > > > +		unsigned long pfn;
> > > > +
> > > > +		pfn = iommu_iova_to_phys(iommu->domain, iova) >> PAGE_SHIFT;
> > > > +		if (pfn) {
> > > > +			iommu_unmap(iommu->domain, iova, 0);
> > > > +			unlocked += put_pfn(pfn, rdwr);
> > > > +		}
> > > > +	}
> > > > +	return unlocked;
> > > > +}
> > > > +
> > > > +static void vfio_dma_unmap(struct vfio_iommu *iommu, unsigned long iova,
> > > > +			   unsigned long npage, int rdwr)
> > > > +{
> > > > +	int unlocked;
> > > > +
> > > > +	unlocked = __vfio_dma_unmap(iommu, iova, npage, rdwr);
> > > > +	vfio_lock_acct(-unlocked);
> > > 
> > > Have you checked that your accounting will work out if the user maps
> > > the same memory page to multiple IOVAs?
> > 
> > Hmm, it probably doesn't.  We potentially over-penalize the user process
> > here.
> 
> Ok.

FWIW, I don't intend to fix this right now, but I have added a comment
in the code noting it.  We'll have to see if there's an efficient way to
make the tracking better.

> > > > +}
> > > > +
> > > > +/* Unmap ALL DMA regions */
> > > > +void vfio_iommu_unmapall(struct vfio_iommu *iommu)
> > > > +{
> > > > +	struct list_head *pos, *pos2;
> > > > +	struct dma_map_page *mlp;
> > > > +
> > > > +	mutex_lock(&iommu->dgate);
> > > > +	list_for_each_safe(pos, pos2, &iommu->dm_list) {
> > > > +		mlp = list_entry(pos, struct dma_map_page, list);
> > > > +		vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> > > > +		list_del(&mlp->list);
> > > > +		kfree(mlp);
> > > > +	}
> > > > +	mutex_unlock(&iommu->dgate);
> > > 
> > > Ouch, no good at all.  Keeping track of every DMA map is no good on
> > > POWER or other systems where IOMMU operations are a hot path.  I think
> > > you'll need an iommu specific hook for this instead, which uses
> > > whatever data structures are natural for the IOMMU.  For example a
> > > 1-level pagetable, like we use on POWER will just zero every entry.
> > 
> > It's already been noted in the docs that current users have relatively
> > static mappings and a performance interface is TBD for dynamically
> > backing streaming DMA.  The current vfio_iommu exposes iommu_ops, POWER
> > will need to come up with something to expose instead.
> 
> Right, but I'm not just talking about the current map/unmap calls
> themselves.  This infrastructure for tracking it looks like it's
> intended to be generic for all mapping methods.  If not, I can't see
> the reason for it, because I don't think the current interface
> requires such tracking inherently.

It does seem that way, but there is a purpose.  We need to unmap
everything on release.  It's easy to assume that iommu_domain_free()
will unmap everything from the IOMMU, which it does, but we've also done
a get_user_pages on each of those in vfio, which we need to cleanup.  We
can't rely on userspace to do this since they might have been SIGKILL'd.
Making it generic with coalescing of adjacent regions and such is
primarily for space efficiency.

<snip>
> > > > +#ifdef CONFIG_COMPAT
> > > > +static long vfio_iommu_compat_ioctl(struct file *filep,
> > > > +				    unsigned int cmd, unsigned long arg)
> > > > +{
> > > > +	arg = (unsigned long)compat_ptr(arg);
> > > > +	return vfio_iommu_unl_ioctl(filep, cmd, arg);
> > > 
> > > Um, this only works if the structures are exactly compatible between
> > > 32-bit and 64-bit ABIs.  I don't think that is always true.
> > 
> > I think all our structure sizes are independent of host width.  If I'm
> > missing something, let me know.
> 
> Ah, for structures, that might be true.  I was seeing the bunch of
> ioctl()s that take ints.

Ugh, I suppose you're thinking of an ILP64 platform with ILP32 compat
mode.  Darn it, guess we need to make everything 64bit, including file
descriptors.

<snip>
> > > > +
> > > > +/* Get a new iommu file descriptor.  This will open the iommu, setting
> > > > + * the current->mm ownership if it's not already set. */
> > > 
> > > I know I've had this explained to me several times before, but I've
> > > forgotten again.  Why do we need to wire the iommu to an mm?
> > 
> > We're mapping process virtual addresses into the IOMMU, so it makes
> > sense to restrict ourselves to a single virtual address space.  It also
> > enforces the ownership, that only a single mm is in control of the
> > group.
> 
> Neither of those seems conclusive to me, but I remember that I saw a
> strong reason earlier, even if I can't remember it now.

The point of the group is to provide a unit of ownership.  We can't let
$userA open $groupid and fetch a device, then have $userB do the same,
grabbing a different device.  The mappings will step on each other and
the devices have no isolation.  We can't restrict that purely by file
permissions or we'll have the same problem with sudo.  At one point we
discussed a single open instance, but that unnecessarily limits the
user, so we settled on the mm.  Thanks,

Alex

