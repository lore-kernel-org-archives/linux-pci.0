Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A6317155;
	Tue,  2 Jun 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411257; cv=none; b=QqDKCGTVFREfqTwW0QSNlpiGX/6AaqXckg66wAitVMQ/0flVjv+DTKe1bqX8biFaItZntf0plfcCJKbal0eJdylMMqcKVMehm7Db4Zh5LIfrjSRGwtkAotLuKl7yXpoNroB1ZsL+KKK5dMCab4NXXxE8K3vfNUNtBbj3T6l19a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411257; c=relaxed/simple;
	bh=uTzK/zy3zIZLU5xOZUFgOS9wkuV/6VOvzayJgVt2hJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xu/k45SMw6b4U/hSdrFHl7SmAGmkzJDOZT7EyI23A5YvRFNIcHbznB0gBYJU+aAaRti2NhBKhhCWq3NYadC86YqD7oORLWoRUkKPlDAi6bQFauxqlopRS90TOBFUTL6jGnlCfSSjhExFHQPMhGuM4hEEp0gGJrtX0TRoJSfcArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nNCoLmnC; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nNCoLmnC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qrI4vbTz7w/Z+OGbbhps56KFy/y6OwoAYkDbLxPr3Z4=;
	b=nNCoLmnCC0+gXJMrqIsNRkJSTKXOicSCYRXUNbTljus+7zVuZRhSXw6LL6di4Y0tbU+kcFOBe
	RiE342K4/yhW+6f/KGbMyHGNR6Oiy5hcMjj6tyO88wTkd7Poreh7kv1hl49YbbxngFqiCbXoYEG
	x7GUSswqqbZndcgsSLh3Cac=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gVCx62gqHzpStl;
	Tue,  2 Jun 2026 22:33:14 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BB024056D;
	Tue,  2 Jun 2026 22:40:51 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 22:40:50 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v15 07/10] PCI/TPH: Add pcie_tph_supported() helper to check TPH capability
Date: Tue, 2 Jun 2026 22:40:20 +0800
Message-ID: <20260602144023.25254-8-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260602144023.25254-1-fengchengwen@huawei.com>
References: <20260602144023.25254-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add a simple helper pcie_tph_supported() to test whether the device
has TPH capability by checking the cached tph_cap offset.

This helper will be used by upcoming VFIO TPH support to uniformly
judge TPH capability presence.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 12 ++++++++++++
 include/linux/pci-tph.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 383eb954cac0..19ef6e442b76 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -600,3 +600,15 @@ void pci_tph_init(struct pci_dev *pdev)
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
 }
+
+/**
+ * pcie_tph_supported - Check if device has TPH capability
+ * @pdev: PCI device to query
+ *
+ * Return: true if device exposes TPH capability, false otherwise
+ */
+bool pcie_tph_supported(struct pci_dev *pdev)
+{
+	return !!pdev->tph_cap;
+}
+EXPORT_SYMBOL(pcie_tph_supported);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index e4f7045fc152..cf41ff973e69 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -36,6 +36,7 @@ int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
 u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+bool pcie_tph_supported(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -60,6 +61,8 @@ static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
 static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 { return PCI_TPH_LOC_NONE; }
+static inline bool pcie_tph_supported(struct pci_dev *pdev)
+{ return false; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

