Return-Path: <SRS0=YMSp=7T=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=YMSp=7T=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <keith.busch@intel.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V3 1/2] PCI/DPC: Add local struct device
Date: Thu, 17 Aug 2017 19:48:24 +0800
Message-ID: <1502970505-89777-2-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1502970505-89777-1-git-send-email-liudongdong3@huawei.com>
References: <1502970505-89777-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency in DPC driver.
No functional change intended.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/pcie/pcie-dpc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index c39f32e..836534b 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -87,6 +87,7 @@ static irqreturn_t dpc_irq(int irq, void *context)
 {
 	struct dpc_dev *dpc = (struct dpc_dev *)context;
 	struct pci_dev *pdev = dpc->dev->port;
+	struct device *dev = &pdev->dev;
 	u16 status, source;
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
@@ -95,14 +96,14 @@ static irqreturn_t dpc_irq(int irq, void *context)
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
@@ -119,10 +120,11 @@ static int dpc_probe(struct pcie_device *dev)
 {
 	struct dpc_dev *dpc;
 	struct pci_dev *pdev = dev->port;
+	struct device *device = &pdev->dev;
 	int status;
 	u16 ctl, cap;
 
-	dpc = devm_kzalloc(&dev->device, sizeof(*dpc), GFP_KERNEL);
+	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
 	if (!dpc)
 		return -ENOMEM;
 
@@ -131,10 +133,10 @@ static int dpc_probe(struct pcie_device *dev)
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
@@ -147,7 +149,7 @@ static int dpc_probe(struct pcie_device *dev)
 	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
-	dev_info(&dev->device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
+	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
 		cap & 0xf, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
 		FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
 		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), (cap >> 8) & 0xf,
-- 
1.9.1
