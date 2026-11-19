Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120304;
	b=XsueEmsLTkkiWNkSSi8VyjLjIOD0JNQw6GT2CFyGPgoMjffsT3VxUtFBKoFgpI1FXe05
	 q+d7lJqP4986eztkh2wzrwaE4RYRhp+vOnwJj2Z5ZLerMwUKXTRnsN3yertuob0dkDwsG
	 FDjM9uE90aiwK74eFungoWG2UCt79l9Nw0Sb9TZ+vY62q5+e7NEMyU3IjEQj9IQdOURR/
	 gdp9JLK1taRiEpKE2b8zTL2aHdndPBoUA+JywhxNVY3IojuNNJ89G5uIyxep69rqvcHpz
	 GKZtS43/buxvf6pNbkvomQInyglxStf6m9iESiVNA7L3ZIhn1ozxTp462uRmAwQz9HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120304;
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
	bh=hnJocyd2W8ySHxgF372dClpHlJBI9zPtq2sCx5QYVHw=;
	b=xhO9n/vYuvjGBquVlR7Z6YXUherL2n+UcvpdgRBsxmY8ah8rvty5TNwQaKkm1OmVBbHU
	 mRaGDlW1P6AqCkD01jm3znr8bmxhkepPZsnApVl/lN8xn/lnWE25nv56pIEutpzy/Rke1
	 0WyoVZ5Glf1iTq3Q2q/Iimx7bmhAeiOPA6GDpdoA0OLf5lBMJpqotXZjIhi0OGVbymJuz
	 qEKK7sjKZTQSSTCOsLDaxJl5tVy1SsVnG1gaIjLSmxoa+cSfSuxVNuBZmG4m9l1+TfNhe
	 VJKyDWNb+E2QdGmxq5XnxcAGpXawMa6oNZO7/C52QOr+bBlXrZcyTYhGGztvUzG0bfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l5tZVQ1W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.18
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18065606A32A;
	Thu, 19 Nov 2026 20:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18065606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l5tZVQ1W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT6ozgUHk7pz2KQcn9Go3Mtq1DTF5nXd98D7kZ1VT1PTnt0GWKtFse8NYAWs3L1vhPFQ6sQqLjnXrBzlBxdTn5x6oJN7MhaY9dxUvrZFGVLZRzXmvf7Bz1MvRhLmpSUUfrXWbTlyGFjm2GG/O5QkBG8gQYmQj3OkTKK7PfQui+Z/9Z8o7YiYEbt8ji1bZmgY6Um7D2Y+jtUoSsPXjKdtLhJFt+k98DQw2xzkNZ3KT5xd6QwMBizmz5MPhXRiTqZ2kObHOhjW+TNz2mUCA88ZzPJA7CG466QXbzoTYpEW79Jp57WaaiTvCPhpain4hTHpxr2qCAj+K/ZG6sPnMZdbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnJocyd2W8ySHxgF372dClpHlJBI9zPtq2sCx5QYVHw=;
 b=SEnk5VwHxC84bmD5M+UL0iEFS4p/AkDGd78mLNxljeIpgPFd0hVOdiDbApWULKNKCPAC8NiIUmtmInoQ8skpdZUFr6Cygf0TgFtFIAYTWSvyI1jlr0XZVIZ9IRyOF7/Ir8qGDzucuDPOkB2LRjep00PrZ4IZlx+6htRjDxbMyUD7KdOhL5ymgdbMpXaHXVfGF4jVWg6RGtedQOl73S3TNZbN0C45Ey/B85m3kPhHRH00NrXojCs599F3CTOHKZ5Qr/Nh7OO3+IdT4eFPzu1LjhvzaN+STJLlKqTNKWjugrrD2ggT3+DvhqJYYPruw+vPNtyYf/YyTu39LsymFC37Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnJocyd2W8ySHxgF372dClpHlJBI9zPtq2sCx5QYVHw=;
 b=l5tZVQ1W2dxuIa2SXmoxjyskbLojMHwQTk4oTvimbyMIH3xKra5PsvW0s1hLoP66ohahnWjwHputbMx5fJ5lFImNkSnDF3vnjuUA7DD2N3n6l/CgIRUNJAPRpv74MngJAtqVey5DyQr1ZcqxldzouZkpXDkkBqacrcP5Y+KqxL8=
Received: from CY5PR15CA0075.namprd15.prod.outlook.com (2603:10b6:930:18::7)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:31:31 +0000
Received: from CY5PEPF00000E87.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::9) by CY5PR15CA0075.outlook.office365.com
 (2603:10b6:930:18::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:31:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E87.mail.protection.outlook.com (10.167.247.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:31:30 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:31:03 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 36/44] selftests: sdxi: add shared descriptor and context helpers
Date: Thu, 19 Nov 2026 14:23:12 -0600
Message-ID: <20261119202321.1734355-37-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E87:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebe38ae-2f1d-4101-615c-08df467c1808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|10067099003|261022075727099003|261026121527099003|56012099006|261026140227099003|11063799006|261022105027099003|261009223027099003|261021121427099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	I5wsjVHVyRIUreFMpWpbSuWDKH+TArR+1Cx7WfwHM8Y1wrM+vERfc/jJdjvm0/sY3z1LJPNvLM/GXTk2wo8MlI+1Tyc4d00Bh7nZC/0zVNhyL2HSEninYOk7mOBPIxuDwuvIZdalIssGkGULTvzf582JufPQIeQDDVqflr4ms4FXfTgJRPdsuAx3Fnx44Yjgg2dnYjvPSgBty1EJo38zToPb4Eln3jb9S7h95M6wRYdfV8dIV52RdLMBiluhnQhmCRqHTC2gvcaNWkx2OYsjtBjIvXlqy4z+TciyPQFR5KF5DdC63LSYjjhFWvGZ6IIZxFs6QuFmQhmDlB8nWZaYcXJxrodmJdCLVcwL48zDemXpxnR+oGjbZwc1aOaPEhkFiHleRLYDFizcUmRWDJ8n8V+8S7m5a08dnA6ncS612X3/vi2VP/uZh+s7fTnUje1XiHjKb8J1AuuLBu7BmjuzRWBk/Ymm6C+2sj+Ll3mDisi02wjKbU8R3VOpzLC5eX7PYy7n4EFMpcZBYZtKcKocAWnA0sJYpc9moEDuFeAAkDD+CRKnMbXbD0Vj2QeVYJHfQAEPq22n2/eOMjVkGbqTVmAg8YDHvXrVSLn+8/QHxO+Ez7lRfzMqe9quWVa0GNBwAiIEimdhZNtt9XEnKOT7xwxd5FVbOf3EiJJRVEuoS76Nhns+rMEhNeTm40xaPBxEqS2tPcltWD+axnONr47HeQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(261022075727099003)(261026121527099003)(56012099006)(261026140227099003)(11063799006)(261022105027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qK0pMQcQ13SS4S9AIi4Y2dWokptA2jzpmhyvm2vgDxPHtfdPfI7rSqFogbUwWp43L3mYnps2GLdJChNnt9PAgEwRXsFmdyGTo9dxmU5c7y+dhFSvyid7sbCxgQ7UGr6XJXY/5pTu6IlCho0IGgyx+u1zUDZmjO/9nsEt5SgYa+uzA0ndWfIyjG3xYl89jx24d8Ki12k76leevZQoWec+hV9XGctSBOj3dr5vGpn83efMl2rZn/ckm0JqdkOmigcSnVn5NrCswPge6YHEYCjqyfC3VQHXIs/cBovipmvufthTVGqtyEpzOMtSAccydnzeT3MwXJnRWWdC4dCn+X161CZ4ty8tf7ut4FgWWWDmOrfynw88umCv03J64iGIVdl3cuFcAMGP4jL0MeDSErXriPoqL0mgmAt8NyVZIdZpcbfBqLCE6lGFFZOavIfUuWa/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:31:30.2366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebe38ae-2f1d-4101-615c-08df467c1808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E87.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722

Add shared helpers for opening SDXI devices, creating contexts and
building descriptors used by the functional selftests.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 tools/testing/selftests/sdxi/Makefile         |  28 +++
 tools/testing/selftests/sdxi/lib/context.c    | 195 +++++++++++++++++
 tools/testing/selftests/sdxi/lib/descriptor.h |  55 +++++
 .../selftests/sdxi/lib/fixture-context.h      | 126 +++++++++++
 .../selftests/sdxi/lib/fixture-device.h       |  44 ++++
 tools/testing/selftests/sdxi/lib/lib.c        | 206 ++++++++++++++++++
 tools/testing/selftests/sdxi/lib/lib.h        |  61 ++++++
 7 files changed, 715 insertions(+)
 create mode 100644 tools/testing/selftests/sdxi/lib/context.c
 create mode 100644 tools/testing/selftests/sdxi/lib/descriptor.h
 create mode 100644 tools/testing/selftests/sdxi/lib/fixture-context.h
 create mode 100644 tools/testing/selftests/sdxi/lib/fixture-device.h
 create mode 100644 tools/testing/selftests/sdxi/lib/lib.c
 create mode 100644 tools/testing/selftests/sdxi/lib/lib.h

diff --git a/tools/testing/selftests/sdxi/Makefile b/tools/testing/selftests/sdxi/Makefile
index 107a9bd08f04..f2af46ac041f 100644
--- a/tools/testing/selftests/sdxi/Makefile
+++ b/tools/testing/selftests/sdxi/Makefile
@@ -3,3 +3,31 @@ CFLAGS += -std=gnu17 -Og -Wall -Wextra $(werror) $(TOOLS_INCLUDES) $(KHDR_INCLUD
 CPPFLAGS += -I../../../include/ -Ilib/
 
 include ../lib.mk
+
+HOSTAR ?= ar
+
+LIBDIR	:= $(OUTPUT)/lib
+LIB	:= $(LIBDIR)/lib.a
+
+all: $(LIB)
+
+LIBDEPS := \
+	Makefile \
+	lib/descriptor.h \
+	lib/fixture-context.h \
+	lib/fixture-device.h \
+	lib/lib.h
+# Library
+LIBSRC	:= context.c lib.c
+LIBOBJ	:= $(LIBSRC:%.c=$(LIBDIR)/%.o)
+EXTRA_CLEAN += $(LIBOBJ) $(LIB)
+
+$(LIB): $(LIBOBJ)
+	$(HOSTAR) rcs $@ $^
+
+$(LIBDIR)/%.o: ./lib/%.c $(LIBDEPS)
+	mkdir -p $(LIBDIR)
+	$(CC) $< $(CFLAGS) $(CPPFLAGS) -o $@ -c
+
+$(TEST_GEN_PROGS): $(LIB)
+$(TEST_GEN_PROGS_EXTENDED): $(LIB)
diff --git a/tools/testing/selftests/sdxi/lib/context.c b/tools/testing/selftests/sdxi/lib/context.c
new file mode 100644
index 000000000000..0fde2d22f3b8
--- /dev/null
+++ b/tools/testing/selftests/sdxi/lib/context.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI selftest context helpers.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <linux/kernel.h>
+#include <linux/sdxi.h>
+
+#include "lib.h"
+
+#define alloc(...)					\
+	({						\
+		size_t sz = sizeof(__VA_ARGS__);	\
+		void *ptr = malloc(sz);			\
+		if (ptr)				\
+			memset(ptr, 0, sz);		\
+		(typeof(__VA_ARGS__) *)ptr;		\
+	})
+
+enum {
+	SELFTEST_SDXI_CAP0_DB_STRIDE_SHIFT = 20,
+	SELFTEST_SDXI_CAP0_DB_STRIDE_MASK = 0x7,
+};
+
+static size_t sdxi_page_size(void)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+
+	if (page_size <= 0)
+		return 4096;
+
+	return (size_t)page_size;
+}
+
+size_t sdxi_context_db_stride_bytes(int device_fd)
+{
+	struct sdxi_dev_info_args info = {};
+	uint64_t shift;
+
+	info.argsz = sizeof(info);
+	if (ioctl(device_fd, SDXI_GET_DEV_INFO, &info) != 0)
+		return 0;
+
+	shift = (info.cap0 >> SELFTEST_SDXI_CAP0_DB_STRIDE_SHIFT) &
+		SELFTEST_SDXI_CAP0_DB_STRIDE_MASK;
+
+	return 4096ull << shift;
+}
+
+static void sdxi_context_munmap_safe(void *addr, size_t bytes)
+{
+	if (!addr || addr == MAP_FAILED || bytes == 0)
+		return;
+
+	(void)munmap(addr, bytes);
+}
+
+struct sdxi_context *sdxi_context_create(void)
+{
+	struct sdxi_create_cxt_args arg = {
+		.argsz = sizeof(struct sdxi_create_cxt_args),
+		.ds_ring_entries = 1024,
+	};
+	struct sdxi_context *cxt;
+	void *doorbell = MAP_FAILED;
+	void *write_idx = MAP_FAILED;
+	void *cxt_sts = MAP_FAILED;
+	void *ring = MAP_FAILED;
+	size_t page_size;
+	size_t doorbell_bytes;
+	size_t ring_bytes;
+	int cxt_fd = -1;
+	int device_fd;
+	int err;
+
+	cxt = alloc(*cxt);
+	if (!cxt)
+		return NULL;
+
+	errno = 0;
+	device_fd = open("/dev/sdxi0", O_RDWR | O_CLOEXEC);
+	if (device_fd < 0)
+		goto free_cxt;
+
+	page_size = sdxi_page_size();
+	doorbell_bytes = sdxi_context_db_stride_bytes(device_fd);
+	if (doorbell_bytes == 0)
+		goto close_fd;
+
+	ring_bytes = (size_t)arg.ds_ring_entries * sizeof(cxt->ring->entry[0]);
+	cxt_sts = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	write_idx = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ring = mmap(NULL, ring_bytes, PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (cxt_sts == MAP_FAILED || write_idx == MAP_FAILED ||
+	    ring == MAP_FAILED)
+		goto unmap_local;
+
+	arg.cxt_sts_base = (uint64_t)(uintptr_t)cxt_sts;
+	arg.write_index_base = (uint64_t)(uintptr_t)write_idx;
+	arg.ds_ring_base = (uint64_t)(uintptr_t)ring;
+
+	err = ioctl(device_fd, SDXI_CREATE_CXT, &arg);
+	if (err)
+		goto unmap_local;
+
+	cxt_fd = arg.cxt_fd;
+	if (cxt_fd < 0)
+		goto unmap_local;
+
+	ring_bytes = (size_t)arg.ds_ring_entries * sizeof(cxt->ring->entry[0]);
+
+	doorbell = mmap(NULL, doorbell_bytes, PROT_WRITE, MAP_SHARED,
+			cxt_fd, arg.doorbell_mmap_base);
+	if (doorbell == MAP_FAILED)
+		goto unmap;
+
+	*cxt = (struct sdxi_context) {
+		.device_fd = device_fd,
+		.cxt_fd = cxt_fd,
+		.pasid = arg.pasid,
+		.doorbell = doorbell,
+		.doorbell_bytes = doorbell_bytes,
+		.write_idx = write_idx,
+		.write_idx_bytes = page_size,
+		.cxt_sts = cxt_sts,
+		.cxt_sts_bytes = page_size,
+		.ring = ring,
+		.ring_bytes = ring_bytes,
+		.n_entries = arg.ds_ring_entries,
+	};
+
+	return cxt;
+
+unmap:
+	(void)ioctl(cxt_fd, SDXI_QUIESCE_CXT,
+	      &(struct sdxi_quiesce_cxt_args) {
+		      .argsz = sizeof(struct sdxi_quiesce_cxt_args),
+	      });
+	sdxi_context_munmap_safe(doorbell, doorbell_bytes);
+unmap_local:
+	sdxi_context_munmap_safe(write_idx, page_size);
+	sdxi_context_munmap_safe(cxt_sts, page_size);
+	sdxi_context_munmap_safe(ring,
+				 (size_t)arg.ds_ring_entries *
+				 sizeof(cxt->ring->entry[0]));
+close_fd:
+	if (cxt_fd >= 0)
+		(void)close(cxt_fd);
+	(void)close(device_fd);
+free_cxt:
+	free(cxt);
+	return NULL;
+}
+
+void sdxi_context_destroy(struct sdxi_context *cxt)
+{
+	if (!cxt)
+		return;
+
+	(void)ioctl(cxt->cxt_fd, SDXI_QUIESCE_CXT,
+	      &(struct sdxi_quiesce_cxt_args) {
+		      .argsz = sizeof(struct sdxi_quiesce_cxt_args),
+	      });
+	sdxi_context_munmap_safe(cxt->doorbell, cxt->doorbell_bytes);
+	sdxi_context_munmap_safe(cxt->write_idx, cxt->write_idx_bytes);
+	sdxi_context_munmap_safe(cxt->cxt_sts, cxt->cxt_sts_bytes);
+	sdxi_context_munmap_safe(cxt->ring, cxt->ring_bytes);
+	(void)close(cxt->cxt_fd);
+	(void)close(cxt->device_fd);
+	free(cxt);
+}
+
+bool sdxi_context_running(const struct sdxi_context *cxt)
+{
+	struct sdxi_cxt_sts *sts = cxt->cxt_sts;
+	enum {
+		CXTV_RUN = 1,
+	};
+
+	return (READ_ONCE(sts->state) & 0xf) == CXTV_RUN;
+}
diff --git a/tools/testing/selftests/sdxi/lib/descriptor.h b/tools/testing/selftests/sdxi/lib/descriptor.h
new file mode 100644
index 000000000000..9a0d88248dec
--- /dev/null
+++ b/tools/testing/selftests/sdxi/lib/descriptor.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI selftest descriptor encoders.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef SELFTEST_SDXI_DESCRIPTOR_H
+#define SELFTEST_SDXI_DESCRIPTOR_H
+
+#include "linux/build_bug.h"
+#include "linux/compiler.h"
+#include "linux/types.h"
+
+// Size of the "body" of each descriptor between the common opcode and
+// csb_ptr fields.
+#define SDXI_DESC_PAYLOAD_BYTES 52
+
+#define declare_sdxi_desc_payload(_name, _layout)			\
+	struct _name _layout __packed;					\
+	static_assert(sizeof(struct _name) == SDXI_DESC_PAYLOAD_BYTES,	\
+		      "descriptor payload size mismatch")
+
+declare_sdxi_desc_payload(sdxi_desc_nop, {
+		__u8 empty[SDXI_DESC_PAYLOAD_BYTES];
+	});
+
+declare_sdxi_desc_payload(sdxi_desc_copy, {
+		__le32 size;
+		__u8   attr;
+		__u8   rsvd_0[3];
+		__le16 akey0;
+		__le16 akey1;
+		__le64 addr0;
+		__le64 addr1;
+		__u8   rsvd_1[24];
+	});
+
+struct sdxi_desc {
+	union {
+		struct {
+			__le32 opcode;
+			union {
+				__u8   operation[SDXI_DESC_PAYLOAD_BYTES];
+				struct sdxi_desc_nop nop;
+				struct sdxi_desc_copy copy;
+			};
+			__le64 csb_ptr;
+		};
+		__le64 qw[8];
+	};
+} __packed __aligned(64);
+static_assert(sizeof(struct sdxi_desc) == 64, "descriptor size mismatch");
+
+#endif /* SELFTEST_SDXI_DESCRIPTOR_H */
diff --git a/tools/testing/selftests/sdxi/lib/fixture-context.h b/tools/testing/selftests/sdxi/lib/fixture-context.h
new file mode 100644
index 000000000000..6eb95e819236
--- /dev/null
+++ b/tools/testing/selftests/sdxi/lib/fixture-context.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI selftest context fixture.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef SELFTEST_SDXI_FIXTURE_CONTEXT_H
+#define SELFTEST_SDXI_FIXTURE_CONTEXT_H
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <linux/sdxi.h>
+
+#include "lib.h"
+
+#include "../../kselftest_harness.h"
+
+FIXTURE(sdxi_context) {
+	struct sdxi_context context;
+};
+
+FIXTURE_SETUP(sdxi_context)
+{
+	struct sdxi_context *cxt = &self->context;
+	int cxt_fd;
+	int device_fd;
+	long page_size;
+	size_t doorbell_bytes;
+	size_t ring_bytes;
+	void *cxt_sts;
+	void *ring;
+	void *write_idx;
+
+	errno = 0;
+	device_fd = open("/dev/sdxi0", O_RDWR | O_CLOEXEC);
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
+	ring_bytes = (size_t)arg.ds_ring_entries * sizeof(cxt->ring->entry[0]);
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
+	ASSERT_GE(arg.cxt_fd, 0);
+	cxt_fd = arg.cxt_fd;
+	doorbell_bytes = sdxi_context_db_stride_bytes(device_fd);
+	ASSERT_GT(doorbell_bytes, 0U);
+
+	*cxt = (struct sdxi_context) {
+		.device_fd = device_fd,
+		.cxt_fd = cxt_fd,
+		.pasid = arg.pasid,
+		.doorbell = mmap(NULL, doorbell_bytes,
+				 PROT_WRITE, MAP_SHARED,
+				 cxt_fd, arg.doorbell_mmap_base),
+		.doorbell_bytes = doorbell_bytes,
+		.write_idx = write_idx,
+		.write_idx_bytes = (size_t)page_size,
+		.cxt_sts = cxt_sts,
+		.cxt_sts_bytes = (size_t)page_size,
+		.ring = ring,
+		.ring_bytes = ring_bytes,
+		.n_entries = arg.ds_ring_entries,
+	};
+
+	EXPECT_NE(cxt->doorbell, MAP_FAILED);
+	EXPECT_NE(cxt->write_idx, MAP_FAILED);
+	EXPECT_NE(cxt->cxt_sts, MAP_FAILED);
+	EXPECT_NE(cxt->ring, MAP_FAILED);
+}
+
+FIXTURE_TEARDOWN(sdxi_context)
+{
+	struct sdxi_context *cxt = &self->context;
+	struct sdxi_quiesce_cxt_args quiesce = {};
+
+	quiesce.argsz = sizeof(quiesce);
+
+	EXPECT_EQ(ioctl(cxt->cxt_fd, SDXI_QUIESCE_CXT, &quiesce),
+		  0);
+	EXPECT_EQ(munmap(cxt->doorbell, cxt->doorbell_bytes), 0);
+	EXPECT_EQ(munmap(cxt->write_idx, cxt->write_idx_bytes), 0);
+	EXPECT_EQ(munmap(cxt->cxt_sts, cxt->cxt_sts_bytes), 0);
+	EXPECT_EQ(munmap(cxt->ring, cxt->ring_bytes), 0);
+	EXPECT_EQ(close(cxt->cxt_fd), 0);
+	EXPECT_EQ(close(cxt->device_fd), 0);
+}
+
+#endif /* SELFTEST_SDXI_FIXTURE_CONTEXT_H */
diff --git a/tools/testing/selftests/sdxi/lib/fixture-device.h b/tools/testing/selftests/sdxi/lib/fixture-device.h
new file mode 100644
index 000000000000..bd6a26151732
--- /dev/null
+++ b/tools/testing/selftests/sdxi/lib/fixture-device.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI selftest device fixture.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef SELFTEST_SDXI_FIXTURE_DEVICE_H
+#define SELFTEST_SDXI_FIXTURE_DEVICE_H
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/sdxi.h>
+
+#include "lib.h"
+
+#include "../../kselftest_harness.h"
+
+FIXTURE(dev_sdxi) {
+	int fd;
+};
+
+FIXTURE_SETUP(dev_sdxi) {
+	errno = 0;
+	self->fd = open("/dev/sdxi0", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(self->fd, 0) {
+		if (errno == ENOENT)
+			SKIP(return,
+			     "/dev/sdxi0 does not exist");
+		if (errno == EACCES && geteuid() != 0)
+			SKIP(return,
+			     "insufficient privileges");
+	}
+}
+
+FIXTURE_TEARDOWN(dev_sdxi) {
+	EXPECT_EQ(close(self->fd), 0);
+}
+
+#endif /* SELFTEST_SDXI_FIXTURE_DEVICE_H */
diff --git a/tools/testing/selftests/sdxi/lib/lib.c b/tools/testing/selftests/sdxi/lib/lib.c
new file mode 100644
index 000000000000..26a9470d2c97
--- /dev/null
+++ b/tools/testing/selftests/sdxi/lib/lib.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI selftest library helpers.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <stdatomic.h>
+#include <time.h>
+#include <errno.h>
+
+#include "linux/kernel.h"
+#include "linux/bitfield.h"
+#include "linux/bits.h"
+#include "linux/types.h"
+
+#include "descriptor.h"
+#include "lib.h"
+
+#define DESC_SUBTYPE GENMASK(15, 8)
+#define DESC_TYPE GENMASK(26, 16)
+#define DESC_VL  BIT(0)
+#define DESC_SE  BIT(1)
+#define DESC_FE  BIT(2)
+#define DESC_CH  BIT(3)
+#define DESC_CSR BIT(4)
+#define DESC_RB BIT(5)
+
+#define DESC_NP BIT_ULL(0)
+#define DESC_CSB_PTR GENMASK_ULL(63, 5)
+
+enum sdxi_op_group {
+	OPGRP_DMAB = 0x001,
+};
+
+enum sdxi_operation {
+	DMAB_NOP = 0x01,
+	DMAB_COPY = 0x03,
+};
+
+struct sdxi_desc sdxi_dsc_encode_rsvd(void)
+{
+	u32 opcode =
+		FIELD_PREP(DESC_VL, 1) |
+		FIELD_PREP(DESC_SE, 0) |
+		FIELD_PREP(DESC_FE, 1) |
+		FIELD_PREP(DESC_CH, 0) |
+		FIELD_PREP(DESC_CSR, 1) |
+		FIELD_PREP(DESC_SUBTYPE, 0) |
+		FIELD_PREP(DESC_TYPE, 0);
+	u64 csb_ptr =
+		FIELD_PREP(DESC_NP, 1) |
+		FIELD_PREP(DESC_CSB_PTR, 0);
+
+	return (struct sdxi_desc) {
+		.opcode = cpu_to_le32(opcode),
+		.csb_ptr = cpu_to_le64(csb_ptr),
+	};
+}
+
+struct sdxi_desc sdxi_dsc_encode_nop(void)
+{
+	u32 opcode =
+		FIELD_PREP(DESC_VL, 1) |
+		FIELD_PREP(DESC_SE, 0) |
+		FIELD_PREP(DESC_FE, 1) |
+		FIELD_PREP(DESC_CH, 0) |
+		FIELD_PREP(DESC_CSR, 1) |
+		FIELD_PREP(DESC_SUBTYPE, DMAB_NOP) |
+		FIELD_PREP(DESC_TYPE, OPGRP_DMAB);
+	u64 csb_ptr =
+		FIELD_PREP(DESC_NP, 1) |
+		FIELD_PREP(DESC_CSB_PTR, 0);
+
+	return (struct sdxi_desc) {
+		.opcode = cpu_to_le32(opcode),
+		.csb_ptr = cpu_to_le64(csb_ptr),
+	};
+}
+
+struct sdxi_desc sdxi_dsc_encode_copy(void *dest, const void *src, size_t n)
+{
+	u32 opcode =
+		FIELD_PREP(DESC_VL, 1) |
+		FIELD_PREP(DESC_SE, 0) |
+		FIELD_PREP(DESC_FE, 1) |
+		FIELD_PREP(DESC_CH, 0) |
+		FIELD_PREP(DESC_CSR, 1) |
+		FIELD_PREP(DESC_SUBTYPE, DMAB_COPY) |
+		FIELD_PREP(DESC_TYPE, OPGRP_DMAB);
+	u64 csb_ptr =
+		FIELD_PREP(DESC_NP, 1) |
+		FIELD_PREP(DESC_CSB_PTR, 0);
+
+	return (struct sdxi_desc) {
+		.opcode = cpu_to_le32(opcode),
+		.csb_ptr = cpu_to_le64(csb_ptr),
+
+		.copy = (struct sdxi_desc_copy) {
+			.size = cpu_to_le32(n - 1),
+
+			// Note that akeys are hardcoded to 1 here and
+			// in the driver.
+			.akey0 = cpu_to_le16(1),
+			.akey1 = cpu_to_le16(1),
+			.addr0 = cpu_to_le64((uintptr_t)src),
+			.addr1 = cpu_to_le64((uintptr_t)dest),
+		},
+	};
+}
+
+static void copy_desc_to_ring(struct descriptor_ring *ring, size_t idx,
+			      const struct sdxi_desc *src)
+{
+	struct sdxi_desc *dst;
+
+	idx = idx % ARRAY_SIZE(ring->entry);
+	dst = &ring->entry[idx];
+
+	for (size_t i = 1; i < ARRAY_SIZE(src->qw); ++i)
+		dst->qw[i] = src->qw[i];
+
+	atomic_thread_fence(memory_order_acq_rel);
+
+	dst->qw[0] = src->qw[0];
+}
+
+static u64 sample_read_index(const struct sdxi_context *cxt)
+{
+	return le64_to_cpu(READ_ONCE(cxt->cxt_sts->read_index));
+}
+
+int sdxi_submit_async(struct sdxi_context *cxt, const struct sdxi_desc *desc, u64 *pos)
+{
+	u64 read, old_write, new_write;
+
+	if (!sdxi_context_running(cxt))
+		return -EIO;
+
+	read = le64_to_cpu(READ_ONCE(cxt->cxt_sts->read_index));
+	atomic_thread_fence(memory_order_acq_rel);
+	old_write = le64_to_cpu(READ_ONCE(*cxt->write_idx));
+
+	if (read > old_write)
+		return -EINVAL;
+
+	new_write = old_write + 1;
+	if (new_write - read > cxt->n_entries)
+		return -ENOSPC;
+
+	WRITE_ONCE(*cxt->write_idx, cpu_to_le64(new_write));
+	atomic_thread_fence(memory_order_acq_rel);
+	copy_desc_to_ring(cxt->ring, old_write, desc);
+	WRITE_ONCE(*cxt->doorbell, cpu_to_le64(new_write));
+
+	if (pos)
+		*pos = old_write;
+	return 0;
+}
+
+// Submit nops until the function increments the read index or the
+// threshold is reached. Sleeps 1ms between each nop.
+static int force_read_index_advance(struct sdxi_context *cxt, u64 target)
+{
+	struct sdxi_desc nop = sdxi_dsc_encode_nop();
+
+	for (size_t tries = 1000; tries > 0; --tries) {
+		if (sample_read_index(cxt) >= target)
+			return 0;
+		sdxi_submit_async(cxt, &nop, NULL);
+		nanosleep(&(struct timespec) {
+				.tv_nsec = 1000000,
+			  }, NULL);
+	}
+
+	fprintf(stderr, "Failed to force read index advance to %llu\n",
+		(unsigned long long)target);
+	return -ETIMEDOUT;
+}
+
+int sdxi_submit_sync(struct sdxi_context *cxt, const struct sdxi_desc *desc)
+{
+	u64 pos;
+	int err;
+
+	err = sdxi_submit_async(cxt, desc, &pos);
+	if (err)
+		return err;
+
+	return force_read_index_advance(cxt, pos + 1);
+}
+
+int sdxi_submit_oneshot(const struct sdxi_desc *desc)
+{
+	struct sdxi_context *context = sdxi_context_create();
+	int err;
+
+	if (!context)
+		return -EIO;
+
+	err = sdxi_submit_async(context, desc, NULL);
+
+	sdxi_context_destroy(context);
+
+	return err;
+}
diff --git a/tools/testing/selftests/sdxi/lib/lib.h b/tools/testing/selftests/sdxi/lib/lib.h
new file mode 100644
index 000000000000..38e7d665085e
--- /dev/null
+++ b/tools/testing/selftests/sdxi/lib/lib.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI selftest library helpers.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef SELFTEST_SDXI_LIB_H
+#define SELFTEST_SDXI_LIB_H
+
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include "descriptor.h"
+#include "linux/build_bug.h"
+#include "linux/types.h"
+
+struct sdxi_cxt_sts {
+	__u8   state;
+	__u8   misc0;
+	__u8   rsvd_0[6];
+	__le64 read_index;
+};
+
+enum {
+	SDXI_DESC_RING_ENTRIES = 1024,
+};
+
+struct descriptor_ring {
+	struct sdxi_desc entry[SDXI_DESC_RING_ENTRIES];
+};
+
+struct sdxi_context {
+	int device_fd;
+	int cxt_fd;
+	__u32 pasid;
+	__le64 *doorbell;
+	size_t doorbell_bytes;
+	__le64 *write_idx;
+	size_t write_idx_bytes;
+	size_t n_entries;
+	struct sdxi_cxt_sts *cxt_sts;
+	size_t cxt_sts_bytes;
+	struct descriptor_ring *ring;
+	size_t ring_bytes;
+};
+
+size_t sdxi_context_db_stride_bytes(int device_fd);
+struct sdxi_context *sdxi_context_create(void);
+void sdxi_context_destroy(struct sdxi_context *cxt);
+bool sdxi_context_running(const struct sdxi_context *cxt);
+
+struct sdxi_desc sdxi_dsc_encode_copy(void *dest, const void *src, size_t n);
+struct sdxi_desc sdxi_dsc_encode_nop(void);
+struct sdxi_desc sdxi_dsc_encode_rsvd(void);
+
+int sdxi_submit_async(struct sdxi_context *cxt, const struct sdxi_desc *desc, u64 *pos);
+int sdxi_submit_sync(struct sdxi_context *cxt, const struct sdxi_desc *desc);
+int sdxi_submit_oneshot(const struct sdxi_desc *desc);
+
+#endif/* SELFTEST_SDXI_LIB_H */
-- 
2.56.1

