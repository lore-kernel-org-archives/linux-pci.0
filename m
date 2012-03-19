Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v3 09/47] PCI, sysfs: Use device_type and attr_groups with pci dev
Date: Sun, 18 Mar 2012 22:45:58 -0700
Message-Id: <1332135996-13860-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332135996-13860-1-git-send-email-yinghai@kernel.org>
References: <1332135996-13860-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We want to create rescan in sys only for pci bridge instead of all pci dev.

We could use attribute_groups/is_visible method to do that.

Now pci dev does not use device type yet. So add pci_dev_type to take
attr_groups with it.

Add pci_dev_bridge_attrs_are_visible() to control attr_bridge_group only create
attr for bridge.

This is the framework related change, later could attr to bridge_attr_group,
to make those attr only show up on pci bridge device.

Also We could add more attr groups with is_visible to reduce messness in
	pci_create_sysfs_dev_files. ( at least for boot_vga one )

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-sysfs.c |   30 ++++++++++++++++++++++++++++++
 drivers/pci/pci.h       |    1 +
 drivers/pci/probe.c     |    1 +
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a55e248..39d15e6 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1335,3 +1335,33 @@ static int __init pci_sysfs_init(void)
 }
 
 late_initcall(pci_sysfs_init);
+
+static struct attribute *pci_dev_bridge_attrs[] = {
+	NULL,
+};
+
+static umode_t pci_dev_bridge_attrs_are_visible(struct kobject *kobj,
+						struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pdev->subordinate)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group pci_dev_bridge_attr_group = {
+	.attrs = pci_dev_bridge_attrs,
+	.is_visible = pci_dev_bridge_attrs_are_visible,
+};
+
+static const struct attribute_group *pci_dev_attr_groups[] = {
+	&pci_dev_bridge_attr_group,
+	NULL,
+};
+
+struct device_type pci_dev_type = {
+	.groups = pci_dev_attr_groups,
+};
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e494347..13b1159 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -162,6 +162,7 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 }
 extern struct device_attribute pci_dev_attrs[];
 extern struct device_attribute pcibus_dev_attrs[];
+extern struct device_type pci_dev_type;
 #ifdef CONFIG_HOTPLUG
 extern struct bus_attribute pci_bus_attrs[];
 #else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3dc92b9..e51e1a5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1119,6 +1119,7 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->sysdata = dev->bus->sysdata;
 	dev->dev.parent = dev->bus->bridge;
 	dev->dev.bus = &pci_bus_type;
+	dev->dev.type = &pci_dev_type;
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->error_state = pci_channel_io_normal;
-- 
1.7.7

