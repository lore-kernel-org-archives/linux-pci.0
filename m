Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB49318EFF;
	Wed, 15 Apr 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244225; cv=none; b=bbHwzyC/1xxV4jrfFqvuqmgxj4OwQEXn0aNbGzRpXa2ec7B1d98BvgHk4kouW/qb1v1K92KIQiwnayBucP3fY9nsdppHUZCSt2AQXVt319ckaEaUyCgCXpMHW98AW+O1Rbf+sn57IlhwyR4FU+w9Y0aW3Xo2Zs0/Ula6t8KjyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244225; c=relaxed/simple;
	bh=eWgqyhRae6Tlm1UzbVQQnoFE594vqqD0bb/C5dP3sVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHOy3MYW+TdOSiLbHGIXL+rSYJ2GRr9t9XPKePz3krRpFJNYdHtEcsUPWfbPsp6tdnZcngk7ABC9CvrgWjTaGyi0fIpvVHnXLpRwA2zX6UmjRnoyXuQBwTtHyfWlTXaSIIxSG7j48SqiRRyihNyXWCa/P245MFJXfzPpl6BiqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kSC7UOJC; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kSC7UOJC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ozwKrSsjZnb0J3eiqXz1w2jjI92OrNbLu9VFMMnKB0o=;
	b=kSC7UOJCEQYiN1rORu401mr371loZ7NGrhIEb9UC1RvScBNOYlKM2rutvKixFKvJk71VyVISE
	AnjDoD+m0Qmu5UTfmWjYT3b5FqjzA6ljR8uUlaMS8TLy66to4gJIzCXzG69ltEQRGFQ21C0Iuz3
	zw7qJ+yxNMWtvjuc3hM3rDU=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fwZvP2GdFz12LCb;
	Wed, 15 Apr 2026 17:04:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 4975120104;
	Wed, 15 Apr 2026 17:10:19 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 17:10:18 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 1/4] vfio/pci: Add PCIe TPH interface with capability query
Date: Wed, 15 Apr 2026 17:09:56 +0800
Message-ID: <20260415090959.53672-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260415090959.53672-1-fengchengwen@huawei.com>
References: <20260415090959.53672-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add the VFIO_DEVICE_PCI_TPH IOCTL and implement the basic
capability query operation to let userspace discover device
TPH support, supported modes and ST table information.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 56 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 54 ++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d43745fe4c84..35df624439a3 100644
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
@@ -1461,6 +1462,59 @@ static int vfio_pci_ioctl_ioeventfd(struct vfio_pci_core_device *vdev,
 				  ioeventfd.fd);
 }
 
+static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
+				struct vfio_device_pci_tph_op *op,
+				void __user *uarg)
+{
+#ifdef CONFIG_PCIE_TPH
+	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_tph_cap cap = {0};
+	u32 reg;
+
+	if (!pdev->tph_cap)
+		return -EOPNOTSUPP;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+	if (reg & PCI_TPH_CAP_ST_NS)
+		cap.supported_modes |= VFIO_PCI_TPH_MODE_NS;
+	if (reg & PCI_TPH_CAP_ST_IV)
+		cap.supported_modes |= VFIO_PCI_TPH_MODE_IV;
+	if (reg & PCI_TPH_CAP_ST_DS)
+		cap.supported_modes |= VFIO_PCI_TPH_MODE_DS;
+	cap.st_table_present = !!(pcie_tph_get_st_table_loc(pdev) != PCI_TPH_LOC_NONE);
+	cap.st_table_sz = pcie_tph_get_st_table_size(pdev);
+
+	if (copy_to_user(uarg, &cap, sizeof(cap)))
+		return -EFAULT;
+
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
+			      void __user *uarg)
+{
+	struct vfio_device_pci_tph_op op;
+	size_t minsz;
+
+	if (copy_from_user(&op, uarg, sizeof(op.argsz) + sizeof(op.op)))
+		return -EFAULT;
+
+	minsz = offsetof(struct vfio_device_pci_tph_op, cap);
+	if (op.argsz < minsz)
+		return -EINVAL;
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
@@ -1483,6 +1537,8 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
 		return vfio_pci_ioctl_reset(vdev, uarg);
 	case VFIO_DEVICE_SET_IRQS:
 		return vfio_pci_ioctl_set_irqs(vdev, uarg);
+	case VFIO_DEVICE_PCI_TPH:
+		return vfio_pci_ioctl_tph(vdev, uarg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index bb7b89330d35..f3f79f43cee9 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1307,6 +1307,60 @@ struct vfio_precopy_info {
 
 #define VFIO_MIG_GET_PRECOPY_INFO _IO(VFIO_TYPE, VFIO_BASE + 21)
 
+/* PCIe TPH capability query */
+struct vfio_pci_tph_cap {
+	__u8  supported_modes;
+#define VFIO_PCI_TPH_MODE_NS	(1u << 0) /* No steering */
+#define VFIO_PCI_TPH_MODE_IV	(1u << 1) /* Interrupt vector */
+#define VFIO_PCI_TPH_MODE_DS	(1u << 2) /* Device specific */
+	__u8  st_table_present;	/* Indicates whether ST table present */
+	__u16 st_table_sz;	/* ST table size */
+	__u32 reserved;
+};
+
+/* PCIe TPH enable control */
+struct vfio_pci_tph_ctrl {
+	__u8 mode;	/* VFIO_PCI_TPH_MODE_* */
+	__u8 reserved[7];
+};
+
+/* PCIe TPH steer-tag single entry */
+struct vfio_pci_tph_entry {
+	__u32 cpu;	/* [IN] CPU identifier, used with get/set ops */
+	__u8  mem_type;	/* [IN] Memory type, used with get/set ops */
+#define VFIO_PCI_TPH_MEM_TYPE_VM	0
+#define VFIO_PCI_TPH_MEM_TYPE_PM	1
+	__u8  reserved0;
+	__u16 index;	/* [IN] ST table index, used with set ops */
+	__u16 st;	/* [OUT] steer-tag, used with get ops */
+	__u16 reserved1;
+};
+
+/* PCIe TPH batch steer-tags request */
+struct vfio_pci_tph_st {
+	__u32 count;
+	__u32 reserved;
+	struct vfio_pci_tph_entry ents[];
+};
+
+/* IOCTL argument for VFIO_DEVICE_PCI_TPH */
+struct vfio_device_pci_tph_op {
+	__u32 argsz;
+	__u32 op;
+#define VFIO_PCI_TPH_GET_CAP	0
+#define VFIO_PCI_TPH_ENABLE	1
+#define VFIO_PCI_TPH_DISABLE	2
+#define VFIO_PCI_TPH_GET_ST	3
+#define VFIO_PCI_TPH_SET_ST	4
+	union {
+		struct vfio_pci_tph_cap cap;	/* GET_CAP: out */
+		struct vfio_pci_tph_ctrl ctrl;	/* ENABLE: in */
+		struct vfio_pci_tph_st st;	/* GET_ST/SET_ST */
+	};
+};
+
+#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /*
  * Upon VFIO_DEVICE_FEATURE_SET, allow the device to be moved into a low power
  * state with the platform-based power management.  Device use of lower power
-- 
2.17.1

