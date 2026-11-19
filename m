Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119909;
	b=FCq2w5tNwSTTMb9ZbgwE2V6JtmmrTbuA383YXY7sB6g1SZF5d0fsqdXFSBqA+1N8Qasb
	 84PBCzjFuBh4Sj82BllDBAorb6NSlKVzp1/8AojeDHPfUFFhOnmgYYVvDd7fKj7+4dHm7
	 fNkMZ4LdZxZzRVFKOseIho/ILnKY027t6aE6lJjHtQkjTvYb7p/Idpruegm8n8mfRdWpe
	 HEbtfseleW5tzjk7v9IjxJQ0pEMWgK7wrpnsewCNoCQ9eA6h+4nWNcpYci4Wa45SDmJkf
	 6As2KvpOuy/+WDDLvexdMqJdNcL+hSIXbsCkDjYvagI0HK0rRW1zItHMsDRHNLvMb1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119909;
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
	bh=4irHh8xFexXAGxYf7ybSo9zAMMaUSQVmMiiwOZI7KlM=;
	b=EhQmDxOICCUUlq6wktjs4NzO1Vt+8PrHvrM2xRAOXKNCOZr6VdwAPZTUAEXcBi1HEC7s
	 WukJAyttjiqMnIuwDNkPBJ5Tr303coMsBMC7JtVp+Yn4Dl2TM3X398anccb2GV9bjcfYG
	 xOh4jH6fpI38LtW1GDn8kR3y6nhq0iJ49ZGTKQlKPVcL6iBaKCONq0BPi9QrU+Hc8fKdI
	 X6QTyYno+nPUNzW/1NkChSwgJcmPxJY5TxSvsRJWbZ7J+X5mY+tyBeUv90WN9qwpJ6k/J
	 ZEArWCKj7GqHEPLbUMGPUkzLBHnJaOUcXNJ8gJPz+UmF4ERYaCKws+/GJBcoh/EI5EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rF7GONp6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.18
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04097606A32C;
	Thu, 19 Nov 2026 20:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04097606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rF7GONp6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Doh0LFSmuqSxzp9PQAlBj0uoQ1XZXOL9jinBY1rrMiRF7WE+gRELZ/jV4yksThjtoq0E2ti4K+6lJN7Ij4mkjMlljRaI0vEtOuJRA3So+R+jUBLO7Tw7eKx8aYStCNxEppvoIztqt6A88oQIbLkbSnK4evolCBRGIOCoxMc4TN1Ub7unctz/q7f4ypbDE8QJFYvRL5y0dcSumZBC6EP1MzREjY/edNROU5PbzDixGYw5t8pw+IqCwQiRqVCBXqrt6424SJndHMRd11EqnA4bwfmKtlvox1l8dw2OqzUyQ4yQH2lBskvcCqpo41mkLEwyerTNrRcI150Be7REHsE+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4irHh8xFexXAGxYf7ybSo9zAMMaUSQVmMiiwOZI7KlM=;
 b=lza9WHFzt0zgJ+UNyicTuciM8Pt2qpAsrzqvlrCKiR9U/NjqP/w6AL+N6DzK1wQZLmexQYzx6A5I6MZ8UODbxPNFKSlh0AApOxP3DFjPU3eLnigIEei5bGNSTk8VgG4EdNMtkqWVwS3ASWaCJC8x/xeQ7lF4v2EarMYBCB6F1n2aoXncXZkz4sDjrOTHYtWhn3S59nD6WHLjLlbp7b0FVgc4QbdNRFhjsrsxu1L3kbn+3c1GonzgXIvqks34yYNtzCiJ9c+oZRbblOS0eT9wbZe04RyONMk8lb/JrYY3Smd+8qINAxST1fjMzrvS4m73ySKITJy3H2A8LPTmsjQHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4irHh8xFexXAGxYf7ybSo9zAMMaUSQVmMiiwOZI7KlM=;
 b=rF7GONp6t+SXphZc3UiJQpeMCN3RARgI7Uu+fG1tK7iK64njYtBMgRLSsm0GQuEAz96BTH70P0kADN6ISICIskhhUxcpIP2cWH8iiIqeIfVp1c9TOTGJYdftEtMQlBoC7SAhukSBkswPObjZsOlJIJ0c5LgoxfrO3xdPzWvw8eI=
Received: from DM6PR08CA0049.namprd08.prod.outlook.com (2603:10b6:5:1e0::23)
 by LV5PR12MB9780.namprd12.prod.outlook.com (2603:10b6:408:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 20:25:03 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::4d) by DM6PR08CA0049.outlook.office365.com
 (2603:10b6:5:1e0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:25:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:25:02 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:25:00 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 08/44] dmaengine: sdxi: add core RKey table management
Date: Thu, 19 Nov 2026 14:22:44 -0600
Message-ID: <20261119202321.1734355-9-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|LV5PR12MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 554a4962-9dbd-4f6b-f82c-08df467b3119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|22082099003|261009223027099003|18002099003|11063799006|56012099006|261102130727099003|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	B2Ol0YFCR2umAZ+VnfSvZlxdTog1kl4q3kbQhkuEVUmMcNoZQPWwYfXsf7O0PCqxrRjgak/aWDVxSoKRHzrsfFDtHA1MrzU8igzJuocjIU3Z1cwIdfPIH+bvVQHdrht2cWa5BJR+y9/4t9u9J2cO/ODdUs+Ue5IU9YPBTz3p/OjnlDYFx9gP5VtQ2YAcyYDXBn21YcFtPPuJcG7Q/pYeSPnRtknVeg1+HJcHje4+amfxLZMIMlX6CH+uCV+aJVZ3Uq4AuLcjGPwKy7CpI4jtBW/F6NGnk2mzYIn4X2hyCMlOlsUfZNJlvYFaD6Z4//IGZvOLeyGbboAgoiEA/XcD6b4LxoiOeYIC5nD4d1tpUXQ3zRIRgRvmEhsbGSvsgkTHZdWn2E5BdIs/CNMw2N/3Wl1Ot+lf6I297kkhl9dTxdy0KSbmRW1VWtf5cnACdTgSqMd8fS20ivwUgMvj3icg569Y6qXkx01LMQth79+iy43qwFc9W77p4khwEd7+JVr9T0Rb/UDABVFE/3kyyb7HF3G4AhBdsxED/38Fjsw1yEDt2EZrYa9rJcVFv9T3bE9LmJwj24e/Nt+EwOJDnAh/x/j5HsrcoBNjse8P7WqGhViNSjnto7zbNdACmSv6Ltp/dLRZ1Z0Ple+SBOnsWcngFufPDC74kSaNqXUTCkAw2BwWKIdSNBqTgY52HBppvQI32ZzCr2VwemUupTopir6kGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(22082099003)(261009223027099003)(18002099003)(11063799006)(56012099006)(261102130727099003)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1SPSxA5Z/gbjARLLH95Q09ivnIaFsRjk3cYvzukEke0giTWbqH04+NAnDXzAS6ajy+uCzP6Ejqx/Ew7AVidor/sDCg16rph4UJn7SJS14Y3SraM59ITWxd+FSLMNJSHHPXLrKKcMyWqDO2zEJULSy8v6NBXKJe3Ua60lF/a4k2MjM8epA6fzKGsjLNMhdhn2bE/6rSBTYgG/2AUeuqW/BMWPE9/TVmwbFOjJIm78aFesiJSQnbd34kCWkXLzPd/pl2b3mwGVQgcQSTcgcSU/bIRtXZlmR+xEOKlVvcithm/4fz/xQ/5Vl5bXxnCR0yUE7j15bSHrSFcTQiA1LyamFsu5hhZ/FE0M8AIZ2/j4iRZ5HAcJ/MiucVg8KLV0H+PduGU8JPtegRL4wV7kTgmYzBzQO5e3phquU7aFRryVBAqF2DwHHLK67vCWT6Za+qc+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:25:02.7960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 554a4962-9dbd-4f6b-f82c-08df467b3119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9780

Allocate the minimum supported function RKey table when the
capability is present, program MMIO_RKEY, and disable the table during
teardown. Keep userspace key operations for a later UAPI patch.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Makefile |  1 +
 drivers/dma/sdxi/device.c | 11 ++++--
 drivers/dma/sdxi/keys.c   | 70 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/keys.h   | 18 ++++++++++
 drivers/dma/sdxi/sdxi.h   |  8 +++++
 5 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/sdxi/keys.c
 create mode 100644 drivers/dma/sdxi/keys.h

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index bddd1278096c..96d013dcbefd 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -7,6 +7,7 @@ sdxi-core-y := \
 	descriptor.o  \
 	device.o      \
 	dma.o         \
+	keys.o        \
 	ring.o
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 9b6a89e469ad..0e7d3711ba88 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -25,6 +25,7 @@
 #include "context.h"
 #include "dma.h"
 #include "hw.h"
+#include "keys.h"
 #include "mmio.h"
 #include "sdxi.h"
 
@@ -387,6 +388,10 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
 	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
 
+	err = sdxi_keys_init(sdxi, cap1);
+	if (err)
+		return err;
+
 	/* SDXI 1.0 4.1.8.2 Context Level 2 Table Setup */
 	sdxi->L2_table = dmam_alloc_coherent(sdxi->dev,
 					     sizeof(*sdxi->L2_table),
@@ -458,6 +463,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	mutex_init(&sdxi->cxt_lock);
 	mutex_init(&sdxi->admin_lock);
+	mutex_init(&sdxi->rkey_lock);
 	dev_set_drvdata(dev, sdxi);
 
 	err = sdxi->bus_ops->init(sdxi);
@@ -476,9 +482,10 @@ void sdxi_unregister(struct device *dev)
 {
 	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
 
-	/* Stop/reset is best effort if the hardware cannot be quiesced. */
-	sdxi_dev_stop(sdxi);
+	if (sdxi_dev_stop(sdxi))
+		sdxi_dev_force_quiesce(sdxi);
 	sdxi_client_cxts_exit(sdxi);
+	sdxi_keys_exit(sdxi);
 	ida_destroy(&sdxi->vectors);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
diff --git a/drivers/dma/sdxi/keys.c b/drivers/dma/sdxi/keys.c
new file mode 100644
index 000000000000..2e25a9b806e6
--- /dev/null
+++ b/drivers/dma/sdxi/keys.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI key table management.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device/devres.h>
+#include <linux/dma-mapping.h>
+#include <linux/log2.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include "hw.h"
+#include "keys.h"
+#include "mmio.h"
+#include "sdxi.h"
+
+static void sdxi_keys_release(void *data)
+{
+	sdxi_keys_exit(data);
+}
+
+int sdxi_keys_init(struct sdxi_dev *sdxi, u64 cap1)
+{
+	size_t table_size;
+	u64 reg;
+	int ret;
+
+	sdxi->rkey_cap = FIELD_GET(SDXI_MMIO_CAP1_RKEY_CAP, cap1);
+	if (!sdxi->rkey_cap)
+		return 0;
+
+	sdxi->rkey_order = 0;
+	table_size = SZ_4K << sdxi->rkey_order;
+	sdxi->rkey_entries = table_size / sizeof(*sdxi->rkey_table);
+
+	sdxi->rkey_table = dmam_alloc_coherent(sdxi->dev, table_size,
+					       &sdxi->rkey_table_dma,
+					       GFP_KERNEL);
+	if (!sdxi->rkey_table)
+		return -ENOMEM;
+	memset(sdxi->rkey_table, 0, table_size);
+
+	reg = FIELD_PREP(SDXI_MMIO_RKEY_PTR,
+			 sdxi->rkey_table_dma >> ilog2(SZ_4K)) |
+	      FIELD_PREP(SDXI_MMIO_RKEY_SZ, sdxi->rkey_order) |
+	      SDXI_MMIO_RKEY_EN;
+	sdxi_write64(sdxi, SDXI_MMIO_RKEY, reg);
+
+	ret = devm_add_action_or_reset(sdxi->dev, sdxi_keys_release, sdxi);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void sdxi_keys_exit(struct sdxi_dev *sdxi)
+{
+	if (!sdxi->rkey_cap)
+		return;
+
+	sdxi_write64(sdxi, SDXI_MMIO_RKEY, 0);
+	sdxi->rkey_table = NULL;
+	sdxi->rkey_table_dma = 0;
+	sdxi->rkey_entries = 0;
+	sdxi->rkey_order = 0;
+	sdxi->rkey_cap = false;
+}
diff --git a/drivers/dma/sdxi/keys.h b/drivers/dma/sdxi/keys.h
new file mode 100644
index 000000000000..c479da651526
--- /dev/null
+++ b/drivers/dma/sdxi/keys.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI key table management.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_KEYS_H
+#define DMA_SDXI_KEYS_H
+
+#include <linux/types.h>
+
+struct sdxi_dev;
+
+int sdxi_keys_init(struct sdxi_dev *sdxi, u64 cap1);
+void sdxi_keys_exit(struct sdxi_dev *sdxi);
+
+#endif /* DMA_SDXI_KEYS_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 7b3cad785442..48e4631c621c 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -90,6 +90,14 @@ struct sdxi_dev {
 	u16 L1_users[SDXI_L2_TABLE_ENTRIES];
 	struct mutex cxt_lock;		/* context table serialization */
 
+	/* RKey table */
+	struct mutex rkey_lock;
+	struct sdxi_rkey_ent *rkey_table;
+	dma_addr_t rkey_table_dma;
+	u32 rkey_entries;
+	u8 rkey_order;
+	bool rkey_cap;
+
 	struct dma_pool *cxt_ctl_pool;
 
 	unsigned int nr_vectors;
-- 
2.56.1

