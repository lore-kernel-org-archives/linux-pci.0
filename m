Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436E3EDAAF;
	Wed,  6 May 2026 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060803; cv=none; b=BzWen/GPoWsDjBorFvNvnDwG3+oUcDrjGzYYCzUmAXn5A7wLbk+9y9IHnpTfwBr/FMc+ad4NI9XhI6DyYothnposHK4PuXoCjQ7SZ2sE3BwgcHrNsxOupYv0PWaH5DeYfERw2wJiJ19VI8mnNXdxpjY9E3A/FfhDFQBncJkTWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060803; c=relaxed/simple;
	bh=XIfyEc91HNmgRzMcr/nSXiOd3IlLvw3qC2jbTjV8R7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnGJzb99a55CEKx60XwfQ/AMNZdA4IUDfXZLSSxVOQY5X659LLT3rgZBbO4H7lZv0op+0B4Kyv7Yh2wn8kgkNiEDB81LAR9iXbO4ep0TMtqv+ZpyRrSM9bLhrv7g0BgGceB+h4Ik4EkGmubuhQW4BnxUxPUdms7CPG0+EZ0CNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5v5FNZz/; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5v5FNZz/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7cLJyVSz2iZJ28Z6iIJQCs50V5QNwqYcrH/C9Q1rhj8=;
	b=5v5FNZz/HJ+FmLfw0M52/ixcy+05xTOyGsunogFcU9uNYq7fgIoTVNanvJSg97kBwcrYSr+Xt
	W9VdUnCH2P6LIgMXRbrMEOlMETqGlQ8qzjYVntEPjhmcLQ076ZPPEEVz0YOWIQ76IfmrKPiMmhI
	RggkiAXLyxjJX4VnnsGQ8e4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4g9Vht4kFgzpSwn;
	Wed,  6 May 2026 17:39:42 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id CF54F40577;
	Wed,  6 May 2026 17:46:31 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 17:46:31 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v6 3/6] vfio/pci: Add PCIe TPH interface with capability query
Date: Wed, 6 May 2026 17:46:20 +0800
Message-ID: <20260506094623.29327-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506094623.29327-1-fengchengwen@huawei.com>
References: <20260506094623.29327-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add VFIO_DEVICE_PCI_TPH IOCTL to allow userspace to query device TPH
capabilities, supported modes, and steering tag table information.

Add module parameter 'enable_unsafe_tph_ds_mode' to restrict unsafe
device-specific TPH mode to trusted userspace only.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c      |  13 ++-
 drivers/vfio/pci/vfio_pci_core.c |  55 ++++++++++++-
 include/linux/vfio_pci_core.h    |   3 +-
 include/uapi/linux/vfio.h        | 131 +++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..40bf5aa9fd0b 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,12 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+#ifdef CONFIG_PCIE_TPH
+static bool enable_unsafe_tph_ds_mode;
+module_param(enable_unsafe_tph_ds_mode, bool, 0444);
+MODULE_PARM_DESC(enable_unsafe_tph_ds_mode, "Enable UNSAFE TPH device-specific (DS) mode. This mode provides weak isolation, cannot be safely used for virtual machines. If you do not know what this is for, step away. (default: false)");
+#endif
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -257,12 +263,17 @@ static int __init vfio_pci_init(void)
 {
 	int ret;
 	bool is_disable_vga = true;
+	bool is_enable_unsafe_tph_ds_mode = false;
 
 #ifdef CONFIG_VFIO_PCI_VGA
 	is_disable_vga = disable_vga;
 #endif
+#ifdef CONFIG_PCIE_TPH
+	is_enable_unsafe_tph_ds_mode = enable_unsafe_tph_ds_mode;
+#endif
 
-	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
+	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3,
+				 is_enable_unsafe_tph_ds_mode);
 
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..d98d04bad4a3 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -29,6 +29,7 @@
 #include <linux/sched/mm.h>
 #include <linux/iommufd.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pci-tph.h>
 #if IS_ENABLED(CONFIG_EEH)
 #include <asm/eeh.h>
 #endif
@@ -41,6 +42,7 @@
 static bool nointxmask;
 static bool disable_vga;
 static bool disable_idle_d3;
+static bool enable_unsafe_tph_ds_mode;
 
 static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
 {
@@ -1461,6 +1463,53 @@ static int vfio_pci_ioctl_ioeventfd(struct vfio_pci_core_device *vdev,
 				  ioeventfd.fd);
 }
 
+static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
+				struct vfio_device_pci_tph_op *op,
+				void __user *uarg)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u8 mode = pcie_tph_get_st_modes(pdev);
+	struct vfio_pci_tph_cap cap = {0};
+
+	if (op->argsz < offsetof(struct vfio_device_pci_tph_op, cap) +
+			sizeof(struct vfio_pci_tph_cap))
+		return -EINVAL;
+
+	if (mode == 0 || mode == PCI_TPH_CAP_ST_NS)
+		return -EOPNOTSUPP;
+
+	if (mode & PCI_TPH_CAP_ST_IV)
+		cap.supported_modes |= VFIO_PCI_TPH_MODE_IV;
+	if (mode & PCI_TPH_CAP_ST_DS)
+		cap.supported_modes |= VFIO_PCI_TPH_MODE_DS;
+
+	if (pcie_tph_get_st_table_loc(pdev) != PCI_TPH_LOC_NONE)
+		cap.st_table_sz = pcie_tph_get_st_table_size(pdev);
+
+	if (copy_to_user(uarg, &cap, sizeof(cap)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
+			      void __user *uarg)
+{
+	struct vfio_device_pci_tph_op op = {0};
+	size_t minsz = sizeof(op.argsz) + sizeof(op.op);
+
+	if (copy_from_user(&op, uarg, minsz))
+		return -EFAULT;
+
+	switch (op.op) {
+	case VFIO_PCI_TPH_GET_CAP:
+		return vfio_pci_tph_get_cap(vdev, &op, uarg + minsz);
+	default:
+		/* Other ops are not implemented yet */
+		return -EINVAL;
+	}
+}
+
 long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
 			 unsigned long arg)
 {
@@ -1483,6 +1532,8 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
 		return vfio_pci_ioctl_reset(vdev, uarg);
 	case VFIO_DEVICE_SET_IRQS:
 		return vfio_pci_ioctl_set_irqs(vdev, uarg);
+	case VFIO_DEVICE_PCI_TPH:
+		return vfio_pci_ioctl_tph(vdev, uarg);
 	default:
 		return -ENOTTY;
 	}
@@ -2570,11 +2621,13 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 }
 
 void vfio_pci_core_set_params(bool is_nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3)
+			      bool is_disable_idle_d3,
+			      bool is_enable_unsafe_tph_ds_mode)
 {
 	nointxmask = is_nointxmask;
 	disable_vga = is_disable_vga;
 	disable_idle_d3 = is_disable_idle_d3;
+	enable_unsafe_tph_ds_mode = is_enable_unsafe_tph_ds_mode;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f..5af2a2e04ca7 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -157,7 +157,8 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      const struct vfio_pci_regops *ops,
 				      size_t size, u32 flags, void *data);
 void vfio_pci_core_set_params(bool nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3);
+			      bool is_disable_idle_d3,
+			      bool is_enable_unsafe_tph_ds_mode);
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..f899521e52c6 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1321,6 +1321,137 @@ struct vfio_precopy_info {
 
 #define VFIO_MIG_GET_PRECOPY_INFO _IO(VFIO_TYPE, VFIO_BASE + 21)
 
+/**
+ * struct vfio_pci_tph_cap - PCIe TPH capability information
+ * @supported_modes: Supported TPH operating modes
+ * @st_table_sz: Number of entries in ST table; 0 means no ST table
+ * @reserved: Must be zero
+ *
+ * Used with VFIO_PCI_TPH_GET_CAP operation to return device
+ * TLP Processing Hints (TPH) capabilities to userspace.
+ */
+struct vfio_pci_tph_cap {
+	__u8  supported_modes;
+#define VFIO_PCI_TPH_MODE_IV	(1u << 0) /* Interrupt vector */
+#define VFIO_PCI_TPH_MODE_DS	(1u << 1) /* Device specific */
+	__u8  reserved0;
+	__u16 st_table_sz;
+	__u32 reserved;
+};
+
+/**
+ * struct vfio_pci_tph_ctrl - TPH enable control structure
+ * @mode: Selected TPH operating mode (VFIO_PCI_TPH_MODE_*)
+ * @reserved: Must be zero
+ *
+ * Used with VFIO_PCI_TPH_ENABLE operation to specify the
+ * operating mode when enabling TPH on the device.
+ */
+struct vfio_pci_tph_ctrl {
+	__u8 mode;
+	__u8 reserved[7];
+};
+
+/**
+ * struct vfio_pci_tph_entry - Single TPH steering tag entry
+ * @cpu: CPU identifier for steering tag calculation
+ * @mem_type: Memory type (VFIO_PCI_TPH_MEM_TYPE_*)
+ * @reserved0: Must be zero
+ * @index: ST table index for programming
+ * @st: Unused for SET_ST
+ * @reserved1: Must be zero
+ *
+ * For VFIO_PCI_TPH_GET_ST:
+ *   Userspace sets @cpu and @mem_type; kernel returns @st.
+ *
+ * For VFIO_PCI_TPH_SET_ST:
+ *   Userspace sets @index, @cpu, and @mem_type.
+ *   Kernel internally computes the steering tag and programs
+ *   it into the specified @index.
+ *
+ *   If @cpu == U32_MAX, kernel clears the steering tag at
+ *   the specified @index.
+ */
+struct vfio_pci_tph_entry {
+	__u32 cpu;
+	__u8  mem_type;
+#define VFIO_PCI_TPH_MEM_TYPE_VM	0
+#define VFIO_PCI_TPH_MEM_TYPE_PM	1
+	__u8  reserved0;
+	__u16 index;
+	__u16 st;
+	__u16 reserved1;
+};
+
+/**
+ * struct vfio_pci_tph_st - Batch steering tag request
+ * @count: Number of entries in the array
+ * @reserved: Must be zero
+ * @ents: Flexible array of steering tag entries
+ *
+ * Container structure for batch get/set operations.
+ * Used with both VFIO_PCI_TPH_GET_ST and VFIO_PCI_TPH_SET_ST.
+ */
+struct vfio_pci_tph_st {
+	__u32 count;
+	__u32 reserved;
+	struct vfio_pci_tph_entry ents[];
+#define VFIO_PCI_TPH_MAX_ENTRIES    2048
+};
+
+/**
+ * struct vfio_device_pci_tph_op - Argument for VFIO_DEVICE_PCI_TPH
+ * @argsz: User allocated size of this structure
+ * @op: TPH operation (VFIO_PCI_TPH_*)
+ * @cap: Capability data for GET_CAP
+ * @ctrl: Control data for ENABLE
+ * @st: Batch entry data for GET_ST/SET_ST
+ *
+ * @argsz must be set by the user to the size of the structure
+ * being executed. Kernel validates input and returns data
+ * only within the specified size.
+ *
+ * Operations:
+ * - VFIO_PCI_TPH_GET_CAP: Query device TPH capabilities.
+ * - VFIO_PCI_TPH_ENABLE:  Enable TPH using mode from &ctrl.
+ * - VFIO_PCI_TPH_DISABLE: Disable TPH on the device.
+ * - VFIO_PCI_TPH_GET_ST:  Retrieve CPU's steering tags.
+ *                         Valid only for Device-Specific mode and
+ *                         no ST table is present.
+ * - VFIO_PCI_TPH_SET_ST:  Program steering tags into device table.
+ *                         If any entry fails, previously programmed entries
+ *                         are rolled back to 0 before returning error.
+ */
+struct vfio_device_pci_tph_op {
+	__u32 argsz;
+	__u32 op;
+#define VFIO_PCI_TPH_GET_CAP	0
+#define VFIO_PCI_TPH_ENABLE	1
+#define VFIO_PCI_TPH_DISABLE	2
+#define VFIO_PCI_TPH_GET_ST	3
+#define VFIO_PCI_TPH_SET_ST	4
+	union {
+		struct vfio_pci_tph_cap cap;
+		struct vfio_pci_tph_ctrl ctrl;
+		struct vfio_pci_tph_st st;
+	};
+};
+
+/**
+ * VFIO_DEVICE_PCI_TPH - _IO(VFIO_TYPE, VFIO_BASE + 22)
+ *
+ * IOCTL for managing PCIe TLP Processing Hints (TPH) on
+ * a VFIO-assigned PCI device. Provides operations to query
+ * device capabilities, enable/disable TPH, retrieve CPU's
+ * steering tags, and program steering tag tables.
+ *
+ * Return: 0 on success, negative errno on failure.
+ *         -EOPNOTSUPP: Operation not supported
+ *         -ENODEV: Device or required functionality not present
+ *         -EINVAL: Invalid argument or TPH not supported
+ */
+#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /*
  * Upon VFIO_DEVICE_FEATURE_SET, allow the device to be moved into a low power
  * state with the platform-based power management.  Device use of lower power
-- 
2.17.1

