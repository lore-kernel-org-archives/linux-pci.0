Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119996;
	b=lOhgZyq56M7oMzYeaQocUQAWcdf2LldZrCEVPZx4s5WuI0O7sF14hTo28p8L9oDs7N2d
	 BsUTs7Je0at2W/gP51maj+WOJ0TWcqax12467KFi2hMyxeWb0y4AeYfOZ9lLvVEd6g7Do
	 h6FOIwRMqyBhohOUwKxu0u2gXvpRtxIKFO//Bc/9vSk3jGEa0h11HD5czoIPGyrwXOJP2
	 6SIxEiImPkmipQeHw44gNcsy5ouApETZ+Mbc+eq1bs6e/YI2l6MiY1qV10QlIxeSJ6Yok
	 Ac+mLgweOvjvGZT0q1aAlnf/Vl9bz/MdFZsBnFDd86sCfiO9GcYJ04WqTGfW+cOCaQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119996;
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
	bh=1llOAJzXEyj29+djqP6e1mc+Ccp4NwHGxgBc4R7kTX0=;
	b=uPgEV2GN3vETJdWI7SyyjD0mdtMBSsQNiykoHbGff4mONTtdoBc3DkAR3T+1uGAmj6rE
	 r1+M3myuGQmqUF7Km+rlwy9v6xvUJn4nn1PihuB4ErJmxtZ2581QVou0b9WGtEhzJJPLY
	 QABBJJJ4qNFGU3k3TBwc3SesmiR3TRO/3KGfoLJG2fsnWPxxVv7vjzybuIhRwfWJLYs0j
	 V/tlVuskrnU2yAIWcTyphWBAscn16AuToB6X917ISR+pn/jci4VMnD2MDnDIKxYNhwle5
	 oJDANjHK0qZjQEgPkLNMZL/UZ8U0sJqXqmNTGualyDDcyTwnn4IQ3HX+/7qlaHXOr1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aTJ6LhIG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.40
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D4606A32C;
	Thu, 19 Nov 2026 20:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754D4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aTJ6LhIG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVeuq1BWW2wavewiMSjrXVzp27tZ9SiAM0Pl06De4qf+eKm4Iu5/23GVjGcZRpYMk1ZYqkJ5JwLOnxyeNKVUsj5X727/PGbaooWQuhdSJ/Et9hXMUS4b8t1wwLNxSnRd/YwrtRQc1OZhew+PTgPmPe0Q5iR6m0hbvfcvQXqoP04RJBqTj9aVcZAcb12wUM6KGyV4jairv8K5BhlWx2QWyz25R8AsW4xLdJ+WVWk6/6x5ird/DXfizRwAv+GsXLlE4hAubo+vgCZ2hTzW6BumlvohZ2Pg8KG9laNdSM2Xg6x1o6f0F6R0dm4wnZK+SOJmbC853qj+KRxUyR6lIkRl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1llOAJzXEyj29+djqP6e1mc+Ccp4NwHGxgBc4R7kTX0=;
 b=gJ5wPuPt2NR9I5WnX6T5WkYCsxUNoxneeZ1SSsPOz/Y4+gvotYeeblY4oy8D4WjXmZntxvBZY1dyWcGLNgoXmGPFmpupwH3wx28ZnduqiEwgRAnU7f8vmGo4DG7J2L/R6HjfQ6nYVaDzVJzsobs04mG2yB+/yxMVrP1H7pqyyvldo9dQ/iW1VffehDuXZCxCWrdhT5DSq1SX4GvAF0dyLcCMOtSbdsaSnwlxp6YXJf6o6Edz/gCyKQWDvfrFtB+blMHCoRYGv2P5gAXC954IkalE8k/5ot+72WWogT7lHHOpE2jSKFgPpRTWBYT8oym5nBEnLYW5JNin+BdGA95n0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1llOAJzXEyj29+djqP6e1mc+Ccp4NwHGxgBc4R7kTX0=;
 b=aTJ6LhIGYD1O+ZLk+uDG2aKQkX48JJkyrC2xubsDhdZInQf0XNe9USP/eynbM2lSRzsIHNJjW/HlWkcfvr8DZ4aajRC7kzT6cyMMQrSM6iZcHd6Vc+HHu7q1NyfH34V8a23zQhP46i7VFHIkCUlTwLcYhurzGEG1FlylGz7hqCs=
Received: from CH2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:610:5b::38)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 20:26:29 +0000
Received: from DM3PEPF000265B8.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::9f) by CH2PR07CA0064.outlook.office365.com
 (2603:10b6:610:5b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:26:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B8.mail.protection.outlook.com (10.167.23.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:26:28 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:26:27 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 15/44] dmaengine: sdxi: add internal ioctl definitions
Date: Thu, 19 Nov 2026 14:22:51 -0600
Message-ID: <20261119202321.1734355-16-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B8:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: bc429bab-dbe0-4e71-ed65-08df467b6478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|7416014|18002099003|22082099003|56012099006|261021121427099003|261102123227099003|261026121527099003|261022113327099003|11063799006|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0Jwdc4LdZuZQ5TIu7JFp+V/n7WGLvnykGx4GFDHb18wCN4dRbxA2k1NOQylDBiVG+oxg7fFL9Gq0TAS068ilS8E5rfPaJ29kVOn/vGeDkh7RSpFdpq6TfKpohq50Mc39zZmIVN6FWa+W5aarBTVQHweevkkfJdC1yh21YXSrFaZ0XXGAJTg06NtOiQrMiOJz+Yngl0GPTZPadcWdiUfDQeg2jVjucuvupckqesf0ZvTrVVmLUuZAZY2s4IaTBgufkIc7JEqfDj55DSZCdiUjjzdGVplg1Bx6hqbBhbFxVy4hdxa6eGpZ9ec+WhgKYr+6244jX3P/NptAuxsAVBNTTeDLWpkiKPAGIXWRS/XmatCbeylpU2JvHREhwXMdRIUgZHAUd2+TCiBeeeesv6IhD0Jc72cgjEm3btWdqH2S/7HL6Ftt+2rx1XMZQVfel9+BehSvByJMFTWtHyeB8kd2F3yBmujp6AKW9w0xiwdi00RMQTNXGudWQjzDbjDMm3hXfGiPixCKw2amiN5at+DFM/6KKCEyH7MMT6Tv0BG7Z3ZC7HmAk2U4pi8gcGHh7feho6kPHGNJRVNcesPIzKTxBijDon1rxz+pz1BM56zRWP/alIRqeygYHyHDcLFMp7BZ51zxIFyme2RDFWOQsVNKg/hFcEiA7mLpYfZGsFqWeztLK9qNoz1K85rYGd6B1UJZvx6M/QZmB1Pc12qiMvea+A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(7416014)(18002099003)(22082099003)(56012099006)(261021121427099003)(261102123227099003)(261026121527099003)(261022113327099003)(11063799006)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KAwfv6JXb/XXKCU0/kYRTpsCXNF8JrDYIebs7no0Gc/7/vNnbGQGLBlJYtyCiNeU2TxMZzjHm9Uus/J5nFWdfmR889jeBGHAQh8qbLl3BO2VYGHLo5/6CcuXmS+wksL5SIuzEjbRaIeuGYihBWVmQX75iisp3RX7i/r62bzi4sKmorLkHnV2dxoLZCZRHbInITs+mlhwKAxb2MoaOvwnzI77idaF0wqCkATDBaaJePD1dVGK6NPmSl1GJxE7GB3MokXwrHp2KTl9jwpbCD9/53GwMWqP71ZSuSGjrUCwR/+EywC1UC1D8AHs3Oz/26Jq8NW78lBZelqLk1x+JxY8qAHoZMbIFOw8TOrMxW21HjTDtTFUEMt1+iL2zal5rI22yg3op+9giEEGAf46ULzoivdDg56B3avO3mL+6lpfuycT2ndhnljFK1/C/mzJtBsA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:26:28.9581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc429bab-dbe0-4e71-ed65-08df467b6478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419

Define device and context file classes, ioctl access classes, and the
page-aligned context mapping token used by the native SDXI character
device. This patch adds no public file operations yet.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/ioctl.h | 79 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 drivers/dma/sdxi/ioctl.h

diff --git a/drivers/dma/sdxi/ioctl.h b/drivers/dma/sdxi/ioctl.h
new file mode 100644
index 000000000000..8677f3e62e93
--- /dev/null
+++ b/drivers/dma/sdxi/ioctl.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI ioctl and context mapping definitions.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_IOCTL_H
+#define DMA_SDXI_IOCTL_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <asm/page.h>
+
+#include "process.h"
+
+struct file;
+struct sdxi_cxt;
+
+enum sdxi_file_type {
+	SDXI_FILE_DEVICE,
+	SDXI_FILE_CONTEXT,
+};
+
+struct sdxi_file {
+	enum sdxi_file_type type;
+	struct sdxi_process *process;
+	struct sdxi_cxt *cxt;
+};
+
+typedef int sdxi_ioctl_t(struct file *file, struct sdxi_file *sf, void *data);
+
+enum sdxi_ioctl_access_class {
+	SDXI_IOCTL_A_PUBLIC_DEVICE,
+	SDXI_IOCTL_A_CONTEXT_OWNER,
+	SDXI_IOCTL_A_ADMIN_DEVICE,
+	SDXI_IOCTL_A_VENDOR_HANDLER,
+};
+
+struct sdxi_ioctl_desc {
+	unsigned int cmd;
+	unsigned int file_flags;
+	enum sdxi_ioctl_access_class access;
+	sdxi_ioctl_t *func;
+	const char *name;
+};
+
+#define SDXI_IOCTL_F_DEVICE	BIT(0)
+#define SDXI_IOCTL_F_CONTEXT	BIT(1)
+
+#define SDXI_MMAP_TYPE_SHIFT		40
+#define SDXI_MMAP_TYPE_DOORBELL		(0x4ULL << SDXI_MMAP_TYPE_SHIFT)
+#define SDXI_MMAP_TYPE_MASK		(0x7ULL << SDXI_MMAP_TYPE_SHIFT)
+
+#define SDXI_MMAP_CXT_ID_SHIFT		24
+#define SDXI_MMAP_CXT_ID_MASK		GENMASK_ULL(39, 24)
+#define SDXI_MMAP_GEN_SHIFT		PAGE_SHIFT
+#define SDXI_MMAP_GEN_MASK		GENMASK_ULL(23, PAGE_SHIFT)
+
+static inline u64 sdxi_mmap_token(u64 type, u32 cxt_id, u32 generation)
+{
+	return type |
+	       (((u64)cxt_id << SDXI_MMAP_CXT_ID_SHIFT) &
+		SDXI_MMAP_CXT_ID_MASK) |
+	       (((u64)generation << SDXI_MMAP_GEN_SHIFT) &
+		SDXI_MMAP_GEN_MASK);
+}
+
+static inline u32 sdxi_mmap_token_cxt_id(u64 token)
+{
+	return (token & SDXI_MMAP_CXT_ID_MASK) >> SDXI_MMAP_CXT_ID_SHIFT;
+}
+
+static inline u32 sdxi_mmap_token_gen(u64 token)
+{
+	return (token & SDXI_MMAP_GEN_MASK) >> SDXI_MMAP_GEN_SHIFT;
+}
+
+#endif /* DMA_SDXI_IOCTL_H */
-- 
2.56.1

