Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47B3B6BF5
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222334; cv=none; b=gNR58vq1TkHR+CIXCfvVeWDFSkPjAkoVY+xPbwZtuTMr+q+FcKYaWMAXqzFOT++DPZjA+RzfGsJeAK+V5vOmUgcAOZ2K65lfW6bOwv+GMLtrNhtgqRpkkz7AQhkXZHtMBOfGeOVhIs4bBB1ZrvybXrPprS8oyzWVKrvz6me+l+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222334; c=relaxed/simple;
	bh=Y2JBpcWquc1YH7pH76JNqWnLgKjaD9byEW/W4nocC7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eO8NLfyg4keuzFVkErYNq/9RStqhpYx0FsaF6m1ZECgP3GOOFkgwLU0bhAn8+vllio3KHfT2cnxeUoZ54B9B88piC8NOZc2syhjUYjOWTzEZuqogcmuGqYSD5cM2f9hSrK5Ijtfc4i4hPAwk5FbsFRmvHwaCJ0ZmwYviA8VG6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DRJlbMFv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DRJlbMFv"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JKJBfS3374226
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:25:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=MxjwXfxDRwobAObXxPBfEEGagVfEEnNzW9JEFBwDEdI=; b=DRJlbMFvLJFV
	tlaDL+Q5oLiDEMY6Z0HWSolbt0kAKc5j/d59esGDPsrQkrXw937gHTYWaxW2YhW7
	w6K7OGorHs5RiE2KkHgTd5QdYoZVStew/VJo2lRx0EIMcyVRIbutaM0o9thdsi6N
	3702sWO++KSO9hx1l3BGxrtZ6JIp4mFd9GYLIY1y0JkI4gpt+QXqepARMGp8h+yX
	YJG2EHU6rPDqs5fyVenW1ZThq4DuBx668EL69vnzW1cjl92jnJakgZA0Qxt9uNna
	c/HIAwg8WWKFMzIYI6zai7tWTydGnaRqIlAFENqOvlNGfm2k0ntsrqsMza1UugsW
	oJqiYamp/A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8xsxr15c-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:25:32 -0700 (PDT)
Received: from twshared17152.01.snb2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 20:25:27 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 059D32F3ADAA4; Tue, 19 May 2026 13:14:04 -0700 (PDT)
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
Subject: [PATCH v4 1/3] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
Date: Tue, 19 May 2026 13:13:49 -0700
Message-ID: <20260519201401.1558410-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519201401.1558410-1-zhipingz@meta.com>
References: <20260519201401.1558410-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIwNCBTYWx0ZWRfX2GmYe7vaTOvd
 gzBdrC6aXSMvb7L4Xxr/fNuola1noaNCyW/zWeJVfYlRuxzEECZ5dxOhwQoz8tpR7/wUpWhRu0q
 10JNI4jFVsFbbQk2STsuJmJPh8PmhmQGfO+EQuA6xlSuQeeAC7gr/MRFw352NzcnvOrUs3vhTtG
 ZkJvVzEVO8cU4Gb71j6wuAL8GjQOE2E6S1pW2iDFyGjMFjaoU4JAYErJPwuiPmWIOdmJSynFaln
 LEGmfgH6HEnddXj6f1p4/xgg/90lSWpHXSZYIskuXKQx87T3xPdJCUUFMFl5zlLgGcM/Cvc1Esg
 1UrHzOMz2dgkFpD0V7DatbMYtFhUGxe3NHSJDop+mI6A2hITC0DIblN6o1YASt1+odV8meY5Nrd
 4b6PP+s6iqKka60XisP0n0mAbz7Z7b5zCYvwPPW6wOi69vFaAZp38qZw+qcxw5q50JF2glxQiuW
 SrWE21LmOsDDhYdqZXw==
X-Proofpoint-GUID: A_0t4yqeiKfxorAKV4UVil4048PRF2MN
X-Proofpoint-ORIG-GUID: A_0t4yqeiKfxorAKV4UVil4048PRF2MN
X-Authority-Analysis: v=2.4 cv=BLyDalQG c=1 sm=1 tr=0 ts=6a0cc73c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=0PJ4RWdglIPwOLgPEPEA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01

Add a dma-buf get_tph callback for exporters to return TPH
(TLP Processing Hints) metadata, and add VFIO_DEVICE_FEATURE_DMA_BUF_TPH
so userspace can attach that metadata to a VFIO-exported dma-buf.

8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
uAPI carries both with explicit validity flags so importers get the
value matching their requested width. SET is write-once per dma-buf;
the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI is unchanged.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c   |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c | 134 +++++++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_priv.h   |  12 +++
 include/linux/dma-buf.h            |  21 +++++
 include/uapi/linux/vfio.h          |  35 ++++++++
 5 files changed, 198 insertions(+), 7 deletions(-)

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
index f87fd32e4a01..be1c65385670 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -19,7 +19,24 @@ struct vfio_pci_dma_buf {
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
+	 * @tph_flags =3D=3D 0 means "TPH not set". Writers publish a non-zero
+	 * value only once per dma-buf and serialize via vdev->memory_lock;
+	 * readers stay lockless to avoid AB-BA against the dma_resv_lock held
+	 * by importers.
+	 */
+	u32 tph_flags;
+	u16 steering_tag_ext;
+	u8 steering_tag;
+	u8 ph;
+	bool revoked;
 };
=20
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -69,6 +86,36 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
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
+	/* Pair with the smp_store_release() in VFIO_DEVICE_FEATURE_DMA_BUF_TPH=
. */
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
@@ -84,16 +131,17 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_at=
tachment *attachment,
 static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
 {
 	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+	struct vfio_pci_core_device *vdev =3D READ_ONCE(priv->vdev);
=20
 	/*
 	 * Either this or vfio_pci_dma_buf_cleanup() will remove from the list.
 	 * The refcount prevents both.
 	 */
-	if (priv->vdev) {
-		down_write(&priv->vdev->memory_lock);
+	if (vdev) {
+		down_write(&vdev->memory_lock);
 		list_del_init(&priv->dmabufs_elm);
-		up_write(&priv->vdev->memory_lock);
-		vfio_device_put_registration(&priv->vdev->vdev);
+		up_write(&vdev->memory_lock);
+		vfio_device_put_registration(&vdev->vdev);
 	}
 	kfree(priv->phys_vec);
 	kfree(priv);
@@ -101,6 +149,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
=20
 static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
 	.attach =3D vfio_pci_dma_buf_attach,
+	.get_tph =3D vfio_pci_dma_buf_get_tph,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
@@ -269,7 +318,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
 		goto err_free_priv;
 	}
=20
-	priv->vdev =3D vdev;
+	WRITE_ONCE(priv->vdev, vdev);
 	priv->nr_ranges =3D get_dma_buf.nr_ranges;
 	priv->size =3D length;
 	ret =3D vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
@@ -331,6 +380,77 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
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
+	if (READ_ONCE(priv->vdev) !=3D vdev) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	/*
+	 * TPH metadata is write-once per dma-buf so that lockless readers only
+	 * have to observe a single release-published transition from 0 -> flag=
s.
+	 */
+	if (READ_ONCE(priv->tph_flags)) {
+		ret =3D -EBUSY;
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
@@ -388,7 +508,7 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_de=
vice *vdev)
=20
 		dma_resv_lock(priv->dmabuf->resv, NULL);
 		list_del_init(&priv->dmabufs_elm);
-		priv->vdev =3D NULL;
+		WRITE_ONCE(priv->vdev, NULL);
 		priv->revoked =3D true;
 		dma_buf_invalidate_mappings(priv->dmabuf);
 		dma_resv_wait_timeout(priv->dmabuf->resv,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci=
_priv.h
index fca9d0dfac90..c58f369be4b3 100644
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
@@ -128,6 +132,14 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_d=
evice *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
+
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
index d1203da56fc5..49eb6ad644a2 100644
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
+	 * Extended ST are distinct namespaces in the PCIe TPH ST table and may
+	 * both be present with different values, so the exporter must select t=
he
+	 * value that matches @st_width and must not substitute one for the oth=
er.
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
index 5de618a3a5ee..a9cb6cbc6ade 100644
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
+ * distinct namespaces in the PCIe TPH ST table and may both be present =
with
+ * different values. Userspace should populate the value(s) it has from =
the
+ * firmware ST table for this device and set the matching VFIO_DMA_BUF_T=
PH_ST /
+ * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a specifi=
c
+ * width and receives the matching value; if the requested width is not
+ * present, the importer is told TPH is unavailable for this dma-buf.
+ *
+ * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
+ *
+ * The user must set TPH on the dma-buf before the importer consumes it.
+ * TPH metadata is write-once per dma-buf; a second SET returns -EBUSY.
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
+	__u8	steering_tag;
+	__u8	ph;
+	__u16	steering_tag_ext;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
--=20
2.53.0-Meta
