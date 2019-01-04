Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217C1C43612
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED508218CD
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfADSR2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:17:28 -0500
Received: from verein.lst.de ([213.95.11.211]:41135 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfADSR2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 13:17:28 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D34B368D93; Fri,  4 Jan 2019 19:17:26 +0100 (CET)
Date:   Fri, 4 Jan 2019 19:17:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 2/4] nvme-pci: Distribute io queue types after
 creation
Message-ID: <20190104181726.GA25730@lst.de>
References: <20190103225033.11249-1-keith.busch@intel.com> <20190103225033.11249-3-keith.busch@intel.com> <20190104023121.GB31330@ming.t460p> <20190104072106.GA9948@ming.t460p> <20190104155324.GA12342@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104155324.GA12342@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 04, 2019 at 08:53:24AM -0700, Keith Busch wrote:
> On Fri, Jan 04, 2019 at 03:21:07PM +0800, Ming Lei wrote:
> > Thinking about the patch further: after pci_alloc_irq_vectors_affinity()
> > is returned, queue number for non-polled queues can't be changed at will,
> > because we have to make sure to spread all CPUs on each queue type, and
> > the mapping has been fixed by pci_alloc_irq_vectors_affinity() already.
> > 
> > So looks the approach in this patch may be wrong.
> 
> That's a bit of a problem, and not a new one. We always had to allocate
> vectors before creating IRQ driven CQ's, but the vector affinity is
> created before we know if the queue-pair can be created. Should the
> queue creation fail, there may be CPUs that don't have a queue.
> 
> Does this mean the pci msi API is wrong? It seems like we'd need to
> initially allocate vectors without PCI_IRQ_AFFINITY, then have the
> kernel set affinity only after completing the queue-pair setup.

We can't just easily do that, as we want to allocate the memory for
the descriptors on the correct node.  But we can just free the
vectors and try again if we have to.
