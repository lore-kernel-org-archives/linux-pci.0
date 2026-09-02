Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2683DAADD;
	Wed,  2 Sep 2026 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334118; cv=fail; b=eDsXl8N7Nvmt9bzDrakmh0NR8bbXCFx0eSLRgUo2D1H4lxJhtcXx31dbW7MTkI/QuwRNSD4lbfx8pars2e9RBPT7Rvw3RvNhHn43cSI3+NhOuD3wHY7aiUnggWtaSVuXyK36D1m25kBF1EUDJGCQbZriAIa+ZEz2FSOCndnORFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334118; c=relaxed/simple;
	bh=bY7DX2Z6/c9oJc1Yu0I6EzSDAPUPXdiY2C3GRX63jlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhFL58JlpD/LbsM7NnMgV8XyKX6+3151M4MB+iUGeYXDUwXFP5WrYnuXG35AO/jwkVvj4/q7gIwOGRdhF9c0vJkN+b1zuXQtudVNrjnsQUqIJfrb6pFwP/v8E/n1J8GF6SS+wwYXTy/RNssWKWCJ7br3xlcCwKLInxX+KaqBm0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uhNfDOgR; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uhNfDOgR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w87fN4C91yjgSSWmd6+PwWSERpUk/Idz4q6VhGxRhJsny62D/8sqeWCelsuKHgNXO155hAEUOfgi4sAqJyqH4hAguWsCzD2fbH42ydm2YCP8S997OO/EnmqCZijh0Xb7+V2aZkqUBX1JzL21SZtaGlQjP9o6g3LepFXqT0v6ExL7QEstO6dH08CwBEfvkXFe9agXEM5/3gcoPj9/MzJBmmHlc4CG0pN3CY3bIh418M8txJg9KjV0fx50Lfw41a9Q74zEq3PHjKYnv3cFd+/+LD5eh7oast0tV/ndyfk9XRfSUtxUIUN8F6jN0+EOpgpoFNxxjRTiiS3rBuX5qiaVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51ghm4BazpE/gcIioLbVh6618fdxJw1tTT6Jy1EW6uw=;
 b=Xl+9ZLSkoa94ZGiRpU0R4k8KDTC1LIkjSa2iVaoKJ401s6iOi7fyt6ZqXRK8DC31KZZsgxNEwim30VC4Jww9dB+rQhk91OBYci/GejGR8KBcOs3LLD4Tef6slAeXQBhGgkWM+xCLlGwnBEYcP8TxKeAi9cUVsFFdXR+SukzvrmWR8Dg00C6nVbg1nNMoG4RjeiBXJsGXlNSPnXIP3HOa8F87P0Ws1J0RqQ/E287xUrcyj55QCzJC1MsujjipVCh2CKybsHPL1XvT5PVYEZ886MMeeEOvp5I03uL/n4iIKh+Z/6ExB217R0WhmtAaUQZtHdFqHXt32xT+GDpK3Uj1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51ghm4BazpE/gcIioLbVh6618fdxJw1tTT6Jy1EW6uw=;
 b=uhNfDOgRu7v35Z13zYpkvbw20VULRhKA/u0j7Dti1ImdiTM/EKtcnmp1OXJ7muCFITp5pzLF/I6uIxT3hteMFOF6ftgtEIKVSkpGKDxygl0YEPOVPJ+a/w3ubzIk39D4PIENUqAIwSz/JN+bsfq03sKwHb54dBZ5t8d06LyJHxmqjxmzhlw4l8KMUDrUFSexHbov9PWcKuzAM1ynfoG+5U2R9h8U5y2rEitMpBa5IiVKk6Q2VgBRaTCHmX6qFkVDZHfOBgwGByxJfsk1XUxYd+g4bCbtaAywM7SZLbCYZbghGD3SjoaWQE+BLaxH6uJwT5RloNop5jw0xqqa6EV8Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:27 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:27 +0000
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
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v11 07/12] cxl: Validate HDM ranges before CXL reset
Date: Wed,  2 Sep 2026 07:27:59 +0000
Message-ID: <20260902072804.665639-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d251b9-1953-4fc0-8297-08df08c3c798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HKCDed62MqKRNZgtByL4iUwiFcdsvtXnKW3XCiMfOaziyyy/Y+92YuKpbyPDBDYm8GbEtwCrGwGrslcWlGMry5PBH1pkvU6LL008a0KlSicau2E2K748lRNiFk61IxiYReE5fc7sbhB3edv1KHRGsPAdeyxv3KkQ6mKyqVe4al9QsDqzZe0TZahKpsoZYQ/qBNHi83/pH06I2871dxgTp5fdY8HcL0tOjU6Shq9ZsrfIL1SFk9hm3TrILW5x00Rh7xv1Jj8qax+YM5Lwe6f5ATRNYAuhpdshoVHUp2qpd/stOaECZ1l3XqjeVuEvIcVYn8RW2yuYkMUEIH34ww2PubfrurmH9Q+SdRhVziHdcNE17ea1e9OyDDQP0g/UwbHkvkF2g4bTQQX3JaBbEW6U9xgpzo7GYgDyTxI6xlx3lCMkvtdKHsTb1YFm5muOHGCBpxbx6i78t6yOfjyWuZKixOR5QepX1Aebte8SkpNoOmUNKsYjnFNx2iaIEr8xI8pxYIlbWMGgp5tzal3b+qa+PC3CGjRvflDBDe/elrW8mJtgVGwk1LC7KusYE6A24AD7JWj2dFVny7ANgi57WyhNdFGohE/fP1xk4ru9jGtYtnHCcViKuT+6kPSRsHII1fDCg9J1gdvVh5hgGIdBrMRG+6AlRe+Jm0sJZi5O+kQQRtqkBCkXFQVyTGSjunaObKoZ0QhxuKYYIf6tyUgpdFM3yQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zVPu0llqBV6R3P930lJHzUpif17bhUa8cGv4/XE+9swpQ6FyY34ZqldLNFAT?=
 =?us-ascii?Q?/TNWHS6iACnspJG9S3O9N67nEpBaKR+U5HzhDuaaJ/UDVGFigOllgJyfkKTi?=
 =?us-ascii?Q?LaWi2sDe0tUOXx2LozvEGI14TJPjKGPEJxF900T3i2VQunTHfxMweiYIWLX7?=
 =?us-ascii?Q?JGTcyqtjZr64LN4NipNpR9nH/fsVvqUIoOZ0FNvNQI/fz32eF73KxPlGlRsg?=
 =?us-ascii?Q?OdZF8JcS8C9tcaDmuWN5ECXveYU9vDszmYRPlG4VToUK6IMuOvS7PeBBPRG3?=
 =?us-ascii?Q?L7rBRYAwTXVaBWurlflV2enagxmbldWgA/nHY4jKOuvwQp3pLv9BokPjYmYU?=
 =?us-ascii?Q?RLWUYekMBR0jYHsGtSvCWpgX6llBpCvOrJhFjqbblmEXjmdorzwIbRYRpy/4?=
 =?us-ascii?Q?7dg6k2v+UBifeqiJcfY+OoNVyFfDO7K6kiyvjPGNx4isflPHFl9ztD01kdYv?=
 =?us-ascii?Q?GzjGjE/VWTMLEoMhRFCjftUR7uI8CuDkn13abw0EojE6A1xsN7ePhnwvaOEN?=
 =?us-ascii?Q?DcVl2vu0p/pu5X14+A8nNbPehyNcK+hF9ILfCyNCZQGk3/3maQQgZdfRxlb/?=
 =?us-ascii?Q?7GaPyth9N/E1W5JK9yG7sHu0M93OEzDAX6zlmxnQ6hykDxGNgI5C3dPDae5+?=
 =?us-ascii?Q?ORDjFwHbSNcptgSwfSb4HfybfpyD7T321LdCpt0i7OKT8yKwcb4w0EY+aW0W?=
 =?us-ascii?Q?UFrNPru92shzdhbLhzXEHXGeDwTRnPn1iv1eBvhTu5z4jRcoanEt9rEzRIZP?=
 =?us-ascii?Q?KI3RPae1H+xCoHMLu1VaDI+99kLyhq+eeIQUVoSs49S+DEpefnvuCTpAtEzL?=
 =?us-ascii?Q?gM9u+Pv/M7bRjQsMw4aYFXICs9tWLJ7OHLiZWAU/iUzDryOf4cDOYHZUHs8p?=
 =?us-ascii?Q?HBb59y0EHL+7uJup4SG+uOMfHSmqkpyjaMXrVzAgsQhOmMewyRrXIZuAbcDW?=
 =?us-ascii?Q?KdUUp3+O6pceDtOumSQpRto5/WU6ZhA8/9N9zpzj0uo5w5wQDxTo+qCy7Yz5?=
 =?us-ascii?Q?f5mxTTAm7sr0qAlWEAJ2z3pxcwgcKXSSbYeO5ClJRznVZA1r+A2Xls0d1fhk?=
 =?us-ascii?Q?qu7NgcXCkGAVD+rzNOEXUnvAA4O6RUwug+3YDZ9kpamL5y6ip7J/rEfqDvIN?=
 =?us-ascii?Q?xCL/fS6Alv/eKA/9T0xbcsb3l+uUy3kVubkLtk1O6I7foOZMaV8PqTReX0Ho?=
 =?us-ascii?Q?OYwvseqMgfcvD+K00cMpXbW1Zw0We5Jki3BQuxvbY9d05N9GgDH13kuP4ZcZ?=
 =?us-ascii?Q?ZGvgEMoC/nThpsWKvYa2sRnI2T1MkfJ9iXLoSz3KDfm/0buIoG9suAj4c0DX?=
 =?us-ascii?Q?CTIudITMUIDaj/kTsC76lz9kbWP14L/n5O2I2GWrExlwmsfmohV5r18/+I5x?=
 =?us-ascii?Q?yaBpfU6pnIJVEumdgC8jNHF6jbYTxnChkhzBm5thjG5FzayxALNrbcHegVdA?=
 =?us-ascii?Q?buvm0I5u3M700WKjspj7MBA+X2iEn8Ezc3bFtfE6fBFKJwbffBwduNlFusYi?=
 =?us-ascii?Q?6fdTEvUV6RUYQgt+/axSG+kPmoopyCGt4i9Ph365qbPY5pMJXugHNzsN6Txo?=
 =?us-ascii?Q?QX3A5yQhQWNDtluW7AlUGISV0di+UPWdceszki6HFr1ovE9KnAVIHXl2wU9c?=
 =?us-ascii?Q?bOg7oLlNYQEPqo5VYFXIuxZFrCnCeWJdWSqW1+6Ppr1t84mmY71rmnw5MzoI?=
 =?us-ascii?Q?+h6zCvaQ5K2t9zKxXsvtnVTOpYFyUzBUjjTtrjqrjuIpDRSL6BClJ8Mu2uDv?=
 =?us-ascii?Q?l9+NIpoeEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d251b9-1953-4fc0-8297-08df08c3c798
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:27.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dcKNT1iVIvPDUfYXgDlxJ+7Xcq1tZ2meU8a/krNJA6Dqz5mTNp1LqmTkFFIFBDeKsk68nFbigZxtD38mnKBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

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
index 439071a5c34d..13bd0c3faf7e 100644
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
 
@@ -514,6 +516,229 @@ static const u32 cxl_reset_timeout_ms[] = {
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
@@ -542,6 +767,20 @@ static int cxl_reset_get_dvsec(struct pci_dev *pdev, u16 *cap_out)
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

