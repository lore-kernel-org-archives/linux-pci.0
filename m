Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12241 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbbE0Sbz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 14:31:55 -0400
From: William Davis <wdavis@nvidia.com>
To: "markh@compro.net" <markh@compro.net>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Terence Ripperda <TRipperda@nvidia.com>,
	"John Hubbard" <jhubbard@nvidia.com>,
	"jglisse@redhat.com" <jglisse@redhat.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: RE: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
Date: Wed, 27 May 2015 18:31:53 +0000
Message-ID: <6f77384007cd47eea5ecb4b60977fdac@HQMAIL106.nvidia.com>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
 <1431973504-5903-5-git-send-email-wdavis@nvidia.com>
 <20150519234300.GA31666@google.com> <555C79E5.9040507@compro.net>
 <ea891abe867444d193742030348a6ad1@HQMAIL106.nvidia.com>
 <555CDD6F.40304@compro.net>
 <202fc76456cf4f3aac02034d5366780c@HQMAIL106.nvidia.com>
 <555CE97A.1030805@compro.net>
In-Reply-To: <555CE97A.1030805@compro.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Mark Hounschell [mailto:markh@compro.net]
> Sent: Wednesday, May 20, 2015 3:07 PM
> To: William Davis; Bjorn Helgaas
> Cc: joro@8bytes.org; iommu@lists.linux-foundation.org; linux-pci@vger.kernel.org; Terence Ripperda;
> John Hubbard; jglisse@redhat.com; konrad.wilk@oracle.com; Jonathan Corbet; David S. Miller
> Subject: Re: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
> 
> >>
> >> I currently just do
> >>
> >> page = virt_to_page(__va(bus_address));
> >>
> >> then just use the normal API. Works for writes anyway.
> >>
> >
> > What platform is this on? I don't understand how that could work for
> > peer-to-peer. As I understand it, there are no 'struct page's for MMIO
> > regions, and you could actually end up with a very different page as a
> > result of that unchecked translation (e.g., a "valid" struct page, but
> > not in the peer's MMIO range at all).
> >
> 
> This is an x86-64 AMD 990FX chip set. Works fine. Every time. I do have
> the peers memory that is being written to mmap'd by the task that is
> doing this, but this works.
> 
> Mark
> 

I spent some time looking into this, and I was surprised to find it worked
for me too. At least, it seems like it works, but it is a dangerous
accident that it did, and so I think the patch is still necessary.

In the IOMMU mapping paths, the IOMMU drivers (at least on x86) only
really use the struct page * to get the physical address that it
references, and I think that's usually done exclusively with pointer
arithmetic these days. So you are getting a pointer to a struct page that
actually doesn't exist, because it's either in a hole or off the end of
the memory map.

You can verify this by calling dump_page() on the struct page * returned
by this calculation. On my Intel machine, this BUGs, unable to handle the
paging request when looking at the struct page fields. If I just use the
pointer without dereferencing it, the IOMMU paths can get the correct
physical address without any issues, but this is by accident and not by
design, nor is it portable, so we shouldn't rely on this technique.

Thanks,
Will

--
nvpublic
