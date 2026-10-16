Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A844FD781;
	Fri, 16 Oct 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167610; cv=fail; b=bhe4G9Z+oxtgVuw0uJYoSf1nQ1CjAFYURoffkw19Vo8hYw3wd08I/4So1y0zEyCM5u9JZn2nxEGqs1BX7+3phz2aoto5eSmu3pNCzxBDFLMjXFr5+/TIxdakYlSPHtfBlrIE7Po534uX3QcdZb7YMso09g0+dGbWK8ar++EGVEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167610; c=relaxed/simple;
	bh=HP6QyxBvbCrcdJwLpKlgHDqO3S8t1cXcPkx/sMI13+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSY9IwBf37EcwQHjUg+JGiAAPwJZyqmlG/Q7LzUxulEgB8VeE12ItYXIkPOgrUnzmDl+SUjVhwCNI52Lo+B8VJntcvSmGExsWuXTkBzP/SUpMp1XurK2w/ekEFUpuFWUS3asiVzWCs9cQtB4q4eKkab/46RljiDgbTc6wX6CaIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TiT3P6C3; arc=fail smtp.client-ip=52.101.85.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TiT3P6C3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRznQygZ2l/GpB5RyFK5ORvAizRWk9oTmQV6D98QoYJKU2xHImyI/CkrjDhhhjW7WRjgUMidlAhnPa8eWPoORDBTC6Q81fagDKxuBrUjTVYQ1K+KwKmyDCzcLfCekw9tY4ogvTwYswk4jON/0OGyg+fnJqPcpEZQ7/YsbOfLJzZr1bFz9/kQLSMkTvUGV05e21gsLymNaTD1Uc8YMgdBFKGlZrOYMTT+VJnBN4nMMTjwoT0J6/gmK7fHQY6bCuUhCK+k1mht+ya0TQ4TRU4N4xiRVT9M5jXq40UpFcqNIdxmi0vbJjHqQeaPenMrVYOG16kUt6g0O3t+QAas4HXFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I6lHQG328066eYl+ftzMN4FD4r0tJCAjE9567M9JxA=;
 b=p2IAki98Oi3g1sDTY74Y7kBO1QjNrq+7uYGlGXnbMGVo+q4yr+8Pq+yC/1L7DHhxxpWDlD0i0c3rh9qpNw8wy2YkO6vWxlgqUN9JeCKbhI2G55555Up57uH+VkYFo604rUKay8cqmndpcH9LwE+xZBdso1NZY4s+yXlpK1GbKaoP/0FzFg+0+gy9+fVktSTlji8sdk+93quD/0NWwztOQArsdGg60zMW3Msu6OQvpAjt2RwYETFQ8vf2M8jRlULKZs5DIGlighv5R7j6iUL9zAK7apBbctkxcoFi/OzkZ8ET4hn4U/hBq7piUaxDOwmeZMv8n5vohIeFNLPJum/6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I6lHQG328066eYl+ftzMN4FD4r0tJCAjE9567M9JxA=;
 b=TiT3P6C3o+6hW1oMTDdO8d3J+94Y+z/HM0jBTvxieDMg+nKxXxQNXZsLA5wNSIZwOzX/o6aOYPDulHThFaoY1hpMKbSzYb5ripWK6xLOJmiJC+8rlrQcVWtPLL0WRQ3h4yrVTtIOs5uLa3F5vPBzm+M88YAjQ9143gXbWyPFxOO1g2t/aMgKOVz8y0IwQxMshwyyO347McFsktAjOhbL5L2heQ7HpO8Jd62P+wXNKdhdqMSRAYoiG2Ts+MjELf+jz1JbJet5dgO59v3ZBF7mFn/EVm1ExblEnvCEhjrWMYMLGZqYeDUm/rmDg+rRDHhao0saYWWCmdSt0zMHv5NQvw==
Received: from MN0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::26)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Fri, 16 Oct
 2026 16:19:59 +0000
Received: from BN7PEPF000000A9.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::4a) by MN0P220CA0016.outlook.office365.com
 (2603:10b6:208:52e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 16:19:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A9.mail.protection.outlook.com (10.167.245.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:19:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:19:31 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:19:22 -0700
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
Subject: [PATCH v6 03/31] cxl: Move component register defines to uapi/cxl/cxl_regs.h
Date: Fri, 16 Oct 2026 21:48:10 +0530
Message-ID: <20261016161839.2765592-4-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A9:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afe3746-bd6c-4476-8399-08df2ba152d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|82310400026|36860700016|11063799006|921020|56012099006|261009223027099003|22082099003|6133799003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/13y/+7yNxEtHG/ywQitO5FOFdKfIiYGEDaogOAl3Rf1hi7OYYuO1TaAx4bUp27anK1GGGUMjxbcAc5pMT6DugSwcOJ7tCpxpyy7Mye90nQA/64CpjLipvt/+xMa06PWQtCmx4mIptcCKjC2CMws4fbQ1objzCq/o++ethvlweCMpZQ7qymq6uWuMP7qgZl+V7bJz7ZW9sGnAXat6IGMwA//foILEkU6kw/5PM+jN99uJpWPkhxKVSKXwt+oJseg6iMXXqDabSG+imoyPboRtOFd6PkQ0JCJs2PMuQCPD2oK0bQSWi5+DJJ7rP+MTkKoK3kFSZBzo1BxAI28fHHVPR2LYBBpnD+m28NYRT1K6pyZDE+Vwan/Zaf8SrFxW9No9X5mPK81IeMa4XRne0tBy4o57Vzm+cpTRxUfjnkT9gx0lhEIaEqxw1lnuWTGTvCPqvCFDFT0Zidser0gsqztGlnrZs2OWQGe1Wuh5aMB2j/UjCjO6vf3lP0V2JaXLr2d3hRXSSjPRSzbVQ+rKJc2VsC5SGV7XwYmkqMZ1zfg1n+7dXrZ9IY4Jqx8E0uj8X7Q9z5/Qir3OrasEzt6kC6VfdTOdLdsOdlRoO/lZ2YfC2E7wTuGtpsyfTsQNy67/5sEqigwTWJ7W8Uy1zV8gPLlf72aKXRCjkCpc71rBMyToNNyzv6U3QSG14WfWWWEON8ExuTlmc0ydbfFYL48jkO2MvilaLKCMabRt1i4vRH1SsUYJ5O+cfTGmqonaNpC6rM7
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(82310400026)(36860700016)(11063799006)(921020)(56012099006)(261009223027099003)(22082099003)(6133799003)(18002099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+e9WqsJmfMnqWlVtI3eX6xoujWsvAwZhHZDl+v6IPMOe0jOO04f3qew602wD4Gr4Vm08dgI9AGudHt8tTpmPtV7RFwVUADdFlh0lUeWEp59AfVy96CovimaRClYqmi43WJR+nU6sXlv6ywGae18CMmXAy67KX4MO5qDx2E2U9yuDYqzgGGN5Qn5HkS+BFwB9daGAcZOwSXEhxqlLtI64DpyrfKrpI0hcKSqFjjhkTo5CosmGcI9fjRO/LacRMFCfAFDbJ0GxKxPFoQrvJCLZO75SrvYqGV1PP4G8UFA9XfV71WHgATwJ9qoY3aWExX17LfGf+/M4yDZ0z/yl9DZlNP8dKSYmr+EwlPUT/PkgmeT2Zc/+CBT0nte6AttnwRdegfKGj9WtpnKU6NDfbGlUGPy7x7VAai+G/NZ7HzBuckcq4lD4XA6eB1Hn0nOpacRn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:19:58.7464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afe3746-bd6c-4476-8399-08df2ba152d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356

From: Manish Honap <mhonap@nvidia.com>

The CXL component and HDM decoder register layout is spec-defined and is
needed by a userspace consumer that cannot include the private
drivers/cxl/cxl.h

The vfio-cxl selftest
(tools/testing/selftests/vfio/vfio_cxl_type2_test.c) builds against
installed uapi headers only. Move those defines to a new uapi header, the
way PCI register offsets live in uapi pci_regs.h, and include it from
drivers/cxl/cxl.h so existing in-kernel users are unchanged.

The section references in the moved comments are updated to CXL r4.0.

No functional change.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                 |  1 +
 drivers/cxl/cxl.h           | 47 +------------------------------
 include/uapi/cxl/cxl_regs.h | 56 +++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 46 deletions(-)
 create mode 100644 include/uapi/cxl/cxl_regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 08fc6efdb6cf..c3aef3dce68c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6575,6 +6575,7 @@ F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
 F:	drivers/pci/cxl.c
 F:	include/cxl/
+F:	include/uapi/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ad4e80be2bd7..b62074453866 100644
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
index 000000000000..276f9361c840
--- /dev/null
+++ b/include/uapi/cxl/cxl_regs.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+
+#ifndef _UAPI_CXL_REGS_H_
+#define _UAPI_CXL_REGS_H_
+
+#include <linux/bits.h>
+#include <linux/const.h>
+
+/* CXL r4.0 sec 8.2.3 Component Register Layout and Definition */
+#define CXL_COMPONENT_REG_BLOCK_SIZE 0x10000
+
+/* CXL r4.0 sec 8.2.4 CXL.cache and CXL.mem Registers */
+#define CXL_CM_OFFSET 0x1000
+#define CXL_CM_CAP_HDR_OFFSET 0x0
+#define   CXL_CM_CAP_HDR_ID_MASK __GENMASK(15, 0)
+#define     CM_CAP_HDR_CAP_ID 1
+#define   CXL_CM_CAP_HDR_VERSION_MASK __GENMASK(19, 16)
+#define     CM_CAP_HDR_CAP_VERSION 1
+#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK __GENMASK(23, 20)
+#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
+#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK __GENMASK(31, 24)
+#define CXL_CM_CAP_PTR_MASK __GENMASK(31, 20)
+
+#define   CXL_CM_CAP_CAP_ID_RAS 0x2
+#define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_HDM_VERSION 1
+
+/* HDM decoders CXL r4.0 sec 8.2.4.20 CXL HDM Decoder Capability Structure */
+#define CXL_HDM_DECODER_CAP_OFFSET 0x0
+#define   CXL_HDM_DECODER_COUNT_MASK __GENMASK(3, 0)
+#define   CXL_HDM_DECODER_TARGET_COUNT_MASK __GENMASK(7, 4)
+#define   CXL_HDM_DECODER_INTERLEAVE_11_8 _BITUL(8)
+#define   CXL_HDM_DECODER_INTERLEAVE_14_12 _BITUL(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY _BITUL(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY _BITUL(12)
+#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
+#define   CXL_HDM_DECODER_ENABLE _BITUL(1)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
+#define   CXL_HDM_DECODER0_CTRL_IG_MASK __GENMASK(3, 0)
+#define   CXL_HDM_DECODER0_CTRL_IW_MASK __GENMASK(7, 4)
+#define   CXL_HDM_DECODER0_CTRL_LOCK _BITUL(8)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT _BITUL(9)
+#define   CXL_HDM_DECODER0_CTRL_COMMITTED _BITUL(10)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR _BITUL(11)
+#define   CXL_HDM_DECODER0_CTRL_HOSTONLY _BITUL(12)
+#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
+#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
+#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
+
+#endif /* _UAPI_CXL_REGS_H_ */
-- 
2.53.0

