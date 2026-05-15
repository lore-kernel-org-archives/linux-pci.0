Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769D3FB05B;
	Fri, 15 May 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838053; cv=none; b=ANDA8Mot/oSQS5n7Yz7G8rfuDbV0AQ8gio7n8sil/JJPQ74JKKX3WYl447S15j251YfRWQ/EGatXAoybh2lh6HlsBArz3hFsX4mzkquXkm3RHInd63uHOTYcoOkJAzexb4l0Bvg4WF9SMacd14N5XtnKM5yBcChub+oKGAIQeO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838053; c=relaxed/simple;
	bh=kxStJ6fFHV7/iPdPavNY7ee0OKbIUpFBAQDTaZ+3gnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayD3n22e+kNjJK1DjiWr4ZDSl/cGO+M+Mrf/h1NIokj+7nJwDo4AcMKgFIdBDn6zIqmSJbtTJZqkqyQZ5lKee2NmSbHA/If1Z7RSvx9okhmTQyZlLhDbZJoa1EGq7+59MZS1/gMGpb18cSeo/c/qvSQt4wJQt5ja7AGWtxN51mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GGqN2BOA; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GGqN2BOA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l+IVHK1kPZvH+e0u6wIuaR5a3cbC24NUh6YzAN74ZTQ=;
	b=GGqN2BOAa0qLfcYzgh/HyQ+2UGAGFgXgUPZyAxjRMmk7YPH16T5Q3aNDHswby/HBSyJUPlYdg
	pbmnBGxXH7SDdJ03yf1geFbUGizhmddLGev2iIVSZer7W6SmBkE7PVs/f3716GqKV1okJPQH+wG
	xZW+0e93/tqmOlFBgqRyWlI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gH2736Q9tz1T4FX;
	Fri, 15 May 2026 17:33:03 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 198C340561;
	Fri, 15 May 2026 17:40:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 May 2026 17:40:47 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 3/5] PCI/TPH: Add pcie_tph_enabled_mode() helper
Date: Fri, 15 May 2026 17:40:38 +0800
Message-ID: <20260515094040.38496-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260515094040.38496-1-fengchengwen@huawei.com>
References: <20260515094040.38496-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add a helper to query enabled TPH mode on a PCI device. This is useful for
drivers like VFIO-PCI that need to validate TPH state before allowing
access to steering tag tables.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 12 ++++++++++++
 include/linux/pci-tph.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index ba31b010f67a..91c1e83410a3 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -451,6 +451,18 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 }
 EXPORT_SYMBOL(pcie_enable_tph);
 
+/**
+ * pcie_tph_enabled_mode - Get current enabled TPH mode
+ * @pdev: PCI device
+ *
+ * Return the enabled TPH mode (IV/DS) or 0 if disabled.
+ */
+int pcie_tph_enabled_mode(struct pci_dev *pdev)
+{
+	return pdev->tph_enabled ? pdev->tph_mode : 0;
+}
+EXPORT_SYMBOL(pcie_tph_enabled_mode);
+
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 5772d48ea444..28d0fa762146 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -28,6 +28,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
+int pcie_tph_enabled_mode(struct pci_dev *pdev);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 u8 pcie_tph_get_st_modes(struct pci_dev *pdev);
@@ -42,6 +43,8 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline int pcie_tph_enabled_mode(struct pci_dev *pdev)
+{ return 0; }
 static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
 static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
-- 
2.17.1

