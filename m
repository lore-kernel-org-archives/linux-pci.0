Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119918;
	b=zSCtvvd0BrVCUBbvLde7DIZiDFIetzG03LQbRdW+5ECQHhIbVQOrptjUY98qk6K0ovks
	 vjV4T03v+QRGGJPGcm5NGOwaukOu4DRCE/lDtEVjzgyup0kCpL/AGhzX4yzHVGvarWNcL
	 cGdbtbxHs55U9VscYqhn+1xl9Ytkry4mseu/EL3drDRE1DiRcg7BpksdA+uk6oUmXK956
	 nBzPQIDpmq7ykPx28xFAIb7JsU552xyM6guIjkkZoGs9ESKXTTexLE/CsbYhF56R3/5uo
	 b8IgHlXDJ1WED9gdKzL37svr8PX+SXLh98ZljUPZS39tuAmCYJa8/LEAt1uXaEc/63w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119918;
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
	bh=QLrbBU9GYiBtwfkEeyPp+BWfizrWDp5kMDdNmytNM8s=;
	b=eD5tamNRSHqJAmMtGMDptq4iizXlr5jnD8b0GP0CxyZdJbRgtIwu3Nk9dNI+ObrgoFRH
	 M3PeRdOyAt2oMVF4bMwE00izWrIqyTOuS8G0smSAKUjDtj+i6/QNMzjIu9Agoizz6a253
	 c2P3R4G+dY2mSbjAj67oqHyRROCojZROXZ8lNanyHHJMiSLlsXqXCOUTVimZKIlaqAKSu
	 +VutiuftRgj5hMGHNRRsrDQ8UXA9eOIqTcyIadeSEFHKp1cvYbpQUgXcy0ENkFlotQJyK
	 HIaf1maK2iNv2MaaMCpWfdWTtjDqUQZZjxoaYWwd5x0jOxwadgZDA2HJ7rKx9E26E3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3Kff9V34;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.24
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71070606A324;
	Thu, 19 Nov 2026 20:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71070606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3Kff9V34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV/5uMxKvx2U5O3uwY9UawLp1GTYPRA6KNMiMQAeuBYjPU+uxgkR6V4SH+KVdrPSHDGRezLwp8qcVeJu0TZz/kxTpnGNjWNBNRT3HMOVlntXly8g4PVcYukbx4zfUYDMoGuMd0etMVBi989d2O8vPOukr/e7wH3e8VewrDkT3sIp+9e2z05MZb666V1SG9b0By2cALCox1Xaj0c/goZ0INP/1jhwMBgAwlFCWGNv1sSoMa2VD6oz8knoUMMJNsOJ3HG68DbZvdkT1HlEuYYo3PCeH6g61eeszYxqvHKBASYM8DaQUM8BU09FFXWRxTh27KsXHd3/T9UZ2x40Vnx0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLrbBU9GYiBtwfkEeyPp+BWfizrWDp5kMDdNmytNM8s=;
 b=q7TFNovWUEeYN+dqlCLKzzQjJ0+w42HUKdNlvpFG+ZQL7LTnChttPsHdZdNm1PAV6ik2+oxd7nTUCqz6axME7iEgpizsUxb7N9SpFZs6sr2OTt/4JxNOZFXBhusF/wkYP54RNuVptBF12pDBaJ4ROi/gC9qRdYz+1A8kFYwOolO3xGRLFl9mDtBAKfBLmNqQsP2L7NNGM4iRYMlJ88GN2ZR93Mtg9DKKFrySm3tZgeYZ6QjLZAIH95RBRjNL9d5SPEHkXJGPoDbfZETL7QTfssGkKUC6Zzjwe9EzILFosumcf9JCjHWXwEgZAIvoaRbuOm7rNtckc/uz8u4QvyU3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLrbBU9GYiBtwfkEeyPp+BWfizrWDp5kMDdNmytNM8s=;
 b=3Kff9V341DnyBz8Vy9dAeM25GH1JSwWza5KzExB4JwyVmrZjL3M8Kae2aE01AkbadCf6oeEaB/J+dkjm8pHMeABrRkd0Z41Kz0BxT6IgS00VeONlvHw0r1+93fcStMEkcuxuyxruEB9z1tb8R5Z6RWZnKi0Y/ylFOHSHneBBTxs=
Received: from CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:25:14 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::12) by CH0PR03CA0086.outlook.office365.com
 (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 20:25:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:25:13 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:25:12 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 09/44] dmaengine: sdxi: handle hardware error logs
Date: Thu, 19 Nov 2026 14:22:45 -0600
Message-ID: <20261119202321.1734355-10-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9af10a-b9fb-4f82-6720-08df467b379d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|7416014|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|261026140227099003|261021133027099003|261026130827099003|261021130227099003|261021123027099003|261102123227099003|261028144727099003|261021121427099003|261022075727099003|261026135527099003|261021135927099003|261022115727099003|261022105027099003|261022113327099003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	sN0Zi0iNfMJNYMy4eWMaPPqnJg3LFkfpsoFjpzfChAQBvKriQIMvodJLPZHs2VR8YSMVTjwu3D7kiqL5w89bXrSEO9qjYvF1POFbhSk8qK1z5bWoJp8MXvOvLN0iBcybwXi8lv4D0Wp0+3R8sKU+TsltMA5+hTBYsn9VNiLIz7dRe6Jv2C1AGtYv8GkDGemfCXbaOCjWSC9gEaX8GbHimHzI6T2i9WIhWihKfw9TEKixfMx9floURgs04d3dir3uslDqLIixy+d4kW1pgVDPA4yH+YlUnXCOnRZIN+EEMDBKnyMY/DqAdP8uiaKH86oURBLTJMsncyXdt9u4HkdRflqLXxTFElhdlqbOfUJM2dFN9ExzJfxoyUWvH+d1vgalP6LKHdBFmSRtMjJlDtFU/Ss1qAmVyFBIYYSkqrBWcUfC5aqTB4zQaoc9nLnEM+RlhhIt/vom9DBHHuHCJI0WY/mIAbzNcxLQdPc+WQ8PCVX1Tu9pvJYWHYIax7oTSf/n+t/63A8HUZejiYGzw7Lx95mmMtpuUGcs1WWVadAcw7shaG0ka1MLWTnRT8Yaq+tWSPKQPbPTRyLlBm8Wdv9um9oyGgnoVY3zX7f/ST9v+0cOpEfjzuqaflBpkkUCdyAUs6I45NX1peLGKizPH8s3La1FOBqK0dL0Gc8in3PAzMs1xy6b9uIAfvjkZ6YYp5n3jnUPJlz6MFHMTAu4RDA3Jg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261026140227099003)(261021133027099003)(261026130827099003)(261021130227099003)(261021123027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261026135527099003)(261021135927099003)(261022115727099003)(261022105027099003)(261022113327099003)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k7miAIzMdzZJjAM6FgUu62qUb3UryYot++P42PG132JwiBtlnNzZz7DkWEk4jIZwni1VgvNkxkxkkz4ZlU4a2edNkHaIVzcAo4ITqWdMYk2C7Qjk+psd+OFYHeZW9eJH11wvosjYBEHqs/z3QB83mXEuOtIwxqJoPhbUcMegSdB/Cjf1QJS9/KJ6aRRjrsKbBTiIIJaxH1bxd9mTKQiCZ5qet2vxVs38AfQee/yepH20sJa5RUll+G8Z0c8riafX+5EAOAAeO+T8/gTC35Pjg3jCEBwJNCqlrIAGMxvmGhvAoMH3ReFBkRdMiLcWWoSnoFdeg9nK9pgL8WoepW9vW5bJU9hIcPf4TaiT73OaRAk1YwHUUkLszTp74DOP0QnMXhUtRB9qlBcYcxLpaSsgQV0OF87sXiWnFTVLfDbF5OSb4GZyZTT91vFT/QDs30rd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:25:13.6998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9af10a-b9fb-4f82-6720-08df467b379d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250

Configure the architected error log on vector zero, decode entries
with the packing API, and report hardware failures from a threaded
interrupt.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Kconfig  |   2 +-
 drivers/dma/sdxi/Makefile |   1 +
 drivers/dma/sdxi/device.c |  14 ++-
 drivers/dma/sdxi/error.c  | 246 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/error.h  |  16 +++
 drivers/dma/sdxi/sdxi.h   |   5 +
 6 files changed, 281 insertions(+), 3 deletions(-)
 create mode 100644 drivers/dma/sdxi/error.c
 create mode 100644 drivers/dma/sdxi/error.h

diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index 85e23608405c..e01b5365c154 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -5,6 +5,7 @@ config SDXI_CORE
 	depends on 64BIT
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
+	select PACKING
 	help
 	  Enable support for Smart Data Accelerator Interface (SDXI)
 	  Platform Data Mover devices. SDXI is a vendor-neutral
@@ -32,7 +33,6 @@ config SDXI_KUNIT_TEST
 	tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
 	depends on SDXI_CORE && KUNIT
 	default KUNIT_ALL_TESTS
-	select PACKING
 	help
 	  KUnit tests for parts of the SDXI driver. Does not require
 	  SDXI hardware.
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 96d013dcbefd..3f49bc9af955 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -7,6 +7,7 @@ sdxi-core-y := \
 	descriptor.o  \
 	device.o      \
 	dma.o         \
+	error.o       \
 	keys.o        \
 	ring.o
 
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 0e7d3711ba88..fa9421a5410b 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -24,6 +24,7 @@
 
 #include "context.h"
 #include "dma.h"
+#include "error.h"
 #include "hw.h"
 #include "keys.h"
 #include "mmio.h"
@@ -413,6 +414,10 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	if (err)
 		return err;
 
+	err = sdxi_error_init(sdxi);
+	if (err)
+		return err;
+
 	/*
 	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
 	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
@@ -423,8 +428,11 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	 * code starts client contexts.
 	 */
 	err = sdxi_dev_start(sdxi);
-	if (err)
-		sdxi_dev_stop(sdxi);
+	if (err) {
+		sdxi_error_exit(sdxi);
+		if (sdxi_dev_stop(sdxi))
+			sdxi_dev_force_quiesce(sdxi);
+	}
 
 	return err;
 }
@@ -464,6 +472,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	mutex_init(&sdxi->cxt_lock);
 	mutex_init(&sdxi->admin_lock);
 	mutex_init(&sdxi->rkey_lock);
+	sdxi->error_irq = -1;
 	dev_set_drvdata(dev, sdxi);
 
 	err = sdxi->bus_ops->init(sdxi);
@@ -482,6 +491,7 @@ void sdxi_unregister(struct device *dev)
 {
 	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
 
+	sdxi_error_exit(sdxi);
 	if (sdxi_dev_stop(sdxi))
 		sdxi_dev_force_quiesce(sdxi);
 	sdxi_client_cxts_exit(sdxi);
diff --git a/drivers/dma/sdxi/error.c b/drivers/dma/sdxi/error.c
new file mode 100644
index 000000000000..561e88d81f41
--- /dev/null
+++ b/drivers/dma/sdxi/error.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI error log handling.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device/devres.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/log2.h>
+#include <linux/packing.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include "error.h"
+#include "hw.h"
+#include "mmio.h"
+#include "sdxi.h"
+
+#define SDXI_ERRLOG_TYPE	0x7f7
+#define SDXI_ERRLOG_ENTRIES	64
+#define SDXI_ERRLOG_SIZE	(SDXI_ERRLOG_ENTRIES * \
+				 sizeof(struct sdxi_errlog_hd_ent))
+
+struct sdxi_errlog_entry {
+	u64 dsc_index;
+	u16 cxt_num;
+	u16 err_class;
+	u16 type;
+	u8 step;
+	u8 buf;
+	u8 sub_step;
+	u8 reaction;
+	bool vl;
+	bool cv;
+	bool div;
+	bool bv;
+};
+
+#define ERRLOG_FIELD(_high, _low, _member) \
+	PACKED_FIELD(_high, _low, struct sdxi_errlog_entry, _member)
+
+static const struct packed_field_u16 sdxi_errlog_fields[] = {
+	ERRLOG_FIELD(0, 0, vl),
+	ERRLOG_FIELD(13, 8, step),
+	ERRLOG_FIELD(26, 16, type),
+	ERRLOG_FIELD(32, 32, cv),
+	ERRLOG_FIELD(33, 33, div),
+	ERRLOG_FIELD(34, 34, bv),
+	ERRLOG_FIELD(38, 36, buf),
+	ERRLOG_FIELD(43, 40, sub_step),
+	ERRLOG_FIELD(46, 44, reaction),
+	ERRLOG_FIELD(63, 48, cxt_num),
+	ERRLOG_FIELD(127, 64, dsc_index),
+	ERRLOG_FIELD(367, 352, err_class),
+};
+
+enum {
+	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
+};
+
+static const char *const sdxi_err_steps[] = {
+	[1] = "internal",
+	[2] = "context L2",
+	[3] = "context L1",
+	[4] = "context control",
+	[5] = "context status",
+	[6] = "write index",
+	[7] = "descriptor",
+	[8] = "completion status",
+	[9] = "atomic return data",
+	[10] = "descriptor buffer",
+	[11] = "AKey lookup",
+	[12] = "RKey lookup",
+};
+
+static const char *sdxi_err_step_name(u8 step)
+{
+	if (step < ARRAY_SIZE(sdxi_err_steps) && sdxi_err_steps[step])
+		return sdxi_err_steps[step];
+
+	return "reserved";
+}
+
+static bool sdxi_errlog_decode(struct sdxi_dev *sdxi,
+			       const struct sdxi_errlog_hd_ent *raw,
+			       struct sdxi_errlog_entry *entry)
+{
+	unpack_fields(raw, sizeof(*raw), entry, sdxi_errlog_fields,
+		      SDXI_PACKING_QUIRKS);
+
+	if (!entry->vl) {
+		dev_err_ratelimited(sdxi->dev,
+				    "ignoring error log entry with vl=0\n");
+		return false;
+	}
+	if (entry->type != SDXI_ERRLOG_TYPE) {
+		dev_err_ratelimited(sdxi->dev,
+				    "ignoring error log type %#x\n",
+				    entry->type);
+		return false;
+	}
+
+	return true;
+}
+
+static void sdxi_errlog_report(struct sdxi_dev *sdxi, u64 read_index,
+			       const struct sdxi_errlog_entry *entry)
+{
+	dev_err(sdxi->dev,
+		"error log[%zu]: class=%#x step=%u (%s) substep=%u reaction=%u\n",
+		(size_t)(read_index % SDXI_ERRLOG_ENTRIES), entry->err_class,
+		entry->step, sdxi_err_step_name(entry->step), entry->sub_step,
+		entry->reaction);
+
+	if (entry->cv)
+		dev_err(sdxi->dev, "  context=%u\n", entry->cxt_num);
+	if (entry->div)
+		dev_err(sdxi->dev, "  descriptor index=%#llx\n",
+			entry->dsc_index);
+	if (entry->bv)
+		dev_err(sdxi->dev, "  buffer=%u\n", entry->buf);
+}
+
+static irqreturn_t sdxi_error_irq_thread(int irq, void *data)
+{
+	struct sdxi_dev *sdxi = data;
+	u64 ack_mask = SDXI_MMIO_ERR_STS_STS_BIT |
+		       SDXI_MMIO_ERR_STS_OVF_BIT |
+		       SDXI_MMIO_ERR_STS_ERR_BIT;
+	u64 write_index;
+	u64 read_index;
+	u64 status;
+	u64 count;
+
+	status = sdxi_read64(sdxi, SDXI_MMIO_ERR_STS);
+	if (!(status & ack_mask))
+		return IRQ_NONE;
+
+	if (status & SDXI_MMIO_ERR_STS_ERR_BIT)
+		dev_err(sdxi->dev, "hardware could not write the error log\n");
+	if (status & SDXI_MMIO_ERR_STS_OVF_BIT)
+		dev_err(sdxi->dev, "error log overflowed\n");
+	if (!(status & SDXI_MMIO_ERR_STS_STS_BIT)) {
+		sdxi_write64(sdxi, SDXI_MMIO_ERR_STS, status & ack_mask);
+		return IRQ_HANDLED;
+	}
+
+	read_index = sdxi_read64(sdxi, SDXI_MMIO_ERR_RD);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_STS, status & ack_mask);
+	write_index = sdxi_read64(sdxi, SDXI_MMIO_ERR_WRT);
+	dma_rmb();
+
+	if (write_index < read_index) {
+		dev_err(sdxi->dev,
+			"error log index mismatch: read=%#llx write=%#llx\n",
+			read_index, write_index);
+		read_index = write_index;
+	}
+
+	count = write_index - read_index;
+	if (count > SDXI_ERRLOG_ENTRIES)
+		read_index = write_index - SDXI_ERRLOG_ENTRIES;
+
+	while (read_index < write_index) {
+		struct sdxi_errlog_entry entry = {};
+		struct sdxi_errlog_hd_ent raw;
+		size_t index = read_index % SDXI_ERRLOG_ENTRIES;
+
+		memcpy(&raw, &sdxi->err_log[index], sizeof(raw));
+		if (sdxi_errlog_decode(sdxi, &raw, &entry))
+			sdxi_errlog_report(sdxi, read_index, &entry);
+		read_index++;
+	}
+
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, read_index);
+	return IRQ_HANDLED;
+}
+
+int sdxi_error_init(struct sdxi_dev *sdxi)
+{
+	unsigned int size_order;
+	u64 reg;
+	int ret;
+
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_STS,
+		     SDXI_MMIO_ERR_STS_STS_BIT |
+		     SDXI_MMIO_ERR_STS_OVF_BIT |
+		     SDXI_MMIO_ERR_STS_ERR_BIT);
+
+	sdxi->err_log = dmam_alloc_coherent(sdxi->dev, SDXI_ERRLOG_SIZE,
+					    &sdxi->err_log_dma, GFP_KERNEL);
+	if (!sdxi->err_log)
+		return -ENOMEM;
+	memset(sdxi->err_log, 0, SDXI_ERRLOG_SIZE);
+
+	sdxi->error_irq = sdxi->bus_ops->get_irq(sdxi, SDXI_ERROR_VECTOR);
+	if (sdxi->error_irq < 0)
+		return sdxi->error_irq;
+
+	ret = devm_request_threaded_irq(sdxi->dev, sdxi->error_irq, NULL,
+					sdxi_error_irq_thread,
+					IRQF_TRIGGER_NONE, "sdxi-error", sdxi);
+	if (ret)
+		return ret;
+
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_WRT, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, 0);
+
+	reg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CTL);
+	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 1);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
+
+	size_order = ilog2(SDXI_ERRLOG_SIZE) - ilog2(SZ_4K);
+	reg = FIELD_PREP(SDXI_MMIO_ERR_CFG_PTR,
+			 sdxi->err_log_dma >> ilog2(SZ_4K)) |
+	      FIELD_PREP(SDXI_MMIO_ERR_CFG_SZ, size_order) |
+	      SDXI_MMIO_ERR_CFG_EN;
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, reg);
+
+	return 0;
+}
+
+void sdxi_error_exit(struct sdxi_dev *sdxi)
+{
+	u64 reg;
+
+	if (!sdxi->err_log)
+		return;
+
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
+
+	reg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CTL);
+	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
+
+	if (sdxi->error_irq >= 0)
+		devm_free_irq(sdxi->dev, sdxi->error_irq, sdxi);
+
+	sdxi->error_irq = -1;
+	sdxi->err_log = NULL;
+	sdxi->err_log_dma = 0;
+}
diff --git a/drivers/dma/sdxi/error.h b/drivers/dma/sdxi/error.h
new file mode 100644
index 000000000000..756a4fe45158
--- /dev/null
+++ b/drivers/dma/sdxi/error.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI error log handling.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_ERROR_H
+#define DMA_SDXI_ERROR_H
+
+struct sdxi_dev;
+
+int sdxi_error_init(struct sdxi_dev *sdxi);
+void sdxi_error_exit(struct sdxi_dev *sdxi);
+
+#endif /* DMA_SDXI_ERROR_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 48e4631c621c..65e0191391db 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -98,6 +98,11 @@ struct sdxi_dev {
 	u8 rkey_order;
 	bool rkey_cap;
 
+	/* Error log */
+	int error_irq;
+	struct sdxi_errlog_hd_ent *err_log;
+	dma_addr_t err_log_dma;
+
 	struct dma_pool *cxt_ctl_pool;
 
 	unsigned int nr_vectors;
-- 
2.56.1

