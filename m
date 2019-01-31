Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC713C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 19:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96DD20B1F
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 19:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAaTfU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:35:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfAaTfT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 14:35:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D224A4035;
        Thu, 31 Jan 2019 19:35:18 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F08F460C45;
        Thu, 31 Jan 2019 19:35:15 +0000 (UTC)
Date:   Thu, 31 Jan 2019 14:35:14 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
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
Message-ID: <20190131193513.GC16593@redhat.com>
References: <20190130041841.GB30598@mellanox.com>
 <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
 <20190131081355.GC26495@lst.de>
 <20190131190202.GC7548@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190131190202.GC7548@mellanox.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 31 Jan 2019 19:35:18 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 07:02:15PM +0000, Jason Gunthorpe wrote:
> On Thu, Jan 31, 2019 at 09:13:55AM +0100, Christoph Hellwig wrote:
> > On Wed, Jan 30, 2019 at 03:52:13PM -0700, Logan Gunthorpe wrote:
> > > > *shrug* so what if the special GUP called a VMA op instead of
> > > > traversing the VMA PTEs today? Why does it really matter? It could
> > > > easily change to a struct page flow tomorrow..
> > > 
> > > Well it's so that it's composable. We want the SGL->DMA side to work for
> > > APIs from kernel space and not have to run a completely different flow
> > > for kernel drivers than from userspace memory.
> > 
> > Yes, I think that is the important point.
> > 
> > All the other struct page discussion is not about anyone of us wanting
> > struct page - heck it is a pain to deal with, but then again it is
> > there for a reason.
> > 
> > In the typical GUP flows we have three uses of a struct page:
> > 
> >  (1) to carry a physical address.  This is mostly through
> >      struct scatterlist and struct bio_vec.  We could just store
> >      a magic PFN-like value that encodes the physical address
> >      and allow looking up a page if it exists, and we had at least
> >      two attempts at it.  In some way I think that would actually
> >      make the interfaces cleaner, but Linus has NACKed it in the
> >      past, so we'll have to convince him first that this is the
> >      way forward
> 
> Something like this (and more) has always been the roadblock with
> trying to mix BAR memory into SGL. I think it is such a big problem as
> to be unsolvable in one step.. 
> 
> Struct page doesn't even really help anything beyond dma_map as we
> still can't pretend that __iomem is normal memory for general SGL
> users.
> 
> >  (2) to keep a reference to the memory so that it doesn't go away
> >      under us due to swapping, process exit, unmapping, etc.
> >      No idea how we want to solve this, but I guess you have
> >      some smart ideas?
> 
> Jerome, how does this work anyhow? Did you do something to make the
> VMA lifetime match the p2p_map/unmap? Or can we get into a situation
> were the VMA is destroyed and the importing driver can't call the
> unmap anymore?
> 
> I know in the case of notifiers the VMA liftime should be strictly
> longer than the map/unmap - but does this mean we can never support
> non-notifier users via this scheme?

So in this version the requirement is that the importer also have a mmu
notifier registered and that's what all GPU driver do already. Any
driver that map some range of vma to a device should register itself as
a mmu notifier listener to do something when vma goes away. I posted a
patchset a while ago to allow listener to differentiate when the vma is
going away from other type of invalidation [1]

With that in place you can easily handle the pin case. Driver really
need to do something when the vma goes away with GUP or not. As the
device is then writing/reading to/from something that does not match
anything in the process address space.

So user that want pin would register notifier, call p2p_map with pin
flag and ignore all notifier callback except the unmap one when the
unmap one happens they have the vma and they should call p2p_unmap
from their invalidate callback and update their device to either some
dummy memory or program it in a way that the userspace application
will notice.

This can all be handled by some helper so that driver do not have to
write more than 5 lines of code and function to update their device
mapping to something of their choosing.


> 
> >  (3) to make the PTEs dirty after writing to them.  Again no sure
> >      what our preferred interface here would be
> 
> This need doesn't really apply to BAR memory..
> 
> > If we solve all of the above problems I'd be more than happy to
> > go with a non-struct page based interface for BAR P2P.  But we'll
> > have to solve these issues in a generic way first.
> 
> I still think the right direction is to build on what Logan has done -
> realize that he created a DMA-only SGL - make that a formal type of
> the kernel and provide the right set of APIs to work with this type,
> without being forced to expose struct page.
> 
> Basically invert the API flow - the DMA map would be done close to
> GUP, not buried in the driver. This absolutely doesn't work for every
> flow we have, but it does enable the ones that people seem to care
> about when talking about P2P.

This does not work for GPU really i do not want to have to rewrite GPU
driver for this. Struct page is a burden and it does not bring anything
to the table. I rather provide an all in one stop for driver to use
this without having to worry between regular vma and special vma.

Note that in this patchset i reuse chunk of Logan works and intention is
to also allow PCI struct page to work too. But they should not be the
only mechanisms.

> 
> To get to where we are today we'd need a few new IB APIs, and some
> nvme change to work with DMA-only SGL's and so forth, but that doesn't
> seem so bad. The API also seems much more safe and understandable than
> todays version that is trying to hope that the SGL is never touched by
> the CPU.
> 
> It also does present a path to solve some cases of the O_DIRECT
> problems if the block stack can develop some way to know if an IO will
> go down a DMA-only IO path or not... This seems less challenging that
> auditing every SGL user for iomem safety??

So what is this O_DIRECT thing that keep coming again and again here :)
What is the use case ? Note that bio will always have valid struct page
of regular memory as using PCIE BAR for filesystem is crazy (you do not
have atomic or cache coherence and many CPU instruction have _undefined_
effect so what ever the userspace would do might do nothing.

Now if you want to use BAR address as destination or source of directIO
then let just update the directIO code to handle this. There is no need
to go hack every single place in the kernel that might deal with struct
page or sgl. Just update the place that need to understand this. We can
even update directIO to work on weird platform. The change to directIO
will be small, couple hundred line of code at best.

Cheers,
Jérôme

[1] https://lore.kernel.org/linux-fsdevel/20190123222315.1122-1-jglisse@redhat.com/T/#m69e8f589240e18acbf196a1c8aa1d6fc97bd3565
