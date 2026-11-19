Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120311;
	b=YGAKpVe2frbuI5bAr3wNqDCj4PVpJ5LNGTojTrGq9D+ymb/jL9agxd2RAI5uTn6utEoM
	 +NL/iIB+7Zc+CPCzH4QwNlqM8C1Z18LmG4fu0b9CJA1hSC8bYLfWHjaUg10Mpsn8qvYf9
	 vLMok2FtFozV4HWgl1P8wpN6bpkuLXUpfiDzwTHk0l4C67QClLg3cSUs+qpv2hkYQXnFa
	 djBDNM1rLsjiT/GX1DPPc3tS/BjVYsYAT1zNOjGORhuMl4miBM21vbUMZcpg4hqPxoN19
	 g/WXZUg4Xjz+VXu5a9srqWN1NIFG4iRs4pLYtOHJ1IXX7mEsqGuLmK1RLj4LYVR7GfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120311;
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
	bh=mU34t/Hthn6zH5H8vxAT5HvWwhT9qIuDa0eoeZpYQO8=;
	b=ePZo1QfHjalNy8gm0gUo1PVanvjke682QXXGmnbMvJmih+a/WxbuvswG+4CkN88W53MR
	 DODsh7JeJLFYkMly8or6Tw7HATU7GW4TSrEVXhYa0P+Bp01YnPSRVcd2vDCJTkKDZhEQH
	 1ZfUV6qdoxC+/vJL6TwYYUV4WkrLzVEGNk2qyaHCb+3dR4RvfOSGBOu9BBxhe9EpMFQq8
	 P2OULS8/SUKSWJpSCcdGbWRN94cTCSjchVnPLihZ79+hbhik6mYM/VsPZvXtW0k927foU
	 +NZWAyjyo44K6mU5LT2OeRseYyHZggocqIW9DaRaqBuTrQu0/pDMc1qezJHJs+gUf+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qwh7KI8x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.62
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ABD606A320;
	Thu, 19 Nov 2026 20:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13ABD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qwh7KI8x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsLPgrqYnZXoSeUS8r3LIVKy0X35WYtULNtxO1oW54W/PIaeh4opGsBLSrzMwEGYsjQsCA+IBzjgn1Ta1d5s0AeQk/I0K1aN55jzrfP/k33ckdD0zRA+GFZkLVUGTXvsYG28tNFVvjuyidBkVShqRJDei9/nRGpGwI96/ouIDsjvBIw0qtkAtIOeA6z+HevKB6WBIEWAYJgbsAQWTTN0hZMYFQtAQz+inc2TD+HYTjAmxMBhO9jjcMF4vHnC4+aFYim2p//vcOU0HwaalphiHG2G+AcI4wQbO2LEBTPw1/gtZkgKSrXi/+vzTy2TOTY+iEQbnCXqEEi37h9qO7cRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU34t/Hthn6zH5H8vxAT5HvWwhT9qIuDa0eoeZpYQO8=;
 b=v5zgugW1TKLBt+XqKtjKJRTeYRBnqcCqkCoTA/fVWHTqHUsjOc056XVrox2Ok7rzKiwkz9foDvKPUmTff2Ah7yT6U/apsYiYirVozfZeklGVy6mtgNm8OK9wrqSpPEX7GJnccMvLGm5qOQmUUWZ3wvR9z2PHi4Jz9uxQulrF8amXugXTDTCmxEj59eaHj2B/RVLanaUa2kYoyC6AfS+Tduex84Ed8ceZ9zrpSiX/mjJ0Jia3ef+OAoNhwu8loVWs+5SbYZL9EVH9czL3zbFhCIyt8MO0UkdEF0+mReJHlrG5Vx92NpYdZJJs8pMrnhdYNwp7vz6nB6L7WCMCrT6vOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU34t/Hthn6zH5H8vxAT5HvWwhT9qIuDa0eoeZpYQO8=;
 b=qwh7KI8x0hybQJEiibTtKaSmeWh4T808alEcRZ8Z1K5esO0nxeV1sKm1d/65S5SAUIcgOd2h3+S70uFob56ZkR/k1lF/2lMUftY9LKox0L+d1cobbF99p2pKklA7Hv4eeIeiXq0kVrY2Nm3z3gZqY7c8OnqnSzST2vj05XxY1PY=
Received: from CY5PR22CA0039.namprd22.prod.outlook.com (2603:10b6:930:1d::13)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:31:41 +0000
Received: from CY5PEPF00000E85.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::72) by CY5PR22CA0039.outlook.office365.com
 (2603:10b6:930:1d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:31:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E85.mail.protection.outlook.com (10.167.247.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:31:41 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:31:39 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 37/44] selftests: sdxi: test context creation
Date: Thu, 19 Nov 2026 14:23:13 -0600
Message-ID: <20261119202321.1734355-38-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E85:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 1914bfe6-a41a-4fa7-2ab2-08df467c1e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|23010399003|18002099003|22082099003|261009223027099003|6133799003|11063799006|261026121527099003|261026140227099003|56012099006|261026130827099003|261021130227099003|261026135527099003|261021133027099003|261021135927099003|261022113327099003|261021121427099003|261021123027099003|10067099003|261028144727099003|261022105027099003|261022115727099003|261102123227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	SHRKpB40aCHoogagFLn7jk93zx5UuGlGwKEgCPuxnYaUJ47YAKQkpR2JNBmdFeKWpkgkBxtcSbfY/lUDhFcojBa8BwkFhysQh1kHMGC3DS2LqtIR7TBZtLQpRBE1J/nTT46XO6WmiVbkoQxFXp7el4xQGIzpemaxLboRjU7cHTmUvVtnf/VVm99k3LTFMNRj9d8RvNslOWQ9DgdI5L39Ffub+IDfjRo8TA1BC8kwzSqUlFhkhSEt6bEHs1+zurqqtPVDJrq8anJATwO6wIIsLlj1ZhiIhmUrNARVzzK16sAjULFNugmJUGdGoPCC1lKJjrZ2emKdxkSRA/0oc1szjP2tFv97vkukbpvIjlxAlvPJisH1/SMsZcUVrZI2o0FnWX3V6NL6TXKDu8ulpmfT7wpApa4imx3CTGU77PK/CMu6GDbrtZqzQXs471ulIxtHMrXGYVRoLyvkciiyCcqvgWdh5dW+sDNP86uHoQEc+Owj2Q4p6psgl65E0xR6lvrCBh7/BegF84wE/07zM+PclYbZUfJ+Y7c1k5AbzxPG63YkJvq0SA1rpBXaOlc+zGOa/0K0llpHEKGHMPiuRgkeCiuIf2fK9f53cn3ZySfddKUSgu5xE1u9nJgL5D6hBYYiq18UFfqsOLz4gXG19Vtj4f85fThnrczt1EJ4t1q+/j2Dxs7qn2qWDbjCxfC0czm/p7aZok/gx817S2rkQApWhg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(261009223027099003)(6133799003)(11063799006)(261026121527099003)(261026140227099003)(56012099006)(261026130827099003)(261021130227099003)(261026135527099003)(261021133027099003)(261021135927099003)(261022113327099003)(261021121427099003)(261021123027099003)(10067099003)(261028144727099003)(261022105027099003)(261022115727099003)(261102123227099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IekfxOjao2sVbIFYbAMxPGDU3v8luWPs9ZCoBgQElQFC3RO6JW3ocUv/2nP57zlPbKFs7FSBpztNMjHWzzJmO41hUdB8xyxV9+Q17CTJfPEKCHaNLevybwD7PB4IyiWjBWKwhB+8nuumrAwEN5CDdt4A6ftEwGsWW261w9wM2HW4QStwg0KmvaL4cJBZGB2Sr5YLcUtuairRlYofPk/zSgDM2y6sC9A20r2wtAa4oKk0j9KhC2/O3r70ckKD/sYhwyvGKuSUF7PmlT2GQn2vrd8O9H20Ap2NUCf22jwTOeNPfvvjphhZkPtgYwO9MoinXx2OdXUcijIEB37H4isYoz/Y91pb/mHdIxuYoBGKH7npGi70o2QPBvfGV5AM/9cufiLGGRSSCkQhSVb9H6AkOmaGhVNrAA7LrWDPF/BNF5K8SSI9/6K99SGX8Sj3lsKb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:31:41.2309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1914bfe6-a41a-4fa7-2ab2-08df467c1e9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E85.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134

Add basic context creation smoke test for the SDXI selftest suite.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 tools/testing/selftests/sdxi/.gitignore |   1 +
 tools/testing/selftests/sdxi/Makefile   |   2 +
 tools/testing/selftests/sdxi/context.c  | 343 ++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 tools/testing/selftests/sdxi/.gitignore
 create mode 100644 tools/testing/selftests/sdxi/context.c

diff --git a/tools/testing/selftests/sdxi/.gitignore b/tools/testing/selftests/sdxi/.gitignore
new file mode 100644
index 000000000000..9e3f2c52330c
--- /dev/null
+++ b/tools/testing/selftests/sdxi/.gitignore
@@ -0,0 +1 @@
+/context
diff --git a/tools/testing/selftests/sdxi/Makefile b/tools/testing/selftests/sdxi/Makefile
index f2af46ac041f..dba5d7df3872 100644
--- a/tools/testing/selftests/sdxi/Makefile
+++ b/tools/testing/selftests/sdxi/Makefile
@@ -2,6 +2,8 @@ werror := -Werror
 CFLAGS += -std=gnu17 -Og -Wall -Wextra $(werror) $(TOOLS_INCLUDES) $(KHDR_INCLUDES)
 CPPFLAGS += -I../../../include/ -Ilib/
 
+TEST_GEN_PROGS := context
+
 include ../lib.mk
 
 HOSTAR ?= ar
diff --git a/tools/testing/selftests/sdxi/context.c b/tools/testing/selftests/sdxi/context.c
new file mode 100644
index 000000000000..8649b76f60e3
--- /dev/null
+++ b/tools/testing/selftests/sdxi/context.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI context ioctl selftests.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <linux/sdxi.h>
+
+#include "lib.h"
+#include "lib/fixture-context.h"
+#include "../kselftest_harness.h"
+
+#define AKEY_ENT_VL		(1U << 0)
+#define AKEY_ENT_IV		(1U << 1)
+#define AKEY_ENT_PV		(1U << 2)
+#define AKEY_ENT_STE		(1U << 3)
+#define AKEY_ENT_PH_SHIFT	30
+#define AKEY_ENT_INTR_SHIFT	4
+#define AKEY_ENT_INTR_MAX	((1U << 11) - 1)
+
+static void akey_pack_intr(uint32_t data[4], uint32_t pasid,
+			   uint32_t intr_num, bool iv)
+{
+	memset(data, 0, sizeof(uint32_t) * 4);
+	data[0] = AKEY_ENT_VL | AKEY_ENT_PV;
+	if (iv)
+		data[0] |= AKEY_ENT_IV;
+	data[0] |= (intr_num & AKEY_ENT_INTR_MAX) << AKEY_ENT_INTR_SHIFT;
+	data[1] = pasid;
+}
+
+static int set_single_akey(int cxt_fd, uint16_t index, const uint32_t data[4])
+{
+	struct sdxi_set_keys_args *args;
+	size_t bytes = sizeof(*args) + sizeof(args->entries[0]);
+	int rc;
+
+	args = calloc(1, bytes);
+	if (!args)
+		return -ENOMEM;
+
+	args->argsz = sizeof(*args);
+	args->nkeys = 1;
+	args->entries[0].index = index;
+	memcpy(args->entries[0].data, data, sizeof(args->entries[0].data));
+
+	rc = ioctl(cxt_fd, SDXI_SET_AKEYS, args);
+	rc = rc ? -errno : 0;
+
+	free(args);
+	return rc;
+}
+
+static int get_single_akey(int cxt_fd, uint16_t index, uint32_t data[4])
+{
+	struct sdxi_get_keys_args *args;
+	size_t bytes = sizeof(*args) + sizeof(args->entries[0]);
+	int rc;
+
+	args = calloc(1, bytes);
+	if (!args)
+		return -ENOMEM;
+
+	args->argsz = sizeof(*args);
+	args->nkeys = 1;
+	args->entries[0].index = index;
+
+	rc = ioctl(cxt_fd, SDXI_GET_AKEYS, args);
+	rc = rc ? -errno : 0;
+	if (!rc)
+		memcpy(data, args->entries[0].data, sizeof(args->entries[0].data));
+
+	free(args);
+	return rc;
+}
+
+// This basically duplicates the normal context fixture, maybe this
+// could be fixed by using a variant?
+FIXTURE(sdxi_context_nomap) {
+	int cxt_fd;
+	int device_fd;
+	void *write_idx;
+	size_t write_idx_bytes;
+	void *cxt_sts;
+	size_t cxt_sts_bytes;
+	void *ring;
+	size_t ring_bytes;
+};
+
+FIXTURE_SETUP(sdxi_context_nomap)
+{
+	int device_fd;
+	long page_size;
+	size_t ring_bytes;
+	void *cxt_sts;
+	void *ring;
+	void *write_idx;
+
+	errno = 0;
+	device_fd = open("/dev/sdxi0", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(device_fd, 0) {
+		if (errno == ENOENT)
+			SKIP(return,
+			     "/dev/sdxi0 does not exist");
+		if (errno == EACCES && geteuid() != 0)
+			SKIP(return,
+			     "insufficient privileges");
+	}
+
+	struct sdxi_create_cxt_args arg = {
+		.argsz = sizeof(struct sdxi_create_cxt_args),
+		.ds_ring_entries = 1024,
+	};
+
+	page_size = sysconf(_SC_PAGESIZE);
+	ASSERT_GT(page_size, 0);
+	ring_bytes = (size_t)arg.ds_ring_entries * sizeof(struct sdxi_desc);
+
+	cxt_sts = mmap(NULL, (size_t)page_size, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	write_idx = mmap(NULL, (size_t)page_size, PROT_READ | PROT_WRITE,
+			 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ring = mmap(NULL, ring_bytes, PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	ASSERT_NE(cxt_sts, MAP_FAILED);
+	ASSERT_NE(write_idx, MAP_FAILED);
+	ASSERT_NE(ring, MAP_FAILED);
+
+	/* Fault in and invalidate the ring before the device can fetch it. */
+	memset(ring, 0, ring_bytes);
+
+	arg.cxt_sts_base = (uint64_t)(uintptr_t)cxt_sts;
+	arg.write_index_base = (uint64_t)(uintptr_t)write_idx;
+	arg.ds_ring_base = (uint64_t)(uintptr_t)ring;
+
+	ASSERT_EQ(ioctl(device_fd, SDXI_CREATE_CXT, &arg), 0);
+
+	self->cxt_fd = arg.cxt_fd;
+	self->device_fd = device_fd;
+	self->write_idx = write_idx;
+	self->write_idx_bytes = (size_t)page_size;
+	self->cxt_sts = cxt_sts;
+	self->cxt_sts_bytes = (size_t)page_size;
+	self->ring = ring;
+	self->ring_bytes = ring_bytes;
+}
+
+FIXTURE_TEARDOWN(sdxi_context_nomap) {
+	int cxt_fd = self->cxt_fd;
+	int device_fd = self->device_fd;
+	struct sdxi_quiesce_cxt_args quiesce = {};
+
+	quiesce.argsz = sizeof(quiesce);
+
+	EXPECT_EQ(ioctl(cxt_fd, SDXI_QUIESCE_CXT, &quiesce),
+		  0);
+	EXPECT_EQ(munmap(self->write_idx, self->write_idx_bytes), 0);
+	EXPECT_EQ(munmap(self->cxt_sts, self->cxt_sts_bytes), 0);
+	EXPECT_EQ(munmap(self->ring, self->ring_bytes), 0);
+	EXPECT_EQ(close(cxt_fd), 0);
+	EXPECT_EQ(close(device_fd), 0);
+}
+
+TEST_F(sdxi_context_nomap, context_create_and_destroy_nomap)
+{
+	// Just run the fixture setup and teardown
+}
+
+TEST(sdxi_create_cxt_rejects_nonzero_flags)
+{
+	struct sdxi_create_cxt_args arg = {
+		.argsz = sizeof(arg),
+		.flags = 1,
+		.ds_ring_entries = 1024,
+	};
+	int device_fd;
+
+	errno = 0;
+	device_fd = open("/dev/sdxi0", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(device_fd, 0) {
+		if (errno == ENOENT)
+			SKIP(return, "/dev/sdxi0 does not exist");
+		if (errno == EACCES && geteuid() != 0)
+			SKIP(return, "insufficient privileges");
+	}
+
+	errno = 0;
+	EXPECT_EQ(ioctl(device_fd, SDXI_CREATE_CXT, &arg), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(close(device_fd), 0);
+}
+
+TEST(sdxi_create_cxt_requires_user_dataplane)
+{
+	struct sdxi_create_cxt_args arg = {
+		.argsz = sizeof(arg),
+		.ds_ring_entries = 1024,
+	};
+	int device_fd;
+
+	errno = 0;
+	device_fd = open("/dev/sdxi0", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(device_fd, 0) {
+		if (errno == ENOENT)
+			SKIP(return, "/dev/sdxi0 does not exist");
+		if (errno == EACCES && geteuid() != 0)
+			SKIP(return, "insufficient privileges");
+	}
+
+	errno = 0;
+	EXPECT_EQ(ioctl(device_fd, SDXI_CREATE_CXT, &arg), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(close(device_fd), 0);
+}
+
+TEST_F(sdxi_context, context_create_and_destroy)
+{
+	EXPECT_TRUE(sdxi_context_running(&self->context));
+}
+
+TEST_F(sdxi_context, cxt_eventfd_bind_unbind)
+{
+	struct sdxi_cxt_eventfd_args args = {};
+	int efd;
+	int rc;
+
+	args.argsz = sizeof(args);
+
+	efd = eventfd(0, EFD_CLOEXEC | EFD_NONBLOCK);
+	ASSERT_GE(efd, 0);
+
+	args.eventfd = efd;
+	rc = ioctl(self->context.cxt_fd, SDXI_CXT_EVENTFD, &args);
+	if (rc != 0) {
+		if (errno == EOPNOTSUPP) {
+			close(efd);
+			SKIP(return, "context interrupts not supported");
+		}
+		ASSERT_EQ(rc, 0);
+	}
+
+	EXPECT_GE(args.intr_akey, 2);
+	EXPECT_GT(args.intr_num, 0U);
+
+	args.eventfd = -1;
+	args.argsz = sizeof(args);
+	EXPECT_EQ(ioctl(self->context.cxt_fd, SDXI_CXT_EVENTFD, &args), 0);
+	EXPECT_EQ(args.intr_akey, 0);
+	EXPECT_EQ(args.intr_num, 0U);
+
+	close(efd);
+}
+
+TEST_F(sdxi_context, akey_iv_requires_cxt_eventfd)
+{
+	uint32_t data[4];
+	int rc;
+
+	akey_pack_intr(data, self->context.pasid, 1, true);
+	rc = set_single_akey(self->context.cxt_fd, 2, data);
+	if (rc == -EOPNOTSUPP)
+		SKIP(return, "context interrupts not supported");
+
+	EXPECT_EQ(rc, -ENOTCONN);
+}
+
+TEST_F(sdxi_context, akey_iv_requires_matching_intr_num)
+{
+	struct sdxi_cxt_eventfd_args args = {};
+	uint32_t data[4];
+	uint32_t wrong_intr;
+	uint16_t test_akey;
+	int efd;
+	int rc;
+
+	args.argsz = sizeof(args);
+
+	efd = eventfd(0, EFD_CLOEXEC | EFD_NONBLOCK);
+	ASSERT_GE(efd, 0);
+
+	args.eventfd = efd;
+	rc = ioctl(self->context.cxt_fd, SDXI_CXT_EVENTFD, &args);
+	if (rc != 0) {
+		if (errno == EOPNOTSUPP) {
+			close(efd);
+			SKIP(return, "context interrupts not supported");
+		}
+		ASSERT_EQ(rc, 0);
+	}
+
+	ASSERT_NE(args.intr_akey, UINT16_MAX);
+	test_akey = args.intr_akey + 1;
+
+	wrong_intr = (args.intr_num == 1U) ? 2U : 1U;
+	akey_pack_intr(data, self->context.pasid, wrong_intr, true);
+	EXPECT_EQ(set_single_akey(self->context.cxt_fd, test_akey, data),
+		  -EINVAL);
+
+	akey_pack_intr(data, self->context.pasid, args.intr_num, true);
+	EXPECT_EQ(set_single_akey(self->context.cxt_fd, test_akey, data), 0);
+
+	args.eventfd = -1;
+	args.argsz = sizeof(args);
+	EXPECT_EQ(ioctl(self->context.cxt_fd, SDXI_CXT_EVENTFD, &args), 0);
+	close(efd);
+}
+
+TEST_F(sdxi_context, akey_user_rejects_dsh_fields)
+{
+	uint32_t data[4];
+
+	if (geteuid() == 0)
+		SKIP(return, "non-admin AKey validation test");
+
+	ASSERT_EQ(get_single_akey(self->context.cxt_fd, 1, data), 0);
+
+	data[0] |= AKEY_ENT_STE;
+	EXPECT_EQ(set_single_akey(self->context.cxt_fd, 2, data), -EPERM);
+
+	ASSERT_EQ(get_single_akey(self->context.cxt_fd, 1, data), 0);
+
+	data[1] |= 1U << AKEY_ENT_PH_SHIFT;
+	EXPECT_EQ(set_single_akey(self->context.cxt_fd, 2, data), -EPERM);
+
+	ASSERT_EQ(get_single_akey(self->context.cxt_fd, 1, data), 0);
+
+	data[2] = 1;
+	EXPECT_EQ(set_single_akey(self->context.cxt_fd, 2, data), -EPERM);
+}
+
+TEST_HARNESS_MAIN
-- 
2.56.1

