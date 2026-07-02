Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D82E8DEA;
	Thu,  2 Jul 2026 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996159; cv=none; b=TfkxPwwuhKgfi7e9VF8+THQXKEeHTEpC7fFgqjp0L/0SZBKh7RnLy7yOwBVuuoXYlFx2/jo6vacEMNgMpWOCiyJPWqdELPj9wGv8YO9pNRfPbz+9aIo75+p1yZeFixigdGAIq0r2JX1PHVGdwLamZQRfxBFUgcECJTZKS/55nQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996159; c=relaxed/simple;
	bh=2fE0A6mR42ih2yDeSEt8ASDRY7Yklqurps/FJHtPmbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmWL7MdJhjFpEaLpvT3b68t7PqFvxHMdWRhTVnPk/zQNHrXTHpUSRYRbvNqt0OMdxQo8zJkl/88BqTzDAN6UORYO3nbitNz6veji6vYdCFvlsPfkyDLMyTv19dr6BXeRjOG1zSVa4rIbecJzlzWc4wW1hKZwlRp066kpswF162w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NgDLEpqO; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NgDLEpqO"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=svNlUSd/201SQZo2Rpm3m8g4RZyAi3rgoOgLe5uImWM=;
	b=NgDLEpqOTa5B8bC3c+S3F6AgnazPNVI0RgXDpKPQHXCgfYWMRnluOVAn5c4uRuxj4qQPQlZdr
	rQ6kHw4sdKaOtjKqmR7M1COEf4KbtYUrKDwS6iJbpycXjHvWAMD80ce4IT7sOW8ygwQz7YJAJDk
	FIChevh0kzwwQ991HDBYOTQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4grbry4L3Cz1prL9;
	Thu,  2 Jul 2026 20:33:22 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id F42184058C;
	Thu,  2 Jul 2026 20:42:34 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:34 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 08/18] PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST _DSM
Date: Thu, 2 Jul 2026 20:42:14 +0800
Message-ID: <20260702124224.57168-9-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260702124224.57168-1-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Add new helper pci_tph_dsm_supported() to check whether the root port
of a given PCI device exposes the TPH ST ACPI _DSM method.

Wrap all ACPI logic under CONFIG_ACPI guard, return false directly
when ACPI is disabled.

This helper is prepared for follow-up VFIO TPH virtualization patches
to uniformly judge platform CPU TPH resolving support.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 28 ++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index c080cf5401a3..fcdba135a4f3 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -615,3 +615,31 @@ bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
 	return pdev->tph_ext_support;
 }
 EXPORT_SYMBOL(pcie_tph_supported);
+
+/**
+ * pcie_tph_dsm_supported - Check if root port exposes TPH ST _DSM
+ * @pdev: target PCI device
+ *
+ * Return true if root port of @pdev provides TPH ST DSM function,
+ * false otherwise (ACPI disabled or DSM missing).
+ */
+bool pcie_tph_dsm_supported(struct pci_dev *pdev)
+{
+#ifdef CONFIG_ACPI
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	acpi_handle handle;
+
+	if (!rp || !rp->bus || !rp->bus->bridge)
+		return false;
+
+	handle = ACPI_HANDLE(rp->bus->bridge);
+	if (!handle)
+		return false;
+
+	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7,
+			      BIT(TPH_ST_DSM_FUNC_INDEX));
+#else
+	return false;
+#endif
+}
+EXPORT_SYMBOL_GPL(pcie_tph_dsm_supported);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 5917a0694c1d..ac9692d740a6 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -37,6 +37,7 @@ u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext);
+bool pcie_tph_dsm_supported(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -63,6 +64,8 @@ static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 { return PCI_TPH_LOC_NONE; }
 static inline bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
 { return false; }
+static inline bool pcie_tph_dsm_supported(struct pci_dev *pdev)
+{ return false; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

