Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6852B1E6;
	Fri, 16 Oct 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167736; cv=fail; b=Y+mZAlogp6GidLOjSDBy5Vu9/Qdv3iIwOuaQRVVotcRppr4NhjP2OMyk41Q12fF7VB3G7/fWSht9/LLqESnYN0INOvJmMAIQsMbdqsaZ3DTQNDaR+A0KIvlk/drN+qUo1gvB7o9rHs4CsFk681SzaxeYyExz0877dJvA/qCE+dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167736; c=relaxed/simple;
	bh=gUdHzNQzT0+YCBLzRZ5/KioDtXo6pfw+6ZLcvTeYD1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bK3+VvqtqERe9EUhYwvskxOAzIWSnmHG1EWZmYxEl0m0sOMIh8HF4einSsa0hUIhW2sLL/vaz1PAo/DrZLsQ66WcZuIJf1izo9fo51pke0ExWGyx8KXXpeRA3jFnXe6b/+HY1gfkv/UMzTPfLo11HkSO8y4M2ygV127xw2Eyswc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a6+uXv0F; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a6+uXv0F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uunx7VGjv7KKMl/Nvtr5ghoRbWekNnEzvu9xKhcB4EvTMRKNR44XtQzf45TypdW5drv1JHORD7cdF/0QhzqltEsWg8N2+VdIRFSzgYcwgDv5TbMMK4DGZ0aUHJgVJAMZ9f6Y+DBFMx89Ksy9JPyTb268VTiSL4Y5GHD+51gQ6STfEpKNxBcRRxe65DKuqhITE0za01uqxC1fhoFc37wHgLrjAmCYqLUgvXFOUTYrel4F/nVVCoymzrRNebeuRDOMY/0nWs6m7mNRfgDC28mlmb2uq/LJvxXPHGHMkN/NACM4zptSXK5QwmYGaG5mJyYS1H2rraaiTviNZKYo350pwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2ceYharjIhQRKTvFmfH9U76N4MqgQt9QUXY4vXHakU=;
 b=ZwgzyKHKgyWSZAodI35HqE9Px9LMzRr4CPN062SHwml0Mg5c7itNC4qKlQW5b3f0t6DOpFNOWZKEapiCbmnq//GcF3VMq43xif1oZfT3b5ufgGvWSnsA/HxvO9HYjLu6kvFfoqLZPDLV5KftYz6B1tF5+/wL3QNjwmeN7VB2sbvFWxmHP3zqUglPB69D5+4tdmLiv8tkzvx6No7PLv+VoE8geoebo1nN+5asbJM3HgGN6MguF5Z8FVES/iEqLYbip4CXVbTrUmXhym2OIiAO95S0Jq+PXYkNQQ3890mn02b8lSoK2Z/OcZc94fl+Yd0AZXxXrILztz3XLuFtEjgP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2ceYharjIhQRKTvFmfH9U76N4MqgQt9QUXY4vXHakU=;
 b=a6+uXv0FI7kqpaJj9wnagiXeu+EfTBgm09r+SDerbtJiJyq8rahrDKfLFOl9JpAZl4QJiO65t41R6/X5cuxFxhmi4+Mnl+cum4OW7wsqPdve2KuYj6wGeTyS9nvEuhjKwrJKKdcVEuyxb0IklnMxh/xo2T15jcUogXD7KP9DgmDXWUWpT1HHSx9+dx2SSYdt2h449OXWuMhD9qCFc2ty3frVEbMRzhYo+dJKBK1h21F4pV9xs5NADlQgzABQ0nqxj7t3Q8XP5KzXLPQCronRHPa2Wp7mPT2mAHDWEmNuNmf7omvwv/GzuPb81dqmJ8puV2LmUTCTJP/TVCBMYXweMQ==
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by SA5PPFB29794CA1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:22:09 +0000
Received: from CH01EPF000BE949.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::5f) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 16:22:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE949.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:22:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:21:44 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:21:35 -0700
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
Subject: [PATCH v6 18/31] vfio/cxl: Add the vfio-cxl provider module skeleton
Date: Fri, 16 Oct 2026 21:48:25 +0530
Message-ID: <20261016161839.2765592-19-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE949:EE_|SA5PPFB29794CA1:EE_
X-MS-Office365-Filtering-Correlation-Id: c858e635-91e0-49d2-1313-08df2ba1a044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|7416014|18002099003|10067099003|22082099003|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hbtJgqH6ZL4fROqMaEsQodSIePyo5ehArlcTBTpEqbhj6PPHUkRuomm/JjEBwH+VtO0eIeCTqCMCrDvDVMQ3xltqNAeB1Ul+gEwqveht55CkCCDzYasdCwUO2VXCzC8pmew5rBO4ooC1UJrB6KjTCGDWZURGjcJ9/FiI3JZj+Gn4CyaTOoyX/GxJtYqbAHuEFBKcUZQYYa321OVXa9z5BO4HSYFvGZVMdr09DKFD55wum4qGkHNzLWq9ziMBm0pdVEoqNcd9RUc/1RULrwbQkSXALiBd7sHt/HWh/39G4SAqh4EY9vL4cvfFAHxgvWKCnK9+TURuIWt4bgRqx5nE+Se2HBi4of56uUy0kaKEehI42+l09dUKUTMQstn0lZDQqVM0+ICSbGes6+lZ917YcMn6io0U7L8Uc90X0+esmOUhsrWTnl9hDmCHLR6b7eSRcz8uD/lgUsgkf6+QM2emMlCqlQGEcH9Sks5gDDZY48xLEBwonOfGj0SAldNZCdYA5iIcEjIW6dwADCiETOKvouhRZIG/a6J+0CpcGm8zPTw1mhkG9h17JmNFVIILTtO2Jwm48AaFra3+8Er0H38dtQeoFH0bW9M6mod1fp7NWhkDngS77jjL9kxlFojse2QB//u6FsnhS2Gwf73xjpND8s6pGNEu4YWfok5xLEMGeMv4A096bNmGyDw15SNPCM8AqOu3b8sI8bXRywOF1xeimWIHluS8rAkgIYmwTST3uqocFdFBWAVG0zLWlah2wsUF
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(7416014)(18002099003)(10067099003)(22082099003)(921020)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QsHVp1BAdLrCqHm8k9cEqZtIotavSgCDZCDqAlZjJhjNPtN2IBOnjK+f0yQ0uyrRkR7AY9UbKtDlRuaHn5PEVXgnr+kEEg4jmnYGbSy9UGR8ekWws3gNH9RCD7SB6wwojZdBxjKSNM7IC3AR2eRH996Zcg4kJe3ASMnrr5AeuQsnx7mlj0I9wj4xcfeQJTUiet2QJ/Kf5gdjn8RqARNf0RugulPXKIqECRMsr5U+SOIq66d7P/HQLGllXr10dFBeB9pfS8VLcbzLB1DXFSD5yXz7iYHZj3za65KO/CiNDxwkbrpbs/PKKeVrnafHz9x9AKnxuZ8CKfPydPdJQcGf9INPBwwjPVY6L94bgP9kFJCBuyWh2r1qHX8j6t/GM7CxhavjvRA+v/U9k0iaSUDKucFplAgrzienr/T+MvGWqi+KAq8IP4y9lufYoi75bblz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:22:08.6565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c858e635-91e0-49d2-1313-08df2ba1a044
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE949.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB29794CA1

From: Manish Honap <mhonap@nvidia.com>

Add the vfio-cxl module that vfio-pci-core loads on demand for a CXL
Type-2 device, registering its callbacks at module_init. Its reset op
runs the PCI core's reset methods until vfio-cxl serves the device
memory.

vfio-cxl is a feature of vfio-pci-core rather than a variant driver, so
its Kconfig sources above the variant drivers and its objects link right
after vfio-pci-core while still being loaded on demand:
request_module("vfio-cxl") finds it by module name.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                          |  7 +++
 drivers/vfio/pci/Kconfig             |  2 +
 drivers/vfio/pci/Makefile            |  2 +
 drivers/vfio/pci/cxl/Kconfig         | 11 ++++
 drivers/vfio/pci/cxl/Makefile        |  3 +
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 82 ++++++++++++++++++++++++++++
 6 files changed, 107 insertions(+)
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/Makefile
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c3aef3dce68c..8ac0a91ce647 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28636,6 +28636,13 @@ L:	kvm@vger.kernel.org
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
index 000000000000..ee49d68d689c
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO support for CXL Type-2 devices.
+ *
+ * Copyright (c) 2026 NVIDIA Corporation & Affiliates
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
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
+static int vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
+{
+	return 0;
+}
+
+/*
+ * Until vfio-cxl serves the device memory, reset through the PCI core's
+ * reset methods, which run CXL Reset ahead of FLR. Restore the PCI state
+ * here rather than through pci_reset_function_locked(): its reset_prepare
+ * and reset_done callbacks take memory_lock, which the caller already holds.
+ * The caller has saved the state, or on close loaded the open-time copy.
+ */
+static int vfio_cxl_reset(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int ret;
+
+	ret = __pci_reset_function_locked(pdev);
+	pci_restore_state(pdev);
+
+	return ret;
+}
+
+static const struct vfio_cxl_ops vfio_cxl_ops = {
+	.init		= vfio_cxl_init_device,
+	.release	= vfio_cxl_release_device,
+	.open_device	= vfio_cxl_open_device,
+	.close_device	= vfio_cxl_close_device,
+	.reset_prepare	= vfio_cxl_reset_prepare,
+	.reset_done	= vfio_cxl_reset_done,
+	.reset		= vfio_cxl_reset,
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
2.53.0

