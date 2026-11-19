Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119896;
	b=RAD+P0SYAAROude7jYN/M6iEzKqPJhEgT+IJ+HJlhyODUyo83ce4tYCHOkX3e09J/a0n
	 1D2KHerwa/MKgQPmI7zB6uVRcD9yJYpkRSRxtYwn10EdBY5UoEMmiJ5JbcgcGUAoIZGEy
	 sanQ3s0mVUflI0QOSdBN6K9ZAdfutKAfHld7o3t4iTYCyKng1hve89V6I6ndc9Y3ABYgO
	 ijqPnzy/RKKbaV7HwaInmqztzslyzBhMj3dxVZakeQpTT/J92hlCYoLqvUUcOV8OugP6U
	 YtI8IPlypEHywLFBAmx2qyzbiAX6hGv7xNizeU/sfqu10EBjHNKP6E7F6wArJF84trw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119896;
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
	bh=MRCTRFrviAABTMqpdgF5fOMlKt0E6qtgt6smWW19bj8=;
	b=YucDry3wYizXpKYIgUytuU0EiaK7s6OYvFgy38BjQGjRGqMpUmrOQTqJARMrny4/rmOa
	 99v3b+471TRultgeWGfJSBVgOMvYN+rP64rsiepZJ79UXYfxpTcCEndamV8ThrQC9hqFb
	 bdUU8AbD4RHdq/+F8i2xezq8jY/2yh1Q8phKG1+WXihlWNtfxVR0xFsDmG2kzFsVUeOYf
	 dKum+jOLFBieDgspfI8XgqV0GR3sDXOaG56go4cwnBGYBaywzv42wtaC+/4l1gfWGP327
	 nF7tj2grlIp59VyapO5MZlmmT3r8ORNgm8Tk9vOKDlStzBfHd9ovFmbz5gZ1vVn2hXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="jta9Cyr/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.3
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0983606A324;
	Thu, 19 Nov 2026 20:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0983606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jta9Cyr/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQSCR5ukF5HAGqIaKnwwnWOUsp8pZLJ03UU/hzvt4bayx+ZTkAL/4GdvyWvgyDDTMK1k+0amq5XS82rN+IpczWPxP4WNQ0I94o/3sbwZ7/Zm0+L8MLL87AB6IXl4YLDU0u8iyAqGSoRm7v8JO66/5c7XcJRbkREa6Vc7/LoFmoDOSgjOQHfxRhIzNegMXkIOcY1JBtdiNTdRmYd60gCqpxWV0PoM6LsFt3+DZhwJDgpK07udjRIRN42sc0G7L9zykjjpI/mVwiPTe6wcXQuhT7b5kUfie8/T82lDj0pZjsxK0CfHoo+dt2bDqym4iGYyWEF2EbP23E277SnHsvloGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRCTRFrviAABTMqpdgF5fOMlKt0E6qtgt6smWW19bj8=;
 b=F7dPdVdDMm/MW4XkaOdk6EkXfiSJGeRP8quFl5z4Psp2AK6QczPqNJdaTat+OPB46dhYuEoSwqxrIpisLbH38Tg4v2jEpMG6WQIih/TM7H81oL2HkekqxzjC+ujBUoKS0cKYRXjJqOBxsYcG8vPk9r0BPrbn4vw77Q/c6PqgfVoGX68CFoCCjO8BynXRrmDgobwqIZsPV851rvEC5DMKPt3DYnO+Wpb39dyLDuLHQW+36UxmQeQbKCWInKqNx42ctLBq3rKqrllS0zBDjB59/QrRzbdBR/gZHtTbJluHkt+9eHbaj9fCK57PPQY67dn8zkij4O5cjO0GhBlcoeIK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRCTRFrviAABTMqpdgF5fOMlKt0E6qtgt6smWW19bj8=;
 b=jta9Cyr/WNuniofFuE2TJAKmlKJBwadTVQB/IOHpJb+95dTaQkVxo1Cw8a/jSL3ZTyUv8be4O9bo2Oss3BeTlhleYIX6rquA23fwet0o5IdPTgJB957YQ6uf1wH8K+U2bLprtV1aaGaoWGctkfRYFuoA2HCE+6mw0P33DaL4QWI=
Received: from DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27) by
 SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:24:51 +0000
Received: from DM3PEPF000265BD.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::45) by DS7P222CA0015.outlook.office365.com
 (2603:10b6:8:2e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 20:24:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BD.mail.protection.outlook.com (10.167.23.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:24:50 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:24:49 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 07/44] dmaengine: sdxi: implement synchronous admin operations
Date: Thu, 19 Nov 2026 14:22:43 -0600
Message-ID: <20261119202321.1734355-8-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BD:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dda251d-86d1-4404-93dd-08df467b29e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|7416014|11063799006|10067099003|261026140227099003|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261102130727099003|261022075727099003|261026121527099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vkWkzjBgHv7192+6ON9tYaLf+lcUBiu6hZeTGgno70gd7Ib5eUFEwvcshxMNBK6BOuVmE04v8rQfP5Dgbh3JDM1Fs41VJDqcuuHDV0L3+9E/2E3Ks1KvkfReVn/1adrdXlJqrKsPiFuCKlUaB6GJYzxX+BrFi9fJdj6N3LipcezsngfEdS43so1ml+odzB8kLPQ8t/fPxXZuLMWa+Rs2/DDEwnsO3z/HEIjfY1gbHcacm0VxZLOL4n2up0VfqxuWorg7d+7lBNP3Y+xstae4UzN4SIhg/ZEeQf33UlajAxkELkBPsHyerpf6kA4zDZrgaw+WIQ2qAKzpZ7XMtpp4F+prg+eIof1/dgrFQHVeDwbF6RD5U0hh0+7ZRDNISmOuHSQ2+J6uahoQgBcE2Z2G977qM2lNzQ1Uk+Hb0C3YaUuV2CMsSKZtz2HlOQlO6domeaizvDe9oVrwhgxvNbkuP90dAK9FJwEeCzy+wRAaokcIeE9gPKwf5uZPmWSnnetwI0pK7pQO+LwecFyBSaiqA2V2JTe7ihN3GgWtvzzyPVMKPbKp/hNRWWdf9tchmYQtwA8IoiUQm2zmnlR0C0SCJoBzpWsmF/xeiMP2kfg12EDHvYEYNBliNNfbHzGH3Q8Le27so0iNgF7yealwiMXfqGJhAUe19C3A0P/tGKYAmFV2mHI4DDvSZ7VK76wT/Y7W/IhWe+Yrx91eVWnD45L64g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(7416014)(11063799006)(10067099003)(261026140227099003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261102130727099003)(261022075727099003)(261026121527099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BC6IOPJRPMQ+lOUdJWOQ8s6AasXyvZF1AOxDFQThgnCvcjJMSmc6+okiEOmNCQO/w0m2h7rp3wlo4C0RhqyiQgWd+hWqQMGLcJ5nSyh3haXAucB/7jlFPgl/plNBob1+H/wezMQ5YwejZQ7Dq72lkeo2eon6YXmrbe0aWtOsHhVYlY9RAy+MJFu+8Cf+XmoxqiDC/YrWdaXlBmRoRR/IVAm+VmDpSsdS2uH/0E/meKlSMrDQvkzdrUFiewrmBukw4ZHS1gOziyiUELIJS5CB/EXV905Gn2VrA+jWfzImeqM0Ms5QYG6cvscsoOKPUGjSWSyEQSfxiZGhpEgSZygJFMbBpQZJW+YqAWl7lvEaIVRVHUbeHkRm/gCvw18LDhUGEJGR1GFxftaVs75/sE8X1CsEzMaRWrG79oi1zsQIejlHU1PHDQ6jFtD0nRmfNkgr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:24:50.6995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dda251d-86d1-4404-93dd-08df467b29e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516

Move context start and stop submission out of existing context
management code into new admin management files, and build the final
AdminGrp helper layer on the existing submission queue and completion
queue. Implement AKey and RKey sync helpers as part of AdminGrp. To
support vendor modules that will be introduced later, a discovery
operations plus a generic exported descriptor path are also added.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Makefile  |   1 +
 drivers/dma/sdxi/admin.c   | 281 +++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/admin.h   |  45 ++++++
 drivers/dma/sdxi/context.c | 136 +-----------------
 drivers/dma/sdxi/context.h |  13 --
 drivers/dma/sdxi/device.c  |  33 +++++
 drivers/dma/sdxi/dma.c     |  22 ++-
 drivers/dma/sdxi/pci.c     |  16 +++
 drivers/dma/sdxi/sdxi.h    |   8 ++
 9 files changed, 402 insertions(+), 153 deletions(-)
 create mode 100644 drivers/dma/sdxi/admin.c
 create mode 100644 drivers/dma/sdxi/admin.h

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 3a1d36997b44..bddd1278096c 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
 sdxi-core-y := \
+	admin.o       \
 	completion.o  \
 	context.o     \
 	descriptor.o  \
diff --git a/drivers/dma/sdxi/admin.c b/drivers/dma/sdxi/admin.c
new file mode 100644
index 000000000000..ed3890de8cc1
--- /dev/null
+++ b/drivers/dma/sdxi/admin.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI administrative command submission.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "admin.h"
+#include "completion.h"
+#include "descriptor.h"
+#include "ring.h"
+
+#define SDXI_ADMIN_DEFAULT_TIMEOUT_MS	5000U
+#define SDXI_ADMIN_DRAIN_TIMEOUT_MS	1000U
+
+static int sdxi_adm_submit(struct sdxi_cxt *adm,
+			   const struct sdxi_desc *descs, size_t nr_descs,
+			   unsigned int timeout_ms, u32 *cst_flags,
+			   bool interruptible)
+{
+	struct sdxi_ring_resv resv;
+	struct sdxi_completion comp;
+	struct sdxi_slot slot;
+	bool completed = false;
+	int wait_ret;
+	size_t i;
+	int ret;
+
+	if (!adm || !sdxi_cxt_is_admin(adm) || !adm->ring_state)
+		return -ENODEV;
+	if (!nr_descs)
+		return -EINVAL;
+
+	/* Keep reservations from becoming visible before they are populated. */
+	mutex_lock(&adm->sdxi->admin_lock);
+	if (adm->sdxi->admin_dead) {
+		ret = -EIO;
+		goto out_unlock;
+	}
+	ret = sdxi_cst_pool_get_wait(adm->cst_pool, &comp);
+	if (ret)
+		goto out_unlock;
+	ret = sdxi_ring_reserve(adm->ring_state, nr_descs, &resv);
+	if (ret) {
+		sdxi_cst_pool_put(adm->cst_pool, comp.cst_blk);
+		goto out_unlock;
+	}
+
+	for (i = 0; i < nr_descs; i++) {
+		slot = sdxi_ring_resv_slot(&resv, i);
+		*sdxi_slot_desc(slot) = descs[i];
+		if (i + 1 == nr_descs)
+			sdxi_cxt_submit(adm, slot, &comp, SDXI_CXT_SUBMIT_KICK);
+		else
+			sdxi_cxt_submit(adm, slot, NULL, 0);
+	}
+
+	ret = sdxi_cst_blk_wait_timeout(comp.cst_blk, timeout_ms, interruptible);
+	if (ret == -ETIMEDOUT || ret == -ERESTARTSYS) {
+		/*
+		 * The descriptor can still access caller-owned DMA memory after
+		 * a timed or interrupted wait. Drain it before returning so the
+		 * caller can safely release any associated mappings.
+		 */
+		wait_ret = sdxi_cst_blk_wait_timeout(comp.cst_blk,
+						 SDXI_ADMIN_DRAIN_TIMEOUT_MS,
+						 false);
+		if (wait_ret == 0 || wait_ret == -EIO) {
+			completed = true;
+			if (cst_flags)
+				*cst_flags = sdxi_cst_blk_flags(comp.cst_blk);
+		}
+		if (wait_ret == -ETIMEDOUT) {
+			adm->sdxi->admin_dead = true;
+			dev_err(adm->sdxi->dev,
+				"admin command did not drain; quiescing function\n");
+			sdxi_dev_force_quiesce(adm->sdxi);
+		}
+	}
+	if (!ret || ret == -EIO) {
+		completed = true;
+		if (cst_flags)
+			*cst_flags = sdxi_cst_blk_flags(comp.cst_blk);
+	}
+	if (completed)
+		sdxi_cst_pool_put(adm->cst_pool, comp.cst_blk);
+	sdxi_ring_wake_up(adm->ring_state);
+
+out_unlock:
+	mutex_unlock(&adm->sdxi->admin_lock);
+	return ret;
+}
+
+int sdxi_adm_update_cxt(struct sdxi_cxt *cxt)
+{
+	struct sdxi_desc descs[2] = {};
+	int ret;
+
+	if (!cxt || sdxi_cxt_is_admin(cxt))
+		return -EINVAL;
+
+	ret = sdxi_encode_cxt_upd(&descs[0], &(const struct sdxi_cxt_upd) {
+			.level = SDXI_CXT_UPD_LVL_L1,
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	if (ret)
+		return ret;
+
+	ret = sdxi_encode_sync(&descs[1], &(const struct sdxi_sync) {
+			.filter = SDXI_SYNC_FLT_CXT,
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	if (ret)
+		return ret;
+
+	return sdxi_adm_submit(to_admin_cxt(cxt), descs, ARRAY_SIZE(descs),
+			       SDXI_ADMIN_DEFAULT_TIMEOUT_MS, NULL, false);
+}
+
+int sdxi_adm_start_cxt_sync(struct sdxi_cxt *cxt, unsigned int timeout_ms,
+			    u32 *cst_flags, bool interruptible)
+{
+	struct sdxi_desc descs[2] = {};
+	int ret;
+
+	if (!cxt || sdxi_cxt_is_admin(cxt))
+		return -EINVAL;
+
+	ret = sdxi_encode_cxt_start(&descs[0], &(const struct sdxi_cxt_start) {
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	if (ret)
+		return ret;
+
+	ret = sdxi_encode_sync(&descs[1], &(const struct sdxi_sync) {
+			.filter = SDXI_SYNC_FLT_CXT,
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	if (ret)
+		return ret;
+
+	return sdxi_adm_submit(to_admin_cxt(cxt), descs, ARRAY_SIZE(descs),
+			       timeout_ms, cst_flags, interruptible);
+}
+
+int sdxi_adm_stop_cxt_sync(struct sdxi_cxt *cxt, unsigned int timeout_ms,
+			   u32 *cst_flags, bool interruptible)
+{
+	struct sdxi_desc descs[2] = {};
+	int ret;
+
+	if (!cxt || sdxi_cxt_is_admin(cxt))
+		return -EINVAL;
+
+	ret = sdxi_encode_cxt_stop(&descs[0], &(const struct sdxi_cxt_stop) {
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	if (ret)
+		return ret;
+
+	ret = sdxi_encode_sync(&descs[1], &(const struct sdxi_sync) {
+			.filter = SDXI_SYNC_FLT_STOP,
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	if (ret)
+		return ret;
+
+	return sdxi_adm_submit(to_admin_cxt(cxt), descs, ARRAY_SIZE(descs),
+			       timeout_ms, cst_flags, interruptible);
+}
+
+int sdxi_adm_rkey_update_sync(struct sdxi_dev *sdxi, u16 rkey_start,
+			      u16 rkey_end, unsigned int timeout_ms,
+			      u32 *cst_flags)
+{
+	struct sdxi_desc descs[2] = {};
+	int ret;
+
+	if (!sdxi)
+		return -ENODEV;
+
+	ret = sdxi_encode_rkey_upd(&descs[0], &(const struct sdxi_rkey_upd) {
+			.rkey_start = rkey_start,
+			.rkey_end = rkey_end,
+		});
+	if (ret)
+		return ret;
+
+	ret = sdxi_encode_sync(&descs[1], &(const struct sdxi_sync) {
+			.filter = SDXI_SYNC_FLT_RKEY,
+			.key_start = rkey_start,
+			.key_end = rkey_end,
+		});
+	if (ret)
+		return ret;
+
+	return sdxi_adm_submit(sdxi->admin_cxt, descs, ARRAY_SIZE(descs),
+			       timeout_ms, cst_flags, false);
+}
+
+int sdxi_adm_akey_update_sync(struct sdxi_dev *sdxi, u16 cxt_start,
+			      u16 cxt_end, u16 akey_start, u16 akey_end,
+			      unsigned int timeout_ms, u32 *cst_flags)
+{
+	struct sdxi_cxt_range range = {
+		.cxt_start = cxt_start,
+		.cxt_end = cxt_end,
+	};
+	struct sdxi_desc descs[2] = {};
+	int ret;
+
+	if (!sdxi)
+		return -ENODEV;
+
+	ret = sdxi_encode_akey_upd(&descs[0], &(const struct sdxi_akey_upd) {
+			.range = range,
+			.akey_start = akey_start,
+			.akey_end = akey_end,
+		});
+	if (ret)
+		return ret;
+
+	ret = sdxi_encode_sync(&descs[1], &(const struct sdxi_sync) {
+			.filter = SDXI_SYNC_FLT_AKEY,
+			.range = range,
+			.key_start = akey_start,
+			.key_end = akey_end,
+		});
+	if (ret)
+		return ret;
+
+	return sdxi_adm_submit(sdxi->admin_cxt, descs, ARRAY_SIZE(descs),
+			       timeout_ms, cst_flags, false);
+}
+
+int sdxi_adm_disc(struct sdxi_dev *sdxi, u16 index_start, u16 index_end,
+		  dma_addr_t addr, unsigned int timeout_ms, u32 *cst_flags)
+{
+	struct sdxi_desc desc = {};
+	int ret;
+
+	if (!sdxi)
+		return -ENODEV;
+
+	ret = sdxi_encode_disc(&desc, &(const struct sdxi_disc) {
+			.index_start = index_start,
+			.index_end = index_end,
+			.addr = addr,
+		});
+	if (ret)
+		return ret;
+
+	return sdxi_adm_submit(sdxi->admin_cxt, &desc, 1, timeout_ms,
+			       cst_flags, false);
+}
+
+int sdxi_adm_submit_desc(struct sdxi_cxt *adm, const struct sdxi_desc *desc,
+			 unsigned int timeout_ms, u32 *cst_flags)
+{
+	if (!desc)
+		return -EINVAL;
+
+	return sdxi_adm_submit(adm, desc, 1, timeout_ms, cst_flags, false);
+}
+EXPORT_SYMBOL_NS_GPL(sdxi_adm_submit_desc, "SDXI");
+
+int sdxi_adm_start_cxt(struct sdxi_cxt *cxt)
+{
+	return sdxi_adm_start_cxt_sync(cxt, SDXI_ADMIN_DEFAULT_TIMEOUT_MS,
+				       NULL, false);
+}
+
+int sdxi_adm_stop_cxt(struct sdxi_cxt *cxt)
+{
+	return sdxi_adm_stop_cxt_sync(cxt, SDXI_ADMIN_DEFAULT_TIMEOUT_MS,
+				      NULL, false);
+}
diff --git a/drivers/dma/sdxi/admin.h b/drivers/dma/sdxi/admin.h
new file mode 100644
index 000000000000..175f8c28c757
--- /dev/null
+++ b/drivers/dma/sdxi/admin.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI administrative command helpers.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_ADMIN_H
+#define DMA_SDXI_ADMIN_H
+
+#include <linux/dma-mapping.h>
+#include <linux/types.h>
+
+#include "context.h"
+
+static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
+{
+	return cxt->sdxi->admin_cxt;
+}
+
+static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
+{
+	return cxt == to_admin_cxt(cxt);
+}
+
+int sdxi_adm_update_cxt(struct sdxi_cxt *cxt);
+int sdxi_adm_start_cxt_sync(struct sdxi_cxt *cxt, unsigned int timeout_ms,
+			    u32 *cst_flags, bool interruptible);
+int sdxi_adm_stop_cxt_sync(struct sdxi_cxt *cxt, unsigned int timeout_ms,
+			   u32 *cst_flags, bool interruptible);
+int sdxi_adm_rkey_update_sync(struct sdxi_dev *sdxi, u16 rkey_start,
+			      u16 rkey_end, unsigned int timeout_ms,
+			      u32 *cst_flags);
+int sdxi_adm_akey_update_sync(struct sdxi_dev *sdxi, u16 cxt_start,
+			      u16 cxt_end, u16 akey_start, u16 akey_end,
+			      unsigned int timeout_ms, u32 *cst_flags);
+int sdxi_adm_disc(struct sdxi_dev *sdxi, u16 index_start, u16 index_end,
+		  dma_addr_t addr, unsigned int timeout_ms, u32 *cst_flags);
+int sdxi_adm_submit_desc(struct sdxi_cxt *adm, const struct sdxi_desc *desc,
+			 unsigned int timeout_ms, u32 *cst_flags);
+
+int sdxi_adm_start_cxt(struct sdxi_cxt *cxt);
+int sdxi_adm_stop_cxt(struct sdxi_cxt *cxt);
+
+#endif /* DMA_SDXI_ADMIN_H */
diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index d75668e89e61..a8d065b57bac 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -22,6 +22,7 @@
 #include <asm/barrier.h>
 #include <asm/rwonce.h>
 
+#include "admin.h"
 #include "completion.h"
 #include "context.h"
 #include "descriptor.h"
@@ -106,78 +107,6 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 	return_ptr(cxt);
 }
 
-/* Claim completion storage before making a ring reservation irrevocable. */
-static int sdxi_cxt_reserve(struct sdxi_cxt *cxt, size_t nr,
-			    struct sdxi_ring_resv *resv,
-			    struct sdxi_completion *comp)
-{
-	int err;
-
-	err = sdxi_cst_pool_get_wait(cxt->cst_pool, comp);
-	if (err)
-		return err;
-
-	err = sdxi_ring_reserve(cxt->ring_state, nr, resv);
-	if (err)
-		sdxi_cst_pool_put(cxt->cst_pool, comp->cst_blk);
-
-	return err;
-}
-
-static int sdxi_cxt_poll_completion(struct sdxi_cxt *cxt,
-				    const struct sdxi_completion *comp)
-{
-	int err = sdxi_cst_blk_poll(comp->cst_blk);
-
-	/*
-	 * A timeout does not end hardware ownership. Keep these administrative
-	 * blocks claimed until context teardown, even if they complete later.
-	 * Repeated timeouts can exhaust the pool; allocation then times out too.
-	 */
-	if (err != -ETIMEDOUT)
-		sdxi_cst_pool_put(cxt->cst_pool, comp->cst_blk);
-	sdxi_ring_wake_up(cxt->ring_state);
-
-	return err;
-}
-
-/*
- * Signal the function that a client context's control structures have
- * been modified so it discards any privately cached copies of them.
- * DSC_SYNC.CXT is required before the operation can be considered
- * complete.
- */
-static int sdxi_cxt_update(const struct sdxi_cxt *cxt)
-{
-	struct sdxi_cxt *adm = to_admin_cxt(cxt);
-	struct sdxi_slot upd, sync;
-	struct sdxi_ring_resv resv;
-	struct sdxi_completion comp;
-	int err;
-
-	might_sleep();
-
-	err = sdxi_cxt_reserve(adm, 2, &resv, &comp);
-	if (err)
-		return err;
-
-	upd = sdxi_ring_resv_slot(&resv, 0);
-	sync = sdxi_ring_resv_slot(&resv, 1);
-
-	sdxi_encode_cxt_upd(sdxi_slot_desc(upd), &(const struct sdxi_cxt_upd) {
-			.level = SDXI_CXT_UPD_LVL_L1,
-			.range = sdxi_cxt_range_single(cxt->id),
-		});
-	sdxi_encode_sync(sdxi_slot_desc(sync), &(const struct sdxi_sync) {
-			.filter = SDXI_SYNC_FLT_CXT,
-			.range = sdxi_cxt_range_single(cxt->id),
-		});
-	sdxi_cxt_submit(adm, upd, NULL, 0);
-	sdxi_cxt_submit(adm, sync, &comp, SDXI_CXT_SUBMIT_KICK);
-
-	return sdxi_cxt_poll_completion(adm, &comp);
-}
-
 struct sdxi_cxt_ctl_cfg {
 	dma_addr_t ds_ring_ptr;
 	dma_addr_t cxt_sts_ptr;
@@ -417,67 +346,6 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
 }
 
-int sdxi_start_cxt(struct sdxi_cxt *cxt)
-{
-	struct sdxi_cxt *adm = to_admin_cxt(cxt);
-	struct sdxi_ring_resv resv;
-	struct sdxi_completion comp;
-	struct sdxi_slot start;
-	int err;
-
-	might_sleep();
-
-	/* Administrative context activation is controlled by the function state. */
-	if (WARN_ON(adm == cxt))
-		return -EINVAL;
-
-	err = sdxi_cxt_reserve(adm, 1, &resv, &comp);
-	if (err)
-		return err;
-
-	start = sdxi_ring_resv_slot(&resv, 0);
-	sdxi_encode_cxt_start(sdxi_slot_desc(start), &(const struct sdxi_cxt_start) {
-			.range = sdxi_cxt_range_single(cxt->id),
-		});
-	sdxi_cxt_submit(adm, start, &comp, SDXI_CXT_SUBMIT_KICK);
-
-	return sdxi_cxt_poll_completion(adm, &comp);
-}
-
-void sdxi_stop_cxt(struct sdxi_cxt *cxt)
-{
-	struct sdxi_cxt *adm = to_admin_cxt(cxt);
-	struct sdxi_slot stop, sync;
-	struct sdxi_ring_resv resv;
-	struct sdxi_completion comp;
-	int err;
-
-	might_sleep();
-
-	/* Administrative context stopping is controlled by the function state. */
-	if (WARN_ON(adm == cxt))
-		return;
-
-	err = sdxi_cxt_reserve(adm, 2, &resv, &comp);
-	if (WARN_ON_ONCE(err))
-		return;
-
-	stop = sdxi_ring_resv_slot(&resv, 0);
-	sync = sdxi_ring_resv_slot(&resv, 1);
-
-	sdxi_encode_cxt_stop(sdxi_slot_desc(stop), &(const struct sdxi_cxt_stop) {
-			.range = sdxi_cxt_range_single(cxt->id),
-		});
-	sdxi_encode_sync(sdxi_slot_desc(sync), &(const struct sdxi_sync) {
-			.filter = SDXI_SYNC_FLT_STOP,
-			.range = sdxi_cxt_range_single(cxt->id),
-		});
-	sdxi_cxt_submit(adm, stop, NULL, 0);
-	sdxi_cxt_submit(adm, sync, &comp, SDXI_CXT_SUBMIT_KICK);
-
-	WARN_ON(sdxi_cxt_poll_completion(adm, &comp));
-}
-
 /*
  * Temporary owner for context id until it can be assigned to a
  * context object; enables scope-based cleanup.
@@ -637,7 +505,7 @@ int sdxi_cxt_exit(struct sdxi_cxt *cxt)
 	invalidate_cxt_ctl(cxt->cxt_ctl);
 	mutex_unlock(&sdxi->cxt_lock);
 
-	err = sdxi_cxt_update(cxt);
+	err = sdxi_adm_update_cxt(cxt);
 	if (err) {
 		dev_err(sdxi->dev,
 			"context %u release failed (%d), retaining resources until function shutdown\n",
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index acf41709c4de..196207cbca94 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -60,9 +60,6 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
 int sdxi_cxt_exit(struct sdxi_cxt *cxt);
 void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
 
-int sdxi_start_cxt(struct sdxi_cxt *cxt);
-void sdxi_stop_cxt(struct sdxi_cxt *cxt);
-
 enum sdxi_submit_flags {
 	SDXI_CXT_SUBMIT_KICK  = BIT(0),
 	SDXI_CXT_SUBMIT_FENCE = BIT(1),
@@ -73,16 +70,6 @@ void sdxi_cxt_attach_cst(struct sdxi_slot slot,
 void sdxi_cxt_submit(struct sdxi_cxt *cxt, struct sdxi_slot slot,
 		     const struct sdxi_completion *comp, enum sdxi_submit_flags flags);
 
-static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
-{
-	return cxt->sdxi->admin_cxt;
-}
-
-static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
-{
-	return cxt == to_admin_cxt(cxt);
-}
-
 static inline void sdxi_cxt_kick(struct sdxi_cxt *cxt)
 {
 	/*
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index c5b5b39a7fe5..9b6a89e469ad 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -245,6 +245,38 @@ static int sdxi_dev_start(struct sdxi_dev *sdxi)
 	return 0;
 }
 
+void sdxi_dev_force_quiesce(struct sdxi_dev *sdxi)
+{
+	enum sdxi_fn_gsv status = sdxi_dev_gsv(sdxi);
+	int ret;
+
+	if (status == SDXI_GSV_STOP)
+		return;
+
+	if (status != SDXI_GSV_ERROR) {
+		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_HD);
+		ret = sdxi_dev_gsv_poll(sdxi, status,
+					status == SDXI_GSV_STOP ||
+					status == SDXI_GSV_ERROR);
+		if (!ret && status == SDXI_GSV_STOP)
+			return;
+	} else {
+		ret = 0;
+	}
+
+	if (!ret && status == SDXI_GSV_ERROR) {
+		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
+		ret = sdxi_dev_gsv_poll(sdxi, status,
+					status == SDXI_GSV_STOP);
+		if (!ret)
+			return;
+	}
+
+	dev_err(sdxi->dev, "failed to quiesce function; disabling bus DMA\n");
+	if (sdxi->bus_ops->force_quiesce)
+		sdxi->bus_ops->force_quiesce(sdxi);
+}
+
 /* Stop the function and discard inherited MMIO configuration. */
 static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
 {
@@ -425,6 +457,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	ida_init(&sdxi->vectors);
 	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	mutex_init(&sdxi->cxt_lock);
+	mutex_init(&sdxi->admin_lock);
 	dev_set_drvdata(dev, sdxi);
 
 	err = sdxi->bus_ops->init(sdxi);
diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
index 512855c83da2..a4b254a3080d 100644
--- a/drivers/dma/sdxi/dma.c
+++ b/drivers/dma/sdxi/dma.c
@@ -20,6 +20,7 @@
 
 #include "../dmaengine.h"
 #include "../virt-dma.h"
+#include "admin.h"
 #include "completion.h"
 #include "context.h"
 #include "descriptor.h"
@@ -416,9 +417,12 @@ static int sdxi_dma_alloc_chan_resources(struct dma_chan *dma_chan)
 	if (err)
 		goto free_akey;
 
-	err = sdxi_start_cxt(sdchan->cxt);
-	if (err)
+	err = sdxi_adm_start_cxt(sdchan->cxt);
+	if (err) {
+		sdxi->admin_dead = true;
+		sdxi_dev_force_quiesce(sdxi);
 		goto free_irq;
+	}
 
 	return 0;
 free_irq:
@@ -428,25 +432,31 @@ static int sdxi_dma_alloc_chan_resources(struct dma_chan *dma_chan)
 free_vector:
 	sdxi_free_vector(sdxi, vector);
 exit_cxt:
-	sdxi_cxt_exit(sdchan->cxt);
+	WARN_ON(sdxi_cxt_exit(sdchan->cxt));
 	return err;
 }
 
 static void sdxi_dma_free_chan_resources(struct dma_chan *dma_chan)
 {
 	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
+	struct sdxi_dev *sdxi = sdchan->cxt->sdxi;
 	LIST_HEAD(head);
+	int err;
 
-	sdxi_stop_cxt(sdchan->cxt);
+	err = sdxi_adm_stop_cxt(sdchan->cxt);
+	if (WARN_ON(err)) {
+		sdxi->admin_dead = true;
+		sdxi_dev_force_quiesce(sdxi);
+	}
 	free_irq(sdchan->irq, sdchan);
-	sdxi_free_vector(sdchan->cxt->sdxi, sdchan->vector);
+	sdxi_free_vector(sdxi, sdchan->vector);
 	sdxi_free_akey(sdchan->cxt, sdchan->akey);
 	/* virt-dma does not know about the driver's pending list. */
 	scoped_guard(spinlock_irqsave, &sdchan->vchan.lock)
 		list_splice_tail_init(&sdchan->pending, &head);
 	vchan_dma_desc_free_list(&sdchan->vchan, &head);
 	vchan_free_chan_resources(to_virt_chan(dma_chan));
-	sdxi_cxt_exit(sdchan->cxt);
+	WARN_ON(sdxi_cxt_exit(sdchan->cxt));
 }
 
 int sdxi_dma_register(struct sdxi_dev *sdxi)
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index ef978ca22db1..f9f75ff5e179 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -113,10 +113,26 @@ static int sdxi_pci_get_irq(struct sdxi_dev *sdxi, unsigned int nr)
 	return pci_irq_vector(sdxi_to_pci_dev(sdxi), nr);
 }
 
+static void sdxi_pci_force_quiesce(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+	int ret;
+
+	pci_clear_master(pdev);
+	ret = pci_try_reset_function(pdev);
+	if (!ret)
+		return;
+
+	dev_err(&pdev->dev, "function reset failed: %d\n", ret);
+	if (!pci_wait_for_pending_transaction(pdev))
+		dev_err(&pdev->dev, "pending PCI transactions did not drain\n");
+}
+
 static const struct sdxi_bus_ops sdxi_pci_ops = {
 	.init = sdxi_pci_init,
 	.reset = sdxi_pci_reset,
 	.get_irq = sdxi_pci_get_irq,
+	.force_quiesce = sdxi_pci_force_quiesce,
 };
 
 static int sdxi_pci_probe(struct pci_dev *pdev,
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 6d2b9ba88182..7b3cad785442 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -63,6 +63,11 @@ struct sdxi_bus_ops {
 	 * @get_irq: Map device interrupt index to Linux IRQ number.
 	 */
 	int (*get_irq)(struct sdxi_dev *sdxi, unsigned int index);
+	/**
+	 * @force_quiesce: Permanently prevent further bus-mastering DMA after
+	 *                  device recovery fails.
+	 */
+	void (*force_quiesce)(struct sdxi_dev *sdxi);
 };
 
 struct sdxi_dev {
@@ -91,6 +96,8 @@ struct sdxi_dev {
 	struct ida vectors;
 
 	struct sdxi_cxt *admin_cxt;
+	struct mutex admin_lock;		/* admin submission serialization */
+	bool admin_dead;
 	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
 
 	bool has_mailbox;
@@ -138,6 +145,7 @@ static inline int sdxi_vector_to_irq(struct sdxi_dev *sdxi, unsigned int nr)
 
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
 void sdxi_unregister(struct device *dev);
+void sdxi_dev_force_quiesce(struct sdxi_dev *sdxi);
 
 static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
 {
-- 
2.56.1

