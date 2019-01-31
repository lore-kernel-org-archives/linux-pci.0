Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D517C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D5120881
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfAaIN5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:13:57 -0500
Received: from verein.lst.de ([213.95.11.211]:56255 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfAaIN5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 03:13:57 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9A19368CEB; Thu, 31 Jan 2019 09:13:55 +0100 (CET)
Date:   Thu, 31 Jan 2019 09:13:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Message-ID: <20190131081355.GC26495@lst.de>
References: <20190129234752.GR3176@redhat.com> <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com> <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de> <20190130190651.GC17080@mellanox.com> <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com> <20190130195900.GG17080@mellanox.com> <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com> <20190130215019.GL17080@mellanox.com> <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 03:52:13PM -0700, Logan Gunthorpe wrote:
> > *shrug* so what if the special GUP called a VMA op instead of
> > traversing the VMA PTEs today? Why does it really matter? It could
> > easily change to a struct page flow tomorrow..
> 
> Well it's so that it's composable. We want the SGL->DMA side to work for
> APIs from kernel space and not have to run a completely different flow
> for kernel drivers than from userspace memory.

Yes, I think that is the important point.

All the other struct page discussion is not about anyone of us wanting
struct page - heck it is a pain to deal with, but then again it is
there for a reason.

In the typical GUP flows we have three uses of a struct page:

 (1) to carry a physical address.  This is mostly through
     struct scatterlist and struct bio_vec.  We could just store
     a magic PFN-like value that encodes the physical address
     and allow looking up a page if it exists, and we had at least
     two attempts at it.  In some way I think that would actually
     make the interfaces cleaner, but Linus has NACKed it in the
     past, so we'll have to convince him first that this is the
     way forward
 (2) to keep a reference to the memory so that it doesn't go away
     under us due to swapping, process exit, unmapping, etc.
     No idea how we want to solve this, but I guess you have
     some smart ideas?
 (3) to make the PTEs dirty after writing to them.  Again no sure
     what our preferred interface here would be

If we solve all of the above problems I'd be more than happy to
go with a non-struct page based interface for BAR P2P.  But we'll
have to solve these issues in a generic way first.
