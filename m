Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6248124A;
	Thu,  2 Jul 2026 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996176; cv=none; b=evg/BLA+MnAOf8YC/vqrMGFK/oZIg4V3rnkYJg9Ro9NQCZmykxOeOzCBQyJbbvCN7fCyo0H34bgjT3pKfTM9cRIoGIRAfx7vcUr0EGcxdSbxSngXfhoJd4svKtftWV/iXHdMZBm66Q6rnh4xvIGoTg9XCyYRuV/SZVebcv/uJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996176; c=relaxed/simple;
	bh=5dzU1vMaz3uJcjWKKMVs8mmvmhzs3gfjYCTjT3ZNRwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tj1tBO296CP5J9YV/GvLjha1TFb4oCY2PFsDMcaIsTXDq2Bt9B76SG8RO/HOCQ6xlYKGPqz8KWk1y7ea3SLJqnCAb1U73eHKoB4BC5m40jVjBZawAcXLvw1/8paAMAEuj5M7K88w+v/ib1lzYvaf2DztPQQCKIA1BLHoxil9fAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Kp3YYeqJ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Kp3YYeqJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fiz8zIYdhpW3YAqQNyvdV/je4tzfRw26qXh4mkR7bb8=;
	b=Kp3YYeqJbnGuVuHvkTW0+1flK41Bf3tHKBHvLUSoH4imliqD+9qCrvYZgRSFUcmLlcNrPiMDZ
	2+ucHYv/N7hm7G+tLlieJP0yNutWq/zkeLM0PWzNDwj1d3cLthq/upeNjMv+FcJx+GLvdAOvkf/
	wYylfe0Q9wd7omsI1LUcG24=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4grbsM54gqz1T4Gj;
	Thu,  2 Jul 2026 20:33:43 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 1653C40579;
	Thu,  2 Jul 2026 20:42:36 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:35 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 10/18] vfio/pci: Introduce tph policy parameter for staged TPH feature enablement
Date: Thu, 2 Jul 2026 20:42:16 +0800
Message-ID: <20260702124224.57168-11-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260702124224.57168-1-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Add a module parameter 'tph' to implement staged TPH feature enabling
policy. The parameter accepts a value from 0 to 3 to progressively enable
TPH capabilities:

0 = No-ST mode: RESOLVE only returns PH for DMABUF source;
                ST programming unavailable
1 = Add IV mode: RESOLVE only returns PH for DMABUF source;
                 ST program supports NONE/DMABUF/CPU sources
2 = Add DS mode: RESOLVE returns PH+ST for DMABUF/CPU sources;
                 ST program supports NONE/DMABUF/CPU sources
3 = Add LITERAL: RESOLVE returns PH+ST for DMABUF/CPU sources;
                 ST program supports NONE/DMABUF/CPU/LITERAL sources

This commit only adds parameter plumbing and state storage, no
functional TPH logic is introduced yet.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c      | 25 +++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h |  7 +++++++
 include/linux/vfio_pci_core.h    |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..7ef82b445722 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,28 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+static unsigned int tph_policy;
+static int tph_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, VFIO_PCI_TPH_POLICY_NO_ST,
+				     VFIO_PCI_TPH_POLICY_LITERAL);
+}
+static const struct kernel_param_ops tph_param_ops = {
+	.set = tph_set,
+	.get = param_get_uint,
+};
+module_param_cb(tph, &tph_param_ops, &tph_policy, 0644);
+MODULE_PARM_DESC(tph,
+	"Global TPH policy level (0=default No-ST):\n"
+	"0 = No-ST mode: RESOLVE only returns PH for DMABUF source;\n"
+	"                ST programming unavailable\n"
+	"1 = Add IV mode: RESOLVE only returns PH for DMABUF source;\n"
+	"                 ST program supports NONE/DMABUF/CPU sources\n"
+	"2 = Add DS mode: RESOLVE returns PH+ST for DMABUF/CPU sources;\n"
+	"                 ST program supports NONE/DMABUF/CPU sources\n"
+	"3 = Add LITERAL: RESOLVE returns PH+ST for DMABUF/CPU sources;\n"
+	"                 ST program supports NONE/DMABUF/CPU/LITERAL sources\n");
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -142,6 +164,9 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
+#ifdef CONFIG_PCIE_TPH
+	vdev->tph_policy = tph_policy;
+#endif
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..c997cc9bf330 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -11,6 +11,13 @@
 /* Cap maximum number of ioeventfds per device (arbitrary) */
 #define VFIO_PCI_IOEVENTFD_MAX		1000
 
+enum vfio_pci_tph_policy {
+	VFIO_PCI_TPH_POLICY_NO_ST = 0,
+	VFIO_PCI_TPH_POLICY_IV_ST = 1,
+	VFIO_PCI_TPH_POLICY_DS_ST = 2,
+	VFIO_PCI_TPH_POLICY_LITERAL = 3,
+};
+
 struct vfio_pci_ioeventfd {
 	struct list_head	next;
 	struct vfio_pci_core_device	*vdev;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..a0641286dd90 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -149,6 +149,7 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	u8			tph_policy;
 };
 
 enum vfio_pci_io_width {
-- 
2.17.1

