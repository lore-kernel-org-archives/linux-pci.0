Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE41C374A0B;
	Tue, 14 Jul 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025834; cv=none; b=py4N/8pdZLCgslaS0/d6XV7HtNOChdA1IIlI++Uz4dntAWF1a88AJrjX3A8tzvsAZPloB9hGZFik65BSRVj951xlagB2l8DY2TFih6t/RvX2C4YBqTs1p4TZoeCmVjszohicmeGR/tatnpX9Z0rK5pROlcS0X6TA0akdCDalU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025834; c=relaxed/simple;
	bh=AfBbZinyPkvv9pHAFeDZEmzcCrGznNAVuoT+JYjB1AE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ+yVBtU9yxDbCjGYK2KA0zt8fVWYVlQpAm/qdhtVDz06SrY6CAks5wzdG8PgP8gxttc35ATaK0osl9RbR8Jj6g7Irc/imeyBK+mUMOZy1/YFSdo9OVcNky1J4xZ89j99BIRye/Tk+ctAz1Og3JCg9fzx9LyiOQ1DMbnGWVNhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EP7FRZHd; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EP7FRZHd; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EP7FRZHd";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EP7FRZHd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nJ9tUqEeKb083GLegU+bL0n0tXNv+0zzhl0e1t9yWAc=;
	b=EP7FRZHdY1xcH7uOeL4zF3Gij4qxrvFNcBedq9rlW1OzTHldkGR7xoPVNfyftVpyM5U0mtZfU
	kvlxp8cbl5sn7N42ZL9/C767J6jXBfw464E/ecuUIRCS0Uzdwum+UOxGg5G0uBEnMCMxtUlP0gW
	6A5gUpfLXtUCd0xwSiR0dTQ=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4gzwrJ3QGjz126M0Y;
	Tue, 14 Jul 2026 18:43:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nJ9tUqEeKb083GLegU+bL0n0tXNv+0zzhl0e1t9yWAc=;
	b=EP7FRZHdY1xcH7uOeL4zF3Gij4qxrvFNcBedq9rlW1OzTHldkGR7xoPVNfyftVpyM5U0mtZfU
	kvlxp8cbl5sn7N42ZL9/C767J6jXBfw464E/ecuUIRCS0Uzdwum+UOxGg5G0uBEnMCMxtUlP0gW
	6A5gUpfLXtUCd0xwSiR0dTQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gzwf66j14zcb0T;
	Tue, 14 Jul 2026 18:34:22 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FD494058C;
	Tue, 14 Jul 2026 18:43:37 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:36 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 11/16] PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST _DSM
Date: Tue, 14 Jul 2026 18:43:20 +0800
Message-ID: <20260714104325.54444-12-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260714104325.54444-1-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
index 8194f8b45e3c..e6a850ab2b03 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -627,3 +627,31 @@ void pci_tph_init(struct pci_dev *pdev)
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
 }
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
index c26bf8bba478..aeaf701e7965 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -50,6 +50,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 u8 pcie_tph_completer_type(struct pci_dev *pdev);
+bool pcie_tph_dsm_supported(struct pci_dev *pdev);
 #else
 #define pcie_std_tph_supported(pdev) false
 #define pcie_ext_tph_supported(pdev) false
@@ -83,6 +84,8 @@ static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
 { return PCI_TPH_REQ_DISABLE; }
 static inline u8 pcie_tph_completer_type(struct pci_dev *pdev)
 { return PCI_EXP_DEVCAP2_TPH_COMP_NONE; }
+static inline bool pcie_tph_dsm_supported(struct pci_dev *pdev)
+{ return false; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

