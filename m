Return-Path: <SRS0=+FHt=72=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=+FHt=72=broadcom.com=oza.oza@kernel.org>
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	<helgaas@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Oza Pawandeep <oza.oza@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v8 1/3] PCI: iproc: factor out ep configuration access
Date: Thu, 24 Aug 2017 10:34:24 +0530
Message-Id: <1503551066-23212-2-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1503551066-23212-1-git-send-email-oza.oza@broadcom.com>
References: <1503551066-23212-1-git-send-email-oza.oza@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

This patch factors out ep configuration access
as a separate function.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index c574863..61d9be6 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -448,6 +448,31 @@ static inline void iproc_pcie_apb_err_disable(struct pci_bus *bus,
 	}
 }
 
+static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
+					       unsigned int busno,
+					       unsigned int slot,
+					       unsigned int fn,
+					       int where)
+{
+	u16 offset;
+	u32 val;
+
+	/* EP device access */
+	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
+		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
+		(fn << CFG_ADDR_FUNC_NUM_SHIFT) |
+		(where & CFG_ADDR_REG_NUM_MASK) |
+		(1 & CFG_ADDR_CFG_TYPE_MASK);
+
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_ADDR, val);
+	offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
+
+	if (iproc_pcie_reg_is_invalid(offset))
+		return NULL;
+
+	return (pcie->base + offset);
+}
+
 /**
  * Note access to the configuration registers are protected at the higher layer
  * by 'pci_lock' in drivers/pci/access.c
@@ -459,7 +484,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
 {
 	unsigned slot = PCI_SLOT(devfn);
 	unsigned fn = PCI_FUNC(devfn);
-	u32 val;
 	u16 offset;
 
 	/* root complex access */
@@ -484,18 +508,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
 		if (slot > 0)
 			return NULL;
 
-	/* EP device access */
-	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
-		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
-		(fn << CFG_ADDR_FUNC_NUM_SHIFT) |
-		(where & CFG_ADDR_REG_NUM_MASK) |
-		(1 & CFG_ADDR_CFG_TYPE_MASK);
-	iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_ADDR, val);
-	offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
-	if (iproc_pcie_reg_is_invalid(offset))
-		return NULL;
-	else
-		return (pcie->base + offset);
+	return iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
 }
 
 static void __iomem *iproc_pcie_bus_map_cfg_bus(struct pci_bus *bus,
-- 
1.9.1
