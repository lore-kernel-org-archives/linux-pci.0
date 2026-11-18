Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993175;
	b=XfI3QbnxGeYDRy/T8J648Fdk5+D/zZmAi/+IUiQZa/ZQxxSUKtc9X5HJOFL9Tdab1tK0
	 XiVWKf3z4MQ3/S6IPlXyzQMLH20cX7qjMjqfLrKVWxaMj3UyhKiFjPTOdkpS8aVyjZXsJ
	 lmbutubwiW/85lt5XwRefHngDHAwYvmRSpRk7/WxuyaGXjPKio09jR4pRSY7QmtNDJg5K
	 Z6WFlyl/5JvRsEP2b5AOwcguE3qjde7E8jthMyMoi3ptI8unTEI/R5sUismYavz9g3E9y
	 QlX099StagTjDQOcsuyFbP/ysdkKIVQLQ3Ay+Q8E9KpxN9kxbCG0Or/+JyKISfy+WPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993175;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=ipNAFaNKhFHSnkUbXxstTEs6appl1mmpWidtf64WTCU=;
	b=ZcB0td+Klr3MS3iGlX+TjT3EYLFT+Cy7VZQufbAV4sSlD+Jv9YjEL24kzw5NAYVwjScu
	 itX2ePnQCSPYi5KdipIPevhdSN0ojN2BKLhfHTZKR5J1V8XS0NoVKeo+uVzOD5unuy0N4
	 wp3XnejWgihyzF5aGt/xgI1b+M5diGxjn0KpV5+g/CDVStm3tJ+V2x6r5WlM3X1b22DL3
	 gA/htwuLUHaUdnzK8c4427ss96TwOr+knGKoot9Ei3AfrwF6wmEhua72vG/kfL83A0ZTf
	 ew1dFkQqmjtRsDWZWR+0PLnUBNM8AnQh4nSbCOw6XdK2a0iIf1XjvROuIOEkIMQnNlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3dOZO9R1;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607A606A32F;
	Wed, 18 Nov 2026 09:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E607A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3dOZO9R1
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ipNAFaNKhFHSnkUbXxstTEs6appl1mmpWidtf64WTCU=;
	b=3dOZO9R1FKWLRlIK6ypsgsg3cbTjpp6oh+Hv5QQO/rr4biXXnBXa7hrfA/gART2B24IuzJX9l
	8CiLVclnqNXepzRfLKCRXWN1JbZFSN9i7FMltDNyrc4IZCFJ7ZHA+zJRrjnX/iRkB06rS5m0jy/
	dPrOYWxYqGOhIXPMu8rSWu8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jTwpK5SXgz12LCq;
	Wed, 18 Nov 2026 17:11:53 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 07258202E6;
	Wed, 18 Nov 2026 17:12:46 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:45 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 01/13] PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
Date: Wed, 18 Nov 2026 17:12:26 +0800
Message-ID: <20261118091238.45992-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261118091238.45992-1-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
index 4d064b86befc..c4ceb08204d6 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -167,11 +167,14 @@ static u8 get_st_modes(struct pci_dev *pdev)
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
 
@@ -186,9 +189,6 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 
 	/* Check ST table location first */
 	loc = pcie_tph_get_st_table_loc(pdev);
-
-	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 	if (loc != PCI_TPH_LOC_CAP)
 		return 0;
 
@@ -317,8 +317,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
 
 	loc = pcie_tph_get_st_table_loc(pdev);
-	/* Convert loc to match with PCI_TPH_LOC_* */
-	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
 
 	switch (loc) {
 	case PCI_TPH_LOC_MSIX:
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..159ffb82b34e 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -41,6 +41,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
+{ return 0; }
+static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
+{ return PCI_TPH_LOC_NONE; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

