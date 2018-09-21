Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992DBC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536A021567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwu9wvW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536A021567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390698AbeIUWh6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390415AbeIUWh5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 18:37:57 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E145921565;
        Fri, 21 Sep 2018 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537548494;
        bh=NB80ZvOh4YQqHfMJmQ4hYag9UWb+rjpX8+eT5pv2gr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hwu9wvW13Go+uvuZ+ANfMpGXpRGRGW1bKFGLbU5hYmwS5QBfC2z9FjLV6q2gsHLkO
         Pxg/ubwh87LW8ZIlx2X8JUg62O5FFLT/dnXpV/jQllnEdUI9HUAowiwZC5YNBqZBsS
         YbZh6p58w5kf3zBSyvBwwOSlJxIfzCRRwFnQULHo=
Date:   Fri, 21 Sep 2018 11:48:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvdimm@lists.01.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
Message-ID: <20180921164813.GJ224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-4-logang@deltatee.com>
 <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 08:15:50AM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 12, 2018 at 06:11:46PM -0600, Logan Gunthorpe wrote:
> > The DMA address used when mapping PCI P2P memory must be the PCI bus
> > address. Thus, introduce pci_p2pmem_map_sg() to map the correct
> > addresses when using P2P memory. Memory mapped in this way does not
> > need to be unmapped.
> 
> I think the use of "map" in this context is slightly confusing because the
> general expectation is that map/unmap must be balanced.
> 
> I assume it's because the "mapping" consumes no resources, e.g., requires
> no page table entries.  Possibly there's a better verb than "map", e.g.,
> "convert", "convert_to_p2pdma", etc?
> 
> If you keep "map", maybe add a sentence or two about why there's no
> corresponding unmap?

Another wrinkle is that "map" usually takes an A and gives you back a
B.  Now the caller has both A and B and both are still valid.

Here we pass in an SGL and the SGL is transformed, so the caller only
has B and A has been destroyed, i.e., the SGL can no longer be used as
it was before, and there's no way to get A back.

Maybe this is pointless bikeshedding, so if your color is the best,
don't change anything.

Bjorn
