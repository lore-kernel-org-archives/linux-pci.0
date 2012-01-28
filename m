Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 02/13] PCI: Add busn_res operation functions
Date: Fri, 27 Jan 2012 18:49:20 -0800
Message-Id: <1327718971-9598-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

will use them insert/update busn res in pci_bus

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |    3 +++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a114173..71261da 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1622,6 +1622,50 @@ err_out:
 	return NULL;
 }
 
+void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
+{
+	struct resource *res = &b->busn_res;
+	struct resource *parent_res = &iobusn_resource;
+	int ret;
+
+	res->start = (pci_domain_nr(b) << 8) | bus;
+	res->end = (pci_domain_nr(b) << 8) | bus_max;
+	res->flags = IORESOURCE_BUS;
+
+	if (!pci_is_root_bus(b))
+		parent_res = &b->parent->busn_res;
+
+	ret = insert_resource(parent_res, res);
+
+	dev_printk(KERN_DEBUG, &b->dev,
+	 "busn_res: %06llx-%06llx %s inserted under %06llx-%06llx\n",
+			(unsigned long long)res->start,
+			(unsigned long long)res->end,
+			 ret ? "can not be" : "is",
+			(unsigned long long)parent_res->start,
+			(unsigned long long)parent_res->end);
+}
+
+void pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
+{
+	struct resource *res = &b->busn_res;
+	unsigned long long old_end = res->end;
+
+	res->end &= ~0xff;
+	res->end |= bus_max;
+	dev_printk(KERN_DEBUG, &b->dev,
+		 "busn_res: %06llx-%06llx end updated to %06llx-%06llx\n",
+			(unsigned long long)res->start,
+			old_end,
+			(unsigned long long)res->start,
+			(unsigned long long)res->end);
+}
+
+void pci_bus_release_busn_res(struct pci_bus *b)
+{
+	release_resource(&b->busn_res);
+}
+
 struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 94ad468..3da935c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -665,6 +665,9 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
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

