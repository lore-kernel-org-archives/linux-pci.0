Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9915 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754509AbdBGTX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 14:23:58 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv6 1/5] pci: Export pci device config accessors
Date: Tue,  7 Feb 2017 14:32:33 -0500
Message-Id: <1486495957-26177-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
References: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch replaces the inline pci device config read and write accessors
with exported functions. This is preparing for these functions to make
use of private data.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/access.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  | 32 ++++++--------------------------
 2 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index db23954..d37b2ed 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -889,3 +889,41 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 	return ret;
 }
 EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
+
+int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
+{
+	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
+}
+EXPORT_SYMBOL(pci_read_config_byte);
+
+int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
+{
+	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
+}
+EXPORT_SYMBOL(pci_read_config_word);
+
+int pci_read_config_dword(const struct pci_dev *dev, int where,
+					u32 *val)
+{
+	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
+}
+EXPORT_SYMBOL(pci_read_config_dword);
+
+int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
+{
+	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
+}
+EXPORT_SYMBOL(pci_write_config_byte);
+
+int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
+{
+	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
+}
+EXPORT_SYMBOL(pci_write_config_word);
+
+int pci_write_config_dword(const struct pci_dev *dev, int where,
+					 u32 val)
+{
+	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
+}
+EXPORT_SYMBOL(pci_write_config_dword);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a12..b00a2d3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -944,32 +944,12 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
 
 struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops);
 
-static inline int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
-{
-	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
-}
-static inline int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
-{
-	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
-}
-static inline int pci_read_config_dword(const struct pci_dev *dev, int where,
-					u32 *val)
-{
-	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
-}
-static inline int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
-{
-	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
-}
-static inline int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
-{
-	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
-}
-static inline int pci_write_config_dword(const struct pci_dev *dev, int where,
-					 u32 val)
-{
-	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
-}
+int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val);
+int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val);
+int pci_read_config_dword(const struct pci_dev *dev, int where, u32 *val);
+int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val);
+int pci_write_config_word(const struct pci_dev *dev, int where, u16 val);
+int pci_write_config_dword(const struct pci_dev *dev, int where, u32 val);
 
 int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
 int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
-- 
2.7.2
