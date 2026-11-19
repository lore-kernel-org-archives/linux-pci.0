Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120005;
	b=1u9HkUnBHYH7ifZGqmN/MOe+TcroGeEJEvY+y+mfmuY0Zyy74d8hWp1eldTDGcAVfwVn
	 kjtl/iLKPVJLQlxM+RHY27+uwHteyoIBD9cuM1XUG1JX0KtoKCOjkTAEZcn5/Y3gTlPa5
	 yrnSfLrqsBm5zjvGGJuGALxRBr8cM1XZQQPzoVdQ3RP4yIwldUGSM2HBxllPIC3CxlmAQ
	 /4hpALWQRoPEkE/iYjRsp8GxGgTG3fmuNxPHkZiA8Da1y8rC53eNhWRdl8Pe0giQ+o4sp
	 KJAlACI5SUJB6LwXLfSqEaEeRF4O+Xkvz3mhaHomtgpplDIb7D61c8cJ0RP8mGXHzcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120005;
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
	bh=OcKABhUk16+YpOqSgc0fs8zJBBQFjR6R6E1OztGn/jU=;
	b=kExxVQie02JM9lZZCZZDMWB0XPbqftPDEX8Wesfxmd4KP7MwFZ1xEOB8P2Llep5V9q6K
	 NJqXIjpX0ck3ygyn7nfWRG5w6UUboHr6tp1YkJgnIdlgwTA1969VlVg6LzZOo4LTVtPty
	 2guhh2YclFMVvgDRLZUtw7ee1Vo6VZud+VgHDtf5z2FxRgavrQLnuAMQuVQ1lF2QXYgIv
	 bDG2jaxzf48WUHd1Tcpe8iDjWXl+5oUVNXNu3eZ4jORxD41YPfMHE1ZkbmFf0d+qp7jAj
	 Pbw5bjcOHtSLc5RzdVStbclqb7IzajfIX/a5CYCIpwt2vENceOPdckCrWo0FlrH5qAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mzNFYjfC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.32
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306D606A324;
	Thu, 19 Nov 2026 20:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3306D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mzNFYjfC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo4WU9kKzSyewIU8AbpLH5iaTU8qRPHK7ht4SF/DW5rC932jW9HWTl9FA0fqP00Rr8MtN5XMgRgHPn6+j9aX5/WQE1j3v1ACdYGGvOh8UgCQU3O1wnnfBfCzUewqPYwtx0cOh8Nl/5KfCo4xxqbWPCszlWRIHBrUfye+ntNIF6fW+k+2NauERzFH4NX+8LQwQDbQYi8KmGhpz3CEJQH+G39fhfdaPK6U1WUZrn9OhixDN9YRjvsjLIfLaSSDsroC4Gs++eEfWZZa9Djyu2EJNgkc9oasg++mU5NIR8JhX5Nm/WQTwFOaocwZ0eO3ImeC38p1HBGFe2QWToMtoJMXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcKABhUk16+YpOqSgc0fs8zJBBQFjR6R6E1OztGn/jU=;
 b=uZO/bpnPXDfTXtMbEPfF2KpBtinztHnBaOvFWoi5XBEnwXsranTXDPtHlQtGidwoTwluSpXL0TugdQeO4IRMrsbCKzohbIhYuxGfzfLVTt5Pi1b2nxxtH1jpPU3xt8/3X8U96ymaZLqyWCKZxZGPXPm7l3DYxq3SkzoLFK9rbrA49VlhMJF49CB5tfyjq0QNNLILt6GhquCz7rWOoH/PenFdP7gVW+W6XGcrhz647FLVhUQj/drWVZnIX09GtE/+4XCX4MlSugA7uUKLgmaqj+paeZ/MMkBIV4Nbqtd0l4MwHEo83QH2YTrHs9FaSJ8LqN4w4BdUv2waSZWK30p3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcKABhUk16+YpOqSgc0fs8zJBBQFjR6R6E1OztGn/jU=;
 b=mzNFYjfC6E/idZbebGdu1zvGagDothGO82e4zIIWSVzxXKTGZoBCaSn6ms0qzSbo2bzQM7vr5TPNEJHkv9ts+znrbJ9C1Gtzftq/MVMB7JEvwcIZsQdnLp26kJwUk4MHpFHrivgeE/oZsmRTtC7qSBmSqfWsLxgJ4BWCy/C3nl0=
Received: from DM6PR02CA0131.namprd02.prod.outlook.com (2603:10b6:5:1b4::33)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:26:40 +0000
Received: from DM3PEPF000265B9.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::88) by DM6PR02CA0131.outlook.office365.com
 (2603:10b6:5:1b4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 20:26:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B9.mail.protection.outlook.com (10.167.23.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:26:40 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:26:39 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 16/44] dmaengine: sdxi: register core character devices
Date: Thu, 19 Nov 2026 14:22:52 -0600
Message-ID: <20261119202321.1734355-17-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B9:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ca6d6b-5d51-49f1-c555-08df467b6b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|18002099003|22082099003|6133799003|5023799004|56012099006|11063799006|261026140227099003|261026121527099003|261022075727099003|261009223027099003|10067099003|261102130727099003|261102123227099003|261021121427099003|261021123027099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	0Ui+CSEd2xQn2p1x1noP/7fJH+wbLSc6A3q07hT+L89UuVuPKgg41OcwtMf4c5PoZ/SSn+n1DOEjnM1PhQTHo3suOHQIHXQSx22My9gMuevqJa2160PyVx7fiCKz/Z+nUS3J4XZZGqtTEMkOlb91G9eTxAljgsl+vm3BmoeZ/DB4Uv5FIfbgVJLQff5jx+TXdn0Vd7q2CTHE1WA5pXAiEP9qq90mCpZlAS8Vsyzvk+SFQRXixKIpw9BiHVl5EAgjr41c8e9JG0igXS5BOozJHkkZE35En79Ej1xeUioXi4Kab+h5ft4P9LUExdEfuTY4h/iIfETlbObfOSAGb241mMqmsGrYh2wVjd51Ds6JbHxIl21gW1AYofeoaNAC72/bJ3PAR6VQ1okt71WU3AlnYwjpWpnUpWx+DfwUv3zCUcDFPYgGtyQLcpbglC9VP4ugzJ0pEIincrRx1tDTU0hXc6uRAG6PDoNKMjoy6ubL2xlQhtGvFhdMPw8j7BCJNW9Bgc/GRcR3WZvLyiHXvEtsrXPfJvw9B4LXf+9ng3H4yqNYwkAcokkP2jEx7fVYZw/IwSdSUPo4Yo7l7c7HuFb5C5m0SedQa9/Kev6Th6pxWXWuqqczrgWMt+svdjHI1yxuAV4kEYkHCpW9r50X8EhgtA2o5FaeLkn/KlqTcLMDRt7+7WlCDToiQLGEo6wp4k6ZJhsRwmMUa9k70AkagRIgqw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(6133799003)(5023799004)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261022075727099003)(261009223027099003)(10067099003)(261102130727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yifmUhRAw1oAGciMykJF4JI51KAfoZnFnHxOV+lkjmoTcbgAykDQ3AAG0+BIYTV1oPmQqltBlCFhzbZiNG923CZ6ukF+Ysy1jraJHa4oOHIVZTRFzAlghMikb33sxfKu3hsXx8Gk7olVLL1N8tQZtR1NfUH1h3ssGmhWTgKT7YAF4Eh7XzUrFuOjT6gUVE0kwRyW9v1xHPBz6p5kEJdv8GugElnY5biO5+8v+7UIGNyCfn38SGjdj1UOQklFWgWdux8K+LgRhRWFt+uYxSc8OOmqXRs0Xfqy5tKxZ5fBkzOYL1m3xiSLyZ4Xng2WXgu2SxsDeheF+oOpf8gocugSwO9p/eeFyyOyJc/3dTEZHTa14zjlqKJWorhEB7i0f4c1uELT44OZvQnlQUGf5Fp3juQ1Rn3hHKgREeT7VooWjgOjpWLkGijA/+Co5v8cUA4E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:26:40.2292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ca6d6b-5d51-49f1-c555-08df467b6b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

Create one core-owned SDXI character device per registered function and
bind each open file to process state. Preserve the existing core/PCI
split; functional ioctls and context mappings remain disabled until
their handlers are added later.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Makefile  |   1 +
 drivers/dma/sdxi/context.c |  70 ++++++++++++-----
 drivers/dma/sdxi/context.h |   1 +
 drivers/dma/sdxi/device.c  | 121 +++++++++++++++++++++++++----
 drivers/dma/sdxi/ioctl.c   | 155 +++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/keys.c    |  11 ---
 drivers/dma/sdxi/pci.c     |   1 +
 drivers/dma/sdxi/process.c |  12 ++-
 drivers/dma/sdxi/sdxi.h    |  16 ++++
 9 files changed, 340 insertions(+), 48 deletions(-)
 create mode 100644 drivers/dma/sdxi/ioctl.c

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index a915982e76a7..a9eaf01df4aa 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -9,6 +9,7 @@ sdxi-core-y := \
 	dma.o         \
 	error.o       \
 	intr.o        \
+	ioctl.o       \
 	keys.o        \
 	process.o     \
 	ring.o
diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 2c3b6f5df4b5..a4976f2b5e53 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -75,6 +75,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 	mutex_destroy(&cxt->cleanup_lock);
 	kfree(cxt->ring_state);
 	kfree(cxt);
+	put_device(&sdxi->chardev);
 }
 
 DEFINE_FREE(sdxi_cxt, struct sdxi_cxt *, if (_T) sdxi_free_cxt(_T))
@@ -89,6 +90,7 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 		return NULL;
 
 	cxt->sdxi = sdxi;
+	get_device(&sdxi->chardev);
 	refcount_set(&cxt->refs, 1);
 	mutex_init(&cxt->cleanup_lock);
 	mutex_init(&cxt->akey_lock);
@@ -647,10 +649,9 @@ static int sdxi_cxt_quiesce_locked(struct sdxi_cxt *cxt,
 	return 0;
 }
 
-static void sdxi_cxt_cleanup_workfn(struct work_struct *work)
+static bool sdxi_cxt_cleanup(struct sdxi_cxt *cxt,
+			     struct sdxi_process **process_out)
 {
-	struct sdxi_cxt *cxt = container_of(to_delayed_work(work),
-					     struct sdxi_cxt, cleanup_work);
 	struct sdxi_process *process = NULL;
 	bool force_release = false;
 	bool destroy = false;
@@ -697,6 +698,25 @@ static void sdxi_cxt_cleanup_workfn(struct work_struct *work)
 
 out_unlock:
 	mutex_unlock(&cxt->cleanup_lock);
+	if (!destroy)
+		return false;
+
+	*process_out = process;
+	return true;
+}
+
+static void sdxi_cxt_cleanup_workfn(struct work_struct *work)
+{
+	struct sdxi_cxt *cxt = container_of(to_delayed_work(work),
+					     struct sdxi_cxt, cleanup_work);
+	struct sdxi_process *process = NULL;
+	struct sdxi_dev *sdxi = cxt->sdxi;
+	bool destroy = false;
+
+	down_read(&sdxi->state_lock);
+	if (sdxi->online)
+		destroy = sdxi_cxt_cleanup(cxt, &process);
+	up_read(&sdxi->state_lock);
 
 	if (destroy)
 		sdxi_cxt_finish_release(cxt, process);
@@ -734,13 +754,6 @@ static void sdxi_cxt_force_exit(struct sdxi_cxt *cxt)
 	sdxi_cxt_put(cxt);
 }
 
-static void free_admin_cxt(void *ptr)
-{
-	struct sdxi_dev *sdxi = ptr;
-
-	sdxi_cxt_force_exit(sdxi->admin_cxt);
-}
-
 static int sdxi_cxt_doorbell_offset(const struct sdxi_cxt *cxt,
 				    size_t *offset);
 static int sdxi_cxt_set_kernel_doorbell(struct sdxi_cxt *cxt);
@@ -782,7 +795,18 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	cxt->started = true;
 	sdxi->admin_cxt = no_free_ptr(cxt);
 
-	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
+	return 0;
+}
+
+void sdxi_admin_cxt_exit(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cxt *cxt = sdxi->admin_cxt;
+
+	if (!cxt)
+		return;
+
+	sdxi->admin_cxt = NULL;
+	sdxi_cxt_force_exit(cxt);
 }
 
 /*
@@ -1154,27 +1178,33 @@ void sdxi_cxt_release_user_handle(struct sdxi_cxt *cxt)
 
 int sdxi_cxt_notify_mm_release(struct sdxi_cxt *cxt)
 {
+	struct sdxi_dev *sdxi;
 	int ret = 0;
 
 	if (!cxt)
 		return -EINVAL;
+	sdxi = cxt->sdxi;
 
+	down_read(&sdxi->state_lock);
 	mutex_lock(&cxt->cleanup_lock);
 	cxt->mm_dead = true;
 	if (!cxt->resources_released) {
-		ret = sdxi_cxt_quiesce_locked(cxt, 0, NULL, false);
-		if (ret) {
-			dev_err(cxt->sdxi->dev,
-				"failed to quiesce context %u during mm release: %d; quiescing function\n",
-				cxt->id, ret);
-			sdxi_dev_fail(cxt->sdxi);
-			cxt->started = false;
-			cxt->quiesced = true;
-			cxt->quiesce_cst_flags = 0;
+		if (sdxi->online) {
+			ret = sdxi_cxt_quiesce_locked(cxt, 0, NULL, false);
+			if (ret) {
+				dev_err(cxt->sdxi->dev,
+					"failed to quiesce context %u during mm release: %d; quiescing function\n",
+					cxt->id, ret);
+				sdxi_dev_fail(cxt->sdxi);
+				cxt->started = false;
+				cxt->quiesced = true;
+				cxt->quiesce_cst_flags = 0;
+			}
 		}
 		sdxi_cxt_queue_cleanup_locked(cxt, 0);
 	}
 	mutex_unlock(&cxt->cleanup_lock);
+	up_read(&sdxi->state_lock);
 
 	return ret;
 }
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index bbe83e54b827..03cb5634fa09 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -89,6 +89,7 @@ struct sdxi_cxt {
 };
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
+void sdxi_admin_cxt_exit(struct sdxi_dev *sdxi);
 struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
 struct sdxi_cxt *sdxi_ucxt_new(struct sdxi_dev *sdxi, u32 ring_entries,
 			       u64 ds_ring, u64 write_index, u64 cxt_sts,
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 1587795c0a16..ff5b5d932bc9 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -414,8 +414,10 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	sdxi->L2_table = dmam_alloc_coherent(sdxi->dev,
 					     sizeof(*sdxi->L2_table),
 					     &sdxi->L2_dma, GFP_KERNEL);
-	if (!sdxi->L2_table)
-		return -ENOMEM;
+	if (!sdxi->L2_table) {
+		err = -ENOMEM;
+		goto exit_keys;
+	}
 	memset(sdxi->L2_table, 0, sizeof(*sdxi->L2_table));
 
 	cxt_l2 = FIELD_PREP(SDXI_MMIO_CXT_L2_PTR, sdxi->L2_dma >> ilog2(SZ_4K));
@@ -429,11 +431,11 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	 */
 	err = sdxi_admin_cxt_init(sdxi);
 	if (err)
-		return err;
+		goto exit_keys;
 
 	err = sdxi_error_init(sdxi);
 	if (err)
-		return err;
+		goto exit_admin;
 
 	/*
 	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
@@ -449,8 +451,15 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 		sdxi_error_exit(sdxi);
 		if (sdxi_dev_stop(sdxi))
 			sdxi_dev_force_quiesce(sdxi);
+		goto exit_admin;
 	}
 
+	return 0;
+
+exit_admin:
+	sdxi_admin_cxt_exit(sdxi);
+exit_keys:
+	sdxi_keys_exit(sdxi);
 	return err;
 }
 
@@ -469,38 +478,100 @@ static int sdxi_device_init(struct sdxi_dev *sdxi)
 	if (err)
 		return err;
 
-	sdxi_dma_register(sdxi);
+	err = sdxi_dma_register(sdxi);
+	if (err) {
+		sdxi_error_exit(sdxi);
+		if (sdxi_dev_stop(sdxi))
+			sdxi_dev_force_quiesce(sdxi);
+		sdxi_admin_cxt_exit(sdxi);
+		sdxi_keys_exit(sdxi);
+		return err;
+	}
+
 	return 0;
 }
 
+static void sdxi_device_quiesce(struct sdxi_dev *sdxi)
+{
+	sdxi_error_exit(sdxi);
+	if (sdxi_dev_stop(sdxi))
+		sdxi_dev_force_quiesce(sdxi);
+}
+
+/* Hardware must already be quiesced before this releases DMA-visible state. */
+static void sdxi_device_exit(struct sdxi_dev *sdxi)
+{
+	sdxi_client_cxts_exit(sdxi);
+	sdxi_admin_cxt_exit(sdxi);
+	sdxi_keys_exit(sdxi);
+	xa_destroy(&sdxi->client_cxts);
+	ida_destroy(&sdxi->vectors);
+}
+
+static void sdxi_dev_release(struct device *chardev)
+{
+	struct sdxi_dev *sdxi = container_of(chardev, struct sdxi_dev,
+					     chardev);
+
+	put_device(sdxi->dev);
+	kfree(sdxi);
+}
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 {
 	struct sdxi_dev *sdxi;
 	int err;
 
-	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
+	sdxi = kzalloc_obj(*sdxi, GFP_KERNEL);
 	if (!sdxi)
 		return -ENOMEM;
 
-	sdxi->dev = dev;
+	sdxi->dev = get_device(dev);
 	sdxi->bus_ops = ops;
+	device_initialize(&sdxi->chardev);
+	sdxi->chardev.release = sdxi_dev_release;
+	init_rwsem(&sdxi->state_lock);
 	ida_init(&sdxi->vectors);
 	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	mutex_init(&sdxi->cxt_lock);
 	mutex_init(&sdxi->admin_lock);
 	mutex_init(&sdxi->rkey_lock);
 	sdxi->error_irq = -1;
+	sdxi->minor = -1;
 	dev_set_drvdata(dev, sdxi);
 
 	err = sdxi->bus_ops->init(sdxi);
 	if (err)
-		return err;
+		goto destroy_allocators;
 
 	err = sdxi_fn_prepare(sdxi);
 	if (err)
-		return err;
+		goto destroy_allocators;
+
+	err = sdxi_device_init(sdxi);
+	if (err)
+		goto destroy_allocators;
+
+	down_write(&sdxi->state_lock);
+	err = sdxi_chardev_register(sdxi);
+	if (!err)
+		sdxi->online = true;
+	up_write(&sdxi->state_lock);
+	if (err) {
+		sdxi_device_quiesce(sdxi);
+		sdxi_device_exit(sdxi);
+		goto put_chardev;
+	}
+
+	return 0;
 
-	return sdxi_device_init(sdxi);
+destroy_allocators:
+	xa_destroy(&sdxi->client_cxts);
+	ida_destroy(&sdxi->vectors);
+put_chardev:
+	dev_set_drvdata(dev, NULL);
+	put_device(&sdxi->chardev);
+	return err;
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
 
@@ -508,16 +579,34 @@ void sdxi_unregister(struct device *dev)
 {
 	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
 
-	sdxi_error_exit(sdxi);
-	if (sdxi_dev_stop(sdxi))
-		sdxi_dev_force_quiesce(sdxi);
-	sdxi_client_cxts_exit(sdxi);
-	sdxi_keys_exit(sdxi);
-	ida_destroy(&sdxi->vectors);
+	if (!sdxi)
+		return;
+
+	down_write(&sdxi->state_lock);
+	sdxi_chardev_unregister(sdxi);
+	sdxi_device_quiesce(sdxi);
+	sdxi->online = false;
+	up_write(&sdxi->state_lock);
+
+	sdxi_device_exit(sdxi);
+	dev_set_drvdata(dev, NULL);
+	put_device(&sdxi->chardev);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
 
+static int __init sdxi_core_init(void)
+{
+	return sdxi_chardev_init();
+}
+
+static void __exit sdxi_core_exit(void)
+{
+	sdxi_chardev_exit();
+}
+
 MODULE_AUTHOR("Wei Huang");
 MODULE_AUTHOR("Nathan Lynch");
 MODULE_DESCRIPTION("SDXI core");
 MODULE_LICENSE("GPL");
+module_init(sdxi_core_init);
+module_exit(sdxi_core_exit);
diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
new file mode 100644
index 000000000000..17661fca54a7
--- /dev/null
+++ b/drivers/dma/sdxi/ioctl.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI character device support.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "ioctl.h"
+#include "process.h"
+#include "sdxi.h"
+
+#define SDXI_MAX_MINORS	256
+
+static dev_t sdxi_devt;
+static struct class *sdxi_class;
+static DEFINE_IDA(sdxi_minor_ida);
+
+static long sdxi_ioctl_unsupported(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+static int sdxi_open(struct inode *inode, struct file *file)
+{
+	struct sdxi_dev *sdxi;
+	struct sdxi_process *process;
+	struct sdxi_file *sf;
+
+	if (!inode->i_cdev)
+		return -ENODEV;
+
+	sdxi = container_of(inode->i_cdev, struct sdxi_dev, cdev);
+	down_read(&sdxi->state_lock);
+	if (!sdxi->online) {
+		up_read(&sdxi->state_lock);
+		return -ENODEV;
+	}
+	process = sdxi_process_create(sdxi);
+	up_read(&sdxi->state_lock);
+	if (IS_ERR(process))
+		return PTR_ERR(process);
+
+	sf = kzalloc_obj(*sf, GFP_KERNEL);
+	if (!sf) {
+		sdxi_process_put(process);
+		return -ENOMEM;
+	}
+
+	sf->type = SDXI_FILE_DEVICE;
+	sf->process = process;
+	file->private_data = sf;
+	return 0;
+}
+
+static int sdxi_release(struct inode *inode, struct file *file)
+{
+	struct sdxi_file *sf = file->private_data;
+
+	if (!sf)
+		return 0;
+
+	sdxi_process_put(sf->process);
+	kfree(sf);
+	file->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations sdxi_fops = {
+	.owner = THIS_MODULE,
+	.open = sdxi_open,
+	.release = sdxi_release,
+	.unlocked_ioctl = sdxi_ioctl_unsupported,
+	.compat_ioctl = sdxi_ioctl_unsupported,
+};
+
+int sdxi_chardev_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&sdxi_devt, 0, SDXI_MAX_MINORS, "sdxi");
+	if (ret)
+		return ret;
+
+	sdxi_class = class_create("sdxi");
+	if (IS_ERR(sdxi_class)) {
+		ret = PTR_ERR(sdxi_class);
+		sdxi_class = NULL;
+		unregister_chrdev_region(sdxi_devt, SDXI_MAX_MINORS);
+		return ret;
+	}
+
+	return 0;
+}
+
+void sdxi_chardev_exit(void)
+{
+	class_destroy(sdxi_class);
+	sdxi_class = NULL;
+	unregister_chrdev_region(sdxi_devt, SDXI_MAX_MINORS);
+	ida_destroy(&sdxi_minor_ida);
+}
+
+int sdxi_chardev_register(struct sdxi_dev *sdxi)
+{
+	dev_t devt;
+	int minor;
+	int ret;
+
+	minor = ida_alloc_max(&sdxi_minor_ida, SDXI_MAX_MINORS - 1,
+			      GFP_KERNEL);
+	if (minor < 0)
+		return minor;
+
+	sdxi->minor = minor;
+	devt = MKDEV(MAJOR(sdxi_devt), minor);
+	sdxi->chardev.devt = devt;
+	sdxi->chardev.class = sdxi_class;
+	sdxi->chardev.parent = sdxi->dev;
+	dev_set_drvdata(&sdxi->chardev, sdxi);
+	ret = dev_set_name(&sdxi->chardev, "sdxi%d", minor);
+	if (ret)
+		goto free_minor;
+
+	cdev_init(&sdxi->cdev, &sdxi_fops);
+	sdxi->cdev.owner = THIS_MODULE;
+
+	ret = cdev_device_add(&sdxi->cdev, &sdxi->chardev);
+	if (ret)
+		goto free_minor;
+
+	return 0;
+
+free_minor:
+	sdxi->minor = -1;
+	ida_free(&sdxi_minor_ida, minor);
+	return ret;
+}
+
+void sdxi_chardev_unregister(struct sdxi_dev *sdxi)
+{
+	if (sdxi->minor < 0)
+		return;
+
+	cdev_device_del(&sdxi->cdev, &sdxi->chardev);
+	ida_free(&sdxi_minor_ida, sdxi->minor);
+	sdxi->minor = -1;
+}
diff --git a/drivers/dma/sdxi/keys.c b/drivers/dma/sdxi/keys.c
index 2e25a9b806e6..c2f1db0d1594 100644
--- a/drivers/dma/sdxi/keys.c
+++ b/drivers/dma/sdxi/keys.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/device/devres.h>
 #include <linux/dma-mapping.h>
 #include <linux/log2.h>
 #include <linux/sizes.h>
@@ -17,16 +16,10 @@
 #include "mmio.h"
 #include "sdxi.h"
 
-static void sdxi_keys_release(void *data)
-{
-	sdxi_keys_exit(data);
-}
-
 int sdxi_keys_init(struct sdxi_dev *sdxi, u64 cap1)
 {
 	size_t table_size;
 	u64 reg;
-	int ret;
 
 	sdxi->rkey_cap = FIELD_GET(SDXI_MMIO_CAP1_RKEY_CAP, cap1);
 	if (!sdxi->rkey_cap)
@@ -49,10 +42,6 @@ int sdxi_keys_init(struct sdxi_dev *sdxi, u64 cap1)
 	      SDXI_MMIO_RKEY_EN;
 	sdxi_write64(sdxi, SDXI_MMIO_RKEY, reg);
 
-	ret = devm_add_action_or_reset(sdxi->dev, sdxi_keys_release, sdxi);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 7b477b7bec55..eca55c8d65f8 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -130,6 +130,7 @@ static void sdxi_pci_force_quiesce(struct sdxi_dev *sdxi)
 }
 
 static const struct sdxi_bus_ops sdxi_pci_ops = {
+	.owner = THIS_MODULE,
 	.init = sdxi_pci_init,
 	.reset = sdxi_pci_reset,
 	.get_irq = sdxi_pci_get_irq,
diff --git a/drivers/dma/sdxi/process.c b/drivers/dma/sdxi/process.c
index bc0552b554ba..b64f2307e4e3 100644
--- a/drivers/dma/sdxi/process.c
+++ b/drivers/dma/sdxi/process.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/iommu.h>
+#include <linux/module.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
@@ -100,6 +101,7 @@ void sdxi_process_unbind_sva(struct sdxi_process *process,
 
 static void sdxi_process_free(struct sdxi_process *process)
 {
+	struct sdxi_dev *sdxi = process->sdxi;
 	struct iommu_sva *sva;
 	u32 pasid;
 
@@ -111,6 +113,8 @@ static void sdxi_process_free(struct sdxi_process *process)
 	put_task_struct(process->lead_thread);
 	mmdrop(process->mm);
 	kfree(process);
+	module_put(sdxi->bus_ops->owner);
+	put_device(&sdxi->chardev);
 }
 
 void sdxi_process_get(struct sdxi_process *process)
@@ -167,10 +171,16 @@ struct sdxi_process *sdxi_process_create(struct sdxi_dev *sdxi)
 
 	if (!task->mm)
 		return ERR_PTR(-EINVAL);
+	if (!try_module_get(sdxi->bus_ops->owner))
+		return ERR_PTR(-ENODEV);
+	get_device(&sdxi->chardev);
 
 	process = kzalloc_obj(*process, GFP_KERNEL);
-	if (!process)
+	if (!process) {
+		put_device(&sdxi->chardev);
+		module_put(sdxi->bus_ops->owner);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	refcount_set(&process->refs, 1);
 	mutex_init(&process->mutex);
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index fa34aaa36c16..98d2baffbbdf 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -9,11 +9,14 @@
 #define DMA_SDXI_H
 
 #include <linux/bug.h>
+#include <linux/cdev.h>
 #include <linux/compiler_types.h>
+#include <linux/device.h>
 #include <linux/dev_printk.h>
 #include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
 
@@ -44,11 +47,14 @@ enum {
 };
 
 struct sdxi_dev;
+struct module;
 
 /**
  * struct sdxi_bus_ops - Bus-specific methods for SDXI devices.
  */
 struct sdxi_bus_ops {
+	/** @owner: Module providing these operations, or NULL if built in. */
+	struct module *owner;
 	/**
 	 * @init: Map control registers and doorbell region, allocate
 	 *        IRQ ranges. Invoked before bus-agnostic SDXI
@@ -117,6 +123,12 @@ struct sdxi_dev {
 
 	bool has_mailbox;
 
+	struct cdev cdev;
+	struct device chardev;
+	int minor;
+	bool online;
+	struct rw_semaphore state_lock;	/* online state and user operations */
+
 	const struct sdxi_bus_ops *bus_ops;
 };
 
@@ -163,6 +175,10 @@ void sdxi_unregister(struct device *dev);
 bool sdxi_dev_in_error(const struct sdxi_dev *sdxi);
 void sdxi_dev_force_quiesce(struct sdxi_dev *sdxi);
 void sdxi_dev_fail(struct sdxi_dev *sdxi);
+int sdxi_chardev_init(void);
+void sdxi_chardev_exit(void);
+int sdxi_chardev_register(struct sdxi_dev *sdxi);
+void sdxi_chardev_unregister(struct sdxi_dev *sdxi);
 
 static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
 {
-- 
2.56.1

