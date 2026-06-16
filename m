Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE94426EBF;
	Tue, 16 Jun 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606794; cv=none; b=E3Zm7rLblGmaSWoEk7PgcCzMsqcO+CViSuIuv0cgMk3jf1Htf9rjHNIThzfrZMo8A95yKOBa/TmJBzO5hJ0lg858XLYLR9B++kZQ+hoOxAqM35CJLF/4ZcUId4+EsbIGaV4EoM6d+kgjWLLBQwNEAEJN51xf2cH7xR3bia9Fkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606794; c=relaxed/simple;
	bh=BRRroXDkBaOPv9wjw0QIQhWqRH6EFnOJUdsZr1FzFwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBmSAhb8HMQVyXrIfiCKEct0356mqZHkGOX6u/8408A/2vjxEbuHDkDoI2rPt2xuxx0KrAuFpD2pM2sIO+P9g1gAgAIJ3U2/OteF02nbLG8WtMUXxTqjfEQ/ILJROpC9vMXvaCRs4cs84sz+tlPMeUiFrzqdEJe8d2gLzS+d9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZhnwlU13; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZhnwlU13"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=POCLP6q/BRUZWOzXjgfwgkrQxfg9Ud/zDOh5cR7OofM=;
	b=ZhnwlU13PsLtJgCsadh8nDKJlsvsjAHbEtO6StwThsTJxIG0JnnD+oqmgTYBEV0MuQvILIjTu
	rydyK6w3Rm70IKDXuCyYu/wSj2LuKypSwTHDywEZH+HCZmeV/9f+eYeePqS7olK4yTkrSoaMyoS
	KhpkCpssiLdLfSdEkGPNZvM=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gfk3q0TyGz1cyP2;
	Tue, 16 Jun 2026 18:38:31 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C5D9C40539;
	Tue, 16 Jun 2026 18:46:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 18:46:27 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v17 01/12] PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
Date: Tue, 16 Jun 2026 18:46:10 +0800
Message-ID: <20260616104621.41915-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260616104621.41915-1-fengchengwen@huawei.com>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
 include/linux/pci-tph.h |  5 +++++
 2 files changed, 10 insertions(+), 7 deletions(-)

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
index be68cd17f2f8..6f02b020d7d7 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -8,6 +8,7 @@
  */
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
+#include <linux/pci.h>
 
 /*
  * According to the ECN for PCI Firmware Spec, Steering Tag can be different
@@ -41,6 +42,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
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

