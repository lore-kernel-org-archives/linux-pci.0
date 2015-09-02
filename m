Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:40388 "EHLO
	mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbbIBH2N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2015 03:28:13 -0400
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 51E1BAC00FD
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2015 16:28:10 +0900 (JST)
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Subject: [PATCH v2] PCI/AER: Cleanup AER error status registers on probing/restoring devices
Date: Thu,  3 Sep 2015 01:30:51 +0900
Message-Id: <1441211451-14319-1-git-send-email-izumi.taku@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AER uncorrectable or correctable error might be recorded
when power on devices. These errors can be ignored, so
BIOS usually cleans up these registers ahead of OS's scanning
devices.
However, in case of hot-plug PCIe devices, BIOS can't care.
Currently OS don't clean up AER error status registers on probing
devices, ignorable AER errors recorded when power-on remains.
This causes false-positive.
The same is true of during-resume-from-suspend.

This patch address this problem by cleaning up AER error status
registers on probing devices and on restoring devices.

v1 -> v2:
 - delete unnecessary EXPORT_SYMBOL_GPL
 - add pci_is_pcie() check to pci_cleanup_aer_error_status_regs()
 - cleanup AER error status register at pci_restore_state()

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/pci/pci.c                  |  4 ++++
 drivers/pci/pcie/aer/aerdrv_core.c | 28 ++++++++++++++++++++++++++++
 drivers/pci/probe.c                |  4 ++++
 include/linux/aer.h                |  5 +++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cc76238..a1bc255 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -27,6 +27,7 @@
 #include <linux/pci_hotplug.h>
 #include <asm-generic/pci-bridge.h>
 #include <asm/setup.h>
+#include <linux/aer.h>
 #include "pci.h"
 
 const char *pci_power_names[] = {
@@ -1085,6 +1086,9 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_ats_state(dev);
 	pci_restore_vc_state(dev);
 
+	/* Cleanup AER error status registerts */
+	pci_cleanup_aer_error_status_regs(dev);
+
 	pci_restore_config_space(dev);
 
 	pci_restore_pcix_state(dev);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 9803e3d..fba785e 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -74,6 +74,34 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
 
+int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+{
+	int pos;
+	u32 status;
+	int port_type;
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return -EIO;
+
+	port_type = pci_pcie_type(dev);
+	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
+		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, status);
+	}
+
+	pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &status);
+	pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS, status);
+
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+
+	return 0;
+}
+
 /**
  * add_error_device - list device to be handled
  * @e_info: pointer to error info
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d2e36bb..80c5429 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/pci-aspm.h>
+#include <linux/aer.h>
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
@@ -1587,6 +1588,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	/* Enable ACS P2P upstream forwarding */
 	pci_enable_acs(dev);
+
+	/* Cleanup AER error status registerts */
+	pci_cleanup_aer_error_status_regs(dev);
 }
 
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4fef65e..744b997 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -42,6 +42,7 @@ struct aer_capability_regs {
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
+int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
 #else
 static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
@@ -55,6 +56,10 @@ static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 void cper_print_aer(struct pci_dev *dev, int cper_severity,
-- 
1.8.3.1

