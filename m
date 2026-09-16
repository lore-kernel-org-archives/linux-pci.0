Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D353359D;
	Wed, 16 Sep 2026 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583853; cv=fail; b=Xx7A9PWLf0HQz5lRXZmpz6xByGrbrXooa5AnHN79vmxTDhUTrtMXltkr8Kt3bPtSpNZa1qkOWVDv64qTGnte2sZG3QJevuBFqPIS0erzw2+fh6l4tjQo23nE076L6wa3Ip5wcjFuM0ENqBd+YOP5E+lrnVBsSycgjUKo4KeMkFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583853; c=relaxed/simple;
	bh=wDibT8Zt7Clfflbj1V7Cs5lzsCMBCdWd6zTAmayEQqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNiq7hk6ID2bvLA1BeF/x6B4Kfnau1NSYMWMDc02VfoD27AQqxR/OZ4u0UUX8X8y0/NyhYy9Qcl9JQdItA7qT8kvR5IbZxWdi/PiPZZAav5J68jTG9FM49Hc8hCispilzSMTwbfkzNsLzgx4zwLGzXogEVIF4jWDkNrvmG5/3TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UASwdUtt; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UASwdUtt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6IvxWBSjTwWsp/swgpT1TlsWieoyWKKO/tOmDysSenHRU7Qslfp1Vq/J39E3n8NNmkhwwTvXtx84fF8t+EA2NA3QufwnIUdyKjXZuNKkJIah3VCVJXlCnY9ITUD0gF6k14UGCjkiEuslMMeovwOm+oAht3LIFjWgFmVA02KPZt+CQmP16/4hd1qBONXmygA5yYazukPY8cBgm+rsEpZd8LEdsTRV5pSrPqg6pavmDO+dM8CD+yMqF2Bk3sTpO9hc3uwNolbJg7kzcEqSW90oulDU0AymIyevJoZsLfBNCK14xhAB/Oy8bvyy7WMaf7Nnu1MGEDWg9YyY3ltJUUHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMzEzNmX0xurrRqWhwWdBwnI/oNGSrCwZyTSuuD0UTs=;
 b=DNQODosaSP25oegUKZq95NTzicvV0QPMwLgXigXqRY4iBOn3XfFWYRV54QSITn/ayqLk3EQq0lZqPZYVjXV+1hYvi0XZXTEw+qeoOFUzsBuGyJbRWi1YObKZTtKyfRDgaNtfFs5WHxS3Fqwq4zU6otMFliAIfbcYtK2ULglxgyNkSwUgRB835WiZBiQeYYQLdv8gIi3JqNQR+unuYdsxQ5k/Dj0pRlh/o46lJWvXOe3beY0efxcQc5FcDwcIsyWF+n12Xub6KwaTtVdpi4wEKObAz36CJeYKhmykofXIUmHNyHE4HyJbm/KEM0XmLNkufZciEHrP40x2pGauSutUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMzEzNmX0xurrRqWhwWdBwnI/oNGSrCwZyTSuuD0UTs=;
 b=UASwdUttI+DBrtHvC+Js6C/Ci2BqHqb6iaaqDMhIwiTj+MZkIe9rkLHs+v3xvclUkcRLyzHEax76Ojt2Hr6sOVFYkkDwGFuvoJXK8JIX4x7mQhREJMtLO2uzAE9v4K52dRosT/HaJVPM+BH9GrQCAFAmZU3fuwGAd1z73eHUQxTM2LdV0FpW0aD4kGkIHOHS8WYASxcJLWP18Mpl5eCOYfAMIE3MkS41T8icJmFGxgd4P2cDpVt5ofi9VQjWspcNOBDSYmuUEDHtZAMJNWxoNIajdrWOZ9Saubdmw0h2rVG78cKfgMMmCqXOQ9l8cahkCEBZHJCQxcu9enqpHAU+EA==
Received: from MN2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:208:23e::8)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 18:37:01 +0000
Received: from LV8PEPF00000065.namprd03.prod.outlook.com
 (2603:10b6:208:23e:cafe::78) by MN2PR14CA0003.outlook.office365.com
 (2603:10b6:208:23e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 LV8PEPF00000065.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:37:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:36:34 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:36:25 -0700
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
Subject: [PATCH v5 03/27] cxl: Move component register defines to uapi/cxl/cxl_regs.h
Date: Thu, 17 Sep 2026 00:05:16 +0530
Message-ID: <20260916183540.3813685-4-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000065:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed56e37-4068-4f59-3d34-08df14217f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|6133799003|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	9382WhVIaVu4W4Nx79XF5S4wyEKX394CFXcLCGeWDZPDJH64IC9p7+ouOFr4q+L94WcfLV466iQBwaNS5SPYYOETRNC7Zdbm2yeF7pWYGKe0OkF/RiKq+KBNGhZKnVO7Q3suV8GUG4YLZxVEnSfh8v7IO5+1sa47QTS1ETdrTrJFB9zkATUnlwRHN2G3lAWKBmRfhndcTe5gj4H6iGk5bi/137bPoTmnfBQ9wfReYqTNB6E7PS/4Rx0xwmOizSywvKh9v/P74Luuy4TcyWpd0gR9WWgLtzk+EPnFS+6kzB+bQ1v3zHyjKYX2f5wz/BXlvC+bQBn2U5jTWlYYFGdCkOMZtg7cS5M+aNhvDjd7kEEr3QdRuAf8ggkX7Yag6LUhIWPS2o+t/GfIGLqZehTgQ63ug1W38Vl5aCDzB+E08VPRQRoAZ6KZ4cX2P2hITztH4+inTIsP1i91zMFwShWu+1rfC2vaS8OpIMeGUfw0q2Cst+VFGQGc9MFcM5HHUA7XwhL5bwmeVg0OUn4El4dOngSpss6ZPSK99gpiK59Ffg2CrObK05gN6w6y7qp6uVtfwbbukUFmqNvk11sKTOw2LVEF1qLldG8tBm+5gFBaMHuNAsglqo2j6MFaXA86cHWZvKXb4wys2dvdufFX5E9F+/i46eS9bR5hsMtI9slpNrd1PnIPw3a/tVE6HTtE8ACMpR4MpoWSr5qjeb4drFm4il5Ki5hH9pNy7+sHOPvDiMQYv0XhyE+LBo4zmAqq36Cz
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GX9SHoP+C+J0k8kkQWsOtanEZrY4xk8jMbUL02l6FfRbB96eBM9HWJq8N6vV4CpF0zc7/FbM5H4P+TL/UXs3Q4Ou3YWrSa0e0E1PmWBdU2K1V3qgK8TZwnBIK0fDGh/7K6CGKyszAoKum7wxdVt97l11N2M0uqboZ7X6AOQs1waxfXrdufJj6Xqs4WfwDAV9XNKMkk4zUEnzR0jF54p/eexwxVm6vTWXgEH1OM3nNxseXr9fUitSPnCrf2HV8VwbsfOQNFnf8ewmZG8F1IJQIyJkPFuAJOP5h/bYDB7rv6ujEkVRsF46rXJ3sWnfabVvBbkvsv2gybqXUu8Aok/UXDBfacIjLZyu5llZL79YWnGute1tpxGYRAqnF04dLN1L8+eDFWsDLD1WGI5XXH9BQVpCyA6vj1D+WZgcyBCDWucqtssC7IGUNMicWi2+X2sN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:37:01.4424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed56e37-4068-4f59-3d34-08df14217f83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000065.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232

From: Manish Honap <mhonap@nvidia.com>

The CXL component and HDM decoder register layout is spec-defined and is
needed by a userspace consumer that cannot include the private
drivers/cxl/cxl.h

The vfio-cxl selftest
(tools/testing/selftests/vfio/vfio_cxl_type2_test.c) builds against
installed uapi headers only. Move those defines to a new uapi header, the
way PCI register offsets live in uapi pci_regs.h, and include it from
drivers/cxl/cxl.h so existing in-kernel users are unchanged.

No functional change; the GENMASK and BIT forms are written as plain
values as a uapi header requirement.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                 |  1 +
 drivers/cxl/cxl.h           | 47 +-------------------------------
 include/uapi/cxl/cxl_regs.h | 53 +++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 46 deletions(-)
 create mode 100644 include/uapi/cxl/cxl_regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..2037501cd621 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6573,6 +6573,7 @@ F:	Documentation/driver-api/cxl
 F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
 F:	include/cxl/
+F:	include/uapi/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 03ce50a6a06e..43c30e08df86 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/range.h>
 #include <cxl/cxl.h>
+#include <cxl/cxl_regs.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -24,52 +25,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
  * (port-driver, region-driver, nvdimm object-drivers... etc).
  */
 
-/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
-#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
-
-/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
-#define CXL_CM_OFFSET 0x1000
-#define CXL_CM_CAP_HDR_OFFSET 0x0
-#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
-#define     CM_CAP_HDR_CAP_ID 1
-#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
-#define     CM_CAP_HDR_CAP_VERSION 1
-#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
-#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
-#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
-#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
-
-#define   CXL_CM_CAP_CAP_ID_RAS 0x2
-#define   CXL_CM_CAP_CAP_ID_HDM 0x5
-#define   CXL_CM_CAP_CAP_HDM_VERSION 1
-
-/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
-#define CXL_HDM_DECODER_CAP_OFFSET 0x0
-#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
-#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
-#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
-#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
-#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
-#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
-#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
-#define   CXL_HDM_DECODER_ENABLE BIT(1)
-#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
-#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
-#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
-#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
-#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
-#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
-#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
-#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
-#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
-#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
-#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
-#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
-#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
-#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
-#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
-#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
-
 /* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
 #define CXL_DECODER_MIN_GRANULARITY 256
 #define CXL_DECODER_MAX_ENCODED_IG 6
diff --git a/include/uapi/cxl/cxl_regs.h b/include/uapi/cxl/cxl_regs.h
new file mode 100644
index 000000000000..15a5a1930c75
--- /dev/null
+++ b/include/uapi/cxl/cxl_regs.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+
+#ifndef _UAPI_CXL_REGS_H_
+#define _UAPI_CXL_REGS_H_
+
+/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
+#define CXL_COMPONENT_REG_BLOCK_SIZE 0x10000
+
+/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers */
+#define CXL_CM_OFFSET 0x1000
+#define CXL_CM_CAP_HDR_OFFSET 0x0
+#define   CXL_CM_CAP_HDR_ID_MASK 0xffff
+#define     CM_CAP_HDR_CAP_ID 1
+#define   CXL_CM_CAP_HDR_VERSION_MASK 0xf0000
+#define     CM_CAP_HDR_CAP_VERSION 1
+#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK 0xf00000
+#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
+#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK 0xff000000
+#define CXL_CM_CAP_PTR_MASK 0xfff00000
+
+#define   CXL_CM_CAP_CAP_ID_RAS 0x2
+#define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_HDM_VERSION 1
+
+/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
+#define CXL_HDM_DECODER_CAP_OFFSET 0x0
+#define   CXL_HDM_DECODER_COUNT_MASK 0xf
+#define   CXL_HDM_DECODER_TARGET_COUNT_MASK 0xf0
+#define   CXL_HDM_DECODER_INTERLEAVE_11_8 0x100
+#define   CXL_HDM_DECODER_INTERLEAVE_14_12 0x200
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY 0x800
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY 0x1000
+#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
+#define   CXL_HDM_DECODER_ENABLE 0x2
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
+#define   CXL_HDM_DECODER0_CTRL_IG_MASK 0xf
+#define   CXL_HDM_DECODER0_CTRL_IW_MASK 0xf0
+#define   CXL_HDM_DECODER0_CTRL_LOCK 0x100
+#define   CXL_HDM_DECODER0_CTRL_COMMIT 0x200
+#define   CXL_HDM_DECODER0_CTRL_COMMITTED 0x400
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR 0x800
+#define   CXL_HDM_DECODER0_CTRL_HOSTONLY 0x1000
+#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
+#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
+#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
+
+#endif /* _UAPI_CXL_REGS_H_ */
-- 
2.25.1

