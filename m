Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404E5C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E090B20858
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E090B20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbeIYXz6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:55:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:2002 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeIYXz6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 19:55:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 10:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="86469192"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2018 10:46:29 -0700
Date:   Tue, 25 Sep 2018 11:48:35 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v7 10/13] nvme-pci: Add support for P2P memory in requests
Message-ID: <20180925174835.GA12185@localhost.localdomain>
References: <20180925162231.4354-1-logang@deltatee.com>
 <20180925162231.4354-11-logang@deltatee.com>
 <20180925171147.GB11822@localhost.localdomain>
 <3549a9bb-3604-1739-c008-4e1a95441333@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3549a9bb-3604-1739-c008-4e1a95441333@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 11:41:44AM -0600, Logan Gunthorpe wrote:
> Hey,
> 
> On 2018-09-25 11:11 a.m., Keith Busch wrote:
> > Sorry if this was already discussed. Is there a reason the following
> > pattern is not pushed to the generic dma_map_sg_attrs?
> > 
> > 	if (is_pci_p2pdma_page(sg_page(sg)))
> > 		pci_p2pdma_map_sg(dev, sg, nents, dma_dir);
> > 
> > Beyond that, series looks good.
> 
> Yes, this has been discussed. It comes down to a few reasons:
> 
> 1) Intrusiveness on other systems: ie. not needing to pay the cost for
> every single dma_map_sg call
> 
> 2) Consistency: we can add the check to dma_map_sg, but adding similar
> functionality to dma_map_page, etc is difficult seeing it's hard for the
> unmap operation to detect if a dma_addr_t was P2P memory to begin with.
> 
> 3) Safety for developers trying to use P2P memory: Right now developers
> must be careful with P2P pages and ensure they aren't mapped using other
> means (ie dma_map_page). Having them check the drivers that are handling
> the pages to ensure the appropriate map function is always used is and
> that P2P pages aren't being mixed with regular pages is better than
> developers relying on magic in dma_map_sg() and getting things wrong.
> 
> That being said, I think in the future everyone would like to move in
> that direction but it means we will have to solve some difficult
> problems with the existing infrastructure.

Gotchya, thanks for jogging my memory.
