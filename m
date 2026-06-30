Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F33346B4
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859761; cv=none; b=G2RiTOoizFuE35x/LTLtfeD5jy26bxO1PTd7TXBqrWibo3h82GxWcphgQm34N062GVDBoHULRio+UUZNGLTZ+Gr2pTgAm7xamCx0ljNUIvi0JS2FWiqTUEh1gKkyQ1GXwBRFWF/aiThvQHDQSxeLXtzSuHZ9n8z87uPJWNCNIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859761; c=relaxed/simple;
	bh=5g+22e29fOYvauZYw4YuZAH1yJtq7ZZ4LAcP3Lqgc+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxPFVh7Z3swNzZ4VwR9MHVgQqMsTaXHAvjRgJygIbfJ1zKjt2WobVDZJutWOOoWYTwKmk2xfVx8eJ+40orLPY7+3sQrbDMwdYtamGWQHXGyjAOCoI3agmVSrDwQ/JwUS5EI+hmUTC1NFEmS4dgmRmyAcmNYUMlsHLZ7PartHOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=sXWO/gCJ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="sXWO/gCJ"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65ULIWhQ2183873
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:49:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=V5HrMD4GpsJgMd6AuQBQhQ8l07qeCG1Yb2K7nW2bncQ=; b=sXWO/gCJKB6p
	hR7ztrJgNBjK/8MHFQUfeAbV2zr9Q04EP00do4YahQrqWYVcoupWMXsp+RNUcr/G
	WiEepTNy3g/dcGlPgWfNqhLqGkfaL5AcVngD/ePEDeAeYIhrkT/aG+FOMMCBlGbT
	SKnHx5ot2AasueEiCNJuAg4m7Kzq0gDVcKNYVTh3OjVy9HxbujpdZkh3X100OCwl
	oSs5a1lFvia09fSxekT2F4lkLRzt79Loarp8QvnMXpFgGFiaRBY1Vl283076qw0e
	hVt8fzEVbJ+urUET1z4IglkWShNjWMPoivfwmv4erzzEUW4qL3lPvxM3aDRD6Pf8
	UB9YxsukJg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4f456aqxe6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:49:18 -0700 (PDT)
Received: from twshared122966.16.frc2.facebook.com (2620:10d:c085:108::150d)
 by mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 30 Jun 2026 22:49:15 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 50AD040C59C2E; Tue, 30 Jun 2026 15:43:31 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael
 Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson
	<alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v10 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
Date: Tue, 30 Jun 2026 15:42:25 -0700
Message-ID: <20260630224328.3218796-4-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260630224328.3218796-1-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OHkDIQz_RqL-reD9Q4GQLSkOjoFmK1-L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIyMiBTYWx0ZWRfX+IIQcIQAdc2a
 Z7XmqKschiZb3krPZ53IFsHmm+baBzVa/lWsUB1jSAhkL2eQmpMgKO+sFGlXhQmrhK/DtiXrPiJ
 GGP6T+KulaupAQpgxckhvwfxzgScSWY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIyMiBTYWx0ZWRfX3UWmjFMSx2zn
 xTdMfi3ZaHAUQqPYUhwRbCGcuRavpyLUYDhL93Vy5coX80mKCv4x57KWp10Ep9uOSzR+UzMcSBq
 3gxIDbBrxuVAOL0QQyajyq0bcEN3oEJI3Y7Hxvpz94ZUd/jBdi+Fkij3zvOrZHvz0yuxcewZdV3
 RXqiyWCaEfY1M6I7roIq5neVrKmVsF7Ka0FEAdOatc3oRiVqI+p6iRoC/69NqeFSwl+GRBAGL9u
 2iVQEGLMOiG9bkTsSaIsw+/upl+iQbW/UwxWpwpTzAAgnQtAOUUwcss0XSDoVTW+jzF8FUFsHtf
 7PkmdKX+qQjNGPfOzgvi8CNnraJ20wHn3EKN0MeHYrXw9Ctyzjrk6RSnXMrr8VXyiuvfNCH78jR
 BKCcWgfNuOzum/3v6YdHxFIcW8ZAARVxs+pqJ861kNVyBkv40jJBSYsIqPTGaPkpFG4qA6pJMP5
 zs6T0+6s1MKnODwGIcQ==
X-Proofpoint-GUID: OHkDIQz_RqL-reD9Q4GQLSkOjoFmK1-L
X-Authority-Analysis: v=2.4 cv=euDvCIpX c=1 sm=1 tr=0 ts=6a4447ee cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VabnemYjAAAA:8 a=jp8Fuoutt1YJt9GT4a8A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01

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

Reject requests the device cannot consume as a completer:
pcie_tph_completer_type() must report at least
PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
gate so the feature only probes as supported when the device can really
consume it.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c   |  3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c | 99 +++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
 include/uapi/linux/vfio.h          | 43 +++++++++++++
 4 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
index a28f1e99362c..c7d6902bc61b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1572,6 +1572,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device =
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
index c16f460c01d6..8de72f9e7502 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -3,6 +3,7 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pci-tph.h>
 #include <linux/dma-resv.h>
=20
 #include "vfio_pci_priv.h"
@@ -19,7 +20,14 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
-	u8 revoked : 1;
+
+	/* Protected by dmabuf->resv. */
+	u16 tph_st_ext;
+	u8 tph_st;
+	bool revoked;
+	u8 tph_st_valid:1;
+	u8 tph_st_ext_valid:1;
+	u8 tph_ph:2;
 };
=20
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -30,7 +38,7 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmab=
uf,
 	if (!attachment->peer2peer)
 		return -EOPNOTSUPP;
=20
-	if (priv->revoked)
+	if (READ_ONCE(priv->revoked))
 		return -ENODEV;
=20
 	if (!dma_buf_attach_revocable(attachment))
@@ -69,6 +77,26 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 	return ret;
 }
=20
+static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool ext=
ended,
+					u16 *steering_tag, u8 *ph)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (extended) {
+		if (!priv->tph_st_ext_valid)
+			return -EOPNOTSUPP;
+		*steering_tag =3D priv->tph_st_ext;
+	} else {
+		if (!priv->tph_st_valid)
+			return -EOPNOTSUPP;
+		*steering_tag =3D priv->tph_st;
+	}
+	*ph =3D priv->tph_ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment=
,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -101,6 +129,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
=20
 static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
 	.attach =3D vfio_pci_dma_buf_attach,
+	.get_pci_tph =3D vfio_pci_dma_buf_get_pci_tph,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
@@ -333,6 +362,72 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
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
+	u8 comp;
+	int ret;
+
+	comp =3D pcie_tph_completer_type(vdev->pdev);
+	if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
+		return -EOPNOTSUPP;
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
+	if (set_tph.ph & ~0x3)
+		return -EINVAL;
+
+	if ((set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT) &&
+	    comp !=3D PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
+		return -EOPNOTSUPP;
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
+	if (priv->vdev !=3D vdev) {
+		ret =3D -EINVAL;
+		goto out_put;
+	}
+
+	ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);
+	if (ret)
+		goto out_put;
+
+	priv->tph_st         =3D set_tph.steering_tag;
+	priv->tph_st_ext     =3D set_tph.steering_tag_ext;
+	priv->tph_ph         =3D set_tph.ph;
+	priv->tph_st_valid   =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
+	priv->tph_st_ext_valid =3D
+		!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
+	dma_resv_unlock(dmabuf->resv);
+	ret =3D 0;
+
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
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..4c1c70aac150 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,49 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
=20
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) met=
adata
+ * with a vfio-exported dma-buf. The dma-buf must have been created by
+ * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must repor=
t
+ * TPH Completer support in Device Capabilities 2 (bits 13:12); requests
+ * carrying VFIO_DMA_BUF_TPH_ST_EXT additionally require the device to
+ * report the Extended TPH Completer encoding. Otherwise the ioctl
+ * returns -EOPNOTSUPP.
+ *
+ * @dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA=
_BUF.
+ *
+ * 8-bit ST (@steering_tag) and 16-bit Extended ST (@steering_tag_ext) a=
re
+ * distinct namespaces. @flags is the authoritative validity mask for th=
e
+ * two namespaces: VFIO_DMA_BUF_TPH_ST marks @steering_tag valid and
+ * VFIO_DMA_BUF_TPH_ST_EXT marks @steering_tag_ext valid. An importer
+ * requests one namespace and receives the matching value.
+ *
+ * Each SET fully replaces the dma-buf's TPH state for future queries
+ * only. A namespace whose flag bit is clear is reported as unsupported
+ * to future importers; an importer that has already retrieved a value
+ * is unaffected. @flags =3D=3D 0 leaves both namespaces unsupported for
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
=20
 /**
--=20
2.53.0-Meta

