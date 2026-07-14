Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0036A358;
	Tue, 14 Jul 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025847; cv=none; b=uh3pV80IqnaU6digaj+tT0gZHttv8Gmt+l4cnczWHwUMpISEdFUTX1SgDMuVuDigKnxUSwdHmV0qcp96UC/FOWzmFSwoL7t76QvND7umRuP3xxgc9Md1AjNc2N2PSEfQB1GEr/+WQ0IpnX5qIWLEJdGpHayw4rrykgKKEM6nd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025847; c=relaxed/simple;
	bh=KxGLe44pwtnkVBA9/Py29/AgAik8z85yyKoqqRL7r0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0QdGMkcXow6GivSQbZ7uzgf6rry8xUbAsJdHBeCoVrDTsZyTn4xQ+dIwlYkTXaVgWvBMbz2OBYide+5Q+i5/opJ3j2G26hQGsHSVptDMz7w9BTW2Mn+NDyiMEHq5ZlSssGfE8kRAwJb40HfNlqb2iwz/mNbSz6ariDbKLsTWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=321GVgYd; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="321GVgYd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EzYAaW5+j8CHVh+YGDZR/SatlP3Y9CadTzeTzTlKprY=;
	b=321GVgYdmog4N1hHOKMDFN5eqd4lxadcP4UQ2Rf0XXyAWNWAsONb0slgVmmqE3XXIL1Yw+SlF
	IyzE9lU2PtIrd0I/pljDds4ydryPLQgx+6BAKpiSj1g7hL4fhC3IbTZF+ThjTji/U1QGgjlYlgO
	g67F/R7+pDDPa5LvCp8nXcA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gzwf61lCYz1cyVQ;
	Tue, 14 Jul 2026 18:34:22 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 906C74057C;
	Tue, 14 Jul 2026 18:43:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:37 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 14/16] vfio/pci: Add DS-ST TPH policy and extend TPH_RESOLVE capabilities
Date: Tue, 14 Jul 2026 18:43:23 +0800
Message-ID: <20260714104325.54444-15-fengchengwen@huawei.com>
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

Further extend VFIO TPH policy model based on NO-ST/IV-ST baseline,
add DS-ST policy and enrich TPH_RESOLVE to support full ST resolution.

- Add VFIO_PCI_TPH_POLICY_DS_ST level 2 policy, extend module param range
  * NO-ST: only DMABUF PH resolve, no ST capability
  * IV-ST: DMABUF PH resolve, support NONE/DMABUF/CPU ST programming
  * DS-ST: support DMABUF & CPU resolve, full ST/PH reporting and ST
    programming
- Relax TPH control write restriction to allow NS/IV/DS mode selection
- Extend TPH_RESOLVE logic:
  * Support CPU volatile/persistent memory source resolution
  * DMABUF source returns both PH and ST under DS-ST policy
  * CPU source returns ST tag only
- Add new TPH capability bits for ST resolution: RESOLVE_DMABUF_ST,
  RESOLVE_CPU_ST
- Expose resolution capabilities conditionally based on DS policy and DSM
  support

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c        |  4 +-
 drivers/vfio/pci/vfio_pci_config.c |  2 +-
 drivers/vfio/pci/vfio_pci_core.c   | 67 +++++++++++++++++++++---------
 drivers/vfio/pci/vfio_pci_priv.h   |  1 +
 include/uapi/linux/vfio.h          |  9 +++-
 5 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 02c5c8283099..c407c217b649 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -64,7 +64,7 @@ static unsigned int tph_policy;
 static int tph_policy_set(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp, VFIO_PCI_TPH_POLICY_NO_ST,
-				     VFIO_PCI_TPH_POLICY_IV_ST);
+				     VFIO_PCI_TPH_POLICY_DS_ST);
 }
 static const struct kernel_param_ops tph_param_ops = {
 	.set = tph_policy_set,
@@ -76,6 +76,8 @@ MODULE_PARM_DESC(tph_policy,
 	"0 = No-ST mode: RESOLVE only returns PH for DMABUF source;\n"
 	"                ST programming unavailable\n"
 	"1 = Add IV mode: RESOLVE only returns PH for DMABUF source;\n"
+	"                 ST program supports NONE/DMABUF/CPU sources\n"
+	"2 = Add DS mode: RESOLVE returns PH for DMABUF source, ST for DMABUF/CPU sources;\n"
 	"                 ST program supports NONE/DMABUF/CPU sources\n");
 
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 8c68504839b9..97dad6db69e3 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1201,7 +1201,7 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
 	cap = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CAP]);
 	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
 	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
-	if (mode > PCI_TPH_ST_IV_MODE || !(cap & (1u << mode)) || req == 0x2 ||
+	if (mode > PCI_TPH_ST_DS_MODE || !(cap & (1u << mode)) || req == 0x2 ||
 		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
 		goto restore; /* Drop invalid or unsupported write value */
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index df31f4e8766f..ae2e0e2252a1 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1611,6 +1611,24 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static u32 vfio_pci_get_tph_st_size(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u32 loc = pcie_tph_get_st_table_loc(pdev);
+	int ret;
+
+	if (loc == PCI_TPH_LOC_CAP) {
+		return pcie_tph_get_st_table_size(pdev);
+	} else if (loc == PCI_TPH_LOC_MSIX) {
+		ret = pci_msix_vec_count(pdev);
+		if (ret < 0)
+			return 0;
+		return ret;
+	} else {
+		return 0;
+	}
+}
+
 static u32 vfio_pci_get_tph_capability(struct vfio_pci_core_device *vdev)
 {
 	u32 flags = VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH;
@@ -1622,6 +1640,17 @@ static u32 vfio_pci_get_tph_capability(struct vfio_pci_core_device *vdev)
 		if (pcie_tph_dsm_supported(vdev->pdev))
 			flags |= VFIO_DEVICE_TPH_CAP_ST_CPU;
 	}
+	if (vdev->tph_policy >= VFIO_PCI_TPH_POLICY_DS_ST &&
+		(vdev->tph_cap_virt & PCI_TPH_CAP_ST_DS)) {
+		if (vfio_pci_get_tph_st_size(vdev) > 0) {
+			flags |= VFIO_DEVICE_TPH_CAP_ST_NONE;
+			flags |= VFIO_DEVICE_TPH_CAP_ST_DMABUF;
+			if (pcie_tph_dsm_supported(vdev->pdev))
+				flags |= VFIO_DEVICE_TPH_CAP_ST_CPU;
+		}
+		if (pcie_tph_dsm_supported(vdev->pdev))
+			flags |= VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST;
+	}
 
 	return flags;
 }
@@ -1666,8 +1695,12 @@ static u32 vfio_pci_get_tph_resolve_allow_src(struct vfio_pci_core_device *vdev)
 	u32 flags = vfio_pci_get_tph_capability(vdev);
 	u32 allow_src = 0;
 
-	if (flags & VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH)
+	if (flags & (VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH |
+		     VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_ST))
 		allow_src |= VFIO_DEVICE_TPH_SRC_DMABUF;
+	if (flags & VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST)
+		allow_src |= VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
+			     VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT;
 
 	return allow_src;
 }
@@ -1751,6 +1784,7 @@ static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
 
 	resolve.valid = 0;
 	resolve.ph = 0;
+	resolve.st = 0;
 
 	if (user_flags & VFIO_DEVICE_TPH_SRC_DMABUF) {
 		ret = vfio_pci_get_dmabuf_tph(resolve.src, extended,
@@ -1759,8 +1793,21 @@ static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
 			return ret;
 		resolve.ph = ph;
 		resolve.valid = VFIO_DEVICE_TPH_VALID_PH;
+		if (vdev->tph_policy >= VFIO_PCI_TPH_POLICY_DS_ST) {
+			resolve.st = tag;
+			resolve.valid |= VFIO_DEVICE_TPH_VALID_ST;
+		}
+		goto out;
 	}
 
+	ret = vfio_pci_get_tph_st_tag(vdev->pdev, user_flags, resolve.src,
+				      extended, &tag);
+	if (ret)
+		return ret;
+	resolve.valid |= VFIO_DEVICE_TPH_VALID_ST;
+	resolve.st = tag;
+
+out:
 	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
 }
 
@@ -1780,24 +1827,6 @@ static u32 vfio_pci_get_tph_st_allow_src(struct vfio_pci_core_device *vdev)
 	return allow_src;
 }
 
-static u32 vfio_pci_get_tph_st_size(struct vfio_pci_core_device *vdev)
-{
-	struct pci_dev *pdev = vdev->pdev;
-	u32 loc = pcie_tph_get_st_table_loc(pdev);
-	int ret;
-
-	if (loc == PCI_TPH_LOC_CAP) {
-		return pcie_tph_get_st_table_size(pdev);
-	} else if (loc == PCI_TPH_LOC_MSIX) {
-		ret = pci_msix_vec_count(pdev);
-		if (ret < 0)
-			return 0;
-		return ret;
-	} else {
-		return 0;
-	}
-}
-
 static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
 				u32 flags,
 				struct vfio_device_feature_tph_st __user *arg,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 7b89aab7c4c1..03c4a0414264 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -14,6 +14,7 @@
 enum vfio_pci_tph_policy {
 	VFIO_PCI_TPH_POLICY_NO_ST = 0,
 	VFIO_PCI_TPH_POLICY_IV_ST = 1,
+	VFIO_PCI_TPH_POLICY_DS_ST = 2,
 };
 
 struct vfio_pci_ioeventfd {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 4b2132c2794e..9bc3cef7a89a 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1606,6 +1606,10 @@ struct vfio_device_feature_tph {
 #define VFIO_DEVICE_TPH_CAP_ST_CPU		(1u << 2)
 /* NONE source (means steering tag is zero) TPH_ST batch programming supported */
 #define VFIO_DEVICE_TPH_CAP_ST_NONE		(1u << 3)
+/* DMABUF source resolve steering tag supported */
+#define VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_ST	(1u << 4)
+/* CPU source resolve steering tag supported */
+#define VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST	(1u << 5)
 
 /*
  * VFIO_DEVICE_FEATURE_TPH_RESOLVE - Resolve TPH attributes from given source
@@ -1622,15 +1626,16 @@ struct vfio_device_feature_tph {
  * @valid: OUT - bitmap indicating valid output fields, see
  *         VFIO_DEVICE_TPH_VALID_*
  * @ph:    OUT - TPH processing hint (valid when VALID_PH is set in valid)
- * @rsv:   Must be zero, reserved for future extensions
+ * @st:    OUT - TPH steering tag (valid when VALID_ST is set in valid)
  */
 struct vfio_device_feature_tph_resolve {
 	__u32 flags;
 	__u32 src;
 	__u8  valid;
 #define VFIO_DEVICE_TPH_VALID_PH (1u << 0) /* ph holds valid processing hint */
+#define VFIO_DEVICE_TPH_VALID_ST (1u << 1) /* st holds valid steering tag */
 	__u8  ph;
-	__u16 rsv;
+	__u16 st;
 };
 
 /*
-- 
2.17.1

