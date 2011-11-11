Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21760 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105Ab1KKWLd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Nov 2011 17:11:33 -0500
Message-ID: <1321049456.2682.220.camel@bling.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	dwg@au1.ibm.com, joerg.roedel@amd.com, agraf@suse.de,
	benve@cisco.com, aafabbri@cisco.com, B08248@freescale.com,
	B07421@freescale.com, avi@redhat.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Date: Fri, 11 Nov 2011 15:10:56 -0700
In-Reply-To: <20111111175118.GA6946@phenom.dumpdata.com>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <20111111175118.GA6946@phenom.dumpdata.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Thanks Konrad!  Comments inline.

On Fri, 2011-11-11 at 12:51 -0500, Konrad Rzeszutek Wilk wrote:
> On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
> > VFIO provides a secure, IOMMU based interface for user space
> > drivers, including device assignment to virtual machines.
> > This provides the base management of IOMMU groups, devices,
> > and IOMMU objects.  See Documentation/vfio.txt included in
> > this patch for user and kernel API description.
> > 
> > Note, this implements the new API discussed at KVM Forum
> > 2011, as represented by the drvier version 0.2.  It's hoped
> > that this provides a modular enough interface to support PCI
> > and non-PCI userspace drivers across various architectures
> > and IOMMU implementations.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> > 
> > Fingers crossed, this is the last RFC for VFIO, but we need
> > the iommu group support before this can go upstream
> > (http://lkml.indiana.edu/hypermail/linux/kernel/1110.2/02303.html),
> > hoping this helps push that along.
> > 
> > Since the last posting, this version completely modularizes
> > the device backends and better defines the APIs between the
> > core VFIO code and the device backends.  I expect that we
> > might also adopt a modular IOMMU interface as iommu_ops learns
> > about different types of hardware.  Also many, many cleanups.
> > Check the complete git history for details:
> > 
> > git://github.com/awilliam/linux-vfio.git vfio-ng
> > 
> > (matching qemu tree: git://github.com/awilliam/qemu-vfio.git)
> > 
> > This version, along with the supporting VFIO PCI backend can
> > be found here:
> > 
> > git://github.com/awilliam/linux-vfio.git vfio-next-20111103
> > 
> > I've held off on implementing a kernel->user signaling
> > mechanism for now since the previous netlink version produced
> > too many gag reflexes.  It's easy enough to set a bit in the
> > group flags too indicate such support in the future, so I
> > think we can move ahead without it.
> > 
> > Appreciate any feedback or suggestions.  Thanks,
> > 
> > Alex
> > 
> >  Documentation/ioctl/ioctl-number.txt |    1 
> >  Documentation/vfio.txt               |  304 +++++++++
> >  MAINTAINERS                          |    8 
> >  drivers/Kconfig                      |    2 
> >  drivers/Makefile                     |    1 
> >  drivers/vfio/Kconfig                 |    8 
> >  drivers/vfio/Makefile                |    3 
> >  drivers/vfio/vfio_iommu.c            |  530 ++++++++++++++++
> >  drivers/vfio/vfio_main.c             | 1151 ++++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_private.h          |   34 +
> >  include/linux/vfio.h                 |  155 +++++
> >  11 files changed, 2197 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/vfio.txt
> >  create mode 100644 drivers/vfio/Kconfig
> >  create mode 100644 drivers/vfio/Makefile
> >  create mode 100644 drivers/vfio/vfio_iommu.c
> >  create mode 100644 drivers/vfio/vfio_main.c
> >  create mode 100644 drivers/vfio/vfio_private.h
> >  create mode 100644 include/linux/vfio.h
> > 
> > diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> > index 54078ed..59d01e4 100644
> > --- a/Documentation/ioctl/ioctl-number.txt
> > +++ b/Documentation/ioctl/ioctl-number.txt
> > @@ -88,6 +88,7 @@ Code  Seq#(hex)	Include File		Comments
> >  		and kernel/power/user.c
> >  '8'	all				SNP8023 advanced NIC card
> >  					<mailto:mcr@solidum.com>
> > +';'	64-76	linux/vfio.h
> >  '@'	00-0F	linux/radeonfb.h	conflict!
> >  '@'	00-0F	drivers/video/aty/aty128fb.c	conflict!
> >  'A'	00-1F	linux/apm_bios.h	conflict!
> > diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> > new file mode 100644
> > index 0000000..5866896
> > --- /dev/null
> > +++ b/Documentation/vfio.txt
> > @@ -0,0 +1,304 @@
> > +VFIO - "Virtual Function I/O"[1]
> > +-------------------------------------------------------------------------------
> > +Many modern system now provide DMA and interrupt remapping facilities
> > +to help ensure I/O devices behave within the boundaries they've been
> > +allotted.  This includes x86 hardware with AMD-Vi and Intel VT-d as
> > +well as POWER systems with Partitionable Endpoints (PEs) and even
> > +embedded powerpc systems (technology name unknown).  The VFIO driver
> > +is an IOMMU/device agnostic framework for exposing direct device
> > +access to userspace, in a secure, IOMMU protected environment.  In
> > +other words, this allows safe, non-privileged, userspace drivers.
> > +
> > +Why do we want that?  Virtual machines often make use of direct device
> > +access ("device assignment") when configured for the highest possible
> > +I/O performance.  From a device and host perspective, this simply turns
> > +the VM into a userspace driver, with the benefits of significantly
> > +reduced latency, higher bandwidth, and direct use of bare-metal device
> > +drivers[2].
> 
> Are there any constraints of running a 32-bit userspace with
> a 64-bit kernel and with 32-bit user space drivers?

Shouldn't be.  I'll need to do some testing on that, but it was working
on the previous generation of vfio.

> > +
> > +Some applications, particularly in the high performance computing
> > +field, also benefit from low-overhead, direct device access from
> > +userspace.  Examples include network adapters (often non-TCP/IP based)
> > +and compute accelerators.  Previous to VFIO, these drivers needed to
> > +go through the full development cycle to become proper upstream driver,
> > +be maintained out of tree, or make use of the UIO framework, which
> > +has no notion of IOMMU protection, limited interrupt support, and
> > +requires root privileges to access things like PCI configuration space.
> > +
> > +The VFIO driver framework intends to unify these, replacing both the
> > +KVM PCI specific device assignment currently used as well as provide
> > +a more secure, more featureful userspace driver environment than UIO.
> > +
> > +Groups, Devices, IOMMUs, oh my
> 
> <chuckles> oh my, eh?

Anything for a corny chuckle :)

> > +-------------------------------------------------------------------------------
> > +
> > +A fundamental component of VFIO is the notion of IOMMU groups.  IOMMUs
> > +can't always distinguish transactions from each individual device in
> > +the system.  Sometimes this is because of the IOMMU design, such as with
> > +PEs, other times it's caused by the I/O topology, for instance a
> > +PCIe-to-PCI bridge masking all devices behind it.  We call the sets of
> > +devices created by these restictions IOMMU groups (or just "groups" for
> > +this document).
> > +
> > +The IOMMU cannot distiguish transactions between the individual devices
> > +within the group, therefore the group is the basic unit of ownership for
> > +a userspace process.  Because of this, groups are also the primary
> > +interface to both devices and IOMMU domains in VFIO.
> > +
> > +The VFIO representation of groups is created as devices are added into
> > +the framework by a VFIO bus driver.  The vfio-pci module is an example
> > +of a bus driver.  This module registers devices along with a set of bus
> > +specific callbacks with the VFIO core.  These callbacks provide the
> > +interfaces later used for device access.  As each new group is created,
> > +as determined by iommu_device_group(), VFIO creates a /dev/vfio/$GROUP
> > +character device.
> > +
> > +In addition to the device enumeration and callbacks, the VFIO bus driver
> > +also provides a traditional device driver and is able to bind to devices
> > +on it's bus.  When a device is bound to the bus driver it's available to
> > +VFIO.  When all the devices within a group are bound to their bus drivers,
> > +the group becomes "viable" and a user with sufficient access to the VFIO
> > +group chardev can obtain exclusive access to the set of group devices.
> > +
> > +As documented in linux/vfio.h, several ioctls are provided on the
> > +group chardev:
> > +
> > +#define VFIO_GROUP_GET_FLAGS            _IOR(';', 100, __u64)
> > + #define VFIO_GROUP_FLAGS_VIABLE        (1 << 0)
> > + #define VFIO_GROUP_FLAGS_MM_LOCKED     (1 << 1)
> > +#define VFIO_GROUP_MERGE                _IOW(';', 101, int)
> > +#define VFIO_GROUP_UNMERGE              _IOW(';', 102, int)
> > +#define VFIO_GROUP_GET_IOMMU_FD         _IO(';', 103)
> > +#define VFIO_GROUP_GET_DEVICE_FD        _IOW(';', 104, char *)
> > +
> > +The last two ioctls return new file descriptors for accessing
> > +individual devices within the group and programming the IOMMU.  Each of
> > +these new file descriptors provide their own set of file interfaces.
> > +These ioctls will fail if any of the devices within the group are not
> > +bound to their VFIO bus driver.  Additionally, when either of these
> > +interfaces are used, the group is then bound to the struct_mm of the
> > +caller.  The GET_FLAGS ioctl can be used to view the state of the group.
> > +
> > +When either the GET_IOMMU_FD or GET_DEVICE_FD ioctls are invoked, a
> > +new IOMMU domain is created and all of the devices in the group are
> > +attached to it.  This is the only way to ensure full IOMMU isolation
> > +of the group, but potentially wastes resources and cycles if the user
> > +intends to manage multiple groups with the same set of IOMMU mappings.
> > +VFIO therefore provides a group MERGE and UNMERGE interface, which
> > +allows multiple groups to share an IOMMU domain.  Not all IOMMUs allow
> > +arbitrary groups to be merged, so the user should assume merging is
> > +opportunistic.  A new group, with no open device or IOMMU file
> > +descriptors, can be merged into an existing, in-use, group using the
> > +MERGE ioctl.  A merged group can be unmerged using the UNMERGE ioctl
> > +once all of the device file descriptors for the group being merged
> > +"out" are closed.
> > +
> > +When groups are merged, the GET_IOMMU_FD and GET_DEVICE_FD ioctls are
> > +essentially fungible between group file descriptors (ie. if device A
> > +is in group X, and X is merged with Y, a file descriptor for A can be
> > +retrieved using GET_DEVICE_FD on Y.  Likewise, GET_IOMMU_FD returns a
> > +file descriptor referencing the same internal IOMMU object from either
> > +X or Y).  Merged groups can be dissolved either explictly with UNMERGE
> > +or automatically when ALL file descriptors for the merged group are
> > +closed (all IOMMUs, all devices, all groups).
> > +
> > +The IOMMU file descriptor provides this set of ioctls:
> > +
> > +#define VFIO_IOMMU_GET_FLAGS            _IOR(';', 105, __u64)
> > + #define VFIO_IOMMU_FLAGS_MAP_ANY       (1 << 0)
> > +#define VFIO_IOMMU_MAP_DMA              _IOWR(';', 106, struct vfio_dma_map)
> > +#define VFIO_IOMMU_UNMAP_DMA            _IOWR(';', 107, struct vfio_dma_map)
> 
> Coherency support is not going to be addressed right? What about sync?
> Say you need to sync CPU to Device address?

Do we need to expose that to userspace or should the underlying
iommu_ops take care of it?

> > +
> > +The GET_FLAGS ioctl returns basic information about the IOMMU domain.
> > +We currently only support IOMMU domains that are able to map any
> > +virtual address to any IOVA.  This is indicated by the MAP_ANY flag.
> > +
> > +The (UN)MAP_DMA commands make use of struct vfio_dma_map for mapping
> > +and unmapping IOVAs to process virtual addresses:
> > +
> > +struct vfio_dma_map {
> > +        __u64   len;            /* length of structure */
> 
> What is the purpose of the 'len' field? Is it to guard against future
> version changes?

Yes, David Gibson suggested we include flags & len for all data
structures to help future proof them.

> > +        __u64   vaddr;          /* process virtual addr */
> > +        __u64   dmaaddr;        /* desired and/or returned dma address */
> > +        __u64   size;           /* size in bytes */
> > +        __u64   flags;
> > +#define VFIO_DMA_MAP_FLAG_WRITE         (1 << 0) /* req writeable DMA mem */
> > +};
> > +
> > +Current users of VFIO use relatively static DMA mappings, not requiring
> > +high frequency turnover.  As new users are added, it's expected that the
> 
> Is there a limit to how many DMA mappings can be created?

Not that I'm aware of for the current AMD-Vi/VT-d implementations.  I
suppose iommu_ops would return -ENOSPC if it hit a limit.  I added the
VFIO_IOMMU_FLAGS_MAP_ANY flag above to try to identify that kind of
restriction.

> > +IOMMU file descriptor will evolve to support new mapping interfaces, this
> > +will be reflected in the flags and may present new ioctls and file
> > +interfaces.
> > +
> > +The device GET_FLAGS ioctl is intended to return basic device type and
> > +indicate support for optional capabilities.  Flags currently include whether
> > +the device is PCI or described by Device Tree, and whether the RESET ioctl
> > +is supported:
> 
> And reset in terms of PCIe spec is the FLR?

Yes, just a pass through to pci_reset_function() for the pci vfio bus
driver.

> > +
> > +#define VFIO_DEVICE_GET_FLAGS           _IOR(';', 108, __u64)
> > + #define VFIO_DEVICE_FLAGS_PCI          (1 << 0)
> > + #define VFIO_DEVICE_FLAGS_DT           (1 << 1)
> > + #define VFIO_DEVICE_FLAGS_RESET        (1 << 2)
> > +
> > +The MMIO and IOP resources used by a device are described by regions.
> 
> IOP?

I/O port, I'll spell it out.

> > +The GET_NUM_REGIONS ioctl tells us how many regions the device supports:
> > +
> > +#define VFIO_DEVICE_GET_NUM_REGIONS     _IOR(';', 109, int)
> 
> Don't want __u32?

It could be, not sure if it buys us anything maybe even restricts us.
We likely don't need 2^32 regions (famous last words?), so we could
later define <0 to something?

> > +
> > +Regions are described by a struct vfio_region_info, which is retrieved by
> > +using the GET_REGION_INFO ioctl with vfio_region_info.index field set to
> > +the desired region (0 based index).  Note that devices may implement zero
> > 
> +sized regions (vfio-pci does this to provide a 1:1 BAR to region index
> > +mapping).
> 
> Huh?

PCI has the following static mapping:

enum {
        VFIO_PCI_BAR0_REGION_INDEX,
        VFIO_PCI_BAR1_REGION_INDEX,
        VFIO_PCI_BAR2_REGION_INDEX,
        VFIO_PCI_BAR3_REGION_INDEX,
        VFIO_PCI_BAR4_REGION_INDEX,
        VFIO_PCI_BAR5_REGION_INDEX,
        VFIO_PCI_ROM_REGION_INDEX,
        VFIO_PCI_CONFIG_REGION_INDEX,
        VFIO_PCI_NUM_REGIONS
};

So 8 regions are always reported regardless of whether the device
implements all the BARs and the ROM.  Then we have a fixed bar:index
mapping so we don't have to create a region_info field to describe the
bar number for the index.

> > +
> > +struct vfio_region_info {
> > +        __u32   len;            /* length of structure */
> > +        __u32   index;          /* region number */
> > +        __u64   size;           /* size in bytes of region */
> > +        __u64   offset;         /* start offset of region */
> > +        __u64   flags;
> > +#define VFIO_REGION_INFO_FLAG_MMAP              (1 << 0)
> > +#define VFIO_REGION_INFO_FLAG_RO                (1 << 1)
> > +#define VFIO_REGION_INFO_FLAG_PHYS_VALID        (1 << 2)
> 
> What is FLAG_MMAP? Does it mean: 1) it can be mmaped, or 2) it is mmaped?

Supports mmap

> FLAG_RO is pretty obvious - presumarily this is for firmware regions and such.
> And PHYS_VALID is if the region is disabled for some reasons? If so
> would the name FLAG_DISABLED be better?

No, POWER guys have some need to report the host physical address of the
region, so the flag indicates whether the below field is present and
valid.  I'll clarify these in the docs.

> 
> > +        __u64   phys;           /* physical address of region */
> > +};
> > +
> > +#define VFIO_DEVICE_GET_REGION_INFO     _IOWR(';', 110, struct vfio_region_info)
> > +
> > +The offset indicates the offset into the device file descriptor which
> > +accesses the given range (for read/write/mmap/seek).  Flags indicate the
> > +available access types and validity of optional fields.  For instance
> > +the phys field may only be valid for certain devices types.
> > +
> > +Interrupts are described using a similar interface.  GET_NUM_IRQS
> > +reports the number or IRQ indexes for the device.
> > +
> > +#define VFIO_DEVICE_GET_NUM_IRQS        _IOR(';', 111, int)
> 
> _u32?

Same as above, but I don't have a strong preference.

> > +
> > +struct vfio_irq_info {
> > +        __u32   len;            /* length of structure */
> > +        __u32   index;          /* IRQ number */
> > +        __u32   count;          /* number of individual IRQs */
> > +        __u64   flags;
> > +#define VFIO_IRQ_INFO_FLAG_LEVEL                (1 << 0)
> > +};
> > +
> > +Again, zero count entries are allowed (vfio-pci uses a static interrupt
> > +type to index mapping).
> 
> I am not really sure what that means.

This is so PCI can expose:

enum {
        VFIO_PCI_INTX_IRQ_INDEX,
        VFIO_PCI_MSI_IRQ_INDEX,
        VFIO_PCI_MSIX_IRQ_INDEX,
        VFIO_PCI_NUM_IRQS
};

So like regions it always exposes 3 IRQ indexes where count=0 if the
device doesn't actually support that type of interrupt.  I just want to
spell out that bus drivers have this kind of flexibility.

> > +
> > +Information about each index can be retrieved using the GET_IRQ_INFO
> > +ioctl, used much like GET_REGION_INFO.
> > +
> > +#define VFIO_DEVICE_GET_IRQ_INFO        _IOWR(';', 112, struct vfio_irq_info)
> > +
> > +Individual indexes can describe single or sets of IRQs.  This provides the
> > +flexibility to describe PCI INTx, MSI, and MSI-X using a single interface.
> > +
> > +All VFIO interrupts are signaled to userspace via eventfds.  Integer arrays,
> > +as shown below, are used to pass the IRQ info index, the number of eventfds,
> > +and each eventfd to be signaled.  Using a count of 0 disables the interrupt.
> > +
> > +/* Set IRQ eventfds, arg[0] = index, arg[1] = count, arg[2-n] = eventfds */
> 
> Are eventfds u64 or u32?

int, they're just file descriptors

> Why not just define a structure?
> struct vfio_irq_eventfds {
> 	__u32	index;
> 	__u32	count;
> 	__u64	eventfds[0]
> };

We could do that if preferred.  Hmm, are we then going to need
size/flags?

> How do you get an eventfd to feed in here?

eventfd(2), in qemu event_notifier_init() -> event_notifier_get_fd()

> > +#define VFIO_DEVICE_SET_IRQ_EVENTFDS    _IOW(';', 113, int)
> 
> u32?

Not here, it's an fd, so should be an int.

> > +
> > +When a level triggered interrupt is signaled, the interrupt is masked
> > +on the host.  This prevents an unresponsive userspace driver from
> > +continuing to interrupt the host system.  After servicing the interrupt,
> > +UNMASK_IRQ is used to allow the interrupt to retrigger.  Note that level
> > +triggered interrupts implicitly have a count of 1 per index.
> 
> So they are enabled automatically? Meaning you don't even hav to do
> SET_IRQ_EVENTFDS b/c the count is set to 1?

I suppose that should be "no more than 1 per index" (ie. PCI would
report a count of 0 for VFIO_PCI_INTX_IRQ_INDEX if the device doesn't
support INTx).  I think you might be confusing VFIO_DEVICE_GET_IRQ_INFO
which tells how many are available with VFIO_DEVICE_SET_IRQ_EVENTFDS
which does the enabling/disabling.  All interrupts are disabled by
default because userspace needs to give us a way to signal them via
eventfds.  It will be device dependent whether multiple index can be
enabled simultaneously.  Hmm, is that another flag on the irq_info
struct or do we expect drivers to implicitly have that kind of
knowledge?

> > +
> > +/* Unmask IRQ index, arg[0] = index */
> > +#define VFIO_DEVICE_UNMASK_IRQ          _IOW(';', 114, int)
> 
> So this is for MSI as well? So if I've an index = 1, with count = 4,
> and doing unmaks IRQ will chip enable all the MSI event at once?

No, this is only for re-enabling level triggered interrupts as discussed
above.  Edge triggered interrupts like MSI don't need an unmask... we
may want to do something to accelerate the MSI-X table access for
masking specific interrupts, but I figured that would need to be PCI
aware since those are PCI features, and would therefore be some future
extension of the PCI bus driver and exposed via VFIO_DEVICE_GET_FLAGS.

> I guess there is not much point in enabling/disabling selective MSI
> IRQs..

Some older OSes are said to make extensive use of masking for MSI, so we
probably want this at some point.  I'm assuming future PCI extension for
now.

> > +
> > +Level triggered interrupts can also be unmasked using an irqfd.  Use
> 
> irqfd or eventfd?

irqfd is an eventfd in reverse.  eventfd = kernel signals userspace via
an fd, irqfd = userspace signals kernel via an fd.

> > +SET_UNMASK_IRQ_EVENTFD to set the file descriptor for this.
> 
> So only level triggered? Hmm, how do I know whether the device is
> level or edge? Or is that edge (MSI) can also be unmaked using the
> eventfs

Yes, only for level.  Isn't a device going to know what type of
interrupt it uses?  MSI masking is PCI specific, not handled by this.

> > +
> > +/* Set unmask eventfd, arg[0] = index, arg[1] = eventfd */
> > +#define VFIO_DEVICE_SET_UNMASK_IRQ_EVENTFD      _IOW(';', 115, int)
> > +
> > +When supported, as indicated by the device flags, reset the device.
> > +
> > +#define VFIO_DEVICE_RESET               _IO(';', 116)
> 
> Does it disable the 'count'? Err, does it disable the IRQ on the
> device after this and one should call VFIO_DEVICE_SET_IRQ_EVENTFDS
> to set new eventfds? Or does it re-use the eventfds and the device
> is enabled after this?

It doesn't affect the interrupt programming.  Should it?

> > +
> > +Device tree devices also invlude ioctls for further defining the
> 
> include
> 
> > +device tree properties of the device:
> > +
> > +struct vfio_dtpath {
> > +        __u32   len;            /* length of structure */
> > +        __u32   index;
> 
> 0 based I presume?

Everything else is, I would assume so/

> > +        __u64   flags;
> > +#define VFIO_DTPATH_FLAGS_REGION        (1 << 0)
> 
> What is region in this context?? Or would this make much more sense
> if I knew what Device Tree actually is.

Powerpc guys, any comments?  This was their suggestion.  These are
effectively the first device specific extension, available when
VFIO_DEVICE_FLAGS_DT is set.

> > +#define VFIO_DTPATH_FLAGS_IRQ           (1 << 1)
> > +        char    *path;
> 
> Ah, now I see why you want 'len' here.. But I am still at loss
> why you want that with the other structures.

Attempt to future proof and validate input.

> > +};
> > +#define VFIO_DEVICE_GET_DTPATH          _IOWR(';', 117, struct vfio_dtpath)
> > +
> > +struct vfio_dtindex {
> > +        __u32   len;            /* length of structure */
> > +        __u32   index;
> > +        __u32   prop_type;
> 
> Is that an enum type? Is this definied somewhere?
> > +        __u32   prop_index;
> 
> What is the purpose of this field?

Need input from powerpc folks here

> > +        __u64   flags;
> > +#define VFIO_DTINDEX_FLAGS_REGION       (1 << 0)
> > +#define VFIO_DTINDEX_FLAGS_IRQ          (1 << 1)
> > +};
> > +#define VFIO_DEVICE_GET_DTINDEX         _IOWR(';', 118, struct vfio_dtindex)
> > +
> > +
> > +VFIO bus driver API
> > +-------------------------------------------------------------------------------
> > +
> > +Bus drivers, such as PCI, have three jobs:
> > + 1) Add/remove devices from vfio
> > + 2) Provide vfio_device_ops for device access
> > + 3) Device binding and unbinding
> 
> suspend/resume?

In the previous version of vfio, the vfio core signaled suspend/resume
to userspace via netlink, effectively putting userspace on the pm
notifier chain.  I was intending to do the same here.

> > +
> > +When initialized, the bus driver should enumerate the devices on it's
> > +bus and call vfio_group_add_dev() for each device.  If the bus supports
> > +hotplug, notifiers should be enabled to track devices being added and
> > +removed.  vfio_group_del_dev() removes a previously added device from
> > +vfio.
> > +
> > +Adding a device registers a vfio_device_ops function pointer structure
> > +for the device:
> 
> Huh? So this gets created for _every_ 'struct device' that is added
> the VFIO bus? Is this structure exposed? Or is this an internal one?

Every device added creates a struct vfio_device and if necessary a
struct vfio_group.  These are internal, just for managing groups and
devices.

> > +
> > +struct vfio_device_ops {
> > +	bool			(*match)(struct device *, char *);
> > +	int			(*get)(void *);
> > +	void			(*put)(void *);
> > +	ssize_t			(*read)(void *, char __user *,
> > +					size_t, loff_t *);
> > +	ssize_t			(*write)(void *, const char __user *,
> > +					 size_t, loff_t *);
> > +	long			(*ioctl)(void *, unsigned int, unsigned long);
> > +	int			(*mmap)(void *, struct vm_area_struct *);
> > +};
> > +
> > +When a device is bound to the bus driver, the bus driver indicates this
> > +to vfio using the vfio_bind_dev() interface.  The device_data parameter
> 
> Might want to paste the function decleration for it.. b/c I am not sure
> where the 'device_data' parameter is on the argument list.

Ok

> > +is a pointer to an opaque data structure for use only by the bus driver.
> > +The get, put, read, write, ioctl, and mmap vfio_device_ops all pass
> > +this data structure back to the bus driver.  When a device is unbound
> 
> Oh, so it is on the 'void *'.

Right

> > +from the bus driver, the vfio_unbind_dev() interface signals this to
> > +vfio.  This function returns the pointer to the device_data structure
> 
> That function
> > +registered for the device.
> 
> I am not really sure what this section purpose is? Could this be part
> of the header file or the code? It does not look to be part of the
> ioctl API?

We've passed into the "VFIO bus driver API" section of the document, to
explain the interaction between vfio-core and vfio bus drivers.

> > +
> > +As noted previously, a group contains one or more devices, so
> > +GROUP_GET_DEVICE_FD needs to identify the specific device being requested.
> > +The vfio_device_ops.match callback is used to allow bus drivers to determine
> > +the match.  For drivers like vfio-pci, it's a simple match to dev_name(),
> > +which is unique in the system due to the PCI bus topology, other bus drivers
> > +may need to include parent devices to create a unique match, so this is
> > +left as a bus driver interface.
> > +
> > +-------------------------------------------------------------------------------
> > +
> > +[1] VFIO was originally an acronym for "Virtual Function I/O" in it's
> > +initial implementation by Tom Lyon while as Cisco.  We've since outgrown
> > +the acronym, but it's catchy.
> > +
> > +[2] As always there are trade-offs to virtual machine device
> > +assignment that are beyond the scope of VFIO.  It's expected that
> > +future IOMMU technologies will reduce some, but maybe not all, of
> > +these trade-offs.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f05f5f6..4bd5aa0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7106,6 +7106,14 @@ S:	Maintained
> >  F:	Documentation/filesystems/vfat.txt
> >  F:	fs/fat/
> >  
> > +VFIO DRIVER
> > +M:	Alex Williamson <alex.williamson@redhat.com>
> > +L:	kvm@vger.kernel.org
> 
> No vfio mailing list? Or a vfio-mailing list? 

IIRC, Avi had agreed that we could use kvm for now.  I don't know that
vfio will warrant it's own list.  If it picks up, sure, we can move it.

> > +S:	Maintained
> > +F:	Documentation/vfio.txt
> > +F:	drivers/vfio/
> > +F:	include/linux/vfio.h
> > +
> >  VIDEOBUF2 FRAMEWORK
> >  M:	Pawel Osciak <pawel@osciak.com>
> >  M:	Marek Szyprowski <m.szyprowski@samsung.com>
> > diff --git a/drivers/Kconfig b/drivers/Kconfig
> > index b5e6f24..e15578b 100644
> > --- a/drivers/Kconfig
> > +++ b/drivers/Kconfig
> > @@ -112,6 +112,8 @@ source "drivers/auxdisplay/Kconfig"
> >  
> >  source "drivers/uio/Kconfig"
> >  
> > +source "drivers/vfio/Kconfig"
> > +
> >  source "drivers/vlynq/Kconfig"
> >  
> >  source "drivers/virtio/Kconfig"
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 1b31421..5f138b5 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -58,6 +58,7 @@ obj-$(CONFIG_ATM)		+= atm/
> >  obj-$(CONFIG_FUSION)		+= message/
> >  obj-y				+= firewire/
> >  obj-$(CONFIG_UIO)		+= uio/
> > +obj-$(CONFIG_VFIO)		+= vfio/
> >  obj-y				+= cdrom/
> >  obj-y				+= auxdisplay/
> >  obj-$(CONFIG_PCCARD)		+= pcmcia/
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > new file mode 100644
> > index 0000000..9acb1e7
> > --- /dev/null
> > +++ b/drivers/vfio/Kconfig
> > @@ -0,0 +1,8 @@
> > +menuconfig VFIO
> > +	tristate "VFIO Non-Privileged userspace driver framework"
> > +	depends on IOMMU_API
> > +	help
> > +	  VFIO provides a framework for secure userspace device drivers.
> > +	  See Documentation/vfio.txt for more details.
> > +
> > +	  If you don't know what to do here, say N.
> > diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> > new file mode 100644
> > index 0000000..088faf1
> > --- /dev/null
> > +++ b/drivers/vfio/Makefile
> > @@ -0,0 +1,3 @@
> > +vfio-y := vfio_main.o vfio_iommu.o
> > +
> > +obj-$(CONFIG_VFIO) := vfio.o
> > diff --git a/drivers/vfio/vfio_iommu.c b/drivers/vfio/vfio_iommu.c
> > new file mode 100644
> > index 0000000..029dae3
> > --- /dev/null
> > +++ b/drivers/vfio/vfio_iommu.c
> > @@ -0,0 +1,530 @@
> > +/*
> > + * VFIO: IOMMU DMA mapping support
> > + *
> > + * Copyright (C) 2011 Red Hat, Inc.  All rights reserved.
> > + *     Author: Alex Williamson <alex.williamson@redhat.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Derived from original vfio:
> > + * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
> > + * Author: Tom Lyon, pugs@cisco.com
> > + */
> > +
> > +#include <linux/compat.h>
> > +#include <linux/device.h>
> > +#include <linux/fs.h>
> > +#include <linux/iommu.h>
> > +#include <linux/module.h>
> > +#include <linux/mm.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/vfio.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include "vfio_private.h"
> > +
> > +struct dma_map_page {
> > +	struct list_head	list;
> > +	dma_addr_t		daddr;
> > +	unsigned long		vaddr;
> > +	int			npage;
> > +	int			rdwr;
> 
> rdwr? Is this a flag thing? Could it be made in an enum?

Or maybe better would just be a bool.

> > +};
> > +
> > +/*
> > + * This code handles mapping and unmapping of user data buffers
> > + * into DMA'ble space using the IOMMU
> > + */
> > +
> > +#define NPAGE_TO_SIZE(npage)	((size_t)(npage) << PAGE_SHIFT)
> > +
> > +struct vwork {
> > +	struct mm_struct	*mm;
> > +	int			npage;
> > +	struct work_struct	work;
> > +};
> > +
> > +/* delayed decrement for locked_vm */
> > +static void vfio_lock_acct_bg(struct work_struct *work)
> > +{
> > +	struct vwork *vwork = container_of(work, struct vwork, work);
> > +	struct mm_struct *mm;
> > +
> > +	mm = vwork->mm;
> > +	down_write(&mm->mmap_sem);
> > +	mm->locked_vm += vwork->npage;
> > +	up_write(&mm->mmap_sem);
> > +	mmput(mm);		/* unref mm */
> > +	kfree(vwork);
> > +}
> > +
> > +static void vfio_lock_acct(int npage)
> > +{
> > +	struct vwork *vwork;
> > +	struct mm_struct *mm;
> > +
> > +	if (!current->mm) {
> > +		/* process exited */
> > +		return;
> > +	}
> > +	if (down_write_trylock(&current->mm->mmap_sem)) {
> > +		current->mm->locked_vm += npage;
> > +		up_write(&current->mm->mmap_sem);
> > +		return;
> > +	}
> > +	/*
> > +	 * Couldn't get mmap_sem lock, so must setup to decrement
> > +	 * mm->locked_vm later. If locked_vm were atomic, we wouldn't
> > +	 * need this silliness
> > +	 */
> > +	vwork = kmalloc(sizeof(struct vwork), GFP_KERNEL);
> > +	if (!vwork)
> > +		return;
> > +	mm = get_task_mm(current);	/* take ref mm */
> > +	if (!mm) {
> > +		kfree(vwork);
> > +		return;
> > +	}
> > +	INIT_WORK(&vwork->work, vfio_lock_acct_bg);
> > +	vwork->mm = mm;
> > +	vwork->npage = npage;
> > +	schedule_work(&vwork->work);
> > +}
> > +
> > +/* Some mappings aren't backed by a struct page, for example an mmap'd
> > + * MMIO range for our own or another device.  These use a different
> > + * pfn conversion and shouldn't be tracked as locked pages. */
> > +static int is_invalid_reserved_pfn(unsigned long pfn)
> 
> static bool
> 
> > +{
> > +	if (pfn_valid(pfn)) {
> > +		int reserved;
> > +		struct page *tail = pfn_to_page(pfn);
> > +		struct page *head = compound_trans_head(tail);
> > +		reserved = PageReserved(head);
> 
> bool reserved = PageReserved(head);

Agree on both

> > +		if (head != tail) {
> > +			/* "head" is not a dangling pointer
> > +			 * (compound_trans_head takes care of that)
> > +			 * but the hugepage may have been split
> > +			 * from under us (and we may not hold a
> > +			 * reference count on the head page so it can
> > +			 * be reused before we run PageReferenced), so
> > +			 * we've to check PageTail before returning
> > +			 * what we just read.
> > +			 */
> > +			smp_rmb();
> > +			if (PageTail(tail))
> > +				return reserved;
> > +		}
> > +		return PageReserved(tail);
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static int put_pfn(unsigned long pfn, int rdwr)
> > +{
> > +	if (!is_invalid_reserved_pfn(pfn)) {
> > +		struct page *page = pfn_to_page(pfn);
> > +		if (rdwr)
> > +			SetPageDirty(page);
> > +		put_page(page);
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/* Unmap DMA region */
> > +/* dgate must be held */
> 
> dgate?

DMA gate, the mutex for iommu operations.  This a carry over from old
vfio.  As there's only one mutex on the struct vfio_iommu, I can just
rename that to "lock".

> > +static int __vfio_dma_unmap(struct vfio_iommu *iommu, unsigned long iova,
> > +			    int npage, int rdwr)
> > +{
> > +	int i, unlocked = 0;
> > +
> > +	for (i = 0; i < npage; i++, iova += PAGE_SIZE) {
> > +		unsigned long pfn;
> > +
> > +		pfn = iommu_iova_to_phys(iommu->domain, iova) >> PAGE_SHIFT;
> > +		if (pfn) {
> > +			iommu_unmap(iommu->domain, iova, 0);
> 
> What is the '0' for? Perhaps a comment: /* We only do zero order */

yep.  We'll need to improve this at some point to take advantage of
large iommu pages, but it shouldn't affect the API.  I'll add comment.

> > +			unlocked += put_pfn(pfn, rdwr);
> > +		}
> > +	}
> > +	return unlocked;
> > +}
> > +
> > +static void vfio_dma_unmap(struct vfio_iommu *iommu, unsigned long iova,
> > +			   unsigned long npage, int rdwr)
> > +{
> > +	int unlocked;
> > +
> > +	unlocked = __vfio_dma_unmap(iommu, iova, npage, rdwr);
> > +	vfio_lock_acct(-unlocked);
> > +}
> > +
> > +/* Unmap ALL DMA regions */
> > +void vfio_iommu_unmapall(struct vfio_iommu *iommu)
> > +{
> > +	struct list_head *pos, *pos2;
> 
> pos2 should probably be just called 'tmp'

ok

> > +	struct dma_map_page *mlp;
> 
> What does 'mlp' stand for?
> 
> mlp -> dma_page ?

Carry over from original code, I can guess, but not sure what Tom was
originally thinking.  I think everyone has asked so far, so I'll make a
pass at coming up with a names that I can explain.

> > +
> > +	mutex_lock(&iommu->dgate);
> > +	list_for_each_safe(pos, pos2, &iommu->dm_list) {
> > +		mlp = list_entry(pos, struct dma_map_page, list);
> > +		vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> 
> Uh, so if it did not get put_page() we would try to still delete it?
> Couldn't that lead to corruption as the 'mlp' is returned to the poll?
> 
> Ah wait, the put_page is on the DMA page, so it is OK to
> delete the tracking structure. It will be just a leaked page.

Assume you're referencing this chunk:

vfio_dma_unmap
  __vfio_dma_unmap
    ...
        pfn = iommu_iova_to_phys(iommu->domain, iova) >> PAGE_SHIFT;
        if (pfn) {
                iommu_unmap(iommu->domain, iova, 0);
                unlocked += put_pfn(pfn, rdwr);
        }

So we skip things that aren't mapped in the iommu, but anything not
mapped should have already been put (failed vfio_dma_map).  If it is
mapped, we put it if we originally got it via get_user_pages_fast.
unlocked would only not get incremented here if it was an mmap'd page
(such as the mmap of an mmio space of another vfio device), via the code
in vaddr_get_pfn (stolen from KVM).

> > +		list_del(&mlp->list);
> > +		kfree(mlp);
> > +	}
> > +	mutex_unlock(&iommu->dgate);
> > +}
> > +
> > +static int vaddr_get_pfn(unsigned long vaddr, int rdwr, unsigned long *pfn)
> > +{
> > +	struct page *page[1];
> > +	struct vm_area_struct *vma;
> > +	int ret = -EFAULT;
> > +
> > +	if (get_user_pages_fast(vaddr, 1, rdwr, page) == 1) {
> > +		*pfn = page_to_pfn(page[0]);
> > +		return 0;
> > +	}
> > +
> > +	down_read(&current->mm->mmap_sem);
> > +
> > +	vma = find_vma_intersection(current->mm, vaddr, vaddr + 1);
> > +
> > +	if (vma && vma->vm_flags & VM_PFNMAP) {
> > +		*pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
> > +		if (is_invalid_reserved_pfn(*pfn))
> > +			ret = 0;
> 
> Did you mean to break here?

We're in an if block, not a loop.

> > +	}
> > +
> > +	up_read(&current->mm->mmap_sem);
> > +
> > +	return ret;
> > +}
> > +
> > +/* Map DMA region */
> > +/* dgate must be held */
> > +static int vfio_dma_map(struct vfio_iommu *iommu, unsigned long iova,
> > +			unsigned long vaddr, int npage, int rdwr)
> > +{
> > +	unsigned long start = iova;
> > +	int i, ret, locked = 0, prot = IOMMU_READ;
> > +
> > +	/* Verify pages are not already mapped */
> 
> I think a 'that' is missing above.

Ok.

> > +	for (i = 0; i < npage; i++, iova += PAGE_SIZE)
> > +		if (iommu_iova_to_phys(iommu->domain, iova))
> > +			return -EBUSY;
> > +
> > +	iova = start;
> > +
> > +	if (rdwr)
> > +		prot |= IOMMU_WRITE;
> > +	if (iommu->cache)
> > +		prot |= IOMMU_CACHE;
> > +
> > +	for (i = 0; i < npage; i++, iova += PAGE_SIZE, vaddr += PAGE_SIZE) {
> > +		unsigned long pfn = 0;
> > +
> > +		ret = vaddr_get_pfn(vaddr, rdwr, &pfn);
> > +		if (ret) {
> > +			__vfio_dma_unmap(iommu, start, i, rdwr);
> > +			return ret;
> > +		}
> > +
> > +		/* Only add actual locked pages to accounting */
> > +		if (!is_invalid_reserved_pfn(pfn))
> > +			locked++;
> > +
> > +		ret = iommu_map(iommu->domain, iova,
> > +				(phys_addr_t)pfn << PAGE_SHIFT, 0, prot);
> 
> Put a comment by the 0 saying /* order 0 pages only! */

Yep

> > +		if (ret) {
> > +			/* Back out mappings on error */
> > +			put_pfn(pfn, rdwr);
> > +			__vfio_dma_unmap(iommu, start, i, rdwr);
> > +			return ret;
> > +		}
> > +	}
> > +	vfio_lock_acct(locked);
> > +	return 0;
> > +}
> > +
> > +static inline int ranges_overlap(unsigned long start1, size_t size1,
> 
> Perhaps a bool?

Sure

> > +				 unsigned long start2, size_t size2)
> > +{
> > +	return !(start1 + size1 <= start2 || start2 + size2 <= start1);
> > +}
> > +
> > +static struct dma_map_page *vfio_find_dma(struct vfio_iommu *iommu,
> > +					  dma_addr_t start, size_t size)
> > +{
> > +	struct list_head *pos;
> > +	struct dma_map_page *mlp;
> > +
> > +	list_for_each(pos, &iommu->dm_list) {
> > +		mlp = list_entry(pos, struct dma_map_page, list);
> > +		if (ranges_overlap(mlp->daddr, NPAGE_TO_SIZE(mlp->npage),
> > +				   start, size))
> > +			return mlp;
> > +	}
> > +	return NULL;
> > +}
> > +
> > +int vfio_remove_dma_overlap(struct vfio_iommu *iommu, dma_addr_t start,
> > +			    size_t size, struct dma_map_page *mlp)
> > +{
> > +	struct dma_map_page *split;
> > +	int npage_lo, npage_hi;
> > +
> > +	/* Existing dma region is completely covered, unmap all */
> > +	if (start <= mlp->daddr &&
> > +	    start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> > +		vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> > +		list_del(&mlp->list);
> > +		npage_lo = mlp->npage;
> > +		kfree(mlp);
> > +		return npage_lo;
> > +	}
> > +
> > +	/* Overlap low address of existing range */
> > +	if (start <= mlp->daddr) {
> > +		size_t overlap;
> > +
> > +		overlap = start + size - mlp->daddr;
> > +		npage_lo = overlap >> PAGE_SHIFT;
> > +		npage_hi = mlp->npage - npage_lo;
> > +
> > +		vfio_dma_unmap(iommu, mlp->daddr, npage_lo, mlp->rdwr);
> > +		mlp->daddr += overlap;
> > +		mlp->vaddr += overlap;
> > +		mlp->npage -= npage_lo;
> > +		return npage_lo;
> > +	}
> > +
> > +	/* Overlap high address of existing range */
> > +	if (start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> > +		size_t overlap;
> > +
> > +		overlap = mlp->daddr + NPAGE_TO_SIZE(mlp->npage) - start;
> > +		npage_hi = overlap >> PAGE_SHIFT;
> > +		npage_lo = mlp->npage - npage_hi;
> > +
> > +		vfio_dma_unmap(iommu, start, npage_hi, mlp->rdwr);
> > +		mlp->npage -= npage_hi;
> > +		return npage_hi;
> > +	}
> > +
> > +	/* Split existing */
> > +	npage_lo = (start - mlp->daddr) >> PAGE_SHIFT;
> > +	npage_hi = mlp->npage - (size >> PAGE_SHIFT) - npage_lo;
> > +
> > +	split = kzalloc(sizeof *split, GFP_KERNEL);
> > +	if (!split)
> > +		return -ENOMEM;
> > +
> > +	vfio_dma_unmap(iommu, start, size >> PAGE_SHIFT, mlp->rdwr);
> > +
> > +	mlp->npage = npage_lo;
> > +
> > +	split->npage = npage_hi;
> > +	split->daddr = start + size;
> > +	split->vaddr = mlp->vaddr + NPAGE_TO_SIZE(npage_lo) + size;
> > +	split->rdwr = mlp->rdwr;
> > +	list_add(&split->list, &iommu->dm_list);
> > +	return size >> PAGE_SHIFT;
> > +}
> > +
> > +int vfio_dma_unmap_dm(struct vfio_iommu *iommu, struct vfio_dma_map *dmp)
> > +{
> > +	int ret = 0;
> > +	size_t npage = dmp->size >> PAGE_SHIFT;
> > +	struct list_head *pos, *n;
> > +
> > +	if (dmp->dmaaddr & ~PAGE_MASK)
> > +		return -EINVAL;
> > +	if (dmp->size & ~PAGE_MASK)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&iommu->dgate);
> > +
> > +	list_for_each_safe(pos, n, &iommu->dm_list) {
> > +		struct dma_map_page *mlp;
> > +
> > +		mlp = list_entry(pos, struct dma_map_page, list);
> > +		if (ranges_overlap(mlp->daddr, NPAGE_TO_SIZE(mlp->npage),
> > +				   dmp->dmaaddr, dmp->size)) {
> > +			ret = vfio_remove_dma_overlap(iommu, dmp->dmaaddr,
> > +						      dmp->size, mlp);
> > +			if (ret > 0)
> > +				npage -= NPAGE_TO_SIZE(ret);
> > +			if (ret < 0 || npage == 0)
> > +				break;
> > +		}
> > +	}
> > +	mutex_unlock(&iommu->dgate);
> > +	return ret > 0 ? 0 : ret;
> > +}
> > +
> > +int vfio_dma_map_dm(struct vfio_iommu *iommu, struct vfio_dma_map *dmp)
> > +{
> > +	int npage;
> > +	struct dma_map_page *mlp, *mmlp = NULL;
> > +	dma_addr_t daddr = dmp->dmaaddr;
> > +	unsigned long locked, lock_limit, vaddr = dmp->vaddr;
> > +	size_t size = dmp->size;
> > +	int ret = 0, rdwr = dmp->flags & VFIO_DMA_MAP_FLAG_WRITE;
> > +
> > +	if (vaddr & (PAGE_SIZE-1))
> > +		return -EINVAL;
> > +	if (daddr & (PAGE_SIZE-1))
> > +		return -EINVAL;
> > +	if (size & (PAGE_SIZE-1))
> > +		return -EINVAL;
> > +
> > +	npage = size >> PAGE_SHIFT;
> > +	if (!npage)
> > +		return -EINVAL;
> > +
> > +	if (!iommu)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&iommu->dgate);
> > +
> > +	if (vfio_find_dma(iommu, daddr, size)) {
> > +		ret = -EBUSY;
> > +		goto out_lock;
> > +	}
> > +
> > +	/* account for locked pages */
> > +	locked = current->mm->locked_vm + npage;
> > +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> > +		printk(KERN_WARNING "%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
> > +			__func__, rlimit(RLIMIT_MEMLOCK));
> > +		ret = -ENOMEM;
> > +		goto out_lock;
> > +	}
> > +
> > +	ret = vfio_dma_map(iommu, daddr, vaddr, npage, rdwr);
> > +	if (ret)
> > +		goto out_lock;
> > +
> > +	/* Check if we abut a region below */
> > +	if (daddr) {
> > +		mlp = vfio_find_dma(iommu, daddr - 1, 1);
> > +		if (mlp && mlp->rdwr == rdwr &&
> > +		    mlp->vaddr + NPAGE_TO_SIZE(mlp->npage) == vaddr) {
> > +
> > +			mlp->npage += npage;
> > +			daddr = mlp->daddr;
> > +			vaddr = mlp->vaddr;
> > +			npage = mlp->npage;
> > +			size = NPAGE_TO_SIZE(npage);
> > +
> > +			mmlp = mlp;
> > +		}
> > +	}
> > +
> > +	if (daddr + size) {
> > +		mlp = vfio_find_dma(iommu, daddr + size, 1);
> > +		if (mlp && mlp->rdwr == rdwr && mlp->vaddr == vaddr + size) {
> > +
> > +			mlp->npage += npage;
> > +			mlp->daddr = daddr;
> > +			mlp->vaddr = vaddr;
> > +
> > +			/* If merged above and below, remove previously
> > +			 * merged entry.  New entry covers it.  */
> > +			if (mmlp) {
> > +				list_del(&mmlp->list);
> > +				kfree(mmlp);
> > +			}
> > +			mmlp = mlp;
> > +		}
> > +	}
> > +
> > +	if (!mmlp) {
> > +		mlp = kzalloc(sizeof *mlp, GFP_KERNEL);
> > +		if (!mlp) {
> > +			ret = -ENOMEM;
> > +			vfio_dma_unmap(iommu, daddr, npage, rdwr);
> > +			goto out_lock;
> > +		}
> > +
> > +		mlp->npage = npage;
> > +		mlp->daddr = daddr;
> > +		mlp->vaddr = vaddr;
> > +		mlp->rdwr = rdwr;
> > +		list_add(&mlp->list, &iommu->dm_list);
> > +	}
> > +
> > +out_lock:
> > +	mutex_unlock(&iommu->dgate);
> > +	return ret;
> > +}
> > +
> > +static int vfio_iommu_release(struct inode *inode, struct file *filep)
> > +{
> > +	struct vfio_iommu *iommu = filep->private_data;
> > +
> > +	vfio_release_iommu(iommu);
> > +	return 0;
> > +}
> > +
> > +static long vfio_iommu_unl_ioctl(struct file *filep,
> > +				 unsigned int cmd, unsigned long arg)
> > +{
> > +	struct vfio_iommu *iommu = filep->private_data;
> > +	int ret = -ENOSYS;
> > +
> > +        if (cmd == VFIO_IOMMU_GET_FLAGS) {
> 
> Something is weird with the tabbing here..

Indeed, the joys of switching between kernel and qemu ;)  fixed

> > +                u64 flags = VFIO_IOMMU_FLAGS_MAP_ANY;
> > +
> > +                ret = put_user(flags, (u64 __user *)arg);
> > +
> > +        } else if (cmd == VFIO_IOMMU_MAP_DMA) {
> > +		struct vfio_dma_map dm;
> > +
> > +		if (copy_from_user(&dm, (void __user *)arg, sizeof dm))
> > +			return -EFAULT;
> > +
> > +		ret = vfio_dma_map_dm(iommu, &dm);
> > +
> > +		if (!ret && copy_to_user((void __user *)arg, &dm, sizeof dm))
> > +			ret = -EFAULT;
> > +
> > +	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
> > +		struct vfio_dma_map dm;
> > +
> > +		if (copy_from_user(&dm, (void __user *)arg, sizeof dm))
> > +			return -EFAULT;
> > +
> > +		ret = vfio_dma_unmap_dm(iommu, &dm);
> > +
> > +		if (!ret && copy_to_user((void __user *)arg, &dm, sizeof dm))
> > +			ret = -EFAULT;
> > +	}
> > +	return ret;
> > +}
> > +
> > +#ifdef CONFIG_COMPAT
> > +static long vfio_iommu_compat_ioctl(struct file *filep,
> > +				    unsigned int cmd, unsigned long arg)
> > +{
> > +	arg = (unsigned long)compat_ptr(arg);
> > +	return vfio_iommu_unl_ioctl(filep, cmd, arg);
> > +}
> > +#endif	/* CONFIG_COMPAT */
> > +
> > +const struct file_operations vfio_iommu_fops = {
> > +	.owner		= THIS_MODULE,
> > +	.release	= vfio_iommu_release,
> > +	.unlocked_ioctl	= vfio_iommu_unl_ioctl,
> > +#ifdef CONFIG_COMPAT
> > +	.compat_ioctl	= vfio_iommu_compat_ioctl,
> > +#endif
> > +};
> > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > new file mode 100644
> > index 0000000..6169356
> > --- /dev/null
> > +++ b/drivers/vfio/vfio_main.c
> > @@ -0,0 +1,1151 @@
> > +/*
> > + * VFIO framework
> > + *
> > + * Copyright (C) 2011 Red Hat, Inc.  All rights reserved.
> > + *     Author: Alex Williamson <alex.williamson@redhat.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Derived from original vfio:
> > + * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
> > + * Author: Tom Lyon, pugs@cisco.com
> > + */
> > +
> > +#include <linux/cdev.h>
> > +#include <linux/compat.h>
> > +#include <linux/device.h>
> > +#include <linux/file.h>
> > +#include <linux/anon_inodes.h>
> > +#include <linux/fs.h>
> > +#include <linux/idr.h>
> > +#include <linux/iommu.h>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/vfio.h>
> > +#include <linux/wait.h>
> > +
> > +#include "vfio_private.h"
> > +
> > +#define DRIVER_VERSION	"0.2"
> > +#define DRIVER_AUTHOR	"Alex Williamson <alex.williamson@redhat.com>"
> > +#define DRIVER_DESC	"VFIO - User Level meta-driver"
> > +
> > +static int allow_unsafe_intrs;
> 
> __read_mostly

Ok

> > +module_param(allow_unsafe_intrs, int, 0);
> 
> S_IRUGO ?

I actually intended that to be S_IRUGO | S_IWUSR just like the kvm
parameter so it can be toggled runtime.

> > +MODULE_PARM_DESC(allow_unsafe_intrs,
> > +        "Allow use of IOMMUs which do not support interrupt remapping");
> > +
> > +static struct vfio {
> > +	dev_t			devt;
> > +	struct cdev		cdev;
> > +	struct list_head	group_list;
> > +	struct mutex		lock;
> > +	struct kref		kref;
> > +	struct class		*class;
> > +	struct idr		idr;
> > +	wait_queue_head_t	release_q;
> > +} vfio;
> 
> You probably want to move this below the 'vfio_group'
> as vfio contains the vfio_group.

Only via the group_list.  Are you suggesting for readability or to avoid
forward declarations (which we don't need between these two with current
ordering).

> > +
> > +static const struct file_operations vfio_group_fops;
> > +extern const struct file_operations vfio_iommu_fops;
> > +
> > +struct vfio_group {
> > +	dev_t			devt;
> > +	unsigned int		groupid;
> > +	struct bus_type		*bus;
> > +	struct vfio_iommu	*iommu;
> > +	struct list_head	device_list;
> > +	struct list_head	iommu_next;
> > +	struct list_head	group_next;
> > +	int			refcnt;
> > +};
> > +
> > +struct vfio_device {
> > +	struct device			*dev;
> > +	const struct vfio_device_ops	*ops;
> > +	struct vfio_iommu		*iommu;
> > +	struct vfio_group		*group;
> > +	struct list_head		device_next;
> > +	bool				attached;
> > +	int				refcnt;
> > +	void				*device_data;
> > +};
> 
> And perhaps move this above vfio_group. As vfio_group
> contains a list of these structures?

These are inter-linked, so chicken and egg.  The current ordering is
more function based than definition based.  struct vfio is the highest
level object, groups are next, iommus and devices are next, but we need
to share iommus with the other file, so that lands in the header.

> > +
> > +/*
> > + * Helper functions called under vfio.lock
> > + */
> > +
> > +/* Return true if any devices within a group are opened */
> > +static bool __vfio_group_devs_inuse(struct vfio_group *group)
> > +{
> > +	struct list_head *pos;
> > +
> > +	list_for_each(pos, &group->device_list) {
> > +		struct vfio_device *device;
> > +
> > +		device = list_entry(pos, struct vfio_device, device_next);
> > +		if (device->refcnt)
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +/* Return true if any of the groups attached to an iommu are opened.
> > + * We can only tear apart merged groups when nothing is left open. */
> > +static bool __vfio_iommu_groups_inuse(struct vfio_iommu *iommu)
> > +{
> > +	struct list_head *pos;
> > +
> > +	list_for_each(pos, &iommu->group_list) {
> > +		struct vfio_group *group;
> > +
> > +		group = list_entry(pos, struct vfio_group, iommu_next);
> > +		if (group->refcnt)
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +/* An iommu is "in use" if it has a file descriptor open or if any of
> > + * the groups assigned to the iommu have devices open. */
> > +static bool __vfio_iommu_inuse(struct vfio_iommu *iommu)
> > +{
> > +	struct list_head *pos;
> > +
> > +	if (iommu->refcnt)
> > +		return true;
> > +
> > +	list_for_each(pos, &iommu->group_list) {
> > +		struct vfio_group *group;
> > +
> > +		group = list_entry(pos, struct vfio_group, iommu_next);
> > +
> > +		if (__vfio_group_devs_inuse(group))
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +static void __vfio_group_set_iommu(struct vfio_group *group,
> > +				   struct vfio_iommu *iommu)
> > +{
> > +	struct list_head *pos;
> > +
> > +	if (group->iommu)
> > +		list_del(&group->iommu_next);
> > +	if (iommu)
> > +		list_add(&group->iommu_next, &iommu->group_list);
> > +
> > +	group->iommu = iommu;
> > +
> > +	list_for_each(pos, &group->device_list) {
> > +		struct vfio_device *device;
> > +
> > +		device = list_entry(pos, struct vfio_device, device_next);
> > +		device->iommu = iommu;
> > +	}
> > +}
> > +
> > +static void __vfio_iommu_detach_dev(struct vfio_iommu *iommu,
> > +				    struct vfio_device *device)
> > +{
> > +	BUG_ON(!iommu->domain && device->attached);
> 
> Whoa. Heavy hammer there.
> 
> Perhaps WARN_ON as you do check it later on.

I think it's warranted, internal consistency is broken if we have a
device that thinks it's attached to an iommu domain that doesn't exist.
It should, of course, never happen and this isn't a performance path.

> > +
> > +	if (!iommu->domain || !device->attached)
> > +		return;
> > +
> > +	iommu_detach_device(iommu->domain, device->dev);
> > +	device->attached = false;
> > +}
> > +
> > +static void __vfio_iommu_detach_group(struct vfio_iommu *iommu,
> > +				      struct vfio_group *group)
> > +{
> > +	struct list_head *pos;
> > +
> > +	list_for_each(pos, &group->device_list) {
> > +		struct vfio_device *device;
> > +
> > +		device = list_entry(pos, struct vfio_device, device_next);
> > +		__vfio_iommu_detach_dev(iommu, device);
> > +	}
> > +}
> > +
> > +static int __vfio_iommu_attach_dev(struct vfio_iommu *iommu,
> > +				   struct vfio_device *device)
> > +{
> > +	int ret;
> > +
> > +	BUG_ON(device->attached);
> 
> How about:
> 
> WARN_ON(device->attached, "The engineer who wrote the user-space device driver is trying to register
> the device again! Tell him/her to stop please.\n");

I would almost demote this one to a WARN_ON, but userspace isn't in
control of attaching and detaching devices from the iommu.  That's a
side effect of getting the iommu or device file descriptor.  So again,
this is an internal consistency check and it should never happen,
regardless of userspace.

> > +
> > +	if (!iommu || !iommu->domain)
> > +		return -EINVAL;
> > +
> > +	ret = iommu_attach_device(iommu->domain, device->dev);
> > +	if (!ret)
> > +		device->attached = true;
> > +
> > +	return ret;
> > +}
> > +
> > +static int __vfio_iommu_attach_group(struct vfio_iommu *iommu,
> > +				     struct vfio_group *group)
> > +{
> > +	struct list_head *pos;
> > +
> > +	list_for_each(pos, &group->device_list) {
> > +		struct vfio_device *device;
> > +		int ret;
> > +
> > +		device = list_entry(pos, struct vfio_device, device_next);
> > +		ret = __vfio_iommu_attach_dev(iommu, device);
> > +		if (ret) {
> > +			__vfio_iommu_detach_group(iommu, group);
> > +			return ret;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +/* The iommu is viable, ie. ready to be configured, when all the devices
> > + * for all the groups attached to the iommu are bound to their vfio device
> > + * drivers (ex. vfio-pci).  This sets the device_data private data pointer. */
> > +static bool __vfio_iommu_viable(struct vfio_iommu *iommu)
> > +{
> > +	struct list_head *gpos, *dpos;
> > +
> > +	list_for_each(gpos, &iommu->group_list) {
> > +		struct vfio_group *group;
> > +		group = list_entry(gpos, struct vfio_group, iommu_next);
> > +
> > +		list_for_each(dpos, &group->device_list) {
> > +			struct vfio_device *device;
> > +			device = list_entry(dpos,
> > +					    struct vfio_device, device_next);
> > +
> > +			if (!device->device_data)
> > +				return false;
> > +		}
> > +	}
> > +	return true;
> > +}
> > +
> > +static void __vfio_close_iommu(struct vfio_iommu *iommu)
> > +{
> > +	struct list_head *pos;
> > +
> > +	if (!iommu->domain)
> > +		return;
> > +
> > +	list_for_each(pos, &iommu->group_list) {
> > +		struct vfio_group *group;
> > +		group = list_entry(pos, struct vfio_group, iommu_next);
> > +
> > +		__vfio_iommu_detach_group(iommu, group);
> > +	}
> > +
> > +	vfio_iommu_unmapall(iommu);
> > +
> > +	iommu_domain_free(iommu->domain);
> > +	iommu->domain = NULL;
> > +	iommu->mm = NULL;
> > +}
> > +
> > +/* Open the IOMMU.  This gates all access to the iommu or device file
> > + * descriptors and sets current->mm as the exclusive user. */
> > +static int __vfio_open_iommu(struct vfio_iommu *iommu)
> > +{
> > +	struct list_head *pos;
> > +	int ret;
> > +
> > +	if (!__vfio_iommu_viable(iommu))
> > +		return -EBUSY;
> > +
> > +	if (iommu->domain)
> > +		return -EINVAL;
> > +
> > +	iommu->domain = iommu_domain_alloc(iommu->bus);
> > +	if (!iommu->domain)
> > +		return -EFAULT;
> 
> ENOMEM?

Yeah, probably more appropriate.

> > +
> > +	list_for_each(pos, &iommu->group_list) {
> > +		struct vfio_group *group;
> > +		group = list_entry(pos, struct vfio_group, iommu_next);
> > +
> > +		ret = __vfio_iommu_attach_group(iommu, group);
> > +		if (ret) {
> > +			__vfio_close_iommu(iommu);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (!allow_unsafe_intrs &&
> > +	    !iommu_domain_has_cap(iommu->domain, IOMMU_CAP_INTR_REMAP)) {
> > +		__vfio_close_iommu(iommu);
> > +		return -EFAULT;
> > +	}
> > +
> > +	iommu->cache = (iommu_domain_has_cap(iommu->domain,
> > +					     IOMMU_CAP_CACHE_COHERENCY) != 0);
> > +	iommu->mm = current->mm;
> > +
> > +	return 0;
> > +}
> > +
> > +/* Actively try to tear down the iommu and merged groups.  If there are no
> > + * open iommu or device fds, we close the iommu.  If we close the iommu and
> > + * there are also no open group fds, we can futher dissolve the group to
> > + * iommu association and free the iommu data structure. */
> > +static int __vfio_try_dissolve_iommu(struct vfio_iommu *iommu)
> > +{
> > +
> > +	if (__vfio_iommu_inuse(iommu))
> > +		return -EBUSY;
> > +
> > +	__vfio_close_iommu(iommu);
> > +
> > +	if (!__vfio_iommu_groups_inuse(iommu)) {
> > +		struct list_head *pos, *ppos;
> > +
> > +		list_for_each_safe(pos, ppos, &iommu->group_list) {
> > +			struct vfio_group *group;
> > +
> > +			group = list_entry(pos, struct vfio_group, iommu_next);
> > +			__vfio_group_set_iommu(group, NULL);
> > +		}
> > +
> > +
> > +		kfree(iommu);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct vfio_device *__vfio_lookup_dev(struct device *dev)
> > +{
> > +	struct list_head *gpos;
> > +	unsigned int groupid;
> > +
> > +	if (iommu_device_group(dev, &groupid))
> 
> Hmm, where is this defined? v3.2-rc1 does not seem to have it?

>From patch header:

        Fingers crossed, this is the last RFC for VFIO, but we need
        the iommu group support before this can go upstream
        (http://lkml.indiana.edu/hypermail/linux/kernel/1110.2/02303.html),
        hoping this helps push that along.

hat's the one bit keeping me from doing a non-RFC of the core, besides
fixing all these comments ;)

> > +		return NULL;
> > +
> > +	list_for_each(gpos, &vfio.group_list) {
> > +		struct vfio_group *group;
> > +		struct list_head *dpos;
> > +
> > +		group = list_entry(gpos, struct vfio_group, group_next);
> > +
> > +		if (group->groupid != groupid)
> > +			continue;
> > +
> > +		list_for_each(dpos, &group->device_list) {
> > +			struct vfio_device *device;
> > +
> > +			device = list_entry(dpos,
> > +					    struct vfio_device, device_next);
> > +
> > +			if (device->dev == dev)
> > +				return device;
> > +		}
> > +	}
> > +	return NULL;
> > +}
> > +
> > +/* All release paths simply decrement the refcnt, attempt to teardown
> > + * the iommu and merged groups, and wakeup anything that might be
> > + * waiting if we successfully dissolve anything. */
> > +static int vfio_do_release(int *refcnt, struct vfio_iommu *iommu)
> > +{
> > +	bool wake;
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	(*refcnt)--;
> > +	wake = (__vfio_try_dissolve_iommu(iommu) == 0);
> > +
> > +	mutex_unlock(&vfio.lock);
> > +
> > +	if (wake)
> > +		wake_up(&vfio.release_q);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Device fops - passthrough to vfio device driver w/ device_data
> > + */
> > +static int vfio_device_release(struct inode *inode, struct file *filep)
> > +{
> > +	struct vfio_device *device = filep->private_data;
> > +
> > +	vfio_do_release(&device->refcnt, device->iommu);
> > +
> > +	device->ops->put(device->device_data);
> > +
> > +	return 0;
> > +}
> > +
> > +static long vfio_device_unl_ioctl(struct file *filep,
> > +				  unsigned int cmd, unsigned long arg)
> > +{
> > +	struct vfio_device *device = filep->private_data;
> > +
> > +	return device->ops->ioctl(device->device_data, cmd, arg);
> > +}
> > +
> > +static ssize_t vfio_device_read(struct file *filep, char __user *buf,
> > +				size_t count, loff_t *ppos)
> > +{
> > +	struct vfio_device *device = filep->private_data;
> > +
> > +	return device->ops->read(device->device_data, buf, count, ppos);
> > +}
> > +
> > +static ssize_t vfio_device_write(struct file *filep, const char __user *buf,
> > +				 size_t count, loff_t *ppos)
> > +{
> > +	struct vfio_device *device = filep->private_data;
> > +
> > +	return device->ops->write(device->device_data, buf, count, ppos);
> > +}
> > +
> > +static int vfio_device_mmap(struct file *filep, struct vm_area_struct *vma)
> > +{
> > +	struct vfio_device *device = filep->private_data;
> > +
> > +	return device->ops->mmap(device->device_data, vma);
> > +}
> > +	
> > +#ifdef CONFIG_COMPAT
> > +static long vfio_device_compat_ioctl(struct file *filep,
> > +				     unsigned int cmd, unsigned long arg)
> > +{
> > +	arg = (unsigned long)compat_ptr(arg);
> > +	return vfio_device_unl_ioctl(filep, cmd, arg);
> > +}
> > +#endif	/* CONFIG_COMPAT */
> > +
> > +const struct file_operations vfio_device_fops = {
> > +	.owner		= THIS_MODULE,
> > +	.release	= vfio_device_release,
> > +	.read		= vfio_device_read,
> > +	.write		= vfio_device_write,
> > +	.unlocked_ioctl	= vfio_device_unl_ioctl,
> > +#ifdef CONFIG_COMPAT
> > +	.compat_ioctl	= vfio_device_compat_ioctl,
> > +#endif
> > +	.mmap		= vfio_device_mmap,
> > +};
> > +
> > +/*
> > + * Group fops
> > + */
> > +static int vfio_group_open(struct inode *inode, struct file *filep)
> > +{
> > +	struct vfio_group *group;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	group = idr_find(&vfio.idr, iminor(inode));
> > +
> > +	if (!group) {
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	filep->private_data = group;
> > +
> > +	if (!group->iommu) {
> > +		struct vfio_iommu *iommu;
> > +
> > +		iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
> > +		if (!iommu) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +		INIT_LIST_HEAD(&iommu->group_list);
> > +		INIT_LIST_HEAD(&iommu->dm_list);
> > +		mutex_init(&iommu->dgate);
> > +		iommu->bus = group->bus;
> > +		__vfio_group_set_iommu(group, iommu);
> > +	}
> > +	group->refcnt++;
> > +
> > +out:
> > +	mutex_unlock(&vfio.lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int vfio_group_release(struct inode *inode, struct file *filep)
> > +{
> > +	struct vfio_group *group = filep->private_data;
> > +
> > +	return vfio_do_release(&group->refcnt, group->iommu);
> > +}
> > +
> > +/* Attempt to merge the group pointed to by fd into group.  The merge-ee
> > + * group must not have an iommu or any devices open because we cannot
> > + * maintain that context across the merge.  The merge-er group can be
> > + * in use. */
> > +static int vfio_group_merge(struct vfio_group *group, int fd)
> > +{
> > +	struct vfio_group *new;
> > +	struct vfio_iommu *old_iommu;
> > +	struct file *file;
> > +	int ret = 0;
> > +	bool opened = false;
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	file = fget(fd);
> > +	if (!file) {
> > +		ret = -EBADF;
> > +		goto out_noput;
> > +	}
> > +
> > +	/* Sanity check, is this really our fd? */
> > +	if (file->f_op != &vfio_group_fops) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	new = file->private_data;
> > +
> > +	if (!new || new == group || !new->iommu ||
> > +	    new->iommu->domain || new->bus != group->bus) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	/* We need to attach all the devices to each domain separately
> > +	 * in order to validate that the capabilities match for both.  */
> > +	ret = __vfio_open_iommu(new->iommu);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (!group->iommu->domain) {
> > +		ret = __vfio_open_iommu(group->iommu);
> > +		if (ret)
> > +			goto out;
> > +		opened = true;
> > +	}
> > +
> > +	/* If cache coherency doesn't match we'd potentialy need to
> > +	 * remap existing iommu mappings in the merge-er domain.
> > +	 * Poor return to bother trying to allow this currently. */
> > +	if (iommu_domain_has_cap(group->iommu->domain,
> > +				 IOMMU_CAP_CACHE_COHERENCY) !=
> > +	    iommu_domain_has_cap(new->iommu->domain,
> > +				 IOMMU_CAP_CACHE_COHERENCY)) {
> > +		__vfio_close_iommu(new->iommu);
> > +		if (opened)
> > +			__vfio_close_iommu(group->iommu);
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	/* Close the iommu for the merge-ee and attach all its devices
> > +	 * to the merge-er iommu. */
> > +	__vfio_close_iommu(new->iommu);
> > +
> > +	ret = __vfio_iommu_attach_group(group->iommu, new);
> > +	if (ret)
> > +		goto out;
> > +
> > +	/* set_iommu unlinks new from the iommu, so save a pointer to it */
> > +	old_iommu = new->iommu;
> > +	__vfio_group_set_iommu(new, group->iommu);
> > +	kfree(old_iommu);
> > +
> > +out:
> > +	fput(file);
> > +out_noput:
> > +	mutex_unlock(&vfio.lock);
> > +	return ret;
> > +}
> > +
> > +/* Unmerge the group pointed to by fd from group. */
> > +static int vfio_group_unmerge(struct vfio_group *group, int fd)
> > +{
> > +	struct vfio_group *new;
> > +	struct vfio_iommu *new_iommu;
> > +	struct file *file;
> > +	int ret = 0;
> > +
> > +	/* Since the merge-out group is already opened, it needs to
> > +	 * have an iommu struct associated with it. */
> > +	new_iommu = kzalloc(sizeof(*new_iommu), GFP_KERNEL);
> > +	if (!new_iommu)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&new_iommu->group_list);
> > +	INIT_LIST_HEAD(&new_iommu->dm_list);
> > +	mutex_init(&new_iommu->dgate);
> > +	new_iommu->bus = group->bus;
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	file = fget(fd);
> > +	if (!file) {
> > +		ret = -EBADF;
> > +		goto out_noput;
> > +	}
> > +
> > +	/* Sanity check, is this really our fd? */
> > +	if (file->f_op != &vfio_group_fops) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	new = file->private_data;
> > +	if (!new || new == group || new->iommu != group->iommu) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	/* We can't merge-out a group with devices still in use. */
> > +	if (__vfio_group_devs_inuse(new)) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	__vfio_iommu_detach_group(group->iommu, new);
> > +	__vfio_group_set_iommu(new, new_iommu);
> > +
> > +out:
> > +	fput(file);
> > +out_noput:
> > +	if (ret)
> > +		kfree(new_iommu);
> > +	mutex_unlock(&vfio.lock);
> > +	return ret;
> > +}
> > +
> > +/* Get a new iommu file descriptor.  This will open the iommu, setting
> > + * the current->mm ownership if it's not already set. */
> > +static int vfio_group_get_iommu_fd(struct vfio_group *group)
> > +{
> > +	int ret = 0;
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	if (!group->iommu->domain) {
> > +		ret = __vfio_open_iommu(group->iommu);
> > +		if (ret)
> > +			goto out;
> > +	}
> > +
> > +	ret = anon_inode_getfd("[vfio-iommu]", &vfio_iommu_fops,
> > +			       group->iommu, O_RDWR);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	group->iommu->refcnt++;
> > +out:
> > +	mutex_unlock(&vfio.lock);
> > +	return ret;
> > +}
> > +
> > +/* Get a new device file descriptor.  This will open the iommu, setting
> > + * the current->mm ownership if it's not already set.  It's difficult to
> > + * specify the requirements for matching a user supplied buffer to a
> > + * device, so we use a vfio driver callback to test for a match.  For
> > + * PCI, dev_name(dev) is unique, but other drivers may require including
> > + * a parent device string. */
> > +static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
> > +{
> > +	struct vfio_iommu *iommu = group->iommu;
> > +	struct list_head *gpos;
> > +	int ret = -ENODEV;
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	if (!iommu->domain) {
> > +		ret = __vfio_open_iommu(iommu);
> > +		if (ret)
> > +			goto out;
> > +	}
> > +
> > +	list_for_each(gpos, &iommu->group_list) {
> > +		struct list_head *dpos;
> > +
> > +		group = list_entry(gpos, struct vfio_group, iommu_next);
> > +
> > +		list_for_each(dpos, &group->device_list) {
> > +			struct vfio_device *device;
> > +
> > +			device = list_entry(dpos,
> > +					    struct vfio_device, device_next);
> > +
> > +			if (device->ops->match(device->dev, buf)) {
> > +				struct file *file;
> > +
> > +				if (device->ops->get(device->device_data)) {
> > +					ret = -EFAULT;
> > +					goto out;
> > +				}
> > +
> > +				/* We can't use anon_inode_getfd(), like above
> > +				 * because we need to modify the f_mode flags
> > +				 * directly to allow more than just ioctls */
> > +				ret = get_unused_fd();
> > +				if (ret < 0) {
> > +					device->ops->put(device->device_data);
> > +					goto out;
> > +				}
> > +
> > +				file = anon_inode_getfile("[vfio-device]",
> > +							  &vfio_device_fops,
> > +							  device, O_RDWR);
> > +				if (IS_ERR(file)) {
> > +					put_unused_fd(ret);
> > +					ret = PTR_ERR(file);
> > +					device->ops->put(device->device_data);
> > +					goto out;
> > +				}
> > +
> > +				/* Todo: add an anon_inode interface to do
> > +				 * this.  Appears to be missing by lack of
> > +				 * need rather than explicitly prevented.
> > +				 * Now there's need. */
> > +				file->f_mode |= (FMODE_LSEEK |
> > +						 FMODE_PREAD |
> > +						 FMODE_PWRITE);
> > +
> > +				fd_install(ret, file);
> > +
> > +				device->refcnt++;
> > +				goto out;
> > +			}
> > +		}
> > +	}
> > +out:
> > +	mutex_unlock(&vfio.lock);
> > +	return ret;
> > +}
> > +
> > +static long vfio_group_unl_ioctl(struct file *filep,
> > +				 unsigned int cmd, unsigned long arg)
> > +{
> > +	struct vfio_group *group = filep->private_data;
> > +
> > +	if (cmd == VFIO_GROUP_GET_FLAGS) {
> > +		u64 flags = 0;
> > +
> > +		mutex_lock(&vfio.lock);
> > +		if (__vfio_iommu_viable(group->iommu))
> > +			flags |= VFIO_GROUP_FLAGS_VIABLE;
> > +		mutex_unlock(&vfio.lock);
> > +
> > +		if (group->iommu->mm)
> > +			flags |= VFIO_GROUP_FLAGS_MM_LOCKED;
> > +
> > +		return put_user(flags, (u64 __user *)arg);
> > +	}
> > +		
> > +	/* Below commands are restricted once the mm is set */
> > +	if (group->iommu->mm && group->iommu->mm != current->mm)
> > +		return -EPERM;
> > +
> > +	if (cmd == VFIO_GROUP_MERGE || cmd == VFIO_GROUP_UNMERGE) {
> > +		int fd;
> > +		
> > +		if (get_user(fd, (int __user *)arg))
> > +			return -EFAULT;
> > +		if (fd < 0)
> > +			return -EINVAL;
> > +
> > +		if (cmd == VFIO_GROUP_MERGE)
> > +			return vfio_group_merge(group, fd);
> > +		else
> > +			return vfio_group_unmerge(group, fd);
> > +	} else if (cmd == VFIO_GROUP_GET_IOMMU_FD) {
> > +		return vfio_group_get_iommu_fd(group);
> > +	} else if (cmd == VFIO_GROUP_GET_DEVICE_FD) {
> > +		char *buf;
> > +		int ret;
> > +
> > +		buf = strndup_user((const char __user *)arg, PAGE_SIZE);
> > +		if (IS_ERR(buf))
> > +			return PTR_ERR(buf);
> > +
> > +		ret = vfio_group_get_device_fd(group, buf);
> > +		kfree(buf);
> > +		return ret;
> > +	}
> > +
> > +	return -ENOSYS;
> > +}
> > +
> > +#ifdef CONFIG_COMPAT
> > +static long vfio_group_compat_ioctl(struct file *filep,
> > +				    unsigned int cmd, unsigned long arg)
> > +{
> > +	arg = (unsigned long)compat_ptr(arg);
> > +	return vfio_group_unl_ioctl(filep, cmd, arg);
> > +}
> > +#endif	/* CONFIG_COMPAT */
> > +
> > +static const struct file_operations vfio_group_fops = {
> > +	.owner		= THIS_MODULE,
> > +	.open		= vfio_group_open,
> > +	.release	= vfio_group_release,
> > +	.unlocked_ioctl	= vfio_group_unl_ioctl,
> > +#ifdef CONFIG_COMPAT
> > +	.compat_ioctl	= vfio_group_compat_ioctl,
> > +#endif
> > +};
> > +
> > +/* iommu fd release hook */
> > +int vfio_release_iommu(struct vfio_iommu *iommu)
> > +{
> > +	return vfio_do_release(&iommu->refcnt, iommu);
> > +}
> > +
> > +/*
> > + * VFIO driver API
> > + */
> > +
> > +/* Add a new device to the vfio framework with associated vfio driver
> > + * callbacks.  This is the entry point for vfio drivers to register devices. */
> > +int vfio_group_add_dev(struct device *dev, const struct vfio_device_ops *ops)
> > +{
> > +	struct list_head *pos;
> > +	struct vfio_group *group = NULL;
> > +	struct vfio_device *device = NULL;
> > +	unsigned int groupid;
> > +	int ret = 0;
> > +	bool new_group = false;
> > +
> > +	if (!ops)
> > +		return -EINVAL;
> > +
> > +	if (iommu_device_group(dev, &groupid))
> > +		return -ENODEV;
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	list_for_each(pos, &vfio.group_list) {
> > +		group = list_entry(pos, struct vfio_group, group_next);
> > +		if (group->groupid == groupid)
> > +			break;
> > +		group = NULL;
> > +	}
> > +
> > +	if (!group) {
> > +		int minor;
> > +
> > +		if (unlikely(idr_pre_get(&vfio.idr, GFP_KERNEL) == 0)) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		group = kzalloc(sizeof(*group), GFP_KERNEL);
> > +		if (!group) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		group->groupid = groupid;
> > +		INIT_LIST_HEAD(&group->device_list);
> > +
> > +		ret = idr_get_new(&vfio.idr, group, &minor);
> > +		if (ret == 0 && minor > MINORMASK) {
> > +			idr_remove(&vfio.idr, minor);
> > +			kfree(group);
> > +			ret = -ENOSPC;
> > +			goto out;
> > +		}
> > +
> > +		group->devt = MKDEV(MAJOR(vfio.devt), minor);
> > +		device_create(vfio.class, NULL, group->devt,
> > +			      group, "%u", groupid);
> > +
> > +		group->bus = dev->bus;
> 
> 
> Oh, so that is how the IOMMU iommu_ops get copied! You might
> want to mention that - I was not sure where the 'handoff' is
> was done to insert a device so that it can do iommu_ops properly.
> 
> Ok, so the time when a device is detected whether it can do
> IOMMU is when we try to open it - as that is when iommu_domain_alloc
> is called which can return NULL if the iommu_ops is not set.
> 
> So what about devices that don't have an iommu_ops? Say they
> are using SWIOTLB? (like the AMD-Vi sometimes does if the
> device is not on its list).
> 
> Can we use iommu_present?

I'm not sure I'm following your revelation ;)  Take a look at the
pointer to iommu_device_group I pasted above, or these:

https://github.com/awilliam/linux-vfio/commit/37dd08c90d149caaed7779d4f38850a8f7ed0fa5
https://github.com/awilliam/linux-vfio/commit/63ca8543533d8130db23d7949133e548c3891c97
https://github.com/awilliam/linux-vfio/commit/8d7d70eb8e714fbf8710848a06f8cab0c741631e

That call includes an iommu_present() check, so if there's no iommu or
the iommu can't provide a groupid, the device is skipped over from vfio
(can't be used).

So the ordering is:

 - bus driver registers device
   - if it has an iommu group, add it to the vfio device/group tracking

 - group gets opened
   - user gets iommu or device fd results in iommu_domain_alloc

Devices without iommu_ops don't get to play in the vfio world.

> > +		list_add(&group->group_next, &vfio.group_list);
> > +		new_group = true;
> > +	} else {
> > +		if (group->bus != dev->bus) {
> > +			printk(KERN_WARNING
> > +			       "Error: IOMMU group ID conflict.  Group ID %u "
> > +				"on both bus %s and %s\n", groupid,
> > +				group->bus->name, dev->bus->name);
> > +			ret = -EFAULT;
> > +			goto out;
> > +		}
> > +
> > +		list_for_each(pos, &group->device_list) {
> > +			device = list_entry(pos,
> > +					    struct vfio_device, device_next);
> > +			if (device->dev == dev)
> > +				break;
> > +			device = NULL;
> > +		}
> > +	}
> > +
> > +	if (!device) {
> > +		if (__vfio_group_devs_inuse(group) ||
> > +		    (group->iommu && group->iommu->refcnt)) {
> > +			printk(KERN_WARNING
> > +			       "Adding device %s to group %u while group is already in use!!\n",
> > +			       dev_name(dev), group->groupid);
> > +			/* XXX How to prevent other drivers from claiming? */
> > +		}
> > +
> > +		device = kzalloc(sizeof(*device), GFP_KERNEL);
> > +		if (!device) {
> > +			/* If we just created this group, tear it down */
> > +			if (new_group) {
> > +				list_del(&group->group_next);
> > +				device_destroy(vfio.class, group->devt);
> > +				idr_remove(&vfio.idr, MINOR(group->devt));
> > +				kfree(group);
> > +			}
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		list_add(&device->device_next, &group->device_list);
> > +		device->dev = dev;
> > +		device->ops = ops;
> > +		device->iommu = group->iommu; /* NULL if new */
> > +		__vfio_iommu_attach_dev(group->iommu, device);
> > +	}
> > +out:
> > +	mutex_unlock(&vfio.lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_group_add_dev);
> > +
> > +/* Remove a device from the vfio framework */
> > +void vfio_group_del_dev(struct device *dev)
> > +{
> > +	struct list_head *pos;
> > +	struct vfio_group *group = NULL;
> > +	struct vfio_device *device = NULL;
> > +	unsigned int groupid;
> > +
> > +	if (iommu_device_group(dev, &groupid))
> > +		return;
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	list_for_each(pos, &vfio.group_list) {
> > +		group = list_entry(pos, struct vfio_group, group_next);
> > +		if (group->groupid == groupid)
> > +			break;
> > +		group = NULL;
> > +	}
> > +
> > +	if (!group)
> > +		goto out;
> > +
> > +	list_for_each(pos, &group->device_list) {
> > +		device = list_entry(pos, struct vfio_device, device_next);
> > +		if (device->dev == dev)
> > +			break;
> > +		device = NULL;
> > +	}
> > +
> > +	if (!device)
> > +		goto out;
> > +
> > +	BUG_ON(device->refcnt);
> > +
> > +	if (device->attached)
> > +		__vfio_iommu_detach_dev(group->iommu, device);
> > +
> > +	list_del(&device->device_next);
> > +	kfree(device);
> > +
> > +	/* If this was the only device in the group, remove the group.
> > +	 * Note that we intentionally unmerge empty groups here if the
> > +	 * group fd isn't opened. */
> > +	if (list_empty(&group->device_list) && group->refcnt == 0) {
> > +		struct vfio_iommu *iommu = group->iommu;
> > +
> > +		if (iommu) {
> > +			__vfio_group_set_iommu(group, NULL);
> > +			__vfio_try_dissolve_iommu(iommu);
> > +		}
> > +
> > +		device_destroy(vfio.class, group->devt);
> > +		idr_remove(&vfio.idr, MINOR(group->devt));
> > +		list_del(&group->group_next);
> > +		kfree(group);
> > +	}
> > +out:
> > +	mutex_unlock(&vfio.lock);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_group_del_dev);
> > +
> > +/* When a device is bound to a vfio device driver (ex. vfio-pci), this
> > + * entry point is used to mark the device usable (viable).  The vfio
> > + * device driver associates a private device_data struct with the device
> > + * here, which will later be return for vfio_device_fops callbacks. */
> > +int vfio_bind_dev(struct device *dev, void *device_data)
> > +{
> > +	struct vfio_device *device;
> > +	int ret = -EINVAL;
> > +
> > +	BUG_ON(!device_data);
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	device = __vfio_lookup_dev(dev);
> > +
> > +	BUG_ON(!device);
> > +
> > +	ret = dev_set_drvdata(dev, device);
> > +	if (!ret)
> > +		device->device_data = device_data;
> > +
> > +	mutex_unlock(&vfio.lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_bind_dev);
> > +
> > +/* A device is only removeable if the iommu for the group is not in use. */
> > +static bool vfio_device_removeable(struct vfio_device *device)
> > +{
> > +	bool ret = true;
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	if (device->iommu && __vfio_iommu_inuse(device->iommu))
> > +		ret = false;
> > +
> > +	mutex_unlock(&vfio.lock);
> > +	return ret;
> > +}
> > +
> > +/* Notify vfio that a device is being unbound from the vfio device driver
> > + * and return the device private device_data pointer.  If the group is
> > + * in use, we need to block or take other measures to make it safe for
> > + * the device to be removed from the iommu. */
> > +void *vfio_unbind_dev(struct device *dev)
> > +{
> > +	struct vfio_device *device = dev_get_drvdata(dev);
> > +	void *device_data;
> > +
> > +	BUG_ON(!device);
> > +
> > +again:
> > +	if (!vfio_device_removeable(device)) {
> > +		/* XXX signal for all devices in group to be removed or
> > +		 * resort to killing the process holding the device fds.
> > +		 * For now just block waiting for releases to wake us. */
> > +		wait_event(vfio.release_q, vfio_device_removeable(device));
> > +	}
> > +
> > +	mutex_lock(&vfio.lock);
> > +
> > +	/* Need to re-check that the device is still removeable under lock. */
> > +	if (device->iommu && __vfio_iommu_inuse(device->iommu)) {
> > +		mutex_unlock(&vfio.lock);
> > +		goto again;
> > +	}
> > +
> > +	device_data = device->device_data;
> > +
> > +	device->device_data = NULL;
> > +	dev_set_drvdata(dev, NULL);
> > +
> > +	mutex_unlock(&vfio.lock);
> > +	return device_data;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_unbind_dev);
> > +
> > +/*
> > + * Module/class support
> > + */
> > +static void vfio_class_release(struct kref *kref)
> > +{
> > +	class_destroy(vfio.class);
> > +	vfio.class = NULL;
> > +}
> > +
> > +static char *vfio_devnode(struct device *dev, mode_t *mode)
> > +{
> > +	return kasprintf(GFP_KERNEL, "vfio/%s", dev_name(dev));
> > +}
> > +
> > +static int __init vfio_init(void)
> > +{
> > +	int ret;
> > +
> > +	idr_init(&vfio.idr);
> > +	mutex_init(&vfio.lock);
> > +	INIT_LIST_HEAD(&vfio.group_list);
> > +	init_waitqueue_head(&vfio.release_q);
> > +
> > +	kref_init(&vfio.kref);
> > +	vfio.class = class_create(THIS_MODULE, "vfio");
> > +	if (IS_ERR(vfio.class)) {
> > +		ret = PTR_ERR(vfio.class);
> > +		goto err_class;
> > +	}
> > +
> > +	vfio.class->devnode = vfio_devnode;
> > +
> > +	/* FIXME - how many minors to allocate... all of them! */
> > +	ret = alloc_chrdev_region(&vfio.devt, 0, MINORMASK, "vfio");
> > +	if (ret)
> > +		goto err_chrdev;
> > +
> > +	cdev_init(&vfio.cdev, &vfio_group_fops);
> > +	ret = cdev_add(&vfio.cdev, vfio.devt, MINORMASK);
> > +	if (ret)
> > +		goto err_cdev;
> > +
> > +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> > +
> > +	return 0;
> > +
> > +err_cdev:
> > +	unregister_chrdev_region(vfio.devt, MINORMASK);
> > +err_chrdev:
> > +	kref_put(&vfio.kref, vfio_class_release);
> > +err_class:
> > +	return ret;
> > +}
> > +
> > +static void __exit vfio_cleanup(void)
> > +{
> > +	struct list_head *gpos, *gppos;
> > +
> > +	list_for_each_safe(gpos, gppos, &vfio.group_list) {
> > +		struct vfio_group *group;
> > +		struct list_head *dpos, *dppos;
> > +
> > +		group = list_entry(gpos, struct vfio_group, group_next);
> > +
> > +		list_for_each_safe(dpos, dppos, &group->device_list) {
> > +			struct vfio_device *device;
> > +
> > +			device = list_entry(dpos,
> > +					    struct vfio_device, device_next);
> > +			vfio_group_del_dev(device->dev);
> > +		}
> > +	}
> > +
> > +	idr_destroy(&vfio.idr);
> > +	cdev_del(&vfio.cdev);
> > +	unregister_chrdev_region(vfio.devt, MINORMASK);
> > +	kref_put(&vfio.kref, vfio_class_release);
> > +}
> > +
> > +module_init(vfio_init);
> > +module_exit(vfio_cleanup);
> > +
> > +MODULE_VERSION(DRIVER_VERSION);
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR(DRIVER_AUTHOR);
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > diff --git a/drivers/vfio/vfio_private.h b/drivers/vfio/vfio_private.h
> > new file mode 100644
> > index 0000000..350ad67
> > --- /dev/null
> > +++ b/drivers/vfio/vfio_private.h
> > @@ -0,0 +1,34 @@
> > +/*
> > + * Copyright (C) 2011 Red Hat, Inc.  All rights reserved.
> > + *     Author: Alex Williamson <alex.williamson@redhat.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Derived from original vfio:
> > + * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
> > + * Author: Tom Lyon, pugs@cisco.com
> > + */
> > +
> > +#include <linux/list.h>
> > +#include <linux/mutex.h>
> > +
> > +#ifndef VFIO_PRIVATE_H
> > +#define VFIO_PRIVATE_H
> > +
> > +struct vfio_iommu {
> > +	struct iommu_domain		*domain;
> > +	struct bus_type			*bus;
> > +	struct mutex			dgate;
> > +	struct list_head		dm_list;
> > +	struct mm_struct		*mm;
> > +	struct list_head		group_list;
> > +	int				refcnt;
> > +	bool				cache;
> > +};
> > +
> > +extern int vfio_release_iommu(struct vfio_iommu *iommu);
> > +extern void vfio_iommu_unmapall(struct vfio_iommu *iommu);
> > +
> > +#endif /* VFIO_PRIVATE_H */
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > new file mode 100644
> > index 0000000..4269b08
> > --- /dev/null
> > +++ b/include/linux/vfio.h
> > @@ -0,0 +1,155 @@
> > +/*
> > + * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
> > + * Author: Tom Lyon, pugs@cisco.com
> > + *
> > + * This program is free software; you may redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; version 2 of the License.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> > + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> > + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> > + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> > + * SOFTWARE.
> > + *
> > + * Portions derived from drivers/uio/uio.c:
> > + * Copyright(C) 2005, Benedikt Spranger <b.spranger@linutronix.de>
> > + * Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
> > + * Copyright(C) 2006, Hans J. Koch <hjk@linutronix.de>
> > + * Copyright(C) 2006, Greg Kroah-Hartman <greg@kroah.com>
> > + *
> > + * Portions derived from drivers/uio/uio_pci_generic.c:
> > + * Copyright (C) 2009 Red Hat, Inc.
> > + * Author: Michael S. Tsirkin <mst@redhat.com>
> > + */
> > +#include <linux/types.h>
> > +
> > +#ifndef VFIO_H
> > +#define VFIO_H
> > +
> > +#ifdef __KERNEL__
> > +
> > +struct vfio_device_ops {
> > +	bool			(*match)(struct device *, char *);
> > +	int			(*get)(void *);
> > +	void			(*put)(void *);
> > +	ssize_t			(*read)(void *, char __user *,
> > +					size_t, loff_t *);
> > +	ssize_t			(*write)(void *, const char __user *,
> > +					 size_t, loff_t *);
> > +	long			(*ioctl)(void *, unsigned int, unsigned long);
> > +	int			(*mmap)(void *, struct vm_area_struct *);
> > +};
> > +
> > +extern int vfio_group_add_dev(struct device *device,
> > +			      const struct vfio_device_ops *ops);
> > +extern void vfio_group_del_dev(struct device *device);
> > +extern int vfio_bind_dev(struct device *device, void *device_data);
> > +extern void *vfio_unbind_dev(struct device *device);
> > +
> > +#endif /* __KERNEL__ */
> > +
> > +/*
> > + * VFIO driver - allow mapping and use of certain devices
> > + * in unprivileged user processes. (If IOMMU is present)
> > + * Especially useful for Virtual Function parts of SR-IOV devices
> > + */
> > +
> > +
> > +/* Kernel & User level defines for ioctls */
> > +
> > +#define VFIO_GROUP_GET_FLAGS		_IOR(';', 100, __u64)
> 
> > + #define VFIO_GROUP_FLAGS_VIABLE	(1 << 0)
> > + #define VFIO_GROUP_FLAGS_MM_LOCKED	(1 << 1)
> > +#define VFIO_GROUP_MERGE		_IOW(';', 101, int)
> > +#define VFIO_GROUP_UNMERGE		_IOW(';', 102, int)
> > +#define VFIO_GROUP_GET_IOMMU_FD		_IO(';', 103)
> > +#define VFIO_GROUP_GET_DEVICE_FD	_IOW(';', 104, char *)
> > +
> > +/*
> > + * Structure for DMA mapping of user buffers
> > + * vaddr, dmaaddr, and size must all be page aligned
> > + */
> > +struct vfio_dma_map {
> > +	__u64	len;		/* length of structure */
> > +	__u64	vaddr;		/* process virtual addr */
> > +	__u64	dmaaddr;	/* desired and/or returned dma address */
> > +	__u64	size;		/* size in bytes */
> > +	__u64	flags;
> > +#define	VFIO_DMA_MAP_FLAG_WRITE		(1 << 0) /* req writeable DMA mem */
> > +};
> > +
> > +#define	VFIO_IOMMU_GET_FLAGS		_IOR(';', 105, __u64)
> > + /* Does the IOMMU support mapping any IOVA to any virtual address? */
> > + #define VFIO_IOMMU_FLAGS_MAP_ANY	(1 << 0)
> > +#define	VFIO_IOMMU_MAP_DMA		_IOWR(';', 106, struct vfio_dma_map)
> > +#define	VFIO_IOMMU_UNMAP_DMA		_IOWR(';', 107, struct vfio_dma_map)
> > +
> > +#define VFIO_DEVICE_GET_FLAGS		_IOR(';', 108, __u64)
> > + #define VFIO_DEVICE_FLAGS_PCI		(1 << 0)
> > + #define VFIO_DEVICE_FLAGS_DT		(1 << 1)
> > + #define VFIO_DEVICE_FLAGS_RESET	(1 << 2)
> > +#define VFIO_DEVICE_GET_NUM_REGIONS	_IOR(';', 109, int)
> > +
> > +struct vfio_region_info {
> > +	__u32	len;		/* length of structure */
> > +	__u32	index;		/* region number */
> > +	__u64	size;		/* size in bytes of region */
> > +	__u64	offset;		/* start offset of region */
> > +	__u64	flags;
> > +#define VFIO_REGION_INFO_FLAG_MMAP		(1 << 0)
> > +#define VFIO_REGION_INFO_FLAG_RO		(1 << 1)
> > +#define VFIO_REGION_INFO_FLAG_PHYS_VALID	(1 << 2)
> > +	__u64	phys;		/* physical address of region */
> > +};
> > +
> > +#define VFIO_DEVICE_GET_REGION_INFO	_IOWR(';', 110, struct vfio_region_info)
> > +
> > +#define VFIO_DEVICE_GET_NUM_IRQS	_IOR(';', 111, int)
> > +
> > +struct vfio_irq_info {
> > +	__u32	len;		/* length of structure */
> > +	__u32	index;		/* IRQ number */
> > +	__u32	count;		/* number of individual IRQs */
> > +	__u32	flags;
> > +#define VFIO_IRQ_INFO_FLAG_LEVEL		(1 << 0)
> > +};
> > +
> > +#define VFIO_DEVICE_GET_IRQ_INFO	_IOWR(';', 112, struct vfio_irq_info)
> > +
> > +/* Set IRQ eventfds, arg[0] = index, arg[1] = count, arg[2-n] = eventfds */
> > +#define VFIO_DEVICE_SET_IRQ_EVENTFDS	_IOW(';', 113, int)
> > +
> > +/* Unmask IRQ index, arg[0] = index */
> > +#define VFIO_DEVICE_UNMASK_IRQ		_IOW(';', 114, int)
> > +
> > +/* Set unmask eventfd, arg[0] = index, arg[1] = eventfd */
> > +#define VFIO_DEVICE_SET_UNMASK_IRQ_EVENTFD	_IOW(';', 115, int)
> > +
> > +#define VFIO_DEVICE_RESET		_IO(';', 116)
> > +
> > +struct vfio_dtpath {
> > +	__u32	len;		/* length of structure */
> > +	__u32	index;
> > +	__u64	flags;
> > +#define VFIO_DTPATH_FLAGS_REGION	(1 << 0)
> > +#define VFIO_DTPATH_FLAGS_IRQ		(1 << 1)
> > +	char	*path;
> > +};
> > +#define VFIO_DEVICE_GET_DTPATH		_IOWR(';', 117, struct vfio_dtpath)
> > +
> > +struct vfio_dtindex {
> > +	__u32	len;		/* length of structure */
> > +	__u32	index;
> > +	__u32	prop_type;
> > +	__u32	prop_index;
> > +	__u64	flags;
> > +#define VFIO_DTINDEX_FLAGS_REGION	(1 << 0)
> > +#define VFIO_DTINDEX_FLAGS_IRQ		(1 << 1)
> > +};
> > +#define VFIO_DEVICE_GET_DTINDEX		_IOWR(';', 118, struct vfio_dtindex)
> > +
> > +#endif /* VFIO_H */
> 
> 
> So where is the vfio-pci? Is that a seperate posting?

You can find it in the tree pointed to in the patch description:

https://github.com/awilliam/linux-vfio/commit/534725d327e2b7791a229ce72d2ae8a62ee0a4e5

I was hoping to get some consensus around the new core before spending
too much time polishing up the bus driver.  Thanks for the review, it's
very much appreciated!

Alex


