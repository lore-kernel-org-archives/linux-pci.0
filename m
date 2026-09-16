Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3824C59B661;
	Wed, 16 Sep 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583884; cv=fail; b=t1PLTIcfegAOkHwDgKjeUpcHdULeSwOGNCKYVyMHX31M38uvn+egTfPl5gSKyoj4vj+3GmmiNXEnklSNwM6kM6Q+FGJhNVbw6FOb7aR/rpKnhCFv0V6zfA6RbU8WnKudKspRDNYcF4sPo+Nhp3+ZYCAfGrVZ2Mm7DQllMhNvgck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583884; c=relaxed/simple;
	bh=MvS+sJqArEqMeFRPbZCdfbTVSgcxB+wz05ZWHL2xQwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlXH8hX8Ozi8/x7y1xsZzBe5ifNEhLdoLRH2yigQgTPu1NfYxt8w6WQ8Mymj5owWorXoKVz+SzBNkujGJsvnJSAVwZZTXiAQgMfYS6scH2gFu3t4fE1upIOU7ZAtrS7wd6rMdaMVMZwqiCx7V4SvUxVW/UzKWLntc7K4PiaVCrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZFxte//A; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZFxte//A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpAIXSQr7XE4k5GL6a+gl2BGr9jR11bOjH2o1gYjQ/Je1SUFgO7847gjwlALyX2seVX6dPK2d2qFpcmGIEww2wmEShD6WUKsoYyrSQTWtrx26G/3afzioMTYYvc8coRkscw0wdIxnQsYgcnMk4T7zGxwgKO/1E9IYLLxr2/L6e4RWa6ijJpmQXUVTerLBhXT8HVoHfizpzja8XOFDUn5iAmDM/ecsFAC96JGVO/IBWqG/MsITd5OdjyZ5Qjydc/z17DlslvP0zOFo63Pp/NXmZJRnl7AIYor0WG2jnVdWwMe7D/FpFniOek+zmczfsP/B4msxRrpF33iBtT35RFAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3uF82QFZx67/FcxUP7snnuPALd5zo/is9cMmYPE+04=;
 b=OPpov0+VpU2+13GlkkiKgPbIyTUbGPry3yRqLNjQXcyXk2BkQ0L/eIU0G+u054JIhH01usHQRV1Qyxqw1aBu/0Jr3jHAiNmI2pUZcvW8QPHMXSo/f/+5EYqIgWwiADnyflhKEVFqdRQ8+07u3dDrxMg/9sFnTGLd1dLOC16ya9pSBvzIHmhhKMwt1Od6tePJJLNVqYKo3eBrDl1RBKmN/qQRfGeg7U+OKwK0YaBuMCwjEGUEs6umJ0ZeU4Atv5JbYwZnEbk4dyyETUwrb8hEjRSqcXY6Op/5+SjW50zq/rkYN4HVURvzC6l8g5X6n46sn/dNZI7IfYvnPYhFsM8Uww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3uF82QFZx67/FcxUP7snnuPALd5zo/is9cMmYPE+04=;
 b=ZFxte//AYyE3eGx9TM034z2QHlLjG4hIleyuRxSDGyiQqYKnQw0dFduSEU2DrAbIhSwPXRUuXtKYAB8UO0i/GISoMm/a1LrD+shiM6J9Lp05Q+VoCeULB7pVxQZpBUE4nNIrqf7eSG6HfBTfYGmMSWf7moC8A3Q70uv6kgQ7Q7SDS7opRdmAWtFml6h5wgnwH1M3ZwP0k1Lzkp1wW3Dr0iEtzrUZnQv8oOw/hoTgljY2093x0Br/zRgbziKGGDOvBIYvGSo6xEcAq6GXx653G/Z6s3484/JMPOpLK9inwLzeQAgi0xiewdV340zMrV1qDlmoCjR+Xfj9hX4EsTfsoQ==
Received: from MN2PR08CA0018.namprd08.prod.outlook.com (2603:10b6:208:239::23)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:37:35 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::30) by MN2PR08CA0018.outlook.office365.com
 (2603:10b6:208:239::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 18:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:37:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:37:02 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:36:53 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v5 06/27] vfio/pci: Detect CXL devices and load the CXL provider on demand
Date: Thu, 17 Sep 2026 00:05:19 +0530
Message-ID: <20260916183540.3813685-7-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f06bc6a-763a-4aeb-a62c-08df14219313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|23010399003|36860700016|22082099003|18002099003|10067099003|921020|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	9yzq39ua3uKE4tk5QOP5mkw9xILdy3/godFIKRF6Jqy3Zx5i4NsY1JkKmGax98oCN99JdenjkhuQGJUUfeQImBvQX7dGkMhaOD8QMDVNSNuvp8/Bud5+n+mA2OkRdwzkzPpO54qfn1By5Xpcw9njaLKIbsCZuAhvzuD5Ckqe/ja9dpSzFTvdhrXKx3TuzMYx3sEfI0zL6GO694uXkqWYaj0x5IGCT3kMzdWaG9vjJqAFcyQy4VxWOWv+KpzFD1ZjVzDYPzY0zbwkCrqoEykfEsNtk7232EeORRgWAYDWQxzyU8q5TpdWdznUXAElXX3cEsC33wEyXI/ocUBKVa/09ZFtThDegZzzK0Y3rByn9IKFOD1yqirInbt6miCSh9nmlVnhXHPqOweba5EUCwA/hsKwZwGLkVhJPhmWJM7XlIZIXdOVKz2SFXF91HddwNWkuWVKsIR3ugquyKueMUVSurvBuQXHIfLndDhvaGTqWhv5UXDEh67tY8aoA/0fULJQPualzfMS2EzE0eli7iHTPjphxz5ePBRfZJTsmvrmbX11Z9RMYze9ZYV9A1VVELkOFkYF8LYI11GLn1LuWOmVe/XVgyEfq6G2qPeVvrLMPX9qYf8Qc98R2dvGahS99L2t4QPHTx+SSJfouBBHWwphN9ZfQWrTJsBoPhJCUUI+on4YK/4yyhV5VHNJ0ho2AoCWKZKzXUXyCq/PiGiLKQq1fBllsJEd7uQm0eGhNi6WPXGjrIJ9p66G+THSQtUSqqC2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(10067099003)(921020)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MAwnuMHZRXpk4WLzZDTuS13qYLqSF8WMbHrgUg6e3CyZsQ9zDdfpBNTq1Wb5o3qXYBJE/JkbsUXAm8ANrKus9d6vpkTWb7AjD+yRyYlZfwNR/NDZiOv7rAHgQZ4YAJSsTBVB0eqF/91EFTazXss3AULWCFz3yRcbHFhy7gRXorzNnmSuCdriDvC+XX+bpNJ++tbgLqoi4CaIQaPagEdf5zBxIIklvd6sfk/cMMaMNc2RV3t0vX1C9+b3xpUK4omZ4Cb1OBxqYbykAidgweTS21aiKtJ6WTw5IhPI1TTqUNcTOkBBdZ1jJhoVw9Kz1lVQNXCYSlpiuCXpCLRNq+sEPoRe2xfLNC0i/mc+vJKqMdSLe/XugFax2is35xUCEiwU5JfNrvEfcgjOnFLl0ul8cE7WbK6zjOFog6r5zbig4LVwXoT8wh7mqItHZvBGIvtx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:37:34.1883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f06bc6a-763a-4aeb-a62c-08df14219313
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663

From: Manish Honap <mhonap@nvidia.com>

A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and the
CXL core in unconditionally would bloat every vfio-pci setup. Detect a
CXL Type-2 device at bind and request_module("vfio-cxl") only then, then
hand the device to the registered ops.

Each bound CXL device pins the provider through
vfio_pci_get_cxl_ops() (try_module_get) and drops it with
vfio_pci_put_cxl_ops() at release, so vfio-cxl can unload once no CXL
device is bound.

If the provider is absent the device is driven as plain vfio-pci. A
built-in provider whose initcall has not run yet is waited for with
-EPROBE_DEFER; the deferred-probe machinery will retry the bind once the
provider registers.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 84 ++++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  3 ++
 2 files changed, 87 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 2cc5dd20396c..9eede1e56ab5 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2202,6 +2202,84 @@ void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
 
+static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void)
+{
+	guard(rwsem_read)(&vfio_pci_cxl_ops_rwsem);
+
+	if (vfio_pci_cxl_ops && try_module_get(vfio_pci_cxl_ops->owner))
+		return vfio_pci_cxl_ops;
+
+	return NULL;
+}
+
+static void vfio_pci_put_cxl_ops(const struct vfio_cxl_ops *ops)
+{
+	module_put(ops->owner);
+}
+
+/*
+ * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CXL DVSEC.
+ * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem only)
+ * devices, which the vfio-cxl provider does not handle, so confirm the Type-2
+ * identity before engaging it.
+ */
+static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev)
+{
+	u16 dvsec, cap;
+
+	if (!pcie_is_cxl(pdev))
+		return false;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return false;
+
+	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
+		return false;
+
+	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
+		(cap & PCI_DVSEC_CXL_MEM_CAPABLE);
+}
+
+/*
+ * Load vfio-cxl on demand for a CXL Type-2 device and hand the device to its
+ * ops. If the provider is absent the device is driven as plain vfio-pci; a
+ * built-in provider whose initcall has not run yet is waited for with
+ * -EPROBE_DEFER.
+ */
+static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
+{
+	const struct vfio_cxl_ops *ops;
+	int ret;
+
+	if (!vfio_pci_is_cxl_type2(vdev->pdev))
+		return 0;
+
+	request_module("vfio-cxl");
+	ops = vfio_pci_get_cxl_ops();
+	if (!ops)
+		return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
+
+	ret = ops->init(vdev);
+	if (ret) {
+		vfio_pci_put_cxl_ops(ops);
+		return ret;
+	}
+
+	vdev->cxl_ops = ops;
+	return 0;
+}
+
+static void vfio_pci_core_cxl_release(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->cxl_ops)
+		return;
+
+	vdev->cxl_ops->release(vdev);
+	vfio_pci_put_cxl_ops(vdev->cxl_ops);
+}
+
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 {
 	struct vfio_pci_core_device *vdev =
@@ -2223,6 +2301,10 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
 
+	ret = vfio_pci_core_cxl_init(vdev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
@@ -2232,6 +2314,8 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 
+	vfio_pci_core_cxl_release(vdev);
+
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
 	kfree(vdev->region);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9fe0d1a3a370..7f3a2bcb5830 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -29,6 +29,7 @@ struct vfio_pci_core_device;
 struct vfio_pci_region;
 struct p2pdma_provider;
 struct dma_buf_attachment;
+struct vfio_cxl_state;
 
 struct vfio_pci_eventfd {
 	struct eventfd_ctx	*ctx;
@@ -109,6 +110,8 @@ struct vfio_pci_core_device {
 	struct vfio_device	vdev;
 	struct pci_dev		*pdev;
 	const struct vfio_pci_device_ops *pci_ops;
+	const struct vfio_cxl_ops *cxl_ops;
+	struct vfio_cxl_state   *cxl;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
 	/* Flags modified at runtime - dedicated storage unit */
-- 
2.25.1

