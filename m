Return-Path: <SRS0=pf5Q=PO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FBBC43387
	for <linux-pci@archiver.kernel.org>; Sun,  6 Jan 2019 02:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF489222C3
	for <linux-pci@archiver.kernel.org>; Sun,  6 Jan 2019 02:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfAFC45 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:56:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfAFC45 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jan 2019 21:56:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3B0487621;
        Sun,  6 Jan 2019 02:56:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7C225D75E;
        Sun,  6 Jan 2019 02:56:49 +0000 (UTC)
Date:   Sun, 6 Jan 2019 10:56:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 2/4] nvme-pci: Distribute io queue types after creation
Message-ID: <20190106025643.GB20802@ming.t460p>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-3-keith.busch@intel.com>
 <20190104023121.GB31330@ming.t460p>
 <20190104072106.GA9948@ming.t460p>
 <20190104155324.GA12342@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104155324.GA12342@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 06 Jan 2019 02:56:57 +0000 (UTC)
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

I think this kind of API style(two stages) is more clean, and
error-immune.

- pci_alloc_irq_vectors() is only for allocating irq vectors
- pci_set_irq_vectors_affnity() is for spreading affinity at will


Thanks,
Ming
