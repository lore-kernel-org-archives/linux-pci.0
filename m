Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34615 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933746AbeCGPnB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 10:43:01 -0500
Received: by mail-ot0-f194.google.com with SMTP id n74so2452329ota.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2018 07:43:01 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
Subject: [PATCH 9/9] PCI: move private DT related functions into private header
Date: Wed,  7 Mar 2018 09:42:43 -0600
Message-Id: <20180307154243.3205-10-robh@kernel.org>
In-Reply-To: <20180307154243.3205-1-robh@kernel.org>
References: <20180307154243.3205-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The functions in linux/of_pci.h are primarily used by host bridge
drivers, so they can be private to drivers/pci/.

The remaining functions are still used mostly in host bridge drivers
that still live in arch specific code. Hopefully someday, those will get
moved into drivers/pci as well.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/dwc/pci-dra7xx.c           |  1 +
 drivers/pci/dwc/pcie-designware-host.c |  1 +
 drivers/pci/host/pci-aardvark.c        |  2 ++
 drivers/pci/host/pci-ftpci100.c        |  2 ++
 drivers/pci/host/pci-mvebu.c           |  2 ++
 drivers/pci/host/pci-rcar-gen2.c       |  2 ++
 drivers/pci/host/pci-tegra.c           |  2 ++
 drivers/pci/host/pci-v3-semi.c         |  2 ++
 drivers/pci/host/pci-xgene.c           |  2 ++
 drivers/pci/host/pcie-altera.c         |  2 ++
 drivers/pci/host/pcie-iproc-platform.c |  1 +
 drivers/pci/host/pcie-mediatek.c       |  2 ++
 drivers/pci/host/pcie-rcar.c           |  2 ++
 drivers/pci/host/pcie-rockchip.c       |  2 ++
 drivers/pci/host/pcie-xilinx-nwl.c     |  2 ++
 drivers/pci/host/pcie-xilinx.c         |  2 ++
 drivers/pci/pci.h                      | 40 ++++++++++++++++++++++++++++++++++
 include/linux/of_pci.h                 | 34 -----------------------------
 18 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index ed8558d638e5..620709d38a64 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -27,6 +27,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
+#include "../pci.h"
 #include "pcie-designware.h"
 
 /* PCIe controller wrapper DRA7XX configuration registers */
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 8de2d5c69b1d..17faa4c04dd6 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -14,6 +14,7 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 
+#include "../pci.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index b04d37b3c5de..55b94911bc9a 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -19,6 +19,8 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 
+#include "../pci.h"
+
 /* PCIe core registers */
 #define PCIE_CORE_CMD_STATUS_REG				0x4
 #define     PCIE_CORE_CMD_IO_ACCESS_EN				BIT(0)
diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 5008fd87956a..474faa2e922e 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -28,6 +28,8 @@
 #include <linux/irq.h>
 #include <linux/clk.h>
 
+#include "../pci.h"
+
 /*
  * Special configuration registers directly in the first few words
  * in I/O space.
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 5d4dccfc9d81..23e270839e6a 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -21,6 +21,8 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 
+#include "../pci.h"
+
 /*
  * PCIe unit register offsets.
  */
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index a28370bb2b2a..0cb00f2edc89 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -21,6 +21,8 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 /* AHB-PCI Bridge PCI communication registers */
 #define RCAR_AHBPCI_PCICOM_OFFSET	0x800
 
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index dd9b3bcc41c3..8292f763a49b 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -38,6 +38,8 @@
 #include <soc/tegra/cpuidle.h>
 #include <soc/tegra/pmc.h>
 
+#include "../pci.h"
+
 #define INT_PCI_MSI_NR (8 * 32)
 
 /* register definitions */
diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/host/pci-v3-semi.c
index 0a4dea796663..04bf53d02f23 100644
--- a/drivers/pci/host/pci-v3-semi.c
+++ b/drivers/pci/host/pci-v3-semi.c
@@ -33,6 +33,8 @@
 #include <linux/regmap.h>
 #include <linux/clk.h>
 
+#include "../pci.h"
+
 #define V3_PCI_VENDOR			0x00000000
 #define V3_PCI_DEVICE			0x00000002
 #define V3_PCI_CMD			0x00000004
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 0a0d7ee6d3c9..648a50243022 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -22,6 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 #define PCIECORE_CTLANDSTATUS		0x50
 #define PIM1_1L				0x80
 #define IBAR2				0x98
diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 2235f4760951..3292c20abe40 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -17,6 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 #define RP_TX_REG0			0x2000
 #define RP_TX_REG1			0x2004
 #define RP_TX_CNTRL			0x2008
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index e764a2a2693c..fb23fdf919c8 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 
+#include "../pci.h"
 #include "pcie-iproc.h"
 
 static const struct of_device_id iproc_pcie_of_match_table[] = {
diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index a8b20c5012a9..5b3da5856ca2 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -22,6 +22,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
+#include "../pci.h"
+
 /* PCIe shared registers */
 #define PCIE_SYS_CFG		0x00
 #define PCIE_INT_ENABLE		0x0c
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 6ab28f29ac6a..9629ec039deb 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -28,6 +28,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 #define PCIECAR			0x000010
 #define PCIECCTLR		0x000018
 #define  CONFIG_SEND_ENABLE	(1 << 31)
diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index f1e8f97ea1fb..daf9120a4350 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -36,6 +36,8 @@
 #include <linux/reset.h>
 #include <linux/regmap.h>
 
+#include "../pci.h"
+
 /*
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
  * bits.  This allows atomic updates of the register without locking.
diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 0acaf483d031..7702d68abbdc 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -21,6 +21,8 @@
 #include <linux/platform_device.h>
 #include <linux/irqchip/chained_irq.h>
 
+#include "../pci.h"
+
 /* Bridge core config registers */
 #define BRCFG_PCIE_RX0			0x00000000
 #define BRCFG_INTERRUPT			0x00000010
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 0ad188effc09..ec193e930caa 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -23,6 +23,8 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
+#include "../pci.h"
+
 /* Register definitions */
 #define XILINX_PCIE_REG_BIR		0x00000130
 #define XILINX_PCIE_REG_IDR		0x00000138
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd81911b127..d1b91c26b0d4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -396,4 +396,44 @@ static inline u64 pci_rebar_size_to_bytes(int size)
 	return 1ULL << (size + 20);
 }
 
+struct device_node;
+
+#ifdef CONFIG_OF
+int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
+int of_get_pci_domain_nr(struct device_node *node);
+int of_pci_get_max_link_speed(struct device_node *node);
+
+#else
+static inline int
+of_pci_parse_bus_range(struct device_node *node, struct resource *res)
+{
+	return -EINVAL;
+}
+
+static inline int
+of_get_pci_domain_nr(struct device_node *node)
+{
+	return -1;
+}
+
+static inline int
+of_pci_get_max_link_speed(struct device_node *node)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_OF */
+
+#if defined(CONFIG_OF_ADDRESS)
+int of_pci_get_host_bridge_resources(struct device_node *dev,
+			unsigned char busno, unsigned char bus_max,
+			struct list_head *resources, resource_size_t *io_base);
+#else
+static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
+			unsigned char busno, unsigned char bus_max,
+			struct list_head *resources, resource_size_t *io_base)
+{
+	return -EINVAL;
+}
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 091033a6b836..e83d87fc5673 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -13,9 +13,6 @@ struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
-int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
-int of_get_pci_domain_nr(struct device_node *node);
-int of_pci_get_max_link_speed(struct device_node *node);
 void of_pci_check_probe_only(void);
 int of_pci_map_rid(struct device_node *np, u32 rid,
 		   const char *map_name, const char *map_mask_name,
@@ -32,18 +29,6 @@ static inline int of_pci_get_devfn(struct device_node *np)
 	return -EINVAL;
 }
 
-static inline int
-of_pci_parse_bus_range(struct device_node *node, struct resource *res)
-{
-	return -EINVAL;
-}
-
-static inline int
-of_get_pci_domain_nr(struct device_node *node)
-{
-	return -1;
-}
-
 static inline int of_pci_map_rid(struct device_node *np, u32 rid,
 			const char *map_name, const char *map_mask_name,
 			struct device_node **target, u32 *id_out)
@@ -51,12 +36,6 @@ static inline int of_pci_map_rid(struct device_node *np, u32 rid,
 	return -EINVAL;
 }
 
-static inline int
-of_pci_get_max_link_speed(struct device_node *node)
-{
-	return -EINVAL;
-}
-
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
@@ -70,17 +49,4 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 #endif
 
-#if defined(CONFIG_OF_ADDRESS)
-int of_pci_get_host_bridge_resources(struct device_node *dev,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources, resource_size_t *io_base);
-#else
-static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources, resource_size_t *io_base)
-{
-	return -EINVAL;
-}
-#endif
-
 #endif
-- 
2.14.1
