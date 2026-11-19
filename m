Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120244;
	b=SYKwYSMj9B53QmWf/xO1y/DNG8aFAP4F80Fiyby00xPApM+T/Qp5mOcr2VdLRWPlBayz
	 Z+Ov2fbQ+NpZn2nronrkhJW8LMQDvf290vlpER99JEJryubfl2mPMlWBtsJyZBB+sOAHx
	 R5W0TB8oeDBbdTMYLJBdpsdiYKR1eWTkdHQpmFcdQory3l5eFZUdIgC0SDS24Vbv0zIWa
	 oJKWSZVtzujccB8KGHj6H/s5cQMmSRjrXg90eVTdFGiOTBpfDNWyCJa+YHnFF9n7SRxHw
	 TNhUA/UnH8n0nQxbMQvt8Kiczc2kMGtPkKXAmNVIQoqMkcuGXCowSl6oH11IFTHtTrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120244;
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
	bh=NjmIqHflQ+F26H8TINkAyz/+kKSSHovVqt0YJ9gpK+o=;
	b=Sn+67YS/rkqy+AugXKET8mWXTgFVWEM6wZKaHrvXji/ityNEufkqbIYWjEpIEErHmbxS
	 xli7qu5QNxs7FMEy8uxXEzQPYy8uuluk90nZuitLPiVMmpmpvui+Y2yUtPr1A6RgdARRP
	 YtZ6o5+KDczGR8fng7ZGLGIZsYBilHHVw+OsRnzNmWqYzRrwtr9OrOWdq/as0EqcMfkEh
	 bA1oLfYQ5hyQfp1wzhuCvMUpEq/uX9+suzTJj11Y9wqP1EIrvlbJAdEx/AUm4zBrsV+p+
	 mRc1462Z4wBpMIbf6sb8w5I3m+dzwZcADS5q8KTvBNoBIiUtc8j1Kyvx9O1TXsa4VUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kmWMKogG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E4606A326;
	Thu, 19 Nov 2026 20:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 670E4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kmWMKogG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoDJfIgzWcz3gkqVEHEgjWW7rL1Wp2B0A4KR1g4Y5FF1A8rRxi/It+R7GbgpvJ/su/ca9HYZlexzCC3nXIbt6PHWtU9ilmW+tIi6167T12BzH1whvrqQ0dp9RK8cJdeiK4IPqOnpiXZ6eByuoDBRC2HX0okCJerf4EArMR/yqxOaolQ4bi8Gy0w/ANhFKG79zgYEnf1x71JkZvB4uzolCPQgWM38VYHtpxDq8Rr6kOdUq/aUQ3j68PqNEg12slK/CYPp6Dc3kE7bKJ49yEXQ/8saNDnXJCLkqBc7uBPu7K/hNGtm+A+ih7sRkYU2fK3HYJnAHrc3nwu1rh8Ez3UCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjmIqHflQ+F26H8TINkAyz/+kKSSHovVqt0YJ9gpK+o=;
 b=A7m/GOGYyAKeY0homNH2xKDFfQiGNveqsCnG8rHYHyl/+DBPqWH7Ue175LlUBz1CxMIzm2OnF3r0lt/IFUbXTgH9WJdZkovlvduhTzqW7a1gMCfzzYBiVF8isVbkxht0q6nzlIm0Thh6cluVe7abgQuQJ4XWYAc2ThCd9bU6TDQCX0Sl55+bk+pwE/yyMzEftXDwciOCPkQhriC8j2krY1g6Sn3LflUF/oaBQCbmgKwzrqz0zYEoYsi69PwD8Qdk3LFW4wy0pxxt/sI71C8kDoXFlW0kP7yxRFZoPymPcTGiXn7Q2Ku+Q/93AW4/DAsnmolnuYd5KzeVGfy5DPGkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjmIqHflQ+F26H8TINkAyz/+kKSSHovVqt0YJ9gpK+o=;
 b=kmWMKogGHowrDADdRvxr3N5Ah64JAOc3YRpsiwxR8fNy6oeB4e6xBVacfcpCRGPnQlXRVlcWJq9mhCR1kxFBFDN8C3v+2CsbvhEG3vhXxd7bgncS4LJBlkvk8XBV60wuedgT2L9qUyNcAAzkW1/3WUzjS+G9mmFvwPuyH/RXa+s=
Received: from CY5PR17CA0033.namprd17.prod.outlook.com (2603:10b6:930:12::8)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 20:30:36 +0000
Received: from CY5PEPF00000E83.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::74) by CY5PR17CA0033.outlook.office365.com
 (2603:10b6:930:12::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:30:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E83.mail.protection.outlook.com (10.167.247.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:30:36 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:30:34 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 34/44] dmaengine: sdxi: amd: test QoS validation with KUnit
Date: Thu, 19 Nov 2026 14:23:10 -0600
Message-ID: <20261119202321.1734355-35-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E83:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdb9b55-9c82-4930-cea5-08df467bf7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|22082099003|18002099003|261009223027099003|11063799006|56012099006|261102130727099003|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|10067099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	aDJPdyLSCDXct9xNBQK4pT25bIIKWs94XWMH9sKUvk+Tbpu2MO2+7DhJ/jI+64n5bok25FKGrd6ImndDOTdxYmBC2ZSita0m0nSdLaHyc2o321llWPILhZjjfW0aP8XlwLEFiFyzAHw+41lv4/XW60MPQeNlHCh4AWRYtSj0jBb9yUHQ9/Wd2fWIQKhR/0p9qCx83BY4Z34Upt6JDH2k7TLGTnVEseNlRnr1BpVh/C5VpjwRnCTnXJBESnSi9YOtm1Rk1TYS2stzY2AAgWg6EPn0eCw0SAOAuVXhslpljS6Jw8cIYaLWxXBkXLf8pmjD2L4KJqr1a78rc+q8r3QmNhO60EO2PTqCBmf1gHEGjForvKGtTdarfNbY9SgJIRACujVJ+Ua7HA3jhkGrbg1iha19lcgucLK+fkdkgwG9ibH2LHki2UcYq7w8rZ0ie79Usy9gm4HWgeEn4BOfjRlquuzZhahcR6nnVLVrG+GEX5B9/2gvkD4kH82z1PnHUlVdP1/0fg9TPixOJ3qNyXeIq3w/1f/uJ0u3Ov18tae14qRv8bS7coreMDfCyL5SNgRVHhAbXfKezvXIewBmnhSXqCFRw98NKn6E5kurc3bj+bsuzOozfPtF5UcvD8L/d+7Lq0H8GsHBg8FiIymIBQ3y0+HZEsgF2igJaguzhqMogIXbaeDBjftIkxQhIAKl2bjw5+6xyc6MXDjG2QzW6c0hfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102130727099003)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(10067099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bqBui/QQ1H2+b9NzFGPaMIfzzj2N5pzGpo9/i0/J/X/53qKmwCRZ/KokJKPzNmoWt0V7sW7CQKbb0UJ4rTvwYLFfmLwehQZO/7A9cc4qGDvj3lUnxDGMqvgYVfh6OZixIQmsCOK4fjECiasSoR1FPcsfpR5RxMRiqtv6BgcYLku+aPq6JF4zAxWwcwa4w268c1XMxx5x6HWhXwgvUzgCx+UnhmpGX4xKuSyzd42lX8pj3f23H/kRaxaSNbY4NJieLOgcbh6RBAYscz3zJWuqBxg2RgC/nmYfnE1IxKofphu7O+jf+R4fxVga0BrNAssbzhwBAEqNvYlpq7n6qRuShfrmJj9S6DoSX2rzEijyfBTSKr9YOYFTcevkV7z/XwvRMsfJWgwtt5xtkhyfakR5k7FF9d/yOzGX0z4v/Q9ZwLn+FOelxgfgwovUoR3n3Y8T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:30:36.2387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdb9b55-9c82-4930-cea5-08df467bf7dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E83.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655

Add KUnit coverage for AMD QoS validation helpers. Note that hardware
execution paths still remain covered by other functional kunit tests.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Kconfig         |   5 +
 drivers/dma/sdxi/amd/Makefile    |   2 +
 drivers/dma/sdxi/amd/qos_kunit.c | 180 +++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/dma/sdxi/amd/qos_kunit.c

diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index ec89d976c3d3..fc71f1d3bc78 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -52,3 +52,8 @@ config SDXI_AMD_QOS
 	  descriptors on the admin context on behalf of userspace.
 
 	  If built as a module, this will be called sdxi-amd-qos.
+
+config SDXI_AMD_QOS_KUNIT_TEST
+	tristate
+	depends on SDXI_AMD_QOS
+	default SDXI_KUNIT_TEST
diff --git a/drivers/dma/sdxi/amd/Makefile b/drivers/dma/sdxi/amd/Makefile
index 5aee7e8a2414..7a7baad0247a 100644
--- a/drivers/dma/sdxi/amd/Makefile
+++ b/drivers/dma/sdxi/amd/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_SDXI_AMD_QOS) += sdxi-amd-qos.o
 sdxi-amd-qos-objs := qos.o
+
+obj-$(CONFIG_SDXI_AMD_QOS_KUNIT_TEST) += qos_kunit.o
diff --git a/drivers/dma/sdxi/amd/qos_kunit.c b/drivers/dma/sdxi/amd/qos_kunit.c
new file mode 100644
index 000000000000..237e9ad79b19
--- /dev/null
+++ b/drivers/dma/sdxi/amd/qos_kunit.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD SDXI QoS helper tests.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <linux/bitfield.h>
+#include <linux/module.h>
+
+#include "qos.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static void sdxi_kunit_qos_query_selector(struct kunit *t)
+{
+	u64 query_selector =
+		sdxi_amd_qos_query_selector(0x1234,
+					    SDXI_AMD_QOS_TEL_QTYPE_POOL_CONFIG);
+
+	KUNIT_EXPECT_EQ(t, (u16)0x1234,
+			(u16)FIELD_GET(GENMASK_ULL(15, 0), query_selector));
+	KUNIT_EXPECT_EQ(t, (u8)SDXI_AMD_QOS_TEL_QTYPE_POOL_CONFIG,
+			(u8)FIELD_GET(GENMASK_ULL(18, 16), query_selector));
+	KUNIT_EXPECT_EQ(t, 0U,
+			(u32)FIELD_GET(GENMASK_ULL(31, 19),
+					query_selector));
+}
+
+static void sdxi_kunit_qos_align_bw(struct kunit *t)
+{
+	KUNIT_EXPECT_EQ(t, 0U, sdxi_amd_qos_align_bw(39, 40));
+	KUNIT_EXPECT_EQ(t, 40U, sdxi_amd_qos_align_bw(40, 40));
+	KUNIT_EXPECT_EQ(t, 40U, sdxi_amd_qos_align_bw(79, 40));
+	KUNIT_EXPECT_EQ(t, 80U, sdxi_amd_qos_align_bw(80, 40));
+}
+
+static void sdxi_kunit_qos_validate_devupd(struct kunit *t)
+{
+	KUNIT_EXPECT_EQ(t, 0,
+			sdxi_amd_qos_validate_devupd_req(119, 120, 80, 40));
+	KUNIT_EXPECT_EQ(t, -EINVAL,
+			sdxi_amd_qos_validate_devupd_req(121, 120, 80, 40));
+	KUNIT_EXPECT_EQ(t, -EINVAL,
+			sdxi_amd_qos_validate_devupd_req(79, 120, 80, 40));
+}
+
+static void sdxi_kunit_qos_validate_poolupd(struct kunit *t)
+{
+	const struct sdxi_amd_qos_poolupd_req create = {
+		.pool_num = 1,
+		.pool_operation = SDXI_AMD_QOS_POOL_OP_CREATE,
+		.pool_minbw = 41,
+		.pool_maxbw = 79,
+	};
+	const struct sdxi_amd_qos_poolupd_req invalid_bw = {
+		.pool_num = 1,
+		.pool_operation = SDXI_AMD_QOS_POOL_OP_UPDATE,
+		.pool_minbw = 79,
+		.pool_maxbw = 41,
+	};
+	const struct sdxi_amd_qos_poolupd_req create_pool0 = {
+		.pool_operation = SDXI_AMD_QOS_POOL_OP_CREATE,
+	};
+	const struct sdxi_amd_qos_poolupd_req destroy_pool0 = {
+		.pool_operation = SDXI_AMD_QOS_POOL_OP_DESTROY,
+	};
+
+	KUNIT_EXPECT_EQ(t, 0,
+			sdxi_amd_qos_validate_poolupd_req(&create, 8, 40));
+	KUNIT_EXPECT_EQ(t, -EINVAL,
+			sdxi_amd_qos_validate_poolupd_req(&invalid_bw, 8, 40));
+	KUNIT_EXPECT_EQ(t, -EINVAL,
+			sdxi_amd_qos_validate_poolupd_req(&create_pool0, 8, 40));
+	KUNIT_EXPECT_EQ(t, -EINVAL,
+			sdxi_amd_qos_validate_poolupd_req(&destroy_pool0, 8, 40));
+}
+
+static void sdxi_kunit_qos_validate_fnupd(struct kunit *t)
+{
+	const struct sdxi_amd_qos_fnupd_req function = {
+		.pool_num = 1,
+		.vf_num = 4,
+		.cxt_start = 16,
+		.cxt_end = 16,
+	};
+	const struct sdxi_amd_qos_fnupd_req context = {
+		.pool_num = 1,
+		.flags = SDXI_AMD_QOS_TARGET_F_CXT,
+		.cxt_start = 1,
+		.cxt_end = 1,
+	};
+	const struct sdxi_amd_qos_fnupd_req invalid_context = {
+		.pool_num = 1,
+		.flags = SDXI_AMD_QOS_TARGET_F_CXT,
+		.cxt_start = 16,
+		.cxt_end = 16,
+	};
+	const struct sdxi_amd_qos_fnupd_req invalid_vf = {
+		.pool_num = 1,
+		.flags = SDXI_AMD_QOS_TARGET_F_VF,
+		.vf_num = 4,
+	};
+	const u16 features = SDXI_AMD_QOS_FEATURE_FLEXIBLE_POOL_SCOPE;
+	int ret;
+
+	KUNIT_EXPECT_EQ(t, 0,
+			sdxi_amd_qos_validate_fnupd_req(&function, 8, 0, 16, 0));
+	KUNIT_EXPECT_EQ(t, 0,
+			sdxi_amd_qos_validate_fnupd_req(&context, 8, 0, 16, 0));
+	ret = sdxi_amd_qos_validate_fnupd_req(&invalid_context, 8, 0, 16, features);
+	KUNIT_EXPECT_EQ(t, -EINVAL, ret);
+
+	ret = sdxi_amd_qos_validate_fnupd_req(&invalid_vf, 8, 4, 16, 0);
+	KUNIT_EXPECT_EQ(t, -EINVAL, ret);
+}
+
+static void sdxi_kunit_qos_validate_tel(struct kunit *t)
+{
+	const struct sdxi_amd_qos_tel_req device = {
+		.query_type = SDXI_AMD_QOS_TEL_QTYPE_DEVICE,
+	};
+	const struct sdxi_amd_qos_tel_req pool = {
+		.pool_num = 7,
+		.flags = SDXI_AMD_QOS_TARGET_F_VF,
+		.vf_num = 99,
+		.cxt_num = 99,
+		.query_type = SDXI_AMD_QOS_TEL_QTYPE_POOL_CONFIG,
+	};
+	const struct sdxi_amd_qos_tel_req unsupported = {
+		.flags = SDXI_AMD_QOS_TARGET_F_CXT,
+		.cxt_num = 1,
+		.query_type = SDXI_AMD_QOS_TEL_QTYPE_POOL_ASSIGN,
+	};
+	const struct sdxi_amd_qos_tel_req invalid_context = {
+		.flags = SDXI_AMD_QOS_TARGET_F_CXT,
+		.cxt_num = 16,
+		.query_type = SDXI_AMD_QOS_TEL_QTYPE_POOL_ASSIGN,
+	};
+	const struct sdxi_amd_qos_tel_req invalid_query = {
+		.query_type = 6,
+	};
+	const u16 features = SDXI_AMD_QOS_FEATURE_FLEXIBLE_POOL_SCOPE;
+	int ret;
+
+	KUNIT_EXPECT_EQ(t, 0,
+			sdxi_amd_qos_validate_tel_req(&device, 8, 4, 16, 0));
+	KUNIT_EXPECT_EQ(t, 0,
+			sdxi_amd_qos_validate_tel_req(&pool, 8, 4, 16, 0));
+	ret = sdxi_amd_qos_validate_tel_req(&unsupported, 8, 4, 16, 0);
+	KUNIT_EXPECT_EQ(t, -EOPNOTSUPP, ret);
+
+	ret = sdxi_amd_qos_validate_tel_req(&invalid_context, 8, 4, 16, features);
+	KUNIT_EXPECT_EQ(t, -EINVAL, ret);
+
+	ret = sdxi_amd_qos_validate_tel_req(&invalid_query, 8, 4, 16, 0);
+	KUNIT_EXPECT_EQ(t, -EINVAL, ret);
+}
+
+static struct kunit_case sdxi_qos_cases[] = {
+	KUNIT_CASE(sdxi_kunit_qos_query_selector),
+	KUNIT_CASE(sdxi_kunit_qos_align_bw),
+	KUNIT_CASE(sdxi_kunit_qos_validate_devupd),
+	KUNIT_CASE(sdxi_kunit_qos_validate_poolupd),
+	KUNIT_CASE(sdxi_kunit_qos_validate_fnupd),
+	KUNIT_CASE(sdxi_kunit_qos_validate_tel),
+	{}
+};
+
+static struct kunit_suite sdxi_qos_suite = {
+	.name = "AMD SDXI QoS helpers",
+	.test_cases = sdxi_qos_cases,
+};
+
+kunit_test_suite(sdxi_qos_suite);
+
+MODULE_DESCRIPTION("AMD SDXI QoS helper tests");
+MODULE_AUTHOR("Wei Huang");
+MODULE_LICENSE("GPL");
-- 
2.56.1

