Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:44102
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751554Ab1KLAOP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2011 19:14:15 -0500
Message-ID: <4EBDBA50.3070801@freescale.com>
Date: Fri, 11 Nov 2011 18:14:08 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: <chrisw@sous-sol.org>, <aik@au1.ibm.com>, <pmac@au1.ibm.com>,
	<dwg@au1.ibm.com>, <joerg.roedel@amd.com>, <agraf@suse.de>,
	<benve@cisco.com>, <aafabbri@cisco.com>, <B08248@freescale.com>,
	<B07421@freescale.com>, <avi@redhat.com>, <konrad.wilk@oracle.com>,
	<kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
References: <20111103195452.21259.93021.stgit@bling.home>
In-Reply-To: <20111103195452.21259.93021.stgit@bling.home>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/03/2011 03:12 PM, Alex Williamson wrote:
> +Many modern system now provide DMA and interrupt remapping facilities
> +to help ensure I/O devices behave within the boundaries they've been
> +allotted.  This includes x86 hardware with AMD-Vi and Intel VT-d as
> +well as POWER systems with Partitionable Endpoints (PEs) and even
> +embedded powerpc systems (technology name unknown).  

Maybe replace "(technology name unknown)" with "(such as Freescale chips
with PAMU)" or similar?

Or just leave out the parenthetical.

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

This suggests the argument to VFIO_GROUP_GET_DEVICE_FD is a pointer to a
pointer to char rather than a pointer to an array of char (just as e.g.
VFIO_GROUP_MERGE takes a pointer to an int, not just an int).

> +The IOMMU file descriptor provides this set of ioctls:
> +
> +#define VFIO_IOMMU_GET_FLAGS            _IOR(';', 105, __u64)
> + #define VFIO_IOMMU_FLAGS_MAP_ANY       (1 << 0)
> +#define VFIO_IOMMU_MAP_DMA              _IOWR(';', 106, struct vfio_dma_map)
> +#define VFIO_IOMMU_UNMAP_DMA            _IOWR(';', 107, struct vfio_dma_map)

What is the implication if VFIO_IOMMU_FLAGS_MAP_ANY is clear?  Is such
an implementation supposed to add a new flag that describes its
restrictions?

Can we get a way to turn DMA access off and on, short of unmapping
everything, and then mapping it again?

> +The GET_FLAGS ioctl returns basic information about the IOMMU domain.
> +We currently only support IOMMU domains that are able to map any
> +virtual address to any IOVA.  This is indicated by the MAP_ANY flag.
> +
> +The (UN)MAP_DMA commands make use of struct vfio_dma_map for mapping
> +and unmapping IOVAs to process virtual addresses:
> +
> +struct vfio_dma_map {
> +        __u64   len;            /* length of structure */
> +        __u64   vaddr;          /* process virtual addr */
> +        __u64   dmaaddr;        /* desired and/or returned dma address */
> +        __u64   size;           /* size in bytes */
> +        __u64   flags;
> +#define VFIO_DMA_MAP_FLAG_WRITE         (1 << 0) /* req writeable DMA mem */
> +};

What are the semantics of "desired and/or returned dma address"?

Are we always supposed to provide a desired address, but it may be
different on return?  Or are there cases where we want to say "give me
whatever you want" or "give me this or fail"?

How much of this needs to be filled out for unmap?

Note that the "length of structure" approach means that ioctl numbers
will change whenever this grows -- perhaps we should avoid encoding the
struct size into these ioctls?

> +struct vfio_region_info {
> +        __u32   len;            /* length of structure */
> +        __u32   index;          /* region number */
> +        __u64   size;           /* size in bytes of region */
> +        __u64   offset;         /* start offset of region */
> +        __u64   flags;
> +#define VFIO_REGION_INFO_FLAG_MMAP              (1 << 0)
> +#define VFIO_REGION_INFO_FLAG_RO                (1 << 1)
> +#define VFIO_REGION_INFO_FLAG_PHYS_VALID        (1 << 2)
> +        __u64   phys;           /* physical address of region */
> +};
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
> +        __u64   flags;
> +#define VFIO_IRQ_INFO_FLAG_LEVEL                (1 << 0)

Make sure flags is 64-bit aligned -- some 32-bit ABIs, such as x86, will
not do this, causing problems if the kernel is 64-bit and thus assumes a
different layout.

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
> +continuing to interrupt the host system.

It's usually necessary even in the case of responsive userspace, just to
get to the point where userspace can execute (ignoring cases where
userspace runs on one core while the interrupt storms another).

For edge interrupts, will me mask if an interrupt comes in and the
previous interrupt hasn't been read out yet (and then unmask when the
last interrupt gets read out), to isolate us from a rapidly firing
interrupt source that userspace can't keep up with?

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

Where is length of buffer (and description of associated semantics)?

> +struct vfio_device_ops {
> +	bool			(*match)(struct device *, char *);

const char *?

> +	int			(*get)(void *);
> +	void			(*put)(void *);
> +	ssize_t			(*read)(void *, char __user *,
> +					size_t, loff_t *);
> +	ssize_t			(*write)(void *, const char __user *,
> +					 size_t, loff_t *);
> +	long			(*ioctl)(void *, unsigned int, unsigned long);
> +	int			(*mmap)(void *, struct vm_area_struct *);
> +};

When defining an API, please do not omit parameter names.

Should specify what the driver is supposed to do with get/put -- I guess
not try to unbind when the count is nonzero?  Races could still lead the
unbinder to be blocked, but I guess it lets the driver know when it's
likely to succeed.

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

Can we limit the IOMMU_API dependency to the IOMMU parts of VFIO?  It
would still be useful for devices which don't do DMA, or where we accept
the lack of protection/translation (e.g. we have a customer that wants
to do KVM device assignment on one of our lower-end chips that lacks an
IOMMU).

> +struct dma_map_page {
> +	struct list_head	list;
> +	dma_addr_t		daddr;
> +	unsigned long		vaddr;
> +	int			npage;
> +	int			rdwr;
> +};

npage should be long.

What is "rdwr"?  non-zero for write?  non-zero for read? :-)
is_write would be a better name.

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

There's no way to hand this stuff to the IOMMU driver in chunks larger
than a page?  That's going to be a problem for our IOMMU, which wants to
deal with large windows.

> +	vfio_lock_acct(locked);
> +	return 0;
> +}
> +
> +static inline int ranges_overlap(unsigned long start1, size_t size1,
> +				 unsigned long start2, size_t size2)
> +{
> +	return !(start1 + size1 <= start2 || start2 + size2 <= start1);
> +}

You pass DMA addresses to this, so use dma_addr_t.  unsigned long is not
always large enough.

What if one of the ranges wraps around (including the legitimate
possibility of start + size == 0)?

> +static long vfio_iommu_unl_ioctl(struct file *filep,
> +				 unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_iommu *iommu = filep->private_data;
> +	int ret = -ENOSYS;

-ENOIOCTLCMD or -ENOTTY?

> +
> +        if (cmd == VFIO_IOMMU_GET_FLAGS) {
> +                u64 flags = VFIO_IOMMU_FLAGS_MAP_ANY;
> +
> +                ret = put_user(flags, (u64 __user *)arg);
> +
> +        } else if (cmd == VFIO_IOMMU_MAP_DMA) {
> +		struct vfio_dma_map dm;

Whitespace.

Any reason not to use a switch?

> +/* Return true if any devices within a group are opened */
> +static bool __vfio_group_devs_inuse(struct vfio_group *group)
[snip]
> +static bool __vfio_iommu_groups_inuse(struct vfio_iommu *iommu)
[snip]
> +static bool __vfio_iommu_inuse(struct vfio_iommu *iommu)
[snip]
> +static void __vfio_group_set_iommu(struct vfio_group *group,
> +				   struct vfio_iommu *iommu)

...and so on.

Why all the leading underscores?  Doesn't look like you're trying to
distinguish between this and a more public version with the same name.

> +/* Get a new device file descriptor.  This will open the iommu, setting
> + * the current->mm ownership if it's not already set.  It's difficult to
> + * specify the requirements for matching a user supplied buffer to a
> + * device, so we use a vfio driver callback to test for a match.  For
> + * PCI, dev_name(dev) is unique, but other drivers may require including
> + * a parent device string. */
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

If there's a match, we're done with the loop -- might as well break out
now rather than indent everything else.

> +				struct file *file;
> +
> +				if (device->ops->get(device->device_data)) {
> +					ret = -EFAULT;
> +					goto out;
> +				}

Why does a failure of get() result in -EFAULT?  -EFAULT is for bad user
addresses.

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

Maybe cleaner with goto-based error management?

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

Factor this into vfio_dev_to_group() (and likewise for other such lookups)?

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

Factor out into vfio_create_group()?

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

It took me a little while to figure out that this was comparing bus
types, not actual bus instances (which would be an inappropriate
restriction). :-P

Still, isn't it what we really care about that it's the same IOMMU
domain?  Couldn't different bus types share an iommu_ops?

And again, -EFAULT isn't the right error.

-Scott

