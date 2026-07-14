Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1933C17A300;
	Tue, 14 Jul 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025820; cv=none; b=DO6pzD/QpYXbnYjCHBj6xYYyVVjkraY8BDQncEwiTo7a5VWsEDUJ9PlNqwe6nrwzjK1Rh58LQQcLJje2UP2jI5mly/OApG58nWKpqtmx3XLoJWr9CAwf3bakKgOYJuXC9eEmQbNVQQ+aCMXHE9MvyyQt9Ddz+mc9iSRQhzpiFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025820; c=relaxed/simple;
	bh=Z/eVKqYPG/VH5LMZSi323WEUXsQr2yilST0S33aMvv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1PtVL1PhbXPRbUHi3AONuY8HQH7hGaKz4ORWwSbbvbHLxMH7s78Wet4y4CYvgbYe+RVhJOnsrd9AwFI82roTOS9uP3C2kLSykJvDE3V8Nw+nMt6uZhgMy628Su+clCr1+sETFFhKn8Tc7QBmE0rx0cD827g521ARzC3bQHACTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=utW3JX+u; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="utW3JX+u"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=A0P/I5G7APAtmzZPENUvmVEKmN9MtQ6Yg4Gotr0+wKE=;
	b=utW3JX+uKRz5DD7H20faLGGaIRy9Oy6Lyxq23XWH+Jqp8iAFzzar4ENz5zGaoNWzy+E2MZyu5
	WFnEChT2uctIUIdRR8H6uL4/5yw4nzMGgYIxwyLBa1UtMyZlXo1m2/Q8M4jI80GpXBrAJaa1gnH
	+tAcR4Pa28JorrvWGPfN38M=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gzwf35HKxzRhQm;
	Tue, 14 Jul 2026 18:34:19 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 40C9940537;
	Tue, 14 Jul 2026 18:43:36 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:35 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 09/16] PCI/TPH: Add macros to check standard and extended TPH support
Date: Tue, 14 Jul 2026 18:43:18 +0800
Message-ID: <20260714104325.54444-10-fengchengwen@huawei.com>
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

Add two helper macros for TPH capability checking:
- pcie_std_tph_supported(): check basic standard TPH support
- pcie_ext_tph_supported(): check extended TPH requester support

They rely on the cached tph_max_type value validated during probe,
and provide consistent capability queries for subsequent VFIO TPH
virtualization code. Stub definitions are added for !CONFIG_PCIE_TPH.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 include/linux/pci-tph.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 6901f6e2f8c7..04b521b7c2c7 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,7 +9,7 @@
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
 
-#include <linux/pci_regs.h>
+#include <linux/pci.h>
 
 /*
  * According to the ECN for PCI Firmware Spec, Steering Tag can be different
@@ -23,6 +23,18 @@ enum tph_mem_type {
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
@@ -37,6 +49,8 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 u8 pcie_tph_completer_type(struct pci_dev *pdev);
 #else
+#define pcie_std_tph_supported(pdev) false
+#define pcie_ext_tph_supported(pdev) false
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
 { return -EINVAL; }
-- 
2.17.1

