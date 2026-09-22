Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F00522F10;
	Tue, 22 Sep 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066383; cv=fail; b=A2k64GzHF+bugQhVigYr329uZmmgoY6L2dMgu1TAADdsaawji8XhUd+9IsFdLZ50d/vIvRoAKW4JKH8ECpTCtW9+WymmpruRRywJlXWqROA8/FjNaYoT6XPgfgt43umnbeUNBv7ydIfb8n0WYmiW8923h6/6U2JnYdMUk6EBtZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066383; c=relaxed/simple;
	bh=XK0bAfqo5tV8AIltWXcQkOOh5yCOQEEQ9ljY9TwmicM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUTba3cXYdwwfxWbqHn5YtFO4+fJgHle3JORjmGEeRpR5dDl8i3GU5ykCg1hXxZJ+EBRjLHcyGh59dAA5292KrjK55u14kdJ0tUjMYlVOtxd4ka7bepvVmYNuW8ggKhmdRwE9JvKQ5GqFdhv/Gl8fLJymcsvFNMKmHPHuUJwzxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YyHc6zWQ; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YyHc6zWQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzWXoQX+mvhNvKCVH/+UnPZ6KtU/ifjntZydsnPIyHQyCq3P6Rcy4BZ7U+Smrsaswm71onerQ7iRg0xOYLBdo23f2af1kmRLFAfQx0kIT5RiB0ATE1U13SahIFQmL4/QrYzUPbgeR+3Ge29T+UA2WVCkYvsys0ThlgApi1W6Sky1Rr+XIzs6usySNQ5aDDTrkz6nMv9lyF3MRArUiQai/UzxNqU+auuST1WVZVUK7sXISYVsu+9HTJ52/rJzjN7EeIlJvUzBWoIwcf7u/PfyCFxVEEyHy5bKc/El4ZK8mJKt/0dHcZrhQdqzO0AFpQIYxKACmntayA5Qi2fhz0XCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7IC6ShS1V6EsNviaEzI49r3XvJpKpiUMXDtvjbMHoc=;
 b=s0PNQsZtdlHldsnOFoY7xShxo/NTabdD+ewdDas6Pj7skz/ZNWhpXAR2Zaz8EHLR/Ysr01ZQczwrGE785OsH5rsRM40gMswcITgwf0nbbk6ycHltk1DEAE97A2wYBptcCaCkOYmhi/o9kQrfQT+oh86fw9x1NLMra+g7q1IRVFwtUXPRxA6S1F/zLI5sIOTgVL7rH0UnmjPH30ZsBoLfbqxHdEsu1sjURYGPEhJRmpGq4C+yxQtvv7zyqDPPqPYtENPRNWjKmx3a8hk3jz1tvNXY/Q62hsimJ1DY0M6yzOVCpKePr7AmTUIuRuYNhIR8eGSRuOUe/Pvz2gRQWm2cyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7IC6ShS1V6EsNviaEzI49r3XvJpKpiUMXDtvjbMHoc=;
 b=YyHc6zWQuO3GBm8nSe7p7WDgjD3ijenTvV4a5DjWx7iIckwlY2ZO5HIqehG6LYdBmEhtmMsk3insPCKVJY0H4eGqANU8JEFUdiThMA2lUrrgdUbr2g4hqfg99sqkU3Ie4PK4aiz6A0PenCaji6vxnQoXnWrzhpxFCSHr2YP4TphC7qDNQzQ3Epcm2TDuSgJs0WMwZFkrVQ2mS4qFoJn0XL/9z72XC4nHTJMnIsD/m4/H+hUX6/2P5okb/8P4UAl7tWfP1Yy2m5cIYKQY4vEMh6b6pux8yu+lO4V9/HcdqItBab7vl8ufBWJ5BLHtqCJMVP2KH65eLLYS6JMBzqlsOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:38 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:38 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v13 04/15] cxl: Move decoder declarations to shared header
Date: Tue, 22 Sep 2026 08:39:13 +0000
Message-ID: <20260922083924.2451158-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:303:2a::21) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df9fd32-c67a-439a-2602-08df188509b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b325eZn94hs4cM24QcWkJxc7PHYe/7b/Xr3oLLCHJ8LSkaDgh1mblogiHvnaOtHnPVe9qbN9cTIEJQH6uaFNz15vwlbGdim2Fzqskm13PEBKa4zDay2zsmPx7hJnjMWDTq6y64sDXdLGZlcPpswSRgeLwx8Sc/R3pSFHlNyuDuurEusnyP3/R8a30F6Q387te3qCDeHlIM+AcM+f7qSGIqy7e8IvM1uWnMNM1CU6zqDVTj77N3juOMxS8NYfb5SCDiSjemkj1ISuuRCk8qP4rGzzigVtC1IPI/Xeui48S1V4vNTOYVTz/DY/u0SI5mmCnWSbsdyP4x9ZbHyDksjGu/KvyrygWNxSQdJd5vQxjAVaaX9oi2pYqRUBsMORpzRU1U6bB6763tpBPQ5OOQpJUO+xd5W/Tht0b5uR/MRGHV/IdkZ/dmIJiGUGMvZc2nB2yJcfuaTryjVfzdmoBAeQzSr9HwsxBK2rixeBgwKbgOGf8xjSADK4JSKZ7Ni0edoYq3TMnAkSIgVwmiieMXj5OiWW1aknkKS70O9CPkdg4ma4fi6PnfwscFEEIKaR5XevfKwTeJhEgCWmfUC+Jte4ul9TS7bbIhhdpZZzkJR40H7EscHwst35+kxIfbTZg/bH0FraO8m9SqcfQMF5+Zvj5yEpVIXUeOjdTEQxmnoHyvN8i/Q/ny8vOl9Q7MoeXcPPNF9OwcgWGx1pef2VJTsU3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tbPB4FBOYmky6P9lGh+Z1YTHr+ieYP45mwbVhLn8ND0qvxH2cooFJ4X7fsvx?=
 =?us-ascii?Q?Y+ys1a5JNhp7LAy4zeNuZ3GPaXsNYH1qwxkeVeLPEA+kHeyjazqNy1Wy5GbF?=
 =?us-ascii?Q?LP/IgyCJy/XncQ555z37xjVmU4s084NBrlDOqsUzJz816CS54eDKSZohkDO/?=
 =?us-ascii?Q?kWu/tFidNaLSpwqpe/KeGJw9PGBKE/Gxs3RGkpp28UFpWhr+Lv38tsS+x0Xg?=
 =?us-ascii?Q?QD6twqLrX5kmILskVz15sSsUV/d0jkAPsHIbIoCnpHZ3j2sP1xfiZVSjMMO2?=
 =?us-ascii?Q?ZIj7PANWDA33aF81qNhYdXeoHx1ektziGxDQ5BwN9nz+pt5HV1imYwFxQyxA?=
 =?us-ascii?Q?5WTKdhh+sLJxwm9O1Y5EFU4cWWxULXnpzXWY3q0m+tKoyYt7luYO6woK++r4?=
 =?us-ascii?Q?Kul5AEPuRDmvlxbyidwMg9ZmRJwe3Ev9VIffvwLggi57dPr8M1KQhuaYXyA4?=
 =?us-ascii?Q?gpGNkLQTOtZOVErabhCdi4tfIeheXr3maAg0B6rKnGxrG7qG2FOf8XPXBayL?=
 =?us-ascii?Q?F37XpTC1BuLa5KEj/wzSNszGi3jD0y7Y+fnL7eV/gW0+R/jhQUngviJE4JmV?=
 =?us-ascii?Q?OIShBpPbUgNFGufXGUpwIOgu38YslkhSrugkUd/Vob8O+Xwriv/hiz4Foiv0?=
 =?us-ascii?Q?DdSQHDpTjcmMRD5zk9TXdDJYLMC7kipZtShfEVKwlObWKgoqWI2MT/mppkrI?=
 =?us-ascii?Q?huDYf9r5NhIGu3sWEnQeqUoDL5Zs68YV/K24cTjxcRjr4RFhAaKs9v5oLYre?=
 =?us-ascii?Q?E4f59fEmrnDGVDqeV2hTIRCpeEA6ErhQfLlogFIoYmNrmEn4kW4tOppMBcPl?=
 =?us-ascii?Q?09KWX96bEfsXTMA+v8vBSH/BYxy/OILSkC9GDa0GOo+IO3RxbBnMnvnJdmsf?=
 =?us-ascii?Q?1T7ZqW2pwLD86YG3OmeEkX/fIw4NZmO/dk89EaHdrUFhD7h4GiS/3jNk+7YI?=
 =?us-ascii?Q?JgZnvX+JNK/c2scKSDw2NZkG2mKfjaP/hPyCov+8pOkpXW+lMqZmojrga1Zr?=
 =?us-ascii?Q?D8J0pdDtkNHPJ9t2qbTFQk9phrgDkeWIkQFyREBshZqv/5Mt7AlNI6wDSjLT?=
 =?us-ascii?Q?lB/jUTo+bgKeQH/jRPBsUG+5fBUsCSnKaX2wnb9a3zIty7wcmdewQhK/H6jh?=
 =?us-ascii?Q?RTWeBIN9rFvnc/1q0WN5XKOhgWJE2UFVyrECqpCI0luSdsnn+CauV0mzHbiA?=
 =?us-ascii?Q?6wYBZFryLMiKtq6oYlj/rvC1B105i7k5hpzu50jiOjlU6ONlJolM271W8C2G?=
 =?us-ascii?Q?XoZjLMnT5n2D1d5LtrYDx8OqIibdLZBYaspQzzT3HIfyJl/5mRx+5+/i3M2f?=
 =?us-ascii?Q?ZsUAlF+HzLz7MeSvqI2Pok4UrjaVk4m51U9cSge8VAMCDCkJli8pEv8lUPbd?=
 =?us-ascii?Q?+8bIgwORm+rOkR8ymyJT+6R4yUPhgkhNPLDSghuZwXQr3+0SlFxI5xo29tlz?=
 =?us-ascii?Q?pKY5BKstkzjg6NNG6wDqtLZcVLlJy4jlFFSco+YwE5XUYCzPBC1qWIjtC7tJ?=
 =?us-ascii?Q?0yXPCpwMaLkr78WWjo4lKVCbaFV2nWenjZvVKoN08R36shhQhgHIMlHoZtwh?=
 =?us-ascii?Q?MkDkwhy4tcOwmQazYzCHLGZlT99SdbCCTBto0JhDIOJlt7ZBZgptOR2z293T?=
 =?us-ascii?Q?xLLjAw4rv0iY/IQqOAvpHfJ+5ZQPplXQKTD5zOIb14PTJl3rigY7htRTLL55?=
 =?us-ascii?Q?qZgeyyNtyBGhrYXaq8b83aDLBetprfZ5hbVghHtriqgc4bXu2/ZOv8zm1KS/?=
 =?us-ascii?Q?HzdFCLCMLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df9fd32-c67a-439a-2602-08df188509b8
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:38.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2j6r9fDN4cuJ8sDLuQinbyWdwl4ytUXI5YTETDM5uGlweLPRXnKxjRMkGdAkmAsEWomph8cBX6NN3m1esUxDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

Move the common decoder declarations to include/cxl/cxl.h for use by
shared decoder settings. Preserve their layout and documentation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/cxl.h | 37 -------------------------------------
 include/cxl/cxl.h | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9e0500d56866..44ff3334648c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -264,45 +264,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
-enum cxl_decoder_type {
-	CXL_DECODER_DEVMEM = 2,
-	CXL_DECODER_HOSTONLYMEM = 3,
-};
-
-#define CXL_DECODER_MAX_INTERLEAVE 16
-
 #define CXL_QOS_CLASS_INVALID -1
 
-/**
- * struct cxl_decoder - Common CXL HDM Decoder Attributes
- * @dev: this decoder's device
- * @id: kernel device name id
- * @hpa_range: Host physical address range mapped by this decoder
- * @interleave_ways: number of cxl_dports in this decode
- * @interleave_granularity: data stride per dport
- * @target_type: accelerator vs expander (type2 vs type3) selector
- * @region: currently assigned region for this decoder
- * @flags: memory type capabilities and locking
- * @target_map: cached copy of hardware port-id list, available at init
- *              before all @dport objects have been instantiated. While
- *              dport id is 8bit, CFMWS interleave targets are 32bits.
- * @commit: device/decoder-type specific callback to commit settings to hw
- * @reset: device/decoder-type specific callback to reset hw settings
-*/
-struct cxl_decoder {
-	struct device dev;
-	int id;
-	struct range hpa_range;
-	int interleave_ways;
-	int interleave_granularity;
-	enum cxl_decoder_type target_type;
-	struct cxl_region *region;
-	unsigned long flags;
-	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
-	int (*commit)(struct cxl_decoder *cxld);
-	void (*reset)(struct cxl_decoder *cxld);
-};
-
 /*
  * Track whether this decoder is free for userspace provisioning, reserved for
  * region autodiscovery, whether it is started connecting (awaiting other
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..69941f7fdb76 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -5,8 +5,10 @@
 #ifndef __CXL_CXL_H__
 #define __CXL_CXL_H__
 
+#include <linux/device.h>
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -23,7 +25,44 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
-struct device;
+struct cxl_region;
+
+enum cxl_decoder_type {
+	CXL_DECODER_DEVMEM = 2,
+	CXL_DECODER_HOSTONLYMEM = 3,
+};
+
+#define CXL_DECODER_MAX_INTERLEAVE 16
+
+/**
+ * struct cxl_decoder - Common CXL HDM Decoder Attributes
+ * @dev: this decoder's device
+ * @id: kernel device name id
+ * @hpa_range: Host physical address range mapped by this decoder
+ * @interleave_ways: number of cxl_dports in this decode
+ * @interleave_granularity: data stride per dport
+ * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @region: currently assigned region for this decoder
+ * @flags: memory type capabilities and locking
+ * @target_map: cached copy of hardware port-id list, available at init
+ *              before all @dport objects have been instantiated. While
+ *              dport id is 8bit, CFMWS interleave targets are 32bits.
+ * @commit: device/decoder-type specific callback to commit settings to hw
+ * @reset: device/decoder-type specific callback to reset hw settings
+*/
+struct cxl_decoder {
+	struct device dev;
+	int id;
+	struct range hpa_range;
+	int interleave_ways;
+	int interleave_granularity;
+	enum cxl_decoder_type target_type;
+	struct cxl_region *region;
+	unsigned long flags;
+	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
+	int (*commit)(struct cxl_decoder *cxld);
+	void (*reset)(struct cxl_decoder *cxld);
+};
 
 /*
  * Using struct_group() allows for per register-block-type helper routines,
-- 
2.43.0

