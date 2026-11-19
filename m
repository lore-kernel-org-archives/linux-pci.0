Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120355;
	b=pD1nqY5pqWILmkT6DKotY9NwVBr6/zUIysXrJY/UJc8bLCOKEYTb6IT0mhTaqXJsLZGR
	 8LYWWNGebWFn9qJLvx6gJScce9S8Et7TpiMgp1+hW9jEx94Sef/1rAM4tlcX/S+AoZrfA
	 bCCJCs2VkvUfyxT3w3f8FvKffrAcEnU1Ce904oN+rkctyEjwqDK+RGWWSxfo3RSbpwerh
	 q12XyQqY7m7c6eIUAhmuI4KKBIoU8kTKdINZqH9UicfFt8JYFHx8rXdiEWBu2nkHwzpPi
	 7rXK3zmfcw0EjLaG6a2dBjjxzVwcpZBpMXWa4GD1JMFGAEYYfsQpY3ZN4/3B3UkCGfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120355;
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
	bh=f6Sn0Yjh9bNXhoZY50G8FJwS2wtqWGcLzd4WPMO8lgg=;
	b=dOv1E/U0BIHw5wEwJyeD7fHuRt7jjS8Eq0tjXumYVvppRxqL8DASe2xTcmtLlVK6eeMX
	 Alft+TqV+OJQMaOCe+MKqZncWpGSVp1paT5dBHfnaS/UCQNEu7pJ2xcQtu0YjditMczyP
	 ZOwu4p1cnH0Ju6y18D7MfmwjRsGx3Ij81YPV9DFdQ7VYfV32gKO0/d7PWEg5xw2F1GUfB
	 LoWlkMUZCAjrrx5nTF6m2HYisCMwFwIpfqhjaiUK9sKwg2Qw/OCDa0T1KF4QdOtzkF6/d
	 W6UrP+3x0k9mChgesvRsEqjvDoBrUYlQJM56oDgbXYEboOxj1Cg5McrEhRqsNb27/kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="kl42/ZVv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.68
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F860A2635;
	Thu, 19 Nov 2026 20:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D8F860A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kl42/ZVv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfAr+MsPqdzIuADD8s59M8fCX9suP3/dizqo5pyTjhP+p4EnGHZF4FmFcFqAHsA3pj7oXMIHtZm8FRaFpwGhaDJ74ZVO7+jvAwrL/Y4CVlbO9/5PTuIwUYSIPVf9gzHeePlmlmO3BSlIO+e0y95wixRsjTadAD07dRd7PI5LFiKQbtwwvRRsdtZgpkh3+/LMAMclsJHY3BrXgWgADKsTs1htK07WL/qz8qpNgu7HaqqMZ6GWe7P+UntUi5ie3ijMy7WyS9F+gihrnIsTJJ+SMZDOblQKp4iyj8UiZmADXxoi+6FaI5fjYimlMXSNooVWYCvY2zCOrhatCZ/3NPLFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6Sn0Yjh9bNXhoZY50G8FJwS2wtqWGcLzd4WPMO8lgg=;
 b=wWq6AgetQMiwqfBsCqs6mRuRymfgrKpATfs2UJBFEXwRrNNhNxRyD23XnZEn9rMw2aIl1PvgR8buOo7ziImvrDg4Xj8KL3O7MZmwCuQe0WYdBVyH24nVUa5nySjmFuePuTcFhkydVtc1OwL6f/Ghmko+qjgVTDL1wk61U9S62hqFB+/obrupwDXn7tPxGwyVYYl+uWF8EvqrDnuqiNTDSSXjCEkpohBtfclXAw7fkY+RZ+DQjWv8MpTn5OL093lvXNJIMljVBvX3ybNMHyhdGV1W+gxMA7VPU0e5RvYtvcEeHuXcXDQBndf6WMg3j+kC4FBMMsRS4UpfGvIt2m6q4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6Sn0Yjh9bNXhoZY50G8FJwS2wtqWGcLzd4WPMO8lgg=;
 b=kl42/ZVvzl1f/BmrKmeOhhRZ9ibC+ZgYKLTP8kFf2EAEJkCPktOgPmRoWyi1JeFqhi4yTtjCNaHCleH01s5yvUMTfi1Iw+pNFulAHrDSKafw4HG0bXMaLyVVwddz2c2ovcUyCZpLm4OuSXGBPF7uEFpEmnLTU3ywMHa4UfmKYXk=
Received: from CY5PR22CA0035.namprd22.prod.outlook.com (2603:10b6:930:1d::11)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:32:28 +0000
Received: from CY5PEPF00000E85.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::62) by CY5PR22CA0035.outlook.office365.com
 (2603:10b6:930:1d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:32:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E85.mail.protection.outlook.com (10.167.247.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:32:28 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:32:27 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 41/44] selftests: sdxi: test device ioctls
Date: Thu, 19 Nov 2026 14:23:17 -0600
Message-ID: <20261119202321.1734355-42-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E85:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c60bd44-b212-44c9-34d1-08df467c3ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|6133799003|22082099003|18002099003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|56012099006|261026140227099003|261102123227099003|261026121527099003|261028144727099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hxik4XpThDVnXWPG3tFsj0QuGO36o7E1kBZ2iRmTRMwxn/fDRa7Di5+btCMFqzjNVv2QUl3Sr20ovBq847m/WRTTq6F30Tv6gFkNvQCC743nQlK2KdVkVaqGZEV7za9WU2MqOCuEDvZ27s2EUuJcbAc7fuKUBVhP8VbPsGJbX8/GVGKnEJIOfxMHDyQCGPB960Yw4HZ4x4XIc13pGTFnT6pmoCuYMrioRulcXryBNgeSGoG0POWUGDp3txhloFawpdWvpUFmX8mUpY+BLJx7Jdst/1UXekrT6Z3kLULzmbQyDdgRWjIHLzBoc8CDU2TXdFh2s5KBP5NlmLjCSZDLPvXW8FhKG0QvLOn0cPMMkz29rp+dlgQgQGGWwA9KBYSkkJZtcUkjGEq4INaNWvyiBbb418Md2soVHLV7bwpD0x7FqFNiHqTpBfewSpxBCVbogtLW6v/K4zNGhWByvkG+YBqP6TwoiOQBoSgFwEmDzdUnwdpiQmYdZJqka6WF1lCPFUjwlngsMvWVyxsBOj4nA9aI4k4mEZPd102GUrYhAw68Iu+BnX1HqWbwIzsFU+vQGJtmWlrAtUWXvFAoVPQoJlEyQbj4knshCZMdvHJsxPsIN2cJ1WUI+N2C7Cbe86Ol3SnwhLlzaQcEopJ297ZBLV/CzyZTglC11IorAtqSmabx4Ocfnl2KLfbXEFfScqLNcmvbUBb78ewDnvjJoBaydw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LNTkAtWHYHWNfUnPJFRnqeyAkMN5O3if+R+jYkcwu32YPNWkh7zTSYVGb6dFr56cGICsYy9nAeo/RTVXpC9SqGe83WTjAo7XyEJZn5RjWCo7zFRiHAYuXSK4e1EsH9QVZ09oRHORQz6Fa0+B0gJGXFSw9POPPw1nAfsZYbyU8kkWaWHFau5W0VshcFX2KoDiSyz1CIni43p0sYWc2rL+oYvp01yULdl1C8F7fOJ6XgWSMGKxZuh0qCFvFv686nt48BpSEPnYh8vBelWu+m2XToqfFfXKrbd+YdZc44LZtSlmdz5jJXAdhsF7Q572F00g9thPk7DgUoTt36uQP1xvNqtYfXkHfpO7U85yBKo6UQNz0b74KPRFvXlcNLRoYXN/j+SldcHxviHZuHIAj8CivsfuHWitD8OpKLzTMgSNWfxuJtiWsSWMTAX5ji2Esh4W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:32:28.5232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c60bd44-b212-44c9-34d1-08df467c3ac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E85.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865

Add coverage for UAPI discovery, device information and device
attribute ioctls to SDXI selftest suite.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 tools/testing/selftests/sdxi/.gitignore |   1 +
 tools/testing/selftests/sdxi/Makefile   |   2 +-
 tools/testing/selftests/sdxi/device.c   | 245 ++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sdxi/device.c

diff --git a/tools/testing/selftests/sdxi/.gitignore b/tools/testing/selftests/sdxi/.gitignore
index d891f7a24c40..17855ea86222 100644
--- a/tools/testing/selftests/sdxi/.gitignore
+++ b/tools/testing/selftests/sdxi/.gitignore
@@ -2,3 +2,4 @@
 /nop
 /copy
 /error
+/device
diff --git a/tools/testing/selftests/sdxi/Makefile b/tools/testing/selftests/sdxi/Makefile
index c05390cb9d86..88e51b08f468 100644
--- a/tools/testing/selftests/sdxi/Makefile
+++ b/tools/testing/selftests/sdxi/Makefile
@@ -2,7 +2,7 @@ werror := -Werror
 CFLAGS += -std=gnu17 -Og -Wall -Wextra $(werror) $(TOOLS_INCLUDES) $(KHDR_INCLUDES)
 CPPFLAGS += -I../../../include/ -Ilib/
 
-TEST_GEN_PROGS := context nop copy error
+TEST_GEN_PROGS := context nop copy error device
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/sdxi/device.c b/tools/testing/selftests/sdxi/device.c
new file mode 100644
index 000000000000..2fdec79e6bf5
--- /dev/null
+++ b/tools/testing/selftests/sdxi/device.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI device ioctl selftests.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <linux/sdxi.h>
+
+#include "lib.h"
+#include "lib/fixture-device.h"
+#include "../kselftest_harness.h"
+
+TEST_F(dev_sdxi, open_and_close_device)
+{
+	// Just run the fixture setup and teardown
+}
+
+TEST_F(dev_sdxi, get_uapi_info)
+{
+	struct sdxi_uapi_info_args info = {};
+
+	info.argsz = sizeof(info);
+
+	ASSERT_EQ(ioctl(self->fd, SDXI_GET_UAPI_INFO, &info), 0);
+	EXPECT_EQ(info.uapi_major, SDXI_UAPI_MAJOR);
+	EXPECT_EQ(info.uapi_minor, SDXI_UAPI_MINOR);
+	EXPECT_GT(info.cap_words, 0);
+	EXPECT_LE(info.cap_words, SDXI_UAPI_CAP_WORDS);
+	EXPECT_EQ(info.rsvd0, 0);
+	/* The driver must publish at least one capability bit. */
+	EXPECT_NE(info.caps[0], 0ULL);
+	EXPECT_NE(info.caps[0] & SDXI_UAPI_CAP_ADMIN_VENDOR, 0ULL);
+	EXPECT_NE(info.caps[0] & SDXI_UAPI_CAP_CXT_EVENTFD, 0ULL);
+}
+
+TEST_F(dev_sdxi, get_uapi_info_rejects_flags)
+{
+	struct sdxi_uapi_info_args info = {};
+
+	info.argsz = sizeof(info);
+	info.flags = 1;
+
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_UAPI_INFO, &info), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(dev_sdxi, get_dev_info)
+{
+	struct sdxi_dev_info_args info = {};
+
+	info.argsz = sizeof(info);
+
+	ASSERT_EQ(ioctl(self->fd, SDXI_GET_DEV_INFO, &info), 0);
+	EXPECT_EQ(info.argsz, sizeof(info));
+	/* SDXI 1.x devices report a non-zero major version. */
+	EXPECT_GE(info.hw_major, 1);
+	EXPECT_EQ(info.rsvd0, 0U);
+	EXPECT_EQ(info.rsvd1[0], 0ULL);
+	EXPECT_EQ(info.rsvd1[1], 0ULL);
+	EXPECT_EQ(info.rsvd1[2], 0ULL);
+	EXPECT_EQ(info.rsvd1[3], 0ULL);
+}
+
+TEST_F(dev_sdxi, get_dev_info_rejects_flags)
+{
+	struct sdxi_dev_info_args info = {};
+
+	info.argsz = sizeof(info);
+	info.flags = 1;
+
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_DEV_INFO, &info), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(dev_sdxi, get_dev_info_rejects_short_argsz)
+{
+	struct sdxi_dev_info_args info = {};
+
+	info.argsz = sizeof(info) - 1;
+
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_DEV_INFO, &info), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+static int sdxi_get_dev_attr(int fd, uint64_t attr, uint64_t *out)
+{
+	struct sdxi_dev_attr_args args = {};
+	int rc;
+
+	args.argsz = sizeof(args);
+	args.attr = attr;
+
+	rc = ioctl(fd, SDXI_GET_DEV_ATTR, &args);
+	if (rc == 0 && out)
+		*out = args.val;
+	return rc;
+}
+
+TEST_F(dev_sdxi, get_dev_attr)
+{
+	uint64_t val;
+
+	ASSERT_EQ(sdxi_get_dev_attr(self->fd, SDXI_DEV_ATTR_MAX_BUFFER, &val), 0);
+	EXPECT_LE(val, 11U);
+
+	ASSERT_EQ(sdxi_get_dev_attr(self->fd, SDXI_DEV_ATTR_MAX_AKEY_SZ, &val), 0);
+	EXPECT_LE(val, 8U);
+
+	ASSERT_EQ(sdxi_get_dev_attr(self->fd, SDXI_DEV_ATTR_MAX_CXT, &val), 0);
+	EXPECT_GT(val, 0U);
+
+	/* MAX_RKEY_SZ is read-only and may be 0 if RKEY isn't supported. */
+	EXPECT_EQ(sdxi_get_dev_attr(self->fd, SDXI_DEV_ATTR_MAX_RKEY_SZ, &val), 0);
+}
+
+TEST_F(dev_sdxi, get_dev_attr_rejects_unknown)
+{
+	struct sdxi_dev_attr_args args = {};
+
+	args.argsz = sizeof(args);
+	args.attr = 0;
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_DEV_ATTR, &args), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+
+	args.attr = 0xffff;
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_DEV_ATTR, &args), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+}
+
+TEST_F(dev_sdxi, get_dev_attr_rejects_flags)
+{
+	struct sdxi_dev_attr_args args = {};
+
+	args.argsz = sizeof(args);
+	args.attr = SDXI_DEV_ATTR_MAX_BUFFER;
+	args.flags = 1;
+
+	errno = 0;
+	EXPECT_EQ(ioctl(self->fd, SDXI_GET_DEV_ATTR, &args), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(dev_sdxi, set_dev_attr_requires_admin)
+{
+	struct sdxi_dev_attr_args args = {};
+	uint64_t cur;
+	int rc;
+
+	if (geteuid() == 0)
+		SKIP(return, "needs non-root");
+
+	ASSERT_EQ(sdxi_get_dev_attr(self->fd, SDXI_DEV_ATTR_GRP_ID, &cur), 0);
+
+	args.argsz = sizeof(args);
+	args.attr = SDXI_DEV_ATTR_GRP_ID;
+	args.val = cur;
+
+	errno = 0;
+	rc = ioctl(self->fd, SDXI_SET_DEV_ATTR, &args);
+	EXPECT_EQ(rc, -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(dev_sdxi, set_dev_attr_round_trip)
+{
+	struct sdxi_dev_attr_args args = {};
+	uint64_t orig, applied;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+
+	ASSERT_EQ(sdxi_get_dev_attr(self->fd, SDXI_DEV_ATTR_GRP_ID, &orig), 0);
+
+	args.argsz = sizeof(args);
+	args.attr = SDXI_DEV_ATTR_GRP_ID;
+	args.val = orig;
+
+	ASSERT_EQ(ioctl(self->fd, SDXI_SET_DEV_ATTR, &args), 0);
+	EXPECT_EQ(args.argsz, sizeof(args));
+	EXPECT_EQ(args.val, orig);
+
+	ASSERT_EQ(sdxi_get_dev_attr(self->fd, SDXI_DEV_ATTR_GRP_ID, &applied), 0);
+	EXPECT_EQ(applied, orig);
+}
+
+TEST_F(dev_sdxi, set_dev_attr_rejects_exceeding_caps)
+{
+	struct sdxi_dev_info_args info = {};
+	struct sdxi_dev_attr_args args = {};
+	uint64_t cap_max_buffer;
+	int rc;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+
+	info.argsz = sizeof(info);
+	ASSERT_EQ(ioctl(self->fd, SDXI_GET_DEV_INFO, &info), 0);
+
+	cap_max_buffer = info.cap1 & 0xf;
+	if (cap_max_buffer == 0xf)
+		SKIP(return, "cap1.max_buffer already saturates the field");
+
+	args.argsz = sizeof(args);
+	args.attr = SDXI_DEV_ATTR_MAX_BUFFER;
+	args.val = cap_max_buffer + 1;
+
+	errno = 0;
+	rc = ioctl(self->fd, SDXI_SET_DEV_ATTR, &args);
+	EXPECT_EQ(rc, -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(dev_sdxi, set_dev_attr_rejects_read_only)
+{
+	struct sdxi_dev_attr_args args = {};
+	int rc;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+
+	args.argsz = sizeof(args);
+	args.attr = SDXI_DEV_ATTR_MAX_RKEY_SZ;
+	args.val = 0;
+
+	errno = 0;
+	rc = ioctl(self->fd, SDXI_SET_DEV_ATTR, &args);
+	EXPECT_EQ(rc, -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+}
+
+TEST_HARNESS_MAIN
-- 
2.56.1

