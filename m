Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120323;
	b=J6xZUXTCOX1ssw5cA8/E83b0VBJJZBcDZn00BK+WlthFMagMIvmrnHdnCT3z/9fqw6A3
	 5lCdt5iFYV0UPXCBfGNI6oXnNEMmLPwi5GZE9OwhRPOeXPggR1VpapGyvvh5VB4uTU7kZ
	 9aigkmmjFbDRATgEX/5FnJfivRi1lpGCJ8bMPMkdC0I0eRt2RSCeWQa/WRTe3+4mBQtlt
	 zMwkzV7wdMK6bin4yckQXs3uwESU9YytuVjAnq0Nnt8jaL7EL+H3NAwMyu/qdhYNBCprV
	 7mtWiJRDmPZV/fGWmsa8goqQaeEwD0E//gwRD0j75zGwhDVQPtuaxxPN114hKh9p9NQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120323;
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
	bh=Q4hGaQIV11q8lSy5SDT1R6YpJxxlC2OWLLxvEg4o5Cs=;
	b=ji80J76nUzApYkzFzabKfLUhXxpNFkdT8ct4oL6QPLv23KgyU6lRaiNPX69saPdNpFWZ
	 XSjTJ7pTJ9cxrDnxKJOVTbpd5tAtRcHAk2Ki2qk7YPJFxpp5zDduNItOBufUMo2QxMohI
	 I6d9IaxsAwvuIAZd+MijJjPScCPQzsyfiWRRNP/+ZzeNjLsWg0Pfk0529dkNEK2d0NALU
	 htR9gn+XLQFV8zPgZNldHN12Tg25nIIaqWEXFFUdv1Fesi+02vcrzz8ij0Quj3fZQtFzl
	 iImK4AdbElxRmCGqmigxmTpU/FQ2FzMlIXeHucL1ubQ8WEf20dETRB/Dl3RqjGtxIjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DNt853UI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.61
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562C60A261E;
	Thu, 19 Nov 2026 20:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4562C60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DNt853UI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bad6Ow1c7vOWtqEYypZ4KeRvNHtuBJ5nDDsCaBZuNfaie7N4dHhGQIkNhmnssGSWdJM6J3lqo0QUGTYTakJwKuLgBbMdN3w59CAjAXbbw5Bu5PUzoH3n4ZyN+qZ4w9fB7w8bXArRUXbPLEy8QoulA2Ol0iSIpA3pbnqWGYy57XtCm6SxBZW0cAJxnp1mmlycH8JWVd1a+epBHiDaF+yqHtNXNOQ56qXWs2LF4ydaz6amyqOxN/ob4yNb2AnMz0SCgC9O3nDBM5srZLrUj5S6zAtVjSbM+S/blBJv0YheJ6OHhz+aUMOy+6q82fJHtAZeFQJZIJ1kODrlr2UYCVFkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4hGaQIV11q8lSy5SDT1R6YpJxxlC2OWLLxvEg4o5Cs=;
 b=Qvp7+Uj8NKsg32cWI5I8FVimjS41tc4O9ECyZ7J2tQq91WLORsTgMo+t9hCkI48DAOZE737iQrLz3ycKt73YCOy+AEiVcJr4X9ZX/XQVH3MsjG3NV+gGd2ioruPK2yWiueX8zSijCV252ieS3mjS2aQ7x6NRpsh5BHykNkCYt89roZ08yZnHq7ULCwOcwk6VWktW9S4p75XwGoAiFA8+uM5meLVhN4ZqHYYTd3esPpUxhV4U3HLEh0yvbWgvc1+ylH7paeuq5I+a861pRxq6LVIWSJ9s+GpR9k4nTl/PueGOMoOSy22Ec/1Bjpx2pOIVxuRcwXh4f0RNCP/GPMXZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4hGaQIV11q8lSy5SDT1R6YpJxxlC2OWLLxvEg4o5Cs=;
 b=DNt853UI8KktA1LGD/umWlXJj0BQddqFPnSKGdZiCJGGg5foerRpTiYYX1m5uR5QH94pYiy+1StdaZ43z0X69BxRhwCNt0W0VVM6s417siqaXSgPTlhqJ7ZNxsfSYmeF0D96I9SczTW2YNuZb8QIG2IhKwbtfJFg8ZeTpwT5h2A=
Received: from CYXPR02CA0011.namprd02.prod.outlook.com (2603:10b6:930:cf::25)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:31:53 +0000
Received: from CY5PEPF00000E82.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::a3) by CYXPR02CA0011.outlook.office365.com
 (2603:10b6:930:cf::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:31:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E82.mail.protection.outlook.com (10.167.247.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:31:52 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:31:51 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 38/44] selftests: sdxi: test NOP descriptor submission
Date: Thu, 19 Nov 2026 14:23:14 -0600
Message-ID: <20261119202321.1734355-39-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E82:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aba2b15-7265-41eb-64b8-08df467c258c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|261022105027099003|261026140227099003|261021123027099003|261028144727099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	E6xmRaHlsu8w9hAH7owwBkxjxFAsCpp40g8RxYx9vsAWD+AM/MFEYeYSoomJ61QqlWFFs2kftumoaDRTNFaSikMH74GPKoZ2VzCB2otOKRLMw/DFRLQxMmx+6YCMOqMsvnZlGJUsuImwVcSgHyQx9aMTh0VqrsGu1J2uJXCxX/BfrJpZ96dV2xv0JpIDfT/byHKcTjEy8lJYW0zfMmp9BRI/agMGdcXtf9tqLU/K6+jT7zFZaz/Pmrbe3f6e0wvJDYHw/R5hmH+UDCMQpmxE8t1JFY7IkMQQb3/NFM3NJpc39yDet+u0r0881xmmITqCM3eFD6P9if7rJGY1BS4teAbuc2Y9WMMzd1ftwvNy/UlFptwP4GLqUcxR8c9Pzp7w9F4TBi6FmwoYYGONP0nRlzmzVx6KSQRW7JK1k7KT6eykTSbFyguvAVJVsKnX0vpGbO/IaAsA+cpHL93L2PxdyNI+TqaFaVCK3jpR6oM+7r+0fq/m8CkxyQZ1SQdHPix38dn/gZGhd9qVzeEspirtw5+cLVMx6x/25H7MAnw72Vme9lu9p5CtFNaAqmU2Dk72E68LJ9hAragByUSrLJm6xLIqQiw7L9QhQP+WdjgD/t/b6SfF+vLVSz0lwziQCiUlSPUogGqIZvhWRq9pan/28F19OGAuy6fsxf1rjaZ/G0eW9IDxZawZRsSIp82svZaKFB5ZElc4hjDowJKu4bsESg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261021123027099003)(261028144727099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mrPhkO4nFqTJDyv8QuNe1qjrGHidjP/+DmvPx13+/oWbWOMsig/sRCH0tnxVl2QV8YAGYB3C96ZqNlvnMztf6SNRp0eMyKX+QiQX6DGDFX0NRW2+c8QEW1T68PXJZco5/M9SgAL0xQHt4EcQqKF1f7ld6Fm8yAesaSi/qBQ8byt0jFlyyxnQsxTXU6JRcutgMysEabKi2UjcADwIvZmeKylNnJUFl2+K8IuC/VeLttI00yKQV2lig1q9r6GQgribrPgFC/873fIKxCtb5WIwvjwGAbin0Lf6n1Yez5dnyL/B6aXPe8asmZid26eLAt3BFVXG1cmP4agmJ6NWrXdwX0+kSj+uPBFGmPETPJ9FiL5IoFwKlCvQlQsMFM0MsO+e+D6cowe37FccH7qAV2+L0wnBZHbB6GpUMROVoygfpNHCkjptqGzWvAUDwcTnv3S4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:31:52.8848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aba2b15-7265-41eb-64b8-08df467c258c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E82.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219

Add a NOP descriptor submission and completion test to the SDXI
selftest suite.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 tools/testing/selftests/sdxi/.gitignore |  1 +
 tools/testing/selftests/sdxi/Makefile   |  2 +-
 tools/testing/selftests/sdxi/nop.c      | 30 +++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sdxi/nop.c

diff --git a/tools/testing/selftests/sdxi/.gitignore b/tools/testing/selftests/sdxi/.gitignore
index 9e3f2c52330c..1127a33c0c5b 100644
--- a/tools/testing/selftests/sdxi/.gitignore
+++ b/tools/testing/selftests/sdxi/.gitignore
@@ -1 +1,2 @@
 /context
+/nop
diff --git a/tools/testing/selftests/sdxi/Makefile b/tools/testing/selftests/sdxi/Makefile
index dba5d7df3872..8da832249c70 100644
--- a/tools/testing/selftests/sdxi/Makefile
+++ b/tools/testing/selftests/sdxi/Makefile
@@ -2,7 +2,7 @@ werror := -Werror
 CFLAGS += -std=gnu17 -Og -Wall -Wextra $(werror) $(TOOLS_INCLUDES) $(KHDR_INCLUDES)
 CPPFLAGS += -I../../../include/ -Ilib/
 
-TEST_GEN_PROGS := context
+TEST_GEN_PROGS := context nop
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/sdxi/nop.c b/tools/testing/selftests/sdxi/nop.c
new file mode 100644
index 000000000000..fdddf28d269e
--- /dev/null
+++ b/tools/testing/selftests/sdxi/nop.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI NOP descriptor selftest.
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
+TEST_F(sdxi_context, nop)
+{
+	struct sdxi_desc d = sdxi_dsc_encode_nop();
+
+	EXPECT_EQ(sdxi_submit_sync(&self->context, &d), 0);
+}
+
+TEST_F(sdxi_context, nops_wrap)
+{
+	struct sdxi_desc d = sdxi_dsc_encode_nop();
+
+	for (size_t i = 0; i < self->context.n_entries * 2; ++i)
+		EXPECT_EQ(sdxi_submit_sync(&self->context, &d), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.56.1

