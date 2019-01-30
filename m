Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6119EC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FAC20881
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfA3XJl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:09:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfA3XJl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 18:09:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BACE8C0C6C2B;
        Wed, 30 Jan 2019 22:30:31 +0000 (UTC)
Received: from redhat.com (ovpn-126-0.rdu2.redhat.com [10.10.126.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98B08608C6;
        Wed, 30 Jan 2019 22:30:29 +0000 (UTC)
Date:   Wed, 30 Jan 2019 17:30:27 -0500
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
Message-ID: <20190130223027.GH5061@redhat.com>
References: <bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
 <20190130185652.GB17080@mellanox.com>
 <20190130192234.GD5061@redhat.com>
 <20190130193759.GE17080@mellanox.com>
 <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
 <20190130201114.GB17915@mellanox.com>
 <20190130204332.GF5061@redhat.com>
 <20190130204954.GI17080@mellanox.com>
 <20190130214525.GG5061@redhat.com>
 <20190130215600.GM17080@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130215600.GM17080@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 30 Jan 2019 22:30:32 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 09:56:07PM +0000, Jason Gunthorpe wrote:
> On Wed, Jan 30, 2019 at 04:45:25PM -0500, Jerome Glisse wrote:
> > On Wed, Jan 30, 2019 at 08:50:00PM +0000, Jason Gunthorpe wrote:
> > > On Wed, Jan 30, 2019 at 03:43:32PM -0500, Jerome Glisse wrote:
> > > > On Wed, Jan 30, 2019 at 08:11:19PM +0000, Jason Gunthorpe wrote:
> > > > > On Wed, Jan 30, 2019 at 01:00:02PM -0700, Logan Gunthorpe wrote:
> > > > > 
> > > > > > We never changed SGLs. We still use them to pass p2pdma pages, only we
> > > > > > need to be a bit careful where we send the entire SGL. I see no reason
> > > > > > why we can't continue to be careful once their in userspace if there's
> > > > > > something in GUP to deny them.
> > > > > > 
> > > > > > It would be nice to have heterogeneous SGLs and it is something we
> > > > > > should work toward but in practice they aren't really necessary at the
> > > > > > moment.
> > > > > 
> > > > > RDMA generally cannot cope well with an API that requires homogeneous
> > > > > SGLs.. User space can construct complex MRs (particularly with the
> > > > > proposed SGL MR flow) and we must marshal that into a single SGL or
> > > > > the drivers fall apart.
> > > > > 
> > > > > Jerome explained that GPU is worse, a single VMA may have a random mix
> > > > > of CPU or device pages..
> > > > > 
> > > > > This is a pretty big blocker that would have to somehow be fixed.
> > > > 
> > > > Note that HMM takes care of that RDMA ODP with my ODP to HMM patch,
> > > > so what you get for an ODP umem is just a list of dma address you
> > > > can program your device to. The aim is to avoid the driver to care
> > > > about that. The access policy when the UMEM object is created by
> > > > userspace through verbs API should however ascertain that for mmap
> > > > of device file it is only creating a UMEM that is fully covered by
> > > > one and only one vma. GPU device driver will have one vma per logical
> > > > GPU object. I expect other kind of device do that same so that they
> > > > can match a vma to a unique object in their driver.
> > > 
> > > A one VMA rule is not really workable.
> > > 
> > > With ODP VMA boundaries can move around across the lifetime of the MR
> > > and we have no obvious way to fail anything if userpace puts a VMA
> > > boundary in the middle of an existing ODP MR address range.
> > 
> > This is true only for vma that are not mmap of a device file. This is
> > what i was trying to get accross. An mmap of a file is never merge
> > so it can only get split/butcher by munmap/mremap but when that happen
> > you also need to reflect the virtual address space change to the
> > device ie any access to a now invalid range must trigger error.
> 
> Why is it invalid? The address range still has valid process memory?

If you do munmap(A, size) then all address in the range [A, A+size]
are invalid. This is what i am refering too here. Same for mremap.

> 
> What is the problem in the HMM mirror that it needs this restriction?

No restriction at all here. I think i just wasn't understood.

> There is also the situation where we create an ODP MR that spans 0 ->
> U64_MAX in the process address space. In this case there are lots of
> different VMAs it covers and we expect it to fully track all changes
> to all VMAs.

Yes and that works however any memory access above TASK_SIZE will
return -EFAULT as this is kernel address space so you can only access
anything that is a valid process virtual address.

> 
> So we have to spin up dedicated umem_odps that carefully span single
> VMAs, and somehow track changes to VMA ?

No you do not.

> 
> mlx5 odp does some of this already.. But yikes, this needs some pretty
> careful testing in all these situations.

Sorry if i confused you even more than the first time. Everything works
you have nothing to worry about :)

> 
> > > I think the HMM mirror API really needs to deal with this for the
> > > driver somehow.
> > 
> > Yes the HMM does deal with this for you, you do not have to worry about
> > it. Sorry if that was not clear. I just wanted to stress that vma that
> > are mmap of a file do not behave like other vma hence when you create
> > the UMEM you can check for those if you feel the need.
> 
> What properties do we get from HMM mirror? Will it tell us when to
> create more umems to cover VMA seams or will it just cause undesired
> no-mapped failures in some cases?

You do not get anything from HMM mirror, i might add a flag so that
HMM can report this special condition if driver wants to know. If
you want to know you have to look at the vma by yourself. GPU driver
will definitly want to know whem importing so i might add a flag so
that they do not have to lookup the vma themself to know.

Again if you do not care then just ignore everything here, it is
handled by HMM and you do not have to worry one bit. If it worked
with GUP it will work with HMM and with those p2p patches if it
will even works against vma that are mmap of a file and that set
the p2p_map function.

Cheers,
Jérôme
