Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767A357CEB
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612393; cv=none; b=Og7ToSiIOAEXf7dLUIwBfrY0mFWFRp7HzzPKM0jalwh85VGz99KsXSXBJZM+kLiu2r/jRTQnd+8gKcB0NiRFKRV/DYFrrkl80CEDH0M9IROgNQ9ssb0g6K9F/gRoQhrTCQf6JljBCZkVpQ5qGNbCXE1QNmm6Mmfa3C471vWdtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612393; c=relaxed/simple;
	bh=nZ8DGxht7JgjPZK2BMVeoxnCfh8sbQ8DVQPGNHNtPNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adv1ob0ho1NS1ByRSC6U5TB1ufGs+R/VYbBHcSBjA9DFuUYpbtAwwUVfoPo/mP5hgWI6oFgwQwkfN2rrUEPoaDIhaj56Q8HsWadJZ5R0nxEMxDpFI/jIizifpwbQzWt4tug1/zeXh+iGEvm6gzZrXWeZYPDt7DsWYlibeX1dD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TUMyd+sC; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TUMyd+sC"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CFuXni2197497
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:59:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Lq5M0ijWGT00RVOnCVcHBl1hr1cUTV8zkisYn0NWZjU=; b=TUMyd+sC+fuG
	wq6QpLWT0kfbjeZbGMtvtitLWb0SSfvi2gAJWA9xW1Z4QMDjvgXkk55HPOiFl6e4
	g3/Nb1bu4IdugYuinfPJ6AGH8atamIh8gk3rXjgWuW0OALKOCxsI7oV1y2AqKKcc
	2jKvi6uhUxW5zhVpjrmBkYLd0r8qU+pLhaKti05cDq4FZiQ4CQ1prL2UoYOumEhY
	StIRxNTd/PaF4UgoTBL5lS1Zp6qlYvh7LXVz6shtGdHIbzrSka5iDWjrl/dZs0At
	rGFCKBmcK3O+HZOpLwkaXBteASfGCUIEoGm/m1zH9+ltAZ1gTV1wOHmaVFJTQfZ5
	F2seakzu7g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvxjwp3-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:59:50 -0700 (PDT)
Received: from twshared15563.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 12 May 2026 18:59:47 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id A6C0B2923919D; Tue, 12 May 2026 11:47:57 -0700 (PDT)
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
Subject: [PATCH v3 2/2] RDMA/mlx5: get tph for p2p access when registering dma-buf mr
Date: Tue, 12 May 2026 11:47:49 -0700
Message-ID: <20260512184755.4137227-3-zhipingz@meta.com>
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
X-Authority-Analysis: v=2.4 cv=KI9qylFo c=1 sm=1 tr=0 ts=6a0378a6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8 a=-VLc4JsVDVYd0Cd11n8A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5NiBTYWx0ZWRfX5cGzLTrbLcNj
 kF3PDQloEda4Y/DQmxhiFDWH4cIsYKNtIeZIzcBJ7CicpZZJXDkrsX4tuR6jrnD6VEKhst2ENqA
 0sDpsrs5TfO84Q42Q6YQne25uygM4mL87Xt5hOcezHCVEpgiRAQa4wlOiEB0rLhZlX/eR8YuNFh
 pVI0jo8nrmNRnZpHW0kWJZwokADTyfGG7XWAgyQbABFSvcI/DE+ZMC9oZJukgOfDjGjbl/zCkJ7
 YoG9EtuH9nNuWbxoTS24CJO/7gvepqYjFAK4usizBfrqxcTa/9k12hrSr3nPppT55rDkiKBtPzb
 Y4dVUHEHUoseGSwYOGINT4/F5MbipCPcjOQGkDZtxg14LYJaaVDxBowKp9zZ8lB5jyvT1hp8AMq
 fEmoWDOXp4HZ27SWoW7xNR9Vt2agL163MmBDG0MnybVTFM1ufhjxtkLKzctU39XgVMgu6Uwa1dW
 IKMZDpvRKhY7j0bKarw==
X-Proofpoint-ORIG-GUID: orf9WSeNCEWWTcLpNHTUjBUA22aFAIRQ
X-Proofpoint-GUID: orf9WSeNCEWWTcLpNHTUjBUA22aFAIRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01

Query dma-buf TPH metadata when registering a dma-buf MR for peer to
peer access and translate the raw steering tag into an mlx5 steering
tag index. Factor mlx5_st_alloc_index() so callers that already have a
raw steering tag can allocate the corresponding mlx5 index directly.
Keep the DMAH path as the first priority and only fall back to dma-buf
metadata when no DMAH is supplied.

Add pcie_tph_get_st_width() so the mlx5 IB driver can query the
device's negotiated ST width without poking pci_dev::tph_req_type
directly (that field is gated by CONFIG_PCIE_TPH and would otherwise
break !CONFIG_PCIE_TPH builds). Pass the width to the dma-buf
get_tph() callback so the exporter can return the value that matches
the consumer's capability.

Pass the dma_buf pointer that the umem already resolved into
get_tph_mr_dmabuf() instead of re-resolving the user-supplied fd.
Re-resolving opens a TOCTOU where a concurrent dup2() can substitute a
different dma_buf between umem creation and TPH lookup.

Track the per-MR ownership of the allocated mlx5 ST index on
mlx5_ib_mr (dmabuf_st_index / dmabuf_st_owned) and release it once the
firmware mkey no longer references it. Both the cached path
(mlx5r_umr_revoke_mr_with_lock + ib_frmr_pool_push) and the
destroy_mkey path call mlx5_ib_mr_put_dmabuf_st() so the ST index does
not leak when the MR is reused from the FRMR pool.

Initialize ret in mlx5_st_create() so the cached steering-tag path
returns success cleanly under clang builds.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
 drivers/infiniband/hw/mlx5/mr.c               | 72 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 27 ++++---
 drivers/pci/tph.c                             | 20 ++++++
 include/linux/mlx5/driver.h                   |  7 ++
 include/linux/pci-tph.h                       |  2 +
 6 files changed, 124 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw=
/mlx5/mlx5_ib.h
index e156dc4d7529..4ab867392267 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -721,6 +721,12 @@ struct mlx5_ib_mr {
 			u8 revoked :1;
 			/* Indicates previous dmabuf page fault occurred */
 			u8 dmabuf_faulted:1;
+			/* Set when the MR owns dmabuf_st_index and must
+			 * release it via mlx5_st_dealloc_index() once the
+			 * firmware mkey is no longer referencing it.
+			 */
+			u8 dmabuf_st_owned:1;
+			u16 dmabuf_st_index;
 			struct mlx5_ib_mkey null_mmkey;
 		};
 	};
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index 3b6da45061a5..84d570f7cafb 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-resv.h>
+#include <linux/pci-tph.h>
 #include <rdma/frmr_pools.h>
 #include <rdma/ib_umem_odp.h>
 #include "dm.h"
@@ -46,6 +47,8 @@
 #include "data_direct.h"
 #include "dmah.h"
=20
+MODULE_IMPORT_NS("DMA_BUF");
+
 static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
@@ -899,6 +902,54 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
 	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+/*
+ * Query TPH metadata from @dmabuf and translate the raw steering tag in=
to
+ * an mlx5 ST index. On success, returns 0 and the caller becomes the
+ * owner of *@st_index (must be released with mlx5_st_dealloc_index()
+ * once the firmware mkey no longer references it). On any failure
+ * *@st_index and *@ph are left as the no-TPH defaults set by the caller=
.
+ *
+ * @dmabuf must already be referenced by the caller (e.g. via the umem's
+ * attachment) so we don't re-resolve the user's fd here and avoid a
+ * dup2() TOCTOU between umem creation and TPH lookup.
+ */
+static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf *d=
mabuf,
+			      u16 *st_index, u8 *ph)
+{
+	u16 steering_tag;
+	u8 st_width;
+	int ret;
+
+	if (!dmabuf->ops->get_tph)
+		return;
+
+	st_width =3D pcie_tph_get_st_width(dev->mdev->pdev);
+	if (!st_width)
+		return;
+
+	ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
+	if (ret) {
+		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
+		*ph =3D MLX5_IB_NO_PH;
+		return;
+	}
+
+	ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_index);
+	if (ret) {
+		*ph =3D MLX5_IB_NO_PH;
+		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
+	}
+}
+
+static void mlx5_ib_mr_put_dmabuf_st(struct mlx5_ib_mr *mr)
+{
+	if (mr->umem && mr->dmabuf_st_owned) {
+		mlx5_st_dealloc_index(mr_to_mdev(mr)->mdev,
+				      mr->dmabuf_st_index);
+		mr->dmabuf_st_owned =3D 0;
+	}
+}
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -941,16 +992,26 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device =
*dma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+	} else {
+		get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
+				  &st_index, &ph);
 	}
=20
 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
 				access_flags, access_mode,
 				st_index, ph);
 	if (IS_ERR(mr)) {
+		if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+			mlx5_st_dealloc_index(dev->mdev, st_index);
 		ib_umem_release(&umem_dmabuf->umem);
 		return ERR_CAST(mr);
 	}
=20
+	if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX) {
+		mr->dmabuf_st_index =3D st_index;
+		mr->dmabuf_st_owned =3D 1;
+	}
+
 	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
=20
 	atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_pages);
@@ -1378,8 +1439,15 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_i=
b_mr *mr)
 	int ret;
=20
 	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
-	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
+	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr)) {
+		/*
+		 * The mkey has been revoked: firmware no longer references
+		 * dmabuf_st_index, so release it before this mr re-enters
+		 * the FRMR cache for reuse by another registration.
+		 */
+		mlx5_ib_mr_put_dmabuf_st(mr);
 		return 0;
+	}
=20
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
@@ -1400,6 +1468,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 		dma_resv_unlock(
 			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
 	}
+	if (!ret)
+		mlx5_ib_mr_put_dmabuf_st(mr);
 	return ret;
 }
=20
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 997be91f0a13..c5058557c7f0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -29,7 +29,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *de=
v)
 	u8 direct_mode =3D 0;
 	u16 num_entries;
 	u32 tbl_loc;
-	int ret;
+	int ret =3D 0;
=20
 	if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
 		return NULL;
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
@@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
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
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..644fb5b1f27c 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -174,6 +174,26 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
=20
+/**
+ * pcie_tph_get_st_width - Return the device's negotiated Steering Tag w=
idth
+ * @pdev: PCI device to query
+ *
+ * Return: 16 if the TPH Requester is enabled in Extended TPH mode, 8 if
+ * enabled in regular TPH mode, 0 if TPH is not enabled or supported.
+ */
+u8 pcie_tph_get_st_width(struct pci_dev *pdev)
+{
+	switch (pdev->tph_req_type) {
+	case PCI_TPH_REQ_TPH_ONLY:
+		return 8;
+	case PCI_TPH_REQ_EXT_TPH:
+		return 16;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL(pcie_tph_get_st_width);
+
 /*
  * Return the size of ST table. If ST table is not in TPH Requester Exte=
nded
  * Capability space, return 0. Otherwise return the ST Table Size + 1.
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04b96c5abb57..523a9ab0ae1e 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1166,10 +1166,17 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
 			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
=20
 #ifdef CONFIG_PCIE_TPH
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index);
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
 static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu_uid, u16 *st_index)
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..679f94f68cef 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+u8 pcie_tph_get_st_width(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *d=
ev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u8 pcie_tph_get_st_width(struct pci_dev *pdev) { return 0;=
 }
 #endif
=20
 #endif /* LINUX_PCI_TPH_H */
--=20
2.52.0

