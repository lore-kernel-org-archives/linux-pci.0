Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:50019
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752706Ab1KVUBU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2011 15:01:20 -0500
Message-ID: <4ECBFF75.4000807@freescale.com>
Date: Tue, 22 Nov 2011 14:00:53 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: <aafabbri@cisco.com>, <aik@au1.ibm.com>, <kvm@vger.kernel.org>,
	<pmac@au1.ibm.com>, <qemu-devel@nongnu.org>,
	<joerg.roedel@amd.com>, <konrad.wilk@oracle.com>, <agraf@suse.de>,
	David Gibson <dwg@au1.ibm.com>, <chrisw@sous-sol.org>,
	<B08248@freescale.com>, <iommu@lists.linux-foundation.org>,
	<avi@redhat.com>, <linux-pci@vger.kernel.org>,
	<B07421@freescale.com>, <benve@cisco.com>
Subject: Re: [Qemu-devel] [RFC PATCH] vfio: VFIO Driver core framework
References: <20111103195452.21259.93021.stgit@bling.home> <20111115063431.GA4921@truffala.fritz.box> <1321380088.17169.282.camel@bling.home> <20111117000218.GB5411@truffala.fritz.box> <1321648376.26410.238.camel@bling.home> <20111118210952.GA28979@schlenkerla.am.freescale.net> <CAEMbtc+2bs9WDqacyVZQKPkbpxX-mBb_w6S85jL2wHpMacX47Q@mail.gmail.com>
In-Reply-To: <CAEMbtc+2bs9WDqacyVZQKPkbpxX-mBb_w6S85jL2wHpMacX47Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/22/2011 01:16 PM, Alex Williamson wrote:
> On Fri, Nov 18, 2011 at 2:09 PM, Scott Wood <scottwood@freescale.com> wrote:
>> On Fri, Nov 18, 2011 at 01:32:56PM -0700, Alex Williamson wrote:
>>> Ugh, I suppose you're thinking of an ILP64 platform with ILP32 compat
>>> mode.
>>
>> Does Linux support ILP64?  There are "int" ioctls all over the place, and
>> I don't think we do compat wrappers for them.  In fact, some of the
>> ioctls in linux/fs.h use "int" for the compatible version of ioctls
>> originally defined as "long".
>>
>> It's cleaner to always use the fixed types, though.
> 
> I've updated anything that passes data to use a structure 

That's a bit extreme...

> and will make use of __s32 in place of ints.  If there ever exists an ILP64
> system, we can use a flag bit of the structure to indicate 64bit file
> descriptor support.

If we end up supporting an ABI where compatibility between user and
kernel is broken even when we use fixed-size types and are careful about
alignment, we'll need a compat wrapper, and we'll know what ABI
userspace is supposed to be using.  I'm not sure how a flag would help.

>>> The point of the group is to provide a unit of ownership.  We can't let
>>> $userA open $groupid and fetch a device, then have $userB do the same,
>>> grabbing a different device.  The mappings will step on each other and
>>> the devices have no isolation.  We can't restrict that purely by file
>>> permissions or we'll have the same problem with sudo.
>>
>> What is the problem with sudo?  If you're running processes as the same
>> user, regardless of how, they're going to be able to mess with each
>> other.
> 
> Just trying to indicate that file permissions are easy to bypass and
> privileged users can inadvertently do stupid stuff.

Preventing stupid stuff can also prevent useful stuff.  Security and
accident-avoidance are different things.  "We can't let" is the domain
of the former.

> Kind of like request_region() in the kernel.   Kernel drivers are privileged, but
> we still want to enforce an owner of that region.  VFIO extends the
> ownership of a device to a single entity in userspace.  How do we
> identify that entity and keep others out?

That's fine as long as it's an optional safeguard that can be turned off
if needed.  Maybe require userspace to set a flag via some mechanism to
indicate it's opening the device in shared mode.

>> It would be nice if this limitation weren't excessively integrated into
>> the design -- in the embedded space we've got unusual partitioning
>> setups, including failover arrangements where partitions share devices.
>> The device may be configured with the IOMMU pointing only at regions that
>> are shared by both mms, or the non-shared regions may be reconfigured as
>> active ownership of the device gets handed around.
>>
>> It would be up to userspace code to make sure that the mappings don't
>> "step on each other".  The mapping could be done with whichever mm issued
>> the map call for a given region.
>>
>> For this use case, there is unlikely to be an issue with ownership
>> because there will not be separate privilege domains creating partitions
>> -- other use cases could refrain from enabling multiple-mm support unless
>> ownership issues are resolved.
>>
>> This doesn't need to be supported initially, but we should try to avoid
>> letting the assumption permeate the code.
> 
> So I'm hearing "we want to use this driver you're developing that's
> centered around using the iommu to securely provide access to a device
> from userspace, but can we do it without the iommu and can we loosen
> up the security a bit?"  Is that about right?  ;)  Thanks,

We have a variety of use cases for userspace and KVM-guest access to
devices.  Some of those involve an iommu, some don't.  Some involve
shared ownership (which isn't necessarily a loosening of security --
there's still an iommu, and access control on the vfio group), some
don't.  Some don't involve DMA at all.  I see no reason to have entirely
separate kernel mechanisms for these use cases.

I'm not asking you to implement any of this, just hoping you'll keep
such flexibility in mind when deciding on fundamental assumptions that
the code and API are to make.

-Scott

