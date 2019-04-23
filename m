Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FC5C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 18:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8AD218D2
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 18:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kkLfeHze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfDWSa0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:30:26 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:60386 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfDWSaZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 14:30:25 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C26EC0B10;
        Tue, 23 Apr 2019 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556044224; bh=P3PDKBh5Tmuow7pKb5XuRnQlmy8Ut8iWYQgNqBVrhY0=;
        h=From:To:Cc:Subject:Date:From;
        b=kkLfeHze7wwyR2EguYqOz0UPS/GXpOqwQTW0lBDlZErcSQnJsFtOoB7UeSaUIJW51
         rKDiUC+dCMgOJmRUPXujjVzPgozqBuyeUtBejKW37C6uZNIt7Il5jIuCBXLg2Go4Hr
         09N1qhhU7IBLJXhTBOoF5eLkhcd4yhI72l9BIzjbBQlY8Mq2jxCyJpl/BBruoJBVSE
         XoKSRe9rhptvby6eHhJozbJR353WACLTbZ8npf8rMR791fi5Jz+2Pic+NsxbcSewj2
         UypJGZjH2b18e3ppd11uYBhDnfmfxme7uoKkMqzWtf1bLeRB9vhyavklP5QeTHlek8
         Up0JkMrB1T8Gw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4F8AFA009A;
        Tue, 23 Apr 2019 18:30:24 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 7E1BC3F820;
        Tue, 23 Apr 2019 20:30:23 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [RFC v6 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
Date:   Tue, 23 Apr 2019 20:30:07 +0200
Message-Id: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys eDMA IP driver (version 0 and for EP side only) to Linux
kernel. This IP is generally distributed with Synopsys PCIe EndPoint IP
(depends of the use and licensing agreement), which supports:
 - legacy and unroll modes
 - 16 independent and concurrent channels (8 write + 8 read)
 - supports linked list (scatter-gather) transfer
 - each linked list descriptor can transfer from 1 byte to 4 Gbytes
 - supports cyclic transfer
 - PCIe EndPoint glue-logic

This patch series contains:
 - eDMA core + eDMA core v0 driver (implements the interface with
 DMAengine controller APIs and interfaces with eDMA HW block)
 - eDMA PCIe glue-logic reference driver (attaches to Synopsys EP and
 provides memory access to eDMA core driver)

Gustavo Pimentel (6):
  dmaengine: Add Synopsys eDMA IP core driver
  dmaengine: Add Synopsys eDMA IP version 0 support
  dmaengine: Add Synopsys eDMA IP version 0 debugfs support
  PCI: Add Synopsys endpoint EDDA Device ID
  dmaengine: Add Synopsys eDMA IP PCIe glue-logic
  MAINTAINERS: Add Synopsys eDMA IP driver maintainer

 MAINTAINERS                              |   7 +
 drivers/dma/Kconfig                      |   2 +
 drivers/dma/Makefile                     |   1 +
 drivers/dma/dw-edma/Kconfig              |  18 +
 drivers/dma/dw-edma/Makefile             |   7 +
 drivers/dma/dw-edma/dw-edma-core.c       | 920 +++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h       | 165 ++++++
 drivers/dma/dw-edma/dw-edma-pcie.c       | 229 ++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 348 ++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  28 +
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 361 ++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  28 +
 drivers/dma/dw-edma/dw-edma-v0-regs.h    | 158 ++++++
 drivers/misc/pci_endpoint_test.c         |   2 +-
 include/linux/dma/edma.h                 |  47 ++
 include/linux/pci_ids.h                  |   1 +
 16 files changed, 2321 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/dw-edma/Kconfig
 create mode 100644 drivers/dma/dw-edma/Makefile
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-pcie.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-regs.h
 create mode 100644 include/linux/dma/edma.h

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Joao Pinto <jpinto@synopsys.com>
-- 
2.7.4

