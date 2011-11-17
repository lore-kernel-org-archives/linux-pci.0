Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266Ab1KQUXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Nov 2011 15:23:01 -0500
Message-ID: <1321561337.2633.40.camel@x201.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	dwg@au1.ibm.com, joerg.roedel@amd.com, agraf@suse.de,
	benve@cisco.com, aafabbri@cisco.com, B08248@freescale.com,
	B07421@freescale.com, avi@redhat.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Date: Thu, 17 Nov 2011 13:22:17 -0700
In-Reply-To: <20111116165227.GB2793@phenom.dumpdata.com>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <20111111175118.GA6946@phenom.dumpdata.com>
	 <1321049456.2682.220.camel@bling.home>
	 <20111116165227.GB2793@phenom.dumpdata.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2011-11-16 at 11:52 -0500, Konrad Rzeszutek Wilk wrote:
> On Fri, Nov 11, 2011 at 03:10:56PM -0700, Alex Williamson wrote:
<snip>
> > > > +
> > > > +Regions are described by a struct vfio_region_info, which is retrieved by
> > > > +using the GET_REGION_INFO ioctl with vfio_region_info.index field set to
> > > > +the desired region (0 based index).  Note that devices may implement zero
> > > > 
> > > +sized regions (vfio-pci does this to provide a 1:1 BAR to region index
> > > > +mapping).
> > > 
> > > Huh?
> > 
> > PCI has the following static mapping:
> > 
> > enum {
> >         VFIO_PCI_BAR0_REGION_INDEX,
> >         VFIO_PCI_BAR1_REGION_INDEX,
> >         VFIO_PCI_BAR2_REGION_INDEX,
> >         VFIO_PCI_BAR3_REGION_INDEX,
> >         VFIO_PCI_BAR4_REGION_INDEX,
> >         VFIO_PCI_BAR5_REGION_INDEX,
> >         VFIO_PCI_ROM_REGION_INDEX,
> >         VFIO_PCI_CONFIG_REGION_INDEX,
> >         VFIO_PCI_NUM_REGIONS
> > };
> > 
> > So 8 regions are always reported regardless of whether the device
> > implements all the BARs and the ROM.  Then we have a fixed bar:index
> > mapping so we don't have to create a region_info field to describe the
> > bar number for the index.
> 
> OK. Is that a problem if the real device actually has a zero sized BAR?
> Or is zero sized BAR in PCI spec equal to "disabled, not in use" ? Just
> wondering whether (-1ULL) should be used instead? (Which seems the case
> in QEMU code).

Yes, PCI spec defines that unimplemented BARs are hardwired to zero, so
the sizing operation returns zero for the size.

<snip>
> > > > +struct vfio_irq_info {
> > > > +        __u32   len;            /* length of structure */
> > > > +        __u32   index;          /* IRQ number */
> > > > +        __u32   count;          /* number of individual IRQs */
> > > > +        __u64   flags;
> > > > +#define VFIO_IRQ_INFO_FLAG_LEVEL                (1 << 0)
> > > > +};
> > > > +
> > > > +Again, zero count entries are allowed (vfio-pci uses a static interrupt
> > > > +type to index mapping).
> > > 
> > > I am not really sure what that means.
> > 
> > This is so PCI can expose:
> > 
> > enum {
> >         VFIO_PCI_INTX_IRQ_INDEX,
> >         VFIO_PCI_MSI_IRQ_INDEX,
> >         VFIO_PCI_MSIX_IRQ_INDEX,
> >         VFIO_PCI_NUM_IRQS
> > };
> > 
> > So like regions it always exposes 3 IRQ indexes where count=0 if the
> > device doesn't actually support that type of interrupt.  I just want to
> > spell out that bus drivers have this kind of flexibility.
> 
> I think you should change the comment that  says 'IRQ number', as the
> first thing that comes in my mind is 'GSI' or MSI/MSI-x vector.
> Perhaps '/* index to be used with return value from GET_NUM_IRQS ioctl.
> Order of structures can be unsorted. */

Ah, yes.  I see the confusion.  They can't really be unsorted though,
the user needs some point of reference.  For PCI they will be strictly
ordered.  For Device Tree, I assume there will be a path referencing the
index.  I'll update the doc to clarify.

<snip>
> > > > +
> > > > +When a level triggered interrupt is signaled, the interrupt is masked
> > > > +on the host.  This prevents an unresponsive userspace driver from
> > > > +continuing to interrupt the host system.  After servicing the interrupt,
> > > > +UNMASK_IRQ is used to allow the interrupt to retrigger.  Note that level
> > > > +triggered interrupts implicitly have a count of 1 per index.
> > > 
> > > So they are enabled automatically? Meaning you don't even hav to do
> > > SET_IRQ_EVENTFDS b/c the count is set to 1?
> > 
> > I suppose that should be "no more than 1 per index" (ie. PCI would
> > report a count of 0 for VFIO_PCI_INTX_IRQ_INDEX if the device doesn't
> > support INTx).  I think you might be confusing VFIO_DEVICE_GET_IRQ_INFO
> > which tells how many are available with VFIO_DEVICE_SET_IRQ_EVENTFDS
> > which does the enabling/disabling.  All interrupts are disabled by
> > default because userspace needs to give us a way to signal them via
> > eventfds.  It will be device dependent whether multiple index can be
> > enabled simultaneously.  Hmm, is that another flag on the irq_info
> > struct or do we expect drivers to implicitly have that kind of
> > knowledge?
> 
> Right, that was what I was wondering. Not sure how the PowerPC
> world works with this.

On second thought, I think an exclusive flag isn't appropriate.  VFIO is
not meant to abstract the device to the level that a user could write a
generic "vfio driver".  The user will always need to understand the type
of device, VFIO just provides the conduit to make use of it.  There's
too much left undefined with a simplistic exclusive flag.

<snip>
> > > > +SET_UNMASK_IRQ_EVENTFD to set the file descriptor for this.
> > > 
> > > So only level triggered? Hmm, how do I know whether the device is
> > > level or edge? Or is that edge (MSI) can also be unmaked using the
> > > eventfs
> > 
> > Yes, only for level.  Isn't a device going to know what type of
> > interrupt it uses?  MSI masking is PCI specific, not handled by this.
> 
> I certainly hope it knows, but you know buggy drivers do exist.
> 
> What would be the return value if somebody tried to unmask an edge one?
> Should that be documented here? -ENOSPEC?

I would assume EINVAL or EFAULT since the user is providing an invalid
argument/bad address.

> > > > +
> > > > +/* Set unmask eventfd, arg[0] = index, arg[1] = eventfd */
> > > > +#define VFIO_DEVICE_SET_UNMASK_IRQ_EVENTFD      _IOW(';', 115, int)
> > > > +
> > > > +When supported, as indicated by the device flags, reset the device.
> > > > +
> > > > +#define VFIO_DEVICE_RESET               _IO(';', 116)
> > > 
> > > Does it disable the 'count'? Err, does it disable the IRQ on the
> > > device after this and one should call VFIO_DEVICE_SET_IRQ_EVENTFDS
> > > to set new eventfds? Or does it re-use the eventfds and the device
> > > is enabled after this?
> > 
> > It doesn't affect the interrupt programming.  Should it?
> 
> I would hope not, but I am trying to think of ways one could screw this up.
> Perhaps just saying that - "No need to call VFIO_DEVICE_SET_IRQ_EVENTFDS
> as the kernel (and the device) will retain the interrupt.".

Ok, I added some words around this in the doc.

> .. snip..
> > > I am not really sure what this section purpose is? Could this be part
> > > of the header file or the code? It does not look to be part of the
> > > ioctl API?
> > 
> > We've passed into the "VFIO bus driver API" section of the document, to
> > explain the interaction between vfio-core and vfio bus drivers.
> 
> Perhaps a different file?

The entire file is ~300 lines.  Seems excessive to split.

<snip>
> > > > +static void __vfio_iommu_detach_dev(struct vfio_iommu *iommu,
> > > > +				    struct vfio_device *device)
> > > > +{
> > > > +	BUG_ON(!iommu->domain && device->attached);
> > > 
> > > Whoa. Heavy hammer there.
> > > 
> > > Perhaps WARN_ON as you do check it later on.
> > 
> > I think it's warranted, internal consistency is broken if we have a
> > device that thinks it's attached to an iommu domain that doesn't exist.
> > It should, of course, never happen and this isn't a performance path.
> > 
> > > > +
> > > > +	if (!iommu->domain || !device->attached)
> > > > +		return;
> 
> Well, the deal is that you BUG_ON earlier, but you check for it here.
> But the BUG_ON will stop execution , so the check 'if ..' is actually
> not needed.

The BUG_ON is a subtly different check:

domain | attached
-------+---------
   0   |   0     Nothing to do
   0   |   1     <--- BUG_ON, we're broken
   1   |   0     Nothing to do
   1   |   1     Do stuff

Writing out the truth table, I see now I could just make this:
   if (!attached) {return;}
since the BUG_ON takes care of the other case.

The reason for the laziness of allowing this to simply return is that if
we hit an error attaching an individual device within a group, we just
push the whole group back through __vfio_iommu_detach_group(), so some
devices may have never been attached.

> > > > +
> > > > +	iommu_detach_device(iommu->domain, device->dev);
> > > > +	device->attached = false;
> > > > +}
> > > > +
> > > > +static void __vfio_iommu_detach_group(struct vfio_iommu *iommu,
> > > > +				      struct vfio_group *group)
> > > > +{
> > > > +	struct list_head *pos;
> > > > +
> > > > +	list_for_each(pos, &group->device_list) {
> > > > +		struct vfio_device *device;
> > > > +
> > > > +		device = list_entry(pos, struct vfio_device, device_next);
> > > > +		__vfio_iommu_detach_dev(iommu, device);
> > > > +	}
> > > > +}
> > > > +
> > > > +static int __vfio_iommu_attach_dev(struct vfio_iommu *iommu,
> > > > +				   struct vfio_device *device)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	BUG_ON(device->attached);
> > > 
> > > How about:
> > > 
> > > WARN_ON(device->attached, "The engineer who wrote the user-space device driver is trying to register
> > > the device again! Tell him/her to stop please.\n");
> > 
> > I would almost demote this one to a WARN_ON, but userspace isn't in
> > control of attaching and detaching devices from the iommu.  That's a
> > side effect of getting the iommu or device file descriptor.  So again,
> > this is an internal consistency check and it should never happen,
> > regardless of userspace.
> > 
> 
> Ok, then you might want to expand it to
> 
> BUG_ON(!device  || device->attached);
> 
> In case something has gone horribly wrong.

Impressive, that exceeds even my paranoia ;)  For that we would have had
to walk the group->device_list and come up with a NULL device pointer.
I think we can assume that won't happen.  I've also got this though:

        if (!iommu || !iommu->domain)
                return -EINVAL;

Which is effectively just being lazy without a good excuse like above.
That could probably be folded into the BUG_ON.
> 
> .. snip..
> > > > +		group->devt = MKDEV(MAJOR(vfio.devt), minor);
> > > > +		device_create(vfio.class, NULL, group->devt,
> > > > +			      group, "%u", groupid);
> > > > +
> > > > +		group->bus = dev->bus;
> > > 
> > > 
> > > Oh, so that is how the IOMMU iommu_ops get copied! You might
> > > want to mention that - I was not sure where the 'handoff' is
> > > was done to insert a device so that it can do iommu_ops properly.
> > > 
> > > Ok, so the time when a device is detected whether it can do
> > > IOMMU is when we try to open it - as that is when iommu_domain_alloc
> > > is called which can return NULL if the iommu_ops is not set.
> > > 
> > > So what about devices that don't have an iommu_ops? Say they
> > > are using SWIOTLB? (like the AMD-Vi sometimes does if the
> > > device is not on its list).
> > > 
> > > Can we use iommu_present?
> > 
> > I'm not sure I'm following your revelation ;)  Take a look at the
> 
> I am trying to figure out who sets the iommu_ops call on the devices.

The iommu driver registers ops with bus_set_iommu, so then we just need
to pass the bus pointer and iommu_ops figures out the rest.  If there's
no iommu_ops for a device or the iommu_ops doesn't implement the
device_group callback, it gets skipped by vfio and therefore won't be
usable by this interface.

> > pointer to iommu_device_group I pasted above, or these:
> > 
> > https://github.com/awilliam/linux-vfio/commit/37dd08c90d149caaed7779d4f38850a8f7ed0fa5
> > https://github.com/awilliam/linux-vfio/commit/63ca8543533d8130db23d7949133e548c3891c97
> > https://github.com/awilliam/linux-vfio/commit/8d7d70eb8e714fbf8710848a06f8cab0c741631e
> > 
> > That call includes an iommu_present() check, so if there's no iommu or
> > the iommu can't provide a groupid, the device is skipped over from vfio
> > (can't be used).
> > 
> > So the ordering is:
> > 
> >  - bus driver registers device
> >    - if it has an iommu group, add it to the vfio device/group tracking
> > 
> >  - group gets opened
> >    - user gets iommu or device fd results in iommu_domain_alloc
> > 
> > Devices without iommu_ops don't get to play in the vfio world.
> 
> Right, and I think the answer of which devices get iommu_ops is done via
> bus_set_iommu.

Exactly.

> (Thinking in long-term of what would be required to make this work
> with Xen and it sounds like I will need to implement a Xen IOMMU driver)

Yeah, that would make sense.  Thanks!

Alex

