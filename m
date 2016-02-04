Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [165.204.55.251] ([165.204.55.251]:54922 "EHLO
	KellyTonga.amd.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965649AbcBDPBQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 10:01:16 -0500
From: Kelly Zytaruk <kelly.zytaruk@amd.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kelly Zytaruk <kelly.zytaruk@amd.com>
Subject: [PATCH] PCI: Support SRIOV on Legacy EndPoint device
Date: Thu,  4 Feb 2016 09:48:26 -0500
Message-Id: <1454597306-26189-1-git-send-email-kelly.zytaruk@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some AMD GPUs have hardware support for grapics SRIOV.
If the GPU has a display output then the GPU needs to support Legacy VGA operation.
If CLASS_CODE = VGA then the device should have a Port Type = Legacy EndPoint.
Therefore in order to enable SRIOV on a GPU with a display output LEGACY_END_POINT is supported as a valid Port Type.

Signed-off-by: Kelly Zytaruk <kelly.zytaruk@amd.com>
---
 drivers/pci/iov.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 31f31d4..da4fbac 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -388,7 +388,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	struct pci_dev *pdev;
 
 	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
-	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
+	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT &&
+	    pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END)
 		return -ENODEV;
 
 	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
-- 
1.7.10.4

