Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A5DC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD3F218CD
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfADSV2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:21:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:10912 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfADSV2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 13:21:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 10:21:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="112156786"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jan 2019 10:21:27 -0800
Date:   Fri, 4 Jan 2019 11:19:48 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/4] nvme-pci: Set tagset nr_maps just once
Message-ID: <20190104181947.GA12498@localhost.localdomain>
References: <20190103210954.11129-1-keith.busch@intel.com>
 <20190104181528.GA25651@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104181528.GA25651@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 04, 2019 at 07:15:28PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 03, 2019 at 02:09:51PM -0700, Keith Busch wrote:
> > The driver overwrites the intermediate nr_map assignments to
> > HCTX_MAX_TYPES, so remove those unnecessary temporary settings.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> Actually the more complex calculation is the right one here.
> I've just merged a patch from Jianchao to remove the other line.

Yep, I just saw that. Jianchao's is the right way to go here.
