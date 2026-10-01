Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C44DA553;
	Thu,  1 Oct 2026 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846565; cv=fail; b=EZTamnAGorG7OMGt+cGOv8AsbytKy+KyHEhKAs7g2GmjmjRAeHpxLdDbkwfKK7h/Wk3qjgO5AQk3El4LzuU67wmvcz+2z0RpvEfQ32afmJqtXTWCOL/5+fwl/1O7o1gKm77V2uT6H2Jaxq51PbDEPPhfjCCznFm+WvQo7aVMz2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846565; c=relaxed/simple;
	bh=kfuWSBcpQZfzQFKLFJwB9cKkdxTdie/Vv0KvzOxvSeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCrbll9D3aQLJA8ZQaUq529BFAuheYlxW38blHgRTX4iJulJlhRJDviNtansbbkAVwNe50VWClWGGl947oGzXr2JIusJdQYyS7gmtatBD2Du5ud7b3NHnCDvQw5wfk+w44z3ebNP2sW6WhZ7jT32+ngb+ZL311lT6qvLM9HCFsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fKxelsiK; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fKxelsiK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udbmpZgwRCXmjrG+hPWlIr/CZeBx4Vlx73D9qjpQjRw70w+8+KqJ3XNhTLE02xO38WsI47gzbQ8O5fF9nt9A5Ylg6L+4w41uksjnU6iJXMv/MrcR8knhpDf3OCFkwws5QhfATPhuheU3LdzKNJJM7AyYKhKR9PG21bfUOnkh3wv7nPaTrVdjJySos/lrY3z7nZ3SRD2lUq5fXT979dwaTUA2h4emhjlxV7q1e2IdCnZh8UclsGXt9IPq4ERUb++6FQxRxKqJMYj0L9kNiX3Uw1SpwBP7dzRkq7lpoV+CHiaqo/hWSzVqZif3i03SLHEq/wPfOtflBgQZJX7M8mdaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3OdDiSYmDREnzPaU/LlIhmLXy3Eo5h+QTibYF3cgVk=;
 b=o6uj3aq6jexojB5EtQoiMJZQ2eMIpCOUSKt+fFzmqrXM9p1A9ilxTLzVnRmm3CRQNqXNRtLAbE8J0WkoN7yDPaLg83/nqqGmk5shMgT2U1iHZj6Zn+zxurv+AljtWyY46m5j3dJb9+5+n+qXH3WP+rv2EXKf1f9KAXhTQz3F2NtEFX8UWyj2TF8ZLoDel15wKKFgnLy3J3uzbTF6V+Dz61kz9i12V4LunnLh9hDM9FpPdSNwYTTbM6UsseBrR221DH+ZBbvmPR+SsgG8EIbQtiMMAnyV1K6fSBVYFMcaNKXMFmnytNmgIaf9PAUJJdKiHLhg7xeVX3ShlAzS2195SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3OdDiSYmDREnzPaU/LlIhmLXy3Eo5h+QTibYF3cgVk=;
 b=fKxelsiKUjxPS2Vd613L3MuP+xwQInreQQUT8INprMU3tkahzJ33PuPOByUHKYsQWaLaYAcAQVVJBmu8TgtU8I44HY3RYa/+15nCU400YHZF41/yF1vRiuHgXiMxre/IzubsXpshJqBsKQLBgPAm/lQa4tFhkgBg5wgsn2jGbPdnf3tjElsrx5mJ+CP9zbbXkiVzQFKnhZhvyJ6LpHG8Ufw07/uqJgCRvA59CB0NnuNmbkXbBgl/i9BrEIPGQReql4QdFx64q1wcsTr06Hwz3WSRXz0tpetdKMGE5wvLN9DWFnHb74kO8sgDiNGcE8Wf+Q2F1dusSn1OqB9E+j2MqQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:22:38 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:22:38 +0000
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
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v14 03/16] cxl: Move decoder declarations to shared header
Date: Thu,  1 Oct 2026 09:22:14 +0000
Message-ID: <20261001092227.3004747-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0262.namprd04.prod.outlook.com
 (2603:10b6:303:88::27) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd34d20-3875-40ed-55da-08df1f9d8970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2FbQin+1r+eSKgNDV9Dmw1W2VWA43c8/veiYtnzQcC5wG/uX5cgeQRBOkg0HyCTENYiGroQdkS+S8QrnsbTiAsoZcofhfMwPH6Ep78JrX4agc9HOwS7PmvDdGcv0oaVcg/Br874YauyxtA7ZECtTwEVnUNU40Hjbhp+LuufwD95BKJuYT7fa7PIDrdXbntnX6g1E1PDmATiXcSyr+F/OnKqSUtC3/4N9BpvAmLNg8prxeD26mgIFKH6bfQO3+X6oOoH84YtKM+xt/Yc9FcghV9CgpThbdU7Ai/fbCNU0eds9wC5nJcTXUr8f0/kH1JKf/KXSETE/sxCxEgoJJW1koRgqsBoWa68mqKyxoNk9K2XNq+11khJuVlArG5A/FeuPQhVL7ERGYGGMTrHVzNl6v3qwOZv0NZe9YPHaZZlVjodDYRSh1bX8yg9bIiqWLYjQ3lIgskz5gC+niXBsUU/shL55hSbsrRcl007NFJ6B0hu9vcQpBvEw89y/X8Encp5XxM2cpx9eeH3uSrtWdfMWPaGiSaj1Y8M40cmlc8Cv2b1/qCN6AO0G6jrY5HH2RCybQQK0TFDwlfJvpZkfPmOSDJqvyJL+aw/I6wChknVqDNqGuT0ZFIACrWJAAI14ZM+6ZE4bFVXBGiaftA2T8+AytTt/CppdBnXy6zGnco4G8bu7rUeOOXT3STGhCs7qc26QJOoRlndpCj5KVhvCNZtrwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQEtaudB4clCNKrax089+SWqyDT+xGr5+18neUbykpzy5GZSEra2/viR5IIb?=
 =?us-ascii?Q?GaAVcr3I+qdfR90pnGw9sQq1/aZ+ZSKDExXsrK/6HwZqfWlpbxXuOtdYnu53?=
 =?us-ascii?Q?kQ3XVf6UhdY/LSAJRnRUaT6DUkIRogWkr8KZwOJDZrC7NNCpRR6/HRe6HeFW?=
 =?us-ascii?Q?Oj/ALeTFRSd2gSF48c8gwUU9DTFT5d5Ajsy+Zt3d20jXW0LUhubQp0lYvbCI?=
 =?us-ascii?Q?1dByyMwZO+qIZe+aWH3CJc28qx7XMgXBaGggVRDmydlQxOc8U9Nn15p+L/mz?=
 =?us-ascii?Q?qppPI2qKBNml9Ih19ZuPyykQhMeKgwY6aGUlNjr7muOTsTK3DL1k34QhwO+3?=
 =?us-ascii?Q?L8vtu9Zoy5ygUtBKxWdsFDCvwmQj0uAp75nQolwENr8UdiY1s2+oiN8SobRP?=
 =?us-ascii?Q?kUv09OK2H2MOyL6t2dcJ3l48losAVYxd4pSFeRlWRyi959NeNGVVSP/YCEO/?=
 =?us-ascii?Q?jBDaQUy4XSbP1GUBOcz0IbRl0LXGPhOn20bLBwO2/R0tqVdGWenvaW/NhqL7?=
 =?us-ascii?Q?ZikKlIDespIYZrYMb5PMml2NYqfyMsL4eGTfjph+HeH3NLQuY3RAEjQp2Jsc?=
 =?us-ascii?Q?mr0+yJjPd5zXY8nShoQgKF4jjLSrpkWmb7rh1YvlZOUVMU5Ohth02v8fEPQT?=
 =?us-ascii?Q?r9KtqTQA4jw2SZMIYfWKK2LJt0iEdFKa3hEMiWwTrAaJ49xJQ1hSKRQB71Ir?=
 =?us-ascii?Q?LMjj6A6JX81kAi//ycYuXkejkCWEZIB6CGq+OoyktUJZx0+jaEKgnEcRMHIC?=
 =?us-ascii?Q?wdcymr72Y4VTZPfgtFO5kJHAX0D5t2D8la1SM+6StS387rOSUpyfkBLnjU/8?=
 =?us-ascii?Q?6/6k993T5XCH7X9zgvHL12nYOoRtRjDCsFtXsL8hW1z0QNHfnXod90E2yzVu?=
 =?us-ascii?Q?6991gIsNvamkWTtrbnH0zxJluusUjbOH4LCS5IiQXjHc7dH55fOkCcXWUJTi?=
 =?us-ascii?Q?7wLW8atboaH2J9vc6g0kJtcMXfGh8pguX5ajEWwOjpmgNwYUbkhq1yTihQSm?=
 =?us-ascii?Q?mN/zv8bDSqE3jZpxpNEn90NHDWtmrLarRySD68rQ7eD6U6cS1ZNNI0DgrTpU?=
 =?us-ascii?Q?g1eHFbtwRjqFKDC3xKzg6qTWVs9MtaNvstyQNp9utPr+3cqsUtDF8NR5WwPO?=
 =?us-ascii?Q?V55cmYyyv2pQDfK5FfTDDJTm1oYaL2kT0Sw0sgjzvcTVFL3JbBCRkC4vftJc?=
 =?us-ascii?Q?uP8LhwigNUe73fSB2ORg8P6q49Afi0wz891VgdRIGTLIZ0I33b09yPP6/blL?=
 =?us-ascii?Q?hPR3IQwglvdXeGukBx+IX3OSY35ava8n6NPVyopRDWUY4ddspAIvNL76Vww/?=
 =?us-ascii?Q?qtvYaDs/kw9VfMtCNue0RwfA5avL42FebH/shUroHYT3mDJF5ZbxnzMvTThk?=
 =?us-ascii?Q?YmnOICQGfojBBkdHZ+dJW1jUH8oCd0OLJxhJX3Ysr7MgrpG992wLHsTMiFgK?=
 =?us-ascii?Q?6C2FAvUSLt1VG0ae79uIVxJdcQyV8HIoAZQgLZsmShryHnT3ZzEkWP1kixlb?=
 =?us-ascii?Q?RezsjlfAPcIT/Y2ua9e+5bqtc6N05XPZb5HOTOSpl0I1heBr/WF78qnOFpo0?=
 =?us-ascii?Q?UfJ+i8dCuATtftDYdbNadhxFR3QriRYb/zTdbSJpMB1nnvb2QiMRCl01p8lK?=
 =?us-ascii?Q?u7PP4qHvYABvEezcZBDqXmdeZd29pOJUgzpN/xFXVbXy9jXTC72QxyLU78AK?=
 =?us-ascii?Q?leUYq0VPS/A4kN7aOkhWEyu049qEd1Eu0SndIBagRFg7Tz6CGk1afpYNcaSg?=
 =?us-ascii?Q?w8VqPMQALA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd34d20-3875-40ed-55da-08df1f9d8970
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:22:38.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /m5Z0iYR8GDgw7usydeQ0Ch1k+rYgulRVFGF1SPo7YWEo/384y71pTxqKlUApp1QeFelc/Vp2FX/Hz30ZtMm7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

Move the common decoder declarations to include/cxl/cxl.h for use by
shared decoder settings. Preserve their layout and documentation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

