Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993179;
	b=Ks2kFfXACvUWK/qvWPcmmzzz8aVipXp7SkK0nzD8xacUjyzxn8NK4DKvyu7nOWC68Pm1
	 ibCS//pXPK91XGdcsgU2gGtyCEUwk/2oekQYckTjyG88REQ8iSuIIbYEI44BA55jgX4+B
	 bb5nMhhlTreqlXZzpMRiKihQoWWzfVf2hw4oSdvfEEp1Rx75yHGVdnUI2qcCuoiRXZXNe
	 6glfH05GCd+etz59IUXNn/twnnaFYEGTED6Rblh+efyGY1jtXqvk5Subg9W0Em0VM1/EO
	 /L36lchGLqFcYP8NUC+L234mdRzCd/YeRfv2vs7w5QYryzvbvb2NnlGWwJW+zIHiNFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993179;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=aFT87rUQqZwGHrebjcvSW+u41zzEGjQmj+R2KYXMj7k=;
	b=0WBBkPmg/4VBIyDNE1lKJK9R/2qqN75TFx4w4fKI5R90a/l7tzcGzZyxCsEbAtEA3iBg
	 VHR64V/JraXiMaFBKdYiRsQn9q+qaGFoGR+5dSqt2LutWmSriYX1qxsyXM85lc//yhLg0
	 l2EzZSmKs38ygcaHNUQUGpveY0d9c6fje3msr4d5Q1nv5txyxDGL+lLIJ3uM4SPtaU6s3
	 GYleuH6fKwcvAgF9De2VF4wEJEy6zDAHF2NctZE5Sla2wI+2BALBhNbbYQrlCj+w6Mv8P
	 dhXAqNMWbDnhzwkqEb7gFD85zZ3HvGHvSLglHd6pAkVvPoE1wHCmieIqjGIW1MGzhnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yr8UWalX;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE3606A32A;
	Wed, 18 Nov 2026 09:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CEE3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yr8UWalX
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aFT87rUQqZwGHrebjcvSW+u41zzEGjQmj+R2KYXMj7k=;
	b=yr8UWalXvPyFGmQM6FiSdKPQ2EVO+2xLaDzJ2iYOTiqcLOqm1hrINEkIZWwz7azLciLDT2HFk
	NiQjqAg7cjFLuYI+ACrZqLNrkGUp2ARobUnjoXvLGHubohR4L8s8pd7UsR+brlBPxrToX7HouLi
	vZ/ctatODKBOod4QdqvrbzY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jTwpn4nbtz1T4G5;
	Wed, 18 Nov 2026 17:12:17 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DDB240579;
	Wed, 18 Nov 2026 17:12:57 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:47 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 06/13] PCI/TPH: Add macros to check standard and extended TPH support
Date: Wed, 18 Nov 2026 17:12:31 +0800
Message-ID: <20261118091238.45992-7-fengchengwen@huawei.com>
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

Add two helper macros for TPH capability checking:
- pcie_std_tph_supported(): check basic standard TPH support
- pcie_ext_tph_supported(): check extended TPH requester support

They rely on the cached tph_max_type value validated during probe,
and provide consistent capability queries for subsequent VFIO TPH
virtualization code. Stub definitions are added for !CONFIG_PCIE_TPH.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 include/linux/pci-tph.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index b2bec02f3ea0..50640fdc84e1 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,6 +9,8 @@
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
 
+#include <linux/pci.h>
+
 /*
  * According to the ECN for PCI Firmware Spec, Steering Tag can be different
  * depending on the memory type: Volatile Memory or Persistent Memory. When a
@@ -21,6 +23,18 @@ enum tph_mem_type {
 };
 
 #ifdef CONFIG_PCIE_TPH
+/**
+ * pcie_std_tph_supported - check standard TPH requester support
+ * @pdev: PCI device
+ */
+#define pcie_std_tph_supported(pdev) \
+	((pdev)->tph_max_type >= PCI_TPH_REQ_TPH_ONLY)
+/**
+ * pcie_ext_tph_supported - check extended TPH requester support
+ * @pdev: PCI device
+ */
+#define pcie_ext_tph_supported(pdev) \
+	((pdev)->tph_max_type == PCI_TPH_REQ_EXT_TPH)
 int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
 int pcie_tph_get_cpu_st_ext(struct pci_dev *dev, enum tph_mem_type mem_type,
@@ -33,6 +47,8 @@ int pcie_enable_tph(struct pci_dev *pdev, u8 mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
+#define pcie_std_tph_supported(pdev) false
+#define pcie_ext_tph_supported(pdev) false
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
 { return -EINVAL; }
-- 
2.17.1

