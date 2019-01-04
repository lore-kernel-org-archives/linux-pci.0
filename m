Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F1EC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A4D218CD
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfADSTk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:19:40 -0500
Received: from verein.lst.de ([213.95.11.211]:41147 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfADSTk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 13:19:40 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 05CF868D93; Fri,  4 Jan 2019 19:19:39 +0100 (CET)
Date:   Fri, 4 Jan 2019 19:19:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 4/4] nvme-pci: Use PCI to handle IRQ reduce and retry
Message-ID: <20190104181938.GB25730@lst.de>
References: <20190103225033.11249-1-keith.busch@intel.com> <20190103225033.11249-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103225033.11249-5-keith.busch@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I can't say I am a huge fan of the complex callback.  If we just made
the number of read vs write queues a factor instead of invidual
scalar numbers we could just handle this in the irq code without
the callback, and the concept might actually be understandable by
mere humans..
