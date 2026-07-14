Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3D377019;
	Tue, 14 Jul 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025821; cv=none; b=bAXdzpiHYVcvL54iu3xuIciekpc86GxdGDSYPKB9WeIbaAyIfNOQiQzuq0Rg17wUtvrD1PVqqvHRy910Lwi62zD4Ob++Iv9BxHmY+5K9Ge2ZHPmQaEYlZ4JVJ6W01OVE5Ioi8lkXLTPEMozCMHE9ClZW9IflLsjHzA+p+Ig6xGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025821; c=relaxed/simple;
	bh=jaItuoiGd/qYiDBvNvINCbawmc8Zt0SZrVrWJPGlKAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwjg1SkS8SPn+fNTNGHnZTxSJunedrQKGF8Tbp01+zSVTDnY7cn+eAN3OS5jfrosWb5V93xpS6RT+BdVF63q8I0+lVtooBZthXRxks1I/eWPJWSTIKBFdO0vt2AU28JAh3e8mQVhoukvNIsggKQOsUCmZXoq7lH7HxOCHF41eNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fMyPRkKB; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fMyPRkKB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1H432/95ov9UV1/4tk7WKRccJMvqEkYc94jgXM1YlKA=;
	b=fMyPRkKBXyvs1zL/1SuyltZwZ19IBJJJw7RUgctikWr21ZGKbYkwr+7+ArYsdK8WWy4KMLkx3
	H6uhZzCgke5vpc3Mefj0aLEEXK8eD+C0lFAQoJN/dZRm5+3+6O1trZAx1PbdEb11q9aa5u8dAbX
	IpzAptR1tfFiN9k704qw3/Y=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzwdy41CnzKm9T;
	Tue, 14 Jul 2026 18:34:14 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id CE9FC4056A;
	Tue, 14 Jul 2026 18:43:34 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:34 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 06/16] PCI/TPH: Cache negotiated max requester type at probe time
Date: Tue, 14 Jul 2026 18:43:15 +0800
Message-ID: <20260714104325.54444-7-fengchengwen@huawei.com>
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

pcie_enable_tph() recalculates the TPH requester capability and queries
root port completer type on every invocation, causing redundant config
space reads.

Calculate the negotiated maximum requester type once during pci_tph_init()
and cache it in a new pdev->tph_max_type bitfield. Simplify the enable path
by reusing the cached value to eliminate repeated hardware access.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c   | 45 ++++++++++++++++++++++++---------------------
 include/linux/pci.h |  4 +++-
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 41084a45b0bb..d123f91775c6 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -418,9 +418,8 @@ EXPORT_SYMBOL(pcie_disable_tph);
  *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
  *
  * Check whether the mode is actually supported by the device before enabling
- * and return an error if not. Additionally determine what types of requests,
- * TPH or extended TPH, can be issued by the device based on its TPH requester
- * capability and the Root Port's completer capability.
+ * and return an error if not. Automatically uses the pre-cached tph_max_type
+ * value, the negotiated maximum requester type between device and root port.
  *
  * Return: 0 on success, otherwise negative value (-errno)
  */
@@ -428,7 +427,6 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 {
 	u32 reg;
 	u8 dev_modes;
-	u8 rp_req_type;
 
 	/* Honor "notph" kernel parameter */
 	if (pci_tph_disabled)
@@ -440,6 +438,9 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	if (pdev->tph_enabled)
 		return -EBUSY;
 
+	if (pdev->tph_max_type == PCI_TPH_REQ_DISABLE)
+		return -EINVAL;
+
 	/* Sanitize and check ST mode compatibility */
 	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
 	dev_modes = get_st_modes(pdev);
@@ -448,23 +449,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
 	pdev->tph_mode = mode;
 
-	/* Get req_type supported by device and its Root Port */
-	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
-	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
-		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
-	else
-		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
-
-	/* Check if the device is behind a Root Port */
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
-		rp_req_type = get_rp_completer_type(pdev);
-
-		/* Final req_type is the smallest value of two */
-		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
-	}
-
-	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
-		return -EINVAL;
+	pdev->tph_req_type = pdev->tph_max_type;
 
 	/* Write them into TPH control register */
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
@@ -551,13 +536,31 @@ void pci_no_tph(void)
 
 void pci_tph_init(struct pci_dev *pdev)
 {
+	u8 tph_req_type, rp_req_type;
 	int num_entries;
 	u32 save_size;
+	u32 reg = 0;
 
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
 	if (!pdev->tph_cap)
 		return;
 
+	/* Get req_type supported by device and its Root Port */
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
+		tph_req_type = PCI_TPH_REQ_EXT_TPH;
+	else
+		tph_req_type = PCI_TPH_REQ_TPH_ONLY;
+
+	/* Check if the device is behind a Root Port */
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
+		rp_req_type = get_rp_completer_type(pdev);
+		/* Final req_type is the smallest value of two */
+		tph_req_type = min(tph_req_type, rp_req_type);
+	}
+
+	pdev->tph_max_type = tph_req_type;
+
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ce520523b152..5ed58799a9b1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -587,7 +587,9 @@ struct pci_dev {
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
 #ifdef CONFIG_PCIE_TPH
-	u16		tph_cap:15;	/* TPH capability offset */
+	u16		tph_cap:13;	/* TPH capability offset */
+	u16		tph_max_type:2; /* Negotiated max TPH requester type
+					   between device and root port */
 	u16		tph_enabled:1;	/* Whether TPH is enabled */
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
-- 
2.17.1

