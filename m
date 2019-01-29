Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0DBC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFFB2080F
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfA2TvB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:51:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfA2TvB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 14:51:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5104490901;
        Tue, 29 Jan 2019 19:51:00 +0000 (UTC)
Received: from redhat.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A659053;
        Tue, 29 Jan 2019 19:50:57 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:50:55 -0500
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
Message-ID: <20190129195055.GH3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129193250.GK10108@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 29 Jan 2019 19:51:00 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 07:32:57PM +0000, Jason Gunthorpe wrote:
> On Tue, Jan 29, 2019 at 02:11:23PM -0500, Jerome Glisse wrote:
> > On Tue, Jan 29, 2019 at 11:36:29AM -0700, Logan Gunthorpe wrote:
> > > 
> > > 
> > > On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:
> > > 
> > > > +	/*
> > > > +	 * Optional for device driver that want to allow peer to peer (p2p)
> > > > +	 * mapping of their vma (which can be back by some device memory) to
> > > > +	 * another device.
> > > > +	 *
> > > > +	 * Note that the exporting device driver might not have map anything
> > > > +	 * inside the vma for the CPU but might still want to allow a peer
> > > > +	 * device to access the range of memory corresponding to a range in
> > > > +	 * that vma.
> > > > +	 *
> > > > +	 * FOR PREDICTABILITY IF DRIVER SUCCESSFULY MAP A RANGE ONCE FOR A
> > > > +	 * DEVICE THEN FURTHER MAPPING OF THE SAME IF THE VMA IS STILL VALID
> > > > +	 * SHOULD ALSO BE SUCCESSFUL. Following this rule allow the importing
> > > > +	 * device to map once during setup and report any failure at that time
> > > > +	 * to the userspace. Further mapping of the same range might happen
> > > > +	 * after mmu notifier invalidation over the range. The exporting device
> > > > +	 * can use this to move things around (defrag BAR space for instance)
> > > > +	 * or do other similar task.
> > > > +	 *
> > > > +	 * IMPORTER MUST OBEY mmu_notifier NOTIFICATION AND CALL p2p_unmap()
> > > > +	 * WHEN A NOTIFIER IS CALL FOR THE RANGE ! THIS CAN HAPPEN AT ANY
> > > > +	 * POINT IN TIME WITH NO LOCK HELD.
> > > > +	 *
> > > > +	 * In below function, the device argument is the importing device,
> > > > +	 * the exporting device is the device to which the vma belongs.
> > > > +	 */
> > > > +	long (*p2p_map)(struct vm_area_struct *vma,
> > > > +			struct device *device,
> > > > +			unsigned long start,
> > > > +			unsigned long end,
> > > > +			dma_addr_t *pa,
> > > > +			bool write);
> > > > +	long (*p2p_unmap)(struct vm_area_struct *vma,
> > > > +			  struct device *device,
> > > > +			  unsigned long start,
> > > > +			  unsigned long end,
> > > > +			  dma_addr_t *pa);
> > > 
> > > I don't understand why we need new p2p_[un]map function pointers for
> > > this. In subsequent patches, they never appear to be set anywhere and
> > > are only called by the HMM code. I'd have expected it to be called by
> > > some core VMA code and set by HMM as that's what vm_operations_struct is
> > > for.
> > > 
> > > But the code as all very confusing, hard to follow and seems to be
> > > missing significant chunks. So I'm not really sure what is going on.
> > 
> > It is set by device driver when userspace do mmap(fd) where fd comes
> > from open("/dev/somedevicefile"). So it is set by device driver. HMM
> > has nothing to do with this. It must be set by device driver mmap
> > call back (mmap callback of struct file_operations). For this patch
> > you can completely ignore all the HMM patches. Maybe posting this as
> > 2 separate patchset would make it clearer.
> > 
> > For instance see [1] for how a non HMM driver can export its memory
> > by just setting those callback. Note that a proper implementation of
> > this should also include some kind of driver policy on what to allow
> > to map and what to not allow ... All this is driver specific in any
> > way.
> 
> I'm imagining that the RDMA drivers would use this interface on their
> per-process 'doorbell' BAR pages - we also wish to have P2P DMA to
> this memory. Also the entire VFIO PCI BAR mmap would be good to cover
> with this too.

Correct, you would set those callback on the mmap of your doorbell.

> 
> Jerome, I think it would be nice to have a helper scheme - I think the
> simple case would be simple remapping of PCI BAR memory, so if we
> could have, say something like:
> 
> static const struct vm_operations_struct my_ops {
>   .p2p_map = p2p_ioremap_map_op,
>   .p2p_unmap = p2p_ioremap_unmap_op,
> }
> 
> struct ioremap_data {
>   [..]
> }
> 
> fops_mmap() {
>    vma->private_data = &driver_priv->ioremap_data;
>    return p2p_ioremap_device_memory(vma, exporting_device, [..]);
> }
> 
> Which closely matches at least what the RDMA drivers do. Where
> p2p_ioremap_device_memory populates p2p_map and p2p_unmap pointers
> with sensible functions, etc.
> 
> It looks like vfio would be able to use this as well (though I am
> unsure why vfio uses remap_pfn_range instead of io_remap_pfn range for
> BAR memory..)

Yes simple helper that implement a sane default implementation is
definitly a good idea. As i was working with GPU it was not something
that immediatly poped to mind (see below). But i can certainly do
a sane set of default helper that simple device driver can use right
away without too much thinking on there part. I will add this for
next posting.

> Do any drivers need more control than this?

GPU driver do want more control :) GPU driver are moving things around
all the time and they have more memory than bar space (on newer platform
AMD GPU do resize the bar but it is not the rule for all GPUs). So
GPU driver do actualy manage their BAR address space and they map and
unmap thing there. They can not allow someone to just pin stuff there
randomly or this would disrupt their regular work flow. Hence they need
control and they might implement threshold for instance if they have
more than N pages of bar space map for peer to peer then they can decide
to fall back to main memory for any new peer mapping.

Cheers,
Jérôme
