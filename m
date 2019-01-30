Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239D5C169C4
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 01:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E4D2147A
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 01:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfA3BR6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:17:58 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34102 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfA3BR6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 20:17:58 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1goeVd-0001rh-FE; Tue, 29 Jan 2019 18:17:46 -0700
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
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
Date:   Tue, 29 Jan 2019 18:17:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129234752.GR3176@redhat.com>
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



On 2019-01-29 4:47 p.m., Jerome Glisse wrote:
> The whole point is to allow to use device memory for range of virtual
> address of a process when it does make sense to use device memory for
> that range. So they are multiple cases where it does make sense:
> [1] - Only the device is accessing the range and they are no CPU access
>       For instance the program is executing/running a big function on
>       the GPU and they are not concurrent CPU access, this is very
>       common in all the existing GPGPU code. In fact AFAICT It is the
>       most common pattern. So here you can use HMM private or public
>       memory.
> [2] - Both device and CPU access a common range of virtul address
>       concurrently. In that case if you are on a platform with cache
>       coherent inter-connect like OpenCAPI or CCIX then you can use
>       HMM public device memory and have both access the same memory.
>       You can not use HMM private memory.
> 
> So far on x86 we only have PCIE and thus so far on x86 we only have
> private HMM device memory that is not accessible by the CPU in any
> way.

I feel like you're just moving the rug out from under us... Before you
said ignore HMM and I was asking about the use case that wasn't using
HMM and how it works without HMM. In response, you just give me *way*
too much information describing HMM. And still, as best as I can see,
managing DMA mappings (which is different from the userspace mappings)
for GPU P2P should be handled by HMM and the userspace mappings should
*just* link VMAs to HMM pages using the standard infrastructure we
already have.

>> And what struct pages are actually going to be backing these VMAs if
>> it's not using HMM?
> 
> When you have some range of virtual address migrated to HMM private
> memory then the CPU pte are special swap entry and they behave just
> as if the memory was swapped to disk. So CPU access to those will
> fault and trigger a migration back to main memory.

This isn't answering my question at all... I specifically asked what is
backing the VMA when we are *not* using HMM.

Logan
