Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F13612F3;
	Tue, 16 Jun 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606800; cv=none; b=Odng0s9RmFTXMq1Jfo+oDS6QhNaTBC7CZOVl/Fc8PBQ2RcTpjruevrN7HFRgAAiaO4LFt6ucNR94IfBrSj2Kvs+10AplFRMwC7dtoHMU0LxUknINFctVc487AKZ8L9Ec+z/jyQacS6C/YIcXTGT0juoCjKz0fn6tWNHEhQcd+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606800; c=relaxed/simple;
	bh=u1hbTvYuoaTpPawzDxtyhxNutUWKMki2T/Drhy4IkFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxnXBVNDcpVofk4uvgY76+WC7od1cgPh8/KPutC68ERQVcnvZlfT9eda7CYsaqqXcqHaBgoj+22e0hCQCuWNEnZMQ0wMNJNz/nS9bTW1934TT/W76nwb0ENIYpBLbTf+QLG/0LvD/768MB9N8tjJMpPaSNHjyr8JgqfK+6DG+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4Mr63kky; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4Mr63kky"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=X/dExQSu+zpbYzU9DsHphLcz05fH+l0f2eXFhDFKrWg=;
	b=4Mr63kkydQtljnzv3apNerw7bFMxBTGrSDLyr8aRP4iJDSjBMdfIdwd7k55uIMQ1HAIMysyR+
	oGatuWlJCmPE/Odp2g3LgaReqPeP3dSqT9YpCDW5X14yPE01BOz02aup3Usgz0j9cdTY5dRk1VH
	n2Lg1uQP23TI/wm+MtWnAeQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gfk3n5l6CzpSvM;
	Tue, 16 Jun 2026 18:38:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 40C7440538;
	Tue, 16 Jun 2026 18:46:31 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 18:46:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU to steering-tag mapping
Date: Tue, 16 Jun 2026 18:46:17 +0800
Message-ID: <20260616104621.41915-9-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260616104621.41915-1-fengchengwen@huawei.com>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add per-device sysfs binary attribute tph_cpu_st to expose ACPI DSM CPU
to steering-tag data to userspace, resolving the concern that VFIO should
not host CPU-to-ST translation interfaces.

Follow PCI standard binattr framework: dynamic visible group, fixed-size
8-byte packed uapi entry, aligned offset read, root-only 0400 permission.
Refactor duplicate ACPI DSM logic into shared tph_get_cpu_st_info helper.

ABI: /sys/bus/pci/devices/<BDF>/tph_cpu_st

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/pci-sysfs.c  |   3 ++
 drivers/pci/pci.h        |   4 ++
 drivers/pci/tph.c        | 113 +++++++++++++++++++++++++++++++++------
 include/uapi/linux/pci.h |  15 ++++++
 4 files changed, 120 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..ad9e4e8d320b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1832,6 +1832,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #ifdef CONFIG_PCI_TSM
 	&pci_tsm_auth_attr_group,
 	&pci_tsm_attr_group,
+#endif
+#ifdef CONFIG_PCIE_TPH
+	&pcie_tph_cpu_st_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..09306078a658 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1366,6 +1366,10 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 extern const struct attribute_group aspm_ctrl_attr_group;
 #endif
 
+#ifdef CONFIG_PCIE_TPH
+extern const struct attribute_group pcie_tph_cpu_st_attr_group;
+#endif
+
 #ifdef CONFIG_X86_INTEL_MID
 bool pci_use_mid_pm(void);
 int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state);
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 95280aab4fb5..aca5093e8152 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -130,6 +130,29 @@ static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
 
 	return AE_OK;
 }
+
+static int tph_get_cpu_st_info(struct pci_dev *pdev, unsigned int cpu,
+			       union st_info *info)
+{
+	acpi_handle rp_acpi_handle;
+	struct pci_dev *rp;
+	u32 cpu_uid;
+	int ret;
+
+	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
+	if (ret != 0)
+		return ret;
+
+	rp = pcie_find_root_port(pdev);
+	if (!rp || !rp->bus || !rp->bus->bridge)
+		return -ENODEV;
+
+	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
+	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, info) != AE_OK)
+		return -EINVAL;
+
+	return 0;
+}
 #endif
 
 /* Update the TPH Requester Enable field of TPH Control Register */
@@ -231,31 +254,36 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
 	return pci_write_config_word(pdev, offset, tag);
 }
 
+static void get_cpu_all_st(struct pci_dev *pdev, unsigned int cpu,
+			   struct pci_tph_cpu_st *st)
+{
+	memset(st, 0, sizeof(*st));
+#ifdef CONFIG_ACPI
+	union st_info info;
+	int ret;
+
+	ret = tph_get_cpu_st_info(pdev, cpu, &info);
+	if (ret == 0) {
+		st->vm_st = info.vm_st_valid ? info.vm_st : 0;
+		st->pm_st = info.pm_st_valid ? info.pm_st : 0;
+		st->vm_xst = info.vm_xst_valid ? info.vm_xst : 0;
+		st->pm_xst = info.pm_xst_valid ? info.pm_xst : 0;
+		st->reserved = 0;
+	}
+#endif
+}
+
 static int get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 		      u8 req_type, unsigned int cpu, u16 *tag)
 {
 #ifdef CONFIG_ACPI
-	struct pci_dev *rp;
-	acpi_handle rp_acpi_handle;
 	union st_info info;
-	u32 cpu_uid;
 	int ret;
 
-	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
+	ret = tph_get_cpu_st_info(pdev, cpu, &info);
 	if (ret != 0)
 		return ret;
 
-	rp = pcie_find_root_port(pdev);
-	if (!rp || !rp->bus || !rp->bus->bridge)
-		return -ENODEV;
-
-	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
-
-	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
-		*tag = 0;
-		return -EINVAL;
-	}
-
 	*tag = tph_extract_tag(mem_type, req_type, &info);
 
 	pci_dbg(pdev, "get steering tag: mem_type=%s, req_type=%u, cpu=%d, tag=%#04x\n",
@@ -619,3 +647,58 @@ bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
 	return pdev->tph_ext_support;
 }
 EXPORT_SYMBOL(pcie_tph_supported);
+
+static ssize_t tph_cpu_st_read(struct file *filp, struct kobject *kobj,
+			       const struct bin_attribute *bin_attr, char *buf,
+			       loff_t off, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	size_t entry_sz = PCI_TPH_CPU_ST_ENTRY_SZ;
+	struct pci_tph_cpu_st st;
+	unsigned int target_cpu;
+	size_t copy_len;
+
+	if (off >= nr_cpu_ids * entry_sz || off % entry_sz != 0)
+		return 0;
+
+	target_cpu = off / entry_sz;
+	if (!cpu_possible(target_cpu))
+		return -ENODEV;
+
+	get_cpu_all_st(pdev, target_cpu, &st);
+
+	copy_len = min_t(size_t, entry_sz, count);
+	memcpy(buf, &st, copy_len);
+
+	return copy_len;
+}
+static BIN_ATTR(tph_cpu_st, 0400, tph_cpu_st_read, NULL, 0);
+
+static const struct bin_attribute *const tph_cpu_st_bin_attrs[] = {
+	&bin_attr_tph_cpu_st,
+	NULL,
+};
+
+static size_t tph_cpu_st_bin_size(struct kobject *kobj,
+				  const struct bin_attribute *a, int n)
+{
+	return nr_cpu_ids * PCI_TPH_CPU_ST_ENTRY_SZ;
+}
+
+static umode_t tph_cpu_st_attr_is_visible(struct kobject *kobj,
+					  const struct bin_attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (pcie_tph_supported(pdev, false))
+		return a->attr.mode;
+
+	return 0;
+}
+
+const struct attribute_group pcie_tph_cpu_st_attr_group = {
+	.bin_attrs = tph_cpu_st_bin_attrs,
+	.bin_size = tph_cpu_st_bin_size,
+	.is_bin_visible = tph_cpu_st_attr_is_visible,
+};
diff --git a/include/uapi/linux/pci.h b/include/uapi/linux/pci.h
index 4f150028965d..d8aa9f8d47f6 100644
--- a/include/uapi/linux/pci.h
+++ b/include/uapi/linux/pci.h
@@ -46,4 +46,19 @@ enum pci_hotplug_event {
 	PCI_HOTPLUG_CARD_NOT_PRESENT,
 };
 
+/*
+ * PCIe TPH sysfs binary entry for CPU-to-ST mapping
+ * Sysfs file: /sys/bus/pci/devices/<BDF>/tph_cpu_st
+ * Each entry is 8 bytes aligned, seek offset = cpu_id * PCI_TPH_CPU_ST_ENTRY_SZ
+ */
+struct pci_tph_cpu_st {
+	__u8  vm_st;        /* Volatile Memory Steering Tag (1 byte) */
+	__u8  pm_st;        /* Persistent Memory Steering Tag (1 byte) */
+	__u16 vm_xst;       /* Volatile Memory Extended Steering Tag (2 bytes) */
+	__u16 pm_xst;       /* Persistent Memory Extended Steering Tag (2 bytes) */
+	__u16 reserved;     /* Padding to 8 bytes for aligned offset lookup */
+} __packed;
+
+#define PCI_TPH_CPU_ST_ENTRY_SZ sizeof(struct pci_tph_cpu_st)
+
 #endif /* _UAPILINUX_PCI_H */
-- 
2.17.1

