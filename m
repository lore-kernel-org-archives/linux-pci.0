Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753103AbcLAIbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 03:31:33 -0500
Subject: [PATCH v10 07/12] PCI/ACPI: Provide acpi_get_rc_resources() for
 ARM64 platform
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Thu, 01 Dec 2016 02:30:22 -0600
Message-ID: <20161201083022.12247.65297.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dongdong Liu <liudongdong3@huawei.com>

The acpi_get_rc_resources() is used to get the RC register address that can
not be described in MCFG.  It takes the _HID & segment to look for and
outputs the RC address resource.  Use PNP0C02 devices to describe such RC
address resource.  Use _UID to match segment to tell which root bus the
PNP0C02 resource belongs to.

[bhelgaas: wrap in #ifdef CONFIG_PCI_QUIRKS]
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-acpi.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |    4 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d966d47..cfab024 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -29,6 +29,77 @@ const u8 pci_acpi_dsm_uuid[] = {
 	0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
 };
 
+#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
+static int acpi_get_rc_addr(struct acpi_device *adev, struct resource *res)
+{
+	struct resource_entry *entry;
+	struct list_head list;
+	unsigned long flags;
+	int ret;
+
+	INIT_LIST_HEAD(&list);
+	flags = IORESOURCE_MEM;
+	ret = acpi_dev_get_resources(adev, &list,
+				     acpi_dev_filter_resource_type_cb,
+				     (void *) flags);
+	if (ret < 0) {
+		dev_err(&adev->dev,
+			"failed to parse _CRS method, error code %d\n", ret);
+		return ret;
+	} else if (ret == 0) {
+		dev_err(&adev->dev,
+			"no IO and memory resources present in _CRS\n");
+		return -EINVAL;
+	}
+
+	entry = list_first_entry(&list, struct resource_entry, node);
+	*res = *entry->res;
+	acpi_dev_free_resource_list(&list);
+	return 0;
+}
+
+static acpi_status acpi_match_rc(acpi_handle handle, u32 lvl, void *context,
+				 void **retval)
+{
+	u16 *segment = context;
+	unsigned long long uid;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
+	if (ACPI_FAILURE(status) || uid != *segment)
+		return AE_CTRL_DEPTH;
+
+	*(acpi_handle *)retval = handle;
+	return AE_CTRL_TERMINATE;
+}
+
+int acpi_get_rc_resources(const char *hid, u16 segment, struct resource *res)
+{
+	struct acpi_device *adev;
+	acpi_status status;
+	acpi_handle handle;
+	int ret;
+
+	status = acpi_get_devices(hid, acpi_match_rc, &segment, &handle);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Can't find _HID %s device\n", hid);
+		return -ENODEV;
+	}
+
+	ret = acpi_bus_get_device(handle, &adev);
+	if (ret)
+		return ret;
+
+	ret = acpi_get_rc_addr(adev, res);
+	if (ret) {
+		dev_err(&adev->dev, "can't get RC resource\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
 phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 {
 	acpi_status status = AE_NOT_EXIST;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4518562..c27b0fc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -356,4 +356,8 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
+#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
+int acpi_get_rc_resources(const char *hid, u16 segment, struct resource *res);
+#endif
+
 #endif /* DRIVERS_PCI_H */

