Return-Path: <SRS0=qdHo=LL=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=qdHo=LL=broadcom.com=ray.jui@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH] PCI: iproc: Remove PAXC slot check to allow VF support
Date: Tue, 28 Aug 2018 10:22:58 -0700
Message-Id: <20180828172258.76629-1-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>

Fix previous incorrect logic that limits PAXC slot number to zero only.
In order for SRIOV/VF to work, we need to allow the slot number to be
greater than zero.

Fixes: 46560388c476c ("PCI: iproc: Allow multiple devices except on PAXC")
Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 3160e9342a2f..c20fd6bd68fd 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -630,14 +630,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
 			return (pcie->base + offset);
 	}
 
-	/*
-	 * PAXC is connected to an internally emulated EP within the SoC.  It
-	 * allows only one device.
-	 */
-	if (pcie->ep_is_internal)
-		if (slot > 0)
-			return NULL;
-
 	return iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
 }
 
-- 
2.17.1
