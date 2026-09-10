Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7D3D45D5;
	Thu, 10 Sep 2026 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024140; cv=fail; b=SSQkP5ERx3KiDzg2NGty5QhuGWbzBohkIJEOzxkaSQvq+gSlrrb+YacpeRX4jOEZASEi6Zj47MtjVG5M60kRsuQUaQp/3VqtLZFE8r0Mbxu/jd0/5HhFmJDtwCaIEZnibm7k3br9DQ/mAmweVf0xzDf1yR9LyG1rSxtQOldssFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024140; c=relaxed/simple;
	bh=fO6KrLRK/Uae2TimUEbgvuhv5w8PEiCTgGfejhzfmO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHu9+8+yyrSOorpvODGxeDa5CtOub4/+XT3CJoKKv6jm1OloHlW8JS6BERkAPVE4oXbL+QHd81cSFdsNQ1AaWuB8+JytJzDSd4v2ngWR9pA/X8TcpCE+RzADEZ0L7uyFh1BGpPAbDHbJKJEw3QEp0A1JcBb0U2D/qJJ4o1T6L5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8vFwNH6; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8vFwNH6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTBZE6ojPsxoc84/fixVSrJncyaxwWHycxugsZdyCgydD/bBpS3avjttSvm95AIiLVpWkk+VIydVmzq6cQZ7jED7hOJshcCWNNXPaOx78O4n8eH1UVHEVBRyDvLmzdLkxiUhq6KlE+ZAA6HtCrBNgxWrvmaNKkX35+HL7p6GFoITx175qGCfd+UGwnI7WAzR1VrOSGWWwJ/NGrKSz1rPnT/uGaJmallGj5kefoomw7tOeGml8IKwE5YxvqDJ5fIasN+BWK06KgNQ/6Ih4V5467z1Bml2XP9dfV4mUV5e4ZvsoIIHeD3demThsyJmvxYZN/I7/JDJSkWJew/ff9SGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEwQVa8XTANpgSl4P8MJBY5s61UqHJSEj08M8jTPulA=;
 b=dgSsuuBJmZFa83Sdw0tpP9GT8THbEgj7220V/oj+eDoXQ2iRUR+13HhfhrkmfKpzWqHAAnpicrseZlR8tZGRGT6M5LJGYM/xVJ/CQiQWudxTIms7wPRNPpCTmNLD7grmlyzqg3sQCOg3a2+pj5ogGl5NwVAbuogIt3Y5oas+85NOCClkTfbIsiJMJgUDr1/g5tZ19r4NnunKtrv0XZuqCcQ9UioCBs8ZxU2Y/tX6Zj3mItvpr+B3GmNkUnjoOaX1W/0ckFvrj+JZq/FcXf4bD0LEbCSpGDzmAr7YrM7WlaPYIA4YQVQO+i5KKutO/QIMAOQQ1Jldv7cMOFcxc2Ne3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEwQVa8XTANpgSl4P8MJBY5s61UqHJSEj08M8jTPulA=;
 b=V8vFwNH6RopTQKnyN4Fyb0pO4Y4WAnfDxV0tKLH2d9IpdqIL4lwatDr1FfCUGVZAX83ZRTjkJMmv+Z4fXClRpqQFu7WSr2PviRt5Hbvp1zv9EkLBnpnoSpz7wAJAYD68EA6Odg+qz0lYXYihwXHtlbdSBD9N/m8LhvHy9mKWC+iab9ZA1zf1evuxyk2czS5lrGJu/BbioNHNOsJwZAVyzFO5J0WHFWpwZzJeUy8YP+v+DeqNA6Os6nUd+NoDRkvZpejrq9B00S0KZVVae4uWuejcDaZQxOyrbudP4iIeopztY8j4FoQZtL7M77H3IM+Nw43ow2sp+omojhuSy796IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:45 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:45 +0000
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
Subject: [PATCH v12 07/12] cxl: Validate HDM ranges before CXL reset
Date: Thu, 10 Sep 2026 07:08:03 +0000
Message-ID: <20260910070808.1444264-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: c425da0b-8425-48f1-8260-08df0f0a5ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	2SJ3qlGMeIned1ewFOBgH7okaSpSEfZivGl6JaHJ2MNk6nrVOAI2639qrIHG8FMblegwU65P40bJAOzXTzUFvD/9TF/BSnzkt6Ql7KyRqXpTVFxNmHhuZEpx95Gz7PnCnX286IZiFYFQeyP/KQtwW8cuYipe1Edbb/WHNkCqLozgP7CPqHcAxYxJfKZOk3iRz/YDX6pNR16M1WnstUE7rNT93ejA9JnisJ9CR5yp9bwlQLLz/hUKTkiEh62mMrdnx7Wv2+XDK1U018S3IGsH1kHWsOsikWLD4aLmXIkOrJvtW7BJ4+5sC+8bMMtaV169IrQ+KxNqFwJCySZ/xcQseAlP3a4kw+g5st8uHoINi+r/NLAl4Zl7IHdHUf/OacSSPZvNoMKmQ/sKQLF2IbGvoJOLQNiFSkKB/7ZPx+JIHyMi6b4oxDBAjwCkddCz+gJ0mnOMU4zPdbBWuzn5Aab8xMdnhM6VFmpKiC3Ka7ZgxCySt/PewuHLm2FyWPvbPFFi5A3yt4iiioBexQBQ9+VyOjXOYtQ3bool9iWEKDPbl66Sc0F6/cc7Vcod5xtT+irUc9AGtp7sb+RXFMo5hBNk7M8Nm2AWhWLFW4MHHM3dxTd3R6bvKWlxD79o5mOehg3T9T39vMyW8Nba88Iaz9kkYH+Yoc9hQXeNYxrGI62hoKQxaYmn8irlT7DnSey8xllmiMduOLvY4l71BameBusyXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wix5wtMMU0kI/DSCY1VB+3H0M/jTomzhgJ8bSse/ckeDDnoZzVBUyqLT1KlR?=
 =?us-ascii?Q?w4t3BZHlmR/bB5bePSzBEFX/nNXUw32BLroCTQrgyNsKgrvfI1NYaLIXvryV?=
 =?us-ascii?Q?wVyC/9PgcW2f2wGN3TUfHgFvos2b0rsC9uL51uNZIjOJPQCVcdvPGak34A1Z?=
 =?us-ascii?Q?yR4D/D+RWPEdFjDefVCeYK/8DtBZganwF3nMkVkGGLkpWY+2GWmGIxADWKIM?=
 =?us-ascii?Q?akRWxOrp1rw2hi57fuhmEMIjsg7k0Uk9bD4LpJtGvzZTjZ6nSOw6nmAtTHRj?=
 =?us-ascii?Q?huikfJ3LauqlKOwo1L5Mw6/vWrz5PqF4sQTArqm+zLzxbET4siPo/QeowmG/?=
 =?us-ascii?Q?kBAJjzljNesoQUXbcrongyFH9eDzOw5s/zFP4d25IARiHDBR/nhMOmWS8e9h?=
 =?us-ascii?Q?DZFXL1F02AFHOGENzkN0atjSzFZ8v988n6dAZz8T376LmtZTJR38s29etD/d?=
 =?us-ascii?Q?uG1Lq6XV706jJLFjzBKm8gW7ijlRPI9nPvmr4D+H56wTK/M+l0Uf4+OBkgkV?=
 =?us-ascii?Q?1B9+mCnIuajXj1Kg/0SKBrA/BbIHmXQN4HNMlgfNPlsxF+hq5VyRTiYcbJpe?=
 =?us-ascii?Q?aMRQrKN7cgvd3sJZbQtx2Bms9fU3ZEtRG6ZcjyoWoBKELjyW0uUfZ3hXuLFW?=
 =?us-ascii?Q?Rse9gHRiKejYA2PXMIvrrFYlAQ78itKU3bAp+sqS7NiM8+5xh6tkLDF7rgxu?=
 =?us-ascii?Q?jLgzhjgnqort3DBbPvq12QwWOjTgzp1v/tUU2BkB0b8pju934QJPArk34mHV?=
 =?us-ascii?Q?0wt5g5+lbh1WXNPn34usGouY13e7hV/feoPTZcbWRrxivWdOSTG2E92VKY7T?=
 =?us-ascii?Q?9WQxSFDth0wjecEtsFencON1MrZwVW421lX7B+YnUgITETeIQphQniE4vPd8?=
 =?us-ascii?Q?oLZOWwSK+J1paUWMUK7AmMTK94JVYqwnZsL66o2unm6D1vrX9M/cihF7Cuec?=
 =?us-ascii?Q?eXs5Be44uXYze4JlsWsES2ecZs+c6v9NfwghR7Sx+kYoFDStev0/Cjx3T9IM?=
 =?us-ascii?Q?Yi0eP1+AzLZjf7SeidkORDqYjyj/5WCDjw4Dt22OoqxfrRHgaQKmAEBPONU0?=
 =?us-ascii?Q?25dVehcFwDv+1837gV7lkKVvibhv9t0GdBhfN/G8bZiQpRnvPdwVbKMYrTok?=
 =?us-ascii?Q?A0OS6funvc5KoiU4JntV5GvdwHJZXTyYPtk59eC1TylAZ5SzqUtaWkj9f9Ln?=
 =?us-ascii?Q?acCzZyiUviSpqJGP8KpKQbem890mpNxvbFxMkzxKnvDw2tdYoQc4q+PgI/db?=
 =?us-ascii?Q?zpETfDYRIJtfcTS/vOGWeKPK1y+pbNFR7Zhkcgxt8b5rDfuImmgpYbQYm/S9?=
 =?us-ascii?Q?XGuZgy0g/y0XgHpQWK0qD0Udn7r7OYTC77p54T6u9E0KD7ubHtbtFevcpn5P?=
 =?us-ascii?Q?vhsX7lBGCOwAsV1aP9kBvM2wEXEOOS/1VzSxpf8k0TNnbqKgKeka2XWtBpbz?=
 =?us-ascii?Q?0q2UicLr6N4tFwnIaO+XtioOCt2+u0mW0UIUNru4r4nDafey1aJiOCZ/rFn7?=
 =?us-ascii?Q?QcsSDzhUR9mY2Pb5QYcL5zZUirJSeKIzbs0H4rrc04XBDyW5A+q2Z/E8BBnU?=
 =?us-ascii?Q?wLJqBMnAhj9hYIiszJjB+fRZatsocjB7vxoKhTaQWgHsb8/Op9VhJg1k7L56?=
 =?us-ascii?Q?i+bxEL/lnmP9QpJUE0N4cQ3j3x8LU4EKQS2jCcZnMEk3Kh8LbuAF0QMAN5Wf?=
 =?us-ascii?Q?eqg1eEkvmlQeFRHoK/+1DiJHy3DVJHQt2fuh7DyfVeqYds25Pf4NhYjKDeeI?=
 =?us-ascii?Q?VMrJHV1G7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c425da0b-8425-48f1-8260-08df0f0a5ab0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:45.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5Mvhxci02onw7f99DZIPDITsMHElRn0ecHdOom8UuRl2hiXxLivLpwoPm8SdUSwfis1BSUIUYWZNQ8atq2oMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Before reset, require cached HDM decoder state, collect enabled decoder
ranges, and reserve them with request_mem_region(). This rejects reset
while affected CXL memory is busy and keeps the validation stable
through reset.

If CPU cache invalidation support is available, invalidate the affected
ranges before reset. If the runtime backend is unavailable, continue
after the range reservation succeeds.

Reject CXL Reset when no cached HDM decoder state is available. The reset
path needs the cached address map to validate affected ranges and perform
CPU cache invalidation. Also reject normalized-addressing decoders for
now because the cached decoder range is not a system physical address.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 255 +++++++++++++++++++++++++++++++++++-
 1 file changed, 254 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 9c1aa0800521..7e4eee3e50c0 100644
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
 
@@ -509,6 +511,229 @@ static const u32 cxl_reset_timeout_ms[] = {
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
+		struct cxl_decoder_settings *settings = &info->settings[i];
+
+		if (!(settings->flags & CXL_DECODER_F_ENABLE))
+			continue;
+
+		/* A committed zero-size decoder maps no HPA. */
+		if (!range_len(&settings->hpa_range))
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
+static int cxl_hdm_range_request(struct cxl_hdm_range *range)
+{
+	struct pci_dev *pdev = range->pdev;
+	const struct range *hpa_range = &range->hpa_range;
+
+	range->res = request_mem_region(hpa_range->start, range->len,
+					"cxl_reset");
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
+	int rc;
+
+	rc = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
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
 static int cxl_reset_get_dvsec(struct pci_dev *pdev, u16 *cap_out)
 {
 	int dvsec, rc;
@@ -539,6 +764,20 @@ static int cxl_reset_get_dvsec(struct pci_dev *pdev, u16 *cap_out)
 	return dvsec;
 }
 
+static bool cxl_reset_hdm_available(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info;
+
+	/*
+	 * pdev->hdm is owned by the PCI device and released with pci_dev, so
+	 * reset-method probes and reset requests can test availability without
+	 * a CXL driver bound to the device.
+	 */
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	return info && info->hdm_size;
+}
+
 #define CXL_RESET_CTRL2_CMD_MASK \
 	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
 
@@ -731,7 +970,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
+	struct cxl_hdm_range_context range_ctx;
 	int dvsec;
+	int rc;
 	u16 cap;
 
 	dvsec = cxl_reset_get_dvsec(pdev, &cap);
@@ -741,5 +982,17 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (probe)
 		return 0;
 
-	return cxl_reset_execute(pdev, dvsec, cap);
+	if (!cxl_reset_hdm_available(pdev))
+		return -ENOTTY;
+
+	cxl_hdm_range_context_init(&range_ctx);
+
+	scoped_guard(rwsem_write, &cxl_rwsem.region) {
+		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
+		if (!rc)
+			rc = cxl_reset_execute(pdev, dvsec, cap);
+		cxl_hdm_range_context_destroy(&range_ctx);
+	}
+
+	return rc;
 }
-- 
2.43.0

