Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120102;
	b=wRRmco4cIdUkIlZoNzEQXzVQUPG0qupB8V9iBbQx5mruwdFyfiMfOGaBQPnP3sodfK5P
	 xU2lYOhhMq1CLefWZeOCKpqNigU2bhAkR3nhx6SNAJtuZLMGoK3HLK6Tu7n5Nnauxkv60
	 MlKwpm73AsYZeYY1tOt4LfQVayjQ4CIqqyliBJzMIKF6Oqp5q32jAjCTyXFmcnK2FdbMG
	 YI+Sp2VfjT4AxnQZOFgpQCVbGbY1iHqGSvhlmY3E/MTNhpqRisW6T23LQy/UYRIzyizur
	 bHELd4FydXH9KjvG7rSLvjrn6AWYUNL0wxX3tyT0R+IbJYoquUqdp+eTfS0NY7slfZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120102;
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
	bh=CHCn69oqYfSoWZXkBF7tUpqypP46zyDMTZc/Nu8AENw=;
	b=1B7zXjfi1b0ii1vkvo8eY9Oqywjq/Tg94pSfagXt69g2BcIwHYKyT/rjZhGWbnCTTtV7
	 a230hLm1LZwk9jl5fL5IwFIGhNzsoQlg61KHilYadhHggxf3gnWRzgsgEoLlAxKFKpSMw
	 gScE9NBRkNEAwsmmx74bteaKDvcr0sbg7gaVhF5OPdRzvH39A9hdrfHH+0bga0tephdRd
	 gZN9LzHVcZyQW3hB0r/9XOpZzCDqe4j4vDTv2aHFGUkl8w9S1NP28wudjSMgd3ZNtcP8p
	 bF5xhqS8z3W+zbwhuHl7Y1zzVdggp6SoBmApRMObX/vTVA5JtVViJd41Rp6sKEIY+lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fr6FFsib;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.54
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184C606A324;
	Thu, 19 Nov 2026 20:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4184C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fr6FFsib
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QStTxTn7HCdMMidPPymhmHtoT7w9NpRPLWjTEZWkwUxF5eSXg6z01aVjQOHTjoCb9/DZYwJjbWS1laorXMoK0XSd+zVYfBvg6TWxL1rN2PD+HHpLAwotrYVyP5p2EFlS1kkmkxHOBHxcpU888foCHG3VO8WYRqkEzjtN2sKczHv6lZNesVUopIxEQc9/NmTXahsL3aLj7UgX4oF/bOmm1DhwKgzeXnkXDzrufinCfl48t70VwCiDbGwVCiT6UoyyYzuCTFiou/o8K7fEoaNxziknlFld2jI3vtuO/Rcni1WP2bsN5zCS+byYBo1axTXEXA5CukfO6VTFc5wo8zPdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHCn69oqYfSoWZXkBF7tUpqypP46zyDMTZc/Nu8AENw=;
 b=YivgI8pS3vVNR2WmZy6QgcWSehCJ3JX0SCthG8m/MrW0f7VHWXMnmLzZf92fRq5386DAQAW6GQEgvnyHqn/e/eBbLRWSAe7PmoCtmcrok4I+FCxMfBOoeN2mfKSSuNJL5Qbfu1yfeSBj+hIb3z50P3KHw7q2MaDVJksgR97n7HfX16cIHrsel+j1ZV/mM5pbLKNBKJFs8RzKffInPPPGp0VE3BsRVbeO+XVcR09RXxl9pHQY0JHuutLXOueNb5ObGFhM5aqaXFkfUzMD2YzO9mHyqlI2OAb9BnL0P3Ncx/rhBE4FV/5EMNzty4pKSD65vYMezZ+h4AUPH6i+f3grtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHCn69oqYfSoWZXkBF7tUpqypP46zyDMTZc/Nu8AENw=;
 b=fr6FFsibCEw5lcbaMyTQUZ69YpWaYbvUKVp39hMpQd8LgaFicv7AbretEqVOo/70IQO/sCoUoVQoNbRlN1EGutukf5L+ZNN+EkVEWmhS2JYgQflFjIXei3loTB6NrGMouY+yRVSHMvUzicO0hHCs2txUvB4hYYw1ZIQq2g9fimI=
Received: from DM6PR02CA0137.namprd02.prod.outlook.com (2603:10b6:5:1b4::39)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 19 Nov
 2026 20:28:12 +0000
Received: from DM3PEPF000265B9.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::92) by DM6PR02CA0137.outlook.office365.com
 (2603:10b6:5:1b4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:28:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B9.mail.protection.outlook.com (10.167.23.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:28:12 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:28:07 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 22/44] dmaengine: sdxi: expose operation-group discovery
Date: Thu, 19 Nov 2026 14:22:58 -0600
Message-ID: <20261119202321.1734355-23-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B9:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 8929dc43-94ee-402b-d018-08df467ba266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|7416014|82310400026|376014|10067099003|56012099006|5023799004|11063799006|261021121427099003|261028144727099003|261026121527099003|261021123027099003|261022105027099003|261022075727099003|261102123227099003|261026140227099003|261009223027099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7cSoWZQsLADgU5okIKhNe4PHA9sp+3RLaJLXrLZKzbw2+umVv1cPRUrhml1i5k+ijnmDL8sl2Pb86eaB8rfI6RipndMIYm17ToMS8EqrKjpgpN/wASqWtgvPfrjAwPWjEfhb9SFJ3r4hbYJIdwRt0uFppn0UsWWJb9g3gDzZFI/Mlf15IUpNWkomvYDkcXfkFenbPbK4ZoyK4Es89RXDVnM0WzdmFsoJhdb/6/hLftrC6JLCVVNWNUsZH+pGYa2yapfjnxkviq1SXBW09w+q90mgVqfHS+J67cSkbPbrIr70izue86kCPEhr3zMAU62aaKvM/kpOxKyJ4r0Z/oq7tvCkFt7rjZ0zMVeNMMfxzhp25C41S+rixlUyv74+QehewzTecPN5z6nYgyaDO0hayebEZ7vn/svjN0bNXtmIx1kq8NRIEbFcAo/Ju2JO+0ulcKoOZEvQtNqZNVpBf116gPs0z/1tIb6ynPEX8Av0AUMV6of3pcS8gu6PHO3yaqc5fPMbAomNViYVtChhDGuGTZBsXM18d/xTIHaeVSEnJJuorNjb78s0rEMjdvoOYaadSnMJgMzQ0D9QRySeMC8/M3rBzJaKI/cePfzfgj7j6kSBdnCTahM5epjSsd24wh/g3GGnTmEafcEPl4qls3pE0Hfd4ry+9Saw7G0YQW34iMPMs+UqHj8wpdPljCvC2rw3znNa85PxZIuojtg1minu4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(7416014)(82310400026)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(261021121427099003)(261028144727099003)(261026121527099003)(261021123027099003)(261022105027099003)(261022075727099003)(261102123227099003)(261026140227099003)(261009223027099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zCR5990RUI2T29Dfm40cNg6gq3wlrCIuu0pQNannXHw+fEe9khmRfnCFHI7+i/iwtby+Hgw6Ogt8q9VbAlLEWirMtEoNxqAdgB6yzJtcLMBduFwmYcc9jXKBlM+KnD90XjuV8e+4/b9DPAlKv2hG5MAlPslCAUeLl+2almcxx8/Ckw7F9s0WnKkGP67kIFmGaCHVHFjbpkbut7Ou+0yXA/l4NVYRPf+adG5LEsBfkpyWRdRzvF378sdWLsI3VpoD2PKtqx8Wp953Y5dof0IND/EcqINmFbFHUJO0tSovSmhQVXWaplYcpypPWeSL8oXUzF2KsTfwc5o8ooxdCF389bEnd7olIcXqxvzelVJICJEnV3Py05eYIt9j/Nt8BclANOT9tDUBw/tXBYAchIpTaINoWg+/1a//4p6fCyf8j0uzYFZ5b5jX11QRaqyoXQhZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:28:12.9035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8929dc43-94ee-402b-d018-08df467ba266
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279

Expose read-only SDXI 1.1 discovery on device fds and use discovered
GUIDs to authorize raw opb_000 requests for user contexts. For security
reasons, deny unknown and admin-only groups. It also enables atomic
groups only when PCI requester support is available.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/ioctl.c | 177 ++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/pci.c   |  12 +++
 drivers/dma/sdxi/sdxi.h  |   1 +
 3 files changed, 186 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index f0b298b92430..80648bed0e87 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/uuid.h>
 #include <uapi/linux/sdxi.h>
 
 #include "admin.h"
@@ -99,7 +100,8 @@ static int sdxi_ioctl_get_uapi_info(struct file *file, struct sdxi_file *sf,
 			SDXI_UAPI_CAP_RKEY_MGMT |
 			SDXI_UAPI_CAP_CXT_CREATE |
 			SDXI_UAPI_CAP_CXT_EVENTFD |
-			SDXI_UAPI_CAP_AKEY_MGMT,
+			SDXI_UAPI_CAP_AKEY_MGMT |
+			SDXI_UAPI_CAP_ADMIN_DISC,
 		},
 	};
 
@@ -321,22 +323,134 @@ static bool sdxi_u32_array_zero(const u32 *values, size_t count)
 	return true;
 }
 
+enum sdxi_op_group_policy {
+	SDXI_OP_GROUP_UNKNOWN,
+	SDXI_OP_GROUP_USER,
+	SDXI_OP_GROUP_ADMIN_ONLY,
+};
+
+struct sdxi_op_group_policy_entry {
+	guid_t guid;
+	enum sdxi_op_group_policy policy;
+};
+
+static const struct sdxi_op_group_policy_entry sdxi_op_group_policy[] = {
+	{ GUID_INIT(0x193259fe, 0x150b, 0x4008, 0xa8, 0x3f, 0x6f, 0xaf, 0x59,
+		    0xf5, 0x27, 0x2a), SDXI_OP_GROUP_USER },
+	{ GUID_INIT(0xd9bc29a1, 0x91dc, 0x4243, 0x97, 0x51, 0xb6, 0xb0, 0x32,
+		    0x9d, 0xaf, 0xe1), SDXI_OP_GROUP_USER },
+	{ GUID_INIT(0x3ac7630e, 0x7009, 0x424b, 0x82, 0x99, 0x20, 0xe2, 0x90,
+		    0x1e, 0xcc, 0x5e), SDXI_OP_GROUP_USER },
+	{ GUID_INIT(0x7fb16347, 0x4c3a, 0x4d16, 0x84, 0x42, 0xcb, 0xa5, 0x1e,
+		    0x34, 0x08, 0x80), SDXI_OP_GROUP_USER },
+	{ GUID_INIT(0x0af23293, 0x7595, 0x4939, 0xb0, 0x8a, 0x1c, 0x72, 0x93,
+		    0xc2, 0xe9, 0x75), SDXI_OP_GROUP_USER },
+	{ GUID_INIT(0x989b9a64, 0x28d9, 0x4294, 0x9c, 0x7b, 0x9a, 0x3f, 0x27,
+		    0xaf, 0xaf, 0x5c), SDXI_OP_GROUP_USER },
+	{ GUID_INIT(0x15114db9, 0x4a7e, 0x47ab, 0x97, 0xdd, 0xea, 0x86, 0xed,
+		    0xa1, 0x0b, 0x6e), SDXI_OP_GROUP_USER },
+	{ GUID_INIT(0xb3e551a3, 0xf1a9, 0x4c9a, 0x82, 0x52, 0xda, 0xf5, 0xc0,
+		    0xd9, 0x1a, 0x44), SDXI_OP_GROUP_USER },
+	{ GUID_INIT(0x2595c4dc, 0x6fac, 0x49d2, 0xa3, 0x31, 0xb1, 0x40, 0x0a,
+		    0x7f, 0x69, 0x0f), SDXI_OP_GROUP_USER },
+	{ GUID_INIT(0xf5b7610b, 0x0dc6, 0x4c03, 0xab, 0x79, 0x65, 0xf1, 0xf4,
+		    0xef, 0xcf, 0x4c), SDXI_OP_GROUP_ADMIN_ONLY },
+};
+
+static enum sdxi_op_group_policy
+sdxi_op_group_lookup(const guid_t *guid)
+{
+	size_t i;
+
+	if (guid_is_null(guid))
+		return SDXI_OP_GROUP_UNKNOWN;
+
+	for (i = 0; i < ARRAY_SIZE(sdxi_op_group_policy); i++)
+		if (guid_equal(guid, &sdxi_op_group_policy[i].guid))
+			return sdxi_op_group_policy[i].policy;
+
+	return SDXI_OP_GROUP_UNKNOWN;
+}
+
+#define SDXI_DISC_TIMEOUT_MS	5000U
+
+static int sdxi_discover_user_op_groups(struct sdxi_dev *sdxi, u32 available,
+					u32 *allowed, u32 *denied)
+{
+	const u16 first = 1;
+	const u16 last = 31;
+	const size_t record_size = sizeof(guid_t);
+	const size_t size = (last - first + 1) * record_size;
+	dma_addr_t dma;
+	u8 *records;
+	u16 index;
+	int ret;
+
+	if (!sdxi_dev_compatible(sdxi, SDXI_VERSION_1_1) ||
+	    !(available & SDXI_OPB_000_DISC_MASK))
+		return 0;
+
+	records = dma_alloc_coherent(sdxi->dev, size, &dma, GFP_KERNEL);
+	if (!records)
+		return -ENOMEM;
+
+	ret = sdxi_adm_disc(sdxi, first, last, dma, SDXI_DISC_TIMEOUT_MS,
+			    NULL);
+	if (ret)
+		goto free_records;
+
+	dma_rmb();
+	for (index = first; index <= last; index++) {
+		enum sdxi_op_group_policy policy;
+		guid_t guid;
+		u32 bit = BIT(index);
+
+		if (!(available & bit))
+			continue;
+
+		import_guid(&guid, records + (index - first) * record_size);
+		policy = sdxi_op_group_lookup(&guid);
+		if (policy == SDXI_OP_GROUP_USER)
+			*allowed |= bit;
+		else if (policy == SDXI_OP_GROUP_ADMIN_ONLY)
+			*denied |= bit;
+	}
+
+free_records:
+	dma_free_coherent(sdxi->dev, size, records, dma);
+	return ret;
+}
+
 static int sdxi_user_op_groups(struct sdxi_dev *sdxi, u32 requested,
 			       u32 *applied)
 {
 	u32 available;
 	u32 allowed;
+	u32 denied = SDXI_OPB_000_ADMIN;
+	bool use_default = !requested;
+	int ret;
 
 	available = FIELD_GET(SDXI_MMIO_CTL2_OPB_000_AVL,
 			      sdxi_read64(sdxi, SDXI_MMIO_CTL2));
 	allowed = available & SDXI_OPB_000_INTR;
+	if (sdxi->atomic_ops_enabled)
+		allowed |= available & SDXI_OPB_000_ATOMIC;
+
+	ret = sdxi_discover_user_op_groups(sdxi, available, &allowed,
+					   &denied);
+	if (ret && !use_default &&
+	    (requested & SDXI_OPB_000_DISC_MASK))
+		return ret;
 
-	if (!requested)
+	if (use_default)
 		requested = allowed;
-	if (requested & SDXI_OPB_000_ADMIN)
+	if (requested & denied)
 		return -EPERM;
 	if (requested & ~available)
 		return -EINVAL;
+	if ((requested & SDXI_OPB_000_ATOMIC) &&
+	    !sdxi->atomic_ops_enabled)
+		return -EOPNOTSUPP;
 	if (requested & ~allowed)
 		return -EOPNOTSUPP;
 
@@ -552,6 +666,61 @@ static int sdxi_ioctl_quiesce_cxt(struct file *file, struct sdxi_file *sf,
 	return ret;
 }
 
+static int sdxi_ioctl_admin_disc(struct file *file, struct sdxi_file *sf,
+				 void *data)
+{
+	struct sdxi_admin_disc_args *args = data;
+	size_t required;
+	dma_addr_t dma;
+	void *buffer;
+	u16 start;
+	u16 end;
+	u32 timeout_ms;
+	int ret;
+
+	if (args->argsz < sizeof(*args) || args->flags ||
+	    !sdxi_u32_array_zero(args->rsvd0, ARRAY_SIZE(args->rsvd0)))
+		return -EINVAL;
+	if (!sdxi_dev_compatible(sf->process->sdxi, SDXI_VERSION_1_1))
+		return -EOPNOTSUPP;
+
+	start = args->index.start;
+	end = args->index.end;
+	if (start > end || end > 2047)
+		return -EINVAL;
+
+	required = (size_t)(end - start + 1) * sizeof(guid_t);
+	args->argsz = sizeof(*args);
+	args->cst_flags = 0;
+	if (args->buf_size < required) {
+		args->buf_size = required;
+		return -ENOSPC;
+	}
+	if (!args->buf_uptr)
+		return -EINVAL;
+
+	buffer = dma_alloc_coherent(sf->process->sdxi->dev, required, &dma,
+				    GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	timeout_ms = args->timeout_ms ?: SDXI_DISC_TIMEOUT_MS;
+	if (!capable(CAP_SYS_ADMIN))
+		timeout_ms = min(timeout_ms, SDXI_DISC_TIMEOUT_MS);
+	ret = sdxi_adm_disc(sf->process->sdxi, start, end, dma,
+			    timeout_ms, &args->cst_flags);
+	if (!ret) {
+		dma_rmb();
+		if (copy_to_user(u64_to_user_ptr(args->buf_uptr), buffer,
+				 required))
+			ret = -EFAULT;
+	}
+
+	dma_free_coherent(sf->process->sdxi->dev, required, buffer, dma);
+	args->buf_size = required;
+	return ret;
+}
+
 #define SDXI_IOCTL_DEF(_nr, _cmd, _func, _files, _access)	\
 	[_nr] = {						\
 		.cmd = (_cmd),					\
@@ -588,7 +757,7 @@ static const struct sdxi_ioctl_desc sdxi_ioctls[] = {
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
 	SDXI_IOCTL_DEF(0x0c, SDXI_SET_AKEYS, sdxi_ioctl_set_akeys,
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
-	SDXI_IOCTL_DEF(0x0d, SDXI_ADMIN_DISC, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x0d, SDXI_ADMIN_DISC, sdxi_ioctl_admin_disc,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_PUBLIC_DEVICE),
 	SDXI_IOCTL_DEF(0x0e, SDXI_ADMIN_VENDOR, sdxi_ioctl_unsupported,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_VENDOR_HANDLER),
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 010ed2c6ad74..52bdaeda08ff 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
+#include <linux/pci-ats.h>
 #include <linux/pci.h>
 
 #include "context.h"
@@ -68,6 +69,17 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
 	sdxi->has_mailbox = pdev->is_virtfn ||
 		pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
 
+	/*
+	 * PCIe defines AtomicOp Requester Enable as a PF-owned control that
+	 * also applies to its VFs. Configure the physical function so VF
+	 * contexts inherit the transport capability correctly.
+	 */
+	ret = pci_enable_atomic_ops_to_root(pci_physfn(pdev),
+					    PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+					    PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	if (!ret)
+		sdxi->atomic_ops_enabled = true;
+
 	/*
 	 * Allocate the minimum required set of vectors plus one for
 	 * each client context supported by the function.
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 0f7a63d6fc4b..55ca853d6d1c 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -135,6 +135,7 @@ struct sdxi_dev {
 	struct cdev cdev;
 	struct device chardev;
 	int minor;
+	bool atomic_ops_enabled;
 	bool online;
 	struct rw_semaphore state_lock;	/* online state and user operations */
 
-- 
2.56.1

