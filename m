Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8400C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968832075E
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553551970;
	bh=rTPQhfrv7doYYXbwR07pPwkE5fVuYjpCBPbp0u558+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e58tUtemgS7ITZkCFtlSqlGCT6LtPKUQuLz3Zjffh1iPdOHhxPcpXL4Rpt7HLUmtD
	 Jkb1xwHOxemCUlzNB0xe7tQJ/QSNQeRFFo9sAnbLOdbBr2gvXqdaoeMAsHa7mg5blv
	 EBhSdTlQwXNm4nzSJE2gxVLu7erOnxgDOyAZEnoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfCYWMo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbfCYWMn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 18:12:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 731B52075E;
        Mon, 25 Mar 2019 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553551962;
        bh=rTPQhfrv7doYYXbwR07pPwkE5fVuYjpCBPbp0u558+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyeSezvLBh8mPd1P9CsZmmOK0Mw3djSHfglhwhQ44KWmYPDYI+FyAKMFIPhURgAnR
         N3S2ySfCRRLJX8jwaNPhty/g4FrBPJhlho/smnr91XmlMSYQe0V64DkGqrsDxHTi06
         fb9aFKG+Nb0FrUC8pqmW+amKddfbRTeJC9FLH2vo=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] PCI/MSI: Remove unused mask_msi_irq() and unmask_msi_irq()
Date:   Mon, 25 Mar 2019 17:12:29 -0500
Message-Id: <20190325221229.36930-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325221229.36930-1-helgaas@kernel.org>
References: <20190325221229.36930-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Change pcie-xilinx-nwl.c to use pci_msi_mask_irq() and pci_msi_unmask_irq()
like all other PCI host controller drivers.  Remove the now-unused
mask_msi_irq() and unmask_msi_irq().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Michal Simek <michal.simek@xilinx.com>
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 9 ++++-----
 include/linux/msi.h                      | 9 ---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 81538d77f790..3b031f00a94a 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -438,11 +438,10 @@ static const struct irq_domain_ops legacy_domain_ops = {
 #ifdef CONFIG_PCI_MSI
 static struct irq_chip nwl_msi_irq_chip = {
 	.name = "nwl_pcie:msi",
-	.irq_enable = unmask_msi_irq,
-	.irq_disable = mask_msi_irq,
-	.irq_mask = mask_msi_irq,
-	.irq_unmask = unmask_msi_irq,
-
+	.irq_enable = pci_msi_unmask_irq,
+	.irq_disable = pci_msi_mask_irq,
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
 };
 
 static struct msi_domain_info nwl_msi_domain_info = {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index f934982a0e68..052f04fcf953 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -148,15 +148,6 @@ u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
-static inline void mask_msi_irq(struct irq_data *data)
-{
-	pci_msi_mask_irq(data);
-}
-static inline void unmask_msi_irq(struct irq_data *data)
-{
-	pci_msi_unmask_irq(data);
-}
-
 /*
  * The arch hooks to setup up msi irqs. Those functions are
  * implemented as weak symbols so that they /can/ be overriden by
-- 
2.21.0.392.gf8f6787159e-goog

