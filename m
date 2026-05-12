Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78733D51A
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612389; cv=none; b=CqPVH8SyA8RN4cW2ZCIa64i7wZmvLz8Jb6jxBo6GDJ7/CKUhy1YjvQOZN3bORyNvOXA84yIE7Pk6e6Zc11ir68MJgeELlSYwVFLS6X/GVQa26+XWuXNjZf8Fz+1CongZqiRgdqG+ZvPtuji4arKNkEfvdDX4U5QcmgXGFYJaDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612389; c=relaxed/simple;
	bh=YwPSjgWBXxmNHgud2+hAZxdcZR0T5WBOt9LOtpCJ4K4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnzBqnWCFGqnpAT7gUB5AMXPFSxliFOCFHrSTIw3fte3zZdYyO+RHBg2JnUtxMCFQueV53caMK65U+pIteeqKON99eHjR5/Z38xn/8fbkt0JWer0slHtxTPFdZQHjt6czPfn2w/vwpTKCJA5vWCzXBdTCSK29SU1cilyExKzetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lSoPnRRW; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lSoPnRRW"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CGAR5U2088552
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:59:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4Re1NucPCqEAWwDSkFb+LzzLwT9eUiR/ltTaBQwBdWc=; b=lSoPnRRW3k8X
	p/Qsih9b+tK2icsLZ7XPqpte8VWvochIL3Hl6b+6b0eOtfs42ed5vhA7nDOcXR2c
	i1jmG7cDtHk02R8BNANp4Y/gwyerfJ8h5LpX4oUxn8Ipxd/Xg7F9mVe2kvIEm3zs
	EPQ2iR13lzIM0cXvkWMwH+Cqmw19Y2ofRVGMUyVNGxD/5H+YWr7fdKzaG21i8Z+b
	1yW0kdVTwzpfgFlsvog/tFRv/NIVkwvmG48YKol1rIYeEz+3kyMpw14ZksPjKKt5
	PFrBxcqoJnS58/yQjAp+tZBP2lD59cDWUwskN3JY4ezdBv53wcxxO96U17g6Y1ig
	FBvtfZwBNA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvrtyv4-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:59:46 -0700 (PDT)
Received: from twshared32810.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 12 May 2026 18:59:44 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 0EBD62923917E; Tue, 12 May 2026 11:47:57 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v3 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
Date: Tue, 12 May 2026 11:47:48 -0700
Message-ID: <20260512184755.4137227-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260512184755.4137227-1-zhipingz@meta.com>
References: <20260512184755.4137227-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BMKDalQG c=1 sm=1 tr=0 ts=6a0378a2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8 a=o3qAWRaeB0woPFogT2YA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 48R9b51zkUh5AlYAgQhNMMOylfCMo2hV
X-Proofpoint-ORIG-GUID: 48R9b51zkUh5AlYAgQhNMMOylfCMo2hV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5NiBTYWx0ZWRfX25/yML8vUL5A
 ibGy+tGLm5LIIMBhMJBToGlfUzW4Y1BOp6t67COWtMqRJfdQAd2MpoZLzEliWnqGHtAcY2t9HSm
 ScAXoD9fzXa5+v1LEVWy8rcEvai+wFpwq6Em5t4lVTrm3YhIbT8EUMwLbMozV3Uo/886uCF0IZ7
 GZVAj8vCavLj7RIMqefjm2dXrMLlBk1DHTcTlpJkrXU0nIN6uQar4d7zUiL0/NwmxflE6WNpcDj
 0nPTFclTrf/ev/iqOgb8GwJFMum4c3vFnapkhIyv/MMSXgmf7+Y33zMqzSVcroPjCieHxoaSt+R
 ETDFCDiCdW2dXXr72lm8I32CKPC0IwvyWrZcHCrBbDms7/T3n356OT4l1VFPgFL67JJxZvcf6kT
 vU77hksgK3uiJx+zivrJgJXezzFuigKvSUePBAZ/w46O4zJlq+RlqMmYnDY3P4aMiWvo4UQPC4j
 bsY7EOySjCM7jgO8+eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01

Add a dma-buf callback that returns raw TPH metadata from the exporter
so peer devices can reuse the steering tag and processing hint
associated with a VFIO-exported buffer. Add a new
VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
VFIO_DEVICE_FEATURE_DMA_BUF along with the TPH values, validates the fd
is a vfio-exported dma-buf belonging to this device, and stores the TPH
metadata under memory_lock. The existing VFIO_DEVICE_FEATURE_DMA_BUF
uAPI is unchanged.

8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe TPH
ST table (firmware reports them as separate fields with separate
validity bits in the ACPI _DSM ST table), so the uAPI carries both
values along with a flags field that indicates which value(s) are
valid for this device. The exporter selects the value that matches the
importer's requested width and returns -EOPNOTSUPP if that width is
not present, instead of substituting a value across namespaces.

Publish the TPH fields under memory_lock and gate readers on a
release/acquire on the flags field; this lets get_tph() run lockless
and avoids inverting the memory_lock -> dma_resv_lock ordering set up
by vfio_pci_dma_buf_move(). Convert the @revoked bitfield to a plain bool
so concurrent updates of @revoked (under dma_resv_lock) and the new TPH
fields (under memory_lock) cannot race on a shared bitfield byte.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

---
 drivers/vfio/pci/vfio_pci_core.c   |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c | 113 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |  11 +++
 include/linux/dma-buf.h            |  21 ++++++
 include/uapi/linux/vfio.h          |  35 +++++++++
 5 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
index 3f8d093aacf8..94aa6dd95701 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device =
*device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
+		return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
+							 argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
index f87fd32e4a01..28247602e359 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -19,7 +19,23 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
-	u8 revoked : 1;
+	/*
+	 * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
+	 * consumed by the @get_tph dma-buf callback.
+	 *
+	 * @tph_flags is the publish/consume gate: writers populate
+	 * @steering_tag, @steering_tag_ext and @ph first, then store
+	 * @tph_flags with smp_store_release(); readers do
+	 * smp_load_acquire(&tph_flags) before accessing the value fields.
+	 * @tph_flags =3D=3D 0 means "TPH not set". Writers serialize via
+	 * vdev->memory_lock; readers are lockless to avoid AB-BA against
+	 * the dma_resv_lock held by importers.
+	 */
+	u32 tph_flags;
+	u16 steering_tag;
+	u16 steering_tag_ext;
+	u8 ph;
+	bool revoked;
 };
=20
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -69,6 +85,35 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 	return ret;
 }
=20
+static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steerin=
g_tag,
+				    u8 *ph, u8 st_width)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+	u32 flags;
+
+	flags =3D smp_load_acquire(&priv->tph_flags);
+	if (!flags)
+		return -EOPNOTSUPP;
+
+	switch (st_width) {
+	case 8:
+		if (!(flags & VFIO_DMA_BUF_TPH_ST))
+			return -EOPNOTSUPP;
+		*steering_tag =3D priv->steering_tag;
+		break;
+	case 16:
+		if (!(flags & VFIO_DMA_BUF_TPH_ST_EXT))
+			return -EOPNOTSUPP;
+		*steering_tag =3D priv->steering_tag_ext;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*ph =3D priv->ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment=
,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -101,6 +146,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
=20
 static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
 	.attach =3D vfio_pci_dma_buf_attach,
+	.get_tph =3D vfio_pci_dma_buf_get_tph,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
@@ -331,6 +377,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
 	return ret;
 }
=20
+int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
+				      u32 flags,
+				      struct vfio_device_feature_dma_buf_tph __user *arg,
+				      size_t argsz)
+{
+	struct vfio_device_feature_dma_buf_tph set_tph;
+	struct vfio_pci_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	int ret;
+
+	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(set_tph));
+	if (ret !=3D 1)
+		return ret;
+
+	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
+		return -EFAULT;
+
+	if (set_tph.reserved[0] || set_tph.reserved[1] || set_tph.reserved[2])
+		return -EINVAL;
+
+	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
+		return -EINVAL;
+
+	if (!set_tph.flags)
+		return -EINVAL;
+
+	/* PCIe TLP Processing Hint is a 2-bit field. */
+	if (set_tph.ph & ~0x3)
+		return -EINVAL;
+
+	dmabuf =3D dma_buf_get(set_tph.dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
+		ret =3D -EINVAL;
+		goto out_put;
+	}
+
+	priv =3D dmabuf->priv;
+	down_write(&vdev->memory_lock);
+	if (priv->vdev !=3D vdev) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	priv->steering_tag =3D set_tph.steering_tag;
+	priv->steering_tag_ext =3D set_tph.steering_tag_ext;
+	priv->ph =3D set_tph.ph;
+	/*
+	 * Publish the TPH values before the gate flag, so that lockless
+	 * readers in vfio_pci_dma_buf_get_tph() see fully-initialized
+	 * fields once they observe a non-zero tph_flags.
+	 */
+	smp_store_release(&priv->tph_flags, set_tph.flags);
+	ret =3D 0;
+
+out_unlock:
+	up_write(&vdev->memory_lock);
+out_put:
+	dma_buf_put(dmabuf);
+	return ret;
+}
+
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revok=
ed)
 {
 	struct vfio_pci_dma_buf *priv;
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci=
_priv.h
index fca9d0dfac90..200dd061ea5d 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev *p=
dev)
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32=
 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz);
+int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
+				      u32 flags,
+				      struct vfio_device_feature_dma_buf_tph __user *arg,
+				      size_t argsz);
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revok=
ed);
 #else
@@ -128,6 +132,13 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_d=
evice *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
+static inline int
+vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u32=
 flags,
+				  struct vfio_device_feature_dma_buf_tph __user *arg,
+				  size_t argsz)
+{
+	return -ENOTTY;
+}
 static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device =
*vdev)
 {
 }
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..d6a1b44052fc 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,27 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_tph:
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @steering_tag: Returns the raw TPH steering tag for @st_width
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 * @st_width: Consumer's supported steering tag width in bits (8 or 16)
+	 *
+	 * Return the TPH (TLP Processing Hints) metadata associated with this
+	 * DMA buffer for the requested steering-tag width. 8-bit ST and 16-bit
+	 * Extended ST are distinct namespaces in the PCIe TPH ST table, so the
+	 * exporter must select the value that matches @st_width and must not
+	 * substitute one for the other.
+	 *
+	 * Return 0 on success, -EOPNOTSUPP if no metadata is available for the
+	 * requested width, or -EINVAL if @st_width is not 8 or 16.
+	 *
+	 * This callback is optional.
+	 */
+	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
+		       u8 st_width);
+
 	/**
 	 * @map_dma_buf:
 	 *
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..53b2bbd9fc1e 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,41 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
=20
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) met=
adata
+ * with a vfio-exported dma-buf. The dma-buf must have been created by
+ * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
+ *
+ * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_=
BUF.
+ *
+ * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
+ * distinct namespaces in the PCIe TPH ST table; userspace should popula=
te
+ * the value(s) it has from the firmware ST table for this device and se=
t
+ * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bit in @fl=
ags.
+ * An importer requests a specific width and receives the matching value=
;
+ * if the requested width is not present, the importer is told TPH is
+ * unavailable for this dma-buf.
+ *
+ * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
+ *
+ * The user must set TPH on the dma-buf before the importer consumes it.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
+
+#define VFIO_DMA_BUF_TPH_ST		(1 << 0)  /* steering_tag valid */
+#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)  /* steering_tag_ext valid */
+
+struct vfio_device_feature_dma_buf_tph {
+	__s32	dmabuf_fd;
+	__u32	flags;
+	__u16	steering_tag;
+	__u16	steering_tag_ext;
+	__u8	ph;
+	__u8	reserved[3];
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
--=20
2.52.0

