Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 8/9] PCI/portdrv: Clean up whitespace
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:50 -0500
Message-ID: <152848877040.14051.14265851714984144776.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Clean up trivial whitespace issues.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_pci.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 76ad08e97a6f..4fc86d0eef9d 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -644,7 +644,7 @@ int pcie_port_device_register(struct pci_dev *dev)
  * this port device.
  */
 static int pcie_portdrv_probe(struct pci_dev *dev,
-					const struct pci_device_id *id)
+			      const struct pci_device_id *id)
 {
 	int status;
 
@@ -759,13 +759,11 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
 	device_for_each_child(&dev->dev, NULL, err_resume_iter);
 }
 
-/*
- * LINUX Device Driver Model
- */
 static const struct pci_device_id port_pci_ids[] = { {
 	/* handle any PCI-Express port */
 	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
-	}, { /* end: all zeroes */ }
+	},
+	{ }
 };
 
 static const struct pci_error_handlers pcie_portdrv_err_handler = {
@@ -777,7 +775,7 @@ static const struct pci_error_handlers pcie_portdrv_err_handler = {
 
 static struct pci_driver pcie_portdriver = {
 	.name		= "pcieport",
-	.id_table	= &port_pci_ids[0],
+	.id_table	= port_pci_ids,
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
@@ -809,7 +807,7 @@ static const struct dmi_system_id pcie_portdrv_dmi_table[] __initconst = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "U-100"),
 		     },
 	 },
-	 {}
+	 { }
 };
 
 static int __init pcie_portdrv_init(void)
