Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36622 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeHQRlj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2018 13:41:39 -0400
Received: by mail-qk0-f194.google.com with SMTP id 93-v6so5042811qks.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2018 07:38:02 -0700 (PDT)
From: Hari Vyas <hari.vyas@broadcom.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>
Subject: [PATCH] PCI: fix of read-write config operation in SMP environment
Date: Fri, 17 Aug 2018 20:07:48 +0530
Message-Id: <1534516668-1206-1-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Read modify write operations performed on same pci configuration
registers which have bit fields may not work properly in SMP
environment. Let us assume one thread tries to set master bit
and other thread memory bit of PCI_COMMAND register, result may
be unpredictable.

Better we introduce a new routine in struct pci_ops like
(int (*modify_safe)(struct pci_bus *bus, unsigned int devfn,
int where, int size, u32 old, u32 new);
This routine may first read current value and apply diff.

Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
---
 drivers/pci/access.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c       |  1 +
 drivers/pci/setup-res.c |  2 +-
 include/linux/pci.h     |  4 ++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index a3ad2fe..c4cf99b 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -588,3 +588,64 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
 	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
 }
 EXPORT_SYMBOL(pci_write_config_dword);
+
+#define PCI_OP_MODIFY(size, type, len) \
+int pci_bus_modify_config_##size \
+	(struct pci_bus *bus, unsigned int devfn, int pos, 		\
+	 type rval, type wval)						\
+{									\
+	int res;							\
+	unsigned long flags;						\
+	u32 rdata = 0;							\
+	u32 wdata = 0;							\
+	u32 temp_data = 0;						\
+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	pci_lock_config(flags);						\
+	if (bus->ops->modify) {						\
+		res = bus->ops->modify(bus, devfn, pos, len,		\
+				       rval, wval);			\
+	} else {							\
+		temp_data = rval ^ wval;				\
+		res = bus->ops->read(bus, devfn, pos, len, &rdata);	\
+		wdata = rdata ^ temp_data;				\
+		res = bus->ops->write(bus, devfn, pos, len, wdata);	\
+	}								\
+	pci_unlock_config(flags);					\
+	return res;							\
+}
+
+PCI_OP_MODIFY(byte, u8, 1)
+PCI_OP_MODIFY(word, u16, 2)
+PCI_OP_MODIFY(dword, u32, 4)
+int pci_modify_config_byte(const struct pci_dev *dev, int where,
+			   u8 rval, u8 wval)
+{
+	if (pci_dev_is_disconnected(dev)) {
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	return pci_bus_modify_config_byte(dev->bus, dev->devfn, where,
+					  rval, wval);
+}
+EXPORT_SYMBOL(pci_modify_config_byte);
+
+int pci_modify_config_word(const struct pci_dev *dev, int where,
+			   u16 rval, u16 wval)
+{
+	if (pci_dev_is_disconnected(dev)) {
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	return pci_bus_modify_config_word(dev->bus, dev->devfn, where,
+					  rval, wval);
+}
+EXPORT_SYMBOL(pci_modify_config_word);
+
+int pci_modify_config_dword(const struct pci_dev *dev, int where,
+			    u32 rval, u32 wval)
+{
+	if (pci_dev_is_disconnected(dev)) {
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	return pci_bus_modify_config_dword(dev->bus, dev->devfn, where,
+					   rval, wval);
+}
+EXPORT_SYMBOL(pci_modify_config_dword);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 316496e..db1c132 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3712,6 +3712,7 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
 		pci_dbg(dev, "%s bus mastering\n",
 			enable ? "enabling" : "disabling");
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		pci_modify_config_word(dev, PCI_COMMAND, old_cmd, cmd);
 	}
 	dev->is_busmaster = enable;
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d8ca40a..a2e6fa4 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -493,7 +493,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 
 	if (cmd != old_cmd) {
 		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		pci_modify_config_word(dev, PCI_COMMAND, old_cmd, cmd);
 	}
 	return 0;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c133ccf..d948c4b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -664,6 +664,7 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*modify)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 rval, u32 wval);
 };
 
 /*
@@ -991,6 +992,9 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
 int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val);
 int pci_write_config_word(const struct pci_dev *dev, int where, u16 val);
 int pci_write_config_dword(const struct pci_dev *dev, int where, u32 val);
+int pci_modify_config_byte(const struct pci_dev *dev, int where, u8 rval, u8 wval);
+int pci_modify_config_word(const struct pci_dev *dev, int where, u16 rval, u16 wval);
+int pci_modify_config_dword(const struct pci_dev *dev, int where, u32 rval, u32 wval);
 
 int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
 int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
-- 
1.9.1
