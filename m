Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38210 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab1KNWr4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2011 17:47:56 -0500
References: <20111103195452.21259.93021.stgit@bling.home> <4EBDBA50.3070801@freescale.com> <1321304079.17169.74.camel@bling.home> <4EC195AB.60007@freescale.com>
In-Reply-To: <4EC195AB.60007@freescale.com>
Mime-Version: 1.0 (iPad Mail 8J2)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <90988001-B9CE-4469-9763-951F53948BE8@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	"<chrisw@sous-sol.org>" <chrisw@sous-sol.org>,
	"<aik@au1.ibm.com>" <aik@au1.ibm.com>,
	"<pmac@au1.ibm.com>" <pmac@au1.ibm.com>,
	"<dwg@au1.ibm.com>" <dwg@au1.ibm.com>,
	"<joerg.roedel@amd.com>" <joerg.roedel@amd.com>,
	"<benve@cisco.com>" <benve@cisco.com>,
	"<aafabbri@cisco.com>" <aafabbri@cisco.com>,
	"<B08248@freescale.com>" <B08248@freescale.com>,
	"<B07421@freescale.com>" <B07421@freescale.com>,
	"<avi@redhat.com>" <avi@redhat.com>,
	"<konrad.wilk@oracle.com>" <konrad.wilk@oracle.com>,
	"<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
	"<qemu-devel@nongnu.org>" <qemu-devel@nongnu.org>,
	"<iommu@lists.linux-foundation.org>"
	<iommu@lists.linux-foundation.org>,
	"<linux-pci@vger.kernel.org>" <linux-pci@vger.kernel.org>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
Date: Mon, 14 Nov 2011 23:48:27 +0100
To: Scott Wood <scottwood@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Am 14.11.2011 um 23:26 schrieb Scott Wood <scottwood@freescale.com>:

> On 11/14/2011 02:54 PM, Alex Williamson wrote:
>> On Fri, 2011-11-11 at 18:14 -0600, Scott Wood wrote:
>>> What are the semantics of "desired and/or returned dma address"?
>> 
>> I believe the original intention was that a user could leave dmaaddr
>> clear and let the iommu layer provide an iova address.  The iommu api
>> has since evolved and that mapping scheme really isn't present anymore.
>> We'll currently fail if we can map the requested address.  I'll update
>> the docs to make that be the definition.
> 
> OK... if there is any desire in the future to have the kernel pick an
> address (which could be useful for IOMMUs that don't set
> VFIO_IOMMU_FLAGS_MAP_ANY), there should be an explicit flag for this,
> since zero could be a valid address to request (doesn't mean "clear").
> 
>>> Note that the "length of structure" approach means that ioctl numbers
>>> will change whenever this grows -- perhaps we should avoid encoding the
>>> struct size into these ioctls?
>> 
>> How so?  What's described here is effectively the base size.  If we
>> later add feature foo requiring additional fields, we set a flag, change
>> the size, and tack those fields onto the end.  The kernel side should
>> balk if the size doesn't match what it expects from the flags it
>> understands (which I think I probably need to be more strict about).
> 
> The size of the struct is encoded into the ioctl number via the _IOWR()
> macro.  If we want the struct to be growable in the future, we should
> leave that out and just use _IO().  Otherwise if the size of the struct
> changes, the ioctl number changes.  This is annoying for old userspace
> plus new kernel (have to add compat entries to the switch), and broken
> for old kernel plus new userspace.

Avi wanted to write up a patch for this to allow ioctls with arbitrary size, for exctly this purpose.

> 
>>> Can we limit the IOMMU_API dependency to the IOMMU parts of VFIO?  It
>>> would still be useful for devices which don't do DMA, or where we accept
>>> the lack of protection/translation (e.g. we have a customer that wants
>>> to do KVM device assignment on one of our lower-end chips that lacks an
>>> IOMMU).
>> 
>> Ugh.  I'm not really onboard with it given that we're trying to sell
>> vfio as a secure user space driver interface with iommu-based
>> protection.
> 
> That's its main use case, but it doesn't make much sense to duplicate
> the non-iommu-related bits for other use cases.
> 
> This applies at runtime too, some devices don't do DMA at all (and thus
> may not be part of an IOMMU group, even if there is an IOMMU present for
> other devices -- could be considered a standalone group of one device,
> with a null IOMMU backend).  Support for such devices can wait, but it's
> good to keep the possibility in mind.

I agree. Potentially backing a device with a nop iommu also makes testing easier.

Alex

> 
