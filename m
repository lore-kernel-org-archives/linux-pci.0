Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A0326931;
	Wed, 25 Feb 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009821; cv=none; b=lmrC7APwIlLHAQTFvL6WCeTzdILFn6Z12SAKPh79jRuQ3QkN99vuGzXv8m0bw75lKWjsodcwdYJyGX96Id0Eevn0EKmAfe2jztzzAGH2H0Us8jFNOK4DmFqrOB4jO3rWESdJ0bYihfpfj7o+d1UG9AVYxYJG5why2TmAom0+MR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009821; c=relaxed/simple;
	bh=Q2+eln8AOytxLuSyo1ljLJzo0e/fMmCnx58iBBB8z/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SX3DxEOJ7zuWlM6svgSNUYi82Q9NC6UB8pnOcSmlL/WhQm298o/iNKH6K6//yuaT8sPbp1aLdITnKRZ6f7MUpSSo69WDVoxHDsVdd0rkpaiPKPgcsLbQhAgYo955oFKvkngagvu6ATTn9lLFfwOs6lrNpfCLdpqSSDUCZ25mC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTP id 61P8tBd7077809;
	Wed, 25 Feb 2026 16:55:12 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Feb
 2026 16:55:11 +0800
From: Randolph <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>,
        <christian.bruel@foss.st.com>, <Ghennadi.Procopciuc@nxp.com>,
        <quic_wenbyao@quicinc.com>, <qiang.yu@oss.qualcomm.com>,
        <vincent.guittot@linaro.org>, <vidyas@nvidia.com>,
        <elder@riscstar.com>, <s-vadapalli@ti.com>,
        <ciprianmarian.costea@nxp.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v11 3/4] PCI: qilai: Add Andes QiLai SoC PCIe host driver support
Date: Wed, 25 Feb 2026 16:55:03 +0800
Message-ID: <20260225085504.3757601-4-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225085504.3757601-1-randolph@andestech.com>
References: <20260225085504.3757601-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 61P8tBd7077809

From: Randolph Lin <randolph@andestech.com>

Add driver support for DesignWare based PCIe controller in Andes
QiLai SoC. The driver only supports the Root Complex mode.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/pci/controller/dwc/Kconfig            |  13 ++
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-andes-qilai.c | 197 ++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d0aa031397fa..95bfb60d73a4 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -61,6 +61,19 @@ config PCI_MESON
 	  and therefore the driver re-uses the DesignWare core functions to
 	  implement the driver.
 
+config PCIE_ANDES_QILAI
+	tristate "Andes QiLai PCIe controller"
+	depends on ARCH_ANDES || COMPILE_TEST
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	help
+	  Say Y here to enable PCIe controller support on Andes QiLai SoCs,
+	  which operate in Root Complex mode. The Andes QiLai SoC PCIe
+	  controller is based on DesignWare IP and therefore the driver
+	  re-uses the DesignWare core functions to implement the driver.
+	  The Andes QiLai SoC features three Root Complexes, each operating
+	  on PCIe 4.0.
+
 config PCIE_ARTPEC6
 	bool
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 67ba59c02038..9e61458dff00 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
+obj-$(CONFIG_PCIE_ANDES_QILAI) += pcie-andes-qilai.o
 obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
diff --git a/drivers/pci/controller/dwc/pcie-andes-qilai.c b/drivers/pci/controller/dwc/pcie-andes-qilai.c
new file mode 100644
index 000000000000..bd1588be44e0
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-andes-qilai.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the PCIe Controller in QiLai from Andes
+ *
+ * Copyright (C) 2026 Andes Technology Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+
+#define PCIE_INTR_CONTROL1			0x15c
+#define PCIE_MSI_CTRL_INT_EN			BIT(28)
+
+#define PCIE_LOGIC_COHERENCY_CONTROL3		0x8e8
+
+/*
+ * Refer to Table A4-5 (Memory type encoding) in the
+ * AMBA AXI and ACE Protocol Specification.
+ *
+ * The selected value corresponds to the Memory type field:
+ * "Write-back, Read and Write-allocate".
+ *
+ * The last three rows in the table A4-5 in
+ * AMBA AXI and ACE Protocol Specification:
+ * ARCACHE        AWCACHE        Memory type
+ * ------------------------------------------------------------------
+ * 1111 (0111)    0111           Write-back Read-allocate
+ * 1011           1111 (1011)    Write-back Write-allocate
+ * 1111           1111           Write-back Read and Write-allocate (selected)
+ */
+#define IOCP_ARCACHE				0b1111
+#define IOCP_AWCACHE				0b1111
+
+#define PCIE_CFG_MSTR_ARCACHE_MODE		GENMASK(6, 3)
+#define PCIE_CFG_MSTR_AWCACHE_MODE		GENMASK(14, 11)
+#define PCIE_CFG_MSTR_ARCACHE_VALUE		GENMASK(22, 19)
+#define PCIE_CFG_MSTR_AWCACHE_VALUE		GENMASK(30, 27)
+
+#define PCIE_GEN_CONTROL2			0x54
+#define PCIE_CFG_LTSSM_EN			BIT(0)
+
+#define PCIE_REGS_PCIE_SII_PM_STATE		0xc0
+#define SMLH_LINK_UP				BIT(6)
+#define RDLH_LINK_UP				BIT(7)
+
+struct qilai_pcie {
+	struct dw_pcie pci;
+	void __iomem *apb_base;
+};
+
+#define to_qilai_pcie(_pci) container_of(_pci, struct qilai_pcie, pci)
+
+static bool qilai_pcie_link_up(struct dw_pcie *pci)
+{
+	struct qilai_pcie *pcie = to_qilai_pcie(pci);
+	u32 val;
+
+	val = readl(pcie->apb_base + PCIE_REGS_PCIE_SII_PM_STATE);
+
+	return FIELD_GET(SMLH_LINK_UP, val) && FIELD_GET(RDLH_LINK_UP, val);
+}
+
+static int qilai_pcie_start_link(struct dw_pcie *pci)
+{
+	struct qilai_pcie *pcie = to_qilai_pcie(pci);
+	u32 val;
+
+	val = readl(pcie->apb_base + PCIE_GEN_CONTROL2);
+	val |= PCIE_CFG_LTSSM_EN;
+	writel(val, pcie->apb_base + PCIE_GEN_CONTROL2);
+
+	return 0;
+}
+
+static const struct dw_pcie_ops qilai_pcie_ops = {
+	.link_up = qilai_pcie_link_up,
+	.start_link = qilai_pcie_start_link,
+};
+
+/*
+ * Set up the QiLai PCIe IOCP (IO Coherence Port) Read/Write Behaviors to the
+ * Write-Back, Read and Write Allocate mode.
+ *
+ * The IOCP HW target is SoC last-level cache (L2 Cache), which serves as the
+ * system cache. The IOCP HW helps maintain cache monitoring, ensuring that
+ * the device can snoop data from/to the cache.
+ */
+static void qilai_pcie_iocp_cache_setup(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u32 val;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_LOGIC_COHERENCY_CONTROL3);
+	FIELD_MODIFY(PCIE_CFG_MSTR_ARCACHE_MODE, &val, IOCP_ARCACHE);
+	FIELD_MODIFY(PCIE_CFG_MSTR_AWCACHE_MODE, &val, IOCP_AWCACHE);
+	FIELD_MODIFY(PCIE_CFG_MSTR_ARCACHE_VALUE, &val, IOCP_ARCACHE);
+	FIELD_MODIFY(PCIE_CFG_MSTR_AWCACHE_VALUE, &val, IOCP_AWCACHE);
+	dw_pcie_writel_dbi(pci, PCIE_LOGIC_COHERENCY_CONTROL3, val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static void qilai_pcie_enable_msi(struct qilai_pcie *pcie)
+{
+	u32 val;
+
+	val = readl(pcie->apb_base + PCIE_INTR_CONTROL1);
+	val |= PCIE_MSI_CTRL_INT_EN;
+	writel(val, pcie->apb_base + PCIE_INTR_CONTROL1);
+}
+
+static int qilai_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qilai_pcie *pcie = to_qilai_pcie(pci);
+
+	qilai_pcie_enable_msi(pcie);
+
+	return 0;
+}
+
+static void qilai_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	qilai_pcie_iocp_cache_setup(pp);
+}
+
+static const struct dw_pcie_host_ops qilai_pcie_host_ops = {
+	.init = qilai_pcie_host_init,
+	.post_init = qilai_pcie_host_post_init,
+};
+
+static int qilai_pcie_probe(struct platform_device *pdev)
+{
+	struct qilai_pcie *pcie;
+	struct dw_pcie *pci;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pcie);
+
+	pci = &pcie->pci;
+	pcie->pci.dev = dev;
+	pcie->pci.ops = &qilai_pcie_ops;
+	pcie->pci.pp.ops = &qilai_pcie_host_ops;
+	pci->use_parent_dt_ranges = true;
+
+	dw_pcie_cap_set(&pcie->pci, REQ_RES);
+
+	pcie->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
+	if (IS_ERR(pcie->apb_base))
+		return PTR_ERR(pcie->apb_base);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_no_callbacks(dev);
+	devm_pm_runtime_enable(dev);
+
+	ret = dw_pcie_host_init(&pcie->pci.pp);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize PCIe host\n");
+
+	return 0;
+}
+
+static const struct of_device_id qilai_pcie_of_match[] = {
+	{ .compatible = "andestech,qilai-pcie" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, qilai_pcie_of_match);
+
+static struct platform_driver qilai_pcie_driver = {
+	.probe = qilai_pcie_probe,
+	.driver = {
+		.name	= "qilai-pcie",
+		.of_match_table = qilai_pcie_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+builtin_platform_driver(qilai_pcie_driver);
+
+MODULE_AUTHOR("Randolph Lin <randolph@andestech.com>");
+MODULE_DESCRIPTION("Andes QiLai PCIe driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

