Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46666 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab1KVTQi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2011 14:16:38 -0500
MIME-Version: 1.0
In-Reply-To: <20111118210952.GA28979@schlenkerla.am.freescale.net>
References: <20111103195452.21259.93021.stgit@bling.home>
	<20111115063431.GA4921@truffala.fritz.box>
	<1321380088.17169.282.camel@bling.home>
	<20111117000218.GB5411@truffala.fritz.box>
	<1321648376.26410.238.camel@bling.home>
	<20111118210952.GA28979@schlenkerla.am.freescale.net>
Date: Tue, 22 Nov 2011 12:16:32 -0700
Message-ID: <CAEMbtc+2bs9WDqacyVZQKPkbpxX-mBb_w6S85jL2wHpMacX47Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Scott Wood <scottwood@freescale.com>
Cc: aafabbri@cisco.com, aik@au1.ibm.com, kvm@vger.kernel.org,
	pmac@au1.ibm.com, qemu-devel@nongnu.org, joerg.roedel@amd.com,
	konrad.wilk@oracle.com, agraf@suse.de,
	David Gibson <dwg@au1.ibm.com>, chrisw@sous-sol.org,
	B08248@freescale.com, iommu@lists.linux-foundation.org,
	avi@redhat.com, linux-pci@vger.kernel.org, B07421@freescale.com,
	benve@cisco.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2011 at 2:09 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Fri, Nov 18, 2011 at 01:32:56PM -0700, Alex Williamson wrote:
>> Hmm, that might be cleaner than eliminating the size with just using
>> _IO().  So we might have something like:
>>
>> #define VFIO_IOMMU_MAP_DMA              _IOWR(';', 106, struct vfio_dma_map)
>> #define VFIO_IOMMU_MAP_DMA_V2           _IOWR(';', 106, struct vfio_dma_map_v2)
>>
>> For which the driver might do:
>>
>> case VFIO_IOMMU_MAP_DMA:
>> case VFIO_IOMMU_MAP_DMA_V2:
>> {
>>       struct vfio_dma_map map;
>>
>>       /* We don't care about the extra v2 bits */
>>       if (copy_from_user(&map, (void __user *)arg, sizeof map))
>>               return -EFAULT;
>
> That won't work if you have an old kernel that doesn't know about v2, and
> a new user that uses v2.  To make this work you'd have to strip out the
> size from the ioctl number before switching (but still use it when
> considering whether to access the v2 fields).  Simpler to just leave it
> out of the ioctl number and put it in the struct field as currently
> planned.

Ok, _IO for all ioctls passing structs then.

>> > > I think all our structure sizes are independent of host width.  If I'm
>> > > missing something, let me know.
>> >
>> > Ah, for structures, that might be true.  I was seeing the bunch of
>> > ioctl()s that take ints.
>>
>> Ugh, I suppose you're thinking of an ILP64 platform with ILP32 compat
>> mode.
>
> Does Linux support ILP64?  There are "int" ioctls all over the place, and
> I don't think we do compat wrappers for them.  In fact, some of the
> ioctls in linux/fs.h use "int" for the compatible version of ioctls
> originally defined as "long".
>
> It's cleaner to always use the fixed types, though.

I've updated anything that passes data to use a structure and will
make use of __s32 in place of ints.  If there ever exists an ILP64
system, we can use a flag bit of the structure to indicate 64bit file
descriptor support.

>> Darn it, guess we need to make everything 64bit, including file
>> descriptors.
>
> What's wrong with __u32/__s32 (or uint32_t/int32_t)?
>
> I really do not see Linux supporting an ABI that has no 32-bit type at
> all, especially in a situation where userspace compatibility is needed.
> If that does happen, the ABI breakage will go well beyond VFIO.

Yep, I think the structs fix this and still leave room for the impossible.

>> The point of the group is to provide a unit of ownership.  We can't let
>> $userA open $groupid and fetch a device, then have $userB do the same,
>> grabbing a different device.  The mappings will step on each other and
>> the devices have no isolation.  We can't restrict that purely by file
>> permissions or we'll have the same problem with sudo.
>
> What is the problem with sudo?  If you're running processes as the same
> user, regardless of how, they're going to be able to mess with each
> other.

Just trying to indicate that file permissions are easy to bypass and
privileged users can inadvertently do stupid stuff.  Kind of like
request_region() in the kernel.   Kernel drivers are privileged, but
we still want to enforce an owner of that region.  VFIO extends the
ownership of a device to a single entity in userspace.  How do we
identify that entity and keep others out?

> Is it possible to expose access to only specific groups via an
> individually-permissionable /dev/device, so only the entity handing out
> access to devices needs access to everything?

Yes, that's fundamental to vfio.  vfio-bus drivers enumerate devices
to the vfio-core.  Privileged users bind devices to the vfio-bus
driver creating viable groups.  Groups are represented as chardevs
under /dev/vfio.  If a user has permission to access the chardev, they
have the ability to use the devices.  Once they get a device or iommu
descriptor the group is tied to them via the struct mm and only they
are permitted to access the other devices in the group.

>> At one point we discussed a single open instance, but that
>> unnecessarily limits the user, so we settled on the mm.  Thanks,
>
> It would be nice if this limitation weren't excessively integrated into
> the design -- in the embedded space we've got unusual partitioning
> setups, including failover arrangements where partitions share devices.
> The device may be configured with the IOMMU pointing only at regions that
> are shared by both mms, or the non-shared regions may be reconfigured as
> active ownership of the device gets handed around.
>
> It would be up to userspace code to make sure that the mappings don't
> "step on each other".  The mapping could be done with whichever mm issued
> the map call for a given region.
>
> For this use case, there is unlikely to be an issue with ownership
> because there will not be separate privilege domains creating partitions
> -- other use cases could refrain from enabling multiple-mm support unless
> ownership issues are resolved.
>
> This doesn't need to be supported initially, but we should try to avoid
> letting the assumption permeate the code.

So I'm hearing "we want to use this driver you're developing that's
centered around using the iommu to securely provide access to a device
from userspace, but can we do it without the iommu and can we loosen
up the security a bit?"  Is that about right?  ;)  Thanks,

Alex
