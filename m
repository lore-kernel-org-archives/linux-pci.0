Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38233 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbbLVBxu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2015 20:53:50 -0500
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] PCI: generic: Refactor code to enable reuse by other drivers.
Date: Mon, 21 Dec 2015 17:53:41 -0800
Message-Id: <1450749222-15966-2-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1450749222-15966-1-git-send-email-ddaney.cavm@gmail.com>
References: <1450749222-15966-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

No change in functionality.

Move structure definitions into a separate header file.  Split probe
function in to two parts:

   - a small driver specific probe function (gen_pci_probe)

   - a common probe that can be used by other drivers
     (gen_pci_common_probe)

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/host/pci-host-generic.c | 53 ++++++++++++-----------------------
 drivers/pci/host/pci-host-generic.h | 56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 35 deletions(-)
 create mode 100644 drivers/pci/host/pci-host-generic.h

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 5434c90..e83cec7 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -25,33 +25,7 @@
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
 
-struct gen_pci_cfg_bus_ops {
-	u32 bus_shift;
-	struct pci_ops ops;
-};
-
-struct gen_pci_cfg_windows {
-	struct resource				res;
-	struct resource				*bus_range;
-	void __iomem				**win;
-
-	struct gen_pci_cfg_bus_ops		*ops;
-};
-
-/*
- * ARM pcibios functions expect the ARM struct pci_sys_data as the PCI
- * sysdata.  Add pci_sys_data as the first element in struct gen_pci so
- * that when we use a gen_pci pointer as sysdata, it is also a pointer to
- * a struct pci_sys_data.
- */
-struct gen_pci {
-#ifdef CONFIG_ARM
-	struct pci_sys_data			sys;
-#endif
-	struct pci_host_bridge			host;
-	struct gen_pci_cfg_windows		cfg;
-	struct list_head			resources;
-};
+#include "pci-host-generic.h"
 
 static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
 					     unsigned int devfn,
@@ -208,19 +182,15 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
 	return 0;
 }
 
-static int gen_pci_probe(struct platform_device *pdev)
+int gen_pci_common_probe(struct platform_device *pdev,
+			 struct gen_pci *pci)
 {
 	int err;
 	const char *type;
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
 	struct pci_bus *bus, *child;
 
-	if (!pci)
-		return -ENOMEM;
-
 	type = of_get_property(np, "device_type", NULL);
 	if (!type || strcmp(type, "pci")) {
 		dev_err(dev, "invalid \"device_type\" %s\n", type);
@@ -229,8 +199,6 @@ static int gen_pci_probe(struct platform_device *pdev)
 
 	of_pci_check_probe_only();
 
-	of_id = of_match_node(gen_pci_of_match, np);
-	pci->cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
 	pci->host.dev.parent = dev;
 	INIT_LIST_HEAD(&pci->host.windows);
 	INIT_LIST_HEAD(&pci->resources);
@@ -273,6 +241,21 @@ static int gen_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int gen_pci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id;
+	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+
+	if (!pci)
+		return -ENOMEM;
+
+	of_id = of_match_node(gen_pci_of_match, dev->of_node);
+	pci->cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
+
+	return gen_pci_common_probe(pdev, pci);
+}
+
 static struct platform_driver gen_pci_driver = {
 	.driver = {
 		.name = "pci-host-generic",
diff --git a/drivers/pci/host/pci-host-generic.h b/drivers/pci/host/pci-host-generic.h
new file mode 100644
index 0000000..089fecb
--- /dev/null
+++ b/drivers/pci/host/pci-host-generic.h
@@ -0,0 +1,56 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (C) 2014 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#ifndef _PCI_HOST_GENERIC_H
+#define _PCI_HOST_GENERIC_H
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+struct gen_pci_cfg_bus_ops {
+	u32 bus_shift;
+	struct pci_ops ops;
+};
+
+struct gen_pci_cfg_windows {
+	struct resource				res;
+	struct resource				*bus_range;
+	void __iomem				**win;
+
+	struct gen_pci_cfg_bus_ops		*ops;
+};
+
+/*
+ * ARM pcibios functions expect the ARM struct pci_sys_data as the PCI
+ * sysdata.  Add pci_sys_data as the first element in struct gen_pci so
+ * that when we use a gen_pci pointer as sysdata, it is also a pointer to
+ * a struct pci_sys_data.
+ */
+struct gen_pci {
+#ifdef CONFIG_ARM
+	struct pci_sys_data			sys;
+#endif
+	struct pci_host_bridge			host;
+	struct gen_pci_cfg_windows		cfg;
+	struct list_head			resources;
+};
+
+int gen_pci_common_probe(struct platform_device *pdev,
+			 struct gen_pci *pci);
+
+#endif /* _PCI_HOST_GENERIC_H */
-- 
1.8.3.1

