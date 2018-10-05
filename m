Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93859C00449
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 07:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C460208E7
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 07:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C460208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeJEOIm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:08:42 -0400
Received: from verein.lst.de ([213.95.11.211]:59289 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeJEOIm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 10:08:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BF3FB67358; Fri,  5 Oct 2018 09:11:18 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:11:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
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
Subject: Re: [PATCH v9 12/13] nvmet: Introduce helper functions to allocate
 and free request SGLs
Message-ID: <20181005071118.GA23879@lst.de>
References: <20181004212747.6301-1-logang@deltatee.com> <20181004212747.6301-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004212747.6301-13-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
