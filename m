Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120147;
	b=K+kmomHprVP72nQtb97YVgr4DKRNIPYJdiuK1juZWtHcMRM65WCtSVgViR3Yqd1cZBHm
	 1kgWYj8lzA8u+1m4DwW+BlAZu7Ho6QHfIMxOtH24hsMvUaEdAmnWJeFQeSEH3XMjtH/61
	 IgNKr8lcodxLGA4l9zI0Mnd/4V0u36RfhBJJocGA/7OEBtlTRXeoB9XtbEPzqoKPxl5j9
	 /VvKrdXPIbSPnZQlx/LYrykm2A5SUVrpVsRzilFbRUHkCkzbILPoiQG9v7jcw916bzBS6
	 N4fZjKOKoCqXwQyvRfCEhHTH0d1Ua2GY+m5OgJrqquBp6Kh1WHxN3FllDtRX1JAYqhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120147;
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
	bh=bei9j55cxvKPbRiA3KO0Gm/kDcQhJ2YxXlaIzJRDqR8=;
	b=VNPmhp9ElElUHg48pVH515jdOT3OpTCc4OqvPqnxZ4H3kVf9FPnkt6yZMqOVFwoZLrCs
	 wqUEqhfg8bnihIyEBqF+1Icj/WDEONcbEhgAsxmJgrWjHrtPMGfwYvk4KULRFuxw/0W7/
	 0ZEyaMjKeoOXC3rBSVUQoGisqHJNryK8CjzhXbJ6wKAhPv7C+uFnMxo4Eihj9xTkEivGr
	 jqRxGsU4Jbgk50WlsCZ1/BRnaHTwvNDObTm8UEJC8GQWQ0uS8jnNch6Vqm1hTH+4c4rek
	 L3c0+e1bo+osJNE/stBdWiumyQYl+T27+ElHtvnV7rvNU8MlMZ6YSXiXDPmjoVU0ilg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CKh1WDE4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.71
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B6606A330;
	Thu, 19 Nov 2026 20:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B43B6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CKh1WDE4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqirimgnYO6ILIenKODvZIZP6gz2Bqz+KSMLGIjjgs/ZsVHj4lt2H5MpVR1qF6F1mdwQWlkWCyg3vHmO+3l+pASnoBaNUHOA15363X7pSS4UlchY/dfpZkHfFBqK7FzEUORVgWotzLBfHQAasLbnc+cfLZ5jaoliPU2jlTB/DV11G1RpZ0K7lWLajs9xoLOuGaAsf++dqkjY/X+arrr34nI/j/b2Olw4WybrWGLdme2OGPdqW/uFynZK1W3ngW7O7PBUixpAHSlZ8r2Lov6lr+7tma5fzgHrwsO+dR+dweiGhzlhU9YI2uRrM3Xm+/758ck2j84qRMOF3hjiUHXvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bei9j55cxvKPbRiA3KO0Gm/kDcQhJ2YxXlaIzJRDqR8=;
 b=jzkMtLAvNRLjD1Cabqe1PMdWXYwHN4mibYAcBK4/MoqZbvTPazJKZA+6Okl4ZvxWvsj1rZ3FiILmEKPOWKWRiaDpIhlUdW0zyAyxeUFd9AdAR0fFaJIgSBAH7KcNQE9v0v8P4zQ+Q5K9bS5ZeAXqgRzNpql6I2ingq5exNmagX0Y3UvwtRZ9MU2H6jD/yaQuWjHNgKyETNFQkAnrOQ31zc/izkobznbfVZL9gP8HXGHJuh7dUH0ZZXkVOvjijAlQy8lZoh/3+F7TlZ/khY6YazDbHIMk4eDdcKQK6xVNvvqPDfmr2/OIqv4EupEgnBI131czH+aw2R+34H/yn/P6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bei9j55cxvKPbRiA3KO0Gm/kDcQhJ2YxXlaIzJRDqR8=;
 b=CKh1WDE4ojLBpup0Ygf40D/JkJoOJTtw6k9hwwLoD9SwrPAAIq4gBd9WVYTDUoF/C8PoYkGAGf7DbHClXf7Vj2/zTwrW9ThQCHho/yrXoH7TuTNuRqVCRnD6gnhwbkOlqoPMPfdg7QxjYCaood6kbd4GbItlbsoqLgiHvKDh/HI=
Received: from CY5PR16CA0016.namprd16.prod.outlook.com (2603:10b6:930:10::26)
 by CH4PR12MB164784.namprd12.prod.outlook.com (2603:10b6:610:522::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:29:01 +0000
Received: from CY5PEPF00000E84.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::72) by CY5PR16CA0016.outlook.office365.com
 (2603:10b6:930:10::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:29:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E84.mail.protection.outlook.com (10.167.247.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:29:01 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:28:58 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 26/44] dmaengine: sdxi: add SDXI trace events
Date: Thu, 19 Nov 2026 14:23:02 -0600
Message-ID: <20261119202321.1734355-27-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E84:EE_|CH4PR12MB164784:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df9aeb5-132a-4664-8be9-08df467bbf69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006|261026121527099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Crl8KrF3BI6Ke22c01I8wQo+ZQZ/Igdei3PIDxpckccibzUrAzyNyLybkTOr2T9HS+CuQJhOTkApFdCKj/SBi65aSng4ChO/9ChtD4JV4B5bWlDJwREkI74N3BITP8rWsgJa0V4OTMAuhDLFCY6xc0BBdUym4qO4vGJuBFBAfmk7UHJ70dMv2YJxdHhZ+s9OkOUgQcOeiB7Rn8pi4x7FLe/xlqOdB0DLnYda7AwEp5BPS6TtcJhI9yAqz1ARqsJHLHtbLRkpp76Sm6cFlQoeSrM7dwEtSrP4jxtOdsMGJdwKHMpjTfJjld3Cg4tngHFUSziyliIlMLC/vE7DU8pw5g4qHznvuORklY7yvfh0O9xajmuaxa6NDApW//5ddctOmFrs8GbRL8gYKofE0swUl81kujTREdfxiojh336CZUOvJ25AFw07h+DCKH7qP74ezJgVD7W+p7jLerm9/uTS9ajKpRKt0Rd9zzQT1Si/dQQxr+hyCKlOMRCAOy/pZrP8Eped4kLMU4Bd41s9WBSn0fPaXSdXkeS7zQYChCGDh7euaFD97hfkTb9dEvD2vfD+GpPrUC+gtgrNoAUqB6yBfRgX108E4cz4RgfmrrGRyFYOZYWbZyuzk6/c9ihYQ/fPO0Jk7EANpYmk8oBQfhmjM0YvCQlIkNpPGfJWEH5M4fOlala171b0vPxsO/KpaFI5GlqiL156xlL4e0/nrOrhmQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M8ZdGLOmr5/X2JWVqQzwdc7+Jqrv0DyPk8TFdGFfgpiiAni5Kap/ldDRgCn0bUO/t4JxZ+hAn3pJCkwhy2orA2K4ZgJ1NbKNlgDLcHYljK6iMi+Ig4zQb8uTx3QTcYaav+P9bUh1g339X+Nv0DQfu+rtFXM/wddTMxYeU7VVlozsYr4sjuhe/xaIhHtYph/NI5rBWxN+LiRaQlmFUDZDVssetzIwRYcFFMfBqq+D45R86b0h9keMNjd0V9/NubglLBYWEmaEa5qGzUpasw5YFIlzZF5bIRQEjqVNJfXj4EVOiWU2Xqs/xUTz4CwcFgfkbuo+j6QmFi7rF0uesZf0hG46u5PoIGAkwNdLajaWaLbetW0YHbdwThUF8b3MKdunlO8M/8kXDTh3RZWNqa5+Q06Wlp7CjbwZhBxlgtYu/+7h+KS4jZqPQ8q+jmNL02zi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:29:01.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df9aeb5-132a-4664-8be9-08df467bbf69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E84.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB164784

Add trace events for context and submission queue creation and
destruction, along with process SVA bind and unbind operations. Insert
the trace points into the corresponding call sites in SDXI driver.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Makefile  |   1 +
 drivers/dma/sdxi/context.c |  31 ++++++---
 drivers/dma/sdxi/process.c |   6 +-
 drivers/dma/sdxi/trace.c   |   9 +++
 drivers/dma/sdxi/trace.h   | 137 +++++++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 11 deletions(-)
 create mode 100644 drivers/dma/sdxi/trace.c
 create mode 100644 drivers/dma/sdxi/trace.h

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 019038cc91bc..34f62b7366eb 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -14,6 +14,7 @@ sdxi-core-y := \
 	process.o     \
 	ring.o        \
 	sysfs.o       \
+	trace.o       \
 	vendor.o
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 43ffe132cf2e..91c2837bbe82 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -36,6 +36,7 @@
 #include "ring.h"
 #include "sdxi.h"
 #include "submission.h"
+#include "trace.h"
 
 #define DEFAULT_DESC_RING_ENTRIES 1024
 #define SDXI_CXT_QUIESCE_TIMEOUT_MS 5000U
@@ -50,6 +51,16 @@ enum {
 
 static void sdxi_cxt_cleanup_workfn(struct work_struct *work);
 
+static void sdxi_cxt_free_sq(struct sdxi_cxt *cxt)
+{
+	if (!cxt->sq)
+		return;
+
+	trace_sdxi_free_sq(cxt, cxt->sq);
+	sdxi_sq_free(cxt->sdxi, cxt->sq);
+	cxt->sq = NULL;
+}
+
 /*
  * Free context and its resources. @cxt may be partially allocated but
  * must have ->sdxi set.
@@ -70,8 +81,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 				  cxt->akey_table, cxt->akey_table_dma);
 	if (cxt->cst_pool)
 		sdxi_cst_pool_destroy(sdxi, cxt->cst_pool);
-	if (cxt->sq)
-		sdxi_sq_free(sdxi, cxt->sq);
+	sdxi_cxt_free_sq(cxt);
 	ida_destroy(&cxt->akey_ida);
 	mutex_destroy(&cxt->akey_lock);
 	mutex_destroy(&cxt->cleanup_lock);
@@ -205,6 +215,7 @@ static int sdxi_alloc_kernel_submission(struct sdxi_cxt *cxt)
 	cxt->sq = sdxi_sq_alloc(cxt->sdxi, DEFAULT_DESC_RING_ENTRIES);
 	if (!cxt->sq)
 		return -ENOMEM;
+	trace_sdxi_create_sq(cxt, cxt->sq);
 
 	cxt->cst_pool = sdxi_cst_pool_create(cxt->sdxi,
 					     DEFAULT_DESC_RING_ENTRIES);
@@ -434,11 +445,13 @@ static int sdxi_publish_cxt(struct sdxi_cxt *cxt,
 	mutex_unlock(&cxt->sdxi->cxt_lock);
 	if (err) {
 		invalidate_cxt_ctl(cxt->cxt_ctl);
-	} else {
-		cxt->published = true;
-		cxt->update_pending = false;
+		return err;
 	}
-	return err;
+
+	cxt->published = true;
+	cxt->update_pending = false;
+	trace_sdxi_create_cxt(cxt->sdxi, cxt);
+	return 0;
 }
 
 /* Invalidate a context. */
@@ -451,6 +464,7 @@ static void sdxi_rescind_cxt(struct sdxi_cxt *cxt)
 
 	if (!cxt->published)
 		return;
+	trace_sdxi_free_cxt(sdxi, cxt);
 
 	mutex_lock(&sdxi->cxt_lock);
 	L1_table = sdxi->L1_tables[l2_idx];
@@ -575,10 +589,7 @@ static void sdxi_cxt_release_resources(struct sdxi_cxt *cxt)
 		sdxi_cst_pool_destroy(sdxi, cxt->cst_pool);
 		cxt->cst_pool = NULL;
 	}
-	if (cxt->sq) {
-		sdxi_sq_free(sdxi, cxt->sq);
-		cxt->sq = NULL;
-	}
+	sdxi_cxt_free_sq(cxt);
 	kfree(cxt->ring_state);
 	cxt->ring_state = NULL;
 }
diff --git a/drivers/dma/sdxi/process.c b/drivers/dma/sdxi/process.c
index b64f2307e4e3..31847af18e83 100644
--- a/drivers/dma/sdxi/process.c
+++ b/drivers/dma/sdxi/process.c
@@ -14,6 +14,7 @@
 #include "context.h"
 #include "process.h"
 #include "sdxi.h"
+#include "trace.h"
 
 static void sdxi_process_cleanup(struct sdxi_process *process)
 {
@@ -95,8 +96,10 @@ void sdxi_process_unbind_sva(struct sdxi_process *process,
 		mmu_notifier_unregister(&process->notifier, process->mm);
 	}
 
-	if (sva)
+	if (sva) {
 		iommu_sva_unbind_device(sva);
+		trace_sdxi_unbind_process(process->sdxi, pasid);
+	}
 }
 
 static void sdxi_process_free(struct sdxi_process *process)
@@ -157,6 +160,7 @@ int sdxi_process_bind(struct sdxi_process *process)
 
 	process->pasid = pasid;
 	process->sva = sva;
+	trace_sdxi_bind_process(process->sdxi, pasid);
 	return 0;
 
 unbind:
diff --git a/drivers/dma/sdxi/trace.c b/drivers/dma/sdxi/trace.c
new file mode 100644
index 000000000000..8fcde4538c94
--- /dev/null
+++ b/drivers/dma/sdxi/trace.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI tracepoints.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/drivers/dma/sdxi/trace.h b/drivers/dma/sdxi/trace.h
new file mode 100644
index 000000000000..e39db0e3debd
--- /dev/null
+++ b/drivers/dma/sdxi/trace.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI tracepoints.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM sdxi
+
+#if !defined(_TRACE_SDXI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SDXI_H
+
+#include <linux/tracepoint.h>
+
+#include "context.h"
+
+TRACE_EVENT(sdxi_create_cxt,
+	    TP_PROTO(struct sdxi_dev *sdxi, struct sdxi_cxt *cxt),
+	    TP_ARGS(sdxi, cxt),
+	    TP_STRUCT__entry(
+		    __field(u16, sfunc)
+		    __field(unsigned int, cxt_id)
+		    __field(void *, cce)
+		    __field(u64, cce_dma_addr)
+		    __field(void *, akey)
+		    __field(u64, akey_dma_addr)
+	    ),
+	    TP_fast_assign(
+		    __entry->sfunc = sdxi->sfunc;
+		    __entry->cxt_id = cxt->id;
+		    __entry->cce = cxt->cxt_ctl;
+		    __entry->cce_dma_addr = cxt->cxt_ctl_dma;
+		    __entry->akey = cxt->akey_table;
+		    __entry->akey_dma_addr = cxt->akey_table_dma;
+	    ),
+	    TP_printk("cxt=%u sfunc=%#x cxt_ctl=%p cxt_ctl_dma=%#llx akey=%p akey_dma=%#llx",
+		      __entry->cxt_id, __entry->sfunc, __entry->cce,
+		      __entry->cce_dma_addr, __entry->akey,
+		      __entry->akey_dma_addr)
+);
+
+TRACE_EVENT(sdxi_free_cxt,
+	    TP_PROTO(struct sdxi_dev *sdxi, struct sdxi_cxt *cxt),
+	    TP_ARGS(sdxi, cxt),
+	    TP_STRUCT__entry(
+		    __field(u16, sfunc)
+		    __field(unsigned int, cxt_id)
+	    ),
+	    TP_fast_assign(
+		    __entry->sfunc = sdxi->sfunc;
+		    __entry->cxt_id = cxt->id;
+	    ),
+	    TP_printk("cxt=%u sfunc=%#x", __entry->cxt_id, __entry->sfunc)
+);
+
+TRACE_EVENT(sdxi_create_sq,
+	    TP_PROTO(struct sdxi_cxt *cxt, struct sdxi_sq *sq),
+	    TP_ARGS(cxt, sq),
+	    TP_STRUCT__entry(
+		    __field(u16, sfunc)
+		    __field(unsigned int, cxt_id)
+		    __field(void *, desc_ring)
+		    __field(u64, desc_ring_addr)
+		    __field(void *, write_index)
+		    __field(u64, write_index_addr)
+		    __field(void *, cxt_status)
+		    __field(u64, cxt_status_addr)
+	    ),
+	    TP_fast_assign(
+		    __entry->sfunc = cxt->sdxi->sfunc;
+		    __entry->cxt_id = cxt->id;
+		    __entry->desc_ring = sq->ring;
+		    __entry->desc_ring_addr = sdxi_sq_ring_dma(sq);
+		    __entry->write_index = &sq->write_index;
+		    __entry->write_index_addr = sdxi_sq_write_index_dma(sq);
+		    __entry->cxt_status = &sq->cxt_sts;
+		    __entry->cxt_status_addr = sdxi_sq_cxt_sts_dma(sq);
+	    ),
+	    TP_printk("cxt=%u sfunc=%#x ring=%p/%#llx widx=%p/%#llx sts=%p/%#llx",
+		      __entry->cxt_id, __entry->sfunc, __entry->desc_ring,
+		      __entry->desc_ring_addr, __entry->write_index,
+		      __entry->write_index_addr, __entry->cxt_status,
+		      __entry->cxt_status_addr)
+);
+
+TRACE_EVENT(sdxi_free_sq,
+	    TP_PROTO(struct sdxi_cxt *cxt, struct sdxi_sq *sq),
+	    TP_ARGS(cxt, sq),
+	    TP_STRUCT__entry(
+		    __field(u16, sfunc)
+		    __field(unsigned int, cxt_id)
+	    ),
+	    TP_fast_assign(
+		    __entry->sfunc = cxt->sdxi->sfunc;
+		    __entry->cxt_id = cxt->id;
+	    ),
+	    TP_printk("cxt=%u sfunc=%#x", __entry->cxt_id, __entry->sfunc)
+);
+
+TRACE_EVENT(sdxi_bind_process,
+	    TP_PROTO(const struct sdxi_dev *sdxi, u32 pasid),
+	    TP_ARGS(sdxi, pasid),
+	    TP_STRUCT__entry(
+		    __string(devname, dev_name(sdxi_to_dev(sdxi)))
+		    __field(u32, pasid)
+	    ),
+	    TP_fast_assign(
+		    __assign_str(devname);
+		    __entry->pasid = pasid;
+	    ),
+	    TP_printk("device=%s pasid=%u", __get_str(devname), __entry->pasid)
+);
+
+TRACE_EVENT(sdxi_unbind_process,
+	    TP_PROTO(const struct sdxi_dev *sdxi, u32 pasid),
+	    TP_ARGS(sdxi, pasid),
+	    TP_STRUCT__entry(
+		    __string(devname, dev_name(sdxi_to_dev(sdxi)))
+		    __field(u32, pasid)
+	    ),
+	    TP_fast_assign(
+		    __assign_str(devname);
+		    __entry->pasid = pasid;
+	    ),
+	    TP_printk("device=%s pasid=%u", __get_str(devname), __entry->pasid)
+);
+
+#endif /* _TRACE_SDXI_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../drivers/dma/sdxi
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
-- 
2.56.1

