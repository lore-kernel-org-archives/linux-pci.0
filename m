Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119955;
	b=b4vNXaWp15J8olcWndEYzSYTLyEgI//H680HGzfZcqD+y2jZoCxsLa275wOeSMRInl4L
	 zLE75J0CxO6RHKcZtFBD32KOE8F7kxfly+Db9ByJ3t0sYMZc9ta5j3++AXOw8hiUQwt46
	 gZPFTERWtuaCPEpnq7cPVHd4o/VVQmRxgS0+9du9n/WlDqxrp4/MjxDqmIU7fP6fWZ3Bt
	 JxBuSwr1jYmESydRM+0Xmv6d9UbPsyYW2GWb9zSMmkUW+7xKs+Fl50t9+JoPKBzwzXMz6
	 O+ebqHh0r4pI38YpU1pFuuE29MmwozpSxafvIX0VMIIITarXFZmKgRUpIqjQ3AjigPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119955;
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
	bh=/0Vxbop1chlXikWr6rTp//fh3IAxIJr9sS1jmUuScF4=;
	b=TNTYMvsn+syIeKx4od5hILUqx3/stpFTL6kT1arlSzh5yx0vOWRM3B81WraSynQPM/To
	 1hHB7PlMgNAn5eHxM8tv0QPjD/x2DchfehCCtDk9ZNLMsqLFtznNegMkbaT2jK+sW9jeL
	 p8m1fYwoRZ8zuK/HPLxkng/tK0w3AwHzS9wFHWYpOg1tiGgFqbqNz8b22uwyAMQ8eew8o
	 T6+AKUR50rRHL9ivPEEe+OZaokG1PNFekp7JNArDwvQkI0TxPjh2hm74zZUoNB70Yv07j
	 CTg2nYN+bEnlyyAEd8De3TMmU8t4+IRugwJ+csCtqTSFLRv2JPDu8QE5zUq/iLHn/3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kDDfG1Wr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.36
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D3606A32A;
	Thu, 19 Nov 2026 20:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D7D3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kDDfG1Wr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrNzgjBUUrESJhwOjVXmHjLZlPNv1+0jhyrY0k5tPjq+drhBzSX70ElCwlRsKMFf6a8g5Wc1cC9d+Sy9BUoVvf8T68TFN1iLieNZoA54VXE4BNIZKGwEQYzGdWPFXMtLsuXE37jQXWKj2p3iBZBUghMgQ7F+Ej9dWIBZiqE+itncRw5a3n78Rsp0shPKFvEmLX9f5sPSVElKoVOVQzCJu0lY2XiszdYmcYice1CH/hawm/qWHwJtzxZ1cBalTegauWcKemxXIpRnuR3Hk7mywyR6NrBGDGJFIPVLDn/0EVEOBghGoBczTBwZugnUkEh30XO0NzbOl5kqcPT6rvzfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0Vxbop1chlXikWr6rTp//fh3IAxIJr9sS1jmUuScF4=;
 b=CEejq+O1qaPNBWRKjh/c6aM2rQd4IhEd46t8M2Vvd6322CduGphtRQ9ti8TNn1L8EJr4xab4/hMJl5Rmlp0DRgOGSSa/AwOHR2HpVPGdVO3gRRpOTcF9/GdfOovRE0CcrKp9AFoJgSPxB4yi2kbXv3vh9Qdwl2cOW2PD+1YSpE1keCQ6MMWbfcc45YW1h9w/wqAQXObKovdq4ye0qUGexnQ1di697q7R6S1f+nMQ+VlVAFtCECCXeA9ZKE2PTvkspYUxugT5DnmP6s+IQVogVLt1ZyyGN58xFJ1iYmgFkj5OyfDC37cob48sW1KlH/u6ts/w6jafXDeZDceInZ75Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0Vxbop1chlXikWr6rTp//fh3IAxIJr9sS1jmUuScF4=;
 b=kDDfG1Wr4GDAZxaBjycyfhhLZWUx/ss6gFcZzB02S9ygY3nWdNm6mej6Qdes/LNuyOYUGCEVrPqyqff6GU6OuGewC6UDSJkcNBq9wOzqk/VfWs8+lFr9+9MO/BZQFVRR7HE6tAVfYxUaFRsBJ7lZodoIa8Oo4CGqsf+Orezrbto=
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 20:25:49 +0000
Received: from DM3PEPF000265BC.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::2e) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:25:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BC.mail.protection.outlook.com (10.167.23.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:25:49 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:25:47 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 12/44] dmaengine: sdxi: route context interrupts to eventfd
Date: Thu, 19 Nov 2026 14:22:48 -0600
Message-ID: <20261119202321.1734355-13-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BC:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: a182590b-cd8f-454f-8f17-08df467b4cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|18002099003|22082099003|6133799003|261022105027099003|261021123027099003|56012099006|11063799006|261028144727099003|261102123227099003|10067099003|261021121427099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	uXm02KlCIAc7eg++2+0MQQLhJtxialL7hCGEN5twRPb0DNFeP8wEdaC3lkaBtaJp/bx4po8VsmwazuuNum+JqB28tn5V8MUWw4GGS43+PEFnemfTwLslmqCRr0pdOq1ECoi2OjUmT/NHDYurU9TeGnrTRgWKNLLcnogdOyjpjJxQkpE2gYYMsI4lEyjvqzG1k/rRrhhunXALxHm6mtALvyXruroaMp6qATPMNgiw0AdNbCOXqxeVTS0pmBeozc/W9ixE4kRk1CyaSqLkOcnTRWkiVdVUHmLslqndLjZ0XJorpmXCLP64W+X8LMqlSZ7Li/a17ws/pCpYUPwPCus4a+zn65voSFhIHBNMI5pvjzFe17jY88zYTPaocVkL0/NJbYQ6BqrcMMWlz+r3+ga1wV/nrrllkTsgj7soQ1uQm3jeEYyxVR3QxrCwhHK228oSNMcr+aHMpZ1j07ir2tBzndrvuBi04IQSuHVtfxnV43wepC4vp9fcv5s32zVdE2WoFA+m4gkZxXQtRviZ/kaiw6gmEqXBJOMr9DruQrNlmpLMkDJP5mMBRSRVRyrMtlUytagM8C0zReH0+fLb0snyrz8KYtgb7bCOQzPcNDNzY81CESBfZLVumMrtWOoynBVlwcdiDU207hrF52dbkMYDDy4WsK3GWlsd77MRplarbSNSKcP+Z9hMrmWCJSNMmqh2NYauQrorkG7dAXimAJsdCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(261022105027099003)(261021123027099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(10067099003)(261021121427099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fG17YhfGP9Z3zdqm+42ixi2jjoH9m5sMfx6Z5Lu5Ss0AcIiuUHWh0JzCwTNjyMvoy5o2MXJRiJ6bcHSvhltVXFY1HYEjUfydwJD3gtSW+Pc3NcnwT6bAz7o53SWLiAgeYQXCzl7iTl0/kh8uxXpND24j3UlJClua2NPDncG/VAr2RwPHILy6GPHKlKS7dIKFWDj9zVonWIPO+Sisxf51R9m8GWEmLsMx2nx4S+bE+Vj0k5ZC0g3Rh2mfWLe4LObIPSdf1Dko6LCth4RmQCjEAQcsZrNRFbPSHsqFtSoLmqaNJzoaHKfawWa0gDX7roP4IMLl7Yy9oSAeaVK+nAUSObu+0kq8iKYmoug7SBWHXGV50gj2936VOtOQK1rvTQc3ZFFWMmnFp2f0+TToJqOP4+R/BXwwkok5MzhtTLxttJqhLI1fmo/dWlBMVrR39IIz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:25:49.1895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a182590b-cd8f-454f-8f17-08df467b4cc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

Allocate userspace context interrupts from the existing vector IDA,
route them to eventfds, and reserve a dynamic AKey for interrupt
generation. Synchronize AKey cache updates on bind and unbind, and treat
an armed interrupt without an eventfd as a fatal context condition.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Makefile  |   1 +
 drivers/dma/sdxi/context.c |   6 +
 drivers/dma/sdxi/context.h |  11 ++
 drivers/dma/sdxi/intr.c    | 320 +++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/intr.h    |  21 +++
 5 files changed, 359 insertions(+)
 create mode 100644 drivers/dma/sdxi/intr.c
 create mode 100644 drivers/dma/sdxi/intr.h

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index f20a7c39dfc9..a915982e76a7 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -8,6 +8,7 @@ sdxi-core-y := \
 	device.o      \
 	dma.o         \
 	error.o       \
+	intr.o        \
 	keys.o        \
 	process.o     \
 	ring.o
diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index fe7996a024d6..f5e31f9f9131 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -29,6 +29,7 @@
 #include "context.h"
 #include "descriptor.h"
 #include "hw.h"
+#include "intr.h"
 #include "process.h"
 #include "ring.h"
 #include "sdxi.h"
@@ -91,8 +92,11 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 	refcount_set(&cxt->refs, 1);
 	mutex_init(&cxt->cleanup_lock);
 	mutex_init(&cxt->akey_lock);
+	spin_lock_init(&cxt->intr_lock);
 	init_waitqueue_head(&cxt->poll_wq);
 	INIT_DELAYED_WORK(&cxt->cleanup_work, sdxi_cxt_cleanup_workfn);
+	cxt->intr_vector = -1;
+	cxt->intr_irq = -1;
 	ida_init(&cxt->akey_ida);
 	cxt->pasid = IOMMU_NO_PASID;
 	cxt->opb_000_enb = sdxi->op_grp_cap;
@@ -533,6 +537,8 @@ static void sdxi_cxt_release_resources(struct sdxi_cxt *cxt)
 {
 	struct sdxi_dev *sdxi = cxt->sdxi;
 
+	sdxi_cxt_exit_intr(cxt);
+
 	if (cxt->registered) {
 		WARN_ON(xa_erase(&sdxi->client_cxts, cxt->id) != cxt);
 		cxt->registered = false;
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index eed8cef453df..b4a416509243 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/wait.h>
@@ -31,6 +32,9 @@ struct sdxi_akey_table {
 	struct sdxi_akey_ent entry[SZ_4K / sizeof(struct sdxi_akey_ent)];
 };
 
+struct eventfd_ctx;
+struct sdxi_process;
+
 /* For encoding the akey table size in CXT_L1_ENT's akey_sz. */
 static inline u8 akey_table_order(const struct sdxi_akey_table *tbl)
 {
@@ -75,6 +79,13 @@ struct sdxi_cxt {
 
 	struct sdxi_ring_state *ring_state;
 	struct sdxi_process *process;
+
+	spinlock_t intr_lock;		/* eventfd and interrupt state */
+	struct eventfd_ctx *intr_eventfd;
+	int intr_vector;
+	int intr_irq;
+	u16 intr_akey;
+	bool intr_armed;
 };
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
diff --git a/drivers/dma/sdxi/intr.c b/drivers/dma/sdxi/intr.c
new file mode 100644
index 000000000000..7544aa0ba347
--- /dev/null
+++ b/drivers/dma/sdxi/intr.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI userspace context interrupt routing.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+#include <linux/eventfd.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+
+#include "admin.h"
+#include "context.h"
+#include "hw.h"
+#include "intr.h"
+#include "sdxi.h"
+
+#define SDXI_UCXT_DEFAULT_AKEY		1
+#define SDXI_INTR_UPDATE_TIMEOUT_MS	5000U
+
+static int sdxi_cxt_alloc_intr_akey(struct sdxi_cxt *cxt, u16 *akey)
+{
+	u32 index;
+
+	for (index = SDXI_UCXT_DEFAULT_AKEY + 1;
+	     index < ARRAY_SIZE(cxt->akey_table->entry); index++) {
+		u16 intr = le16_to_cpu(cxt->akey_table->entry[index].intr_num);
+
+		if (!(intr & SDXI_AKEY_ENT_VL)) {
+			*akey = index;
+			return 0;
+		}
+	}
+
+	return -ENOSPC;
+}
+
+static void sdxi_cxt_clear_intr_akey(struct sdxi_cxt *cxt, u16 akey)
+{
+	struct sdxi_akey_ent *entry;
+
+	if (!cxt->akey_table || !akey ||
+	    akey >= ARRAY_SIZE(cxt->akey_table->entry))
+		return;
+
+	entry = &cxt->akey_table->entry[akey];
+	WRITE_ONCE(entry->intr_num, 0);
+	dma_wmb();
+	memset(entry, 0, sizeof(*entry));
+	dma_wmb();
+}
+
+static void sdxi_cxt_arm_intr_akey(struct sdxi_cxt *cxt, u16 akey)
+{
+	struct sdxi_akey_ent *entry = &cxt->akey_table->entry[akey];
+	u32 pasid = FIELD_PREP(SDXI_AKEY_ENT_PASID, cxt->pasid);
+	u16 intr;
+
+	intr = SDXI_AKEY_ENT_VL |
+	       SDXI_AKEY_ENT_IV |
+	       FIELD_PREP(SDXI_AKEY_ENT_PV, cxt->pasid_valid) |
+	       FIELD_PREP(SDXI_AKEY_ENT_INTR_NUM, cxt->intr_vector);
+
+	memset(entry, 0, sizeof(*entry));
+	entry->pasid = cpu_to_le32(pasid);
+	dma_wmb();
+	WRITE_ONCE(entry->intr_num, cpu_to_le16(intr));
+}
+
+static irqreturn_t sdxi_cxt_irq_handler(int irq, void *data)
+{
+	struct sdxi_cxt *cxt = data;
+	struct eventfd_ctx *eventfd;
+	unsigned long flags;
+	bool armed;
+
+	spin_lock_irqsave(&cxt->intr_lock, flags);
+	eventfd = cxt->intr_eventfd;
+	armed = cxt->intr_armed;
+	if (eventfd)
+		eventfd_signal(eventfd);
+	spin_unlock_irqrestore(&cxt->intr_lock, flags);
+
+	if (!eventfd && armed) {
+		dev_err(cxt->sdxi->dev,
+			"context %u interrupt without eventfd\n", cxt->id);
+		sdxi_cxt_kill(cxt);
+	}
+
+	return IRQ_HANDLED;
+}
+
+bool sdxi_cxt_has_intr_fd(const struct sdxi_cxt *cxt)
+{
+	return cxt && READ_ONCE(cxt->intr_eventfd);
+}
+
+int sdxi_cxt_init_intr(struct sdxi_cxt *cxt)
+{
+	int vector;
+	int irq;
+	int ret;
+
+	if (!cxt || !cxt->akey_table || !cxt->id)
+		return -EINVAL;
+	if (cxt->intr_vector >= 0)
+		return 0;
+
+	vector = sdxi_alloc_vector(cxt->sdxi);
+	if (vector < 0)
+		return vector;
+	if (!FIELD_FIT(SDXI_AKEY_ENT_INTR_NUM, vector)) {
+		ret = -ENOSPC;
+		goto free_vector;
+	}
+
+	irq = sdxi_vector_to_irq(cxt->sdxi, vector);
+	if (irq < 0) {
+		ret = irq;
+		goto free_vector;
+	}
+
+	ret = request_irq(irq, sdxi_cxt_irq_handler, IRQF_TRIGGER_NONE,
+			  "sdxi-context", cxt);
+	if (ret)
+		goto free_vector;
+
+	cxt->intr_vector = vector;
+	cxt->intr_irq = irq;
+	return 0;
+
+free_vector:
+	sdxi_free_vector(cxt->sdxi, vector);
+	return ret;
+}
+
+static int sdxi_cxt_clear_intr_fd(struct sdxi_cxt *cxt)
+{
+	struct eventfd_ctx *eventfd;
+	unsigned long flags;
+	u16 akey;
+	int ret;
+
+	mutex_lock(&cxt->akey_lock);
+	if (!cxt->akey_table || cxt->intr_vector < 0 || cxt->intr_irq < 0) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	spin_lock_irqsave(&cxt->intr_lock, flags);
+	akey = cxt->intr_akey;
+	eventfd = cxt->intr_eventfd;
+	spin_unlock_irqrestore(&cxt->intr_lock, flags);
+
+	if (!akey) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	sdxi_cxt_clear_intr_akey(cxt, akey);
+	ret = sdxi_adm_akey_update_sync(cxt->sdxi, cxt->id, cxt->id,
+					akey, akey,
+					SDXI_INTR_UPDATE_TIMEOUT_MS, NULL);
+	if (ret) {
+		sdxi_cxt_arm_intr_akey(cxt, akey);
+		(void)sdxi_adm_akey_update_sync(cxt->sdxi, cxt->id, cxt->id,
+						akey, akey,
+						SDXI_INTR_UPDATE_TIMEOUT_MS,
+						NULL);
+		goto out_unlock;
+	}
+
+	spin_lock_irqsave(&cxt->intr_lock, flags);
+	cxt->intr_armed = false;
+	cxt->intr_akey = 0;
+	cxt->intr_eventfd = NULL;
+	spin_unlock_irqrestore(&cxt->intr_lock, flags);
+
+out_unlock:
+	mutex_unlock(&cxt->akey_lock);
+	if (!ret && eventfd)
+		eventfd_ctx_put(eventfd);
+	return ret;
+}
+
+void sdxi_cxt_exit_intr(struct sdxi_cxt *cxt)
+{
+	struct eventfd_ctx *eventfd;
+	unsigned long flags;
+	int vector;
+	int irq;
+	u16 akey;
+
+	if (!cxt)
+		return;
+
+	mutex_lock(&cxt->akey_lock);
+	spin_lock_irqsave(&cxt->intr_lock, flags);
+	akey = cxt->intr_akey;
+	eventfd = cxt->intr_eventfd;
+	cxt->intr_armed = false;
+	cxt->intr_akey = 0;
+	cxt->intr_eventfd = NULL;
+	spin_unlock_irqrestore(&cxt->intr_lock, flags);
+	sdxi_cxt_clear_intr_akey(cxt, akey);
+	irq = cxt->intr_irq;
+	vector = cxt->intr_vector;
+	cxt->intr_irq = -1;
+	cxt->intr_vector = -1;
+	mutex_unlock(&cxt->akey_lock);
+
+	if (eventfd)
+		eventfd_ctx_put(eventfd);
+	if (irq >= 0)
+		free_irq(irq, cxt);
+	if (vector >= 0)
+		sdxi_free_vector(cxt->sdxi, vector);
+}
+
+int sdxi_cxt_set_intr_fd(struct sdxi_cxt *cxt, int eventfd_fd,
+			 u16 *akey, u32 *intr_num)
+{
+	struct eventfd_ctx *old_eventfd;
+	struct eventfd_ctx *eventfd;
+	unsigned long flags;
+	u16 old_akey;
+	u16 intr_akey;
+	bool old_armed;
+	bool new_akey = false;
+	bool published = false;
+	int ret;
+
+	if (!cxt || !cxt->akey_table)
+		return -ENODEV;
+	if (sdxi_cxt_is_fatal(cxt))
+		return -ENODEV;
+	if (cxt->intr_vector < 0 || cxt->intr_irq < 0)
+		return -EOPNOTSUPP;
+
+	if (eventfd_fd < 0) {
+		ret = sdxi_cxt_clear_intr_fd(cxt);
+		if (!ret) {
+			if (akey)
+				*akey = 0;
+			if (intr_num)
+				*intr_num = 0;
+		}
+		return ret;
+	}
+
+	eventfd = eventfd_ctx_fdget(eventfd_fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	mutex_lock(&cxt->akey_lock);
+	if (!cxt->akey_table || cxt->intr_vector < 0 || cxt->intr_irq < 0 ||
+	    sdxi_cxt_is_fatal(cxt)) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	spin_lock_irqsave(&cxt->intr_lock, flags);
+	old_akey = cxt->intr_akey;
+	intr_akey = old_akey;
+	old_eventfd = cxt->intr_eventfd;
+	old_armed = cxt->intr_armed;
+	spin_unlock_irqrestore(&cxt->intr_lock, flags);
+
+	if (!intr_akey) {
+		ret = sdxi_cxt_alloc_intr_akey(cxt, &intr_akey);
+		if (ret)
+			goto out_unlock;
+		new_akey = true;
+	}
+
+	spin_lock_irqsave(&cxt->intr_lock, flags);
+	cxt->intr_eventfd = eventfd;
+	cxt->intr_akey = intr_akey;
+	cxt->intr_armed = true;
+	spin_unlock_irqrestore(&cxt->intr_lock, flags);
+	published = true;
+
+	sdxi_cxt_arm_intr_akey(cxt, intr_akey);
+	ret = sdxi_adm_akey_update_sync(cxt->sdxi, cxt->id, cxt->id,
+					intr_akey, intr_akey,
+					SDXI_INTR_UPDATE_TIMEOUT_MS, NULL);
+	if (ret) {
+		if (new_akey) {
+			sdxi_cxt_clear_intr_akey(cxt, intr_akey);
+			(void)sdxi_adm_akey_update_sync(cxt->sdxi,
+							cxt->id, cxt->id,
+							intr_akey, intr_akey,
+							SDXI_INTR_UPDATE_TIMEOUT_MS,
+							NULL);
+		}
+		spin_lock_irqsave(&cxt->intr_lock, flags);
+		cxt->intr_eventfd = old_eventfd;
+		cxt->intr_akey = old_akey;
+		cxt->intr_armed = old_armed;
+		spin_unlock_irqrestore(&cxt->intr_lock, flags);
+		goto out_unlock;
+	}
+	mutex_unlock(&cxt->akey_lock);
+
+	if (old_eventfd)
+		eventfd_ctx_put(old_eventfd);
+	if (akey)
+		*akey = intr_akey;
+	if (intr_num)
+		*intr_num = cxt->intr_vector;
+	return 0;
+
+out_unlock:
+	mutex_unlock(&cxt->akey_lock);
+	if (!published || ret)
+		eventfd_ctx_put(eventfd);
+	return ret;
+}
diff --git a/drivers/dma/sdxi/intr.h b/drivers/dma/sdxi/intr.h
new file mode 100644
index 000000000000..07e99fb772ea
--- /dev/null
+++ b/drivers/dma/sdxi/intr.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI userspace context interrupt routing.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_INTR_H
+#define DMA_SDXI_INTR_H
+
+#include <linux/types.h>
+
+struct sdxi_cxt;
+
+int sdxi_cxt_init_intr(struct sdxi_cxt *cxt);
+void sdxi_cxt_exit_intr(struct sdxi_cxt *cxt);
+int sdxi_cxt_set_intr_fd(struct sdxi_cxt *cxt, int eventfd_fd,
+			 u16 *akey, u32 *intr_num);
+bool sdxi_cxt_has_intr_fd(const struct sdxi_cxt *cxt);
+
+#endif /* DMA_SDXI_INTR_H */
-- 
2.56.1

