Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA3C3644C6;
	Mon, 22 Jun 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114337; cv=none; b=ty6bTMHMMVGQtcCp+CYZWr6vScqYRHfmvF+YXg8BBJ/mHmBhcnLyfkZDINHO1n7Ku5e5NoNArSx1/TwtvnAuqzWwEKlxMJ+SddV9w4gAZwNtLGuQlGasw08T/gpPDoFsZlrn2TDBZMtEVCoxx65yTA9xfB6htwC0jet1XMu0ulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114337; c=relaxed/simple;
	bh=C0WbT8eqnmIfBBHZguuqumLvAbUpdoQ7mhSOfJbV3k0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIyfIbuU5OADMykRTOrw086T/0iiXLL2mvVjk2ol6EeBnxgIzR97DXT1BYO0xos90qvhVz6LJ+zpOOoqPvwXv3PocVXeNm4Yaiqb8C8XJG9Fq0aV7zzz9nd0Ne/a2cU33UcamgfgbLWU7eWbKeJ9hjd2Lc2XjVGYOyl8DRnNIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uM6uLXeC; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uM6uLXeC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=65oRwhImegxb5EemkORsjCZ8+Na5woU3ZOPIJydV3/g=;
	b=uM6uLXeCIs2rxz+Jp4EV5k5nLPVoOE2TMN1deM4NdAf9AhWELFyAL940OlP+t9jSqPLpVuHZ8
	NDvXQY1aaLiZBeuzxRgGP/SsA1w7Mt72wEQ2cDprWb/o3dYqfAnricNIF2HhViXWzRu3Rc1cfKL
	qq3dkVFLssTLgjm0QdqV2Yk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gkKl070G9z1cyNs;
	Mon, 22 Jun 2026 15:36:28 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9749D4056C;
	Mon, 22 Jun 2026 15:45:31 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 22 Jun 2026 15:45:31 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v18 06/12] PCI/TPH: Expose the enabled TPH requester type
Date: Mon, 22 Jun 2026 15:45:17 +0800
Message-ID: <20260622074523.38473-7-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260622074523.38473-1-fengchengwen@huawei.com>
References: <20260622074523.38473-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

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
index aca08671fdfe..6c4623cacc85 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -483,6 +483,18 @@ int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended)
 }
 EXPORT_SYMBOL(pcie_enable_tph_explicit);
 
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
index 1a508b3d511f..e4f7045fc152 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -33,6 +33,7 @@ int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
@@ -47,6 +48,8 @@ static inline int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
 				enum tph_mem_type mem_type,
 				bool extended, unsigned int cpu, u16 *tag)
 { return -EINVAL; }
+static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{ return PCI_TPH_REQ_DISABLE; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
-- 
2.17.1

