Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:61974 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaJ0BeX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 26 Oct 2014 21:34:23 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <wangyijing@huawei.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH] MSI: Remove the redundant irq_set_chip_data()
Date: Mon, 27 Oct 2014 10:15:50 +0800
Message-ID: <1414376150-20633-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, pcie-designware, pcie-rcar and pci-tegra drivers
use irq chip_data to save the msi_chip pointer. They
already call irq_set_chip_data() in their own MSI irq map
functions. And chip_data is an opaque pointer, how to use
it is arch dependent. It should not be placed in MSI core.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/msi.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9fab30a..38511d9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -41,14 +41,13 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	if (err < 0)
 		return err;
 
-	irq_set_chip_data(desc->irq, chip);
-
 	return 0;
 }
 
 void __weak arch_teardown_msi_irq(unsigned int irq)
 {
-	struct msi_chip *chip = irq_get_chip_data(irq);
+	struct msi_desc *entry = irq_get_msi_desc(irq);
+	struct msi_chip *chip = entry->dev->bus->msi;
 
 	if (!chip || !chip->teardown_irq)
 		return;
-- 
1.7.1

