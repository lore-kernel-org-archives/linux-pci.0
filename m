Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3834B40C;
	Wed, 21 Jan 2026 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768972495; cv=none; b=nyfZvKP/Ry5BLN7dUEeNhRNnlp1i037hhnjml64En3CJ8dxQLKzicLoQhB/B88ABJRActNzxCiiO81zEWE676cNP4dT8w98k5MWzz26s9qHM+1CKnl63imxz/0nU8UF172tzUEzIn8vjIU0o9U9abh3uh+4JmH7UXuPpRFu+OzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768972495; c=relaxed/simple;
	bh=RTn8PMmdZbnnFYuw8GDyFWD3LhJPthn3FjHcohLI8NE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VbLX4Cn9M+LEZVr439PhrllEbCQVWJBwKTM4rQ8+Qu93TvdlfTqfM762JerqWjucVKNqVyBCmQ2gYOAmku5KaLbz+Bva6mnD9boPFIj2qquxXJkUVLX/axYmaD3SBann/ZHI7Ddv7H6EJ3qRLH/X2ZzMbfzXly4VRfd80AUBuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RBpCQquF; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RBpCQquF"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L0Fgh22831002;
	Tue, 20 Jan 2026 21:14:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=bVFvrI7hBT+Eb0J4FKr4gI6
	xiIKv7w+vK3Laj7su22Y=; b=RBpCQquFsskhApoiv0/kVKedoupCAjZYvtGLZaa
	CrdpnvzjFRlmjGElLluvIo9qeWn39Frx2qSNa21Aa/5wi8o3a3VyOvqrKSA05cQ8
	28XZyAr23lIEaqEiCpq+gRr+3K8r30B7hB4XaMHGIBchEl81DVwbCwxSVFmDytTR
	3/8ghC3abVDNykw/prW9DWitvw314B/R4O7/yj6CiLV4WdLV3rTD+MCdonyi5aUT
	3yNHPudnxdWP0okuw+S9u7PSz6NABA9rcxc40t/eWUTfesAHlfr0SsCdkPMZ2L9n
	kcrM5IrMwSiJeOFn9rZbP7U/7I6jD0/Jzm4bbWTMwC3vRKg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4btm3ngfxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 21:14:47 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 Jan 2026 21:15:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 20 Jan 2026 21:15:03 -0800
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 7E2B83F7083;
	Tue, 20 Jan 2026 21:14:46 -0800 (PST)
From: Pragnesh Patel <pragneshp@marvell.com>
To:
CC: <gcherian@marvell.com>, Suneel Garapati <sgarapati@marvell.com>,
        "Pragnesh
 Patel" <pragneshp@marvell.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: octeon: Add link down handler support for PCIe MAC controller
Date: Tue, 20 Jan 2026 21:14:29 -0800
Message-ID: <20260121051439.1882086-1-pragneshp@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MCh5woMg648d5KwNcsMkIa60f4XpVFCR
X-Proofpoint-ORIG-GUID: MCh5woMg648d5KwNcsMkIa60f4XpVFCR
X-Authority-Analysis: v=2.4 cv=ZcUQ98VA c=1 sm=1 tr=0 ts=697060c7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8
 a=Q1g5pn1pL30H-8oL7iwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA0MCBTYWx0ZWRfXw+2xTl/krazb
 fghcNcbJEFHALsbFq/bweVPW33uSy/YSXNA5TM5xtF8JFQZMZ3pP/uCQEM4PMUhZqDta2YEJFcK
 YVAL+uGn7SF2pdCf7MZSDswkdFAp8KAEH7JlksjvHaMQwkdZknPILLKEIuIB8Bt+ZesX5xMxe0e
 BsCz3WPGjEchTxSc/easj1pKRKWVnAemOjmnWj70Pl224ycI2kcXT3zg6xBejU/6maZXVYqJt+0
 xNO+FUbXYk+0T0pOfTF41s3BxFpykx5eA0qomRN0wP+p/w+FcsDgH+huo5W6JJndEOHqukfMG6j
 0DyxZ4t44FdsNkH52KLDMkvdsfnIogToCcyoL7rj4a7PxheSEBxK8hMigmAj3+fDJU04z2aBKRF
 uxHn0iZapn8sOsNsUS6jK7hDzZQQ1Fm3fgkCVKkSZsDm7VbRvhdVI+ZheZ1XGjTk21lUL/7FLZN
 ZcMbrJsauaIEc5kPUjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01

From: Suneel Garapati <sgarapati@marvell.com>

This driver adds support for link-down interrupt in PCIe MAC (PEM)
controller in Root complex mode to support hot-plug removal of
endpoint devices.

An interrupt handler is registered for RST_INT msix vector
which is triggered with link going down. This handler
performs cleanup of root bridge and its children and
re-initializes root bridge to kernel for next link-up event.

Signed-off-by: Suneel Garapati <sgarapati@marvell.com>
Signed-off-by: Pragnesh Patel <pragneshp@marvell.com>
---
 MAINTAINERS                             |   6 +
 drivers/pci/controller/Kconfig          |   9 +
 drivers/pci/controller/Makefile         |   1 +
 drivers/pci/controller/pci-octeon-pem.c | 278 ++++++++++++++++++++++++
 4 files changed, 294 insertions(+)
 create mode 100644 drivers/pci/controller/pci-octeon-pem.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f1b020588597..9af8f676c027 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15363,6 +15363,12 @@ R:	Vamsi Attunuru <vattunuru@marvell.com>
 S:	Supported
 F:	drivers/pci/hotplug/octep_hp.c
 
+MARVELL OCTEON PEM CONTROLLER DRIVER
+R:	George Cherian <gcherian@marvell.com>
+R:	Pragnesh Patel <pragneshp@marvell.com>
+S:	Supported
+F:	drivers/pci/controller/pci-octeon-pem.c
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index c254d2b8bf17..5251dc8b1188 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -231,6 +231,15 @@ config PCI_HYPERV_INTERFACE
 	  drivers to have a common interface with the Hyper-V PCI frontend
 	  driver.
 
+config PCI_OCTEON_PEM
+	bool "Marvell Octeon PEM (PCIe MAC) controller"
+	depends on ARM64 || COMPILE_TEST
+	depends on PCI_MSI
+	depends on HOTPLUG_PCI_PCIE
+	help
+	  Say Y here if you want PEM controller support for Marvell ARM64 Octeon SoCs
+	  in root complex mode.
+
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 229929a945c2..dd1dab50dd07 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PCI_V3_SEMI) += pci-v3-semi.o
 obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
 obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
+obj-$(CONFIG_PCI_OCTEON_PEM) += pci-octeon-pem.o
 obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
 obj-$(CONFIG_PCIE_IPROC_MSI) += pcie-iproc-msi.o
 obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
diff --git a/drivers/pci/controller/pci-octeon-pem.c b/drivers/pci/controller/pci-octeon-pem.c
new file mode 100644
index 000000000000..2d67e2b16e9e
--- /dev/null
+++ b/drivers/pci/controller/pci-octeon-pem.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Octeon PEM driver
+ *
+ * Copyright (C) 2021 Marvell.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/sysfs.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "../hotplug/pciehp.h"
+#include "../pci.h"
+
+#define DRV_NAME	"octeon-pem"
+#define DRV_VERSION	"1.0"
+
+#define PCI_DEVID_OCTEON_PEM	0xA06C
+
+#define ID_SHIFT		36
+#define DOMAIN_OFFSET		0x3
+#define ON_OFFSET		0xE0
+#define RST_SOFT_PERST_OFFSET	0x298
+#define RST_INT_OFFSET		0x300
+#define RST_INT_ENA_W1C_OFFSET	0x310
+#define RST_INT_ENA_W1S_OFFSET	0x318
+#define RST_INT_LINKDOWN	BIT(1)
+
+struct pem_ctlr {
+	int			index;
+	char			irq_name[32];
+	void __iomem		*base;
+	struct pci_dev		*pdev;
+	struct work_struct	recover_rc_work;
+};
+
+static struct pcie_device *to_pciehp_dev(struct pci_dev *dev)
+{
+	struct device *device;
+
+	device = pcie_port_find_device(dev, PCIE_PORT_SERVICE_HP);
+	if (!device)
+		return NULL;
+	return to_pcie_device(device);
+}
+
+static void pem_recover_rc_link(struct work_struct *ws)
+{
+	struct pem_ctlr *pem = container_of(ws, struct pem_ctlr,
+					    recover_rc_work);
+	struct pci_dev *pem_dev = pem->pdev;
+	struct pci_dev *root_port;
+	struct pci_bus *bus;
+	struct pcie_device *pcie;
+	struct controller *ctrl;
+	int rc_domain, timeout = 100;
+	u64 pem_reg;
+
+	rc_domain = pem->index + DOMAIN_OFFSET;
+
+	root_port = pci_get_domain_bus_and_slot(rc_domain, 0, 0);
+	if (!root_port) {
+		dev_err(&pem_dev->dev, "failed to get root port\n");
+		return;
+	}
+
+	dev_dbg(&pem_dev->dev, "PEM%d rcvr work\n", pem->index);
+
+	/* Check if HP interrupt thread is in progress
+	 * and wait for it to complete
+	 */
+	pcie = to_pciehp_dev(root_port);
+	if (!pcie)
+		return;
+	ctrl = get_service_data(pcie);
+	wait_event(ctrl->requester,
+		   !atomic_read(&ctrl->pending_events) &&
+		   !ctrl->ist_running);
+	dev_dbg(&pem_dev->dev, "PEM%d HP ist done\n", pem->index);
+
+	/* Disable hot-plug interrupt
+	 * Removal and rescan below would setup again.
+	 */
+	pcie_disable_interrupt(ctrl);
+	dev_dbg(&pem_dev->dev, "PEM%d Disable interrupt\n", pem->index);
+
+	pci_lock_rescan_remove();
+
+	pci_walk_bus(root_port->subordinate, pci_dev_set_disconnected, NULL);
+
+	/* Clean-up device and RC bridge */
+	pci_stop_and_remove_bus_device(root_port);
+
+	pci_unlock_rescan_remove();
+
+	usleep_range(100, 200);
+
+	writeq(0x0, pem->base + RST_SOFT_PERST_OFFSET);
+
+	while (timeout--) {
+		/* Check for PEM_OOR to be set */
+		pem_reg = readq(pem->base + ON_OFFSET);
+		if (pem_reg & BIT(1))
+			break;
+		usleep_range(1000, 2000);
+	}
+	if (!timeout) {
+		dev_warn(&pem_dev->dev,
+			 "PEM failed to get out of reset\n");
+		return;
+	}
+
+	pci_lock_rescan_remove();
+
+	/*
+	 * Hardware resets and initializes config space of RC bridge
+	 * on every link down event with auto-mode in use.
+	 * Re-scan will setup RC bridge cleanly in kernel
+	 * after removal and to be ready for next link-up event.
+	 */
+	bus = NULL;
+	while ((bus = pci_find_next_bus(bus)) != NULL)
+		if (bus->domain_nr == rc_domain)
+			pci_rescan_bus(bus);
+	pci_unlock_rescan_remove();
+	pci_dev_put(root_port);
+
+	/* Ack interrupt */
+	writeq(RST_INT_LINKDOWN, pem->base + RST_INT_OFFSET);
+	/* Enable RST_INT[LINKDOWN] interrupt */
+	writeq(RST_INT_LINKDOWN, pem->base + RST_INT_ENA_W1S_OFFSET);
+}
+
+static irqreturn_t pem_irq_handler(int irq, void *dev_id)
+{
+	struct pem_ctlr *pem = (struct pem_ctlr *)dev_id;
+
+	/* Disable RST_INT[LINKDOWN] interrupt */
+	writeq(RST_INT_LINKDOWN, pem->base + RST_INT_ENA_W1C_OFFSET);
+	schedule_work(&pem->recover_rc_work);
+
+	return IRQ_HANDLED;
+}
+
+static int pem_register_interrupts(struct pci_dev *pdev)
+{
+	struct pem_ctlr *pem = pci_get_drvdata(pdev);
+	int nvec, err;
+
+	nvec = pci_msix_vec_count(pdev);
+	/* Some earlier silicon versions do not support RST vector
+	 * so check on table size before registering otherwise
+	 * return with info message.
+	 */
+	if (nvec != 10) {
+		dev_info(&pdev->dev,
+			 "No RST MSI-X vector support on silicon\n");
+		return 0;
+	}
+	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
+	if (err < 0) {
+		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed %d\n",
+			nvec);
+		return -ENOSPC;
+	}
+
+	snprintf(pem->irq_name, 32, "PEM%d RST_INT", pem->index);
+
+	/* register interrupt for RST_INT */
+	return devm_request_irq(&pdev->dev, pci_irq_vector(pdev, 9),
+				pem_irq_handler, 0,
+				pem->irq_name, pem);
+}
+
+static int pem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct pem_ctlr *pem;
+	struct pci_dev *root_port;
+	int err, rc_domain;
+
+	pem = devm_kzalloc(dev, sizeof(struct pem_ctlr), GFP_KERNEL);
+	if (!pem)
+		return -ENOMEM;
+
+	pem->pdev = pdev;
+	pci_set_drvdata(pdev, pem);
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		goto enable_failed;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
+		goto region_failed;
+	}
+
+	pci_set_master(pdev);
+
+	/* CSR Space mapping */
+	pem->base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
+	if (!pem->base) {
+		dev_err(&pdev->dev, "Unable to map BAR0\n");
+		err = -ENODEV;
+		goto bar0_map_failed;
+	}
+	pem->index = ((u64)pci_resource_start(pdev, 0) >> ID_SHIFT) & 0xf;
+
+	rc_domain = pem->index + DOMAIN_OFFSET;
+
+	root_port = pci_get_domain_bus_and_slot(rc_domain, 0, 0);
+	if (!root_port) {
+		dev_err(&pdev->dev, "failed to get root port\n");
+		goto bar0_map_failed;
+	}
+	if (!root_port->is_hotplug_bridge) {
+		dev_info(&pdev->dev, "Hot-plug disabled skip registration\n");
+		goto bar0_map_failed;
+	}
+
+	err = pem_register_interrupts(pdev);
+	if (err < 0) {
+		dev_err(dev, "Register interrupt failed\n");
+		goto irq_failed;
+	}
+
+	INIT_WORK(&pem->recover_rc_work, pem_recover_rc_link);
+
+	/* Enable RST_INT[LINKDOWN] interrupt */
+	writeq(RST_INT_LINKDOWN, pem->base + RST_INT_ENA_W1S_OFFSET);
+
+	dev_info(&pdev->dev, "PEM%d probed\n", pem->index);
+	return 0;
+
+irq_failed:
+bar0_map_failed:
+	pci_release_regions(pdev);
+region_failed:
+enable_failed:
+	pci_set_drvdata(pdev, NULL);
+	return err;
+}
+
+static void pem_remove(struct pci_dev *pdev)
+{
+	pci_release_regions(pdev);
+}
+
+/* Supported devices */
+static const struct pci_device_id pem_id_table[] = {
+	{PCI_VDEVICE(CAVIUM, PCI_DEVID_OCTEON_PEM)},
+	{0} /* end of table */
+};
+
+static struct pci_driver pem_driver = {
+	.name = DRV_NAME,
+	.id_table = pem_id_table,
+	.probe = pem_probe,
+	.remove = pem_remove,
+};
+
+module_pci_driver(pem_driver);
+
+MODULE_AUTHOR("Marvell Inc.");
+MODULE_DESCRIPTION("Marvell Octeon PEM Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+MODULE_DEVICE_TABLE(pci, pem_id_table);
-- 
2.43.0

