Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119861;
	b=wBugcRI3dBqtKPVyYXfSuA5v2RRTL3mCz3Ui1u8yASzFycerTkBOgtOiEDgl1y2xXfUs
	 0Qzvth7NQoJgXWMcX4gupOWm7jBitex25t0cFm084oqcxlgxpvYDhA4W0yWF3fMMoCWPs
	 hZ8d4PmdLHB7jxLzeUXUJ57kVS1eBErY7DRROHtcuxfpTEgPViZhUJYjjiZSJsBaW63Y4
	 0/ymWTHPV2ZcYvG5gXKBlJVM3vW+/B9qxuZNgf4prIRNz0OAqwc8LTpssx2i6zM/i2+SI
	 OGsNa+3SuoXI+tydn3hf0YE5TD3iB7K72IfuymFxWSrwACWDPVv6wT89YuIouXJUx7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119861;
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
	bh=/HmkpyDMQL9c3U/vW6soMy2lZR/DN1XlJL+PAfRTvKA=;
	b=fGNw4Dl5Pbbdh+B3uTgjIWEaMBUf9qdgMhosK8F2mRRBZ0SQdzveYj9jow4oZZDvnqlR
	 gIjkb8Lsz9bxLzqiJhmkhBAqBgxwwy4HpDmhDjxG9RVE1ch2oLi1y3UIfpADOxlIZ79r9
	 ODPRgL7lcqYjYjNNOcZ4Mk8V3+xoiAc+N+VjDeF2vv8amnfZ9FjjKAytv+XNJeC0qb8St
	 JFaRzKZJZd2uQ55EWJj4s5EGHztlbbKkM4dgY81hiiITwib9s7P5FdqgLhcdiiyaYcXCM
	 9Vw+zI/AVsuiYpfO6HqEbRbXuBk4M0wQcTG3LzQJ0KTNqQLYIyYB8d6HtQw4Jc/pD0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eklz8O6d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.47
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54D606A324;
	Thu, 19 Nov 2026 20:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF54D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eklz8O6d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEnROBJS5AD4xT7JkQSEJ7zmB7a8r1FA8KZqBg19yvaeLW3Xuhn7PRwbMjiFavEHBQYtdKqWwV8QeuCkcIuM0yQvDMrciAV0bimHmWTGg13WiYUCpTKpk2KlGNYuIAPyt82SAKgFqu8Fk73By2dcZZP+5MoyML59/fTRiBO6wkUoeaskUAAVbTfMgqAeG/kFe9J3POuw5Q/cmaN+ZHtKQ5xoRyewFngDpArNp7f0l9pzlkkBseaweA2rDplQO4xA3PBuYnBkWxqTI39Q1o5pub6RxZ944RCSuBwV4asWYkvx7sRZHg9t2elbOEHQOraTrCkFMQvR1O9rdSnqjkJ/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HmkpyDMQL9c3U/vW6soMy2lZR/DN1XlJL+PAfRTvKA=;
 b=pR4eehWm0PaYiuAd0GnL6W3CzU3rBNNxACULu5rnICY9yqO+pAVwNAzDPkcdSDqJWY50H7AHF9jQY6g471YSJKASaZn5XTwxcbRGMPCoWcvJ9Tw4wLigxQ/FQBb3mgO5JDK4CJ7JZcV/fI3qJ3LMj+W5pfwxrWmV9svnGVW5vLMezk/8eS8sZRtLuK8eIJwo4v6kH5oiMy8q3KYUDYv5fb9PsuOFE9zQRV4aSb9Tqagi6hOmYPucVZG1mRPgq8S+RoE1IhEoIEbd/kFUV4umThlI9uhZ0T2k546T28wqbuAiOAjgTGglQYfKO/4TpcjCcuEBRulB0epJWov8ZGgYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HmkpyDMQL9c3U/vW6soMy2lZR/DN1XlJL+PAfRTvKA=;
 b=eklz8O6dRU9Dg8U18DMoBNr9jV9+tls2mzHSwgej2A2FdWIQpofRqJIjM8HQRvz0rVSwSBEHaCcGsBe7Dl47O41IfNlkfe7Dir1yYJ76jjGLvo0QVZZUEOcY27IsskD9Lg4YlmxYLVrNqQbP6LEQizZ2tuvoQT1DQUZSpbGoZlk=
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by CHAPR12MB999250.namprd12.prod.outlook.com (2603:10b6:610:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:24:15 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::47) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.2 via Frontend Transport; Thu, 19
 Nov 2026 20:24:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:24:15 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:24:14 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 04/44] dmaengine: sdxi: encode admin descriptors
Date: Thu, 19 Nov 2026 14:22:40 -0600
Message-ID: <20261119202321.1734355-5-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|CHAPR12MB999250:EE_
X-MS-Office365-Filtering-Correlation-Id: b3183eb3-9d70-4fbb-8f3a-08df467b14f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|7416014|1800799024|18002099003|22082099003|261009223027099003|261102123227099003|56012099006|261026121527099003|11063799006|10067099003|261102130727099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	LuQRHhAP5a5WIUdk5kPqLteYNU/CfHU/5Sj5y6NZ/57SY0EgXpp01tlCkAH1vX54CunrZQzOUPHGMuouc7GjnNP1HLYKpCRtIcycG9wkeYZOojXG2ma6VlWNa/lP8nvMMAhL9/vRChF51Kv+9USCFRIBfGSGNbSJrCO7NMQGu2tROeOr4gWUSvef2sP1KwbUMzCthiqTc1QMNsmzxkxcjAgmJXFNKZzErvkyqfCGV+wjZmbRrHmZAkZj68JrvR6p8Taz9amRilVsLcMjNS9ofAuey7igUZr1+VMfyOrBncUWhQ5nkVpQAV/8L25cM03XcwMNeTyffhFFb0z2yE+1B50mCc3eJqA0Wq7rrQ7k2P6LDqWSUP5qJUDJPWXSPiWCE9BcyIzlpwIVQcQJe/YgiHFMorK/yE96Vv8Q6oNiVaBa2PDXS6YudNbyJByPUs9cXkkKK8rixMb8Mt5ImtnIV8/5UUU1IJDff6x5gD5NXB61f5cGuxlhYPf4xTtcJl8H4XPXn7c2Xe3+VSOzOrjqVDvxYjrCL6XR79X8WFGff8Yb903VbAyI6GbZ/hmS7gjuIaaGg4Yg85vsCUz50sHjMyV1XgwZUvRT+yQzCLWYrDmgMzaECcD1O8DQbAi4NMOkez5eXnz3HEO5l0pAmPeXYUKEU/hgeCv5hfQJkCPxF/ImlhxLngyDQDH9u9/YPO5oaiSKXpVQKoz1vLaRCok62w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(7416014)(1800799024)(18002099003)(22082099003)(261009223027099003)(261102123227099003)(56012099006)(261026121527099003)(11063799006)(10067099003)(261102130727099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4mGMyqLiZ+WyrC0BdpASSb2XwszUn8/zsXYEoHog47C1g/ShAV8KZUnjYrQaFHx52zeGyta1jVIeF/j4xeShgpD0ywDQUY20PEd1fFzmK9RHzk8VM8J54XX1nPhlW+JXFuhtnQ0txB6auGQC80dXQkNP+54pvaLWP8QeIVqjGTad1bru1LZ4MynqY/pn0Jv0Ims2CJDfFOUfwV5q/4yBo8YQrH285tOIE04bIZj1vxMDzjz/hq02GRZ++9G820NIv5Nc3TuhV0Pe4+Aj4+hL8AmlVGT6SgFtUV1vJsHYHPxRa49Y50ZNUkojbqI7tZz0rJsAWV+e/HoyYs/Elx0ym4if2mujXPEnwutOuSMfJFkn1867vgnxCOpTNzFHpSuxIwVR1SteCbHzn/armhz0wKlWWdXtkuYgt1i2NLsoEEJFjM+c6DGadiZ8NbuGY4nY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:24:15.5418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3183eb3-9d70-4fbb-8f3a-08df467b14f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999250

Extend the existing descriptor helpers with key-range synchronization,
along with new AKey and RKey update operations. Also introduce a
descriptor discovery helper based on SDXI 1.1 Spec. For each layout
and validation path, add independent packing-based kunit tests.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/descriptor.c       |  89 +++++++++++++++++
 drivers/dma/sdxi/descriptor.h       |  27 +++++
 drivers/dma/sdxi/descriptor_kunit.c | 150 ++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)

diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
index 25b5d2862e79..5aa1752b0222 100644
--- a/drivers/dma/sdxi/descriptor.c
+++ b/drivers/dma/sdxi/descriptor.c
@@ -7,6 +7,7 @@
 
 #include <kunit/test-bug.h>
 #include <kunit/visibility.h>
+#include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/range.h>
@@ -211,6 +212,8 @@ int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params)
 			.cflags = cflags,
 			.cxt_start = cpu_to_le16(params->range.cxt_start),
 			.cxt_end = cpu_to_le16(params->range.cxt_end),
+			.key_start = cpu_to_le16(params->key_start),
+			.key_end = cpu_to_le16(params->key_end),
 			.csb_ptr = cpu_to_le64(csb_ptr),
 		},
 	};
@@ -218,3 +221,89 @@ int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params)
 	return 0;
 }
 EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_sync);
+
+int sdxi_encode_disc(struct sdxi_desc *desc, const struct sdxi_disc *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+
+	if (params->index_start > params->index_end)
+		return -EINVAL;
+	if (params->index_end > 2047)
+		return -EINVAL;
+	if (!IS_ALIGNED(params->addr, 16))
+		return -EINVAL;
+
+	opcode = FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_DISC) |
+		 FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN);
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.disc = (typeof(desc->disc)) {
+			.opcode = cpu_to_le32(opcode),
+			.index_start = cpu_to_le16(params->index_start),
+			.index_end = cpu_to_le16(params->index_end),
+			.addr = cpu_to_le64(params->addr),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_disc);
+
+int sdxi_encode_akey_upd(struct sdxi_desc *desc,
+			 const struct sdxi_akey_upd *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+
+	if (params->range.cxt_start > params->range.cxt_end)
+		return -EINVAL;
+	if (params->akey_start > params->akey_end)
+		return -EINVAL;
+
+	opcode = FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_AKEY_UPD) |
+		 FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN);
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.akey_upd = (typeof(desc->akey_upd)) {
+			.opcode = cpu_to_le32(opcode),
+			.cxt_start = cpu_to_le16(params->range.cxt_start),
+			.cxt_end = cpu_to_le16(params->range.cxt_end),
+			.akey_start = cpu_to_le16(params->akey_start),
+			.akey_end = cpu_to_le16(params->akey_end),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_akey_upd);
+
+int sdxi_encode_rkey_upd(struct sdxi_desc *desc,
+			 const struct sdxi_rkey_upd *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+
+	if (params->rkey_start > params->rkey_end)
+		return -EINVAL;
+
+	opcode = FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_RKEY_UPD) |
+		 FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN);
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.rkey_upd = (typeof(desc->rkey_upd)) {
+			.opcode = cpu_to_le32(opcode),
+			.rkey_start = cpu_to_le16(params->rkey_start),
+			.rkey_end = cpu_to_le16(params->rkey_end),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_rkey_upd);
diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
index cf071a281941..a1c3b6cf243b 100644
--- a/drivers/dma/sdxi/descriptor.h
+++ b/drivers/dma/sdxi/descriptor.h
@@ -138,8 +138,35 @@ struct sdxi_sync {
 		SDXI_SYNC_FLT_FN   = 0x4,
 	} filter;
 	struct sdxi_cxt_range range;
+	u16 key_start;
+	u16 key_end;
 };
 
 int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params);
 
+struct sdxi_disc {
+	u16 index_start;
+	u16 index_end;
+	dma_addr_t addr;
+};
+
+int sdxi_encode_disc(struct sdxi_desc *desc, const struct sdxi_disc *params);
+
+struct sdxi_akey_upd {
+	struct sdxi_cxt_range range;
+	u16 akey_start;
+	u16 akey_end;
+};
+
+int sdxi_encode_akey_upd(struct sdxi_desc *desc,
+			 const struct sdxi_akey_upd *params);
+
+struct sdxi_rkey_upd {
+	u16 rkey_start;
+	u16 rkey_end;
+};
+
+int sdxi_encode_rkey_upd(struct sdxi_desc *desc,
+			 const struct sdxi_rkey_upd *params);
+
 #endif /* DMA_SDXI_DESCRIPTOR_H */
diff --git a/drivers/dma/sdxi/descriptor_kunit.c b/drivers/dma/sdxi/descriptor_kunit.c
index fdca024e3e31..c5f3c9eb6224 100644
--- a/drivers/dma/sdxi/descriptor_kunit.c
+++ b/drivers/dma/sdxi/descriptor_kunit.c
@@ -163,6 +163,54 @@ static const struct packed_field_u16 cxt_upd_subfields[] = {
 	cxt_upd_field(95, 80, cxt_end),
 };
 
+/* DSC_AKEY_UPD */
+struct unpacked__akey_upd {
+	u16 cxt_start;
+	u16 cxt_end;
+	u16 akey_start;
+	u16 akey_end;
+};
+
+#define akey_upd_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__akey_upd, _member)
+
+static const struct packed_field_u16 akey_upd_subfields[] = {
+	akey_upd_field(79, 64, cxt_start),
+	akey_upd_field(95, 80, cxt_end),
+	akey_upd_field(111, 96, akey_start),
+	akey_upd_field(127, 112, akey_end),
+};
+
+/* DSC_RKEY_UPD */
+struct unpacked__rkey_upd {
+	u16 rkey_start;
+	u16 rkey_end;
+};
+
+#define rkey_upd_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__rkey_upd, _member)
+
+static const struct packed_field_u16 rkey_upd_subfields[] = {
+	rkey_upd_field(111, 96, rkey_start),
+	rkey_upd_field(127, 112, rkey_end),
+};
+
+/* DSC_DISC */
+struct unpacked__disc {
+	u16 index_start;
+	u16 index_end;
+	u64 addr;
+};
+
+#define disc_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__disc, _member)
+
+static const struct packed_field_u16 disc_subfields[] = {
+	disc_field(42, 32, index_start),
+	disc_field(58, 48, index_end),
+	disc_field(191, 132, addr),
+};
+
 /* DSC_GENERIC */
 struct unpacked_desc {
 	u64 csb_ptr;
@@ -182,6 +230,9 @@ struct unpacked_desc {
 		struct unpacked__cxt_start cxt_start;
 		struct unpacked__cxt_stop cxt_stop;
 		struct unpacked__cxt_upd cxt_upd;
+		struct unpacked__akey_upd akey_upd;
+		struct unpacked__rkey_upd rkey_upd;
+		struct unpacked__disc disc;
 	};
 };
 
@@ -234,6 +285,9 @@ define_unpack_fn(sync)
 define_unpack_fn(cxt_start)
 define_unpack_fn(cxt_stop)
 define_unpack_fn(cxt_upd)
+define_unpack_fn(akey_upd)
+define_unpack_fn(rkey_upd)
+define_unpack_fn(disc)
 
 static void desc_poison(struct sdxi_desc *d)
 {
@@ -489,6 +543,8 @@ static void sync(struct kunit *t)
 	struct sdxi_sync sync = {
 		.filter = SDXI_SYNC_FLT_STOP,
 		.range = sdxi_cxt_range(1, U16_MAX),
+		.key_start = 2,
+		.key_end = 3,
 	};
 	struct sdxi_desc desc;
 	struct unpacked_desc unpacked;
@@ -503,6 +559,97 @@ static void sync(struct kunit *t)
 	KUNIT_EXPECT_EQ(t, unpacked.sync.flt, SDXI_SYNC_FLT_STOP);
 	KUNIT_EXPECT_EQ(t, unpacked.sync.cxt_start, 1);
 	KUNIT_EXPECT_EQ(t, unpacked.sync.cxt_end, U16_MAX);
+	KUNIT_EXPECT_EQ(t, unpacked.sync.key_start, 2);
+	KUNIT_EXPECT_EQ(t, unpacked.sync.key_end, 3);
+}
+
+static void akey_upd(struct kunit *t)
+{
+	struct sdxi_akey_upd update = {
+		.range = sdxi_cxt_range(3, 5),
+		.akey_start = 7,
+		.akey_end = 11,
+	};
+	struct unpacked_desc unpacked;
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_akey_upd(&desc, &update));
+	unpack_akey_upd(&unpacked, &desc);
+
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_AKEY_UPD);
+	KUNIT_EXPECT_EQ(t, unpacked.akey_upd.cxt_start, 3);
+	KUNIT_EXPECT_EQ(t, unpacked.akey_upd.cxt_end, 5);
+	KUNIT_EXPECT_EQ(t, unpacked.akey_upd.akey_start, 7);
+	KUNIT_EXPECT_EQ(t, unpacked.akey_upd.akey_end, 11);
+
+	update.range = (struct sdxi_cxt_range) {
+		.cxt_start = 2,
+		.cxt_end = 1,
+	};
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_akey_upd(&desc, &update));
+
+	update.range = sdxi_cxt_range_single(1);
+	update.akey_start = 2;
+	update.akey_end = 1;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_akey_upd(&desc, &update));
+}
+
+static void rkey_upd(struct kunit *t)
+{
+	struct sdxi_rkey_upd update = {
+		.rkey_start = 13,
+		.rkey_end = 17,
+	};
+	struct unpacked_desc unpacked;
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_rkey_upd(&desc, &update));
+	unpack_rkey_upd(&unpacked, &desc);
+
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_RKEY_UPD);
+	KUNIT_EXPECT_EQ(t, unpacked.rkey_upd.rkey_start, 13);
+	KUNIT_EXPECT_EQ(t, unpacked.rkey_upd.rkey_end, 17);
+
+	update.rkey_start = 2;
+	update.rkey_end = 1;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_rkey_upd(&desc, &update));
+}
+
+static void disc(struct kunit *t)
+{
+	struct sdxi_disc discovery = {
+		.index_start = 1,
+		.index_end = 31,
+		.addr = 0x12340,
+	};
+	struct unpacked_desc unpacked;
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_disc(&desc, &discovery));
+	unpack_disc(&unpacked, &desc);
+
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_DISC);
+	KUNIT_EXPECT_EQ(t, unpacked.disc.index_start, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.disc.index_end, 31);
+	KUNIT_EXPECT_EQ(t, unpacked.disc.addr, 0x1234);
+
+	discovery.index_start = 2;
+	discovery.index_end = 1;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_disc(&desc, &discovery));
+
+	discovery.index_start = 0;
+	discovery.index_end = 2048;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_disc(&desc, &discovery));
+
+	discovery.index_end = 1;
+	discovery.addr = 0x12341;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_disc(&desc, &discovery));
 }
 
 static struct kunit_case generic_desc_tcs[] = {
@@ -513,6 +660,9 @@ static struct kunit_case generic_desc_tcs[] = {
 	KUNIT_CASE(cxt_stop),
 	KUNIT_CASE(cxt_upd),
 	KUNIT_CASE(sync),
+	KUNIT_CASE(akey_upd),
+	KUNIT_CASE(rkey_upd),
+	KUNIT_CASE(disc),
 	{}
 };
 
-- 
2.56.1

