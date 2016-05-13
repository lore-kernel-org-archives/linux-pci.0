Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:45896 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbcEMLQs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:16:48 -0400
Message-Id: <f7fa3cf94bbf7f04e97aecbb65255ce65afc2631.1463134231.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 05/13] PCI: Use portdrv pm iterator on further callbacks
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We already allow service drivers to declare ->suspend and ->resume
callbacks which get called one by one when the port is suspended or
resumed.

Allow the same for ->prepare, ->complete, ->resume_noirq,
->runtime_suspend and ->runtime_resume.

Call pcie_port_resume_noirq() also on ->restore_noirq.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/portdrv_pci.c | 29 ++++++++++++++++++++++++++---
 include/linux/pcieport_if.h    |  5 +++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index acbd1d2..f75d4b5 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -104,6 +104,18 @@ static int generic_iter(struct device *dev, void *data)
  * The return value is 0 if all port services' callbacks returned 0, otherwise
  * it is the return value of the last callback executed.
  */
+static int pcie_port_prepare(struct device *dev)
+{
+	size_t o = offsetof(struct pcie_port_service_driver, prepare);
+	return device_for_each_child(dev, &o, generic_iter);
+}
+
+static void pcie_port_complete(struct device *dev)
+{
+	size_t o = offsetof(struct pcie_port_service_driver, complete);
+	device_for_each_child(dev, &o, generic_iter);
+}
+
 static int pcie_port_suspend(struct device *dev)
 {
 	size_t o = offsetof(struct pcie_port_service_driver, suspend);
@@ -118,6 +130,7 @@ static int pcie_port_resume(struct device *dev)
 
 static int pcie_port_resume_noirq(struct device *dev)
 {
+	size_t o = offsetof(struct pcie_port_service_driver, resume_noirq);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
 	/*
@@ -127,17 +140,24 @@ static int pcie_port_resume_noirq(struct device *dev)
 	 */
 	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
 		pcie_clear_root_pme_status(pdev);
-	return 0;
+
+	return device_for_each_child(dev, &o, generic_iter);
 }
 
 static int pcie_port_runtime_suspend(struct device *dev)
 {
-	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
+	size_t o = offsetof(struct pcie_port_service_driver, runtime_suspend);
+
+	if (!to_pci_dev(dev)->bridge_d3)
+		return -EBUSY;
+
+	return device_for_each_child(dev, &o, generic_iter);
 }
 
 static int pcie_port_runtime_resume(struct device *dev)
 {
-	return 0;
+	size_t o = offsetof(struct pcie_port_service_driver, runtime_resume);
+	return device_for_each_child(dev, &o, generic_iter);
 }
 
 static int pcie_port_runtime_idle(struct device *dev)
@@ -151,6 +171,8 @@ static int pcie_port_runtime_idle(struct device *dev)
 }
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
+	.prepare	= pcie_port_prepare,
+	.complete	= pcie_port_complete,
 	.suspend	= pcie_port_suspend,
 	.resume		= pcie_port_resume,
 	.freeze		= pcie_port_suspend,
@@ -158,6 +180,7 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 	.poweroff	= pcie_port_suspend,
 	.restore	= pcie_port_resume,
 	.resume_noirq	= pcie_port_resume_noirq,
+	.restore_noirq	= pcie_port_resume_noirq,
 	.runtime_suspend = pcie_port_runtime_suspend,
 	.runtime_resume	= pcie_port_runtime_resume,
 	.runtime_idle	= pcie_port_runtime_idle,
diff --git a/include/linux/pcieport_if.h b/include/linux/pcieport_if.h
index d205bd6..092517d 100644
--- a/include/linux/pcieport_if.h
+++ b/include/linux/pcieport_if.h
@@ -49,8 +49,13 @@ struct pcie_port_service_driver {
 	const char *name;
 	int (*probe) (struct pcie_device *dev);
 	void (*remove) (struct pcie_device *dev);
+	int (*prepare) (struct pcie_device *dev);
+	int (*complete) (struct pcie_device *dev);
 	int (*suspend) (struct pcie_device *dev);
 	int (*resume) (struct pcie_device *dev);
+	int (*resume_noirq) (struct pcie_device *dev);
+	int (*runtime_suspend) (struct pcie_device *dev);
+	int (*runtime_resume) (struct pcie_device *dev);
 
 	/* Service Error Recovery Handler */
 	const struct pci_error_handlers *err_handler;
-- 
2.8.1

