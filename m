Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F66AC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D222F20989
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfA2UnP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:43:15 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60028 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfA2UnP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 15:43:15 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1goaDn-0006jl-FD; Tue, 29 Jan 2019 13:43:04 -0700
To:     Jerome Glisse <jglisse@redhat.com>
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
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <c2c02af7-1d6f-e54f-c7fb-99c5b7776014@deltatee.com>
 <20190129194418.GG3176@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b3264844-2c04-6c34-f1e7-6b3bf9849a75@deltatee.com>
Date:   Tue, 29 Jan 2019 13:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129194418.GG3176@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, jroedel@suse.de, robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, jgg@mellanox.com, Felix.Kuehling@amd.com, christian.koenig@amd.com, bhelgaas@google.com, rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-29 12:44 p.m., Jerome Glisse wrote:
>> I'd suggest [1] should be a part of the patchset so we can actually see
>> a user of the stuff you're adding.
> 
> I did not wanted to clutter patchset with device driver specific usage
> of this. As the API can be reason about in abstract way.

It's hard to reason about an interface when you can't see what all the
layers want to do with it. Most maintainers (I'd hope) would certainly
never merge code that has no callers, and for much the same reason, I'd
rather not review patches that don't have real use case examples.

Logan
