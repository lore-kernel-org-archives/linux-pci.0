Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D216FC169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F37F21B18
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jQip50PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfBKRek (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:34:40 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:36450 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfBKRek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 12:34:40 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 99F0C24E01D3;
        Mon, 11 Feb 2019 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549906479; bh=IWrbO15+fj+FBN+6ioXyYanYd4wK76ZhBjINFDxkv9I=;
        h=From:To:Cc:Subject:Date:From;
        b=jQip50PVyasj/48lnbtAvS6KpXnRS3liCygM71bSGuNbRuWCMJxn1f9A+a18+7xFJ
         TR4nedqkk45rCLNqcltTK7DlqsFQ0LzhxZoBIYOmJuUnqOJGTLxgLyiEddU4r8B+mj
         eBs3/UXogRxvVEiocRZ+wuts0mBSwgt41Juw0WsklPEPPF8kbPAxFYIBcUK61N8k7V
         G7++AYFBzSO+cXd5RxMLC7KujN4GgDfpAC2Apoa8pNn0NApI/lXwdhYqwaLEAOIwUv
         1alc2u9zcy3tDT7uK8nwzHTWObqKmCMM/1O5eOY2iYl/fZTWAbry6DXCmvVVtLtVzU
         YCad7fMSDcAxA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 609D3A00A8;
        Mon, 11 Feb 2019 17:34:39 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 4C5F23C205;
        Mon, 11 Feb 2019 18:34:38 +0100 (CET)
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
Subject: [RFC v5 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
Date:   Mon, 11 Feb 2019 18:34:29 +0100
Message-Id: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
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

 MAINTAINERS                              |    7 +
 drivers/dma/Kconfig                      |    2 +
 drivers/dma/Makefile                     |    1 +
 drivers/dma/dw-edma/Kconfig              |   18 +
 drivers/dma/dw-edma/Makefile             |    7 +
 drivers/dma/dw-edma/dw-edma-core.c       | 1069 ++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h       |  164 +++++
 drivers/dma/dw-edma/dw-edma-pcie.c       |  227 +++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c    |  346 ++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.h    |   26 +
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  359 ++++++++++
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |   26 +
 drivers/dma/dw-edma/dw-edma-v0-regs.h    |  156 +++++
 drivers/misc/pci_endpoint_test.c         |    2 +-
 include/linux/dma/edma.h                 |   43 ++
 include/linux/pci_ids.h                  |    1 +
 16 files changed, 2453 insertions(+), 1 deletion(-)
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

