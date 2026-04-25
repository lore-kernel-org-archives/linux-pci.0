Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35853321B1;
	Sat, 25 Apr 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777106787; cv=none; b=u0/p7JPUdvMuE79AIdf1bV2uJYfMXUAcaVVqkoo+SuDHr2tOo9+A1mA0CjBcz0KBahGXaNCOKlYmkxUbkedHr74QVCnt4597p5O+q0ylCoMkGY7UYpvvdhl81X++FSvOOckHUcpf6TYfepEgolLpo+0n4W0GSVK4dOssyLHi2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777106787; c=relaxed/simple;
	bh=Gx7tpU6S7W2c2AoOW7EdmvXsgoRKdjMoXXEsDjjSEys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeCUYoq9bZ+zocwLHvPmo2F0/NRMinToH/XlCkS7Kve+Y2MnmhlW9mmYrvvgB9LChaBr9sDQe4l/eMUOIScLvCw8Fb6IRDVAzkmClPfI8wjWVd2sk3iKT7G7rSkdTnhwsPsI3AxKs634005RbOqgyd8tQXDNu+/hhfSJD5xFb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SMwNCJZz; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SMwNCJZz"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WgVWU6zoDpnq0ILk/hO0MLd7A+Ww9qyRKPHUW/8gbP8=;
	b=SMwNCJZz/6//HrEFhqfKfJPkbQgfjD0DNTbOIETPsKTUEMtI1AHBDmSR7453z/XOKFv3VPi4P
	yzdis+1M5qysYLUw+MnwTLO9Fneu3N+V4wL1jtHg0eENtewYB9P+TqHEy5LnQRK2yCpdWnku+3u
	oQ43tVRs64jmybrSeJpoKeg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g2jv9259BznTWD;
	Sat, 25 Apr 2026 16:40:05 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A68A40571;
	Sat, 25 Apr 2026 16:46:17 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Apr 2026 16:46:16 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v4 1/5] PCI/TPH: Export pcie_tph_get_st_modes() for external use
Date: Sat, 25 Apr 2026 16:46:03 +0800
Message-ID: <20260425084607.53825-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260425084607.53825-1-fengchengwen@huawei.com>
References: <20260425084607.53825-1-fengchengwen@huawei.com>
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

And also add pcie_tph_get_st_table_size() and
pcie_tph_get_st_table_loc() stub implementation in the !CONFIG_PCI_TPH
case.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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

