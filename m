Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728653A3E78;
	Wed, 15 Apr 2026 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237711; cv=none; b=pgHoDH8EWpGs6/sOFC9v7GHlobfL2hEQhwzd6pg2JaBvKClgOFqrwwFxy2HtHMD49QHDsPmzzwaeYm13mprfNLu/ke/k/oRP+j3pcxv5Q58jic7hk7UanqxrrrvMsPp94UjUof7VwLuiiWBiV4D4Go/NWItgzZtI5sK+TzI4cTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237711; c=relaxed/simple;
	bh=Df6Z0BC/fmcCgTmIaQKmJpeKdDfOcTPZf4FzR5Uuh8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEkgQmCKddOiQfq5fh9e9/pSrd+zkda0Sdl/SrkGqEBCcFBEKMstPCTUAb84+cuJV5Z6m/8V/r0NO9AoTLtad7vMqP1vih9wCMmCwSTM81gdU0PdmlQD/skEdSSIc6e6B+/S+oMav0vmcTcLFwAxYrtxonKbSYkJCFVBY845tt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=dsb3TjNj; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="dsb3TjNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=aAl20ajiw8N51DI4yylnwCBG45C9mJu
	XRKbkQeSIosU=; b=dsb3TjNjWiJcMUY3pnuc0fKFXfTlQm6xrMUAE89FaY9og9J
	NZr9KUBy8vkizKVjb6jfSJohEbscvjd/ILgaPfT/72/N6Ccfp9Clt8PEHBQm99q2
	OZnQ3I2I5Ox1P/yMLgXofpwdoBOkKv6CODDgJizXwLkBtcFgi8Qs3B7FNd5s=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUKdPN9poSgCAA--.1324S5;
	Wed, 15 Apr 2026 15:22:15 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Wed, 15 Apr 2026 15:21:19 +0800
Subject: [PATCH v3 3/3] PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root
 Complex driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-ultrarisc-pcie-v3-3-73f06e972616@ultrarisc.com>
References: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
In-Reply-To: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776237679; l=9299;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=ogV9+SfPCI2fWh594Lcx5NPt0KYv8PFn/JafQ/WgrSY=;
 b=AmpWM5ThgaEpmYpPz7KpGw7i18UCIVBcFIovm86cxZ76u8WHvKfH8uh7yWtAhBvZdQjz71/Bi
 PRSFW+B/Y+xDZXruVupls8SRwcAmdAYxt+gzp/xVejdnQg9RXGsVXfb
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUKdPN9poSgCAA--.1324S5
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyktr4fuF47Gry5JrWfuFg_yoWftr18pa
	15CFWFyF4UJF45uF4Skas5AF1aq3ZxurWUGFZFgw12g3ZIyryDXFyvg34ayFn7GF4jgry3
	Kw1jya4UGan8XwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRQAwsUUUUU=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQASEWnfCz0AGAAAsa

From: Xincheng Zhang <zhangxincheng@ultrarisc.com>

Add DP1000 SoC PCIe Root Complex driver.

Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 MAINTAINERS                                  |   1 +
 drivers/pci/controller/dwc/Kconfig           |  12 ++
 drivers/pci/controller/dwc/Makefile          |   1 +
 drivers/pci/controller/dwc/pcie-designware.h |  22 ++++
 drivers/pci/controller/dwc/pcie-ultrarisc.c  | 186 +++++++++++++++++++++++++++
 5 files changed, 222 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ec02d8443dd..c8159670a14d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20588,6 +20588,7 @@ M:	Jia Wang <wangjia@ultrarisc.com>
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
index 000000000000..7094ee8c532f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DWC PCIe RC driver for UltraRISC DP1000 SoC
+ *
+ * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/types.h>
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
+struct ultrarisc_pcie {
+	struct dw_pcie *pci;
+};
+
+static struct pci_ops ultrarisc_pci_ops = {
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = pci_generic_config_read32,
+	.write = pci_generic_config_write32,
+};
+
+static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct pci_host_bridge *bridge = pp->bridge;
+
+	bridge->ops = &ultrarisc_pci_ops;
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
+	u8 cap_exp;
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
+	FIELD_MODIFY(PCI_EXP_DEVCTL2_COMP_TIMEOUT, &val, 0x6);
+	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_DEVCTL2, val);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
+	val &= ~(HOLD_PHY_RST | L1SUB_DISABLE);
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
+	struct ultrarisc_pcie *pcie;
+	struct dw_pcie *pci;
+	struct dw_pcie_rp *pp;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
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
+	pci->max_link_speed = 4;
+	pcie->pci = pci;
+
+	pp = &pci->pp;
+
+	platform_set_drvdata(pdev, pcie);
+
+	pp->irq = platform_get_irq(pdev, 1);
+	if (pp->irq < 0)
+		return pp->irq;
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
+	struct ultrarisc_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+
+	return dw_pcie_suspend_noirq(pci);
+}
+
+static int ultrarisc_pcie_resume_noirq(struct device *dev)
+{
+	struct ultrarisc_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
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

