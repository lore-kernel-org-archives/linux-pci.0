Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:60693 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbcB2M4N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Feb 2016 07:56:13 -0500
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 5/6] PCI: Enable runtime PM for Intel Sunrisepoint PCIe root ports
Date: Mon, 29 Feb 2016 14:56:05 +0200
Message-Id: <1456750566-116248-6-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel Sunrisepoint (Skylake PCH) PCIe root ports are capable of being
suspended runtime so allow runtime PM for these ports.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index eb0f425f51cc..864c1bdd0e91 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -81,6 +81,7 @@ static int pcie_portdrv_restore_config(struct pci_dev *dev)
 
 enum pcie_port_type {
 	PCIE_PORT_DEFAULT,
+	PCIE_PORT_SPT,
 };
 
 struct pcie_port_config {
@@ -92,6 +93,10 @@ static const struct pcie_port_config pcie_port_configs[] = {
 	[PCIE_PORT_DEFAULT] = {
 		.suspend_allowed = true,
 	},
+	[PCIE_PORT_SPT] = {
+		.suspend_allowed = true,
+		.runtime_suspend_allowed = true,
+	},
 };
 
 #ifdef CONFIG_PM
@@ -431,6 +436,9 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
  * LINUX Device Driver Model
  */
 static const struct pci_device_id port_pci_ids[] = {
+	/* Intel Sunrisepoint */
+	{ PCI_VDEVICE(INTEL, 0x9d14), .driver_data = PCIE_PORT_SPT },
+	{ PCI_VDEVICE(INTEL, 0x9d15), .driver_data = PCIE_PORT_SPT },
 	/* handle any PCI-Express port */
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
 	  .driver_data = PCIE_PORT_DEFAULT },
-- 
2.7.0

