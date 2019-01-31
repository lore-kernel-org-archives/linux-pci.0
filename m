Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6739CC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E49218AC
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfAaICO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:02:14 -0500
Received: from verein.lst.de ([213.95.11.211]:56188 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731016AbfAaICF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 03:02:05 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A164168CEB; Thu, 31 Jan 2019 09:02:03 +0100 (CET)
Date:   Thu, 31 Jan 2019 09:02:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20190131080203.GA26495@lst.de>
References: <20190129174728.6430-4-jglisse@redhat.com> <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com> <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com> <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com> <20190129205827.GM10108@mellanox.com> <20190130080208.GC29665@lst.de> <20190130174424.GA17080@mellanox.com> <bcbdfae6-cfc6-c34f-4ff2-7bb9a08f38af@deltatee.com> <20190130185027.GC5061@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130185027.GC5061@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 01:50:27PM -0500, Jerome Glisse wrote:
> I do not see how VMA changes are any different than using struct page
> in respect to userspace exposure. Those vma callback do not need to be
> set by everyone, in fact expectation is that only handful of driver
> will set those.
> 
> How can we do p2p between RDMA and GPU for instance, without exposure
> to userspace ? At some point you need to tell userspace hey this kernel
> does allow you to do that :)

To do RDMA on a memory region you need struct page backіng to start
with..
