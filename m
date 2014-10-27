Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:6870 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbaJ0HIN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Oct 2014 03:08:13 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Thierry Reding" <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 02/10] PCI/MSI: Introduce weak pcibios_msi_controller()
Date: Mon, 27 Oct 2014 15:48:39 +0800
Message-ID: <1414396127-30023-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
References: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce a new weak pcibios_msi_controller() to
get the associate msi_chip for PCI bus. This is
preparation for save msi_chip in arch PCI sysdata.
This weak function will be removed after we save
msi_chip in generic pci_host_bridge.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 1c7ca4a..f085f7f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -30,9 +30,24 @@ int pci_msi_ignore_mask;
 
 /* Arch hooks */
 
+struct msi_controller * __weak pcibios_msi_controller(struct pci_bus *bus)
+{
+	return NULL;
+}
+
+struct msi_controller *pci_msi_controller(struct pci_bus *bus)
+{
+	struct msi_controller *ctrl = bus->msi;
+
+	if (ctrl)
+		return ctrl;
+
+	return pcibios_msi_controller(bus);
+}
+
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
-	struct msi_controller *ctrl = dev->bus->msi;
+	struct msi_controller *ctrl = pci_msi_controller(dev->bus);
 	int err;
 
 	if (!ctrl || !ctrl->setup_irq)
@@ -48,7 +63,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 void __weak arch_teardown_msi_irq(unsigned int irq)
 {
 	struct msi_desc *entry = irq_get_msi_desc(irq);
-	struct msi_controller *ctrl = entry->dev->bus->msi;
+	struct msi_controller *ctrl = pci_msi_controller(entry->dev->bus);
 
 	if (!ctrl || !ctrl->teardown_irq)
 		return;
-- 
1.7.1

