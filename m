Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14103 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeIABeu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:50 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 15/16] PCI/DPC: Wait for reset complete
Date: Fri, 31 Aug 2018 15:26:38 -0600
Message-Id: <20180831212639.10196-16-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DPC is only for error recovery. Since we're not removing the topology
and relying on link state interrupts to re-enumerate anymore, the dpc
reset handler has to implement the required reset timings and checks.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 93ce26191a2b..34bac3e2beac 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -66,32 +66,38 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 
 static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
-	struct dpc_dev *dpc;
-	struct pcie_device *pciedev;
-	struct device *devdpc;
-
-	u16 cap;
+	struct device *dev = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
+	struct pcie_device *pciedev = to_pcie_device(dev);
+	struct dpc_dev *dpc = get_service_data(pciedev);
+	u16 cap = dpc->cap_pos;
 
 	/*
 	 * DPC disables the Link automatically in hardware, so it has
 	 * already been reset by the time we get here.
-	 */
-	devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
-	pciedev = to_pcie_device(devdpc);
-	dpc = get_service_data(pciedev);
-	cap = dpc->cap_pos;
-
-	/*
+	 *
 	 * Wait until the Link is inactive, then clear DPC Trigger Status
 	 * to allow the Port to leave DPC.
 	 */
 	pcie_wait_for_link(pdev, false);
-
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
 		return PCI_ERS_RESULT_DISCONNECT;
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
+	/*
+	 * PCIe 4.0r1 6.6.1, a component must enter LTSSM Detect within 20ms,
+	 * after which we should expect an link active if the reset was
+	 * successful. If so, software must wait a minimum 100ms before sending
+	 * configuration requests to devices downstream this port.
+	 *
+	 * If the link fails to activate, either the device was physically
+	 * removed or the link is permanently failed.
+	 */
+	msleep(20);
+	if (!pcie_wait_for_link(pdev, true))
+		return PCI_ERS_RESULT_DISCONNECT;
+	msleep(100);
+
 	if (pdev->subordinate)
 		pdev->subordinate->error_state = pci_channel_io_normal;
 	return PCI_ERS_RESULT_RECOVERED;
-- 
2.14.4
