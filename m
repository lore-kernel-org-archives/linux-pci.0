Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB13ECBFD;
	Wed, 27 May 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875253; cv=none; b=ZL9P2aItMODJPwpb+hFpbPRptnI7AxwfslcFRyYfhmqZwze/dkDKit7HFxqVfXxZgUNizXOvlbM7Ll3ypQFz2OKyxnoZtRvCvPb5wtFpD+UresqP4EedSqdF6CD9jBLmYRS9cg6CnBiFtddcJtvrV2Vu+f+cC+baPcnEbTOv0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875253; c=relaxed/simple;
	bh=AJLzBytr62xHaBsgrznfrHRdwzkJynMxrxwwqMjXG6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTpTHp0aBG5oqWkq6lf/omn+2w5jAYti2vsLcpnuWWzSuppplDb0A/sFUuHcp4q1zSsUHdouCfKNyxxxzQkoxGKvopf03q0Xp/+faRlJZmkaXXQfdhYEsorruRpGy13y1W6TDw0odp7HwKTmPp9/OPdgs5RPGrZ0SZ3knIw6NPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PUWQJX79; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PUWQJX79"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=w4IkP7oe0CMiNx0B/2njmQduX3jI/5PECyRtGikKUhQ=;
	b=PUWQJX79lhKJWVRNgltcH9/3XsO0LEMN1M5Otril5r9SoPlMfAR64mAFPIgbTOQ+ZUk26BYZF
	qPHZkvuxoEB6jtLFcQEMOyuf9PdZwukPf+iXcc44IY1m1gMWTXTs4X5ou49Lt/+H1WlFA7+XBim
	bC9/UaUBOiW3NQH8rHBQrIg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gQPj63BrszmV6T;
	Wed, 27 May 2026 17:39:38 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 55AA340539;
	Wed, 27 May 2026 17:47:25 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 17:47:24 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v13 1/8] PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
Date: Wed, 27 May 2026 17:47:12 +0800
Message-ID: <20260527094719.43886-2-fengchengwen@huawei.com>
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
index 91145e8d9d95..bef3a55539c4 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -166,11 +166,14 @@ static u8 get_st_modes(struct pci_dev *pdev)
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
 
@@ -185,9 +188,6 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 
 	/* Check ST table location first */
 	loc = pcie_tph_get_st_table_loc(pdev);
-
-	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 	if (loc != PCI_TPH_LOC_CAP)
 		return 0;
 
@@ -316,8 +316,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
 
 	loc = pcie_tph_get_st_table_loc(pdev);
-	/* Convert loc to match with PCI_TPH_LOC_* */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 
 	switch (loc) {
 	case PCI_TPH_LOC_MSIX:
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..7502fef81833 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -41,6 +41,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
+{ return 0; }
+static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
+{ return 0; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

