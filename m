Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36213 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbbKWMkb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2015 07:40:31 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 1/2] PCI: Add pci_ops.add_bus() callback
Date: Mon, 23 Nov 2015 13:40:25 +0100
Message-Id: <1448282426-2642-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

This callback will be called on every newly created bus. Drivers can
implement it to perform driver-specific initialization of the bus.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/probe.c | 8 +++++++-
 include/linux/pci.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e735c728e3b3..fbed432f8915 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -754,7 +754,13 @@ add_dev:
 	ret = device_register(&child->dev);
 	WARN_ON(ret < 0);
 
-	pcibios_add_bus(child);
+	if (child->ops->add_bus) {
+		ret = child->ops->add_bus(child);
+		if (ret < 0)
+			dev_err(&child->dev, "failed to add bus: %d\n", ret);
+	} else {
+		pcibios_add_bus(child);
+	}
 
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(child);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e828e7b4afec..70c1228d585f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -569,6 +569,7 @@ static inline int pcibios_err_to_errno(int err)
 /* Low-level architecture-dependent routines */
 
 struct pci_ops {
+	int (*add_bus)(struct pci_bus *bus);
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
-- 
2.5.0

