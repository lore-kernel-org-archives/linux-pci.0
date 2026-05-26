Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542B3B5842;
	Tue, 26 May 2026 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768541; cv=none; b=T8/IlzLGTpC87Xfvo6TVnbTKtBEV0E+EqANxydvOP2Aox3RAUrYvYxv8jh7mjXanlYUVldYoQDub/HgLLqimMIELjg7MqFX/mmq4G3OdveC92SZD7nQfG11H3hXWaBQYOO8P449EUDOn/tN7Ka+aJc6z/gsa4RBH9yW3gKEANzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768541; c=relaxed/simple;
	bh=bHPpIMA/45gmM6gG9F6tNkFvfjNCWrm6wS7j6X9nt3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSgAdft6fxJeFvRgT9OdC73J9mwkPTTojFeuE+rNyzf3WmnHlQWrP3T37FhgBVo5mvrOp2LqEJ3GkGK8Vnp0wJhf1R2R8/SzV1nPAmutkV19OCUlZr4ZJHNhnkERKLG10guaRh+jveYIlkTljAKyID0yNsyf3CTOPNjkUgx9a8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Y/hv3MFo; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Y/hv3MFo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fwbhlqQ9gPYaXZUXZH9Wt1S5e6sAmf7g28qlZo1FgdI=;
	b=Y/hv3MFoP0NehrcpefXtEm9CKmK89UwvutP1OjPA1Pmz18Ic5sBv/pCl1/X0y4wLUczV858Kt
	47fvoR0um66nQLNGMpcvzDEAxKgjO2z0g1TvO2eRUgsGV14UU5e5NUVxq5CeyoN0DFxxIWE+Nyl
	DwcZ/NqEDWADIWJreIJ2+tU=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gPfDl6Xf5z1cySm;
	Tue, 26 May 2026 12:00:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B53A40561;
	Tue, 26 May 2026 12:08:39 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 12:08:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v12 2/6] PCI/TPH: Export pcie_tph_get_st_modes() for external use
Date: Tue, 26 May 2026 12:08:26 +0800
Message-ID: <20260526040830.52854-3-fengchengwen@huawei.com>
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

Export the helper to retrieve supported PCIe TPH steering tag modes so
that drivers like VFIO can query and expose device capabilities to
userspace.

Add stub functions for pcie_tph_get_st_table_size() and
pcie_tph_get_st_table_loc() when !CONFIG_PCIE_TPH.

Add tph_cap validation for pcie_tph_get_st_modes() and
pcie_tph_get_st_table_loc() to prevent invalid PCI configuration
space access when TPH is not supported.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/tph.c       | 23 +++++++++++++++++++----
 include/linux/pci-tph.h |  7 +++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 877cf556242b..11a06730e08c 100644
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
-	u32 reg;
+	u32 reg = 0;
+
+	if (!pdev->tph_cap)
+		return 0;
 
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
 	reg &= PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS;
 
 	return reg;
 }
+EXPORT_SYMBOL(pcie_tph_get_st_modes);
 
 /**
  * pcie_tph_get_st_table_loc - Return the device's ST table location
@@ -166,7 +178,10 @@ static u8 get_st_modes(struct pci_dev *pdev)
  */
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 {
-	u32 reg;
+	u32 reg = 0;
+
+	if (!pdev->tph_cap)
+		return PCI_TPH_LOC_NONE;
 
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
 
@@ -395,7 +410,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
 	/* Sanitize and check ST mode compatibility */
 	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
-	dev_modes = get_st_modes(pdev);
+	dev_modes = pcie_tph_get_st_modes(pdev);
 	if (!((1 << mode) & dev_modes))
 		return -EINVAL;
 
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..5c3997f4b51b 100644
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
+{ return PCI_TPH_LOC_NONE; }
+static inline u8 pcie_tph_get_st_modes(struct pci_dev *pdev)
+{ return 0; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

