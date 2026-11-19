Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119970;
	b=b621QjYR3Ot/AXBz/6WGK+gRJ12Hqfz4sLxLbARZwLGAMYzZeCU6VkOy7fNiob1VafFv
	 LXn7eV2HNsDBw1ljbEETcvCCwgSHQQXlW07cGVWZOjHzhcz9GSoqbuz+eabKveRTrR1xb
	 ci4k2LIrjknGLluFF0i5R/Hgx23eNqkBVzYTvRWI4mbrCyrNcx/P1YKBewut3oWVIT71Z
	 tLl4Rw+f4BjkAfOfv6oSqNwJTDOaYhisbotlVS9EskUYrAJMOgWaOhIQ27o+ac7bj7GZs
	 rij3xhmDDkbrUwXO0YO1DHQPn+62kYbKnXPeavPt6o0otf2tfDE7LEPcEtDJ8WmXJjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119970;
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
	bh=dWK6xBFobwKaMWfK+h0g9LiVdImD7qaDhrZgRnaeUCk=;
	b=paWF7WUoAGBKcR2iyLZ2A0tfJKpEyViNQBhOE5qxnu3l61m9Zgw7LyCN5psr+IdeVRBI
	 tM8rJFG3Mi9pXgtjdI3Tk1B827ONaNvP6YppxOv9Rf4v3sGCKuowydqHTSRPdz5OWFxnd
	 nVY1wWeC0yDyIoiLLzga572S5oAueGNyla8vAEGXcexfFHm6bkjj71Hl9p8QW4WRxpZ7X
	 BHGTZ0RMty7/7u8YQ/I71t3BoQcEXeE8QpZsBbELCw11qZWvY8eu66rKc9DIsNcQe4pnV
	 fk87ZrQziAw8Cc6eqiwxULsUYkxBbFT6E6XMMYXsr07qC+lWIq5ITMGFqX0P4eD6lhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OlJVy+aq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.18
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4EE606A320;
	Thu, 19 Nov 2026 20:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B4EE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OlJVy+aq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnfdY+f7CEjnmqJGuEANcGGb7ofdpP4enAtAthjKO5TudBuLdpe2gaoQEtqRtT/XXFsmu92m3Aq0Elft6EEmbOEl3Mbk7N7izXARuhU2JubCpXEWRVym14GKqp8/wpgo4lNrtRKMLoyi17pLARZSSg1igI4rTH6BCqsPWekCc1B60elWFRpwNZSNnLMTESthQ6ADQ/L8dQ933ZbZRY6bkydl9FsRxeSHXRIbinducRlPXk0Z2D5mw+khRHr7ERypAPE3SyOwRGyyi4VeAQxLj1DbjPj+Vb2F3goKvhcLPWgyVoBG26WaO4jzMsAGxen7kg/nDIFqDlKOmGbomSHAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWK6xBFobwKaMWfK+h0g9LiVdImD7qaDhrZgRnaeUCk=;
 b=tWwLRA9sxAY1hgmKJ5X3JddDLNBSL775jc8/bfNd6DnwSUUXtFJpSZNHsdknTcGDuFZMrdVbdc5vnT+vPGr1YkGwspg+MImT9wsqTNhONQqF3vXTaeodRAfMT90ocfIZpXFsItvcoaA8UgO7U0YghqLDwPFkvB2UY+tVQHsDdP8GGagrz8Gj86rnAvsLhEBWhHfZBBxkaMEGQfVOCOw84krq2m+oRr7TUfoYe6AKHAdTjH1v8dtuSoZGnMtvY1TyC97jsJwAreHTKQVbdjBQbIyzgvLYmMHzDpwnxhwurnfjWkxZSHY5rWvg0NQXG8klLzmV4qt/BghgwnCQcRObEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWK6xBFobwKaMWfK+h0g9LiVdImD7qaDhrZgRnaeUCk=;
 b=OlJVy+aqRnuOEOzBYk6cuAu0reDMKlGv97GG1UAsB6aUxT5mfotU3dqGiqcp7j+AdIZLrt+J4ZPhJ2BbmvJrDbqlLonQQTFTMHjpURC6NtOElgP1r1SelysbpPwETzTmLkgDizA/cpEGmH5oOsGBb7IZFKj+fM6GURquJ9PQwDA=
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:26:01 +0000
Received: from DM3PEPF000265BA.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::a1) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:26:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BA.mail.protection.outlook.com (10.167.23.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:26:00 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:25:59 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 13/44] dmaengine: sdxi: kill user contexts on fatal errors
Date: Thu, 19 Nov 2026 14:22:49 -0600
Message-ID: <20261119202321.1734355-14-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BA:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8d91af-b623-40b5-18bd-08df467b53c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|10067099003|261022075727099003|261026121527099003|56012099006|261026140227099003|261026130827099003|11063799006|261022105027099003|261022115727099003|261021130227099003|261009223027099003|261021135927099003|261021123027099003|261021133027099003|261021121427099003|261022113327099003|261026135527099003|261102123227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QPzMGsHJpjcVYYVpT0QXMPHFvW+I4i40gJ2pu4Bz60TIflmkJ1WzW0la9UvxfOOiJllMkie/ILXuZae72K8HgOFH9dzELLa/W+Ll+IteSAO/EyZCX/KSJe+6Th3LO/okPHU34LPvMLfwH7OhkLzez6iVCjB85RvU8RaEQBpYPG1gzqok8Am4Ma9WLiYNdGHWTUtvYTv3k0H/DJP+9Fa6bFhVoxwglPgr45lQj2uZAhoODe+56iv6EnJC6dnoFVnjflhLwQ2gq3PkgIjGZWZwM7G5yWJa4luVSW8S6TxxSd0eGMQq0xwO+BZA2YYDcz9QGkkzFfqxXX4+jB8ny9HDOtidK0m2ISTN2pEotlr3HKlf26Yah7It4HvmH2L817m2+x4YSMMhRxx3qt8Cp5DEJVlL+yMEJ6uyXomcB1Ghe3f0v9C1VSM8cuzkfy+64GTyZJohgEBA/r1HjEjwyzLL0SCo7Rui6x2YkLZH1/6ex8WGjdm9JRaGmh5b4neSPAIeHzqmsJBG7psHXoDbl8LyKYotqOf8/mzwyqg+bshXWzA8qPorvbuzDLZy6h8NDyuOXPhxKcCF05zlfQfv/DdqZPpkYpNWtEzRhn3N1I1l5Itf+ZjXwSni8Xq7sOSi9GX91zcA/kG4Hw1k8xtTMlE7s+jY+37qZG37RADJj5BP6BPs4MzLfyTUgSwltgjYNiQuNIP3GbmkuukfontLqV+iCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(261022075727099003)(261026121527099003)(56012099006)(261026140227099003)(261026130827099003)(11063799006)(261022105027099003)(261022115727099003)(261021130227099003)(261009223027099003)(261021135927099003)(261021123027099003)(261021133027099003)(261021121427099003)(261022113327099003)(261026135527099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fHYl3Q6af6Jy8pjyJbN6/l+IwW1R722Lqed9yYab45m+ffWTPbXjfjXMsZmc25z47lkviJI5ZkBwM2X7E2dh13brSU51OO1pCmGfj65VuLZ8BqgwRvt0lhDSeYokxZsSIsam+Boeg2zynnGxRgJOTf6Zzk09LdSPkOJdmZpHjEylLy6iSLkUs2tQLF2DQrQiQHwzKH3VdJU/JmG0MzxTj9A9iNrun7dhb0TbA0WjTnGELMg0vB2X+5+YILAG+v3OA4MKo3oBHyaprGE27Sc5k/0IUKV/FkFl1PvkUjCLWSPZDpqZ9ohGoe1QHsq2iKlDrjUegEyPHKumHe+zqBasNquZBVOQphyHv+IKT6hdtt94vr5vhCkaOFvqFi98e+x5YelssaJWNwfaazxZF5FhxIOb947XkblOE83OOutpTeEQQffj2wvHWEnhHb1l5DJa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:26:00.9390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8d91af-b623-40b5-18bd-08df467b53c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673

Use context references from current xarray to translate error-log
stop reactions into fatal userspace context cleanup. Kernel and
administrative contexts remain under their existing owners.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/context.c | 21 +++++++++++
 drivers/dma/sdxi/context.h |  1 +
 drivers/dma/sdxi/device.c  |  5 +++
 drivers/dma/sdxi/error.c   | 71 ++++++++++++++++++++++++++++++++++++--
 drivers/dma/sdxi/sdxi.h    |  1 +
 5 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index f5e31f9f9131..2c3b6f5df4b5 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -1119,6 +1119,27 @@ void sdxi_cxt_kill(struct sdxi_cxt *cxt)
 	wake_up_poll(&cxt->poll_wq, EPOLLERR);
 }
 
+void sdxi_cxt_kill_stopped(struct sdxi_cxt *cxt)
+{
+	bool newly_fatal;
+
+	if (!cxt)
+		return;
+
+	mutex_lock(&cxt->cleanup_lock);
+	newly_fatal = !cxt->fatal;
+	cxt->fatal = true;
+	cxt->started = false;
+	cxt->quiesced = true;
+	cxt->quiesce_cst_flags = 0;
+	if (sdxi_cxt_is_user(cxt))
+		sdxi_cxt_queue_cleanup_locked(cxt, 0);
+	mutex_unlock(&cxt->cleanup_lock);
+
+	if (newly_fatal)
+		wake_up_poll(&cxt->poll_wq, EPOLLERR);
+}
+
 void sdxi_cxt_release_user_handle(struct sdxi_cxt *cxt)
 {
 	if (!cxt)
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index b4a416509243..bbe83e54b827 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -108,6 +108,7 @@ int sdxi_cxt_quiesce(struct sdxi_cxt *cxt, unsigned int timeout_ms,
 bool sdxi_cxt_is_user(const struct sdxi_cxt *cxt);
 bool sdxi_cxt_is_fatal(const struct sdxi_cxt *cxt);
 void sdxi_cxt_kill(struct sdxi_cxt *cxt);
+void sdxi_cxt_kill_stopped(struct sdxi_cxt *cxt);
 void sdxi_cxt_release_user_handle(struct sdxi_cxt *cxt);
 int sdxi_cxt_notify_mm_release(struct sdxi_cxt *cxt);
 void sdxi_cxt_vma_open(struct sdxi_cxt *cxt);
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index e760c8a2603a..1587795c0a16 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -96,6 +96,11 @@ static enum sdxi_fn_gsv sdxi_dev_gsv(const struct sdxi_dev *sdxi)
 	return gsv;
 }
 
+bool sdxi_dev_in_error(const struct sdxi_dev *sdxi)
+{
+	return sdxi_dev_gsv(sdxi) == SDXI_GSV_ERROR;
+}
+
 static const unsigned long gsv_poll_interval_us = USEC_PER_MSEC * 100;
 static const unsigned long gsv_transition_timeout_us = USEC_PER_SEC * 1;
 
diff --git a/drivers/dma/sdxi/error.c b/drivers/dma/sdxi/error.c
index 561e88d81f41..4d8607b3bbec 100644
--- a/drivers/dma/sdxi/error.c
+++ b/drivers/dma/sdxi/error.c
@@ -14,6 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/string.h>
 
+#include "context.h"
 #include "error.h"
 #include "hw.h"
 #include "mmio.h"
@@ -61,6 +62,11 @@ enum {
 	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
 };
 
+enum sdxi_errlog_reaction {
+	SDXI_ERRLOG_REACTION_CXT_STOP = 1,
+	SDXI_ERRLOG_REACTION_FN_STOP = 2,
+};
+
 static const char *const sdxi_err_steps[] = {
 	[1] = "internal",
 	[2] = "context L2",
@@ -124,6 +130,44 @@ static void sdxi_errlog_report(struct sdxi_dev *sdxi, u64 read_index,
 		dev_err(sdxi->dev, "  buffer=%u\n", entry->buf);
 }
 
+static bool sdxi_errlog_handle_reaction(struct sdxi_dev *sdxi,
+					const struct sdxi_errlog_entry *entry)
+{
+	struct sdxi_cxt *cxt;
+
+	if (entry->reaction == SDXI_ERRLOG_REACTION_FN_STOP)
+		return true;
+	if (entry->reaction != SDXI_ERRLOG_REACTION_CXT_STOP ||
+	    !entry->cv || !entry->cxt_num)
+		return false;
+
+	cxt = sdxi_cxt_get_by_id(sdxi, entry->cxt_num);
+	if (!cxt)
+		return false;
+
+	if (sdxi_cxt_is_user(cxt))
+		sdxi_cxt_kill_stopped(cxt);
+	sdxi_cxt_put(cxt);
+	return false;
+}
+
+static void sdxi_error_handle_function(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cxt *cxt;
+	u32 cxt_id;
+
+	dev_err(sdxi->dev, "function stopped after hardware error\n");
+	sdxi_dev_fail(sdxi);
+
+	for (cxt_id = 1; cxt_id <= sdxi->max_cxtid; cxt_id++) {
+		cxt = sdxi_cxt_get_by_id(sdxi, cxt_id);
+		if (!cxt)
+			continue;
+		sdxi_cxt_kill_stopped(cxt);
+		sdxi_cxt_put(cxt);
+	}
+}
+
 static irqreturn_t sdxi_error_irq_thread(int irq, void *data)
 {
 	struct sdxi_dev *sdxi = data;
@@ -134,10 +178,16 @@ static irqreturn_t sdxi_error_irq_thread(int irq, void *data)
 	u64 read_index;
 	u64 status;
 	u64 count;
+	bool function_stopped;
 
 	status = sdxi_read64(sdxi, SDXI_MMIO_ERR_STS);
-	if (!(status & ack_mask))
-		return IRQ_NONE;
+	function_stopped = sdxi_dev_in_error(sdxi);
+	if (!(status & ack_mask)) {
+		if (!function_stopped)
+			return IRQ_NONE;
+		sdxi_error_handle_function(sdxi);
+		return IRQ_HANDLED;
+	}
 
 	if (status & SDXI_MMIO_ERR_STS_ERR_BIT)
 		dev_err(sdxi->dev, "hardware could not write the error log\n");
@@ -145,6 +195,8 @@ static irqreturn_t sdxi_error_irq_thread(int irq, void *data)
 		dev_err(sdxi->dev, "error log overflowed\n");
 	if (!(status & SDXI_MMIO_ERR_STS_STS_BIT)) {
 		sdxi_write64(sdxi, SDXI_MMIO_ERR_STS, status & ack_mask);
+		if (function_stopped)
+			sdxi_error_handle_function(sdxi);
 		return IRQ_HANDLED;
 	}
 
@@ -170,12 +222,17 @@ static irqreturn_t sdxi_error_irq_thread(int irq, void *data)
 		size_t index = read_index % SDXI_ERRLOG_ENTRIES;
 
 		memcpy(&raw, &sdxi->err_log[index], sizeof(raw));
-		if (sdxi_errlog_decode(sdxi, &raw, &entry))
+		if (sdxi_errlog_decode(sdxi, &raw, &entry)) {
 			sdxi_errlog_report(sdxi, read_index, &entry);
+			function_stopped |=
+				sdxi_errlog_handle_reaction(sdxi, &entry);
+		}
 		read_index++;
 	}
 
 	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, read_index);
+	if (function_stopped)
+		sdxi_error_handle_function(sdxi);
 	return IRQ_HANDLED;
 }
 
@@ -214,6 +271,10 @@ int sdxi_error_init(struct sdxi_dev *sdxi)
 	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 1);
 	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
 
+	reg = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &reg, 1);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, reg);
+
 	size_order = ilog2(SDXI_ERRLOG_SIZE) - ilog2(SZ_4K);
 	reg = FIELD_PREP(SDXI_MMIO_ERR_CFG_PTR,
 			 sdxi->err_log_dma >> ilog2(SZ_4K)) |
@@ -237,6 +298,10 @@ void sdxi_error_exit(struct sdxi_dev *sdxi)
 	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 0);
 	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
 
+	reg = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &reg, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, reg);
+
 	if (sdxi->error_irq >= 0)
 		devm_free_irq(sdxi->dev, sdxi->error_irq, sdxi);
 
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index c000542b5ce9..fa34aaa36c16 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -160,6 +160,7 @@ static inline int sdxi_vector_to_irq(struct sdxi_dev *sdxi, unsigned int nr)
 
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
 void sdxi_unregister(struct device *dev);
+bool sdxi_dev_in_error(const struct sdxi_dev *sdxi);
 void sdxi_dev_force_quiesce(struct sdxi_dev *sdxi);
 void sdxi_dev_fail(struct sdxi_dev *sdxi);
 
-- 
2.56.1

