Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876443D47BD;
	Thu, 19 Mar 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936091; cv=none; b=LnHFQGvcntr/241lGbiDNilxgVQVX4rLLz75z+gk+PFHUMXY+GMuhuhZ2gM3KduzE7x/O4mv5fnR56UfNu1m79xWxKfPSIPjt/zKFIqt453oFS+viyQrIM0ZpJJ8vG6ujwC6Mc44/JQnI7OZ3rjEZpKgqu1TlUrHhsZn7HalKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936091; c=relaxed/simple;
	bh=oVHrcLuY6hBTh4c0PH13hYkB+QUo+mhvuPjQs24kOYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVMPxodBPn9Yakgj+xj9fLHa9Sh0IXreAd8pEXARC8sHZPmxj+fZkXDk0yguRX5RTgPpBXIepq/+Qaj0Ud9DSmkrH5vww0SqLfCL4DCCDkpmn9jkswrurw9iiJjtx7nujze4XaiYmcTCxtKVoLHeEeodRa3+DEsG/quCBozz62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0QaTzJ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0QaTzJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCC4C2BCAF;
	Thu, 19 Mar 2026 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936091;
	bh=oVHrcLuY6hBTh4c0PH13hYkB+QUo+mhvuPjQs24kOYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0QaTzJ4LpsZGZ6muUgx2L7jRVDbElNFS8pX9k/ZpM1aEZ1YWewEdgQlN11zmQ7nd
	 zyc8ptRohlJ3JtbSlHUgz34G3aPOOQs5aqw5wyrcJD8aQZtllG2R8BEOLVZsjqdHMc
	 2x8hSsDo2n14GnGPW6XHaLfrLtOYf2htQIJOqNC9/Z2exLuBcFmWqwM1XaWlYVMxeQ
	 DvXUF/3DwXLkttjpmq6Y6KX6ZUksRSPaB/2qjmXEXMi64FFL409rrVmOJIN4E7aBPu
	 B4TZNi91vWq/VpuKKx3HkxI/7DL2o8mVhZVvCUgSHjHLtsKAq2pGx4esISD7qbz94g
	 GgY3KajFepWqQ==
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
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 4/5] PCI: tegra: Add Tegra264 support
Date: Thu, 19 Mar 2026 17:01:08 +0100
Message-ID: <20260319160110.2131954-5-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319160110.2131954-1-thierry.reding@kernel.org>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
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

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/Kconfig         |   8 +
 drivers/pci/controller/Makefile        |   1 +
 drivers/pci/controller/pcie-tegra264.c | 506 +++++++++++++++++++++++++
 3 files changed, 515 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-tegra264.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e72ac6934379..36abee65eca1 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -257,6 +257,14 @@ config PCI_TEGRA
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
 
+config PCIE_TEGRA264
+	bool "NVIDIA Tegra264 PCIe controller"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on PCI_MSI
+	help
+	  Say Y here if you want support for the PCIe host controller found
+	  on NVIDIA Tegra264 SoCs.
+
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe controller (host mode)"
 	depends on ARCH_RENESAS || COMPILE_TEST
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
index 000000000000..0c8351b88941
--- /dev/null
+++ b/drivers/pci/controller/pcie-tegra264.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright (c) 2022-2025, NVIDIA CORPORATION. All rights reserved.
+/*
+ * PCIe host controller driver for Tegra264 SoC
+ *
+ * Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
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
+#define PCIE_LINK_UP_DELAY	10000	/* 10 msec */
+#define PCIE_LINK_UP_TIMEOUT	1000000	/* 1 s */
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
+#define XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS		0x58
+#define XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS_DLL_ACTIVE	BIT(29)
+
+#define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a
+
+#define XTL_RC_MGMT_PERST_CONTROL		0x218
+#define XTL_RC_MGMT_PERST_CONTROL_PERST_O_N	BIT(0)
+
+#define XTL_RC_MGMT_CLOCK_CONTROL		0x47C
+#define XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT	BIT(9)
+
+struct tegra264_pcie {
+	struct device *dev;
+	bool link_state;
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
+			dev_err(pcie->dev, "failed to get wake IRQ: %d\n", err);
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
+	struct tegra_bpmp_message msg;
+	struct mrq_pcie_request req;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+
+	req.cmd = CMD_PCIE_RP_CONTROLLER_OFF;
+	req.rp_ctrlr_off.rp_controller = pcie->ctl_id;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_PCIE;
+	msg.tx.data = &req;
+	msg.tx.size = sizeof(req);
+
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		dev_info(pcie->dev, "failed to turn off PCIe #%u: %d\n",
+			 pcie->ctl_id, err);
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
+	bw = width * (PCIE_SPEED2MBS_ENC(speed) / BITS_PER_BYTE);
+	value = MBps_to_icc(bw);
+
+	err = icc_set_bw(pcie->icc_path, bw, bw);
+	if (err < 0)
+		dev_err(pcie->dev,
+			"failed to request bandwidth (%u MBps): %d\n",
+			bw, err);
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
+		unsigned long type = range.flags & IORESOURCE_TYPE_BITS;
+		unsigned int addr_hi, addr_lo, limit_hi, limit_lo;
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
+				region = "prefetchable memory";
+			} else {
+				addr_hi = XAL_RC_MEM_32BIT_BASE_HI;
+				addr_lo = XAL_RC_MEM_32BIT_BASE_LO;
+				limit_hi = XAL_RC_MEM_32BIT_LIMIT_HI;
+				limit_lo = XAL_RC_MEM_32BIT_LIMIT_LO;
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
+static void tegra264_pcie_init(struct tegra264_pcie *pcie)
+{
+	u32 value;
+
+	if (!tegra_is_silicon()) {
+		dev_info(pcie->dev,
+			 "skipping link state for PCIe #%u in simulation\n",
+			 pcie->ctl_id);
+		pcie->link_state = true;
+		return;
+	}
+
+	/* Poll every 10 msec for 1 sec to link up */
+	readl_poll_timeout(pcie->ecam + XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS,
+		value, value & XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS_DLL_ACTIVE,
+		PCIE_LINK_UP_DELAY, PCIE_LINK_UP_TIMEOUT);
+
+	if (value & XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS_DLL_ACTIVE) {
+		/* Per PCIe r5.0, 6.6.1 wait for 100ms after DLL up */
+		msleep(100);
+		dev_info(pcie->dev, "PCIe #%u link is up (speed: %d)\n",
+			 pcie->ctl_id, (value & 0xf0000) >> 16);
+		pcie->link_state = true;
+		tegra264_pcie_icc_set(pcie);
+	} else {
+		dev_info(pcie->dev, "PCIe #%u link is down\n", pcie->ctl_id);
+
+		value = readl(pcie->xtl + XTL_RC_MGMT_CLOCK_CONTROL);
+
+		/** Set link state only when link fails and no hot-plug feature is present */
+		if ((value & XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT) == 0) {
+			dev_info(pcie->dev,
+				 "PCIe #%u link is down and not hotplug-capable, turning off\n",
+				 pcie->ctl_id);
+			tegra264_pcie_bpmp_set_rp_state(pcie);
+			pcie->link_state = false;
+		} else {
+			pcie->link_state = true;
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
+	if (!bridge) {
+		dev_err(dev, "failed to allocate host bridge\n");
+		return -ENOMEM;
+	}
+
+	pcie = pci_host_bridge_priv(bridge);
+	platform_set_drvdata(pdev, pcie);
+	pcie->bridge = bridge;
+	pcie->dev = dev;
+
+	err = pinctrl_pm_select_default_state(dev);
+	if (err < 0) {
+		dev_err(dev, "failed to configure sideband pins: %d\n", err);
+		return err;
+	}
+
+	err = tegra264_pcie_parse_dt(pcie);
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to parse device tree");
+
+	pcie->xal = devm_platform_ioremap_resource_byname(pdev, "xal");
+	if (IS_ERR(pcie->xal)) {
+		err = PTR_ERR(pcie->xal);
+		dev_err(dev, "failed to map xal memory: %d\n", err);
+		return err;
+	}
+
+	pcie->xtl = devm_platform_ioremap_resource_byname(pdev, "xtl-pri");
+	if (IS_ERR(pcie->xtl)) {
+		err = PTR_ERR(pcie->xtl);
+		dev_err(dev, "failed to map xtl-pri memory: %d\n", err);
+		return err;
+	}
+
+	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (!bus) {
+		dev_err(dev, "failed to get bus resource\n");
+		return -ENODEV;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam");
+	if (!res) {
+		dev_err(dev, "failed to get ECAM resource\n");
+		return -ENXIO;
+	}
+
+	pcie->icc_path = devm_of_icc_get(&pdev->dev, "write");
+	if (IS_ERR(pcie->icc_path))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pcie->icc_path),
+				     "failed to get ICC");
+
+	pcie->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
+	if (IS_ERR(pcie->cfg)) {
+		err = PTR_ERR(pcie->cfg);
+		dev_err(dev, "failed to create ECAM: %d\n", err);
+		return err;
+	}
+
+	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+	bridge->sysdata = pcie->cfg;
+	pcie->ecam = pcie->cfg->win;
+
+	/*
+	 * Parse BPMP property only for silicon, as interaction with BPMP is
+	 * not needed for other platforms.
+	 */
+	if (tegra_is_silicon()) {
+		pcie->bpmp = tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
+		if (IS_ERR(pcie->bpmp)) {
+			err = PTR_ERR(pcie->bpmp);
+			dev_err(dev, "failed to get BPMP: %d\n", err);
+			goto free;
+		}
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
+	tegra264_pcie_init(pcie);
+
+	if (!pcie->link_state)
+		goto put_pm;
+
+	err = pci_host_probe(bridge);
+	if (err < 0) {
+		dev_err(dev, "failed to register host: %d\n", err);
+		goto put_pm;
+	}
+
+	return err;
+
+put_pm:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	if (tegra_is_silicon())
+		tegra_bpmp_put(pcie->bpmp);
+free:
+	pci_ecam_free(pcie->cfg);
+	return err;
+}
+
+static void tegra264_pcie_remove(struct platform_device *pdev)
+{
+	struct tegra264_pcie *pcie = platform_get_drvdata(pdev);
+
+	/*
+	 * If we undo tegra264_pcie_init() then link goes down and need
+	 * controller reset to bring up the link again. Remove intention is
+	 * to clean up the root bridge and re-enumerate during bind.
+	 */
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
+			dev_err(dev, "failed to enable wake IRQ: %d\n", err);
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
+			dev_err(dev, "failed to disable wake IRQ: %d\n", err);
+	}
+
+	if (pcie->link_state == false)
+		return 0;
+
+	tegra264_pcie_init(pcie);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra264_pcie_pm_ops = {
+	.resume_noirq = tegra264_pcie_resume_noirq,
+	.suspend_noirq = tegra264_pcie_suspend_noirq,
+};
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
+MODULE_DESCRIPTION("NVIDIA Tegra264 PCIe host controller driver");
+MODULE_LICENSE("GPL");
-- 
2.52.0

