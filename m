Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A26363C60;
	Tue, 14 Jul 2026 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025819; cv=none; b=eevm8UpH59MiJGv2YaxosA5rPEh/1eHsnb12c09dwBvYxwZxD3xtq+UtBmMjq4YgWTiXTEevbwLcYSF+hjSNaoe6/qzJfaTASZBVNYiQXYEYhAbI1WnDg03ogthIpCvvS4omR5+Rl0U5t4tcv5zZmtW7FJurCu1c7RHiXAS1qvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025819; c=relaxed/simple;
	bh=musq/lKzoEctB+Kyr6riXQrt1/pN9DZw0glpr9dAP7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRGSMfXmI0Y50NbMS40VPptQlKF/JEK/SfBJgLto4KvS/2FmaIZx7jdbhaB5OlRVq9GtdynpRDYl9JsLSBwjjprAwxoXmNfM9P0F+ssFyGvt8IT1jD2Mpvy5EC55CjgjybQ7FpEBaOI7BPxp9PqIIiiHYhW4TpxvCDQr8TAuX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tX0/3Fj/; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tX0/3Fj/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VzokQ3EOLc+1zJjYjYQHrT0TdNSJ4gX4CUd6SvdD5wU=;
	b=tX0/3Fj/1N9oru7OfgYVQMymmH51Hb/sLN7fAo64oMNdsbaUdPegMUyp9C2X4chgZX1hP6L2L
	kBU8i3yIuuxXwFe2D7ez76xAHolNrFeDokME6I9X21bibWjjqHfMnEVfIuruY59MA9EWPrU4+YY
	atR39jGkxp39VrEbbzTzQLA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzwdz3lV8zKm9N;
	Tue, 14 Jul 2026 18:34:15 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C38924057C;
	Tue, 14 Jul 2026 18:43:35 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:35 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 08/16] PCI/TPH: Refactor pcie_tph_get_cpu_st & add requester variant
Date: Tue, 14 Jul 2026 18:43:17 +0800
Message-ID: <20260714104325.54444-9-fengchengwen@huawei.com>
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

Refactor pcie_tph_get_cpu_st() and add pcie_tph_get_cpu_st_ext() extended
variant with explicit requester type parameter.

- Preserve original pcie_tph_get_cpu_st() as a compatibility wrapper,
  using the default negotiated tph_max_type automatically, so existing
  callers require no modification.
- Add exported pcie_tph_get_cpu_st_ext() to accept an explicit requester
  type argument for ST namespace selection, used by upcoming VFIO TPH
  support.
- Add requester type validation to reject invalid values and enforce the
  hardware negotiated tph_max_type capability limit.

Update pci-tph.h header and CONFIG_PCIE_TPH stub inline definitions
to match the new function signatures.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 45 ++++++++++++++++++++++++++++++++---------
 include/linux/pci-tph.h | 10 +++++++--
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 1239a919b9a4..633dc6308b68 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -276,20 +276,22 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
 }
 
 /**
- * pcie_tph_get_cpu_st() - Retrieve Steering Tag for a target memory associated
- * with a specific CPU
+ * pcie_tph_get_cpu_st_ext() - Retrieve Steering Tag for a target memory
+ * associated with a specific CPU, with explicit requester type selection
  * @pdev: PCI device
  * @mem_type: target memory type (volatile or persistent RAM)
+ * @req_type: TPH requester type to select ST namespace
  * @cpu: associated CPU id
  * @tag: Steering Tag to be returned
  *
- * Return the Steering Tag for a target memory that is associated with a
- * specific CPU as indicated by cpu.
+ * Return the Steering Tag for a target memory associated with a specific CPU,
+ * using the specified TPH requester type to select the correct ST namespace.
+ * Validates requester type against hardware negotiated capability limits.
  *
  * Return: 0 if success, otherwise negative value (-errno)
  */
-int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
-			unsigned int cpu, u16 *tag)
+int pcie_tph_get_cpu_st_ext(struct pci_dev *pdev, enum tph_mem_type mem_type,
+			    u8 req_type, unsigned int cpu, u16 *tag)
 {
 #ifdef CONFIG_ACPI
 	struct pci_dev *rp;
@@ -298,6 +300,10 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 	u32 cpu_uid;
 	int ret;
 
+	if (req_type == PCI_TPH_REQ_DISABLE || req_type == 2 ||
+		req_type > pdev->tph_max_type)
+		return -EINVAL;
+
 	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
 	if (ret != 0)
 		return ret;
@@ -313,17 +319,38 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
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
+EXPORT_SYMBOL(pcie_tph_get_cpu_st_ext);
+
+/**
+ * pcie_tph_get_cpu_st() - Retrieve Steering Tag for a target memory associated
+ * with a specific CPU
+ * @pdev: PCI device
+ * @mem_type: target memory type (volatile or persistent RAM)
+ * @cpu: associated CPU id
+ * @tag: Steering Tag to be returned
+ *
+ * Return the Steering Tag for a target memory associated with a specific CPU,
+ * using the default negotiated TPH requester type.
+ *
+ * Return: 0 if success, otherwise negative value (-errno)
+ */
+int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
+			unsigned int cpu, u16 *tag)
+{
+	return pcie_tph_get_cpu_st_ext(pdev, mem_type, pdev->tph_max_type,
+				       cpu, tag);
+}
 EXPORT_SYMBOL(pcie_tph_get_cpu_st);
 
 /**
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 3055776495c1..6901f6e2f8c7 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -25,8 +25,9 @@ enum tph_mem_type {
 #ifdef CONFIG_PCIE_TPH
 int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
-int pcie_tph_get_cpu_st(struct pci_dev *dev,
-			enum tph_mem_type mem_type,
+int pcie_tph_get_cpu_st_ext(struct pci_dev *dev, enum tph_mem_type mem_type,
+			    u8 req_type, unsigned int cpu, u16 *tag);
+int pcie_tph_get_cpu_st(struct pci_dev *dev, enum tph_mem_type mem_type,
 			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph_ext(struct pci_dev *pdev, u8 mode, u8 req_type);
@@ -39,6 +40,11 @@ u8 pcie_tph_completer_type(struct pci_dev *pdev);
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
 { return -EINVAL; }
+static inline int pcie_tph_get_cpu_st_ext(struct pci_dev *dev,
+					  enum tph_mem_type mem_type,
+					  u8 req_type, unsigned int cpu,
+					  u16 *tag)
+{ return -EINVAL; }
 static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu, u16 *tag)
-- 
2.17.1

