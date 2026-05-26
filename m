Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB913AA1A9;
	Tue, 26 May 2026 04:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768532; cv=none; b=b+5FntZYt7qn9bwBUpoviBqQD3rxERFCGP+I2onX/GLhV9Kj2rgJ/KPUlvd4/CCFf5qEUvyVzUlHbK+z9hQ9dJE7ksEfbzOLR+t7GL62mj5o7892Gz+2jiYhlLguQ+mFzghpX3dSzE/YutG/0SyYpuj6ya0Tf7xyiVGtLiaRK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768532; c=relaxed/simple;
	bh=8r7u902LSrHgxJENYPsqa786sEo2jPMvkSKNlOzpPko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xq9EqIq2MLQ7Dvks3UZQHSzTMGxjmRVIau3XpD/ekvJo6ZGQ2V3wZeFGVZq9S2G3ivfYVMC7Mh3h53AqYFIoAKh9k42Ygq/EMive0JD5WZb1bm8jx6gkN+SMkZQvK+MD6Yne1fZnGs0pCCQLVgx6ppa2MnZQQ6rh1JkYPD2prGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eXOYDrGq; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eXOYDrGq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WKZEGkZwbXmm+1B7l7ynzDNPB2zkkBtEzGpUNo6iDJ8=;
	b=eXOYDrGqYlY5lCuKN4C6c9YLv+ZxTz4Dt7usRWLd85j5i/70SDVdHjcbp3X/+IndSNxlEDidO
	1KvU4WlM2KGhbyMNVZZLFLypGi2h13Up5N8HKmSBQVbagriWJ7bOL/yESHgHPhhfvAPRYpA3zrB
	Y0DXc5Ujoi8lhavLxwx0Plk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gPfDl6pZHzLlSS;
	Tue, 26 May 2026 12:00:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 746D240561;
	Tue, 26 May 2026 12:08:40 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 12:08:39 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v12 4/6] PCI/TPH: Move tph_req_type initialization into pci_tph_init
Date: Tue, 26 May 2026 12:08:28 +0800
Message-ID: <20260526040830.52854-5-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260526040830.52854-1-fengchengwen@huawei.com>
References: <20260526040830.52854-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Relocate tph_req_type resolution logic from pcie_enable_tph() to
pci_tph_init(). The request type is fixed per device and root port topology
at probe time, no need recalculation on each TPH enable.

Also drop redundant tph_req_type reset in pcie_disable_tph(), the value
remains valid across disable/enable cycles.

This change allows pcie_tph_get_cpu_st() to work properly and retrieve
valid steering tag values even when TPH is not enabled on the device.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 95e2a95055ee..3660ad5d3623 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -371,7 +371,6 @@ void pcie_disable_tph(struct pci_dev *pdev)
 	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, 0);
 
 	pdev->tph_mode = 0;
-	pdev->tph_req_type = 0;
 	pdev->tph_enabled = 0;
 }
 EXPORT_SYMBOL(pcie_disable_tph);
@@ -396,7 +395,6 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 {
 	u32 reg;
 	u8 dev_modes;
-	u8 rp_req_type;
 
 	/* Honor "notph" kernel parameter */
 	if (pci_tph_disabled)
@@ -416,21 +414,6 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
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
 	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
 		return -EINVAL;
 
@@ -538,11 +521,27 @@ void pci_tph_init(struct pci_dev *pdev)
 {
 	int num_entries;
 	u32 save_size;
+	u8 rp_req_type;
+	u32 reg = 0;
 
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
 	if (!pdev->tph_cap)
 		return;
 
+	/* Get req_type supported by device and its Root Port */
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
+		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
+	else
+		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
+
+	/* Check if the device is behind a Root Port */
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
+		rp_req_type = get_rp_completer_type(pdev);
+		/* Final req_type is the smallest value of two */
+		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
+	}
+
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
-- 
2.17.1

