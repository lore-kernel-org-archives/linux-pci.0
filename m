Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53793 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422672AbcBZQa3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Feb 2016 11:30:29 -0500
Subject: [PATCH v11 4/4] PCI: designware: Add driver for prototyping kits
 based on ARC SDP
To: Joao Pinto <Joao.Pinto@synopsys.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: mark.rutland@arm.com, Alexey.Brodkin@synopsys.com, arnd@arndb.de,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	linux-pci@vger.kernel.org, Vineet.Gupta1@synopsys.com,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com,
	robh+dt@kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
	galak@codeaurora.org, Jingoo Han <jingoohan1@gmail.com>,
	linux-snps-arc@lists.infradead.org
Date: Fri, 26 Feb 2016 10:30:21 -0600
Message-ID: <20160226163021.11964.74095.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160226162554.11964.96983.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160226162554.11964.96983.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joao Pinto <Joao.Pinto@synopsys.com>

Add a reference platform driver for PCI RC IP Protoyping Kits based on the
ARC SDP.

[bhelgaas: changelog, split patch up, MAINTAINERS update]
Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../devicetree/bindings/pci/designware-pcie.txt    |   17 ++
 MAINTAINERS                                        |    7 +
 drivers/pci/host/Kconfig                           |   11 ++
 drivers/pci/host/Makefile                          |    1 
 drivers/pci/host/pcie-designware-plat.c            |  138 ++++++++++++++++++++
 5 files changed, 174 insertions(+)
 create mode 100644 drivers/pci/host/pcie-designware-plat.c

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 5b0853d..64f2fff 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -28,3 +28,20 @@ Optional properties:
 - clock-names: Must include the following entries:
 	- "pcie"
 	- "pcie_bus"
+
+Example configuration:
+
+	pcie: pcie@0xdffff000 {
+		compatible = "snps,dw-pcie";
+		reg = <0xdffff000 0x1000>, /* Controller registers */
+		      <0xd0000000 0x2000>; /* PCI config space */
+		reg-names = "ctrlreg", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000
+			  0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
+		interrupts = <25>, <24>;
+		#interrupt-cells = <1>;
+		num-lanes = <1>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 30aca4a..e6c327b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8367,6 +8367,13 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*designware*
 
+PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
+M:	Joao Pinto <jpinto@synopsys.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
+F:	drivers/pci/host/pcie-designware-plat.c
+
 PCI DRIVER FOR GENERIC OF HOSTS
 M:	Will Deacon <will.deacon@arm.com>
 L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 75a6054..7c47d69 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -16,6 +16,17 @@ config PCI_MVEBU
 	depends on ARCH_MVEBU || ARCH_DOVE
 	depends on OF
 
+config PCIE_DW_PLAT
+	bool "Platform bus based DesignWare PCIe Controller"
+	select PCIE_DW
+	---help---
+	 This selects the DesignWare PCIe controller support. Select this if
+	 you have a PCIe controller on Platform bus.
+
+	 If you have a controller with this interface, say Y or M here.
+
+	 If unsure, say N.
+
 config PCIE_DW
 	bool
 
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 7b2f20c..7136a1e 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
new file mode 100644
index 0000000..b350099
--- /dev/null
+++ b/drivers/pci/host/pcie-designware-plat.c
@@ -0,0 +1,138 @@
+/*
+ * PCIe RC driver for Synopsys DesignWare Core
+ *
+ * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Authors: Joao Pinto <jpinto@synopsys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/signal.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+
+struct dw_plat_pcie {
+	void __iomem		*mem_base;
+	struct pcie_port	pp;
+};
+
+static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	return dw_handle_msi_irq(pp);
+}
+
+static void dw_plat_pcie_host_init(struct pcie_port *pp)
+{
+	dw_pcie_setup_rc(pp);
+	dw_pcie_wait_for_link(pp);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+}
+
+static struct pcie_host_ops dw_plat_pcie_host_ops = {
+	.host_init = dw_plat_pcie_host_init,
+};
+
+static int dw_plat_add_pcie_port(struct pcie_port *pp,
+				 struct platform_device *pdev)
+{
+	int ret;
+
+	pp->irq = platform_get_irq(pdev, 1);
+	if (pp->irq < 0)
+		return pp->irq;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq(pdev, 0);
+		if (pp->msi_irq < 0)
+			return pp->msi_irq;
+
+		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+					dw_plat_pcie_msi_irq_handler,
+					IRQF_SHARED, "dw-plat-pcie-msi", pp);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request MSI IRQ\n");
+			return ret;
+		}
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &dw_plat_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dw_plat_pcie_probe(struct platform_device *pdev)
+{
+	struct dw_plat_pcie *dw_plat_pcie;
+	struct pcie_port *pp;
+	struct resource *res;  /* Resource from DT */
+	int ret;
+
+	dw_plat_pcie = devm_kzalloc(&pdev->dev, sizeof(*dw_plat_pcie),
+					GFP_KERNEL);
+	if (!dw_plat_pcie)
+		return -ENOMEM;
+
+	pp = &dw_plat_pcie->pp;
+	pp->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	dw_plat_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dw_plat_pcie->mem_base))
+		return PTR_ERR(dw_plat_pcie->mem_base);
+
+	pp->dbi_base = dw_plat_pcie->mem_base;
+
+	ret = dw_plat_add_pcie_port(pp, pdev);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, dw_plat_pcie);
+	return 0;
+}
+
+static const struct of_device_id dw_plat_pcie_of_match[] = {
+	{ .compatible = "snps,dw-pcie", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_plat_pcie_of_match);
+
+static struct platform_driver dw_plat_pcie_driver = {
+	.driver = {
+		.name	= "dw-pcie",
+		.of_match_table = dw_plat_pcie_of_match,
+	},
+	.probe = dw_plat_pcie_probe,
+};
+
+module_platform_driver(dw_plat_pcie_driver);
+
+MODULE_AUTHOR("Joao Pinto <Joao.Pinto@synopsys.com>");
+MODULE_DESCRIPTION("Synopsys PCIe host controller glue platform driver");
+MODULE_LICENSE("GPL v2");

