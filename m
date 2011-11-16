Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:44375 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab1KPRrz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2011 12:47:55 -0500
Message-ID: <4EC3F746.4010408@freescale.com>
Date: Wed, 16 Nov 2011 11:47:50 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<chrisw@sous-sol.org>, <aik@au1.ibm.com>, <pmac@au1.ibm.com>,
	<dwg@au1.ibm.com>, <joerg.roedel@amd.com>, <agraf@suse.de>,
	<benve@cisco.com>, <aafabbri@cisco.com>, <B08248@freescale.com>,
	<B07421@freescale.com>, <avi@redhat.com>, <kvm@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
References: <20111103195452.21259.93021.stgit@bling.home>  <20111111175118.GA6946@phenom.dumpdata.com> <1321049456.2682.220.camel@bling.home>
In-Reply-To: <1321049456.2682.220.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/11/2011 04:10 PM, Alex Williamson wrote:
> 
> Thanks Konrad!  Comments inline.
> 
> On Fri, 2011-11-11 at 12:51 -0500, Konrad Rzeszutek Wilk wrote:
>> On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
>>> +When supported, as indicated by the device flags, reset the device.
>>> +
>>> +#define VFIO_DEVICE_RESET               _IO(';', 116)
>>
>> Does it disable the 'count'? Err, does it disable the IRQ on the
>> device after this and one should call VFIO_DEVICE_SET_IRQ_EVENTFDS
>> to set new eventfds? Or does it re-use the eventfds and the device
>> is enabled after this?
> 
> It doesn't affect the interrupt programming.  Should it?

It should probably clear any currently pending interrupts, as if the
unmask IOCTL were called.

>>> +device tree properties of the device:
>>> +
>>> +struct vfio_dtpath {
>>> +        __u32   len;            /* length of structure */
>>> +        __u32   index;
>>
>> 0 based I presume?
> 
> Everything else is, I would assume so/

Yes, it should be zero-based -- this matches how such indices are done
in the kernel device tree APIs.

>>> +        __u64   flags;
>>> +#define VFIO_DTPATH_FLAGS_REGION        (1 << 0)
>>
>> What is region in this context?? Or would this make much more sense
>> if I knew what Device Tree actually is.
> 
> Powerpc guys, any comments?  This was their suggestion.  These are
> effectively the first device specific extension, available when
> VFIO_DEVICE_FLAGS_DT is set.

An assigned device may consist of an entire subtree of the device tree,
and both register banks and interrupts can come from any node in the
tree.  Region versus IRQ here indicates the context in which to
interpret index, in order to retrieve the path of the node that supplied
this particular region or IRQ.

>>> +};
>>> +#define VFIO_DEVICE_GET_DTPATH          _IOWR(';', 117, struct vfio_dtpath)
>>> +
>>> +struct vfio_dtindex {
>>> +        __u32   len;            /* length of structure */
>>> +        __u32   index;
>>> +        __u32   prop_type;
>>
>> Is that an enum type? Is this definied somewhere?
>>> +        __u32   prop_index;
>>
>> What is the purpose of this field?
> 
> Need input from powerpc folks here

To identify what this resource (register bank or IRQ) this is, we need
both the path to the node and the index into the reg or interrupts
property within the node.

We also need to distinguish reg from ranges, and interrupts from
interrupt-map.  As you suggested elsewhere in the thread, the device
tree API should probably be left out for now, and added later along with
the device tree "bus" driver.

>>> +static void __vfio_iommu_detach_dev(struct vfio_iommu *iommu,
>>> +				    struct vfio_device *device)
>>> +{
>>> +	BUG_ON(!iommu->domain && device->attached);
>>
>> Whoa. Heavy hammer there.
>>
>> Perhaps WARN_ON as you do check it later on.
> 
> I think it's warranted, internal consistency is broken if we have a
> device that thinks it's attached to an iommu domain that doesn't exist.
> It should, of course, never happen and this isn't a performance path.
> 
[snip]
>>> +static int __vfio_iommu_attach_dev(struct vfio_iommu *iommu,
>>> +				   struct vfio_device *device)
>>> +{
>>> +	int ret;
>>> +
>>> +	BUG_ON(device->attached);
>>
>> How about:
>>
>> WARN_ON(device->attached, "The engineer who wrote the user-space device driver is trying to register
>> the device again! Tell him/her to stop please.\n");
> 
> I would almost demote this one to a WARN_ON, but userspace isn't in
> control of attaching and detaching devices from the iommu.  That's a
> side effect of getting the iommu or device file descriptor.  So again,
> this is an internal consistency check and it should never happen,
> regardless of userspace.

The rule isn't to use BUG for internal consistency checks and WARN for
stuff userspace can trigger, but rather to use BUG if you cannot
reasonably continue, WARN for "significant issues that need prompt
attention" that are reasonably recoverable.  Most instances of WARN are
internal consistency checks.

>From include/asm-generic/bug.h:
> If you're tempted to BUG(), think again:  is completely giving up
> really the *only* solution?  There are usually better options, where
> users don't need to reboot ASAP and can mostly shut down cleanly.

-Scott

