Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24542DB78C;
	Thu, 26 Mar 2026 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533552; cv=none; b=gV1FjlCzqaTrkcia2gDkRYDGlz/+r9Ipm6y2ye6QrqhyOqM4uJIisH9Zw9TLhWPequtg8Pjz3cekSWN+yvVEkdxpEy3W43xqC2TRpm80qB+yQQQtCKPQn64f+6A9s8wTZrNXC6x4M4ig+hppzr6E+QlWnm2L952u1uPNQZie9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533552; c=relaxed/simple;
	bh=ibVgTfS6zzOchUEmfzaHKz0BJo5BzKaMbOgEk4WjVlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXXLxJv2sMMMPws9Z3uFf/O0Ew16FG+iblrWcNB8aXBMDhC8W3liGXxQ+ijwmRgnWmAj9lFnH+5LzMVxJdD4z6mYDA6Uwm9mfmtBp8QmpV/zDxTgMyEumXdNwEpAJXWEb1chg0i4gb7ia+qU4y3WFWSJvBlKlv74UD3/0aEyFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbBjIdVO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbBjIdVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CEFC116C6;
	Thu, 26 Mar 2026 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533552;
	bh=ibVgTfS6zzOchUEmfzaHKz0BJo5BzKaMbOgEk4WjVlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbBjIdVOqi+p5nih6Q7sAv3Gq5J2jxxMNQput4HZahvKRC/pVLgjmsBOiFhBUKYXy
	 KgZ9hbUvHJ5bohwNo6nk+QYTQn69K3A7OtTLV9l9Q3gA5qAnqwu3pqquIFGQHCmGME
	 42q6lgRiXPst0n3Ft6Gu/rq9G0mqGWJQKGdlF9bB/09hw4T3VnHbE1dh7AbCSD2oQ5
	 gzUzRlk6+6+o4SiANTnZ8JeQa1Z/l7stAHKS0K57WDPSwKVHJow7hHRWTJxztv6n7z
	 IIE3NYOSdnoKqZ6uxseiOw4uPRfdYcCWLkrzS4kpQyUccY+jvpHANuXKYCnZTb8Jip
	 4jA+E+W0GnKmw==
From: Thierry Reding <thierry.reding@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 5/6] PCI: tegra: Add Tegra264 support
Date: Thu, 26 Mar 2026 14:58:52 +0100
Message-ID: <20260326135855.2795149-6-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326135855.2795149-1-thierry.reding@kernel.org>
References: <20260326135855.2795149-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
driver is very small, with its main purpose being to set up the address
translation registers and then creating a standard PCI host using ECAM.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- use separate error messages for BPMP transfer failures vs. BPMP
  command failures
- use link speed to index into pcie_link_speed to get the correct
  enumeration values for PCIE_SPEED2MBS_ENC
- pass correct value to icc_set_bw()
- remove misleading comment

Changes in v2:
- specify generations applicable for PCI_TEGRA driver to avoid confusion
- drop SPDX-FileCopyrightText tag
- rename link_state to link_up to clarify meaning
- replace memset() by an empty initializer
- sanity-check only enable BAR regions
- bring PCI link out of reset in case firmware didn't
- use common wait times instead of defining our own
- use core helpers to parse and print PCI link speed
- fix multi-line comment
- use dev_err_probe() more ubiquitously
- fix probe sequence and error cleanup
- use DEFINE_NOIRQ_DEV_PM_OPS() to avoid warnings for !PM_SUSPEND
- reuse more standard registers and remove unused register definitions
- use %pe and ERR_PTR() to print symbolic errors
- add signed-off-by from Manikanta as the original author
- add myself as author after significantly modifying the driver

 drivers/pci/controller/Kconfig         |  10 +-
 drivers/pci/controller/Makefile        |   1 +
 drivers/pci/controller/pcie-tegra264.c | 522 +++++++++++++++++++++++++
 3 files changed, 532 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/controller/pcie-tegra264.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 5aaed8ac6e44..6ead04f7bd6e 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -254,7 +254,15 @@ config PCI_TEGRA
 	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want support for the PCIe host controller found
-	  on NVIDIA Tegra SoCs.
+	  on NVIDIA Tegra SoCs (Tegra20 through Tegra186).
+
+config PCIE_TEGRA264
+	bool "NVIDIA Tegra264 PCIe controller"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on PCI_MSI
+	help
+	  Say Y here if you want support for the PCIe host controller found
+	  on NVIDIA Tegra264 SoCs.
 
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe controller (host mode)"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index ac8db283f0fe..d478743b5142 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PCI_HYPERV_INTERFACE) += pci-hyperv-intf.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
+obj-$(CONFIG_PCIE_TEGRA264) += pcie-tegra264.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
 obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
 obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
new file mode 100644
index 000000000000..21872797e41a
--- /dev/null
+++ b/drivers/pci/controller/pcie-tegra264.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe host controller driver for Tegra264 SoC
+ *
+ * Copyright (c) 2022-2026, NVIDIA CORPORATION. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci-ecam.h>
+#include <linux/pci.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include <soc/tegra/bpmp.h>
+#include <soc/tegra/bpmp-abi.h>
+#include <soc/tegra/fuse.h>
+
+#include "../pci.h"
+
+/* XAL registers */
+#define XAL_RC_ECAM_BASE_HI			0x00
+#define XAL_RC_ECAM_BASE_LO			0x04
+#define XAL_RC_ECAM_BUSMASK			0x08
+#define XAL_RC_IO_BASE_HI			0x0c
+#define XAL_RC_IO_BASE_LO			0x10
+#define XAL_RC_IO_LIMIT_HI			0x14
+#define XAL_RC_IO_LIMIT_LO			0x18
+#define XAL_RC_MEM_32BIT_BASE_HI		0x1c
+#define XAL_RC_MEM_32BIT_BASE_LO		0x20
+#define XAL_RC_MEM_32BIT_LIMIT_HI		0x24
+#define XAL_RC_MEM_32BIT_LIMIT_LO		0x28
+#define XAL_RC_MEM_64BIT_BASE_HI		0x2c
+#define XAL_RC_MEM_64BIT_BASE_LO		0x30
+#define XAL_RC_MEM_64BIT_LIMIT_HI		0x34
+#define XAL_RC_MEM_64BIT_LIMIT_LO		0x38
+#define XAL_RC_BAR_CNTL_STANDARD		0x40
+#define XAL_RC_BAR_CNTL_STANDARD_IOBAR_EN	BIT(0)
+#define XAL_RC_BAR_CNTL_STANDARD_32B_BAR_EN	BIT(1)
+#define XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN	BIT(2)
+
+/* XTL registers */
+#define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a
+
+#define XTL_RC_MGMT_PERST_CONTROL		0x218
+#define XTL_RC_MGMT_PERST_CONTROL_PERST_O_N	BIT(0)
+
+#define XTL_RC_MGMT_CLOCK_CONTROL		0x47c
+#define XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT	BIT(9)
+
+struct tegra264_pcie {
+	struct device *dev;
+	bool link_up;
+
+	/* I/O memory */
+	void __iomem *xal;
+	void __iomem *xtl;
+	void __iomem *ecam;
+
+	/* bridge configuration */
+	struct pci_config_window *cfg;
+	struct pci_host_bridge *bridge;
+
+	/* wake IRQ */
+	struct gpio_desc *wake_gpio;
+	unsigned int wake_irq;
+
+	/* BPMP and bandwidth management */
+	struct icc_path *icc_path;
+	struct tegra_bpmp *bpmp;
+	u32 ctl_id;
+};
+
+static int tegra264_pcie_parse_dt(struct tegra264_pcie *pcie)
+{
+	int err;
+
+	pcie->wake_gpio = devm_gpiod_get_optional(pcie->dev, "nvidia,pex-wake",
+						  GPIOD_IN);
+	if (IS_ERR(pcie->wake_gpio))
+		return PTR_ERR(pcie->wake_gpio);
+
+	if (pcie->wake_gpio) {
+		device_init_wakeup(pcie->dev, true);
+
+		err = gpiod_to_irq(pcie->wake_gpio);
+		if (err < 0) {
+			dev_err(pcie->dev, "failed to get wake IRQ: %pe\n",
+				ERR_PTR(err));
+			return err;
+		}
+
+		pcie->wake_irq = (unsigned int)err;
+	}
+
+	return 0;
+}
+
+static void tegra264_pcie_bpmp_set_rp_state(struct tegra264_pcie *pcie)
+{
+	struct tegra_bpmp_message msg = {};
+	struct mrq_pcie_request req = {};
+	int err;
+
+	req.cmd = CMD_PCIE_RP_CONTROLLER_OFF;
+	req.rp_ctrlr_off.rp_controller = pcie->ctl_id;
+
+	msg.mrq = MRQ_PCIE;
+	msg.tx.data = &req;
+	msg.tx.size = sizeof(req);
+
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		dev_info(pcie->dev, "BPMP transfer failed for PCIe #%u: %pe\n",
+			 pcie->ctl_id, ERR_PTR(err));
+
+	if (msg.rx.ret)
+		dev_info(pcie->dev, "failed to turn off PCIe #%u: %d\n",
+			 pcie->ctl_id, msg.rx.ret);
+}
+
+static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
+{
+	u32 value, speed, width, bw;
+	int err;
+
+	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
+	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
+
+	bw = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]));
+	value = MBps_to_icc(bw / BITS_PER_BYTE);
+
+	err = icc_set_bw(pcie->icc_path, value, value);
+	if (err < 0)
+		dev_err(pcie->dev,
+			"failed to request bandwidth (%u Mbps): %pe\n",
+			bw, ERR_PTR(err));
+}
+
+/*
+ * The various memory regions used by the controller (I/O, memory, ECAM) are
+ * set up during early boot and have hardware-level protections in place. If
+ * the DT ranges don't match what's been setup, the controller won't be able
+ * to write the address endpoints properly, so make sure to validate that DT
+ * and firmware programming agree on these ranges.
+ */
+static bool tegra264_pcie_check_ranges(struct platform_device *pdev)
+{
+	struct tegra264_pcie *pcie = platform_get_drvdata(pdev);
+	struct device_node *np = pcie->dev->of_node;
+	struct of_pci_range_parser parser;
+	phys_addr_t phys, limit, hi, lo;
+	struct of_pci_range range;
+	struct resource *res;
+	bool status = true;
+	u32 value;
+	int err;
+
+	err = of_pci_range_parser_init(&parser, np);
+	if (err < 0)
+		return false;
+
+	for_each_of_pci_range(&parser, &range) {
+		unsigned int addr_hi, addr_lo, limit_hi, limit_lo, enable;
+		unsigned long type = range.flags & IORESOURCE_TYPE_BITS;
+		phys_addr_t start, end, mask;
+		const char *region = NULL;
+
+		end = range.cpu_addr + range.size - 1;
+		start = range.cpu_addr;
+
+		switch (type) {
+		case IORESOURCE_IO:
+			addr_hi = XAL_RC_IO_BASE_HI;
+			addr_lo = XAL_RC_IO_BASE_LO;
+			limit_hi = XAL_RC_IO_LIMIT_HI;
+			limit_lo = XAL_RC_IO_LIMIT_LO;
+			enable = XAL_RC_BAR_CNTL_STANDARD_IOBAR_EN;
+			mask = SZ_64K - 1;
+			region = "I/O";
+			break;
+
+		case IORESOURCE_MEM:
+			if (range.flags & IORESOURCE_PREFETCH) {
+				addr_hi = XAL_RC_MEM_64BIT_BASE_HI;
+				addr_lo = XAL_RC_MEM_64BIT_BASE_LO;
+				limit_hi = XAL_RC_MEM_64BIT_LIMIT_HI;
+				limit_lo = XAL_RC_MEM_64BIT_LIMIT_LO;
+				enable = XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN;
+				region = "prefetchable memory";
+			} else {
+				addr_hi = XAL_RC_MEM_32BIT_BASE_HI;
+				addr_lo = XAL_RC_MEM_32BIT_BASE_LO;
+				limit_hi = XAL_RC_MEM_32BIT_LIMIT_HI;
+				limit_lo = XAL_RC_MEM_32BIT_LIMIT_LO;
+				enable = XAL_RC_BAR_CNTL_STANDARD_32B_BAR_EN;
+				region = "memory";
+			}
+
+			mask = SZ_1M - 1;
+			break;
+		}
+
+		/* not interested in anything that's not I/O or memory */
+		if (!region)
+			continue;
+
+		/* don't check regions that haven't been enabled */
+		value = readl(pcie->xal + XAL_RC_BAR_CNTL_STANDARD);
+		if ((value & enable) == 0)
+			continue;
+
+		hi = readl(pcie->xal + addr_hi);
+		lo = readl(pcie->xal + addr_lo);
+		phys = hi << 32 | lo;
+
+		hi = readl(pcie->xal + limit_hi);
+		lo = readl(pcie->xal + limit_lo);
+		limit = hi << 32 | lo | mask;
+
+		if (phys != start || limit != end) {
+			dev_err(pcie->dev,
+				"%s region mismatch: %pap-%pap -> %pap-%pap\n",
+				region, &phys, &limit, &start, &end);
+			status = false;
+		}
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam");
+	if (!res)
+		return false;
+
+	hi = readl(pcie->xal + XAL_RC_ECAM_BASE_HI);
+	lo = readl(pcie->xal + XAL_RC_ECAM_BASE_LO);
+	phys = hi << 32 | lo;
+
+	value = readl(pcie->xal + XAL_RC_ECAM_BUSMASK);
+	limit = phys + ((value + 1) << 20) - 1;
+
+	if (phys != res->start || limit != res->end) {
+		dev_err(pcie->dev,
+			"ECAM region mismatch: %pap-%pap -> %pap-%pap\n",
+			&phys, &limit, &res->start, &res->end);
+		status = false;
+	}
+
+	return status;
+}
+
+static bool tegra264_pcie_link_up(struct tegra264_pcie *pcie,
+				  enum pci_bus_speed *speed)
+{
+	u16 value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
+
+	if (value & PCI_EXP_LNKSTA_DLLLA) {
+		if (speed)
+			*speed = pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS,
+							   value)];
+
+		return true;
+	}
+
+	return false;
+}
+
+static void tegra264_pcie_init(struct tegra264_pcie *pcie)
+{
+	enum pci_bus_speed speed;
+	unsigned int i;
+	u32 value;
+
+	/* bring the link out of reset */
+	value = readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
+	value |= XTL_RC_MGMT_PERST_CONTROL_PERST_O_N;
+	writel(value, pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
+
+	if (!tegra_is_silicon()) {
+		dev_info(pcie->dev,
+			 "skipping link state for PCIe #%u in simulation\n",
+			 pcie->ctl_id);
+		pcie->link_up = true;
+		return;
+	}
+
+	for (i = 0; i < PCIE_LINK_WAIT_MAX_RETRIES; i++) {
+		if (tegra264_pcie_link_up(pcie, NULL))
+			break;
+
+		usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
+	}
+
+	if (tegra264_pcie_link_up(pcie, &speed)) {
+		/* Per PCIe r5.0, 6.6.1 wait for 100ms after DLL up */
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+
+		dev_info(pcie->dev, "PCIe #%u link is up (speed: %s)\n",
+			 pcie->ctl_id, pci_speed_string(speed));
+		tegra264_pcie_icc_set(pcie);
+		pcie->link_up = true;
+	} else {
+		dev_info(pcie->dev, "PCIe #%u link is down\n", pcie->ctl_id);
+
+		value = readl(pcie->xtl + XTL_RC_MGMT_CLOCK_CONTROL);
+
+		/*
+		 * Set link state only when link fails and no hot-plug feature
+		 * is present.
+		 */
+		if ((value & XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT) == 0) {
+			dev_info(pcie->dev,
+				 "PCIe #%u link is down and not hotplug-capable, turning off\n",
+				 pcie->ctl_id);
+			tegra264_pcie_bpmp_set_rp_state(pcie);
+			pcie->link_up = false;
+		} else {
+			pcie->link_up = true;
+		}
+	}
+}
+
+static int tegra264_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct tegra264_pcie *pcie;
+	struct resource_entry *bus;
+	struct resource *res;
+	int err;
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct tegra264_pcie));
+	if (!bridge)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to allocate host bridge\n");
+
+	pcie = pci_host_bridge_priv(bridge);
+	platform_set_drvdata(pdev, pcie);
+	pcie->bridge = bridge;
+	pcie->dev = dev;
+
+	err = pinctrl_pm_select_default_state(dev);
+	if (err < 0)
+		return dev_err_probe(dev, err,
+				     "failed to configure sideband pins\n");
+
+	err = tegra264_pcie_parse_dt(pcie);
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to parse device tree");
+
+	pcie->xal = devm_platform_ioremap_resource_byname(pdev, "xal");
+	if (IS_ERR(pcie->xal))
+		return dev_err_probe(dev, PTR_ERR(pcie->xal),
+				     "failed to map XAL memory\n");
+
+	pcie->xtl = devm_platform_ioremap_resource_byname(pdev, "xtl-pri");
+	if (IS_ERR(pcie->xtl))
+		return dev_err_probe(dev, PTR_ERR(pcie->xtl),
+				     "failed to map XTL-PRI memory\n");
+
+	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return dev_err_probe(dev, -ENODEV,
+				     "failed to get bus resources\n");
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam");
+	if (!res)
+		return dev_err_probe(dev, -ENXIO,
+				     "failed to get ECAM resource\n");
+
+	pcie->icc_path = devm_of_icc_get(&pdev->dev, "write");
+	if (IS_ERR(pcie->icc_path))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pcie->icc_path),
+				     "failed to get ICC");
+
+	/*
+	 * Parse BPMP property only for silicon, as interaction with BPMP is
+	 * not needed for other platforms.
+	 */
+	if (tegra_is_silicon()) {
+		pcie->bpmp = tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
+		if (IS_ERR(pcie->bpmp))
+			return dev_err_probe(dev, PTR_ERR(pcie->bpmp),
+					     "failed to get BPMP\n");
+	}
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	/* sanity check that programmed ranges match what's in DT */
+	if (!tegra264_pcie_check_ranges(pdev)) {
+		err = -EINVAL;
+		goto put_pm;
+	}
+
+	pcie->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
+	if (IS_ERR(pcie->cfg)) {
+		err = dev_err_probe(dev, PTR_ERR(pcie->cfg),
+				    "failed to create ECAM\n");
+		goto put_pm;
+	}
+
+	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+	bridge->sysdata = pcie->cfg;
+	pcie->ecam = pcie->cfg->win;
+
+	tegra264_pcie_init(pcie);
+
+	if (!pcie->link_up)
+		goto free;
+
+	err = pci_host_probe(bridge);
+	if (err < 0) {
+		dev_err(dev, "failed to register host: %pe\n", ERR_PTR(err));
+		goto free;
+	}
+
+	return err;
+
+free:
+	pci_ecam_free(pcie->cfg);
+put_pm:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	if (tegra_is_silicon())
+		tegra_bpmp_put(pcie->bpmp);
+
+	return err;
+}
+
+static void tegra264_pcie_remove(struct platform_device *pdev)
+{
+	struct tegra264_pcie *pcie = platform_get_drvdata(pdev);
+
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(pcie->bridge->bus);
+	pci_remove_root_bus(pcie->bridge->bus);
+	pci_unlock_rescan_remove();
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	if (tegra_is_silicon())
+		tegra_bpmp_put(pcie->bpmp);
+
+	pci_ecam_free(pcie->cfg);
+}
+
+static int tegra264_pcie_suspend_noirq(struct device *dev)
+{
+	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
+	int err;
+
+	if (pcie->wake_gpio && device_may_wakeup(dev)) {
+		err = enable_irq_wake(pcie->wake_irq);
+		if (err < 0)
+			dev_err(dev, "failed to enable wake IRQ: %pe\n",
+				ERR_PTR(err));
+	}
+
+	return 0;
+}
+
+static int tegra264_pcie_resume_noirq(struct device *dev)
+{
+	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
+	int err;
+
+	if (pcie->wake_gpio && device_may_wakeup(dev)) {
+		err = disable_irq_wake(pcie->wake_irq);
+		if (err < 0)
+			dev_err(dev, "failed to disable wake IRQ: %pe\n",
+				ERR_PTR(err));
+	}
+
+	if (pcie->link_up == false)
+		return 0;
+
+	tegra264_pcie_init(pcie);
+
+	return 0;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(tegra264_pcie_pm_ops,
+			       tegra264_pcie_suspend_noirq,
+			       tegra264_pcie_resume_noirq);
+
+static const struct of_device_id tegra264_pcie_of_match[] = {
+	{
+		.compatible = "nvidia,tegra264-pcie",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tegra264_pcie_of_match);
+
+static struct platform_driver tegra264_pcie_driver = {
+	.probe = tegra264_pcie_probe,
+	.remove = tegra264_pcie_remove,
+	.driver = {
+		.name = "tegra264-pcie",
+		.pm = &tegra264_pcie_pm_ops,
+		.of_match_table = tegra264_pcie_of_match,
+	},
+};
+module_platform_driver(tegra264_pcie_driver);
+
+MODULE_AUTHOR("Manikanta Maddireddy <mmaddireddy@nvidia.com>");
+MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra264 PCIe host controller driver");
+MODULE_LICENSE("GPL");
-- 
2.52.0

