Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC43ECBDF;
	Wed,  6 May 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060796; cv=none; b=V/JtFERem8hekCe70w+JNEeBpXn9AVJKCCom+lA3wuA+HqSkZDdgdfxKNLSpsTtR/QRtncVwwT4MqaWWHxrPeV53hvHXwraHb232YWA5X8OuGbkl8dO3El0Sce/6E1gBuLQaRW29G2r4UdcigtRSpEmPXPyjq7Kf6gz40CaMrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060796; c=relaxed/simple;
	bh=nc+kMNBiVpPpNZkDNxsYRsFUiQTmFjOejAYkxZ+729E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sv8yi1gE4F3k5zwc77azyVpRzYojDL+D51/e4wRJxalz1hDzJcCYkLcqbwB2r0uNGOao+nVDCPOXt+kA4KL90sQbbwOeQhGkTDqBghN3aH6yHYA9zDZH3JnC6zXyHWpQ11zN91ICZD7fkhYeyjxhwcrwr8H31DGACKTcbO9y6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ez8h+2P4; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ez8h+2P4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ehw2qEU2k6FkgAstiAZCoKUA1h6nFfq+GSfhBIOtQO8=;
	b=Ez8h+2P4NukROIwAsoPu2o3OSPv4tJIon7d+jZQWNits3e2jxuchEKMx+Y0Zdd0WcAUpftSxr
	i5+vBKqyQYIn/xrfgZhs7Na70j+1bRt9xiCUEImFggmQgJ+XVraCl5uivmVhjHL3fK6hswDBU0q
	CZ68bpzkRx2Io7z7zW7Lcek=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4g9VjB5hwJzmV69;
	Wed,  6 May 2026 17:39:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 72FE740562;
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
Subject: [PATCH v6 2/6] PCI/TPH: Export pcie_tph_get_st_modes() for external use
Date: Wed, 6 May 2026 17:46:19 +0800
Message-ID: <20260506094623.29327-3-fengchengwen@huawei.com>
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

Export the helper to retrieve supported PCIe TPH steering tag modes so
that drivers like VFIO can query and expose device capabilities to
userspace.

Add stub functions for pcie_tph_get_st_table_size() and
pcie_tph_get_st_table_loc() when !CONFIG_PCI_TPH.

Add tph_cap validation for pcie_tph_get_st_modes() and
pcie_tph_get_st_table_loc() to prevent invalid PCI configuration
space access when TPH is not supported.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/tph.c       | 20 ++++++++++++++++++--
 include/linux/pci-tph.h |  7 +++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index f17b74b5fb1e..ba31b010f67a 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -145,15 +145,27 @@ static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
 	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
 }
 
-static u8 get_st_modes(struct pci_dev *pdev)
+/**
+ * pcie_tph_get_st_modes - Get supported Steering Tag modes
+ * @pdev: PCI device to query
+ *
+ * Return:
+ *  Bitmask of supported ST modes (PCI_TPH_CAP_ST_NS, PCI_TPH_CAP_ST_IV,
+ *                                 PCI_TPH_CAP_ST_DS)
+ */
+u8 pcie_tph_get_st_modes(struct pci_dev *pdev)
 {
 	u32 reg;
 
+	if (!pdev->tph_cap)
+		return 0;
+
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
 	reg &= PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS;
 
 	return reg;
 }
+EXPORT_SYMBOL(pcie_tph_get_st_modes);
 
 /**
  * pcie_tph_get_st_table_loc - Return the device's ST table location
@@ -168,6 +180,9 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 {
 	u32 reg;
 
+	if (!pdev->tph_cap)
+		return PCI_TPH_LOC_NONE;
+
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
 
 	return reg & PCI_TPH_CAP_LOC_MASK;
@@ -183,6 +198,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 	u32 reg;
 	u32 loc;
 
+	/* Check ST table location first */
 	loc = pcie_tph_get_st_table_loc(pdev);
 	if (loc != PCI_TPH_LOC_CAP)
 		return 0;
@@ -394,7 +410,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
 	/* Sanitize and check ST mode compatibility */
 	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
-	dev_modes = get_st_modes(pdev);
+	dev_modes = pcie_tph_get_st_modes(pdev);
 	if (!((1 << mode) & dev_modes))
 		return -EINVAL;
 
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..586c75b19e01 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+u8 pcie_tph_get_st_modes(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -41,6 +42,12 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
+{ return 0; }
+static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
+{ return 0x7FF; /* Values that do not appear in normal case */ }
+static inline u8 pcie_tph_get_st_modes(struct pci_dev *pdev)
+{ return 0; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

