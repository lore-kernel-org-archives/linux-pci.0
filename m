Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:55976 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcFAMcW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 08:32:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
Date: Wed,  1 Jun 2016 14:31:22 +0200
Message-Id: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A lot of PCI host bridges require different methods for initiating
type 0 and type 1 config space accesses, leading to duplication of
code.

This adds support for the two different kinds at the pci_ops
level, with the newly added map_bridge/read_bridge/write_bridge
operations for type 1 accesses.

When these are not set, we fall back to the regular map_bus/read/write
operations, so all existing drivers keep working, and bridges that
have identical operations continue to only require one set.

In most cases, a driver will only have to override either map_bridge
or read_bridge/write_bridge but not both.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is slightly refined over what I had in the "Add PCIe driver for
Rockchip Soc" thread earlier, but probably not the final version yet,
so I'd like to get more feedback on it.

In particular, I think it may be useful to add a third set of
functions for the config space of devices that are directly attached
to the host bridge, as those are sometimes (designware, rcar, mvebu)
yet again different from the host bridge itself and from all other
devices. On the other hand, that adds further complexity that we
may want to leave out of the common code, and I honestly can't
seem to come up for a catchy name form the callbacks.

 drivers/pci/access.c | 35 +++++++++++++++++++++++++++--------
 include/linux/pci.h  |  3 +++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index d11cdbb8fba3..263606ece211 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -34,9 +34,12 @@ int pci_bus_read_config_##size \
 	u32 data = 0;							\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	raw_spin_lock_irqsave(&pci_lock, flags);			\
-	res = bus->ops->read(bus, devfn, pos, len, &data);		\
+	if (!bus->parent == 0 && bus->ops->read_bridge)			\
+		res = bus->ops->read_bridge(bus, devfn, pos, len, &data);	\
+	else								\
+		res = bus->ops->read(bus, devfn, pos, len, &data);	\
 	*value = (type)data;						\
-	raw_spin_unlock_irqrestore(&pci_lock, flags);		\
+	raw_spin_unlock_irqrestore(&pci_lock, flags);			\
 	return res;							\
 }
 
@@ -48,8 +51,11 @@ int pci_bus_write_config_##size \
 	unsigned long flags;						\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	raw_spin_lock_irqsave(&pci_lock, flags);			\
-	res = bus->ops->write(bus, devfn, pos, len, value);		\
-	raw_spin_unlock_irqrestore(&pci_lock, flags);		\
+	if (!bus->parent && bus->ops->write_bridge)			\
+		res = bus->ops->write_bridge(bus, devfn, pos, len, value);\
+	else								\
+		res = bus->ops->write(bus, devfn, pos, len, value);	\
+	raw_spin_unlock_irqrestore(&pci_lock, flags);			\
 	return res;							\
 }
 
@@ -72,7 +78,11 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 {
 	void __iomem *addr;
 
-	addr = bus->ops->map_bus(bus, devfn, where);
+	if (!bus->parent && bus->ops->map_bridge)
+		addr = bus->ops->map_bridge(bus, devfn, where);
+	else
+		addr = bus->ops->map_bus(bus, devfn, where);
+
 	if (!addr) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -94,7 +104,10 @@ int pci_generic_config_write(struct pci_bus *bus, unsigned int devfn,
 {
 	void __iomem *addr;
 
-	addr = bus->ops->map_bus(bus, devfn, where);
+	if (!bus->parent && bus->ops->map_bridge)
+		addr = bus->ops->map_bridge(bus, devfn, where);
+	else
+		addr = bus->ops->map_bus(bus, devfn, where);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -114,7 +127,10 @@ int pci_generic_config_read32(struct pci_bus *bus, unsigned int devfn,
 {
 	void __iomem *addr;
 
-	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
+	if (!bus->parent && bus->ops->map_bridge)
+		addr = bus->ops->map_bridge(bus, devfn, where);
+	else
+		addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
 	if (!addr) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -135,7 +151,10 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
 	void __iomem *addr;
 	u32 mask, tmp;
 
-	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
+	if (!bus->parent && bus->ops->map_bridge)
+		addr = bus->ops->map_bridge(bus, devfn, where);
+	else
+		addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index df41c4645911..2b1d08771b36 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -580,6 +580,9 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	void __iomem *(*map_bridge)(struct pci_bus *bus, unsigned int devfn, int where);
+	int (*read_bridge)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
+	int (*write_bridge)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
 };
 
 /*
-- 
2.7.0

