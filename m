Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab1KQUwr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Nov 2011 15:52:47 -0500
Message-ID: <1321563126.2633.54.camel@x201.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	dwg@au1.ibm.com, joerg.roedel@amd.com, agraf@suse.de,
	benve@cisco.com, aafabbri@cisco.com, B08248@freescale.com,
	B07421@freescale.com, avi@redhat.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Date: Thu, 17 Nov 2011 13:52:06 -0700
In-Reply-To: <4EC3F746.4010408@freescale.com>
References: <20111103195452.21259.93021.stgit@bling.home>
	  <20111111175118.GA6946@phenom.dumpdata.com>
	 <1321049456.2682.220.camel@bling.home> <4EC3F746.4010408@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2011-11-16 at 11:47 -0600, Scott Wood wrote:
> On 11/11/2011 04:10 PM, Alex Williamson wrote:
> > 
> > Thanks Konrad!  Comments inline.
> > 
> > On Fri, 2011-11-11 at 12:51 -0500, Konrad Rzeszutek Wilk wrote:
> >> On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
> >>> +When supported, as indicated by the device flags, reset the device.
> >>> +
> >>> +#define VFIO_DEVICE_RESET               _IO(';', 116)
> >>
> >> Does it disable the 'count'? Err, does it disable the IRQ on the
> >> device after this and one should call VFIO_DEVICE_SET_IRQ_EVENTFDS
> >> to set new eventfds? Or does it re-use the eventfds and the device
> >> is enabled after this?
> > 
> > It doesn't affect the interrupt programming.  Should it?
> 
> It should probably clear any currently pending interrupts, as if the
> unmask IOCTL were called.

Sounds reasonable.

> >>> +device tree properties of the device:
> >>> +
> >>> +struct vfio_dtpath {
> >>> +        __u32   len;            /* length of structure */
> >>> +        __u32   index;
> >>
> >> 0 based I presume?
> > 
> > Everything else is, I would assume so/
> 
> Yes, it should be zero-based -- this matches how such indices are done
> in the kernel device tree APIs.
> 
> >>> +        __u64   flags;
> >>> +#define VFIO_DTPATH_FLAGS_REGION        (1 << 0)
> >>
> >> What is region in this context?? Or would this make much more sense
> >> if I knew what Device Tree actually is.
> > 
> > Powerpc guys, any comments?  This was their suggestion.  These are
> > effectively the first device specific extension, available when
> > VFIO_DEVICE_FLAGS_DT is set.
> 
> An assigned device may consist of an entire subtree of the device tree,
> and both register banks and interrupts can come from any node in the
> tree.  Region versus IRQ here indicates the context in which to
> interpret index, in order to retrieve the path of the node that supplied
> this particular region or IRQ.

Ok.  Thanks for the clarification.  We'll wait for the vfio-dt bus
driver before actually including this.

> >>> +};
> >>> +#define VFIO_DEVICE_GET_DTPATH          _IOWR(';', 117, struct vfio_dtpath)
> >>> +
> >>> +struct vfio_dtindex {
> >>> +        __u32   len;            /* length of structure */
> >>> +        __u32   index;
> >>> +        __u32   prop_type;
> >>
> >> Is that an enum type? Is this definied somewhere?
> >>> +        __u32   prop_index;
> >>
> >> What is the purpose of this field?
> > 
> > Need input from powerpc folks here
> 
> To identify what this resource (register bank or IRQ) this is, we need
> both the path to the node and the index into the reg or interrupts
> property within the node.
> 
> We also need to distinguish reg from ranges, and interrupts from
> interrupt-map.  As you suggested elsewhere in the thread, the device
> tree API should probably be left out for now, and added later along with
> the device tree "bus" driver.

Yep, I'll do that.

> >>> +static void __vfio_iommu_detach_dev(struct vfio_iommu *iommu,
> >>> +				    struct vfio_device *device)
> >>> +{
> >>> +	BUG_ON(!iommu->domain && device->attached);
> >>
> >> Whoa. Heavy hammer there.
> >>
> >> Perhaps WARN_ON as you do check it later on.
> > 
> > I think it's warranted, internal consistency is broken if we have a
> > device that thinks it's attached to an iommu domain that doesn't exist.
> > It should, of course, never happen and this isn't a performance path.
> > 
> [snip]
> >>> +static int __vfio_iommu_attach_dev(struct vfio_iommu *iommu,
> >>> +				   struct vfio_device *device)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	BUG_ON(device->attached);
> >>
> >> How about:
> >>
> >> WARN_ON(device->attached, "The engineer who wrote the user-space device driver is trying to register
> >> the device again! Tell him/her to stop please.\n");
> > 
> > I would almost demote this one to a WARN_ON, but userspace isn't in
> > control of attaching and detaching devices from the iommu.  That's a
> > side effect of getting the iommu or device file descriptor.  So again,
> > this is an internal consistency check and it should never happen,
> > regardless of userspace.
> 
> The rule isn't to use BUG for internal consistency checks and WARN for
> stuff userspace can trigger, but rather to use BUG if you cannot
> reasonably continue, WARN for "significant issues that need prompt
> attention" that are reasonably recoverable.  Most instances of WARN are
> internal consistency checks.

That makes sense.

> From include/asm-generic/bug.h:
> > If you're tempted to BUG(), think again:  is completely giving up
> > really the *only* solution?  There are usually better options, where
> > users don't need to reboot ASAP and can mostly shut down cleanly.

Ok, I'll make a cleanup pass of demoting BUG_ONs to WARN_ONs.  Thanks,

Alex

