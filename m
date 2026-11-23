Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401405;
	b=YZhfjtSfKzNrCoUKc95d8Lwgfk168Sp+m0DzKb9S6jF1GaigqRtjUzu+jd2KUgKr8yGV
	 tc51wlDInnqxuOQuFWxMo6aFYadEKsgsI874nHdWiB8W5sZhMxJ09EueeoOpj2Hmjvgpj
	 1HJXHgpS6V+MzyxAe8j1a0mlZrQ1jYe3TWFT/29uoVzYAWBSkcAQ22FCl2l7eKN+QPifi
	 by7/Rag53q3EOLSiJtEOOWe97IFg25s0iIQlUqSfKpCNtKLvMzsrYxT9fcgqiJDhZsCJt
	 MIKpMZUjB2dNloJyLp5iC61ffH6pgds7bVJhvpvHErvZvZypyA9C+tz8c3SlE+6DLcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401405;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=hLnt9vqTjTcdvnMDlhN60imRqoAgG1siCmEJYGqw3Bs=;
	b=EC+xByijjwc2sVNuFFd1CJYs8j4dITzccTbJfNLoYp8ewIi92GMSP9nUjbBVhx449XXL
	 LhLqblOXCVypgzBXrsu2s4QGDuP/uekKahSOce2bhdsVBhxQaIpVEdOOuMndH4I57eVTa
	 4ztjMLwpzWeu0zBiz4EQEbzhj89p9rhEGpTClUMvFaAh0BeC3r3uBVzkFOe9PCz46QhBc
	 9kZb50YH1okj3eYvEwrFDqkI95ZdJCcPqKUj3/NqA6QUr5YKx3kWQGgI/AwpV+LJ1JaxF
	 YROV4yyXe7AVWeeBa4TQ9W1PIXf9HCAFpqihthUZ0l/VBpWcCxH2GZc4d9XM57cOhHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bX8jpM2R;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83A606A32C;
	Mon, 23 Nov 2026 02:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A83A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bX8jpM2R
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hLnt9vqTjTcdvnMDlhN60imRqoAgG1siCmEJYGqw3Bs=;
	b=bX8jpM2RIRKnSqTNK/Mx00VHma4R6oDBSO+KpzwxwVlirfDXKDP56F3P6b6PC7a2A/3we0Amf
	ZhVf9wO5VGAi+MkZasqiwjJwZxQgYjBZh+T9TnyYyZCq2ieqhefVM4W0way/q9roprOmE5wLy1i
	pfhJB9uWZFOi8EklN/+xu2M=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jXqnS3xjVz1d04Z;
	Mon, 23 Nov 2026 10:36:12 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 541834057C;
	Mon, 23 Nov 2026 10:36:35 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:34 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 01/13] PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
Date: Mon, 23 Nov 2026 10:36:16 +0800
Message-ID: <20261123023628.7728-2-fengchengwen@huawei.com>
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

pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
field value to bit 0. But the function is designed to return raw
PCI_TPH_LOC_* values as defined in the function comment.

This causes incorrect ST table location detection. Fix it by using bitwise
AND with PCI_TPH_CAP_LOC_MASK to return the unshifted field value matching
the function specification.

This doesn't make a difference to mlx5_st_create(), the lone external
caller, because it only checks for PCI_TPH_LOC_NONE (0), but will be needed
for callers that check for PCI_TPH_LOC_CAP or PCI_TPH_LOC_MSIX.

Also add tph_cap validation for pcie_tph_get_st_table_loc() to prevent
invalid PCI configuration space access when TPH is not supported. Add stub
functions for pcie_tph_get_st_table_size() and pcie_tph_get_st_table_loc()
when !CONFIG_PCIE_TPH.

Fixes: 0a61ec9cc51b ("PCI/TPH: Expose pcie_tph_get_st_table_size()")
Fixes: 7b8a8ec20cfc ("PCI/TPH: Expose pcie_tph_get_st_table_loc()")
Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/tph.c       | 12 +++++-------
 include/linux/pci-tph.h |  6 ++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 4d064b86befc..c4ceb08204d6 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -167,11 +167,14 @@ static u8 get_st_modes(struct pci_dev *pdev)
  */
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 {
-	u32 reg;
+	u32 reg = 0;
+
+	if (!pdev->tph_cap)
+		return PCI_TPH_LOC_NONE;
 
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
 
-	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
+	return reg & PCI_TPH_CAP_LOC_MASK;
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
 
@@ -186,9 +189,6 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 
 	/* Check ST table location first */
 	loc = pcie_tph_get_st_table_loc(pdev);
-
-	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 	if (loc != PCI_TPH_LOC_CAP)
 		return 0;
 
@@ -317,8 +317,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
 
 	loc = pcie_tph_get_st_table_loc(pdev);
-	/* Convert loc to match with PCI_TPH_LOC_* */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 
 	switch (loc) {
 	case PCI_TPH_LOC_MSIX:
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..980124dcb075 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,6 +9,8 @@
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
 
+#include <linux/pci.h>
+
 /*
  * According to the ECN for PCI Firmware Spec, Steering Tag can be different
  * depending on the memory type: Volatile Memory or Persistent Memory. When a
@@ -41,6 +43,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
+{ return 0; }
+static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
+{ return PCI_TPH_LOC_NONE; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

