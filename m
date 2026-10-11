Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111652DF6E6;
	Sun, 11 Oct 2026 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684895; cv=fail; b=J3jRCTp2Sp1lgHWVdweAhq/8dUixbYLp4A63p3/d71nAgk07dspsWff8RHrsjsWkacblZPntxj8dwlO3hduiFxqa1iuhyq3x+l9ElYTlHff9vBEs04a1/YMDzF+xn9QNiquEtuT7J+D2H9rw7x9v2hfbg39SisVjzsh1rKmX7bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684895; c=relaxed/simple;
	bh=1hDihpwqgq04+KpA8gnqCIKQOOmatob4Buuy/SPtTSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ovr0Ggj/uOalliWmwNn9JYPSd1YHsmSc5OblI+qEbumu8LBOrE25QzsJ8i5Y5m0SlrBFk4eFb1F3txiuaqkmZQNR+3/lFyo+prM+tN7cWEbRnP3AUAsyKKfqMVIRWCx5N4uMe3DW6/K3u+ReVtDEyVS0jMkXLoUoRlr8lUJL5wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=udtnfyqo; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="udtnfyqo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0G1+VpKs88OPxM7Xi1bpZIR0mPAcRAb8Bedanag2hVVzugQ/WL6tZWbZIh7rU9E8/UwIYfsGJBqZVaa8n+Drjn5HtKmdi7uLxYMcGg+brKC1LxKlIDKNufHQqux+T2ZWWK5Q0Ye6k8c96pCR+uKZnpL4Ytfff+bdTVJ3tgZ78JaqaBOWvGvlLp7IFi/4y83iolajAJqKN91du4/03VjNF9n6xS/J3OaDB4qGS2d6FkVO9gNZe+Je6XcGmdyMMIzgY7xAVFxsMBfZmU0BG6QBEgEPlrDvmscu5ogUMFIdyYPFM7jiEAkAO/jI9heploU2n3LXVWC+b4M/+UdX/00lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G326+VpLnbJNi7cGpX5FBwyQ39443IDD5RyJAh77bdo=;
 b=dutqVumwLJ3CzamRy3yy+n+7hxLxbk26M3HGsUuka1EO+xNxrXhIsN7n+F8b3/yARzB7B5cRvTQQ38bv2MiJAUH4bCuucf1tHW5Cjz3wxdUWi4zLohEinzepq1xrtQuVY7exuUQfMBTBI7zYqrdGdE1kWpsGFjf77bk/Ms30Yb8OE//hugZsfY15vmTuYsSCqHK8rwwqPzMb6vyVzahzGethkKN8qwFycMh40Y/MemNdP6AR2reuflL9YTflTqm7GiyGAjD+SROa3P8gOI7g+PxJ+AZQqBjQ5ADZDvxBLRLFIKog7AfZgR3eCzRPtfS1xZ8EjaQlU/srLNcX5CqQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G326+VpLnbJNi7cGpX5FBwyQ39443IDD5RyJAh77bdo=;
 b=udtnfyqoUEgIRadaYPOWoI3WGCHlZJyM7yfCMSGLIKb+u3BCq+AdtvySh00zfAAx3jUnrDY7/lPDhGZEvrm8+3G6HidU5a9Vziit2cO7UyZ1SPw29cPbVu7hwhjm3rgWsELdckgBzDzX4jQRinJkACIMwn69K5UDx/AK4XdHeMST1SwxCBwz1il+NHhaFHV4a2TgOpgIhrNrgfMwvu1GcuvTC2W5kwsyCK572zcthytT9YX68fSa3FhsBZ1EKUlvS06YSumNrRYQW5v63tP6AjhHBCGrHrtvw3kWGgK1NZwjS0pHzJG/41qc5P4nogTvljCrXbjDC0XyHO2y4LVBgg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:42 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:42 +0000
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
Subject: [PATCH v15 05/16] cxl: Introduce endpoint HDM decoder settings
Date: Sun, 11 Oct 2026 02:14:11 +0000
Message-ID: <20261011021422.3428136-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::8) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: f816eb69-4b29-44c0-43f5-08df273d6928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+JbXmLpQPYD/GRG06+ECY6fs+F4+Oa380MmlusN6/WYdapsh1XnyKRJgZU9VQQIwnZXStibtZWkL4jyei82c4xY7Q01XgbPV/N9tMoh9CfluivixFZgtTP2j7kz7Dl2VDvxGpV2zh2+sqBaGANk9+kzKgW3569x31dMkYFvGxxeQoa53L3fJys2qguMx+G5p1dWd+3o16NcEeLaHq5VrgBcrS/Tzkl0pMBGypiY3/GapwdHWfDejfZU/XF3LgIUGBVyWoZ+D3KJhPIWNzAtGQ9PWvBPy6ys/vy60i1ZG3CIo03eUlf7RcKBsch5M0EVRSct60XZ5+IFo7/0AFqnPiFKoRiM/30Nk9KzMt7R3mAO/RZZzdalH3Rx+ZJoyWFizo5G/miQbeDW5WKvPnEsvro0diSjdJy93wxQ4Naic+TM20myVCEUJ7zc786RLexGROltSBLwFUGHidwWLJSy5XBoTv08Asb1ZxznCZcl4owpkQH73xOBbY0iPxM/js5oK1gz+jNZy4j/hAGfctvrb+f5dXR0Qb6cDh5ZJEnf/r8Axpb3PAMT2foJsvkVqNtmZesJR3pUqtDMJpk0XoCc4Cvqmltq61eygIqbgJgj4p2gTs9TCTZb199u5iHO1nE7UNHBNOWvxIIRO+ltYAsXCDglnspx7LlmddT4C/ellPgt/YG5qbjEWEht6GUOV5W+pJd/tlExTA0jm/yJosWGxZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6fcnOsLFKK4tdwrI4GWh61HB0YCrDxYeMGvFy1zk94efCc6LT/R10Ro6E89X?=
 =?us-ascii?Q?f8lImFji+QMERtDB+8oYKAU/+6CjRnzvYwiY0QhFzVWqAFyqYzAD1rA8gOMO?=
 =?us-ascii?Q?2r1idEgNFXgdKq6bVLJYJBu2ua2EBQ2qEe55puBk6cdGMZmKP2dCDdBlf4+b?=
 =?us-ascii?Q?kOpj3w0EvmdzZDi3i75/+rdslTE5hUzJO78cpIoEBtdXCMTwlWRNd3xXhpVm?=
 =?us-ascii?Q?HDpS7L7LBgbE0+vcGbBrOAOVICbQP+m8KbH0GQFjNmuaXe7QDne2544yqZr3?=
 =?us-ascii?Q?PuwIcfj2/DSTvcJfYzHCoxJAq2k0LhXnOHtvGN9tmPGTn9sFmXyLMOSVB8wj?=
 =?us-ascii?Q?DO1BfEFWct0jhFQXlBQ4KMxAOH1MFA/tnVZfLX7S5kV9JhgSzXNo6UkCRMNe?=
 =?us-ascii?Q?LBVmhUT0a48QUq3dpBjTU/wFQ06RhCInlHMhirld1xjbpAgLvmurBf1zw/xz?=
 =?us-ascii?Q?59oUKZQ0P0sBJGsLiFaiYm0paA3IBKtiwhLEpFyKC7mVcL2PHuMxs+v9kbRY?=
 =?us-ascii?Q?JgIQzG36kBblkJmOfiJeMEIZ8wYmFbu92KIkU6b4HHi9lLxpb+MeD9c9DvQK?=
 =?us-ascii?Q?pnZmeATelbQB9pRJhkw+rCQAsAocRuYn7mAm60sS0swetI2Opx+FOaKZdYcD?=
 =?us-ascii?Q?pVWxqFJZ2zk3ccLPcBBTzfGHSzc+WzZd0TAM8p2l73wxHs+cLbuLYf4RBVGx?=
 =?us-ascii?Q?uXLDT4WD+j/qypcNbNXrpBAjgFTvRRwepHqU3bpqNgqpViDZBfien8IFlP+L?=
 =?us-ascii?Q?QOkqveHw3VEiAe2fcp7iCULmr4XMwGG/Ymrr0n5woMHkZriETh/8Wu8lQBt+?=
 =?us-ascii?Q?bOf5rf2lN96JxXw2xv5oMSRt6Cl6ZosHIUg5IJJ865PYp6Kwrvc+CwOIx13i?=
 =?us-ascii?Q?O0PM8Kzb8yMuDhkGYic8hGW+xa7uP7JJw9LR2/ZjmksaZ8xJehJVG0BG3GsQ?=
 =?us-ascii?Q?s6YxKIij2wjYyHm3qyQ37pAgRjGBD+v28QdhboPzGn86D0Xj6wDN3vrTRP99?=
 =?us-ascii?Q?u53j+wpHg3VNNL+CzwtEAVCuXdgWujE49uOIyjMD9t0EsFanz32b7TTQHNTf?=
 =?us-ascii?Q?gSFI5tnwh4+0ubaL/tvG81GawFUYCzEz3HN3SOfwOONCiYkuNmABJji66Jz6?=
 =?us-ascii?Q?tKSHFNCLNZAZwHTnoYBnVn9cfcz7Xg8RS6K2hSA9asLO2Goh6r2r2WhGAj/b?=
 =?us-ascii?Q?2ynTcOTLmRtpLCmbO+cjN70GUPLVpIxPVj+nu+RIQoHWpcyyoZsxTwfFUza7?=
 =?us-ascii?Q?SgYVB6XG5jGiE9o68xYjAJ3AXPixapgrY9AHce9LCfgWTNvWKjKIeiXZrioc?=
 =?us-ascii?Q?fZ9Fqhmg1Q/AltXafrMAV6U+67U5QKIVjKCWdlgq5GhUPbN2K8SZwHkTUetA?=
 =?us-ascii?Q?2bJGDAU/YvWLx+nImR8MemDiv3Wdl3GYepX/3Cp15GCg/oeaNcFZPsUuP7S9?=
 =?us-ascii?Q?sBUlIch5h0gujhLBcaFAw5AZOd94Vze/m2kifJHbJ5657AXyapK2756xEGOR?=
 =?us-ascii?Q?7+XJpLRvn2tr1dMyqHzYakv1hmIKJiJE14tHkqjoummjWb2EZAXZcyJzZrfX?=
 =?us-ascii?Q?Nqaem9rBv+1XveJ2Sa0+v1y4BKCcAawTX9jjB5oC9lIiN86dS1ED5YhUVl3D?=
 =?us-ascii?Q?s9/FRLF+XS0JVOlI9kWT/K0IDQAJcM5jkUZrTfx19EpdqGAjLQmZ1OUXlADx?=
 =?us-ascii?Q?qbzfXtlsC+5vDUrMzPrDdVxMOhD/VTEk3QIZuYULyUKecnbPUYfy/s9lZMg3?=
 =?us-ascii?Q?9soiJa9C4g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f816eb69-4b29-44c0-43f5-08df273d6928
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:42.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVsRdAUhR7c27CGjReXzj/S6BPseTJ6g3r3sWAxKD+cjfP51KCu8c4vw7EKvnmORlXgos2ic3dh/5UkmxzUTGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Keep common decoder configuration in cxl_decoder_config and represent
endpoint DPA skip in cxl_endpoint_decoder_settings. Share range
programming, but keep endpoint skip and switch target-list writes in
their respective commit paths.

Separate commit initiation from completion waiting so reset restoration
can reuse register programming without changing normal DPA-lock policy.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=20f9084b5b763238e2f18f629916bbbb46ec9f7d
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM
---
 drivers/cxl/core/core.h |  8 ++++
 drivers/cxl/core/hdm.c  | 96 ++++++++++++++++++++++++++++-------------
 include/cxl/hdm.h       | 19 ++++++++
 3 files changed, 93 insertions(+), 30 deletions(-)
 create mode 100644 include/cxl/hdm.h

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 983d7690c3a5..fb14b222f3ca 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -7,6 +7,8 @@
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
 
+struct cxl_endpoint_decoder_settings;
+
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 extern const struct device_type cxl_pmu_type;
@@ -139,6 +141,12 @@ struct cxl_rwsem {
 
 extern struct cxl_rwsem cxl_rwsem;
 
+void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
+			       void __iomem *hdm);
+void cxl_commit_start_switch(const struct cxl_decoder_config *config,
+			     u64 targets, void __iomem *hdm);
+int cxld_await_commit(void __iomem *hdm, int id);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 9e05032a5426..7d3254a712e4 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/hdm.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -707,7 +708,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
 {
 	u16 eig;
 	u8 eiw;
@@ -716,12 +717,12 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	 * Input validation ensures these warns never fire, but otherwise
 	 * suppress unititalized variable usage warnings.
 	 */
-	if (WARN_ONCE(ways_to_eiw(cxld->config.interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", cxld->config.interleave_ways))
+	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n", config->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->config.interleave_granularity, &eig),
+	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
 		      "invalid interleave_granularity: %d\n",
-		      cxld->config.interleave_granularity))
+		      config->interleave_granularity))
 		return;
 
 	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
@@ -729,10 +730,10 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
 }
 
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
-			  !!(cxld->config.target_type == CXL_DECODER_HOSTONLYMEM),
+			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
@@ -764,7 +765,7 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
  * clock skew and other marginal behavior
  */
 #define COMMIT_TIMEOUT_MS 20
-static int cxld_await_commit(void __iomem *hdm, int id)
+int cxld_await_commit(void __iomem *hdm, int id)
 {
 	u32 ctrl;
 	int i;
@@ -784,45 +785,80 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
-static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+static u32 cxl_hdm_write_range(void __iomem *hdm,
+			       const struct cxl_decoder_config *config)
 {
-	int id = cxld->config.id;
-	u64 base, size;
+	u64 size = range_len(&config->hpa_range);
+	u64 base = config->hpa_range.start;
+	int id = config->id;
 	u32 ctrl;
 
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->config.id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->config.hpa_range.start;
-	size = range_len(&cxld->config.hpa_range);
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	cxld_set_interleave(config, &ctrl);
+	cxld_set_type(config, &ctrl);
 
 	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
 	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	return ctrl;
+}
+
+void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
+			       void __iomem *hdm)
+{
+	int id = settings->config.id;
+	u32 ctrl;
+
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	ctrl = cxl_hdm_write_range(hdm, &settings->config);
+	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
+	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+void cxl_commit_start_switch(const struct cxl_decoder_config *config,
+			     u64 targets, void __iomem *hdm)
+{
+	int id = config->id;
+	u32 ctrl;
+
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	ctrl = cxl_hdm_write_range(hdm, config);
+	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+static void
+cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
+			      struct cxl_endpoint_decoder_settings *settings)
+{
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
+	*settings = (struct cxl_endpoint_decoder_settings) {
+		.config = cxled->cxld.config,
+		.skip = cxled->skip,
+	};
+}
+
+static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+{
+	struct cxl_endpoint_decoder_settings settings;
 
 	if (is_switch_decoder(&cxld->dev)) {
 		struct cxl_switch_decoder *cxlsd =
 			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
 		u64 targets;
 
 		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
-	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
-
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
+		cxl_commit_start_switch(&cxld->config, targets, hdm);
+		return;
 	}
 
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	cxl_endpoint_decoder_snapshot(to_cxl_endpoint_decoder(&cxld->dev),
+				      &settings);
+	cxl_commit_start_endpoint(&settings, hdm);
 }
 
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
new file mode 100644
index 000000000000..219b9bb67440
--- /dev/null
+++ b/include/cxl/hdm.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#ifndef __CXL_HDM_H__
+#define __CXL_HDM_H__
+
+#include <linux/types.h>
+#include <cxl/cxl.h>
+
+/**
+ * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
+ * @config: common decoder configuration
+ * @skip: length of DPA space skipped before this decoder's DPA mapping
+ */
+struct cxl_endpoint_decoder_settings {
+	struct cxl_decoder_config config;
+	u64 skip;
+};
+
+#endif /* __CXL_HDM_H__ */
-- 
2.43.0

