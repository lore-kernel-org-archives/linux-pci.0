Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06242EEAA;
	Thu, 13 Aug 2026 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613896; cv=fail; b=F9CumTjsPwz8wCVDS0L14SrGWhq7YJb9ogx8WN+34mxmMwanuMUz+8zo28Ot3AINnAWbdKNNxyYX0VRAO9UcXoWQQiziPNMyEwlheKPJ1/E1PlAsAlVVJet4/NHQixkSapgJY1fC6/y35rSyd2NvGgN9ehDwWUZqZ2celG9Q5J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613896; c=relaxed/simple;
	bh=M2C0lsPKRPn1DXxDJ5G6RHEarCEeGj/6mrwwIieo6uY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzMEdEIkCL+22Yccokj27YjdgN4uyEZUdB5zaw8vCfHa3HcqbZle4eFz2vOt/odACnDGMjD5MnPwpK7xXRwNxiMhtFxCofw9lx6dJGuoWgzic9r1t38m42q6JjEddACD1Ei/wfP9jhRoHEFCmzCFMy7rAxdSmj+jZdHixV5IITA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CLy5nTE/; arc=fail smtp.client-ip=52.101.48.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CLy5nTE/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZOlbSvmBBB8TvhLJVKaEYbHCODYHtYK5LWaksg6bAX5R5ob5kDspix2xkVua4x4Qzee7pN3i69kJoYztr49P/W6UBI4l4RhLm0PF5lDFcyOQ+O6f46Id7QHsEZqnMRv2HsQyMGHqSmWEwqwq2qFHTwgXia2ZbYPCWFr0He3XtGm9AfjvPU15kf8cU2sdAqvTIuvqj95DSVf885jGl5wyTBnv8SOjWQVqshiQx3fKhO37eh6AvE+JEZZSksbr7Q83Z8LYmmw7E2AkeF/yIS0uyJyQ/huDpJAy3Kk225fjk62rw4r2Dfnsdu772/C+WYBOCwPBwA8bVRJ4pyxfe3dNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkbQSp9tRx/35eBw80UFlzJ77yLfOJ7hLBuP6kJ/bqU=;
 b=aAuUgZ+JUcQ8p5+GWajQDaPz9/inxZQfRBXaGIiEjd8Joc+90IgdhPA6vsunyls5KUPVADi71jKSOlCe08BKygOkrCNeGAfPGfvOCONAIrqWwRClSdPqyI25gdKR9MbTAqzH6/1teuE5tcnT2nrbabZp86dK4zXRuAM8e4fHgZOsuqoGTCrnWOBTTAmZ88UAJ+uRQi4vm7ubKEsaF309wz0np/8McA/2KJwpsVUPAIlNFV0qbDdzKj/pNFL1VMPXVrvN/mso4UibRzLBxGe0wjte9wMc7hWecx6JwstRnJ9tSebc0LinPL+tBPMpFIKcWjekvOTjndwyD6J+/uTO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkbQSp9tRx/35eBw80UFlzJ77yLfOJ7hLBuP6kJ/bqU=;
 b=CLy5nTE/tk54oeWOE+vJ/sD27oyKOl8DA3kF/ZEzkk599cCkgL8XaE/Kw/efyCRs6WhB+2m8/MemZ8re9SKtTr0f0NStSePdCsMcLE7ehDU87oXQUsz4jc6sbHqP8TUgi8qJHQQdTYGY1KAy/G1J0UyCQYwRjYeHIswQniNsLRxeYBtRugLNzmdvzero+fPiHbxChrSMd6XCcRzWMqKgbURV4NrQa4OAGrMKfIrwVtGmq6SIKumUukS40LgTOLkJjTuPEaRNNHnfKHWs4RI0bMqJ/CsFfyvfhGU9cp9vx4E4ZdRA0X/Q09MxBYGbTa9BJ4zFLJwuNyDNaEQhiAeZSg==
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:38:01 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::4f) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 09:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:38:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:37:40 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:37:30 -0700
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
Subject: [PATCH v4 03/27] cxl: Move component register defines to uapi/cxl/cxl_regs.h
Date: Thu, 13 Aug 2026 15:06:07 +0530
Message-ID: <20260813093631.2288172-4-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b81279-d5ce-4727-1dea-08def91e9121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|11063799006|3023799007|10067099003|56012099006|6133799003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TV/4TJr6A8F692LNhtiLxogzJvcO9M3pHgjpN2UXQ2HLxb/YDRu8SE/YoyUAmLdl/2IsNNFkU/9WAyMTOHDeCMAVfmHI0bL4ic/qj/JOdEh7E2ItEAV3h+D9Z2Eg2t+mMV2R+4byOwqrAhHTOpjQF+tt3C5SASLLRtKIPVJ2Gbpl6sj3+sqdxQXEQ89rcehTLnEVcbs4SJoFdQSKwwdgPijIdIIMG0sevzeVC9AHgNk1ZFdVA7h3teXN8AvZpB9u6u83A1uvzU7inUqTWCrCkZ76ivtpziocXA8SMdb33hoExR/szbsB6oiEWovl7ZOYkb8d1hpIYr9JIwrhlejDKDLSJZzuHRGUHLNa8j4OahBxIBfHS3o8n6t7+FqbScRsFwTIN1zqQF0hunudJqtD+uYkXAEd3TT3EDo9oz9PetfDnL8Dwmf5aeKqZFsHQfSLMm3gmO2vLNVKNWl4sG3aswoRMHCgH8Yi9VA1tabe5n+XsANEjnnduJb06P20t0DWbgEST4+9505Y/g142N0fmt0Q+2L/vuGYn9I/qiUsy0KIb16/cg7pj1YO3LwA42z9DrT8GbIP7VFcpVvKkGnCDj1vI7vpDq0HTuLAzyMwejmBJTbQXMsVbel4HNR29j57CmNDnJBGpfKAZECGsBmybpeIx5irDgEMoi+y7x2VuyGhIX/zXrfHq3Ui10PEJdZ+4cqj1fF9ejB73zRdZnvuhz/WtQRnypmywIyoezFh3MA14jlTGzIJf67MhN2h9wsH
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(11063799006)(3023799007)(10067099003)(56012099006)(6133799003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jxDPv24sXHKACGRgRrqqVnhNffOiw3Ehl+YKiwmVrGK87ePjTWObns0qu5UrMQV8C/fnHv1owQCwRp/QYpU693UEkYAGsMqqNQG1NNaTZBaeE6qhev4I/vETGjILclAUlhUeuhzqw5pzTFJ2OI/ZFETDva7056a8yBHy0buggWkJeGrICwCyiR3AtFTWeDeoWtDur2FsfV+fa48Y0UOHnvlN9jIzshOb2Dc9606T7zjZ/Yid0ncWA2CEqECtNBqXUj3GoaYAcAoT3yaynU7jMg7gXtHnu/g0HiYiuxKT7CGC9DmtNYlF/rfPGzWEa7sccYR7He9manUZwVy6FKH2Qau+x2P8ysf4f8dah6X90q1ZuTiNwqBDhPqsLR89YRyTKTFoxVBGEXwXj/RuNl4gkOaF2Qzx4HyQAyIkgemgbihxFK3R+7CEAd5NlQhw2pUC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:38:01.0526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b81279-d5ce-4727-1dea-08def91e9121
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500

From: Manish Honap <mhonap@nvidia.com>

The CXL component and HDM decoder register layout is spec-defined and is
needed by consumers outside the CXL subsystem such as vfio-cxl, which
cannot include the private drivers/cxl/cxl.h. Move those defines to a new
uapi header, the way PCI register offsets live in uapi pci_regs.h, and
include it from drivers/cxl/cxl.h so existing users are unchanged.

No functional change; the GENMASK and BIT forms are written as plain
values as an uAPI header requirement.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                 |  1 +
 drivers/cxl/cxl.h           | 47 +-----------------------------
 include/uapi/cxl/cxl_regs.h | 58 +++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 46 deletions(-)
 create mode 100644 include/uapi/cxl/cxl_regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7307..c665bf8f1a28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6528,6 +6528,7 @@ F:	Documentation/driver-api/cxl
 F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
 F:	include/cxl/
+F:	include/uapi/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c795cce0fcbc..2893b2427be1 100644
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
index 000000000000..04bf790f0fdc
--- /dev/null
+++ b/include/uapi/cxl/cxl_regs.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+
+#ifndef _UAPI_CXL_REGS_H_
+#define _UAPI_CXL_REGS_H_
+
+/*
+ * CXL Component Register layout from the CXL specification. Kept in uapi so a
+ * VMM can consume the register offsets without a kernel header dependency.
+ */
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

