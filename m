Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65205 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933490AbcIFWA0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 18:00:26 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 2/4] pci: No config access for removed devices
Date: Tue,  6 Sep 2016 16:00:17 -0600
Message-Id: <1473199219-3369-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
References: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we've  detected that the PCI device is removed, do not attempt to
access the device's config space.

On a config read, if the device is not present, the value returned will be
set to all 1's. This is the same as what hardware would normally return
when accessing a removed device, but we do not need to repeatedly test
hardware's completion capabilities if software can take a short-cut.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 include/linux/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 865d3ec..1b62f7a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -932,28 +932,46 @@ struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops);
 
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

