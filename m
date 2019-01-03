Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401FDC43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 22:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1624C21479
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 22:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfACWw3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:52:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:4211 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbfACWw3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 17:52:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 14:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="307303344"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2019 14:52:28 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 0/4] NVMe IRQ sets fixups
Date:   Thu,  3 Jan 2019 15:50:29 -0700
Message-Id: <20190103225033.11249-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes from v1:

  Added documentation to Documentation/PCI/MSI-HOWTO.txt

  Grammar, spelling, and format fixes to commit logs and code comments.

Keith Busch (4):
  nvme-pci: Set tagset nr_maps just once
  nvme-pci: Distribute io queue types after creation
  PCI/MSI: Handle vector reduce and retry
  nvme-pci: Use PCI to handle IRQ reduce and retry

 Documentation/PCI/MSI-HOWTO.txt |  36 +++++++++++-
 drivers/nvme/host/pci.c         | 126 +++++++++++++++++++---------------------
 drivers/pci/msi.c               |  20 ++-----
 include/linux/interrupt.h       |   5 ++
 4 files changed, 107 insertions(+), 80 deletions(-)

-- 
2.14.4

