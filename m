Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C8AC4151A
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D450B2087F
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfAaIFE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:05:04 -0500
Received: from verein.lst.de ([213.95.11.211]:56220 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfAaIFE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 03:05:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9019B68CEB; Thu, 31 Jan 2019 09:05:01 +0100 (CET)
Date:   Thu, 31 Jan 2019 09:05:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
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
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Message-ID: <20190131080501.GB26495@lst.de>
References: <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com> <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com> <20190129205827.GM10108@mellanox.com> <20190130080208.GC29665@lst.de> <20190130174424.GA17080@mellanox.com> <bcbdfae6-cfc6-c34f-4ff2-7bb9a08f38af@deltatee.com> <20190130191946.GD17080@mellanox.com> <3793c115-2451-1479-29a9-04bed2831e4b@deltatee.com> <20190130204414.GH17080@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130204414.GH17080@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 08:44:20PM +0000, Jason Gunthorpe wrote:
> Not really, for MRs most drivers care about DMA addresses only. The
> only reason struct page ever gets involved is because it is part of
> the GUP, SGL and dma_map family of APIs.

And the only way you get the DMA address is through the dma mapping
APIs.  Which except for the little oddball dma_map_resource expect
a struct page in some form.  And dma_map_resource isn't really up
to speed for full blown P2P.

Now we could and maybe eventually should change all this.  But that
is a pre-requisitive for doing anything more fancy, and not something
to be hacked around.

> O_DIRECT seems to be the justification for struct page, but nobody is
> signing up to make O_DIRECT have the required special GUP/SGL/P2P flow
> that would be needed to *actually* make that work - so it really isn't
> a justification today.

O_DIRECT is just the messenger.  Anything using GUP will need a struct
page, which is all our interfaces that do I/O directly to user pages.
