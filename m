Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A5FC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD14C2084C
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfA3TqF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:46:05 -0500
Received: from ale.deltatee.com ([207.54.116.67]:40824 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbfA3TqF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 14:46:05 -0500
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.205])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1govny-0008PD-5M; Wed, 30 Jan 2019 12:45:51 -0700
To:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jerome Glisse <jglisse@redhat.com>,
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
References: <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
Date:   Wed, 30 Jan 2019 12:45:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130190651.GC17080@mellanox.com>
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



On 2019-01-30 12:06 p.m., Jason Gunthorpe wrote:
>> Way less problems than not having struct page for doing anything
>> non-trivial.  If you map the BAR to userspace with remap_pfn_range
>> and friends the mapping is indeed very simple.  But any operation
>> that expects a page structure, which is at least everything using
>> get_user_pages won't work.
> 
> GUP doesn't work anyhow today, and won't work with BAR struct pages in
> the forseeable future (Logan has sent attempts on this before).

I don't recall ever attempting that... But patching GUP for special
pages or VMAS; or working around by not calling it in some cases seems
like the thing that's going to need to be done one way or another.

> Jerome made the HMM mirror API use this flow, so afer his patch to
> switch the ODP MR to use HMM, and to switch GPU drivers, it will work
> for those cases. Which is more than the zero cases than we have today
> :)

But we're getting the same bait and switch here... If you are using HMM
you are using struct pages, but we're told we need this special VMA hack
for cases that don't use HMM and thus don't have struct pages...

Logan
