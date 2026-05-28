Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F153F075D;
	Thu, 28 May 2026 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972423; cv=none; b=VZ3ThwDg6iPT5/wSD0wPQt7jyf2Nrpy8LOE+rl8JVV6GzyIjB3/XsG7/c4wZraR7sChC9w7pI/QhUzEmmI5WUGVPlFi68UBqoU3KY0qyFuidzh0xUNs63SS6lvWH4vg/rPd2JKH+aGVkGMBC1geFS4vJ9nxJrIIhzqGG2p78+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972423; c=relaxed/simple;
	bh=FMd3MY7wTwb9NOngMOEVR20srd2mxVySi5Xm/TaYKZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3bxrw2QQBGE3VNcoEHq+Y4gZ3sZvJSFUQvUf5Q/f+3eHcRjC6wndMlxM6Ocla4/Tf8DTigY8hGfKpI5pxBKKz3ZLII+AioZE53JLnS0Mlx8b+ii0LJk4DUIgTfWMfXWVHwg7PvTmxqCXTQxUMPikFvLAG6niXb3YV/s1p0d6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KBI9aVCT; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KBI9aVCT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xDnrHAih70P5U+Gb4fQkG+mHDydABO7euckLoroXUFk=;
	b=KBI9aVCTRbPT+aIdRq8f6JHdLAF8owlKoCtFRrst9Gq0luFd4MX4bOaWIVmM7BiOvRCr1SpVx
	7GFOYUQbEN8CC31PkSMNoABv1q6dcaKkPsRzjx5Q/Z717tTauisf39QyYP/r4KneaA5u1bCUZP1
	Eb4YboEfIJBXsQ2o4P0B4Ow=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gR5dq3tqgzLlwx;
	Thu, 28 May 2026 20:39:11 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E730402AB;
	Thu, 28 May 2026 20:46:57 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 20:46:56 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v14 5/8] PCI/TPH: expose the enabled TPH requester type
Date: Thu, 28 May 2026 20:46:46 +0800
Message-ID: <20260528124649.14732-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260528124649.14732-1-fengchengwen@huawei.com>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)

From: Zhiping Zhang <zhipingz@meta.com>

Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
requester mode without reaching into pci_dev internals.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 12 ++++++++++++
 include/linux/pci-tph.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 4a2c3575a883..c7957b4a28d3 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -460,6 +460,18 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode,
 }
 EXPORT_SYMBOL(pcie_enable_tph);
 
+/**
+ * pcie_tph_enabled_req_type - Return the device's enabled TPH requester type
+ * @pdev: PCI device to query
+ *
+ * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_TPH.
+ */
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{
+	return pdev->tph_req_type;
+}
+EXPORT_SYMBOL(pcie_tph_enabled_req_type);
+
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 7f78a40173c9..55af14d2457e 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -44,6 +44,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode,
 		    enum tph_req_policy req_policy);
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
@@ -59,6 +60,8 @@ static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode,
 				  enum tph_req_policy req_policy)
 { return -EINVAL; }
+static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{ return PCI_TPH_REQ_DISABLE; }
 static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
 static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
-- 
2.17.1

