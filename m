Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120122;
	b=kzM+kOIMhuC3tq4mZy8biGR4jmj5jhGUW0BBLjFDX0dXsLr26vRH6EwHYQiMdEZv/sZW
	 KTkFUfPAumt12KQwgjxyDOgmfO1yQpowYRiu0lf0fG+Y9L1ppGlR7AlkSHYjLXTvnf4oz
	 ws+rbKUZb61tGS1FGM/rCvYX269wQjw/Q1YgzZDmLr+Vs4YeT7u3T+DBhDyJr5XiwKmJY
	 kGFrvwZGS3dVn8IKrQnqzqNeYZ7xMSJmIIoDQ87DvDHUHrme6jrvqggY6WxFdE8o1CwCY
	 UDHzsb1Uw/0hfzilIUcEUoPWvBeb+Po9cHIVVUslSpZsxyNJBG3yK+YubXiaQPr8Pcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120122;
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
	bh=clcKmXPROLSkcD51/rwf4d3hToWhRa4PwGvLY9MbA4c=;
	b=rGtkXTWWpUlA8wLvLvBDXHN6JHQvlvBQJrndIePh4pmJ2879M0ANkys+rkvDroG35kE9
	 ODXW6aDZEx1DKTOSxPrLYRz3tMUJFP2sU5ow/qhsYZDBU1RA9wgjjzitX47E4eb/yT3c9
	 dXCF13MEblMFc6UFmNNUJA3+R9WSP4YCAnzoNCqzXn2DZTykTBygxjygDRF81nH2IR5xi
	 Rr0X6VBvgfN/SS3FhLetKfP1Kx6N+Oh6k9lApmoEiZz/BWL35gcCJyChlNGWmasWcxJzu
	 vV6mO3nlv6iboKsTEWXsS+WGOgPa+WwiKKSzb1PvQy8KMY57jPnHtlcW7dh6O5AILgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0fbwYJ6p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.1
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D3606A324;
	Thu, 19 Nov 2026 20:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F6D3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0fbwYJ6p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvezHYXWWae1n3elcTZr2sT4Og0kjrh4Ep/YL/5tHN6mj+cODkPB+hLVtN+lS1Kn2Y2uDLmYOZ6BbWIzQ7vwa3SJRciYr1NfCfzl7SlKEeVHdc/hdyihyUjvluETxxypIQD2vWuiIcPg2/CkJV6vBDfveBi9VEGhQ00HAF+y4hwUmKtiwNvg2kiDHbwlZsOYIU/Y2G4jC82nPLj+dmYuJYtT5I/XX4t2GbuA8aeVPvh4zgtsp4H8MzdfzhvJLpRUf2QUuzxEnC2sotv+X+zi+LmtCXu8eqhnZak34YGKpN6aB/SUMHVjX7fC5xa5YtcMalv7uoWdnwfyIyHU22r5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clcKmXPROLSkcD51/rwf4d3hToWhRa4PwGvLY9MbA4c=;
 b=W9zWAr1DKg3ZQC06hwl0gta9+bEN2U5rWgQYoj1FSVCF/w6RLdXrNNaYlU/EqKLgIZOjJi/PiBuGA4KSIO/OJcqmSN+LtqOMHD3Kakh/to4sncVe0zqHIwHMqSbN9UXlFQU1Lkxbo6gmAKNsnvU/v3H6duEscNXwKueMxmxl5Id0L1QwtTqIxmQCrCw9wVVehj3/LjE80oPO0Lz35iCU6UMNX3OQ21MrXiRxur3YljThGqWWvogpZOIPE3nfkoV+aJGBf1jqwgUE3VIs7KzjaxkshtfqTroNiP7BxQcftyaZg0LO5rlVpkBVsodenYf6ipSknVK8T4Ar7VdBTrQdWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clcKmXPROLSkcD51/rwf4d3hToWhRa4PwGvLY9MbA4c=;
 b=0fbwYJ6pNwuyIcBsiDNboYt+AFxIH4B+WMjARXF93ATGSqVjj1AEG3ckuotReZE0C8oOEoo15+mukAJqH2fs79JA4ZIv33+ecf3bDzvo0ZF+/RahVaDlMyoX0dyz9rnRuTnm3hh9D8bXp15pgj7zPROEzP91XJ0JKeofMn0EmCs=
Received: from CY8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:930:49::29)
 by FT1PR12MB222952.namprd12.prod.outlook.com (2603:10b6:170:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:28:37 +0000
Received: from CY5PEPF00000E81.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::a0) by CY8PR12CA0036.outlook.office365.com
 (2603:10b6:930:49::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:28:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E81.mail.protection.outlook.com (10.167.247.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:28:36 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:28:35 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 24/44] dmaengine: sdxi: expose character device attributes
Date: Thu, 19 Nov 2026 14:23:00 -0600
Message-ID: <20261119202321.1734355-25-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E81:EE_|FT1PR12MB222952:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5dd2ca-7027-4f1d-bdf3-08df467bb0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|6133799003|22082099003|261009223027099003|18002099003|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	73CcOu1fdUJ5qZH5GXAb3XPA8bpSNx56MWjsPcRUvOGEVyB75vkdnS+xWZWPjU2cd9UFLT9d4ksR/GE2WWfIz0eb5XXenKP6bU16sbj1Q0R/FuBUjq7Aq1CyaTA2MBQhbOsXL3GgTkxrnb6EZY027z26w23GcSDwrANBYPOvb06gKYrm3mft0Xz+B7CUa8dI0ZP/WDr3Bnog6uEGgdxM+Z5Xxx+rMTH3kRdAo5efgSV8lCy0mHeIiHv6r1nF/yqZq2/cNKJU95Bzir3vQWShSRKdxD9eX8tbPLEa5G7NiwRW8j/8UsLw3X2xdVsBDL++qBcUOPiAIDu7cNMafuYU7YsDMNSdMpNoKku1kHxlGSw/h3iA/52FbAj0kGYixmyqzbBdixUZCv+wBYRC2PoOZWIsW/hPx5Yoq2lpBUNu58Z0WBhxAw9YjghzUBDJfe6I/f+2A7tLpGYb37qjmLY80740+T3edCYnx10PDKaAnl/92TU5KVfAjA3xioZGUVNX6itC2d/r2HKmUENTHqEGgt72HxIAdSlSM15Abiyrd8EuVrD+mSlXkqHbZLdTz5m+E3pB+qBvQ3LzZsYXetNKhYzBwXYM6WEy1sqVAbG0lPPkqNlRaVG5kVBr+buD/C8WwcMAPB7i4EsFtOROUxfCbd3Ga+7nPeIq10jYbPeB1PHe24Qt7amz7xdHQv0P7nzdOedxygcHDESevu/dXmQWdg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(6133799003)(22082099003)(261009223027099003)(18002099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ElJZeZbzYg3/gLnGYVYAImVb6wd0X4HhBTwkElWMdif10Ns776QEaF6gnFMtP+BQy6V1xj6d3FLQOKdy1JCZ4sM+n736o9+rH2MiXU7VuBFhCBxBPbbHUZK94Z0FkvYxSmATwrPwRmJB2yzur+iQvvHd9xVwMccG6LyQd9ANOORxCq0U1ShzjxEUDigWcCanHSzyzguP+iUwxey0/gwzDZADCLtFhkSJEI650Tdj4GUl1W1mUWHCdGD9smy7Akcy9HXSmKJf9Y5bxfQHZQ2nvHPlxoUuuW0VcBdbMP/1eoezEh8C4YKgL27Zh+orCvOiw5Y/B6/yAGogvywsdRHhlQm3vLKeYWjT7VOrj6AoA1tZf2doHpk5K4snKIeB3P56bEi1zmrB78nKAK88CCxJJFUzp7p2CMBbHskQWk4ENHZ/RLi1EVk8KIHzYVJQF/vl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:28:36.7655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5dd2ca-7027-4f1d-bdf3-08df467bb0a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E81.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB222952

Add read-only version, context count, function identity, and NUMA
attributes as sysfs to each SDXI character device. Derive context
accounting from live sessions so users can retrieve accurate
information.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/Makefile  |  1 +
 drivers/dma/sdxi/context.c |  9 ++++-
 drivers/dma/sdxi/context.h |  1 +
 drivers/dma/sdxi/device.c  |  1 +
 drivers/dma/sdxi/ioctl.c   |  2 ++
 drivers/dma/sdxi/sdxi.h    |  2 ++
 drivers/dma/sdxi/sysfs.c   | 70 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/sysfs.h   | 13 +++++++
 8 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/sdxi/sysfs.c
 create mode 100644 drivers/dma/sdxi/sysfs.h

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 253398a45c74..019038cc91bc 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -13,6 +13,7 @@ sdxi-core-y := \
 	keys.o        \
 	process.o     \
 	ring.o        \
+	sysfs.o       \
 	vendor.o
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index cdaa0f654429..43ffe132cf2e 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -424,8 +424,11 @@ static int sdxi_publish_cxt(struct sdxi_cxt *cxt,
 	};
 
 	err = configure_L1_entry(ent, &L1_cfg);
-	if (!err)
+	if (!err) {
 		cxt->sdxi->L1_users[l2_idx]++;
+		cxt->sdxi->cxt_count++;
+		cxt->counted = true;
+	}
 
 out_unlock:
 	mutex_unlock(&cxt->sdxi->cxt_lock);
@@ -459,6 +462,10 @@ static void sdxi_rescind_cxt(struct sdxi_cxt *cxt)
 		goto out_unlock;
 
 	sdxi->L1_users[l2_idx]--;
+	if (cxt->counted) {
+		sdxi->cxt_count--;
+		cxt->counted = false;
+	}
 
 out_unlock:
 	mutex_unlock(&sdxi->cxt_lock);
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index c245c7ee7841..22a33291020f 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -65,6 +65,7 @@ struct sdxi_cxt {
 	bool registered;
 	bool published;
 	bool update_pending;
+	bool counted;
 	bool started;
 
 	struct sdxi_cxt_ctl *cxt_ctl;
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 7ebecae3c541..c6b690c39b05 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -387,6 +387,7 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 
 	/* Read capabilities and features. */
 	cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0);
+	sdxi->sfunc = FIELD_GET(SDXI_MMIO_CAP0_SFUNC, cap0);
 	sdxi->db_stride = SZ_4K;
 	sdxi->db_stride *= 1U << FIELD_GET(SDXI_MMIO_CAP0_DB_STRIDE, cap0);
 	if (sdxi->db_stride > sdxi->db_size)
diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index feef322a005e..dbd6a916392d 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -36,6 +36,7 @@
 #include "mmio.h"
 #include "process.h"
 #include "sdxi.h"
+#include "sysfs.h"
 #include "vendor.h"
 
 #define SDXI_MAX_MINORS	256
@@ -1295,6 +1296,7 @@ int sdxi_chardev_register(struct sdxi_dev *sdxi)
 	sdxi->chardev.devt = devt;
 	sdxi->chardev.class = sdxi_class;
 	sdxi->chardev.parent = sdxi->dev;
+	sdxi->chardev.groups = sdxi_dev_groups;
 	dev_set_drvdata(&sdxi->chardev, sdxi);
 	ret = dev_set_name(&sdxi->chardev, "sdxi%d", minor);
 	if (ret)
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 55ca853d6d1c..062ba4be90ad 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -92,6 +92,7 @@ struct sdxi_dev {
 	struct sdxi_version sdxi_version;
 
 	/* hardware capabilities (from cap0 & cap1) */
+	u16 sfunc;
 	u32 db_stride;			/* doorbell stride in bytes */
 	u64 max_ring_entries;
 	u16 max_cxtid;			/* Maximum context ID allowed. */
@@ -129,6 +130,7 @@ struct sdxi_dev {
 	bool admin_dead;
 	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
 	u32 mmap_gen;
+	unsigned int cxt_count;
 
 	bool has_mailbox;
 
diff --git a/drivers/dma/sdxi/sysfs.c b/drivers/dma/sdxi/sysfs.c
new file mode 100644
index 000000000000..808712952f37
--- /dev/null
+++ b/drivers/dma/sdxi/sysfs.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI character device attributes.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/sysfs.h>
+
+#include "sdxi.h"
+
+static ssize_t version_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u.%u\n", sdxi->sdxi_version.major,
+			  sdxi->sdxi_version.minor);
+}
+static DEVICE_ATTR_RO(version);
+
+static ssize_t cxt_count_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+	unsigned int count;
+
+	mutex_lock(&sdxi->cxt_lock);
+	count = sdxi->cxt_count;
+	mutex_unlock(&sdxi->cxt_lock);
+
+	return sysfs_emit(buf, "%u\n", count);
+}
+static DEVICE_ATTR_RO(cxt_count);
+
+static ssize_t sfunc_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", sdxi->sfunc);
+}
+static DEVICE_ATTR_RO(sfunc);
+
+static ssize_t numa_node_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", dev_to_node(sdxi->dev));
+}
+static DEVICE_ATTR_RO(numa_node);
+
+static struct attribute *sdxi_dev_attrs[] = {
+	&dev_attr_version.attr,
+	&dev_attr_cxt_count.attr,
+	&dev_attr_sfunc.attr,
+	&dev_attr_numa_node.attr,
+	NULL,
+};
+
+static const struct attribute_group sdxi_dev_group = {
+	.attrs = sdxi_dev_attrs,
+};
+
+const struct attribute_group *sdxi_dev_groups[] = {
+	&sdxi_dev_group,
+	NULL,
+};
diff --git a/drivers/dma/sdxi/sysfs.h b/drivers/dma/sdxi/sysfs.h
new file mode 100644
index 000000000000..91e672bb7adc
--- /dev/null
+++ b/drivers/dma/sdxi/sysfs.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI sysfs declarations.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_SYSFS_H
+#define DMA_SDXI_SYSFS_H
+
+extern const struct attribute_group *sdxi_dev_groups[];
+
+#endif /* DMA_SDXI_SYSFS_H */
-- 
2.56.1

