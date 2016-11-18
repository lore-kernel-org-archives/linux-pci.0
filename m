Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <rafael@kernel.org>,
        <Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jcm@redhat.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V5 1/2] PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform
Date: Fri, 18 Nov 2016 17:22:30 +0800
Message-ID: <1479460951-49281-2-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1479460951-49281-1-git-send-email-liudongdong3@huawei.com>
References: <1479460951-49281-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

The acpi_get_rc_resources() is used to get the RC register address that can
not be described in MCFG. It takes the _HID&segment to look for and outputs
the RC address resource. Use PNP0C02 devices to describe such RC address
resource. Use _UID to match segment to tell which root bus the PNP0C02
resource belong to.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/pci-acpi.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |  4 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d966d47..3557e3a 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -29,6 +29,77 @@
 	0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
 };
 
+#ifdef CONFIG_ARM64
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
+		pr_err("Can't find _HID %s device", hid);
+		return -ENODEV;
+	}
+
+	ret = acpi_bus_get_device(handle, &adev);
+	if (ret)
+		return ret;
+
+	ret = acpi_get_rc_addr(adev, res);
+	if (ret) {
+		dev_err(&adev->dev, "can't get RC resource");
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
index 4518562..17ffa38 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -356,4 +356,8 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
+#ifdef CONFIG_ARM64
+int acpi_get_rc_resources(const char *hid, u16 segment, struct resource *res);
+#endif
+
 #endif /* DRIVERS_PCI_H */
-- 
1.9.1
