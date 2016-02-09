Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [165.204.55.251] ([165.204.55.251]:38544 "EHLO
	KellyTonga.amd.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756904AbcBIPlv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 10:41:51 -0500
From: Kelly Zytaruk <kelly.zytaruk@amd.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Kelly Zytaruk <kelly.zytaruk@amd.com>
Subject: [PATCH] [PATCH] PCI: Support SRIOV on Legacy EndPoint device
Date: Tue,  9 Feb 2016 10:41:36 -0500
Message-Id: <1455032496-1538-1-git-send-email-kelly.zytaruk@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is not neccessary to check for PCI_EXP_TYPE in sriov_init().  There appears to be no reason for the check.

Some AMD GPUs have hardware support for grapics SRIOV.
If the GPU has a display output then the GPU needs to support Legacy VGA operation.
If CLASS_CODE = VGA then the device should have a Port Type = Legacy EndPoint.
Therefore in order to enable SRIOV on a GPU with a display output, LEGACY_END_POINT is supported as a valid Port Type by removing the check for Port Type.

Patch is also logged in Bugzilla #112221

Signed-off-by: Kelly Zytaruk <kelly.zytaruk@amd.com>
---
 drivers/pci/iov.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 31f31d4..fe4bd0a 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -387,10 +387,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	struct resource *res;
 	struct pci_dev *pdev;
 
-	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
-	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
-		return -ENODEV;
-
 	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
 	if (ctrl & PCI_SRIOV_CTRL_VFE) {
 		pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, 0);
-- 
1.7.10.4

