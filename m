Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119828;
	b=skGZo6haAaYUKsCpvdrFJq6rF9qmhHOIH0tT9lrmAeQK2Xd10fV4TdZU45Bw3xvdH/A7
	 A9ho8vuyRwpAmsRCNie4QAYHyMZmvtAt68siQ2DUW4/aNiDI3n9Y9ckK/mNRQMB36uPZ1
	 VovULMP5LH3N3o+avmXVd5NtE1M9PrdZNTrFYXbC0UuhYH0b6JRbUzVyzVHuI4F214FsE
	 z8ea4zVmp2qsmTbCWjpAPNEFb+kstQCMxVhSKGnN+6FbKZdP3FV40Ain5n7ADh2UUfawE
	 2ODe/mVZ/JFvBVceYOAKpQzhAtrIVcCgbh1fAztg0XUqMNq6JQa0A4fgCWiVU7WijqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119828;
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
	bh=j6eJOW7ws0nqMVqSggYjelPWQXiHIiYer+HUiMaSFh8=;
	b=BluqK2mcOghKFKMpRVgCaUDUYJguthUUUJBcFiXyo7RVUsr2wB9rxifTOcM6btv2H61D
	 vaH+nejYRIbGP/xl96sdWPCYaikXfJIKnJWsNvD6SYkL6C8cxWfZzII19pTdY5YistV0p
	 S4/ROHBynW3a0c/BqcZSgGFJy7u/RSlsbUbWjF298R+1xzaceNqBL0ZhWiWWbW68roSIG
	 Hq7mw8kfqETnQRmvG1Wgqg2N6Sfq3guWGFVMAUTWzaHOgNNXdoFmVmJyLSyTXf2Jgqvr/
	 w7aqTMjFNRf/U0HSvwr+7z6zyfpJgkyji694eDFJKbmshHX+iTLG/mEcS+vfSEcJ4aA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3r0a8iIy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.31
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E7606A326;
	Thu, 19 Nov 2026 20:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD7E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3r0a8iIy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg5MtG/f2SiB1O081oc51PKZGSDdG/hbIZe4QrQDhVlt3yEaPzvDdXZS0NY4TywKAq7PjHs6mGOGd1fesE86qVdfrDb0BKWvFlv8DFOefLOtOorIDwzFk92AUTkXaquxJ83IQzW95VuiAUwLHb9SU39VU73DDrthGay8QWGwhXOlAq/mgwaOSPoqXvv64Sz5hFHx9KwYKbFGb7h6SWyuAhk0KHLgTocfCvkzUsYSBIsDZgcpwVexC+sY3T+NvtdRHr42IhKNgDreu+TS6Ua9PFRR4qPWazjCVUYnxfk8KmthaoMtNa1l4X8j+tsVSSPi86DAwMrUHegpKLvmNwYJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6eJOW7ws0nqMVqSggYjelPWQXiHIiYer+HUiMaSFh8=;
 b=MMXQ7oMco3He0DUPthub+h4c9URDktNC/EXkT/jYPhtqEP3KUrFZQYJ33HzYpYewjBoRG3CLA69Htfi2Gj0DBBYM8wHFcWGvXZtJlBn1nT2BTvKSyNOFVvrE2NxI3b6JHmeQFzRIzOAWQtTAZX4iCINu9WeWNhviKeTGTU0B35qwmpJoyfqe00irgZH8+iaeADOux62yihba1rAoBylgwD52M01G5oe9rOJthSxrLcj7Hu1JgVLXpy3B1Aev+78ezYmM9AW9CCYSugC3PyNSbaIUkEYvnJp+y8ggK0sglEMpbXLv8UXWWBUqi5HaslkK5zNm3Hcr4Bgb8AptStaKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6eJOW7ws0nqMVqSggYjelPWQXiHIiYer+HUiMaSFh8=;
 b=3r0a8iIy45VBZIhm4OF/QiXkwb/IrvT5BIzeETnZKy2MP399E5QsMeI5uXWfd7PBFRtPzId9Bh3MNBjOeLHdokke5SJANNHfYeJLdBQRhFEXwFCsQGwsZ9lwIrv+VyOtrX7+NVC70GGtHe3ysk7DbvLmPOzBvmCMkeryV9fG9AY=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by LV1PR12MB583771.namprd12.prod.outlook.com (2603:10b6:408:508::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 20:23:42 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::7b) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 20:23:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:23:41 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:23:39 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 01/44] dmaengine: sdxi: cache hardware version for feature gating
Date: Thu, 19 Nov 2026 14:22:37 -0600
Message-ID: <20261119202321.1734355-2-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|LV1PR12MB583771:EE_
X-MS-Office365-Filtering-Correlation-Id: b00b1c74-608c-4d9b-c0d2-08df467b00ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|261026121527099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	4zGPi7vAGOUFN8rfhx2FwWmnBBQwWKY0dhsS2u/lZBJgiIP2lhkT0duemrtRlVslGt8c7VCyrAVP9ML7wjGIut7a4uA66WB6/RR5x0HJmk/ZQxoeyBiKPfepth0daDkHbuO/nalSDxZMQMFL1ESZGjhaWe3odKCCFMYJ7ZKUYGW5lHzA4G4/J8YVGRf2MWWfWMe/9e2yOuDvphxbE8DOohzlVkbiMbx+9Bd5J91miiO/QuR2grwhwxWh4lk2rZxR+gDdi3SIw7doMBtJuyyKmiONrQVdGOjf9G0Yl2jURkhp/BIj08U/T4Wk3FHTQuUkN0rQfy51qPdC38ybVacTgL/0xuFEz4oO+qPPSZDeESz68sTFer71efDmh2y0YqDWyw3IIzwKBObNh5fhQmsRgU2qD20/VHhs6LDxywc8c9SxVPlDOcMDpavsSE4DO6VGEMLzvOe9UdkNQArt9aaSa7ixpvzKoV+P/180Ww7Fd1D47fyzCrLXCb/qLvc2Stqp82UMT0I/pLIQhJ1F/qtOdCy6hQbq/HuFoR/c/E+t9dQlI1qoR5Px5ANhSgTpuRZNrZ/DK4Mj0TDlsiWhW/HedHErlsipJmi3VudIqqHBnpcbIMCaYodhjq5lz1ryq36HKgAuGXZf4+qSadBwg0+3ZSmikWMLqhFiAKZnA3bHSogguGK+MtFwAc/y+O6wieLlubyP/no29769YsjqQblZkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kJuKe6kJYW5RZPrd3+Q46TNVO2FBdFVsSFQ3UQuT7sibFwFKp03yNVWRTvSc/dxuyHzyY2WATygcTqCvKdCZbTTIXQUWag+xKE5RZYBFJ4KS15B3KtDjRQfS6tD7+RZWH6sPkhUV/QAucwpANfd8fAVgjvMxsk6PkazCmnGF2nJkCUAGdILZM0VZ/UW3ba9Wx2fMD5Qr5j3DyZz//0Y/uM2I9cG69RrjoF1Ho2eLnb7WjAMJz6Z6wGDqcMYCmxhUBDTYOmp08UxGSlAUXEqN3Qo9vJ18JlSrtNT2yj1TYbb+ri0iwod2/1ZSSzTtrJhlY358mS/JRzyywX81YQhaXPzBxGaNYCrHKyGysMDHtSsVs0cXqSY7ykdyvFhjiloYJE8UnTCZa0AWLPQdxoVJV5OIlB7LFfINhOWXvCMdLio7MYgAF8a3gQB6yzx2TGTD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:23:41.7523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00b1c74-608c-4d9b-c0d2-08df467b00ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB583771

Cache the SDXI version reported by MMIO_VERSION and add a small
comparison helper for later feature gating. This prepares the core
for SDXI HW discovery without changing existing behavior.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/device.c  |  9 ++++++---
 drivers/dma/sdxi/sdxi.h    |  9 +++++++++
 drivers/dma/sdxi/version.h | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 drivers/dma/sdxi/version.h

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 265ebea1e350..e3fa39ee9988 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -326,9 +326,12 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	int err;
 
 	version = sdxi_read64(sdxi, SDXI_MMIO_VERSION);
-	dev_info(sdxi->dev, "SDXI %llu.%llu device found\n",
-		  FIELD_GET(SDXI_MMIO_VERSION_MAJOR, version),
-		  FIELD_GET(SDXI_MMIO_VERSION_MINOR, version));
+	sdxi->sdxi_version = (struct sdxi_version) {
+		.major = FIELD_GET(SDXI_MMIO_VERSION_MAJOR, version),
+		.minor = FIELD_GET(SDXI_MMIO_VERSION_MINOR, version),
+	};
+	dev_info(sdxi->dev, "SDXI %u.%u device found\n",
+		 sdxi->sdxi_version.major, sdxi->sdxi_version.minor);
 
 	/* Read capabilities and features. */
 	cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0);
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 07044d837d9a..0bc08fc6ae75 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -17,6 +17,7 @@
 #include <linux/xarray.h>
 
 #include "mmio.h"
+#include "version.h"
 
 #define ID_TO_L1_INDEX(id)	((id) & 0x7F)
 
@@ -66,6 +67,8 @@ struct sdxi_dev {
 	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
 	void __iomem *dbs;		/* virt addr of doorbells */
 
+	struct sdxi_version sdxi_version;
+
 	/* hardware capabilities (from cap0 & cap1) */
 	u32 db_stride;			/* doorbell stride in bytes */
 	u16 max_cxtid;			/* Maximum context ID allowed. */
@@ -90,6 +93,12 @@ struct sdxi_dev {
 	const struct sdxi_bus_ops *bus_ops;
 };
 
+static inline bool sdxi_dev_compatible(const struct sdxi_dev *sdxi,
+				       struct sdxi_version version)
+{
+	return sdxi_version_ge(sdxi->sdxi_version, version);
+}
+
 /**
  * sdxi_alloc_vector() - Allocate an interrupt vector.
  *
diff --git a/drivers/dma/sdxi/version.h b/drivers/dma/sdxi/version.h
new file mode 100644
index 000000000000..79a9c996335f
--- /dev/null
+++ b/drivers/dma/sdxi/version.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI version constants and comparison helpers.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_VERSION_H
+#define DMA_SDXI_VERSION_H
+
+#include <linux/types.h>
+
+struct sdxi_version {
+	u8 major;
+	u8 minor;
+};
+
+#define SDXI_VERSION_1_0 ((struct sdxi_version){ .major = 1, .minor = 0 })
+#define SDXI_VERSION_1_1 ((struct sdxi_version){ .major = 1, .minor = 1 })
+
+static inline u16 sdxi_version_as_u16(struct sdxi_version version)
+{
+	return (version.major << 8) | version.minor;
+}
+
+static inline bool sdxi_version_ge(struct sdxi_version version,
+				   struct sdxi_version minimum)
+{
+	return sdxi_version_as_u16(version) >= sdxi_version_as_u16(minimum);
+}
+
+#endif /* DMA_SDXI_VERSION_H */
-- 
2.56.1

