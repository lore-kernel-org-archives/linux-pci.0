Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67B43BDA1;
	Thu, 13 Aug 2026 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613935; cv=fail; b=JNUoiIcVGKtky7LUnwX3GOS/tBmoBs99cDBLjlfEZy1uWSGkTGfruKlM85Z1jxDLG0ILN+nw//bW3JVegjWF4Tu6UG7VJ9h+aSqv7wqItP6LzgAGb059gd5XctsaKvZ2M1pVIUhu1wetrf6BI5f0IVL3kVfeVIXDYXVplZ3oHV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613935; c=relaxed/simple;
	bh=9LlLSlHf1IcJuNoZLYuguFF/0H+u1JTiqZXyB+uzPbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbwrb8dVMCDVpoA36hdQeDRYV2Y5R2tRNDLbr3rESWQGhJ5IopqXi1/o0T03Z13JpjbDxrhXgYmy6pkzdGOAE48T33CDrFt5/ilHO6xOge4GpufW0dnk0/FFoNe7aYI+AZKbKlWJifDWCJNFNZ/4irPBJAQgwyXZN9pXpu9Jw/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Juzp3Lht; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Juzp3Lht"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEE8HA90crE0oAMFoG86o2NtzSnLpn2fuJbWpteo3p8lMlFOae9x8FnlR6SDWfFS9Rq3KzWRw13IUftOxZ3oJyGi7kbi/q5M06BQL6t3URAlNOMB10AxIVwedVQZqEwupZNd+lNhg856rYRWAYSdP9aUtY6rvbOkbWiGFhUKgALXPWRwB4QoT4y48ILsfODubeUtoDzswFm0KsrfU7fdfCPkyHnI8qNIlAgKQv1G1PR/qyxzeqx/IAxtpEIBYNYRTupp6CW7f6J721aACIHWY9Pk9r+QgxkaCaIpu05B9d7mxZKZNgEdieYF+bRFml50thwOlvCJjtkYoGfEV07akQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqCswmrL3uVTb60RkKl7dn2EJKpMbbuZIOq23/jiuD0=;
 b=DyzzRpxsFku15yq5TbTmCprJBJNU7EWsM1ydCHoj+OCJ/yYBE8Yr3AMbmn4UOMcJ7MY+lRpFdDziHFyYFDDoalmR+TZhUPRQP+qN3VEBzHxPMr1t1QtR9wKKDrILOX46Pxi/bpLAs/oo7fznxHns5IX91n4o4j2BvLEtb/6MBJIGHQ44F7eq2++y/jVsCzBl3zHiRDtazuW8DPt82XoHMxIQ85DU4aTcrudSfcbEw0pX/GAS/Wz80DmUQzCnE0K83wW3Ea8MoL0nyTs/7OEhKVCUlqBozNKgXFkBbZpgCArf22aU35UQITHIFeG8o65DKU6+5k/pqtwBVif3pfefDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqCswmrL3uVTb60RkKl7dn2EJKpMbbuZIOq23/jiuD0=;
 b=Juzp3LhtmTcC/M36HZZiziQWoD+v7ucQZpY3zXRYOQyUshQgOKnmQmvjl+UP7Ov+yCKtebisQFYbCnyiyZ/GkABkHk4PRXbdiOhdmbdZeUav9YnL8jYCrZXpjnnbkxb+7w0VRG4IqwjoTyaFk8H53JdFP+vVfuG4RE5wE66jIJdLH03IkJWj2XjLDnK0NQ16kRYqOhE56W15mEvLMAKKuKqo3PyI7shzQrt0KLS2A8hQ9EtHFNRQCSX24nJCFkTdI/v383kKsOAVQ/H8Hn0nQxWazxTezKg/4y+zarYhom2WXRkcHnkZdD7nuI3hPYQP+/QerkSG1u4yal01Snh7og==
Received: from BN9PR03CA0874.namprd03.prod.outlook.com (2603:10b6:408:13c::9)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:38:47 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::1) by BN9PR03CA0874.outlook.office365.com
 (2603:10b6:408:13c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Thu,
 13 Aug 2026 09:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:38:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:38:28 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:38:18 -0700
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
Subject: [PATCH v4 08/27] vfio/cxl: Add the vfio-cxl module skeleton
Date: Thu, 13 Aug 2026 15:06:12 +0530
Message-ID: <20260813093631.2288172-9-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: a11e3d30-1de0-4147-f705-08def91eac22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|1800799024|82310400026|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EFelLOK8JyfwoxrVRz00gyFinqOKMnwCC6zp9UdWD/HJssU1cJR6tunbnT4oxHZA3QNRFAQYVTMj4HK0Z2MebIt82llJLPX+NerNCSi95K4pcf3WkU0HSBqIxRdCy/GSiEbhOd3dR8GIa7vxKVO/a3sbcBgFLJY1i9gRUCjAaC1VV/Q5qIwOC7CBw+jsIqc3Xv1tFaH2lZ5ETkE13cBYefSrfOboXFjkjDRNdSIo2UUVbg+Zq5iCfPcBg3oDcV+yUqTaQmn7IU9KfwIaaipV4Zq2P5lbnpCr9hhA+6eb/WV8X94HdNhVjUykqjA9BHrM5SqbqLUW8W4zLA2vnIRvCHF+rbhfJP/4UPnSpGpTZXdQobNgBeLI/FBjYHxC1a4MIX1qNZ3yoIPsaSoichghwbmt2BMiw1HyFbdtIkLa+xSULSqJfF72Giwqyjmlw0H9BIFmPZHORNtoI3UXd5EvfgZuq0xfwgMucA+dqReKvfKuSuQyJkazqGlz7Rp78/ZoNbcmQ9u4uaNp0MHOuBfLnyxGq/ZZu2MT2qCCsryPWAU6+oi4pegRm6PGpnQj7OwGTWE09YIlw0k7pUoY50wqYh3NErxde/hja82WU5obZE52nQawubsZ1WZuD7SLXO+mhKieqkXN+xrs4SllSMztsuvsXOH+eM+ZqrAV+guhYxl8ST4aHNFXSvICuC1jM3NdF4TXf7P8QZFPLSsfmmDhb3N5AYPCp7/G2JLguYs6NEwiN4nuDb0UHURTc7xDr9H9
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nduZBd7fL8o1EIUoKZawvvs5wkDqary7BPLQSJYGLAOmXofRRRohzSdeV8QYwcDoRuaYst67VBdC5OkQ4hvxwIPxRsfmY+l8wi2uCcjt7pAMlWxZW2nPVHwfGafFDkDENedxd98cRXhVh5IGGvPROwKfuAMW5Q+60gIomu0eebP6I1cJ+23umtA5n2Lq6cBy/Rbwx/NexrkbsH760IzupYDaI7+b1pGifxfw0HtguPvfgA+P8ZJo9PpcbRqo3DZZyqs4Ppz+iwpUPL5isq7WhESp+NoxprjQI6DZ55L2laJzr59xLSFLetgdYYUtI2Fd7zN39UzFwZbVUKOoQh21ZGKwv3y8cc/ra55TozqFn5p3Oe3V9XrymPs7NCMqrkZ7BhekjMiVNXc078VZwMdlLG3XwgpIySd4gVxti+UZgNNHjYA/qpNQJISR8mhAE2Ff
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:38:46.3576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11e3d30-1de0-4147-f705-08def91eac22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953

From: Manish Honap <mhonap@nvidia.com>

Add the vfio-cxl module that vfio-pci loads on demand for CXL Type-2
devices. It registers a set of callbacks with vfio-pci-core at
module_init and drops them at exit; the callbacks are stubs here and
are filled in by later patches.

VFIO_CXL depends on CXL_BUS and builds as vfio-cxl.ko, which
request_module("vfio-cxl") resolves through MODULE_ALIAS.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                          |  7 +++++
 drivers/vfio/pci/Kconfig             |  2 ++
 drivers/vfio/pci/Makefile            |  2 ++
 drivers/vfio/pci/cxl/Kconfig         | 11 ++++++++
 drivers/vfio/pci/cxl/Makefile        |  3 ++
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 41 ++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+)
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/Makefile
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c665bf8f1a28..aa8cecbc4cf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28312,6 +28312,13 @@ L:	kvm@vger.kernel.org
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
index 296bf01e185e..c3f54fc8ccc0 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -70,6 +70,8 @@ source "drivers/vfio/pci/virtio/Kconfig"
 
 source "drivers/vfio/pci/nvgrace-gpu/Kconfig"
 
+source "drivers/vfio/pci/cxl/Kconfig"
+
 source "drivers/vfio/pci/qat/Kconfig"
 
 source "drivers/vfio/pci/xe/Kconfig"
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..c3031070a1f3 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -21,6 +21,8 @@ obj-$(CONFIG_VIRTIO_VFIO_PCI) += virtio/
 
 obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
 
+obj-$(CONFIG_VFIO_CXL) += cxl/
+
 obj-$(CONFIG_QAT_VFIO_PCI) += qat/
 
 obj-$(CONFIG_XE_VFIO_PCI) += xe/
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
index 000000000000..cbec7319452c
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -0,0 +1,41 @@
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
+static const struct vfio_cxl_ops vfio_cxl_ops = {
+	.init_device	= vfio_cxl_init_device,
+	.release_device	= vfio_cxl_release_device,
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
+MODULE_ALIAS("vfio-cxl");
-- 
2.25.1

