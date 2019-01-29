Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588A4C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F09920869
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfA2U57 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:57:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfA2U57 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 15:57:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 256123DE03;
        Tue, 29 Jan 2019 20:57:58 +0000 (UTC)
Received: from redhat.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A46D119745;
        Tue, 29 Jan 2019 20:57:54 +0000 (UTC)
Date:   Tue, 29 Jan 2019 15:57:50 -0500
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
Message-ID: <20190129205749.GN3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 29 Jan 2019 20:57:58 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 01:39:49PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-29 12:32 p.m., Jason Gunthorpe wrote:
> > Jerome, I think it would be nice to have a helper scheme - I think the
> > simple case would be simple remapping of PCI BAR memory, so if we
> > could have, say something like:
> > 
> > static const struct vm_operations_struct my_ops {
> >   .p2p_map = p2p_ioremap_map_op,
> >   .p2p_unmap = p2p_ioremap_unmap_op,
> > }
> > 
> > struct ioremap_data {
> >   [..]
> > }
> > 
> > fops_mmap() {
> >    vma->private_data = &driver_priv->ioremap_data;
> >    return p2p_ioremap_device_memory(vma, exporting_device, [..]);
> > }
> 
> This is roughly what I was expecting, except I don't see exactly what
> the p2p_map and p2p_unmap callbacks are for. The importing driver should
> see p2pdma/hmm struct pages and use the appropriate function to map
> them. It shouldn't be the responsibility of the exporting driver to
> implement the mapping. And I don't think we should have 'special' vma's
> for this (though we may need something to ensure we don't get mapping
> requests mixed with different types of pages...).

GPU driver must be in control and must be call to. Here there is 2 cases
in this patchset and i should have instead posted 2 separate patchset as
it seems that it is confusing things.

For the HMM page, the physical address of the page ie the pfn does not
correspond to anything ie there is nothing behind it. So the importing
device has no idea how to get a valid physical address from an HMM page
only the device driver exporting its memory with HMM device memory knows
that.


For the special vma ie mmap of a device file. GPU driver do manage their
BAR ie the GPU have a page table that map BAR page to GPU memory and the
driver _constantly_ update this page table, it is reflected by invalidating
the CPU mapping. In fact most of the time the CPU mapping of GPU object are
invalid they are valid only a small fraction of their lifetime. So you
_must_ have some call to inform the exporting device driver that another
device would like to map one of its vma. The exporting device can then
try to avoid as much churn as possible for the importing device. But this
has consequence and the exporting device driver must be allow to apply
policy and make decission on wether or not it authorize the other device
to peer map its memory. For GPU the userspace application have to call
specific API that translate into specific ioctl which themself set flags
on object (in the kernel struct tracking the user space object). The only
way to allow program predictability is if the application can ask and know
if it can peer export an object (ie is there enough BAR space left).

Moreover i would like to be able to use this API between GPUs that are
inter-connected between each other and for those the CPU page table are
just invalid and the physical address to use are only meaning full to the
exporting and importing device. So again here core kernel has no idea of
what the physical address would be.


So in both cases, at very least for GPU, we do want total control to be
given to the exporter.

> 
> I also figured there'd be a fault version of p2p_ioremap_device_memory()
> for when you are mapping P2P memory and you want to assign the pages
> lazily. Though, this can come later when someone wants to implement that.

For GPU the BAR address space is manage page by page and thus you do not
want to map a range of BAR addresses but you want to allow mapping of
multiple page of BAR address that are not adjacent to each other nor
ordered in anyway. But providing helper for simpler device does make sense.

Cheers,
Jérôme
