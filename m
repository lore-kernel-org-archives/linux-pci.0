Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FEBC04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECBD2084E
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lH1hLnX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECBD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeLLLNp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:13:45 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:37672 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeLLLNp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 06:13:45 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9627B24E2138;
        Wed, 12 Dec 2018 03:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544613224; bh=K2hKC/6zhy5lsPdlpOslABhs/QShB7zgSUAfrTDJadA=;
        h=From:To:Cc:Subject:Date:From;
        b=lH1hLnX/HiPIG/FPs3V1jFlAHeZtJSJoH4SRiY+jYLVDiRUAKvwo/vKgLHP96t9kr
         WTaBHyX2JbmDeRrgBZMPlu6feLP4q3QsbfplUF6i+74CB4pSE8DhDvnjM45OQ3W+SS
         4OoWZ8+S51EbxN6KOQRVD+KlPYIpDvWxRWcSivgLaEQe8+KD9LdqyCZ1sREz+HCF8O
         7bmvNipbMSRjSjmoxdGkRes2QdXOHXikcMyDjHA9jH3DrMGLPj8Z9No865JDhvyqNa
         uMTBUlN8zIWEqJ0QgiULmYOzTAlhZkScO0gqcxGGHB+Ar6P0Lo9qyn3Iha1r9mUPv6
         UgUx1gEGbouYg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 09DD43CFB;
        Wed, 12 Dec 2018 03:13:44 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 3C7E73BDC0;
        Wed, 12 Dec 2018 12:13:43 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [RFC 0/6] dma: Add Synopsys eDMA IP driver (version 0)
Date:   Wed, 12 Dec 2018 12:13:20 +0100
Message-Id: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
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
  dma: Add Synopsys eDMA IP core driver
  dma: Add Synopsys eDMA IP version 0 support
  dma: Add Synopsys eDMA IP version 0 debugfs support
  dma: Add Synopsys eDMA IP PCIe glue-logic
  MAINTAINERS: Add Synopsys eDMA IP driver maintainer
  pci: pci_ids: Add Synopsys device id 0xedda

 MAINTAINERS                              |   7 +
 drivers/dma/Kconfig                      |   2 +
 drivers/dma/Makefile                     |   1 +
 drivers/dma/dw-edma/Kconfig              |  18 +
 drivers/dma/dw-edma/Makefile             |   7 +
 drivers/dma/dw-edma/dw-edma-core.c       | 945 +++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h       | 145 +++++
 drivers/dma/dw-edma/dw-edma-pcie.c       | 302 ++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 347 ++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  24 +
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 359 ++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  21 +
 drivers/dma/dw-edma/dw-edma-v0-regs.h    | 143 +++++
 drivers/misc/pci_endpoint_test.c         |   2 +-
 include/linux/dma/edma.h                 |  42 ++
 include/linux/pci_ids.h                  |   1 +
 16 files changed, 2365 insertions(+), 1 deletion(-)
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
Cc: Eugeniy Paltsev <paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Joao Pinto <jpinto@synopsys.com>
-- 
2.7.4

