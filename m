Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88700426ED3;
	Tue, 16 Jun 2026 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606794; cv=none; b=Om+vIt1+GxBms8gLpNnXE6wM4PqBAj/MhjhQm8sB7DqdwgO0RdbcW3++ARsSNORV5aP+8uheLR2FZpW9OHZR4prB8CdytsvKBRXqLbo1x2FVFFgyQNbIgaOITQ6inuoaedUdaRGxCVmeY6SMW9sn47j7+0e26FZX+9tUpdsIr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606794; c=relaxed/simple;
	bh=9J5bqqmSphQwLa6cry1/qexPnxbjcbd/eDu0T9ngMxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmXl98Gwi8ztPF0eBf2PaDF1JjFJy32cU6UCz1cJ+GPbIB3nhMJHE3MwDaEo3twA2ZLfiwW0Pklm/jSZ2gb1/KP6Q25W8c22EFstW04iMS7LprE2ivgc65T+kvShjZhVa9S6bAElBBSXv85oU/0NRrgB6nId6dtP7lxuhor/pac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qG13va8h; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qG13va8h"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q2I4UZb7prqaKrbv3UYYhTmywuHlp+yKxLX19M59nA8=;
	b=qG13va8hOWNdR9awQ64S501kdnSRiwhIEaEirJVxXDdY+WZ1aesT9SIotpZXQmGmFBDNLzGta
	LpxBdSY3r5irabLMRIDimaZTezBT+/8CWyGyN9WwCSHX5vH9n6bYeJp230Dx7OGq8WkwPLCL8FA
	b/DDZbPiEaG0gZd88+GlwKg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gfk3s1DWFzLlTZ;
	Tue, 16 Jun 2026 18:38:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id B7B2F40562;
	Tue, 16 Jun 2026 18:46:30 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 18:46:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v17 07/12] PCI/TPH: Add pcie_tph_supported() helper to check TPH capability attributes
Date: Tue, 16 Jun 2026 18:46:16 +0800
Message-ID: <20260616104621.41915-8-fengchengwen@huawei.com>
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

Add new helper pcie_tph_supported() with want_ext parameter:
- want_ext = false: Check if device has valid TPH capability;
- want_ext = true: Check hardware Extended TPH support.

This helper is prepared for follow-up VFIO TPH virtualization patches to
uniformly query basic TPH existence and Extended TPH capability.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 19 +++++++++++++++++++
 include/linux/pci-tph.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 6c4623cacc85..95280aab4fb5 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -600,3 +600,22 @@ void pci_tph_init(struct pci_dev *pdev)
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
 }
+
+/**
+ * pcie_tph_supported - Check TPH capability attribute
+ * @pdev: PCI device to query
+ * @want_ext: false - check TPH cap exists; true - check EXT_TPH support
+ *
+ * Return: true on matched condition, false otherwise
+ */
+bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
+{
+	if (!pdev->tph_cap)
+		return false;
+
+	if (!want_ext)
+		return true;
+
+	return pdev->tph_ext_support;
+}
+EXPORT_SYMBOL(pcie_tph_supported);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index e4f7045fc152..5917a0694c1d 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -36,6 +36,7 @@ int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
 u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -60,6 +61,8 @@ static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
 static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 { return PCI_TPH_LOC_NONE; }
+static inline bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
+{ return false; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

