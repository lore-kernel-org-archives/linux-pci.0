Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B436F419;
	Tue, 14 Jul 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025835; cv=none; b=p3Rc5zubmj1BeUNaGjCPZvzids/yJ+LRCtesibNtv6gt9EMQ90rv5Gdwp5IuSw9nmc8DV16lBaAdWGQrq/pcz1P5Eh/2goExICy+1ZWXaWei0n0UGuZTbZu0K8aKdVuWUDA20OJLuUSaoLzv98GAhQERmY6k9bQCGCOdRkiN2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025835; c=relaxed/simple;
	bh=jv16ygj9H3uuqh7MMgQ5U4c9fqqT0oyQbxBno59GCgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/RCs9PjsendxK5PvW0L2aAbW6YElRTsbRtcI0S7CnfOfeRLe+voYGClXNedfjK1/dshgf7s3Qc318MFPJdBUENDByY+ZBAGw81kvOxDVqJ3sRto4JdYGFJUOxIB0qTYDYWJ8h+ur5OB9WLTZW/k7Ght5BCBX94HVCb9uDdl/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HL7QpwZb; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HL7QpwZb; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HL7QpwZb";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HL7QpwZb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lM8lpB/I5Yf6GRgeD6ZGDXm60DYZeJDrGrGUNkzOzrw=;
	b=HL7QpwZbgVPGP7BbK48DezRU7d3IfxfmQbuMlw94S/PmRC1hMG4WYKvof1L3YO858BbZsUbVu
	leNdpZ+cTm/NFhxXLOjJqPWEoObQ/qtMy3AhMQgJ2ZizjxhgJ59kr0vZJbQDGH9oY2TldzAI4+P
	T8oq7OddY84s4LBCYjIuXv4=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4gzwrJ6yKXz126M0Y;
	Tue, 14 Jul 2026 18:43:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lM8lpB/I5Yf6GRgeD6ZGDXm60DYZeJDrGrGUNkzOzrw=;
	b=HL7QpwZbgVPGP7BbK48DezRU7d3IfxfmQbuMlw94S/PmRC1hMG4WYKvof1L3YO858BbZsUbVu
	leNdpZ+cTm/NFhxXLOjJqPWEoObQ/qtMy3AhMQgJ2ZizjxhgJ59kr0vZJbQDGH9oY2TldzAI4+P
	T8oq7OddY84s4LBCYjIuXv4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gzwf30xPFzcb0f;
	Tue, 14 Jul 2026 18:34:19 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FFCA203B8;
	Tue, 14 Jul 2026 18:43:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:32 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 03/16] vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
Date: Tue, 14 Jul 2026 18:43:12 +0800
Message-ID: <20260714104325.54444-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260714104325.54444-1-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

From: Zhiping Zhang <zhipingz@meta.com>

Implement dma-buf get_pci_tph for vfio-pci exported dma-bufs and add
VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
for a VFIO-owned device.

8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
uAPI carries both with explicit validity flags, and get_pci_tph()
returns the value matching the importer's requested namespace or
-EOPNOTSUPP.

Publish and read the TPH descriptor under dmabuf->resv, matching the
locking used for other importer-visible dma-buf state. The SET ioctl
takes dma_resv_lock_interruptible(), while the callback runs under
DMA-buf's asserted resv lock.

The attach path reads @revoked without holding memory_lock. Annotate it
with READ_ONCE() to document this intentional lockless access: the read
is a benign early-out, and a racing revocation is re-checked under
dmabuf->resv in vfio_pci_dma_buf_map() before any mapping is handed out.
The annotation only needs to keep the access well-formed against the
memory_lock-protected writers.

Reject requests the device cannot consume as a completer:
pcie_tph_completer_type() must report at least
PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
gate so the feature only probes as supported when the device can really
consume it.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c   |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c | 102 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |  12 ++++
 include/uapi/linux/vfio.h          |  43 ++++++++++++
 4 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f11a9624b9c..4e5e34a77b76 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1625,6 +1625,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
+		return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
+							 argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..5351839c1338 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -3,6 +3,7 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pci-tph.h>
 #include <linux/dma-resv.h>
 
 #include "vfio_pci_priv.h"
@@ -19,7 +20,17 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
-	u8 revoked : 1;
+
+	/*
+	 * Updates protected by dmabuf->resv, @revoked additionally
+	 * protected by memory_lock.
+	 */
+	u16 tph_st_ext;
+	u8 tph_st;
+	bool revoked;
+	u8 tph_st_valid:1;
+	u8 tph_st_ext_valid:1;
+	u8 tph_ph:2;
 };
 
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -30,7 +41,7 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 	if (!attachment->peer2peer)
 		return -EOPNOTSUPP;
 
-	if (priv->revoked)
+	if (READ_ONCE(priv->revoked))
 		return -ENODEV;
 
 	if (!dma_buf_attach_revocable(attachment))
@@ -69,6 +80,26 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
 	return ret;
 }
 
+static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
+					u16 *steering_tag, u8 *ph)
+{
+	struct vfio_pci_dma_buf *priv = dmabuf->priv;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (extended) {
+		if (!priv->tph_st_ext_valid)
+			return -EOPNOTSUPP;
+		*steering_tag = priv->tph_st_ext;
+	} else {
+		if (!priv->tph_st_valid)
+			return -EOPNOTSUPP;
+		*steering_tag = priv->tph_st;
+	}
+	*ph = priv->tph_ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -101,6 +132,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
 
 static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
 	.attach = vfio_pci_dma_buf_attach,
+	.get_pci_tph = vfio_pci_dma_buf_get_pci_tph,
 	.map_dma_buf = vfio_pci_dma_buf_map,
 	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
 	.release = vfio_pci_dma_buf_release,
@@ -333,6 +365,72 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	return ret;
 }
 
+int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
+				      u32 flags,
+				      struct vfio_device_feature_dma_buf_tph __user *arg,
+				      size_t argsz)
+{
+	struct vfio_device_feature_dma_buf_tph set_tph;
+	struct vfio_pci_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	u8 comp;
+	int ret;
+
+	comp = pcie_tph_completer_type(vdev->pdev);
+	if (comp == PCI_EXP_DEVCAP2_TPH_COMP_NONE)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(set_tph));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
+		return -EFAULT;
+
+	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
+		return -EINVAL;
+
+	if (set_tph.ph & ~0x3)
+		return -EINVAL;
+
+	if ((set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT) &&
+	    comp != PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
+		return -EOPNOTSUPP;
+
+	dmabuf = dma_buf_get(set_tph.dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
+		ret = -EINVAL;
+		goto out_put;
+	}
+
+	priv = dmabuf->priv;
+	if (priv->vdev != vdev) {
+		ret = -EINVAL;
+		goto out_put;
+	}
+
+	ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
+	if (ret)
+		goto out_put;
+
+	priv->tph_st         = set_tph.steering_tag;
+	priv->tph_st_ext     = set_tph.steering_tag_ext;
+	priv->tph_ph         = set_tph.ph;
+	priv->tph_st_valid   = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
+	priv->tph_st_ext_valid =
+		!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
+	dma_resv_unlock(dmabuf->resv);
+	ret = 0;
+
+out_put:
+	dma_buf_put(dmabuf);
+	return ret;
+}
+
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 {
 	struct vfio_pci_dma_buf *priv;
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..c58f369be4b3 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz);
+int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
+				      u32 flags,
+				      struct vfio_device_feature_dma_buf_tph __user *arg,
+				      size_t argsz);
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
 #else
@@ -128,6 +132,14 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
+
+static inline int
+vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u32 flags,
+				  struct vfio_device_feature_dma_buf_tph __user *arg,
+				  size_t argsz)
+{
+	return -ENOTTY;
+}
 static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 {
 }
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..4c1c70aac150 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,49 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
+ * with a vfio-exported dma-buf. The dma-buf must have been created by
+ * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must report
+ * TPH Completer support in Device Capabilities 2 (bits 13:12); requests
+ * carrying VFIO_DMA_BUF_TPH_ST_EXT additionally require the device to
+ * report the Extended TPH Completer encoding. Otherwise the ioctl
+ * returns -EOPNOTSUPP.
+ *
+ * @dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
+ *
+ * 8-bit ST (@steering_tag) and 16-bit Extended ST (@steering_tag_ext) are
+ * distinct namespaces. @flags is the authoritative validity mask for the
+ * two namespaces: VFIO_DMA_BUF_TPH_ST marks @steering_tag valid and
+ * VFIO_DMA_BUF_TPH_ST_EXT marks @steering_tag_ext valid. An importer
+ * requests one namespace and receives the matching value.
+ *
+ * Each SET fully replaces the dma-buf's TPH state for future queries
+ * only. A namespace whose flag bit is clear is reported as unsupported
+ * to future importers; an importer that has already retrieved a value
+ * is unaffected. @flags == 0 leaves both namespaces unsupported for
+ * future importers.
+ *
+ * @ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
+ *
+ * Undefined @flags and @ph bits must always be zero.
+ *
+ * Userspace must configure TPH before handing the dma-buf fd to an
+ * importer.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
+
+#define VFIO_DMA_BUF_TPH_ST		(1 << 0)
+#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)
+
+struct vfio_device_feature_dma_buf_tph {
+	__s32	dmabuf_fd;
+	__u32	flags;
+	__u16	steering_tag_ext;
+	__u8	steering_tag;
+	__u8	ph;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

