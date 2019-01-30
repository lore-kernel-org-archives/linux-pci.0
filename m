Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B876C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A820870
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbfA3RcQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:32:16 -0500
Received: from ale.deltatee.com ([207.54.116.67]:39644 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfA3RcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 12:32:16 -0500
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.205])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gotiY-0006g6-4S; Wed, 30 Jan 2019 10:32:07 -0700
To:     Christoph Hellwig <hch@lst.de>, Jerome Glisse <jglisse@redhat.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com> <20190130080208.GC29665@lst.de>
 <4e0637ba-0d7c-66a5-d3de-bc1e7dc7c0ef@amd.com>
 <20190130155543.GC3177@redhat.com> <20190130172653.GA6707@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <39edda88-acd8-c8ec-a6a5-64898006b69f@deltatee.com>
Date:   Wed, 30 Jan 2019 10:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130172653.GA6707@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, jroedel@suse.de, robin.murphy@arm.com, m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, Felix.Kuehling@amd.com, bhelgaas@google.com, rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgg@mellanox.com, Christian.Koenig@amd.com, jglisse@redhat.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-30 10:26 a.m., Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 10:55:43AM -0500, Jerome Glisse wrote:
>> Even outside GPU driver, device driver like RDMA just want to share their
>> doorbell to other device and they do not want to see those doorbell page
>> use in direct I/O or anything similar AFAICT.
> 
> At least Mellanox HCA support and inline data feature where you
> can copy data directly into the BAR.  For something like a usrspace
> NVMe target it might be very useful to do direct I/O straight into
> the BAR for that.

Yup, these are things we definitely want to be able to do, and have done
with hacky garbage code: Direct I/O from NVMe to P2P BAR, then we could
Direct I/O to another drive or map it as an MR and send it over an RNIC.

We'd definitely like to move in that direction. And a world where such
userspace mappings are gimpped by the fact that they are only some
special feature of userspace VMAs that can only be used in specialized
userspace interfaces is not useful to us.

Logan
