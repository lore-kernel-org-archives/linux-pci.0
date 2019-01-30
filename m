Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCBAC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 20:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AA3218AF
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 20:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfA3Uf0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:35:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387609AbfA3UfZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 15:35:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63599461CF;
        Wed, 30 Jan 2019 20:35:24 +0000 (UTC)
Received: from redhat.com (ovpn-126-0.rdu2.redhat.com [10.10.126.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 712C460462;
        Wed, 30 Jan 2019 20:35:21 +0000 (UTC)
Date:   Wed, 30 Jan 2019 15:35:16 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Message-ID: <20190130203516.GE5061@redhat.com>
References: <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com>
 <bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
 <20190130185652.GB17080@mellanox.com>
 <20190130192234.GD5061@redhat.com>
 <5a60507e-e781-d0a4-353e-32105ca7ace3@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a60507e-e781-d0a4-353e-32105ca7ace3@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 30 Jan 2019 20:35:25 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 12:52:44PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-30 12:22 p.m., Jerome Glisse wrote:
> > On Wed, Jan 30, 2019 at 06:56:59PM +0000, Jason Gunthorpe wrote:
> >> On Wed, Jan 30, 2019 at 10:17:27AM -0700, Logan Gunthorpe wrote:
> >>>
> >>>
> >>> On 2019-01-29 9:18 p.m., Jason Gunthorpe wrote:
> >>>> Every attempt to give BAR memory to struct page has run into major
> >>>> trouble, IMHO, so I like that this approach avoids that.
> >>>>
> >>>> And if you don't have struct page then the only kernel object left to
> >>>> hang meta data off is the VMA itself.
> >>>>
> >>>> It seems very similar to the existing P2P work between in-kernel
> >>>> consumers, just that VMA is now mediating a general user space driven
> >>>> discovery process instead of being hard wired into a driver.
> >>>
> >>> But the kernel now has P2P bars backed by struct pages and it works
> >>> well. 
> >>
> >> I don't think it works that well..
> >>
> >> We ended up with a 'sgl' that is not really a sgl, and doesn't work
> >> with many of the common SGL patterns. sg_copy_buffer doesn't work,
> >> dma_map, doesn't work, sg_page doesn't work quite right, etc.
> >>
> >> Only nvme and rdma got the special hacks to make them understand these
> >> p2p-sgls, and I'm still not convinced some of the RDMA drivers that
> >> want access to CPU addresses from the SGL (rxe, usnic, hfi, qib) don't
> >> break in this scenario.
> >>
> >> Since the SGLs become broken, it pretty much means there is no path to
> >> make GUP work generically, we have to go through and make everything
> >> safe to use with p2p-sgls before allowing GUP. Which, frankly, sounds
> >> impossible with all the competing objections.
> >>
> >> But GPU seems to have a problem unrelated to this - what Jerome wants
> >> is to have two faulting domains for VMA's - visible-to-cpu and
> >> visible-to-dma. The new op is essentially faulting the pages into the
> >> visible-to-dma category and leaving them invisible-to-cpu.
> >>
> >> So that duality would still have to exists, and I think p2p_map/unmap
> >> is a much simpler implementation than trying to create some kind of
> >> special PTE in the VMA..
> >>
> >> At least for RDMA, struct page or not doesn't really matter. 
> >>
> >> We can make struct pages for the BAR the same way NVMe does.  GPU is
> >> probably the same, just with more mememory at stake?  
> >>
> >> And maybe this should be the first implementation. The p2p_map VMA
> >> operation should return a SGL and the caller should do the existing
> >> pci_p2pdma_map_sg() flow.. 
> > 
> > For GPU it would not work, GPU might want to use main memory (because
> > it is running out of BAR space) it is a lot easier if the p2p_map
> > callback calls the right dma map function (for page or io) rather than
> > having to define some format that would pass down the information.
> 
> >>
> >> Worry about optimizing away the struct page overhead later?
> > 
> > Struct page do not fit well for GPU as the BAR address can be reprogram
> > to point to any page inside the device memory (think 256M BAR versus
> > 16GB device memory). Forcing struct page on GPU driver would require
> > major surgery to the GPU driver inner working and there is no benefit
> > to have from the struct page. So it is hard to justify this.
> 
> I think we have to consider the struct pages to track the address space,
> not what backs it (essentially what HMM is doing). If we need to add
> operations for the driver to map the address space/struct pages back to
> physical memory then do that. Creating a whole new idea that's tied to
> userspace VMAs still seems wrong to me.

VMA is the object RDMA works on, GPU driver have been working with
VMA too, where VMA is tie to only one specific GPU object. So the most
disrupting approach here is using struct page. It was never use and
will not be use in many driver. Updating those to struct page is too
risky and too much changes. The vma call back is something you can
remove at any time if you have something better that do not need major
surgery to GPU driver.

Cheers,
Jérôme
