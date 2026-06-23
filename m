Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC9328611;
	Tue, 23 Jun 2026 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185119; cv=fail; b=eRvBZ7508sRvmVnOuhlW8Vy971rrlPwknGvVNlYta3Dde2l12VDx5rbhCGkQri2QpPguGdxIXaK1MA5TzefgbKVp1F+/j6YYVrCcXqrOa4kZBnAWK34G5FlUhz4Ma3+A4yIfKuOt2Nhhk5rv32VslCn1Qb5j+MWX4iuY0UUgXIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185119; c=relaxed/simple;
	bh=s9zEcZd1RQHiE5ntziwFv501wb6CKzSk06mDUXKbQRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPCqZZjL/j2cFshdeT++ybTm668oPaT62+LzaxF/TtH86xSG+8RnoHXKP0cjVISyMJQEXLmbU00E81uv9VrTYwqA/jfrt+W6YO1UP6p/kxQ3Ba2AWzWFGk/OTQCZ8CdEuhNC1KJTB09HWeyMlv473a4YAjOVD9cCOAiI/5jR/nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Juh+gbyT; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Juh+gbyT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzSDcnq8Yw7WuKPjXODdGvaBOHGvxvXNPXBeVzjCiZfF6Fxq9fxNeoID+so8SHYcaKlPeWNFxzu8eLU9Se/ak5tH486hK3G7xS8t198YAMMh6QNKGRz2vIkRvaPjb8B8hCIdrCZDMXq0asY8QvBWQNi1pVCRAy1HSvwQ3DrHknR68NXgSYijt2XJHDEQNYSlMWkPErLNF+i5QS8t70B3RNVFoEeFtQEECyPQvpzQzuRI9XwUA6wr5b2oQ1E6FxKTUOpkhXVmo+8PhvbcpdNoYpPV89v5+H43agPkkvVKibH+rS3OxKT3295ILb4p+vIrC2ZEYbDAwKte13zPbmwPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IFLFMHvTYSKsjVfntAMSRHgR0KGex/BDGBCLFISkGc=;
 b=SWoK1MIUrTYj1GB8uIwN9K9pysdijpElfLL/H1uVOI/Mo2LhD4FzEjXayQ7jgxNPlhyp5nIQRRCJG5l2b9YtIkbTl5qLBuxHAYq0HZ9E2KGsHn3O2ZYsVX5zKvOff/Icg8Oy7XBG6oxYAUjpX0PNVrTLZlwvXQ80U79cI02p90qWYoSoUYEX2besMuPbvOqGZOM2wPOrRJ2A7tCJCIt0FJxaxeHvEa641EaqVh+JndPdvjBU/RPDvYZoI5BZF99DRlZEGMzIEY2YUC4XGBrhlwEN1lKpeqwK6Ax/d4Wht6TffDwj87srvDzn0aew1TWyiawj52xVLfBn1gKQjFp7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IFLFMHvTYSKsjVfntAMSRHgR0KGex/BDGBCLFISkGc=;
 b=Juh+gbyThMZao9jbOn6LxEvT0IhmRU6AR7Onu11fUdy/HtLtqKvuhzokdwGLFJoZFzRapm4u62seE6gp+6DhsxHGHnDcQxF9te7zwD99BFLTfvRa0iP/dRdAR+3tGrk5d0o/8mWhbcrbpiJ2yT0UnbzN1GNJzaSs0H7b+vJgwVhs+iiYtbIdqHDiYVONv/HYR+Wq2E6HjNPGh24BcBLnjdng0sy0C04eKiDTfjUPP8658oznvm2u4m9Hx4zR5HlAx9hIUWUk8xGBzjyYZv8eRYLifrwgZke/ihIBUbICuNuv9gUK+mdv1/R947edq9LKUIMEfiom3goCqcbExTHHrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:25:11 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:11 +0000
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
Subject: [PATCH v7 06/11] cxl: Validate HDM ranges before CXL reset
Date: Tue, 23 Jun 2026 03:24:48 +0000
Message-ID: <20260623032453.3404772-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 058ad2e4-a007-4ec9-c951-08ded0d708af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	wRRKa068mgZ//EM9FqXcHjfCpFMODe4heVmjmhwJLBpvTrN/RARxHHw9UxGBlTCcbDkRtY2DZqtb4yf5jpB8S0RJXx1Xv+XosS1HgSKsTXT9ADKKogEkcRvfZA0p5lS6q6GJIIGGOV79VzPnAd+EbiEum25wjSd1IaCCHCh1CLCWSkPlLlNrYXmfSYoED3Y0SQUwcnQJxc+HVyyn+M6ORUR1fNQPHQ0+WF4Nl4ViypFJa5o4cocF+STMetGO//K5uwCJMNHoUQAe2JEIldrTfk9mX4Bg5tVGAR3jLw/vCmRsaL0gqSm/zWqS/7t3Q/ijZ3WUkTuxr7UC7+DYgW3nYT7HzB1UaKsZFO+vNxtylZZvWgjYZQO5GtdOZBwK8wk1ZKDEfDF+IwMwagXOJdC6UQqC1J/l7+wjELszR2xQh1V2dFb7s/5EN+gDFEglzsg2nouLFnksCh0M7iTbdmmo6NE9raoHNCp0cBT2WHOEP9Oqzsv69y7TWpY5323lIlGW8wMmZozbn0P/X0eIGMPRDjJuYDKWi2Dk1jv71pGqQMdS74IZYqOeWpwz8pbk6vocNy7lawokjRvIRGEkuWc9d4umGPYMjd9LE9veQfwAmy2+juNIf/pBhbyk6xrh/GvL/HdIF7QOzEZOoChqO6NprU5qbtdjdKf4zJq71vmwfdGcylIei+fqBvOS1spfnM/bESZNLQlGFgjX2LHW9dSqbQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bv9FrgYeSKNjmmqCuXQ25Lhd6kpyqzyQgpLRp9x3dwU+uyXx0J+1Rzks6hwa?=
 =?us-ascii?Q?DLwwjBwgFC6kitpbWuqX81plhqP+GjifZhFJiljbRi87OmJP2cc6fbPANjkU?=
 =?us-ascii?Q?XvF8QAhsHxLIjZeK/oTbpoDDZQXBjrGrZv5gxzdtbdpMNMnN5eTCAoq6HxuR?=
 =?us-ascii?Q?kwnM/c+GprggbZtHx0tn6sSREGjv/7h3OFu3euF3U78rtev76OimUdu/yzT4?=
 =?us-ascii?Q?q2m59h0fb5p64lQr1wXzDFtt1j2ArrIwSUcuq84O37N9WRxy+omKcjm/HdI/?=
 =?us-ascii?Q?P6IQ/fCzU2OCG3O/ZB1mAKXZ55mphxNrZTxSTMpRNgB3D/WqDiZGNH3iWr4P?=
 =?us-ascii?Q?dCVkuQUQ63V7RtX7sxY3RAuzfJM7fUl+iAIblDkHUbC2X+WnwAFF/LWi629D?=
 =?us-ascii?Q?aatwQmidV917y6z+wz3kYjUK/s2GlhrZX+xlRI/ommmIyFa4iTbenyPfn3SW?=
 =?us-ascii?Q?PemjPp4M+SBoTskiUAikVDaUHbp3YBtTCJL9UlDzuyNol0xbsw8wPpTJgx0e?=
 =?us-ascii?Q?EokV0E4jFwsHYJ2CUwW2DP+mOQYhW+LxIEtPjq5AM64z7yQFbOwqGFwnXXRb?=
 =?us-ascii?Q?r6Sv8463hAdsjFnE9WfNvSb8ilL6OP/upyRvhwO0df8HeFx292ukowMadWrJ?=
 =?us-ascii?Q?LA6vJ13qD8Ui1cuekocIPn3erYbJy0qlZP3AFxqGhrsAQBz3fN2cC30Es9G9?=
 =?us-ascii?Q?yPL8GYp1quNUpzTfTP5MycqrysOyw77Ho0uRT1xy98GfHlT7mvl+Ag3vPrJD?=
 =?us-ascii?Q?sEzF8NsfESHv+PtSv/j0ZY0LQq9qH6BZQHxEYJdv0cepkZopPn29ktYpXEt9?=
 =?us-ascii?Q?FbbOE/U6vIgRWF7W7tixv8PDK0yj+ROakuFXHj2UIfMnt3bNDfWPC4RxkXG5?=
 =?us-ascii?Q?dEkPvnL8Fad/dr81uVxvdVqGPIcYlD96ktv6hb206KuyXCWFehKmF52ydBx5?=
 =?us-ascii?Q?q8o3Kyb7bOgl5iKkylHYT7Eyq/WscQMhEVnulk+voVLSr5HtXfzzxYqTISgB?=
 =?us-ascii?Q?EdlNXfZrCSkWk6Mlja3rK0LHIcpof/l0xztpDyHnkOpiQsg9i/MJ9jvmsRNQ?=
 =?us-ascii?Q?eyafVOwFbDQKzSg7jQnnZOY1GuPBwFC8IjQp/qCHABxt910hwT4WXHXwpl5+?=
 =?us-ascii?Q?s4GsSMYSG9sF8l90jNCAlfLXryhX6JKC5Sjs3nDiaiu6vGdLuuiGvSdG0APa?=
 =?us-ascii?Q?SHL0twZJgkE4EFuMCB50rNIbAKMaXKCPL/LuDbTU5jwjjbSScBAQpJjvk3II?=
 =?us-ascii?Q?Dg60MMt8KUlA7FH2PuzfFbuySajYagj/10kf86tg5H4eRn33V4hfMpvs4GRF?=
 =?us-ascii?Q?NKL7Mc8ikqGh73hqZqxhEFdWt4e+3RfGeXx/QLC+RbOzQPnj5N0fzYAD7d3P?=
 =?us-ascii?Q?8CYlrnLErDiRSiXRm1kwI5cdseG/waZhOZKm29oOVXOEtsTP53YNHMZPFVlA?=
 =?us-ascii?Q?y+UM0IySUh/ny0Zh9yFEvXJ0QKEAFhJF5rVsRqRaOAbt879RyVSRNDBcARv7?=
 =?us-ascii?Q?bOZO/XVIpe5KyLdiA2Sg80hMwWz9nDagVGkwx8KeMkdh6HuHzHQRLIN6B1iG?=
 =?us-ascii?Q?uBn7EEjUHBAsu47EP6GDUR2EX9kO+IQB61CqoAZa92hrBkCxiwV/yIpj2182?=
 =?us-ascii?Q?S3+esrRa9pO54U2sbVqJSRctbbl+os+MkIKNRmicYSx/zLDOAiWaGXXiw2Oq?=
 =?us-ascii?Q?Kj4dElj40VuU66EYIURe4pqg8qepXzfsD65OAZGwYRnTpW8+zLheIvwVS5wI?=
 =?us-ascii?Q?UUcHhLyCHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058ad2e4-a007-4ec9-c951-08ded0d708af
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:11.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di48NWBdMwe5ubHIQAbfDgh8GTiXrpjvMo7Whwm3Pte3fugdLSWmvRn+MNI7B2QC1V03nSr8E2Uq/28e6DHprA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

Before reset, collect enabled cached HDM decoder ranges, reserve them with
request_mem_region(), and invalidate CPU caches. This rejects reset while
affected CXL memory is busy and keeps the validation stable through reset.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c | 239 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index fdfcc9e825e0..786d1060e40d 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -10,6 +10,8 @@
 #include <linux/iommu.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -336,6 +338,230 @@ static const u32 cxl_reset_timeout_ms[] = {
 #define CXL_CACHE_WBI_TIMEOUT_US 100000
 #define CXL_CACHE_WBI_POLL_US 100
 
+struct cxl_hdm_range {
+	struct list_head list;
+	struct pci_dev *pdev;
+	struct range hpa_range;
+	struct resource *res;
+};
+
+struct cxl_hdm_range_context {
+	struct list_head ranges;
+};
+
+static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
+{
+	INIT_LIST_HEAD(&ctx->ranges);
+}
+
+static void cxl_hdm_range_context_destroy(struct cxl_hdm_range_context *ctx)
+{
+	struct cxl_hdm_range *range, *next;
+
+	list_for_each_entry_safe(range, next, &ctx->ranges, list) {
+		list_del(&range->list);
+		if (range->res)
+			release_mem_region(range->hpa_range.start,
+					   resource_size(range->res));
+		kfree(range);
+	}
+}
+
+static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
+			     struct pci_dev *pdev, const struct range *hpa_range)
+{
+	struct cxl_hdm_range *range;
+
+	if (hpa_range->end < hpa_range->start)
+		return -EINVAL;
+
+	list_for_each_entry(range, &ctx->ranges, list)
+		if (range->hpa_range.start == hpa_range->start &&
+		    range->hpa_range.end == hpa_range->end)
+			return 0;
+
+	range = kzalloc_obj(*range);
+	if (!range)
+		return -ENOMEM;
+
+	range->pdev = pdev;
+	range->hpa_range = *hpa_range;
+	list_add_tail(&range->list, &ctx->ranges);
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
+				  struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
+	int rc;
+
+	if (!info) {
+		pci_err(pdev, "CXL HDM decoder state unavailable\n");
+		return -ENXIO;
+	}
+
+	for (int i = 0; i < info->decoder_count; i++) {
+		struct cxl_decoder_settings *settings = &info->settings[i];
+
+		if (!(settings->flags & CXL_DECODER_F_ENABLE))
+			continue;
+
+		if (settings->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
+			pci_err(pdev,
+				"CXL reset does not support normalized address decoders\n");
+			return -EOPNOTSUPP;
+		}
+
+		rc = cxl_hdm_range_add(ctx, pdev, &settings->hpa_range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_range_len(struct pci_dev *pdev,
+			     const struct range *hpa_range, u64 *len)
+{
+	if (sizeof(resource_size_t) < sizeof(hpa_range->start) &&
+	    (hpa_range->start > (resource_size_t)~0ULL ||
+	     hpa_range->end > (resource_size_t)~0ULL)) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (hpa_range->end < hpa_range->start)
+		return -EINVAL;
+
+	if (!hpa_range->start && hpa_range->end == U64_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	*len = range_len(hpa_range);
+	if (sizeof(resource_size_t) < sizeof(*len) &&
+	    *len > (resource_size_t)~0ULL) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (sizeof(size_t) < sizeof(*len) && *len > SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_range_request(struct cxl_hdm_range *range)
+{
+	struct pci_dev *pdev = range->pdev;
+	const struct range *hpa_range = &range->hpa_range;
+	u64 len;
+	int rc;
+
+	rc = cxl_hdm_range_len(pdev, hpa_range, &len);
+	if (rc)
+		return rc;
+
+	range->res = request_mem_region(hpa_range->start, len, "cxl_reset");
+	if (!range->res) {
+		pci_err(pdev,
+			"cannot reset while CXL memory range is busy [%#llx-%#llx]\n",
+			hpa_range->start, hpa_range->end);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_request(struct cxl_hdm_range_context *ctx)
+{
+	struct cxl_hdm_range *range;
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	list_for_each_entry(range, &ctx->ranges, list) {
+		rc = cxl_hdm_range_request(range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_range_flush_cache(struct cxl_hdm_range *range)
+{
+	struct pci_dev *pdev = range->pdev;
+	const struct range *hpa_range = &range->hpa_range;
+	u64 len;
+	int rc;
+
+	rc = cxl_hdm_range_len(pdev, hpa_range, &len);
+	if (rc)
+		return rc;
+
+	rc = cpu_cache_invalidate_memregion(hpa_range->start, len);
+	if (rc)
+		pci_err(pdev,
+			"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
+			hpa_range->start, hpa_range->end, rc);
+
+	return rc;
+}
+
+static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
+					   struct pci_dev *pdev)
+{
+	struct cxl_hdm_range *range;
+	int rc;
+
+	if (list_empty(&ctx->ranges))
+		return 0;
+
+	if (!cpu_cache_has_invalidate_memregion()) {
+		pci_err(pdev, "failed to synchronize CPU cache state\n");
+		return -ENXIO;
+	}
+
+	list_for_each_entry(range, &ctx->ranges, list) {
+		rc = cxl_hdm_range_flush_cache(range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
+				  struct pci_dev *pdev)
+{
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	rc = cxl_hdm_ranges_collect(ctx, pdev);
+	if (rc)
+		return rc;
+
+	rc = cxl_hdm_ranges_request(ctx);
+	if (rc)
+		return rc;
+
+	return cxl_hdm_ranges_flush_cpu_caches(ctx, pdev);
+}
+
 static int cxl_reset_dvsec(struct pci_dev *pdev)
 {
 	int dvsec, rc;
@@ -528,7 +754,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
+	struct cxl_hdm_range_context range_ctx;
 	int dvsec;
+	int rc;
 
 	dvsec = cxl_reset_dvsec(pdev);
 	if (dvsec < 0)
@@ -537,5 +765,14 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (probe)
 		return 0;
 
-	return cxl_reset_execute(pdev, dvsec);
+	cxl_hdm_range_context_init(&range_ctx);
+
+	scoped_guard(rwsem_write, &cxl_rwsem.region) {
+		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
+		if (!rc)
+			rc = cxl_reset_execute(pdev, dvsec);
+	}
+
+	cxl_hdm_range_context_destroy(&range_ctx);
+	return rc;
 }
-- 
2.43.0

