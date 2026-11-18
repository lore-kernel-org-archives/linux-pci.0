Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993181;
	b=mMH+v19n6dXmKIowDccrmdjojD4bjQtzd+wSQms3/eSaQx4cwM2VL4F75iOAFk7Mjn2y
	 Dxv6IL5LEJufF1ZzIkv5gS04Q8iAIU9I7tg6EbsNp7WvcQCF6/YJuO6EPv+JV9HTlZAiz
	 d2mS7p76xs5ZK4wyf5Ro1R+Y9BfTaQBIcBursB4RoVXN2YonGJ9mJxPTkVIUoHyHnK4Sl
	 vPsi6ud7whS7gCcjkBT7nYpJV4ef6IKXMKWWmS+hb1QSAo8yevIx7UNkRr/8mtJ1GaqVv
	 nX85VQ+CuhdQESwg5IuEgHoOQuAxHHcvOLV+YXzrchkYYEYt/9U3z73/DWtHbHuYKVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993181;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=8P0vFIDDXbkjWmgIOLg0zHXfvmzVwI/Dt81D1/YuzpU=;
	b=XX6S/2JBzWmwgADTVdOEg+y6XtCicsFwKEadpx6qjComgP6AC5feHUQvGsFvDr3tVGrD
	 3zeOQVd6Gk15WR4afUpk29Y/E8Q28FRcIltYBjSokazemmNOodsSp31T1SoMYqdWPhexY
	 xjymqE+Dti7buQL9VSm88D+eNWC4q+RXmkFGkKcbNchYz4IJn2QpbhYblbqM5rZqoM1gm
	 BtVW0slgxZJj9Tewl50oP7xDUMJZzmi+KSrzZPDu29zqJ3LDZY6q89KCV+vIjb97jv1nN
	 sO++cR1Nu3/lfBmuqZ0CLqVbQzx86jOvCRlI8oKwOAzUJdCXv6oddjsFRKlQtDy0qbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=YLzIwqJo;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82BD606A893;
	Wed, 18 Nov 2026 09:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E82BD606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=YLzIwqJo
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8P0vFIDDXbkjWmgIOLg0zHXfvmzVwI/Dt81D1/YuzpU=;
	b=YLzIwqJoIsgUd6p7fX2qIwdAMlAkCJoNACT50bMFNz+e3mo2Rp3eNlzP/e57bRx953iNN7OzF
	ORskm04/69frQnV3gkBsDbArQNURDuBRKKEAq1YkmEThLhV2ddWSHiiE/92Bmjf0FH8WJkgZkco
	C/YHnZtPqTDuEHwhWc/QYCE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jTwqK1QN2z1prR3;
	Wed, 18 Nov 2026 17:12:45 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D41640561;
	Wed, 18 Nov 2026 17:12:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:57 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 08/13] PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST _DSM
Date: Wed, 18 Nov 2026 17:12:33 +0800
Message-ID: <20261118091238.45992-9-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261118091238.45992-1-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
index c8b867dd233d..c3d940745fe4 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -587,3 +587,31 @@ void pci_tph_init(struct pci_dev *pdev)
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
index 58c8d416aff2..c19dbbb87620 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -48,6 +48,7 @@ int pcie_enable_tph_ext(struct pci_dev *pdev, u8 mode, u8 req_type);
 int pcie_enable_tph(struct pci_dev *pdev, u8 mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+bool pcie_tph_dsm_supported(struct pci_dev *pdev);
 #else
 #define pcie_std_tph_supported(pdev) false
 #define pcie_ext_tph_supported(pdev) false
@@ -77,6 +78,8 @@ static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
 static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 { return PCI_TPH_LOC_NONE; }
+static inline bool pcie_tph_dsm_supported(struct pci_dev *pdev)
+{ return false; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

