Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713DAC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB0E218D2
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfA3XaF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:30:05 -0500
Received: from ale.deltatee.com ([207.54.116.67]:42800 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfA3XaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 18:30:05 -0500
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.205])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1goyiP-0002Sm-FK; Wed, 30 Jan 2019 15:52:18 -0700
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jerome Glisse <jglisse@redhat.com>,
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
References: <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
Date:   Wed, 30 Jan 2019 15:52:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130215019.GL17080@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, jroedel@suse.de, robin.murphy@arm.com, m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, Felix.Kuehling@amd.com, christian.koenig@amd.com, bhelgaas@google.com, rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, hch@lst.de, jgg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-30 2:50 p.m., Jason Gunthorpe wrote:
> On Wed, Jan 30, 2019 at 02:01:35PM -0700, Logan Gunthorpe wrote:
> 
>> And I feel the GUP->SGL->DMA flow should still be what we are aiming
>> for. Even if we need a special GUP for special pages, and a special DMA
>> map; and the SGL still has to be homogenous....
> 
> *shrug* so what if the special GUP called a VMA op instead of
> traversing the VMA PTEs today? Why does it really matter? It could
> easily change to a struct page flow tomorrow..

Well it's so that it's composable. We want the SGL->DMA side to work for
APIs from kernel space and not have to run a completely different flow
for kernel drivers than from userspace memory.

For GUP to do a special VMA traversal it would now need to return
something besides struct pages which means no SGL and it means a
completely different DMA mapping call.
> Would you feel better if this also came along with a:
> 
>   struct dma_sg_table *sgl_dma_map_user(struct device *dma_device, 
>              void __user *prt, size_t len)

That seems like a nice API. But certainly the implementation would need
to use existing dma_map or pci_p2pdma_map calls, or whatever as part of
it...

,
> flow which returns a *DMA MAPPED* sgl that does not have struct page
> pointers as another interface?
> 
> We can certainly call an API like this from RDMA for non-ODP MRs.
> 
> Eliminating the page pointers also eliminates the __iomem
> problem. However this sgl object is not copyable or accessible from
> the CPU, so the caller must be sure it doesn't need CPU access when
> using this API. 

We actually stopped caring about the __iomem problem. We are working
under the assumption that pages returned by devm_memremap_pages() can be
accessed as normal RAM and does not need the __iomem designation. The
main problem now is that code paths need to know to use pci_p2pdma_map
or not. And in theory this could be pushed into regular dma_map
implementations but we'd have to get it into all of them which is a pain.

Logan
