Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CE54146B;
	Tue, 29 Sep 2026 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703244; cv=fail; b=Misnw4nnVFu/Aqc8b9WbD4rkWV6KYHzC+73tNTw/hmH/6oAgjlgP//0a+DnwQgZtgcgTbVNceaQ5yQXLb0V+rGLug7pLovNbEmIRZpHajPbACHjITHpWLHUhusvtuT+Gw1zSOVHz3MBO90H1gzBN3wOc6E/pxcQqNVAxS1A6dlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703244; c=relaxed/simple;
	bh=Z8jWZinQlWLOL45PQeB5lrH+WfHGMW9b5SROLzSMwnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsy2brnEjnH7V26YhWEAAa2aIdW4ALvK0Y0NolhxWrOo18UPrGczeODsNFcKmXgb7crrJpwmwGZ08w2NdaBNd+wyqeHwtT4EV6DvEtYs2MqDy5/yQvUItFJg/EQr/v2vcgljRkVoP9pMBvEY1258sMSuXIXEshkw45tJou2lbDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHwpDntO; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHwpDntO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKNwpNEerZK3kSo6lIgJwrDCTJwcrulVu5+AvoJAQV7mKezToAG293FApcBFurMIKJeTqzcdFMdxr8WeS1IXghIQU4oVDojQdypbmFZ9L6nlAzBRYEfBtBmMrpafJ4Tj4A3UXkvyRHlF6v1ObcQygMkA8F4YTS3ub9eJcvJkFqa6oXrshnrBabHjiCVBXODZNiKG+H/zSQQ0U7cSeKt7k1suOgjHlet7MlbTKhk2hyst4CrPLB8tT/vrWXpkXJHrxIiEJct948n4lQDoDnR/K9J4Fs7zIZ1hwxkSB05lOKpP0YHA7ZyxMCHV9uNduuMgsGFAxgIOiHoipmdHBVpwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMIW0LkLn5EtC53OLrlI/pNdDfZq9DLcGUT+kgbOfSY=;
 b=gLA+yx3bEJX57BiARKAvfHRObPttBwZxnnQznSKq4Xi4G1Y7CybmzmlYUlP4315safsMZbsJs2DKVbuV1jEVpvc5vMiQjjkdeP202RH3ilLeDFoq9vJeV6+XBnqmWwp/b/pmycl2InGVDUfxUze3+wkBQu1/Yxbel13gFW3gaxSEYfgrxiolEa5/b+wBHbc6mM271utyg9NYuEPLtM+IK3alXuXs5VUWp3iv/AM9lkQFY9OXWxzkBtadUSQXGiWn2L8Xll4lqtYp9xU8zKBxszwTn7z96RVSUR+/eRuQwl7THAc3AhOLsRgrgPhxRmUb5Y7n6dXZqZgNV7cS6mf3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMIW0LkLn5EtC53OLrlI/pNdDfZq9DLcGUT+kgbOfSY=;
 b=tHwpDntOdfmymmkZVAzUnYRZi475ch3qTUfz52CjrjFvJBr/Hni/AjcG9gzDAZ9MqIrNHOjkh43aUFOt/u+EJVNhS+jqduWUl1tq6id2zHWvHHcel8eLFTzBzSF8sQueEpaD5TMX2ccfUop2U4boClWIBcFrFAVsQz2UjBBn7Jp/a1kSbYUc/efCXfg536MarelstIln9Qy22helw/aBcpiF197A4lxZl0KKGSwTEkMixUvw3+J5IiuS42+1h7r0XQVgQvFF4GBI0LX1D37fKMG2+u3InqGMSrnxzTtqBAPpfUPPE3wTy5R7UrTeR+MLWkf6kUEPEgoo9xvCcAyTYg==
Received: from PH8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:2cd::18)
 by IA3PR12MB460542.namprd12.prod.outlook.com (2603:10b6:208:709::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 17:33:57 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:510:2cd:cafe::8a) by PH8PR07CA0019.outlook.office365.com
 (2603:10b6:510:2cd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 17:33:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:33:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:27 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:24 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 01/16] vfio/pci: Add a device access gate
Date: Tue, 29 Sep 2026 18:32:50 +0100
Message-ID: <20260929173305.204856-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929173305.204856-1-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|IA3PR12MB460542:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b95ad7a-bfb5-4a10-54e5-08df1e4fd75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|260925021911599003|11063799006|56012099006|260925021311599003|260925022911599003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	INEfaaWd/IJiv8oZUtOkbhqljD7ptkOz43/pptxbxU/qEp7VUrJ835ZNKSdE9HRpKuZ1GqqaDYgnREgHPNLmg4GJ/hjaYz0dUh7aAswhs5bBDa8ZhxrONJXKVAuz53g5qHfGdbsC4VusazPAgLc1KHISsubfEH5+/fDs2XxDzxThXlXEayUwBJq8HZAzZHgttXK/xs7igxfjgqYE8NCEfGYKxzGtq/z6wB3Ah59JGhzuTkJKsCmm6FLex84DUIndtyAK1eth+qGg5usBjn44nTzYtz/339xDDtd+VZ/DtTRe2apySNwpFOqH2rDY0C6tD1SIGyTHlVxDHZNkAVOF9ZY7y0lSOzNfRTOv09y6c9sZ/8s2x2JqdoI/E34BlJB5j/f0GhbUannducxmJ9aJlIvVf+Txv1jxlVAPAViMjNzfsvUNjWx0K2EtPv2lWN1ahoidlhpnsyYGTpM4wyzX6mC+jTaZax8GvcYvxFLyDRjTQU5PNvE2gT2cr0X7UPkJe5RW0l8wwYMhySsFyKlVZGa52RcaVuFUGeNJ3RkjYAQdCu603B+mpB20JxJGLa++1fEnhKsrO93JuulkYeoYzbcTlgtRScG1eFqFXqCEVUuEY3FcRZHpODY6zYWRBplXLHPAyRJ5QIvsMky1JB/1gkNk4eq+CDyOJEHO7CMFAwCU3IclLoGpqHPmfrcrIGjEE5QqZtGzZRxZQefZgiC5bA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(260925021911599003)(11063799006)(56012099006)(260925021311599003)(260925022911599003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s4U0JKUIPhlzNthcs3QEIivgC7Dcp+BHBlp8qbqefBfcOpimFDNltRAxbQ8/aTvS6F7gsIT/SGfR+uftk5BXCJmBq9okXkCYim+zjHy3v/KG02ROk9GyuCaZ41c5/uhaGwJoKg8mx14VGp9/GafQ1gxS/5wKC+0fpAAvYDs66aE1Zb8Hy8ta2jyJ9hUkki+dzhuhDsRC62Q0rEUH5ReeX9CuT4eR23W35ml0x7zJgYkJO38tIcDwkNez67ZeToIcZX0W3uOD/6j+pYyjSNGIaaTog0IXK27pWCqGF9AschphgxgEujJVY5dviIWLAVi+P3pdMgln7a+dmGmCqW4s8n5+yE6m95VHAga1/9XVVt8kgwmDA6gWU9otPOS3+UWkTWy4f7lz2AIGe4m27uZlx6lJ2vWLKRi+GTi1YcX7bLV73qoDhjXaUQNSHTyMCbeG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:33:57.2928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b95ad7a-bfb5-4a10-54e5-08df1e4fd75a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB460542

PCI error recovery needs to block new device accesses and drain
outstanding accesses before changing device state.

Add an SRCU-based access gate, enabled by pci_recovery_supported.
Serialize open and close state updates with access_lock.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h |  3 ++
 include/linux/vfio_pci_core.h    | 19 ++++++++++++
 drivers/vfio/pci/vfio_pci_core.c | 53 ++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..623e73f379cc 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -73,6 +73,9 @@ u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
 
+int vfio_pci_core_access_begin(struct vfio_pci_core_device *vdev);
+void vfio_pci_core_access_end(struct vfio_pci_core_device *vdev, int idx);
+
 #ifdef CONFIG_VFIO_PCI_IGD
 bool vfio_pci_is_intel_display(struct pci_dev *pdev);
 int vfio_pci_igd_init(struct vfio_pci_core_device *vdev);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..de0993280344 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -13,6 +13,7 @@
 #include <linux/vfio.h>
 #include <linux/irqbypass.h>
 #include <linux/rcupdate.h>
+#include <linux/srcu.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/notifier.h>
@@ -129,6 +130,7 @@ struct vfio_pci_core_device {
 	bool			disable_idle_d3:1;
 	bool			nointxmask:1;
 	bool			disable_vga:1;
+	bool			pci_recovery_supported:1;
 	/* Flags modified at runtime - dedicated storage unit */
 	bool			needs_reset;
 	bool			pm_intx_masked;
@@ -148,6 +150,23 @@ struct vfio_pci_core_device {
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
+	/*
+	 * Device accesses take access_srcu and check device_open and
+	 * access_blocked. To block access, set access_blocked and wait for
+	 * existing readers with synchronize_srcu(). New accesses fail with
+	 * -EIO while blocked.
+	 *
+	 * Close clears access_blocked before device_open.
+	 *
+	 * INTx paths use irqlock instead of access_srcu to coordinate with
+	 * recovery. They read pci_recovery_enabled and access_blocked with
+	 * READ_ONCE(), since writers do not always hold irqlock.
+	 */
+	struct srcu_struct	access_srcu;
+	bool			access_blocked;
+	/* Set after open completes, cleared before close tears down state. */
+	bool			device_open;
+	struct mutex		access_lock;	/* gate flag writers */
 	struct list_head	dmabufs;
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..88a78766c178 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -662,10 +662,18 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled(vdev) && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
+	if (vdev->pci_recovery_supported) {
+		ret = init_srcu_struct(&vdev->access_srcu);
+		if (ret)
+			goto out_free_config;
+	}
+
 	vfio_pci_core_map_bars(vdev);
 
 	return 0;
 
+out_free_config:
+	vfio_config_free(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
@@ -812,6 +820,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	/* Put the pm-runtime usage counter acquired during enable */
 	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
+
+	if (vdev->pci_recovery_supported)
+		cleanup_srcu_struct(&vdev->access_srcu);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
 
@@ -820,6 +831,13 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 
+	if (vdev->pci_recovery_supported) {
+		scoped_guard(mutex, &vdev->access_lock) {
+			WRITE_ONCE(vdev->access_blocked, false);
+			WRITE_ONCE(vdev->device_open, false);
+		}
+	}
+
 	if (vdev->sriov_pf_core_dev) {
 		mutex_lock(&vdev->sriov_pf_core_dev->vf_token->lock);
 		WARN_ON(!vdev->sriov_pf_core_dev->vf_token->users);
@@ -852,6 +870,12 @@ void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
 		vdev->sriov_pf_core_dev->vf_token->users++;
 		mutex_unlock(&vdev->sriov_pf_core_dev->vf_token->lock);
 	}
+
+	if (vdev->pci_recovery_supported) {
+		guard(mutex)(&vdev->access_lock);
+		WRITE_ONCE(vdev->access_blocked, false);
+		WRITE_ONCE(vdev->device_open, true);
+	}
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_finish_enable);
 
@@ -1680,6 +1704,33 @@ static ssize_t vfio_pci_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	return ret;
 }
 
+/*
+ * Return an SRCU index for access_end(), or -EIO if access is blocked
+ * or the device is closed. Do not wait for recovery.
+ */
+int vfio_pci_core_access_begin(struct vfio_pci_core_device *vdev)
+{
+	int idx;
+
+	if (!vdev->pci_recovery_supported)
+		return 0;
+
+	idx = srcu_read_lock(&vdev->access_srcu);
+	if (unlikely(!READ_ONCE(vdev->device_open) ||
+		     READ_ONCE(vdev->access_blocked))) {
+		srcu_read_unlock(&vdev->access_srcu, idx);
+		return -EIO;
+	}
+
+	return idx;
+}
+
+void vfio_pci_core_access_end(struct vfio_pci_core_device *vdev, int idx)
+{
+	if (vdev->pci_recovery_supported)
+		srcu_read_unlock(&vdev->access_srcu, idx);
+}
+
 ssize_t vfio_pci_core_read(struct vfio_device *core_vdev, char __user *buf,
 		size_t count, loff_t *ppos)
 {
@@ -2196,6 +2247,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 	INIT_LIST_HEAD(&vdev->dmabufs);
+	mutex_init(&vdev->access_lock);
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
 
@@ -2210,6 +2262,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
+	mutex_destroy(&vdev->access_lock);
 	kfree(vdev->region);
 	kfree(vdev->pm_save);
 }
-- 
2.43.0

