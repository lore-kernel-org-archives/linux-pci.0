Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9C2FFF81;
	Tue, 23 Jun 2026 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185123; cv=fail; b=dobShgoCv2Mjl5rTU/hkwqnnlDh6YuHKAc5WJjV0vPJpmoo64psHYyLpOwzTaQBmUz1gl/YyN13+F9/2Z9von/ZlSk2NTv0py6/ClBljVXRA2f3FIfK4HZZg72LxgLxuoEbbFwCHESbelY348bfAp6lzbrP/nSUkwm+O96TT8kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185123; c=relaxed/simple;
	bh=XfWwtIIArK9gW3VTLxhL2273/gCzDCR6r38gSM8R1w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=racVShVSFuSzVCHZy3lSag/dFKhl3DybeTrCB559IQY4QLL+/QUfkgttCaj74ahLdDwIab3mpYUltGbJ9v7EfqaTzPzte5nPEmUfCWQFYY5wi+4SrmXrLDCNGnc5eLuS81gyDksjrp3f9cvFYrkqB8aR6H99ufkvK3XHjRnFrzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p7dFgMqQ; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p7dFgMqQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVIbfQM8YHwzC58ppmbPmOGpBLNlzUKYsRX35WO7owznvueiV5m4HraClitM9BKvPDA0watY3akono1Gu5fTm2YU3KwbYtyEjCgFlem7YXNFlCQhC6q3++iQAZbc7/wTtoF8tbUryxgaZItpOGt/Vhp1LYbJJ4eVlN+yKo1OwYHxGSqx0EHjSBv0//X/wkS56fjExYQgjNl6jzpqbZxRReIurvhqCfNR/TJWAYqgPczuG42s2yGhlqDd+YW6CrY0z22MEJ8rqUOtpW4SUrvQc8DavfhHsVVWHxZeDLPdUi1nmVO/L6XSx21RZy3vGE0GeB4Co9wmFv76RzHRD8zLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaAWq4hKFq7EnCcJ3KQsVwVkdl74j8aXOJjnJt/pPq0=;
 b=EtKECiOkhAD0lUl4q9dZqIj8HikJHl6mSJMszRzd5thvKaqnMfGy3m8Xc0SecvNboQVEwMnOY5iSV+zsr5lKfRjf6Yo/fRxuSugB2Vebnada3AzolDHCuz0E6eRnHe5QgG8OoIHVYk85San+c+9D9+d08Rw0qvLrrex7OiIv5vkxYiIh2umE5N26v9eUGYVsVKAKOStrBfCazeZaCGSEpA92UwymQqFUF5wbROZfULTQVA8uvMOxXO03yt9672zw8Fjo6CIsbUNFNlNJNGAfLuThEYUdKwfnR3nQ/bgrH7Nh7D3+qE5L3Yuf8a7GSi+ozdDY+7kFluZgJprgLq/rNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaAWq4hKFq7EnCcJ3KQsVwVkdl74j8aXOJjnJt/pPq0=;
 b=p7dFgMqQfuQ9JWorJJWCXvekJnTEyGI0x5DwoWgt1wfDkEe/BZDWv+9vGtVg8s1fkoZJcnJOW2VWFKk+skoCmEXAUyuPoscuLwzJQJE3AmbcAJILZWimgsnAz2YAXDCY3dPlCST/4wb7oyQ68O2lFNpih6WGZ4iDjox9fJmi9rS1kosWchmhQEaw60p4dAyd5RLeTpUmOzn6f6BPdOk9rLKbS40xUxB3R66Mbcd4SeIHiLvM4TmXCVVs8qfveRdc6iVKgDIFCwajti7DG2fDXBv+g9asHsMob6wHcCFWjzkyw8RNiH1KbzORXkVMY8w+vrswDPMJJmhoPQBaqGGJeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:25:16 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:16 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v7 08/11] cxl: Coordinate sibling functions for CXL reset
Date: Tue, 23 Jun 2026 03:24:50 +0000
Message-ID: <20260623032453.3404772-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c605a0b-7507-47c4-a177-08ded0d70b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	Ryln12aYtLkffAzlhAOZnNCn5itF+f/qiB+vxbDQy+5uWKGQnB0OwnYX2V7XDtVohHv1LtgGzI/b58TGLcUYpKgLuPBTcnHpt2kpJwIpBHw1gPRLSrTyPaimLld7UlI6ySuT2OOUEweqYuIbrLNPno4amSjbsjYJU8HL+uKDztCOSNfx3W6dy5dv8qoFkqALmzQnT8P+L2ApGtAUi1R5B4aH8jNvAbFpV3yZY+iNzqHmLIZJ6ncwHuqXg5tSsKRAcYgeqj5ykZok99/6GayWt93BzwAstztCdStLczZCU2oTkVnBk5NgeWMS51PLbyp1SoH63obLI2FYmfHX95AHY2BJYg+Zm1v0Oiq/n16zXQKxDYOQpDSrrnn+B1YYQquW0yo2dItclyV6i8hvpucMNl0fPJHG/QxOX4HD6Kmsr0HJ56Oaho6V2FJ/0dZtfpV2Ki74NkE0bb4feIxvr3Gp7smAdzPvOha7RhihsDAPWJQjR48injltqLhH1hxzu2II5CLVwNsQzblgOaC+2ddnHR44SRJoSpmHRFWUKc59jxLF4rmq9CBRIswiJGimrme/HwWQMo3YfT+11Jqc7+w1/7B5RoqAu+F9bm5m9T4O8LRpFloB3klw4vrgbpOCJ+Mj9/LBMES0MARAszQhh3rrDRFHkJN95nvRP0WN9tHycx/yfpsGPWPqMm90SleCWp6wQttPJugKx0z37SkophCw0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbiQ8doMDdkjMUtO6uJ44oSWpehbnNRHcM/Q21rdycgVCBVzbwQ40kGY0iMB?=
 =?us-ascii?Q?Eu22osAAzhRhXVBHdwJ0VgZcTAT9avU5MYENN2dv+LpyAJz8/O5Jht7g1wVr?=
 =?us-ascii?Q?xHyrZ3D9aYF/ijoMceQVTFv74AFLlqKcTh/YaJW2c3YeH1BXQxShSXY2N1MP?=
 =?us-ascii?Q?Dhu1BzDY2a80oTPRw5sJZ2UL1//1BKNHbsriKoz/Jg1vvb109NMlAhKIJDBj?=
 =?us-ascii?Q?2GnpzHz/9ui5VgaHlsahMhSc3quqh5Xn8geQbDOZAO0RIoMdEkdoKyw0Tfr1?=
 =?us-ascii?Q?kYJMpCCnPR8C0PNnfnUz51vw83j203mjBdN2ZyLuT8gKUuvQzEm3hA4HQy1S?=
 =?us-ascii?Q?QqH2WGWURNwsAbzfuFgmHsCEpaHM7hQdU3xtxURlbMIpJIKD3y4d82a/spIj?=
 =?us-ascii?Q?xxeinNz0tNDjZPmOMBXZuTge5JjgpGKKafriR4rXA3qsYF0a22R8FZFGphmK?=
 =?us-ascii?Q?PqMv9oOnSF/34R93vLDJ1uD32kZYFO0vHOFXVCoH2m3eAv3e9odLBCfDRtEE?=
 =?us-ascii?Q?TNctbWAMWVdIAweGmGFdJIfPb0o1Pue8HV8eFbnx6hkv4L4Yiu+GGuwcqA1y?=
 =?us-ascii?Q?wvtmUj+rfztW/zcnZQYnOvuEnoqLXir1+LlfslHoKN+f2dBjyFOxQTPnR5LH?=
 =?us-ascii?Q?cM1pjGltwtFWvbxveNZ2z4OaacpoP5HkUCZAMXOg8gbPYiNmE0K5YJRDKu4V?=
 =?us-ascii?Q?kvkzldfY90RNIUCQYHi49r1q0u5yKkRdWqZnI/2BdvX4Pdi5oZkgBZwZvuFn?=
 =?us-ascii?Q?Re1CHdRYZZgEf0tV+HzknHL4c5i6tDqwdAFD5gEVWlxitFuPahvzpOhJNZQF?=
 =?us-ascii?Q?lDTmgC1uIoK3ld+MpmXwnXIMMFcc7z/ZEm6AiCTzL+h0ey13RrzfE9pChGQd?=
 =?us-ascii?Q?XmmziYTiy+lYp+IUZwlIjKYNeKWF5nxEJriT3/amFfabNns5zliB3P3c0HRL?=
 =?us-ascii?Q?/SIeaDPyvQCQDzDaHy2RQu3LFY+aIlnObkNApEL9qsZVF/L+H0/OcHkxbszJ?=
 =?us-ascii?Q?UkU9gyoR56z8vFX1eAmLfALTNSaX91Wo3zRWL/cvbyfkDtRiRXlcYhad8o5d?=
 =?us-ascii?Q?t2pgSUkF10tmJ5z2zfEI7lihmSSKJn89VkBelp83AVksjuymEVe+V8iEIn3U?=
 =?us-ascii?Q?LQYp4NcIRBC5TTZcUzjyeYOsPtGQBBmOILEEHQ93fYjzr/OI4nWKQxXNMAcb?=
 =?us-ascii?Q?45At42amY7TmL7aoUoFoKsClaFCfIjH7PrDNDOjFFjPQ4KeNj1mijQGpYunU?=
 =?us-ascii?Q?5chFhiDq5u2gjUc8e2MxNe2ePPKUQm/wt08ekqcjvoDEA1+q50V5o17c2f37?=
 =?us-ascii?Q?DDSEygRY/ADrAVAy/h0f6gmZf4drV7dW/+Y+cziwUP11QoSk/gOf7tWaHbyq?=
 =?us-ascii?Q?ujULB8VmZpkWXDMRcuGpPsnoWc4K3SINWvqBL1kXW4x1WahOzbJYB78grS6G?=
 =?us-ascii?Q?OOmJxTOt4Vh5PAypVf9qMM8agnxpOTbsHQD1GzPo1N4XPagvq3C5rPW46zpC?=
 =?us-ascii?Q?OodjIVH6tBJ6AY3KP8njhYPVo4b0DFUE/apBuQTcHPxUNH9oSzWeUR9IGjai?=
 =?us-ascii?Q?vNjMHyRRvTHXo/CQfU2d2ITr53HNJ8Y5kzLp33YvFPUKGALPaHkpi0BSaVkI?=
 =?us-ascii?Q?EIdKPo13i5Aovg2mVnP9kTZKNSQWJWmIMTpU6W2b/FgfV07tS2Miy4jD1K7X?=
 =?us-ascii?Q?uz2+Y2/UnvOx1Z1RLky0h4hQklI+w+3kaeLsVHojkovueJtvzILpqMUV1f41?=
 =?us-ascii?Q?YpZ+op1BAA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c605a0b-7507-47c4-a177-08ded0d70b80
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:16.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+QwSgxJaLdhQAB4rRPEo6WC51EITNe89qhRcQv02UKmvy0KaEI4Twatx6FpHtRCHwB7QMKPpg27jtWa93B0/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

CXL Device Reset affects all CXL.cache and CXL.mem functions in the reset
scope. Lock same-scope siblings with pci_dev_trylock(), save/disable them,
drain pending transactions, and hold IOMMU reset blocks until recovery.

Also include mem-capable siblings in HDM range validation and CPU cache
invalidation. Cache-only siblings are quiesced, but skipped for HDM range
handling.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c | 146 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 130 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 1ae714a3595c..69bcfab89858 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -344,10 +344,17 @@ static const u32 cxl_reset_timeout_ms[] = {
 #define CXL_RESET_FUNCTION_MAP_REGS (CXL_RESET_MAX_FUNCTIONS / 32)
 #define CXL_RESET_SIBLINGS_INIT 8
 
+struct cxl_reset_sibling {
+	struct pci_dev *pdev;
+	bool has_mem;
+};
+
 struct cxl_reset_context {
 	struct pci_dev *target;
-	struct pci_dev **siblings;
+	struct cxl_reset_sibling *siblings;
 	int nr_siblings;
+	int nr_siblings_locked;
+	int nr_siblings_prepared;
 	int sibling_capacity;
 };
 
@@ -380,7 +387,7 @@ static void cxl_reset_context_init(struct cxl_reset_context *ctx,
 static void cxl_reset_context_destroy(struct cxl_reset_context *ctx)
 {
 	for (int i = 0; i < ctx->nr_siblings; i++)
-		pci_dev_put(ctx->siblings[i]);
+		pci_dev_put(ctx->siblings[i].pdev);
 	kfree(ctx->siblings);
 }
 
@@ -426,35 +433,49 @@ static int cxl_reset_func_map_bit(struct pci_dev *sibling, bool ari)
 	return PCI_FUNC(sibling->devfn) * 32 + PCI_SLOT(sibling->devfn);
 }
 
-static int cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
+static int cxl_reset_read_cxl_cap(struct pci_dev *pdev, u16 *cap)
 {
 	int dvsec, rc;
-	u16 cap;
 
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
 					  PCI_DVSEC_CXL_DEVICE);
 	if (!dvsec)
-		return 0;
+		return -ENODEV;
 
-	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, cap);
 	if (rc) {
 		rc = pcibios_err_to_errno(rc);
-		pci_warn(pdev,
-			 "failed to read CXL capability; cannot determine reset scope: %d\n",
-			 rc);
+		pci_warn(pdev, "failed to read CXL capability: %d\n", rc);
 		return rc;
 	}
 
+	return 0;
+}
+
+static int cxl_reset_has_cache_or_mem(struct pci_dev *pdev, bool *has_mem)
+{
+	u16 cap;
+	int rc;
+
+	*has_mem = false;
+
+	rc = cxl_reset_read_cxl_cap(pdev, &cap);
+	if (rc == -ENODEV)
+		return 0;
+	if (rc)
+		return rc;
+
+	*has_mem = cap & PCI_DVSEC_CXL_MEM_CAPABLE;
 	return !!(cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
 			 PCI_DVSEC_CXL_MEM_CAPABLE));
 }
 
 static int cxl_reset_add_sibling(struct cxl_reset_context *ctx,
-				 struct pci_dev *sibling)
+				 struct pci_dev *sibling, bool has_mem)
 {
 	if (ctx->nr_siblings >= ctx->sibling_capacity) {
 		int capacity = ctx->sibling_capacity ?: CXL_RESET_SIBLINGS_INIT;
-		struct pci_dev **siblings;
+		struct cxl_reset_sibling *siblings;
 
 		if (capacity > INT_MAX / 2)
 			return -ENOMEM;
@@ -470,7 +491,11 @@ static int cxl_reset_add_sibling(struct cxl_reset_context *ctx,
 		ctx->sibling_capacity = capacity;
 	}
 
-	ctx->siblings[ctx->nr_siblings++] = pci_dev_get(sibling);
+	ctx->siblings[ctx->nr_siblings] = (struct cxl_reset_sibling) {
+		.pdev = pci_dev_get(sibling),
+		.has_mem = has_mem,
+	};
+	ctx->nr_siblings++;
 	return 0;
 }
 
@@ -479,6 +504,7 @@ static int cxl_reset_collect_sibling(struct pci_dev *sibling, void *data)
 	struct cxl_reset_walk_context *wctx = data;
 	struct cxl_reset_context *ctx = wctx->ctx;
 	struct pci_dev *pdev = ctx->target;
+	bool has_mem;
 	int fn, rc;
 
 	if (sibling == pdev)
@@ -494,7 +520,7 @@ static int cxl_reset_collect_sibling(struct pci_dev *sibling, void *data)
 	if (test_bit(fn, wctx->non_cxl_func_map))
 		return 0;
 
-	rc = cxl_reset_has_cache_or_mem(sibling);
+	rc = cxl_reset_has_cache_or_mem(sibling, &has_mem);
 	if (rc < 0) {
 		wctx->rc = rc;
 		return rc;
@@ -502,7 +528,7 @@ static int cxl_reset_collect_sibling(struct pci_dev *sibling, void *data)
 	if (!rc)
 		return 0;
 
-	wctx->rc = cxl_reset_add_sibling(ctx, sibling);
+	wctx->rc = cxl_reset_add_sibling(ctx, sibling, has_mem);
 	return wctx->rc;
 }
 
@@ -520,6 +546,69 @@ static int cxl_reset_collect_siblings(struct cxl_reset_context *ctx)
 	return wctx.rc;
 }
 
+static void cxl_pci_functions_unlock(struct cxl_reset_context *ctx)
+{
+	while (ctx->nr_siblings_locked) {
+		struct pci_dev *sibling;
+
+		sibling = ctx->siblings[--ctx->nr_siblings_locked].pdev;
+		pci_dev_unlock(sibling);
+	}
+}
+
+static int cxl_pci_functions_lock(struct cxl_reset_context *ctx)
+{
+	for (int i = 0; i < ctx->nr_siblings; i++) {
+		struct pci_dev *sibling = ctx->siblings[i].pdev;
+
+		if (!pci_dev_trylock(sibling)) {
+			cxl_pci_functions_unlock(ctx);
+			return -EAGAIN;
+		}
+
+		ctx->nr_siblings_locked++;
+	}
+
+	return 0;
+}
+
+static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
+{
+	while (ctx->nr_siblings_prepared) {
+		struct pci_dev *sibling;
+
+		sibling = ctx->siblings[--ctx->nr_siblings_prepared].pdev;
+		pci_dev_reset_iommu_done(sibling);
+		pci_dev_restore(sibling);
+	}
+}
+
+static int cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
+{
+	for (int i = 0; i < ctx->nr_siblings_locked; i++) {
+		struct pci_dev *sibling = ctx->siblings[i].pdev;
+		int rc;
+
+		pci_dev_save_and_disable(sibling);
+		if (!pci_wait_for_pending_transaction(sibling))
+			pci_err(sibling,
+				"timed out waiting for pending transactions\n");
+
+		rc = pci_dev_reset_iommu_prepare(sibling);
+		if (rc) {
+			pci_err(sibling,
+				"failed to stop IOMMU for CXL reset: %d\n",
+				rc);
+			pci_dev_restore(sibling);
+			return rc;
+		}
+
+		ctx->nr_siblings_prepared++;
+	}
+
+	return 0;
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
@@ -716,8 +805,9 @@ static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
 }
 
 static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
-				  struct pci_dev *pdev)
+				  struct cxl_reset_context *reset_ctx)
 {
+	struct pci_dev *pdev = reset_ctx->target;
 	int rc;
 
 	lockdep_assert_held_write(&cxl_rwsem.region);
@@ -726,6 +816,17 @@ static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
 	if (rc)
 		return rc;
 
+	for (int i = 0; i < reset_ctx->nr_siblings; i++) {
+		struct cxl_reset_sibling *sibling = &reset_ctx->siblings[i];
+
+		if (!sibling->has_mem)
+			continue;
+
+		rc = cxl_hdm_ranges_collect(ctx, sibling->pdev);
+		if (rc)
+			return rc;
+	}
+
 	rc = cxl_hdm_ranges_request(ctx);
 	if (rc)
 		return rc;
@@ -944,11 +1045,24 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (rc)
 		goto out;
 
+	rc = cxl_pci_functions_lock(&ctx);
+	if (rc)
+		goto out_unlock;
+
+	rc = cxl_pci_functions_reset_prepare(&ctx);
+	if (rc)
+		goto out_functions_done;
+
 	scoped_guard(rwsem_write, &cxl_rwsem.region) {
-		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
+		rc = cxl_hdm_ranges_prepare(&range_ctx, &ctx);
 		if (!rc)
 			rc = cxl_reset_execute(pdev, dvsec);
 	}
+
+out_functions_done:
+	cxl_pci_functions_reset_done(&ctx);
+out_unlock:
+	cxl_pci_functions_unlock(&ctx);
 out:
 	cxl_hdm_range_context_destroy(&range_ctx);
 	cxl_reset_context_destroy(&ctx);
-- 
2.43.0

