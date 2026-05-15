Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFE4014B2;
	Fri, 15 May 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838053; cv=none; b=rYbubG7ZdPMNFtfd+KhIQxBuLKT8OB+PSljLIsEt5qSEnhn+nCJeYzehc3g6QfxVMhhS4Wpxd5hbjXqPl4XC1WYUTbUzwZb7xrj18zKKFKFj8mlMKeD6lbiTxZ3lwk2eeTgDSIva1EHgAoaXy8/PhcOsOBiblaOENso1ZStiwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838053; c=relaxed/simple;
	bh=MP1scr7Tn2Wz7CNC4w0dZph7MGXbzqJZqTVc+OeQmns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqh+hFiOwCOD+5r7hqywDRgdHzNwSG3m9BDsHMu+6eosdIW47aDmYOeql45l70wz6c1GMuVJHs2pFSX/os1OGfAk0X9r8+jE5onxRIR+wftmvvWSj9JlwWYE+n0701YLo/mUugxYq9jbWen6qe7bVCsUF9z+jPWxm0fynntKGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PPhioNH7; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PPhioNH7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HoQ30A9An0SdWKg2N3rE7nfb3sw1fZBuKMG6Db9Wn0g=;
	b=PPhioNH7Ru3DN3tZ6TWXJoOpOWFN3w/lhHhLTfiphGE1XwoY508Xe+vQhIExQr9vKX5TT4YlF
	mrqSn22qMm4NZCV1p5+LaLrfIVNaYTn2YVbzOgHlgxQT/Y2I2GsiJol2xaQEWVWvf8P/FVHzjt/
	w3VrcT8t4WakG1gjY/PTjB0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gH27r6Hz5z12LGP;
	Fri, 15 May 2026 17:33:44 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id E56DA2025F;
	Fri, 15 May 2026 17:40:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 May 2026 17:40:48 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 5/5] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH ST entry management
Date: Fri, 15 May 2026 17:40:40 +0800
Message-ID: <20260515094040.38496-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260515094040.38496-1-fengchengwen@huawei.com>
References: <20260515094040.38496-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add VFIO_DEVICE_FEATURE_TPH_ST to allow userspace to manage PCIe TPH
Steering Tag entries.

SET: Program contiguous ST entries when ST table resides in TPH Capability
     or MSI-X table. U32_MAX CPU ID clears the corresponding ST entry.
GET: Retrieve ST values per CPU ID, only available in DS mode.

Both operations are only valid when TPH is enabled on the device.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 89 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 41 +++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index cc13fc8eea9d..13304a37ba26 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1521,6 +1521,93 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
+					u32 flags,
+					struct vfio_device_feature_tph_st __user *arg,
+					size_t argsz)
+{
+	bool is_set = !!(flags & VFIO_DEVICE_FEATURE_SET);
+	struct vfio_device_feature_tph_st tph_st;
+	struct pci_dev *pdev = vdev->pdev;
+	enum tph_mem_type mtype;
+	int i, j, ret;
+	u32 *cpus;
+	u16 st;
+
+	if (!enable_unsafe_tph ||
+		pcie_tph_enabled_mode(pdev) == PCI_TPH_ST_NS_MODE)
+		return -EOPNOTSUPP;
+	if (!is_set && pcie_tph_enabled_mode(pdev) != PCI_TPH_ST_DS_MODE)
+		return -EOPNOTSUPP;
+	if (is_set && pcie_tph_get_st_table_loc(pdev) == PCI_TPH_LOC_NONE)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz,
+				 VFIO_DEVICE_FEATURE_GET |
+				 VFIO_DEVICE_FEATURE_SET,
+				 sizeof(tph_st));
+	if (ret <= 0)
+		return ret;
+
+	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
+		return -EFAULT;
+
+	if (tph_st.count == 0 || tph_st.count > VFIO_TPH_ST_MAX_COUNT ||
+		tph_st.flags > VFIO_TPH_ST_MEM_TYPE_PM)
+		return -EINVAL;
+	if (!is_set && tph_st.index != 0)
+		return -EINVAL;
+	if (is_set && (tph_st.index >= VFIO_TPH_ST_MAX_COUNT ||
+		       tph_st.index + tph_st.count > VFIO_TPH_ST_MAX_COUNT))
+		return -EINVAL;
+
+	cpus = memdup_array_user(&arg->data, tph_st.count, sizeof(*cpus));
+	if (IS_ERR(cpus))
+		return PTR_ERR(cpus);
+
+	mtype = tph_st.flags & VFIO_TPH_ST_MEM_TYPE_PM ? TPH_MEM_TYPE_PM :
+							 TPH_MEM_TYPE_VM;
+	if (!is_set) {
+		for (i = 0; i < tph_st.count; i++) {
+			ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
+			if (ret)
+				goto out;
+			cpus[i] = st;
+		}
+		goto out;
+	}
+
+	for (i = 0; i < tph_st.count; i++) {
+		if (cpus[i] == U32_MAX) {
+			ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, 0);
+			if (ret)
+				goto out;
+			continue;
+		}
+
+		ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
+		if (ret)
+			goto out;
+		ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, st);
+		if (ret)
+			goto out;
+	}
+
+out:
+	if (!is_set && !ret) {
+		if (copy_to_user(&arg->data, cpus,
+			tph_st.count * sizeof(*cpus)))
+			return -EFAULT;
+	}
+	if (is_set && ret) {
+		/* Roll back previously programmed entries to 0 */
+		for (j = 0; j < i; j++)
+			pcie_tph_set_st_entry(pdev, tph_st.index + j, 0);
+	}
+	kfree(cpus);
+	return ret;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1539,6 +1626,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_ST:
+		return vfio_pci_core_feature_tph_st(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..aca39d4e5307 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,47 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * VFIO_DEVICE_FEATURE_TPH_ST - Get/Set PCIe TPH Steering Tag (ST) entries
+ *
+ * Provides userspace interface to manage PCIe TPH ST table entries.
+ * This feature is only available when device TPH is enabled.
+ *
+ * Upon VFIO_DEVICE_FEATURE_SET:
+ *   Program contiguous ST table entries from the starting @index.
+ *   Valid only for hardware with ST table located in TPH Capability
+ *   space or MSI-X table. If an entry CPU ID is specified as U32_MAX,
+ *   the corresponding ST entry will be cleared. @index and @count define
+ *   the contiguous entry range to be programmed.
+ *   If any entry programming fails, the operation will roll back and
+ *   clear all entries that were successfully programmed before the error.
+ *
+ * Upon VFIO_DEVICE_FEATURE_GET:
+ *   Retrieve the ST value mapped to each given CPU ID in the @data array.
+ *   Userspace fills @data with CPU ID array, the interface returns each
+ *   CPU's corresponding ST value back in place.
+ *   Valid only when TPH DS mode is enabled.
+ *
+ * @flags: Operation flags (VFIO_TPH_ST_MEM_TYPE_*).
+ * @index: Starting ST entry index, only valid for FEATURE_SET.
+ * @count: Number of contiguous entries to access.
+ * @data: Array of CPU IDs for both SET and GET. On SET it programs ST for
+ *        each CPU; on GET it returns the mapped ST value of each CPU.
+ *
+ * This feature is gated by enable_unsafe_tph module parameter.
+ */
+#define VFIO_DEVICE_FEATURE_TPH_ST	13
+
+struct vfio_device_feature_tph_st {
+	__u32 flags;
+#define VFIO_TPH_ST_MEM_TYPE_VM		(0U << 0)
+#define VFIO_TPH_ST_MEM_TYPE_PM		(1U << 0)
+	__u16 index;
+	__u16 count;
+#define VFIO_TPH_ST_MAX_COUNT		2048
+	__u32 data[] __counted_by(count);
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

