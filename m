Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401406;
	b=3JBIhSptcBpR98sQ65/pjOqu+663MuTGBisQbhdzyBuXX1nnav/KK1jgvBS0VLYcPZc+
	 Qf7LmopmofquHBmKNLy4gLqdLRCaou51mnfvdxyjGbT/j0lzbm4cHAwIJ/PnOiXt4KjPk
	 vohGVyf3KK/EehwwkiELWLVhbK3OJxvEGlIjyr6M8Fusk8qps4q8QTxMuHi9F/fOaiUCJ
	 kbBKD0lp3WE0myzvf1faymJkAwY78qOP3R/JqE3l4yHyOmAyR9bnu+CdOQ3TrHYOnEWSo
	 Mhwkq6Pkt0uD5iYzRRzmoJGQdA4SL3SPllNGHoCCUN1BlJ8YsS6xWHDwdQLusA4omcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401406;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=s4A2q5Mczd2bDRHMGHHHc1NKAHWWnGXAvrrcfk7noRo=;
	b=I3ZsAHY0Rw1eRZx0h/RKEluBxj00FRZ6BPg8lpeWViA+rP6oBgnHEcZthmwSLuchas5U
	 gJqC7VMwXJftLUvVr61iq3MjU5a8MP0wVGtSKzjtxRgWr+UA84130XCCoRROO+ijP4BRq
	 sIIaTuq9jW82UC5XXGZYkwEyEkva/jSt3jKfNG5GLB45Ih7Re3jY335lZzmo/1pLe+sIN
	 blZq+OQ65Fpo2T15N/thP1T1kXl3OWRqBKrbf1BGI5JRUmb2a0DNJ1NLgzxbG/lPZicpz
	 51ARjizJ7LpiEdKeg0ZrI1FIZJNH39v2H+J4m9tvkkIAPnXZFj2L3lvJcKcMGCUo1BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IXsrEvpt;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A67C606A337;
	Mon, 23 Nov 2026 02:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A67C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IXsrEvpt
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=s4A2q5Mczd2bDRHMGHHHc1NKAHWWnGXAvrrcfk7noRo=;
	b=IXsrEvptFO1lB7eMbdgmvIN/kL5Yeg0FrDEZ9rZQWfY9wfX/dehVVYtyO9hKO/dcj4/M7RILa
	cuMNh3SOntWlVQHrUVCpql2Y7SDdvh33ly5wtIrf9vBDRQVjOJMgntoNL8qbCCh5UrK5Ty+1Bv0
	azH3edHIKwIGsg4pYx6nv4g=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jXqnT3Rf1z1cyqB;
	Mon, 23 Nov 2026 10:36:13 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 4075240586;
	Mon, 23 Nov 2026 10:36:36 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:35 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 03/13] PCI/TPH: Cache negotiated max requester type at probe time
Date: Mon, 23 Nov 2026 10:36:18 +0800
Message-ID: <20261123023628.7728-4-fengchengwen@huawei.com>
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

pcie_enable_tph() recalculates the TPH requester capability and queries
root port completer type on every invocation, causing redundant config
space reads.

Calculate the negotiated maximum requester type once during pci_tph_init()
and cache it in a new pdev->tph_max_type bitfield. Simplify the enable path
by reusing the cached value to eliminate repeated hardware access.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c   | 45 ++++++++++++++++++++++++---------------------
 include/linux/pci.h |  4 +++-
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index c4ceb08204d6..58f7ba41e1f7 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -375,9 +375,8 @@ EXPORT_SYMBOL(pcie_disable_tph);
  *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
  *
  * Check whether the mode is actually supported by the device before enabling
- * and return an error if not. Additionally determine what types of requests,
- * TPH or extended TPH, can be issued by the device based on its TPH requester
- * capability and the Root Port's completer capability.
+ * and return an error if not. Automatically uses the pre-cached tph_max_type
+ * value, the negotiated maximum requester type between device and root port.
  *
  * Return: 0 on success, otherwise negative value (-errno)
  */
@@ -385,7 +384,6 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 {
 	u32 reg;
 	u8 dev_modes;
-	u8 rp_req_type;
 
 	/* Honor "notph" kernel parameter */
 	if (pci_tph_disabled)
@@ -397,6 +395,9 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	if (pdev->tph_enabled)
 		return -EBUSY;
 
+	if (pdev->tph_max_type == PCI_TPH_REQ_DISABLE)
+		return -EINVAL;
+
 	/* Sanitize and check ST mode compatibility */
 	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
 	dev_modes = get_st_modes(pdev);
@@ -405,23 +406,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
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
+	pdev->tph_req_type = pdev->tph_max_type;
 
 	/* Write them into TPH control register */
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
@@ -508,13 +493,31 @@ void pci_no_tph(void)
 
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
+	pdev->tph_max_type = tph_req_type;
+
 	num_entries = pcie_tph_get_st_table_size(pdev);
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6b577890fbb2..1dc3cb011dff 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -595,7 +595,9 @@ struct pci_dev {
 	struct gpio_desc *wake;		/* WAKE# GPIO */
 
 #ifdef CONFIG_PCIE_TPH
-	u16		tph_cap:15;	/* TPH capability offset */
+	u16		tph_cap:13;	/* TPH capability offset */
+	u16		tph_max_type:2; /* Negotiated max TPH requester type
+					   between device and root port */
 	u16		tph_enabled:1;	/* Whether TPH is enabled */
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
-- 
2.17.1

