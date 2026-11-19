Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120182;
	b=GJ3U+sBueLzUcE5fJDfC3hyyYuOfvKpR9JH9h1lRXdGbYV4Y7pBnYWkAZ2jUS72okKP3
	 fjFGcmDMiP4Be3REq4O7/f/gHDKDlWLzxMz1k+ImTvJ9yxRl8qc7QK42KgEVciYPnfOk2
	 hgWvUkLPhu5wV89v6FBypvB73ZDZEVIwKn52WuLwiPJjI/iVsDAHGAP3AJPiv7GXTFN4s
	 40upO99hHl+FJZG7FQs7EJEANBw2/x1cLQDKMKWiMyD4AozrkWsv7kley4H78dJFAqCSU
	 pPkhloyDh1Vp260DqQz2zw5S0a309M0oOvwTpSodCsrY9j/iSa+YmyBpTb8B4ps/uzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120182;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=j6+S0cqf2zoem/ZNyxWqMhtQcse1D+7l7y14SbI/akY=;
	b=ENHghLRoxKtyVL7JmgkYytfKCkeJDE4lVppNiLq15SeDs6kidtZyA/y5Q8ReABgTX6NY
	 h3l9mzgKEe1Lm3nulfigy7lhQZ2BPmybn7rhQqxwf7ZKdMzHw92T3dsBUHLWURyxhOdGk
	 4IiLjwUM5meOogzoklyh+mOqUxvfbOzITFByDUc90UnzQxGMWYh2vjtBOPNWb+OLd/yzF
	 cKMRR5rVaejVW5TKEu23bDYNv5Xld7yWGyihdaljTE0Hkw4n3yy9CMd/T0S2snzltcX32
	 abxVU5PZHr5rJDfrDDdqYe15SwRmuwiywQP3aMpLkj1gFCzSPZ6tZhbjD7ZRYINXagA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AHEcUn1L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81267606A324;
	Thu, 19 Nov 2026 20:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81267606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AHEcUn1L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vorbkkmka31Tix6nw3ZotJQ8Rn6uA+j3sFwrzvaNOYfJ/0ZHaqkV55HCp9uIrTNtUVsPHTQ5iAd1XDnvkjd+EMxMzdDOZgxuYW3X4Q3/KAUhwV9ruDkM+1j0cKdrEEa7NNn631lLfCvKNKtSXfRai49kbgx9vLTrPBrhDuueDS+ILGH/7ei6j1Ewz4pPJA4sEUU2zKdxlZoPtfz+5K4RRJQjzBujWDouCZ8982CqEfXZUCUL2fbiuJr9OlMKGkUMpj4w5ZICX3mCTAx8LhszvqIJr+LkxXAgIGTVNKXeF37CW85tRjfzkUdEbJlNOMRTqtHd2rzG1m+gkbjn1mq8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6+S0cqf2zoem/ZNyxWqMhtQcse1D+7l7y14SbI/akY=;
 b=Hp8WlNnrLKaIU5IT5p7Gdq5JB2slm5YesmirSrECFJ68Z70BCO48BOciqaSe8bLp7YDIELGihsHaZNbyQPZ/MsDnWZLSdUo1c+s6MRSmGHJK6XZOJD8VqNErMmcTVWSuFHrDnNtykDrLnvGKPXPlqxK3l7Mou7X9ashBNhQ25Q9Au/ao97aiK2QxXFrfsY+3eRM91HMOUOxUVs3Ps8zKbUdkZqfXPcMmmx8qJekanD5DXgP7uqk19iLF2jK9MZ9pdXV8X1wbUU5qcDG7wAOR5Ayn2KxfVHRu4QoqCfBGvGjyX/9ub3iJJI3drEQ8bErOYudI4w6ceg7jHR57vLxLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6+S0cqf2zoem/ZNyxWqMhtQcse1D+7l7y14SbI/akY=;
 b=AHEcUn1LRYMatWKozhPBlFL6gSg90XXhLpk/DfpxvV+zJDc+CtlKUd9eAt09qNx/CV+ersfS7tRz9uc3ExZyDXctFlvco+wwgZ2LVhaJ/6ARn5nr6DvetTSccpJM6VmYq0VZPhyhSZiGjVUG/4zUSKgUlmaXeJs4Dv1ecCZUI5U=
Received: from CYXPR02CA0013.namprd02.prod.outlook.com (2603:10b6:930:cf::24)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 19 Nov
 2026 20:29:34 +0000
Received: from CY5PEPF00000E82.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::d) by CYXPR02CA0013.outlook.office365.com
 (2603:10b6:930:cf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:29:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E82.mail.protection.outlook.com (10.167.247.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:29:33 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:29:32 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 29/44] dmaengine: sdxi: amd: add QoS validation scaffolding
Date: Thu, 19 Nov 2026 14:23:05 -0600
Message-ID: <20261119202321.1734355-30-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E82:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cb0003-a46b-4270-f0b7-08df467bd293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|7416014|261026121527099003|10067099003|3023799007|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003|261022075727099003|261022105027099003|261102130727099003|261102123227099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nc757U3xM0vcWZJ8fmCsNALXXLXOsILYgsRQB1ItzWUJOGFA2hjZ7yHgNSDjpDbnZpVk+DXg19GjsSTFPsrSmJV35l+1xQHxTIcvKvC8pMr3H5FabFGu4+DwKJGbhwPSXXF4WT8LSscJzJqm5/vTW/DXFR1NzxjDtc8S/Y7hZXEecPCx+rqqwS5xOwng2loJ3haeqZ4A1PbUxzbl9CJ0+EvMU+srNjzcDrteGtVZMqU8bNcJ1kJ0yy6ZySYwT03ulMttW5Vc3pmrSz3RpRtB0ab6iACTFspjGdoUtzfUZdSKOfD0PQVLZudpMe76lm+a3cf5q0HRg5DZymS5hPorf+qoHB+/Z8AskOknA9ikjn9aX1MzmxfkqwZKGa4mD71+5cxgTxTrqFAzzpZLofrKmj5YbDYXFThxMZGUd5VhzSTshFcH5w1T+K5db54pGVSPmjtiqcnNe4CoK5H3UKH+EkvEaG8doHI0vcuYPkQmTtaW1CDP/GocxD2xZaOrzJtpFJTTgt5/0228VzR123KI9sOvX5b3RYp/flwhGS6umnISoUAJ/LLOQioNAfsCN8FGFB+3VthkDtbsg9lHFp7p5cvexRBYrkNPASNj3PzVx70sITcunj1Y0Ocnn1UrnI0Y9XR35j5F7hzC5DrYuyegLx42/RQeuDjWDdG9JjhfjEhGwnMWXm81qxouhCbb+scKC507R9D7lkiPh/BisoSzuw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(7416014)(261026121527099003)(10067099003)(3023799007)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022075727099003)(261022105027099003)(261102130727099003)(261102123227099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6B8qzyzy3LhqGZh+9O8wVShZBRMatJO7Xtn59O1MTkJok4EvANdNFn8+ElPaY7+2f7sdKoRqDGNG/JjTd7IJQpZa5Q/lczP/bS1rty54CIuj1y0nUAk3YtRTMD8MpcAN1XfqttJV/M6waGmobQpOvjtQHoCHE2RZ5yfBKUicCLv+Ml1WpqhcpnqMCfrMtPVAiuYw0Qp2pXHJ/ku0zElZagOtU0mT/G9s5RkFbQGlPaf7Kbgf/uJ+igB6KvPG/d9FrcRMsJXUSKYpjPHdxBiaD+iZ8v85QS9/UEzWX/NFoCL6hpPpn3T15mDMUUIOV7GnWi6ASttdxtD0TGpAvEN6oFXve0Nxlx6rrwLE5FwGCOJnJZ20CWZjGeprvICM2N3CC6IBZ3JhLUnm5xrfUbpiLO1vYqbDSB6OzG5frHSQsDLJhZVHnPfJMzzJbRyLyYJy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:29:33.6830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cb0003-a46b-4270-f0b7-08df467bd293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E82.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D

Create the AMD QoS handler source with common user-buffer helpers,
GUID discovery, and request validators. The added validators check
bandwidth alignment, device and pool updates, function assignments
and telemetry selectors.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/amd/qos.c | 266 +++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/amd/qos.h |   4 +-
 2 files changed, 268 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/sdxi/amd/qos.c

diff --git a/drivers/dma/sdxi/amd/qos.c b/drivers/dma/sdxi/amd/qos.c
new file mode 100644
index 000000000000..b18ed727aee9
--- /dev/null
+++ b/drivers/dma/sdxi/amd/qos.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD SDXI QoS vendor-command handling.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/capability.h>
+#include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <kunit/visibility.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/sdxi.h>
+
+#include "../admin.h"
+#include "../sdxi.h"
+#include "../vendor.h"
+#include "qos.h"
+
+#define SDXI_AMD_QOS_CAP_BYTES			48U
+#define SDXI_AMD_QOS_TEL_FIXED_BYTES		48U
+#define SDXI_AMD_QOS_TEL_HDR_BYTES		48U
+#define SDXI_AMD_QOS_POOL_REPORT_ENTRY_BYTES	132U
+#define SDXI_AMD_QOS_MAX_TEL_BYTES		SZ_1M
+
+struct sdxi_amd_qos_cap_info {
+	u16 feature_flags;
+	u16 max_pools;
+	u32 device_maxbw_cap;
+	u32 granularity_bw;
+};
+
+struct sdxi_amd_qos_dev_info {
+	u32 device_maxbw;
+	u32 total_allocated_bw;
+};
+
+struct sdxi_amd_qos_pool_info {
+	u32 pool_minbw;
+	u32 pool_maxbw;
+	u16 assigned_functions;
+	u16 assigned_contexts;
+};
+
+/*
+ * SDXI DSC_DISC uses RFC4122-like GUIDs, but with time_low/time_mid/time_hi
+ * stored in little-endian order.
+ */
+static const u8 sdxi_amd_guid_qos[16] = {
+	0x0b, 0x61, 0xb7, 0xf5, 0xc6, 0x0d, 0x03, 0x4c,
+	0xab, 0x79, 0x65, 0xf1, 0xf4, 0xef, 0xcf, 0x4c,
+};
+
+static int
+sdxi_amd_qos_copy_input(const struct sdxi_admin_vendor_args *args,
+			void *dst, size_t size)
+{
+	void __user *ubuf;
+
+	if (!size) {
+		if (args->in_size || args->in_uptr)
+			return -EINVAL;
+		return 0;
+	}
+
+	if (args->in_size != size || !args->in_uptr)
+		return -EINVAL;
+
+	ubuf = u64_to_user_ptr(args->in_uptr);
+	if (!access_ok(ubuf, size))
+		return -EFAULT;
+	if (copy_from_user(dst, ubuf, size))
+		return -EFAULT;
+	if (args->op == SDXI_AMD_QOS_ADMIN_OP_FNUPD &&
+	    size == sizeof(struct sdxi_amd_qos_fnupd_req)) {
+		struct sdxi_amd_qos_fnupd_req *req = dst;
+
+		if (!(req->flags & SDXI_AMD_QOS_TARGET_F_VF))
+			req->vf_num = 0;
+		if (!(req->flags & SDXI_AMD_QOS_TARGET_F_CXT)) {
+			req->cxt_start = 0;
+			req->cxt_end = 0;
+		}
+	}
+
+	return 0;
+}
+
+static int
+sdxi_amd_qos_require_no_output(struct sdxi_admin_vendor_args *args)
+{
+	if (args->out_size || args->out_uptr)
+		return -EINVAL;
+
+	args->out_size = 0;
+
+	return 0;
+}
+
+static int
+sdxi_amd_qos_prepare_output(struct sdxi_admin_vendor_args *args,
+			    size_t required, void __user **ubuf)
+{
+	u32 available = args->out_size;
+
+	if (required > U32_MAX)
+		return -EOVERFLOW;
+
+	args->out_size = (u32)required;
+	if (available < required)
+		return -ENOSPC;
+	if (!args->out_uptr)
+		return -EINVAL;
+
+	*ubuf = u64_to_user_ptr(args->out_uptr);
+	if (!access_ok(*ubuf, required))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sdxi_amd_qos_admin_ready(const struct sdxi_cxt *adm)
+{
+	if (!adm || !adm->sq || !adm->ring_state || !adm->sq->cxt_sts)
+		return -ENODEV;
+	if (sdxi_cxt_sts_state(adm->sq->cxt_sts) != CXTV_RUN)
+		return -EIO;
+
+	return 0;
+}
+
+u64 sdxi_amd_qos_query_selector(u16 cxt_num, u8 query_type)
+{
+	return FIELD_PREP(GENMASK_ULL(15, 0), cxt_num) |
+	       FIELD_PREP(GENMASK_ULL(18, 16), query_type);
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_amd_qos_query_selector);
+
+u32 sdxi_amd_qos_align_bw(u32 bw, u32 granularity)
+{
+	if (!granularity)
+		return bw;
+
+	return (bw / granularity) * granularity;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_amd_qos_align_bw);
+
+int sdxi_amd_qos_validate_devupd_req(u32 device_maxbw, u32 device_maxbw_cap,
+				     u32 total_allocated_bw, u32 granularity_bw)
+{
+	if (device_maxbw > device_maxbw_cap)
+		return -EINVAL;
+
+	if (sdxi_amd_qos_align_bw(device_maxbw, granularity_bw) <
+	    total_allocated_bw)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_amd_qos_validate_devupd_req);
+
+int sdxi_amd_qos_validate_poolupd_req(const struct sdxi_amd_qos_poolupd_req *req,
+				      u16 max_pools, u32 granularity_bw)
+{
+	u32 min_bw;
+	u32 max_bw;
+
+	if (!req || !max_pools)
+		return -EINVAL;
+	if (req->rsvd0)
+		return -EINVAL;
+	if (req->pool_num >= max_pools)
+		return -EINVAL;
+	if (req->pool_operation > SDXI_AMD_QOS_POOL_OP_DESTROY)
+		return -EINVAL;
+	if ((req->pool_operation == SDXI_AMD_QOS_POOL_OP_CREATE ||
+	     req->pool_operation == SDXI_AMD_QOS_POOL_OP_DESTROY) &&
+	    !req->pool_num)
+		return -EINVAL;
+	if (req->pool_operation == SDXI_AMD_QOS_POOL_OP_DESTROY)
+		return 0;
+	if (req->pool_minbw > req->pool_maxbw)
+		return -EINVAL;
+
+	min_bw = sdxi_amd_qos_align_bw(req->pool_minbw, granularity_bw);
+	max_bw = sdxi_amd_qos_align_bw(req->pool_maxbw, granularity_bw);
+	if (min_bw > max_bw)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_amd_qos_validate_poolupd_req);
+
+int sdxi_amd_qos_validate_fnupd_req(const struct sdxi_amd_qos_fnupd_req *req,
+				    u16 max_pools, u16 max_vfs, u32 max_cxts,
+				    u16 feature_flags)
+{
+	if (!req || !max_pools)
+		return -EINVAL;
+	if (req->rsvd0)
+		return -EINVAL;
+	if (req->pool_num >= max_pools)
+		return -EINVAL;
+	if (req->flags & ~(SDXI_AMD_QOS_TARGET_F_CXT |
+			   SDXI_AMD_QOS_TARGET_F_VF))
+		return -EINVAL;
+	if (req->flags & SDXI_AMD_QOS_TARGET_F_VF) {
+		if (!max_vfs || req->vf_num >= max_vfs)
+			return -EINVAL;
+	}
+
+	if (!(req->flags & SDXI_AMD_QOS_TARGET_F_CXT))
+		return 0;
+
+	(void)feature_flags;
+	if (req->cxt_start > req->cxt_end)
+		return -EINVAL;
+	if (req->cxt_start >= max_cxts || req->cxt_end >= max_cxts)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_amd_qos_validate_fnupd_req);
+
+int sdxi_amd_qos_validate_tel_req(const struct sdxi_amd_qos_tel_req *req,
+				  u16 max_pools, u16 max_vfs, u32 max_cxts,
+				  u16 feature_flags)
+{
+	if (!req)
+		return -EINVAL;
+	if (req->rsvd0[0] || req->rsvd0[1] || req->rsvd0[2])
+		return -EINVAL;
+
+	switch (req->query_type) {
+	case SDXI_AMD_QOS_TEL_QTYPE_DEVICE:
+	case SDXI_AMD_QOS_TEL_QTYPE_ACTIVE_POOLS:
+		return 0;
+	case SDXI_AMD_QOS_TEL_QTYPE_POOL_CONFIG:
+	case SDXI_AMD_QOS_TEL_QTYPE_POOL_REPORT:
+	case SDXI_AMD_QOS_TEL_QTYPE_POOL_VARIANCE:
+		if (!max_pools || req->pool_num >= max_pools)
+			return -EINVAL;
+		return 0;
+	case SDXI_AMD_QOS_TEL_QTYPE_POOL_ASSIGN:
+		if (req->flags & SDXI_AMD_QOS_TARGET_F_VF) {
+			if (!max_vfs || req->vf_num >= max_vfs)
+				return -EINVAL;
+		}
+		if (!(req->flags & SDXI_AMD_QOS_TARGET_F_CXT))
+			return 0;
+		if (!(feature_flags & SDXI_AMD_QOS_FEATURE_FLEXIBLE_POOL_SCOPE))
+			return -EOPNOTSUPP;
+		if (req->cxt_num >= max_cxts)
+			return -EINVAL;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_amd_qos_validate_tel_req);
diff --git a/drivers/dma/sdxi/amd/qos.h b/drivers/dma/sdxi/amd/qos.h
index e5e3e5cf9a50..09c5ee417d9c 100644
--- a/drivers/dma/sdxi/amd/qos.h
+++ b/drivers/dma/sdxi/amd/qos.h
@@ -81,8 +81,8 @@ struct sdxi_amd_qos_tel_req {
 
 u64 sdxi_amd_qos_query_selector(u16 cxt_num, u8 query_type);
 u32 sdxi_amd_qos_align_bw(u32 bw, u32 granularity);
-int sdxi_amd_qos_validate_devupd_req(u32 device_maxbw, u32 total_allocated_bw,
-				     u32 granularity_bw);
+int sdxi_amd_qos_validate_devupd_req(u32 device_maxbw, u32 device_maxbw_cap,
+				     u32 total_allocated_bw, u32 granularity_bw);
 int sdxi_amd_qos_validate_poolupd_req(const struct sdxi_amd_qos_poolupd_req *req,
 				      u16 max_pools, u32 granularity_bw);
 int sdxi_amd_qos_validate_fnupd_req(const struct sdxi_amd_qos_fnupd_req *req,
-- 
2.56.1

