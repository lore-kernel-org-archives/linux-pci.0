Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F29449B0F;
	Wed,  5 Aug 2026 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931072; cv=none; b=unxgYZ6mYLyvWyxfpgUSUa89MDO50bRRZsUq835MoPYus8GT3vnBPHBDcYD7JmZIV3a9WDD5aWukkGf22S5nJXjTOL+Q0o1zbh654TVhplY4ODjHSiGf0zUNutmoZTliWsU7dOC8kjO+rhnyFhWeFFr1Kt7HUCRHDpcWQXiE7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931072; c=relaxed/simple;
	bh=aTqCsEnuGscX/iPNFdtTZ1NrDKqRTwxDLP603+30Qvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5UYy9mjKFKD0iUR8YoPxxZWg1XiOPDM0bGdoVqrPr+ZBs48UpE9s3D6T4TC9Baky6WyfiucjA7420HclKnPcKpJESX5VI6sJM7f5FqrmbDK+R7h5Db5AuJ67sHeM7pxIclUpO1ZrFy6nQAkNxaVqlkOL0qOEyMtAtO+aUc4ynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIrOujUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIrOujUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572691F000E9;
	Wed,  5 Aug 2026 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931067;
	bh=awvJhnsJwxAymEIAnFPrGQKmsl2oXtGQSqpjwM+RqvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CIrOujUkFTWwiVbRjYP/Og+N0kvJPd00r0UXpc7QjYJjJs5bfk/wNjOv/cRpATVtl
	 r9FZ52zBho4DG2m9mdCyw3zIxv/VjR8WkGLjXX/p0NILoGgxOYyuHpjH3yQGyhXnYX
	 Kd+VwdcaixrpM0V5WOz60g/9sVVHV+yjlp4tJaQ/hkdb6z/ogWe2pHG5W/CrziMPQb
	 ZwQSUiv3NDRznccgN03OdUeB37ppt4v7Jdwnm5I4Poq5b97jXNU9t6bQYKuk92Jbrq
	 cFHDoNKJ2J3R3jnearIaJ3G91ZhIoOFgdZXfrUZm6wp8uhNAmLYJe6f44YGrqROQ7Y
	 VGnISfBqRmCgw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 05 Aug 2026 13:57:22 +0200
Subject: [PATCH v9 3/5] PCI: tegra: Add Tegra264 support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tegra264-pcie-v9-3-fa2ed7350ae1@nvidia.com>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
In-Reply-To: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
 Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18025; i=treding@nvidia.com;
 h=from:subject:message-id; bh=I66f7Aff8CwDwYd7ORcI3MdP2SOyBSeKCXYyuLDUvIw=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqcyUx0Z2PFG2zlGfV9PB7240lGTACl+kw6P9RX
 IzxzY0lVH+JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanMlMQAKCRDdI6zXfz6z
 obYnD/0YhxTWvnp5Wf91hF5gLSOBYl63XcCjuSRPkY4YZgZm6cqiT08+UNamjZZzvr/5No66QSE
 6HwOV7I365M70eaPC3IbmI18BygIlvYTfijWE5m5aJ0HKELS8oAeiPo5ZvHcYIh63/sZxXWoUDx
 dR5v5XvsTiHtNQBFmZeOfnYVufojwTpjopsZwT94UB5kt81dYN9rOGNs0IT3w4GcMoa9c+esLoq
 yF0raFN+ZwFLF6n4qzpG7Kc/lXtBxvnosHsHrBcLwNp+ItRIF+iB5jx/BVABCu6ni4L+1hBNxY4
 IF4LTRsEBVMo4/alJe4C4hoHVvu2a1Od0LUEPJySdSi28IftGWxHcqNQ60TYu+VkrgTHtZh0dw/
 ReqKSUIeRwksUQB5c2C1ubIkRFjmsnj3r5iKBV9bqP6dvGq27Hk0GstLhCVXNbdR5QNyw+a7+Wh
 h9WadSPBRREsJKG9ymP98Gfj1EwtaQOZImTYRBuPDKd2fC7/V8BQOxy4nTeCygRNI9Gn4H48Rur
 OOdzq/mO7UYSGURbc0cyCD/9SEbkH7tu2smBkQuF/s5e4Idj3EomXuRP3+K2FNURDrF5fbvnArS
 xv+E96ZfXdk+qOAeOw7Pab+3fzw5qd1norfS6qLjIoVnep9VIUFDiGlj1/tR9hQhokH7sM2SRiT
 s0Ht3RDqiAlOrCg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
driver is very small, with its main purpose being to set up the address
translation registers and then creating a standard PCI host using ECAM.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v9:
- remove suspend/resume support, it doesn't work on Tegra264 yet
- use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
- rename tegra264_pcie_check_ranges() for clarity
- remove unused header includes

Changes in v8:
- remove controller deinitialization, firmware does this already
- separately track hotplug support and link up state for clarity
- select pinctrl sleep state on suspend for symmetry with resume
- fail probe if the link is down and not hotplug-capable
- remove WAKE# IRQ support
- add err_ prefix to gotos

Changes in v7:
- select PCI_ECAM to satisfy the build dependency (Jonathan Hunter)
- remove pre-silicon support patch to avoid extra build dependency

Changes in v6:
- remove unneeded pm_runtime_disable() call (Sashiko)
- do not use noirq suspend/resume callbacks (Sashiko)
- wrap PM ops in pm_ptr() macro (Sashiko)
- use standard wait times with msleep() (Lukas Wunner)
- properly check errors for wake IRQs
- fix build failures /o\

Changes in v5:
- make PCIE_TEGRA264 symbol tristate
- drop dependency on PCI_MSI
- reorganize tegra264_pcie struct
- use standard wake-gpios property
- rename tegra264_pcie_bpmp_set_rp_state() to tegra264_pcie_power_off()
- use dev_err() instead of dev_info() for some error messages
- add clarifying comment as to why bandwidth requests aren't fatal
- address some compiler warnings on 32-bit physical address platforms
- drop needless comments
- explicitly deinitialize controller on suspend
- use devm_pm_runtime_active_enabled()
- rename "free" label to "free_ecam"
- use dev_err_probe() in more places
- reselect default pin state during resume, not probe
- return early on absence of wake GPIO
- simplify BW value calculation

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

fixups
---
 drivers/pci/controller/Kconfig         |  10 +-
 drivers/pci/controller/Makefile        |   1 +
 drivers/pci/controller/pcie-tegra264.c | 450 +++++++++++++++++++++++++++++++++
 3 files changed, 460 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8a3a31b2bc12..b20d84290f7e 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -255,7 +255,15 @@ config PCI_TEGRA
 	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want support for the PCIe host controller found
-	  on NVIDIA Tegra SoCs.
+	  on NVIDIA Tegra SoCs (Tegra20 through Tegra186).
+
+config PCIE_TEGRA264
+	tristate "NVIDIA Tegra264 PCIe controller"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	select PCI_ECAM
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
index 000000000000..e0c5b9d0d20b
--- /dev/null
+++ b/drivers/pci/controller/pcie-tegra264.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe host controller driver for Tegra264 SoC
+ *
+ * Copyright (c) 2022-2026, NVIDIA CORPORATION. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interconnect.h>
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
+	/* BPMP and bandwidth management */
+	struct icc_path *icc_path;
+	struct tegra_bpmp *bpmp;
+	u32 ctl_id;
+
+	bool supports_hotplug;
+	bool link_up;
+};
+
+static void tegra264_pcie_power_off(struct tegra264_pcie *pcie)
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
+		dev_err(pcie->dev, "failed to turn off PCIe #%u: %pe\n",
+			pcie->ctl_id, ERR_PTR(err));
+
+	if (msg.rx.ret)
+		dev_err(pcie->dev, "failed to turn off PCIe #%u: %d\n",
+			pcie->ctl_id, msg.rx.ret);
+}
+
+static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
+{
+	u32 value, speed, width;
+	int err;
+
+	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
+	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
+
+	value = Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]));
+
+	/*
+	 * We don't want to error out here because a boot-critical device
+	 * could be connected to this root port. Failure to set the bandwidth
+	 * request may have an adverse impact on performance, but it is not
+	 * generally fatal, so we opt to continue regardless so that users
+	 * get a chance to fix things.
+	 */
+	err = icc_set_bw(pcie->icc_path, value, value);
+	if (err < 0)
+		dev_err(pcie->dev,
+			"failed to request bandwidth (%u kBps): %pe\n",
+			value, ERR_PTR(err));
+}
+
+/*
+ * The various memory regions used by the controller (I/O, memory, ECAM) are
+ * set up during early boot and have hardware-level protections in place. If
+ * the DT ranges don't match what's been setup, the controller won't be able
+ * to write the address endpoints properly, so make sure to validate that DT
+ * and firmware programming agree on these ranges.
+ */
+static bool tegra264_pcie_valid_ranges(struct platform_device *pdev)
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
+		phys = ((hi << 16) << 16) | lo;
+
+		hi = readl(pcie->xal + limit_hi);
+		lo = readl(pcie->xal + limit_lo);
+		limit = ((hi << 16) << 16) | lo | mask;
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
+	phys = ((hi << 16) << 16) | lo;
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
+static bool tegra264_pcie_supports_hotplug(struct tegra264_pcie *pcie)
+{
+	u32 value = readl(pcie->xtl + XTL_RC_MGMT_CLOCK_CONTROL);
+
+	return (value & XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT) != 0;
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
+	/* bring the endpoint out of reset */
+	value = readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
+	value |= XTL_RC_MGMT_PERST_CONTROL_PERST_O_N;
+	writel(value, pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
+
+	for (i = 0; i < PCIE_LINK_WAIT_MAX_RETRIES; i++) {
+		if (tegra264_pcie_link_up(pcie, NULL))
+			break;
+
+		msleep(PCIE_LINK_WAIT_SLEEP_MS);
+	}
+
+	pcie->supports_hotplug = tegra264_pcie_supports_hotplug(pcie);
+	pcie->link_up = tegra264_pcie_link_up(pcie, &speed);
+
+	if (pcie->link_up) {
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+		dev_info(pcie->dev, "PCIe #%u link is up (speed: %s)\n",
+			 pcie->ctl_id, pci_speed_string(speed));
+		tegra264_pcie_icc_set(pcie);
+	} else {
+		dev_info(pcie->dev, "PCIe #%u link is down\n", pcie->ctl_id);
+
+		/*
+		 * Make sure to reset the bandwidth requirements if the link
+		 * is down but hotplug-capable.
+		 */
+		if (pcie->supports_hotplug)
+			tegra264_pcie_icc_set(pcie);
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
+	pcie->icc_path = devm_of_icc_get(dev, "write");
+	if (IS_ERR(pcie->icc_path))
+		return dev_err_probe(dev, PTR_ERR(pcie->icc_path),
+				     "failed to get ICC\n");
+
+	pcie->bpmp = tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
+	if (IS_ERR(pcie->bpmp))
+		return dev_err_probe(dev, PTR_ERR(pcie->bpmp),
+				     "failed to get BPMP\n");
+
+	err = devm_pm_runtime_set_active_enabled(dev);
+	if (err < 0) {
+		dev_err_probe(dev, err, "failed to enable runtime PM\n");
+		goto err_put_bpmp;
+	}
+
+	err = pm_runtime_resume_and_get(dev);
+	if (err < 0) {
+		dev_err_probe(dev, err, "failed to power on device\n");
+		goto err_put_bpmp;
+	}
+
+	/* sanity check that programmed ranges match what's in DT */
+	if (!tegra264_pcie_valid_ranges(pdev)) {
+		err = -EINVAL;
+		goto err_put_pm;
+	}
+
+	pcie->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
+	if (IS_ERR(pcie->cfg)) {
+		err = dev_err_probe(dev, PTR_ERR(pcie->cfg),
+				    "failed to create ECAM\n");
+		goto err_put_pm;
+	}
+
+	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+	bridge->sysdata = pcie->cfg;
+	pcie->ecam = pcie->cfg->win;
+
+	tegra264_pcie_init(pcie);
+
+	/*
+	 * Fail if the link isn't up and doesn't support hotplug, no device
+	 * will ever be able to be added on this bus.
+	 */
+	if (!pcie->link_up && !pcie->supports_hotplug) {
+		err = dev_err_probe(pcie->dev, -ENODEV,
+				    "PCIe #%u link is down and not hotplug-capable, turning off\n",
+				    pcie->ctl_id);
+		tegra264_pcie_power_off(pcie);
+		goto err_free_ecam;
+	}
+
+	err = pci_host_probe(bridge);
+	if (err < 0) {
+		dev_err_probe(dev, err, "failed to register host\n");
+		goto err_free_ecam;
+	}
+
+	return 0;
+
+err_free_ecam:
+	pci_ecam_free(pcie->cfg);
+err_put_pm:
+	pm_runtime_put_sync(dev);
+err_put_bpmp:
+	tegra_bpmp_put(pcie->bpmp);
+
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
+	tegra_bpmp_put(pcie->bpmp);
+	pci_ecam_free(pcie->cfg);
+}
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
2.54.0

