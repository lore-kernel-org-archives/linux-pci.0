Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3885353A6F;
	Thu,  2 Jul 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005341; cv=none; b=JbmN1ZjipP6c0512YcJdeReN2nQavglOEuG4gHuvxFVOkOtIIZ7VAHTuyd7eW5pCCYY28aorolInaA/TpB7nF4Ms4x2VwUMpqIh5QEgYBlX0L/Cfgsu76wTbybHRj5XhllzylSNQb4yZwh+tSMRTi2ZJIsEaMWEyml3Ivj6Wo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005341; c=relaxed/simple;
	bh=64sEJ70pMqIorPYpE4ozxX1HPSdtTnd0AhgORamF6ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IVPWc6vGbwsgJ49FlEW4UDkl5Wvf7delsCWAP0bX63WzrYz/WSaBRULO00XdmHIDg/5ArIskAQO1KYefCaDbAdP1Rj8jZmXsO0YU4rl/J4s6Jf28S63tXgEdJ7zSxz5KBAp53KATRIjOCD95KxeM1kk2lgRrEFDmpYgykoEsbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=pDCrfVri; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="pDCrfVri"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E8312EC1F3;
	Thu,  2 Jul 2026 17:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1783004831; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ScyQhIkjFFeLltD3MMNuyE4Zhyfx9/649xL6SwKi5zo=;
	b=pDCrfVriwEIfnYuMy77/ILvwXL/l9d/M8D2nkFUHoCQMWcO4fJVVbuu+rmd0PFyGbsnWH/
	UZ1NeDWiehSTDvfq6AdWhorMNoK9VJ23IKL7fCCn0+HgdjHGhQV07BJ+ZkbGEYYB+IJM9U
	+xmJJMcruGJ85mA8MCZAABLXnHktyjeapDNrHxQVMCsXxA68DZuXdfUFJ0PRJU/OuS0T/K
	Z6mocXcSHGoFvifavCNbkrTAObN7uk3C1ko95FFRuVvKLCuLZPvjBcWkjO8BtbqKSwLS88
	3k9NYb/QGSNhvi/FCTnEikOg+GUyEeYohT/9X3mtqLu+d7mEQUmBe3w6bve+Wg==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: linux-pci@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	naseefkm@gmail.com,
	ryder.lee@mediatek.com,
	helgaas@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ansuelsmth@gmail.com,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v11] PCI: mediatek: Add support for EcoNet EN7528 SoC
Date: Thu,  2 Jul 2026 15:07:04 +0000
Message-Id: <20260702150704.265282-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add support for the PCIe present on the EcoNet EN7528 (and EN751221) SoCs.

These SoCs have a mix of Gen1 and Gen2 capable ports, but the Gen2 ports
require re-training after startup.

Co-developed-by: Ahmed Naseef <naseefkm@gmail.com>
Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
Rebased on bcabbbd29c53 ("Merge branch 'pci/controller/rzg3s-host'")
v10: https://lore.kernel.org/linux-mips/20260611082329.243515-1-cjd@cjdns.fr/
---
 drivers/pci/controller/Kconfig         |   2 +-
 drivers/pci/controller/pcie-mediatek.c | 154 +++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 2247709ef6d6..8a3a31b2bc12 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -209,7 +209,7 @@ config PCI_MVEBU
 
 config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
-	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
+	depends on ARCH_AIROHA || ARCH_MEDIATEK || ECONET || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI
 	select IRQ_MSI_LIB
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 8b57c3d75b94..a60d1ae076f8 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -10,11 +10,13 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
+#include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/msi.h>
@@ -78,6 +80,7 @@
 
 #define PCIE_CONF_VEND_ID	0x100
 #define PCIE_CONF_DEVICE_ID	0x102
+#define PCIE_CONF_REV_CLASS	0x104
 #define PCIE_CONF_CLASS_ID	0x106
 
 #define PCIE_INT_MASK		0x420
@@ -90,6 +93,11 @@
 #define MSI_MASK		BIT(23)
 #define MTK_MSI_IRQS_NUM	32
 
+#define EN7528_HOST_MODE	0x00804201
+#define EN7528_LINKUP_REG	0x50
+#define EN7528_RC0_LINKUP	BIT(1)
+#define EN7528_RC1_LINKUP	BIT(2)
+
 #define PCIE_AHB_TRANS_BASE0_L	0x438
 #define PCIE_AHB_TRANS_BASE0_H	0x43c
 #define AHB2PCIE_SIZE(x)	((x) & GENMASK(4, 0))
@@ -145,12 +153,15 @@ struct mtk_pcie_port;
  * @MTK_PCIE_FIX_DEVICE_ID: host's device ID needed to be fixed
  * @MTK_PCIE_NO_MSI: Bridge has no MSI support, and relies on an external block
  * @MTK_PCIE_SKIP_RSTB: Skip calling RSTB bits on PCIe probe
+ * @MTK_PCIE_RETRAIN: Retrain link to bridge after startup because some
+ *                    Gen2-capable devices start as Gen1.
  */
 enum mtk_pcie_quirks {
 	MTK_PCIE_FIX_CLASS_ID = BIT(0),
 	MTK_PCIE_FIX_DEVICE_ID = BIT(1),
 	MTK_PCIE_NO_MSI = BIT(2),
 	MTK_PCIE_SKIP_RSTB = BIT(3),
+	MTK_PCIE_RETRAIN = BIT(4),
 };
 
 /**
@@ -756,6 +767,134 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	return 0;
 }
 
+static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
+{
+	struct mtk_pcie *pcie = port->pcie;
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct resource *mem = NULL;
+	struct resource_entry *entry;
+	u32 val, link_mask;
+	int err;
+
+	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
+	if (entry)
+		mem = entry->res;
+	if (!mem)
+		return -EINVAL;
+
+	if (!pcie->cfg) {
+		dev_err(pcie->dev, "EN7528: pciecfg syscon not available\n");
+		return -EINVAL;
+	}
+
+	/* Assert all reset signals */
+	writel(0, port->base + PCIE_RST_CTRL);
+
+	/*
+	 * Enable PCIe link down reset, if link status changed from link up to
+	 * link down, this will reset MAC control registers and configuration
+	 * space.
+	 */
+	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
+
+	msleep(PCIE_T_PVPERL_MS);
+
+	/* De-assert PHY, PE, PIPE, MAC and configuration reset */
+	val = readl(port->base + PCIE_RST_CTRL);
+	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
+	       PCIE_MAC_SRSTB | PCIE_CRSTB;
+	writel(val, port->base + PCIE_RST_CTRL);
+
+	writel(PCIE_CLASS_CODE | PCIE_REVISION_ID,
+	       port->base + PCIE_CONF_REV_CLASS);
+	writel(EN7528_HOST_MODE, port->base);
+
+	link_mask = (port->slot == 0) ? EN7528_RC0_LINKUP : EN7528_RC1_LINKUP;
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	err = regmap_read_poll_timeout(pcie->cfg, EN7528_LINKUP_REG, val,
+				       !!(val & link_mask), 20,
+				       PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
+	if (err) {
+		dev_err(pcie->dev, "EN7528: port%d link timeout\n", port->slot);
+		return -ETIMEDOUT;
+	}
+
+	/* Activate INTx interrupts */
+	val = readl(port->base + PCIE_INT_MASK);
+	val &= ~INTX_MASK;
+	writel(val, port->base + PCIE_INT_MASK);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		mtk_pcie_enable_msi(port);
+
+	/* Set AHB to PCIe translation windows */
+	val = lower_32_bits(mem->start) |
+	      AHB2PCIE_SIZE(fls(resource_size(mem)));
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
+
+	val = upper_32_bits(mem->start);
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
+
+	writel(WIN_ENABLE, port->base + PCIE_AXI_WINDOW0);
+
+	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK))
+		dev_info(pcie->dev,
+			 "module not built-in, Gen2 unavailable even if supported\n");
+
+	return 0;
+}
+
+/**
+ * mtk_pcie_retrain - retrain the root bridge link if needed
+ * @dev: The device, for use in logging
+ * @host: The host bridge which contains the link
+ *
+ * Due to what is likely a hardware bug, some devices (notably EcoNet) start up
+ * as Gen1, and must be retrained once after initial configuration in order to
+ * reach Gen2.
+ *
+ * These devices always self-identify as Gen2 capable, but sometimes the PHY is
+ * only capable of Gen1 operation, and sometimes the PCIe card (e.g. wifi) is
+ * only Gen1 capable. Therefore it is most convenient to retrain every port
+ * after startup.
+ */
+static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *host)
+{
+	struct pci_dev *rp;
+	int ret = -ENOENT;
+	u16 lnksta = 0;
+	u32 speed;
+
+	/* Should already have been warned about during startup_port */
+	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK))
+		return 0;
+
+	guard(rwsem_read)(&pci_bus_sem);
+
+	for_each_pci_bridge(rp, host->bus) {
+		if (pci_pcie_type(rp) != PCI_EXP_TYPE_ROOT_PORT)
+			continue;
+
+#if IS_BUILTIN(CONFIG_PCIE_MEDIATEK)
+		ret = pcie_retrain_link(rp, true);
+#endif
+
+		if (ret)
+			return dev_err_probe(&rp->dev, ret,
+					     "failed to retrain port\n");
+
+		pcie_capability_read_word(rp, PCI_EXP_LNKSTA, &lnksta);
+		speed = lnksta & PCI_EXP_LNKSTA_CLS;
+
+		pci_info(rp, "link retrained, speed %s\n",
+			 pci_speed_string(pcie_link_speed[speed]));
+
+	}
+
+	return 0;
+}
+
 static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus,
 				      unsigned int devfn, int where)
 {
@@ -1169,6 +1308,13 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto put_resources;
 
+	/*
+	 * Ignore error because pci_host_probe() was already called, and in any
+	 * case it is possible that the port will still work as Gen1.
+	 */
+	if (pcie->soc->quirks & MTK_PCIE_RETRAIN)
+		mtk_pcie_retrain(dev, host);
+
 	return 0;
 
 put_resources:
@@ -1290,8 +1436,16 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
 	.quirks = MTK_PCIE_FIX_CLASS_ID | MTK_PCIE_FIX_DEVICE_ID,
 };
 
+static const struct mtk_pcie_soc mtk_pcie_soc_en7528 = {
+	.ops = &mtk_pcie_ops_v2,
+	.startup = mtk_pcie_startup_port_en7528,
+	.setup_irq = mtk_pcie_setup_irq,
+	.quirks = MTK_PCIE_RETRAIN,
+};
+
 static const struct of_device_id mtk_pcie_ids[] = {
 	{ .compatible = "airoha,an7583-pcie", .data = &mtk_pcie_soc_an7583 },
+	{ .compatible = "econet,en7528-pcie", .data = &mtk_pcie_soc_en7528 },
 	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },

base-commit: bcabbbd29c53a5b07eff29f8861d045b2c709c26
-- 
2.39.5

