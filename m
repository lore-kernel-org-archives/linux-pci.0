Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120077;
	b=sHTSBafM7J3tUO8YWnwOHBFw7om4ENLQof41lANy1F0MV21m/L3nIB70FlyBRconl6zo
	 gi2KxSRbcZE8LcdpIObR5LUgOBxb18HS5rKcO42utGhg6Sv0udUoABSs3usBTXLD8LYgG
	 GWSYau4jqpm+zPcwVPp0arjh96AxNlOWS0BFCyUV5kyKHrIPujtzvayNE6+LU84HayUhI
	 sJ86IJ0RotRTDg/c+LsPQ3BN7WQ63NTTskUG3cv6dSoLuMa8lH7EhZXWnSU6ieb90hKGW
	 btERytmatXQcm9N1J1S9LqFqcgWw+dMMixz2z6A/C4gHP/JSq+6QJlmOX+4ZP6yYiZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120077;
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
	bh=mnbIfjQqSoXuZ3G9I8kQSMVGDXbrQbtInOIXXoEJVb4=;
	b=qCr1Q4FiBLw+Dbt63litcykCsE4H4mSWbtOyg5c7Nsfmr+tFcANb35SKqAd9tTl6t6Sj
	 Fsl87FddTSdyc7qvIGlyOWc7wRJjY2O9bhSBICNcHitDO+mriRmA6hCgtzc5D0qZErClq
	 e21tuOGgrsKDsTqyJZIHIzSu0QRX8CRVrKRvFSVYiKwLqGy/DF4jVNhzgNXZMHOvZRBn9
	 uq4U2EeNijznrIyTHa0oiwSi4e2fNzXImoG2FG95ozQqpoMALJ2PR5uiQ30hfM2Jrtj4n
	 zZl3F03ru6WtgmMwEV5E1KrghTB9Iws0AlTsjUfAnWgFFdrucvZFOQvmWRK8zxgA3Yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kQuSCueq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD0606A337;
	Thu, 19 Nov 2026 20:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30BD0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kQuSCueq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOOJk4afHStv/Rosnm5wRar/er/6qQpsKpCzbcPdcQYET6SXMDoZElHxVd6vpIEz1R4Ma/O2lo+8meYs+SgJzo2fQCQDKgwrZOJKL+Af0IopVWtp8mlZldBR91q6cUxBSq4GdgdDFkF9Nd2OBlL3OukdZM4OEWoG+z1izMGv7XzD3i1D6CtMZSc9JtdS7qXRFioFf5HfE45b6Lph53ln1II7ksEqIxBM0gLORyOZYR/mctgPvfsT+dycdadtVqXvDCWbROevl5ddgdjfOWm+QoKzfBdfv6kUq8RoPaDrPYjaNC92EBNlgTzPUq81noqbsDYUDRvoIUVpY/31Rcl4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnbIfjQqSoXuZ3G9I8kQSMVGDXbrQbtInOIXXoEJVb4=;
 b=SXyNjUjeHeawKtNxFrQVFWN3LFoICT830wovCnJRLS8bSeK/nDNJABcrjungHxTw1Dhka3cCLgSfX2RH1wwzIeKsW/JCnFbFFLZM5mUGIAbuH2DB6v+KefBauzogh34umt31J8e8QS4+4Xcrn6zfS8RgetDf7ZWGNVoT9LgAWLK50/3j5efaR1D/ZTnhmgLiRrnk1Rs6rjdLDk35UrbAbrzl0msp8M9tFHE79fN3vC5LpnRTslh4SICZ5BMlrARSHz7sL9EB6o3qyNTlnv1gY+UjRoq+nigHbeqD2W80U058aQQtWfitvFgr2Q8zZMrjDk1+5Y29oltienN/EYgXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnbIfjQqSoXuZ3G9I8kQSMVGDXbrQbtInOIXXoEJVb4=;
 b=kQuSCueqFipkS39748eGg7s+9FZ+O1o7eYMkewjEGGd6vsqwXjCZP7am6pLTUUi4ajhTVe9F0ra8hZMDbpDuTHjv/CdijBzsYojJrNbdL3ZZpQduyBuPHaNVeL9KMTYH7FrXzS90phNvsbPCE2pIv68MKBg24VMse2wUOTR0hFU=
Received: from CH0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:610:cc::33)
 by BN7PPF49208036B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:27:52 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::a6) by CH0PR03CA0088.outlook.office365.com
 (2603:10b6:610:cc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:27:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:27:52 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:27:51 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 21/44] dmaengine: sdxi: implement AKey management ioctls
Date: Thu, 19 Nov 2026 14:22:57 -0600
Message-ID: <20261119202321.1734355-22-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|BN7PPF49208036B:EE_
X-MS-Office365-Filtering-Correlation-Id: 8253c584-f291-4bb5-901e-08df467b965c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|7416014|376014|22082099003|18002099003|261009223027099003|261021133027099003|261022115727099003|11063799006|261022105027099003|261026140227099003|261021123027099003|5023799004|56012099006|261028144727099003|10067099003|261102123227099003|261026130827099003|261021121427099003|261022113327099003|261026135527099003|261022075727099003|261026121527099003|261021135927099003|261021130227099003;
X-Microsoft-Antispam-Message-Info:
	0u3kP6wFs/ktt3DyPmQzEmheSW8dqxLmA9iWFA4+Sw32KisifSLjciU15Dmgfh2deUmKBJYgSOXwZ6hrUE4DNmJLWl0Ebs9bOMdW+DWWwPRoMNP9qSoNPRpEgQKshaJL/y629+ElXF9jWESlBLJlEPdlmCr5ytmc4/53IGksKXf1SukP1//F5RLA6VEeuZDMlkpAZIRD7t2CV9wYgyAUae2T+1f9nhjK3C+hCHstggSd8AKmK6DXoO60e52oz/riuzLh1qZgxha7aABlh5F4sQ4yh4mSKLAMZe0w08ozg2OB44+mSDx03rBb3MwjuK1jjozhhwtYn+fvyaG1780d8jrh97J5IcDLT1yPziK+2+ignhrjfCAg9aQl3Jn+TCmsKHPpk+SPOKjX4Kt8kzxihEPRdm2LbfxYTOjQZeB1XQDre067ocadpbRt7uBAGsug2TTHuuAcPrJBdCyTFI6SSCUZgmNCZ3zgP4ZIesSJQLXCxKtTcP2gqPaBA01gt9qhkUakAnie86xRlo7FXET1naEy43LvihotyyFwThdtGmtch+A554zcDEsGD6QlnApAYmLYyqtJz84dQftw4F6ENm4WQoV6f9K5m02Q60eGdIKxBPsy0uvdjyk07cUU2kyfl40mW0Xcf2LwDq91sth8diN6P4xROxMbiaJc2/F4onjGDg0vZvXu3NwqO8oqxzyyLUInQgTDLir5FH+bLIv/ng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(376014)(22082099003)(18002099003)(261009223027099003)(261021133027099003)(261022115727099003)(11063799006)(261022105027099003)(261026140227099003)(261021123027099003)(5023799004)(56012099006)(261028144727099003)(10067099003)(261102123227099003)(261026130827099003)(261021121427099003)(261022113327099003)(261026135527099003)(261022075727099003)(261026121527099003)(261021135927099003)(261021130227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lK6+T5KfsLotr/f30OoLsV2+EkYFgbPvDCl4y2aoUWxaw/kWGq00XZuVr17DDYkzvYN+IQqcStUdzOXWu++9vvHplJAGJ9FVyLOCVE6ApqGE8nzEgKnTDVF47F7iCdhDgfS7iD5cSd9CLObAtN+7xs7UKvkU5OVmPrvEtcNdv0EGKK06mp9guoLZQbo6x3qYHIcZC/qb0G7T5HLyD87PXEkGnUZRRpcgxfwyhHvEeE+8zAXcgJc4ZtThaMPI9EXoAJmHRCHPmtRErtqyygVge+R1T9Y4UA23AdIEjXcSzkc6MQN28QiXetxKrSHEoLTGsuf858ixI5h/jUeag322+sGbdCGcNiBd7Yiyekp9lr0RekYz6GELIXGnTm+4N/b3caZKN4xxt5vogvlVgXjz+Ob5xhmiLuy4DdzyjCEoXteuLnV6kifiGd0a7N3akuXF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:27:52.6638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8253c584-f291-4bb5-901e-08df467b965c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B

Implement context-scoped AKey bitmap, read, and write operations. For
security reasons, we constraint caller's requests to local
non-privileged PASID and validate interrupt entries against the bound
eventfd vector.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/ioctl.c |   9 +-
 drivers/dma/sdxi/keys.c  | 234 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/keys.h  |   4 +
 3 files changed, 243 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index 4f4b900d2542..f0b298b92430 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -98,7 +98,8 @@ static int sdxi_ioctl_get_uapi_info(struct file *file, struct sdxi_file *sf,
 			SDXI_UAPI_CAP_DEV_ATTR_MGMT |
 			SDXI_UAPI_CAP_RKEY_MGMT |
 			SDXI_UAPI_CAP_CXT_CREATE |
-			SDXI_UAPI_CAP_CXT_EVENTFD,
+			SDXI_UAPI_CAP_CXT_EVENTFD |
+			SDXI_UAPI_CAP_AKEY_MGMT,
 		},
 	};
 
@@ -581,11 +582,11 @@ static const struct sdxi_ioctl_desc sdxi_ioctls[] = {
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_PUBLIC_DEVICE),
 	SDXI_IOCTL_DEF(0x09, SDXI_CXT_EVENTFD, sdxi_ioctl_cxt_eventfd,
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
-	SDXI_IOCTL_DEF(0x0a, SDXI_GET_AKEY_LIST, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x0a, SDXI_GET_AKEY_LIST, sdxi_ioctl_get_akey_list,
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
-	SDXI_IOCTL_DEF(0x0b, SDXI_GET_AKEYS, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x0b, SDXI_GET_AKEYS, sdxi_ioctl_get_akeys,
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
-	SDXI_IOCTL_DEF(0x0c, SDXI_SET_AKEYS, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x0c, SDXI_SET_AKEYS, sdxi_ioctl_set_akeys,
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
 	SDXI_IOCTL_DEF(0x0d, SDXI_ADMIN_DISC, sdxi_ioctl_unsupported,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_PUBLIC_DEVICE),
diff --git a/drivers/dma/sdxi/keys.c b/drivers/dma/sdxi/keys.c
index 75a2855ed13d..0d570daefd34 100644
--- a/drivers/dma/sdxi/keys.c
+++ b/drivers/dma/sdxi/keys.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/capability.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
@@ -14,7 +15,9 @@
 #include <uapi/linux/sdxi.h>
 
 #include "admin.h"
+#include "context.h"
 #include "hw.h"
+#include "intr.h"
 #include "ioctl.h"
 #include "keys.h"
 #include "mmio.h"
@@ -163,6 +166,87 @@ static void sdxi_rkey_store(struct sdxi_rkey_ent *destination,
 	WRITE_ONCE(destination->intr_num, source->intr_num);
 }
 
+static int sdxi_akey_validate(const struct sdxi_akey_ent *entry)
+{
+	u16 intr_num = le16_to_cpu(entry->intr_num);
+	u32 pasid = le32_to_cpu(entry->pasid);
+
+	if (intr_num & BIT(15))
+		return -EINVAL;
+	if (pasid & ~(SDXI_AKEY_ENT_PASID | SDXI_AKEY_ENT_PR |
+		      SDXI_AKEY_ENT_PH))
+		return -EINVAL;
+	if (memchr_inv(entry->rsvd_0, 0, sizeof(entry->rsvd_0)) ||
+	    memchr_inv(entry->rsvd_1, 0, sizeof(entry->rsvd_1)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sdxi_akey_validate_user(const struct sdxi_cxt *cxt,
+				   const struct sdxi_akey_ent *entry)
+{
+	u16 intr_num = le16_to_cpu(entry->intr_num);
+	u32 pasid = le32_to_cpu(entry->pasid);
+
+	if (!(intr_num & SDXI_AKEY_ENT_VL)) {
+		if (intr_num || entry->tgt_sfunc || pasid || entry->stag ||
+		    entry->rkey)
+			return -EINVAL;
+		return 0;
+	}
+
+	if (entry->tgt_sfunc || !(intr_num & SDXI_AKEY_ENT_PV) ||
+	    intr_num & SDXI_AKEY_ENT_STE)
+		return -EPERM;
+	if (FIELD_GET(SDXI_AKEY_ENT_PASID, pasid) != cxt->pasid ||
+	    pasid & (SDXI_AKEY_ENT_PR | SDXI_AKEY_ENT_PH))
+		return -EPERM;
+	if (entry->stag || entry->rkey)
+		return -EPERM;
+	if (!(intr_num & SDXI_AKEY_ENT_IV) &&
+	    FIELD_GET(SDXI_AKEY_ENT_INTR_NUM, intr_num))
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool sdxi_akey_driver_owned(const struct sdxi_cxt *cxt, u32 index)
+{
+	u16 intr_akey = READ_ONCE(cxt->intr_akey);
+
+	return index < 2 || (intr_akey && index == intr_akey);
+}
+
+static int sdxi_akey_validate_interrupt(const struct sdxi_cxt *cxt,
+					const struct sdxi_akey_ent *entry)
+{
+	u16 intr_num = le16_to_cpu(entry->intr_num);
+
+	if (!(intr_num & SDXI_AKEY_ENT_IV))
+		return 0;
+	if (!sdxi_cxt_has_intr_fd(cxt))
+		return -ENOTCONN;
+	if (FIELD_GET(SDXI_AKEY_ENT_INTR_NUM, intr_num) != cxt->intr_vector)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void sdxi_akey_store(struct sdxi_akey_ent *destination,
+			    const struct sdxi_akey_ent *source)
+{
+	struct sdxi_akey_ent entry = *source;
+	u16 intr_num = le16_to_cpu(source->intr_num);
+
+	entry.intr_num = cpu_to_le16(intr_num & ~SDXI_AKEY_ENT_VL);
+	WRITE_ONCE(destination->intr_num, 0);
+	dma_wmb();
+	memcpy(destination, &entry, sizeof(entry));
+	dma_wmb();
+	WRITE_ONCE(destination->intr_num, source->intr_num);
+}
+
 int sdxi_keys_init(struct sdxi_dev *sdxi, u64 cap1)
 {
 	size_t table_size;
@@ -327,3 +411,153 @@ int sdxi_ioctl_set_rkeys(struct file *file, struct sdxi_file *sf, void *data)
 	mutex_unlock(&sdxi->rkey_lock);
 	return ret;
 }
+
+int sdxi_ioctl_get_akey_list(struct file *file, struct sdxi_file *sf,
+			     void *data)
+{
+	struct sdxi_key_list_args *args = data;
+	struct sdxi_cxt *cxt = sf->cxt;
+	int ret;
+
+	ret = sdxi_key_args_check(args->argsz, sizeof(*args), args->flags,
+				  &args->rsvd0, 1);
+	if (ret)
+		return ret;
+	if (!cxt || sdxi_cxt_is_fatal(cxt))
+		return -ENODEV;
+
+	mutex_lock(&cxt->akey_lock);
+	if (!cxt->akey_table) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+	ret = sdxi_key_list_fill(args, cxt->akey_table,
+				 ARRAY_SIZE(cxt->akey_table->entry),
+				 sizeof(cxt->akey_table->entry[0]));
+out_unlock:
+	mutex_unlock(&cxt->akey_lock);
+	return ret;
+}
+
+int sdxi_ioctl_get_akeys(struct file *file, struct sdxi_file *sf, void *data)
+{
+	struct sdxi_get_keys_args *args = data;
+	struct sdxi_cxt *cxt = sf->cxt;
+	u32 entries;
+	u32 i;
+	int ret;
+
+	ret = sdxi_key_args_check(args->argsz, sizeof(*args), args->flags,
+				  &args->rsvd0, 1);
+	if (ret)
+		return ret;
+	if (!cxt || sdxi_cxt_is_fatal(cxt))
+		return -ENODEV;
+
+	entries = ARRAY_SIZE(cxt->akey_table->entry);
+	if (args->nkeys > entries)
+		return -EINVAL;
+	ret = sdxi_key_check_indices(args->entries, args->nkeys, entries,
+				     NULL, NULL);
+	if (ret)
+		return ret;
+
+	args->argsz = sizeof(*args);
+	mutex_lock(&cxt->akey_lock);
+	if (!cxt->akey_table) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+	for (i = 0; i < args->nkeys; i++)
+		memcpy(args->entries[i].data,
+		       &cxt->akey_table->entry[args->entries[i].index],
+		       sizeof(args->entries[i].data));
+	ret = 0;
+out_unlock:
+	mutex_unlock(&cxt->akey_lock);
+	return ret;
+}
+
+int sdxi_ioctl_set_akeys(struct file *file, struct sdxi_file *sf, void *data)
+{
+	struct sdxi_set_keys_args *args = data;
+	struct sdxi_cxt *cxt = sf->cxt;
+	u32 entries;
+	u16 first;
+	u16 last;
+	u32 i;
+	int ret;
+
+	ret = sdxi_key_args_check(args->argsz, sizeof(*args), args->flags,
+				  args->rsvd0, ARRAY_SIZE(args->rsvd0));
+	if (ret)
+		return ret;
+
+	args->argsz = sizeof(*args);
+	sdxi_set_keys_init(args);
+
+	if (!cxt || sdxi_cxt_is_fatal(cxt))
+		return -ENODEV;
+	entries = ARRAY_SIZE(cxt->akey_table->entry);
+	if (!args->nkeys) {
+		args->commit_state = SDXI_KEY_COMMIT_ALL;
+		return 0;
+	}
+	if (args->nkeys > entries)
+		return -EINVAL;
+
+	ret = sdxi_key_check_indices(args->entries, args->nkeys, entries,
+				     &first, &last);
+	if (ret)
+		return ret;
+
+	mutex_lock(&cxt->akey_lock);
+	if (!cxt->akey_table) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	for (i = 0; i < args->nkeys; i++) {
+		struct sdxi_akey_ent entry;
+
+		if (sdxi_akey_driver_owned(cxt, args->entries[i].index)) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
+		memcpy(&entry, args->entries[i].data, sizeof(entry));
+		ret = sdxi_akey_validate(&entry);
+		if (ret)
+			goto out_unlock;
+		if (!capable(CAP_SYS_ADMIN)) {
+			ret = sdxi_akey_validate_user(cxt, &entry);
+			if (ret)
+				goto out_unlock;
+		}
+		ret = sdxi_akey_validate_interrupt(cxt, &entry);
+		if (ret)
+			goto out_unlock;
+	}
+
+	for (i = 0; i < args->nkeys; i++) {
+		struct sdxi_akey_ent entry;
+
+		memcpy(&entry, args->entries[i].data, sizeof(entry));
+		sdxi_akey_store(&cxt->akey_table->entry[args->entries[i].index],
+				&entry);
+	}
+	dma_wmb();
+
+	ret = sdxi_adm_akey_update_sync(cxt->sdxi, cxt->id, cxt->id,
+					first, last,
+					sdxi_set_keys_timeout(args), NULL);
+	if (ret) {
+		args->commit_state = SDXI_KEY_COMMIT_PARTIAL;
+		goto out_unlock;
+	}
+
+	args->commit_state = SDXI_KEY_COMMIT_ALL;
+out_unlock:
+	mutex_unlock(&cxt->akey_lock);
+	return ret;
+}
diff --git a/drivers/dma/sdxi/keys.h b/drivers/dma/sdxi/keys.h
index fed5c20a2cfc..6e36527b610a 100644
--- a/drivers/dma/sdxi/keys.h
+++ b/drivers/dma/sdxi/keys.h
@@ -20,5 +20,9 @@ int sdxi_ioctl_get_rkey_list(struct file *file, struct sdxi_file *sf,
 			     void *data);
 int sdxi_ioctl_get_rkeys(struct file *file, struct sdxi_file *sf, void *data);
 int sdxi_ioctl_set_rkeys(struct file *file, struct sdxi_file *sf, void *data);
+int sdxi_ioctl_get_akey_list(struct file *file, struct sdxi_file *sf,
+			     void *data);
+int sdxi_ioctl_get_akeys(struct file *file, struct sdxi_file *sf, void *data);
+int sdxi_ioctl_set_akeys(struct file *file, struct sdxi_file *sf, void *data);
 
 #endif /* DMA_SDXI_KEYS_H */
-- 
2.56.1

