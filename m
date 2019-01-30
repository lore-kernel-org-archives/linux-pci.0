Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2178FC282D4
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 08:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD2F21473
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 08:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfA3IAI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:00:08 -0500
Received: from verein.lst.de ([213.95.11.211]:50745 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfA3IAI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 03:00:08 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 65FAD68CEC; Wed, 30 Jan 2019 09:00:06 +0100 (CET)
Date:   Wed, 30 Jan 2019 09:00:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Jerome Glisse <jglisse@redhat.com>,
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
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Message-ID: <20190130080006.GB29665@lst.de>
References: <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com> <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com> <20190129205749.GN3176@redhat.com> <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com> <20190129215028.GQ3176@redhat.com> <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com> <20190129234752.GR3176@redhat.com> <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com> <20190130041841.GB30598@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130041841.GB30598@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 04:18:48AM +0000, Jason Gunthorpe wrote:
> Every attempt to give BAR memory to struct page has run into major
> trouble, IMHO, so I like that this approach avoids that.

Way less problems than not having struct page for doing anything
non-trivial.  If you map the BAR to userspace with remap_pfn_range
and friends the mapping is indeed very simple.  But any operation
that expects a page structure, which is at least everything using
get_user_pages won't work.

So you can't do direct I/O to your remapped BAR, you can't create MRs
on it, etc, etc.
