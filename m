Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:50095 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755634AbdGLJvd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2017 05:51:33 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: [PATCH] PCI: altera: remove unused num_of_vectors variable
Date: Wed, 12 Jul 2017 17:51:16 +0800
Message-Id: <1499853076-71180-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It was never used and could be removed, otherwise
we could see a warning:

drivers/pci/host/pcie-altera-msi.c: In function 'altera_msi_isr':
drivers/pci/host/pcie-altera-msi.c:67:6: warning: variable
'num_of_vectors' set but not used [-Wunused-but-set-variable]

Cc: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-altera-msi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
index 4e5d628..2864030 100644
--- a/drivers/pci/host/pcie-altera-msi.c
+++ b/drivers/pci/host/pcie-altera-msi.c
@@ -64,13 +64,11 @@ static void altera_msi_isr(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct altera_msi *msi;
 	unsigned long status;
-	u32 num_of_vectors;
 	u32 bit;
 	u32 virq;
 
 	chained_irq_enter(chip, desc);
 	msi = irq_desc_get_handler_data(desc);
-	num_of_vectors = msi->num_of_vectors;
 
 	while ((status = msi_readl(msi, MSI_STATUS)) != 0) {
 		for_each_set_bit(bit, &status, msi->num_of_vectors) {
-- 
1.9.1
