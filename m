Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D0CC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F44218F0
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfADSfX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:35:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:36551 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbfADSfU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 13:35:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 10:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="123320342"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2019 10:35:19 -0800
Date:   Fri, 4 Jan 2019 11:33:40 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 4/4] nvme-pci: Use PCI to handle IRQ reduce and retry
Message-ID: <20190104183339.GA12508@localhost.localdomain>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-5-keith.busch@intel.com>
 <20190104181938.GB25730@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104181938.GB25730@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 04, 2019 at 07:19:38PM +0100, Christoph Hellwig wrote:
> I can't say I am a huge fan of the complex callback.  If we just made
> the number of read vs write queues a factor instead of invidual
> scalar numbers we could just handle this in the irq code without
> the callback, and the concept might actually be understandable by
> mere humans..

Okay, we could express this as a ratio. I'll explore that path a bit
more.
