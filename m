Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37946 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbcBIOav (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 09:30:51 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: Add pci_ops.{add,remove}_bus() callbacks
Date: Tue,  9 Feb 2016 15:30:47 +0100
Message-Id: <1455028248-1950-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

These callbacks will be called on every newly created bus and when a bus
is being removed, respectively. This can be used by drivers to implement
driver-specific initialization and teardown of the bus, in addition to
the architecture-specifics implemented by the pcibios_add_bus() and the
pcibios_remove_bus() functions.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add pci_ops.remove_bus() callback
- always call pcibios_add_bus()

 drivers/pci/probe.c  | 6 ++++++
 drivers/pci/remove.c | 4 ++++
 include/linux/pci.h  | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9bb0d5a..3ea4de1c6926 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -758,6 +758,12 @@ add_dev:
 
 	pcibios_add_bus(child);
 
+	if (child->ops->add_bus) {
+		ret = child->ops->add_bus(child);
+		if (WARN_ON(ret < 0))
+			dev_err(&child->dev, "failed to add bus: %d\n", ret);
+	}
+
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(child);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8a280e9c2ad1..d35c7fcde3af 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -54,6 +54,10 @@ void pci_remove_bus(struct pci_bus *bus)
 	pci_bus_release_busn_res(bus);
 	up_write(&pci_bus_sem);
 	pci_remove_legacy_files(bus);
+
+	if (bus->ops->remove_bus)
+		bus->ops->remove_bus(bus);
+
 	pcibios_remove_bus(bus);
 	device_unregister(&bus->dev);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6585da..0f7ef14c4d10 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -578,6 +578,8 @@ static inline int pcibios_err_to_errno(int err)
 /* Low-level architecture-dependent routines */
 
 struct pci_ops {
+	int (*add_bus)(struct pci_bus *bus);
+	void (*remove_bus)(struct pci_bus *bus);
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
-- 
2.7.1

