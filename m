Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523Ab1LAVZh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 1 Dec 2011 16:25:37 -0500
Message-ID: <1322774717.26545.118.camel@bling.home>
Subject: Re: [Qemu-devel] [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Stuart Yoder <b08248@gmail.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, aafabbri@cisco.com,
	kvm@vger.kernel.org, pmac@au1.ibm.com, qemu-devel@nongnu.org,
	joerg.roedel@amd.com, konrad.wilk@oracle.com, agraf@suse.de,
	dwg@au1.ibm.com, chrisw@sous-sol.org, B08248@freescale.com,
	iommu@lists.linux-foundation.org, avi@redhat.com,
	linux-pci@vger.kernel.org, B07421@freescale.com, benve@cisco.com
Date: Thu, 01 Dec 2011 14:25:17 -0700
In-Reply-To: <CALRxmdAjeyyM3Ta+DCTxtdc_J69fnVko_9hzmjcLUCe8SskNnQ@mail.gmail.com>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <4ED43AD9.5090509@au1.ibm.com> <4ED43CFE.8040009@au1.ibm.com>
	 <1322538856.19120.126.camel@bling.home>
	 <1322594768.19120.194.camel@bling.home>
	 <CALRxmdDEGwA787gEgC3d_yU99TqOZOtWeDJ9N-QCQ3gxV8yyMw@mail.gmail.com>
	 <1322610273.19120.209.camel@bling.home>
	 <CALRxmdBaguEZD8CnogHv+mSPuLx9et1CGRAa8oO_182Pjjp6-Q@mail.gmail.com>
	 <1322672293.19120.232.camel@bling.home>
	 <CALRxmdAjeyyM3Ta+DCTxtdc_J69fnVko_9hzmjcLUCe8SskNnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2011-12-01 at 14:58 -0600, Stuart Yoder wrote:
> >> The attributes are not intrinsic features of the domain.  User space will
> >> need to set them.  But in thinking about it a bit more I think the attributes
> >> are more properties of the domain rather than a per map() operation
> >> characteristic.  I think a separate API might be appropriate.  Define a
> >> new set_domain_attrs() op in the iommu_ops.    In user space, perhaps
> >>  a new vfio group API-- VFIO_GROUP_SET_ATTRS,
> >> VFIO_GROUP_GET_ATTRS.
> >
> > In that case, you should definitely be following what Alexey is thinking
> > about with an iommu_setup IOMMU API callback.  I think it's shaping up
> > to do:
> >
> > x86:
> >  - Report any IOVA range restrictions imposed by hw implementation
> > POWER:
> >  - Request IOVA window size, report size and base
> > powerpc:
> >  - Set domain attributes, probably report range as well.
> 
> One other mechanism we need as well is the ability to
> enable/disable a domain.
> 
> For example-- suppose a device is assigned to a VM, the
> device is in use when the VM is abruptly terminated.  The
> VM terminate would shut off DMA at the IOMMU, but now
> the device is in an indeterminate state.   Some devices
> have no simple reset bit and getting the device back into
> a sane state could be complicated-- something the hypervisor
> doesn't want to do.
> 
> So now KVM restarts the VM, vfio init happens for the device
> and  the IOMMU for that device is re-configured,
> etc, but we really can't re-enable DMA until the guest OS tells us
> (via an hcall) that it is ready.   The guest needs to get the
> assigned device in a sane state before DMA is enabled.

Giant red flag.  We need to paravirtualize the guest?  Not on x86.  Some
devices are better for assignment than others.  PCI devices are moving
towards supporting standard reset mechanisms.

> Does this warrant a new domain enable/disable API, or should
> we make this part of the setup API we are discussing
> here?

What's wrong with simply not adding any DMA mapping entries until you
think your guest is ready?  Isn't that effectively the same thing?
Unmap ~= disable.  If the IOMMU API had a mechanism to toggle the iommu
domain on and off, I wouldn't be opposed to adding an ioctl to do it,
but it really seems like just a shortcut vs map/unmap.  Thanks,

Alex

