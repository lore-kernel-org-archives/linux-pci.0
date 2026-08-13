Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918B448B85;
	Thu, 13 Aug 2026 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614121; cv=fail; b=MEp94LvLUVSIpKKxyvU2XcZFLvYQ2L/nf10nku15FaGEIc6Eb1RhMObekKSfNnNqTa6q6eS678Zm/yubKzjZJozXEAHmLag/UlNIdHxYvx7cGvCTYnnzwC/FUV0sFl72f71pyieeuIRcJBXavgwihnKH7rKDYpYqYpr0NQYVBpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614121; c=relaxed/simple;
	bh=J6dun6h3iVy+doDTpdaJ/8SpkzdmUWuGBfBlaqtdtWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNH2UC+Kqs5llh7BFU/kHNeskt4qHQn7uVOssjoaM6ZzQRdg+6RJVjC9v0mw5WAx8gFMq36/cVdLKt/vl2W3oTWF+l5onhdGI8++aD2bLJeh/K7Z32lqE/g0NFfeWtN3uztZnULoTuMzfB4zr9rqgEC0VAm4Yglgoo40EArCOUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SiY+Lo8g; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SiY+Lo8g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLSTgdN9tP5PV6Q2nePi32onltmRN+D2d9QpkFxDIct0GBC1UuNEN0kF2kHXdwg+medhaz2ALFWXITU6ePyIsxktLieXm7AhYF0raEhIv36J2SQJI2WjFElqh8k40ChSN/be6uEZigmV7D0Yzi1eZHh8MHY9ly2JCCYnNLyV1IKvKL/Np1nj/h+HQVa2IwWcPuIPcKJuUk/7takwgcXFe0Kc6nwuOYnqyJn24GdFVah7PtV267unNCLFHI0Oy4qf1y6LrYBFMALtyG1rY5n2SbhgiQQyRbgsxGIoWAPv7oHxIiI37KVrx57FWVq0Slk6hgvFl+FeYzDTNo994fB/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoWGEQIsRItxBW0kZrN7LSu8wqCfiE4NT63sgKg/ecs=;
 b=cNaj96KrcC1rSXtIObzk9QaLkUpqG84VjieOEY0XcehKyfKL4XcPtmIg0HVFJrEIKZ+jxjQ0pDBFnXhj2q4arsZA/gk3eE23cfKc5jIGYlkk14AcEZ0EzGuYadrTL1RccOiEGVeGVssV6UhiydaGYjlJ/eomRqpypOhQFW2kWp1RO0IpAyttbrZmAslrgMPJUcYb1Gs0hovw5qLQg0tPmCQ42qaTTRub8ny/HVgCqHyKTgomXPYu0d81WYhvVghP4yVyzJryZSy/bQkvcedaSYJbqf9nNEQdJhLDcSWbFykB2Rxm+3/cWA5xVOyTq2A6KufJeVL3bXJfXmXXWTwDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoWGEQIsRItxBW0kZrN7LSu8wqCfiE4NT63sgKg/ecs=;
 b=SiY+Lo8gNF9i3bklICZA5clSHNPcs2JTnYnPrJduY4bNnTPKzFPdBj7Ua+0WGe6pNJ+F2K/Tr8bOtV+ZQXb666PBFTQfsDCQWdRK7xskSLioXC1Gshn9vzGDw7coTzMLWfD0pL7xCSVRQjobWHxRvw/UjrGaQr/AL7TU5JYOsxAIoHLW3qy2wOMcWt1NRNU6t7ZB1sjg7o1AbAS2CoDjL+osStSpQpXYNIg5GgOtdVxbwXIkA9ycvd742fGmT3AFNGwHlHRRO57liHkq8wZJq1E/pwo4zOCMSClctNDVzD6vzPZ1mzkJTM0SAS0vR6fr9E79URLurhFUYNOSujrp2Q==
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 09:41:46 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::a7) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Thu, 13 Aug 2026 09:41:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:41:29 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:41:19 -0700
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
Subject: [PATCH v4 27/27] selftests/vfio: Add CXL Type-2 passthrough corner-case tests
Date: Thu, 13 Aug 2026 15:06:31 +0530
Message-ID: <20260813093631.2288172-28-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: b4eff44a-56db-459f-6f01-08def91f173d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|921020|6133799003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	It4cUNO0BFmp0XBF+V3Rhue9W6vZN1Vkl1sPlB1fuagG2WtBKc88twbFSL8/xd7BmrgGRH9SB1P9zgGcNQQ3iUIZ19wtVtGMn1D8/T9ZumcfoHNuVeYZbWVy/uGPzsEy9o0iokCIwsa0m557wIufmzwX67w92qK/OAnbpUiM09QaTNiNdNHeYAFPlNZZceOMCD9eswboD0kFm3Th1X/D+2mhCUTh9NiSMeqgXA3zsfZ9nBxmCW//apX4KcZ7kIiu6JYdketUJY/GJzbjUeq8WFB52D90CxhsP1SnmBFkXO9z3fZK8Ogq7CFmkpHlhTqjiar5WvXoS+Ams9hetRSySM378uHtMmsYZ0Yt/SCaA4EdWFUjlomzf0gei4H2B7W+2hX7KnqgY45qqmspcUE8DtO8egJSFw8X+bAAFzSDgdo735gAE3e72qtXvwDesZRsJ0FdaoYNP/2MOh6+XS6oZRBPt61QtZWfo/3KQXRi9qACKr8jvWeQrzCc/a8xn+810F6bgC5pM/hHOJ5eKVnjISwkcc4MHXOgrEaJm+PqSyjBjv8IH0+bLybBDdkniaseZwHgJ69Q+dncr/cJJWkzNrHuHuSkgHLkze/hG1g6eQvFPEAmlJSpOXcCug/K2IKSIzp3Yt4yeZQrK+Xw7X0D63vqvYkNXb62nGA2h3oyiU2TuEVNO4Y+VrSFkctVnbL9kEU/nHAVaE8bnu1l5bCDtBKJ6mj6mLnOQ141gJo6Wzem3EYYT1Fl+o4z7RYnfLw9
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wqYpSsm2ECQesvmao6Y5pema/1Ncs8EheAAi8thMRBD8nHIYsucrZ5nbEjO5lOaGIgZidy7LE2oiKf+bfkCAFtv8fWOIif+pcI0TDaSy1icmhRiv5snWwVqOwa6ne9FvoUZpeEDiAOF4MLHRpX5xLThgP35g7noG2cJxAEkUbCrs2EBuKp4eso8ttyhlFpme9uYDUYXVxIFja4fi3STODmhA6g5VyASjFIvFyb+dss2yIs/CDsR6UW8KI6xwo8EWiuUSMks3srIOXjCvVLjdMrqHLuEWq5AnastFi4/2v5yrRQonMus4cYj6GZgkzjniJjYHw1qQM+Wb/HinsAq6RCacENzN+S8uEhCU5+90uI2fd3FqcvdtB56Fed8HZqzpTsV4Dpa0JTmYHaKUF5bDz/ldb1L/OZMCLFVBeAdJ/eQtGzyJFFTLoeQaTL+1Rfb+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:41:46.0447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eff44a-56db-459f-6f01-08def91f173d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210

From: Manish Honap <mhonap@nvidia.com>

Exercise the vfio-cxl contract on a bound CXL Type-2 device: the two VFIO
regions and the geometry capability, the HDM memory mmap (including a 2 MB
huge fault), the dword-aligned trapped decoder block, and the
lock-on-commit FSM. The decoder writes land in the per-open shadow and
each test reopens the device, so the FSM tests repeat cleanly.

Cover the HDM memory two ways: a host-CPU load/store of the mmap, and the
path a VMM actually uses, mmap plus a stage-2 IOAS map for the device's
ATS access. The mmap flag is required for the IOAS path, so assert it is
advertised rather than skipping when it is absent.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  57 +-
 .../selftests/vfio/vfio_cxl_type2_test.c      | 799 ++++++++++++++++++
 4 files changed, 855 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b9361a8d618e..192b1681b3bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28319,6 +28319,7 @@ L:	linux-cxl@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/vfio-pci-cxl.rst
 F:	drivers/vfio/pci/cxl/
+F:	tools/testing/selftests/vfio/vfio_cxl_type2_test.c
 
 VFIO DRIVER
 M:	Alex Williamson <alex@shazbot.org>
diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..08f88e88cb4d 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
+TEST_GEN_PROGS += vfio_cxl_type2_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 94dc5fcecbeb..ab49b41653c4 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -160,9 +160,31 @@ static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
 	ioctl_assert(device->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 }
 
+/* Return the sparse-mmap capability in @info, or NULL if the region has none. */
+static struct vfio_region_info_cap_sparse_mmap *
+vfio_pci_sparse_mmap_cap(struct vfio_region_info *info)
+{
+	struct vfio_info_cap_header *hdr;
+	u32 offset;
+
+	if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS))
+		return NULL;
+
+	for (offset = info->cap_offset; offset; offset = hdr->next) {
+		hdr = (void *)info + offset;
+		if (hdr->id == VFIO_REGION_INFO_CAP_SPARSE_MMAP)
+			return (struct vfio_region_info_cap_sparse_mmap *)hdr;
+	}
+
+	return NULL;
+}
+
 static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
 {
 	struct vfio_pci_bar *bar = &device->bars[index];
+	struct vfio_region_info_cap_sparse_mmap *sparse;
+	u8 infobuf[1024] = {};
+	struct vfio_region_info *info = (void *)infobuf;
 	size_t align, size;
 	int prot = 0;
 	void *vaddr;
@@ -190,9 +212,38 @@ static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
 	align = min_t(size_t, size, SZ_1G);
 
 	vaddr = mmap_reserve(size, align, 0);
-	bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
-			  device->fd, bar->info.offset);
-	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
+
+	/*
+	 * A BAR that is only partially mmappable, such as a CXL Type-2 component
+	 * BAR with the HDM decoder block trapped, advertises the mmappable
+	 * ranges through a sparse-mmap capability. Map each area within the
+	 * reservation and leave the excluded ranges unmapped; mapping the whole
+	 * BAR would be rejected.
+	 */
+	info->argsz = sizeof(infobuf);
+	info->index = index;
+	ioctl_assert(device->fd, VFIO_DEVICE_GET_REGION_INFO, info);
+	sparse = vfio_pci_sparse_mmap_cap(info);
+	if (sparse) {
+		u32 i;
+
+		bar->vaddr = vaddr;
+		for (i = 0; i < sparse->nr_areas; i++) {
+			void *p;
+
+			if (!sparse->areas[i].size)
+				continue;
+			p = mmap(vaddr + sparse->areas[i].offset,
+				 sparse->areas[i].size, prot,
+				 MAP_SHARED | MAP_FIXED, device->fd,
+				 bar->info.offset + sparse->areas[i].offset);
+			VFIO_ASSERT_NE(p, MAP_FAILED);
+		}
+	} else {
+		bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
+				  device->fd, bar->info.offset);
+		VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
+	}
 
 	madvise(bar->vaddr, size, MADV_HUGEPAGE);
 }
diff --git a/tools/testing/selftests/vfio/vfio_cxl_type2_test.c b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
new file mode 100644
index 000000000000..8c23ddd014ca
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
@@ -0,0 +1,799 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vfio_cxl_type2_test - corner-case tests for the vfio-cxl kernel contract.
+ *
+ * Exercises the user-visible surface the vfio-cxl module adds to a CXL Type-2
+ * device: the two VFIO regions (HDM memory and the trapped HDM decoder block),
+ * the component-register geometry capability, and the lock-on-commit decoder
+ * FSM the kernel runs on the trapped block.
+ *
+ * Unlike a plain vfio-pci device the guest programs its own endpoint decoder,
+ * so the trapped block enforces the commit handshake and freezes a locked
+ * decoder. These tests drive that FSM directly. Writes to the decoder block
+ * land in the per-open kernel shadow only, never on the physical decoder, and
+ * each test reopens the device (fresh shadow), so the FSM tests are safe to
+ * repeat and do not leak state between tests.
+ *
+ * Usage: ./vfio_cxl_type2_test <BDF>  (or export VFIO_SELFTESTS_BDF=<BDF>).
+ * The device must be bound to vfio-pci with the vfio-cxl module available.
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.
+ */
+
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/pci_regs.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <cxl/cxl_regs.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+#define PCI_DVSEC_VENDOR_ID_CXL		0x1e98
+#define PCI_DVSEC_ID_CXL_DEVICE		0x0000
+
+/* CXL r3.1 8.1.9.1: Register Block Identifier for the component registers. */
+#define CXL_REGLOC_RBI_COMPONENT	1
+
+/*
+ * Register Locator DVSEC block-1 field masks. The uapi pci_regs.h names expand
+ * to __GENMASK(), which is not a macro in this userspace include path, so use
+ * explicit values.
+ */
+#define REG_LOCATOR_BIR_MASK		0x00000007
+#define REG_LOCATOR_BLOCK_ID_MASK	0x0000ff00
+#define REG_LOCATOR_BLOCK_OFF_LOW_MASK	0xffff0000
+
+/*
+ * vfio-pci's region-offset packing is kernel-internal (vfio_pci_core.h), not
+ * UAPI. Define it locally; the guards let a future kernel hoist it to UAPI.
+ */
+#ifndef VFIO_PCI_OFFSET_SHIFT
+#define VFIO_PCI_OFFSET_SHIFT		40
+#endif
+#ifndef VFIO_PCI_INDEX_TO_OFFSET
+#define VFIO_PCI_INDEX_TO_OFFSET(i)	((uint64_t)(i) << VFIO_PCI_OFFSET_SHIFT)
+#endif
+
+static const char *device_bdf;
+
+/* Locate a region-info capability by id inside a GET_REGION_INFO buffer. */
+static const struct vfio_info_cap_header *
+find_region_cap(const void *buf, size_t bufsz, uint16_t id)
+{
+	const struct vfio_region_info *ri = buf;
+	const struct vfio_info_cap_header *cap;
+	size_t off = ri->cap_offset;
+
+	while (off && off + sizeof(*cap) <= bufsz) {
+		cap = (const void *)((const char *)buf + off);
+		if (cap->id == id)
+			return cap;
+		off = cap->next;
+	}
+	return NULL;
+}
+
+/*
+ * Find a CXL region by scanning every region's VFIO_REGION_INFO_CAP_TYPE for
+ * the CXL type and the requested subtype. Returns the region index or -1.
+ * @buf is a caller scratch buffer left holding the matched region's info
+ * (with caps).
+ */
+static int find_cxl_region(int fd, uint32_t nregions, uint32_t subtype,
+			   void *buf, size_t bufsz)
+{
+	uint32_t i;
+
+	for (i = 0; i < nregions; i++) {
+		struct vfio_region_info *ri = buf;
+		const struct vfio_region_info_cap_type *t;
+		const struct vfio_info_cap_header *hdr;
+
+		memset(buf, 0, bufsz);
+		ri->argsz = bufsz;
+		ri->index = i;
+		if (ioctl(fd, VFIO_DEVICE_GET_REGION_INFO, ri))
+			continue;
+		if (!(ri->flags & VFIO_REGION_INFO_FLAG_CAPS))
+			continue;
+
+		hdr = find_region_cap(buf, bufsz, VFIO_REGION_INFO_CAP_TYPE);
+		if (!hdr)
+			continue;
+		t = (const void *)hdr;
+		if (t->type == VFIO_REGION_TYPE_CXL && t->subtype == subtype)
+			return i;
+	}
+	return -1;
+}
+
+/* Walk the PCI extended capability list for the CXL Device DVSEC. */
+static uint16_t find_cxl_dvsec(struct vfio_pci_device *dev)
+{
+	uint16_t pos = PCI_CFG_SPACE_SIZE;
+	int iter = 0;
+
+	while (pos && iter++ < 64) {
+		uint32_t hdr = vfio_pci_config_readl(dev, pos);
+		uint16_t cap_id = hdr & 0xffff;
+		uint16_t next = (hdr >> 20) & 0xffc;
+		uint32_t h1, h2;
+
+		if (cap_id == PCI_EXT_CAP_ID_DVSEC) {
+			h1 = vfio_pci_config_readl(dev, pos + 4);
+			h2 = vfio_pci_config_readl(dev, pos + 8);
+			if ((h1 & 0xffff) == PCI_DVSEC_VENDOR_ID_CXL &&
+			    (h2 & 0xffff) == PCI_DVSEC_ID_CXL_DEVICE)
+				return pos;
+		}
+		pos = next;
+	}
+	return 0;
+}
+
+FIXTURE(vfio_cxl) {
+	struct iommu *iommu;
+	struct vfio_pci_device *dev;
+
+	int mem_idx;
+	uint64_t mem_size;
+	uint32_t mem_flags;
+	int comp_idx;
+	uint64_t comp_size;
+	uint32_t comp_bar;
+	uint64_t comp_offset;	/* HDM block offset within comp_bar */
+	uint64_t comp_off;	/* mmap/rw base offset of the comp region */
+	uint16_t dvsec;
+};
+
+FIXTURE_SETUP(vfio_cxl)
+{
+	uint8_t infobuf[512] = {};
+	struct vfio_device_info *info = (void *)infobuf;
+	const struct vfio_region_info_cap_cxl_comp_regs *geo;
+	const struct vfio_info_cap_header *hdr;
+	uint8_t rbuf[1024];
+
+	self->iommu = iommu_init(default_iommu_mode);
+	self->dev = vfio_pci_device_init(device_bdf, self->iommu);
+
+	info->argsz = sizeof(infobuf);
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_INFO, info));
+
+	if (!(info->flags & VFIO_DEVICE_FLAGS_CXL))
+		SKIP(return, "not a CXL Type-2 device");
+
+	self->mem_idx = find_cxl_region(self->dev->fd, info->num_regions,
+					VFIO_REGION_SUBTYPE_CXL_MEM,
+					rbuf, sizeof(rbuf));
+	ASSERT_GE(self->mem_idx, 0);
+	self->mem_size = ((struct vfio_region_info *)rbuf)->size;
+	self->mem_flags = ((struct vfio_region_info *)rbuf)->flags;
+
+	self->comp_idx = find_cxl_region(self->dev->fd, info->num_regions,
+					 VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+					 rbuf, sizeof(rbuf));
+	ASSERT_GE(self->comp_idx, 0);
+	self->comp_size = ((struct vfio_region_info *)rbuf)->size;
+
+	/* The geometry cap rides on the component-register region. */
+	hdr = find_region_cap(rbuf, sizeof(rbuf),
+			      VFIO_REGION_INFO_CAP_CXL_COMP_REGS);
+	ASSERT_NE(NULL, hdr);
+	geo = (const void *)hdr;
+	self->comp_bar = geo->bar;
+	self->comp_offset = geo->offset;
+
+	self->comp_off = VFIO_PCI_INDEX_TO_OFFSET(self->comp_idx);
+	self->dvsec = find_cxl_dvsec(self->dev);
+}
+
+FIXTURE_TEARDOWN(vfio_cxl)
+{
+	vfio_pci_device_cleanup(self->dev);
+	iommu_cleanup(self->iommu);
+}
+
+/* GET_INFO advertises the flag and both CXL regions with a sane geometry cap. */
+TEST_F(vfio_cxl, device_is_cxl)
+{
+	ASSERT_NE(self->mem_idx, self->comp_idx);
+	ASSERT_GT(self->mem_size, 0);
+	ASSERT_GT(self->comp_size, 0);
+	ASSERT_LT(self->comp_bar, PCI_STD_NUM_BARS);
+	/* The HDM memory must advertise mmap; a VMM needs it for stage-2. */
+	ASSERT_NE(0, self->mem_flags & VFIO_REGION_INFO_FLAG_MMAP);
+}
+
+/*
+ * The component BAR carries the physical HDM decoder block, which vfio traps
+ * and excludes from mmap so the guest cannot reprogram it directly. Mapping the
+ * whole BAR must fail; mapping the ranges around the excluded block, as the
+ * sparse-mmap capability advertises, must succeed.
+ */
+TEST_F(vfio_cxl, comp_bar_sparse_mmap)
+{
+	size_t page_size = getpagesize();
+	uint8_t rbuf[1024] = {};
+	struct vfio_region_info *ri = (void *)rbuf;
+	const struct vfio_region_info_cap_sparse_mmap *sm;
+	const struct vfio_info_cap_header *hdr;
+	uint64_t bar_off, decoder_page;
+	void *map;
+	uint32_t i;
+
+	/* Region info for the component BAR, with capabilities. */
+	ri->argsz = sizeof(rbuf);
+	ri->index = self->comp_bar;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, ri));
+	ASSERT_NE(0, ri->flags & VFIO_REGION_INFO_FLAG_MMAP);
+	bar_off = ri->offset;
+
+	/* The trapped decoder block splits the BAR, so it must be sparse. */
+	hdr = find_region_cap(rbuf, sizeof(rbuf),
+			      VFIO_REGION_INFO_CAP_SPARSE_MMAP);
+	ASSERT_NE(NULL, hdr);
+	sm = (const void *)hdr;
+	ASSERT_GT(sm->nr_areas, 0);
+
+	/* Mapping the whole BAR must fail: it covers the excluded block. */
+	map = mmap(NULL, ri->size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, bar_off);
+	ASSERT_EQ(MAP_FAILED, map);
+
+	/* Every advertised area is page aligned and must map. */
+	for (i = 0; i < sm->nr_areas; i++) {
+		uint64_t ao = sm->areas[i].offset;
+		uint64_t as = sm->areas[i].size;
+
+		if (!as)
+			continue;
+		ASSERT_EQ(0, ao & (page_size - 1));
+		ASSERT_EQ(0, as & (page_size - 1));
+
+		map = mmap(NULL, as, PROT_READ | PROT_WRITE, MAP_SHARED,
+			   self->dev->fd, bar_off + ao);
+		ASSERT_NE(MAP_FAILED, map);
+		ASSERT_EQ(0, munmap(map, as));
+	}
+
+	/* The page holding the decoder block must never be mmappable. */
+	decoder_page = self->comp_offset & ~(uint64_t)(page_size - 1);
+	map = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, bar_off + decoder_page);
+	ASSERT_EQ(MAP_FAILED, map);
+}
+
+/* mmap one page of the HDM memory, write a pattern, read it back. */
+TEST_F(vfio_cxl, hdm_mem_mmap_rw)
+{
+	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
+	uint32_t pattern = 0xdeadbeefU, readback = 0;
+	void *map;
+
+	if (self->mem_size < SZ_4K)
+		SKIP(return, "HDM memory < 4K");
+
+	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, off);
+	ASSERT_NE(MAP_FAILED, map);
+
+	memcpy(map, &pattern, sizeof(pattern));
+	memcpy(&readback, map, sizeof(readback));
+	ASSERT_EQ(pattern, readback);
+
+	ASSERT_EQ(0, munmap(map, SZ_4K));
+}
+
+/*
+ * A 2 MB-aligned window should map as a huge (PMD) fault. The kernel falls back
+ * to base pages when it cannot, so only correctness (write/read) is asserted.
+ */
+TEST_F(vfio_cxl, hdm_mem_huge_mmap)
+{
+	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
+	uint32_t pattern = 0x5a5a5a5aU, readback = 0;
+	void *map, *last;
+
+	if (self->mem_size < SZ_2M)
+		SKIP(return, "HDM memory < 2M");
+
+	map = mmap(NULL, SZ_2M, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, off);
+	ASSERT_NE(MAP_FAILED, map);
+
+	/* Touch the last dword so a 2 MB PMD fault covers the whole window. */
+	last = (char *)map + SZ_2M - sizeof(pattern);
+	memcpy(last, &pattern, sizeof(pattern));
+	memcpy(&readback, last, sizeof(readback));
+	ASSERT_EQ(pattern, readback);
+
+	ASSERT_EQ(0, munmap(map, SZ_2M));
+}
+
+/*
+ * A guest driver disables and re-enables PCI Memory-Space during init and
+ * reset. The committed HDM decoder stays valid across that toggle, so once
+ * Memory-Space is re-enabled the coherent HDM memory must be reachable again
+ * without a reset. This is the regression test for the hdm_valid access gate
+ * being cleared by a Memory-Space disable and never restored, which left a
+ * later valid mmap fault wrongly SIGBUS-ing.
+ *
+ * The region is exercised only through the mmap path (as a VMM does) and only
+ * while Memory-Space is enabled. An access with Memory-Space disabled aborts
+ * on the fabric as a fatal host error, so the test never attempts one: the
+ * toggle in between is pure config-space writes.
+ */
+TEST_F(vfio_cxl, hdm_mem_survives_mem_space_toggle)
+{
+	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
+	uint32_t pattern = 0x12345678U, readback = 0;
+	uint16_t cmd;
+	void *map;
+
+	if (self->mem_size < SZ_4K)
+		SKIP(return, "HDM memory < 4K");
+
+	/* Seed a known pattern through the mmap path with Memory-Space on. */
+	cmd = vfio_pci_config_readw(self->dev, PCI_COMMAND);
+	vfio_pci_config_writew(self->dev, PCI_COMMAND,
+			       cmd | PCI_COMMAND_MEMORY);
+	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, off);
+	ASSERT_NE(MAP_FAILED, map);
+	memcpy(map, &pattern, sizeof(pattern));
+	ASSERT_EQ(0, munmap(map, SZ_4K));
+
+	/*
+	 * Toggle Memory-Space off and back on with no HDM access in between,
+	 * as a guest driver does during init/reset.
+	 */
+	vfio_pci_config_writew(self->dev, PCI_COMMAND,
+			       cmd & ~PCI_COMMAND_MEMORY);
+	vfio_pci_config_writew(self->dev, PCI_COMMAND,
+			       cmd | PCI_COMMAND_MEMORY);
+
+	/*
+	 * The committed decoder stayed valid across the toggle, so a fresh mmap
+	 * fault succeeds and the seeded pattern reads back, without a reset.
+	 * Before the fix the gate was cleared by the disable and never restored,
+	 * so the fault wrongly SIGBUS-ed.
+	 */
+	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, off);
+	ASSERT_NE(MAP_FAILED, map);
+	memcpy(&readback, map, sizeof(readback));
+	ASSERT_EQ(pattern, readback);
+	ASSERT_EQ(0, munmap(map, SZ_4K));
+
+	/* Restore PCI_COMMAND. */
+	vfio_pci_config_writew(self->dev, PCI_COMMAND, cmd);
+}
+
+/*
+ * Mirror how a VMM uses the region: mmap the HDM memory and map it into the
+ * IOAS (stage-2) so the device can reach it over ATS. The mmap flag is required
+ * for that path, so its absence is a failure, not a skip. The host CPU does not
+ * dereference the mapping; the guest reaches it through stage-2.
+ */
+TEST_F(vfio_cxl, hdm_mem_ioas_map)
+{
+	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
+	struct iova_allocator *iova_alloc;
+	struct dma_region region;
+	void *map;
+
+	ASSERT_NE(0, self->mem_flags & VFIO_REGION_INFO_FLAG_MMAP);
+
+	/* iova_allocator_alloc() requires a power-of-2 size. */
+	if (self->mem_size < SZ_2M)
+		SKIP(return, "HDM memory < 2M");
+
+	map = mmap(NULL, SZ_2M, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, off);
+	ASSERT_NE(MAP_FAILED, map);
+
+	iova_alloc = iova_allocator_init(self->iommu);
+	region.vaddr = map;
+	region.size = SZ_2M;
+	region.iova = iova_allocator_alloc(iova_alloc, SZ_2M);
+
+	iommu_map(self->iommu, &region);
+	iommu_unmap(self->iommu, &region);
+
+	iova_allocator_cleanup(iova_alloc);
+	ASSERT_EQ(0, munmap(map, SZ_2M));
+}
+
+/* The trapped block starts at the HDM decoder registers; CTRL 0 reads back. */
+TEST_F(vfio_cxl, comp_regs_hdm_read)
+{
+	uint64_t ctrl = self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	uint32_t val = 0;
+
+	ASSERT_GE(self->comp_size, CXL_HDM_DECODER0_CTRL_OFFSET(0) + 4);
+	ASSERT_EQ((ssize_t)sizeof(val),
+		  pread(self->dev->fd, &val, sizeof(val), ctrl));
+}
+
+/* The decoder registers only take aligned dword accesses. */
+TEST_F(vfio_cxl, comp_regs_reject_unaligned)
+{
+	uint32_t val = 0;
+	uint16_t half = 0;
+
+	/* Unaligned offset. */
+	ASSERT_EQ(-1, pread(self->dev->fd, &val, sizeof(val),
+			    self->comp_off + 1));
+	/* Non-dword size. */
+	ASSERT_EQ(-1, pread(self->dev->fd, &half, sizeof(half),
+			    self->comp_off));
+}
+
+/* Accesses past the region end are rejected. */
+TEST_F(vfio_cxl, comp_regs_reject_out_of_range)
+{
+	uint32_t val = 0;
+
+	ASSERT_EQ(-1, pread(self->dev->fd, &val, sizeof(val),
+			    self->comp_off + self->comp_size));
+}
+
+/*
+ * Commit handshake. This series supports only a firmware committed+locked
+ * decoder, which is the state the device boots in: the host resolved the HPA
+ * before the guest saw the device, so the guest view is frozen until a reset
+ * and a decommit request is ignored. If a decoder is ever seen uncommitted, the
+ * shadow FSM instead lets a commit request reach COMMITTED and a clear tear it
+ * back down; assert whichever contract applies to the decoder's actual state.
+ */
+TEST_F(vfio_cxl, hdm_commit_fsm)
+{
+	uint64_t ctrl = self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	uint32_t v, orig;
+
+	ASSERT_EQ((ssize_t)sizeof(orig),
+		  pread(self->dev->fd, &orig, sizeof(orig), ctrl));
+
+	if ((orig & CXL_HDM_DECODER0_CTRL_COMMITTED) &&
+	    (orig & CXL_HDM_DECODER0_CTRL_LOCK)) {
+		/* Committed+locked: a decommit request must be ignored. */
+		v = orig & ~CXL_HDM_DECODER0_CTRL_COMMIT;
+		ASSERT_EQ((ssize_t)sizeof(v),
+			  pwrite(self->dev->fd, &v, sizeof(v), ctrl));
+		ASSERT_EQ((ssize_t)sizeof(v),
+			  pread(self->dev->fd, &v, sizeof(v), ctrl));
+		ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_COMMITTED);
+		return;
+	}
+
+	/* Uncommitted: the commit handshake round-trips through the shadow. */
+	v = orig | CXL_HDM_DECODER0_CTRL_COMMIT;
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pwrite(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pread(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_COMMITTED);
+
+	v &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pwrite(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pread(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_FALSE(v & CXL_HDM_DECODER0_CTRL_COMMITTED);
+}
+
+/*
+ * Lock on commit: a decoder committed with LOCK set is frozen until reset, so
+ * a later attempt to clear COMMIT is ignored. The freeze lives in the per-open
+ * shadow, so the next test's reopen starts clean.
+ */
+TEST_F(vfio_cxl, hdm_lock_on_commit)
+{
+	uint64_t ctrl = self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	uint32_t v;
+
+	v = CXL_HDM_DECODER0_CTRL_COMMIT | CXL_HDM_DECODER0_CTRL_LOCK;
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pwrite(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pread(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_LOCK);
+
+	/* Attempt to decommit the locked decoder; it must stay committed. */
+	v = 0;
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pwrite(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pread(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_LOCK);
+}
+
+/*
+ * A base written to the trapped block round-trips through the shadow only while
+ * the decoder is uncommitted. In the supported production state the decoder is
+ * already committed, so its base is read-only and the write is ignored; assert
+ * whichever contract applies to the decoder's actual state.
+ */
+TEST_F(vfio_cxl, hdm_base_shadow_roundtrip)
+{
+	uint64_t lo_off = self->comp_off + CXL_HDM_DECODER0_BASE_LOW_OFFSET(0);
+	uint64_t ctrl_off = self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	uint32_t v = 0x30000000U;	/* 256 MB-aligned low base bits */
+	uint32_t rb = 0, orig = 0, ctrl = 0;
+
+	ASSERT_GE(self->comp_size, CXL_HDM_DECODER0_BASE_LOW_OFFSET(0) + 4);
+	ASSERT_EQ((ssize_t)sizeof(ctrl),
+		  pread(self->dev->fd, &ctrl, sizeof(ctrl), ctrl_off));
+	ASSERT_EQ((ssize_t)sizeof(orig),
+		  pread(self->dev->fd, &orig, sizeof(orig), lo_off));
+
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pwrite(self->dev->fd, &v, sizeof(v), lo_off));
+	ASSERT_EQ((ssize_t)sizeof(rb),
+		  pread(self->dev->fd, &rb, sizeof(rb), lo_off));
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+		/* Committed decoder holds its base read-only; write ignored. */
+		ASSERT_EQ(orig, rb);
+	} else {
+		/* Uncommitted decoder accepts the base into the shadow. */
+		ASSERT_EQ(v, rb);
+	}
+}
+
+/*
+ * The CXL Device DVSEC body is virtualized by the kernel; a config read of it
+ * is served from the shadow (no SIGBUS / -EIO). The value itself is
+ * firmware-dependent, so only success is asserted.
+ */
+TEST_F(vfio_cxl, dvsec_body_read)
+{
+	uint32_t v;
+
+	if (!self->dvsec)
+		SKIP(return, "CXL Device DVSEC not found");
+
+	v = vfio_pci_config_readl(self->dev, self->dvsec + PCI_DVSEC_HEADER1);
+	ASSERT_NE(0xffffffffU, v);
+}
+
+/*
+ * Guest-initiated CXL reset: a 0->1 write of Initiate_CXL_Reset in the DVSEC
+ * asks the kernel to run the reset sequence. The bit self-clears and STATUS2
+ * reports the outcome. This is the path a guest drives through QEMU, so the
+ * kernel must complete it and report RESET_COMPLETE, not RESET_ERROR.
+ */
+TEST_F(vfio_cxl, guest_cxl_reset)
+{
+	uint16_t cap, ctrl2, status2;
+
+	if (!self->dvsec)
+		SKIP(return, "CXL Device DVSEC not found");
+
+	cap = vfio_pci_config_readw(self->dev, self->dvsec + PCI_DVSEC_CXL_CAP);
+	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
+		SKIP(return, "device does not support CXL reset");
+
+	/* Request the reset through the control register. */
+	ctrl2 = vfio_pci_config_readw(self->dev,
+				      self->dvsec + PCI_DVSEC_CXL_CTRL2);
+	vfio_pci_config_writew(self->dev, self->dvsec + PCI_DVSEC_CXL_CTRL2,
+			       ctrl2 | PCI_DVSEC_CXL_INIT_CXL_RST);
+
+	/* Initiate_CXL_Reset self-clears once the sequence has run. */
+	ctrl2 = vfio_pci_config_readw(self->dev,
+				      self->dvsec + PCI_DVSEC_CXL_CTRL2);
+	ASSERT_FALSE(ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST);
+
+	/* STATUS2 reports the outcome; a completed reset sets RESET_COMPLETE. */
+	status2 = vfio_pci_config_readw(self->dev,
+					self->dvsec + PCI_DVSEC_CXL_STATUS2);
+	ASSERT_TRUE(status2 & PCI_DVSEC_CXL_RST_DONE);
+	ASSERT_FALSE(status2 & PCI_DVSEC_CXL_RST_ERR);
+}
+
+/*
+ * The component BAR is reachable by fd read everywhere except the trapped
+ * decoder block, which is served only through the comp-regs region. A VMM
+ * relies on this split when it forwards accesses that land in the excluded
+ * mmap page: non-decoder bytes go to the BAR, the decoder goes to the trap.
+ */
+TEST_F(vfio_cxl, comp_bar_rdwr_split)
+{
+	uint64_t bar_off = VFIO_PCI_INDEX_TO_OFFSET(self->comp_bar);
+	uint32_t val;
+
+	/* A non-decoder dword of the BAR reads back through the fd. */
+	ASSERT_EQ((ssize_t)sizeof(val),
+		  pread(self->dev->fd, &val, sizeof(val), bar_off));
+
+	/* The trapped decoder block is off-limits to raw BAR fd access. */
+	ASSERT_EQ(-1, pread(self->dev->fd, &val, sizeof(val),
+			    bar_off + self->comp_offset));
+}
+
+/*
+ * Mirror the guest's HDM discovery: a guest does NOT use VFIO's geometry cap.
+ * It finds the CXL Register Locator DVSEC in config space, takes the component
+ * BAR and offset from it, walks the component-register capability array over
+ * the BAR to locate the HDM decoder, then reads decoder 0's base/size/ctrl and
+ * derives the memory range from a committed decoder.
+ */
+TEST_F(vfio_cxl, guest_hdm_discovery)
+{
+	uint64_t bar_off = VFIO_PCI_INDEX_TO_OFFSET(self->comp_bar);
+	uint32_t reg_lo, reg_hi, cap_array, cap_count, hdr;
+	uint32_t bl, bh, sl, sh, ctrl;
+	uint64_t block_off, cm, hdm_off = 0, base, size;
+	uint16_t pos = PCI_CFG_SPACE_SIZE, regloc = 0, block1;
+	int iter = 0, bar, i;
+
+	/* 1. Find the CXL Register Locator DVSEC in config space. */
+	while (pos && iter++ < 64) {
+		uint32_t h = vfio_pci_config_readl(self->dev, pos);
+
+		if ((h & 0xffff) == PCI_EXT_CAP_ID_DVSEC) {
+			uint32_t h1 = vfio_pci_config_readl(self->dev, pos + 4);
+			uint32_t h2 = vfio_pci_config_readl(self->dev, pos + 8);
+
+			if ((h1 & 0xffff) == PCI_DVSEC_VENDOR_ID_CXL &&
+			    (h2 & 0xffff) == PCI_DVSEC_CXL_REG_LOCATOR) {
+				regloc = pos;
+				break;
+			}
+		}
+		pos = (h >> 20) & 0xffc;
+	}
+	ASSERT_NE(0, regloc);
+
+	/* 2. Take the component register block BAR and offset from block 1. */
+	block1 = regloc + PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1;
+	reg_lo = vfio_pci_config_readl(self->dev, block1);
+	reg_hi = vfio_pci_config_readl(self->dev, block1 + 4);
+
+	ASSERT_EQ(CXL_REGLOC_RBI_COMPONENT,
+		  (reg_lo & REG_LOCATOR_BLOCK_ID_MASK) >> 8);
+	bar = reg_lo & REG_LOCATOR_BIR_MASK;
+	block_off = ((uint64_t)reg_hi << 32) |
+		    (reg_lo & REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+
+	/* The DVSEC must name the same BAR the geometry cap reported. */
+	ASSERT_EQ(self->comp_bar, bar);
+
+	/* 3. Walk the CM capability array over the BAR to find the HDM cap. */
+	cm = block_off + CXL_CM_OFFSET;
+	ASSERT_EQ((ssize_t)sizeof(cap_array),
+		  pread(self->dev->fd, &cap_array, sizeof(cap_array),
+			bar_off + cm + CXL_CM_CAP_HDR_OFFSET));
+	ASSERT_EQ(CM_CAP_HDR_CAP_ID, cap_array & CXL_CM_CAP_HDR_ID_MASK);
+
+	cap_count = (cap_array & CXL_CM_CAP_HDR_ARRAY_SIZE_MASK) >> 24;
+	for (i = 1; i <= (int)cap_count; i++) {
+		ASSERT_EQ((ssize_t)sizeof(hdr),
+			  pread(self->dev->fd, &hdr, sizeof(hdr),
+				bar_off + cm + i * 4));
+		if ((hdr & CXL_CM_CAP_HDR_ID_MASK) == CXL_CM_CAP_CAP_ID_HDM) {
+			hdm_off = cm + ((hdr & CXL_CM_CAP_PTR_MASK) >> 20);
+			break;
+		}
+	}
+	ASSERT_NE(0, hdm_off);
+
+	/* The guest's manual walk must land on the decoder the kernel traps. */
+	ASSERT_EQ(self->comp_offset, hdm_off);
+
+	/* 4. Read decoder 0 through the trapped region and derive base/size. */
+	ASSERT_EQ((ssize_t)sizeof(bl),
+		  pread(self->dev->fd, &bl, sizeof(bl),
+			self->comp_off + CXL_HDM_DECODER0_BASE_LOW_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(bh),
+		  pread(self->dev->fd, &bh, sizeof(bh),
+			self->comp_off + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(sl),
+		  pread(self->dev->fd, &sl, sizeof(sl),
+			self->comp_off + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(sh),
+		  pread(self->dev->fd, &sh, sizeof(sh),
+			self->comp_off + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(ctrl),
+		  pread(self->dev->fd, &ctrl, sizeof(ctrl),
+			self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0)));
+
+	base = ((uint64_t)bh << 32) | bl;
+	size = ((uint64_t)sh << 32) | sl;
+
+	/*
+	 * A guest only accepts a committed decoder. When firmware left decoder 0
+	 * committed the derived range must be non-empty; the base is read to
+	 * mirror the driver even though its value is firmware-defined.
+	 */
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		SKIP(return, "HDM decoder 0 not committed by firmware");
+
+	ASSERT_GT(size, 0);
+	ASSERT_LT(base, base + size);
+}
+
+/*
+ * Tie the committed decoder's advertised geometry to the HDM memory region a
+ * VMM hands the guest. Read decoder 0's base and size through the trapped
+ * region, confirm the mmap-able region covers exactly that range, then map the
+ * advertised base and touch it. A region that advertises the decoder but maps
+ * PROT_NONE (missing READ/WRITE flags) or a size that disagrees with the
+ * decoder passes discovery yet faults the guest on first access; catch that
+ * here instead of on hardware.
+ */
+TEST_F(vfio_cxl, hdm_mem_touch_committed_base)
+{
+	uint64_t mem_off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
+	uint32_t pattern = 0xc0ffee11U, readback = 0;
+	uint32_t bl, bh, sl, sh, ctrl;
+	uint64_t base, size;
+	void *map;
+
+	ASSERT_EQ((ssize_t)sizeof(ctrl),
+		  pread(self->dev->fd, &ctrl, sizeof(ctrl),
+			self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0)));
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		SKIP(return, "HDM decoder 0 not committed by firmware");
+
+	ASSERT_EQ((ssize_t)sizeof(bl),
+		  pread(self->dev->fd, &bl, sizeof(bl),
+			self->comp_off + CXL_HDM_DECODER0_BASE_LOW_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(bh),
+		  pread(self->dev->fd, &bh, sizeof(bh),
+			self->comp_off + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(sl),
+		  pread(self->dev->fd, &sl, sizeof(sl),
+			self->comp_off + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(sh),
+		  pread(self->dev->fd, &sh, sizeof(sh),
+			self->comp_off + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(0)));
+
+	base = ((uint64_t)bh << 32) | bl;
+	size = ((uint64_t)sh << 32) | sl;
+
+	ASSERT_GT(size, 0);
+	ASSERT_LT(base, base + size);
+	/* The mmap-able HDM region must cover exactly the committed decoder. */
+	ASSERT_EQ(size, self->mem_size);
+
+	if (self->mem_size < SZ_4K)
+		SKIP(return, "HDM memory < 4K");
+
+	/*
+	 * Region offset 0 is the decoder's advertised base. Map it read/write and
+	 * touch it: a PROT_NONE mapping (region missing READ/WRITE flags) faults
+	 * here rather than round-tripping the pattern.
+	 */
+	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, mem_off);
+	ASSERT_NE(MAP_FAILED, map);
+
+	memcpy(map, &pattern, sizeof(pattern));
+	memcpy(&readback, map, sizeof(readback));
+	ASSERT_EQ(pattern, readback);
+
+	ASSERT_EQ(0, munmap(map, SZ_4K));
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.25.1

