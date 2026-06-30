Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E9131E823
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860111; cv=none; b=HXxJPWlb4NvyP7NWpKAgP3uAEctTuokbbLDzy+GErSsgbiZxB2C9+Es2HGcMdtI7++HWiN+IJE4gVMMBvI2d8ahE2O0uZlLkUNboc1ODg0mSOkRU5cfkBieOefetveRvVPSsdWBTnOHYiWjqkYeK2vChp853QE0ONivYMFOz94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860111; c=relaxed/simple;
	bh=RLQxxxadUuzX6ecZsv9yXU1DVGzorhqnUHvoDl6bwYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byK50CHWYlEmQzsUvIoJCYKrPkynqlErPDSuIkpWRlvl8HYFAfosGkiyIY7qaJIYWAeEIOFxczQ6Xtl7ZoV5JHPYowCpkcxrFwDJWZUmpwjrG7BhMhHMClqMpbgHWKqIgq7n1kuRVZL4wRkq1MGH9obDP51RPcBLpeypqg+fbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Ma7itR4j; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Ma7itR4j"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65ULMAUC1948418
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:55:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=c+52n3BiXtabeuCT1iAGuCHlet7dZQTs9EbDARTGZG4=; b=Ma7itR4ju7zG
	mjFs6wEwItP030oZPrgAOYfK70U8u12WwQBvbftTGyPIknxULyHTzkSiYZaMW/fa
	NVxUGhUPC0Ob6cI62FCpMwAichDUcXi5PJE+Lk3ar7/2rqEivPny6yMyvHHFJsRl
	o16H8Jb50qpiutrXW7mCFDlKEyY0Q/9ClLfnAcLs3ZWRJ69Fpulkd2ieKYMWAfad
	16Es/JK805eTx5ygchluy58sxpgFHFMgNIu3Hy6EhiHZWabJaPCdcEAtMWBWm/pv
	UXu8SFTTLATh3aLBt80mfaVX09esI+yuvn/8zZDX0VxdfpWQpSoENbGbY0LNODuj
	MI3zCsoxGQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4f45uf7rna-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:55:07 -0700 (PDT)
Received: from twshared11639.02.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 30 Jun 2026 22:55:04 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 193BC40C59C38; Tue, 30 Jun 2026 15:43:31 -0700 (PDT)
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
Subject: [PATCH v10 4/4] RDMA/mlx5: get tph for p2p access when registering dma-buf mr
Date: Tue, 30 Jun 2026 15:42:26 -0700
Message-ID: <20260630224328.3218796-5-zhipingz@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIyMyBTYWx0ZWRfX7wFaA4E08P80
 D1kM3/IWlfChavPKxNUK3nxMLxCGcxIpo32WXMJLr7dwuQy/EgxiYhJm2MyLZcYq5PRbbpmWhna
 kn20AVtEGP9x7/Pi3oPbdfydFj3k4cE=
X-Proofpoint-GUID: x8MfNR7vF0JEoAmJeOuJ6lq88OyZrK98
X-Authority-Analysis: v=2.4 cv=ZOfnX37b c=1 sm=1 tr=0 ts=6a44494b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VabnemYjAAAA:8 a=CbDCq_QkAAAA:8
 a=b6nn37b5_VcVdO3q4OwA:9 a=gKebqoRLp9LExxC7YDUY:22 a=1qrBK16LubpBFNPVNq2M:22
X-Proofpoint-ORIG-GUID: x8MfNR7vF0JEoAmJeOuJ6lq88OyZrK98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIyMyBTYWx0ZWRfX+XeI8hhvwQR9
 eOz+xrMVqwYeWV8HQWYRShp9QD5F6hUk9+0zLD49xlUUGf0rTvKgi9MIkLHbYVelkJXhxzyC8/c
 xIO+AK0m8T6azN1t5r3yxgLuISkmRnSM+R72m8P5MzoEc533ge70H+CChnXYvQ4OMDufG2kyAiE
 WNPh1C51qJ2o6SuXj0W+5qXX9/y+xMHomz419h5QWvUXcst/RusxTvNtfN42wtJYEfjUae140TY
 2i1Tys0/FUW4jGhdpj96+yhYtwgJuAgosPUfsWBZAMwkRac9buTwi49Bulbiy/bziqLCbLNCXnb
 GQV3IwalnGkoccyIl1zcUdZQBu7xEPs1KrOsyJnGngABqSNBtSSkVOx6GNjwQCYFv1e5jOBgcya
 x1gf9zqghla6hLplFrj2bok7GHaaph+/MGfqlpx/UBH0oj94tgOGYEQ83FS+J4lJPD8Xb5gPuMJ
 55NeL30chznrx2CAoxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01

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

Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
modular mlx5_ib builds link cleanly.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mr.c               | 116 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 ++++++--
 include/linux/mlx5/driver.h                   |  15 +++
 4 files changed, 167 insertions(+), 14 deletions(-)

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
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index e6b74955d95d..55216ae63761 100644
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
@@ -167,6 +168,39 @@ static int get_unchangeable_access_flags(struct mlx5=
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
 static struct mlx5_ib_mr *
 _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 		      int access_flags, int access_mode,
@@ -189,13 +223,10 @@ _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, stru=
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
@@ -218,7 +249,9 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib=
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
@@ -557,6 +590,10 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *p=
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
@@ -753,6 +790,12 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd=
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
@@ -769,6 +812,7 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd,=
 struct ib_umem *umem,
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 	if (IS_ERR(mr)) {
+		mlx5_ib_put_st_index_ref(dev, st_index);
 		ib_umem_release(umem);
 		return ERR_CAST(mr);
 	}
@@ -903,6 +947,52 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
 	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+static void get_pci_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_bu=
f *dmabuf,
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
@@ -945,12 +1035,22 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device=
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
+				      &st_index, &ph);
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
@@ -1405,6 +1505,7 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 	if (mr->ibmr.frmr.pool) {
 		if (!mlx5_umr_revoke_mr_with_lock(mr)) {
 			ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr);
+			mlx5_ib_mr_put_st_handle_ref(mr);
 			return 0;
 		}
 	}
@@ -1432,6 +1533,9 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
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

