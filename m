Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58348 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbcB2M4N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Feb 2016 07:56:13 -0500
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 6/6] PCI: Enable runtime PM for Intel Broxton PCIe root ports
Date: Mon, 29 Feb 2016 14:56:06 +0200
Message-Id: <1456750566-116248-7-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel Broxton PCIe root ports are capable of being suspended runtime so
allow runtime PM for these ports.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 864c1bdd0e91..43dd23e42c1d 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -436,6 +436,11 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
  * LINUX Device Driver Model
  */
 static const struct pci_device_id port_pci_ids[] = {
+	/* Intel Broxton */
+	{ PCI_VDEVICE(INTEL, 0x1ad6), .driver_data = PCIE_PORT_SPT },
+	{ PCI_VDEVICE(INTEL, 0x1ad7), .driver_data = PCIE_PORT_SPT },
+	{ PCI_VDEVICE(INTEL, 0x5ad8), .driver_data = PCIE_PORT_SPT },
+	{ PCI_VDEVICE(INTEL, 0x5ada), .driver_data = PCIE_PORT_SPT },
 	/* Intel Sunrisepoint */
 	{ PCI_VDEVICE(INTEL, 0x9d14), .driver_data = PCIE_PORT_SPT },
 	{ PCI_VDEVICE(INTEL, 0x9d15), .driver_data = PCIE_PORT_SPT },
-- 
2.7.0

