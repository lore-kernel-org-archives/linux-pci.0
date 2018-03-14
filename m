Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Date: Wed, 14 Mar 2018 14:41:24 +0300
Message-Id: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When system is resumed if the interrupt generation is enabled it may
trigger immediately when interrupts are enabled depending on what is in
the status register. This may generate spurious DPC conditions and
unnecessary removal of devices.

Make this work better with system suspend and disable interrupt
generation when the system is suspended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 38e40c6c576f..14b96983dbbd 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -280,23 +280,44 @@ static int dpc_probe(struct pcie_device *dev)
 	return status;
 }
 
-static void dpc_remove(struct pcie_device *dev)
+static void dpc_interrupt_enable(struct dpc_dev *dpc, bool enable)
 {
-	struct dpc_dev *dpc = get_service_data(dev);
-	struct pci_dev *pdev = dev->port;
+	struct pci_dev *pdev = dpc->dev->port;
 	u16 ctl;
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);
+	if (enable)
+		ctl |= PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
+	else
+		ctl &= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 }
 
+static void dpc_remove(struct pcie_device *dev)
+{
+	dpc_interrupt_enable(get_service_data(dev), false);
+}
+
+static int dpc_suspend(struct pcie_device *dev)
+{
+	dpc_interrupt_enable(get_service_data(dev), false);
+	return 0;
+}
+
+static int dpc_resume(struct pcie_device *dev)
+{
+	dpc_interrupt_enable(get_service_data(dev), true);
+	return 0;
+}
+
 static struct pcie_port_service_driver dpcdriver = {
 	.name		= "dpc",
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.suspend	= dpc_suspend,
+	.resume		= dpc_resume,
 };
 
 static int __init dpc_service_init(void)
-- 
2.16.1

