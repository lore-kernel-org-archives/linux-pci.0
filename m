Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E95BC43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B74220866
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 13:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfAONLl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:11:41 -0500
Received: from verein.lst.de ([213.95.11.211]:52970 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbfAONLl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 08:11:41 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3D09167358; Tue, 15 Jan 2019 14:11:40 +0100 (CET)
Date:   Tue, 15 Jan 2019 14:11:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-pci@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20190115131140.GB28672@lst.de>
References: <20190103013106.26452-1-ming.lei@redhat.com> <20190114232338.GE33971@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114232338.GE33971@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 14, 2019 at 05:23:39PM -0600, Bjorn Helgaas wrote:
> Applied to pci/msi for v5.1, thanks!
> 
> If this is something that should be in v5.0, let me know and include the
> justification, e.g., something we already merged for v5.0 or regression
> info, etc, and a Fixes: line, and I'll move it to for-linus.

I'd be tempted to queues this up for 5.0.  Ming, what is your position?
