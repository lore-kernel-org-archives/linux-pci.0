Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA1364949;
	Wed, 27 May 2026 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875252; cv=none; b=KNlrObmQuZmArXG3Xiy5PotmgiZQAmOByWOYsZ5rmRUvTIJNIz0BonUTNerziM7dMxm61JTdGQ4X4Lb3DlMqgrUsyvNdMQyE/stup0rFgzzAYKbqGRp/5unDoG7rNsRoMoHkpBDufvo1oR2JdtWT1RXxV971R0beZRlaiJQMmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875252; c=relaxed/simple;
	bh=3FaX2WJAhH/EujqnWLa0GLdnAJm92Pycr7hHKsBmRjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb4M1qFK7MoA2TrmPjFP/1NGcTFezGy9aneOk7lnpD/BD7/NuLQ4dNaGpCRFXu6dlxo2P+g0r+4jjSI/fMtBODy9dynTTpMxnO2iujV4L4Yh1l0fka1zhx6KM4SjXMKL8tgAT2u3tpQr6lkGd1PbVhlxdgXz+WsF8gxvJXPZEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sw+1TZ1c; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sw+1TZ1c"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xAcl6PF6laJpOoYxVBIWhgfoHYJzq8q8tMWFa6YpUdA=;
	b=sw+1TZ1cQFTWg4D1wJWYsR/Zc8byQqCieIQ1RQjXAd+fFPe6yLUcJpiOARs9PWuw94qbkgWVg
	515+H3nUSpdF2xJkSSHK3+ER7RiqnbsyPAlck+UGukZm9vVeAo5hA5GpUECW6VzZuJG890c55G3
	SEHH0BqxYGj9xVBt7jHiJOg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gQPhw4pS1znTXV;
	Wed, 27 May 2026 17:39:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C2C8E40539;
	Wed, 27 May 2026 17:47:25 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 17:47:25 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v13 2/8] PCI/TPH: Cache TPH requester capability at probe time
Date: Wed, 27 May 2026 17:47:13 +0800
Message-ID: <20260527094719.43886-3-fengchengwen@huawei.com>
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

Calculate the negotiated TPH requester type from device and root port
capabilities once in pci_tph_init().

Add tph_ext_requester flag to cache whether the device is allowed to
issue Extended TPH requests after topology negotiation. If the final
requester type is disabled, clear TPH capability to prevent usage.

Simplify pcie_enable_tph() by using the cached requester capability
instead of recalculating every time.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c   | 43 +++++++++++++++++++++++++------------------
 include/linux/pci.h |  1 +
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index bef3a55539c4..b4ecc510033a 100644
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
+	pdev->tph_req_type = pdev->tph_ext_requester ? PCI_TPH_REQ_EXT_TPH :
+						       PCI_TPH_REQ_TPH_ONLY;
 
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
+	pdev->tph_ext_requester = !!(tph_req_type == PCI_TPH_REQ_EXT_TPH);
+
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..0f4361aca794 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -509,6 +509,7 @@ struct pci_dev {
 	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
 	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
+	unsigned int    tph_ext_requester:1;	/* Can issue Extended TPH requests */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.17.1

