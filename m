Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22050 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756436Ab3AHOdB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Jan 2013 09:33:01 -0500
Date: Tue, 08 Jan 2013 14:32:57 +0000
From: tadeusz.struk@intel.com
To: bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	tadeusz.struk@intel.com
Subject: [PATCH] PCI: Make pci_find_upstream_pcie_bridge() handle non PCIE VFs well
Message-ID: <50ec2e19.EUrQfXEnsRJiPCTv%tadeusz.struk@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_find_upstream_pcie_bridge() doesn't handle well non PCIE VFs
that are part of a PCIE PF device.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/pci/search.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bf969ba..8ecdab2 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -23,6 +23,8 @@ EXPORT_SYMBOL_GPL(pci_bus_sem);
  * if the device isn't connected to a PCIe bridge (that is its parent is a
  * legacy PCI bridge and the bridge is directly connected to bus 0), return its
  * parent
+ * if the device is a VF that doesn't have PCIe cap,
+ * but the PF is a PCIE, return NULL
  */
 struct pci_dev *
 pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
@@ -31,6 +33,10 @@ pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
 
 	if (pci_is_pcie(pdev))
 		return NULL;
+
+	if (pdev->is_virtfn && pci_is_pcie(pdev->physfn))
+		return NULL;
+
 	while (1) {
 		if (pci_is_root_bus(pdev->bus))
 			break;
-- 
1.7.7

