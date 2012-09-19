Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 21/40] PCI: Add pci_stop_and_remove_root_bus()
Date: Wed, 19 Sep 2012 11:54:35 -0700
Message-Id: <1348080894-23412-22-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348080894-23412-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQWFcVNKMnV1qaHchwCXfZuMpyxf_f7GQy3FZid9YuLD3w@mail.gmail.com>
 <1348080894-23412-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It supports both pci root bus and pci bus under pci bridge.

-v2: clear pci_bridge's subordinate.
-v3: only handle root bus. and also put Jiang's get/put pair in
-v4: fold pci_stop/remove_bus_devices in... reducing confusing.
-v5: split device_register/unregister to avoid extra get...
     also remove extra blank line.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c  |    3 ++-
 drivers/pci/remove.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    2 ++
 3 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 47238dd..ab845aa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1660,7 +1660,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->dev.parent = parent;
 	bridge->dev.release = pci_release_bus_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
-	error = device_register(&bridge->dev);
+	device_initialize(&bridge->dev);
+	error = device_add(&bridge->dev);
 	if (error)
 		goto bridge_dev_reg_err;
 	b->bridge = get_device(&bridge->dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 513972f..7c0fd92 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -111,3 +111,39 @@ void pci_stop_and_remove_bus_device(struct pci_dev *dev)
 	pci_remove_bus_device(dev);
 }
 EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
+
+void pci_stop_root_bus(struct pci_bus *bus)
+{
+	struct pci_dev *child, *tmp;
+	struct pci_host_bridge *host_bridge;
+
+	if (!pci_is_root_bus(bus))
+		return;
+
+	host_bridge = to_pci_host_bridge(bus->bridge);
+	list_for_each_entry_safe_reverse(child, tmp,
+					 &bus->devices, bus_list)
+		pci_stop_bus_device(child);
+
+	/* stop the host bridge */
+	device_del(&host_bridge->dev);
+}
+
+void pci_remove_root_bus(struct pci_bus *bus)
+{
+	struct pci_dev *child, *tmp;
+	struct pci_host_bridge *host_bridge;
+
+	if (!pci_is_root_bus(bus))
+		return;
+
+	host_bridge = to_pci_host_bridge(bus->bridge);
+	list_for_each_entry_safe(child, tmp,
+				 &bus->devices, bus_list)
+		pci_remove_bus_device(child);
+	pci_remove_bus(bus);
+	host_bridge->bus = NULL;
+
+	/* remove the host bridge */
+	put_device(&host_bridge->dev);
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7404077..88ae237 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -735,6 +735,8 @@ extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
 extern void pci_dev_put(struct pci_dev *dev);
 extern void pci_remove_bus(struct pci_bus *b);
 extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
+void pci_stop_root_bus(struct pci_bus *bus);
+void pci_remove_root_bus(struct pci_bus *bus);
 void pci_setup_cardbus(struct pci_bus *bus);
 extern void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
-- 
1.7.7

