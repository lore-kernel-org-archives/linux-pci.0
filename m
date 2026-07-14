Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E01F0995;
	Tue, 14 Jul 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025821; cv=none; b=W0/vRkDZ5So1FSJzuD4Qek+AloOO3beBGvnlKFiiFFT8EZvlI8cw4EGMMkvi7Ad6DC/RmbAs3oKLeFnP/JNB1vXJdRDppremEhZqpgq5p8UbutUehTycNQHDEBs0sDch7XiHLqKOZ6KyE15VnBK8yLn7vZ0rWR3DxaGv4ZALa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025821; c=relaxed/simple;
	bh=7aKNl2WnPcUru0ffYJUP5RkfIngRe3xi7XOPLP06QoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGq3PtgbEtCvJ2+EpuyEIACyhIsStqklzlzwuM931pv/6wO46MAZSofXh4HWb9NnJuXhKswr0dKRztb1s1HteDGKmJeo71wskJB+0vIISdnB4gVmflxKVBdXfWRNB8qx8yYygeyVqXY3Q5WZmMreZMEKZmSV32I6s8sMReMd/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TgBifjnI; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TgBifjnI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=J+T+L55qZmrw9Gw7k6/gw7/jzvlOKJEWT9q/9HOZeXQ=;
	b=TgBifjnIFbHR+0Ucu4s0BZNNfphQGgaDF8G5cAwv7t42tHcEbJNGc34nWlkDfhs7Pvz1PXxbO
	Tv7tqWzUCQ0AB7+dTplqjbdlOwmm7tWMQghrDqv5B2C516fWsSnA6GrnK0CEWV3HncvcqrrMtxA
	gem0JwYgM3LR2S7yY2XAuZo=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gzwdf0jtRznTts;
	Tue, 14 Jul 2026 18:33:58 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D16724048B;
	Tue, 14 Jul 2026 18:43:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:33 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 04/16] PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
Date: Tue, 14 Jul 2026 18:43:13 +0800
Message-ID: <20260714104325.54444-5-fengchengwen@huawei.com>
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

Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/tph.c       | 12 +++++-------
 include/linux/pci-tph.h |  4 ++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index e7693fd9d676..41084a45b0bb 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -165,11 +165,14 @@ static u8 get_st_modes(struct pci_dev *pdev)
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
 
@@ -229,9 +232,6 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 
 	/* Check ST table location first */
 	loc = pcie_tph_get_st_table_loc(pdev);
-
-	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 	if (loc != PCI_TPH_LOC_CAP)
 		return 0;
 
@@ -360,8 +360,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
 
 	loc = pcie_tph_get_st_table_loc(pdev);
-	/* Convert loc to match with PCI_TPH_LOC_* */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 
 	switch (loc) {
 	case PCI_TPH_LOC_MSIX:
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 7743af6fe432..0e6aa1895050 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -45,6 +45,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
+{ return 0; }
+static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
+{ return PCI_TPH_LOC_NONE; }
 static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
 { return PCI_TPH_REQ_DISABLE; }
 static inline u8 pcie_tph_completer_type(struct pci_dev *pdev)
-- 
2.17.1

