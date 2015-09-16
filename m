Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH 2/8] PCI: iproc: Remove unused code
Date: Tue, 15 Sep 2015 17:39:16 -0700
Message-ID: <1442363962-29805-3-git-send-email-rjui@broadcom.com>
In-Reply-To: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove unused struct iproc_pcie member irqs and #define
IPROC_PCIE_MAX_NUM_IRQS

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index 4880b09..ecaad57 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -14,8 +14,6 @@
 #ifndef _PCIE_IPROC_H
 #define _PCIE_IPROC_H
 
-#define IPROC_PCIE_MAX_NUM_IRQS 6
-
 /**
  * iProc PCIe device
  * @dev: pointer to device data structure
@@ -34,7 +32,6 @@ struct iproc_pcie {
 #endif
 	struct pci_bus *root_bus;
 	struct phy *phy;
-	int irqs[IPROC_PCIE_MAX_NUM_IRQS];
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 };
 
-- 
1.9.1

