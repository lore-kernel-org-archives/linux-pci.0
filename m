Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F7BC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 20:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C3F20989
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 20:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfA3UAR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:00:17 -0500
Received: from ale.deltatee.com ([207.54.116.67]:41020 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbfA3UAR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 15:00:17 -0500
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.205])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gow1l-00005u-Hy; Wed, 30 Jan 2019 13:00:06 -0700
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
References: <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com>
 <bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
 <20190130185652.GB17080@mellanox.com> <20190130192234.GD5061@redhat.com>
 <20190130193759.GE17080@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
Date:   Wed, 30 Jan 2019 13:00:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130193759.GE17080@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, jroedel@suse.de, robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, Felix.Kuehling@amd.com, christian.koenig@amd.com, bhelgaas@google.com, rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, jgg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-30 12:38 p.m., Jason Gunthorpe wrote:
> On Wed, Jan 30, 2019 at 02:22:34PM -0500, Jerome Glisse wrote:
> 
>> For GPU it would not work, GPU might want to use main memory (because
>> it is running out of BAR space) it is a lot easier if the p2p_map
>> callback calls the right dma map function (for page or io) rather than
>> having to define some format that would pass down the information.
> 
> This is already sort of built into the sgl, you are supposed to use
> is_pci_p2pdma_page() and pci_p2pdma_map_sg() and somehow it is supposed
> to work out - but I think this is also fairly incomplete.


> ie the current APIs seem to assume the SGL is homogeneous :(

We never changed SGLs. We still use them to pass p2pdma pages, only we
need to be a bit careful where we send the entire SGL. I see no reason
why we can't continue to be careful once their in userspace if there's
something in GUP to deny them.

It would be nice to have heterogeneous SGLs and it is something we
should work toward but in practice they aren't really necessary at the
moment.

>>> Worry about optimizing away the struct page overhead later?
>>
>> Struct page do not fit well for GPU as the BAR address can be reprogram
>> to point to any page inside the device memory (think 256M BAR versus
>> 16GB device memory).
> 
> The struct page only points to the BAR - it is not related to the
> actual GPU memory in any way. The struct page is just an alternative
> way to specify the physical address of the BAR page.

That doesn't even necessarily need to be the case. For HMM, I
understand, struct pages may not point to any accessible memory and the
memory that backs it (or not) may change over the life time of it. So
they don't have to be strictly tied to BARs addresses. p2pdma pages are
strictly tied to BAR addresses though.

Logan
