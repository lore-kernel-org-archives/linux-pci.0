Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120368;
	b=AV2svdxtA7eKqEDuHiLON3DgjixobjV4IkQ+H6kkcCGwSkP5IgKMeVc12G52Juq8ONyz
	 tqsjZIjNBAcp1XDTINqsphry2MdEykxztrkISZaRNwvI+TwsVW/he73x/9DRwsSYIQNMB
	 8purAKFhgn77z2/3P/Lwc4x6ggElkfzm2m72YlagPQjvrvm7ShnA4VqhGIKA+pIDvRQ3+
	 Medx4NV4QXQREcqFMck9gHmgeeZvh4CX80UMsjeLd8BnmfcGG+a/GL5XKxfyWFVKf+r7g
	 IIdQ7wR7iFGKdy1q0bhaRR1plj/yMGemsnR+U4ee9kNUDcCUDjvHsw9SjIgfH+9qXlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120368;
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
	bh=X/nzU6rYuI/0znhELWbs32MwWLczHmbi2Fe78Su8/EY=;
	b=ZhBobtZrIrTZngPOIRQ7dKTczZGJR7to0SLjDfH5YeaVocOJNpcKz7yTKS2G1pdtU++y
	 Nl5ofFX5AfuriBCHNzuEAJPFgNhYsojTG2SFZulNziWmWi/bWmxc3juRZgdorXWa5CmIv
	 KYcZ6jELzl+G/9x6Myom0zg0vP3ww5QIc5IFKWEHL/ocQaBucVYBMR4pNWfS+fqKWhbl9
	 9ogDYl8Or9ZFCm/ZHTfDiOYiSTBVyucnyREHegevee/9NDj9OejFoZbgI4vM2Nmf/j+AK
	 ZvSN1aAy/iC4ViEytdJMwW30EEL7Q+3taY2ezJHDLesmRhK1bW7fEBGdoaxuriCJSCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="Fbm/5jmY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.52
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818260A380C;
	Thu, 19 Nov 2026 20:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E818260A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Fbm/5jmY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+IM3BZ6256Gnf/QmCGIosJZnebLQ98SeYsJluzJE9d8Omw1V3dVYOtVOVDWNmTum1aBjFkiPOYXrC0PcKII5Ue4qlAuPXYyjtZiI9d4vtK/JYUm1M2W5t0KikrAzbLAoV5azDdu9UGn2tVSNo5GOOnPNw69h4d5JCSjT+R1lPlNMmYx8VVSc75m+l4ud8nSvY3bTtu0MUe7L+tA+4JsDKJPJyaTWFwZScXRdA2fyOZ2JJ68VoxCe0UM+Oew85jQJ/sWp4M1L/72Zy75xNt/u1uI2+uuyerbm2mKHxHdciy/xV6R4w8k4aEqwedvaelFpp9aoI5cCABtF27JSrdWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/nzU6rYuI/0znhELWbs32MwWLczHmbi2Fe78Su8/EY=;
 b=Y1MaM2usxa2+DYFRl/QoVlsjEHKWoqIyTQ7skLCMWY3nmkHN5zRQxL/yNNmyLAdC+NU2F+nQMwHiXbspjeQTRXPZWiXpH77yUb8YhSvEJq2mcMMVPrgaVcVNmM+dRa7nzFI+C1G72hiiFV5DM8VIM1veMWLykVqPwrTfDukeHWGXbj/GUXf68M24c92qaSsHiAnvLSWoG8O97d2T/F2mCkdQvNeO28K3R7OvGKKsahFCz9a8pNtHNVFzc3KTMnM6mD8YvZPC02mDPd2I1h5o6xUCwcgkAdQcWjQ+rUtlw/vxjeX8ahRcWVrD7i45lwb1n4KtqsmllADY4CPUGAI1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/nzU6rYuI/0znhELWbs32MwWLczHmbi2Fe78Su8/EY=;
 b=Fbm/5jmY0LAmrfe9qWpsANBUZiGOBRuEpEzgiBkmH2CwLrZCSEagUPodvLyTr+ge1Xx+rmSpZv5l0Ja7hnUtgsp5LyaGkcaNn+MHaiXtYR17raRbcXt/KgiCesC0EaROBfzqAk/DtLDdEH5t+/QT7JvjPYCY8vKR/5V9bI+yPbg=
Received: from CYXPR03CA0058.namprd03.prod.outlook.com (2603:10b6:930:d1::16)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:32:40 +0000
Received: from CY5PEPF00000E88.namprd05.prod.outlook.com
 (2603:10b6:930:d1:cafe::22) by CYXPR03CA0058.outlook.office365.com
 (2603:10b6:930:d1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 20:32:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E88.mail.protection.outlook.com (10.167.247.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:32:40 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:32:38 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 42/44] selftests: sdxi: test vendor admin ioctls
Date: Thu, 19 Nov 2026 14:23:18 -0600
Message-ID: <20261119202321.1734355-43-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E88:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b4aae4-1612-4c07-3b0f-08df467c41c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|23010399003|6133799003|18002099003|261009223027099003|22082099003|261021133027099003|261021130227099003|261021135927099003|261022105027099003|261021121427099003|261102123227099003|261026130827099003|261026135527099003|261026121527099003|261026140227099003|261028144727099003|56012099006|261022113327099003|261022075727099003|11063799006|261021123027099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lbbbXhczwzq+JM/A54sljNk1xjAc3bWIjE8StQ94N+ySfuSoMNO3By03PM1sP8XT8kEeXzp4z7j6NqCgx23hyTBloyKRuNv0fiVZJ7qfNglEeKIEvEyZRCDuqz6Tv1GLRPyk2F17Isz0DMOTCvb30bDuOVlOAkAi24Qu25RMoPB3JA4Ynl1pzP2eyu4QJAQoKMC7Bai+ZSDdG0NPVSyYWbmQZkDyTdEJAReyBLJQ9slPdnajqHXJ/Lw1TYyNc8hOvf4iMt0J2sq6ELpFThkutZwpJIaOEOct5LyAKqarut/maAvxaVtwE0zmFA9lqV3w8WZB6brlQTGKxILenX2SHR8lG9NQaUodakDEJqRZ33m24A4MQ0xsP/zUF21bqveKplcepQBO5CNgt7kywXUwoAA3cfgoif4XvsrwdLW7Spg3k/hQkTe+xLbPVW2W57djwHyKWacp0Hn4K+aFl4HJceLTaxTWftEyRyNRtbEhflRhI6m11jhhOiqgQX9U2alfuD1UmAOGklLC5YQAbewINo1pCtivgr834YNNly+IysitUyiRCCDtmXBGwh88jsXzG+cZj15A5zON2v7XwtJhbZK4gg7Xj9ejlrz9GktyAbc2elLkxiOhpNyU3oIzFHXX1gdSPIdJyaz+p0wIKbryjGkzFI94HBVnuTaP9xTzJRJxHxVcifVmDYGp3lGwIwSQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(23010399003)(6133799003)(18002099003)(261009223027099003)(22082099003)(261021133027099003)(261021130227099003)(261021135927099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026130827099003)(261026135527099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(261022113327099003)(261022075727099003)(11063799006)(261021123027099003)(261022115727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CdtY/ShWo4QKQjP6W4Lv7wJ+rBDRZLeXj9dVDYes5pYxli2T21DyaEW2dpeBNXljDDi7m4gDHuZ5fod0ZQJmdRxzMsh1wS5b0JrtQyNd4jMk+9Kln0oNaoMUyOdD+gUoIfMGPyTuqEA42pqSleIum0NF1bfhJ/g/ZlKC44M8fQNidHvlHRS7Tnm9ArvFC8bf2JLVgwB0yyxZxHygPr9lUa5lI2PgWCHfLqtTSl8SV1k889Gyp6JzbwWOV0Z72BBZSq0OhrcGkO04AQ5f3Q+qNTZlPPAJ1y3akd2ZSVZQ/bPSNf06aL9M32iCBt/0h4++ZsHpPxrxUCDajmPvpRUlrY84gZHbdCo6M9BHfPWFDYi8+XjYB5Eh8kfCtMHs8Nywk6c8WEwsSo6w0jan2sTvxmYThl4ULWuz+p/mJx73+QlxTjGEbM+E1FygDlaO1sDR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:32:40.2023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b4aae4-1612-4c07-3b0f-08df467c41c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E88.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282

Add root-only coverage for the SDXI_ADMIN_VENDOR probe path and AMD
QoS capability command. Skip the test when the device does not advertise
the QoS vendor operation.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 tools/testing/selftests/sdxi/.gitignore  |   1 +
 tools/testing/selftests/sdxi/Makefile    |   2 +-
 tools/testing/selftests/sdxi/admin_cmd.c | 104 +++++++++++++++++++++++
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sdxi/admin_cmd.c

diff --git a/tools/testing/selftests/sdxi/.gitignore b/tools/testing/selftests/sdxi/.gitignore
index 17855ea86222..022002a27306 100644
--- a/tools/testing/selftests/sdxi/.gitignore
+++ b/tools/testing/selftests/sdxi/.gitignore
@@ -3,3 +3,4 @@
 /copy
 /error
 /device
+/admin_cmd
diff --git a/tools/testing/selftests/sdxi/Makefile b/tools/testing/selftests/sdxi/Makefile
index 88e51b08f468..abdb33981d91 100644
--- a/tools/testing/selftests/sdxi/Makefile
+++ b/tools/testing/selftests/sdxi/Makefile
@@ -2,7 +2,7 @@ werror := -Werror
 CFLAGS += -std=gnu17 -Og -Wall -Wextra $(werror) $(TOOLS_INCLUDES) $(KHDR_INCLUDES)
 CPPFLAGS += -I../../../include/ -Ilib/
 
-TEST_GEN_PROGS := context nop copy error device
+TEST_GEN_PROGS := context nop copy error device admin_cmd
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/sdxi/admin_cmd.c b/tools/testing/selftests/sdxi/admin_cmd.c
new file mode 100644
index 000000000000..f82395931bc6
--- /dev/null
+++ b/tools/testing/selftests/sdxi/admin_cmd.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI admin command selftests.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <errno.h>
+#include <linux/sdxi.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include "lib/fixture-device.h"
+#include "../kselftest_harness.h"
+
+/*
+ * SDXI DSC_DISC uses RFC4122-like GUIDs, but with time_low/time_mid/time_hi
+ * stored in little-endian order.
+ */
+static const uint8_t sdxi_amd_guid_qos[16] = {
+	0x0b, 0x61, 0xb7, 0xf5, 0xc6, 0x0d, 0x03, 0x4c,
+	0xab, 0x79, 0x65, 0xf1, 0xf4, 0xef, 0xcf, 0x4c,
+};
+
+/*
+ * AMD QoS vendor operations are GUID-scoped and not part of the generic
+ * UAPI header. The kernel maps these op ids onto the vendor descriptors
+ * internally.
+ */
+#define SDXI_AMD_QOS_ADMIN_OP_CAP	1U
+
+TEST_F(dev_sdxi, admin_disc_operation_groups)
+{
+	uint8_t disc_buf[31 * 16] = {0};
+	struct sdxi_admin_disc_args args = {
+		.argsz = sizeof(args),
+		.index = {
+			.start = 1,
+			.end = 31,
+		},
+		.buf_uptr = (uint64_t)(uintptr_t)disc_buf,
+		.buf_size = sizeof(disc_buf),
+	};
+	int rc;
+
+	rc = ioctl(self->fd, SDXI_ADMIN_DISC, &args);
+	if (rc != 0) {
+		if (errno == EOPNOTSUPP)
+			SKIP(return, "admin discovery not supported");
+		ASSERT_EQ(rc, 0);
+	}
+
+	EXPECT_EQ(args.buf_size, sizeof(disc_buf));
+}
+
+TEST_F(dev_sdxi, admin_vendor_qos_cap)
+{
+	uint8_t cap_buf[48] = {0};
+	uint32_t word;
+	int rc;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+
+	struct sdxi_admin_vendor_args probe = {
+		.argsz = sizeof(probe),
+		.op = SDXI_ADMIN_VENDOR_PROBE,
+	};
+	struct sdxi_admin_vendor_args cap = {
+		.argsz = sizeof(cap),
+		.op = SDXI_AMD_QOS_ADMIN_OP_CAP,
+		.out_uptr = (uint64_t)(uintptr_t)cap_buf,
+		.out_size = sizeof(cap_buf),
+	};
+
+	memcpy(probe.guid, sdxi_amd_guid_qos, sizeof(probe.guid));
+	memcpy(cap.guid, sdxi_amd_guid_qos, sizeof(cap.guid));
+
+	rc = ioctl(self->fd, SDXI_ADMIN_VENDOR, &probe);
+	if (rc != 0) {
+		if (errno == EOPNOTSUPP)
+			SKIP(return, "QoS vendor path not supported");
+		EXPECT_EQ(0, rc);
+		return;
+	}
+
+	rc = ioctl(self->fd, SDXI_ADMIN_VENDOR, &cap);
+	if (rc != 0) {
+		if (errno == EOPNOTSUPP)
+			SKIP(return, "QoS CAP not supported");
+		EXPECT_EQ(0, rc);
+		return;
+	}
+
+	word = (uint32_t)cap_buf[8] |
+	       ((uint32_t)cap_buf[9] << 8) |
+	       ((uint32_t)cap_buf[10] << 16) |
+	       ((uint32_t)cap_buf[11] << 24);
+	EXPECT_NE(0U, word & 0x0fff);
+}
+
+TEST_HARNESS_MAIN
-- 
2.56.1

