Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E692E7386;
	Sun, 11 Oct 2026 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684884; cv=fail; b=qI7grD0YmgB0mC/6dvXFP/AN4WT8oHXMuNA02uhjhVQakeb3KDQmu9C5nYFNldfGqO/nf5ESj+x2PmARNBRvQ+tRP6Qmfxzau3r9zN39KWEb0vYNP4RgsAyVjywtSutgsU00q9e7p2PwJY0A7oIt1AU9fSVVhU76vwYXjfYec7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684884; c=relaxed/simple;
	bh=UMwJP+FRrd/CUOFdtQPTlSHV34SEI8v/MGnuplcJDrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H8jmQZqHu+jwHRX9edDWDsuBDjPClZv9QBWI22pDZxshLRYWxelbeLEz5Dg3ciWof6r/zQCWAM91uxurHPHGpBtIHaf+ZNNFAWLBnOURJa5VDQJd1Z/ciiwf+R7WsPebMgfl9RHvlt95FuLWkHhTlUPQaQiTA95BLanTQyZOC+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ImxQPWHN; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ImxQPWHN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPpDWt3K3L87F0qR6Ct94GZL9xmNQFQThCx4gxsy4QfwiGWSiyNX8QtmphQOY0gEc2uGbvs+pa7qEHWPAeOLM/rGvYcO+NPC48Xq06gs3uyKKkKAqihxfOTxHaViU7VRgG+nkxDe9H0O7XXaID5Tb5e0J8OSFU9xVOPAco8V8q4SVbsOoCHCsyueIKinyhZfGXyHO31bGLoD/caLaMLFwTkHo0TZEQoiv1LKCNQLywC9ykIuYLlBGhltxWRKFApjyWAA5kI8jK1Fn5Z7ny96mI12FK0i4Hnj/1eTAsPdwPnijjqGahswGVwoYgwSHLhKLx8HzG/DwSLGQ6nGSxXSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKhj0pOddSB02LvjjFEDVnuCK/8oYuVIhul3J2cdc/M=;
 b=EPIpcbvl9zDt04g4bIkVXL8EOFLK/bJxySJrxZGSXYRiCWttGa398gDa0kUHDxIGFUF8Y3Im0wxJdtF8ApmzRC0JSkrn8s+Am82CE0fIkHY6BcLlz0OxznfDyVzOj0CgY6AGsl+NwehBiPI8nGDOVrMRCZFyZQCdWRXsXxIukxr8o3FLgT6VbEe3/K8TX22E/VyeQlfTvizr6l+USrA19/LuN0xvQC2w7JKcX7cC1nLHghOpVRTOtxWfUs9NsU5ZqrCzTcy/q5ewiUDdnQJOXA+XvCtRXSZJeClPv2Dinv1k498FLOYw4xkPe/dr593PRcKdo0blTWow5vgCTn4q5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKhj0pOddSB02LvjjFEDVnuCK/8oYuVIhul3J2cdc/M=;
 b=ImxQPWHNqD7dvEXcoGeuyyn2c0Fwt8xUoUYeyUPAWKy4RNBENP1/ws5/Ife/xZFkyg19O+XLy71FQIqycuv4OTHDnlgM0pV015/2QK/hQA/3uAaWwlD14eAu8mYkr5bBwF23I/pWg29qoRR4RPcRAQEIk5qRhYNOfOPjTpXl0JYgv3DOb8AoLfc07E1hV2K4LPwRh0Oc3a6gW3i6ru4PBcrG87gMNZj7NoO3oyh3VnGjijif4IcIGZIqLltm3ZZm8hiG18asYlZ2qmWICcKlP/tKK5sltLsNxGZnawjElcFYdJEfmYg8y2WaXxme4mPVsINGJXTcbyth0zxFY9CF1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:37 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:37 +0000
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
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v15 03/16] cxl: Move decoder declarations to shared header
Date: Sun, 11 Oct 2026 02:14:09 +0000
Message-ID: <20261011021422.3428136-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:303:6b::17) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f1a4e4-d715-41ee-c889-08df273d6616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	RcSREIGOlrLMOExXR3m2HTxwTueZ5Ze5lBqDLDFzYMBVfET0qdGSZf1vrqYMt/Ja7iaZylbHS7v7I9ISe+ZVztgveU7t5cQQm3oodlTsjZwzxDjt4r0RBE06pniO0m3YgUJgL2f8ILGHpHRwX//t/4KoPzzG4DIENy2DALqymcbgDaT8gxIrBXe1L2kJURAr1O0irTxuKmtUzcHEMpEIS5cemdV8hkwv1CPJesL2aISlZxGn2Uctw0ofIwJ4RxbHjDtWH1Uec3f/zCKjEw7nqlEthmFuUKPpAgFBkv24vajX/wzuDBdrVKHBUdOMTW/9EFp8Nak+QcvsXMYD/i7zqohR6CToGovg7S7BbsmDH4dFkB57nnKgcJGnKNI5CK2MxtlmbCGVzd23AyRw83rOe0krsBJV7LJS6DFwQcL0a/tAX2Tf2YP7WGhqgP1yFrr5PCSMgLGdubzWpt3vYPLYDRxdR7xk4ntjLHH2IWPFPCWx0PD9q7Vz4nsdlijcks++2s/q2RUEE4SBMHbq6UZUbT8FXPKQBSeeeSIK1m27KbOTJsci8qowdOEFO2gdLbz4nXE+Zf7X9v4IXcxmaI35QL8HmPq+eRCeL7cj2eePSllTJQx4RGgKX8k87ON6V3aBYFSnLcB3W4YHgsqbL1COdWPc7Ywqk4BqVJwpxiTjDGi3roBxBCaXXL/nzyOhHQfrJuQ3gSpfbfLzZQRTvHaHCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ivX/s0UfX6JT3ieYNClO/HzVTboJ094B50cwif5rO5YlbAEqp0dS69pzlsG?=
 =?us-ascii?Q?OxkT6dMA6iTMvESPMpDgjBf0CDpzH+eIsqMAMQtwtutNTOLnYk4kmM2Y2y2p?=
 =?us-ascii?Q?PSApOJUoF3aZZJEhvrR2TFpcYSVI/UNG+4cmCWQBS2nPSNsp7lQnK5YQDUSB?=
 =?us-ascii?Q?mSiIQuWn1UyhNR9/Rmf8/vlp3qe46jWqImChYvNg460TlYiOvSeuMqILe3H+?=
 =?us-ascii?Q?lTPrdXLbwT38Vy6Kz3D67clnLfCTirEaSyqCC+3O1Z+KmeawJlzIDhdh6w+6?=
 =?us-ascii?Q?g1ZEybO9yA+EVSfw682LFE1bXF115lgZGNfMTPZ38BWb4PktHdU4HHX/jP10?=
 =?us-ascii?Q?Bwc45fJleh3/O2u0AYCLZFzGIEPVkioUn6ulHwx1lhBSH0fk25KZrkucRrK3?=
 =?us-ascii?Q?rOKbyFVv+84hTAtAxBZ3keIjm4WvXgxSadzMRXKtzshQPqklQZIGRLEQw8fT?=
 =?us-ascii?Q?0A9Hcg8PMowQ2NcYfvsGzhHMvYXSmt1FsEmszVt4gnodGCgJd5jRQTlXax9M?=
 =?us-ascii?Q?JNM/oban1QeR4786CK129xNwrgrp/a+cOZlYZpR5O/8BGlcQqnhiAaMDVuz0?=
 =?us-ascii?Q?owajxWnT+WZpo6NEhxrl7We8gVideUfanROVxe9yiRr4WZ30JT8Q9HPLguxp?=
 =?us-ascii?Q?5bUMVqNE8k4C0/dvtvPmfz/QrcXdGrM1g33Yu3omKOftYpkFnkxq6NrU4m9y?=
 =?us-ascii?Q?EkNvL/1kngaRxnwBJnqo/+yxmaG2wsYYmA74f+RiIeIGIMgqPK/F3Pro+LhX?=
 =?us-ascii?Q?3kXPDyix3M0Oxc7dNcvVkBH3anmiyU7UutiJOjrBQT5KxcjDScwRqhuh48UQ?=
 =?us-ascii?Q?7n+plmhiY65qLIHPgFuHzrQ18jseIEqR0SNfECRa7TtZyRtGtK4+7iKQyRyc?=
 =?us-ascii?Q?Fa/OVIKUApT1WAnMN7Y2jANtFJwqtEmOS6HV7IXK4TiJyVrgHYxrx6D+/Cnt?=
 =?us-ascii?Q?+Lnj8Nf+4LlIc9nhYpTdQNxiuwZJSOadRQLIYJ290GwrD3bn7NUMoEnGaGBd?=
 =?us-ascii?Q?vxJMwanZ9slTb34DzG+dE7drqwglCKDEr0Dx+N0770pn/bOTf9xZg/nHnMNq?=
 =?us-ascii?Q?hoes4Gms5tiU7+K3ZSJF+tPNEKoywM3bYHe06kFewNsUTIFmvMa907aN87U6?=
 =?us-ascii?Q?eP5/iIhWkr44xuFJEnmuhkyC67VdlC9N1D3aoIJ0bviKiody2FaQLCaCb6v0?=
 =?us-ascii?Q?/DW9ohrNun+2kHoe1WFbwHu/bCbjgXKg+3tqjpAQW+QG5jf/2WDJIfmyhK3o?=
 =?us-ascii?Q?ReW11tpYV2k/k0feyely2nagPfkNN5zrdAdlDb9eIkHt+SITZDnxmz+Rfe5C?=
 =?us-ascii?Q?K2a3+R3cn0VbGJXmZZTBcpZqtV1G1y/u2Mc+DjIeMndHmRFE0VYbXxCaRxB5?=
 =?us-ascii?Q?MySIsO4f9OlGFqTgFltK+83aGkmW1lmnW+ZiITsNREntJWMLIKWHULrys5kB?=
 =?us-ascii?Q?UkbGNLZ48bhPneQI7YO1tYP6sz81j0Jv2SuVeVvdmgIXPoXKHkE5zKnEbXTv?=
 =?us-ascii?Q?GWunwoDa65dZle2v4+MIkY8nmvWFc+Uov4MVSjUdVXkIQKmlpAgvh/ZgQ/Mk?=
 =?us-ascii?Q?qvGnPdFz6Afn+9TECbRjnljYEM8FJDM5c59XovIPPOaXhQ65GbZSvo2BpeQK?=
 =?us-ascii?Q?PxtpeMy4u+ukfg6nM4uVBlrf88SIpOTPa7z9mE/2wds/FErPDY92A4qMmmU6?=
 =?us-ascii?Q?MvgaPDHZkxt3rfQ1RImYDkGK1dOM2g+CQ0MY9aLad5blRxxyOAEMEGJch03Z?=
 =?us-ascii?Q?TVByv8kfhg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f1a4e4-d715-41ee-c889-08df273d6616
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:36.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxwyPCyXMFgebBkC/MOtXgTjagaEYbToIzxQRRwrbe8US8+0T/HkTqtYrFbRf+2bAOlkoBeJq8lDxcDLJFkMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Move the common decoder declarations to include/cxl/cxl.h for use by
shared decoder settings. Preserve their layout and documentation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
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

