Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120187;
	b=FTicgfS9gn15LpBMZSvI39mYIJMYRuvYv6ITYQ56jKbWHqwIkb9hqPtvP0dtONXNcz/P
	 noDPmuZk1BzN6rnpCopmTrKQwZabO/nY7+I0DURGD+j2oAYg1n2CefWNEHl22SP3fOZ+K
	 u+we6mCDHaJCtB5yHnCiUQnCyMc3tIg4MORRtQjKYnnWG/tbBlyB/qlW+0sQqoh8C/0e9
	 pL6EyTROTgMKZJPQeQLZolTt0Zd2vfK3LvjYlNgpIfPzeogmZCyqhL6j2yY/U6kMyGzuv
	 Q+twLqJ8cVSo02daYYTnKNJoL9Z6KjXU+TcAe/0e6krKKczAjH7xLgXLSkfhy8H51jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120187;
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
	bh=EWDSN4LlShSQW9W8s/r7hLS++Lndl+cw6aBcjCj2hmE=;
	b=k4mOyv3plPMQqLX7AfbTYoBMel/UaTlPr8H1qkjXBmB3ZX4DPZvTbQVMQ7PtkXdQC6hQ
	 6R6aTytvDAYYfKFfTo4ZTjwY+vqp2reTiGeG8Sc/It2juLz/DWuuSaD8nIFbLRS5MsUum
	 VyuphPqQBva2wmIfew6W/j6mV6CuO3pDGQHJ/I+OmFJn2XqGocpaYuo4S3vhz9BPQHu+L
	 6fwa2TalG60nMy8R++CiyREZj45ZGVEl2QIF99I8Aasfc4fU7pYuM4JJiK4wAhUNP2Kui
	 Fy3lPnWeUXs1NVzuCvCLN3QPKJPGaTGbuNODsbYLpwbPNhCsphuvm/ROT1HbD5QJptA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uikgT5Gf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.49
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244C60A2609;
	Thu, 19 Nov 2026 20:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A244C60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uikgT5Gf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyVqrA/mTSdDCMlIYyN75F6z2MibnreN5p1mJXGnDgt3fcvdfXHffNiWh71eQIswPNjwldrY0q4lkj23w2jCB4ndVWY2UTrqpjOw0XJs1THQvxGoBVpU2AOvxrnCDaQu/J8Gef8Z+xvER2RgH1NzSCjcCgtGDfkJSO9mRkaJAFn+CbU3dCj5GIqCwdTKG22gfjWRo0xilrWGZNruMu9w1jbx3VfTdxfKe0JPzIj6dmylz9sch7XMeOsEHqVlW1/D59nzYYs6lwW3nrNE4qfvsswGnOdl+AjefgoT3z/oM4dUkiIOCVm3lsLKlYzvr8MAIQi1LvUpKzV9+uwYRaryLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWDSN4LlShSQW9W8s/r7hLS++Lndl+cw6aBcjCj2hmE=;
 b=tcye+7YKum4EfMKodbvTg7DcgR3zkrmk6CQ38xpSzZDjdzI4u4npBrBnJXIfVgGaEDh5I3+RsMpVTOr5wCenPHq93z26tSDCwOv6LvJ1GZbEyGN3aK069nmDVjw+gxoT/5hD/94c32Ei0uEZjR8hYFNJprAwu2OGxV2hUxc3j+mpaGPQo7FhwdCmPvmPSCMwzoX/pEMMdXPtdLWQgHWe7Ij/CKGybSVto3HFIyspkn82diAezeh4d7/WPiKHwlAZcVHNpmC8klmNjbKUN4IeMDeKprFFsbhN3/icq/eCT6rf+AR15t2haVnCj9zRla43F8xCpNDh3KYy0qS3AxIppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWDSN4LlShSQW9W8s/r7hLS++Lndl+cw6aBcjCj2hmE=;
 b=uikgT5GfW4eXOOHN4gyuRDzvrGFPgGRwz7CMCB4WAwclgSPYDXJdqAY6thVNOTYvpVR5T98AgHrWGmizTJmDdqJ11TwefWD0cf3zrIX54y0ePTuU1F4RAWZ4bIWN/BgNp0lGXZqZvV29JB6OWsS9VPezWy7Etg4OHxT0uk+YQtg=
Received: from CY5PR18CA0008.namprd18.prod.outlook.com (2603:10b6:930:5::11)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:29:12 +0000
Received: from CY5PEPF00000E86.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::61) by CY5PR18CA0008.outlook.office365.com
 (2603:10b6:930:5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:29:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E86.mail.protection.outlook.com (10.167.247.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:29:11 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:29:09 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 27/44] dmaengine: sdxi: support suspend and resume
Date: Thu, 19 Nov 2026 14:23:03 -0600
Message-ID: <20261119202321.1734355-28-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E86:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b085a4c-cd09-4db4-215f-08df467bc582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|1800799024|376014|18002099003|22082099003|261009223027099003|56012099006|11063799006|260925021311599003|260925021911599003|260925022911599003|261026140227099003|10067099003|261026121527099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261102130727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	glbfu1+/mQWWY60g9qD3skB6I2cs5jxB+y+kORZ2ztFrBOsy90uD8q1pfvxtXf7ZGKNLli8WqOBrnLc+Lov57mMVvCnKbQkzOIOWGMqHgNkbNuVhDEmgEnEu6a72bTTb6Zn9VrJlmhMhcxL0eZ8XjPft1VNQgsLQ1mvF8Cd/s4CV+yVPlH2RlBcqOPO+UMkNfaz0FJyJSTYlLAgH3bMQ65Ssx5Ky/oP1JLjCSMlbwmUCsbTfPm8G5PpqLT7OwP9VABhAAED/wjXoSiOOj5/x8JZP2x5WA0hKKx+yZDJn7yeqDICPkhTb5aWCfyo28sEqoATBQVNutn6H08ImmFMTCdXXKJ1UcvDMosZ6Rt4slBcMZmX7tHDC/gOFzVEsa+i04cGlSs5FHnp31hK4q6KOq2pKKw6vmvTax8bz9frlpMecHbCw1y/AN2E6vKzKfa1n/IjuxT1PKBDua+zF1IAaPug4oK31QFdXyCWUGF0lGVpMglthbqPBnboqZMAwsvUrCSjkiYtoB/VjalZuL9Y6JeRcbaJrsXw/KNju35U77A/vW3HKNOdv0QiQEGB1gI4e2wp+702utzx7tBK7lP4DY2PV0BYwm04Z83MaPQuKHXeOkMbOclDlpEFsO3YJedvEoyeQUnx/SyqMDqFootnGhlR+rVKd+g91Ggly83BS3jG2UFvSEjmxF/jzWprLR5Yrz0IIrB2bf5Q7Tc8VnQoa1g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(56012099006)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(261026140227099003)(10067099003)(261026121527099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261102130727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2THy1fcONFl3H7KP3yvQ4dOeKQJ9+CM9a9KoFTulGITFDMhCaW79owFbD+C/vPCD4czNVfMzqs5bnHCUJl+rdcGpm63qaZQUag4vYAxHgoyBCGkS9s7AiSMtNEw4Bg3ZJzD6Az6aXyYSz05zKyR6hacE/rLdkOK5Bht6j2BAxwFp44X6rxmAEsaxhG0z3h299PsqKHYmakon7F4pmozpGjcy/eaYiYqYlCTDzh0wlvVrjTShlI8IVetaN2BN4lh5WMxmW81oznxDreXO/wUUv98HNYZcIY+72HGTpHqsilUlwpuDVr/9xFjOIHgi+FQvRBavGUvX+3S5P4Sj1gu0CZHS5bHuU/DHotmPGwVkT56Qd4GTCrMOSwC2h2yewICwZr62EIdq88+jD+ArteeUqzhZ2PLo5IagrTmnBCopQSsjEjd7gYkgKRxiB8us3EvO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:29:11.7594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b085a4c-cd09-4db4-215f-08df467bc582
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E86.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074

During suspend, save function control state, stop the function with
error interrupts disabled. Similarly restore context tables, RKeys,
error logging, the admin context, and previously running client contexts
on resume. Keep PCI responsible for wiring the core PM callbacks.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/context.c |  11 +++
 drivers/dma/sdxi/context.h |   1 +
 drivers/dma/sdxi/device.c  | 186 +++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/error.c   |  56 +++++++++++
 drivers/dma/sdxi/error.h   |   2 +
 drivers/dma/sdxi/keys.c    |  14 +++
 drivers/dma/sdxi/keys.h    |   1 +
 drivers/dma/sdxi/pci.c     |   5 +
 drivers/dma/sdxi/sdxi.h    |   8 ++
 9 files changed, 284 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 91c2837bbe82..12502021600d 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -1245,6 +1245,17 @@ int sdxi_cxt_notify_mm_release(struct sdxi_cxt *cxt)
 	return ret;
 }
 
+void sdxi_cxt_resume_cleanup(struct sdxi_cxt *cxt)
+{
+	if (!cxt)
+		return;
+
+	mutex_lock(&cxt->cleanup_lock);
+	if (sdxi_cxt_is_user(cxt) && sdxi_cxt_cleanup_requested(cxt))
+		sdxi_cxt_queue_cleanup_locked(cxt, 0);
+	mutex_unlock(&cxt->cleanup_lock);
+}
+
 void sdxi_cxt_vma_open(struct sdxi_cxt *cxt)
 {
 	if (!cxt)
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 22a33291020f..c3f3353874a0 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -116,6 +116,7 @@ void sdxi_cxt_kill(struct sdxi_cxt *cxt);
 void sdxi_cxt_kill_stopped(struct sdxi_cxt *cxt);
 void sdxi_cxt_release_user_handle(struct sdxi_cxt *cxt);
 int sdxi_cxt_notify_mm_release(struct sdxi_cxt *cxt);
+void sdxi_cxt_resume_cleanup(struct sdxi_cxt *cxt);
 void sdxi_cxt_vma_open(struct sdxi_cxt *cxt);
 int sdxi_cxt_vma_acquire(struct sdxi_cxt *cxt);
 void sdxi_cxt_vma_close(struct sdxi_cxt *cxt);
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index cb7056916c3d..f0e447e7a81b 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -22,6 +22,7 @@
 #include <linux/time.h>
 #include <linux/xarray.h>
 
+#include "admin.h"
 #include "context.h"
 #include "dma.h"
 #include "error.h"
@@ -526,6 +527,190 @@ static void sdxi_dev_release(struct device *chardev)
 	kfree(sdxi);
 }
 
+static void sdxi_restore_admin_cxt(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cxt *adm = sdxi->admin_cxt;
+	u64 doorbell;
+
+	if (!adm || !adm->sq)
+		return;
+
+	WRITE_ONCE(adm->sq->cxt_sts.state,
+		   FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN));
+	dma_wmb();
+	doorbell = le64_to_cpu(READ_ONCE(adm->sq->write_index));
+	writeq(doorbell, adm->sq->doorbell);
+}
+
+static int sdxi_restart_contexts(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cxt *entry;
+	unsigned long index;
+	int result = 0;
+
+	xa_for_each(&sdxi->client_cxts, index, entry) {
+		struct sdxi_cxt *cxt;
+		int ret;
+
+		if (!entry)
+			continue;
+		cxt = sdxi_cxt_get_by_id(sdxi, index);
+		if (!cxt)
+			continue;
+
+		mutex_lock(&cxt->cleanup_lock);
+		if (cxt->fatal || cxt->handle_closed || cxt->mm_dead ||
+		    cxt->cleanup_stopping ||
+		    cxt->resources_released || !cxt->started) {
+			mutex_unlock(&cxt->cleanup_lock);
+			sdxi_cxt_put(cxt);
+			continue;
+		}
+
+		ret = sdxi_adm_start_cxt(cxt);
+		mutex_unlock(&cxt->cleanup_lock);
+		if (ret) {
+			dev_err(sdxi->dev, "failed to restart context %u: %d\n",
+				cxt->id, ret);
+			sdxi_cxt_kill(cxt);
+			result = ret;
+		}
+		sdxi_cxt_put(cxt);
+	}
+
+	return result;
+}
+
+static void sdxi_resume_cleanup_contexts(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cxt *entry;
+	unsigned long index;
+
+	xa_for_each(&sdxi->client_cxts, index, entry) {
+		struct sdxi_cxt *cxt;
+
+		if (!entry)
+			continue;
+		cxt = sdxi_cxt_get_by_id(sdxi, index);
+		if (!cxt)
+			continue;
+		sdxi_cxt_resume_cleanup(cxt);
+		sdxi_cxt_put(cxt);
+	}
+}
+
+int sdxi_suspend(struct device *dev)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+	int ret;
+
+	if (!sdxi)
+		return -ENODEV;
+
+	mutex_lock(&sdxi->pm_lock);
+	if (sdxi->pm_suspended) {
+		ret = 0;
+		goto out_unlock;
+	}
+	down_write(&sdxi->state_lock);
+	if (!sdxi->online) {
+		up_write(&sdxi->state_lock);
+		ret = -EIO;
+		goto out_unlock;
+	}
+	sdxi->online = false;
+
+	mutex_lock(&sdxi->reg_lock);
+	sdxi->pm_ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+	sdxi->pm_ctl2 = sdxi_read64(sdxi, SDXI_MMIO_CTL2);
+	mutex_unlock(&sdxi->reg_lock);
+	sdxi->pm_fn_was_active = sdxi_dev_gsv(sdxi) == SDXI_GSV_ACTIVE;
+
+	sdxi_error_suspend(sdxi);
+	ret = sdxi_dev_stop(sdxi);
+	if (ret) {
+		/* Recovery failed; keep users out and fence DMA. */
+		sdxi_dev_force_quiesce(sdxi);
+	} else {
+		sdxi->pm_suspended = true;
+	}
+	up_write(&sdxi->state_lock);
+
+out_unlock:
+	mutex_unlock(&sdxi->pm_lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(sdxi_suspend, "SDXI");
+
+int sdxi_resume(struct device *dev)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+	u64 cxt_l2;
+	u64 ctl0;
+	bool error_resumed = false;
+	bool make_online = false;
+	bool state_locked = false;
+	int ret = 0;
+
+	if (!sdxi)
+		return -ENODEV;
+
+	mutex_lock(&sdxi->pm_lock);
+	if (!sdxi->pm_suspended)
+		goto out_unlock;
+	down_write(&sdxi->state_lock);
+	state_locked = true;
+
+	ctl0 = sdxi->pm_ctl0;
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_GSR, &ctl0, SDXI_GSRV_STOP_SF);
+	mutex_lock(&sdxi->reg_lock);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
+	mutex_unlock(&sdxi->reg_lock);
+
+	ret = sdxi_dev_stop(sdxi);
+	if (ret)
+		goto resume_failed;
+
+	mutex_lock(&sdxi->reg_lock);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL2, sdxi->pm_ctl2);
+	mutex_unlock(&sdxi->reg_lock);
+	cxt_l2 = FIELD_PREP(SDXI_MMIO_CXT_L2_PTR,
+			    sdxi->L2_dma >> ilog2(SZ_4K));
+	sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, cxt_l2);
+	sdxi_keys_resume(sdxi);
+	sdxi_error_resume(sdxi);
+	error_resumed = true;
+
+	if (sdxi->pm_fn_was_active) {
+		ret = sdxi_dev_start(sdxi);
+		if (ret)
+			goto resume_failed;
+		sdxi_restore_admin_cxt(sdxi);
+		ret = sdxi_restart_contexts(sdxi);
+		if (ret)
+			goto resume_failed;
+	}
+	sdxi->pm_suspended = false;
+	sdxi->online = true;
+	make_online = true;
+	goto out_unlock;
+
+resume_failed:
+	if (error_resumed)
+		sdxi_error_suspend(sdxi);
+	if (sdxi_dev_stop(sdxi))
+		sdxi_dev_force_quiesce(sdxi);
+
+out_unlock:
+	if (state_locked)
+		up_write(&sdxi->state_lock);
+	mutex_unlock(&sdxi->pm_lock);
+	if (make_online)
+		sdxi_resume_cleanup_contexts(sdxi);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(sdxi_resume, "SDXI");
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 {
 	struct sdxi_dev *sdxi;
@@ -546,6 +731,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	mutex_init(&sdxi->reg_lock);
 	mutex_init(&sdxi->admin_lock);
 	mutex_init(&sdxi->rkey_lock);
+	mutex_init(&sdxi->pm_lock);
 	sdxi->error_irq = -1;
 	sdxi->minor = -1;
 	dev_set_drvdata(dev, sdxi);
diff --git a/drivers/dma/sdxi/error.c b/drivers/dma/sdxi/error.c
index d4c1e64dbf2b..ae649985a424 100644
--- a/drivers/dma/sdxi/error.c
+++ b/drivers/dma/sdxi/error.c
@@ -313,3 +313,59 @@ void sdxi_error_exit(struct sdxi_dev *sdxi)
 	sdxi->err_log = NULL;
 	sdxi->err_log_dma = 0;
 }
+
+void sdxi_error_suspend(struct sdxi_dev *sdxi)
+{
+	u64 reg;
+
+	if (!sdxi->err_log)
+		return;
+
+	disable_irq(sdxi->error_irq);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
+
+	mutex_lock(&sdxi->reg_lock);
+	reg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CTL);
+	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
+
+	reg = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &reg, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, reg);
+	mutex_unlock(&sdxi->reg_lock);
+}
+
+void sdxi_error_resume(struct sdxi_dev *sdxi)
+{
+	unsigned int size_order;
+	u64 reg;
+
+	if (!sdxi->err_log)
+		return;
+
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_STS,
+		     SDXI_MMIO_ERR_STS_STS_BIT |
+		     SDXI_MMIO_ERR_STS_OVF_BIT |
+		     SDXI_MMIO_ERR_STS_ERR_BIT);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_WRT, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, 0);
+
+	mutex_lock(&sdxi->reg_lock);
+	reg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CTL);
+	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 1);
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
+
+	reg = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &reg, 1);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, reg);
+	mutex_unlock(&sdxi->reg_lock);
+
+	size_order = ilog2(SDXI_ERRLOG_SIZE) - ilog2(SZ_4K);
+	reg = FIELD_PREP(SDXI_MMIO_ERR_CFG_PTR,
+			 sdxi->err_log_dma >> ilog2(SZ_4K)) |
+	      FIELD_PREP(SDXI_MMIO_ERR_CFG_SZ, size_order) |
+	      SDXI_MMIO_ERR_CFG_EN;
+	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, reg);
+	enable_irq(sdxi->error_irq);
+}
diff --git a/drivers/dma/sdxi/error.h b/drivers/dma/sdxi/error.h
index 756a4fe45158..866117559aa3 100644
--- a/drivers/dma/sdxi/error.h
+++ b/drivers/dma/sdxi/error.h
@@ -12,5 +12,7 @@ struct sdxi_dev;
 
 int sdxi_error_init(struct sdxi_dev *sdxi);
 void sdxi_error_exit(struct sdxi_dev *sdxi);
+void sdxi_error_suspend(struct sdxi_dev *sdxi);
+void sdxi_error_resume(struct sdxi_dev *sdxi);
 
 #endif /* DMA_SDXI_ERROR_H */
diff --git a/drivers/dma/sdxi/keys.c b/drivers/dma/sdxi/keys.c
index 0d570daefd34..8397d575c06a 100644
--- a/drivers/dma/sdxi/keys.c
+++ b/drivers/dma/sdxi/keys.c
@@ -289,6 +289,20 @@ void sdxi_keys_exit(struct sdxi_dev *sdxi)
 	sdxi->rkey_cap = false;
 }
 
+void sdxi_keys_resume(struct sdxi_dev *sdxi)
+{
+	u64 reg;
+
+	if (!sdxi->rkey_cap || !sdxi->rkey_table)
+		return;
+
+	reg = FIELD_PREP(SDXI_MMIO_RKEY_PTR,
+			 sdxi->rkey_table_dma >> ilog2(SZ_4K)) |
+	      FIELD_PREP(SDXI_MMIO_RKEY_SZ, sdxi->rkey_order) |
+	      SDXI_MMIO_RKEY_EN;
+	sdxi_write64(sdxi, SDXI_MMIO_RKEY, reg);
+}
+
 int sdxi_ioctl_get_rkey_list(struct file *file, struct sdxi_file *sf,
 			     void *data)
 {
diff --git a/drivers/dma/sdxi/keys.h b/drivers/dma/sdxi/keys.h
index 6e36527b610a..775dd381e3f3 100644
--- a/drivers/dma/sdxi/keys.h
+++ b/drivers/dma/sdxi/keys.h
@@ -16,6 +16,7 @@ struct sdxi_file;
 
 int sdxi_keys_init(struct sdxi_dev *sdxi, u64 cap1);
 void sdxi_keys_exit(struct sdxi_dev *sdxi);
+void sdxi_keys_resume(struct sdxi_dev *sdxi);
 int sdxi_ioctl_get_rkey_list(struct file *file, struct sdxi_file *sf,
 			     void *data);
 int sdxi_ioctl_get_rkeys(struct file *file, struct sdxi_file *sf, void *data);
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index abef318cfd7c..fa080dc004ab 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -221,12 +221,17 @@ static const struct pci_device_id sdxi_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, sdxi_id_table);
 
+static const struct dev_pm_ops sdxi_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(sdxi_suspend, sdxi_resume)
+};
+
 static struct pci_driver sdxi_driver = {
 	.name = "sdxi",
 	.id_table = sdxi_id_table,
 	.probe = sdxi_pci_probe,
 	.remove = sdxi_pci_remove,
 	.sriov_configure = pci_sriov_configure_simple,
+	.driver.pm = pm_sleep_ptr(&sdxi_pm_ops),
 };
 
 MODULE_IMPORT_NS("SDXI");
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 93b4eb80358c..ce0959bbed90 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -146,6 +146,12 @@ struct sdxi_dev {
 	bool online;
 	struct rw_semaphore state_lock;	/* online state and user operations */
 
+	struct mutex pm_lock;		/* suspend and resume serialization */
+	bool pm_suspended;
+	bool pm_fn_was_active;
+	u64 pm_ctl0;
+	u64 pm_ctl2;
+
 	const struct sdxi_bus_ops *bus_ops;
 };
 
@@ -202,6 +208,8 @@ void sdxi_unregister(struct device *dev);
 bool sdxi_dev_in_error(const struct sdxi_dev *sdxi);
 void sdxi_dev_force_quiesce(struct sdxi_dev *sdxi);
 void sdxi_dev_fail(struct sdxi_dev *sdxi);
+int sdxi_suspend(struct device *dev);
+int sdxi_resume(struct device *dev);
 int sdxi_chardev_init(void);
 void sdxi_chardev_exit(void);
 int sdxi_chardev_register(struct sdxi_dev *sdxi);
-- 
2.56.1

