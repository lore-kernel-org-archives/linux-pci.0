Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 21/39] PCI: Add busn_res operation functions
Date: Wed, 29 Feb 2012 15:07:20 -0800
Message-Id: <1330556858-11768-22-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

will use them insert/update busn res in pci_bus

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |    3 +++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a4a20d6..5efcf1a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1687,6 +1687,56 @@ err_out:
 	return NULL;
 }
 
+void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
+{
+	struct resource *res = &b->busn_res;
+	struct resource *parent_res;
+	int ret;
+
+	res->start = bus;
+	res->end = bus_max;
+	res->flags = IORESOURCE_BUS;
+
+	/* no parent for root bus' busn_res */
+	if (!pci_is_root_bus(b)) {
+		parent_res = &b->parent->busn_res;
+
+		ret = insert_resource(parent_res, res);
+
+		dev_printk(KERN_DEBUG, &b->dev,
+			"busn_res: %pR %s inserted under %pR\n",
+			res, ret ? "can not be" : "is", parent_res);
+	} else
+		dev_printk(KERN_DEBUG, &b->dev,
+			"busn_res: %pR for root bus\n",
+			res);
+}
+
+void pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
+{
+	struct resource *res = &b->busn_res;
+	struct resource old_res = *res;
+
+	res->end = bus_max;
+	dev_printk(KERN_DEBUG, &b->dev,
+			"busn_res: %pR end updated to %pR\n",
+			&old_res, res);
+}
+
+void pci_bus_release_busn_res(struct pci_bus *b)
+{
+	struct resource *res = &b->busn_res;
+	int ret;
+
+	if (!res->flags)
+		return;
+
+	ret = release_resource(res);
+	dev_printk(KERN_DEBUG, &b->dev,
+			"busn_res: %pR %s released\n",
+			res, ret ? "can not be" : "is");
+}
+
 struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 84eedff..40606c1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -671,6 +671,9 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
+void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
+void pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
+void pci_bus_release_busn_res(struct pci_bus *b);
 struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
-- 
1.7.7

