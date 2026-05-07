Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1793B9DB6;
	Thu,  7 May 2026 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159409; cv=none; b=Xvr6QyuD50XnTMaVOni2mVaUGDhXjhLoXSIqBldpwiOBzrXc59xXLGjf+wtCL0c0dXW3R1mPfmgchrNmX4bQk3YNTf2H9H/13i4bokV/ApzjnZXlx3CXJmovLJBcMcrHs2vMtCl77DF3tm4AuTPdcuHvpKZml9uSR8lHTy98fy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159409; c=relaxed/simple;
	bh=Jl36QBFaB1npZ4nQkXnLfLEiPBTpWQe0eZV5jvbLvV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9Vhjg8hyTZg9/Eom0Wujz6fP7Q2khR8Q5lgmR3/qgru3xF8YeId8UTjNowfRwGF8YCD7WUozqHGQILxJR2dqjq4a3XQC/RrgD0sMFjVIvWoH9PfTI5bpO1WB24KeZgiNse8jftCT/odIl98OAEHfG25nJWQ1Qem+bYov4IVjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Akaxkqx8; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Akaxkqx8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uIqZ4KBp1zO/lcRi0QiZxRKpi2g0llki1FIHFBCdG/E=;
	b=Akaxkqx8YW51TvNdywk7oh0bPH5uf6mDumcJvdyulTx6oabACOmULwGQFrdI9zSaGr29esOxj
	X2t8S71U3c27u1dqr+jgYHcovil0MDb090JE8YTVZ0wf+MkazxHApk6fozi3Zr2QUjDShl5BJHv
	EvO7cjxyiRqqUm1gylpmEhs=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gBC9X6LKJz1prlT;
	Thu,  7 May 2026 21:03:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7369220104;
	Thu,  7 May 2026 21:10:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 21:10:02 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v7 1/6] PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
Date: Thu, 7 May 2026 21:09:51 +0800
Message-ID: <20260507130956.34441-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260507130956.34441-1-fengchengwen@huawei.com>
References: <20260507130956.34441-1-fengchengwen@huawei.com>
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

Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/tph.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..877cf556242b 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -170,7 +170,7 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
 
-	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
+	return reg & PCI_TPH_CAP_LOC_MASK;
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
 
@@ -185,9 +185,6 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 
 	/* Check ST table location first */
 	loc = pcie_tph_get_st_table_loc(pdev);
-
-	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 	if (loc != PCI_TPH_LOC_CAP)
 		return 0;
 
@@ -316,8 +313,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
 
 	loc = pcie_tph_get_st_table_loc(pdev);
-	/* Convert loc to match with PCI_TPH_LOC_* */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 
 	switch (loc) {
 	case PCI_TPH_LOC_MSIX:
-- 
2.17.1

