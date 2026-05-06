Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB673EBF33;
	Wed,  6 May 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060796; cv=none; b=gA8Oeiuj7AiwMbNnDmt06MzMereI30BGbe4Dg1Mc6yDMnbxZV3Bbrfk46CN1y5RGm7JAVKj5Vvq2RZB9nJ2J0akg1Bep/G6r+glj0zyyJRg9ZXVxDj7vS0/2wt3qu/fUCeTOtCgdyNfVO7LLNcc6FOXi3+qppNThRgvIZ+iRjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060796; c=relaxed/simple;
	bh=Cb3lKr9ZT4E4FXXH5XoY9N6dSkYP7CZkxlXZCxhMIoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2v1CiaTCZ3PrLS7zJj6F70+Mhv7uXzYtQoBfwQzE2MFxem7nfKaNAWmX9+GtHkiQozuITS3RNgcIbXaTTm6U1EqVv+ir4urEJaVCIZVjzG37kxWw9a7AbpzbQJSRxc46GiAgSPhGMY3UoKcZU94HMGyk4zVrrkB5p5YkGDjWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tkoMLbra; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tkoMLbra"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=33nqALlC/zQMkVVrhUBV9oznkV8KXr0/Dt1jYSrqjtU=;
	b=tkoMLbradJVeoI2VlmEYvv46f0MOHjAhRSw87ubCLksQd4MTOiacqFqlt0S5aSuAhPouQnHmd
	mxoyVtPByNX1GuK2cVGOCpcckazq/I1JtUxRlUsJOxR6eiQmyhuIPdemCh0SgnydGb1HhaO6HZx
	NY4J4l1rqfJxePTba7F9/mg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g9VhX1pmYznTV8;
	Wed,  6 May 2026 17:39:24 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FBF840571;
	Wed,  6 May 2026 17:46:31 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 17:46:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v6 1/6] PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
Date: Wed, 6 May 2026 17:46:18 +0800
Message-ID: <20260506094623.29327-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506094623.29327-1-fengchengwen@huawei.com>
References: <20260506094623.29327-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
field value to bit 0. But the function is designed to return raw
PCI_TPH_LOC_* values as defined in the function comment.

This causes incorrect ST table location detection. Fix it by using bitwise
AND with PCI_TPH_CAP_LOC_MASK to return the unshifted field value matching
the function specification.

While this change appears to be a no-op within tph.c, the external caller
mlx5_st_create() relies on the documented function behavior, making this
fix necessary.

Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/pci/tph.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..f17b74b5fb1e 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -170,7 +170,7 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
 
-	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
+	return reg & PCI_TPH_CAP_LOC_MASK;
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
 
@@ -183,11 +183,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 	u32 reg;
 	u32 loc;
 
-	/* Check ST table location first */
 	loc = pcie_tph_get_st_table_loc(pdev);
-
-	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 	if (loc != PCI_TPH_LOC_CAP)
 		return 0;
 
@@ -316,8 +312,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
 
 	loc = pcie_tph_get_st_table_loc(pdev);
-	/* Convert loc to match with PCI_TPH_LOC_* */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 
 	switch (loc) {
 	case PCI_TPH_LOC_MSIX:
-- 
2.17.1

