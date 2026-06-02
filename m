Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E643F23B7;
	Tue,  2 Jun 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411261; cv=none; b=C5/dls/AdzkjIdel+vvTLOvXxob7oAk1TWflDU/vHpn9+78odOUihn2rt/UYO+eDONzUjB/rIX32vQlRzg/b7KOdA3AnlaGtQDO/HOhzHbt1FfEWtSgGsp39kDEOsCoG9eigJzeL4kDKLO5AfwgHWxeuJ+iJfb2xmc5Je3VxszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411261; c=relaxed/simple;
	bh=3FaX2WJAhH/EujqnWLa0GLdnAJm92Pycr7hHKsBmRjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dzk+tfatMne3o4KNsOjINVEIUm/3CXRCKp01nwcMxzoEFwgMC7NX23HrJGJK1zNaO+Fi03JdJN8AVpT2rF5VxzVjzgDZAnjH0IcvpVaUA87bNJIpEmMAjQ7UrlR/XDa1Dwa9MlzVJcb4ldBvttAL9vdACpgOOZX06ZY7Hzyh/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sw+1TZ1c; arc=none smtp.client-ip=113.46.200.225
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
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gVCwr6k9Qz1K96V;
	Tue,  2 Jun 2026 22:33:00 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1706140573;
	Tue,  2 Jun 2026 22:40:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 22:40:48 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v15 02/10] PCI/TPH: Cache TPH requester capability at probe time
Date: Tue, 2 Jun 2026 22:40:15 +0800
Message-ID: <20260602144023.25254-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260602144023.25254-1-fengchengwen@huawei.com>
References: <20260602144023.25254-1-fengchengwen@huawei.com>
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

