Return-Path: <SRS0=Gasj=PG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A5C43387
	for <linux-pci@archiver.kernel.org>; Sat, 29 Dec 2018 04:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75784218A1
	for <linux-pci@archiver.kernel.org>; Sat, 29 Dec 2018 04:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeL2Ep1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:45:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbeL2Ep1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Dec 2018 23:45:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3766683F51;
        Sat, 29 Dec 2018 03:27:00 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B71C5C220;
        Sat, 29 Dec 2018 03:26:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Shan Hai <shan.hai@oracle.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH V2 0/3] nvme pci: two fixes on nvme_setup_irqs
Date:   Sat, 29 Dec 2018 11:26:47 +0800
Message-Id: <20181229032650.27256-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sat, 29 Dec 2018 03:27:00 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

The 1st one fixes the case that -EINVAL is returned from pci_alloc_irq_vectors_affinity(),
and it is found without this patch QEMU may fallback to single queue if CPU cores is >= 64.

The 2st one fixes the case that -ENOSPC is returned from pci_alloc_irq_vectors_affinity(),
and boot failure is observed on aarch64 system with less irq vectors.

The last one introduces modules parameter of 'default_queues' for addressing irq vector
exhaustion issue reported by Shan Hai.

Ming Lei (3):
  PCI/MSI: preference to returning -ENOSPC from
    pci_alloc_irq_vectors_affinity
  nvme pci: fix nvme_setup_irqs()
  nvme pci: introduce module parameter of 'default_queues'

 drivers/nvme/host/pci.c | 31 ++++++++++++++++++++++---------
 drivers/pci/msi.c       | 20 +++++++++++---------
 2 files changed, 33 insertions(+), 18 deletions(-)

Cc: Shan Hai <shan.hai@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: linux-pci@vger.kernel.org,
Cc: Bjorn Helgaas <bhelgaas@google.com>,

-- 
2.9.5

