Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35648 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdH1SEt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 14:04:49 -0400
Received: by mail-wr0-f175.google.com with SMTP id j29so2902979wre.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Aug 2017 11:04:48 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, mw@semihalf.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] pci: designware: add driver for DWC controller in ECAM shift mode
Date: Mon, 28 Aug 2017 19:04:36 +0100
Message-Id: <20170828180437.2646-2-ard.biesheuvel@linaro.org>
In-Reply-To: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
References: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some implementations of the Synopsys Designware PCIe controller implement
a so-called ECAM shift mode, which allows a static memory window to be
configured that covers the configuration space of the entire bus range.

If the firmware performs all the low level configuration that is required
to expose this controller in a fully ECAM compatible manner, we can
simply describe it as "pci-host-ecam-generic" and be done with it.
However, it appears that in some cases (one of which is the Armada 80x0),
the IP is synthesized with an ATU window size that does not allow the
first bus to be mapped in a way that prevents the device on the
downstream port from appearing more than once.

So implement a driver that relies on the firmware to perform all low
level initialization, and drives the controller in ECAM mode, but
overrides the config space accessors to take the above quirk into
account.

Note that, unlike most drivers for this IP, this driver does not expose
a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
given that this is not a true bridge, and does not require any windows
to be configured in order for the downstream device to operate correctly.
Omitting it also prevents the PCI resource allocation routines from
handing out BAR space to it unnecessarily.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/dwc/Kconfig                | 11 +++
 drivers/pci/dwc/Makefile               |  1 +
 drivers/pci/dwc/pcie-designware-ecam.c | 77 ++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index d275aadc47ee..477576d07911 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -169,4 +169,15 @@ config PCIE_KIRIN
 	  Say Y here if you want PCIe controller support
 	  on HiSilicon Kirin series SoCs.
 
+config PCIE_DW_HOST_ECAM
+	bool "Synopsys DesignWare PCIe controller in ECAM mode"
+	depends on OF && PCI
+	select PCI_HOST_COMMON
+	select IRQ_DOMAIN
+	help
+	  Add support for Synopsys DesignWare PCIe controllers configured
+	  by the firmware into ECAM shift mode. In some cases, these are
+	  fully ECAM compliant, in which case the pci-host-generic driver
+	  may be used instead.
+
 endmenu
diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
index c61be9738cce..7d5a23e5b767 100644
--- a/drivers/pci/dwc/Makefile
+++ b/drivers/pci/dwc/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
+obj-$(CONFIG_PCIE_DW_HOST_ECAM) += pcie-designware-ecam.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 ifneq ($(filter y,$(CONFIG_PCI_DRA7XX_HOST) $(CONFIG_PCI_DRA7XX_EP)),)
diff --git a/drivers/pci/dwc/pcie-designware-ecam.c b/drivers/pci/dwc/pcie-designware-ecam.c
new file mode 100644
index 000000000000..ede627d7d08b
--- /dev/null
+++ b/drivers/pci/dwc/pcie-designware-ecam.c
@@ -0,0 +1,77 @@
+/*
+ * Driver for mostly ECAM compatible Synopsys dw PCIe controllers
+ * configured by the firmware into RC mode
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Copyright (C) 2014 ARM Limited
+ * Copyright (C) 2017 Linaro Limited
+ *
+ * Authors: Will Deacon <will.deacon@arm.com>
+ *          Ard Biesheuvel <ard.biesheuvel@linaro.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/pci-ecam.h>
+#include <linux/platform_device.h>
+
+static int pci_dw_ecam_config_read(struct pci_bus *bus, u32 devfn, int where,
+				   int size, u32 *val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+
+	/*
+	 * The Synopsys dw PCIe controller in RC mode will not filter type 0
+	 * config TLPs sent to devices 1 and up on its downstream port,
+	 * resulting in devices appearing multiple times on bus 0 unless we
+	 * filter them here.
+	 */
+	if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0) {
+		*val = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	return pci_generic_config_read(bus, devfn, where, size, val);
+}
+
+static int pci_dw_ecam_config_write(struct pci_bus *bus, u32 devfn, int where,
+				    int size, u32 val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+
+	if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return pci_generic_config_write(bus, devfn, where, size, val);
+}
+
+static struct pci_ecam_ops pci_dw_ecam_bus_ops = {
+	.pci_ops.map_bus		= pci_ecam_map_bus,
+	.pci_ops.read			= pci_dw_ecam_config_read,
+	.pci_ops.write			= pci_dw_ecam_config_write,
+	.bus_shift			= 20,
+};
+
+static const struct of_device_id pci_dw_ecam_of_match[] = {
+	{ .compatible = "marvell,armada8k-pcie-ecam" },
+	{ .compatible = "socionext,synquacer-pcie-ecam" },
+	{ .compatible = "snps,dw-pcie-ecam" },
+	{ },
+};
+
+static int pci_dw_ecam_probe(struct platform_device *pdev)
+{
+	return pci_host_common_probe(pdev, &pci_dw_ecam_bus_ops);
+}
+
+static struct platform_driver pci_dw_ecam_driver = {
+	.driver.name			= "pcie-designware-ecam",
+	.driver.of_match_table		= pci_dw_ecam_of_match,
+	.driver.suppress_bind_attrs	= true,
+	.probe				= pci_dw_ecam_probe,
+};
+builtin_platform_driver(pci_dw_ecam_driver);
-- 
2.11.0
