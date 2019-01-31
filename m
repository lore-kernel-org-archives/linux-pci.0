Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F791C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 19:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C13420881
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 19:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfAaTTs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:19:48 -0500
Received: from ale.deltatee.com ([207.54.116.67]:50232 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfAaTTs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 14:19:48 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gpHsA-0002Rf-H6; Thu, 31 Jan 2019 12:19:39 -0700
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
References: <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
 <20190131081355.GC26495@lst.de> <20190131190202.GC7548@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e4fd743f-61cb-a443-bc53-9a1c036ebe8c@deltatee.com>
Date:   Thu, 31 Jan 2019 12:19:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131190202.GC7548@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
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



On 2019-01-31 12:02 p.m., Jason Gunthorpe wrote:
> I still think the right direction is to build on what Logan has done -
> realize that he created a DMA-only SGL - make that a formal type of
> the kernel and provide the right set of APIs to work with this type,
> without being forced to expose struct page.

> Basically invert the API flow - the DMA map would be done close to
> GUP, not buried in the driver. This absolutely doesn't work for every
> flow we have, but it does enable the ones that people seem to care
> about when talking about P2P.
> It also does present a path to solve some cases of the O_DIRECT
> problems if the block stack can develop some way to know if an IO will
> go down a DMA-only IO path or not... This seems less challenging that
> auditing every SGL user for iomem safety??


The DMA-only SGL will work for some use cases, but I think it's going to
be a challenge for others. We care most about NVMe and, therefore, the
block layer.

Given my understanding of the block layer, and it's queuing
infrastructure, I don't think having a DMA-only IO path makes sense. I
think it has to be the same path, but with a special DMA-only bio; and
endpoints would have to indicate support for that bio. I can't say I
have a deep enough understanding of the block layer to know how possible
that would be.

Logan
