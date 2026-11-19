Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120459;
	b=FZjo8x5K3gYXCmc62cbhmbSCT7XBHYa+4a4OChnWSE4XriBjATrS78g4AcnH3pwklGtO
	 vqJxyZR1QkOpjlDVGftZsNH48/K5ClZ9GdpTE0XIUDpKbQsUXgH3TmpLHvcndeq2fDMpU
	 Hw/9bVrRCsQR0532s67MN0vwxMrDYOJ6IIzKqj3VxA9oLObDbX9jlaRkRN3F4T+K3syU6
	 LQl0MUB770BK72lAamCKIYW/cgNGEtdwjUQzCvGCaWGXpRY5Mv1kJudbR1PYpWQTSoY3M
	 Iug7swrSk3WruIqOFT41ppypSKx9EOikUb13fFnWt3F/+B0TY5kRV/gXOOEeDvG5N7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120459;
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
	bh=jrSh4obqb3fCd8FIe9PP2RH1ZcS/uOaNI0O2BHd+p7c=;
	b=noo5L3LKpbpzE2DjDgv5JBNqOC68oxjEDFxQTT4az/yPE2ixTMi6iCfvgCIgjwgVtkAP
	 36/VWAvkMIpubipIvdez4pgkM0xxDejAnhSDNMHbu/564AkmG//7i4Wh2Sg6MzKXH+kSx
	 R/G5LbJxefiVhI20HGVW16hqncDRuw9pRuJMpEy1ROvuDJFcFZjYKCCJcuux1eKwJBVEf
	 7XSJs4uhZy9JfTfJKAlzMEQ5vQRX9EvtTXxVp3sii/K9p1n8SZjbgjvG3Qv6HaxC40oAY
	 rNJFTGljFBCaTvbXdhp2GZVtNy8aEauJieelryT2R4r3gcsrI4eChJXRUG4tAc8X1+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=amy22OQl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C860A383F;
	Thu, 19 Nov 2026 20:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A6C860A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=amy22OQl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKE8UGMnr+ud/QgrPEIR9HryDsOdehHyLpiU9QvTF/iXunzXZuIg9AOY+2z+jrHujR7EcOE6y0F05Fj3ec25/HqDHX4fqYQXm57Hj38bSGDEzPc7aahuuVfxjV7pIKO1BGdO0uwkhh0Ct59DHtLTE73WkO2OWdpukrnIo9wfX39ip7UY3oYZr3Lfo5GP7mgJavfXQNYXz10aPFxVk5alpa1nniPtGESRehJq6pb/TisIeZvTuDeEfE0EtcDYIzhYS6j0lHSursBfpV9yvhXmROTPhvoBrWd0Iecaoa8iPCu5mW8DDRTjdGQseR7nwygg2LPUgB+lL5nDoxRlQLk9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrSh4obqb3fCd8FIe9PP2RH1ZcS/uOaNI0O2BHd+p7c=;
 b=fZzHXzhOK2SypzpPhPP1JzD/RAYOpugblkBbf5YK7P0Ky8RORDh9QSvrGvjkltSC/Jwk11P2Dip1UtGXLimlThtXZCuZkAzX8C6MAeZrwqbmZhMwc5o2HuB8utEvi7ODb59M74xZQyd73bSZi9xHVY1QcISzV1mUELmVROSuZ5X3cnxYBSLMDXEAPKyrtAssKbLN/9EBPC0mXEf2K9+lE5Ssz39Gt6ddSsLnSOptomB6sikcLOoiWiUCePjWh8b1U/x3uqaMLPuAWN0TS5J9lzQtCBkC93n/etPMqtPUl2gTDioaB4jNKC6dUYz54OiRrQWq8s5DOxaSEXpd6Q1vZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrSh4obqb3fCd8FIe9PP2RH1ZcS/uOaNI0O2BHd+p7c=;
 b=amy22OQlGO880CehOjH8Le/cV5yVURoFifqDdaLbdvosVzwSkATRgcfrhqFixoJhAbtN3BScDQvdctDac3nrV1n1SVlhWNuQIvgSTxxnXVhywCE9uf2meXUvm9y3MRI8Ta1z9lkfl4vC1lL8bTYz40jwjaMt672fakRSdpwcYR0=
Received: from CY5PR22CA0051.namprd22.prod.outlook.com (2603:10b6:930:1d::27)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:32:07 +0000
Received: from CY5PEPF00000E85.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::84) by CY5PR22CA0051.outlook.office365.com
 (2603:10b6:930:1d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 20:32:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E85.mail.protection.outlook.com (10.167.247.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:32:05 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:32:03 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 39/44] selftests: sdxi: test copy submission and ring wrap
Date: Thu, 19 Nov 2026 14:23:15 -0600
Message-ID: <20261119202321.1734355-40-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E85:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c67d7ad-ee3f-47f4-caa0-08df467c2cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|6133799003|22082099003|261009223027099003|18002099003|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QhpXZcvjHs1nBn1oF1w4obKW39uQnd8s6VWrmSno/N/o3+Km1iYpFeTNI9FEv/yIJPqlI3k/h4E02si6/t9rzpKecYAT5zGpAu/RY97SPOUeDlY9CdJsFKNYtwYZNCftC9s6XxbutWzN3WPBTAc1neDtkU9BZF53eG8Qo3DmUiCFstMEP3MsE3gtyncsTEQtOc1pgUFwBst1PJY86s/iMcSCYQIeoP+bx5M2lpFam6EZ3A09oSRudRAUuEPC845kxO4zhgKI5jnSUeNFYUACwYJebosNND0jQ9aRuYHiBpBxTy3O+epTofTnwnlIoIC4lIN8vOfaaWZYSGm6A31t45izo+RMirrVggE3LScjBmU/wa+lyvks2yzoLjnZvzf+pNxrNX+sz5pwfMhthIyj0JXKA9CvaGuS1HPXH3SAVjBWkrka+3x547teIg6e/ZXHQfc+RxpXgpdOQE4Gb4wvpVcyqwBKQueShf4Lpn/7w1GFnSAtelDiB0m0lqtBmP396UBHmN5naaYv+Rn0/TLJzeoI32hOWRgxzRpuCc5wFvkh6AmzLw9f+IiKO3NklK4kf2mCQsNcnL7/im+A3/8vrhEzaDhk1d1Qk+Lazk+lhszmqoXVYIgCRO4ZyYD0A3JJ71XAa11x1sz0SQs7JG3WAsoA7kLHYtJ/kg0RgMnr8H8uGBn9YGmDuKDYLPAnwaKiAfewkwXoHc+Lpfg0UT5HUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(6133799003)(22082099003)(261009223027099003)(18002099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QbZhCuSMYZqn9E02/dy8vW146ZB6/0KLs9L++VbTznDlqDglwEOEZbpY3SbcnXDfbIOlnNvskKw6M9CciOZV2J5wBfiVf3v8Ji8colcGsblTYi9AAKqNfiM8XunYFxTiVBLq6RporRVVti+hMFwTl12FW/yMTr4co8OcVUosUI6iRV0tapv/95qEprWTQnSEnlfXGsgvyz3XKt8LE/KfGC9fni+TqTlfFqQWGORBascfzwS7iHc1mli/znGVt4EJf43aUQJTQzqWQNvVY5mEySO2GaBecMWX0vew727TCZaEpNTkiWAXkqkw7jTfWM5uPvlW+yXgzXIx9OxsePP2jkIL6NbNfJ9kxl7sJ6nHw0J9B8u32gGaoLg5qLPV2QbxziWr91qv8Hn/r+NtQ2mYJSM0j/bojqFYwr2MLrHfLPMSbiD8WVSNqg7FXUjoH2j+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:32:05.0789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c67d7ad-ee3f-47f4-caa0-08df467c2cd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E85.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209

Add SDXI copy test for the SDXI selftest suite.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 tools/testing/selftests/sdxi/.gitignore |  1 +
 tools/testing/selftests/sdxi/Makefile   |  2 +-
 tools/testing/selftests/sdxi/copy.c     | 40 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sdxi/copy.c

diff --git a/tools/testing/selftests/sdxi/.gitignore b/tools/testing/selftests/sdxi/.gitignore
index 1127a33c0c5b..d05f961b1c67 100644
--- a/tools/testing/selftests/sdxi/.gitignore
+++ b/tools/testing/selftests/sdxi/.gitignore
@@ -1,2 +1,3 @@
 /context
 /nop
+/copy
diff --git a/tools/testing/selftests/sdxi/Makefile b/tools/testing/selftests/sdxi/Makefile
index 8da832249c70..052b0a5fd194 100644
--- a/tools/testing/selftests/sdxi/Makefile
+++ b/tools/testing/selftests/sdxi/Makefile
@@ -2,7 +2,7 @@ werror := -Werror
 CFLAGS += -std=gnu17 -Og -Wall -Wextra $(werror) $(TOOLS_INCLUDES) $(KHDR_INCLUDES)
 CPPFLAGS += -I../../../include/ -Ilib/
 
-TEST_GEN_PROGS := context nop
+TEST_GEN_PROGS := context nop copy
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/sdxi/copy.c b/tools/testing/selftests/sdxi/copy.c
new file mode 100644
index 000000000000..19486501dfff
--- /dev/null
+++ b/tools/testing/selftests/sdxi/copy.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI copy descriptor selftest.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <stdlib.h>
+
+#include "lib/descriptor.h"
+#include "lib/fixture-context.h"
+#include "lib/lib.h"
+#include "../kselftest_harness.h"
+
+TEST_F(sdxi_context, copy)
+{
+	const long src = 0xabcdef;
+	long dest = 0;
+	struct sdxi_desc copy = sdxi_dsc_encode_copy(&dest, &src, sizeof(src));
+
+	EXPECT_EQ(sdxi_submit_sync(&self->context, &copy), 0);
+
+	EXPECT_EQ(dest, src);
+}
+
+TEST_F(sdxi_context, copy_wrap)
+{
+
+	for (size_t i = 0; i < self->context.n_entries * 2; ++i) {
+		const long src = random();
+		long dest = 0;
+		struct sdxi_desc copy = sdxi_dsc_encode_copy(&dest, &src, sizeof(src));
+
+		EXPECT_EQ(sdxi_submit_sync(&self->context, &copy), 0);
+
+		EXPECT_EQ(dest, src);
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.56.1

