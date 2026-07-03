Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B5356760;
	Fri,  3 Jul 2026 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116339; cv=fail; b=AGpRUQURE+qkAwxiYMazejwkPsGvyKxhZNKowEtKEfxBpPuDAm6G3mND4aMZwwcgAdkAqZUVr2ieeTnIUunVEdnbmiZncJRAyrE0W6oToqbbEYBHt2WuunRnlX8W5A0LV8hFLR9P4xi5B0B+E/LST5t1uiM+JqvbqiFz80vJsf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116339; c=relaxed/simple;
	bh=rKLuWcOKsX0RFyPahQ89yMxHbtKIWyrfJIirmx4o7fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DG2bgVMqwvQbXw34N1zmIB2UOsyfV45IxK5V4JJNxd4Ck90EYeoxM4iGUlYlKnX1UPwgTKnnc0z2zh1X8pp/+kY6CwArAehkTKCf8BvU7kpGrS5vDXhTf5lfe3FJNrqCpguaCWO6FtwUB/GxkrCXki8tD/3OfLmrzjB7iiRzjRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mDTLeleP; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mDTLeleP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoZYNJtjCd4Ku4lj4iB0xr741eH5zHNPvL6C1kYPdsN64jlvM7l0kTs6A2ESz9RcPQIfBKBjy+nc+1uTbM0PWc14wYaW8NGkjeyetpAxglw6WP9cy4UwTRt62xUleBgL91YS7e97oI89pjLvWNW4CLY3+Yyppjs71W5LupFa02IzZZ4kx7/MgBmZeH+6EpUeqhfmM9Ea+tQPJlpr+0bM3tnTkntuiciG3W25lUkQ4GdmwAbA2JvszISO2BXkF53SRpuyAypFa1uAANKSki+SERGY63ho+HEcIg929CLJdActGvFTA1j9IAO//F5RRuBz1J5XujIB6mWtx/jwIYIBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHVq27xAX4PEuFkPMQkJy8kubEenACtpV54yZVRnKec=;
 b=dFwMwrfvwz4iq0S+gX5z7TEejiGATHQMoD3TD6EFO8WxlsQCbXF8W29w7KpXI38JTxHiv+HzkeAG8LGKo1chJdBpzOtnWqP1yxxbGzjYyU21hlSeU24c/hP/ltajRXiy1FVhaPQVOlkJmYKsbIkqeWvkKtRVRWDtErjm+ZXIOUh6Sd+FsOKB+kC1pHfP+/WsuRgwkOJMxNjvJaNpJavSgozT+1yGo80AGJZDy99sdgQL469myWHch6zjbq8SCrIAjFhYe8TvjLrmhcqJ9bizqd7Q2KtxvVl4+PpJclIUP6Oxd//3/vSPK5lhxXxH21K7vxLyo8LTZQVfTBe9j5+QdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHVq27xAX4PEuFkPMQkJy8kubEenACtpV54yZVRnKec=;
 b=mDTLelePXmNj2euZC1hDinFDD95TIEC4CpMeEfvj8EPngmQmaZ6LlFumWSvXdtMJpJGDVFW3OvItqQHzUltH0C+nNWghCYMtRaeSLyT9R1tpkutKLFGCIxm/F7ElZgXLxVZIGmX3kfMelbX1GHLWvn5ULoFCR4N4aPDA50iePuKxo9JaC7d2Re0OQIREjoIQmad4MFlLBH9sCEmlzygIZtJ1ES0LIMcwFdvaKKa8H3CKgfP1l//qKt3uyAQRWcxhpdKBrujJ0zeu5k9ZBRt58GUq1h/0vuo3kWbIQ/4QkUXljOCwVBUw9wjrt+cHJG1JKZPueqX+qz1zqNDFZ7wrVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:26 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:26 +0000
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v8 06/10] cxl: Validate HDM ranges before CXL reset
Date: Fri,  3 Jul 2026 22:05:04 +0000
Message-ID: <20260703220508.546528-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::25) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3d09d6-1904-4f85-c9d7-08ded94f2fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	0DZ28PLTeQPDTnQlF+ppGzbmyrYT7PnEV/pFJHq3OqFQjcZ89bmYyIwoENJ+GAkbymk+aCWuMgkNi5FSXLXVRB0VUmgP+W7dhCD9Uv2nzlmfhjtWuW25hpqFQQxY0IdTVoUuPncwz9DxyUZos1Gp1iW+1NfZXKJ9jz65b2HboLzqUI/hpiL4nPlrKBNO2dtiQ2vaLVc5hkfBnZW/RMa35IlVAmU4YdlkFWDqKOI9aR8AwoeCGffUs7qNjJfg5z1TkUM0pWd0ayaGUo3IGg/n5BZRCW/4c799r7II3ygB3yKfSKTtZKI2p9RXPp4P5KFZkMHlFxLBEIK87wAJJV+2BFw4p8iOPiNBy+STsioTIvVTliMlZ5U1naBuLucMvuWBaoaKzr2gjPMUiojlkh8rfAJWsNr0H36zpU/hHAl30G4xDIzm4sINHo0Twa4cfFOluFHBknya6aWD5HJ4wi1VEO7ZzVjSPcU0MQpoONN2dcv+WTggxdZihdq7yWlk8yJAvkSCZineEck+rAI8hsAJZ8dD5Tv3ylZgt7jDYCmWWtaG2ynqusGt0gnUqUeahMi7+Oy+Q/vAMRlgKIIzFvwholcDMjdRcasPAHmAUiyx9+TFb2GnlZ17VJ9Maxb3UQSzKdg6cn9UJt25/klUILzfK5ttuDTSuYguK8wNzymQmCh++QUICpETGsBnJvieAGZL3lWDmYRfpRsp2bzmmliChQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HyVJQemp09eAaiBxJDxPZX/ZPUBS4WuxtfCs+sKPFTwgye7cw88u5qFORH6Q?=
 =?us-ascii?Q?RQP3/87thSTr4Yq8l3oLOenihmvoG+Afb+5u/RTsxH8c2iTWGPHcbbUh3KJt?=
 =?us-ascii?Q?vJSD5C4drAoi9E6CWGRNgB/x5t9BMVXeHX1eASdPeWfgUYjoFBT2Sg+/uNgO?=
 =?us-ascii?Q?0EXzvI6K1st1ErYkFNxfKiM0uwRSP1/bN7AilzsybTAsnW0ljL9JMBw0owsW?=
 =?us-ascii?Q?KItm7adJdl/C+ukWHwvWAIYhSRua1OOZbGOePupiAciW6EPnYzn/5b1ztT2K?=
 =?us-ascii?Q?NoIM94tA58oynQbXiAuq63npHFjDimlfMxpBZG3VzRYop7KVz99d9Kr1u1oQ?=
 =?us-ascii?Q?eavlqT3dlYK7kM84QVpLGImCN3zmh/6oPCIBjrLB1RXVXCOJOjNg5tM9taz9?=
 =?us-ascii?Q?rvSesop8PcrZDXqjKIl3pLEqxDMZ1i6tEdb/A5eKFrteGd9fBaDF2L3RCF3L?=
 =?us-ascii?Q?re6D+U/W3bYwTGzMWG2LWowWhppBjrppFRY2F1wmDDqxSAQU8TPO596Ef666?=
 =?us-ascii?Q?bcVcfoah5OJsFiSdE7C4TkGO3N61NC9KJHTWr6cxmyWhZfoQdELXQ77Epnv4?=
 =?us-ascii?Q?Im65eX67WB0tYmazJvzjOen1gMloEcm23yXE7M84lgWWDxi+z6zVfqQ3pp18?=
 =?us-ascii?Q?QtQE8E/+vV6ED8F8iDzGIHhQPv3ZlDtADU2iKoRD7C/OFlMs3Ffvb8rup0oR?=
 =?us-ascii?Q?30C7T09hVoemGPbBN8ejxRu9//Z7SMzz4SWQsycSW0DcPP5dP+tlnNZGhxFH?=
 =?us-ascii?Q?MnSLqdhEOWrK9pMEQhi8HRD4ySqjlZogpT+X9IwYxNnqDR+5HvqFNxtSESvz?=
 =?us-ascii?Q?IOjY67N9kSRBOOCm1LXZgT2aaLy4CQ3Grefqz+6U7TkpXevIuobd++G3XEnj?=
 =?us-ascii?Q?EeIxgEpNusJlTkwSP6vNi1bxeqEBJ4L5A1DsZlo+bXUdVBt02GCe/twOpBU5?=
 =?us-ascii?Q?inHx/7gpPGjqaS0IYVcZQYLY0HIB3SE/78Yl7aMk+yyCCry2YqB3WCIoikXJ?=
 =?us-ascii?Q?bqiIL6TyWOL58Pu6H3inH9XchHky+lCSgN/ZBAFVOqXa0+3lOkmiFrPax4Ta?=
 =?us-ascii?Q?vMZyieUnZrfygJ0weRswphgM25Cjz7pvUT/zLVuIKawfxP/MT4PA78vt3BDc?=
 =?us-ascii?Q?B8gHclY7CLOMidyimrn+fxPBxMhnNPmbe2oXoufIWAo1CpCuEy0JclroxMJz?=
 =?us-ascii?Q?zFZcnQd9NvvyjjydU7dbJJKkReyeK1tzH8M3WRdEQ0RliJu0hwR9ZOYAcDzY?=
 =?us-ascii?Q?bWOx096iFsL59eAcEHN4ktCRqwySvl8DLS8hNBw+l2H/uIyk94saUhNYP5ee?=
 =?us-ascii?Q?fdbIhtowkeb7mZtViV+dGGVB+xpnxZ3dti/NMWA4CQpGcIIR7lPwCqjUJgGv?=
 =?us-ascii?Q?58MOiXRkyW+H4307mbyacdQRpFhgzWfnHC81NE3ZyqLSTCQGYnD3HIs8itbR?=
 =?us-ascii?Q?oykIABUPT016a2tAA8Kkz7a7LJe79zpuDczwlzDtA5Tk+1YrCe6Y07D2MZhI?=
 =?us-ascii?Q?BFN+N2f/skLhVJ910JuqLyj0vH+PrAbJLpviatrqHuN8XqfIGZD9zWJhVXDk?=
 =?us-ascii?Q?cqwBC2VBGv05mYUGxbdj53XBO5beRSQBjxm1D3yDdmPWrwJLOFRq2raQKsRD?=
 =?us-ascii?Q?vMgyHvq2XLNKT7JFfrNvy6j08xKCnakm3uCYE7O+bBGHM43gUTvUfpqd+hsL?=
 =?us-ascii?Q?ykxBaxCplKr3aRu3WT9PHDGvBLTaaOUkNXENH+Hh//ZZgPsYG4yhXXTJX23W?=
 =?us-ascii?Q?ah9+/fMMrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3d09d6-1904-4f85-c9d7-08ded94f2fe6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:26.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eIbHaGddW78U06fMraRWi6I6alYC9oRB8Zt87zWNKZPd5LizE2PgSbykumi06h+UEIGE7khZlMQYWPVOBTXbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Before reset, collect enabled cached HDM decoder ranges and reserve them
with request_mem_region(). This rejects reset while affected CXL memory is
busy and keeps the validation stable through reset.

If CPU cache invalidation support is available, invalidate the affected
ranges before reset. If the runtime backend is unavailable, continue after
the range reservation succeeds.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c | 240 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 7a9b1ecfadcf..fb741b66e502 100644
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
 
@@ -467,6 +469,231 @@ static const u32 cxl_reset_timeout_ms[] = {
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
+		pci_warn(pdev,
+			 "CPU cache synchronization unavailable; continuing without cache invalidation\n");
+		return 0;
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
@@ -662,7 +889,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
+	struct cxl_hdm_range_context range_ctx;
 	int dvsec;
+	int rc;
 
 	dvsec = cxl_reset_dvsec(pdev);
 	if (dvsec < 0)
@@ -671,5 +900,14 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
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

