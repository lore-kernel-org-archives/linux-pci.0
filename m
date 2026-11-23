Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401407;
	b=2aqkUAc26nn33F68YcZGqshL5d5L6B/woMNiumNy8I4M3YW8fa3xeTMyXTGeYhQjoVAP
	 cyiksz3qqg2dHkUKuCH7Pbwr6n2I4nQkPAqb9Ye3ccVhHvml5BgeKWapeioD9n43uwAbT
	 GwGsuN1wDFa7aqqd7fjEk2501an1awjtxMyfcBk7EhFLjkBii6DELDQtQNt4XgwKx81Mz
	 kGg33jlDKEQB3L+d7fqIPA2t34xF1ZKiMiaACrCppI5FCKg8RUU2as+MsB75zlkMDeQdN
	 UqMUslwaCe9XRsewf2jtp7NIy9BsjqrU9YtBURngOioydFjyMfYlQ09QJYJuY+fdDCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401407;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=EfwvLFp+Xl+cTnqb3cl9AZ7NYLaRAkd9og68ThKdWAA=;
	b=RGVKMI6jEQ1An3oeyAdQGN1pXPquhYf9bB/RLhu4GlxBMR8dvNxcjVQaXi70XAUks7wQ
	 RL1WC2mnteQiq9DV/Xq+o1ev1lVF1+N/WUh+GfTRA+2PZqn3oiiwmhnGdNd4sYYb9hDbA
	 cVV3pcfSZ52fdHDyzDhglQtcynFG9Om2LF0EIQoayvD+OcHXPgvPJZVy9dVCQ6qblsRWw
	 RIUMUe++7UTLjhAj2TSypNYsdP6zJ5khnrCLFzqfcC3vb1BD4F3LVIKyGA9CdhqLmrH2+
	 nQX/ZBZwSySeu4L5WuoyDAUVDCzUqa83esM2GlTVi8qJ72/Yv97TvHOLzJmMGHRKH8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2vwQyboG;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB7606A69D;
	Mon, 23 Nov 2026 02:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FB7606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2vwQyboG
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EfwvLFp+Xl+cTnqb3cl9AZ7NYLaRAkd9og68ThKdWAA=;
	b=2vwQyboGQBi9ScbDTEXdX6yoUsCqbrhY5ZsLWWnUwkwz1HjkoDk+4TOMc3We73BAQXS2xt8Io
	bIUiXNSt/u62Reyp/n68wmLl/D9NV7uUE5hXHKDdvGoBPyiiyNuOSPj9wZoanAVD63AopfjuimV
	yMvo4SV1SJjfmRjxHnFwzFM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jXqmz4dLqznTxM;
	Mon, 23 Nov 2026 10:35:47 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 023944057A;
	Mon, 23 Nov 2026 10:36:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:37 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 07/13] PCI/TPH: Add pcie_tph_set_st_entries() batch ST entry programming helper
Date: Mon, 23 Nov 2026 10:36:22 +0800
Message-ID: <20261123023628.7728-8-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261123023628.7728-1-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
 drivers/pci/tph.c       | 77 +++++++++++++++++++++++++----------------
 include/linux/pci-tph.h |  6 ++++
 2 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 51a065d83104..be44b27bd1ce 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -311,21 +311,19 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 EXPORT_SYMBOL(pcie_tph_get_cpu_st);
 
 /**
- * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
+ * pcie_tph_set_st_entries - Batch set Steering Tag entries in the ST table
  * @pdev: PCI device
- * @index: ST table entry index
- * @tag: Steering Tag to be written
+ * @start: starting ST table index
+ * @count: number of contiguous entries to write
+ * @tags: array of u16 tag values to program
  *
- * Figure out the proper location of ST table, either in the MSI-X table or
- * in the TPH Extended Capability space, and write the Steering Tag into
- * the ST entry pointed by index.
- *
- * Return: 0 if success, otherwise negative value (-errno)
+ * Return: number of successfully written entries (>0), or negative errno
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
@@ -333,9 +331,12 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 	if (!pdev->tph_enabled)
 		return -EINVAL;
 
+	if (!count)
+		return -EINVAL;
+
 	/* No need to write tag if device is in "No ST Mode" */
 	if (pdev->tph_mode == PCI_TPH_ST_NS_MODE)
-		return 0;
+		return count;
 
 	/*
 	 * Disable TPH before updating ST to avoid potential instability as
@@ -344,29 +345,47 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
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
+			set_ctrl_reg_req_en(pdev, pdev->tph_req_type);
+			return i > 0 ? i : (err > 0 ? -EINVAL : err);
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
index 5defe407ef75..703876d35ebe 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -43,6 +43,8 @@ static inline bool pcie_ext_tph_supported(struct pci_dev *pdev)
 
 int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
+int pcie_tph_set_st_entries(struct pci_dev *pdev, unsigned int start,
+			    unsigned int count, const u16 *tags);
 int pcie_tph_get_cpu_st_ext(struct pci_dev *dev, enum tph_mem_type mem_type,
 			    u8 req_type, unsigned int cpu, u16 *tag);
 int pcie_tph_get_cpu_st(struct pci_dev *dev, enum tph_mem_type mem_type,
@@ -60,6 +62,10 @@ static inline bool pcie_ext_tph_supported(struct pci_dev *pdev)
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

