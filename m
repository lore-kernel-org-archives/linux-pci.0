Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Scott Branden <sbranden@broadcom.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v8 1/3] PCI: Export symbols of PCI functions
Date: Wed, 8 Apr 2015 11:21:33 -0700
Message-ID: <1428517295-12825-2-git-send-email-rjui@broadcom.com>
In-Reply-To: <1428517295-12825-1-git-send-email-rjui@broadcom.com>
References: <1428517295-12825-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Export symbols of the following PCI functions so they can be referenced
by a PCI driver compiled as a kernel loadable module:

pci_common_swizzle
pci_create_root_bus
pci_stop_root_bus
pci_remove_root_bus
pci_assign_unassigned_bus_resources
pci_fixup_irqs

Signed-off-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/pci.c       |    1 +
 drivers/pci/probe.c     |    1 +
 drivers/pci/remove.c    |    2 ++
 drivers/pci/setup-bus.c |    1 +
 drivers/pci/setup-irq.c |    1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 81f06e8..14e7f3c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2492,6 +2492,7 @@ u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp)
 	*pinp = pin;
 	return PCI_SLOT(dev->devfn);
 }
+EXPORT_SYMBOL_GPL(pci_common_swizzle);
 
 /**
  *	pci_release_region - Release a PCI bar
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8d2f400..f13a78a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1993,6 +1993,7 @@ err_out:
 	kfree(b);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(pci_create_root_bus);
 
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 {
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8bd76c9..8a280e9 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -139,6 +139,7 @@ void pci_stop_root_bus(struct pci_bus *bus)
 	/* stop the host bridge */
 	device_release_driver(&host_bridge->dev);
 }
+EXPORT_SYMBOL_GPL(pci_stop_root_bus);
 
 void pci_remove_root_bus(struct pci_bus *bus)
 {
@@ -158,3 +159,4 @@ void pci_remove_root_bus(struct pci_bus *bus)
 	/* remove the host bridge */
 	device_unregister(&host_bridge->dev);
 }
+EXPORT_SYMBOL_GPL(pci_remove_root_bus);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e3e17f3..8169597 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1750,3 +1750,4 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 	__pci_bus_assign_resources(bus, &add_list, NULL);
 	BUG_ON(!list_empty(&add_list));
 }
+EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 4e2d595..95c225b 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -65,3 +65,4 @@ void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
 	for_each_pci_dev(dev)
 		pdev_fixup_irq(dev, swizzle, map_irq);
 }
+EXPORT_SYMBOL_GPL(pci_fixup_irqs);
-- 
1.7.9.5

