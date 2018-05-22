Return-Path: <SRS0=Jy+Z=IJ=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=Jy+Z=IJ=broadcom.com=ray.jui@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 2/2] PCI: iproc: Reduce inbound/outbound mapping print level
Date: Tue, 22 May 2018 10:05:09 -0700
Message-Id: <1527008709-20786-3-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1527008709-20786-1-git-send-email-ray.jui@broadcom.com>
References: <1527008709-20786-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

Reduce inbound/outbound mapping print level from dev_info to
dev_dbg. This reduces the console logs during Linux boot process

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index b1d8c60..14f374d 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -827,14 +827,14 @@ static inline int iproc_pcie_ob_write(struct iproc_pcie *pcie, int window_idx,
 	writel(lower_32_bits(pci_addr), pcie->base + omap_offset);
 	writel(upper_32_bits(pci_addr), pcie->base + omap_offset + 4);
 
-	dev_info(dev, "ob window [%d]: offset 0x%x axi %pap pci %pap\n",
-		 window_idx, oarr_offset, &axi_addr, &pci_addr);
-	dev_info(dev, "oarr lo 0x%x oarr hi 0x%x\n",
-		 readl(pcie->base + oarr_offset),
-		 readl(pcie->base + oarr_offset + 4));
-	dev_info(dev, "omap lo 0x%x omap hi 0x%x\n",
-		 readl(pcie->base + omap_offset),
-		 readl(pcie->base + omap_offset + 4));
+	dev_dbg(dev, "ob window [%d]: offset 0x%x axi %pap pci %pap\n",
+		window_idx, oarr_offset, &axi_addr, &pci_addr);
+	dev_dbg(dev, "oarr lo 0x%x oarr hi 0x%x\n",
+		readl(pcie->base + oarr_offset),
+		readl(pcie->base + oarr_offset + 4));
+	dev_dbg(dev, "omap lo 0x%x omap hi 0x%x\n",
+		readl(pcie->base + omap_offset),
+		readl(pcie->base + omap_offset + 4));
 
 	return 0;
 }
@@ -1001,8 +1001,8 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
 	    iproc_pcie_reg_is_invalid(imap_offset))
 		return -EINVAL;
 
-	dev_info(dev, "ib region [%d]: offset 0x%x axi %pap pci %pap\n",
-		 region_idx, iarr_offset, &axi_addr, &pci_addr);
+	dev_dbg(dev, "ib region [%d]: offset 0x%x axi %pap pci %pap\n",
+		region_idx, iarr_offset, &axi_addr, &pci_addr);
 
 	/*
 	 * Program the IARR registers.  The upper 32-bit IARR register is
@@ -1012,9 +1012,9 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
 	       pcie->base + iarr_offset);
 	writel(upper_32_bits(pci_addr), pcie->base + iarr_offset + 4);
 
-	dev_info(dev, "iarr lo 0x%x iarr hi 0x%x\n",
-		 readl(pcie->base + iarr_offset),
-		 readl(pcie->base + iarr_offset + 4));
+	dev_dbg(dev, "iarr lo 0x%x iarr hi 0x%x\n",
+		readl(pcie->base + iarr_offset),
+		readl(pcie->base + iarr_offset + 4));
 
 	/*
 	 * Now program the IMAP registers.  Each IARR region may have one or
@@ -1028,10 +1028,10 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
 		writel(upper_32_bits(axi_addr),
 		       pcie->base + imap_offset + ib_map->imap_addr_offset);
 
-		dev_info(dev, "imap window [%d] lo 0x%x hi 0x%x\n",
-			 window_idx, readl(pcie->base + imap_offset),
-			 readl(pcie->base + imap_offset +
-			       ib_map->imap_addr_offset));
+		dev_dbg(dev, "imap window [%d] lo 0x%x hi 0x%x\n",
+			window_idx, readl(pcie->base + imap_offset),
+			readl(pcie->base + imap_offset +
+			      ib_map->imap_addr_offset));
 
 		imap_offset += ib_map->imap_window_offset;
 		axi_addr += size;
-- 
2.1.4
