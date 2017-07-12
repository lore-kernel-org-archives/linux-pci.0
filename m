Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:51162 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755861AbdGLJrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2017 05:47:25 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Ray Jui <rjui@broadcom.com>
Subject: [PATCH] PCI: iproc: remove unused struct iproc_pcie *pcie
Date: Wed, 12 Jul 2017 17:47:05 +0800
Message-Id: <1499852825-64990-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It was never used and could be removed, otherwise
we could see a warning:

drivers/pci/host/pcie-iproc-msi.c: In function 'iproc_msi_handler':
drivers/pci/host/pcie-iproc-msi.c:320:21: warning: variable 'pcie' set
but not used [-Wunused-but-set-variable]

Cc: Ray Jui <rjui@broadcom.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-iproc-msi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/host/pcie-iproc-msi.c
index 9fad791..2d0f535 100644
--- a/drivers/pci/host/pcie-iproc-msi.c
+++ b/drivers/pci/host/pcie-iproc-msi.c
@@ -317,7 +317,6 @@ static void iproc_msi_handler(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct iproc_msi_grp *grp;
 	struct iproc_msi *msi;
-	struct iproc_pcie *pcie;
 	u32 eq, head, tail, nr_events;
 	unsigned long hwirq;
 	int virq;
@@ -326,7 +325,6 @@ static void iproc_msi_handler(struct irq_desc *desc)
 
 	grp = irq_desc_get_handler_data(desc);
 	msi = grp->msi;
-	pcie = msi->pcie;
 	eq = grp->eq;
 
 	/*
-- 
1.9.1
