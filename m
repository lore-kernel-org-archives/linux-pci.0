Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973E379EFF;
	Tue, 14 Jul 2026 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025822; cv=none; b=e9dID8J1Qvhw+K0/gZkQ6KRqhYIEDy0lKvtAPgcUbuU7X0s54h/m1AJZYd6qC1KoMZFpV3ZaJYarK4yulvo+DEvt0z3UGuKHD1sBYFv8rwkvbkVBdkCm3oNLYxEj7Vkmn7K/mP/fD7mvphcpqtEkvG1LI08RRlnZ6spiH8qnGoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025822; c=relaxed/simple;
	bh=YuspcbHaEk/NPQwy+h3hJSsRugW4gFxHJrpjLeCR0c8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wi/QOyDncLksFz5pCsP9HR5Cnv3Hlv5EarOvRSujfORRzObbLPNjSGnaqNg4WUKPZDoFWIimTl93SF9DWq2ZyTK6wYxF/LoB2dh6HB69qp/2kRTx8dcOh6PwsnPUoUDBM9Anj2Vn7Y9Feo/mwhApRk8m6zAphtKEJ0MSd0sltVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KziSSuVJ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KziSSuVJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O8fU4d8HNEIZbDAtzsrr8cI7XhKSRUKRbUgavPNfbQs=;
	b=KziSSuVJdxFxPhYdga4pT9EYLr8WRvDdwbx1UA3wtCImriRfwjuyfXiA5ReT05kVGd4sb5tfK
	uN01HFFnwFYg7ty1tqV/nu7uAd4hFDhZMREGChp/01EVD46gS10EdYipIRMrfBpnoIar5G8pycA
	owa9Ty8L+DkBYgQRF0lPgIU=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gzwdj0RYCznTts;
	Tue, 14 Jul 2026 18:34:01 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C7B6D40578;
	Tue, 14 Jul 2026 18:43:36 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:36 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 10/16] PCI/TPH: Add pcie_tph_set_st_entries() batch ST entry programming helper
Date: Tue, 14 Jul 2026 18:43:19 +0800
Message-ID: <20260714104325.54444-11-fengchengwen@huawei.com>
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

Add batch variant pcie_tph_set_st_entries() to write a contiguous range
of ST table entries, returning the number of successfully written entries
or negative errno.
- Keep original pcie_tph_set_st_entry() as a wrapper for backward
  compatibility
- Disable/enable TPH once per batch instead of per entry for better
  performance
- Add header declaration and fallback static inline version
- Add error logging for failed ST entry writes

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 74 +++++++++++++++++++++++++----------------
 include/linux/pci-tph.h |  6 ++++
 2 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 633dc6308b68..8194f8b45e3c 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -354,21 +354,19 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 EXPORT_SYMBOL(pcie_tph_get_cpu_st);
 
 /**
- * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
+ * pcie_tph_set_st_entries - Batch set Steering Tag entries in the ST table
  * @pdev: PCI device
- * @index: ST table entry index
- * @tag: Steering Tag to be written
- *
- * Figure out the proper location of ST table, either in the MSI-X table or
- * in the TPH Extended Capability space, and write the Steering Tag into
- * the ST entry pointed by index.
+ * @start: starting ST table index
+ * @count: number of contiguous entries to write
+ * @tags: array of u16 tag values to program
  *
- * Return: 0 if success, otherwise negative value (-errno)
+ * Return: number of successfully written entries, or negative errno
  */
-int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
+int pcie_tph_set_st_entries(struct pci_dev *pdev, unsigned int start,
+			    unsigned int count, const u16 *tags)
 {
-	u32 loc;
 	int err = 0;
+	u32 loc, i;
 
 	if (!pdev->tph_cap)
 		return -EINVAL;
@@ -378,7 +376,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 
 	/* No need to write tag if device is in "No ST Mode" */
 	if (pdev->tph_mode == PCI_TPH_ST_NS_MODE)
-		return 0;
+		return count;
 
 	/*
 	 * Disable TPH before updating ST to avoid potential instability as
@@ -387,29 +385,47 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
 
 	loc = pcie_tph_get_st_table_loc(pdev);
-
-	switch (loc) {
-	case PCI_TPH_LOC_MSIX:
-		err = pci_msix_write_tph_tag(pdev, index, tag);
-		break;
-	case PCI_TPH_LOC_CAP:
-		err = write_tag_to_st_table(pdev, index, tag);
-		break;
-	default:
-		err = -EINVAL;
-	}
-
-	if (err) {
-		pcie_disable_tph(pdev);
-		return err;
+	for (i = 0; i < count; i++) {
+		switch (loc) {
+		case PCI_TPH_LOC_MSIX:
+			err = pci_msix_write_tph_tag(pdev, start + i, tags[i]);
+			break;
+		case PCI_TPH_LOC_CAP:
+			err = write_tag_to_st_table(pdev, start + i, tags[i]);
+			break;
+		default:
+			err = -EINVAL;
+		}
+		if (err != 0) {
+			pci_err(pdev, "failed to set steering tag: %s table, index=%u, tags=%u, ret=%d\n",
+				(loc == PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST",
+				start + i, tags[i], err);
+			pcie_disable_tph(pdev);
+			return i > 0 ? i : err;
+		}
 	}
 
 	set_ctrl_reg_req_en(pdev, pdev->tph_req_type);
 
-	pci_dbg(pdev, "set steering tag: %s table, index=%d, tag=%#04x\n",
-		(loc == PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST", index, tag);
+	pci_dbg(pdev, "batch set steering tag: %s table, start=%u, count=%u success!\n",
+		(loc == PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST", start, count);
 
-	return 0;
+	return count;
+}
+EXPORT_SYMBOL(pcie_tph_set_st_entries);
+
+/**
+ * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
+ * @pdev: PCI device
+ * @index: ST table entry index
+ * @tag: Steering Tag to be written
+ *
+ * Return: 0 if success, otherwise negative value (-errno)
+ */
+int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
+{
+	int ret = pcie_tph_set_st_entries(pdev, index, 1, &tag);
+	return ret == 1 ? 0 : ret;
 }
 EXPORT_SYMBOL(pcie_tph_set_st_entry);
 
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 04b521b7c2c7..c26bf8bba478 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -37,6 +37,8 @@ enum tph_mem_type {
 	((pdev)->tph_max_type == PCI_TPH_REQ_EXT_TPH)
 int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
+int pcie_tph_set_st_entries(struct pci_dev *pdev, unsigned int start,
+			    unsigned int count, const u16 *tags);
 int pcie_tph_get_cpu_st_ext(struct pci_dev *dev, enum tph_mem_type mem_type,
 			    u8 req_type, unsigned int cpu, u16 *tag);
 int pcie_tph_get_cpu_st(struct pci_dev *dev, enum tph_mem_type mem_type,
@@ -54,6 +56,10 @@ u8 pcie_tph_completer_type(struct pci_dev *pdev);
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
 { return -EINVAL; }
+static inline int pcie_tph_set_st_entries(struct pci_dev *pdev,
+					  unsigned int start,
+					  unsigned int count, const u16 *tags)
+{ return -EINVAL; }
 static inline int pcie_tph_get_cpu_st_ext(struct pci_dev *dev,
 					  enum tph_mem_type mem_type,
 					  u8 req_type, unsigned int cpu,
-- 
2.17.1

