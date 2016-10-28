Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46396 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755983AbcJ1Wri (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Oct 2016 18:47:38 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 next 2/3] pci: No config access for removed devices
Date: Fri, 28 Oct 2016 18:58:16 -0400
Message-Id: <1477695497-6207-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we've  detected that the PCI device is removed, there is no need to
access the device's config space. This patch has all the device config
reads and writes return error when in such a state.

If the device is not present on a config read, the value returned will be
set to all 1's. This is the same as what hardware is expected to return
when accessing a removed device, but software can do this faster without
relying on hardware.

When checking if a device is present, we short-cut the removal by
returning the known state instead of querying the bus.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c   |  2 ++
 include/linux/pci.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ba34907..c412095 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4966,6 +4966,8 @@ bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
 
+	if (pdev->is_removed)
+		return false;
 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
 }
 EXPORT_SYMBOL_GPL(pci_device_is_present);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2115d19..a92eedb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -936,28 +936,46 @@ struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops);
 
 static inline int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
+	if (unlikely(dev->is_removed)) {
+		*val = ~0;
+		return -ENODEV;
+	}
 	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
 }
 static inline int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
+	if (unlikely(dev->is_removed)) {
+		*val = ~0;
+		return -ENODEV;
+	}
 	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
 }
 static inline int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
+	if (unlikely(dev->is_removed)) {
+		*val = ~0;
+		return -ENODEV;
+	}
 	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
 }
 static inline int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
 {
+	if (unlikely(dev->is_removed))
+		return -ENODEV;
 	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
 }
 static inline int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
 {
+	if (unlikely(dev->is_removed))
+		return -ENODEV;
 	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
 }
 static inline int pci_write_config_dword(const struct pci_dev *dev, int where,
 					 u32 val)
 {
+	if (unlikely(dev->is_removed))
+		return -ENODEV;
 	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
 }
 
-- 
2.7.2

