Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36202 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdHEGi2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 02:38:28 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 02/10] PCI: introduce ioport_res/iomem_res for PCI_TEST
Date: Fri,  4 Aug 2017 23:37:53 -0700
Message-Id: <20170805063801.15880-3-yinghai@kernel.org>
In-Reply-To: <20170805063801.15880-1-yinghai@kernel.org>
References: <20170805063801.15880-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make every bus to take the pointer to correct iomem_res instead of
using iomem_resource directly.

So PCI_TEST could use different iomem_res later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c     |  2 ++
 drivers/pci/quirks.c    |  2 +-
 drivers/pci/setup-bus.c |  2 +-
 drivers/pci/setup-res.c |  4 ++--
 include/linux/pci.h     | 13 +++++++++++++
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c31310d..1811016 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -881,6 +881,8 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	child->msi = parent->msi;
 	child->sysdata = parent->sysdata;
 	child->bus_flags = parent->bus_flags;
+	child->iomem_res = parent->iomem_res;
+	child->ioport_res = parent->ioport_res;
 
 	/* initialize some portions of the bus device, but don't register it
 	 * now as the parent is not properly set up yet.
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6967c6b..dc31098 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1617,7 +1617,7 @@ static void quirk_alder_ioapic(struct pci_dev *pdev)
 	 * not touch this (and it's already covered by the fixmap), so
 	 * forcibly insert it into the resource tree */
 	if (pci_resource_start(pdev, 0) && pci_resource_len(pdev, 0))
-		insert_resource(&iomem_resource, &pdev->resource[0]);
+		insert_resource(iomem_res(pdev->bus), &pdev->resource[0]);
 
 	/* The next five BARs all seem to be rubbish, so just clean
 	 * them out */
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 958da7d..1c30102 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -805,7 +805,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 	struct resource *r;
 
 	pci_bus_for_each_resource(bus, r, i) {
-		if (r == &ioport_resource || r == &iomem_resource)
+		if (r == ioport_res(bus) || r == iomem_res(bus))
 			continue;
 		if (r && (r->flags & type_mask) == type && !r->parent)
 			return r;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 85774b7..43921a4 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -215,9 +215,9 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 	root = pci_find_parent_resource(dev, res);
 	if (!root) {
 		if (res->flags & IORESOURCE_IO)
-			root = &ioport_resource;
+			root = ioport_res(dev->bus);
 		else
-			root = &iomem_resource;
+			root = iomem_res(dev->bus);
 	}
 
 	dev_info(&dev->dev, "BAR %d: trying firmware assignment %pR\n",
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4869e66..c58a635 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -524,6 +524,9 @@ struct pci_bus {
 	void		*sysdata;	/* hook for sys-specific extension */
 	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci */
 
+	struct resource *iomem_res;	/* pointer to root iomem_resource */
+	struct resource *ioport_res;	/* pointer to root ioport_resource */
+
 	unsigned char	number;		/* bus number */
 	unsigned char	primary;	/* number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
@@ -545,6 +548,16 @@ struct pci_bus {
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
 
+static inline struct resource *iomem_res(struct pci_bus *bus)
+{
+	return bus->iomem_res ? : &iomem_resource;
+}
+
+static inline struct resource *ioport_res(struct pci_bus *bus)
+{
+	return bus->ioport_res ? : &ioport_resource;
+}
+
 /*
  * Returns true if the PCI bus is root (behind host-PCI bridge),
  * false otherwise
-- 
2.9.4
