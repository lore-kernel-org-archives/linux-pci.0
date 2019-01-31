Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68DFC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF199218AF
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 19:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfAaTo3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:44:29 -0500
Received: from ale.deltatee.com ([207.54.116.67]:50398 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfAaTo3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 14:44:29 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gpIG3-0002ds-Dl; Thu, 31 Jan 2019 12:44:20 -0700
To:     Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
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
References: <20190130041841.GB30598@mellanox.com>
 <20190130080006.GB29665@lst.de> <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
 <20190131081355.GC26495@lst.de> <20190131190202.GC7548@mellanox.com>
 <20190131193513.GC16593@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c82228c8-1879-b9f6-6b07-6867df826d2c@deltatee.com>
Date:   Thu, 31 Jan 2019 12:44:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131193513.GC16593@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, jroedel@suse.de, robin.murphy@arm.com, m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, Felix.Kuehling@amd.com, christian.koenig@amd.com, bhelgaas@google.com, rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, jgg@mellanox.com, jglisse@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-31 12:35 p.m., Jerome Glisse wrote:
> So what is this O_DIRECT thing that keep coming again and again here :)
> What is the use case ? Note that bio will always have valid struct page
> of regular memory as using PCIE BAR for filesystem is crazy (you do not
> have atomic or cache coherence and many CPU instruction have _undefined_
> effect so what ever the userspace would do might do nothing.

The point is to be able to use a BAR as the source of data to write/read
from a file system. So as a simple example, if an NVMe drive had a CMB,
and you could map that CMB to userspace, you could do an O_DIRECT read
to the BAR on one drive and an O_DIRECT write from the BAR on another
drive. Thus you could bypass the upstream port of a switch (and
therefore all CPU resources) altogether.

For the most part nobody would want to put a filesystem on a BAR.
(Though there have been some crazy ideas to put persistent memory behind
a CMB...)

> Now if you want to use BAR address as destination or source of directIO
> then let just update the directIO code to handle this. There is no need
> to go hack every single place in the kernel that might deal with struct
> page or sgl. Just update the place that need to understand this. We can
> even update directIO to work on weird platform. The change to directIO
> will be small, couple hundred line of code at best.

Well if you want to figure out how to remove struct page from the entire
block layer that would help everybody. But until then, it's pretty much
impossible to use the block layer (and therefore O_DIRECT) without
struct page.

Logan
