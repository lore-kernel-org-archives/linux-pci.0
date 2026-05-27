Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2A392820;
	Wed, 27 May 2026 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875251; cv=none; b=ia+IDrfGKSsLW/+2o+PWx7lZJm5Tl82NlD3gDiIJPhghZaej2xcG2J1d5g8gMku+nlPm4zuM1uWPrt+MvxOyXyvFBjaDVcMJ0GJjMxrDkZw9901+tq0gg/MLNo1L02qSfPuYxCuDCwbFvBrrRq/ce4n5MYtoMXy8Q9qZya9XWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875251; c=relaxed/simple;
	bh=D73DYFwVjwcIEgNgcApuEGE8m7m5+9nFKXDJWp/2bDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/Hu/7zz6sikmoS4BhG/rsZ80SNV0cqp+rDUMk+fAvuRyMNXU6Zj3ft81IHd/O+ThCDJr9F3/NJZUAAF4G3RdISHtQezPsTtix+qmpZU1umwXPb5zb/JRDVrJ24NLi/ZC6iqV2rUXxwlWuKEN18nvVeAy0VjRmx9Ucpfc47/mSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BKmQ62fU; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BKmQ62fU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1/GqvF4uYB76LIkz+UgMsc+1nogzr//MEy+Fk6lWTvo=;
	b=BKmQ62fUGkmkD0mDlk6kXlrrq1N4FDNIKYVHHgJCekJFo7akYCqnN02+/xbajQjcqcZ4OWH67
	4oNFEjFahS0r0N7VjUyZKgHHOUPoOHnuLPY63AaLqs2oq5lYpP0E1xuXklLiR7jWJ3PXyvtzE7R
	rhOF59HgorGEhhWmCZuBsZ8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gQPhx5shQznTXX;
	Wed, 27 May 2026 17:39:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id EB16D40561;
	Wed, 27 May 2026 17:47:26 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 17:47:26 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v13 5/8] PCI/TPH: expose the enabled TPH requester type
Date: Wed, 27 May 2026 17:47:16 +0800
Message-ID: <20260527094719.43886-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260527094719.43886-1-fengchengwen@huawei.com>
References: <20260527094719.43886-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
index c5695bceb5e8..509057799a9d 100644
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
index 66e6140ddb72..c59656de3bbd 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -41,6 +41,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode,
 		    enum tph_req_policy req_policy);
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
@@ -56,6 +57,8 @@ static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode,
 				  enum tph_req_policy req_policy)
 { return -EINVAL; }
+static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{ return 0; }
 static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
 static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
-- 
2.17.1

