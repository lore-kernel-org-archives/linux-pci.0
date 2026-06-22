Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EACE33F584
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154100; cv=none; b=SPSejeqkY1qK/cLamT4sVacsw+dJ/SZWF2q2mLyJRqwMZL74THYNBhvuUWPrMRnrhdHwffcLXNN9sRFQ4ndKh/3JjNmMRYUmnzr70ZxcHlQE/FAnbIEzP17lLPmQNqjm+I4zEpYnsxlSzi08/F3hKE3jWtP7kF31josyP0eXJXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154100; c=relaxed/simple;
	bh=BDKgYI4khym9t1bhxljusSlxffO76Dx0cOyeIwGhXNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMyD9gYtizc58nVW3ZehrOq/b3bmk5uKaDsGkzRF6Ow0IGXcRiy3XRzblPmbRh1B31Wk93euthF53YbePijsTgpRAudzBeyYMoLmqYl2nLVgXt6SuWUMANILn7yzEUFWochFSTY3UT+oRDtDtG3NQt+DUGQOuEwTDHxDRh9hb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=l/BJ+wli; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="l/BJ+wli"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MIkACI2452333
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 11:48:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ykDuxa3sl48tXpgRGsFXyn2pcyRH4iFV9+14nvV5O8U=; b=l/BJ+wliCr9X
	0xs0s+sHP/611ylOcPWMIuu6Zg7+3OBAauGnmP92+9d1ow/bY6BtIVrfMNOv2rQI
	iQs11Kx8+oCpH5dc02I+d5kO0gzwdbyHOIh/PuuT/dHAUpzjv/XoEzLppw+wlcQI
	fWPyEES2FPL56rqvasMYUdrexCr3QiPhxZERpEQgcWtwQNIijHMMVXQQjO9vDrYV
	kztZArHEw3ls7jaas/acxElm9evwDhzEAhoNNs9sF7DO16OWnS0YfPsqwAdpWMXe
	e+ApCa83dkPNJDjKtx6eq+8urbFxYk/OKwR87uKVKnDf/GVNTNDTXpnpHc9ol6rs
	ZCSxoOLOOg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4excejh1yh-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 11:48:18 -0700 (PDT)
Received: from twshared25959.34.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 18:48:13 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 5FDED3FB8E351; Mon, 22 Jun 2026 11:42:17 -0700 (PDT)
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
Subject: [PATCH v9 4/4] RDMA/mlx5: get tph for p2p access when registering dma-buf mr
Date: Mon, 22 Jun 2026 11:41:37 -0700
Message-ID: <20260622184211.2229399-5-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260622184211.2229399-1-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4MiBTYWx0ZWRfXzysdRNEu2EEe
 pyDmliDnalCq6/vmC6khVRVwbpVxeYUWtKl9ZIr7EGRf7GOyos10iVLXmYPVuldqVfn8DauH24e
 5Afj02lxaJZ52sFM8HYQsBwhWJ38JVJcrIYLniE259+WZDnwf54hwbCqQQNZFTpz6wc8iBHCkhl
 4JBZXpTMJXBnwCmEXUnRXu5TwbmoSq/RVg+P0GAUpS+0CguzwI1Alcq/k1kheXYcSAk9oRbHV5I
 c1/DD1PMC3pG2nfoc8TyxMZk/E+tUnFR7mvVzsqsQ4B8XAokFLJMmnW5tIsdYZ5QNSotfqVvj1Q
 Qwz3L2MvWL8ND7sV99q2AoxRPyaAQY3KthwqxyS00B+Fz3CvpmHkkpz2Bz6j2+YAcoXVH/lr5vX
 ViDOYRMe/wXfBu3sj3Zue5CF2UAuIdm/xo61CpKw2gC6iK2DWGOvue2LgaCMihF190NoPskfT9W
 8VnqO8C0gQnWIod9TYQ==
X-Authority-Analysis: v=2.4 cv=T7u8ifKQ c=1 sm=1 tr=0 ts=6a398372 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VabnemYjAAAA:8 a=CbDCq_QkAAAA:8
 a=b6nn37b5_VcVdO3q4OwA:9 a=gKebqoRLp9LExxC7YDUY:22 a=1qrBK16LubpBFNPVNq2M:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4MiBTYWx0ZWRfX8DBpO2CAXOv9
 IUdB25Hs38LyyyCeWyc0vnCvTOFvP97TDKL4+jkwKTnGL8rfk08fNXbQZvgxPyxCqvYrLAc3v6o
 ZitJzmvdEThO4lK4zBKqcwL9cq9c9M4=
X-Proofpoint-ORIG-GUID: DeIzW6q9cTMq6VLCBKD5hmHVMxgI7yOS
X-Proofpoint-GUID: DeIzW6q9cTMq6VLCBKD5hmHVMxgI7yOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01

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
 drivers/infiniband/hw/mlx5/mr.c               | 103 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++++--
 include/linux/mlx5/driver.h                   |  13 ++
 4 files changed, 157 insertions(+), 9 deletions(-)

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
index e6b74955d95d..7aced3f55456 100644
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
@@ -167,6 +168,32 @@ static int get_unchangeable_access_flags(struct mlx5=
_ib_dev *dev,
 #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
 #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
=20
+static int mlx5_ib_get_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
+					  u16 st_index)
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
+static void mlx5_ib_put_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
+					   u64 kernel_vendor_key)
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
@@ -218,7 +245,9 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib=
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
@@ -335,6 +364,7 @@ static int mlx5r_build_frmr_key(struct ib_device *dev=
ice,
 		get_unchangeable_access_flags(dev, in->access_flags);
 	out->vendor_key =3D in->vendor_key;
 	out->num_dma_blocks =3D in->num_dma_blocks;
+	out->kernel_vendor_key =3D in->kernel_vendor_key;
=20
 	return 0;
 }
@@ -557,6 +587,9 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *pd=
, struct ib_umem *umem,
 	mr->ibmr.pd =3D pd;
 	mr->access_flags =3D access_flags;
 	mr->page_shift =3D order_base_2(page_size);
+	mr->ibmr.frmr.key.kernel_vendor_key =3D
+		FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK, st_index) |
+		FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK, ph);
=20
 	inlen =3D MLX5_ST_SZ_BYTES(create_mkey_in);
 	if (populate)
@@ -755,6 +788,12 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd=
, struct ib_umem *umem,
=20
 	xlt_with_umr =3D mlx5r_umr_can_load_pas(dev, umem->length);
 	if (xlt_with_umr) {
+		err =3D mlx5_ib_get_frmr_st_handle_ref(dev, st_index);
+		if (err) {
+			ib_umem_release(umem);
+			return ERR_PTR(err);
+		}
+
 		mr =3D alloc_cacheable_mr(pd, umem, iova, access_flags,
 					MLX5_MKC_ACCESS_MODE_MTT,
 					st_index, ph);
@@ -769,6 +808,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd,=
 struct ib_umem *umem,
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 	if (IS_ERR(mr)) {
+		if (xlt_with_umr)
+			mlx5_ib_put_st_index_ref(dev, st_index);
 		ib_umem_release(umem);
 		return ERR_CAST(mr);
 	}
@@ -903,6 +944,52 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
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
+static void mlx5_ib_mr_put_frmr_st_handle_ref(struct mlx5_ib_mr *mr)
+{
+	mlx5_ib_put_frmr_st_handle_ref(mr_to_mdev(mr),
+				       mr->ibmr.frmr.key.kernel_vendor_key);
+}
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -945,12 +1032,22 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device=
 *dma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+
+		err =3D mlx5_ib_get_frmr_st_handle_ref(dev, st_index);
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
@@ -1405,6 +1502,7 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 	if (mr->ibmr.frmr.pool) {
 		if (!mlx5_umr_revoke_mr_with_lock(mr)) {
 			ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr);
+			mlx5_ib_mr_put_frmr_st_handle_ref(mr);
 			return 0;
 		}
 	}
@@ -1432,6 +1530,9 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 	if (mr->ibmr.frmr.pool && !ret)
 		ib_frmr_pool_drop(&mr->ibmr);
=20
+	if (!ret)
+		mlx5_ib_mr_put_frmr_st_handle_ref(mr);
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
index b1871c0821d0..b3295b338267 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1182,10 +1182,23 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
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
 static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu_uid, u16 *st_index)
--=20
2.53.0-Meta
