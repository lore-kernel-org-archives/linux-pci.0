Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756074AbdLOXBx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Dec 2017 18:01:53 -0500
Subject: [PATCH] cxgb4: Simplify PCIe Completion Timeout setting
From: Bjorn Helgaas <helgaas@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Ganesh Goudar <ganeshgr@chelsio.com>
Date: Fri, 15 Dec 2017 17:01:50 -0600
Message-ID: <20171215230150.177674.9821.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Simplify PCIe Completion Timeout setting by using the
pcie_capability_clear_and_set_word() interface.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index f63210f15579..4c99fdb2e13b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -8492,22 +8492,6 @@ static int t4_get_flash_params(struct adapter *adap)
 	return 0;
 }
 
-static void set_pcie_completion_timeout(struct adapter *adapter, u8 range)
-{
-	u16 val;
-	u32 pcie_cap;
-
-	pcie_cap = pci_find_capability(adapter->pdev, PCI_CAP_ID_EXP);
-	if (pcie_cap) {
-		pci_read_config_word(adapter->pdev,
-				     pcie_cap + PCI_EXP_DEVCTL2, &val);
-		val &= ~PCI_EXP_DEVCTL2_COMP_TIMEOUT;
-		val |= range;
-		pci_write_config_word(adapter->pdev,
-				      pcie_cap + PCI_EXP_DEVCTL2, val);
-	}
-}
-
 /**
  *	t4_prep_adapter - prepare SW and HW for operation
  *	@adapter: the adapter
@@ -8593,8 +8577,9 @@ int t4_prep_adapter(struct adapter *adapter)
 	adapter->params.portvec = 1;
 	adapter->params.vpd.cclk = 50000;
 
-	/* Set pci completion timeout value to 4 seconds. */
-	set_pcie_completion_timeout(adapter, 0xd);
+	/* Set PCIe completion timeout to 4 seconds. */
+	pcie_capability_clear_and_set_word(adapter->pdev, PCI_EXP_DEVCTL2,
+					   PCI_EXP_DEVCTL2_COMP_TIMEOUT, 0xd);
 	return 0;
 }
 
