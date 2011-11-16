Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:16861 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab1KPQyf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2011 11:54:35 -0500
Date: Wed, 16 Nov 2011 11:52:27 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	dwg@au1.ibm.com, joerg.roedel@amd.com, agraf@suse.de,
	benve@cisco.com, aafabbri@cisco.com, B08248@freescale.com,
	B07421@freescale.com, avi@redhat.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
Message-ID: <20111116165227.GB2793@phenom.dumpdata.com>
References: <20111103195452.21259.93021.stgit@bling.home>
 <20111111175118.GA6946@phenom.dumpdata.com>
 <1321049456.2682.220.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321049456.2682.220.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2011 at 03:10:56PM -0700, Alex Williamson wrote:
> 
> Thanks Konrad!  Comments inline.
> 
> On Fri, 2011-11-11 at 12:51 -0500, Konrad Rzeszutek Wilk wrote:
> > On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
> > > VFIO provides a secure, IOMMU based interface for user space
> > > drivers, including device assignment to virtual machines.
> > > This provides the base management of IOMMU groups, devices,
> > > and IOMMU objects.  See Documentation/vfio.txt included in
> > > this patch for user and kernel API description.
> > > 
> > > Note, this implements the new API discussed at KVM Forum
> > > 2011, as represented by the drvier version 0.2.  It's hoped
> > > that this provides a modular enough interface to support PCI
> > > and non-PCI userspace drivers across various architectures
> > > and IOMMU implementations.
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > > 
> > > Fingers crossed, this is the last RFC for VFIO, but we need
> > > the iommu group support before this can go upstream
> > > (http://lkml.indiana.edu/hypermail/linux/kernel/1110.2/02303.html),
> > > hoping this helps push that along.
> > > 
> > > Since the last posting, this version completely modularizes
> > > the device backends and better defines the APIs between the
> > > core VFIO code and the device backends.  I expect that we
> > > might also adopt a modular IOMMU interface as iommu_ops learns
> > > about different types of hardware.  Also many, many cleanups.
> > > Check the complete git history for details:
> > > 
> > > git://github.com/awilliam/linux-vfio.git vfio-ng
> > > 
> > > (matching qemu tree: git://github.com/awilliam/qemu-vfio.git)
> > > 
> > > This version, along with the supporting VFIO PCI backend can
> > > be found here:
> > > 
> > > git://github.com/awilliam/linux-vfio.git vfio-next-20111103
> > > 
> > > I've held off on implementing a kernel->user signaling
> > > mechanism for now since the previous netlink version produced
> > > too many gag reflexes.  It's easy enough to set a bit in the
> > > group flags too indicate such support in the future, so I
> > > think we can move ahead without it.
> > > 
> > > Appreciate any feedback or suggestions.  Thanks,
> > > 
> > > Alex
> > > 
> > >  Documentation/ioctl/ioctl-number.txt |    1 
> > >  Documentation/vfio.txt               |  304 +++++++++
> > >  MAINTAINERS                          |    8 
> > >  drivers/Kconfig                      |    2 
> > >  drivers/Makefile                     |    1 
> > >  drivers/vfio/Kconfig                 |    8 
> > >  drivers/vfio/Makefile                |    3 
> > >  drivers/vfio/vfio_iommu.c            |  530 ++++++++++++++++
> > >  drivers/vfio/vfio_main.c             | 1151 ++++++++++++++++++++++++++++++++++
> > >  drivers/vfio/vfio_private.h          |   34 +
> > >  include/linux/vfio.h                 |  155 +++++
> > >  11 files changed, 2197 insertions(+), 0 deletions(-)
> > >  create mode 100644 Documentation/vfio.txt
> > >  create mode 100644 drivers/vfio/Kconfig
> > >  create mode 100644 drivers/vfio/Makefile
> > >  create mode 100644 drivers/vfio/vfio_iommu.c
> > >  create mode 100644 drivers/vfio/vfio_main.c
> > >  create mode 100644 drivers/vfio/vfio_private.h
> > >  create mode 100644 include/linux/vfio.h
> > > 
> > > diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> > > index 54078ed..59d01e4 100644
> > > --- a/Documentation/ioctl/ioctl-number.txt
> > > +++ b/Documentation/ioctl/ioctl-number.txt
> > > @@ -88,6 +88,7 @@ Code  Seq#(hex)	Include File		Comments
> > >  		and kernel/power/user.c
> > >  '8'	all				SNP8023 advanced NIC card
> > >  					<mailto:mcr@solidum.com>
> > > +';'	64-76	linux/vfio.h
> > >  '@'	00-0F	linux/radeonfb.h	conflict!
> > >  '@'	00-0F	drivers/video/aty/aty128fb.c	conflict!
> > >  'A'	00-1F	linux/apm_bios.h	conflict!
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
> > > +
> > > +Why do we want that?  Virtual machines often make use of direct device
> > > +access ("device assignment") when configured for the highest possible
> > > +I/O performance.  From a device and host perspective, this simply turns
> > > +the VM into a userspace driver, with the benefits of significantly
> > > +reduced latency, higher bandwidth, and direct use of bare-metal device
> > > +drivers[2].
> > 
> > Are there any constraints of running a 32-bit userspace with
> > a 64-bit kernel and with 32-bit user space drivers?
> 
> Shouldn't be.  I'll need to do some testing on that, but it was working
> on the previous generation of vfio.

<nods> ok
.. snip..

> > > +#define VFIO_IOMMU_GET_FLAGS            _IOR(';', 105, __u64)
> > > + #define VFIO_IOMMU_FLAGS_MAP_ANY       (1 << 0)
> > > +#define VFIO_IOMMU_MAP_DMA              _IOWR(';', 106, struct vfio_dma_map)
> > > +#define VFIO_IOMMU_UNMAP_DMA            _IOWR(';', 107, struct vfio_dma_map)
> > 
> > Coherency support is not going to be addressed right? What about sync?
> > Say you need to sync CPU to Device address?
> 
> Do we need to expose that to userspace or should the underlying
> iommu_ops take care of it?

That I am not sure of. I know that the kernel drivers (especially network ones)
are riddled with:

pci_dma_sync_single_for_cpu(tp->pdev, dma_addr, len, PCI_DMA_FROMDEVICE);
skb_copy_from_linear_data(skb, copy_skb->data, len); 
pci_dma_sync_single_for_device(tp->pdev, dma_addr, len, PCI_DMA_FROMDEVICE);


But I think that has come from the fact that the devices are 32-bit
so they could not do DMA above 4GB. Hence the bounce buffer usage and
the proliferation of pci_dma_sync.. calls to copy the contents to a
bounce buffer if neccessary.

But IOMMUs seem to deal with devices that can map the full gamma of memory
so they are not constrained to that 32-bit or 36-bit, but rather
they do the mapping in hardware if neccessary.

So I think I just answered the question - which is: No.
.. snip..
> > > +        __u64   vaddr;          /* process virtual addr */
> > > +        __u64   dmaaddr;        /* desired and/or returned dma address */
> > > +        __u64   size;           /* size in bytes */
> > > +        __u64   flags;
> > > +#define VFIO_DMA_MAP_FLAG_WRITE         (1 << 0) /* req writeable DMA mem */
> > > +};
> > > +
> > > +Current users of VFIO use relatively static DMA mappings, not requiring
> > > +high frequency turnover.  As new users are added, it's expected that the
> > 
> > Is there a limit to how many DMA mappings can be created?
> 
> Not that I'm aware of for the current AMD-Vi/VT-d implementations.  I
> suppose iommu_ops would return -ENOSPC if it hit a limit.  I added the

Not -ENOMEM? Either way, might want to mention that in this nice
document.

> VFIO_IOMMU_FLAGS_MAP_ANY flag above to try to identify that kind of
> restriction.

.. snip..

> > > +The GET_NUM_REGIONS ioctl tells us how many regions the device supports:
> > > +
> > > +#define VFIO_DEVICE_GET_NUM_REGIONS     _IOR(';', 109, int)
> > 
> > Don't want __u32?
> 
> It could be, not sure if it buys us anything maybe even restricts us.
> We likely don't need 2^32 regions (famous last words?), so we could
> later define <0 to something?

OK.
> 
> > > +
> > > +Regions are described by a struct vfio_region_info, which is retrieved by
> > > +using the GET_REGION_INFO ioctl with vfio_region_info.index field set to
> > > +the desired region (0 based index).  Note that devices may implement zero
> > > 
> > +sized regions (vfio-pci does this to provide a 1:1 BAR to region index
> > > +mapping).
> > 
> > Huh?
> 
> PCI has the following static mapping:
> 
> enum {
>         VFIO_PCI_BAR0_REGION_INDEX,
>         VFIO_PCI_BAR1_REGION_INDEX,
>         VFIO_PCI_BAR2_REGION_INDEX,
>         VFIO_PCI_BAR3_REGION_INDEX,
>         VFIO_PCI_BAR4_REGION_INDEX,
>         VFIO_PCI_BAR5_REGION_INDEX,
>         VFIO_PCI_ROM_REGION_INDEX,
>         VFIO_PCI_CONFIG_REGION_INDEX,
>         VFIO_PCI_NUM_REGIONS
> };
> 
> So 8 regions are always reported regardless of whether the device
> implements all the BARs and the ROM.  Then we have a fixed bar:index
> mapping so we don't have to create a region_info field to describe the
> bar number for the index.

OK. Is that a problem if the real device actually has a zero sized BAR?
Or is zero sized BAR in PCI spec equal to "disabled, not in use" ? Just
wondering whether (-1ULL) should be used instead? (Which seems the case
in QEMU code).

> 
> > > +
> > > +struct vfio_region_info {
> > > +        __u32   len;            /* length of structure */
> > > +        __u32   index;          /* region number */
> > > +        __u64   size;           /* size in bytes of region */
> > > +        __u64   offset;         /* start offset of region */
> > > +        __u64   flags;
> > > +#define VFIO_REGION_INFO_FLAG_MMAP              (1 << 0)
> > > +#define VFIO_REGION_INFO_FLAG_RO                (1 << 1)
> > > +#define VFIO_REGION_INFO_FLAG_PHYS_VALID        (1 << 2)
> > 
> > What is FLAG_MMAP? Does it mean: 1) it can be mmaped, or 2) it is mmaped?
> 
> Supports mmap

> 
> > FLAG_RO is pretty obvious - presumarily this is for firmware regions and such.
> > And PHYS_VALID is if the region is disabled for some reasons? If so
> > would the name FLAG_DISABLED be better?
> 
> No, POWER guys have some need to report the host physical address of the
> region, so the flag indicates whether the below field is present and
> valid.  I'll clarify these in the docs.

Thanks.
.. snip..
> > > +struct vfio_irq_info {
> > > +        __u32   len;            /* length of structure */
> > > +        __u32   index;          /* IRQ number */
> > > +        __u32   count;          /* number of individual IRQs */
> > > +        __u64   flags;
> > > +#define VFIO_IRQ_INFO_FLAG_LEVEL                (1 << 0)
> > > +};
> > > +
> > > +Again, zero count entries are allowed (vfio-pci uses a static interrupt
> > > +type to index mapping).
> > 
> > I am not really sure what that means.
> 
> This is so PCI can expose:
> 
> enum {
>         VFIO_PCI_INTX_IRQ_INDEX,
>         VFIO_PCI_MSI_IRQ_INDEX,
>         VFIO_PCI_MSIX_IRQ_INDEX,
>         VFIO_PCI_NUM_IRQS
> };
> 
> So like regions it always exposes 3 IRQ indexes where count=0 if the
> device doesn't actually support that type of interrupt.  I just want to
> spell out that bus drivers have this kind of flexibility.

I think you should change the comment that  says 'IRQ number', as the
first thing that comes in my mind is 'GSI' or MSI/MSI-x vector.
Perhaps '/* index to be used with return value from GET_NUM_IRQS ioctl.
Order of structures can be unsorted. */

> 
> > > +
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
> > 
> > Are eventfds u64 or u32?
> 
> int, they're just file descriptors
> 
> > Why not just define a structure?
> > struct vfio_irq_eventfds {
> > 	__u32	index;
> > 	__u32	count;
> > 	__u64	eventfds[0]
> > };
> 
> We could do that if preferred.  Hmm, are we then going to need
> size/flags?

Sure.

> 
> > How do you get an eventfd to feed in here?
> 
> eventfd(2), in qemu event_notifier_init() -> event_notifier_get_fd()
> 
> > > +#define VFIO_DEVICE_SET_IRQ_EVENTFDS    _IOW(';', 113, int)
> > 
> > u32?
> 
> Not here, it's an fd, so should be an int.
> 
> > > +
> > > +When a level triggered interrupt is signaled, the interrupt is masked
> > > +on the host.  This prevents an unresponsive userspace driver from
> > > +continuing to interrupt the host system.  After servicing the interrupt,
> > > +UNMASK_IRQ is used to allow the interrupt to retrigger.  Note that level
> > > +triggered interrupts implicitly have a count of 1 per index.
> > 
> > So they are enabled automatically? Meaning you don't even hav to do
> > SET_IRQ_EVENTFDS b/c the count is set to 1?
> 
> I suppose that should be "no more than 1 per index" (ie. PCI would
> report a count of 0 for VFIO_PCI_INTX_IRQ_INDEX if the device doesn't
> support INTx).  I think you might be confusing VFIO_DEVICE_GET_IRQ_INFO
> which tells how many are available with VFIO_DEVICE_SET_IRQ_EVENTFDS
> which does the enabling/disabling.  All interrupts are disabled by
> default because userspace needs to give us a way to signal them via
> eventfds.  It will be device dependent whether multiple index can be
> enabled simultaneously.  Hmm, is that another flag on the irq_info
> struct or do we expect drivers to implicitly have that kind of
> knowledge?

Right, that was what I was wondering. Not sure how the PowerPC
world works with this.

> 
> > > +
> > > +/* Unmask IRQ index, arg[0] = index */
> > > +#define VFIO_DEVICE_UNMASK_IRQ          _IOW(';', 114, int)
> > 
> > So this is for MSI as well? So if I've an index = 1, with count = 4,
> > and doing unmaks IRQ will chip enable all the MSI event at once?
> 
> No, this is only for re-enabling level triggered interrupts as discussed
> above.  Edge triggered interrupts like MSI don't need an unmask... we
> may want to do something to accelerate the MSI-X table access for
> masking specific interrupts, but I figured that would need to be PCI
> aware since those are PCI features, and would therefore be some future
> extension of the PCI bus driver and exposed via VFIO_DEVICE_GET_FLAGS.

OK.
> 
> > I guess there is not much point in enabling/disabling selective MSI
> > IRQs..
> 
> Some older OSes are said to make extensive use of masking for MSI, so we
> probably want this at some point.  I'm assuming future PCI extension for
> now.
> 
> > > +
> > > +Level triggered interrupts can also be unmasked using an irqfd.  Use
> > 
> > irqfd or eventfd?
> 
> irqfd is an eventfd in reverse.  eventfd = kernel signals userspace via
> an fd, irqfd = userspace signals kernel via an fd.

Ah neat.

> 
> > > +SET_UNMASK_IRQ_EVENTFD to set the file descriptor for this.
> > 
> > So only level triggered? Hmm, how do I know whether the device is
> > level or edge? Or is that edge (MSI) can also be unmaked using the
> > eventfs
> 
> Yes, only for level.  Isn't a device going to know what type of
> interrupt it uses?  MSI masking is PCI specific, not handled by this.

I certainly hope it knows, but you know buggy drivers do exist.

What would be the return value if somebody tried to unmask an edge one?
Should that be documented here? -ENOSPEC?

> 
> > > +
> > > +/* Set unmask eventfd, arg[0] = index, arg[1] = eventfd */
> > > +#define VFIO_DEVICE_SET_UNMASK_IRQ_EVENTFD      _IOW(';', 115, int)
> > > +
> > > +When supported, as indicated by the device flags, reset the device.
> > > +
> > > +#define VFIO_DEVICE_RESET               _IO(';', 116)
> > 
> > Does it disable the 'count'? Err, does it disable the IRQ on the
> > device after this and one should call VFIO_DEVICE_SET_IRQ_EVENTFDS
> > to set new eventfds? Or does it re-use the eventfds and the device
> > is enabled after this?
> 
> It doesn't affect the interrupt programming.  Should it?

I would hope not, but I am trying to think of ways one could screw this up.
Perhaps just saying that - "No need to call VFIO_DEVICE_SET_IRQ_EVENTFDS
as the kernel (and the device) will retain the interrupt.".
.. snip..
> > I am not really sure what this section purpose is? Could this be part
> > of the header file or the code? It does not look to be part of the
> > ioctl API?
> 
> We've passed into the "VFIO bus driver API" section of the document, to
> explain the interaction between vfio-core and vfio bus drivers.

Perhaps a different file?
.. large snip ..
> > > +
> > > +	mutex_lock(&iommu->dgate);
> > > +	list_for_each_safe(pos, pos2, &iommu->dm_list) {
> > > +		mlp = list_entry(pos, struct dma_map_page, list);
> > > +		vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> > 
> > Uh, so if it did not get put_page() we would try to still delete it?
> > Couldn't that lead to corruption as the 'mlp' is returned to the poll?
> > 
> > Ah wait, the put_page is on the DMA page, so it is OK to
> > delete the tracking structure. It will be just a leaked page.
> 
> Assume you're referencing this chunk:
> 
> vfio_dma_unmap
>   __vfio_dma_unmap
>     ...
>         pfn = iommu_iova_to_phys(iommu->domain, iova) >> PAGE_SHIFT;
>         if (pfn) {
>                 iommu_unmap(iommu->domain, iova, 0);
>                 unlocked += put_pfn(pfn, rdwr);
>         }
> 
> So we skip things that aren't mapped in the iommu, but anything not
> mapped should have already been put (failed vfio_dma_map).  If it is
> mapped, we put it if we originally got it via get_user_pages_fast.
> unlocked would only not get incremented here if it was an mmap'd page
> (such as the mmap of an mmio space of another vfio device), via the code
> in vaddr_get_pfn (stolen from KVM).

Yup. Sounds right.
.. snip..
> > > +module_param(allow_unsafe_intrs, int, 0);
> > 
> > S_IRUGO ?
> 
> I actually intended that to be S_IRUGO | S_IWUSR just like the kvm
> parameter so it can be toggled runtime.

OK.
> 
> > > +MODULE_PARM_DESC(allow_unsafe_intrs,
> > > +        "Allow use of IOMMUs which do not support interrupt remapping");
> > > +
> > > +static struct vfio {
> > > +	dev_t			devt;
> > > +	struct cdev		cdev;
> > > +	struct list_head	group_list;
> > > +	struct mutex		lock;
> > > +	struct kref		kref;
> > > +	struct class		*class;
> > > +	struct idr		idr;
> > > +	wait_queue_head_t	release_q;
> > > +} vfio;
> > 
> > You probably want to move this below the 'vfio_group'
> > as vfio contains the vfio_group.
> 
> Only via the group_list.  Are you suggesting for readability or to avoid
> forward declarations (which we don't need between these two with current
> ordering).

Just for readability.

> 
> > > +
> > > +static const struct file_operations vfio_group_fops;
> > > +extern const struct file_operations vfio_iommu_fops;
> > > +
> > > +struct vfio_group {
> > > +	dev_t			devt;
> > > +	unsigned int		groupid;
> > > +	struct bus_type		*bus;
> > > +	struct vfio_iommu	*iommu;
> > > +	struct list_head	device_list;
> > > +	struct list_head	iommu_next;
> > > +	struct list_head	group_next;
> > > +	int			refcnt;
> > > +};
> > > +
> > > +struct vfio_device {
> > > +	struct device			*dev;
> > > +	const struct vfio_device_ops	*ops;
> > > +	struct vfio_iommu		*iommu;
> > > +	struct vfio_group		*group;
> > > +	struct list_head		device_next;
> > > +	bool				attached;
> > > +	int				refcnt;
> > > +	void				*device_data;
> > > +};
> > 
> > And perhaps move this above vfio_group. As vfio_group
> > contains a list of these structures?
> 
> These are inter-linked, so chicken and egg.  The current ordering is
> more function based than definition based.  struct vfio is the highest
> level object, groups are next, iommus and devices are next, but we need
> to share iommus with the other file, so that lands in the header.

Ah, OK.
> 
> > > +
> > > +/*
> > > + * Helper functions called under vfio.lock
> > > + */
> > > +
> > > +/* Return true if any devices within a group are opened */
> > > +static bool __vfio_group_devs_inuse(struct vfio_group *group)
> > > +{
> > > +	struct list_head *pos;
> > > +
> > > +	list_for_each(pos, &group->device_list) {
> > > +		struct vfio_device *device;
> > > +
> > > +		device = list_entry(pos, struct vfio_device, device_next);
> > > +		if (device->refcnt)
> > > +			return true;
> > > +	}
> > > +	return false;
> > > +}
> > > +
> > > +/* Return true if any of the groups attached to an iommu are opened.
> > > + * We can only tear apart merged groups when nothing is left open. */
> > > +static bool __vfio_iommu_groups_inuse(struct vfio_iommu *iommu)
> > > +{
> > > +	struct list_head *pos;
> > > +
> > > +	list_for_each(pos, &iommu->group_list) {
> > > +		struct vfio_group *group;
> > > +
> > > +		group = list_entry(pos, struct vfio_group, iommu_next);
> > > +		if (group->refcnt)
> > > +			return true;
> > > +	}
> > > +	return false;
> > > +}
> > > +
> > > +/* An iommu is "in use" if it has a file descriptor open or if any of
> > > + * the groups assigned to the iommu have devices open. */
> > > +static bool __vfio_iommu_inuse(struct vfio_iommu *iommu)
> > > +{
> > > +	struct list_head *pos;
> > > +
> > > +	if (iommu->refcnt)
> > > +		return true;
> > > +
> > > +	list_for_each(pos, &iommu->group_list) {
> > > +		struct vfio_group *group;
> > > +
> > > +		group = list_entry(pos, struct vfio_group, iommu_next);
> > > +
> > > +		if (__vfio_group_devs_inuse(group))
> > > +			return true;
> > > +	}
> > > +	return false;
> > > +}
> > > +
> > > +static void __vfio_group_set_iommu(struct vfio_group *group,
> > > +				   struct vfio_iommu *iommu)
> > > +{
> > > +	struct list_head *pos;
> > > +
> > > +	if (group->iommu)
> > > +		list_del(&group->iommu_next);
> > > +	if (iommu)
> > > +		list_add(&group->iommu_next, &iommu->group_list);
> > > +
> > > +	group->iommu = iommu;
> > > +
> > > +	list_for_each(pos, &group->device_list) {
> > > +		struct vfio_device *device;
> > > +
> > > +		device = list_entry(pos, struct vfio_device, device_next);
> > > +		device->iommu = iommu;
> > > +	}
> > > +}
> > > +
> > > +static void __vfio_iommu_detach_dev(struct vfio_iommu *iommu,
> > > +				    struct vfio_device *device)
> > > +{
> > > +	BUG_ON(!iommu->domain && device->attached);
> > 
> > Whoa. Heavy hammer there.
> > 
> > Perhaps WARN_ON as you do check it later on.
> 
> I think it's warranted, internal consistency is broken if we have a
> device that thinks it's attached to an iommu domain that doesn't exist.
> It should, of course, never happen and this isn't a performance path.
> 
> > > +
> > > +	if (!iommu->domain || !device->attached)
> > > +		return;

Well, the deal is that you BUG_ON earlier, but you check for it here.
But the BUG_ON will stop execution , so the check 'if ..' is actually
not needed.


> > > +
> > > +	iommu_detach_device(iommu->domain, device->dev);
> > > +	device->attached = false;
> > > +}
> > > +
> > > +static void __vfio_iommu_detach_group(struct vfio_iommu *iommu,
> > > +				      struct vfio_group *group)
> > > +{
> > > +	struct list_head *pos;
> > > +
> > > +	list_for_each(pos, &group->device_list) {
> > > +		struct vfio_device *device;
> > > +
> > > +		device = list_entry(pos, struct vfio_device, device_next);
> > > +		__vfio_iommu_detach_dev(iommu, device);
> > > +	}
> > > +}
> > > +
> > > +static int __vfio_iommu_attach_dev(struct vfio_iommu *iommu,
> > > +				   struct vfio_device *device)
> > > +{
> > > +	int ret;
> > > +
> > > +	BUG_ON(device->attached);
> > 
> > How about:
> > 
> > WARN_ON(device->attached, "The engineer who wrote the user-space device driver is trying to register
> > the device again! Tell him/her to stop please.\n");
> 
> I would almost demote this one to a WARN_ON, but userspace isn't in
> control of attaching and detaching devices from the iommu.  That's a
> side effect of getting the iommu or device file descriptor.  So again,
> this is an internal consistency check and it should never happen,
> regardless of userspace.
> 

Ok, then you might want to expand it to

BUG_ON(!device  || device->attached);

In case something has gone horribly wrong.


.. snip..
> > > +		group->devt = MKDEV(MAJOR(vfio.devt), minor);
> > > +		device_create(vfio.class, NULL, group->devt,
> > > +			      group, "%u", groupid);
> > > +
> > > +		group->bus = dev->bus;
> > 
> > 
> > Oh, so that is how the IOMMU iommu_ops get copied! You might
> > want to mention that - I was not sure where the 'handoff' is
> > was done to insert a device so that it can do iommu_ops properly.
> > 
> > Ok, so the time when a device is detected whether it can do
> > IOMMU is when we try to open it - as that is when iommu_domain_alloc
> > is called which can return NULL if the iommu_ops is not set.
> > 
> > So what about devices that don't have an iommu_ops? Say they
> > are using SWIOTLB? (like the AMD-Vi sometimes does if the
> > device is not on its list).
> > 
> > Can we use iommu_present?
> 
> I'm not sure I'm following your revelation ;)  Take a look at the

I am trying to figure out who sets the iommu_ops call on the devices.

> pointer to iommu_device_group I pasted above, or these:
> 
> https://github.com/awilliam/linux-vfio/commit/37dd08c90d149caaed7779d4f38850a8f7ed0fa5
> https://github.com/awilliam/linux-vfio/commit/63ca8543533d8130db23d7949133e548c3891c97
> https://github.com/awilliam/linux-vfio/commit/8d7d70eb8e714fbf8710848a06f8cab0c741631e
> 
> That call includes an iommu_present() check, so if there's no iommu or
> the iommu can't provide a groupid, the device is skipped over from vfio
> (can't be used).
> 
> So the ordering is:
> 
>  - bus driver registers device
>    - if it has an iommu group, add it to the vfio device/group tracking
> 
>  - group gets opened
>    - user gets iommu or device fd results in iommu_domain_alloc
> 
> Devices without iommu_ops don't get to play in the vfio world.

Right, and I think the answer of which devices get iommu_ops is done via
bus_set_iommu.

(Thinking in long-term of what would be required to make this work
with Xen and it sounds like I will need to implement a Xen IOMMU driver)
 

.. snip..
> > 
> > So where is the vfio-pci? Is that a seperate posting?
> 
> You can find it in the tree pointed to in the patch description:
> 
> https://github.com/awilliam/linux-vfio/commit/534725d327e2b7791a229ce72d2ae8a62ee0a4e5

Thanks.

> 
> I was hoping to get some consensus around the new core before spending
> too much time polishing up the bus driver.  Thanks for the review, it's
> very much appreciated!

Sure thing.
> 
> Alex
> 
