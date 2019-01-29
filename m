Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86EFC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430E20869
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfA2TL3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:11:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfA2TL3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 14:11:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5255C065F8D;
        Tue, 29 Jan 2019 19:11:27 +0000 (UTC)
Received: from redhat.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 516235C57C;
        Tue, 29 Jan 2019 19:11:25 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:11:23 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Message-ID: <20190129191120.GE3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 29 Jan 2019 19:11:28 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 11:36:29AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:
> 
> > +	/*
> > +	 * Optional for device driver that want to allow peer to peer (p2p)
> > +	 * mapping of their vma (which can be back by some device memory) to
> > +	 * another device.
> > +	 *
> > +	 * Note that the exporting device driver might not have map anything
> > +	 * inside the vma for the CPU but might still want to allow a peer
> > +	 * device to access the range of memory corresponding to a range in
> > +	 * that vma.
> > +	 *
> > +	 * FOR PREDICTABILITY IF DRIVER SUCCESSFULY MAP A RANGE ONCE FOR A
> > +	 * DEVICE THEN FURTHER MAPPING OF THE SAME IF THE VMA IS STILL VALID
> > +	 * SHOULD ALSO BE SUCCESSFUL. Following this rule allow the importing
> > +	 * device to map once during setup and report any failure at that time
> > +	 * to the userspace. Further mapping of the same range might happen
> > +	 * after mmu notifier invalidation over the range. The exporting device
> > +	 * can use this to move things around (defrag BAR space for instance)
> > +	 * or do other similar task.
> > +	 *
> > +	 * IMPORTER MUST OBEY mmu_notifier NOTIFICATION AND CALL p2p_unmap()
> > +	 * WHEN A NOTIFIER IS CALL FOR THE RANGE ! THIS CAN HAPPEN AT ANY
> > +	 * POINT IN TIME WITH NO LOCK HELD.
> > +	 *
> > +	 * In below function, the device argument is the importing device,
> > +	 * the exporting device is the device to which the vma belongs.
> > +	 */
> > +	long (*p2p_map)(struct vm_area_struct *vma,
> > +			struct device *device,
> > +			unsigned long start,
> > +			unsigned long end,
> > +			dma_addr_t *pa,
> > +			bool write);
> > +	long (*p2p_unmap)(struct vm_area_struct *vma,
> > +			  struct device *device,
> > +			  unsigned long start,
> > +			  unsigned long end,
> > +			  dma_addr_t *pa);
> 
> I don't understand why we need new p2p_[un]map function pointers for
> this. In subsequent patches, they never appear to be set anywhere and
> are only called by the HMM code. I'd have expected it to be called by
> some core VMA code and set by HMM as that's what vm_operations_struct is
> for.
> 
> But the code as all very confusing, hard to follow and seems to be
> missing significant chunks. So I'm not really sure what is going on.

It is set by device driver when userspace do mmap(fd) where fd comes
from open("/dev/somedevicefile"). So it is set by device driver. HMM
has nothing to do with this. It must be set by device driver mmap
call back (mmap callback of struct file_operations). For this patch
you can completely ignore all the HMM patches. Maybe posting this as
2 separate patchset would make it clearer.

For instance see [1] for how a non HMM driver can export its memory
by just setting those callback. Note that a proper implementation of
this should also include some kind of driver policy on what to allow
to map and what to not allow ... All this is driver specific in any
way.

Cheers,
Jérôme

[1] https://cgit.freedesktop.org/~glisse/linux/commit/?h=wip-p2p-showcase&id=964214dcd4df96f296e2214042e8cfce135ae3d4
