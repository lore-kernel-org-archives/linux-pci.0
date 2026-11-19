Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120215;
	b=zxqUsLLc0tUkWdrSybANgEeNZvZH6zaLgmIxcEKZoMriq0OR+XfYW4HvumqWS0F3JymV
	 sIaGcOI9tiY/dsEsbDhQj9qb+0rlJdEQsjq6lKwHbCyxDHzVPWOc7/8YsKsBJNkTI0v3w
	 xony/GGFEi7BH3A1yOij+lmxTWbRuRVDEkZ0eTLOzMdmCu9vBE55/qCvqpzc/8kBk/nLN
	 8FSc3qxLeaJqTrHYMHQ2iR/LMXm+rX/pupugpvH+1eyfWuXXu+1R/jT02YwBqFN3RPP/E
	 qXCb+yN/PZuBNonbQ7fv9JzepGwkr6gDWgdLWvOgMVwYdjPwxlMwXeVkogUWQMFac0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120215;
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
	bh=YqG7TSsSrZu/WKkLKfQU8ZSEtIvjDn8sgDY5s1tqQlw=;
	b=ybMf2+jTil43t2CgI9Q1EgUaiP98vhjhujwwRX37wF+AIpmUNBc7ETEjK9APHZFm15LL
	 +50MPFv6Wic/J2/YVxAbzC8uBlTS6dgV8dh45s9q09L+VgVWbcMC3PPLmpgsaenmfwGCE
	 uZ1m6H/m7LdGu9UBs1zAMUJpEFJQlrSGAjSK/qK8vS8NaUUh8P9qvEUMiIVDsFQFbEUIZ
	 xXhP6dzckqMIeg+tJvelJsDOrSCehX0nGhgcW+rEqsMPmcgIdXZ0Sm5y6WG5bd/PjOQll
	 yF174rzOOCrfCMnp8F9uf0dKQbQ4mmx1tdXwYPG07KwFk608q8HSJrxhc8EpUejzkew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kFLeCws2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.28
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FDF606A325;
	Thu, 19 Nov 2026 20:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FDF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kFLeCws2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvbCwwZypD4qmxwqfuOflbLYtE07jybsYY5V5xOvpj+mYgNKD5gMB/iW85a+u8RJcdKz92aepm7QzhKq8bEhVCVL0VnTA/XG1bRhLPLknOaugq+0RulNQrnkP96zW43hDdBBTJRa5mEnXN5WD8gJTGKgW64K+JUZEUdpSW9lEKLanCdHGTJld5qH3sK8w2OGxOFutMbr57Sk2lWaI4ZZDp9klcQy0Kz4jY/HQmiYB9STLmpcZEFgtHodWpgsotnCHZdz//sblt6rQfpLUa285u3KxxIjJFtsTmmHrbjRAe+hFPMQiWXnXYutBUVJmYYEs4E9G0M7llIPBBc5C1Ea5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqG7TSsSrZu/WKkLKfQU8ZSEtIvjDn8sgDY5s1tqQlw=;
 b=grzA1KaHtr26zxNRfbj6FFFgXv3VBjmKeVN5CxrwIbN8GIDh/Boc+KhNfVBmkHqLF6fxQPkhJcdpusx5yEWWQ21nocVx8joBLm3rEu9v6L73fTAaHWuxNPw4S75JOK3rKFa5k+VYpnAqohccmcHcwpUTOvcSyUv8XhqtjBPKOtYgz5151nBDvU2VeDIZb7q615du4bhMgMtC0zGJvuLwAmw8F91CTkJMgPvOlcvCaCaml/adCienc4ZncE3/HK1Yg6ebCDZlmoLV1aY/2jTFzxf8TLmx7Qx6KXfk5bbaKERAo1/tCt1vBgcBil2ZamsU1UI0RCfdGsrbbUESFasPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqG7TSsSrZu/WKkLKfQU8ZSEtIvjDn8sgDY5s1tqQlw=;
 b=kFLeCws2XsyeOWafGHF/4khgLRApajAkyi2+lE1pEqmkejgFb9YVjhxTm3mcaTY3km6FndLmxHKE86YoUZIGeBjbpCEbBxG7Z4KpgX/oLI7StbR/zOTULuowLpJsRbmEQKGyHNcCdh22o7Fn5ilfFYH/yRzijCG7taenMXIkJiA=
Received: from CYXPR02CA0018.namprd02.prod.outlook.com (2603:10b6:930:cf::11)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:30:09 +0000
Received: from CY5PEPF00000E82.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::5a) by CYXPR02CA0018.outlook.office365.com
 (2603:10b6:930:cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:30:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E82.mail.protection.outlook.com (10.167.247.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:30:09 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:30:06 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 32/44] dmaengine: sdxi: amd: execute QoS vendor operations
Date: Thu, 19 Nov 2026 14:23:08 -0600
Message-ID: <20261119202321.1734355-33-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E82:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8b119b-0ba9-4d07-f019-08df467be7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|82310400026|1800799024|261022105027099003|261102123227099003|261021123027099003|10067099003|11063799006|261026140227099003|56012099006|261021121427099003|261026121527099003|261028144727099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RT3Aa2DEyPxxL3eVjAuDnMdkymXlR4a5x5D0k3w/CmKMZKwfoI58IQq4yWX25jwMPb526Eweqsy8mh7rYADC6IyH1gzbyzCTyzfIxkpVpQ0RcXRoqm0J7ijhND1CKY10QtNL6TkqGbzupk61ojXclhVCCjhVR5Iu+ome5XGs5Wl5GclmjoWygclbCwDbVZNyetcpOAFyGTPDmO1OOx358vO0yA6VPEGnWBbnMHjDRnLRGHpDoAR9KMwnc0i5BEo25hJaCzJeYCYcT7OivVhkxjYVGjQ6pTT7UX1VnFSDai/JBihRaKUQSSKuZkcumRhPbaSSMGX8c/itCnnFcYm2tZKx8NiBu3RlFJOxDhwNWFOXAUfNzyIXW6pblb5r4HZTXrs9ZwzHHEoyqpjtCdenEU2yM+PzcL3yueZ7GhvHoJcad7K4Q3Qi/bjJpAy8T2st9rublmAwu23iXI0ceCLTryPZTDoF2eI76KskB3RkE4JGgnYI4/eDVRCqv75ZMufUy0Jr3t74aotvj6Fu0by9Wjl68kZFEJ/+ZLeNZ0lLu5sjlLsIQBmruYExAaLteZ4NaSLF8K+QCFy//fDHfLBRg6pqDsJH02knPVetlqLDTpclo6LW/vN7hnv0XNEHZc9x9TDdh5bCLQ3xksWDw8CoPO7JLBqGoHv8INzi9xG7heyfz8Gb3+uCHho4YLLUP2xz7kBYvY0g0o5ODVqDucg1Vg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(82310400026)(1800799024)(261022105027099003)(261102123227099003)(261021123027099003)(10067099003)(11063799006)(261026140227099003)(56012099006)(261021121427099003)(261026121527099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dI9ecRuvgE5bBouBJmeHqXYjW3cChzvL6Msh46/2y1hzWrDvkgJGyoZV9ikWTxDCsTKVifmurypBRGmAFxuJ6XhaZG6D8AOTCeZUZ8fqSSRaYND3HyxQOFv+h+tlpZgMQomldcOolLpBx1GGSwWdDHvJtHUMJ09adMCSwN8zSfHEXdAG9eQ6otiWmaVLmVslCSMspBpdmn+qIVSs8O7sQ6SxVMlctaJUy1qSF4iO7UZmxyB27JNJI7Y99S82eCxqwtBcA9qgOTQPTjeGgQ+Klk+bqSG+yUnNyHz2v1Hsg7TyfYIBkHuFFOwWEtcUDJbQDEtOlkbpXjT4cPfHsfVc/S42GvjmI/MmV4FCZyktP5IyeiEdWo8uRsGQh/7lTBhOSo+L4aCkv+gfvIjBbM9UqPo8emOaIQbIxj8A93MFyi6Y7bPtA3388jkB9ehdgz4q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:30:09.5125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8b119b-0ba9-4d07-f019-08df467be7ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E82.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624

Add execution code for AMD QoS capability, device update, pool update,
function update and telemetry operations.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/amd/qos.c | 321 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 320 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/amd/qos.c b/drivers/dma/sdxi/amd/qos.c
index 746e4c8b11e7..7d5dc9b6b32c 100644
--- a/drivers/dma/sdxi/amd/qos.c
+++ b/drivers/dma/sdxi/amd/qos.c
@@ -27,7 +27,13 @@
 #define SDXI_AMD_QOS_TEL_FIXED_BYTES		48U
 #define SDXI_AMD_QOS_TEL_HDR_BYTES		48U
 #define SDXI_AMD_QOS_POOL_REPORT_ENTRY_BYTES	132U
-#define SDXI_AMD_QOS_MAX_TEL_BYTES		SZ_1M
+
+/* One PF entry plus all 10-bit VF-number entries. */
+#define SDXI_AMD_QOS_POOL_REPORT_MAX_FUNCTIONS	1025U
+#define SDXI_AMD_QOS_POOL_REPORT_MAX_BYTES				\
+	(SDXI_AMD_QOS_TEL_HDR_BYTES +					\
+	 SDXI_AMD_QOS_POOL_REPORT_MAX_FUNCTIONS *			\
+	 SDXI_AMD_QOS_POOL_REPORT_ENTRY_BYTES)
 
 struct sdxi_amd_qos_cap_info {
 	u16 feature_flags;
@@ -764,3 +770,316 @@ static int sdxi_amd_qos_prevalidate_tel(struct sdxi_dev *sdxi,
 		return 0;
 	}
 }
+
+static size_t sdxi_amd_qos_tel_bytes_active_pools(u16 max_pools)
+{
+	return SDXI_AMD_QOS_TEL_HDR_BYTES + (size_t)(max_pools + 7U) / 8U;
+}
+
+static int sdxi_amd_qos_pool_report_bytes(u16 assigned_functions,
+					  size_t *bytes)
+{
+	if (assigned_functions > SDXI_AMD_QOS_POOL_REPORT_MAX_FUNCTIONS)
+		return -E2BIG;
+
+	*bytes = SDXI_AMD_QOS_TEL_HDR_BYTES +
+		 (size_t)assigned_functions *
+		 SDXI_AMD_QOS_POOL_REPORT_ENTRY_BYTES;
+	return 0;
+}
+
+static int sdxi_amd_qos_exec(struct sdxi_dev *sdxi, u16 opcode_type,
+			     struct sdxi_admin_vendor_args *args,
+			     unsigned int timeout_ms)
+{
+	struct sdxi_cxt *adm = sdxi->admin_cxt;
+	struct sdxi_amd_qos_cap_info cap;
+	struct sdxi_desc desc;
+	void *buf = NULL;
+	dma_addr_t buf_dma = 0;
+	size_t dma_size = 0;
+	size_t required = 0;
+	void __user *ubuf = NULL;
+	u32 output_available = args->out_size;
+	bool pool_report = false;
+	int err;
+
+	err = sdxi_amd_qos_admin_ready(adm);
+	if (err)
+		return err;
+
+	switch (args->op) {
+	case SDXI_AMD_QOS_ADMIN_OP_CAP:
+		err = sdxi_amd_qos_copy_input(args, NULL, 0);
+		if (err)
+			return err;
+
+		required = SDXI_AMD_QOS_CAP_BYTES;
+		err = sdxi_amd_qos_prepare_output(args, required, &ubuf);
+		if (err)
+			return err;
+
+		sdxi_amd_qos_desc_init(&desc, opcode_type,
+				       SDXI_AMD_QOS_DSC_SUBTYPE_CAP);
+		break;
+	case SDXI_AMD_QOS_ADMIN_OP_DEVUPD: {
+		struct sdxi_amd_qos_devupd_req req;
+		struct sdxi_amd_qos_dev_info info;
+
+		err = sdxi_amd_qos_copy_input(args, &req, sizeof(req));
+		if (err)
+			return err;
+		err = sdxi_amd_qos_get_cap_info(sdxi, adm, opcode_type,
+						timeout_ms, &cap);
+		if (err)
+			return err;
+		err = sdxi_amd_qos_get_dev_info(sdxi, adm, opcode_type,
+						timeout_ms, &info);
+		if (err)
+			return err;
+		err = sdxi_amd_qos_validate_devupd_req(req.device_maxbw,
+						       cap.device_maxbw_cap,
+						       info.total_allocated_bw,
+						       cap.granularity_bw);
+		if (err)
+			return err;
+
+		err = sdxi_amd_qos_require_no_output(args);
+		if (err)
+			return err;
+
+		sdxi_amd_qos_desc_init(&desc, opcode_type,
+				       SDXI_AMD_QOS_DSC_SUBTYPE_DEVUPD);
+		put_unaligned_le32(req.device_maxbw, &desc.generic.operation[4]);
+
+		return sdxi_adm_submit_desc(adm, &desc, timeout_ms,
+					    &args->cst_flags);
+	}
+	case SDXI_AMD_QOS_ADMIN_OP_POOLUPD: {
+		struct sdxi_amd_qos_poolupd_req req;
+		u32 pool_ctl;
+
+		err = sdxi_amd_qos_copy_input(args, &req, sizeof(req));
+		if (err)
+			return err;
+		err = sdxi_amd_qos_get_cap_info(sdxi, adm, opcode_type,
+						timeout_ms, &cap);
+		if (err)
+			return err;
+		err = sdxi_amd_qos_prevalidate_poolupd(sdxi, adm, opcode_type,
+						       timeout_ms, &cap, &req);
+		if (err)
+			return err;
+
+		err = sdxi_amd_qos_require_no_output(args);
+		if (err)
+			return err;
+
+		pool_ctl = FIELD_PREP(GENMASK(11, 0), req.pool_num) |
+			   FIELD_PREP(GENMASK(13, 12), req.pool_operation);
+
+		sdxi_amd_qos_desc_init(&desc, opcode_type,
+				       SDXI_AMD_QOS_DSC_SUBTYPE_POOLUPD);
+		put_unaligned_le32(pool_ctl, &desc.generic.operation[0]);
+		put_unaligned_le32(req.pool_maxbw, &desc.generic.operation[4]);
+		put_unaligned_le32(req.pool_minbw, &desc.generic.operation[8]);
+
+		return sdxi_adm_submit_desc(adm, &desc, timeout_ms,
+					    &args->cst_flags);
+	}
+	case SDXI_AMD_QOS_ADMIN_OP_FNUPD: {
+		struct sdxi_amd_qos_fnupd_req req;
+		u32 target_scope;
+		u32 cxt_range;
+
+		err = sdxi_amd_qos_copy_input(args, &req, sizeof(req));
+		if (err)
+			return err;
+		err = sdxi_amd_qos_get_cap_info(sdxi, adm, opcode_type,
+						timeout_ms, &cap);
+		if (err)
+			return err;
+		err = sdxi_amd_qos_prevalidate_fnupd(sdxi, adm, opcode_type,
+						     timeout_ms, &cap, &req);
+		if (err)
+			return err;
+
+		err = sdxi_amd_qos_target_scope(req.pool_num, req.flags,
+						req.vf_num, &target_scope);
+		if (err)
+			return err;
+
+		err = sdxi_amd_qos_require_no_output(args);
+		if (err)
+			return err;
+
+		cxt_range = FIELD_PREP(GENMASK(15, 0), req.cxt_start) |
+			    ((u32)req.cxt_end << 16);
+
+		sdxi_amd_qos_desc_init(&desc, opcode_type,
+				       SDXI_AMD_QOS_DSC_SUBTYPE_FNUPD);
+		put_unaligned_le32(target_scope, &desc.generic.operation[0]);
+		put_unaligned_le32(cxt_range, &desc.generic.operation[4]);
+
+		return sdxi_adm_submit_desc(adm, &desc, timeout_ms,
+					    &args->cst_flags);
+	}
+	case SDXI_AMD_QOS_ADMIN_OP_TEL: {
+		struct sdxi_amd_qos_tel_req req;
+		u32 target_scope;
+		u64 query_selector;
+		u16 assigned_functions;
+
+		err = sdxi_amd_qos_copy_input(args, &req, sizeof(req));
+		if (err)
+			return err;
+		err = sdxi_amd_qos_get_cap_info(sdxi, adm, opcode_type,
+						timeout_ms, &cap);
+		if (err)
+			return err;
+		err = sdxi_amd_qos_prevalidate_tel(sdxi, adm, opcode_type,
+						   timeout_ms, &cap, &req);
+		if (err)
+			return err;
+
+		switch (req.query_type) {
+		case SDXI_AMD_QOS_TEL_QTYPE_DEVICE:
+			target_scope = 0;
+			query_selector = sdxi_amd_qos_query_selector(0,
+								     req.query_type);
+			required = SDXI_AMD_QOS_TEL_FIXED_BYTES;
+			break;
+		case SDXI_AMD_QOS_TEL_QTYPE_POOL_CONFIG:
+			target_scope = FIELD_PREP(GENMASK(11, 0),
+						  req.pool_num);
+			query_selector = sdxi_amd_qos_query_selector(0,
+								     req.query_type);
+			required = SDXI_AMD_QOS_TEL_FIXED_BYTES;
+			break;
+		case SDXI_AMD_QOS_TEL_QTYPE_POOL_ASSIGN:
+			err = sdxi_amd_qos_target_scope(0, req.flags,
+							req.vf_num,
+							&target_scope);
+			if (err)
+				return err;
+			if (!(req.flags & SDXI_AMD_QOS_TARGET_F_CXT))
+				req.cxt_num = 0;
+			query_selector = sdxi_amd_qos_query_selector(req.cxt_num,
+								     req.query_type);
+			required = SDXI_AMD_QOS_TEL_FIXED_BYTES;
+			break;
+		case SDXI_AMD_QOS_TEL_QTYPE_ACTIVE_POOLS:
+			target_scope = 0;
+			query_selector = sdxi_amd_qos_query_selector(0,
+								     req.query_type);
+			required =
+				sdxi_amd_qos_tel_bytes_active_pools(cap.max_pools);
+			break;
+		case SDXI_AMD_QOS_TEL_QTYPE_POOL_REPORT:
+			target_scope = FIELD_PREP(GENMASK(11, 0),
+						  req.pool_num);
+			query_selector = sdxi_amd_qos_query_selector(0,
+								     req.query_type);
+			err = sdxi_amd_qos_get_assigned_functions(sdxi, adm,
+								  opcode_type,
+								  req.pool_num,
+								  timeout_ms,
+								  &assigned_functions);
+			if (err)
+				return err;
+
+			err = sdxi_amd_qos_pool_report_bytes(assigned_functions,
+							     &required);
+			if (err)
+				return err;
+			dma_size = SDXI_AMD_QOS_POOL_REPORT_MAX_BYTES;
+			pool_report = true;
+			break;
+		case SDXI_AMD_QOS_TEL_QTYPE_POOL_VARIANCE:
+			target_scope = FIELD_PREP(GENMASK(11, 0),
+						  req.pool_num);
+			query_selector = sdxi_amd_qos_query_selector(0,
+								     req.query_type);
+			required = SDXI_AMD_QOS_TEL_FIXED_BYTES;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		err = sdxi_amd_qos_prepare_output(args, required, &ubuf);
+		if (err)
+			return err;
+
+		sdxi_amd_qos_desc_init(&desc, opcode_type,
+				       SDXI_AMD_QOS_DSC_SUBTYPE_TEL);
+		put_unaligned_le32(target_scope, &desc.generic.operation[0]);
+		put_unaligned_le64(query_selector, &desc.generic.operation[4]);
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (!dma_size)
+		dma_size = required;
+
+	buf = dma_alloc_coherent(sdxi_to_dev(sdxi), dma_size, &buf_dma,
+				 GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, 0, dma_size);
+
+	if (!IS_ALIGNED(buf_dma, SZ_4K)) {
+		err = -EIO;
+		goto out_free_submit;
+	}
+
+	switch (args->op) {
+	case SDXI_AMD_QOS_ADMIN_OP_CAP:
+		put_unaligned_le64(buf_dma, &desc.generic.operation[4]);
+		break;
+	case SDXI_AMD_QOS_ADMIN_OP_TEL:
+		put_unaligned_le64(buf_dma, &desc.generic.operation[12]);
+		break;
+	default:
+		err = -EINVAL;
+		goto out_free_submit;
+	}
+
+	err = sdxi_adm_submit_desc(adm, &desc, timeout_ms, &args->cst_flags);
+	if (err)
+		goto out_free_submit;
+
+	dma_rmb();
+	if (pool_report) {
+		size_t actual_required;
+		u32 data_length = get_unaligned_le32(buf + 20);
+		u16 assigned_functions = get_unaligned_le16(buf + 16);
+
+		err = sdxi_amd_qos_pool_report_bytes(assigned_functions,
+						     &actual_required);
+		if (err || data_length !=
+		    actual_required - SDXI_AMD_QOS_TEL_HDR_BYTES) {
+			err = -EIO;
+			goto out_free_submit;
+		}
+
+		args->out_size = actual_required;
+		if (output_available < actual_required) {
+			err = -ENOSPC;
+			goto out_free_submit;
+		}
+		if (!access_ok(ubuf, actual_required)) {
+			err = -EFAULT;
+			goto out_free_submit;
+		}
+		required = actual_required;
+	}
+	if (copy_to_user(ubuf, buf, required))
+		err = -EFAULT;
+
+out_free_submit:
+	dma_free_coherent(sdxi_to_dev(sdxi), dma_size, buf, buf_dma);
+	return err;
+}
-- 
2.56.1

