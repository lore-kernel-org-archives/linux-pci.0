Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:42600 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab1KOGel (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 01:34:41 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <dwg@au1.ibm.com>;
	Tue, 15 Nov 2011 06:33:10 +1000
Date: Tue, 15 Nov 2011 17:34:31 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
Message-ID: <20111115063431.GA4921@truffala.fritz.box>
References: <20111103195452.21259.93021.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111103195452.21259.93021.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
> VFIO provides a secure, IOMMU based interface for user space
> drivers, including device assignment to virtual machines.
> This provides the base management of IOMMU groups, devices,
> and IOMMU objects.  See Documentation/vfio.txt included in
> this patch for user and kernel API description.
> 
> Note, this implements the new API discussed at KVM Forum
> 2011, as represented by the drvier version 0.2.  It's hoped
> that this provides a modular enough interface to support PCI
> and non-PCI userspace drivers across various architectures
> and IOMMU implementations.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> Fingers crossed, this is the last RFC for VFIO, but we need
> the iommu group support before this can go upstream
> (http://lkml.indiana.edu/hypermail/linux/kernel/1110.2/02303.html),
> hoping this helps push that along.
> 
> Since the last posting, this version completely modularizes
> the device backends and better defines the APIs between the
> core VFIO code and the device backends.  I expect that we
> might also adopt a modular IOMMU interface as iommu_ops learns
> about different types of hardware.  Also many, many cleanups.
> Check the complete git history for details:
> 
> git://github.com/awilliam/linux-vfio.git vfio-ng
> 
> (matching qemu tree: git://github.com/awilliam/qemu-vfio.git)
> 
> This version, along with the supporting VFIO PCI backend can
> be found here:
> 
> git://github.com/awilliam/linux-vfio.git vfio-next-20111103
> 
> I've held off on implementing a kernel->user signaling
> mechanism for now since the previous netlink version produced
> too many gag reflexes.  It's easy enough to set a bit in the
> group flags too indicate such support in the future, so I
> think we can move ahead without it.
> 
> Appreciate any feedback or suggestions.  Thanks,
> 
> Alex
> 
>  Documentation/ioctl/ioctl-number.txt |    1 
>  Documentation/vfio.txt               |  304 +++++++++
>  MAINTAINERS                          |    8 
>  drivers/Kconfig                      |    2 
>  drivers/Makefile                     |    1 
>  drivers/vfio/Kconfig                 |    8 
>  drivers/vfio/Makefile                |    3 
>  drivers/vfio/vfio_iommu.c            |  530 ++++++++++++++++
>  drivers/vfio/vfio_main.c             | 1151 ++++++++++++++++++++++++++++++++++
>  drivers/vfio/vfio_private.h          |   34 +
>  include/linux/vfio.h                 |  155 +++++
>  11 files changed, 2197 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/vfio.txt
>  create mode 100644 drivers/vfio/Kconfig
>  create mode 100644 drivers/vfio/Makefile
>  create mode 100644 drivers/vfio/vfio_iommu.c
>  create mode 100644 drivers/vfio/vfio_main.c
>  create mode 100644 drivers/vfio/vfio_private.h
>  create mode 100644 include/linux/vfio.h
> 
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index 54078ed..59d01e4 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -88,6 +88,7 @@ Code  Seq#(hex)	Include File		Comments
>  		and kernel/power/user.c
>  '8'	all				SNP8023 advanced NIC card
>  					<mailto:mcr@solidum.com>
> +';'	64-76	linux/vfio.h
>  '@'	00-0F	linux/radeonfb.h	conflict!
>  '@'	00-0F	drivers/video/aty/aty128fb.c	conflict!
>  'A'	00-1F	linux/apm_bios.h	conflict!
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> new file mode 100644
> index 0000000..5866896
> --- /dev/null
> +++ b/Documentation/vfio.txt
> @@ -0,0 +1,304 @@
> +VFIO - "Virtual Function I/O"[1]
> +-------------------------------------------------------------------------------
> +Many modern system now provide DMA and interrupt remapping facilities
> +to help ensure I/O devices behave within the boundaries they've been
> +allotted.  This includes x86 hardware with AMD-Vi and Intel VT-d as
> +well as POWER systems with Partitionable Endpoints (PEs) and even
> +embedded powerpc systems (technology name unknown).  The VFIO driver
> +is an IOMMU/device agnostic framework for exposing direct device
> +access to userspace, in a secure, IOMMU protected environment.  In
> +other words, this allows safe, non-privileged, userspace drivers.

It's perhaps worth emphasisng that "safe" depends on the hardware
being sufficiently well behaved.  BenH, I know, thinks there are a
*lot* of cards that, e.g. have debug registers that allow a backdoor
to their own config space via MMIO, which would bypass vfio's
filtering of config space access.  And that's before we even get into
the varying degrees of completeness in the isolation provided by
different IOMMUs.

> +Why do we want that?  Virtual machines often make use of direct device
> +access ("device assignment") when configured for the highest possible
> +I/O performance.  From a device and host perspective, this simply turns
> +the VM into a userspace driver, with the benefits of significantly
> +reduced latency, higher bandwidth, and direct use of bare-metal device
> +drivers[2].
> +
> +Some applications, particularly in the high performance computing
> +field, also benefit from low-overhead, direct device access from
> +userspace.  Examples include network adapters (often non-TCP/IP based)
> +and compute accelerators.  Previous to VFIO, these drivers needed to

s/Previous/Prior/  although that may be a .us vs .au usage thing.

> +go through the full development cycle to become proper upstream driver,
> +be maintained out of tree, or make use of the UIO framework, which
> +has no notion of IOMMU protection, limited interrupt support, and
> +requires root privileges to access things like PCI configuration space.
> +
> +The VFIO driver framework intends to unify these, replacing both the
> +KVM PCI specific device assignment currently used as well as provide
> +a more secure, more featureful userspace driver environment than UIO.
> +
> +Groups, Devices, IOMMUs, oh my
> +-------------------------------------------------------------------------------
> +
> +A fundamental component of VFIO is the notion of IOMMU groups.  IOMMUs
> +can't always distinguish transactions from each individual device in
> +the system.  Sometimes this is because of the IOMMU design, such as with
> +PEs, other times it's caused by the I/O topology, for instance a
> +PCIe-to-PCI bridge masking all devices behind it.  We call the sets of
> +devices created by these restictions IOMMU groups (or just "groups" for
> +this document).
> +
> +The IOMMU cannot distiguish transactions between the individual devices
> +within the group, therefore the group is the basic unit of ownership for
> +a userspace process.  Because of this, groups are also the primary
> +interface to both devices and IOMMU domains in VFIO.
> +
> +The VFIO representation of groups is created as devices are added into
> +the framework by a VFIO bus driver.  The vfio-pci module is an example
> +of a bus driver.  This module registers devices along with a set of bus
> +specific callbacks with the VFIO core.  These callbacks provide the
> +interfaces later used for device access.  As each new group is created,
> +as determined by iommu_device_group(), VFIO creates a /dev/vfio/$GROUP
> +character device.

Ok.. so, the fact that it's called "vfio-pci" suggests that the VFIO
bus driver is per bus type, not per bus instance.   But grouping
constraints could be per bus instance, if you have a couple of
different models of PCI host bridge with IOMMUs of different
capabilities built in, for example.

> +In addition to the device enumeration and callbacks, the VFIO bus driver
> +also provides a traditional device driver and is able to bind to devices
> +on it's bus.  When a device is bound to the bus driver it's available to
> +VFIO.  When all the devices within a group are bound to their bus drivers,
> +the group becomes "viable" and a user with sufficient access to the VFIO
> +group chardev can obtain exclusive access to the set of group devices.
> +
> +As documented in linux/vfio.h, several ioctls are provided on the
> +group chardev:
> +
> +#define VFIO_GROUP_GET_FLAGS            _IOR(';', 100, __u64)
> + #define VFIO_GROUP_FLAGS_VIABLE        (1 << 0)
> + #define VFIO_GROUP_FLAGS_MM_LOCKED     (1 << 1)
> +#define VFIO_GROUP_MERGE                _IOW(';', 101, int)
> +#define VFIO_GROUP_UNMERGE              _IOW(';', 102, int)
> +#define VFIO_GROUP_GET_IOMMU_FD         _IO(';', 103)
> +#define VFIO_GROUP_GET_DEVICE_FD        _IOW(';', 104, char *)
> +
> +The last two ioctls return new file descriptors for accessing
> +individual devices within the group and programming the IOMMU.  Each of
> +these new file descriptors provide their own set of file interfaces.
> +These ioctls will fail if any of the devices within the group are not
> +bound to their VFIO bus driver.  Additionally, when either of these
> +interfaces are used, the group is then bound to the struct_mm of the
> +caller.  The GET_FLAGS ioctl can be used to view the state of the group.
> +
> +When either the GET_IOMMU_FD or GET_DEVICE_FD ioctls are invoked, a
> +new IOMMU domain is created and all of the devices in the group are
> +attached to it.  This is the only way to ensure full IOMMU isolation
> +of the group, but potentially wastes resources and cycles if the user
> +intends to manage multiple groups with the same set of IOMMU mappings.
> +VFIO therefore provides a group MERGE and UNMERGE interface, which
> +allows multiple groups to share an IOMMU domain.  Not all IOMMUs allow
> +arbitrary groups to be merged, so the user should assume merging is
> +opportunistic.

I do not think "opportunistic" means what you think it means..

>  A new group, with no open device or IOMMU file
> +descriptors, can be merged into an existing, in-use, group using the
> +MERGE ioctl.  A merged group can be unmerged using the UNMERGE ioctl
> +once all of the device file descriptors for the group being merged
> +"out" are closed.
> +
> +When groups are merged, the GET_IOMMU_FD and GET_DEVICE_FD ioctls are
> +essentially fungible between group file descriptors (ie. if device
> A

IDNT "fungible" MWYTIM, either.

> +is in group X, and X is merged with Y, a file descriptor for A can be
> +retrieved using GET_DEVICE_FD on Y.  Likewise, GET_IOMMU_FD returns a
> +file descriptor referencing the same internal IOMMU object from either
> +X or Y).  Merged groups can be dissolved either explictly with UNMERGE
> +or automatically when ALL file descriptors for the merged group are
> +closed (all IOMMUs, all devices, all groups).

Blech.  I'm really not liking this merge/unmerge API as it stands,
it's horribly confusing.  At the very least, we need some better
terminology.  We need some term for the metagroups; supergroups; iommu
domains or-at-least-they-will-be-once-we-open-the-iommu or
whathaveyous.

The first confusing thing about this interface is that each open group
handle actually refers to two different things; the original group you
opened and the metagroup it's a part of.  For the GET_IOMMU_FD and
GET_DEVICE_FD operations, you're using the metagroup and two "merged"
group handles are interchangeable.  For other MERGE and especially
UNMERGE operations, it matters which is the original group.

The semantics of "merge" and "unmerge" under those names are really
non-obvious.  Merge kind of has to merge two whole metagroups, but
it's unclear if unmerge reverses one merge, or just takes out one
(atom) group.  These operations need better names, at least.

Then it's unclear what order you can do various operations, and which
order you can open and close various things.  You can kind of figure
it out but it takes far more thinking than it should.


So at the _very_ least, we need to invent new terminology and find a
much better way of describing this API's semantics.  I still think an
entirely different interface, where metagroups are created from
outside with a lifetime that's not tied to an fd would be a better
idea.



Now, you specify that you can't use a group as the second argument of
a merge if it already has an open iommu, but it's not clear from the
doc if you can merge things into a group with an open iommu.  Banning
this would make life simpler, because the IOMMU's effective
capabilities may change if you add more devices to the domain.  That's
yet another non-obvious constraint in the interface ordering, though.

> +The IOMMU file descriptor provides this set of ioctls:
> +
> +#define VFIO_IOMMU_GET_FLAGS            _IOR(';', 105, __u64)
> + #define VFIO_IOMMU_FLAGS_MAP_ANY       (1 << 0)
> +#define VFIO_IOMMU_MAP_DMA              _IOWR(';', 106, struct vfio_dma_map)
> +#define VFIO_IOMMU_UNMAP_DMA            _IOWR(';', 107, struct vfio_dma_map)
> +
> +The GET_FLAGS ioctl returns basic information about the IOMMU domain.
> +We currently only support IOMMU domains that are able to map any
> +virtual address to any IOVA.  This is indicated by the MAP_ANY
> flag.

So.  I tend to think of an IOMMU mapping IOVAs to memory pages, rather
than memory pages to IOVAs.  The IOMMU itself, of course maps to
physical addresses, and the meaning of "virtual address" in this
context is not really clear.  I think you would be better off saying
the IOMMU can map any IOVA to any memory page.  From a hardware POV
that means any physical address, but of course for a VFIO user a page
is specified by its process virtual address.

I think we need to pin exactly what "MAP_ANY" means down better.  Now,
VFIO is pretty much a lost cause if you can't map any normal process
memory page into the IOMMU, so I think the only thing that is really
covered is IOVAs.  But saying "can map any IOVA" is not clear, because
if you can't map it, it's not a (valid) IOVA.  Better to say that
IOVAs can be any 64-bit value, which I think is what you really mean
here.

Of course, since POWER is a platform where this is *not* true, I'd
prefer to have something giving the range of valid IOVAs in the core
to start with.

> +
> +The (UN)MAP_DMA commands make use of struct vfio_dma_map for mapping
> +and unmapping IOVAs to process virtual addresses:
> +
> +struct vfio_dma_map {
> +        __u64   len;            /* length of structure */

Thanks for adding these structure length fields.  But I think they
should be called something other than 'len', which is likely to be
confused with size (or some other length that's actually related to
the operation's parameters).  Better to call it 'structlen' or
'argslen' or something.

> +        __u64   vaddr;          /* process virtual addr */
> +        __u64   dmaaddr;        /* desired and/or returned dma address */
> +        __u64   size;           /* size in bytes */
> +        __u64   flags;
> +#define VFIO_DMA_MAP_FLAG_WRITE         (1 << 0) /* req writeable DMA mem */

Make it independent READ and WRITE flags from the start.  Not all
combinations will be be valid on all hardware, but that way we have
the possibilities covered without having to use strange encodings
later.

> +};
> +
> +Current users of VFIO use relatively static DMA mappings, not requiring
> +high frequency turnover.  As new users are added, it's expected that the
> +IOMMU file descriptor will evolve to support new mapping interfaces, this
> +will be reflected in the flags and may present new ioctls and file
> +interfaces.
> +
> +The device GET_FLAGS ioctl is intended to return basic device type and
> +indicate support for optional capabilities.  Flags currently include whether
> +the device is PCI or described by Device Tree, and whether the RESET ioctl
> +is supported:
> +
> +#define VFIO_DEVICE_GET_FLAGS           _IOR(';', 108, __u64)
> + #define VFIO_DEVICE_FLAGS_PCI          (1 << 0)
> + #define VFIO_DEVICE_FLAGS_DT           (1 << 1)

TBH, I don't think the VFIO for DT stuff is mature enough yet to be in
an initial infrastructure patch, though we should certainly be
discussing it as an add-on patch.

> + #define VFIO_DEVICE_FLAGS_RESET        (1 << 2)
> +
> +The MMIO and IOP resources used by a device are described by regions.
> +The GET_NUM_REGIONS ioctl tells us how many regions the device supports:
> +
> +#define VFIO_DEVICE_GET_NUM_REGIONS     _IOR(';', 109, int)
> +
> +Regions are described by a struct vfio_region_info, which is retrieved by
> +using the GET_REGION_INFO ioctl with vfio_region_info.index field set to
> +the desired region (0 based index).  Note that devices may implement zero
> +sized regions (vfio-pci does this to provide a 1:1 BAR to region index
> +mapping).

So, I think you're saying that a zero-sized region is used to encode a
NOP region, that is, to basically put a "no region here" in between
valid region indices.  You should spell that out.

[Incidentally, any chance you could borrow one of RH's tech writers
for this?  I'm afraid you seem to lack the knack for clear and easily
read documentation]

> +struct vfio_region_info {
> +        __u32   len;            /* length of structure */
> +        __u32   index;          /* region number */
> +        __u64   size;           /* size in bytes of region */
> +        __u64   offset;         /* start offset of region */
> +        __u64   flags;
> +#define VFIO_REGION_INFO_FLAG_MMAP              (1 << 0)
> +#define VFIO_REGION_INFO_FLAG_RO                (1 << 1)

Again having separate read and write bits from the start will save
strange encodings later.

> +#define VFIO_REGION_INFO_FLAG_PHYS_VALID        (1 << 2)
> +        __u64   phys;           /* physical address of region */
> +};

I notice there is no field for "type" e.g. MMIO vs. PIO vs. config
space for PCI.  If you added that having a NONE type might be a
clearer way of encoding a non-region than just having size==0.

> +
> +#define VFIO_DEVICE_GET_REGION_INFO     _IOWR(';', 110, struct vfio_region_info)
> +
> +The offset indicates the offset into the device file descriptor which
> +accesses the given range (for read/write/mmap/seek).  Flags indicate the
> +available access types and validity of optional fields.  For instance
> +the phys field may only be valid for certain devices types.
> +
> +Interrupts are described using a similar interface.  GET_NUM_IRQS
> +reports the number or IRQ indexes for the device.
> +
> +#define VFIO_DEVICE_GET_NUM_IRQS        _IOR(';', 111, int)
> +
> +struct vfio_irq_info {
> +        __u32   len;            /* length of structure */
> +        __u32   index;          /* IRQ number */
> +        __u32   count;          /* number of individual IRQs */

Is there a reason for allowing irqs in batches like this, rather than
having each MSI be reflected by a separate irq_info?

> +        __u64   flags;
> +#define VFIO_IRQ_INFO_FLAG_LEVEL                (1 << 0)
> +};
> +
> +Again, zero count entries are allowed (vfio-pci uses a static interrupt
> +type to index mapping).

I know what you mean, but you need a clearer way to express it.

> +Information about each index can be retrieved using the GET_IRQ_INFO
> +ioctl, used much like GET_REGION_INFO.
> +
> +#define VFIO_DEVICE_GET_IRQ_INFO        _IOWR(';', 112, struct vfio_irq_info)
> +
> +Individual indexes can describe single or sets of IRQs.  This provides the
> +flexibility to describe PCI INTx, MSI, and MSI-X using a single interface.
> +
> +All VFIO interrupts are signaled to userspace via eventfds.  Integer arrays,
> +as shown below, are used to pass the IRQ info index, the number of eventfds,
> +and each eventfd to be signaled.  Using a count of 0 disables the interrupt.
> +
> +/* Set IRQ eventfds, arg[0] = index, arg[1] = count, arg[2-n] = eventfds */
> +#define VFIO_DEVICE_SET_IRQ_EVENTFDS    _IOW(';', 113, int)
> +
> +When a level triggered interrupt is signaled, the interrupt is masked
> +on the host.  This prevents an unresponsive userspace driver from
> +continuing to interrupt the host system.  After servicing the interrupt,
> +UNMASK_IRQ is used to allow the interrupt to retrigger.  Note that level
> +triggered interrupts implicitly have a count of 1 per index.

This is a silly restriction.  Even PCI devices can have up to 4 LSIs
on a function in theory, though no-one ever does.  Embedded devices
can and do have multiple level interrupts.

> +
> +/* Unmask IRQ index, arg[0] = index */
> +#define VFIO_DEVICE_UNMASK_IRQ          _IOW(';', 114, int)
> +
> +Level triggered interrupts can also be unmasked using an irqfd.  Use
> +SET_UNMASK_IRQ_EVENTFD to set the file descriptor for this.
> +
> +/* Set unmask eventfd, arg[0] = index, arg[1] = eventfd */
> +#define VFIO_DEVICE_SET_UNMASK_IRQ_EVENTFD      _IOW(';', 115, int)
> +
> +When supported, as indicated by the device flags, reset the device.
> +
> +#define VFIO_DEVICE_RESET               _IO(';', 116)
> +
> +Device tree devices also invlude ioctls for further defining the
> +device tree properties of the device:
> +
> +struct vfio_dtpath {
> +        __u32   len;            /* length of structure */
> +        __u32   index;
> +        __u64   flags;
> +#define VFIO_DTPATH_FLAGS_REGION        (1 << 0)
> +#define VFIO_DTPATH_FLAGS_IRQ           (1 << 1)
> +        char    *path;
> +};
> +#define VFIO_DEVICE_GET_DTPATH          _IOWR(';', 117, struct vfio_dtpath)
> +
> +struct vfio_dtindex {
> +        __u32   len;            /* length of structure */
> +        __u32   index;
> +        __u32   prop_type;
> +        __u32   prop_index;
> +        __u64   flags;
> +#define VFIO_DTINDEX_FLAGS_REGION       (1 << 0)
> +#define VFIO_DTINDEX_FLAGS_IRQ          (1 << 1)
> +};
> +#define VFIO_DEVICE_GET_DTINDEX         _IOWR(';', 118, struct vfio_dtindex)
> +
> +
> +VFIO bus driver API
> +-------------------------------------------------------------------------------
> +
> +Bus drivers, such as PCI, have three jobs:
> + 1) Add/remove devices from vfio
> + 2) Provide vfio_device_ops for device access
> + 3) Device binding and unbinding
> +
> +When initialized, the bus driver should enumerate the devices on it's

s/it's/its/

> +bus and call vfio_group_add_dev() for each device.  If the bus supports
> +hotplug, notifiers should be enabled to track devices being added and
> +removed.  vfio_group_del_dev() removes a previously added device from
> +vfio.
> +
> +Adding a device registers a vfio_device_ops function pointer structure
> +for the device:
> +
> +struct vfio_device_ops {
> +	bool			(*match)(struct device *, char *);
> +	int			(*get)(void *);
> +	void			(*put)(void *);
> +	ssize_t			(*read)(void *, char __user *,
> +					size_t, loff_t *);
> +	ssize_t			(*write)(void *, const char __user *,
> +					 size_t, loff_t *);
> +	long			(*ioctl)(void *, unsigned int, unsigned long);
> +	int			(*mmap)(void *, struct vm_area_struct *);
> +};
> +
> +When a device is bound to the bus driver, the bus driver indicates this
> +to vfio using the vfio_bind_dev() interface.  The device_data parameter
> +is a pointer to an opaque data structure for use only by the bus driver.
> +The get, put, read, write, ioctl, and mmap vfio_device_ops all pass
> +this data structure back to the bus driver.  When a device is unbound
> +from the bus driver, the vfio_unbind_dev() interface signals this to
> +vfio.  This function returns the pointer to the device_data structure
> +registered for the device.
> +
> +As noted previously, a group contains one or more devices, so
> +GROUP_GET_DEVICE_FD needs to identify the specific device being requested.
> +The vfio_device_ops.match callback is used to allow bus drivers to determine
> +the match.  For drivers like vfio-pci, it's a simple match to dev_name(),
> +which is unique in the system due to the PCI bus topology, other bus drivers
> +may need to include parent devices to create a unique match, so this is
> +left as a bus driver interface.
> +
> +-------------------------------------------------------------------------------
> +
> +[1] VFIO was originally an acronym for "Virtual Function I/O" in it's
> +initial implementation by Tom Lyon while as Cisco.  We've since outgrown
> +the acronym, but it's catchy.
> +
> +[2] As always there are trade-offs to virtual machine device
> +assignment that are beyond the scope of VFIO.  It's expected that
> +future IOMMU technologies will reduce some, but maybe not all, of
> +these trade-offs.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f05f5f6..4bd5aa0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7106,6 +7106,14 @@ S:	Maintained
>  F:	Documentation/filesystems/vfat.txt
>  F:	fs/fat/
>  
> +VFIO DRIVER
> +M:	Alex Williamson <alex.williamson@redhat.com>
> +L:	kvm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/vfio.txt
> +F:	drivers/vfio/
> +F:	include/linux/vfio.h
> +
>  VIDEOBUF2 FRAMEWORK
>  M:	Pawel Osciak <pawel@osciak.com>
>  M:	Marek Szyprowski <m.szyprowski@samsung.com>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index b5e6f24..e15578b 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -112,6 +112,8 @@ source "drivers/auxdisplay/Kconfig"
>  
>  source "drivers/uio/Kconfig"
>  
> +source "drivers/vfio/Kconfig"
> +
>  source "drivers/vlynq/Kconfig"
>  
>  source "drivers/virtio/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 1b31421..5f138b5 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_ATM)		+= atm/
>  obj-$(CONFIG_FUSION)		+= message/
>  obj-y				+= firewire/
>  obj-$(CONFIG_UIO)		+= uio/
> +obj-$(CONFIG_VFIO)		+= vfio/
>  obj-y				+= cdrom/
>  obj-y				+= auxdisplay/
>  obj-$(CONFIG_PCCARD)		+= pcmcia/
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> new file mode 100644
> index 0000000..9acb1e7
> --- /dev/null
> +++ b/drivers/vfio/Kconfig
> @@ -0,0 +1,8 @@
> +menuconfig VFIO
> +	tristate "VFIO Non-Privileged userspace driver framework"
> +	depends on IOMMU_API
> +	help
> +	  VFIO provides a framework for secure userspace device drivers.
> +	  See Documentation/vfio.txt for more details.
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> new file mode 100644
> index 0000000..088faf1
> --- /dev/null
> +++ b/drivers/vfio/Makefile
> @@ -0,0 +1,3 @@
> +vfio-y := vfio_main.o vfio_iommu.o
> +
> +obj-$(CONFIG_VFIO) := vfio.o
> diff --git a/drivers/vfio/vfio_iommu.c b/drivers/vfio/vfio_iommu.c
> new file mode 100644
> index 0000000..029dae3
> --- /dev/null
> +++ b/drivers/vfio/vfio_iommu.c
> @@ -0,0 +1,530 @@
> +/*
> + * VFIO: IOMMU DMA mapping support
> + *
> + * Copyright (C) 2011 Red Hat, Inc.  All rights reserved.
> + *     Author: Alex Williamson <alex.williamson@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Derived from original vfio:
> + * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
> + * Author: Tom Lyon, pugs@cisco.com
> + */
> +
> +#include <linux/compat.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/vfio.h>
> +#include <linux/workqueue.h>
> +
> +#include "vfio_private.h"
> +
> +struct dma_map_page {
> +	struct list_head	list;
> +	dma_addr_t		daddr;
> +	unsigned long		vaddr;
> +	int			npage;
> +	int			rdwr;
> +};
> +
> +/*
> + * This code handles mapping and unmapping of user data buffers
> + * into DMA'ble space using the IOMMU
> + */
> +
> +#define NPAGE_TO_SIZE(npage)	((size_t)(npage) << PAGE_SHIFT)
> +
> +struct vwork {
> +	struct mm_struct	*mm;
> +	int			npage;
> +	struct work_struct	work;
> +};
> +
> +/* delayed decrement for locked_vm */
> +static void vfio_lock_acct_bg(struct work_struct *work)
> +{
> +	struct vwork *vwork = container_of(work, struct vwork, work);
> +	struct mm_struct *mm;
> +
> +	mm = vwork->mm;
> +	down_write(&mm->mmap_sem);
> +	mm->locked_vm += vwork->npage;
> +	up_write(&mm->mmap_sem);
> +	mmput(mm);		/* unref mm */
> +	kfree(vwork);
> +}
> +
> +static void vfio_lock_acct(int npage)
> +{
> +	struct vwork *vwork;
> +	struct mm_struct *mm;
> +
> +	if (!current->mm) {
> +		/* process exited */
> +		return;
> +	}
> +	if (down_write_trylock(&current->mm->mmap_sem)) {
> +		current->mm->locked_vm += npage;
> +		up_write(&current->mm->mmap_sem);
> +		return;
> +	}
> +	/*
> +	 * Couldn't get mmap_sem lock, so must setup to decrement
> +	 * mm->locked_vm later. If locked_vm were atomic, we wouldn't
> +	 * need this silliness
> +	 */
> +	vwork = kmalloc(sizeof(struct vwork), GFP_KERNEL);
> +	if (!vwork)
> +		return;
> +	mm = get_task_mm(current);	/* take ref mm */
> +	if (!mm) {
> +		kfree(vwork);
> +		return;
> +	}
> +	INIT_WORK(&vwork->work, vfio_lock_acct_bg);
> +	vwork->mm = mm;
> +	vwork->npage = npage;
> +	schedule_work(&vwork->work);
> +}
> +
> +/* Some mappings aren't backed by a struct page, for example an mmap'd
> + * MMIO range for our own or another device.  These use a different
> + * pfn conversion and shouldn't be tracked as locked pages. */
> +static int is_invalid_reserved_pfn(unsigned long pfn)
> +{
> +	if (pfn_valid(pfn)) {
> +		int reserved;
> +		struct page *tail = pfn_to_page(pfn);
> +		struct page *head = compound_trans_head(tail);
> +		reserved = PageReserved(head);
> +		if (head != tail) {
> +			/* "head" is not a dangling pointer
> +			 * (compound_trans_head takes care of that)
> +			 * but the hugepage may have been split
> +			 * from under us (and we may not hold a
> +			 * reference count on the head page so it can
> +			 * be reused before we run PageReferenced), so
> +			 * we've to check PageTail before returning
> +			 * what we just read.
> +			 */
> +			smp_rmb();
> +			if (PageTail(tail))
> +				return reserved;
> +		}
> +		return PageReserved(tail);
> +	}
> +
> +	return true;
> +}
> +
> +static int put_pfn(unsigned long pfn, int rdwr)
> +{
> +	if (!is_invalid_reserved_pfn(pfn)) {
> +		struct page *page = pfn_to_page(pfn);
> +		if (rdwr)
> +			SetPageDirty(page);
> +		put_page(page);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +/* Unmap DMA region */
> +/* dgate must be held */
> +static int __vfio_dma_unmap(struct vfio_iommu *iommu, unsigned long iova,
> +			    int npage, int rdwr)

Use of "read" and "write" in DMA can often be confusing, since it's
not always clear if you're talking from the perspective of the CPU or
the device (_writing_ data to a device will usually involve it doing
DMA _reads_ from memory).  It's often best to express things as DMA
direction, 'to device', and 'from device' instead.

> +{
> +	int i, unlocked = 0;
> +
> +	for (i = 0; i < npage; i++, iova += PAGE_SIZE) {
> +		unsigned long pfn;
> +
> +		pfn = iommu_iova_to_phys(iommu->domain, iova) >> PAGE_SHIFT;
> +		if (pfn) {
> +			iommu_unmap(iommu->domain, iova, 0);
> +			unlocked += put_pfn(pfn, rdwr);
> +		}
> +	}
> +	return unlocked;
> +}
> +
> +static void vfio_dma_unmap(struct vfio_iommu *iommu, unsigned long iova,
> +			   unsigned long npage, int rdwr)
> +{
> +	int unlocked;
> +
> +	unlocked = __vfio_dma_unmap(iommu, iova, npage, rdwr);
> +	vfio_lock_acct(-unlocked);

Have you checked that your accounting will work out if the user maps
the same memory page to multiple IOVAs?

> +}
> +
> +/* Unmap ALL DMA regions */
> +void vfio_iommu_unmapall(struct vfio_iommu *iommu)
> +{
> +	struct list_head *pos, *pos2;
> +	struct dma_map_page *mlp;
> +
> +	mutex_lock(&iommu->dgate);
> +	list_for_each_safe(pos, pos2, &iommu->dm_list) {
> +		mlp = list_entry(pos, struct dma_map_page, list);
> +		vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> +		list_del(&mlp->list);
> +		kfree(mlp);
> +	}
> +	mutex_unlock(&iommu->dgate);

Ouch, no good at all.  Keeping track of every DMA map is no good on
POWER or other systems where IOMMU operations are a hot path.  I think
you'll need an iommu specific hook for this instead, which uses
whatever data structures are natural for the IOMMU.  For example a
1-level pagetable, like we use on POWER will just zero every entry.

> +}
> +
> +static int vaddr_get_pfn(unsigned long vaddr, int rdwr, unsigned long *pfn)
> +{
> +	struct page *page[1];
> +	struct vm_area_struct *vma;
> +	int ret = -EFAULT;
> +
> +	if (get_user_pages_fast(vaddr, 1, rdwr, page) == 1) {
> +		*pfn = page_to_pfn(page[0]);
> +		return 0;
> +	}
> +
> +	down_read(&current->mm->mmap_sem);
> +
> +	vma = find_vma_intersection(current->mm, vaddr, vaddr + 1);
> +
> +	if (vma && vma->vm_flags & VM_PFNMAP) {
> +		*pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
> +		if (is_invalid_reserved_pfn(*pfn))
> +			ret = 0;
> +	}

It's kind of nasty that you take gup_fast(), already designed to grab
pointers for multiple user pages, then just use it one page at a time,
even for a big map.

> +	up_read(&current->mm->mmap_sem);
> +
> +	return ret;
> +}
> +
> +/* Map DMA region */
> +/* dgate must be held */
> +static int vfio_dma_map(struct vfio_iommu *iommu, unsigned long iova,
> +			unsigned long vaddr, int npage, int rdwr)

iova should be a dma_addr_t.  Bus address size need not match virtual
address size, and may not fit in an unsigned long.

> +{
> +	unsigned long start = iova;
> +	int i, ret, locked = 0, prot = IOMMU_READ;
> +
> +	/* Verify pages are not already mapped */
> +	for (i = 0; i < npage; i++, iova += PAGE_SIZE)
> +		if (iommu_iova_to_phys(iommu->domain, iova))
> +			return -EBUSY;
> +
> +	iova = start;
> +
> +	if (rdwr)
> +		prot |= IOMMU_WRITE;
> +	if (iommu->cache)
> +		prot |= IOMMU_CACHE;
> +
> +	for (i = 0; i < npage; i++, iova += PAGE_SIZE, vaddr += PAGE_SIZE) {
> +		unsigned long pfn = 0;
> +
> +		ret = vaddr_get_pfn(vaddr, rdwr, &pfn);
> +		if (ret) {
> +			__vfio_dma_unmap(iommu, start, i, rdwr);
> +			return ret;
> +		}
> +
> +		/* Only add actual locked pages to accounting */
> +		if (!is_invalid_reserved_pfn(pfn))
> +			locked++;
> +
> +		ret = iommu_map(iommu->domain, iova,
> +				(phys_addr_t)pfn << PAGE_SHIFT, 0, prot);
> +		if (ret) {
> +			/* Back out mappings on error */
> +			put_pfn(pfn, rdwr);
> +			__vfio_dma_unmap(iommu, start, i, rdwr);
> +			return ret;
> +		}
> +	}
> +	vfio_lock_acct(locked);
> +	return 0;
> +}
> +
> +static inline int ranges_overlap(unsigned long start1, size_t size1,
> +				 unsigned long start2, size_t size2)
> +{
> +	return !(start1 + size1 <= start2 || start2 + size2 <= start1);

Needs overflow safety.

> +}
> +
> +static struct dma_map_page *vfio_find_dma(struct vfio_iommu *iommu,
> +					  dma_addr_t start, size_t size)
> +{
> +	struct list_head *pos;
> +	struct dma_map_page *mlp;
> +
> +	list_for_each(pos, &iommu->dm_list) {
> +		mlp = list_entry(pos, struct dma_map_page, list);
> +		if (ranges_overlap(mlp->daddr, NPAGE_TO_SIZE(mlp->npage),
> +				   start, size))
> +			return mlp;
> +	}
> +	return NULL;
> +}

Again, keeping track of each dma map operation is no good for
performance.

> +
> +int vfio_remove_dma_overlap(struct vfio_iommu *iommu, dma_addr_t start,
> +			    size_t size, struct dma_map_page *mlp)
> +{
> +	struct dma_map_page *split;
> +	int npage_lo, npage_hi;
> +
> +	/* Existing dma region is completely covered, unmap all */
> +	if (start <= mlp->daddr &&
> +	    start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> +		vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> +		list_del(&mlp->list);
> +		npage_lo = mlp->npage;
> +		kfree(mlp);
> +		return npage_lo;
> +	}
> +
> +	/* Overlap low address of existing range */
> +	if (start <= mlp->daddr) {
> +		size_t overlap;
> +
> +		overlap = start + size - mlp->daddr;
> +		npage_lo = overlap >> PAGE_SHIFT;
> +		npage_hi = mlp->npage - npage_lo;
> +
> +		vfio_dma_unmap(iommu, mlp->daddr, npage_lo, mlp->rdwr);
> +		mlp->daddr += overlap;
> +		mlp->vaddr += overlap;
> +		mlp->npage -= npage_lo;
> +		return npage_lo;
> +	}
> +
> +	/* Overlap high address of existing range */
> +	if (start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> +		size_t overlap;
> +
> +		overlap = mlp->daddr + NPAGE_TO_SIZE(mlp->npage) - start;
> +		npage_hi = overlap >> PAGE_SHIFT;
> +		npage_lo = mlp->npage - npage_hi;
> +
> +		vfio_dma_unmap(iommu, start, npage_hi, mlp->rdwr);
> +		mlp->npage -= npage_hi;
> +		return npage_hi;
> +	}
> +
> +	/* Split existing */
> +	npage_lo = (start - mlp->daddr) >> PAGE_SHIFT;
> +	npage_hi = mlp->npage - (size >> PAGE_SHIFT) - npage_lo;
> +
> +	split = kzalloc(sizeof *split, GFP_KERNEL);
> +	if (!split)
> +		return -ENOMEM;
> +
> +	vfio_dma_unmap(iommu, start, size >> PAGE_SHIFT, mlp->rdwr);
> +
> +	mlp->npage = npage_lo;
> +
> +	split->npage = npage_hi;
> +	split->daddr = start + size;
> +	split->vaddr = mlp->vaddr + NPAGE_TO_SIZE(npage_lo) + size;
> +	split->rdwr = mlp->rdwr;
> +	list_add(&split->list, &iommu->dm_list);
> +	return size >> PAGE_SHIFT;
> +}
> +
> +int vfio_dma_unmap_dm(struct vfio_iommu *iommu, struct vfio_dma_map *dmp)
> +{
> +	int ret = 0;
> +	size_t npage = dmp->size >> PAGE_SHIFT;
> +	struct list_head *pos, *n;
> +
> +	if (dmp->dmaaddr & ~PAGE_MASK)
> +		return -EINVAL;
> +	if (dmp->size & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	mutex_lock(&iommu->dgate);
> +
> +	list_for_each_safe(pos, n, &iommu->dm_list) {
> +		struct dma_map_page *mlp;
> +
> +		mlp = list_entry(pos, struct dma_map_page, list);
> +		if (ranges_overlap(mlp->daddr, NPAGE_TO_SIZE(mlp->npage),
> +				   dmp->dmaaddr, dmp->size)) {
> +			ret = vfio_remove_dma_overlap(iommu, dmp->dmaaddr,
> +						      dmp->size, mlp);
> +			if (ret > 0)
> +				npage -= NPAGE_TO_SIZE(ret);
> +			if (ret < 0 || npage == 0)
> +				break;
> +		}
> +	}
> +	mutex_unlock(&iommu->dgate);
> +	return ret > 0 ? 0 : ret;
> +}
> +
> +int vfio_dma_map_dm(struct vfio_iommu *iommu, struct vfio_dma_map *dmp)
> +{
> +	int npage;
> +	struct dma_map_page *mlp, *mmlp = NULL;
> +	dma_addr_t daddr = dmp->dmaaddr;
> +	unsigned long locked, lock_limit, vaddr = dmp->vaddr;
> +	size_t size = dmp->size;
> +	int ret = 0, rdwr = dmp->flags & VFIO_DMA_MAP_FLAG_WRITE;
> +
> +	if (vaddr & (PAGE_SIZE-1))
> +		return -EINVAL;
> +	if (daddr & (PAGE_SIZE-1))
> +		return -EINVAL;
> +	if (size & (PAGE_SIZE-1))
> +		return -EINVAL;
> +
> +	npage = size >> PAGE_SHIFT;
> +	if (!npage)
> +		return -EINVAL;
> +
> +	if (!iommu)
> +		return -EINVAL;
> +
> +	mutex_lock(&iommu->dgate);
> +
> +	if (vfio_find_dma(iommu, daddr, size)) {
> +		ret = -EBUSY;
> +		goto out_lock;
> +	}
> +
> +	/* account for locked pages */
> +	locked = current->mm->locked_vm + npage;
> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> +		printk(KERN_WARNING "%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
> +			__func__, rlimit(RLIMIT_MEMLOCK));
> +		ret = -ENOMEM;
> +		goto out_lock;
> +	}
> +
> +	ret = vfio_dma_map(iommu, daddr, vaddr, npage, rdwr);
> +	if (ret)
> +		goto out_lock;
> +
> +	/* Check if we abut a region below */
> +	if (daddr) {
> +		mlp = vfio_find_dma(iommu, daddr - 1, 1);
> +		if (mlp && mlp->rdwr == rdwr &&
> +		    mlp->vaddr + NPAGE_TO_SIZE(mlp->npage) == vaddr) {
> +
> +			mlp->npage += npage;
> +			daddr = mlp->daddr;
> +			vaddr = mlp->vaddr;
> +			npage = mlp->npage;
> +			size = NPAGE_TO_SIZE(npage);
> +
> +			mmlp = mlp;
> +		}
> +	}
> +
> +	if (daddr + size) {
> +		mlp = vfio_find_dma(iommu, daddr + size, 1);
> +		if (mlp && mlp->rdwr == rdwr && mlp->vaddr == vaddr + size) {
> +
> +			mlp->npage += npage;
> +			mlp->daddr = daddr;
> +			mlp->vaddr = vaddr;
> +
> +			/* If merged above and below, remove previously
> +			 * merged entry.  New entry covers it.  */
> +			if (mmlp) {
> +				list_del(&mmlp->list);
> +				kfree(mmlp);
> +			}
> +			mmlp = mlp;
> +		}
> +	}
> +
> +	if (!mmlp) {
> +		mlp = kzalloc(sizeof *mlp, GFP_KERNEL);
> +		if (!mlp) {
> +			ret = -ENOMEM;
> +			vfio_dma_unmap(iommu, daddr, npage, rdwr);
> +			goto out_lock;
> +		}
> +
> +		mlp->npage = npage;
> +		mlp->daddr = daddr;
> +		mlp->vaddr = vaddr;
> +		mlp->rdwr = rdwr;
> +		list_add(&mlp->list, &iommu->dm_list);
> +	}
> +
> +out_lock:
> +	mutex_unlock(&iommu->dgate);
> +	return ret;
> +}

This whole tracking infrastructure is way too complex to impose on
every IOMMU.  We absolutely don't want to do all this when just
updating a 1-level pagetable.

> +static int vfio_iommu_release(struct inode *inode, struct file *filep)
> +{
> +	struct vfio_iommu *iommu = filep->private_data;
> +
> +	vfio_release_iommu(iommu);
> +	return 0;
> +}
> +
> +static long vfio_iommu_unl_ioctl(struct file *filep,
> +				 unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_iommu *iommu = filep->private_data;
> +	int ret = -ENOSYS;
> +
> +        if (cmd == VFIO_IOMMU_GET_FLAGS) {
> +                u64 flags = VFIO_IOMMU_FLAGS_MAP_ANY;
> +
> +                ret = put_user(flags, (u64 __user *)arg);

Um.. flags surely have to come from the IOMMU driver.

> +        } else if (cmd == VFIO_IOMMU_MAP_DMA) {
> +		struct vfio_dma_map dm;
> +
> +		if (copy_from_user(&dm, (void __user *)arg, sizeof dm))
> +			return -EFAULT;
> +
> +		ret = vfio_dma_map_dm(iommu, &dm);
> +
> +		if (!ret && copy_to_user((void __user *)arg, &dm, sizeof dm))
> +			ret = -EFAULT;
> +
> +	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
> +		struct vfio_dma_map dm;
> +
> +		if (copy_from_user(&dm, (void __user *)arg, sizeof dm))
> +			return -EFAULT;
> +
> +		ret = vfio_dma_unmap_dm(iommu, &dm);
> +
> +		if (!ret && copy_to_user((void __user *)arg, &dm, sizeof dm))
> +			ret = -EFAULT;
> +	}
> +	return ret;
> +}
> +
> +#ifdef CONFIG_COMPAT
> +static long vfio_iommu_compat_ioctl(struct file *filep,
> +				    unsigned int cmd, unsigned long arg)
> +{
> +	arg = (unsigned long)compat_ptr(arg);
> +	return vfio_iommu_unl_ioctl(filep, cmd, arg);

Um, this only works if the structures are exactly compatible between
32-bit and 64-bit ABIs.  I don't think that is always true.

> +}
> +#endif	/* CONFIG_COMPAT */
> +
> +const struct file_operations vfio_iommu_fops = {
> +	.owner		= THIS_MODULE,
> +	.release	= vfio_iommu_release,
> +	.unlocked_ioctl	= vfio_iommu_unl_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= vfio_iommu_compat_ioctl,
> +#endif
> +};
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> new file mode 100644
> index 0000000..6169356
> --- /dev/null
> +++ b/drivers/vfio/vfio_main.c
> @@ -0,0 +1,1151 @@
> +/*
> + * VFIO framework
> + *
> + * Copyright (C) 2011 Red Hat, Inc.  All rights reserved.
> + *     Author: Alex Williamson <alex.williamson@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Derived from original vfio:
> + * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
> + * Author: Tom Lyon, pugs@cisco.com
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/compat.h>
> +#include <linux/device.h>
> +#include <linux/file.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/fs.h>
> +#include <linux/idr.h>
> +#include <linux/iommu.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +#include <linux/vfio.h>
> +#include <linux/wait.h>
> +
> +#include "vfio_private.h"
> +
> +#define DRIVER_VERSION	"0.2"
> +#define DRIVER_AUTHOR	"Alex Williamson <alex.williamson@redhat.com>"
> +#define DRIVER_DESC	"VFIO - User Level meta-driver"
> +
> +static int allow_unsafe_intrs;
> +module_param(allow_unsafe_intrs, int, 0);
> +MODULE_PARM_DESC(allow_unsafe_intrs,
> +        "Allow use of IOMMUs which do not support interrupt remapping");

This should not be a global option, but part of the AMD/Intel IOMMU
specific code.  In general it's a question of how strict the IOMMU
driver is about isolation when it determines what the groups are, and
only the IOMMU driver can know what the possibilities are for its
class of hardware.

> +
> +static struct vfio {
> +	dev_t			devt;
> +	struct cdev		cdev;
> +	struct list_head	group_list;
> +	struct mutex		lock;
> +	struct kref		kref;
> +	struct class		*class;
> +	struct idr		idr;
> +	wait_queue_head_t	release_q;
> +} vfio;
> +
> +static const struct file_operations vfio_group_fops;
> +extern const struct file_operations vfio_iommu_fops;
> +
> +struct vfio_group {
> +	dev_t			devt;
> +	unsigned int		groupid;
> +	struct bus_type		*bus;
> +	struct vfio_iommu	*iommu;
> +	struct list_head	device_list;
> +	struct list_head	iommu_next;
> +	struct list_head	group_next;
> +	int			refcnt;
> +};
> +
> +struct vfio_device {
> +	struct device			*dev;
> +	const struct vfio_device_ops	*ops;
> +	struct vfio_iommu		*iommu;
> +	struct vfio_group		*group;
> +	struct list_head		device_next;
> +	bool				attached;
> +	int				refcnt;
> +	void				*device_data;
> +};
> +
> +/*
> + * Helper functions called under vfio.lock
> + */
> +
> +/* Return true if any devices within a group are opened */
> +static bool __vfio_group_devs_inuse(struct vfio_group *group)
> +{
> +	struct list_head *pos;
> +
> +	list_for_each(pos, &group->device_list) {
> +		struct vfio_device *device;
> +
> +		device = list_entry(pos, struct vfio_device, device_next);
> +		if (device->refcnt)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/* Return true if any of the groups attached to an iommu are opened.
> + * We can only tear apart merged groups when nothing is left open. */
> +static bool __vfio_iommu_groups_inuse(struct vfio_iommu *iommu)
> +{
> +	struct list_head *pos;
> +
> +	list_for_each(pos, &iommu->group_list) {
> +		struct vfio_group *group;
> +
> +		group = list_entry(pos, struct vfio_group, iommu_next);
> +		if (group->refcnt)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/* An iommu is "in use" if it has a file descriptor open or if any of
> + * the groups assigned to the iommu have devices open. */
> +static bool __vfio_iommu_inuse(struct vfio_iommu *iommu)
> +{
> +	struct list_head *pos;
> +
> +	if (iommu->refcnt)
> +		return true;
> +
> +	list_for_each(pos, &iommu->group_list) {
> +		struct vfio_group *group;
> +
> +		group = list_entry(pos, struct vfio_group, iommu_next);
> +
> +		if (__vfio_group_devs_inuse(group))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static void __vfio_group_set_iommu(struct vfio_group *group,
> +				   struct vfio_iommu *iommu)
> +{
> +	struct list_head *pos;
> +
> +	if (group->iommu)
> +		list_del(&group->iommu_next);
> +	if (iommu)
> +		list_add(&group->iommu_next, &iommu->group_list);
> +
> +	group->iommu = iommu;
> +
> +	list_for_each(pos, &group->device_list) {
> +		struct vfio_device *device;
> +
> +		device = list_entry(pos, struct vfio_device, device_next);
> +		device->iommu = iommu;
> +	}
> +}
> +
> +static void __vfio_iommu_detach_dev(struct vfio_iommu *iommu,
> +				    struct vfio_device *device)
> +{
> +	BUG_ON(!iommu->domain && device->attached);
> +
> +	if (!iommu->domain || !device->attached)
> +		return;
> +
> +	iommu_detach_device(iommu->domain, device->dev);
> +	device->attached = false;
> +}
> +
> +static void __vfio_iommu_detach_group(struct vfio_iommu *iommu,
> +				      struct vfio_group *group)
> +{
> +	struct list_head *pos;
> +
> +	list_for_each(pos, &group->device_list) {
> +		struct vfio_device *device;
> +
> +		device = list_entry(pos, struct vfio_device, device_next);
> +		__vfio_iommu_detach_dev(iommu, device);
> +	}
> +}
> +
> +static int __vfio_iommu_attach_dev(struct vfio_iommu *iommu,
> +				   struct vfio_device *device)
> +{
> +	int ret;
> +
> +	BUG_ON(device->attached);
> +
> +	if (!iommu || !iommu->domain)
> +		return -EINVAL;
> +
> +	ret = iommu_attach_device(iommu->domain, device->dev);
> +	if (!ret)
> +		device->attached = true;
> +
> +	return ret;
> +}
> +
> +static int __vfio_iommu_attach_group(struct vfio_iommu *iommu,
> +				     struct vfio_group *group)
> +{
> +	struct list_head *pos;
> +
> +	list_for_each(pos, &group->device_list) {
> +		struct vfio_device *device;
> +		int ret;
> +
> +		device = list_entry(pos, struct vfio_device, device_next);
> +		ret = __vfio_iommu_attach_dev(iommu, device);
> +		if (ret) {
> +			__vfio_iommu_detach_group(iommu, group);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/* The iommu is viable, ie. ready to be configured, when all the devices
> + * for all the groups attached to the iommu are bound to their vfio device
> + * drivers (ex. vfio-pci).  This sets the device_data private data pointer. */
> +static bool __vfio_iommu_viable(struct vfio_iommu *iommu)
> +{
> +	struct list_head *gpos, *dpos;
> +
> +	list_for_each(gpos, &iommu->group_list) {
> +		struct vfio_group *group;
> +		group = list_entry(gpos, struct vfio_group, iommu_next);
> +
> +		list_for_each(dpos, &group->device_list) {
> +			struct vfio_device *device;
> +			device = list_entry(dpos,
> +					    struct vfio_device, device_next);
> +
> +			if (!device->device_data)
> +				return false;
> +		}
> +	}
> +	return true;
> +}
> +
> +static void __vfio_close_iommu(struct vfio_iommu *iommu)
> +{
> +	struct list_head *pos;
> +
> +	if (!iommu->domain)
> +		return;
> +
> +	list_for_each(pos, &iommu->group_list) {
> +		struct vfio_group *group;
> +		group = list_entry(pos, struct vfio_group, iommu_next);
> +
> +		__vfio_iommu_detach_group(iommu, group);
> +	}
> +
> +	vfio_iommu_unmapall(iommu);
> +
> +	iommu_domain_free(iommu->domain);
> +	iommu->domain = NULL;
> +	iommu->mm = NULL;
> +}
> +
> +/* Open the IOMMU.  This gates all access to the iommu or device file
> + * descriptors and sets current->mm as the exclusive user. */
> +static int __vfio_open_iommu(struct vfio_iommu *iommu)
> +{
> +	struct list_head *pos;
> +	int ret;
> +
> +	if (!__vfio_iommu_viable(iommu))
> +		return -EBUSY;
> +
> +	if (iommu->domain)
> +		return -EINVAL;
> +
> +	iommu->domain = iommu_domain_alloc(iommu->bus);
> +	if (!iommu->domain)
> +		return -EFAULT;
> +
> +	list_for_each(pos, &iommu->group_list) {
> +		struct vfio_group *group;
> +		group = list_entry(pos, struct vfio_group, iommu_next);
> +
> +		ret = __vfio_iommu_attach_group(iommu, group);
> +		if (ret) {
> +			__vfio_close_iommu(iommu);
> +			return ret;
> +		}
> +	}
> +
> +	if (!allow_unsafe_intrs &&
> +	    !iommu_domain_has_cap(iommu->domain, IOMMU_CAP_INTR_REMAP)) {
> +		__vfio_close_iommu(iommu);
> +		return -EFAULT;
> +	}
> +
> +	iommu->cache = (iommu_domain_has_cap(iommu->domain,
> +					     IOMMU_CAP_CACHE_COHERENCY) != 0);
> +	iommu->mm = current->mm;
> +
> +	return 0;
> +}
> +
> +/* Actively try to tear down the iommu and merged groups.  If there are no
> + * open iommu or device fds, we close the iommu.  If we close the iommu and
> + * there are also no open group fds, we can futher dissolve the group to
> + * iommu association and free the iommu data structure. */
> +static int __vfio_try_dissolve_iommu(struct vfio_iommu *iommu)
> +{
> +
> +	if (__vfio_iommu_inuse(iommu))
> +		return -EBUSY;
> +
> +	__vfio_close_iommu(iommu);
> +
> +	if (!__vfio_iommu_groups_inuse(iommu)) {
> +		struct list_head *pos, *ppos;
> +
> +		list_for_each_safe(pos, ppos, &iommu->group_list) {
> +			struct vfio_group *group;
> +
> +			group = list_entry(pos, struct vfio_group, iommu_next);
> +			__vfio_group_set_iommu(group, NULL);
> +		}
> +
> +
> +		kfree(iommu);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct vfio_device *__vfio_lookup_dev(struct device *dev)
> +{
> +	struct list_head *gpos;
> +	unsigned int groupid;
> +
> +	if (iommu_device_group(dev, &groupid))
> +		return NULL;
> +
> +	list_for_each(gpos, &vfio.group_list) {
> +		struct vfio_group *group;
> +		struct list_head *dpos;
> +
> +		group = list_entry(gpos, struct vfio_group, group_next);
> +
> +		if (group->groupid != groupid)
> +			continue;
> +
> +		list_for_each(dpos, &group->device_list) {
> +			struct vfio_device *device;
> +
> +			device = list_entry(dpos,
> +					    struct vfio_device, device_next);
> +
> +			if (device->dev == dev)
> +				return device;
> +		}
> +	}
> +	return NULL;
> +}
> +
> +/* All release paths simply decrement the refcnt, attempt to teardown
> + * the iommu and merged groups, and wakeup anything that might be
> + * waiting if we successfully dissolve anything. */
> +static int vfio_do_release(int *refcnt, struct vfio_iommu *iommu)
> +{
> +	bool wake;
> +
> +	mutex_lock(&vfio.lock);
> +
> +	(*refcnt)--;
> +	wake = (__vfio_try_dissolve_iommu(iommu) == 0);
> +
> +	mutex_unlock(&vfio.lock);
> +
> +	if (wake)
> +		wake_up(&vfio.release_q);
> +
> +	return 0;
> +}
> +
> +/*
> + * Device fops - passthrough to vfio device driver w/ device_data
> + */
> +static int vfio_device_release(struct inode *inode, struct file *filep)
> +{
> +	struct vfio_device *device = filep->private_data;
> +
> +	vfio_do_release(&device->refcnt, device->iommu);
> +
> +	device->ops->put(device->device_data);
> +
> +	return 0;
> +}
> +
> +static long vfio_device_unl_ioctl(struct file *filep,
> +				  unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_device *device = filep->private_data;
> +
> +	return device->ops->ioctl(device->device_data, cmd, arg);
> +}
> +
> +static ssize_t vfio_device_read(struct file *filep, char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct vfio_device *device = filep->private_data;
> +
> +	return device->ops->read(device->device_data, buf, count, ppos);
> +}
> +
> +static ssize_t vfio_device_write(struct file *filep, const char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	struct vfio_device *device = filep->private_data;
> +
> +	return device->ops->write(device->device_data, buf, count, ppos);
> +}
> +
> +static int vfio_device_mmap(struct file *filep, struct vm_area_struct *vma)
> +{
> +	struct vfio_device *device = filep->private_data;
> +
> +	return device->ops->mmap(device->device_data, vma);
> +}
> +	
> +#ifdef CONFIG_COMPAT
> +static long vfio_device_compat_ioctl(struct file *filep,
> +				     unsigned int cmd, unsigned long arg)
> +{
> +	arg = (unsigned long)compat_ptr(arg);
> +	return vfio_device_unl_ioctl(filep, cmd, arg);
> +}
> +#endif	/* CONFIG_COMPAT */
> +
> +const struct file_operations vfio_device_fops = {
> +	.owner		= THIS_MODULE,
> +	.release	= vfio_device_release,
> +	.read		= vfio_device_read,
> +	.write		= vfio_device_write,
> +	.unlocked_ioctl	= vfio_device_unl_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= vfio_device_compat_ioctl,
> +#endif
> +	.mmap		= vfio_device_mmap,
> +};
> +
> +/*
> + * Group fops
> + */
> +static int vfio_group_open(struct inode *inode, struct file *filep)
> +{
> +	struct vfio_group *group;
> +	int ret = 0;
> +
> +	mutex_lock(&vfio.lock);
> +
> +	group = idr_find(&vfio.idr, iminor(inode));
> +
> +	if (!group) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	filep->private_data = group;
> +
> +	if (!group->iommu) {
> +		struct vfio_iommu *iommu;
> +
> +		iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
> +		if (!iommu) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		INIT_LIST_HEAD(&iommu->group_list);
> +		INIT_LIST_HEAD(&iommu->dm_list);
> +		mutex_init(&iommu->dgate);
> +		iommu->bus = group->bus;
> +		__vfio_group_set_iommu(group, iommu);
> +	}
> +	group->refcnt++;
> +
> +out:
> +	mutex_unlock(&vfio.lock);
> +
> +	return ret;
> +}
> +
> +static int vfio_group_release(struct inode *inode, struct file *filep)
> +{
> +	struct vfio_group *group = filep->private_data;
> +
> +	return vfio_do_release(&group->refcnt, group->iommu);
> +}
> +
> +/* Attempt to merge the group pointed to by fd into group.  The merge-ee
> + * group must not have an iommu or any devices open because we cannot
> + * maintain that context across the merge.  The merge-er group can be
> + * in use. */

Yeah, so merge-er group in use still has its problems, because it
could affect what the IOMMU is capable of.

> +static int vfio_group_merge(struct vfio_group *group, int fd)
> +{
> +	struct vfio_group *new;
> +	struct vfio_iommu *old_iommu;
> +	struct file *file;
> +	int ret = 0;
> +	bool opened = false;
> +
> +	mutex_lock(&vfio.lock);
> +
> +	file = fget(fd);
> +	if (!file) {
> +		ret = -EBADF;
> +		goto out_noput;
> +	}
> +
> +	/* Sanity check, is this really our fd? */
> +	if (file->f_op != &vfio_group_fops) {

This should be a WARN_ON or BUG_ON rather than just an error return, surely.

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	new = file->private_data;
> +
> +	if (!new || new == group || !new->iommu ||
> +	    new->iommu->domain || new->bus != group->bus) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* We need to attach all the devices to each domain separately
> +	 * in order to validate that the capabilities match for both.  */
> +	ret = __vfio_open_iommu(new->iommu);
> +	if (ret)
> +		goto out;
> +
> +	if (!group->iommu->domain) {
> +		ret = __vfio_open_iommu(group->iommu);
> +		if (ret)
> +			goto out;
> +		opened = true;
> +	}
> +
> +	/* If cache coherency doesn't match we'd potentialy need to
> +	 * remap existing iommu mappings in the merge-er domain.
> +	 * Poor return to bother trying to allow this currently. */
> +	if (iommu_domain_has_cap(group->iommu->domain,
> +				 IOMMU_CAP_CACHE_COHERENCY) !=
> +	    iommu_domain_has_cap(new->iommu->domain,
> +				 IOMMU_CAP_CACHE_COHERENCY)) {
> +		__vfio_close_iommu(new->iommu);
> +		if (opened)
> +			__vfio_close_iommu(group->iommu);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Close the iommu for the merge-ee and attach all its devices
> +	 * to the merge-er iommu. */
> +	__vfio_close_iommu(new->iommu);
> +
> +	ret = __vfio_iommu_attach_group(group->iommu, new);
> +	if (ret)
> +		goto out;
> +
> +	/* set_iommu unlinks new from the iommu, so save a pointer to it */
> +	old_iommu = new->iommu;
> +	__vfio_group_set_iommu(new, group->iommu);
> +	kfree(old_iommu);
> +
> +out:
> +	fput(file);
> +out_noput:
> +	mutex_unlock(&vfio.lock);
> +	return ret;
> +}
> +
> +/* Unmerge the group pointed to by fd from group. */
> +static int vfio_group_unmerge(struct vfio_group *group, int fd)
> +{
> +	struct vfio_group *new;
> +	struct vfio_iommu *new_iommu;
> +	struct file *file;
> +	int ret = 0;
> +
> +	/* Since the merge-out group is already opened, it needs to
> +	 * have an iommu struct associated with it. */
> +	new_iommu = kzalloc(sizeof(*new_iommu), GFP_KERNEL);
> +	if (!new_iommu)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&new_iommu->group_list);
> +	INIT_LIST_HEAD(&new_iommu->dm_list);
> +	mutex_init(&new_iommu->dgate);
> +	new_iommu->bus = group->bus;
> +
> +	mutex_lock(&vfio.lock);
> +
> +	file = fget(fd);
> +	if (!file) {
> +		ret = -EBADF;
> +		goto out_noput;
> +	}
> +
> +	/* Sanity check, is this really our fd? */
> +	if (file->f_op != &vfio_group_fops) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	new = file->private_data;
> +	if (!new || new == group || new->iommu != group->iommu) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* We can't merge-out a group with devices still in use. */
> +	if (__vfio_group_devs_inuse(new)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	__vfio_iommu_detach_group(group->iommu, new);
> +	__vfio_group_set_iommu(new, new_iommu);
> +
> +out:
> +	fput(file);
> +out_noput:
> +	if (ret)
> +		kfree(new_iommu);
> +	mutex_unlock(&vfio.lock);
> +	return ret;
> +}
> +
> +/* Get a new iommu file descriptor.  This will open the iommu, setting
> + * the current->mm ownership if it's not already set. */

I know I've had this explained to me several times before, but I've
forgotten again.  Why do we need to wire the iommu to an mm?

> +static int vfio_group_get_iommu_fd(struct vfio_group *group)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&vfio.lock);
> +
> +	if (!group->iommu->domain) {
> +		ret = __vfio_open_iommu(group->iommu);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret = anon_inode_getfd("[vfio-iommu]", &vfio_iommu_fops,
> +			       group->iommu, O_RDWR);
> +	if (ret < 0)
> +		goto out;
> +
> +	group->iommu->refcnt++;
> +out:
> +	mutex_unlock(&vfio.lock);
> +	return ret;
> +}
> +
> +/* Get a new device file descriptor.  This will open the iommu, setting
> + * the current->mm ownership if it's not already set.  It's difficult to
> + * specify the requirements for matching a user supplied buffer to a
> + * device, so we use a vfio driver callback to test for a match.  For
> + * PCI, dev_name(dev) is unique, but other drivers may require including
> + * a parent device string. */

At some point we probably want an interface to enumerate the devices
too, but that can probably wait.

> +static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
> +{
> +	struct vfio_iommu *iommu = group->iommu;
> +	struct list_head *gpos;
> +	int ret = -ENODEV;
> +
> +	mutex_lock(&vfio.lock);
> +
> +	if (!iommu->domain) {
> +		ret = __vfio_open_iommu(iommu);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	list_for_each(gpos, &iommu->group_list) {
> +		struct list_head *dpos;
> +
> +		group = list_entry(gpos, struct vfio_group, iommu_next);
> +
> +		list_for_each(dpos, &group->device_list) {
> +			struct vfio_device *device;
> +
> +			device = list_entry(dpos,
> +					    struct vfio_device, device_next);
> +
> +			if (device->ops->match(device->dev, buf)) {
> +				struct file *file;
> +
> +				if (device->ops->get(device->device_data)) {
> +					ret = -EFAULT;
> +					goto out;
> +				}
> +
> +				/* We can't use anon_inode_getfd(), like above
> +				 * because we need to modify the f_mode flags
> +				 * directly to allow more than just ioctls */
> +				ret = get_unused_fd();
> +				if (ret < 0) {
> +					device->ops->put(device->device_data);
> +					goto out;
> +				}
> +
> +				file = anon_inode_getfile("[vfio-device]",
> +							  &vfio_device_fops,
> +							  device, O_RDWR);
> +				if (IS_ERR(file)) {
> +					put_unused_fd(ret);
> +					ret = PTR_ERR(file);
> +					device->ops->put(device->device_data);
> +					goto out;
> +				}
> +
> +				/* Todo: add an anon_inode interface to do
> +				 * this.  Appears to be missing by lack of
> +				 * need rather than explicitly prevented.
> +				 * Now there's need. */
> +				file->f_mode |= (FMODE_LSEEK |
> +						 FMODE_PREAD |
> +						 FMODE_PWRITE);
> +
> +				fd_install(ret, file);
> +
> +				device->refcnt++;
> +				goto out;
> +			}
> +		}
> +	}
> +out:
> +	mutex_unlock(&vfio.lock);
> +	return ret;
> +}
> +
> +static long vfio_group_unl_ioctl(struct file *filep,
> +				 unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_group *group = filep->private_data;
> +
> +	if (cmd == VFIO_GROUP_GET_FLAGS) {
> +		u64 flags = 0;
> +
> +		mutex_lock(&vfio.lock);
> +		if (__vfio_iommu_viable(group->iommu))
> +			flags |= VFIO_GROUP_FLAGS_VIABLE;
> +		mutex_unlock(&vfio.lock);
> +
> +		if (group->iommu->mm)
> +			flags |= VFIO_GROUP_FLAGS_MM_LOCKED;
> +
> +		return put_user(flags, (u64 __user *)arg);
> +	}
> +		
> +	/* Below commands are restricted once the mm is set */
> +	if (group->iommu->mm && group->iommu->mm != current->mm)
> +		return -EPERM;
> +
> +	if (cmd == VFIO_GROUP_MERGE || cmd == VFIO_GROUP_UNMERGE) {
> +		int fd;
> +		
> +		if (get_user(fd, (int __user *)arg))
> +			return -EFAULT;
> +		if (fd < 0)
> +			return -EINVAL;
> +
> +		if (cmd == VFIO_GROUP_MERGE)
> +			return vfio_group_merge(group, fd);
> +		else
> +			return vfio_group_unmerge(group, fd);
> +	} else if (cmd == VFIO_GROUP_GET_IOMMU_FD) {
> +		return vfio_group_get_iommu_fd(group);
> +	} else if (cmd == VFIO_GROUP_GET_DEVICE_FD) {
> +		char *buf;
> +		int ret;
> +
> +		buf = strndup_user((const char __user *)arg, PAGE_SIZE);
> +		if (IS_ERR(buf))
> +			return PTR_ERR(buf);
> +
> +		ret = vfio_group_get_device_fd(group, buf);
> +		kfree(buf);
> +		return ret;
> +	}
> +
> +	return -ENOSYS;
> +}
> +
> +#ifdef CONFIG_COMPAT
> +static long vfio_group_compat_ioctl(struct file *filep,
> +				    unsigned int cmd, unsigned long arg)
> +{
> +	arg = (unsigned long)compat_ptr(arg);
> +	return vfio_group_unl_ioctl(filep, cmd, arg);
> +}
> +#endif	/* CONFIG_COMPAT */
> +
> +static const struct file_operations vfio_group_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= vfio_group_open,
> +	.release	= vfio_group_release,
> +	.unlocked_ioctl	= vfio_group_unl_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= vfio_group_compat_ioctl,
> +#endif
> +};
> +
> +/* iommu fd release hook */
> +int vfio_release_iommu(struct vfio_iommu *iommu)
> +{
> +	return vfio_do_release(&iommu->refcnt, iommu);
> +}
> +
> +/*
> + * VFIO driver API
> + */
> +
> +/* Add a new device to the vfio framework with associated vfio driver
> + * callbacks.  This is the entry point for vfio drivers to register devices. */
> +int vfio_group_add_dev(struct device *dev, const struct vfio_device_ops *ops)
> +{
> +	struct list_head *pos;
> +	struct vfio_group *group = NULL;
> +	struct vfio_device *device = NULL;
> +	unsigned int groupid;
> +	int ret = 0;
> +	bool new_group = false;
> +
> +	if (!ops)
> +		return -EINVAL;
> +
> +	if (iommu_device_group(dev, &groupid))
> +		return -ENODEV;
> +
> +	mutex_lock(&vfio.lock);
> +
> +	list_for_each(pos, &vfio.group_list) {
> +		group = list_entry(pos, struct vfio_group, group_next);
> +		if (group->groupid == groupid)
> +			break;
> +		group = NULL;
> +	}
> +
> +	if (!group) {
> +		int minor;
> +
> +		if (unlikely(idr_pre_get(&vfio.idr, GFP_KERNEL) == 0)) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		group = kzalloc(sizeof(*group), GFP_KERNEL);
> +		if (!group) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		group->groupid = groupid;
> +		INIT_LIST_HEAD(&group->device_list);
> +
> +		ret = idr_get_new(&vfio.idr, group, &minor);
> +		if (ret == 0 && minor > MINORMASK) {
> +			idr_remove(&vfio.idr, minor);
> +			kfree(group);
> +			ret = -ENOSPC;
> +			goto out;
> +		}
> +
> +		group->devt = MKDEV(MAJOR(vfio.devt), minor);
> +		device_create(vfio.class, NULL, group->devt,
> +			      group, "%u", groupid);
> +
> +		group->bus = dev->bus;
> +		list_add(&group->group_next, &vfio.group_list);
> +		new_group = true;
> +	} else {
> +		if (group->bus != dev->bus) {
> +			printk(KERN_WARNING
> +			       "Error: IOMMU group ID conflict.  Group ID %u "
> +				"on both bus %s and %s\n", groupid,
> +				group->bus->name, dev->bus->name);
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		list_for_each(pos, &group->device_list) {
> +			device = list_entry(pos,
> +					    struct vfio_device, device_next);
> +			if (device->dev == dev)
> +				break;
> +			device = NULL;
> +		}
> +	}
> +
> +	if (!device) {
> +		if (__vfio_group_devs_inuse(group) ||
> +		    (group->iommu && group->iommu->refcnt)) {
> +			printk(KERN_WARNING
> +			       "Adding device %s to group %u while group is already in use!!\n",
> +			       dev_name(dev), group->groupid);
> +			/* XXX How to prevent other drivers from claiming? */
> +		}
> +
> +		device = kzalloc(sizeof(*device), GFP_KERNEL);
> +		if (!device) {
> +			/* If we just created this group, tear it down */
> +			if (new_group) {
> +				list_del(&group->group_next);
> +				device_destroy(vfio.class, group->devt);
> +				idr_remove(&vfio.idr, MINOR(group->devt));
> +				kfree(group);
> +			}
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		list_add(&device->device_next, &group->device_list);
> +		device->dev = dev;
> +		device->ops = ops;
> +		device->iommu = group->iommu; /* NULL if new */
> +		__vfio_iommu_attach_dev(group->iommu, device);
> +	}
> +out:
> +	mutex_unlock(&vfio.lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vfio_group_add_dev);
> +
> +/* Remove a device from the vfio framework */
> +void vfio_group_del_dev(struct device *dev)
> +{
> +	struct list_head *pos;
> +	struct vfio_group *group = NULL;
> +	struct vfio_device *device = NULL;
> +	unsigned int groupid;
> +
> +	if (iommu_device_group(dev, &groupid))
> +		return;
> +
> +	mutex_lock(&vfio.lock);
> +
> +	list_for_each(pos, &vfio.group_list) {
> +		group = list_entry(pos, struct vfio_group, group_next);
> +		if (group->groupid == groupid)
> +			break;
> +		group = NULL;
> +	}
> +
> +	if (!group)
> +		goto out;
> +
> +	list_for_each(pos, &group->device_list) {
> +		device = list_entry(pos, struct vfio_device, device_next);
> +		if (device->dev == dev)
> +			break;
> +		device = NULL;
> +	}
> +
> +	if (!device)
> +		goto out;
> +
> +	BUG_ON(device->refcnt);
> +
> +	if (device->attached)
> +		__vfio_iommu_detach_dev(group->iommu, device);
> +
> +	list_del(&device->device_next);
> +	kfree(device);
> +
> +	/* If this was the only device in the group, remove the group.
> +	 * Note that we intentionally unmerge empty groups here if the
> +	 * group fd isn't opened. */
> +	if (list_empty(&group->device_list) && group->refcnt == 0) {
> +		struct vfio_iommu *iommu = group->iommu;
> +
> +		if (iommu) {
> +			__vfio_group_set_iommu(group, NULL);
> +			__vfio_try_dissolve_iommu(iommu);
> +		}
> +
> +		device_destroy(vfio.class, group->devt);
> +		idr_remove(&vfio.idr, MINOR(group->devt));
> +		list_del(&group->group_next);
> +		kfree(group);
> +	}
> +out:
> +	mutex_unlock(&vfio.lock);
> +}
> +EXPORT_SYMBOL_GPL(vfio_group_del_dev);
> +
> +/* When a device is bound to a vfio device driver (ex. vfio-pci), this
> + * entry point is used to mark the device usable (viable).  The vfio
> + * device driver associates a private device_data struct with the device
> + * here, which will later be return for vfio_device_fops callbacks. */
> +int vfio_bind_dev(struct device *dev, void *device_data)
> +{
> +	struct vfio_device *device;
> +	int ret = -EINVAL;
> +
> +	BUG_ON(!device_data);
> +
> +	mutex_lock(&vfio.lock);
> +
> +	device = __vfio_lookup_dev(dev);
> +
> +	BUG_ON(!device);
> +
> +	ret = dev_set_drvdata(dev, device);
> +	if (!ret)
> +		device->device_data = device_data;
> +
> +	mutex_unlock(&vfio.lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vfio_bind_dev);
> +
> +/* A device is only removeable if the iommu for the group is not in use. */
> +static bool vfio_device_removeable(struct vfio_device *device)
> +{
> +	bool ret = true;
> +
> +	mutex_lock(&vfio.lock);
> +
> +	if (device->iommu && __vfio_iommu_inuse(device->iommu))
> +		ret = false;
> +
> +	mutex_unlock(&vfio.lock);
> +	return ret;
> +}
> +
> +/* Notify vfio that a device is being unbound from the vfio device driver
> + * and return the device private device_data pointer.  If the group is
> + * in use, we need to block or take other measures to make it safe for
> + * the device to be removed from the iommu. */
> +void *vfio_unbind_dev(struct device *dev)
> +{
> +	struct vfio_device *device = dev_get_drvdata(dev);
> +	void *device_data;
> +
> +	BUG_ON(!device);
> +
> +again:
> +	if (!vfio_device_removeable(device)) {
> +		/* XXX signal for all devices in group to be removed or
> +		 * resort to killing the process holding the device fds.
> +		 * For now just block waiting for releases to wake us. */
> +		wait_event(vfio.release_q, vfio_device_removeable(device));
> +	}
> +
> +	mutex_lock(&vfio.lock);
> +
> +	/* Need to re-check that the device is still removeable under lock. */
> +	if (device->iommu && __vfio_iommu_inuse(device->iommu)) {
> +		mutex_unlock(&vfio.lock);
> +		goto again;
> +	}
> +
> +	device_data = device->device_data;
> +
> +	device->device_data = NULL;
> +	dev_set_drvdata(dev, NULL);
> +
> +	mutex_unlock(&vfio.lock);
> +	return device_data;
> +}
> +EXPORT_SYMBOL_GPL(vfio_unbind_dev);
> +
> +/*
> + * Module/class support
> + */
> +static void vfio_class_release(struct kref *kref)
> +{
> +	class_destroy(vfio.class);
> +	vfio.class = NULL;
> +}
> +
> +static char *vfio_devnode(struct device *dev, mode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "vfio/%s", dev_name(dev));
> +}
> +
> +static int __init vfio_init(void)
> +{
> +	int ret;
> +
> +	idr_init(&vfio.idr);
> +	mutex_init(&vfio.lock);
> +	INIT_LIST_HEAD(&vfio.group_list);
> +	init_waitqueue_head(&vfio.release_q);
> +
> +	kref_init(&vfio.kref);
> +	vfio.class = class_create(THIS_MODULE, "vfio");
> +	if (IS_ERR(vfio.class)) {
> +		ret = PTR_ERR(vfio.class);
> +		goto err_class;
> +	}
> +
> +	vfio.class->devnode = vfio_devnode;
> +
> +	/* FIXME - how many minors to allocate... all of them! */
> +	ret = alloc_chrdev_region(&vfio.devt, 0, MINORMASK, "vfio");
> +	if (ret)
> +		goto err_chrdev;
> +
> +	cdev_init(&vfio.cdev, &vfio_group_fops);
> +	ret = cdev_add(&vfio.cdev, vfio.devt, MINORMASK);
> +	if (ret)
> +		goto err_cdev;
> +
> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> +
> +	return 0;
> +
> +err_cdev:
> +	unregister_chrdev_region(vfio.devt, MINORMASK);
> +err_chrdev:
> +	kref_put(&vfio.kref, vfio_class_release);
> +err_class:
> +	return ret;
> +}
> +
> +static void __exit vfio_cleanup(void)
> +{
> +	struct list_head *gpos, *gppos;
> +
> +	list_for_each_safe(gpos, gppos, &vfio.group_list) {
> +		struct vfio_group *group;
> +		struct list_head *dpos, *dppos;
> +
> +		group = list_entry(gpos, struct vfio_group, group_next);
> +
> +		list_for_each_safe(dpos, dppos, &group->device_list) {
> +			struct vfio_device *device;
> +
> +			device = list_entry(dpos,
> +					    struct vfio_device, device_next);
> +			vfio_group_del_dev(device->dev);
> +		}
> +	}
> +
> +	idr_destroy(&vfio.idr);
> +	cdev_del(&vfio.cdev);
> +	unregister_chrdev_region(vfio.devt, MINORMASK);
> +	kref_put(&vfio.kref, vfio_class_release);
> +}
> +
> +module_init(vfio_init);
> +module_exit(vfio_cleanup);
> +
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/drivers/vfio/vfio_private.h b/drivers/vfio/vfio_private.h
> new file mode 100644
> index 0000000..350ad67
> --- /dev/null
> +++ b/drivers/vfio/vfio_private.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (C) 2011 Red Hat, Inc.  All rights reserved.
> + *     Author: Alex Williamson <alex.williamson@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Derived from original vfio:
> + * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
> + * Author: Tom Lyon, pugs@cisco.com
> + */
> +
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +
> +#ifndef VFIO_PRIVATE_H
> +#define VFIO_PRIVATE_H
> +
> +struct vfio_iommu {
> +	struct iommu_domain		*domain;
> +	struct bus_type			*bus;
> +	struct mutex			dgate;
> +	struct list_head		dm_list;
> +	struct mm_struct		*mm;
> +	struct list_head		group_list;
> +	int				refcnt;
> +	bool				cache;
> +};
> +
> +extern int vfio_release_iommu(struct vfio_iommu *iommu);
> +extern void vfio_iommu_unmapall(struct vfio_iommu *iommu);
> +
> +#endif /* VFIO_PRIVATE_H */
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> new file mode 100644
> index 0000000..4269b08
> --- /dev/null
> +++ b/include/linux/vfio.h
> @@ -0,0 +1,155 @@
> +/*
> + * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
> + * Author: Tom Lyon, pugs@cisco.com
> + *
> + * This program is free software; you may redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + * Portions derived from drivers/uio/uio.c:
> + * Copyright(C) 2005, Benedikt Spranger <b.spranger@linutronix.de>
> + * Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
> + * Copyright(C) 2006, Hans J. Koch <hjk@linutronix.de>
> + * Copyright(C) 2006, Greg Kroah-Hartman <greg@kroah.com>
> + *
> + * Portions derived from drivers/uio/uio_pci_generic.c:
> + * Copyright (C) 2009 Red Hat, Inc.
> + * Author: Michael S. Tsirkin <mst@redhat.com>
> + */
> +#include <linux/types.h>
> +
> +#ifndef VFIO_H
> +#define VFIO_H
> +
> +#ifdef __KERNEL__
> +
> +struct vfio_device_ops {
> +	bool			(*match)(struct device *, char *);
> +	int			(*get)(void *);
> +	void			(*put)(void *);
> +	ssize_t			(*read)(void *, char __user *,
> +					size_t, loff_t *);
> +	ssize_t			(*write)(void *, const char __user *,
> +					 size_t, loff_t *);
> +	long			(*ioctl)(void *, unsigned int, unsigned long);
> +	int			(*mmap)(void *, struct vm_area_struct *);
> +};
> +
> +extern int vfio_group_add_dev(struct device *device,
> +			      const struct vfio_device_ops *ops);
> +extern void vfio_group_del_dev(struct device *device);
> +extern int vfio_bind_dev(struct device *device, void *device_data);
> +extern void *vfio_unbind_dev(struct device *device);
> +
> +#endif /* __KERNEL__ */
> +
> +/*
> + * VFIO driver - allow mapping and use of certain devices
> + * in unprivileged user processes. (If IOMMU is present)
> + * Especially useful for Virtual Function parts of SR-IOV devices
> + */
> +
> +
> +/* Kernel & User level defines for ioctls */
> +
> +#define VFIO_GROUP_GET_FLAGS		_IOR(';', 100, __u64)
> + #define VFIO_GROUP_FLAGS_VIABLE	(1 << 0)
> + #define VFIO_GROUP_FLAGS_MM_LOCKED	(1 << 1)
> +#define VFIO_GROUP_MERGE		_IOW(';', 101, int)
> +#define VFIO_GROUP_UNMERGE		_IOW(';', 102, int)
> +#define VFIO_GROUP_GET_IOMMU_FD		_IO(';', 103)
> +#define VFIO_GROUP_GET_DEVICE_FD	_IOW(';', 104, char *)
> +
> +/*
> + * Structure for DMA mapping of user buffers
> + * vaddr, dmaaddr, and size must all be page aligned
> + */
> +struct vfio_dma_map {
> +	__u64	len;		/* length of structure */
> +	__u64	vaddr;		/* process virtual addr */
> +	__u64	dmaaddr;	/* desired and/or returned dma address */
> +	__u64	size;		/* size in bytes */
> +	__u64	flags;
> +#define	VFIO_DMA_MAP_FLAG_WRITE		(1 << 0) /* req writeable DMA mem */
> +};
> +
> +#define	VFIO_IOMMU_GET_FLAGS		_IOR(';', 105, __u64)
> + /* Does the IOMMU support mapping any IOVA to any virtual address? */
> + #define VFIO_IOMMU_FLAGS_MAP_ANY	(1 << 0)
> +#define	VFIO_IOMMU_MAP_DMA		_IOWR(';', 106, struct vfio_dma_map)
> +#define	VFIO_IOMMU_UNMAP_DMA		_IOWR(';', 107, struct vfio_dma_map)
> +
> +#define VFIO_DEVICE_GET_FLAGS		_IOR(';', 108, __u64)
> + #define VFIO_DEVICE_FLAGS_PCI		(1 << 0)
> + #define VFIO_DEVICE_FLAGS_DT		(1 << 1)
> + #define VFIO_DEVICE_FLAGS_RESET	(1 << 2)
> +#define VFIO_DEVICE_GET_NUM_REGIONS	_IOR(';', 109, int)
> +
> +struct vfio_region_info {
> +	__u32	len;		/* length of structure */
> +	__u32	index;		/* region number */
> +	__u64	size;		/* size in bytes of region */
> +	__u64	offset;		/* start offset of region */
> +	__u64	flags;
> +#define VFIO_REGION_INFO_FLAG_MMAP		(1 << 0)
> +#define VFIO_REGION_INFO_FLAG_RO		(1 << 1)
> +#define VFIO_REGION_INFO_FLAG_PHYS_VALID	(1 << 2)
> +	__u64	phys;		/* physical address of region */
> +};
> +
> +#define VFIO_DEVICE_GET_REGION_INFO	_IOWR(';', 110, struct vfio_region_info)
> +
> +#define VFIO_DEVICE_GET_NUM_IRQS	_IOR(';', 111, int)
> +
> +struct vfio_irq_info {
> +	__u32	len;		/* length of structure */
> +	__u32	index;		/* IRQ number */
> +	__u32	count;		/* number of individual IRQs */
> +	__u32	flags;
> +#define VFIO_IRQ_INFO_FLAG_LEVEL		(1 << 0)
> +};
> +
> +#define VFIO_DEVICE_GET_IRQ_INFO	_IOWR(';', 112, struct vfio_irq_info)
> +
> +/* Set IRQ eventfds, arg[0] = index, arg[1] = count, arg[2-n] = eventfds */
> +#define VFIO_DEVICE_SET_IRQ_EVENTFDS	_IOW(';', 113, int)
> +
> +/* Unmask IRQ index, arg[0] = index */
> +#define VFIO_DEVICE_UNMASK_IRQ		_IOW(';', 114, int)
> +
> +/* Set unmask eventfd, arg[0] = index, arg[1] = eventfd */
> +#define VFIO_DEVICE_SET_UNMASK_IRQ_EVENTFD	_IOW(';', 115, int)
> +
> +#define VFIO_DEVICE_RESET		_IO(';', 116)
> +
> +struct vfio_dtpath {
> +	__u32	len;		/* length of structure */
> +	__u32	index;
> +	__u64	flags;
> +#define VFIO_DTPATH_FLAGS_REGION	(1 << 0)
> +#define VFIO_DTPATH_FLAGS_IRQ		(1 << 1)
> +	char	*path;
> +};
> +#define VFIO_DEVICE_GET_DTPATH		_IOWR(';', 117, struct vfio_dtpath)
> +
> +struct vfio_dtindex {
> +	__u32	len;		/* length of structure */
> +	__u32	index;
> +	__u32	prop_type;
> +	__u32	prop_index;
> +	__u64	flags;
> +#define VFIO_DTINDEX_FLAGS_REGION	(1 << 0)
> +#define VFIO_DTINDEX_FLAGS_IRQ		(1 << 1)
> +};
> +#define VFIO_DEVICE_GET_DTINDEX		_IOWR(';', 118, struct vfio_dtindex)
> +
> +#endif /* VFIO_H */
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

