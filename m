Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com ([104.47.32.58]:30460
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728340AbeIKAXh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Sep 2018 20:23:37 -0400
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: linux-pci@vger.kernel.org
Cc: okaya@codeaurora.org, bhelgaas@google.com,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH for-rc] PCI: Fix enabling of PASID on RC integrated endpoints
Date: Mon, 10 Sep 2018 15:27:42 -0400
Message-Id: <1536607662-11690-1-git-send-email-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Set the eetlp_prefix_path on PCIE_EXP_TYPE_RC_END devices to allow PASID
to be enabled on them. This fixes IOMMUv2 initialization on AMD Carrizo
APUs.

Fixes: 7ce3f912ae ("PCI: Enable PASID only if entire path supports End-End TLP prefixes")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201079
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec78400..201f9e5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2074,6 +2074,7 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_PASID
 	struct pci_dev *bridge;
+	int pcie_type;
 	u32 cap;
 
 	if (!pci_is_pcie(dev))
@@ -2083,7 +2084,9 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_EE_PREFIX))
 		return;
 
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+	pcie_type = pci_pcie_type(dev);
+	if (pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
+	    pcie_type == PCI_EXP_TYPE_RC_END)
 		dev->eetlp_prefix_path = 1;
 	else {
 		bridge = pci_upstream_bridge(dev);
-- 
2.7.4
