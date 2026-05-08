Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065535E951;
	Fri,  8 May 2026 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222473; cv=none; b=FGcVU/Vw9xo2+lgcNNIWG61JR+4K5gPc3XcWk+KGq1ecvKQerm3QtvNBxZEkOZRO38z4XfKViHMNPisIYX5KLd2Iv+X4p6zPUZTGxR42YLI3kpM6YeQg+ocUBIAiaHIT9Tsj9IrFH+RsRVP5IGtZKwCPBr6FO/gPiwJk5xgWtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222473; c=relaxed/simple;
	bh=jGWZt+muHQjHiDAtSM3t1BbGSIeNek4CA9L/iIFoteo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYAgrOMOx9kFZC2qKa5MDcMKzf8fdCGvXS7a+ptoE+YGiN7SdXrDmZocOm8HyTtljdFaUIRXOu3JpNRvVqJgniOsKITAP9reeRjlOeRda7ELyY8DwunZbw+NlcU5wa9lQ3jBiJaItlLU5KoaIGkaLx66VHY62bnod8OmxFC0V3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oBYbuELm; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oBYbuELm"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RMM7zbz5ogyu0ekYiyez9w+tUq9cgNHg57Z5pm8yAMs=;
	b=oBYbuELmUO/hWTgQK1BnaVASaEjX3GTwitjGCpO2D/zfkUDw4+zk/P+oek+md93soGfACsjkO
	k4V9fxXSa/rv/iJWIqGf4XAkVXBOxoJHNYP32g4zAXIsr4FpXwCFnIuPAsiH8Nb0AyXMsH2WxTG
	UL4y7guGL2fxS5pwlyoB9wU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gBfT41fl1z1T4Fv;
	Fri,  8 May 2026 14:33:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 569424056A;
	Fri,  8 May 2026 14:41:02 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 14:41:01 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v8 3/7] PCI/TPH: Fix pcie_tph_get_st_table_size() for MSI-X table location
Date: Fri, 8 May 2026 14:40:49 +0800
Message-ID: <20260508064053.37529-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260508064053.37529-1-fengchengwen@huawei.com>
References: <20260508064053.37529-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

pcie_tph_get_st_table_size() previously only returned valid size when ST
Table is in TPH Capability space. According to PCIe spec [1], ST table size
is also valid when ST Table is located in MSI-X table.

Fix it to return valid table size for both PCI_TPH_LOC_CAP and
PCI_TPH_LOC_MSIX locations.

[1] PCI Express Base 6.1 Table 7-258 TPH Requester Capability Register
ST Table Size:
- Value indicates the maximum number of ST Table entries the Function may
  use. Software reads this field to determine the ST Table Size N, which is
  encoded as N-1. For example, a returned value of 000 0000 0011b indicates
  a table size of four entries.
- There is an upper limit of 64 entries when the ST Table is located in the
  TPH Requester Extended Capability structure.
- When the ST Table is located in the MSI-X Table, this value is limited by
  the size of the MSI-X Table.
- This field is only applicable for Functions that implement an ST Table as
  indicated by the ST Table Location field. Otherwise, the value in this
  field is undefined.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index ba31b010f67a..de5bd7039cdc 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -191,7 +191,8 @@ EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
 
 /*
  * Return the size of ST table. If ST table is not in TPH Requester Extended
- * Capability space, return 0. Otherwise return the ST Table Size + 1.
+ * Capability space or MSI-X table, return 0. Otherwise return the
+ * ST Table Size + 1.
  */
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 {
@@ -200,7 +201,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 
 	/* Check ST table location first */
 	loc = pcie_tph_get_st_table_loc(pdev);
-	if (loc != PCI_TPH_LOC_CAP)
+	if (loc != PCI_TPH_LOC_CAP && loc != PCI_TPH_LOC_MSIX)
 		return 0;
 
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
-- 
2.17.1

