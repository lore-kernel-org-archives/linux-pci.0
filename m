Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:47756 "EHLO m50-138.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934342AbbLWM2a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Dec 2015 07:28:30 -0500
From: Geliang Tang <geliangtang@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: label, sysfs: use kobj_to_dev
Date: Wed, 23 Dec 2015 20:28:13 +0800
Message-Id: <0b790bbf7f015e5eb970e5433a8b6197a780e56c.1450873511.git.geliangtang@163.com>
In-Reply-To: <8ab09476f7fb0283031b973808740f40522bebe1.1450873511.git.geliangtang@163.com>
References: <8ab09476f7fb0283031b973808740f40522bebe1.1450873511.git.geliangtang@163.com>
In-Reply-To: <8ab09476f7fb0283031b973808740f40522bebe1.1450873511.git.geliangtang@163.com>
References: <8ab09476f7fb0283031b973808740f40522bebe1.1450873511.git.geliangtang@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use kobj_to_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/pci/pci-label.c |  4 ++--
 drivers/pci/pci-sysfs.c | 40 +++++++++++++++-------------------------
 2 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 024b5c1..0ae74d9 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -77,7 +77,7 @@ static umode_t smbios_instance_string_exist(struct kobject *kobj,
 	struct device *dev;
 	struct pci_dev *pdev;
 
-	dev = container_of(kobj, struct device, kobj);
+	dev = kobj_to_dev(kobj);
 	pdev = to_pci_dev(dev);
 
 	return find_smbios_instance_string(pdev, NULL, SMBIOS_ATTR_NONE) ?
@@ -221,7 +221,7 @@ static umode_t acpi_index_string_exist(struct kobject *kobj,
 {
 	struct device *dev;
 
-	dev = container_of(kobj, struct device, kobj);
+	dev = kobj_to_dev(kobj);
 
 	if (device_has_dsm(dev))
 		return S_IRUGO;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d750870..95d9e7b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -630,8 +630,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr, char *buf,
 			       loff_t off, size_t count)
 {
-	struct pci_dev *dev = to_pci_dev(container_of(kobj, struct device,
-						      kobj));
+	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 	unsigned int size = 64;
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
@@ -707,8 +706,7 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 				struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
 {
-	struct pci_dev *dev = to_pci_dev(container_of(kobj, struct device,
-						      kobj));
+	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 	unsigned int size = count;
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
@@ -769,8 +767,7 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
-	struct pci_dev *dev =
-		to_pci_dev(container_of(kobj, struct device, kobj));
+	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
 	if (off > bin_attr->size)
 		count = 0;
@@ -784,8 +781,7 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *bin_attr, char *buf,
 			      loff_t off, size_t count)
 {
-	struct pci_dev *dev =
-		to_pci_dev(container_of(kobj, struct device, kobj));
+	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
 	if (off > bin_attr->size)
 		count = 0;
@@ -812,8 +808,7 @@ static ssize_t pci_read_legacy_io(struct file *filp, struct kobject *kobj,
 				  struct bin_attribute *bin_attr, char *buf,
 				  loff_t off, size_t count)
 {
-	struct pci_bus *bus = to_pci_bus(container_of(kobj, struct device,
-						      kobj));
+	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
 
 	/* Only support 1, 2 or 4 byte accesses */
 	if (count != 1 && count != 2 && count != 4)
@@ -838,8 +833,7 @@ static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
 				   struct bin_attribute *bin_attr, char *buf,
 				   loff_t off, size_t count)
 {
-	struct pci_bus *bus = to_pci_bus(container_of(kobj, struct device,
-						      kobj));
+	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
 
 	/* Only support 1, 2 or 4 byte accesses */
 	if (count != 1 && count != 2 && count != 4)
@@ -863,8 +857,7 @@ static int pci_mmap_legacy_mem(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *attr,
 			       struct vm_area_struct *vma)
 {
-	struct pci_bus *bus = to_pci_bus(container_of(kobj, struct device,
-						      kobj));
+	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
 
 	return pci_mmap_legacy_page_range(bus, vma, pci_mmap_mem);
 }
@@ -884,8 +877,7 @@ static int pci_mmap_legacy_io(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *attr,
 			      struct vm_area_struct *vma)
 {
-	struct pci_bus *bus = to_pci_bus(container_of(kobj, struct device,
-						      kobj));
+	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
 
 	return pci_mmap_legacy_page_range(bus, vma, pci_mmap_io);
 }
@@ -1000,8 +992,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
 static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 			     struct vm_area_struct *vma, int write_combine)
 {
-	struct pci_dev *pdev = to_pci_dev(container_of(kobj,
-						       struct device, kobj));
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	struct resource *res = attr->private;
 	enum pci_mmap_state mmap_type;
 	resource_size_t start, end;
@@ -1054,8 +1045,7 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *attr, char *buf,
 			       loff_t off, size_t count, bool write)
 {
-	struct pci_dev *pdev = to_pci_dev(container_of(kobj,
-						       struct device, kobj));
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	struct resource *res = attr->private;
 	unsigned long port = off;
 	int i;
@@ -1225,7 +1215,7 @@ static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(container_of(kobj, struct device, kobj));
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
 	if ((off ==  0) && (*buf == '0') && (count == 2))
 		pdev->rom_attr_enabled = 0;
@@ -1251,7 +1241,7 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
 			    struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(container_of(kobj, struct device, kobj));
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	void __iomem *rom;
 	size_t size;
 
@@ -1511,7 +1501,7 @@ static struct attribute *pci_dev_dev_attrs[] = {
 static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 					 struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (a == &vga_attr.attr)
@@ -1530,7 +1520,7 @@ static struct attribute *pci_dev_hp_attrs[] = {
 static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
 					    struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (pdev->is_virtfn)
@@ -1554,7 +1544,7 @@ static struct attribute *sriov_dev_attrs[] = {
 static umode_t sriov_attrs_are_visible(struct kobject *kobj,
 				       struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 
 	if (!dev_is_pf(dev))
 		return 0;
-- 
2.5.0


