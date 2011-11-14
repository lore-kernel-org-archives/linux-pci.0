Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58748 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755362Ab1KNVq5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Nov 2011 16:46:57 -0500
Message-ID: <1321307200.17169.90.camel@bling.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Scott Wood <scottwood@freescale.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	dwg@au1.ibm.com, joerg.roedel@amd.com, agraf@suse.de,
	benve@cisco.com, aafabbri@cisco.com, B08248@freescale.com,
	B07421@freescale.com, avi@redhat.com, konrad.wilk@oracle.com,
	kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Date: Mon, 14 Nov 2011 14:46:40 -0700
In-Reply-To: <1321304079.17169.74.camel@bling.home>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <4EBDBA50.3070801@freescale.com> <1321304079.17169.74.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2011-11-14 at 13:54 -0700, Alex Williamson wrote:
> On Fri, 2011-11-11 at 18:14 -0600, Scott Wood wrote:
> > On 11/03/2011 03:12 PM, Alex Williamson wrote: 
> > > +	for (i = 0; i < npage; i++, iova += PAGE_SIZE, vaddr += PAGE_SIZE) {
> > > +		unsigned long pfn = 0;
> > > +
> > > +		ret = vaddr_get_pfn(vaddr, rdwr, &pfn);
> > > +		if (ret) {
> > > +			__vfio_dma_unmap(iommu, start, i, rdwr);
> > > +			return ret;
> > > +		}
> > > +
> > > +		/* Only add actual locked pages to accounting */
> > > +		if (!is_invalid_reserved_pfn(pfn))
> > > +			locked++;
> > > +
> > > +		ret = iommu_map(iommu->domain, iova,
> > > +				(phys_addr_t)pfn << PAGE_SHIFT, 0, prot);
> > > +		if (ret) {
> > > +			/* Back out mappings on error */
> > > +			put_pfn(pfn, rdwr);
> > > +			__vfio_dma_unmap(iommu, start, i, rdwr);
> > > +			return ret;
> > > +		}
> > > +	}
> > 
> > There's no way to hand this stuff to the IOMMU driver in chunks larger
> > than a page?  That's going to be a problem for our IOMMU, which wants to
> > deal with large windows.
> 
> There is, this is just a simple implementation that maps individual
> pages.  We "just" need to determine physically contiguous chunks and
> mlock them instead of using get_user_pages.  The current implementation
> is much like how KVM maps iommu pages, but there shouldn't be a user API
> change to try to use larger chinks.  We want this for IOMMU large page
> support too.

Also, at one point intel-iommu didn't allow sub-ranges to be unmapped;
an unmap of a single page would unmap the entire original mapping that
contained that page.  That made it easier to map each page individually
for the flexibility it provided on unmap.  I need to see if we still
have that restriction.  Thanks,

Alex


