Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120173;
	b=HSsLcVbX8UHuqeiV/tcncm00p37q03EXwklbtbEXAY43Fnl9VcCIc1rRVChjPa56s/hl
	 rkdLn9sumCeEark4Mv1HI8bpKsc3xrOHLcq6hYr6z2BwkU8W240pwtsvAAZExe18K+rI/
	 LRHT+xM+2tGVHTTcEjUbGyBDL+ipIvFhNq035ro8rtQrB/IX+FSH07O03MeYiTitnNvbW
	 6+DTfwPb/n2D+z7cDCevdVx5ShCxPwRpfSBjM/Tbes+ZgTBon2S2G21wGjLxHqh3pVWol
	 K2IBt6ww8TPP94gDBhuG/k1ndiQ+cgBaiZPzOzOoIy6aimfuqvDXvTYIvJxBH9ah/jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120173;
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
	bh=v2slYim12y1qFGu+XtFXIB5B3SSyMkzTIWy6Pa34qvA=;
	b=FoMHVDGXmJ1tPJb+JDGkkr9LD1YVPmX5LTAn5VzibjUE4U20M3E3x/Ne1DkJf5zXigk/
	 I1hqFtUNhyFkWPWKX9fvUWBzjsUOmI/Mlhj6p1GEJjzDEWxj46QV5RI7qdOJvWNeSfw6b
	 E5xwoHDIf8NjKHnyIv6ETH2wOxL4uoVFAp676gvG6P+gc3ia++fGdelISYbikdnqoZXtJ
	 JCkoKVKVQ34IBl2zNUuPXAjXU4RGXoBwsiQaCBBJvBFVPOeLkNtlQqwBA7LgIpPs8XGa+
	 FNdcX6qy9tU7wSh3Uf4SvRoV83OmqRiOvxHdmrVnaz1q48vRcvhNNJSTNeUoHtkEDXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hIVXCa4t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.8
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB50E606A324;
	Thu, 19 Nov 2026 20:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB50E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hIVXCa4t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzRZGjb2TmyWIN2Mo1+5o73OnVxhzycvnQlclLj2odcFj4F29AqXR7Hh7skawdH5MQUfIDTgUJFZq2uVRpykbN3IJ5puowoyj0SLWC6HO4vLOrcecf+vR79zqlEB2zko7VNHef6pdSok9PxKReqob/sASzEP46kErPf0umb+qkxdGz/PXpw/qu8nKUVFGhPzgcxZ1jZFRI1EprUBnCBOofoCr9wjvf0RiyhrehioZUJdi6je3NaIdgcubv9Gxm2NHD+cXqKhnoyHC2IBI64QIvK7IjTajlGCrcZsuXZP+lAv79osWQXfZ+0+15sHphjeWHUGqnv0t3jzQPyfikcv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2slYim12y1qFGu+XtFXIB5B3SSyMkzTIWy6Pa34qvA=;
 b=U5Pb5NP+Ud4xITC+8Buv+CykIeAXfHOAK9zPI9yWHD8KBFg44wYd0JMJT3MIHPioFsYc8BGMbkd8TAmp0yrJlLwvCIqLZSMvn5YgkorsWzHoZU32RUebN2pY67u4l5T5csEKOm9vQSCdekclBO7F9OmeDTWfEbWq/btvI0teyCeVA5YiB+hg32yBp4Pm3airSnU7koKZmuqRFC7gyU3dbxQdYKKHZwCsqlpWua2skcyFMTKsf0x8RvBRHRsJukta33o1Upt0eBCbWTsXPYEuNefaSOf+0uS6KIAfFLnlYoshTmMgqrm6d2aAkyI95t52Ba12kb69GKxN6sQqcKm27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2slYim12y1qFGu+XtFXIB5B3SSyMkzTIWy6Pa34qvA=;
 b=hIVXCa4t9IG2XnpGa3RRTNhaZP/Ux/8z7FxUNTMbLIR2BuCA8Sd6zBsYiIWRjI5uBENIIaaV1aWjEuJZtoxRbIwt6wUYOeJIgP6tbZVnZWFJzO5cRtud1TNCjorLqoEdgs9UX0DpwVtwSSwC+1HVZAMgF5v4hl64bv604wW0m9I=
Received: from CY8PR12CA0031.namprd12.prod.outlook.com (2603:10b6:930:49::9)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:29:22 +0000
Received: from CY5PEPF00000E81.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::27) by CY8PR12CA0031.outlook.office365.com
 (2603:10b6:930:49::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 20:29:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E81.mail.protection.outlook.com (10.167.247.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:29:22 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:29:21 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 28/44] dmaengine: sdxi: amd: define QoS request formats
Date: Thu, 19 Nov 2026 14:23:04 -0600
Message-ID: <20261119202321.1734355-29-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E81:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: c507a117-e606-4920-d571-08df467bcbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|7416014|376014|22082099003|18002099003|261009223027099003|261102124527099003|11063799006|56012099006|10067099003|261102123227099003|261021121427099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	MacdXzLEe4VpOFeJcGcqCR5QZ5eZ8xEcbLYZpTeH0aHJ2y7vnVf/2VQgUsZK+eiXTTyQaV7av8vLhfgJmbWmdgxf8X3C2oN3BJZOtd/dwpFP95E1t3NwIxFkyapgu0iJu+8ZZfEvtostWcpBdfmyJBELMqPiShgyXXS1Ly7EWkHb86udLxXoh7MbFsPmv15voWDyZsK6IV/O0hitQ7EOlY+vXwhcWl27J5iXD00QlH+I3TB8GkqOsHfKqNiEQQy0cKeNXQ6Pto7HwWGGI3ICgs5sTDxPY4M45PKXd/k9LCVMnaMzc7rGhr4yC4/II7aO4zYJg/jOSkmrOrWabI+MoKMC7RwtTjG9JFSK00q6WvdzgL6OXlv0PD8z+nYrO3JIYdpRLzT0npguo6bAtjWKCeUv0AtGvVB+3RX4zFFObqt6um6jJxX0nolGKigcA2PZYq+R/hjasV5eaWqiZgivE6oVjEgolwyC1EDhjMpKmn50rAUCOeELujrJZ/Tx7DaBt2Y7NYBNApOup8SuaAoht9LHioYmfnwWXceqFAjBpVJx2qqgf01D0tYgY50bypL8begkKakA10LTt4CBPZ7ajw/1vYHoVKfls22k7TkPOCuhpMy8vj5+ZitJ6lOWTi+D3HVB7j4nVv718YpSz01o73lBtSk9NcDR3BIs71QoShSEM8ZAHybSIr4wErcsJMsUdYt48WOyv03jt+mEDkYLow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(376014)(22082099003)(18002099003)(261009223027099003)(261102124527099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261021121427099003)(261022075727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UQJ9a1AGLglEXbi9qoMs4IS2de6NYO77uaAXVOL8IPbc42RMGVZQRgBT8HBXCuNYnCMlFXPvnSPUgcMkjTGJGbdUUAzaisYC3G8I3UYneROEQ1OnxjQdSmhNVe18YvtVhNNb0IReLNodAFhuNhdCRlEblEZA0bjHKsh3UCXp7tDZ+4UumR0MwlAQc8zIJ9ig2nD/67Lwuuj/WzCNERANbp8FUQvs7TXZhEfEkWxr5I0+mlOmajvV+C/nW8eOXP5N/id1yUgE4T1PbL4lhY3K3vtyuCTeQ/h21JMwiRbQVi6iOJGlM1y+1xnRt/KQ24nn6RjHA4eDNtzofkos1f9b8oXd/AhIdbytWkgupFzknXUqOprrextEWgYnixq4ro5wPfJZuu0Ecp0HdyQeaDCxAf0t/6leBneWQyQXiUfwBh8eSDnpT0gczgNcbzcc9hYz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:29:22.2135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c507a117-e606-4920-d571-08df467bcbbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E81.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

AMD QoS monitors and controls resource utilization through the SDXI
physical function (PF). Add AMD QoS vendor request formats, operation
identifiers, and helper prototypes for code introduced later.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/amd/qos.h | 95 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 drivers/dma/sdxi/amd/qos.h

diff --git a/drivers/dma/sdxi/amd/qos.h b/drivers/dma/sdxi/amd/qos.h
new file mode 100644
index 000000000000..e5e3e5cf9a50
--- /dev/null
+++ b/drivers/dma/sdxi/amd/qos.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD SDXI QoS internal definitions.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DMA_SDXI_AMD_QOS_H
+#define __DMA_SDXI_AMD_QOS_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+enum sdxi_amd_qos_admin_vendor_op {
+	SDXI_AMD_QOS_ADMIN_OP_CAP = 1,
+	SDXI_AMD_QOS_ADMIN_OP_DEVUPD = 2,
+	SDXI_AMD_QOS_ADMIN_OP_POOLUPD = 3,
+	SDXI_AMD_QOS_ADMIN_OP_FNUPD = 4,
+	SDXI_AMD_QOS_ADMIN_OP_TEL = 5,
+};
+
+enum sdxi_amd_qos_admin_target_flags {
+	SDXI_AMD_QOS_TARGET_F_CXT = BIT(0),
+	SDXI_AMD_QOS_TARGET_F_VF = BIT(1),
+};
+
+enum sdxi_amd_qos_feature_flags {
+	SDXI_AMD_QOS_FEATURE_DYNAMIC_POOL_RECONFIG = BIT(0),
+	SDXI_AMD_QOS_FEATURE_DYNAMIC_POOL_REASSIGN = BIT(1),
+	SDXI_AMD_QOS_FEATURE_TEL_TIMESTAMPS = BIT(2),
+	SDXI_AMD_QOS_FEATURE_FLEXIBLE_POOL_SCOPE = BIT(3),
+};
+
+struct sdxi_amd_qos_devupd_req {
+	u32 device_maxbw;
+};
+
+struct sdxi_amd_qos_poolupd_req {
+	u16 pool_num;
+	u8 pool_operation;
+	u8 rsvd0;
+	u32 pool_maxbw;
+	u32 pool_minbw;
+};
+
+struct sdxi_amd_qos_fnupd_req {
+	u16 pool_num;
+	u16 flags;
+	u16 vf_num;
+	u16 cxt_start;
+	u16 cxt_end;
+	u16 rsvd0;
+};
+
+struct sdxi_amd_qos_tel_req {
+	u16 pool_num;
+	u16 flags;
+	u16 vf_num;
+	u16 cxt_num;
+	u8 query_type;
+	u8 rsvd0[3];
+};
+
+/* AMD SDXI Quality-of-Service Extensions (ASQOSE). */
+#define SDXI_AMD_QOS_DSC_SUBTYPE_CAP		0x00
+#define SDXI_AMD_QOS_DSC_SUBTYPE_DEVUPD		0x01
+#define SDXI_AMD_QOS_DSC_SUBTYPE_POOLUPD	0x02
+#define SDXI_AMD_QOS_DSC_SUBTYPE_FNUPD		0x03
+#define SDXI_AMD_QOS_DSC_SUBTYPE_TEL		0x04
+
+#define SDXI_AMD_QOS_TEL_QTYPE_DEVICE		0x0
+#define SDXI_AMD_QOS_TEL_QTYPE_POOL_CONFIG	0x1
+#define SDXI_AMD_QOS_TEL_QTYPE_POOL_ASSIGN	0x2
+#define SDXI_AMD_QOS_TEL_QTYPE_ACTIVE_POOLS	0x3
+#define SDXI_AMD_QOS_TEL_QTYPE_POOL_REPORT	0x4
+#define SDXI_AMD_QOS_TEL_QTYPE_POOL_VARIANCE	0x5
+
+#define SDXI_AMD_QOS_POOL_OP_CREATE		0x0
+#define SDXI_AMD_QOS_POOL_OP_UPDATE		0x1
+#define SDXI_AMD_QOS_POOL_OP_DESTROY		0x2
+
+u64 sdxi_amd_qos_query_selector(u16 cxt_num, u8 query_type);
+u32 sdxi_amd_qos_align_bw(u32 bw, u32 granularity);
+int sdxi_amd_qos_validate_devupd_req(u32 device_maxbw, u32 total_allocated_bw,
+				     u32 granularity_bw);
+int sdxi_amd_qos_validate_poolupd_req(const struct sdxi_amd_qos_poolupd_req *req,
+				      u16 max_pools, u32 granularity_bw);
+int sdxi_amd_qos_validate_fnupd_req(const struct sdxi_amd_qos_fnupd_req *req,
+				    u16 max_pools, u16 max_vfs, u32 max_cxts,
+				    u16 feature_flags);
+int sdxi_amd_qos_validate_tel_req(const struct sdxi_amd_qos_tel_req *req,
+				  u16 max_pools, u16 max_vfs, u32 max_cxts,
+				  u16 feature_flags);
+
+#endif /* __DMA_SDXI_AMD_QOS_H */
-- 
2.56.1

