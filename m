Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH v3 1/6] PCI: Add pci_bus_fixup_irqs().
Date: Tue, 22 Sep 2015 16:49:12 -0700
Message-Id: <1442965757-12925-2-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

pci_bus_fixup_irqs() works like pci_fixup_irqs(), except it only does
the fixups for devices on the specified bus.

Follow-on patch will use the new function.

Signed-off-by: David Daney <david.daney@cavium.com>
---
No change from v2.

This patch didn't exist in v1 of the set.

 drivers/pci/setup-irq.c | 30 ++++++++++++++++++++++++++++++
 include/linux/pci.h     |  4 ++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 95c225b..189ad17 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -66,3 +66,33 @@ void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
 		pdev_fixup_irq(dev, swizzle, map_irq);
 }
 EXPORT_SYMBOL_GPL(pci_fixup_irqs);
+
+struct pci_bus_fixup_cb_info {
+	u8 (*swizzle)(struct pci_dev *, u8 *);
+	int (*map_irq)(const struct pci_dev *, u8, u8);
+};
+
+static int pci_bus_fixup_irq_cb(struct pci_dev *dev, void *arg)
+{
+	struct pci_bus_fixup_cb_info *info = arg;
+
+	pdev_fixup_irq(dev, info->swizzle, info->map_irq);
+	return 0;
+}
+
+/*
+ * Fixup the irqs only for devices on the given bus using supplied
+ * swizzle and map_irq function pointers
+ */
+void pci_bus_fixup_irqs(struct pci_bus *bus,
+			u8 (*swizzle)(struct pci_dev *, u8 *),
+			int (*map_irq)(const struct pci_dev *, u8, u8))
+{
+	struct pci_bus_fixup_cb_info info;
+
+	info.swizzle = swizzle;
+	info.map_irq = map_irq;
+	pci_walk_bus(bus, pci_bus_fixup_irq_cb, &info);
+
+}
+EXPORT_SYMBOL_GPL(pci_bus_fixup_irqs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22..b505b50 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1120,6 +1120,10 @@ void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(const struct pci_dev *, u8, u8));
+void pci_bus_fixup_irqs(struct pci_bus *,
+			u8 (*)(struct pci_dev *, u8 *),
+			int (*)(const struct pci_dev *, u8, u8));
+
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
 int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
-- 
1.9.1

