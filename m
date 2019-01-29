Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05592C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 21:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05C820882
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 21:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfA2Vue (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:50:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfA2Vue (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 16:50:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43ADD89AE0;
        Tue, 29 Jan 2019 21:50:33 +0000 (UTC)
Received: from redhat.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF41384E2;
        Tue, 29 Jan 2019 21:50:30 +0000 (UTC)
Date:   Tue, 29 Jan 2019 16:50:28 -0500
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
Message-ID: <20190129215028.GQ3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 29 Jan 2019 21:50:33 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 02:30:49PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-29 1:57 p.m., Jerome Glisse wrote:
> > GPU driver must be in control and must be call to. Here there is 2 cases
> > in this patchset and i should have instead posted 2 separate patchset as
> > it seems that it is confusing things.
> > 
> > For the HMM page, the physical address of the page ie the pfn does not
> > correspond to anything ie there is nothing behind it. So the importing
> > device has no idea how to get a valid physical address from an HMM page
> > only the device driver exporting its memory with HMM device memory knows
> > that.
> > 
> > 
> > For the special vma ie mmap of a device file. GPU driver do manage their
> > BAR ie the GPU have a page table that map BAR page to GPU memory and the
> > driver _constantly_ update this page table, it is reflected by invalidating
> > the CPU mapping. In fact most of the time the CPU mapping of GPU object are
> > invalid they are valid only a small fraction of their lifetime. So you
> > _must_ have some call to inform the exporting device driver that another
> > device would like to map one of its vma. The exporting device can then
> > try to avoid as much churn as possible for the importing device. But this
> > has consequence and the exporting device driver must be allow to apply
> > policy and make decission on wether or not it authorize the other device
> > to peer map its memory. For GPU the userspace application have to call
> > specific API that translate into specific ioctl which themself set flags
> > on object (in the kernel struct tracking the user space object). The only
> > way to allow program predictability is if the application can ask and know
> > if it can peer export an object (ie is there enough BAR space left).
> 
> This all seems like it's an HMM problem and not related to mapping
> BARs/"potential BARs" to userspace. If some code wants to DMA map HMM
> pages, it calls an HMM function to map them. If HMM needs to consult
> with the driver on aspects of how that's mapped, then that's between HMM
> and the driver and not something I really care about. But making the
> entire mapping stuff tied to userspace VMAs does not make sense to me.
> What if somebody wants to map some HMM pages in the same way but from
> kernel space and they therefore don't have a VMA?

No this is the non HMM case i am talking about here. Fully ignore HMM
in this frame. A GPU driver that do not support or use HMM in anyway
has all the properties and requirement i do list above. So all the points
i was making are without HMM in the picture whatsoever. I should have
posted this a separate patches to avoid this confusion.

Regarding your HMM question. You can not map HMM pages, all code path
that would try that would trigger a migration back to regular memory
and will use the regular memory for CPU access.


> >> I also figured there'd be a fault version of p2p_ioremap_device_memory()
> >> for when you are mapping P2P memory and you want to assign the pages
> >> lazily. Though, this can come later when someone wants to implement that.
> > 
> > For GPU the BAR address space is manage page by page and thus you do not
> > want to map a range of BAR addresses but you want to allow mapping of
> > multiple page of BAR address that are not adjacent to each other nor
> > ordered in anyway. But providing helper for simpler device does make sense.
> 
> Well, this has little do with the backing device but how the memory is
> mapped into userspace. With p2p_ioremap_device_memory() the entire range
> is mapped into the userspace VMA immediately during the call to mmap().
> With p2p_fault_device_memory(), mmap() would not actually map anything
> and a page in the VMA would be mapped only when userspace accesses it
> (using fault()). It seems to me like GPUs would prefer the latter but if
> HMM takes care of the mapping from userspace potential pages to actual
> GPU pages through the BAR then that may not be true.

Again HMM has nothing to do here, ignore HMM it does not play any role
and it is not involve in anyway here. GPU want to control what object
they allow other device to access and object they do not allow. GPU driver
_constantly_ invalidate the CPU page table and in fact the CPU page table
do not have any valid pte for a vma that is an mmap of GPU device file
for most of the vma lifetime. Changing that would highly disrupt and
break GPU drivers. They need to control that, they need to control what
to do if another device tries to peer map some of their memory. Hence
why they need to implement the callback and decide on wether or not they
allow the peer mapping or use device memory for it (they can decide to
fallback to main memory).

If the exporter can not control than this is useless to GPU driver. I
would rather not exclude GPU driver from this.

Cheers,
Jérôme
