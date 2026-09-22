Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E952D2D7;
	Tue, 22 Sep 2026 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066401; cv=fail; b=Is+QRFYq7JPOxlHrFIQPpYu3srQoeWeKgC7wx3jZSBxMKVtN5k9fPhbheVZ1SNVhQtyqlolMj4sK0sB1NZffGLIQwVdHlej5QQxmNGWcW3fAMNhDbuSslE7ayo4cZRJxkWVhUdOiS9SpnrbU4A2IovglCHE+1YULC69RI7pK1Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066401; c=relaxed/simple;
	bh=cy10vilaWdcJsB4fNUZawHDXJPPXIXN0RvEyr+NGaQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PnW6Dt5+9wd7qQcVWVDPrbgQS3dckQStNqRiT7Mr091lNeA9fWuIF+54m+TKjEogDNKsQjwiBtoM540sMBLKRVAT2KIv/e552f8TUtRap9YkrPUjjq9onUAwgCQFQ7o9nPOwlSyFQFWW8FueQe1KTH2Avk+HROx7qAjqmNaRlM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jv4QyGdM; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jv4QyGdM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrSGt0QtySvVWK1nOwkPba5G5fAXfRXzd8ctArGNUOUqEy7l56Na2gVNuy4CvF/rJw/oerlOEGG6jMXzv/A+/AkTM+SitYv5iH2MIFWifuqXTj+oMXdsPcKUFUpNg4j2vvGRVd2NN0HX8tf0L7bSEZaQxIWaQhfeNPKDiNizxLKn6+7yV9WuJnQ+gdWJLyVA1sJhn1YwSdZJ+lj3tWTk/+LzmIQ8lvLPjArV0J45ZhUgIxm1JMMghZFUbqTxF19TmBo3b9CJZtnBwkvfNpsOX01SQngc5UZjJVp7OZvz++ekiARLgqM+D8ccQKW0O62PmQa7qZ+7wsy0jc/y97LmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkUYBWDle+4aYolkxdZgdKB/jVCry2We7faftzKPzsE=;
 b=ouemW9u00G6XwpRsgoujsMHSR/5oAy4+f9mM9h+WYld7XPSc5FBJzoijz2DX0zGh98XhK9ootamTKzS7kqbTgFu74CpbGMbo08n5aIvD9ie7pmBD3oWcZ1RYmMQvVfkyyZG99h2AJhdx4H57O2fxEHNnHAMdD7i17IWxF05I/zTv8XwQrk2EBSXRap7dWnV517/GUXDS4eAAjMB7mZdwJzb94mjMr6qtGWUcX2VgCTiEivxkKecR3ySiJNf+WHwTC5ubw1bERE/XNTKFZdFR4ArfW/4VxXWtDlaJY2GAvrshZj6stE3YPEiF5u+4DMLzGtwFmLXRIiqlDLvSb5oS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkUYBWDle+4aYolkxdZgdKB/jVCry2We7faftzKPzsE=;
 b=Jv4QyGdMzkFl7k4/TI+B1WmC0FAcrdsqmj6j4VLGxoe2x/I98WWMBEN9JETwA60Q5WFaWtau+ot/20N4ahYnARexoivL04WifcSQKdVGtD9c6BtKwajpnBiolLeyl7MFp1DSlcdwvEj422FaQxV6mk5ML0NrLU02HSFTBaA6z4xjjGgC8dUmidWMFZwWcUQNrmdGo6ME7XOJ0c/BKBIbJqC0LtkVx+gBgmFyIovteZY5c43AptHR5NL6+NXPTtDfRcm4bifixK98+0JsDIUI8GbHPvK9xamdC3O8S/SM9H3asSS3in6kchUxuEFpw11R+YsVGSyhnEZxj3cV79nJ9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:54 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:54 +0000
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
Subject: [PATCH v13 11/15] cxl: Validate and synchronize HDM ranges around reset
Date: Tue, 22 Sep 2026 08:39:20 +0000
Message-ID: <20260922083924.2451158-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::28) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f99f5b-6a98-4f5b-798a-08df18851342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C1hybhEco8vnxVrobdjs/KNlaC1Q1e0jWcIpzvQppXAtk+s6I+GPWJ7qR1cVsyJDSCS5RMbsHS7AVbLpPRiImY64JgdMeHe4/QpS6Mq1zI9hRr1iL+BxdWE5t8EI2eFaBHU5q8C6ftQt04xWtZaMnRxuhmnIKnlLycQgs7s/ibaXDtOFz6d0LfBSqIy5b3yU5LYE1qopuyErvf/gHw9dlU8BlxsQwcS0cwMIt6eUDHrMbjXVZvmHLLa0C4gUCTR/VfrDCq12/63Aqh4/DTH0zJqDpv5z+/CJ48ABR1wOIfr7I+VnhImvHIMVTPLOL93eHXRKITcWJ82GU1VCKgVTaFvblc4hES6H2ah7RqoqCud5b5D6n5lmw6GWfU0evo4OF9hm1o7NPJfAo7dh/vBRWlL5tORgHgZvYfw+Vuwy/LjutocGmCqTPAYLMUqpOUtHfbGff2ZWa/OPaEU13ts6c8RfZCaSYW9U0nOOcdNJsrZQGexnP1Il0urjHb4MKI4qX7vuu91AA5XM8iaL3rixY4km84fXL3MX0eZQ0YtxjsOjOZGGsxydDly/UfuWlVSsuD986MSq0OhDXjXFSarYCeXJLUMBI6yDMUx0/Q7seZnFJV28olPam5cyEnCWxhVeysw9B/X0ZefLATh/Du1YpnCFDgXt6BfgJEorIp+VlADIX1ByTsbmEiGAHGJFNu51LhnsuQPwn3x3Zb/lUDYE0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMdRRDsZFfVE7MQJRWbsm4XkByrMPFEpVRQ2RHfEec/csFsTXUk1mB4uV+UZ?=
 =?us-ascii?Q?W8+NYAKTJLp8wyiRoeqdasWl1KkgY0fNh52lGb/ThK5AnM9BiunLi3p+QlWj?=
 =?us-ascii?Q?c9SNTTmxMEIMSEEibyX7hcZ1w7xxHKskM8OeggiTn7OYThteMweO6n9ttP0f?=
 =?us-ascii?Q?VjneNSSGdjiMU4XrXqLD15Gtk48T4buHKLpqOyMKtmB1xEfHlOMeh6bFq0E3?=
 =?us-ascii?Q?DMhw6iyWcvE5NnXymeY6sutu093ESEqVVRkTxb5KnaiSx48hrzrynm39MGkM?=
 =?us-ascii?Q?d1A9PLTWeIr6UosDW0NevJRoIs75fpu1HEQQntZUwHPLG1mq/OTQh3nOwKlx?=
 =?us-ascii?Q?v5jpk3bDj0VYIeTbB5OMV7+sKuyL/ho0PILiacXaSbtu75ZfvLvL6Qtxreml?=
 =?us-ascii?Q?2aLwbqFLuxforqX1Iz5jueJlCSyKma66xAiPW/bwWFdmWLkMtbUJ2TyCCRD2?=
 =?us-ascii?Q?WYNaQhvbdkPl6hrtBvKhibvNKJYBZqMEkndAdiYRnXy6hO0J7UXqX/z61STq?=
 =?us-ascii?Q?QIoLUtj3G0oCIkZ09U0NtNGmjahxndTGexc3M7JLnQi3SBMhqUd3jQjrVIaF?=
 =?us-ascii?Q?LaFEunVMd0wkEShw4sfl4KenPMLLLYOjAx6aUxs7MvcjoAS3kdlJgj35v2RR?=
 =?us-ascii?Q?vj4eO1gwrDKq3yhoVkhbjJU7KGyZEq8efFh5X5Rp7FR1a6Qqd4chYlfJ0j2/?=
 =?us-ascii?Q?R2vtoozS2KgqQPm/Q70k0ap5jPta04bYu7rZ7gSUsJKAsMovxfjHeNR8ymvC?=
 =?us-ascii?Q?tTxrllh18hqmc3GDzxRSbq4SSF35MBp33Xke2RWi30EQf2uyqfj8jgAlEF/C?=
 =?us-ascii?Q?UnUvX/a3QcChjenVwtXheLG3GtSiiwg6u5PU+3/3CM9U/ekYOZBqrMWCLvgy?=
 =?us-ascii?Q?7Qbakz4uiZnmhlai0jw6IPB/X6cPHrHCsFU3Jk/ktZ4TpKJ3YYCXbrpM4xFr?=
 =?us-ascii?Q?cM0BmG4n1VXz/GipGmRg9J1gJNMXBsABqa9ivt8O0fWC7ySDMw3qW3tF9C0m?=
 =?us-ascii?Q?0gHAGGm0r+aiyBKRZfUZ+4HAiV4A0aLYJSGXVN8UilxxiJh37yA/cDQ/xAAL?=
 =?us-ascii?Q?bnwQGSnOHxDw2HymRZPoGvEVsAVJSX7dTUnr9xjnB+AMnWZSbuvrlm/gCucV?=
 =?us-ascii?Q?0EkTmbz0UySQGCKz8cBigvX7c5IPZ9oJo0hPE/ojyEnj6nZiZZgiuFt0JM5w?=
 =?us-ascii?Q?L3BhQo2WnRWdZY1gsVT+WHYDqVAaknZ1Uz9xdP+3ZKnK5axrWsORTcpNPDl7?=
 =?us-ascii?Q?Bva7rluMdCGKbuEE4A//f4Y7Jbwb4IB04gdrJ7kCXQHMW7qm1LQJCTn4Y/nZ?=
 =?us-ascii?Q?hWM2we5RAnAFu8azZWmM3UaRsPl0gnzfP+s2zol/LraWAaDDTxtiW3w8tc56?=
 =?us-ascii?Q?9ypFxe+IMOw3i9BwH42eJG0nKY+fL0RNyYi40OiCOSL+vtcN1brFitc4fkbg?=
 =?us-ascii?Q?LVETxGo4FTzgKOPUU0JW1K/gqRgo2Jex1jhyZTzJNcf0ZRaSC6NtPhWXO5nu?=
 =?us-ascii?Q?RHmYrtrZXlzI382pv3WvQ3MfsEiBpcP5+pD8F9E7oyP7E+/gk/WMPVRlhWIr?=
 =?us-ascii?Q?NALp59Ss0QhnFAlazw1IANYSY9k90yHrwcrICpbbW3b3u0augtNb473IxpnJ?=
 =?us-ascii?Q?jOFVNNTYb1uPD53/lKQRLzqH9I6/9NAGZe8vn8c65XuA8I0rOLS36HYPgYHc?=
 =?us-ascii?Q?wBWo0E0YQVOoeJAnZLABOIUozcBUZH2TE6cncmGTyZM83Vws5eWQrZPRsOrn?=
 =?us-ascii?Q?AA7DI4pyTQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f99f5b-6a98-4f5b-798a-08df18851342
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:54.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAiieUsSn2UyphQv2yaHSAJnmkvLVh1aLCZjXx1UjK7jlH9eMW2Q/xpkjcW1ZZzQoLXJMSxeGeB8Btc+l3KZjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

Refuse reset unless enabled system-physical HDM ranges can be reserved
exclusively and CPU-cache invalidation is available. Invalidate before
reset and again after restoration, holding range reservations and IOMMU
exclusion until the second invalidation completes.

Reject normalized-addressing decoders because their cached ranges are not
system physical addresses. Ignore zero-size decoders because they map no
address range.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 244 +++++++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 57eec77cbb21..85a554b6236c 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -11,6 +11,8 @@
 #include <linux/iommu.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -437,6 +439,211 @@ static const u32 cxl_reset_timeout_ms[] = {
 #define CXL_CACHE_WBI_TIMEOUT_US 100000
 #define CXL_CACHE_WBI_POLL_US 100
 
+struct cxl_hdm_range {
+	struct list_head list;
+	struct pci_dev *pdev;
+	struct range hpa_range;
+	u64 len;
+	struct resource *res;
+};
+
+struct cxl_hdm_range_context {
+	struct list_head ranges;
+};
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
+/*
+ * Bound the range twice: request_mem_region() takes resource_size_t while
+ * cpu_cache_invalidate_memregion() takes size_t, and the two differ on
+ * 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT. range_len() can also reach
+ * RESOURCE_SIZE_MAX + 1 for a full-width range, and wraps to zero when
+ * resource_size_t is 64-bit, which the !len test catches.
+ */
+static int cxl_hdm_range_validate(struct pci_dev *pdev,
+				  const struct range *hpa_range)
+{
+	u64 len = range_len(hpa_range);
+
+	if (!len)
+		return -EINVAL;
+
+	if (hpa_range->end > RESOURCE_SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (len > RESOURCE_SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (len > SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
+			     struct pci_dev *pdev, const struct range *hpa_range)
+{
+	struct cxl_hdm_range *range;
+	int rc;
+
+	rc = cxl_hdm_range_validate(pdev, hpa_range);
+	if (rc)
+		return rc;
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
+	range->len = range_len(hpa_range);
+	list_add_tail(&range->list, &ctx->ranges);
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
+				  struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info;
+	int rc;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info) {
+		pci_err(pdev, "CXL HDM decoder state unavailable\n");
+		return -ENXIO;
+	}
+
+	for (int i = 0; i < info->decoder_count; i++) {
+		struct cxl_decoder_config *config = &info->settings[i].config;
+
+		if (!(config->flags & CXL_DECODER_F_ENABLE))
+			continue;
+
+		/* A committed zero-size decoder maps no HPA. */
+		if (!range_len(&config->hpa_range))
+			continue;
+
+		if (config->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
+			pci_err(pdev,
+				"CXL reset does not support normalized address decoders\n");
+			return -EOPNOTSUPP;
+		}
+
+		rc = cxl_hdm_range_add(ctx, pdev, &config->hpa_range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_request(struct cxl_hdm_range_context *ctx)
+{
+	struct cxl_hdm_range *range;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	list_for_each_entry(range, &ctx->ranges, list) {
+		const struct range *hpa_range = &range->hpa_range;
+
+		range->res = request_mem_region(hpa_range->start, range->len,
+						"cxl_reset");
+		if (!range->res) {
+			pci_err(range->pdev,
+				"cannot reset while CXL memory range is busy [%#llx-%#llx]\n",
+				hpa_range->start, hpa_range->end);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_invalidate(struct cxl_hdm_range_context *ctx)
+{
+	struct cxl_hdm_range *range;
+	int rc = 0;
+
+	list_for_each_entry(range, &ctx->ranges, list) {
+		const struct range *hpa_range = &range->hpa_range;
+		int rc2;
+
+		rc2 = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
+		if (rc2)
+			pci_err(range->pdev,
+				"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
+				hpa_range->start, hpa_range->end, rc2);
+		rc = rc ?: rc2;
+	}
+
+	return rc;
+}
+
+static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
+				  struct pci_dev *pdev)
+{
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	if (!cpu_cache_has_invalidate_memregion()) {
+		pci_err(pdev, "CPU cache invalidation unavailable\n");
+		return -ENXIO;
+	}
+
+	rc = cxl_hdm_ranges_collect(ctx, pdev);
+	if (rc)
+		return rc;
+
+	rc = cxl_hdm_ranges_request(ctx);
+	if (rc)
+		return rc;
+
+	return cxl_hdm_ranges_invalidate(ctx);
+}
+
+static int cxl_hdm_ranges_finish(struct cxl_hdm_range_context *ctx)
+{
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	rc = cxl_hdm_ranges_invalidate(ctx);
+	cxl_hdm_range_context_destroy(ctx);
+
+	return rc;
+}
+
 #define CXL_RESET_CTRL2_CMD_MASK \
 	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
 
@@ -560,24 +767,25 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 	}
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
+			     struct cxl_hdm_range_context *range_ctx)
 {
 	int rc, rc2;
 
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (rc)
-		goto out_enable_cache;
+		goto out_destroy_ranges;
 
 	if (!pci_wait_for_pending_transaction(pdev)) {
 		pci_err(pdev, "timed out waiting for pending transactions\n");
 		rc = -ETIMEDOUT;
-		goto out_enable_cache;
+		goto out_destroy_ranges;
 	}
 
 	rc = pci_dev_reset_iommu_prepare(pdev);
 	if (rc) {
 		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
-		goto out_enable_cache;
+		goto out_destroy_ranges;
 	}
 
 	/* Clear Memory Clear again even if this command write reports failure. */
@@ -597,7 +805,14 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 			rc2);
 	rc = rc ?: rc2;
 
+	/* Evict lines fetched during reset before ending DMA exclusion. */
+	rc2 = cxl_hdm_ranges_finish(range_ctx);
+	rc = rc ?: rc2;
 	pci_dev_reset_iommu_done(pdev);
+	goto out_enable_cache;
+
+out_destroy_ranges:
+	cxl_hdm_range_context_destroy(range_ctx);
 
 out_enable_cache:
 	/*
@@ -615,6 +830,7 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
+	struct cxl_hdm_range_context range_ctx;
 	int dvsec, rc;
 	u16 cap, ctrl;
 
@@ -646,5 +862,23 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (probe)
 		return 0;
 
-	return cxl_reset_execute(pdev, dvsec, cap);
+	/* The cache is owned by @pdev and does not require a bound CXL driver. */
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		if (!pdev->hdm || !pdev->hdm->hdm_size)
+			return -ENOTTY;
+
+	if (!cpu_cache_has_invalidate_memregion())
+		return -ENOTTY;
+
+	INIT_LIST_HEAD(&range_ctx.ranges);
+
+	scoped_guard(rwsem_write, &cxl_rwsem.region) {
+		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
+		if (!rc)
+			rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
+		else
+			cxl_hdm_range_context_destroy(&range_ctx);
+	}
+
+	return rc;
 }
-- 
2.43.0

