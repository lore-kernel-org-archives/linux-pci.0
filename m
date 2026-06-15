Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB21D8E01
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507489; cv=none; b=da6E4ej82di4DQR/aC4vYhDj7kfRdoqnjdo0KWikNNJF7wOQNeb/6LhEzSk3bJiYxiYMJxDY3FntzFb4Zuuop3NdduF4Oc0itP6yjkzktY0w9VLs7kjejqaw/pcP73zQkVBbRUkCHmVxbpapckxvffbcbrnL+oF5D+r6ecoD1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507489; c=relaxed/simple;
	bh=8logOR3lxB31/diZL4BZcO5uyCiUAr9l4vbcoVVNMOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cj55ouWSFrsIsZ+OzHOBEr/+Qe3Q+GcSXazJzk0JqH+oiYSs7p8Siwj3KxGcvgbfYvL7J5vo+E641sbLjaokDD0hwJmebeP/a25oylYUXfr/WI0dtgE7jdZJfgUy+tewJmAWQ2lIL2MRWmQ0qjEnTTcx8eW6hBGeupNVMFpqVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eJh1Oc/o; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eJh1Oc/o"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6I8oA1217077
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 00:11:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=QcbEfeB3v492A1yPPhxdGYJNWSs67Ph7OwSqrgtpYVM=; b=eJh1Oc/o95dE
	uzQ07yzoFwxvPW/eI5iESWeCeqKI057LVi+OaPqF02RfaaYFpb6zddTvFPTzCTte
	G4cTHkNoabtC2HvjemxxwInhFstnGkEBVNdInTE80NVIEHEWKweyjNU8cC1pNNOq
	uMHp7E1D2dXEu86x6F5HDfyrFUclEClahV4zsYcRSv+AkdfLOBwq3WsQcxCwP/iT
	bWMziYSMbdkscGHZZSBK/NQdNRrnpMGQq2UM9p6Hfbq+j5Sc80AJH/RBoXUhPZip
	z81YuGgG2g1Vv9WsGvPIr3gZou2+avYRHNvAy/w4650NuNzrpNLHx/d2TCj3FvAB
	XUE293TRKg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es2h0qnua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 00:11:26 -0700 (PDT)
Received: from twshared17215.34.frc3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 07:11:25 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 95DE03EE34524; Sun, 14 Jun 2026 23:59:19 -0700 (PDT)
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
Subject: [PATCH v8 4/4] RDMA/mlx5: get tph for p2p access when registering dma-buf mr
Date: Sun, 14 Jun 2026 23:59:01 -0700
Message-ID: <20260615065912.2177918-5-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260615065912.2177918-1-zhipingz@meta.com>
References: <20260615065912.2177918-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a2fa59e cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=CbDCq_QkAAAA:8
 a=92alqDoterSysbya1toA:9 a=gKebqoRLp9LExxC7YDUY:22 a=1qrBK16LubpBFNPVNq2M:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfX2SgFroWvtfuJ
 c55LNCheQLWPvwk13qlFcCWSEJsyd7iHaHqyaLCbZhwtMf7FBF9LjWJi6FQ1XUQDFYmZeb0OgNv
 /Kcct2KbjeC7KzbDjdP0fOWhBJ9uOAI=
X-Proofpoint-GUID: xBpBsh0TM3klJl5p7ySJpbfAf05p1oQS
X-Proofpoint-ORIG-GUID: xBpBsh0TM3klJl5p7ySJpbfAf05p1oQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfX0k5W64B8Ijzk
 2Pra3T4FGZfAVJGVVUztS7pQFCnBxZtGRyE5PCm/w7z56o2xH/ddyjIaqGHpXtXFpuUyGeCuzy/
 eMRpn0b8WsTqfSEonY750ZAtU8chGjbc7J4vgYKlCjd5lOoR1JRtZpcVEMbAww3n/k7xBbSeiGg
 kx+bpv/LLMMrW9d8eYz9zrOuEL/lX7F627yuSt+hrliStEdf4AvyQ424enwNoSLan2DlzsQWuIA
 /mkE7Y/YujjvQPpGO4InNkWULW2Quaf1C9XbKB7JGBC5F5ZYi9k3Xr3nR6hkD4RoBarUXn9FFAl
 XdvZAT2PCYSzgMto+1Z0BlVAFaQSKFnMjXkg4pwU7OavbNMrRugw7vmco7XMhKq8QF/DADN8gkq
 lwV7UV/m6b4pJ7sNFJembkJFlmGwJeIrjdXuYbxmal4WMY9mlD3c6pahaGNTW7ciDOStA9A8DWj
 rSCUfjrTsO8RfEX3Oog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01

Query dma-buf PCI TPH metadata when registering a dma-buf MR for
peer-to-peer access to a PCIe endpoint and use it to program
requester-side TPH on the outbound mkey. If the exporter has no
metadata, fall back to the existing no-TPH path.

Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
steering tags into local ST entries when table mode is active, and add
mlx5_st_get_index() for DMAH-backed flows that already carry an ST
index.

For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
lifetime rather than pooled mkey lifetime. Acquire the ref before MR
creation and release it again when the MR is returned to the pool or
the backing mkey is destroyed, while leaving the generic FRMR pool core
unchanged.

Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
modular mlx5_ib builds link cleanly.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mr.c               | 105 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 ++++++--
 include/linux/mlx5/driver.h                   |  12 ++
 4 files changed, 157 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/ml=
x5/main.c
index 61078281953d..6d14909c8a2c 100644
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
index 8984b31b9429..d73005bd32a6 100644
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
@@ -901,6 +942,52 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
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
@@ -943,12 +1030,22 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device=
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
@@ -1384,8 +1481,10 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_i=
b_mr *mr)
 	int ret;
=20
 	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
-	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
+	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr)) {
+		mlx5_ib_mr_put_frmr_st_handle_ref(mr);
 		return 0;
+	}
=20
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
@@ -1406,6 +1505,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 		dma_resv_unlock(
 			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
 	}
+	if (!ret)
+		mlx5_ib_mr_put_frmr_st_handle_ref(mr);
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
index 04b96c5abb57..0480b5c4f189 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1166,10 +1166,22 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
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

