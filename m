Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0E3F075B;
	Thu, 28 May 2026 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972423; cv=none; b=txl/DcwrCDpmutPGRqTnGG/n0PWPJ7od6UtTtd8hBi4mhxO/7wWBLhBVpuD6FbeKP0fE4zMmwm06ZcjGgtKeDph5eeuzXyIZtwS9S1EPMnFvZEBhZdfRYBLCyy8+j/K5fJoRfL6MbdSl0Hha9tWyiF0JpEyebCRupbGqdMURMJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972423; c=relaxed/simple;
	bh=j8vW6GHLhqp25cR6v31xjK4HGVRBgpRJgsf1gmXhOsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nsvun5RjGtyq9Did51VMtdgyxOwgg6YVxQZBCGME1LxA7ARMVDqG/pk7UPNtX1lYoIsmzTl4k8UmXLorGMRFub8jacDhtMTi4CNlhyGDufMUuCBkz+0f4pmEmrmE3Q857Xj21vM52mOgVuc2/RXpOeiVW/OqHeDgbPvxeHoaTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0J1gz+sL; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0J1gz+sL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BMqdcEyIun1ujc+gNoYCLBNa+E0rfBZGz9hIlsMDR2w=;
	b=0J1gz+sLS+DHpIvNB3xQgUAUVgt76zEHw/nFeTjDqHzzGCdSePIcF8FHrBgVx3qx1LQ8xaA1O
	WApsqsUEmMFu5bZDeNespzlelXGV43h34WpVfe25ccPI5zmWFQ225Hu1xZ5FMkJaOF1z33mrG/w
	apDWftxKoMhmAO+gt9phkQc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gR5dp5p3PzLlwx;
	Thu, 28 May 2026 20:39:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C303E40538;
	Thu, 28 May 2026 20:46:56 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 20:46:56 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v14 3/8] PCI/TPH: Add requester selection policy to pcie_enable_tph()
Date: Thu, 28 May 2026 20:46:44 +0800
Message-ID: <20260528124649.14732-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260528124649.14732-1-fengchengwen@huawei.com>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Introduce enum tph_req_policy to support auto, standard (8-bit ST) and
extended (16-bit ST) TPH requester selection.

Extend pcie_enable_tph() to take the new policy argument, implement
selection logic and add strict input validation. Update function prototype,
inline fallback stub and kernel-doc to reflect new parameters and behavior.

Refresh Documentation/PCI/tph.rst to document the updated function
signature and new requester policy options.

Adapt existing call sites in bnxt and mlx5 drivers to use TPH_REQ_AUTO
to preserve original runtime behavior.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 Documentation/PCI/tph.rst                     | 12 +++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  2 +-
 drivers/pci/tph.c                             | 31 ++++++++++++++-----
 include/linux/pci-tph.h                       | 16 ++++++++--
 5 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
index b6cf22b9bd90..a5f14d17977c 100644
--- a/Documentation/PCI/tph.rst
+++ b/Documentation/PCI/tph.rst
@@ -47,15 +47,23 @@ Manage TPH
 
 To enable TPH for a device, use the following function::
 
-  int pcie_enable_tph(struct pci_dev *pdev, int mode);
+  int pcie_enable_tph(struct pci_dev *pdev, int mode,
+                      enum tph_req_policy req_policy);
 
 This function enables TPH support for device with a specific ST mode.
-Current supported modes include:
+
+Supported modes include:
 
   * PCI_TPH_ST_NS_MODE - NO ST Mode
   * PCI_TPH_ST_IV_MODE - Interrupt Vector Mode
   * PCI_TPH_ST_DS_MODE - Device Specific Mode
 
+Supported requester policies:
+
+  * TPH_REQ_AUTO     - Auto select by capability
+  * TPH_REQ_STANDARD - Force standard TPH (8-bit Steering Tag)
+  * TPH_REQ_EXTENDED - Force extended TPH (16-bit Steering Tag)
+
 `pcie_enable_tph()` checks whether the requested mode is actually
 supported by the device before enabling. The device driver can figure out
 which TPH mode is supported and can be properly enabled based on the
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 008c34cff7b4..1f8d3e728a9f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11846,7 +11846,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 #endif
 
 	/* Enable TPH support as part of IRQ request */
-	rc = pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
+	rc = pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE, TPH_REQ_AUTO);
 	if (!rc)
 		bp->tph_mode = PCI_TPH_ST_IV_MODE;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
index 997be91f0a13..26ce59d16785 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -55,7 +55,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *dev)
 	}
 
 	/* The OS doesn't support ST */
-	ret = pcie_enable_tph(pdev, PCI_TPH_ST_DS_MODE);
+	ret = pcie_enable_tph(pdev, PCI_TPH_ST_DS_MODE, TPH_REQ_AUTO);
 	if (ret)
 		return NULL;
 
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index b4ecc510033a..f7758445988e 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -373,14 +373,21 @@ EXPORT_SYMBOL(pcie_disable_tph);
  *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
  *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
  *
+ * @req_policy: TPH requester selection policy
+ *
+ *   - TPH_REQ_AUTO:     Auto select by capability
+ *   - TPH_REQ_STANDARD: Force standard TPH (8-bit ST)
+ *   - TPH_REQ_EXTENDED: Force extended TPH (16-bit ST)
+ *
  * Check whether the mode is actually supported by the device before enabling
- * and return an error if not. Additionally determine what types of requests,
- * TPH or extended TPH, can be issued by the device based on its TPH requester
- * capability and the Root Port's completer capability.
+ * and return an error if not. Select TPH requester type according to
+ * @req_policy and negotiated capability between device and root port. Return
+ * error for invalid policy or unsupported extended TPH requests.
  *
  * Return: 0 on success, otherwise negative value (-errno)
  */
-int pcie_enable_tph(struct pci_dev *pdev, int mode)
+int pcie_enable_tph(struct pci_dev *pdev, int mode,
+		    enum tph_req_policy req_policy)
 {
 	u32 reg;
 	u8 dev_modes;
@@ -401,10 +408,20 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	if (!((1 << mode) & dev_modes))
 		return -EINVAL;
 
-	pdev->tph_mode = mode;
+	if (req_policy == TPH_REQ_AUTO) {
+		pdev->tph_req_type = pdev->tph_ext_requester ?
+			PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
+	} else if (req_policy == TPH_REQ_STANDARD) {
+		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
+	} else if (req_policy == TPH_REQ_EXTENDED) {
+		if (!pdev->tph_ext_requester)
+			return -EINVAL;
+		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
+	} else {
+		return -EINVAL;
+	}
 
-	pdev->tph_req_type = pdev->tph_ext_requester ? PCI_TPH_REQ_EXT_TPH :
-						       PCI_TPH_REQ_TPH_ONLY;
+	pdev->tph_mode = mode;
 
 	/* Write them into TPH control register */
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 6f02b020d7d7..eb7f165b2570 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -21,6 +21,16 @@ enum tph_mem_type {
 	TPH_MEM_TYPE_PM		/* persistent memory */
 };
 
+/*
+ * TPH requester selection policy
+ * Used to choose standard/extended TPH when enabling TPH
+ */
+enum tph_req_policy {
+	TPH_REQ_AUTO,		/* Auto select by capability */
+	TPH_REQ_STANDARD,	/* Force standard TPH (8-bit ST) */
+	TPH_REQ_EXTENDED	/* Force extended TPH (16-bit ST) */
+};
+
 #ifdef CONFIG_PCIE_TPH
 int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
@@ -28,7 +38,8 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			enum tph_mem_type mem_type,
 			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
-int pcie_enable_tph(struct pci_dev *pdev, int mode);
+int pcie_enable_tph(struct pci_dev *pdev, int mode,
+		    enum tph_req_policy req_policy);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
@@ -40,7 +51,8 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 				      unsigned int cpu, u16 *tag)
 { return -EINVAL; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
-static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
+static inline int pcie_enable_tph(struct pci_dev *pdev, int mode,
+				  enum tph_req_policy req_policy)
 { return -EINVAL; }
 static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
-- 
2.17.1

