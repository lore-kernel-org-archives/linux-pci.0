Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08813C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 21:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C880C21473
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 21:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfA2VbC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:31:02 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60448 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfA2VbC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 16:31:02 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1goay3-0007MV-KB; Tue, 29 Jan 2019 14:30:52 -0700
To:     Jerome Glisse <jglisse@redhat.com>
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
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205749.GN3176@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
Date:   Tue, 29 Jan 2019 14:30:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129205749.GN3176@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, jroedel@suse.de, robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, Felix.Kuehling@amd.com, christian.koenig@amd.com, bhelgaas@google.com, rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgg@mellanox.com, jglisse@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-29 1:57 p.m., Jerome Glisse wrote:
> GPU driver must be in control and must be call to. Here there is 2 cases
> in this patchset and i should have instead posted 2 separate patchset as
> it seems that it is confusing things.
> 
> For the HMM page, the physical address of the page ie the pfn does not
> correspond to anything ie there is nothing behind it. So the importing
> device has no idea how to get a valid physical address from an HMM page
> only the device driver exporting its memory with HMM device memory knows
> that.
> 
> 
> For the special vma ie mmap of a device file. GPU driver do manage their
> BAR ie the GPU have a page table that map BAR page to GPU memory and the
> driver _constantly_ update this page table, it is reflected by invalidating
> the CPU mapping. In fact most of the time the CPU mapping of GPU object are
> invalid they are valid only a small fraction of their lifetime. So you
> _must_ have some call to inform the exporting device driver that another
> device would like to map one of its vma. The exporting device can then
> try to avoid as much churn as possible for the importing device. But this
> has consequence and the exporting device driver must be allow to apply
> policy and make decission on wether or not it authorize the other device
> to peer map its memory. For GPU the userspace application have to call
> specific API that translate into specific ioctl which themself set flags
> on object (in the kernel struct tracking the user space object). The only
> way to allow program predictability is if the application can ask and know
> if it can peer export an object (ie is there enough BAR space left).

This all seems like it's an HMM problem and not related to mapping
BARs/"potential BARs" to userspace. If some code wants to DMA map HMM
pages, it calls an HMM function to map them. If HMM needs to consult
with the driver on aspects of how that's mapped, then that's between HMM
and the driver and not something I really care about. But making the
entire mapping stuff tied to userspace VMAs does not make sense to me.
What if somebody wants to map some HMM pages in the same way but from
kernel space and they therefore don't have a VMA?


>> I also figured there'd be a fault version of p2p_ioremap_device_memory()
>> for when you are mapping P2P memory and you want to assign the pages
>> lazily. Though, this can come later when someone wants to implement that.
> 
> For GPU the BAR address space is manage page by page and thus you do not
> want to map a range of BAR addresses but you want to allow mapping of
> multiple page of BAR address that are not adjacent to each other nor
> ordered in anyway. But providing helper for simpler device does make sense.

Well, this has little do with the backing device but how the memory is
mapped into userspace. With p2p_ioremap_device_memory() the entire range
is mapped into the userspace VMA immediately during the call to mmap().
With p2p_fault_device_memory(), mmap() would not actually map anything
and a page in the VMA would be mapped only when userspace accesses it
(using fault()). It seems to me like GPUs would prefer the latter but if
HMM takes care of the mapping from userspace potential pages to actual
GPU pages through the BAR then that may not be true.

Logan
