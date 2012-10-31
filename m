Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31154 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965608Ab2JaVT3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Oct 2012 17:19:29 -0400
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [PATCH 1/4] PCI: add pci_device_type to pdev's device struct
Date: Wed, 31 Oct 2012 17:19:06 -0400
Message-Id: <1351718353-6124-2-git-send-email-ddutile@redhat.com>
In-Reply-To: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>

Need type filled in device structure so it
can be used for visible attribute control in
syfsfs for pci_dev.

Authored-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Donald Dutile <ddutile@redhat.com>
---
 drivers/pci/pci-sysfs.c | 24 ++++++++++++++++++++++++
 drivers/pci/pci.h       |  1 +
 drivers/pci/probe.c     |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 02d107b..3d160aa 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1411,3 +1411,27 @@ static int __init pci_sysfs_init(void)
 }
 
 late_initcall(pci_sysfs_init);
+
+static struct attribute *pci_dev_dev_attrs[] = {
+	NULL,
+};
+
+static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
+						struct attribute *a, int n)
+{
+	return a->mode;
+}
+
+static struct attribute_group pci_dev_attr_group = {
+	.attrs = pci_dev_dev_attrs,
+	.is_visible = pci_dev_attrs_are_visible,
+};
+
+static const struct attribute_group *pci_dev_attr_groups[] = {
+	&pci_dev_attr_group,
+	NULL,
+};
+
+struct device_type pci_dev_type = {
+	.groups = pci_dev_attr_groups,
+};
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bacbcba..6f6cd14 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -157,6 +157,7 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 }
 extern struct device_attribute pci_dev_attrs[];
 extern struct device_attribute pcibus_dev_attrs[];
+extern struct device_type pci_dev_type;
 #ifdef CONFIG_HOTPLUG
 extern struct bus_attribute pci_bus_attrs[];
 #else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec909af..0312f1c48 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -975,6 +975,7 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->sysdata = dev->bus->sysdata;
 	dev->dev.parent = dev->bus->bridge;
 	dev->dev.bus = &pci_bus_type;
+	dev->dev.type = &pci_dev_type;
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->error_state = pci_channel_io_normal;
-- 
1.7.10.2.552.gaa3bb87

