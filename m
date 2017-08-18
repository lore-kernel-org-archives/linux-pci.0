Return-Path: <SRS0=WTXb=7U=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=WTXb=7U=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <keith.busch@intel.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V4 2/2] PCI/DPC: Add local struct device
Date: Fri, 18 Aug 2017 16:21:49 +0800
Message-ID: <1503044509-35876-3-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1503044509-35876-1-git-send-email-liudongdong3@huawei.com>
References: <1503044509-35876-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency in DPC driver.
No functional change intended.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/pcie/pcie-dpc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 21d524c..ba6ba03 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -71,6 +71,7 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
 	struct pci_dev *pdev = dpc->dev->port;
+	struct device *dev = &dpc->dev->device;
 	u16 status;
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
@@ -80,15 +81,17 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 		pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
 	}
 	if (status & PCI_EXP_DPC_RP_BUSY) {
-		dev_warn(&pdev->dev, "DPC root port still busy\n");
+		dev_warn(dev, "DPC root port still busy\n");
 		return -EBUSY;
 	}
 	return 0;
 }
 
-static void dpc_wait_link_inactive(struct pci_dev *pdev)
+static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
+	struct pci_dev *pdev = dpc->dev->port;
+	struct device *dev = &dpc->dev->device;
 	u16 lnk_status;
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
@@ -98,7 +101,7 @@ static void dpc_wait_link_inactive(struct pci_dev *pdev)
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 	}
 	if (lnk_status & PCI_EXP_LNKSTA_DLLLA)
-		dev_warn(&pdev->dev, "Link state not disabled for DPC event\n");
+		dev_warn(&dev, "Link state not disabled for DPC event\n");
 }
 
 static void interrupt_event_handler(struct work_struct *work)
@@ -120,7 +123,7 @@ static void interrupt_event_handler(struct work_struct *work)
 	}
 	pci_unlock_rescan_remove();
 
-	dpc_wait_link_inactive(pdev);
+	dpc_wait_link_inactive(dpc);
 	if (dpc->rp && dpc_wait_rp_inactive(dpc))
 		return;
 	if (dpc->rp && dpc->rp_pio_status) {
@@ -246,6 +249,7 @@ static irqreturn_t dpc_irq(int irq, void *context)
 {
 	struct dpc_dev *dpc = (struct dpc_dev *)context;
 	struct pci_dev *pdev = dpc->dev->port;
+	struct device *dev = &dpc->dev->device;
 	u16 status, source;
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
@@ -254,14 +258,14 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	if (!status || status == (u16)(~0))
 		return IRQ_NONE;
 
-	dev_info(&dpc->dev->device, "DPC containment event, status:%#06x source:%#06x\n",
+	dev_info(dev, "DPC containment event, status:%#06x source:%#06x\n",
 		status, source);
 
 	if (status & PCI_EXP_DPC_STATUS_TRIGGER) {
 		u16 reason = (status >> 1) & 0x3;
 		u16 ext_reason = (status >> 5) & 0x3;
 
-		dev_warn(&dpc->dev->device, "DPC %s detected, remove downstream devices\n",
+		dev_warn(dev, "DPC %s detected, remove downstream devices\n",
 			 (reason == 0) ? "unmasked uncorrectable error" :
 			 (reason == 1) ? "ERR_NONFATAL" :
 			 (reason == 2) ? "ERR_FATAL" :
@@ -282,10 +286,11 @@ static int dpc_probe(struct pcie_device *dev)
 {
 	struct dpc_dev *dpc;
 	struct pci_dev *pdev = dev->port;
+	struct device *device = &dev->device;
 	int status;
 	u16 ctl, cap;
 
-	dpc = devm_kzalloc(&dev->device, sizeof(*dpc), GFP_KERNEL);
+	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
 	if (!dpc)
 		return -ENOMEM;
 
@@ -294,10 +299,10 @@ static int dpc_probe(struct pcie_device *dev)
 	INIT_WORK(&dpc->work, interrupt_event_handler);
 	set_service_data(dev, dpc);
 
-	status = devm_request_irq(&dev->device, dev->irq, dpc_irq, IRQF_SHARED,
+	status = devm_request_irq(device, dev->irq, dpc_irq, IRQF_SHARED,
 				  "pcie-dpc", dpc);
 	if (status) {
-		dev_warn(&dev->device, "request IRQ%d failed: %d\n", dev->irq,
+		dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
 			 status);
 		return status;
 	}
@@ -310,7 +315,7 @@ static int dpc_probe(struct pcie_device *dev)
 	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
-	dev_info(&dev->device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
+	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
 		cap & 0xf, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
 		FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
 		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), (cap >> 8) & 0xf,
-- 
1.9.1
