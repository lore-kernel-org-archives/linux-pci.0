Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64DEC169C4
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 00:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1E62082C
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 00:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfA3AIM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:08:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfA3AIL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 19:08:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98862BDD0;
        Wed, 30 Jan 2019 00:08:10 +0000 (UTC)
Received: from redhat.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3216E53;
        Wed, 30 Jan 2019 00:08:08 +0000 (UTC)
Date:   Tue, 29 Jan 2019 19:08:06 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
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
Message-ID: <20190130000805.GS3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
 <20190129195055.GH3176@redhat.com>
 <20190129202429.GL10108@mellanox.com>
 <20190129204359.GM3176@redhat.com>
 <20190129224016.GD4713@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129224016.GD4713@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 30 Jan 2019 00:08:11 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 11:02:25PM +0000, Jason Gunthorpe wrote:
> On Tue, Jan 29, 2019 at 03:44:00PM -0500, Jerome Glisse wrote:
> 
> > > But this API doesn't seem to offer any control - I thought that
> > > control was all coming from the mm/hmm notifiers triggering p2p_unmaps?
> > 
> > The control is within the driver implementation of those callbacks. 
> 
> Seems like what you mean by control is 'the exporter gets to choose
> the physical address at the instant of map' - which seems reasonable
> for GPU.
> 
> 
> > will only allow p2p map to succeed for objects that have been tagged by the
> > userspace in some way ie the userspace application is in control of what
> > can be map to peer device.
> 
> I would have thought this means the VMA for the object is created
> without the map/unmap ops? Or are GPU objects and VMAs unrelated?

GPU object and VMA are unrelated in all open source GPU driver i am
somewhat familiar with (AMD, Intel, NVidia). You can create a GPU
object and never map it (and thus never have it associated with a
vma) and in fact this is very common. For graphic you usualy only
have hand full of the hundreds of GPU object your application have
mapped.

The control for peer to peer can also be a mutable properties of the
object ie userspace do ioctl on the GPU driver which create an object;
Some times after the object is created the userspace do others ioctl
to allow to export the object to another specific device again this
result in ioctl to the device driver, those ioctl set flags and
update GPU object kernel structure with all the info.

In the meantime you have no control on when other driver might call
the vma p2p call backs. So you must have register the vma with
vm_operations that include the p2p_map and p2p_unmap. Those driver
function will check the object kernel structure each time they get
call and act accordingly.



> > For moving things around after a successful p2p_map yes the exporting
> > device have to call for instance zap_vma_ptes() or something
> > similar.
> 
> Okay, great, RDMA needs this flow for hotplug - we zap the VMA's when
> unplugging the PCI device and we can delay the PCI unplug completion
> until all the p2p_unmaps are called...
> 
> But in this case a future p2p_map will have to fail as the BAR no
> longer exists. How to handle this?

So the comment above the callback (i should write more thorough guideline
and documentation) state that export should/(must?) be predictable ie
if an importer device calls p2p_map() once on a vma and it does succeed
then if the same device calls again p2p_map() on the same vma and if the
vma is still valid (ie no unmap or does not correspond to a different
object ...) then the p2p_map() should/(must?) succeed.

The idea is that the importer would do a first call to p2p_map() when it
setup its own object, report failure to userspace if that fails. If it
does succeed then we should never have an issue next time we call p2p_map()
(after mapping being invalidated by mmu notifier for instance). So it will
succeed just like the first call (again assuming the vma is still valid).

Idea is that we can only ask exporter to be predictable and still allow
them to fail if things are really going bad.


> > > I would think that the importing driver can assume the BAR page is
> > > kept alive until it calls unmap (presumably triggered by notifiers)?
> > > 
> > > ie the exporting driver sees the BAR page as pinned until unmap.
> > 
> > The intention with this patchset is that it is not pin ie the importer
> > device _must_ abide by all mmu notifier invalidations and they can
> > happen at anytime. The importing device can however re-p2p_map the
> > same range after an invalidation.
> >
> > I would like to restrict this to importer that can invalidate for
> > now because i believe all the first device to use can support the
> > invalidation.
> 
> This seems reasonable (and sort of says importers not getting this
> from HMM need careful checking), was this in the comment above the
> ops?

I think i put it in the comment above the ops but in any cases i should
write something in documentation with example and thorough guideline.
Note that there won't be any mmu notifier to mmap of a device file
unless the device driver calls for it or there is a syscall like munmap
or mremap or mprotect well any syscall that work on vma.

So assuming the application is no doing something stupid, nor the
driver. Then the result of p2p_map can stay valid until the importer
is done and call p2p_unmap of its own free will. This is what i do
expect for this. But for GPU i would still like to allow GPU driver
to evict (and thus invalidate importer mapping) to main memory or
defragment their BAR address space if the GPU driver feels a pressing
need to do so.

If we ever want to support full pin then we might have to add a
flag so that GPU driver can refuse an importer that wants things
pin forever.

Cheers,
Jérôme
