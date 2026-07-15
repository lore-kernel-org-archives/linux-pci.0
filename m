Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086FC3CB919
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148674; cv=none; b=gZbOuPSxtBxIxVbXWUvDEV/MxRO68D2GLP+wqDPlV3CRKJzNJb7lQXoaSTBi8jZvHHhe8NO3w7OqQKeL2baJCeUGV3u7YAQZ8EbJJuj65aJC3idGJKGZgO7KasTdh7zT+uH726C2uvLbPPUcAxQ917/TJcPAITTZ8E9QjmSPz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148674; c=relaxed/simple;
	bh=Xwc2mb2oISVV5/DyAYk1dQl0+O04MP/yGMy37+d9YNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5HDvoTzXQw0ZTstXnmAR9QQmS1VQfi08uMpz93tuG4/8TqprCuPpd9egG8dHGiwwm3jiCQPAgfjkOhVvwqjQBeZOViTYFNFkKy51/V7tHnKbhPPO/6Z+u8mpaByFQ6ziwOJMa8URrqybGtyDmhhFiCY3o9vl+0ebD358Dw19RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=s4GNEmg7; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="s4GNEmg7"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKPsRA1082404
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:51:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=SRerVsjFZQo0Jm80gmOoJFgaIOfsj+PyflVzjvsJyC4=; b=s4GNEmg724F5
	RL6CbuWVBk08o9nWyfAw3Fya6O+1TP+8aKpW7RX8y8+NUu1au3nbJOav5HLaWVrA
	AOqf2pnRQW5spLD1lGzfRmFeJ3eiPgj4v3FjuXsUwLwpuPidSyzBd+c5Wnv/fJq2
	02P1MVtREa4gDP48AlGMmljSEEIRmoMuIFQEWvRMYfALJoVEzazy8Z2H/J41rWKQ
	oQSgwLKoiI4XBFApqhNCCRN2EzSkalvOBeUJMe6b7Mc3jWAHpf14ruSbqC7VBGkE
	Vcez/FM1bhhjX7N7FxqJXVqhDdTSt1dRfMrAOJWV5fiQUeiXpC0CuaNCV+5CUG6u
	JuXJhE8SpA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fdqss9rb6-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:51:08 -0700 (PDT)
Received: from twshared10463.03.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 15 Jul 2026 20:51:04 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id B95BC423AA09C; Wed, 15 Jul 2026 13:40:13 -0700 (PDT)
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
Subject: [PATCH v12 4/4] RDMA/mlx5: get tph for p2p access when registering dma-buf mr
Date: Wed, 15 Jul 2026 13:39:59 -0700
Message-ID: <20260715204008.3911275-5-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715204008.3911275-1-zhipingz@meta.com>
References: <20260715204008.3911275-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a57f2bc cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8 a=CbDCq_QkAAAA:8
 a=1stQPSrnH06VPgbTlAkA:9 a=gKebqoRLp9LExxC7YDUY:22 a=1qrBK16LubpBFNPVNq2M:22
X-Proofpoint-ORIG-GUID: 1uXUqGvIHTNsDZgpkxJHgwu38eRnJ_-j
X-Proofpoint-GUID: 1uXUqGvIHTNsDZgpkxJHgwu38eRnJ_-j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfXxEyEP5+NO+f2
 opBn+GFEBIhRYc8QnQme+HWJV7MDhuKuOiagl1euMhCSNdirggURg2X+SatCa5tzJcX/zejwzkl
 O5aP1mxteksfC77ciCU00uE9+ki+P0I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfXz7X3IIPMCjD5
 HKzf7jYnnZuiLWCCLY1V8KPOLZWRV8LeueOKjrMRoirFogPsXhrinuAPoMWAyLXpbHM4qkjaNtx
 +Kge32x3M8yc4zicu/ytQjjtBgDX33JheHA+Oo9PJujl4VzwrbhtXVBrDk8M1H6e9M1FwaFI/EK
 MynKkeWwaT6JIi+iB/Wa67TjtDX4v0HyWTkaQW0WOY0lR6PGAykfvbuwM+74eUkTxww924aX+/R
 +XJXzCp0dO1hXhZzjjFWBSmL9r5dJUyhJAGlPbctJKq7lXQzTFkPzGWXWmPo5s5TCbc4+UDYZ8x
 lWqQr3FG9mgWqXvXTbhcuOn77KPlKsZMEZtrWhVjW2WKUcqcLIvOz+XILITCOhLrwxLhc7MP6t9
 IyP35NFRZxd8/7OB+BitFzYzpMqIf3gM6HbKPWED0pOXFQkeQmxprFodQhErR2YeLCYTsRuYNrC
 brDdHfvlch6BAda6YYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01

Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
(typically a GPU or a vfio-pci passthrough device) traverses the host
PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
Processing Hint (TPH) Steering Tag yields the best placement for the
traffic it will sink: per-endpoint hint selection lets the root complex
or switch direct DMA to a specific cache slice / NUMA node, cutting
cross-socket snoop traffic and DRAM pressure under sustained p2p
workloads.

Until now the mlx5 importer had no way to learn the exporter's chosen
ST tag, so dma-buf MRs were registered without TPH and ran with the
default (no-hint) routing. With dma_buf_get_pci_tph() in place this
patch wires up mlx5_ib to query that metadata at MR registration time
for p2p access and use it to program requester-side TPH on the outbound
mkey. If the exporter has no metadata, fall back to the existing
no-TPH path so behavior for non-TPH-aware exporters is unchanged.

Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
steering tags into local ST entries when table mode is active, and add
mlx5_st_get_index() for DMAH-backed flows that already carry an ST
index.

For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
lifetime rather than pooled mkey lifetime. Acquire the ref before MR
creation and release it again when the MR is returned to the pool or
the backing mkey is destroyed, while leaving the generic FRMR pool
core unchanged.

The exporter's steering tag is only valid for the mapping it was queried
against (see dma_buf_get_pci_tph()). The mkey's TPH fields cannot be
reprogrammed in place: they are create-time fields with no UMR update
mask, and rebuilding the mkey would change the rkey/lkey, which must stay
stable across invalidate/refault.

Keep the registration-time TPH tuple in the MR and re-query the exporter
after each dma-buf mapping is established under dmabuf->resv. If the
tuple is unchanged, continue using the existing mkey. If the tuple change=
d
or disappeared, unmap the pages and return -EFAULT rather than continue
with a stale mkey hint; userspace must create a new MR to get a mkey
programmed with the new tuple. For vfio-pci BAR dma-bufs this validation
is expected to be a no-op because invalidation is revoke/quiesce of BAR
access, not movement to a different backing placement, and the
userspace-provided TPH tuple is not changed by the revoke/un-revoke path.

Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
modular mlx5_ib builds link cleanly.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
 drivers/infiniband/hw/mlx5/mr.c               | 151 +++++++++++++++++-
 drivers/infiniband/hw/mlx5/odp.c              |   7 +
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++-
 include/linux/mlx5/driver.h                   |  15 ++
 6 files changed, 220 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/ml=
x5/main.c
index 02809114fc79..a2b497f6b16b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -60,6 +60,7 @@
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX s=
eries) IB driver");
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS("DMA_BUF");
=20
 struct mlx5_ib_event_work {
 	struct work_struct	work;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw=
/mlx5/mlx5_ib.h
index 522984d958bb..c6a956b2ee87 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -646,6 +646,15 @@ enum mlx5_mkey_type {
 /* Used for non-existent ph value */
 #define MLX5_IB_NO_PH 0xff
=20
+struct dma_buf;
+
+struct mlx5_ib_dmabuf_tph {
+	u16 steering_tag;
+	u8 ph;
+	bool extended;
+	bool valid;
+};
+
 struct mlx5_ib_mkey {
 	u32 key;
 	enum mlx5_mkey_type type;
@@ -726,6 +735,7 @@ struct mlx5_ib_mr {
 			u8 revoked :1;
 			/* Indicates previous dmabuf page fault occurred */
 			u8 dmabuf_faulted:1;
+			struct mlx5_ib_dmabuf_tph dmabuf_tph;
 			struct mlx5_ib_mkey null_mmkey;
 		};
 	};
@@ -1341,6 +1351,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *i=
b_mr, int flags, u64 start,
 				    u64 length, u64 virt_addr, int access_flags,
 				    struct ib_pd *pd, struct ib_udata *udata);
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
+int mlx5_ib_validate_dmabuf_tph(struct mlx5_ib_mr *mr, struct dma_buf *d=
mabuf);
 struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type=
,
 			       u32 max_num_sg);
 struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index e6b74955d95d..404c5d081b8a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -39,6 +39,7 @@
 #include <linux/delay.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-resv.h>
+#include <linux/pci-tph.h>
 #include <rdma/frmr_pools.h>
 #include <rdma/ib_umem_odp.h>
 #include "dm.h"
@@ -167,6 +168,61 @@ static int get_unchangeable_access_flags(struct mlx5=
_ib_dev *dev,
 #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
 #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
=20
+static u8 mlx5_ib_tph_key_ph(u8 ph)
+{
+	if (ph =3D=3D MLX5_IB_NO_PH || ph =3D=3D 0)
+		ph ^=3D MLX5_IB_NO_PH;
+
+	return ph;
+}
+
+static int mlx5_ib_get_st_handle_ref(struct mlx5_ib_dev *dev, u16 st_ind=
ex)
+{
+	if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+		return 0;
+
+	return mlx5_st_get_index(dev->mdev, st_index);
+}
+
+static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_ind=
ex)
+{
+	if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+		return;
+
+	mlx5_st_dealloc_index(dev->mdev, st_index);
+}
+
+static void mlx5_ib_put_st_handle_ref(struct mlx5_ib_dev *dev,
+				      u64 kernel_vendor_key)
+{
+	u16 st_index =3D FIELD_GET(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK,
+				 kernel_vendor_key);
+
+	mlx5_ib_put_st_index_ref(dev, st_index);
+}
+
+int mlx5_ib_validate_dmabuf_tph(struct mlx5_ib_mr *mr, struct dma_buf *d=
mabuf)
+{
+	struct mlx5_ib_dmabuf_tph *tph =3D &mr->dmabuf_tph;
+	u16 steering_tag;
+	u8 ph;
+	int ret;
+
+	if (!tph->valid)
+		return 0;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	ret =3D dma_buf_get_pci_tph(dmabuf, tph->extended, &steering_tag, &ph);
+	if (ret)
+		return -EFAULT;
+
+	if (steering_tag !=3D tph->steering_tag || ph !=3D tph->ph)
+		return -EFAULT;
+
+	return 0;
+}
+
 static struct mlx5_ib_mr *
 _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 		      int access_flags, int access_mode,
@@ -189,13 +245,10 @@ _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, stru=
ct ib_umem *umem,
 			MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK :
 			0;
=20
-	/* Normalize ph: swap 0 and MLX5_IB_NO_PH */
-	if (ph =3D=3D MLX5_IB_NO_PH || ph =3D=3D 0)
-		ph ^=3D MLX5_IB_NO_PH;
-
 	mr->ibmr.frmr.key.kernel_vendor_key =3D
 		FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK, st_index) |
-		FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK, ph);
+		FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK,
+			   mlx5_ib_tph_key_ph(ph));
 	err =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr);
 	if (err) {
 		kfree(mr);
@@ -218,7 +271,9 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib=
_dev *dev,
 				      0 :
 				      MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK,
 		.num_dma_blocks =3D ndescs,
-		.kernel_vendor_key =3D 0, /* no PH and no ST index */
+		.kernel_vendor_key =3D
+			FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK,
+				   MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX),
 	};
 	struct mlx5_ib_mr *mr;
 	int ret;
@@ -557,6 +612,10 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *p=
d, struct ib_umem *umem,
 	mr->ibmr.pd =3D pd;
 	mr->access_flags =3D access_flags;
 	mr->page_shift =3D order_base_2(page_size);
+	mr->ibmr.frmr.key.kernel_vendor_key =3D
+		FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK, st_index) |
+		FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK,
+			   mlx5_ib_tph_key_ph(ph));
=20
 	inlen =3D MLX5_ST_SZ_BYTES(create_mkey_in);
 	if (populate)
@@ -753,6 +812,12 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd=
, struct ib_umem *umem,
 			st_index =3D mdmah->st_index;
 	}
=20
+	err =3D mlx5_ib_get_st_handle_ref(dev, st_index);
+	if (err) {
+		ib_umem_release(umem);
+		return ERR_PTR(err);
+	}
+
 	xlt_with_umr =3D mlx5r_umr_can_load_pas(dev, umem->length);
 	if (xlt_with_umr) {
 		mr =3D alloc_cacheable_mr(pd, umem, iova, access_flags,
@@ -769,6 +834,7 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd,=
 struct ib_umem *umem,
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 	if (IS_ERR(mr)) {
+		mlx5_ib_put_st_index_ref(dev, st_index);
 		ib_umem_release(umem);
 		return ERR_CAST(mr);
 	}
@@ -903,6 +969,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
 	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+static void get_pci_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_bu=
f *dmabuf,
+				  struct mlx5_ib_dmabuf_tph *tph,
+				  u16 *st_index, u8 *ph)
+{
+	u16 local_st_index;
+	u16 steering_tag;
+	u8 local_ph;
+	bool extended;
+	int ret;
+
+	switch (pcie_tph_enabled_req_type(dev->mdev->pdev)) {
+	case PCI_TPH_REQ_TPH_ONLY:
+		extended =3D false;
+		break;
+	case PCI_TPH_REQ_EXT_TPH:
+		extended =3D true;
+		break;
+	default:
+		return;
+	}
+
+	/*
+	 * dma_buf_get_pci_tph() must run under dmabuf->resv, but drop the lock
+	 * before mlx5_st_alloc_index_by_tag(): that allocates with GFP_KERNEL,
+	 * which must not run under dmabuf->resv since reclaim can re-enter the
+	 * same reservation object through a dynamic exporter's move_notify pat=
h.
+	 */
+	dma_resv_lock(dmabuf->resv, NULL);
+	ret =3D dma_buf_get_pci_tph(dmabuf, extended, &steering_tag, &local_ph)=
;
+	dma_resv_unlock(dmabuf->resv);
+	if (ret) {
+		if (ret !=3D -EOPNOTSUPP)
+			mlx5_ib_dbg(dev, "get_pci_tph failed (%d)\n", ret);
+		return;
+	}
+
+	ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag,
+					 &local_st_index);
+	if (ret) {
+		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
+		return;
+	}
+
+	*st_index =3D local_st_index;
+	*ph =3D local_ph;
+	tph->steering_tag =3D steering_tag;
+	tph->ph =3D local_ph;
+	tph->extended =3D extended;
+	tph->valid =3D true;
+}
+
+static void mlx5_ib_mr_put_st_handle_ref(struct mlx5_ib_mr *mr)
+{
+	mlx5_ib_put_st_handle_ref(mr_to_mdev(mr),
+				  mr->ibmr.frmr.key.kernel_vendor_key);
+}
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -913,6 +1036,7 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *=
dma_device,
 	struct mlx5_ib_dev *dev =3D to_mdev(pd->device);
 	struct mlx5_ib_mr *mr =3D NULL;
 	struct ib_umem_dmabuf *umem_dmabuf;
+	struct mlx5_ib_dmabuf_tph tph =3D {};
 	u16 st_index =3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX;
 	u8 ph =3D MLX5_IB_NO_PH;
 	int err;
@@ -945,18 +1069,29 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device=
 *dma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+
+		err =3D mlx5_ib_get_st_handle_ref(dev, st_index);
+		if (err) {
+			ib_umem_release(&umem_dmabuf->umem);
+			return ERR_PTR(err);
+		}
+	} else {
+		get_pci_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
+				      &tph, &st_index, &ph);
 	}
=20
 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
 				access_flags, access_mode,
 				st_index, ph);
 	if (IS_ERR(mr)) {
+		mlx5_ib_put_st_index_ref(dev, st_index);
 		ib_umem_release(&umem_dmabuf->umem);
 		return ERR_CAST(mr);
 	}
=20
 	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
=20
+	mr->dmabuf_tph =3D tph;
 	atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_pages);
 	umem_dmabuf->private =3D mr;
 	if (!pinned_mode) {
@@ -1405,6 +1540,7 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 	if (mr->ibmr.frmr.pool) {
 		if (!mlx5_umr_revoke_mr_with_lock(mr)) {
 			ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr);
+			mlx5_ib_mr_put_st_handle_ref(mr);
 			return 0;
 		}
 	}
@@ -1432,6 +1568,9 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 	if (mr->ibmr.frmr.pool && !ret)
 		ib_frmr_pool_drop(&mr->ibmr);
=20
+	if (!ret)
+		mlx5_ib_mr_put_st_handle_ref(mr);
+
 	return ret;
 }
=20
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx=
5/odp.c
index 1badec9bf527..7c1731aa3dd9 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -857,6 +857,13 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr=
, size_t bcnt,
 		return err;
 	}
=20
+	err =3D mlx5_ib_validate_dmabuf_tph(mr, umem_dmabuf->attach->dmabuf);
+	if (err) {
+		ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+		dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
+		return err;
+	}
+
 	page_size =3D mlx5_umem_dmabuf_find_best_pgsz(umem_dmabuf, access_mode)=
;
 	if (!page_size) {
 		ib_umem_dmabuf_unmap_pages(umem_dmabuf);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 7cedc348790d..877b37b4e639 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
 	kfree(st);
 }
=20
-int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
-			unsigned int cpu_uid, u16 *st_index)
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index)
 {
 	struct mlx5_st_idx_data *idx_data;
 	struct mlx5_st *st =3D dev->st;
 	unsigned long index;
 	u32 xa_id;
-	u16 tag;
-	int ret;
+	int ret =3D 0;
=20
 	if (!st)
 		return -EOPNOTSUPP;
=20
-	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
-	if (ret)
-		return ret;
-
 	if (st->direct_mode) {
 		*st_index =3D tag;
 		return 0;
@@ -152,8 +147,46 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
num tph_mem_type mem_type,
 	mutex_unlock(&st->lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
+
+int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
+			unsigned int cpu_uid, u16 *st_index)
+{
+	u16 tag;
+	int ret;
+
+	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
+	if (ret)
+		return ret;
+
+	return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
+}
 EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
=20
+int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_index)
+{
+	struct mlx5_st_idx_data *idx_data;
+	struct mlx5_st *st =3D dev->st;
+	int ret =3D 0;
+
+	if (!st)
+		return -EOPNOTSUPP;
+
+	if (st->direct_mode)
+		return 0;
+
+	mutex_lock(&st->lock);
+	idx_data =3D xa_load(&st->idx_xa, st_index);
+	if (WARN_ON_ONCE(!idx_data))
+		ret =3D -EINVAL;
+	else
+		refcount_inc(&idx_data->usecount);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mlx5_st_get_index);
+
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
 {
 	struct mlx5_st_idx_data *idx_data;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index b1871c0821d0..d26e5744c843 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1182,16 +1182,31 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
 			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
=20
 #ifdef CONFIG_PCIE_TPH
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index);
+int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_index);
 int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
 			unsigned int cpu_uid, u16 *st_index);
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index);
 #else
+static inline int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev,
+					     u16 tag, u16 *st_index)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_in=
dex)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu_uid, u16 *st_index)
 {
 	return -EOPNOTSUPP;
 }
+
 static inline int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 s=
t_index)
 {
 	return -EOPNOTSUPP;
--=20
2.53.0-Meta

