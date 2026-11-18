Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993171;
	b=WR86tpkNLrlGbgK2XqMC6+iWC9wSX4WhuXMPK15+gkI9B+APtJzddleMXNrcTneIv8PY
	 n1UhmxntafkghiR8a4nUex6Lgl+iqKeUtMWN74RLGhubwLBtoi0Kgw6Q0EIom3YRk7Ct7
	 csEPnKYkDUirWiKjE5VCrZpDXbDp3+ZG0CRFQZtmHsbc/xPpB/FAuLWaDzObmv/rtmDch
	 XkBY9BAN+l77CX/uV4d8iDRlcS9Ll+h3NwtKnF12DPMyiTso0H8HbUEoiZd1qLY8leKGw
	 B7pYTFnFdtrnp1DemhRmAZnqOSspKHprPc8gNwhC9ug4Ou+mXO+ZbzcMcfG0HZP5VUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993171;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=fC7d16sKnZ94hg7D3cUEsiZusBH08MBbrrSnGbR4y8U=;
	b=P5Gq2417kEl4Sln7xdyn+K06fATX3dJlUsytvmdBvp4OKWFxT3Nto9ddQN2wX4tzF9cw
	 fbsjj31tUot7uyw4/O5hJbqZg4/Lx0LiLCjjH4YUn1b5AjYEy33q5XU397X3BiyK+S61y
	 3cwJO0w5S66wh5QM/isIp72QEcKRMBSMSqYrUpzD8W3XK9TSyJbEFvdKe5NFxAXbaN39W
	 owgCnaQ7gQzDXXIxrNV1hqjc9NZYmdocTkT1MBhaRdqDPolndJNPKePeutOGDUfXsZfFQ
	 +wUiHeLS/rckFv4LO2Vmics/oGBDe3iH5INK4qHBPkySktmATzBC3dLXIQF25PJm6og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TjErWtK2;
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54407606A32A;
	Wed, 18 Nov 2026 09:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54407606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TjErWtK2
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fC7d16sKnZ94hg7D3cUEsiZusBH08MBbrrSnGbR4y8U=;
	b=TjErWtK2hC1dZGvUgO8veqnAzafhoJwlXhioqVhkOdQgVipv3sBeMGMjsF3LwdGv0dh0qnag5
	MSCdRJGu7wh0ZZIc1Wxo7n6tKWbCvHeK3nKB5guPH4og4wCJWr6s8g1TBtuoZOQFDF97XjrU1Aq
	3X5LROzji6TOmteIXzZebzI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jTwq50F6vzRhV9;
	Wed, 18 Nov 2026 17:12:33 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9374940684;
	Wed, 18 Nov 2026 17:12:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:47 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 05/13] PCI/TPH: Refactor pcie_tph_get_cpu_st & add requester variant
Date: Wed, 18 Nov 2026 17:12:30 +0800
Message-ID: <20261118091238.45992-6-fengchengwen@huawei.com>
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
index d3ff4ccfcc6b..b2bec02f3ea0 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -23,8 +23,9 @@ enum tph_mem_type {
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
@@ -35,6 +36,11 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
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

