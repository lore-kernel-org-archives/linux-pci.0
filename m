Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120340;
	b=elgKtyyOPKXgL5kiVAgxB/FxqRkEpa1ZMvSlvsOsA92qbuJKyexdN++wOWt4iEQ/LydH
	 0Ovubjg7gj5hTmybFwWphpAG9Dn1tNab1/NvHwwjIKQ5V96cB2xtXnHR7WBacChOGyg63
	 yylljMcIj9RGuKzjTNC12Hc2+qbeIBcN+HtPdrrbBuhvf3M5tCQayE62iBgv2uugQ0/X2
	 bxB1jQVGb1rldyrnNtxbrwZdK23iIxFdh/z0JxYxbKN8zn7PsOOqGm4y/NGeQlpHQ68Dh
	 oyULfH6Ed6LKrNG4dOYD/Ond2KzEoJF2vbx6PMbljF9ToARlYClcnW12hSisdIaPbQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120340;
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
	bh=jRMSV0dSKwvRH7wLESkB9zOcSBsxsWiiZymT+SybU7g=;
	b=jGSKbCzdS05WygTh1oZCvNmZ8c7oAY0YLPGO3Q+PJmmqmqCKmJiJi65eHjvL1RM81Iqq
	 zj8qBvWYKA7PCWmCjm23Y09FDmx1w+WTVtjEhd1S2YL+JKRw9BoRqSRbak0BrGT179ceu
	 dGeqOzqHFLs2qLj7UdHWQV7s1lLi1twFjBI5ytwecl84IZq+EFd5LrT+6F1CvnXBMgmwU
	 o8ykkKaAmQl5Eh+A2Yl7cdi7A9oeGTnNu5julty0bsN5nbM7bpoIQt29HpO5KCpnjvF/+
	 SyOAqNz3Lwye4TZzsO+UdyL9M9+Cor10Pt4QNm6+xgMd2RieexDkWnlKYY4qdnJRl5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0dLhQo+s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.67
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302D606A320;
	Thu, 19 Nov 2026 20:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5302D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0dLhQo+s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtS7DxELBMT55tq3EMy2R8jjKQhVwY38BMvWqScn4sD6qJzlrkiLOEjefJFp4saeupuEBdGevcW27TGoAs/HgtNnZoEf/5OT+YagMaJ+mo14zT59PK5OzXbnshVnvnF/srSL+ZGXuFoeUz4Kq67oM2nyLtW+gaIeJHDFNiGsAE05xg1LvCpX7peu4I1TCCZYtuBpplPPSRXsnF7HjM8tc7irXCCYDf76CEpvo0O9t2BIT1y2lmXdonu6tcpTtnHMl5vbXtjbIef0ou3qe1M56STkH/DZ67B8NHPFBvwIoWfXthhHlgKRyjBhgSGo1NezQsXRmGpWSt7IUu3nPZ1eeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRMSV0dSKwvRH7wLESkB9zOcSBsxsWiiZymT+SybU7g=;
 b=H3G92smstfRgIt2WMHUKDBd6O/XDjk3Fi7/0cphZgaXDAPV/sE1fNiFTUXA2oRcZzsEU5FlJ4mYcaoCoElPZC+LiH3FPomb+RQto4QPomEAtiBAQsjkHLY5S42xTqnGnxZKV04Y6uNA8E3sLgB6nldSOl705lIQRi47wTKGMfr0KD+igiSU8y0Z40hEfqDpVrivMxEbmN4F/t3Y87MIDU/TyGkDGyBuJQh9sFzEXF1v09ifqVf8zgGPQUc8roCm3Tzx6K6nXTL6TnHQu9k+cbcgH7ohr7Hf6oP731ZsLTpkgOjFEErSzuQ5yMypmUjgwfWTIa6mi4Icqvag4ci8gCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRMSV0dSKwvRH7wLESkB9zOcSBsxsWiiZymT+SybU7g=;
 b=0dLhQo+s3i4NsEJUUBSTHqx9WOf7BsDmqVE+H6gGbnfUYJfzW6tyI1TNzIufftEWxMNE2qYKpIXgZvveCso+7yIUXSQuEzt+qdMkyRNWw0Tohxq2pk24qizHunZSTpcuq2zePQEQk0VYgO0x7+rtZJ+5Vpehzy72nD5a4XwdtGw=
Received: from CY5PR15CA0071.namprd15.prod.outlook.com (2603:10b6:930:18::16)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:32:16 +0000
Received: from CY5PEPF00000E87.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::7) by CY5PR15CA0071.outlook.office365.com
 (2603:10b6:930:18::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:32:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E87.mail.protection.outlook.com (10.167.247.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:32:16 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:32:15 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 40/44] selftests: sdxi: exercise dataplane error paths
Date: Thu, 19 Nov 2026 14:23:16 -0600
Message-ID: <20261119202321.1734355-41-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E87:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cbbad8-5746-443b-ff62-08df467c33cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|10067099003|56012099006|261026140227099003|11063799006|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2qk09noaikcaqxGdj3+d1FYCwkqFIU9SfL9ulFnzZMVv6+NXs1Zu21zH3x9AkOljzIvZjQh80TDQIW9jhIhPxsPuYkJPsxuL5U76KKwny5fTpB5azW5GsBjpTogGIhDSOk97srjifi3XNETYEtVFeHJ/pn062x2CUQeAEP76DqiJFBqZp0j7JLQQs/Q2+RdbBaWCfiCMgFwyUaQw1Un2Y34c/q3nGWBC2tVqOTovVaj1T9unwmYtJag7VrifzCY++TYdNfLG82iYwfRB6OoO+ZPPlK7UYDAiciSq6wAdgE/k9npwAiAhPLf1JKNjneaiNHWZdFnp69JwRLuU2jfO2AqN2n2dJhNK4CRTn+u5knmEebPbFHkcuouZ82WLpRJr1J/4YxeSJqXc93sPFWvP0hqtjt0cQphc6j6ySMvPGnPSBNVC0k5DhTAeZLfzsNOQoN9XW8Cb1aPcbrZV8dmoB21iC2RkNwJxhx3Q8K18en7/u9mK7j78RT+3cxU+U+Pl9zh5QGMSPvFUfAPKLLrEwX0Mun+nyxP8qNSDyK3feewY1/JK9CcMEwM8Z7HgB6xDEweW1dIPu2TdT9xm+84xXbnFP8OdDlah6sS4E7Y9Jqsx9k8LkCgch98t9rjC/HeY3Xqz9cplCi3Eckhl31MZmVN3fQE/byZkCbVZ2QLnn7JC6Y3L6mwLYNbkaNAQ4YcalVkKuKC6riUCBHvY6GfMbw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(261026140227099003)(11063799006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dz1hAkny1Ns70whPR6oLvozvtGjtzcwqsEKRKHG+gEwgxWD9iVsj/fhAx4IDOHBnaI5hKNlH34bHZi4k0+uxvjrNliL9ktq+Q8GIifuXfNRYo5MUWOdxkipoWBOXMr+ygjFo5/15YPMhLrYSV5/lrCYmInGeiNtC3A9CMI5QpWJQuSHUgSN6DyWJjmCiIfVSNlGEU7gvg+7k8l2BsMGvVLCZ5ANwH097itsoeObGHvtaWnOiPoqJeCruBZlVrnb2V6l1ilZHn+Uojt6GVccz6x49n3Gh9764RwjWLAZFTemcrdFayuIyYJhgpPoEy5x7W1tp2Y8vzYM8YQn5bIcwrZZD1y1g0/Tirm82OIQd/23gHUiNyMxub/XstlgBnwCvpYGuuvvgVmUenXqYG9EGzUpV9Jk3rAb0CPEiMGnfxGKFxJY9fej4/0ybo7hlpzcI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:32:16.8228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cbbad8-5746-443b-ff62-08df467c33cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E87.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243

Add SDXI driver error-path dataplane smoke test for SDXI selftest
suite.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 tools/testing/selftests/sdxi/.gitignore |  1 +
 tools/testing/selftests/sdxi/Makefile   |  2 +-
 tools/testing/selftests/sdxi/error.c    | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sdxi/error.c

diff --git a/tools/testing/selftests/sdxi/.gitignore b/tools/testing/selftests/sdxi/.gitignore
index d05f961b1c67..d891f7a24c40 100644
--- a/tools/testing/selftests/sdxi/.gitignore
+++ b/tools/testing/selftests/sdxi/.gitignore
@@ -1,3 +1,4 @@
 /context
 /nop
 /copy
+/error
diff --git a/tools/testing/selftests/sdxi/Makefile b/tools/testing/selftests/sdxi/Makefile
index 052b0a5fd194..c05390cb9d86 100644
--- a/tools/testing/selftests/sdxi/Makefile
+++ b/tools/testing/selftests/sdxi/Makefile
@@ -2,7 +2,7 @@ werror := -Werror
 CFLAGS += -std=gnu17 -Og -Wall -Wextra $(werror) $(TOOLS_INCLUDES) $(KHDR_INCLUDES)
 CPPFLAGS += -I../../../include/ -Ilib/
 
-TEST_GEN_PROGS := context nop copy
+TEST_GEN_PROGS := context nop copy error
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/sdxi/error.c b/tools/testing/selftests/sdxi/error.c
new file mode 100644
index 000000000000..b4be54722fba
--- /dev/null
+++ b/tools/testing/selftests/sdxi/error.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI error path selftests.
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
+TEST_F(sdxi_context, error)
+{
+	struct sdxi_desc d = sdxi_dsc_encode_rsvd();
+
+	// Attempt to make the error log wrap
+	for (size_t i = 0; i < 80; ++i)
+		EXPECT_EQ(sdxi_submit_oneshot(&d), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.56.1

