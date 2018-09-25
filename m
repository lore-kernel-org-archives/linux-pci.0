Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF38FC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0177120685
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0177120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeIYXui (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:50:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43588 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeIYXui (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 19:50:38 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g4rLI-0003cH-NV; Tue, 25 Sep 2018 11:41:50 -0600
To:     Keith Busch <keith.busch@intel.com>
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
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20180925162231.4354-1-logang@deltatee.com>
 <20180925162231.4354-11-logang@deltatee.com>
 <20180925171147.GB11822@localhost.localdomain>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3549a9bb-3604-1739-c008-4e1a95441333@deltatee.com>
Date:   Tue, 25 Sep 2018 11:41:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925171147.GB11822@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: axboe@kernel.dk, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, keith.busch@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 10/13] nvme-pci: Add support for P2P memory in requests
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey,

On 2018-09-25 11:11 a.m., Keith Busch wrote:
> Sorry if this was already discussed. Is there a reason the following
> pattern is not pushed to the generic dma_map_sg_attrs?
> 
> 	if (is_pci_p2pdma_page(sg_page(sg)))
> 		pci_p2pdma_map_sg(dev, sg, nents, dma_dir);
> 
> Beyond that, series looks good.

Yes, this has been discussed. It comes down to a few reasons:

1) Intrusiveness on other systems: ie. not needing to pay the cost for
every single dma_map_sg call

2) Consistency: we can add the check to dma_map_sg, but adding similar
functionality to dma_map_page, etc is difficult seeing it's hard for the
unmap operation to detect if a dma_addr_t was P2P memory to begin with.

3) Safety for developers trying to use P2P memory: Right now developers
must be careful with P2P pages and ensure they aren't mapped using other
means (ie dma_map_page). Having them check the drivers that are handling
the pages to ensure the appropriate map function is always used is and
that P2P pages aren't being mixed with regular pages is better than
developers relying on magic in dma_map_sg() and getting things wrong.

That being said, I think in the future everyone would like to move in
that direction but it means we will have to solve some difficult
problems with the existing infrastructure.

Logan

