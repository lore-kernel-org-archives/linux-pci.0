Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEEE3EEAE8;
	Wed, 27 May 2026 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875256; cv=none; b=ImmuQeV86FLpX7Gt5mY0meC4IqZPEdOjrhv70Z2z9c9qGL1qN6yC9wPqYRUTBizpMUvaDCOaBxnp18ALaR5H6N0bXgTRsoSPlYo+oRJI0JtTPFKvRadFgqnxTJcv74nXwSxq5+sH42L2OZoFkwxzljISJ7xwUpdJ9SVZj3oK7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875256; c=relaxed/simple;
	bh=SBhaNGvopMUB0QA3y3ElKRrDs4yRpiz4blPnlmVmjZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7Zhx6i64whkYgdAopRuL8F46fu+9rsNSAwaY+BGIU9iToCn8hskwEs1omk8uzz3+9p4LNiSMGqUzCzel4g4UK9RlnJET8QDquYJJcGdHmY+vSgp+M91v8JuL3oO+DHvDIvOsShz9BEsUKfUnJRZJgP9cv+syjLtW0LnGfzpfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0koQvSOZ; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0koQvSOZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3GiG3cQavwOGuowcVw1ihvChht+5DSSapmXEQabN9Cw=;
	b=0koQvSOZjFr8dgXYgO1suYWRTe0mvZR2DEcWWqGPuHiaPIgnVS/1LJ2UeszXulj4yM68NOSD3
	JjXn6U3Mv2quPMTbHdcrvGuFuQ2kS9wq9GjjcX8Axi0Y7RsPTUm0fKIHbWOdYJrgwN9zWv0OzLu
	1Jlg9SSwcNMhSuIUSEiQfoY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gQPj95VVdz1K9Vj;
	Wed, 27 May 2026 17:39:41 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 230904056E;
	Wed, 27 May 2026 17:47:26 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 17:47:25 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v13 3/8] PCI/TPH: Add requester selection policy to pcie_enable_tph()
Date: Wed, 27 May 2026 17:47:14 +0800
Message-ID: <20260527094719.43886-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260527094719.43886-1-fengchengwen@huawei.com>
References: <20260527094719.43886-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
 Documentation/PCI/tph.rst                     | 12 ++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  2 +-
 drivers/pci/tph.c                             | 29 +++++++++++++++----
 include/linux/pci-tph.h                       | 16 ++++++++--
 5 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
index b6cf22b9bd90..112630db756a 100644
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
+  * TPH_REQ_AUTO - Auto select by hardware/root port capability
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
index b4ecc510033a..04ff051ebed3 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -373,14 +373,21 @@ EXPORT_SYMBOL(pcie_disable_tph);
  *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
  *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
  *
+ * @req_policy: TPH requester selection policy
+ *
+ *   - TPH_REQ_AUTO: Auto select by hardware/root port capability
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
@@ -403,8 +410,18 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
 	pdev->tph_mode = mode;
 
-	pdev->tph_req_type = pdev->tph_ext_requester ? PCI_TPH_REQ_EXT_TPH :
-						       PCI_TPH_REQ_TPH_ONLY;
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
 
 	/* Write them into TPH control register */
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 7502fef81833..8a9c45b1e907 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -20,6 +20,16 @@ enum tph_mem_type {
 	TPH_MEM_TYPE_PM		/* persistent memory */
 };
 
+/*
+ * TPH requester selection policy
+ * Used to choose standard/extended TPH when enabling TPH
+ */
+enum tph_req_policy {
+	TPH_REQ_AUTO,		/* Kernel auto selection based on capability */
+	TPH_REQ_STANDARD,	/* Force standard TPH (8-bit ST) */
+	TPH_REQ_EXTENDED	/* Force extended TPH (16-bit ST) */
+};
+
 #ifdef CONFIG_PCIE_TPH
 int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
@@ -27,7 +37,8 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			enum tph_mem_type mem_type,
 			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
-int pcie_enable_tph(struct pci_dev *pdev, int mode);
+int pcie_enable_tph(struct pci_dev *pdev, int mode,
+		    enum tph_req_policy req_policy);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
@@ -39,7 +50,8 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
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

