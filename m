Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588227;
	b=uk9HOw9bmgTrAjrD9sbOjmGJUZOW6VSwp/8IwWQ87ZIr1W0kTSDY2OrF24riATiv8S2S
	 g0rCkr4QngGYNJURV2WEbrst9y4PxTMSScpUWEAFenO62i1hBtXsVzLK6kzlMvOCkH3FV
	 WDR8fvl7q6Taj9QW0SQbMjTQxJpy+HDbAekNosYMQQXcukanGDuXguGW5Dc6CqKMnMWgL
	 Wzsk0LauOfH8h7AGXEpFtN1BK5dUU0+CSUCS8wTWy/YYIEgNxgs7hvbhgREktb8UNdN7l
	 8gT2MFfJt9re6/u2d3aiB03ge6MKHC4WfTCSC8T7Wd5Xx4Ere//SQvd92xaP5J9MGCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588227;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zuIB19EQ7WuXHEG7qThTV9K/2ebxR8lMPfdvLEenEK0=;
	b=d7z0mLNgbUrfB35J+5NTbYjUfO/G9dkITfohScZuYAQoRUVv6RutARHcgFQe3R6U2Aeo
	 3baPAVEFlAP3o76QiaF/BmfwweYHvuUGnrjXjTaeaeKfi7wGdoeCXCMeLAalYMlZ0g3DU
	 2hXnPly2VuejC/jc3IzZxuWTZMSl/1SeBie05bI3waXdY36w4cdg90EPp+j8WGCD13YFW
	 tH7KbVZv5xU2dTAU4wYNCQKoAPGJJMCTbtxQ/SvMV/hO5KCPZN86G+EWQ3/9huvbh4b7H
	 hLOiCMW4b1QKlwnfqe1iFYSah1DLOAgQG3n06yO/ofmHI7i42UcNbjPyG3Acuv8jH4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=ty+x4IeI;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718B606A335;
	Wed, 25 Nov 2026 06:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6718B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=ty+x4IeI
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 64AF54C945;
	Wed, 25 Nov 2026 17:30:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795588218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuIB19EQ7WuXHEG7qThTV9K/2ebxR8lMPfdvLEenEK0=;
	b=ty+x4IeIcqTyetGrCuEfvNWA+4jSVsP8WC6DUYH9jlcDAlyt2G0tWTwt1nO3A/4WfkAyiM
	e2SdMRIgFAISXapU7yKKLUy5Fy2DWw3/FEOdYqKoMKwP5oflSy59BOzHpqL88ofg/bSRGo
	DdmMfWl57tvfjtf02C+IxaZ3waONPa3keQ4wkPo6y6RqY1fWEAIbL8U9MQG01LrI/ZrZOh
	5bO1s0qhN3E76Obkwb0TqdLibkfy2oax+/mQFN/ZgXVWTv+e3/vkoTLQ591MrHsX54381F
	z5TilzErUGBbY4lWikdVEYVVRRW6psW1i5d9lqEzKKoB0YCozD6U5RMRa8bsew==
X-GPT-Reason: legitimate; the email is a technical patch submission
	regarding a Linux kernel driver (PCI: sunxi), which aligns perfectly
	with the sender's personal domain (alastair@d-silva.org) and the
	expected technical content for a developer; the From domain matches
	the sender's identity, there is no marketing/scareware content,
	and no external links or suspicious calls-to-action are present.
From: Alastair D'Silva <alastair@d-silva.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 4/5] PCI: sunxi: Add Allwinner A733 DesignWare PCIe host controller driver
Date: Wed, 25 Nov 2026 17:29:47 +1100
Message-ID: <20261125062948.1234677-5-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125062948.1234677-1-alastair@d-silva.org>
References: <20261125062948.1234677-1-alastair@d-silva.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DesignWare PCIe Root Complex glue driver for Allwinner A733
(sun60i) SoCs using dw_pcie_host_init().

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 MAINTAINERS                             |   8 +
 drivers/pci/controller/dwc/Kconfig      |  15 +
 drivers/pci/controller/dwc/Makefile     |   1 +
 drivers/pci/controller/dwc/pcie-sunxi.c | 505 ++++++++++++++++++++++++
 4 files changed, 529 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-sunxi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ef3162476225..8a5c6a26b24fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -900,6 +900,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/phy/allwinner,sun60i-a733-combophy.yaml
 F:	drivers/phy/allwinner/phy-sun60i-combophy.c
 
+ALLWINNER A733 PCIE DRIVER
+M:	Alastair D'Silva <alastair@d-silva.org>
+L:	linux-pci@vger.kernel.org
+L:	linux-sunxi@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/allwinner,sun60i-a733-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-sunxi.c
+
 ALLWINNER CPUFREQ DRIVER
 M:	Yangtao Li <tiny.windzz@gmail.com>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index dcfbe7e229fde..1c1cfcc917877 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -487,6 +487,21 @@ config PCIE_STM32_EP
 	  This driver can also be built as a module. If so, the module
 	  will be called pcie-stm32-ep.
 
+config PCIE_SUNXI
+	tristate "Allwinner A733 (sun60i) PCIe host controller"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
+	depends on PCI_MSI
+	select GENERIC_PHY
+	select MFD_SYSCON
+	select PCIE_DW_HOST
+	help
+	  Enable support for the Synopsys DesignWare PCIe Root Complex
+	  controller found on Allwinner A733 (sun60i) SoCs. It uses
+	  the generic DesignWare host core and handles Allwinner
+	  clocks, resets, PHY, and legacy INTx interrupts.
+
 config PCI_DRA7XX
 	tristate
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index d4f88cfc6229f..a534eed5a3249 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
 obj-$(CONFIG_PCIE_SPACEMIT_K1) += pcie-spacemit-k1.o
 obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
 obj-$(CONFIG_PCIE_STM32_EP) += pcie-stm32-ep.o
+obj-$(CONFIG_PCIE_SUNXI) += pcie-sunxi.o
 obj-$(CONFIG_PCIE_ULTRARISC) += pcie-ultrarisc.o
 
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/controller/dwc/pcie-sunxi.c b/drivers/pci/controller/dwc/pcie-sunxi.c
new file mode 100644
index 0000000000000..c99a237f6cbd9
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-sunxi.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Allwinner A733 (sun60i) DesignWare PCIe host controller driver
+ *
+ * Copyright (c) 2026 Alastair D'Silva <alastair@d-silva.org>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#include "../../pci.h"
+#include "pcie-designware.h"
+
+/* SerDes subsystem syscon register for PCIe ITS target address */
+#define SERDES_PCIE_ITS_TAGT_ADDR_REG	0x0220
+/* Upper 16 bits of GICv3 ITS GITS_TRANSLATER at 0x03450000 */
+#define SERDES_PCIE_ITS_TAGT_DEFAULT	0x00000345
+
+/* Allwinner PCIe application register offsets (relative to app_base) */
+#define PCIE_APP_CLK_CTRL		0x0800
+#define PCIE_APP_CLK_AUX_EN		BIT(4)
+#define PCIE_APP_CLK_MSTR_AXI_EN	BIT(5)
+#define PCIE_APP_CLK_SLV_AXI_EN		BIT(6)
+#define PCIE_APP_CLK_DBI_EN		BIT(7)
+#define PCIE_APP_CLK_CORE_EN		BIT(8)
+#define PCIE_APP_CLK_PIPE_EN		BIT(9)
+#define PCIE_APP_CLK_REF_EN		BIT(13)
+#define PCIE_APP_CLK_BUS_EN		BIT(21)
+#define PCIE_APP_CLK_SYS_EN		BIT(23)
+#define PCIE_APP_CLK_CTRL_DEFAULT	(PCIE_APP_CLK_SYS_EN | \
+					 PCIE_APP_CLK_BUS_EN | \
+					 PCIE_APP_CLK_REF_EN | \
+					 PCIE_APP_CLK_PIPE_EN | \
+					 PCIE_APP_CLK_CORE_EN | \
+					 PCIE_APP_CLK_DBI_EN | \
+					 PCIE_APP_CLK_SLV_AXI_EN | \
+					 PCIE_APP_CLK_MSTR_AXI_EN | \
+					 PCIE_APP_CLK_AUX_EN)
+
+#define PCIE_LTSSM_CTRL			0x0c00
+#define PCIE_DEVICE_TYPE_RC		BIT(6)
+#define PCIE_LINK_TRAINING		BIT(0)
+#define SII_INT_MASK0			0x0e00
+#define INTX_RX_ASSERT_SHIFT		5
+#define INTX_RX_ASSERT_MASK		GENMASK(8, 5)
+#define INTX_RX_ASSERT(x)		BIT((x) + INTX_RX_ASSERT_SHIFT)
+#define SII_INT_STAS0			0x0e08
+#define PCIE_LINK_STAT			0x0e0c
+#define SMLH_LINK_UP			BIT(0)
+#define RDLH_LINK_UP			BIT(1)
+
+/* Synopsys DWC port logic bit in PCIE_TIMER_CTRL_MAX_FUNC_NUM (0x718) */
+#define PCIE_AXI_CTO_RESP_EN		BIT(19)
+
+#define PCIE_SLV_CLK_RATE		400000000UL
+
+enum sunxi_pcie_clk_id {
+	CLK_ID_AUX,
+	CLK_ID_SLV,
+	CLK_ID_MSTR,
+	NUM_SUNXI_PCIE_CLKS,
+};
+
+enum sunxi_pcie_rst_id {
+	RST_ID_CORE,
+	RST_ID_PWR,
+	RST_ID_MSTR,
+	NUM_SUNXI_PCIE_RSTS,
+};
+
+struct sunxi_pcie {
+	struct dw_pcie pci;
+	void __iomem *app_base;
+	struct regmap *serdes;
+	struct phy *phy;
+	struct clk_bulk_data clks[NUM_SUNXI_PCIE_CLKS];
+	struct reset_control_bulk_data rsts[NUM_SUNXI_PCIE_RSTS];
+	struct gpio_desc *rst_gpio;
+	struct regulator *vpcie3v3;
+	struct irq_domain *intx_irq_domain;
+	raw_spinlock_t intx_lock;
+	int app_irq;
+};
+
+#define to_sunxi_pcie(x)	dev_get_drvdata((x)->dev)
+
+static void sunxi_pcie_intx_irq_mask(struct irq_data *d)
+{
+	struct sunxi_pcie *sunxi = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&sunxi->intx_lock, flags);
+	val = readl(sunxi->app_base + SII_INT_MASK0);
+	val &= ~INTX_RX_ASSERT(hwirq);
+	writel(val, sunxi->app_base + SII_INT_MASK0);
+	raw_spin_unlock_irqrestore(&sunxi->intx_lock, flags);
+}
+
+static void sunxi_pcie_intx_irq_unmask(struct irq_data *d)
+{
+	struct sunxi_pcie *sunxi = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&sunxi->intx_lock, flags);
+	val = readl(sunxi->app_base + SII_INT_MASK0);
+	val |= INTX_RX_ASSERT(hwirq);
+	writel(val, sunxi->app_base + SII_INT_MASK0);
+	raw_spin_unlock_irqrestore(&sunxi->intx_lock, flags);
+}
+
+static const struct irq_chip sunxi_pcie_intx_chip = {
+	.name		= "sunxi-pcie-intx",
+	.irq_mask	= sunxi_pcie_intx_irq_mask,
+	.irq_unmask	= sunxi_pcie_intx_irq_unmask,
+};
+
+static int sunxi_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			       irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sunxi_pcie_intx_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops sunxi_pcie_intx_domain_ops = {
+	.map = sunxi_pcie_intx_map,
+};
+
+static void sunxi_pcie_app_irq_handler(struct irq_desc *desc)
+{
+	struct sunxi_pcie *sunxi = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long status, bit;
+	u32 mask, stas;
+
+	chained_irq_enter(chip, desc);
+
+	mask = readl(sunxi->app_base + SII_INT_MASK0);
+	stas = readl(sunxi->app_base + SII_INT_STAS0);
+	status = (mask & stas) & INTX_RX_ASSERT_MASK;
+
+	bit = INTX_RX_ASSERT_SHIFT;
+	for_each_set_bit_from(bit, &status,
+			      PCI_NUM_INTX + INTX_RX_ASSERT_SHIFT) {
+		writel(BIT(bit), sunxi->app_base + SII_INT_STAS0);
+		generic_handle_domain_irq(sunxi->intx_irq_domain,
+					  bit - INTX_RX_ASSERT_SHIFT);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int sunxi_pcie_init_intx_irq(struct sunxi_pcie *sunxi)
+{
+	struct device *dev = sunxi->pci.dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *intc;
+	int irq;
+
+	intc = of_get_child_by_name(dev->of_node,
+				    "legacy-interrupt-controller");
+	if (!intc)
+		return 0;
+
+	irq = platform_get_irq_byname(pdev, "app");
+	if (irq < 0) {
+		of_node_put(intc);
+		return irq;
+	}
+
+	writel(0, sunxi->app_base + SII_INT_MASK0);
+	writel(~0U, sunxi->app_base + SII_INT_STAS0);
+
+	sunxi->intx_irq_domain =
+		irq_domain_create_linear(of_fwnode_handle(intc), PCI_NUM_INTX,
+					 &sunxi_pcie_intx_domain_ops, sunxi);
+	of_node_put(intc);
+	if (!sunxi->intx_irq_domain)
+		return -ENOMEM;
+
+	irq_set_chained_handler_and_data(irq, sunxi_pcie_app_irq_handler,
+					 sunxi);
+	sunxi->app_irq = irq;
+
+	return 0;
+}
+
+static void sunxi_pcie_deinit_intx_irq(struct sunxi_pcie *sunxi)
+{
+	int i;
+
+	if (sunxi->app_irq > 0) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&sunxi->intx_lock, flags);
+		writel(0, sunxi->app_base + SII_INT_MASK0);
+		raw_spin_unlock_irqrestore(&sunxi->intx_lock, flags);
+		irq_set_chained_handler_and_data(sunxi->app_irq, NULL, NULL);
+		synchronize_irq(sunxi->app_irq);
+		sunxi->app_irq = 0;
+	}
+
+	if (sunxi->intx_irq_domain) {
+		for (i = 0; i < PCI_NUM_INTX; i++)
+			irq_dispose_mapping(irq_find_mapping(sunxi->intx_irq_domain,
+							     i));
+		irq_domain_remove(sunxi->intx_irq_domain);
+		sunxi->intx_irq_domain = NULL;
+	}
+}
+
+static int sunxi_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct sunxi_pcie *sunxi = to_sunxi_pcie(pci);
+	u32 val;
+
+	if (sunxi->serdes)
+		regmap_write(sunxi->serdes, SERDES_PCIE_ITS_TAGT_ADDR_REG,
+			     SERDES_PCIE_ITS_TAGT_DEFAULT);
+
+	/* Configure Root Complex mode */
+	val = readl(sunxi->app_base + PCIE_LTSSM_CTRL);
+	val |= PCIE_DEVICE_TYPE_RC;
+	writel(val, sunxi->app_base + PCIE_LTSSM_CTRL);
+
+	/* Enable AXI completion timeout response and clear coherency regs */
+	dw_pcie_dbi_ro_wr_en(pci);
+	val = dw_pcie_readl_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM);
+	val |= PCIE_AXI_CTO_RESP_EN;
+	dw_pcie_writel_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM, val);
+	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_1_OFF, 0);
+	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0);
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops sunxi_pcie_host_ops = {
+	.init	= sunxi_pcie_host_init,
+};
+
+static bool sunxi_pcie_link_up(struct dw_pcie *pci)
+{
+	struct sunxi_pcie *sunxi = to_sunxi_pcie(pci);
+	u32 val;
+
+	val = readl(sunxi->app_base + PCIE_LINK_STAT);
+
+	return (val & (SMLH_LINK_UP | RDLH_LINK_UP)) ==
+	       (SMLH_LINK_UP | RDLH_LINK_UP);
+}
+
+static int sunxi_pcie_start_link(struct dw_pcie *pci)
+{
+	struct sunxi_pcie *sunxi = to_sunxi_pcie(pci);
+	u32 val;
+
+	if (sunxi->rst_gpio) {
+		/* Ensure T_PERST-CLK (>= 100 us) after REFCLK is stable */
+		usleep_range(100, 200);
+		gpiod_set_value_cansleep(sunxi->rst_gpio, 0);
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+	}
+
+	val = readl(sunxi->app_base + PCIE_LTSSM_CTRL);
+	val |= PCIE_DEVICE_TYPE_RC | PCIE_LINK_TRAINING;
+	writel(val, sunxi->app_base + PCIE_LTSSM_CTRL);
+
+	return 0;
+}
+
+static void sunxi_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct sunxi_pcie *sunxi = to_sunxi_pcie(pci);
+	u32 val;
+
+	val = readl(sunxi->app_base + PCIE_LTSSM_CTRL);
+	val &= ~PCIE_LINK_TRAINING;
+	writel(val, sunxi->app_base + PCIE_LTSSM_CTRL);
+
+	if (sunxi->rst_gpio)
+		gpiod_set_value_cansleep(sunxi->rst_gpio, 1);
+}
+
+static const struct dw_pcie_ops sunxi_dw_pcie_ops = {
+	.link_up	= sunxi_pcie_link_up,
+	.start_link	= sunxi_pcie_start_link,
+	.stop_link	= sunxi_pcie_stop_link,
+};
+
+static int sunxi_pcie_get_resources(struct platform_device *pdev,
+				    struct sunxi_pcie *sunxi)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	sunxi->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
+	if (IS_ERR(sunxi->app_base))
+		return dev_err_probe(dev, PTR_ERR(sunxi->app_base),
+				     "failed to map app registers\n");
+
+	if (of_property_present(dev->of_node, "allwinner,serdes-syscon")) {
+		sunxi->serdes = syscon_regmap_lookup_by_phandle(dev->of_node,
+								"allwinner,serdes-syscon");
+		if (IS_ERR(sunxi->serdes))
+			return dev_err_probe(dev, PTR_ERR(sunxi->serdes),
+					     "failed to get serdes syscon\n");
+	}
+
+	sunxi->clks[CLK_ID_AUX].id = "aux";
+	sunxi->clks[CLK_ID_SLV].id = "slv";
+	sunxi->clks[CLK_ID_MSTR].id = "mstr";
+	ret = devm_clk_bulk_get(dev, NUM_SUNXI_PCIE_CLKS, sunxi->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
+
+	sunxi->rsts[RST_ID_CORE].id = "core";
+	sunxi->rsts[RST_ID_PWR].id = "pwr";
+	sunxi->rsts[RST_ID_MSTR].id = "mstr";
+	ret = devm_reset_control_bulk_get_exclusive(dev, NUM_SUNXI_PCIE_RSTS,
+						    sunxi->rsts);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get resets\n");
+
+	sunxi->phy = devm_phy_get(dev, "pcie0");
+	if (IS_ERR(sunxi->phy))
+		return dev_err_probe(dev, PTR_ERR(sunxi->phy),
+				     "failed to get phy\n");
+
+	sunxi->rst_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(sunxi->rst_gpio))
+		return dev_err_probe(dev, PTR_ERR(sunxi->rst_gpio),
+				     "failed to get reset gpio\n");
+
+	sunxi->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
+	if (IS_ERR(sunxi->vpcie3v3)) {
+		if (PTR_ERR(sunxi->vpcie3v3) == -ENODEV)
+			sunxi->vpcie3v3 = NULL;
+		else
+			return dev_err_probe(dev, PTR_ERR(sunxi->vpcie3v3),
+					     "failed to get vpcie3v3\n");
+	}
+
+	return 0;
+}
+
+static int sunxi_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sunxi_pcie *sunxi;
+	int ret;
+
+	sunxi = devm_kzalloc(dev, sizeof(*sunxi), GFP_KERNEL);
+	if (!sunxi)
+		return -ENOMEM;
+
+	sunxi->pci.dev = dev;
+	sunxi->pci.ops = &sunxi_dw_pcie_ops;
+	sunxi->pci.pp.ops = &sunxi_pcie_host_ops;
+	raw_spin_lock_init(&sunxi->intx_lock);
+	platform_set_drvdata(pdev, sunxi);
+
+	ret = sunxi_pcie_get_resources(pdev, sunxi);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	if (sunxi->vpcie3v3) {
+		ret = regulator_enable(sunxi->vpcie3v3);
+		if (ret)
+			goto err_pm;
+	}
+
+	/* Ensure T_PVPERL (100 ms) from power/PERST# assertion before release */
+	if (sunxi->vpcie3v3 || sunxi->rst_gpio)
+		msleep(PCIE_T_PVPERL_MS);
+
+	ret = clk_set_rate(sunxi->clks[CLK_ID_SLV].clk, PCIE_SLV_CLK_RATE);
+	if (ret)
+		goto err_reg;
+
+	ret = clk_bulk_prepare_enable(NUM_SUNXI_PCIE_CLKS, sunxi->clks);
+	if (ret)
+		goto err_reg;
+
+	ret = reset_control_bulk_assert(NUM_SUNXI_PCIE_RSTS, sunxi->rsts);
+	if (ret)
+		goto err_clks;
+
+	usleep_range(10, 20);
+
+	ret = reset_control_bulk_deassert(NUM_SUNXI_PCIE_RSTS, sunxi->rsts);
+	if (ret)
+		goto err_clks;
+
+	ret = phy_init(sunxi->phy);
+	if (ret)
+		goto err_rsts;
+
+	ret = phy_power_on(sunxi->phy);
+	if (ret)
+		goto err_phy_exit;
+
+	/* Enable core, AXI, DBI, and AUX clock gates */
+	writel(PCIE_APP_CLK_CTRL_DEFAULT, sunxi->app_base + PCIE_APP_CLK_CTRL);
+
+	/* Ensure any bootloader-trained link is stopped before RC init */
+	sunxi_pcie_stop_link(&sunxi->pci);
+
+	ret = sunxi_pcie_init_intx_irq(sunxi);
+	if (ret)
+		goto err_phy_off;
+
+	ret = dw_pcie_host_init(&sunxi->pci.pp);
+	if (ret)
+		goto err_intx;
+
+	return 0;
+
+err_intx:
+	sunxi_pcie_deinit_intx_irq(sunxi);
+	if (sunxi->rst_gpio)
+		gpiod_set_value_cansleep(sunxi->rst_gpio, 1);
+err_phy_off:
+	phy_power_off(sunxi->phy);
+err_phy_exit:
+	phy_exit(sunxi->phy);
+err_rsts:
+	reset_control_bulk_assert(NUM_SUNXI_PCIE_RSTS, sunxi->rsts);
+err_clks:
+	clk_bulk_disable_unprepare(NUM_SUNXI_PCIE_CLKS, sunxi->clks);
+err_reg:
+	if (sunxi->vpcie3v3)
+		regulator_disable(sunxi->vpcie3v3);
+err_pm:
+	pm_runtime_put_sync(dev);
+	return ret;
+}
+
+static void sunxi_pcie_remove(struct platform_device *pdev)
+{
+	struct sunxi_pcie *sunxi = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&sunxi->pci.pp);
+	sunxi_pcie_deinit_intx_irq(sunxi);
+	if (sunxi->rst_gpio)
+		gpiod_set_value_cansleep(sunxi->rst_gpio, 1);
+	phy_power_off(sunxi->phy);
+	phy_exit(sunxi->phy);
+	reset_control_bulk_assert(NUM_SUNXI_PCIE_RSTS, sunxi->rsts);
+	clk_bulk_disable_unprepare(NUM_SUNXI_PCIE_CLKS, sunxi->clks);
+	if (sunxi->vpcie3v3)
+		regulator_disable(sunxi->vpcie3v3);
+	pm_runtime_put_sync(&pdev->dev);
+}
+
+static const struct of_device_id sunxi_pcie_of_match[] = {
+	{ .compatible = "allwinner,sun60i-a733-pcie" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sunxi_pcie_of_match);
+
+static struct platform_driver sunxi_pcie_driver = {
+	.probe	= sunxi_pcie_probe,
+	.remove	= sunxi_pcie_remove,
+	.driver	= {
+		.name		= "sunxi-pcie",
+		.of_match_table	= sunxi_pcie_of_match,
+	},
+};
+module_platform_driver(sunxi_pcie_driver);
+
+MODULE_DESCRIPTION("Allwinner A733 (sun60i) DesignWare PCIe host controller driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

