Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A441E1DF0;
	Mon, 27 Apr 2026 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777253564; cv=none; b=GV7cz2+E2Ec47qGxw1jmkKl5uQwjJm2UxZI5i48w6OYTXXaaSymxTSG4iEJpPT0Uh4+eVKnLvshnxB4tOuZxfrOBPRi/M5N1PEE2357Ic2EKnVrOIqZL44hrk7SGG2d2iBsap6toXaf/XW36Hv/NL+qiS9TLr9J10rq3omiC7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777253564; c=relaxed/simple;
	bh=U8QOcBbqZJil6LNv6DcJUSMqT5HAMW7+nNt0ahHRxEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t22cErdLowxtjHjOUH6WiOCoRWGXrwcj6l+ddFC6RN40DkBkbO/+SP8c0iDk3ruUDFWDM2nf7KwmTO65fitVUtEJffrA9SO4kX91vNJT127dwYVpkoPEzj331iYTo/xC2uj0ia7ExbHasHr+/mQutghpfac8KyXRITxc0zR//mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=LhJQWT+G; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="LhJQWT+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=tSB1zZB8u7tuX0u2+hRQ1ZVE/Lhv5+H
	AhexMuCTJPV4=; b=LhJQWT+GZheRT5kV2cyambfBiKrFCvk0zmj6FYNvcHpOmWI
	1/FBVMZqHWSuKKEquaQ5BtqjTpPfuqplRn7iDut7Bay+2aH6RF+sGb+pA7x3V+Sm
	jVohUY4pJ34brLQXta8q+IElNRNdD5SPj0+AYcNYA6/CG5JQDBegiBF369Y8=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cULPvO5ps_0CAA--.1758S5;
	Mon, 27 Apr 2026 09:33:08 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Mon, 27 Apr 2026 09:32:12 +0800
Subject: [PATCH v4 3/3] PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root
 Complex driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ultrarisc-pcie-v4-3-98935f6cdfb5@ultrarisc.com>
References: <20260427-ultrarisc-pcie-v4-0-98935f6cdfb5@ultrarisc.com>
In-Reply-To: <20260427-ultrarisc-pcie-v4-0-98935f6cdfb5@ultrarisc.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777253539; l=9133;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=pEEmEszYk+Wwemr9LH9I5Z0OFr07mXJ55nbPQpUoxLw=;
 b=kHFtH1VZanxix+cZOxd643Wi5ZsvL2zlmni3SZJZgSTUdHya3UXdCw8DVnQUVVNNGMIG55cAY
 cQqXkJVpeAMD01/Nk1aGjYl+2hjJ2JEf5xjWVMoTzfn/8NJw7WHJRi4
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cULPvO5ps_0CAA--.1758S5
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyktr4fuF47Gry5JrWfuFg_yoWfZFykpa
	15CFWFyF4UJF45ua1Skas5uF1aq3ZxArWUGa9Fgw1293ZxAryUXFyvq34ayFn7GF4UWrya
	kw1jya4UGa15XwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACQAAsj

From: Xincheng Zhang <zhangxincheng@ultrarisc.com>

Add DP1000 SoC PCIe Root Complex driver.

The controller only supports 32-bit aligned configuration space accesses.

Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 MAINTAINERS                                  |   1 +
 drivers/pci/controller/dwc/Kconfig           |  12 ++
 drivers/pci/controller/dwc/Makefile          |   1 +
 drivers/pci/controller/dwc/pcie-designware.h |  22 ++++
 drivers/pci/controller/dwc/pcie-ultrarisc.c  | 175 +++++++++++++++++++++++++++
 5 files changed, 211 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 818685933541..16203b804c16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20589,6 +20589,7 @@ M:	Jia Wang <wangjia@ultrarisc.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-ultrarisc.c
 
 PCIE ENDPOINT DRIVER FOR QUALCOMM
 M:	Manivannan Sadhasivam <mani@kernel.org>
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d0aa031397fa..06f7d98259cd 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -548,4 +548,16 @@ config PCIE_VISCONTI_HOST
 	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
 	  This driver supports TMPV7708 SoC.
 
+config PCIE_ULTRARISC
+	tristate "UltraRISC PCIe host controller"
+	depends on ARCH_ULTRARISC || COMPILE_TEST
+	select PCIE_DW_HOST
+	select PCI_MSI
+	default y if ARCH_ULTRARISC
+	help
+	  Enables support for the PCIe controller in the UltraRISC SoC.
+	  This driver supports UR-DP1000 SoC.
+	  By default, this symbol is enabled when ARCH_ULTRARISC is active,
+	  requiring no further configuration on that platform.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 67ba59c02038..884c46b78e01 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
 obj-$(CONFIG_PCIE_SPACEMIT_K1) += pcie-spacemit-k1.o
 obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
 obj-$(CONFIG_PCIE_STM32_EP) += pcie-stm32-ep.o
+obj-$(CONFIG_PCIE_ULTRARISC) += pcie-ultrarisc.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa..88dcb0e7943a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -69,6 +69,8 @@
 
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_FORCE			0x708
+/* Bit[7:0] LINK_NUM: Link Number. Not used for endpoint */
+#define PORT_LINK_NUM_MASK		GENMASK(7, 0)
 #define PORT_FORCE_DO_DESKEW_FOR_SRIS	BIT(23)
 
 #define PCIE_PORT_AFR			0x70C
@@ -96,6 +98,26 @@
 #define PCIE_PORT_LANE_SKEW		0x714
 #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
 
+/*
+ * PCIE_TIMER_CTRL_MAX_FUNC_NUM: Timer Control and Max Function Number
+ * Register.
+ * This register holds the ack frequency, latency, replay, fast link
+ * scaling timers, and max function number values.
+ * Bit[30:29] FAST_LINK_SCALING_FACTOR: Fast Link Timer Scaling Factor.
+ *   0x0 (SF_1024):Scaling Factor is 1024 (1ms is 1us).
+ *     When the LTSSM is in Config or L12 Entry State, 1ms
+ *     timer is 2us, 2ms timer is 4us and 3ms timer is 6us.
+ *   0x1 (SF_256): Scaling Factor is 256 (1ms is 4us)
+ *   0x2 (SF_64): Scaling Factor is 64 (1ms is 16us)
+ *   0x3 (SF_16): Scaling Factor is 16 (1ms is 64us)
+ */
+#define PCIE_TIMER_CTRL_MAX_FUNC_NUM	0x718
+#define PORT_FLT_SF_MASK	GENMASK(30, 29)
+#define PORT_FLT_SF_VAL_1024	0x0
+#define PORT_FLT_SF_VAL_256	0x1
+#define PORT_FLT_SF_VAL_64	0x2
+#define PORT_FLT_SF_VAL_16	0x3
+
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x3f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
new file mode 100644
index 000000000000..7326bd446590
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DWC PCIe RC driver for UltraRISC SoCs
+ *
+ * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+
+#include "pcie-designware.h"
+
+#define PCIE_CUS_CORE          0x400000
+
+#define LTSSM_ENABLE           BIT(7)
+#define FAST_LINK_MODE         BIT(12)
+#define HOLD_PHY_RST           BIT(14)
+#define L1SUB_DISABLE          BIT(15)
+
+#define ULTRARISC_PCIE_COMP_TIMEOUT_65_210MS	0x6
+
+static struct pci_ops ultrarisc_pci_ops = {
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = pci_generic_config_read32,
+	.write = pci_generic_config_write32,
+};
+
+static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct pci_host_bridge *bridge = pp->bridge;
+	u8 cap_exp;
+	u32 val;
+
+	bridge->ops = &ultrarisc_pci_ops;
+
+	if (dw_pcie_link_up(pci))
+		return 0;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
+	val &= ~FAST_LINK_MODE;
+	dw_pcie_writel_dbi(pci, PCIE_CUS_CORE, val);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM);
+	FIELD_MODIFY(PORT_FLT_SF_MASK, &val, PORT_FLT_SF_VAL_64);
+	dw_pcie_writel_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM, val);
+
+	cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
+	FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val, PCI_EXP_LNKCTL2_TLS_16_0GT);
+	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
+	FIELD_MODIFY(PORT_LINK_NUM_MASK, &val, 0);
+	dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
+
+	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_DEVCTL2);
+	FIELD_MODIFY(PCI_EXP_DEVCTL2_COMP_TIMEOUT, &val,
+		     ULTRARISC_PCIE_COMP_TIMEOUT_65_210MS);
+	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_DEVCTL2, val);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
+	val &= ~(HOLD_PHY_RST | L1SUB_DISABLE);
+	dw_pcie_writel_dbi(pci, PCIE_CUS_CORE, val);
+
+	return 0;
+}
+
+static void ultrarisc_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+{
+	/*
+	 * DP1000 does not support sending PME_Turn_Off from the RC.
+	 * Keep this callback empty to skip the generic MSG TLP path.
+	 */
+}
+
+static const struct dw_pcie_host_ops ultrarisc_pcie_host_ops = {
+	.init = ultrarisc_pcie_host_init,
+	.pme_turn_off = ultrarisc_pcie_pme_turn_off,
+};
+
+static int ultrarisc_pcie_start_link(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
+	val |= LTSSM_ENABLE;
+	dw_pcie_writel_dbi(pci, PCIE_CUS_CORE, val);
+
+	return 0;
+}
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = ultrarisc_pcie_start_link,
+};
+
+static int ultrarisc_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_pcie_rp *pp;
+	struct dw_pcie *pci;
+	int ret;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+
+	/* Set a default value suitable for at most 16 in and 16 out windows */
+	pci->atu_size = SZ_8K;
+
+	pp = &pci->pp;
+
+	platform_set_drvdata(pdev, pci);
+
+	pp->num_vectors = MAX_MSI_IRQS;
+	/* No L2/L3 Ready indication is available on this platform. */
+	pp->skip_l23_ready = true;
+	pp->ops = &ultrarisc_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "Failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ultrarisc_pcie_suspend_noirq(struct device *dev)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+
+	return dw_pcie_suspend_noirq(pci);
+}
+
+static int ultrarisc_pcie_resume_noirq(struct device *dev)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+
+	return dw_pcie_resume_noirq(pci);
+}
+
+static const struct dev_pm_ops ultrarisc_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(ultrarisc_pcie_suspend_noirq,
+				  ultrarisc_pcie_resume_noirq)
+};
+
+static const struct of_device_id ultrarisc_pcie_of_match[] = {
+	{
+		.compatible = "ultrarisc,dp1000-pcie",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ultrarisc_pcie_of_match);
+
+static struct platform_driver ultrarisc_pcie_driver = {
+	.driver = {
+		.name	= "ultrarisc-pcie",
+		.of_match_table = ultrarisc_pcie_of_match,
+		.suppress_bind_attrs = true,
+		.pm = &ultrarisc_pcie_pm_ops,
+	},
+	.probe = ultrarisc_pcie_probe,
+};
+module_platform_driver(ultrarisc_pcie_driver);
+
+MODULE_DESCRIPTION("UltraRISC DP1000 DWC PCIe host controller");
+MODULE_LICENSE("GPL");

-- 
2.34.1

