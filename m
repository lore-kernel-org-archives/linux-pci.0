Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5527A916;
	Thu, 16 Apr 2026 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331278; cv=none; b=ll27gQBNcfPsiZS+az0OgqXH1eGNwWN2h11A8loLG/3txd+00FTf1uPOGvnRXFeHO2y3od+WjKFcBLVBqt7wUqqVmX7k7buWIberW0i/Edgq17l/sYB/grtn+Ohm+GCxPEoLED2c/0Ja4eHWekU1sRVZovVMwyacHzoICUu91Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331278; c=relaxed/simple;
	bh=L0DmendFOefQPFtDMYKcMhHvE4IfubXJSzqUkPf7WoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueSJ+oXSuiHzLGzjTmDRyDcbXfqjkPMClQxp5zTC4MDTdJLTMD1bB9eBjG/88kBPk0B1TCvjebgH+nvX101+zvOd4VfVONumJU3zKqRN6BXITxT1z/pLouNx4xldxTijgqNiCdsz1/RYET1fA0KYtEEMcugeLf68Bbdaf1Hw4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4mP4rr0Q; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4mP4rr0Q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fvtU7x+vm6WEZqPSyBi3XSd/2T89n1LNpBCVUXCkqbs=;
	b=4mP4rr0QnLvnEdOygZZ7JKQ4n0G8fqcpMsmwTEHFM++6EKGHHWOcwkNu+xsn8Za7SXwzIPgUW
	JZx+v/vukr08JvXXnHZ5nJJh81YemT+4IWFyYmsW1uqo8zfI81h0cO3R4wx2CAwTzbTKaAG2AsK
	mcpRVDYAVZWl3J8wzETa1fY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fxC5T17jPzRhR4;
	Thu, 16 Apr 2026 17:14:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E2D140538;
	Thu, 16 Apr 2026 17:21:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 17:21:11 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2 1/5] pci/tph: Export pcie_tph_get_st_modes() for external use
Date: Thu, 16 Apr 2026 17:21:01 +0800
Message-ID: <20260416092105.41439-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260416092105.41439-1-fengchengwen@huawei.com>
References: <20260416092105.41439-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Export the helper to retrieve supported PCIe TPH steering tag modes so
that drivers like VFIO can query and expose device capabilities to
userspace.

And also add pcie_tph_get_st_table_size() and
pcie_tph_get_st_table_loc() stub implementation in the !CONFIG_PCI_TPH
case.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 13 +++++++++++--
 include/linux/pci-tph.h |  7 +++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..f8767bf6fee9 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -145,7 +145,15 @@ static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
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
 
@@ -154,6 +162,7 @@ static u8 get_st_modes(struct pci_dev *pdev)
 
 	return reg;
 }
+EXPORT_SYMBOL(pcie_tph_get_st_modes);
 
 /**
  * pcie_tph_get_st_table_loc - Return the device's ST table location
@@ -400,7 +409,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
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

