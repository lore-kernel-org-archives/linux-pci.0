Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:60078 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbdLYLtq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Dec 2017 06:49:46 -0500
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE# signal for OF
Date: Mon, 25 Dec 2017 19:47:41 +0800
Message-Id: <20171225114742.18920-5-jeffy.chen@rock-chips.com>
In-Reply-To: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add of_pci_setup_wake_irq() and of_pci_teardown_wake_irq() to handle
the PCIe WAKE# interrupt.

Also use the dedicated wakeirq infrastructure to simplify it.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v11:
Only support 1-per-device PCIe WAKE# pin as suggested.

Changes in v10:
Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
since dedicated wakeirq will be lost in device_set_wakeup_enable(false).

Changes in v9:
Fix check error in .cleanup().
Move dedicated wakeirq setup to setup() callback and use
device_set_wakeup_enable() to enable/disable.

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

 drivers/of/of_pci_irq.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c | 10 ++++++++++
 include/linux/of_pci.h   |  9 +++++++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index d39565d5477b..def884c1a37a 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -1,8 +1,57 @@
 #include <linux/kernel.h>
 #include <linux/of_pci.h>
 #include <linux/of_irq.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/export.h>
 
+int of_pci_setup_wake_irq(struct pci_dev *pdev)
+{
+	struct pci_dev *ppdev;
+	struct device_node *dn;
+	int ret, irq;
+
+	/* Get the pci_dev of our parent. Hopefully it's a port. */
+	ppdev = pdev->bus->self;
+	/* Nope, it's a host bridge. */
+	if (!ppdev)
+		return 0;
+
+	dn = pci_device_to_OF_node(ppdev);
+	if (!dn)
+		return 0;
+
+	irq = of_irq_get_byname(dn, "wakeup");
+	if (irq == -EPROBE_DEFER)
+		return irq;
+	/* Ignore other errors, since a missing wakeup is non-fatal. */
+	else if (irq < 0) {
+		dev_info(&pdev->dev, "cannot get wakeup interrupt: %d\n", irq);
+		return 0;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+
+	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, irq);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to set wake IRQ: %d\n", ret);
+		device_init_wakeup(&pdev->dev, false);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pci_setup_wake_irq);
+
+void of_pci_teardown_wake_irq(struct pci_dev *pdev)
+{
+	if (!pdev->dev.power.wakeirq)
+		return;
+
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+}
+EXPORT_SYMBOL_GPL(of_pci_teardown_wake_irq);
+
 /**
  * of_irq_parse_pci - Resolve the interrupt for a PCI device
  * @pdev:       the device whose interrupt is to be resolved
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d79dbc377b9c..b4475ff35d97 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/cpu.h>
+#include <linux/of_pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <linux/kexec.h>
@@ -421,10 +422,17 @@ static int pci_device_probe(struct device *dev)
 	if (error < 0)
 		return error;
 
+	error = of_pci_setup_wake_irq(pci_dev);
+	if (error < 0) {
+		pcibios_free_irq(pci_dev);
+		return error;
+	}
+
 	pci_dev_get(pci_dev);
 	if (pci_device_can_probe(pci_dev)) {
 		error = __pci_device_probe(drv, pci_dev);
 		if (error) {
+			of_pci_teardown_wake_irq(pci_dev);
 			pcibios_free_irq(pci_dev);
 			pci_dev_put(pci_dev);
 		}
@@ -438,6 +446,8 @@ static int pci_device_remove(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	of_pci_teardown_wake_irq(pci_dev);
+
 	if (drv) {
 		if (drv->remove) {
 			pm_runtime_get_sync(dev);
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index bf588a05d0d0..80fe8ae3393e 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -10,6 +10,8 @@ struct of_phandle_args;
 struct device_node;
 
 #ifdef CONFIG_OF_PCI
+int of_pci_setup_wake_irq(struct pci_dev *pdev);
+void of_pci_teardown_wake_irq(struct pci_dev *pdev);
 int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq);
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
@@ -23,6 +25,13 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
 		   const char *map_name, const char *map_mask_name,
 		   struct device_node **target, u32 *id_out);
 #else
+static inline int of_pci_setup_wake_irq(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+static void of_pci_teardown_wake_irq(struct pci_dev *pdev) { };
+
 static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
 	return 0;
-- 
2.11.0
