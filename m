Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DB2C43612
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94852133F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cIr73Rmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbeLQRTr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:19:47 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56488 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732544AbeLQRTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 12:19:47 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CBCE624E27BD;
        Mon, 17 Dec 2018 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545067187; bh=soDh3s6LK9k3liO3hhStLZp8+ZiL9ol3JTveXTvLzXY=;
        h=From:To:Cc:Subject:Date:From;
        b=cIr73RmnQmtZRNfyEkRqtBc2AeYdpQbW0y63C7CQSVM2JQGEOwwuwBI+03eYG9iS+
         DryJBnIx3UWVwuYX8CTAnj7zdzvN2FUn8kXI8y5LXH/R8tk0sJhrNd09VXIS7sZpSn
         DTVyRFZGR6bbwqKE+cRiYmwdLXw0BgViyS8yVZx/gbIfUCWgCIOPe/wK4Ykbu628Pg
         D47jZx3Ns5SxWPDOvFEU7WblfEl0weRgskZxCzh7RGYTX8IwPKDmiMRxxbIPcQHyE/
         mNThZWou3BFnKtTP3dftKGvAkj2k/IH4dbIdbI1KjWHYZtS5MtyrHnEATNRLOBbsUV
         28uUcD+MVu4SQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id CC7E6402B;
        Mon, 17 Dec 2018 09:19:45 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 0713D7EFE;
        Mon, 17 Dec 2018 18:19:45 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: [RFC v2 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
Date:   Mon, 17 Dec 2018 18:19:32 +0100
Message-Id: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys eDMA IP driver (version 0) to Linux kernel. This IP is generally
distributed with Synopsys PCIe EndPoint IP (depends of the use and licensing
agreement), which supports:
 - legacy and unroll modes
 - 16 independent and concurrent channels (8 write + 8 read)
 - supports linked list (scatter-gather) transfer
 - each linked list descriptor can transfer from 1 byte to 4 Gbytes
 - PCIe EndPoint glue-logic

Gustavo Pimentel (6):
  dmaengine: Add Synopsys eDMA IP core driver
  dmaengine: Add Synopsys eDMA IP version 0 support
  dmaengine: Add Synopsys eDMA IP version 0 debugfs support
  PCI: Add Synopsys endpoint EDDA Device id
  dmaengine: Add Synopsys eDMA IP PCIe glue-logic
  MAINTAINERS: Add Synopsys eDMA IP driver maintainer

 MAINTAINERS                              |   7 +
 drivers/dma/Kconfig                      |   2 +
 drivers/dma/Makefile                     |   1 +
 drivers/dma/dw-edma/Kconfig              |  18 +
 drivers/dma/dw-edma/Makefile             |   7 +
 drivers/dma/dw-edma/dw-edma-core.c       | 845 +++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h       | 147 ++++++
 drivers/dma/dw-edma/dw-edma-pcie.c       | 258 ++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 361 +++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  26 +
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 357 +++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  24 +
 drivers/dma/dw-edma/dw-edma-v0-regs.h    | 145 ++++++
 drivers/misc/pci_endpoint_test.c         |   2 +-
 include/linux/dma/edma.h                 |  43 ++
 include/linux/pci_ids.h                  |   1 +
 16 files changed, 2243 insertions(+), 1 deletion(-)
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
Cc: Eugeniy Paltsev <paltsev@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jose Abreu <jose.abreu@synopsys.com>
Cc: Luis Oliveira <lolivei@synopsys.com>
Cc: Vitor Soares <vitor.soares@synopsys.com>
Cc: Nelson Costa <nelson.costa@synopsys.com>
Cc: Pedro Sousa <pedrom.sousa@synopsys.com>

-- 
2.7.4

