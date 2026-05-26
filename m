Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853723AC0EF;
	Tue, 26 May 2026 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768532; cv=none; b=rZIKlyRkOB62x3bfKYYYtEEX5jkINlO9bAgs9C/5heeI3MNomj/4U62kAUyaXiMjeqvcn7+2CDfrrIUan8Qn9NormQ6UeCscYi67M11cd4zuOpe/OXi/dFsEkvy1YS0HZZYRk9li8801YjT3hnWsxq9J8OoHIejENRv18ElGAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768532; c=relaxed/simple;
	bh=i4JnoTzLYJzKN9COBfChXsOMsOHUYVujaeJcnu0T7Jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc/VF23C7RktQFxRdJBaJ+RQru5rkC+BNriLfjf8TuQkk7cxxsJw5c+5ZNO7VhrEonPS53dLhau/smJbS5L9KuahXwspbdzpQ+V2j7fl8jybaZip0tIndMc9ALOTV5OCmc/gipKzbaF+NGwNNci5eLtPLFJbjnSJ7SNqpl/R/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g4eeUNdS; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="g4eeUNdS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9s3/WfeSkDd6rMuudWc9SzehazucwehfIN6hn+q/+BM=;
	b=g4eeUNdSPHcbu2GYF8yCga/mNkI2tAR3RkLgonSW7NQNhA7eNYGklxgqHSlFbjQKuAUleuOws
	ynVWchktj5H3Yl+rjINbR3QSHxKyf7Vw2Cwsms2TM4TOg4PFuOBEzD8V05MRQKC5kEwxEr603WY
	+45+VV5DfY731u3rMVxQVhU=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gPfDj65w7zmV6M;
	Tue, 26 May 2026 12:00:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 0202740562;
	Tue, 26 May 2026 12:08:40 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 12:08:39 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v12 3/6] PCI/TPH: Add pcie_tph_enabled_mode() helper
Date: Tue, 26 May 2026 12:08:27 +0800
Message-ID: <20260526040830.52854-4-fengchengwen@huawei.com>
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

Add a helper to query enabled TPH mode on a PCI device. This is useful for
drivers like VFIO-PCI that need to validate TPH state before allowing
access to steering tag tables.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 14 ++++++++++++++
 include/linux/pci-tph.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 11a06730e08c..95e2a95055ee 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -451,6 +451,20 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 }
 EXPORT_SYMBOL(pcie_enable_tph);
 
+/**
+ * pcie_tph_enabled_mode - Get current enabled TPH mode
+ * @pdev: PCI device
+ *
+ * Return: the enabled TPH mode (one of PCI_TPH_ST_NS_MODE, PCI_TPH_ST_IV_MODE
+ *         or PCI_TPH_ST_DS_MODE) on success, or -EINVAL if TPH is not currently
+ *         enabled on the device.
+ */
+int pcie_tph_enabled_mode(struct pci_dev *pdev)
+{
+	return pdev->tph_enabled ? pdev->tph_mode : -EINVAL;
+}
+EXPORT_SYMBOL(pcie_tph_enabled_mode);
+
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 5c3997f4b51b..e8c9166e33dd 100644
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
+{ return -EINVAL; }
 static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
 static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
-- 
2.17.1

