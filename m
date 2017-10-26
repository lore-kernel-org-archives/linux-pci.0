Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-pci@vger.kernel.org
Subject: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE# signal for OF
Date: Thu, 26 Oct 2017 21:28:40 +0800
Message-Id: <20171026132840.20946-8-jeffy.chen@rock-chips.com>
In-Reply-To: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add pci-of.c to handle the PCIe WAKE# interrupt.

Also use the dedicated wakeirq infrastructure to simplify it.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v8:
Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.

Changes in v7:
Move PCIE_WAKE handling into pci core.

Changes in v6:
Fix device_init_wake error handling, and add some comments.

Changes in v5:
Rebase.

Changes in v3:
Fix error handling.

Changes in v2:
Use dev_pm_set_dedicated_wake_irq.

 drivers/pci/Makefile |   2 +-
 drivers/pci/pci-of.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pci-of.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 66a21acad952..4f76dbdb024c 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -49,7 +49,7 @@ obj-$(CONFIG_PCI_ECAM) += ecam.o
 
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 
-obj-$(CONFIG_OF) += of.o
+obj-$(CONFIG_OF) += of.o pci-of.o
 
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
 
diff --git a/drivers/pci/pci-of.c b/drivers/pci/pci-of.c
new file mode 100644
index 000000000000..55a33206fc84
--- /dev/null
+++ b/drivers/pci/pci-of.c
@@ -0,0 +1,136 @@
+/*
+ * OF PCI PM support
+ *
+ * Copyright (c) 2017 Rockchip, Inc.
+ *
+ * Author: Jeffy Chen <jeffy.chen@rock-chips.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/pm_wakeirq.h>
+#include "pci.h"
+
+struct of_pci_pm_data {
+	struct device	*dev;
+	unsigned int	wakeup_irq;
+	atomic_t	wakeup_cnt;
+};
+
+static void *of_pci_setup(struct device *dev)
+{
+	struct of_pci_pm_data *data;
+	int irq;
+
+	if (!dev->of_node)
+		return NULL;
+
+	data = devm_kzalloc(dev, sizeof(struct of_pci_pm_data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	irq = of_irq_get_byname(dev->of_node, "wakeup");
+	if (irq < 0) {
+		if (irq == -EPROBE_DEFER)
+			return ERR_PTR(irq);
+
+		return NULL;
+	}
+
+	data->wakeup_irq = irq;
+	data->dev = dev;
+
+	device_init_wakeup(dev, false);
+
+	dev_info(dev, "Wakeup IRQ %d\n", irq);
+	return data;
+}
+
+static void *of_pci_setup_dev(struct pci_dev *pci_dev)
+{
+	return of_pci_setup(&pci_dev->dev);
+}
+
+static void *of_pci_setup_host_bridge(struct pci_host_bridge *bridge)
+{
+	return of_pci_setup(bridge->dev.parent);
+}
+
+static void of_pci_cleanup(void *pmdata)
+{
+	struct of_pci_pm_data *data = pmdata;
+
+	if (IS_ERR_OR_NULL(data)) {
+		device_init_wakeup(data->dev, false);
+		dev_pm_clear_wake_irq(data->dev);
+	}
+}
+
+static bool of_pci_can_wakeup(void *pmdata)
+{
+	struct of_pci_pm_data *data = pmdata;
+
+	if (IS_ERR_OR_NULL(data))
+		return false;
+
+	return data->wakeup_irq > 0;
+}
+
+static int of_pci_dev_wakeup(void *pmdata, bool enable)
+{
+	struct of_pci_pm_data *data = pmdata;
+	struct device *dev = data->dev;
+	int ret;
+
+	if (!enable) {
+		dev_pm_clear_wake_irq(dev);
+		return device_set_wakeup_enable(dev, false);
+	}
+
+	ret = device_set_wakeup_enable(dev, true);
+	if (ret < 0)
+		return ret;
+
+	ret = dev_pm_set_dedicated_wake_irq(dev, data->wakeup_irq);
+	if (ret < 0) {
+		device_set_wakeup_enable(dev, false);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int of_pci_bridge_wakeup(void *pmdata, bool enable)
+{
+	struct of_pci_pm_data *data = pmdata;
+
+	if (enable && atomic_inc_return(&data->wakeup_cnt) != 1)
+		return 0;
+
+	if (!enable && atomic_dec_return(&data->wakeup_cnt) != 0)
+		return 0;
+
+	return of_pci_dev_wakeup(pmdata, enable);
+}
+
+static const struct pci_platform_pm_ops of_pci_platform_pm = {
+	.setup_dev		= of_pci_setup_dev,
+	.setup_host_bridge	= of_pci_setup_host_bridge,
+	.cleanup		= of_pci_cleanup,
+	.can_wakeup		= of_pci_can_wakeup,
+	.dev_wakeup		= of_pci_dev_wakeup,
+	.bridge_wakeup		= of_pci_bridge_wakeup,
+};
+
+static int __init of_pci_init(void)
+{
+	pci_set_platform_pm(&of_pci_platform_pm);
+	return 0;
+}
+arch_initcall(of_pci_init);
-- 
2.11.0
