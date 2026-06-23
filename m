Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD943CF692;
	Tue, 23 Jun 2026 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204676; cv=none; b=V2w9NAxuLj7XpWmo9Nu2bTxFaf7OqTr75vgSGLSxnBUV/gZdfvD2+u9PuL/C2xKuKfG1yfWamlf4jMQ9d6NpSYZzb7+YHeIqWjZq/XUQG6JZvYA0ldkjBApt8Wu2dage1KatEZ2GzOrFYFHCXBc14jMx/6T/Du+Z5JYRXvsmxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204676; c=relaxed/simple;
	bh=bY2mMjsHdqWnDNMHr+pZg1V18a/fPgbCDTFi5d65Tzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcxqDcVbJYl6X1aeO1ULSAwyvaKug5BUGVHU61h3d4QG3UlcmNVqRTjpHiN+nsYa/Hrk/tpCj48lkEFoE0QM70hBM04vIeOk7TCIoa/nsEqcLD6zBmK6N1t1aV0TYbhGMjzX3e+WJEfffNp13TV0XiJ5kd57QQdvub9VUKQZe4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bZkOh3QI; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bZkOh3QI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9ASOmKU5wxV2HFQHp4bJUryiBjoMZNh0ICdr8b6IHWE=;
	b=bZkOh3QI9/vM/x5I7mjOdxEM6EkbCAIfqvnX+DtQQo4VbMskfjE5NbC+rY7z4l9ffTZX7v63S
	J2wKvDih/5H1u88yToi06u26TcZttJpyEr0cFd4Pv336DI5C3+5A1iGIUA3fiOiOlA2fiUDWRJG
	SqVHOrm3YAa7hEf2WZZohuY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gkz831dLdzRhVJ;
	Tue, 23 Jun 2026 16:41:55 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9732F40538;
	Tue, 23 Jun 2026 16:50:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 16:50:57 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH RESEND v18 07/12] PCI/TPH: Add pcie_tph_supported() helper to check TPH capability attributes
Date: Tue, 23 Jun 2026 16:50:43 +0800
Message-ID: <20260623085048.51139-8-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260623085048.51139-1-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

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
index ea777cc33ae6..c080cf5401a3 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -596,3 +596,22 @@ void pci_tph_init(struct pci_dev *pdev)
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

