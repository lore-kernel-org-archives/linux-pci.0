Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE742B728;
	Tue, 16 Jun 2026 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606795; cv=none; b=C/irDpJiAvWCpeBRYHnFK/KxP40THHneENkE9MluZLlts+NAVeIzWv8EQaJNZW21aON8PBc+VuykxD3xNDdI9dZ2J1yjVHiXbjKtIX5+GpFMLVXz2mqq2dO8UB0pZmq4Q8wJEWlQ6Hcsxd14VH0B1uNKVkHXNapiFTd2NoTMEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606795; c=relaxed/simple;
	bh=r3QAwdlSAmRLZ+aLW4X9656IfvLSzZAPajlbiWaL+3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojjL83oPLK26f0TAY9K7kgxkupx1QL5pffkQDy1hExQLA4TkC+DWPxb1yCHuCGjJxWBttBMYZFes/pK0GKarjP3ystw0t7iSG89UOEpaf27v7u2zHQ6yKpAFwhBKkhOkUahgeCKIuVzwvyaXqQIPZ6UmLHU7KUgBoAscXj8pXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=I4bTbNbV; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="I4bTbNbV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qX9tWqyTi408HSWkVIyhFdr6SWRL9yjBT/I2V7dPesY=;
	b=I4bTbNbVjpEFjAX+FHelGJtEBUY1bky87boH1JDa6uYcSXRD7WW7r5GYmIDaYjno/7yNmcPdo
	y3huQF7zL8fN8evQTHCWEGKB4TPHNmn4dHmmLXjYueb3E//dsRpKiu6b/ZBM5USFsYpJ6zepwCo
	mhwuqrTKdT5a/0i2Yf3m0sk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gfk2p1chFz12LDj;
	Tue, 16 Jun 2026 18:37:38 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C351D40569;
	Tue, 16 Jun 2026 18:46:29 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 18:46:29 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v17 05/12] PCI/TPH: Refactor pcie_tph_get_cpu_st & add explicit variant
Date: Tue, 16 Jun 2026 18:46:14 +0800
Message-ID: <20260616104621.41915-6-fengchengwen@huawei.com>
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

Refactor pcie_tph_get_cpu_st(): extract core logic into static internal
get_cpu_st() helper accepting explicit requester type parameter.

- Preserve original pcie_tph_get_cpu_st() unchanged as auto wrapper; it
  uses existing pdev->tph_req_type automatically, existing callers require
  no change.
- Add exported pcie_tph_get_cpu_st_explicit() with bool 'extended'
  parameter for manual STD/EXT requester selection, consumed by upcoming
  VFIO TPH code.
- Add capability check: reject explicit EXT request when device does not
  support extended TPH requester.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 68 ++++++++++++++++++++++++++++++-----------
 include/linux/pci-tph.h |  7 +++++
 2 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 51009ac9b379..aca08671fdfe 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -231,21 +231,8 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
 	return pci_write_config_word(pdev, offset, tag);
 }
 
-/**
- * pcie_tph_get_cpu_st() - Retrieve Steering Tag for a target memory associated
- * with a specific CPU
- * @pdev: PCI device
- * @mem_type: target memory type (volatile or persistent RAM)
- * @cpu: associated CPU id
- * @tag: Steering Tag to be returned
- *
- * Return the Steering Tag for a target memory that is associated with a
- * specific CPU as indicated by cpu.
- *
- * Return: 0 if success, otherwise negative value (-errno)
- */
-int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
-			unsigned int cpu, u16 *tag)
+static int get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
+		      u8 req_type, unsigned int cpu, u16 *tag)
 {
 #ifdef CONFIG_ACPI
 	struct pci_dev *rp;
@@ -269,19 +256,64 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 		return -EINVAL;
 	}
 
-	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
+	*tag = tph_extract_tag(mem_type, req_type, &info);
 
-	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu=%d, tag=%#04x\n",
+	pci_dbg(pdev, "get steering tag: mem_type=%s, req_type=%u, cpu=%d, tag=%#04x\n",
 		(mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
-		cpu, *tag);
+		req_type, cpu, *tag);
 
 	return 0;
 #else
 	return -ENODEV;
 #endif
 }
+
+/**
+ * pcie_tph_get_cpu_st() - Retrieve Steering Tag for a target memory associated
+ * with a specific CPU
+ * @pdev: PCI device
+ * @mem_type: target memory type (volatile or persistent RAM)
+ * @cpu: associated CPU id
+ * @tag: Steering Tag to be returned
+ *
+ * Return the Steering Tag for a target memory that is associated with a
+ * specific CPU as indicated by cpu.
+ *
+ * Return: 0 if success, otherwise negative value (-errno)
+ */
+int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
+			unsigned int cpu, u16 *tag)
+{
+	return get_cpu_st(pdev, mem_type, pdev->tph_req_type, cpu, tag);
+}
 EXPORT_SYMBOL(pcie_tph_get_cpu_st);
 
+/**
+ * pcie_tph_get_cpu_st_explicit - Get ST with explicit requester type
+ * @pdev: PCI device
+ * @mem_type: target memory type (volatile or persistent RAM)
+ * @extended: true=EXT_TPH, false=standard TPH only
+ * @cpu: associated CPU id
+ * @tag: output steering tag pointer
+ *
+ * Unlike auto pcie_tph_get_cpu_st(), caller manually picks requester type.
+ * Rejects EXT request if device lacks extended requester capability.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
+				 enum tph_mem_type mem_type,
+				 bool extended, unsigned int cpu, u16 *tag)
+{
+	u8 req_type = extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
+
+	if (extended && !pdev->tph_ext_support)
+		return -EINVAL;
+
+	return get_cpu_st(pdev, mem_type, req_type, cpu, tag);
+}
+EXPORT_SYMBOL(pcie_tph_get_cpu_st_explicit);
+
 /**
  * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
  * @pdev: PCI device
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index ca0faa98afac..1a508b3d511f 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -27,6 +27,9 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev,
 int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			enum tph_mem_type mem_type,
 			unsigned int cpu, u16 *tag);
+int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
+				 enum tph_mem_type mem_type,
+				 bool extended, unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
@@ -40,6 +43,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu, u16 *tag)
 { return -EINVAL; }
+static inline int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
+				enum tph_mem_type mem_type,
+				bool extended, unsigned int cpu, u16 *tag)
+{ return -EINVAL; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
-- 
2.17.1

