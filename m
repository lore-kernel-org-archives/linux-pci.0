Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119851;
	b=MGH4HMWZoS5lPOrd9Vfuz1rLNSBuaSdnnPQurjOOGjxUDCrzXxvRsndbpgH+TcKjDssp
	 MbydMynz+U8H19TlrMY/eG+jaYAQDKRS2IE2EocIwUtM0A2GQ1axuwVHSzU/54iWk3+6C
	 MfUhjMiC90ZxatdqmSbeCSuSN4kZabFUpTn8Ubus6JJ4dpGog+3LAa6GYk1coEcX/Yxg7
	 wC8n+1SsENWl2TVHoHef7YQ1AQirBRkJPGwSXTOlIDL6mnftphTbTtZH5MJPYF8+wRckF
	 mrdcJw2bJAXA7YnqvdX7qmgCKeRT39QS+4fbp7AgHnU92cJYc7mitw4slXEuwzrBtBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119851;
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
	bh=75/4jWmdLHekImBoq6Doy89bUxZyOluPUea/UiRvww0=;
	b=2veKLrB4gVm2B4h1/oZwLlcP4HcHUSSeoqygtNASBKx5KDb3/KCgIN35NKuo2pck5pP2
	 uTM/7+ZzFu4sClUV8uuF5qj1EzpdiVU63HBEjnB/3IYES53443hSgatFa74/7SNUbkiXo
	 RwT+paW3WRJwKxdf0kT1Ze2dG5ore818WYfH70r85zlJWK2O/N9Dexgv2MjmW8kvSRKXZ
	 6iEwJxVYyB4fOwFdvRAU5VSYEXvFTsc8P9MJcxq6ZIzDYxZQXA21b5ljKLY5tzCLjWiOD
	 H24c3OWnRxZHbT+dG7x0pJXXGmVLL/OrAQ02rf+xhbN0XM37Mytoicibrx7gFClI76Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q+eFQ7Zb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.55
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DB606A325;
	Thu, 19 Nov 2026 20:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A8DB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q+eFQ7Zb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJS6syHV/xKtSbfmKFPR3Y7Qw2mXpzhl2vKYYCwTRmJVPgGkT5sFrtGzdTq5B55bDLNfZWMKKyBBT/PvUlrc6cTPQDfbul4zEgclcos+w/MV3/t+l8nZCMe937qEfDNjRErRMpvPJ72HcNYenT0wQhFb1UM6xnjmZYcllQ2Uo00xMCfDJO3UvnQdKQbnz94hCEU6Rsd9PMXIejuPzMD2kO2/nuHRJ+E/SVC4j170JJqzMYhEGoqzH7TKeEKnCK7ASw+1X5gCbgkjE2Vjy232qbo8WenQKSBs5r8rokHsFUGi9VAzBHPU+p+j1vuzthLZBZ52VPkw1c+M0GoL3OAtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75/4jWmdLHekImBoq6Doy89bUxZyOluPUea/UiRvww0=;
 b=qDKeBcCanG6k8Hl15ZyZ5ecQpo+YX2E3p5CJoMvqW58ctAVeKvagdC3o2csiTZVTviY+skdFiIwqnuml645EF5ih8Rwgc1baotqcXAXqfBM0iphUt/7DKX3aq5zCCiHyModUfLY4gWkUB1G9yv5zWZZ0AkWmpMFaJvrqGBpti7AvNSHaHM+4GVeIHXgBNpZxRjTlJ5aat0JuFZ3IpSY9PSibA+RLnwKVB1JsEBkC4E5UyhooVbxzbBSCvZ9li+fZ4fRyzWEXCMoK4IVf5YETHk5vQ/UrwNsg9SYGJIFpvwTw6yiP+275UXUeQtSA9jPChP3F0iPx9CVXIvTU9to+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75/4jWmdLHekImBoq6Doy89bUxZyOluPUea/UiRvww0=;
 b=q+eFQ7Zbd/2ZGFtIn0l/3MXU0ODlveGDfMR5Scbw0whDpmNGF7ID+p9d9//RaqoZ+M57QgKxKhKqMGhlFN0oGjdqCo7BFD4u5xrMtq/ewQwdJopJITtGTktVwjF7Ydan7CblNULppS79Sp5lUHZOUokKMUyJBfjntyyyFAtwp34=
Received: from DM6PR08CA0059.namprd08.prod.outlook.com (2603:10b6:5:1e0::33)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:24:06 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::46) by DM6PR08CA0059.outlook.office365.com
 (2603:10b6:5:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:24:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:24:06 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:24:02 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 03/44] dmaengine: sdxi: define SDXI hardware layouts
Date: Thu, 19 Nov 2026 14:22:39 -0600
Message-ID: <20261119202321.1734355-4-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8991db-7d4a-432a-1a79-08df467b0f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|22082099003|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|261026121527099003|261021121427099003|10067099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	PhwZ1ekTOTDcMXVP1wFrGocYsLZe8k2CqoqJamvq81IUDEiJSzjPW9LDwIr26K3nuUhL/m/uiJf0BijqmXZXmMeblCBn3M7bqHlVcaigD9Mk0rRdy5ijzZOVSwLcApJEJ02vnkeR7+2ArLGOLmH0sTSS7axYioajPSV0VCKdld9Bhcv4NTSW52qotupAaq6DXzmTN9lhUlSYLNbNMJuInPoyC4ghX1n6MyrhQLQ6WnOAJH3nZ/IVmwiOFWVRUPwDloHpHk155MJ5IAOSos7cGN2mjJ0TNV1JNBvhm+DLuqdYFednBKrkv1negqOc+vsNuMvZ9avsdMM/3Zyeh8pLOyVHJrS2j7A9JRil96RYWyLgT7yw97fVaMyhGYnFapTWU/xsF8iPVOaF0c4zttdXRnG/Z33tBMraoeDgk0HToceb2A58eAAnFshIP9cBIP80funHdarpzP+VletrX3t+r14CX4esBMrA+hHZzXCsRd6GuKbdSEkOXZQOwsUBAS9BnnBwveQom+3Q1BK5VH4gl0AsoiTjh826QXqpyQCgUDtZqxbildkm8X/msnjbqanTb1EvQ+JXkyTHNF/kNpM3IiokbjFhhH5h+u8kcpDglwwjw+Rb0nvCd9HwRiCDaf4NSIr9kDIyHkhGpOp/gg74otExU79rpajN1YoAD8DpdgV9DvxK/4pU8p39CIsfVucC6eqV52UmnyiZOEFfouohAA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(10067099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xSbt/Jh0B18dBXRYcldUwP9wRJ+iIWBlY60GB88Gadl2WJknc0ew4otDzWeAsUf93ZzFaFoXyyuOWpWJ/IYPiA74eC94engHgYaE3Ah4u6Vz2L0hkuLrkASSlbfqLjeIQMPLx58LXqqDAxHTBmYsoFnUNZWAgc82o/zUaJ0bgYCCmkPITooim+bqqMkRDIYPFg0xGRnzfzTFYdhbGmbZmdLnDKvkWumGWAcXkllmhi3SzTR0ararIZWdVIvR9JaUNjPc839h8GJtcCKhcZsw8RPwJamnXENtBA1Vsf55yV9Ptu4S4gIGswy/K4fBR/y/jM9KG0GUrzD89KXhEDLwI/9CXvtOouw9TcEggENg4WFbQdj7X0OOeLd19oqYJGOpUXvVvNSSWj7sz5T1eROHJyGgA2yaiWgs3je8eCqZ/GExiQn94MNvLLlfIJ6H0C/G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:24:06.1937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8991db-7d4a-432a-1a79-08df467b0f5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

Add the RKey and error-log entry formats, AKey fields, operation-group
masks, and AdminGrp descriptor layouts needed by the native SDXI
interface. Preserve the existing type names, alignment, and completion
definitions. No functional change is introduced.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/hw.h | 80 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index 71579eb3ac26..6f294f9b6637 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -45,6 +45,13 @@ struct sdxi_cxt_L1_ent {
 #define SDXI_CXT_L1_ENT_PASID          GENMASK(19, 0)
 #define SDXI_CXT_L1_ENT_MAX_BUFFER     GENMASK(23, 20)
 	__le32 opb_000_enb;
+#define SDXI_OPB_000_ADMIN             BIT(2)
+#define SDXI_OPB_000_ATOMIC_FULL       BIT(3)
+#define SDXI_OPB_000_INTR              BIT(4)
+#define SDXI_OPB_000_ATOMIC_MIN        BIT(5)
+#define SDXI_OPB_000_ATOMIC            (SDXI_OPB_000_ATOMIC_FULL | \
+					SDXI_OPB_000_ATOMIC_MIN)
+#define SDXI_OPB_000_DISC_MASK         GENMASK(31, 6)
 	__u8 rsvd_0[8];
 } __packed __aligned(32);
 static_assert(sizeof(struct sdxi_cxt_L1_ent) == 32);
@@ -100,9 +107,14 @@ struct sdxi_akey_ent {
 	__le16 intr_num;
 #define SDXI_AKEY_ENT_VL BIT(0)
 #define SDXI_AKEY_ENT_IV BIT(1)
+#define SDXI_AKEY_ENT_PV BIT(2)
+#define SDXI_AKEY_ENT_STE BIT(3)
 #define SDXI_AKEY_ENT_INTR_NUM GENMASK(14, 4)
 	__le16 tgt_sfunc;
 	__le32 pasid;
+#define SDXI_AKEY_ENT_PASID GENMASK(19, 0)
+#define SDXI_AKEY_ENT_PR    BIT(29)
+#define SDXI_AKEY_ENT_PH    GENMASK(31, 30)
 	__le16 stag;
 	__u8   rsvd_0[2];
 	__le16 rkey;
@@ -110,6 +122,37 @@ struct sdxi_akey_ent {
 } __packed __aligned(16);
 static_assert(sizeof(struct sdxi_akey_ent) == 16);
 
+/* SDXI 1.0 Table 3-8: RKey Table Entry (RKEY_ENT) */
+struct sdxi_rkey_ent {
+	__le16 intr_num;
+#define SDXI_RKEY_ENT_VL BIT(0)
+#define SDXI_RKEY_ENT_IV BIT(1)
+#define SDXI_RKEY_ENT_PV BIT(2)
+#define SDXI_RKEY_ENT_STE BIT(3)
+#define SDXI_RKEY_ENT_INTR_NUM GENMASK(14, 4)
+	__le16 req_sfunc;
+	__le32 pasid;
+#define SDXI_RKEY_ENT_PASID GENMASK(19, 0)
+#define SDXI_RKEY_ENT_PR    BIT(29)
+#define SDXI_RKEY_ENT_PH    GENMASK(31, 30)
+	__le16 stag;
+	__u8 rsvd_0[6];
+} __packed __aligned(16);
+static_assert(sizeof(struct sdxi_rkey_ent) == 16);
+
+/* SDXI 1.0 Table 3-9: Error Log Header Entry (ERRLOG_HD_ENT) */
+struct sdxi_errlog_hd_ent {
+	__le32 opcode;
+	__le16 misc0;
+	__le16 cxt_num;
+	__le64 dsc_index;
+	__u8 rsvd_0[28];
+	__le16 err_class;
+	__u8 rsvd_1[2];
+	__le32 vendor[4];
+} __packed __aligned(64);
+static_assert(sizeof(struct sdxi_errlog_hd_ent) == 64);
+
 /* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
 struct sdxi_cst_blk {
 	__le64 signal;
@@ -141,7 +184,9 @@ struct sdxi_desc {
 #define SDXI_DSC_VL  BIT(0)
 #define SDXI_DSC_SE  BIT(1)
 #define SDXI_DSC_FE  BIT(2)
+#define SDXI_DSC_CH  BIT(3)
 #define SDXI_DSC_CSR BIT(4)
+#define SDXI_DSC_RB  BIT(5)
 #define SDXI_DSC_SUBTYPE GENMASK(15, 8)
 #define SDXI_DSC_TYPE    GENMASK(26, 16)
 
@@ -227,6 +272,38 @@ struct sdxi_desc {
 /* For use with sync.cflags */
 #define SDXI_DSC_SYNC_FLT GENMASK(2, 0)
 
+		/* SDXI 1.0 Table 6-19: DSC_AKEY_UPD Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_akey_upd, akey_upd,
+				__u8 rsvd_0;
+				__u8 vflags;
+				__le16 vf_num;
+				__le16 cxt_start;
+				__le16 cxt_end;
+				__le16 akey_start;
+				__le16 akey_end;
+				__u8 rsvd_1[40];
+		);
+
+		/* SDXI 1.0 Table 6-23: DSC_RKEY_UPD Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_rkey_upd, rkey_upd,
+				__u8 rsvd_0;
+				__u8 vflags;
+				__le16 vf_num;
+				__u8 rsvd_1[4];
+				__le16 rkey_start;
+				__le16 rkey_end;
+				__u8 rsvd_2[40];
+		);
+
+		/* SDXI 1.1 Table 6-27: DSC_DISC Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_disc, disc,
+				__le16 index_start;
+				__le16 index_end;
+				__u8 rsvd_0[8];
+				__le64 addr;
+				__u8 rsvd_1[32];
+		);
+
 #undef define_sdxi_dsc
 	};
 } __packed __aligned(64);
@@ -249,9 +326,12 @@ enum sdxi_dsc_subtype {
 
 	/* Administrative */
 	SDXI_DSC_OP_SUBTYPE_CXT_UPD      = 0x01,
+	SDXI_DSC_OP_SUBTYPE_AKEY_UPD     = 0x02,
 	SDXI_DSC_OP_SUBTYPE_CXT_START_NM = 0x03,
 	SDXI_DSC_OP_SUBTYPE_CXT_STOP     = 0x04,
 	SDXI_DSC_OP_SUBTYPE_SYNC         = 0x06,
+	SDXI_DSC_OP_SUBTYPE_RKEY_UPD     = 0x07,
+	SDXI_DSC_OP_SUBTYPE_DISC         = 0x09,
 };
 
 #endif /* DMA_SDXI_HW_H */
-- 
2.56.1

