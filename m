Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905174;
	b=qL36pGWUQlkg+WHhBdy8MiFNEbuttWfhr38hqQ4vyXdC6JQ4BvjrCk1yZsZy0Hi0QcZr
	 f94DGKBSaGmWNAJHUtMWRI26HHq259GY1FukqXuDiuUA9L6J1NoT1RLQRCH/c8q/h/KFK
	 rc9EyqUwieB0gDJPZ0Elf7vLKNkXRQDmuHKCbn936N9zOeosSH7+HdiTdFiFM/1twNVpg
	 0HtTzorWtMh0UI0W1UXiq1eopbc2CpJGNHw7suREjcax0PrNbovVXwXxFf1Jvw6HwvPN0
	 8ZUsmfn3SVVWWfE8uNfgNCrZ14igft2WwBM3E5v9XccYamIX1v2pedSSz0NOPLEeDaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905174;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=76nCmwTZRgYRCe1/OIK5Wc/nOzIVJAakWFcX3FLE5bM=;
	b=1Hla0vf4c2u9eLT4J9ozV9GubR3LABo4rZtixg/6z8Bs7ewNiR8R4FbiY7DTrWPLaHj0
	 /FvUwjPdHzjzuSzjnU1l0d9DPoqvwKf+FvNvr+dmBrHsnx/f/VHctiwRJwZY2pEPKTkwN
	 OGTGfwiC4yrP5Ur6226W3GoKv6tCGr+2dbqh/5lpn/+SAG23kopN7gyFfCMcAj6d3gXEA
	 7TmL5bC93NDJj2oL85bLYF+sbxZbwqN50n5IFmO/y3XQYsqYldF9XTHAlvWr4Xulpg/r9
	 +A8n6757Wq5Ngvv4PeAav3fkGEEMPbfoRphUs+sE8ncUjTdcgifs9jcfY11MHrakJHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BZnWNTPk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.20
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2AA606D814;
	Thu,  5 Nov 2026 18:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F2AA606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BZnWNTPk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LewZh3xTsOYQhveHID7UltkZF0qMdvvMhtxBCTMIYCDP+gVcfnT6W5B9X/wsqCGyBDmXsE/HQ5WhSbcwHnYDWngg0aF1LjI0ug4VLMW1aPY1JVKNnkDiIp+qnGvOOYEDSccD0j1lcPFAaW4QgaRB/D7PY4nKZhr4baOob8+Ro6ndm+oA+NeTxh1K5JZEolYmNmpMKk+NHflnUshBVEcXBVTKZNL2u4138TGmvtPf5fCaocT5AWqnd9cZSvLW6OgumXTqQ8jbCLCRRW+kDbHaCWHf//lBKH21t2ROUGN31Xp38L7GYWYGEDL7flsqEJJ6eIgRjxbxaBNPobKvFkttLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76nCmwTZRgYRCe1/OIK5Wc/nOzIVJAakWFcX3FLE5bM=;
 b=LA1F2QrFEiKRN/oayKZRMN1U3blTfmyNc9PZAAjopz7sVAqWQXq7XQmigcUI3DB/ZdXUUIzhq68Mf646aVAtLpCnMKke1+hW1/utZRPlRMWOhsThUmg/JlsQRPm3lTRVSmLeRljxTC/hpwOPz008n8euXFgpsNbq7iia06MeW8M51FqoZMMuEv32uPgCUvIHUuOnxNo9QzVjukog4mA7QoeTyV9iUN6SywFs65ZfVyTARURX2A6zqQ8qp8K41GDuIj+FyS0DmwLXoFHpdTFTBKtaSgI5r9yMIBV+HXoQ9QhcHdwG9YY224aFCgHlJfgz3JAt0/ht45jk72C2BxpObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76nCmwTZRgYRCe1/OIK5Wc/nOzIVJAakWFcX3FLE5bM=;
 b=BZnWNTPk34nGtjMw8r+myYEb7zLPR6/WeXvLaNDAp6e/bWcw+1Pl0vWu7Wpx2DIppCrLnJ0RqtLL0fIOXMfhE/yrmLMvmMgB93BENhJqzi9Bh7sAiJ2T03+8OaKtNS9pV8PT0oiJwXHHr9wo9Js74xO49yYNdZW4x9d6zQvdFj165AtS1ADSPT+xgMKtozsu1Bb1MLveWZEnQNxTNBF8YQvueWx2gGiH70aaTij1XWM2t0T0jloRk1x+5TqKtrNgMDI6JV4Yya7g0B+uX3IEvScJFH3vzZm60IsXvBdI7EMDj+1wEas+xygZlc69AyAsVX6juYpmor2KgNSy1kqXgg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SN7PR12MB7884.namprd12.prod.outlook.com
 (2603:10b6:806:343::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:28 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:28 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
	Alex Williamson <alex.williamson@redhat.com>,
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
Subject: [PATCH v17 03/19] cxl: Move decoder declarations to shared header
Date: Thu,  5 Nov 2026 18:59:01 +0000
Message-ID: <20261105185917.2667656-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: aecc56d9-1087-42b1-5206-08df3b6eeac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261026121527099003|56012099006|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261026140227099003|11063799006|261009223027099003|261028144727099003|921020|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kEtAxiVTb5DRqBUKEB7+tViqGGSfqj4F1otZgo2RwNJlZ8sXmFFZAh/Z8kOMpLmeRDUzgFpWlsL7xjPnH3KvNnelxYiCmh3/vRiqUskwUHsNU7baCuA/cEj7sYev/xSGW3IffHTIDlCjFG+bmvNI4aIiCWPxd6Z7d6WHxUafYVGXN8C7m3VAWdu28tXmzed3kOlV/GOB2SLnVDcPW26SPN5+mbueVaR+uXrvwaNtCljbgJTcs7nZ692x6W9dCwU387xjeRri30Q/tO1JyR61b+p02KeQYseH0w+fD0Sn6ngx2/tE7aLfbgwEqr78xsfo9L64m0hlxg+JFVmyAq8qj0a9Js+JlrKAmicwPCtE/isYe1VgcHrGYOSTx1snj7n9wgp0L8RQT2JfGHz7jDPGmfpQRyQ6PYKjyAG4+GjoSX/Srrw056Nlf/mVBLZ6CnmCYWPdDZiIfQeumbAPTTgSqF0ZoCbd10xX2EO9sCS1KYagjCblhwcImPHaG8zEOm7iXy776dg7MYN57aKKtPU5ai808lriHmcz7xb5SFrHJN2vlxfjHs+UWUi48WdouVX7dwfB+bhAa1mWQhe6jHqLdZr8Y0xQavlHw80Zy+yejebu2D0UcGIUz4K6QBTpZlyFge5nNy4Tniriby/9pbc0OXjfpfbIERW/3Rxg/+B9i2M4CTasCbbJk0ld7Pb7CNUWF4MomMIYEGrO/3cZJpZnKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(56012099006)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261026140227099003)(11063799006)(261009223027099003)(261028144727099003)(921020)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ItUPHFKlzqUhM6+xEfsyldmFCiRwAKRMloOSbnv0yYHfkybOlTTKjXXTEgV?=
 =?us-ascii?Q?9FdNVyJrjM3FDqaPXHoaiRFxfALhE7XTc7mLnSHJWQGlSgfNli/Vl6RBoGoR?=
 =?us-ascii?Q?7IJY0ZAFHNTjUpRv9Pa3sDLakzTl2xfs9wZiTPWGY0cKrueh3r/cTrqUNZxe?=
 =?us-ascii?Q?aCLqNgFf+3F5Jp/FpjWT1CTydUQDke5XmIvo/20L8R5oMWIJl51M3+yx4pAV?=
 =?us-ascii?Q?RUmOwMDuXdckmudy0nDILTPPXDdJZeHytG1qRCKiOnpB59xBTx4caxout+u3?=
 =?us-ascii?Q?BUwTRn+XJJzND7jkR9a9v0XDovGPKxX4Ulk39Srg5FDuZRZsYmGO0rnP+67S?=
 =?us-ascii?Q?b/tyiFERGeOGblKL91tgvhTRQ/GiO5uzXAwj2+ZrQ+3oJH0T4t1JF1AAsaai?=
 =?us-ascii?Q?wgkSv5ImKIjmuiNS81IZ0ZqakxgqqAO581p+8OsJUGDOuxFamMuqjEMAyU7C?=
 =?us-ascii?Q?9a1sBibqwLjvr77Lo8mxey3jBMAVq6yg5WCjFF3z1PLuOz+Z8m7hO4UMXkCB?=
 =?us-ascii?Q?/x2cwnch8NCDPs7JOKWVhOW9tKqGw3Em4/1jsy+YcSp2Uq6wnUkx9lqFL4et?=
 =?us-ascii?Q?4DGl446dkqs6l2rowGZwDYnJlFe8lM0HG2uqH2IcM50L4ZWdKFGsP8M7lOet?=
 =?us-ascii?Q?iwCR9kaK0BKfkcQWncKmA4J3H0hlDwjo7ZV4KjFYMRWEAdzhTCGQ79kgPiZE?=
 =?us-ascii?Q?HAKO8DNvNbnAlznssYjz3mig6hbOdf09OaYP1kk1Jn3caaPFMrugoP+40FL6?=
 =?us-ascii?Q?JB2ppbm4CUSbSONyW/LVuvfJvEvFfbVezIHLTafwTc6y6XMVnVaxpx4V/PS3?=
 =?us-ascii?Q?pb9jUV0u0SSRkDFzdUdI2LFOrT1f4fej6cUkbxpb6qQsrCWWnniwxn2siFW2?=
 =?us-ascii?Q?PepbPNBIJvpuLZSYDGj2QpSrscYIp7EXnSW2Y30nLgYChNh9H4qYQeLMSVz2?=
 =?us-ascii?Q?K7NpDGg8CAqfhOehtHX+AQGtGAgI/6JLZL4a+jxi5KI07BpNZs1ntM00rnGR?=
 =?us-ascii?Q?0nBRMg1WhMCk6c89MPBSJFB+9CQ5l2TYQyjarF9coM8ZCwiigaAJ/xSE1zXU?=
 =?us-ascii?Q?fRTmJBzlTIE7jgFwSc63huc5FfV4ZNn6b2Qcb/eZynG97607hDUcoo6hMlMp?=
 =?us-ascii?Q?a8smkhsyw1JdyxO1567jJZP0WfxWbE/8vouO6nR1iM1jdUAU/aUolYcPvtre?=
 =?us-ascii?Q?LDLdrAuo8FSW+dZd/KC0HP/O2h1pWN6j2kqQjU6Qa3NBlWZRdfUlanb1+3kJ?=
 =?us-ascii?Q?0JAxcjM0EWKskxu6ZHP9tvG1FSl/uUUaW1QjFiLmyIqdm71LqiOFK0ttgmcj?=
 =?us-ascii?Q?aF6S5ZoFJUgoKcKti+ck7ESp/K27Th3Km7GVvgHDScWtfIYRtFel4KbmIGmh?=
 =?us-ascii?Q?V/HQVHg/p9kQShaQO64FpYLwhbKFUSTEdVRikc4jRoeKW4mIAjkrQhTxNWkH?=
 =?us-ascii?Q?2cKkjYAQ9z4reFVe0V4rUyZBNw2SMmMc3V0NBKN+UkZAq2hJJX3du8UapM2i?=
 =?us-ascii?Q?XSedTm82zGhsBiRwXB47sFtOwQ17vPGZgc4fJVVhXCa8cpqyhThdcX9NrCic?=
 =?us-ascii?Q?UuUIKqgJl75QgipfI36ZFhMr+Di0XXS2J2WgjD7tA7KBvjwuCsNmugaSSo8W?=
 =?us-ascii?Q?VAik9njMKU76kb87xRAEZo+4xmpwImVhRG2poBhP2WloMX6uEcOaZUdHUYkj?=
 =?us-ascii?Q?VQ5oWc5XrJWnAJwu4pbVjHSggUgyj7EmLBKjPem7+PaghfqszlV17fP/ka/b?=
 =?us-ascii?Q?HNvShD60lQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecc56d9-1087-42b1-5206-08df3b6eeac0
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:28.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vc0gtxoSuU+WDhd5iLGCXW3wPmP3sbnwQniJ7bxGp6e/AGuW4/p238TCu2bw3Dqm21L8wtbS5W4+3bwoCSREZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

Move the common decoder declarations to include/cxl/cxl.h for use by
shared decoder settings. Preserve their layout and documentation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/cxl.h | 38 --------------------------------------
 include/cxl/cxl.h | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 50af716f69df..44ff3334648c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -264,46 +264,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
-enum cxl_decoder_type {
-	CXL_DECODER_DEVMEM = 2,
-	CXL_DECODER_HOSTONLYMEM = 3,
-};
-
-/* 16 is the largest interleave a decoder can express (CXL 4.0 8.2.4.20.7). */
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
index 802b143de83d..613dab8150c7 100644
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
@@ -23,7 +25,45 @@ enum cxl_devtype {
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
+/* 16 is the largest interleave a decoder can express (CXL 4.0 8.2.4.20.7). */
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

