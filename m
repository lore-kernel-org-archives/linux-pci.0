Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A32DC43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE2A21566
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 17:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE2A21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeI0X3h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:29:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:42530 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbeI0X3h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 19:29:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 10:10:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,311,1534834800"; 
   d="scan'208";a="260876714"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2018 10:10:21 -0700
Date:   Thu, 27 Sep 2018 11:12:30 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 13/13] nvmet: Optionally use PCI P2P memory
Message-ID: <20180927171230.GE19589@localhost.localdomain>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-14-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927165420.5290-14-logang@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 27, 2018 at 10:54:20AM -0600, Logan Gunthorpe wrote:
> We create a configfs attribute in each nvme-fabrics target port to
> enable p2p memory use. When enabled, the port will only then use the
> p2p memory if a p2p memory device can be found which is behind the
> same switch hierarchy as the RDMA port and all the block devices in
> use. If the user enabled it and no devices are found, then the system
> will silently fall back on using regular memory.
> 
> If appropriate, that port will allocate memory for the RDMA buffers
> for queues from the p2pmem device falling back to system memory should
> anything fail.
> 
> Ideally, we'd want to use an NVME CMB buffer as p2p memory. This would
> save an extra PCI transfer as the NVME card could just take the data
> out of it's own memory. However, at this time, only a limited number
> of cards with CMB buffers seem to be available.
> 
> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> Signed-off-by: Steve Wise <swise@opengridcomputing.com>
> [hch: partial rewrite of the initial code]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

I haven't the necessary hardware to try this out, but looking forward
to it in the future. Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
