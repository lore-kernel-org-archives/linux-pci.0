Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750886AbdIRT12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2017 15:27:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8IJOWnH104584
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2017 15:27:28 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d2ea07nw4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2017 15:27:27 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <bryantly@linux.vnet.ibm.com>;
        Mon, 18 Sep 2017 15:27:27 -0400
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Juan J . Alvarez" <jjalvare@us.ibm.com>
Subject: [PATCH v1 1/3] powerpc/kernel: Split up pci_bus_add_device
Date: Mon, 18 Sep 2017 14:26:49 -0500
In-Reply-To: <20170918192651.78404-1-bryantly@linux.vnet.ibm.com>
References: <20170918192651.78404-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20170918192651.78404-2-bryantly@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When enabling SR-IOV one might want to have their
own version of starting device drivers for the VFs.
This patch allows for SR-IOV callers to use
pci_bus_add_virtfn_device instead of generic
pci_bus_add_device.

When enabling SR-IOV in PSeries architecture the
dynamic VFs created within the sriov_configure sysfs call
will not load the device driver as firmware will load
the device node when the VF device is assigned to the
logical partition. So we needed a way to overwrite the
way device driver matching is done for virtual functions
on powervm.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
---
 drivers/pci/bus.c   | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 drivers/pci/iov.c   |  2 +-
 include/linux/pci.h |  3 +++
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc56cf19afd3..86daf62c4048 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -302,16 +302,9 @@ void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
 void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
 
-/**
- * pci_bus_add_device - start driver for a single device
- * @dev: device to add
- *
- * This adds add sysfs entries and start device drivers
- */
-void pci_bus_add_device(struct pci_dev *dev)
-{
-	int retval;
 
+void pci_bus_add_sysfs_entries(struct pci_dev *dev)
+{
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
@@ -321,6 +314,11 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
+}
+
+void pci_bus_match_device_driver(struct pci_dev *dev)
+{
+	int retval;
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
@@ -333,6 +331,41 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	dev->is_added = 1;
 }
+
+#ifdef CONFIG_PCI_IOV
+void __weak pci_bus_match_virtfn_driver(struct pci_dev *dev)
+{
+	pci_bus_match_device_driver(dev);
+}
+
+/**
+ * pci_bus_add_virtfn_device - start driver for a virtual function device
+ * @dev: device to add
+ *
+ * This adds add sysfs entries and start device drivers for
+ * virtual function devices
+ *
+ */
+void pci_bus_add_virtfn_device(struct pci_dev *pdev)
+{
+	pci_bus_add_sysfs_entries(pdev);
+	pci_bus_match_virtfn_driver(pdev);
+}
+EXPORT_SYMBOL_GPL(pci_bus_add_virtfn_device);
+#endif
+
+/**
+ * pci_bus_add_device - start driver for a single device
+ * @dev: device to add
+ *
+ * This adds add sysfs entries and start device drivers
+ */
+void pci_bus_add_device(struct pci_dev *dev)
+{
+	pci_bus_add_sysfs_entries(dev);
+	pci_bus_match_device_driver(dev);
+}
+
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
 /**
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ac41c8be9200..16cc72545847 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -162,7 +162,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 
 	pci_device_add(virtfn, virtfn->bus);
 
-	pci_bus_add_device(virtfn);
+	pci_bus_add_virtfn_device(virtfn);
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f68c58a93dd0..39f5c0b4bf23 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -911,6 +911,9 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
 void pci_bus_add_device(struct pci_dev *dev);
+#ifdef CONFIG_PCI_IOV
+void pci_bus_add_virtfn_device(struct pci_dev *dev);
+#endif
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
-- 
2.11.0 (Apple Git-81)
