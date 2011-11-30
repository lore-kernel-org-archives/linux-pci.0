Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756868Ab1K3Q6a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Nov 2011 11:58:30 -0500
Message-ID: <1322672293.19120.232.camel@bling.home>
Subject: Re: [Qemu-devel] [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Stuart Yoder <b08248@gmail.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, aafabbri@cisco.com,
	kvm@vger.kernel.org, pmac@au1.ibm.com, qemu-devel@nongnu.org,
	joerg.roedel@amd.com, konrad.wilk@oracle.com, agraf@suse.de,
	dwg@au1.ibm.com, chrisw@sous-sol.org, B08248@freescale.com,
	iommu@lists.linux-foundation.org, avi@redhat.com,
	linux-pci@vger.kernel.org, B07421@freescale.com, benve@cisco.com
Date: Wed, 30 Nov 2011 09:58:13 -0700
In-Reply-To: <CALRxmdBaguEZD8CnogHv+mSPuLx9et1CGRAa8oO_182Pjjp6-Q@mail.gmail.com>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <4ED43AD9.5090509@au1.ibm.com> <4ED43CFE.8040009@au1.ibm.com>
	 <1322538856.19120.126.camel@bling.home>
	 <1322594768.19120.194.camel@bling.home>
	 <CALRxmdDEGwA787gEgC3d_yU99TqOZOtWeDJ9N-QCQ3gxV8yyMw@mail.gmail.com>
	 <1322610273.19120.209.camel@bling.home>
	 <CALRxmdBaguEZD8CnogHv+mSPuLx9et1CGRAa8oO_182Pjjp6-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2011-11-30 at 09:41 -0600, Stuart Yoder wrote:
> On Tue, Nov 29, 2011 at 5:44 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Tue, 2011-11-29 at 17:20 -0600, Stuart Yoder wrote:
> >> >
> >> > BTW, github now has updated trees:
> >> >
> >> > git://github.com/awilliam/linux-vfio.git vfio-next-20111129
> >> > git://github.com/awilliam/qemu-vfio.git vfio-ng
> >>
> >> Hi Alex,
> >>
> >> Have been looking at vfio a bit.   A few observations and things
> >> we'll need to figure out as it relates to the Freescale iommu.
> >>
> >> __vfio_dma_map() assumes that mappings are broken into
> >> 4KB pages.   That will not be true for us.   We normally will be mapping
> >> much larger physically contiguous chunks for our guests.  Guests will
> >> get hugetlbfs backed memory with very large pages (e.g. 16MB,
> >> 64MB) or very large chunks allocated by some proprietary
> >> means.
> >
> > Hi Stuart,
> >
> > I think practically everyone has commented on the 4k mappings ;)  There
> > are a few problems around this.  The first is that iommu drivers don't
> > necessarily support sub-region unmapping, so if we map 1GB and later
> > want to unmap 4k, we can't do it atomically.  4k gives us the most
> > flexibility for supporting fine granularities.  Another problem is that
> > we're using get_user_pages to pin memory.  It's been suggested that we
> > should use mlock for this, but I can't find anything that prevents a
> > user from later munlock'ing the memory and then getting access to memory
> > they shouldn't have.  Those kind of limit us, but I don't see it being
> > an API problem for VFIO, just implementation.
> 
> Ok.
> 
> >> Also, mappings will have additional Freescale-specific attributes
> >> that need to get passed through to dma_map somehow.   For
> >> example, the iommu can stash directly into a CPU's cache
> >> and we have iommu mapping properties like the cache stash
> >> target id and an operation mapping attribute.
> >>
> >> How do you envision handling proprietary attributes
> >> in struct vfio_dma_map?
> >
> > Let me turn the question around, how do you plan to support proprietary
> > attributes in the IOMMU API?  Is the user level the appropriate place to
> > specify them, or are they an intrinsic feature of the domain?  We've
> > designed struct vfio_dma_map for extension, so depending on how many
> > bits you need, we can make a conduit using the flags directly or setting
> > a new flag to indicate presence of an arch specific attributes field.
> 
> The attributes are not intrinsic features of the domain.  User space will
> need to set them.  But in thinking about it a bit more I think the attributes
> are more properties of the domain rather than a per map() operation
> characteristic.  I think a separate API might be appropriate.  Define a
> new set_domain_attrs() op in the iommu_ops.    In user space, perhaps
>  a new vfio group API-- VFIO_GROUP_SET_ATTRS,
> VFIO_GROUP_GET_ATTRS.

In that case, you should definitely be following what Alexey is thinking
about with an iommu_setup IOMMU API callback.  I think it's shaping up
to do:

x86:
 - Report any IOVA range restrictions imposed by hw implementation
POWER:
 - Request IOVA window size, report size and base
powerpc:
 - Set domain attributes, probably report range as well.

Thanks,

Alex

