Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120387;
	b=cPXWVN+xxHw/PVXSAx0fcEsACeJVGHfyBeT+QLqWZIYXw4pJ6r8kkoj3MwkJtrjvPxoQ
	 Dp2M+O/tGWL5prqDhd0hmIY4Xke7clwlpk90dhlwu4O7lBkKkS+9J/xQ/PAcBlunM6Ow+
	 cBmX81HdkoNl1VcV75L++8ILB5pXn3BVduuSQzAU5EPraVOVjMFMMhvy0gVRVQeHMQakR
	 j1NeSoXKMM0PQeONVk14p1PoGruam3ogRhOJOHOCsVV2t3riBY9w2611xjeEoY3o9VfY6
	 vbTTPsUTJLxXg8ofmHw33IkDbyJDVFUuPWK2isERFgdJD+if2f1sYsyCPkZVyIlyxaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120387;
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
	bh=MnHGuwn8V3kTrMEm+FKVgapVOKrt/0cgNobaK9ktbYQ=;
	b=Y7XCoGyom0dA6ZOvJkHtIkdonXfp76XXMk6Xmbxa/16LRFIxCmMGD77FC+z6sS6EDcH2
	 swfc/saDjbXlVInVYQwx6W81D3Vdmqjk4uBFx2JoxMyAH3Mg8wlSY6XVUR9IOCUIIsAia
	 BKwX/J0azBNroKzhNHjMbMeD7BFaveIWqLxWyj9v5d86KXrrFMNNP38Hrdcper2s4swHn
	 XnVJ50rx5VhPdKnGdsb4RYyqdXxf89ePxuLsgFf/YB808Rv9F6kriV1AOT+OpMj9LaIcg
	 ub28o3d+XbxgcH6/T8I5FubBHEaiHnIyf9nouzHGqx+0pMyPwER34hHjyRAsciAez1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=be+SNdGa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.68
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AF60A380C;
	Thu, 19 Nov 2026 20:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB2AF60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=be+SNdGa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciA5hG3lrrm80GUBB1lo1wZvlq7oyEOeRmEFIpc3EF8TjNpSL8CrJ78EmerjWwSzYDIdZSx7jjROcA71JgRLB0nIsWAvJK3cmiBwzCDddKANLPnUBvzdubvh5VzuKhdR7txFw7C5nMykeouRxT8zeHspNfv0K7IeDb3vmKuaJqH5au9t1/B/SGFczcQRzSyU9jo+Uk25hxgyh6GSf3Ts1R50ZgGoxmNt8+eURWXYqNns+l+5yydipRVZ5JaMkByXyCx+AFZaLlhIDe61wxOXgwOYUuXcNJQofE9Q8PD8Myacz2c5L/hrNfQXtcUUPVuMBurPyuXq3zDOVkhH4SGlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnHGuwn8V3kTrMEm+FKVgapVOKrt/0cgNobaK9ktbYQ=;
 b=wbZXVio1NoBAXXJEV4PQceI/jtZn1IMbltByqTGVE1lC9WaQXwwD0NOa8MqNiZQVjr0l8Ukzk2hZcrHXq3l6+wuhuLpcWwghNQnzXb03PCRihGyOJbi0gG8GrDeLJkEkx+wXbB5rD7rF3rbbie03hJg4HBcpC09BRXFEfrew/oJ2K6jyGfpXrKNK/IcQwh5USyjSqEUvnFNjSWmdMuqMrlM2X10NeNYSGaxgdUZsXiidTzcxSqKiMhAotqtBNjhm2/zpvbXN/jYWTvy+zS0sTyoHWJs2jvMHuupaFQGg7+thR+VX1DOU23/7gW6qFIb3V+8lrL9UvoozMTLH7W4hSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnHGuwn8V3kTrMEm+FKVgapVOKrt/0cgNobaK9ktbYQ=;
 b=be+SNdGaZS6uv15MyLus6qguBPpYMOr4xsTIykTL6CZfRz9wik0vT1ltNuS2clP06Rt0FGX2f4JPHu1pc/kQOXHZsmE8mf8TKb5v6PQgG9/D0GHIjEgGWamFfI6LLqrf9/shdMzKy/n4j6KQPU3smZKV8QVssBl3r7UvNcldWR0=
Received: from CY5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:930:10::23)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:32:52 +0000
Received: from CY5PEPF00000E84.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::28) by CY5PR16CA0002.outlook.office365.com
 (2603:10b6:930:10::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:32:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E84.mail.protection.outlook.com (10.167.247.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:32:51 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:32:50 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 43/44] selftests: sdxi: test RKey ioctls
Date: Thu, 19 Nov 2026 14:23:19 -0600
Message-ID: <20261119202321.1734355-44-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E84:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: b84e115e-3519-4c6f-2584-08df467c48b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|6133799003|22082099003|18002099003|261009223027099003|261022113327099003|261021121427099003|261021123027099003|261022105027099003|56012099006|261026140227099003|261102123227099003|261026121527099003|261028144727099003|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	mRxAHgt2SZGN89Um5P3dw68WkmsZcznwB5y1Ux3jk+NR4us/IFfU7+OgKWgIDJtirzl+XIEMny1/F2klWR37eFmobGijBhNRZ8syed47oFJdBnvZKYaTc/nK3Q+q3fPWQxn33fZDk6D10claDa9OSM8zSiLgEh0DilJYVbENBX+GIuomhZvH9Pc16KZ2RLR5ZzVSAS46+qqQIC4Wi+gNndCHmfQ5vz3mtHQjBpnoZ2Hx9b9EoWjE2stDdV58LvCG1GHtaK8DOm56yZ77t3cqiW4IqXA12p0Ufur45wJlg0HAtrJiU35VkBemByA5dkMVtBvYfxU9kEAt3B8/5Nu309R627ceasm5P/P5OirrJzELn2glqwprikO65a2KbJYVoN4ThHb7SyLOQXpr0AjinVGq82XLa6d7qSYHtrMiog7iwFytJX+rYPy9QAESbdQgbolwFhxj84iYT11KnEm70DZ0WsHBKdaMaVg4h9o39fmzyYj59DvqUoLiUO7AgoRavx2s7ttiSdEGL8f/24UXJPPSk8JhQB0vvm4hEL4YAhm8QjW8Lg3H1eERuT+Us/JHnfllj5+gzD7RncmuAakyqbXFyTSxRXQChzDDKbNUFfe+atI6GbbaiHV4cjMa7a20Vmd9qWyZ87B3hlLFzzlwH007j7dORNuyy49iiwtTUAHoPRDk+fyrq/jYNBFn4J15iWcUkWZv7JbrWINyeS8gNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(261022113327099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/QZeRkFdykJ3QVvBxzAvwO2+JwtndmAoR579Ui7urD4SsbdjSql4EpfG56c3EOqFxTa6XM3jnDuji2WujxJT9iMap2rr7pBt6skbIwi0HQsFmgqQLIlkK1e5aaWaCRu8KRl9URt6E8k7U+fGsbznAGnkJkPbeLrYhnJutBN48uvL9F9a+7juUoSNaB3rjnnHBhm1a3IlSDey4JgcQ+a9kGUt1PTnX/E8ef2Vg7fUfrue9NZrGmpnS+m4uklFYQrHEvq9QtOOt+VGipZFwOqgqASGr2mlJUQ//9fc1nb5FMbk830q8B4Vs1sV9OSCJD56LzSDMYm/+d71QEkUA9HX691wrjsaacF1aN86QgM+OargdPsPvFIZwZxY0MRO5dw57e6UXGMTT6wVkPGgIKJcdoZLoYiVw7iOHWo0dJER9NmQqRadRtlLYZDcOlZcaeUE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:32:51.8487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84e115e-3519-4c6f-2584-08df467c48b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E84.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

Add RKey list, get and set ioctl coverage, including sizing retries
and negative cases to SDXI selftest suite.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 tools/testing/selftests/sdxi/.gitignore |   1 +
 tools/testing/selftests/sdxi/Makefile   |   2 +-
 tools/testing/selftests/sdxi/rkey.c     | 413 ++++++++++++++++++++++++
 3 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sdxi/rkey.c

diff --git a/tools/testing/selftests/sdxi/.gitignore b/tools/testing/selftests/sdxi/.gitignore
index 022002a27306..1c64e625c2bd 100644
--- a/tools/testing/selftests/sdxi/.gitignore
+++ b/tools/testing/selftests/sdxi/.gitignore
@@ -4,3 +4,4 @@
 /error
 /device
 /admin_cmd
+/rkey
diff --git a/tools/testing/selftests/sdxi/Makefile b/tools/testing/selftests/sdxi/Makefile
index abdb33981d91..dce0bcfc93d6 100644
--- a/tools/testing/selftests/sdxi/Makefile
+++ b/tools/testing/selftests/sdxi/Makefile
@@ -2,7 +2,7 @@ werror := -Werror
 CFLAGS += -std=gnu17 -Og -Wall -Wextra $(werror) $(TOOLS_INCLUDES) $(KHDR_INCLUDES)
 CPPFLAGS += -I../../../include/ -Ilib/
 
-TEST_GEN_PROGS := context nop copy error device admin_cmd
+TEST_GEN_PROGS := context nop copy error device admin_cmd rkey
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/sdxi/rkey.c b/tools/testing/selftests/sdxi/rkey.c
new file mode 100644
index 000000000000..c6d09399d791
--- /dev/null
+++ b/tools/testing/selftests/sdxi/rkey.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI RKey ioctl coverage.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ *
+ * Exercises SDXI_GET_RKEY_LIST / SDXI_GET_RKEYS / SDXI_SET_RKEYS against
+ * the device fd using the unified struct sdxi_key_entry +
+ * sdxi_{key_list,get_keys,set_keys}_args contract.
+ *
+ * All tests skip cleanly when the device does not advertise RKey support
+ * (MMIO_CAP1.rkey_cap == 0); root-only behavior is exercised when the
+ * test is invoked with sufficient privileges and otherwise just validated
+ * for the documented EPERM.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <linux/sdxi.h>
+
+#include "lib.h"
+#include "lib/fixture-device.h"
+#include "../kselftest_harness.h"
+
+/*
+ * Wire-format bits for an RKEY_ENT, mirrored from drivers/dma/sdxi/hw.h
+ * so the test stays standalone (kernel-private headers aren't installed).
+ * Keep in sync with `struct sdxi_rkey_ent` and SDXI_RKEY_ENT_*.
+ */
+#define RKEY_ENT_VL		(1U << 0)
+#define RKEY_ENT_INTR_NUM_MAX	((1U << 11) - 1)	/* bits [14:4] */
+
+static void rkey_pack_minimal(uint32_t data[4])
+{
+	memset(data, 0, sizeof(uint32_t) * 4);
+	/* intr_num: only the valid bit; pasid/rsvd left zero. */
+	data[0] = RKEY_ENT_VL;
+}
+
+static int rkey_get_max(int fd, uint32_t *out)
+{
+	struct sdxi_dev_attr_args args = {};
+	int rc;
+
+	args.argsz = sizeof(args);
+	args.attr = SDXI_DEV_ATTR_MAX_RKEY_SZ;
+
+	rc = ioctl(fd, SDXI_GET_DEV_ATTR, &args);
+	if (rc != 0)
+		return -errno;
+
+	*out = (uint32_t)args.val;
+	return 0;
+}
+
+/*
+ * Check SDXI_DEV_ATTR_MAX_RKEY_SZ instead of issuing a list-with-zero-buffer
+ * probe so privileged tests skip deterministically before exercising an
+ * RKey ioctl.
+ */
+static bool rkey_available(struct __test_metadata *_metadata, int fd)
+{
+	uint32_t max = 0;
+	int rc;
+
+	rc = rkey_get_max(fd, &max);
+	if (rc != 0)
+		SKIP(return false,
+		     "SDXI_GET_DEV_ATTR(MAX_RKEY_SZ) failed: %d", rc);
+	if (max == 0)
+		SKIP(return false,
+		     "RKey table not present on this device");
+
+	return true;
+}
+
+static int rkey_read_bitmap(int fd, struct sdxi_key_list_args **out)
+{
+	struct sdxi_key_list_args probe = {};
+	struct sdxi_key_list_args *full;
+	size_t total;
+	int rc;
+
+	probe.argsz = sizeof(probe);
+	if (ioctl(fd, SDXI_GET_RKEY_LIST, &probe) == 0) {
+		/* Empty table is legal; emit a synthesized header for caller. */
+		*out = calloc(1, sizeof(probe));
+		if (!*out)
+			return -ENOMEM;
+		**out = probe;
+		return 0;
+	}
+	if (errno != ENOSPC)
+		return -errno;
+
+	total = sizeof(*full) + probe.buf_size;
+	full = calloc(1, total);
+	if (!full)
+		return -ENOMEM;
+
+	full->argsz = sizeof(*full);
+	full->buf_size = probe.buf_size;
+	rc = ioctl(fd, SDXI_GET_RKEY_LIST, full);
+	if (rc != 0) {
+		rc = -errno;
+		free(full);
+		return rc;
+	}
+
+	*out = full;
+	return 0;
+}
+
+/* ----------------------- SDXI_GET_RKEY_LIST ----------------------- */
+
+TEST_F(dev_sdxi, get_rkey_list_requires_admin)
+{
+	struct sdxi_key_list_args args = {};
+
+	if (geteuid() == 0)
+		SKIP(return, "needs non-root");
+
+	args.argsz = sizeof(args);
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_RKEY_LIST, &args), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(dev_sdxi, get_rkey_list_rejects_flags)
+{
+	struct sdxi_key_list_args args = {};
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (!rkey_available(_metadata, self->fd))
+		return;
+
+	args.argsz = sizeof(args);
+	args.flags = 1;
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_RKEY_LIST, &args), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(dev_sdxi, get_rkey_list_rejects_rsvd)
+{
+	struct sdxi_key_list_args args = {};
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (!rkey_available(_metadata, self->fd))
+		return;
+
+	args.argsz = sizeof(args);
+	args.rsvd0 = 1;
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_RKEY_LIST, &args), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(dev_sdxi, get_rkey_list_resize_and_retry)
+{
+	struct sdxi_key_list_args probe = {};
+	struct sdxi_key_list_args *full;
+	uint32_t required;
+	uint32_t nentries;
+	size_t total;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (!rkey_available(_metadata, self->fd))
+		return;
+
+	/* Probe with buf_size = 0 to learn the required bitmap size. */
+	probe.argsz = sizeof(probe);
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_RKEY_LIST, &probe), -1);
+	EXPECT_EQ(errno, ENOSPC);
+	EXPECT_GT(probe.nentries, 0U);
+	EXPECT_EQ(probe.buf_size, (probe.nentries + 7U) / 8U);
+
+	required = probe.buf_size;
+	nentries = probe.nentries;
+
+	/* Re-issue with the requested capacity; must succeed. */
+	total = sizeof(*full) + required;
+	full = calloc(1, total);
+	ASSERT_NE(full, NULL);
+
+	full->argsz = sizeof(*full);
+	full->buf_size = required;
+
+	ASSERT_EQ(ioctl(self->fd, SDXI_GET_RKEY_LIST, full), 0);
+	EXPECT_EQ(full->nentries, nentries);
+	EXPECT_EQ(full->buf_size, required);
+	EXPECT_LE(full->nvalid, nentries);
+
+	free(full);
+}
+
+/* ------------------------- SDXI_GET_RKEYS ------------------------- */
+
+TEST_F(dev_sdxi, get_rkeys_requires_admin)
+{
+	struct sdxi_get_keys_args args = {};
+
+	if (geteuid() == 0)
+		SKIP(return, "needs non-root");
+
+	args.argsz = sizeof(args);
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_RKEYS, &args), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(dev_sdxi, get_rkeys_rejects_oob_index)
+{
+	union {
+		struct sdxi_get_keys_args align;
+		unsigned char storage[sizeof(struct sdxi_get_keys_args) +
+				      sizeof(struct sdxi_key_entry)];
+	} buffer = {};
+	struct sdxi_get_keys_args *args = (void *)buffer.storage;
+	struct sdxi_key_entry *entry = (void *)(args + 1);
+	uint32_t nentries;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (!rkey_available(_metadata, self->fd))
+		return;
+
+	ASSERT_EQ(rkey_get_max(self->fd, &nentries), 0);
+
+	args->argsz = sizeof(*args);
+	args->nkeys = 1;
+	entry->index = nentries;	/* one past the end */
+
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_RKEYS, args), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(dev_sdxi, get_rkeys_rejects_entry_rsvd)
+{
+	union {
+		struct sdxi_get_keys_args align;
+		unsigned char storage[sizeof(struct sdxi_get_keys_args) +
+				      sizeof(struct sdxi_key_entry)];
+	} buffer = {};
+	struct sdxi_get_keys_args *args = (void *)buffer.storage;
+	struct sdxi_key_entry *entry = (void *)(args + 1);
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (!rkey_available(_metadata, self->fd))
+		return;
+
+	args->argsz = sizeof(*args);
+	args->nkeys = 1;
+	entry->index = 0;
+	entry->rsvd0 = 1;
+
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_RKEYS, args), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+/* ------------------------- SDXI_SET_RKEYS ------------------------- */
+
+TEST_F(dev_sdxi, set_rkeys_requires_admin)
+{
+	struct sdxi_set_keys_args args = {};
+
+	if (geteuid() == 0)
+		SKIP(return, "needs non-root");
+
+	args.argsz = sizeof(args);
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_SET_RKEYS, &args), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(dev_sdxi, set_rkeys_zero_nkeys_reports_commit_all)
+{
+	struct sdxi_set_keys_args args = {};
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (!rkey_available(_metadata, self->fd))
+		return;
+
+	args.argsz = sizeof(args);
+	args.nkeys = 0;
+
+	ASSERT_EQ(ioctl(self->fd, SDXI_SET_RKEYS, &args), 0);
+	EXPECT_EQ(args.commit_state, (uint32_t)SDXI_KEY_COMMIT_ALL);
+	EXPECT_EQ(args.cst_flags, 0U);
+	EXPECT_EQ(args.first_failed_index, 0U);
+}
+
+TEST_F(dev_sdxi, set_rkeys_round_trip)
+{
+	union {
+		struct sdxi_set_keys_args align;
+		unsigned char storage[sizeof(struct sdxi_set_keys_args) +
+				      sizeof(struct sdxi_key_entry)];
+	} set_buffer = {};
+	union {
+		struct sdxi_get_keys_args align;
+		unsigned char storage[sizeof(struct sdxi_get_keys_args) +
+				      sizeof(struct sdxi_key_entry)];
+	} get_buffer = {};
+	struct sdxi_set_keys_args *set_args = (void *)set_buffer.storage;
+	struct sdxi_get_keys_args *get_args = (void *)get_buffer.storage;
+	struct sdxi_key_entry *set_entry = (void *)(set_args + 1);
+	struct sdxi_key_entry *get_entry = (void *)(get_args + 1);
+	uint32_t nentries;
+	uint32_t target_index;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (!rkey_available(_metadata, self->fd))
+		return;
+
+	ASSERT_EQ(rkey_get_max(self->fd, &nentries), 0);
+	ASSERT_GT(nentries, 0U);
+
+	/*
+	 * Use the highest available index to minimize collisions with any
+	 * driver-managed reservations at the bottom of the table.
+	 */
+	target_index = nentries - 1;
+
+	/* Phase 1: write a minimal-but-valid RKey entry. */
+	set_args->argsz = sizeof(*set_args);
+	set_args->nkeys = 1;
+	set_entry->index = target_index;
+	rkey_pack_minimal(set_entry->data);
+
+	ASSERT_EQ(ioctl(self->fd, SDXI_SET_RKEYS, set_args), 0);
+	EXPECT_EQ(set_args->commit_state, (uint32_t)SDXI_KEY_COMMIT_ALL);
+	EXPECT_EQ(set_args->cst_flags, 0U);
+	EXPECT_EQ(set_args->first_failed_index, 0U);
+
+	/* Phase 2: read it back and check the wire bytes survived. */
+	get_args->argsz = sizeof(*get_args);
+	get_args->nkeys = 1;
+	get_entry->index = target_index;
+
+	ASSERT_EQ(ioctl(self->fd, SDXI_GET_RKEYS, get_args), 0);
+	EXPECT_EQ(get_args->nkeys, 1U);
+	EXPECT_EQ(get_entry->index, target_index);
+	EXPECT_EQ(get_entry->data[0], RKEY_ENT_VL);
+	EXPECT_EQ(get_entry->data[1], 0U);
+	EXPECT_EQ(get_entry->data[2], 0U);
+	EXPECT_EQ(get_entry->data[3], 0U);
+
+	/* Phase 3: bitmap reflects the new validity. */
+	struct sdxi_key_list_args *full = NULL;
+	uint8_t mask;
+
+	ASSERT_EQ(rkey_read_bitmap(self->fd, &full), 0);
+	ASSERT_NE(full, NULL);
+	ASSERT_GE(full->buf_size, (target_index / 8) + 1);
+
+	mask = full->data[target_index / 8] & (1U << (target_index % 8));
+	EXPECT_NE(mask, 0);
+	EXPECT_GT(full->nvalid, 0U);
+
+	free(full);
+}
+
+TEST_F(dev_sdxi, set_rkeys_rejects_flags)
+{
+	struct sdxi_set_keys_args args = {};
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (!rkey_available(_metadata, self->fd))
+		return;
+
+	args.argsz = sizeof(args);
+	args.flags = 1;
+
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_SET_RKEYS, &args), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(dev_sdxi, set_rkeys_rejects_rsvd)
+{
+	struct sdxi_set_keys_args args = {};
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (!rkey_available(_metadata, self->fd))
+		return;
+
+	args.argsz = sizeof(args);
+	args.rsvd0[0] = 1;
+
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_SET_RKEYS, &args), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.56.1

