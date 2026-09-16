Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D934E3EF7;
	Wed, 16 Sep 2026 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583972; cv=fail; b=OpiAwD38+LVygtuWh/SEFGM6eylAOEsiEb0LAMI/Y4OFboQDCwgLcbMFO27mu3Db0yrhjmght2C7Livf6jAzNlJyAYmvzOvrOh7xcEp/n9bXnTwk1iEN4fixrckG55V8Auo/9UCfnZIhNFMjEzOuGAcF0jU8xKuOTWofBoohgr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583972; c=relaxed/simple;
	bh=s06+pRlDUUmztsb6flIcEwfmCO0TL3RCfirtOYh4FcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZhv77PNTCHbLNmc5HkikgBMD6zhNKaHDkv/6y1fa9AuHPGtiFVxADmP8fp/78xIKCa8zhG0QIuooTWC2fK711qbNm9ZftJxZ6vvSIxTjaq74TdOrgqJnWPZLD+HLpCO6jX5jRO+tmobsgzAjsLKfjHzpohtCqfmuSb2L8R7ef8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgdcV3Rt; arc=fail smtp.client-ip=40.107.208.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cgdcV3Rt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctUdayLpjvux6/B0HVuHnDV0sj4ptKKv5QBTIeMxmkkn93SOn5J4RYbV2AkxL7+FzM4kznGr09Lng6WIdy4V5kOz/HZ2ccTz1CDYAodhylIlp8f0B/kbEK0VROLWwjYGeE+1BCeFxSUMLRBhMi8nkXUiObra+y4c3Fm0kc51E2af8aP/Kb0DW432NXwZPAD1HoOesfkLOHTdYOzyYdYSW5p+nL4f5AKzTOvI4F7G8voJ+5JNqIs2pjDUMaa1WapuLywlC162Ahw5kNPPf1tzH0NBYSZdoNnJuYkiQsHiokMtTJfUaiBc0nijRzRmaqLlUo0QxVhqfDVeCgsLsBi1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruLempngwKALq7am/bTdeCTtYr6g6kc/d/5dIBi6rS8=;
 b=vuEGA1ualjWKOihW4fHcjd1couBZ0Td0/A9MhbaTMvUFZqod3hm75SdUGKJHFfDHmXbnsdN//LAmr9FGTjGVR00ih6g6Sk/BCQcSWPg6EBKlsz84dqj56NQO/7iRZXLm4W9JyaV4VnGBLhCpCLWkqz3nr89NxY8So4PbQNLD1N7ZyVRKiLCmEyBVnx0CgBK4L/Rlfb3YOaorf815HqTOKAxgVNPDrkg0wsAWMVzqH3vy1aWFGH10i6yZ64rYn0otMgAJ3Uzu3pJJVrfPgq/4f1x0vLPNChwcIAxSOZ/YJr+pqfU0dJ+cSVCrDneqKypc8sXZd7ZWGOlsHHjl8ESljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruLempngwKALq7am/bTdeCTtYr6g6kc/d/5dIBi6rS8=;
 b=cgdcV3Rt+wPfmksIVPQ268VRDyMTnhBR2fPxdrWRxJgeE9JPNqz5pFgYbMI1VFsanRWqrIvaLrRYLM+RRfnhFB9nGmsB0rJyQlxv6ebuBgMR0JTa00L7Zerh4FV4p/H8D70aBc0wt7HiOcSz1CVa1JXoQMu7Dt9XT8Hi8kI/S0+C+/dGnvkyvq4N2aJ3d0NqH1zaBYLFBxcdUgOLKPEMQw1r9NGpJKvYDr/7K3lQVoRpRX9/08+CllpaIoiyHVjWBuvF4x28PcZLVdJUM6St1A7p+Y25IMAfBgneH7MF0LIgH8hKUYHdsCqa/S6L9TTsqIoD04PShp7jap74Y5nSvw==
Received: from BN9PR03CA0717.namprd03.prod.outlook.com (2603:10b6:408:ef::32)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Wed, 16 Sep
 2026 18:38:55 +0000
Received: from BN6PEPF00000074.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::85) by BN9PR03CA0717.outlook.office365.com
 (2603:10b6:408:ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 18:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF00000074.mail.protection.outlook.com (10.167.248.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:38:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:38:26 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:38:16 -0700
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
Subject: [PATCH v5 15/27] vfio/cxl: Add the vfio-cxl provider module skeleton
Date: Thu, 17 Sep 2026 00:05:28 +0530
Message-ID: <20260916183540.3813685-16-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000074:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: ac668983-4a0f-423c-8331-08df1421c306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|18002099003|10067099003|11063799006|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	XAzImX213/fWb8Tq1p+4t08OQZHPnR3hGiZ/L7miqomquQIofD7tUH/AEXFi7nMudHTTSNS9cQjgx00+5MvOlMZy2iCG9FbH6wtNhGKRnmGWtUbU4zxcHcy+IXv7P3xNIkTQX3H/WY82s5FZqcsWSN7h7hGXeusawNMQDniGPrNhZRt045cE2NQp+H9cdyFbdQ06ywU3nR934457tGgDydLUebp2HT2BlK3+UWwS+HNJLsazVkIwdvtl+R0jPpOKB43ETr82ph2KjJDrt3vkXpQEApaMS26lm7Y1C0FzyzL3uJP+YqzD3XSMI+4E3+VAo7pvtq7sNQp4gmB0XjEiZ7hBT3WrPcHGgA1C3BEGYVYLyPPQrRZmUF5wJpm48HLmI8jG7sIl3IZ3GWsLwc0lTmFQ+jeU1798pQgUk45RZ6c5U4yxxrPJWRa80+tb2WCi6ya+fA93h6M4xlhmQ7uF86m+naqXVf4WXwykdyL+SVBZ72USwRcxyOWA3QoV3HuKvIeB5BvRSUglPGF+sfhEbK010LFuaOsqfb8y0iNH1iSeDH2HdWVy/0t2eiXPP4IQ8B7etnEhFAMywwF09Uid8juzgdJ4rSsxM5zOwNXLj93JBsFbG3i1uVdqs9FPQwXiZu1HER4PZcep553/pCgHmM6ZqNdQ4jwIoq/SruymYtaiVVxdcS1Ua8jUqJ3mJ+aUPPHHXxO5/sCt2hOgKDy92yX9PgdOMw2UrLleJanCehYoKYbVGIMYCzht4gPIQbg8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(18002099003)(10067099003)(11063799006)(22082099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lHUeC/e6Yc5Senceyn7NldTFqXY5YE9zEH+N++VBt/QJ/3CmBFWqxWO8WGpIlJiy1+aIlwgzgnNWUIiO5Uc53rCVIHz9e2BvDHdOCHwmL3P4etkUGukix4HpKCs2Qsd8AiIs/Lh4+vPchTgkQ8L81U/k2ThDFtl/wJRkesa8rFHIqZtZrLQlago5APa6WmAkA75xDsOMgFL3wC8EUh8m94w6lqkkXivhG03s5OA/VADEmaIzjR3YkiGKvisaz1s9NnQ/72klbq4QJia1ZyFd+eoGv/mYjkGZw/tQNGtikyoXWRKxgl2kdz8tuG4a561H98v6BQLtReivdytGExCwXHB+fCO3HLRWhU7KB2CNaZotKLTJL5UqASQ2lTDUG7lvziOv1JDQipJjjG0sRfRXnVjCw/7eOmMFM3tWHf2ucY0tN6A4JvfAp+XjjAk14Pj6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:38:54.6493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac668983-4a0f-423c-8331-08df1421c306
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000074.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

From: Manish Honap <mhonap@nvidia.com>

Add the vfio-cxl module that vfio-pci-core loads on demand for a CXL
Type-2 device, registering its callbacks at module_init.

vfio-cxl is a feature of vfio-pci-core rather than a variant driver, so
its Kconfig sources above the variant drivers and its objects link right
after vfio-pci-core while still being loaded on demand through the
vfio-cxl MODULE_ALIAS.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                          |  7 ++++
 drivers/vfio/pci/Kconfig             |  2 +
 drivers/vfio/pci/Makefile            |  2 +
 drivers/vfio/pci/cxl/Kconfig         | 11 +++++
 drivers/vfio/pci/cxl/Makefile        |  3 ++
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 61 ++++++++++++++++++++++++++++
 6 files changed, 86 insertions(+)
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/Makefile
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2037501cd621..75d472d7ca07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28639,6 +28639,13 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/cdx/*
 
+VFIO CXL DRIVER
+M:	Manish Honap <mhonap@nvidia.com>
+L:	kvm@vger.kernel.org
+L:	linux-cxl@vger.kernel.org
+S:	Supported
+F:	drivers/vfio/pci/cxl/
+
 VFIO DRIVER
 M:	Alex Williamson <alex@shazbot.org>
 L:	kvm@vger.kernel.org
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185e..4cd6acd36053 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -58,6 +58,8 @@ config VFIO_PCI_ZDEV_KVM
 config VFIO_PCI_DMABUF
 	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
 
+source "drivers/vfio/pci/cxl/Kconfig"
+
 source "drivers/vfio/pci/mlx5/Kconfig"
 
 source "drivers/vfio/pci/ism/Kconfig"
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..b65117d8d463 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -5,6 +5,8 @@ vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
+obj-$(CONFIG_VFIO_CXL) += cxl/
+
 vfio-pci-y := vfio_pci.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
diff --git a/drivers/vfio/pci/cxl/Kconfig b/drivers/vfio/pci/cxl/Kconfig
new file mode 100644
index 000000000000..1392fa4ed15d
--- /dev/null
+++ b/drivers/vfio/pci/cxl/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VFIO_CXL
+	tristate "VFIO support for CXL Type-2 devices"
+	depends on CXL_BUS && CXL_MEM
+	select VFIO_PCI_CORE
+	help
+	  Add CXL HDM handling to vfio-pci so a CXL Type-2 device, such as a
+	  CXL-attached accelerator, can be assigned to a virtual machine.
+	  vfio-pci loads this module on demand when it binds a CXL device.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/pci/cxl/Makefile b/drivers/vfio/pci/cxl/Makefile
new file mode 100644
index 000000000000..8501bf626108
--- /dev/null
+++ b/drivers/vfio/pci/cxl/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_VFIO_CXL) += vfio-cxl.o
+vfio-cxl-y := vfio_cxl_core.o
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
new file mode 100644
index 000000000000..cd5d41856404
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO support for CXL Type-2 devices.
+ *
+ * Copyright (c) 2026 NVIDIA Corporation & Affiliates
+ */
+
+#include <linux/module.h>
+#include <linux/vfio_pci_core.h>
+
+static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
+{
+	return 0;
+}
+
+static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
+{
+}
+
+static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
+{
+	return 0;
+}
+
+static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
+{
+}
+
+static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
+{
+}
+
+static void vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
+{
+}
+
+static const struct vfio_cxl_ops vfio_cxl_ops = {
+	.init		= vfio_cxl_init_device,
+	.release	= vfio_cxl_release_device,
+	.open_device	= vfio_cxl_open_device,
+	.close_device	= vfio_cxl_close_device,
+	.reset_prepare	= vfio_cxl_reset_prepare,
+	.reset_done	= vfio_cxl_reset_done,
+	.owner		= THIS_MODULE,
+};
+
+static int __init vfio_cxl_init(void)
+{
+	return vfio_pci_core_register_cxl_ops(&vfio_cxl_ops);
+}
+
+static void __exit vfio_cxl_exit(void)
+{
+	vfio_pci_core_unregister_cxl_ops(&vfio_cxl_ops);
+}
+
+module_init(vfio_cxl_init);
+module_exit(vfio_cxl_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
-- 
2.25.1

