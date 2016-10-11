Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 3/4] PCI: dra7xx: Add support to force RC to work in GEN1 mode
Date: Tue, 11 Oct 2016 18:28:34 +0530
Message-ID: <1476190715-16884-4-git-send-email-kishon@ti.com>
In-Reply-To: <1476190715-16884-1-git-send-email-kishon@ti.com>
References: <1476190715-16884-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe in AM57x/DRA7x devices is by default
configured to work in GEN2 mode.  However there
may be situations when working in GEN1 mode is
desired. One example is limitation i925 (PCIe GEN2
mode not supported at junction temperatures < 0C).

Add support to force Root Complex to work in GEN1
mode if so desired, but don't force GEN1 mode on
any board just yet.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt |    1 +
 drivers/pci/host/pci-dra7xx.c                    |   27 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 60e2516..a3d6ca3 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -25,6 +25,7 @@ PCIe Designware Controller
 
 Optional Property:
  - gpios : Should be added if a gpio line is required to drive PERST# line
+ - ti,pcie-is-gen1 : Force the PCIe controller to work in GEN1 (2.5 GT/s).
 
 Example:
 axi {
diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 4ccba6d..2a669cb 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -63,11 +63,14 @@
 #define	LINK_UP						BIT(16)
 #define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
 
+#define EXP_CAP_ID_OFFSET				0x70
+
 struct dra7xx_pcie {
 	struct pcie_port	pp;
 	void __iomem		*base;		/* DT ti_conf */
 	int			phy_count;	/* DT phy-names count */
 	struct phy		**phy;
+	bool			is_gen1;
 };
 
 #define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
@@ -96,12 +99,33 @@ static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx_pcie)
 	struct pcie_port *pp = &dra7xx_pcie->pp;
 	struct device *dev = pp->dev;
 	u32 reg;
+	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(dev, "link is already up\n");
 		return 0;
 	}
 
+	if (dra7xx_pcie->is_gen1) {
+		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
+				 4, &reg);
+		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
+			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
+			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
+					  PCI_EXP_LNKCAP, 4, reg);
+		}
+
+		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
+				 2, &reg);
+		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
+			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
+			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
+					  PCI_EXP_LNKCTL2, 2, reg);
+		}
+	}
+
 	reg = dra7xx_pcie_readl(dra7xx_pcie, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx_pcie, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
@@ -402,6 +426,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	reg &= ~LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx_pcie, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
+	if (of_property_read_bool(np, "ti,pcie-is-gen1"))
+		dra7xx_pcie->is_gen1 = true;
+
 	ret = dra7xx_add_pcie_port(dra7xx_pcie, pdev);
 	if (ret < 0)
 		goto err_gpio;
-- 
1.7.9.5
