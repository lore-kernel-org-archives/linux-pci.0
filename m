Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FCEC43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE5621582
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE5621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeI0X0a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:26:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:22489 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeI0X0a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 19:26:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 10:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,311,1534834800"; 
   d="scan'208";a="266401827"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2018 10:07:16 -0700
Date:   Thu, 27 Sep 2018 11:09:26 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 11/13] nvme-pci: Add a quirk for a pseudo CMB
Message-ID: <20180927170925.GB19589@localhost.localdomain>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927165420.5290-12-logang@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 27, 2018 at 10:54:18AM -0600, Logan Gunthorpe wrote:
> Introduce a quirk to use CMB-like memory on older devices that have
> an exposed BAR but do not advertise support for using CMBLOC and
> CMBSIZE.
> 
> We'd like to use some of these older cards to test P2P memory.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

The implementation looks fine, and this is why we have quirks ... but
CMB has existed since 2014! :)

Reviewed-by: Keith Busch <keith.busch@intel.com>
