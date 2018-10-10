Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779AFC43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 19:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEC12098A
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 19:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gosbco6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEC12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJKDWo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbeJKDWo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Oct 2018 23:22:44 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5BB206B2;
        Wed, 10 Oct 2018 19:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539201542;
        bh=rE5Q1ersntdIliySO1U91em+crnfT7kdOeF5NBNzzdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gosbco6X2S1gVGZ1nMqlh26yQdKFXQbe5hlP7tAjX2Ui3jiXKm62/j3qGE5U6pvpf
         S/f5JFIF6GWaK7d6MPa2SO79idi9B0Tavcnz3k04XjHYm11OiuUytxRT7myRFF8zDV
         v9lLdcv8VWOK/sJIOavbmiQ7d+2LE1oTQEN4tEms=
Date:   Wed, 10 Oct 2018 14:59:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Stephen Bates <sbates@raithlin.com>,
        Keith Busch <keith.busch@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
Message-ID: <20181010195901.GE5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-8-logang@deltatee.com>
 <485de371-0e84-6f20-7f3b-cec5635b87fe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485de371-0e84-6f20-7f3b-cec5635b87fe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 05, 2018 at 07:16:04PM -0600, Jens Axboe wrote:
> On 10/4/18 3:27 PM, Logan Gunthorpe wrote:
> > QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> > supports targeting P2P memory. This will be used by P2P providers and
> > orchestrators (in subsequent patches) to ensure block devices can
> > support P2P memory before submitting P2P backed pages to submit_bio().
> 
> Nit pick, but the subject line still says that it checks support
> for requests. This patch just adds the ability to flag support
> in the queue.

What about the following?  MAINTAINERS doesn't list a specific
maintainer for include/linux/blkdev.h (maybe the "BLOCK LAYER" entry
should have an F: pattern for it?), but I'd really like your ack
before merging this.

commit 7e647ae1eda290786851c3dff4f38189b982386d
Author: Logan Gunthorpe <logang@deltatee.com>
Date:   Thu Oct 4 15:27:41 2018 -0600

    block: Add PCI P2P flag for request queue
    
    Add QUEUE_FLAG_PCI_P2P, meaning a driver's request queue supports targeting
    P2P memory.  This will be used by P2P providers and orchestrators (in
    subsequent patches) to ensure block devices can support P2P memory before
    submitting P2P-backed pages to submit_bio().
    
    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6980014357d4..c32f7171899b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -699,6 +699,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
 #define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
+#define QUEUE_FLAG_PCI_P2PDMA  30	/* device supports PCI p2p requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -731,6 +732,8 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
 #define blk_queue_scsi_passthrough(q)	\
 	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
+#define blk_queue_pci_p2pdma(q)	\
+	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
