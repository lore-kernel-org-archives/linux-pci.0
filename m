Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B8C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086D920869
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 18:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfA3SFq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:05:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfA3SFq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 13:05:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F72D89ACD;
        Wed, 30 Jan 2019 18:05:45 +0000 (UTC)
Received: from redhat.com (ovpn-126-0.rdu2.redhat.com [10.10.126.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33CD55C21A;
        Wed, 30 Jan 2019 18:05:43 +0000 (UTC)
Date:   Wed, 30 Jan 2019 13:05:41 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>,
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
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Message-ID: <20190130180541.GA5061@redhat.com>
References: <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com>
 <20190130080208.GC29665@lst.de>
 <4e0637ba-0d7c-66a5-d3de-bc1e7dc7c0ef@amd.com>
 <20190130155543.GC3177@redhat.com>
 <20190130172653.GA6707@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130172653.GA6707@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 30 Jan 2019 18:05:45 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 06:26:53PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 10:55:43AM -0500, Jerome Glisse wrote:
> > Even outside GPU driver, device driver like RDMA just want to share their
> > doorbell to other device and they do not want to see those doorbell page
> > use in direct I/O or anything similar AFAICT.
> 
> At least Mellanox HCA support and inline data feature where you
> can copy data directly into the BAR.  For something like a usrspace
> NVMe target it might be very useful to do direct I/O straight into
> the BAR for that.

And what i am proposing is not exclusive of that. If exporting device
wants to have struct page for its BAR than it can do so. What i do not
want is imposing that burden on everyone as many devices do not want
or do not care for that. Moreover having struct page and allowing that
struct page to trickle know in obscure corner of the kernel means that
exporter that want that will also have the burden to check that what
they are doing does not end up in something terribly bad.

While i would like a one API fits all i do not think that we can sanely
do that for P2P. They are too much differences between how different
devices expose and manage their BAR to make any such attempt reasonably
sane.

Maybe thing will evolve oragnicaly, but for now i do not see a way out
side the API i am proposing (again this is not exclusive of the struct
page API that is upstream both can co-exist and a device can use both
or just one).

Cheers,
Jérôme
