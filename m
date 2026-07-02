Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E648034E;
	Thu,  2 Jul 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996157; cv=none; b=G7D88SNJhe8+cTM3PxBx+XzIqUF1KSNzFdA2ZkEwctJxf2AMc9++lcNFIDy8S0rw0DNBBPYpHe2eD1ZzrlQvs/MLN6BvBuc23NrnakHQfFZBOZuTaa/HbvTiL/ZtF9s3RSiLF7MIgruS3kzkfNuRqIKV2tqfuZ9fjp9sKoq0rj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996157; c=relaxed/simple;
	bh=lIA6OOvvnDwpWF9l4m51z7S4+oQxefUPkWZHVcFyHeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NV+XzU10WM1mhQ+Rx/Wm3saN19BiNhrwShBS2K/VQTxdnESeQGWdVh2GlX/HmoQr2J+k5DSzBydON3084SOkE8tNl4Iv/+ekLMlv7Mf4MEpCDoLMOGSOonxEgxSWRlZteAKPrhcLkGScvBxWTsUJMb5eqaROO9Cb+8yR8DEnfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kRhwfPJ8; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kRhwfPJ8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yFmJbHUJ4OyGuP62z70V/6zcCmwORpBgvba64hhIAhw=;
	b=kRhwfPJ86AHW4PiY3seBB3hyv9kIv0fOBCAo3D5as+HPB6FzstoV4XHKuFGF2hUTpB0InAu+e
	8XTIRx22KH5GyilHaVyCEGWapTumTcwv3zFvkj5tOoD3FXIigcYeXEjcuA8iYkwpyMXJAc+5dUx
	LSm3+u56AOM5TaFPi1EwSnE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4grbsT68Mrz12LFL;
	Thu,  2 Jul 2026 20:33:49 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 58BF440537;
	Thu,  2 Jul 2026 20:42:32 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:31 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 03/18] PCI/TPH: Cache TPH requester capability at probe time
Date: Thu, 2 Jul 2026 20:42:09 +0800
Message-ID: <20260702124224.57168-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260702124224.57168-1-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

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
index 489487158b99..4097787ea98a 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -383,7 +383,6 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 {
 	u32 reg;
 	u8 dev_modes;
-	u8 rp_req_type;
 
 	/* Honor "notph" kernel parameter */
 	if (pci_tph_disabled)
@@ -403,23 +402,8 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
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
@@ -506,13 +490,36 @@ void pci_no_tph(void)
 
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
index ce520523b152..a99eeea53c81 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -587,7 +587,9 @@ struct pci_dev {
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

