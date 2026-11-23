Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401405;
	b=HDPH8/WQ/qm848rtVRVrASfxzvyFG3i/13okYHaNsIxxCmeYUyYAujcscYdq3SxR2UXo
	 z5+9ahUiKbCYiPNYMAD5X1pi5+FNtKAl5xkFF1xuUWCLnHEgmCGq/dAeUkfE9BXIbHq6v
	 213Eqq3/RN1WZUfud6H8ByfgHZFRtlmUB66Nd9DIXpebSvr39aydDZTLzMw0UvtO172Rg
	 xJSHAkUO00aq9Ms9C9mA1P2c3aXHB4ZCw5h0MHvAmUAxpnxvzbrg9Kkv1HzUbiC0LMr26
	 OFXeNo4+UJ+fbLoNYqASQxlfJoo8ddkfIYFmcYIGXjjE0MthqoBGEuCcboteUqFDSjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401405;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=Sdte2LIcRSrbPBJwV40NT5Xjl2zR7OYaQ8RrrBtDwWw=;
	b=Ru/HsSdHGBqIghfAShaayGPPevMtqG/wl8yxlSb8i6ptfoQu5h/Szkr8TZEIHtM6ABUf
	 hTRcjyzp1fbiZM4o8sNEge4QTTFLOxJU2uD4/nm0HwENUWR8KwqdJrF0q4pf12RZlDZ3Q
	 d0KRv8llakWnxBIg9k5VYkfAUQwNHbZIRgNEE4Tmtb7kR6jN8mzrbk/6idPkUyj3N353v
	 JLkY4oKyzVXouT9PaxA9zZaTJOGu6E0x4X8dA5MnO3xaJkBuWQsQEgSzevZ+kPoiETY1z
	 ujpR/5c3ZgpZHAO4TD5NyrwofmoXM/a+YGKy0oD2LNJ99xWUeGyjRpzDqigTBjgfZrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=d8skYp1E;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FB606A331;
	Mon, 23 Nov 2026 02:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31FB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=d8skYp1E
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Sdte2LIcRSrbPBJwV40NT5Xjl2zR7OYaQ8RrrBtDwWw=;
	b=d8skYp1EJdFdSFsVvUMx5Lfb9/KHoULAH61Umu6tptpsZZqy080xdIHpr09mcxTGLXVRvOxI9
	LkjeE6XvHhbaTz7ZHZx2RRv7dgUJC2SS1MMwsW9dQiZlj6mQsSK2kHBIRTytbmXoxG9o1jMWSRQ
	4JO2sm1ciFC3LLL3CKIMB6c=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jXqmp5klRzpStq;
	Mon, 23 Nov 2026 10:35:38 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B15440575;
	Mon, 23 Nov 2026 10:36:37 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:36 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 05/13] PCI/TPH: Refactor pcie_tph_get_cpu_st & add requester variant
Date: Mon, 23 Nov 2026 10:36:20 +0800
Message-ID: <20261123023628.7728-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261123023628.7728-1-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
index 875c381e094f..51a065d83104 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -233,20 +233,22 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
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
@@ -255,6 +257,10 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 	u32 cpu_uid;
 	int ret;
 
+	if (req_type == PCI_TPH_REQ_DISABLE || req_type == 2 ||
+		req_type > pdev->tph_max_type)
+		return -EINVAL;
+
 	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
 	if (ret != 0)
 		return ret;
@@ -270,17 +276,38 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
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
index f021419251cc..04c93822ee6d 100644
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
@@ -37,6 +38,11 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
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

