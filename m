Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0084.outbound.protection.outlook.com ([207.46.100.84]:19632
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965589AbcBDPX5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 10:23:57 -0500
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Subject: [PATCH] PCI: Support SRIOV on Legacy EndPoint device
Date: Thu, 4 Feb 2016 15:08:50 +0000
Message-ID: <CY1PR12MB02624BD9D5A28EDAF4B3E61FFED10@CY1PR12MB0262.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index 31f31d4..da4fbac 100644
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
