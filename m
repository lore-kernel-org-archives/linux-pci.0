Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03827C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 22:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C0F2147A
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 22:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfA2W7A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:59:00 -0500
Received: from ale.deltatee.com ([207.54.116.67]:32828 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfA2W7A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 17:59:00 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gocL9-0008ND-Kp; Tue, 29 Jan 2019 15:58:48 -0700
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
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
Date:   Tue, 29 Jan 2019 15:58:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129215028.GQ3176@redhat.com>
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



On 2019-01-29 2:50 p.m., Jerome Glisse wrote:
> No this is the non HMM case i am talking about here. Fully ignore HMM
> in this frame. A GPU driver that do not support or use HMM in anyway
> has all the properties and requirement i do list above. So all the points
> i was making are without HMM in the picture whatsoever. I should have
> posted this a separate patches to avoid this confusion.
> 
> Regarding your HMM question. You can not map HMM pages, all code path
> that would try that would trigger a migration back to regular memory
> and will use the regular memory for CPU access.
> 

I thought this was the whole point of HMM... And eventually it would
support being able to map the pages through the BAR in cooperation with
the driver. If not, what's that whole layer for? Why not just have HMM
handle this situation?

And what struct pages are actually going to be backing these VMAs if
it's not using HMM?


> Again HMM has nothing to do here, ignore HMM it does not play any role
> and it is not involve in anyway here. GPU want to control what object
> they allow other device to access and object they do not allow. GPU driver
> _constantly_ invalidate the CPU page table and in fact the CPU page table
> do not have any valid pte for a vma that is an mmap of GPU device file
> for most of the vma lifetime. Changing that would highly disrupt and
> break GPU drivers. They need to control that, they need to control what
> to do if another device tries to peer map some of their memory. Hence
> why they need to implement the callback and decide on wether or not they
> allow the peer mapping or use device memory for it (they can decide to
> fallback to main memory).

But mapping is an operation of the memory/struct pages behind the VMA;
not of the VMA itself and I think that's evident by the code in that the
only way the VMA layer is involved is the fact that you're abusing
vm_ops by adding new ops there and calling it by other layers.

Logan
