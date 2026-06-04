Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA147ECCD;
	Thu,  4 Jun 2026 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579698; cv=none; b=bm8pIIR4pVgVn3p7aKG7aaKB40J0BYbZXxxsJp0Noi/zDtTnnTYCv17kfnnf+mswzHt5M5PuB8nVkTdHQgK2oSF3jAaxt8A7fxNHtLcdHKIzbqnAiYdtf+p5496FVNaTwa4u+3lLshYZWKYtaOni0epesyBLBNujYHQeCrikDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579698; c=relaxed/simple;
	bh=mDZ/OJ17h+wYRwEaXSeihbsTVRhunmVv3DqwFhUC8RI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inXwqg3CoDYm78+jwKXxhVmreXpxW/SFsmurd2KHfioZc7uxYxlSz0C5isJvsrDOvPsGK4+JmrDW/7H/VdnSGiLKFtqM+UKsJqaM3dVZ9Qp5Y5C6UFs1DUi0/QG5A9ukkLNdoblUrCWdSglizbzViNZ3Jl4CDDS5zDD721UJDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=54iC0F+W; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="54iC0F+W"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AV7vdMQpBpqoO346KaGqEgfAmOGFj8+N4jnJN5WpOeo=;
	b=54iC0F+WGUITCdJHqS+u+A+SquLCgq5WVBWxiKg1CWZIhITOEoUWfxTquogAZ0wGojieb6HtR
	TerI6GhPahLK4OB6wDy4Yyjs2SuhUlQCpwYrfwDPBKRlvNB2pUy/tCKcQCama2S4ktt0C5TMSFI
	Z635PqTMHXPk4kH4Cxt1k2g=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gWQD31zyQznTW4;
	Thu,  4 Jun 2026 21:20:19 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id B3DDB40561;
	Thu,  4 Jun 2026 21:28:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 21:28:11 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v16 03/12] PCI/TPH: Cache TPH requester capability at probe time
Date: Thu, 4 Jun 2026 21:27:55 +0800
Message-ID: <20260604132804.28678-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260604132804.28678-1-fengchengwen@huawei.com>
References: <20260604132804.28678-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Calculate the negotiated TPH requester type from device and root port
capabilities once in pci_tph_init().

Add tph_ext_support flag to cache whether the device is allowed to
issue Extended TPH requests after topology negotiation. If the final
requester type is disabled, clear TPH capability to prevent usage.

Simplify pcie_enable_tph() by using the cached requester capability
instead of recalculating every time.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c   | 43 +++++++++++++++++++++++++------------------
 include/linux/pci.h |  4 +++-
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index bef3a55539c4..951f0a33ff66 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -384,7 +384,6 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 {
 	u32 reg;
 	u8 dev_modes;
-	u8 rp_req_type;
 
 	/* Honor "notph" kernel parameter */
 	if (pci_tph_disabled)
@@ -404,23 +403,8 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
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
+	pdev->tph_req_type = pdev->tph_ext_support ? PCI_TPH_REQ_EXT_TPH :
+						     PCI_TPH_REQ_TPH_ONLY;
 
 	/* Write them into TPH control register */
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
@@ -510,13 +494,36 @@ void pci_no_tph(void)
 
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
+	if (tph_req_type == PCI_TPH_REQ_DISABLE) {
+		pdev->tph_cap = 0;
+		return;
+	}
+
+	pdev->tph_ext_support = !!(tph_req_type == PCI_TPH_REQ_EXT_TPH);
+
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 109182658f76..285c0f00882e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -588,7 +588,9 @@ struct pci_dev {
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
 #ifdef CONFIG_PCIE_TPH
-	u16		tph_cap:15;	/* TPH capability offset */
+	u16		tph_cap:14;	/* TPH capability offset */
+	u16		tph_ext_support:1; /* Indicate whether Extended TPH
+					    * requester is supported */
 	u16		tph_enabled:1;	/* Whether TPH is enabled */
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
-- 
2.17.1

