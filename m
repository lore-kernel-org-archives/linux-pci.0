Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58177 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934281AbcI0UMp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Sep 2016 16:12:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Lukas Wunner <lukas@wunner.de>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 3/5] pci: No config access for removed devices
Date: Tue, 27 Sep 2016 16:23:33 -0400
Message-Id: <1475007815-28354-4-git-send-email-keith.busch@intel.com>
In-Reply-To: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we've  detected that the PCI device is removed, there is no need to
access the device's config space. This patch has all the device config
reads and writes return error when in such a state.

If the device is not present on a config read, the value returned will be
set to all 1's. This is the same as what hardware is expected to return
when accessing a removed device, but software can do this faster without
relying on hardware.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 include/linux/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 36b759c..7a320ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -929,28 +929,46 @@ struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops);
 
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

