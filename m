Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120064;
	b=CAuZTb+qFtrEsX1udgFatIXH8DpCb85KiRPMc354jDFBrkc/BxWlVVf5OyYIBM5rUPZu
	 LJl73S0D0GmoUE96Fhbb+K2S8q/x0BRlivTpZSul8h+vvufgWQtlD6cUvJtig8h7dQ0jN
	 M9KxFd4dcLMUFl2tbTooA8N7AwByMpe0WPW/hYo3Tl5vkyb3MjIBHwVolPY/j24k4yRCM
	 1BlzysXHCbbnlStcYuv8M4UTWB7yQzoNvUeEYYYnEDOVanPNn7C2oxeOjQDvkBcBOGYWW
	 wDtgxIJ7xTkS0nxq7UvZjYkU3kHt8GIe9Anvl3tLw3Q1TQQudoDWMfkOGXMxlcTzO4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120064;
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
	bh=7WwPsKqt9Y/iZbFHOlBr3A1jC8c6ldLj6/pNgpwPjVQ=;
	b=0Mrl4iKorggmv1N9a1MzWKS1J2qTcNQCSf4ucjrXX3BQ95catVUEVSBWzN0py23Rmmsk
	 KWnm5CZEFLrRMJPTboziQ4oala2dpR+ZUdrvcmpIligk8uf2mbjjbUCSh9NNmFhVlc7sK
	 Aw7dEg6BtgxWVn7fJ+JyyHd+G5b0qItYmXS3jLx0qkWcmpsOraYIOauXbxkbASAhzGwyV
	 d/ebhr5ndYAx99x4aXXLXG7n2wRH0A87C38Mp4IGzp9aO7vMSwVViDPC6Wy/9PfCfSXG1
	 AosnA0tPgF/fzXIrDWHe75fnctTlmITF2zal6HLbArenYIBQl5S5Tn59L3dXYJX874Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ae1pvRLl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.29
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E579606A332;
	Thu, 19 Nov 2026 20:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E579606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ae1pvRLl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCib434vhEqTw3PdDY6+8jC0/5GeecKY400Fh8gJRkVVVBz3rDZEJ4xWNZ5girzdn69fYK/F4rKPe6Sk8ZxwC3y7nWcV0dVdswQGlS8nawEVuD17qVc1HbDeW1ZFubb6dtid8271yWCwi0tZfRznMYesU8tyhogplNr7yeJXslT1XkyGqu0OajsbLCuRdQ5iqPcqivt7c0LOLYR0uHZQYMBWqAQW0CziitSX5PnNIeWqE1dsZLYh+fJq04pAjnJ/L4WXEnse88Ll8zRWDua6s1PNUXo50gBYBuNRO/0CygILb6jp+nZkRqLLn7YuW9epDx9AzRo8iKFFZnSagvq9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WwPsKqt9Y/iZbFHOlBr3A1jC8c6ldLj6/pNgpwPjVQ=;
 b=hlUGcqzra0aXgx+oL56EncseWq7FiIc5zq3Qr5c62jcvfs8xbvR0cb+2j9V+kEwkjoZzLPhHuNWBaPlJppse/K/O2ODqx4POLKGEhz8qe+3LfIbOVa7TvHQfaoApeS5VK8SY0aWwuIk297V12aQQqD4FSpqejGBnlj9CAa4zv5OAT5f2WMIaKNTqcztLQC7nokloiKJkFSqwIj/KXFzZBqnwCkROp8C3THCQ6uspyv3l4Pret2Mm1jZ6/gf8E5vzrLUcLcLb0vk17sXDGqfwwuJsKHl/7uSjbzJLWTSQ5zAquEt4rL+qDQ4rntwNmor9G4Eafe08L3VVC5zNG9vqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WwPsKqt9Y/iZbFHOlBr3A1jC8c6ldLj6/pNgpwPjVQ=;
 b=Ae1pvRLl8RWF3m2Fli6oqMvCnxPx/Je4vXTOfqbkXvZYnRVwrVEG8oGiTQIBGKwtulWqzjTUdXoNl83679do4Vk0AIPMWOAOksE5aFpRgxahyz0JLK1VaE+wGeblasaUgs61zJk/SMA/kHCZPEwjDAMfOkXupGN21zDdwbCz5u8=
Received: from CH0P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::18)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:27:37 +0000
Received: from DM3PEPF000265BD.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::9d) by CH0P221CA0030.outlook.office365.com
 (2603:10b6:610:11d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 19
 Nov 2026 20:27:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BD.mail.protection.outlook.com (10.167.23.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:27:36 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:27:34 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 20/44] dmaengine: sdxi: implement RKey management ioctls
Date: Thu, 19 Nov 2026 14:22:56 -0600
Message-ID: <20261119202321.1734355-21-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BD:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: b6dd483a-a1a0-4b75-5157-08df467b8cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|10067099003|261022075727099003|261026121527099003|56012099006|261026140227099003|261026130827099003|11063799006|261022105027099003|261022115727099003|261021130227099003|261009223027099003|261021135927099003|261021123027099003|261021133027099003|261021121427099003|261022113327099003|261026135527099003|261102123227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KrxjM1CvO3YSbzNUewOn//Spl6LSaUd7+iA83kPe+u2DvkanPSfC4U5QV31csNFY2txaWOaY0hk0NggU7WQ9oSFxQ2WUFoj+qVHzZDyGI4D/tlKEYNt9SKprjKi/ONICWn0sdCgnCrMpVAIKGzGjKXPTDfO1NPTXK8W9K72qApmWS3mCoLaPcbisBMpRbDZHU0c+amheRUC+Mm1SyeBlyTFJhuwLSS+BjW9bVfuqXHxULjCjqdXAUyqMRBy+8yvNHfpcVFv0diMhz3mNd0HNwAGMcRhO6G3fe6MCMuDtI0JxiRkWGCDDBU2F/PicC1a1/cb1jxebGpXEUbQsjrHDUPj5/OkBJEKs/vnx8Ei05waxxYxE4dIJCLF6uYdlWMOXg0RIckp7OF8qS+Qu8T4ZibTD5l9Iw3tZKh79M7ERkaysdrYGT2pRdJdr4Sau32m/0ph/7IXwZ4QXxRn11CMS9RVa3ndnbquOHYN7lH66BizJEg5d0zQzySedmhJgZisuPc3hfJ1jpdV0VZuYyU5wV9H3cpwk6LWzyPs3mqqUDkFydJ8DlRMVnLs0VeRczwvmvBzNKgYMcNP1+OK1dpoX2TdM/I8hNiu6S0XLzxFOt8PBEVdzkd7bG5rwgrpEGH5V6A4xaBBaef6rUhl6smO4nWHYrENn0DrcI4vnNfxwKExA5zMvduHB70dKCopMVwlzU/gR5gSGgfKfi7ubKL97HA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(261022075727099003)(261026121527099003)(56012099006)(261026140227099003)(261026130827099003)(11063799006)(261022105027099003)(261022115727099003)(261021130227099003)(261009223027099003)(261021135927099003)(261021123027099003)(261021133027099003)(261021121427099003)(261022113327099003)(261026135527099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ivRymDOvFG8AbTAveTnKkUTz9ToVu/huYCsiTVYE74g8MnecRZkSJRbLdsJtP3Ykg+9rQuYx4xuwCqq2bpW+KR+ikY0DO89rcEdUfUfBngTEw+DCQBxqe1MIrsEpb2aCwlspHhP1b9+4K7SzPTlUFDb+iXHUPeVtRXa6bhBh+N75xBx/ZdeyvTr3yCo+oLPNfmWfIBziCES3UyPYgHXtNnsZvHMt35q2hiEgoZPqMX0P37WLZFlK11zajYPS4eLb4+Uy+NwQtnjsC86iYyLUTGiZo9TE6KLNHEIrU6Q3Tcifnn6UnbYPxdPwSO76Ki+sPCOwl00obx+eSGmg/0gRod8SD8HSzmrchXV6ddLJ3jtB6qTY2Pr94bcaMx4NNjFe2PDwu+/a9eOGqbDwuGiNuJfDYptAaqRjWhaoOx+vMVVmW1nDBCFWlHtTkHpkTRT8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:27:36.6593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dd483a-a1a0-4b75-5157-08df467b8cd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335

Implement admin-only RKey bitmap, read, and write operations over
the shared key-table ABI. Validate complete batches before modifying
memory, publish valid bits last, and issue RKey update plus sync
before reporting commit state.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/ioctl.c |   8 +-
 drivers/dma/sdxi/keys.c  | 270 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/keys.h  |   6 +
 3 files changed, 281 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index 682b0b074f38..4f4b900d2542 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -31,6 +31,7 @@
 #include "context.h"
 #include "intr.h"
 #include "ioctl.h"
+#include "keys.h"
 #include "mmio.h"
 #include "process.h"
 #include "sdxi.h"
@@ -95,6 +96,7 @@ static int sdxi_ioctl_get_uapi_info(struct file *file, struct sdxi_file *sf,
 		.caps = {
 			SDXI_UAPI_CAP_DEV_INFO |
 			SDXI_UAPI_CAP_DEV_ATTR_MGMT |
+			SDXI_UAPI_CAP_RKEY_MGMT |
 			SDXI_UAPI_CAP_CXT_CREATE |
 			SDXI_UAPI_CAP_CXT_EVENTFD,
 		},
@@ -569,11 +571,11 @@ static const struct sdxi_ioctl_desc sdxi_ioctls[] = {
 		       SDXI_IOCTL_A_PUBLIC_DEVICE),
 	SDXI_IOCTL_DEF(0x04, SDXI_SET_DEV_ATTR, sdxi_ioctl_set_dev_attr,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
-	SDXI_IOCTL_DEF(0x05, SDXI_GET_RKEY_LIST, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x05, SDXI_GET_RKEY_LIST, sdxi_ioctl_get_rkey_list,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
-	SDXI_IOCTL_DEF(0x06, SDXI_GET_RKEYS, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x06, SDXI_GET_RKEYS, sdxi_ioctl_get_rkeys,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
-	SDXI_IOCTL_DEF(0x07, SDXI_SET_RKEYS, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x07, SDXI_SET_RKEYS, sdxi_ioctl_set_rkeys,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
 	SDXI_IOCTL_DEF(0x08, SDXI_CREATE_CXT, sdxi_ioctl_create_cxt,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_PUBLIC_DEVICE),
diff --git a/drivers/dma/sdxi/keys.c b/drivers/dma/sdxi/keys.c
index c2f1db0d1594..75a2855ed13d 100644
--- a/drivers/dma/sdxi/keys.c
+++ b/drivers/dma/sdxi/keys.c
@@ -7,15 +7,162 @@
 
 #include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
+#include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
+#include <uapi/linux/sdxi.h>
 
+#include "admin.h"
 #include "hw.h"
+#include "ioctl.h"
 #include "keys.h"
 #include "mmio.h"
 #include "sdxi.h"
 
+#define SDXI_KEY_DEFAULT_TIMEOUT_MS	5000U
+
+static u32 sdxi_key_bitmap_bytes(u32 entries)
+{
+	return DIV_ROUND_UP(entries, 8);
+}
+
+static bool sdxi_key_entry_valid(const void *entry)
+{
+	__le16 intr_num;
+
+	memcpy(&intr_num, entry, sizeof(intr_num));
+	return le16_to_cpu(intr_num) & BIT(0);
+}
+
+static u32 sdxi_key_count_valid(const void *table, u32 entries, size_t stride)
+{
+	u32 count = 0;
+	u32 i;
+
+	for (i = 0; i < entries; i++)
+		if (sdxi_key_entry_valid((const u8 *)table + i * stride))
+			count++;
+
+	return count;
+}
+
+static u32 sdxi_key_build_bitmap(u8 *bitmap, const void *table, u32 entries,
+				 size_t stride)
+{
+	u32 bytes = sdxi_key_bitmap_bytes(entries);
+	u32 count = 0;
+	u32 i;
+
+	memset(bitmap, 0, bytes);
+	for (i = 0; i < entries; i++) {
+		if (!sdxi_key_entry_valid((const u8 *)table + i * stride))
+			continue;
+		bitmap[i / 8] |= BIT(i % 8);
+		count++;
+	}
+
+	return count;
+}
+
+static int sdxi_key_args_check(u32 argsz, size_t minimum, u32 flags,
+			       const u32 *reserved, size_t reserved_words)
+{
+	size_t i;
+
+	if (argsz < minimum || flags)
+		return -EINVAL;
+	for (i = 0; i < reserved_words; i++)
+		if (reserved[i])
+			return -EINVAL;
+
+	return 0;
+}
+
+static int sdxi_key_list_fill(struct sdxi_key_list_args *args,
+			      const void *table, u32 entries, size_t stride)
+{
+	u32 available = args->buf_size;
+	u32 required = sdxi_key_bitmap_bytes(entries);
+
+	args->argsz = sizeof(*args);
+	args->buf_size = required;
+	args->nentries = entries;
+	args->nvalid = sdxi_key_count_valid(table, entries, stride);
+
+	if (available < required)
+		return -ENOSPC;
+
+	args->nvalid = sdxi_key_build_bitmap(args->data, table, entries,
+					     stride);
+	return 0;
+}
+
+static int sdxi_key_check_indices(const struct sdxi_key_entry *keys,
+				  u32 nkeys, u32 entries,
+				  u16 *first, u16 *last)
+{
+	u16 minimum = U16_MAX;
+	u16 maximum = 0;
+	u32 i;
+
+	for (i = 0; i < nkeys; i++) {
+		if (keys[i].rsvd0 || keys[i].index >= entries)
+			return -EINVAL;
+		minimum = min_t(u16, minimum, keys[i].index);
+		maximum = max_t(u16, maximum, keys[i].index);
+	}
+
+	if (first)
+		*first = minimum;
+	if (last)
+		*last = maximum;
+	return 0;
+}
+
+static void sdxi_set_keys_init(struct sdxi_set_keys_args *args)
+{
+	args->cst_flags = 0;
+	args->commit_state = SDXI_KEY_COMMIT_NONE;
+	args->first_failed_index = 0;
+}
+
+static unsigned int
+sdxi_set_keys_timeout(const struct sdxi_set_keys_args *args)
+{
+	return args->timeout_ms ?: SDXI_KEY_DEFAULT_TIMEOUT_MS;
+}
+
+static int sdxi_rkey_validate(const struct sdxi_rkey_ent *entry)
+{
+	u16 intr_num = le16_to_cpu(entry->intr_num);
+	u32 pasid = le32_to_cpu(entry->pasid);
+
+	if (intr_num & BIT(15))
+		return -EINVAL;
+	if (pasid & ~(SDXI_RKEY_ENT_PASID | SDXI_RKEY_ENT_PR |
+		      SDXI_RKEY_ENT_PH))
+		return -EINVAL;
+	if (memchr_inv(entry->rsvd_0, 0, sizeof(entry->rsvd_0)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void sdxi_rkey_store(struct sdxi_rkey_ent *destination,
+			    const struct sdxi_rkey_ent *source)
+{
+	struct sdxi_rkey_ent entry = *source;
+	u16 intr_num = le16_to_cpu(source->intr_num);
+
+	entry.intr_num = cpu_to_le16(intr_num & ~SDXI_RKEY_ENT_VL);
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
@@ -57,3 +204,126 @@ void sdxi_keys_exit(struct sdxi_dev *sdxi)
 	sdxi->rkey_order = 0;
 	sdxi->rkey_cap = false;
 }
+
+int sdxi_ioctl_get_rkey_list(struct file *file, struct sdxi_file *sf,
+			     void *data)
+{
+	struct sdxi_key_list_args *args = data;
+	struct sdxi_dev *sdxi = sf->process->sdxi;
+	int ret;
+
+	ret = sdxi_key_args_check(args->argsz, sizeof(*args), args->flags,
+				  &args->rsvd0, 1);
+	if (ret)
+		return ret;
+	if (!sdxi->rkey_cap)
+		return -EOPNOTSUPP;
+	if (!sdxi->rkey_table)
+		return -ENODEV;
+
+	mutex_lock(&sdxi->rkey_lock);
+	ret = sdxi_key_list_fill(args, sdxi->rkey_table,
+				 sdxi->rkey_entries,
+				 sizeof(*sdxi->rkey_table));
+	mutex_unlock(&sdxi->rkey_lock);
+	return ret;
+}
+
+int sdxi_ioctl_get_rkeys(struct file *file, struct sdxi_file *sf, void *data)
+{
+	struct sdxi_get_keys_args *args = data;
+	struct sdxi_dev *sdxi = sf->process->sdxi;
+	u32 i;
+	int ret;
+
+	ret = sdxi_key_args_check(args->argsz, sizeof(*args), args->flags,
+				  &args->rsvd0, 1);
+	if (ret)
+		return ret;
+	if (!sdxi->rkey_cap)
+		return -EOPNOTSUPP;
+	if (!sdxi->rkey_table)
+		return -ENODEV;
+	if (args->nkeys > sdxi->rkey_entries)
+		return -EINVAL;
+
+	ret = sdxi_key_check_indices(args->entries, args->nkeys,
+				     sdxi->rkey_entries, NULL, NULL);
+	if (ret)
+		return ret;
+
+	args->argsz = sizeof(*args);
+	mutex_lock(&sdxi->rkey_lock);
+	for (i = 0; i < args->nkeys; i++)
+		memcpy(args->entries[i].data,
+		       &sdxi->rkey_table[args->entries[i].index],
+		       sizeof(args->entries[i].data));
+	mutex_unlock(&sdxi->rkey_lock);
+
+	return 0;
+}
+
+int sdxi_ioctl_set_rkeys(struct file *file, struct sdxi_file *sf, void *data)
+{
+	struct sdxi_set_keys_args *args = data;
+	struct sdxi_dev *sdxi = sf->process->sdxi;
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
+	if (!sdxi->rkey_cap)
+		return -EOPNOTSUPP;
+	if (!sdxi->rkey_table)
+		return -ENODEV;
+	if (!args->nkeys) {
+		args->commit_state = SDXI_KEY_COMMIT_ALL;
+		return 0;
+	}
+	if (args->nkeys > sdxi->rkey_entries)
+		return -EINVAL;
+
+	ret = sdxi_key_check_indices(args->entries, args->nkeys,
+				     sdxi->rkey_entries, &first, &last);
+	if (ret)
+		return ret;
+
+	mutex_lock(&sdxi->rkey_lock);
+	for (i = 0; i < args->nkeys; i++) {
+		struct sdxi_rkey_ent entry;
+
+		memcpy(&entry, args->entries[i].data, sizeof(entry));
+		ret = sdxi_rkey_validate(&entry);
+		if (ret)
+			goto out_unlock;
+	}
+
+	for (i = 0; i < args->nkeys; i++) {
+		struct sdxi_rkey_ent entry;
+
+		memcpy(&entry, args->entries[i].data, sizeof(entry));
+		sdxi_rkey_store(&sdxi->rkey_table[args->entries[i].index],
+				&entry);
+	}
+	dma_wmb();
+
+	ret = sdxi_adm_rkey_update_sync(sdxi, first, last,
+					sdxi_set_keys_timeout(args), NULL);
+	if (ret) {
+		args->commit_state = SDXI_KEY_COMMIT_PARTIAL;
+		goto out_unlock;
+	}
+
+	args->commit_state = SDXI_KEY_COMMIT_ALL;
+out_unlock:
+	mutex_unlock(&sdxi->rkey_lock);
+	return ret;
+}
diff --git a/drivers/dma/sdxi/keys.h b/drivers/dma/sdxi/keys.h
index c479da651526..fed5c20a2cfc 100644
--- a/drivers/dma/sdxi/keys.h
+++ b/drivers/dma/sdxi/keys.h
@@ -11,8 +11,14 @@
 #include <linux/types.h>
 
 struct sdxi_dev;
+struct file;
+struct sdxi_file;
 
 int sdxi_keys_init(struct sdxi_dev *sdxi, u64 cap1);
 void sdxi_keys_exit(struct sdxi_dev *sdxi);
+int sdxi_ioctl_get_rkey_list(struct file *file, struct sdxi_file *sf,
+			     void *data);
+int sdxi_ioctl_get_rkeys(struct file *file, struct sdxi_file *sf, void *data);
+int sdxi_ioctl_set_rkeys(struct file *file, struct sdxi_file *sf, void *data);
 
 #endif /* DMA_SDXI_KEYS_H */
-- 
2.56.1

