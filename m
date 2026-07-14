Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FF37268B;
	Tue, 14 Jul 2026 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025820; cv=none; b=uNoa2e/HU3GB495xmUcHXJVO8hkB12ZSSRcJbgOIJHs7sBdWSEQDmMVk0HGtF5OiCqMhInljSH7E76NbHwous7ZGvdolPB6FPLXyqjZn2RBMBPvkWf2WYPfNc25qOIydM/5X5nfursuMMF9RdmOtHLAVOswQvlAE/0qrhmFyeVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025820; c=relaxed/simple;
	bh=pRrpJrkO5cyv5mTPuz3glNQ3dmcWGv4qZ0ij/YVkwUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKc1MRLY6qWHmf7TyzYWEmLefVXYG99IW6KvC0ielICHyOxFp1u163+Y8kC6mrGgBMJu+HdCES/g94R2HwU6pPqRHc9MOd1cXmRo4AGEdjrzJcosjHR/SSUZBDcWr4RBX8Zsauve388me3anyP6x+Rpg4a87Mnszbf6vsTjeEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wF/fpqHx; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wF/fpqHx"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=COlVdZm3GFe7ZNcixX9JJFKnaXY4qxRrblAqHFQF20A=;
	b=wF/fpqHxU71KZ8ldaovBG5Xq+5rLQtIbTfkXERuF8DXLlki3tA0sakMQLOOna1wKxAGKkSEfO
	WJG/pvIHH1XW6eSgA43oUrpWLW4HWBdOMh5FSP0WDG5q9ayPuYzp1z+xOeQA14sOOWpWAXkpfPE
	D2BdVJRSzQYInDXFJse0zlI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gzwf25QQSzRhQZ;
	Tue, 14 Jul 2026 18:34:18 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 445AA40561;
	Tue, 14 Jul 2026 18:43:35 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:34 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 07/16] PCI/TPH: Refactor pcie_enable_tph and add requester variant
Date: Tue, 14 Jul 2026 18:43:16 +0800
Message-ID: <20260714104325.54444-8-fengchengwen@huawei.com>
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

Refactor the core TPH enable logic by renaming the original function to
pcie_enable_tph_ext(), which accepts an explicit requester type argument.

- Keep the original pcie_enable_tph() as a compatibility wrapper; it uses
  the pre-cached tph_max_type negotiated capability automatically, so
  existing drivers calling pcie_enable_tph() require no modification.
- Export new pcie_enable_tph_ext() to support explicit requester type
  selection, intended for use by the upcoming VFIO TPH series.
- Add requester type validation to reject values out of hardware negotiated
  range or invalid reserved types.

Update pci-tph.h header and CONFIG_PCIE_TPH stub inline definitions
to match the new function signatures.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 41 ++++++++++++++++++++++++++++++-----------
 include/linux/pci-tph.h |  8 ++++++--
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index d123f91775c6..1239a919b9a4 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -409,21 +409,18 @@ void pcie_disable_tph(struct pci_dev *pdev)
 EXPORT_SYMBOL(pcie_disable_tph);
 
 /**
- * pcie_enable_tph - Enable TPH support for device using a specific ST mode
+ * pcie_enable_tph_ext - Enable TPH support with specific ST mode and
+ * requester type
  * @pdev: PCI device
- * @mode: ST mode to enable. Current supported modes include:
- *
- *   - PCI_TPH_ST_NS_MODE: NO ST Mode
- *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
- *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
+ * @mode: ST mode to enable: PCI_TPH_ST_(NS_MODE / IV_MODE / DS_MODE)
+ * @req_type: Requester type to enable: PCI_TPH_REQ_(TPH_ONLY / EXT_TPH)
  *
- * Check whether the mode is actually supported by the device before enabling
- * and return an error if not. Automatically uses the pre-cached tph_max_type
- * value, the negotiated maximum requester type between device and root port.
+ * Check whether the mode and requester type is actually supported by the
+ * device before enabling and return an error if not.
  *
  * Return: 0 on success, otherwise negative value (-errno)
  */
-int pcie_enable_tph(struct pci_dev *pdev, int mode)
+int pcie_enable_tph_ext(struct pci_dev *pdev, u8 mode, u8 req_type)
 {
 	u32 reg;
 	u8 dev_modes;
@@ -441,6 +438,11 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	if (pdev->tph_max_type == PCI_TPH_REQ_DISABLE)
 		return -EINVAL;
 
+	/* Sanitize and check TPH requester type compatibility */
+	if (req_type == PCI_TPH_REQ_DISABLE || req_type == 2 ||
+		req_type > pdev->tph_max_type)
+		return -EINVAL;
+
 	/* Sanitize and check ST mode compatibility */
 	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
 	dev_modes = get_st_modes(pdev);
@@ -449,7 +451,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
 	pdev->tph_mode = mode;
 
-	pdev->tph_req_type = pdev->tph_max_type;
+	pdev->tph_req_type = req_type;
 
 	/* Write them into TPH control register */
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
@@ -463,6 +465,23 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
 	return 0;
 }
+EXPORT_SYMBOL(pcie_enable_tph_ext);
+
+/**
+ * pcie_enable_tph - Enable TPH support for device using a specific ST mode
+ * @pdev: PCI device
+ * @mode: ST mode to enable: PCI_TPH_ST_(NS_MODE / IV_MODE / DS_MODE)
+ *
+ * Wrapper for pcie_enable_tph_ext(), automatically uses the pre-cached
+ * tph_max_type value (negotiated maximum requester type between device and
+ * root port).
+ *
+ * Return: 0 on success, otherwise negative value (-errno)
+ */
+int pcie_enable_tph(struct pci_dev *pdev, u8 mode)
+{
+	return pcie_enable_tph_ext(pdev, mode, pdev->tph_max_type);
+}
 EXPORT_SYMBOL(pcie_enable_tph);
 
 void pci_restore_tph_state(struct pci_dev *pdev)
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 0e6aa1895050..3055776495c1 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -29,7 +29,8 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			enum tph_mem_type mem_type,
 			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
-int pcie_enable_tph(struct pci_dev *pdev, int mode);
+int pcie_enable_tph_ext(struct pci_dev *pdev, u8 mode, u8 req_type);
+int pcie_enable_tph(struct pci_dev *pdev, u8 mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
@@ -43,7 +44,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 				      unsigned int cpu, u16 *tag)
 { return -EINVAL; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
-static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
+static inline int pcie_enable_tph_ext(struct pci_dev *pdev, u8 mode,
+				      u8 req_type)
+{ return -EINVAL; }
+static inline int pcie_enable_tph(struct pci_dev *pdev, u8 mode)
 { return -EINVAL; }
 static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
-- 
2.17.1

