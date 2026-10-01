Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D83F788F;
	Thu,  1 Oct 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846596; cv=fail; b=ctW3zNXheXNp3JhHH+O1cnlw8wAGb4tpwyigIECnGwTYwC/aZn/eQnIRxKPRm85HWD1s6CV2oeOWsgVN2lELQiazI3O3pPKruIlkp/2gqYmL9i6FRhaw0xK/xN3vZe0C7EkwbYY2q0PJkz3Idg0S8Tm/NK5i9MOTd8IVpohme8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846596; c=relaxed/simple;
	bh=Ax91tReatSx33O6qCU6AytpgMor9eYRGswbmc+ONIF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XkAQX6HV8hK3qFCdDlSukGXiEp4J61DnUS0SPbE8s2RwwlPnPE1IJl8KAlK5plrCEpGL6ztCBhc8UJrz98Z1lsc3BC3kbiF25Evjbm4mWuZzuXjfKPJgVSCQadOOEBDnJyIeLWmKqrgAmiqO4/JPDHyyLYblcL8W1huEEdlXkjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VLekAWFi; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VLekAWFi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I10e5aQyOSP1/UFAEg8DCT2Bma33PEBRfpqDPeQMp5kDsymOmzelsuQWdQB1oo92GExz1jauDzKKqXMa5uaG5/Fdh61APLac2TkwCsVfrmhA5RHyv5C68q31jlW9fC3GDNLQCvFN/3hnnbB3WcK06CP8dvjTLPQjREZ2llfK3qBI8jBDFUpEs1zTJQkx68c5eIrtcvIw90jzJfuioR8y9MCc9PhrLLh9yBUryrZVbOZIGrgZrkHxbCAxH/620gkfuWAbxmBzerMTP/TwKYt7DfZiJM78EjGsjFc8eNEAv3JDWrzHsfaa7V3wGIfEaeo6gKQrBr+E5FKk8xNDRFgNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/fzicXYa0VD/y15kf2jhB0nr+znnmp9L09ELpBualQ=;
 b=nb7hPs5eittTykM39KSyXJLlBk1ojYgVlBZTEouXJWFWM5D0S1mEEhDDV1ubEbOdbME2IxqYG+2rfddHwe3E8dEeeFgzfC9kNwD3+foD7Haq03vcK+AOmHgWmsUmkmuj/5JK9Q8pVv3XCf7hj+zxSwYRtngveNg77kAIKLYv3tC9wR6YhAdETx7WoGszWOHGiWzfok8nVTihi951HXjA19uPoUmGt1YC4bK+zgraCWJW2K+BHAMjnW0YlhloCZjeuBK4YNLQvpEyUbvyxb0e5v0Nf8PmWtZeh8F+m/y5ZFrLy2QfRADzKthAKH0K8Miq3S8+uiIYOe3X147ElfSmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/fzicXYa0VD/y15kf2jhB0nr+znnmp9L09ELpBualQ=;
 b=VLekAWFiZaj2oyymAaLsz76q15MA8BmbaEFx2vOuZKsAWLQgzhVAFods4/s27eE7Kr5LQp1aNvTepn+gddi06D3X/tn0oCym+7EnZXVGMSSSVLbDCr2QLp7LOS5GaRRsk1uI21tRUvG2EJvuezI0wmggTr4pf29TYrTAsf+WW0LhgM8VitHoiZjnHMXZPgUnmNRNuFyCI5/pcwimx9uGEdYY8si3olANnitJYeJZReXZPt2VBOm+GoqusywRT/ioGthbvOcSeucGcngpyl35h05iuYIEf1/+2PzVLaLc5wl8RFNWe1ZWNjF5xVxa8+jO+JchArkWlZ+FExTOs2D0nA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:23:06 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:23:06 +0000
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
Subject: [PATCH v14 12/16] cxl: Validate and synchronize HDM ranges around reset
Date: Thu,  1 Oct 2026 09:22:23 +0000
Message-ID: <20261001092227.3004747-13-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c6cb0c-5f1c-4e47-c011-08df1f9d99b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5HpmiLRiM3DgeSsqwD5N8q9aQkF767r8ZgNHUaxaFyVnSUurlLy4SqotGOoiTlNBm9Q24DQUA9qCLmFfgzQKdF9mRU4XoMUC675VxTPQSY+J3v6l1S9WMBh1BRn4jeGymXlMf17+WjTMz+p8vVB8q/bb/5QK7zg+paiVkTpM2gZULdNG+Wo7UpEyU0IZ8XaLqv8Sxm857umDhSgk16L/V7zD2YAd34uqIg4OCBMHxR/ORBQVIafK+3Rzf3+pD6f9ImbDSiZd77DYXV3lW6Url/KHymPqVhu8l/nGBtKcyOd0CM6VsXrhkRPutnpHfHIXqhvr2WOKhGzILHXpJOyRDcAMoz4zVhdnoCHsnf0+F7ImtRKRwe57d7h23d3ZLxT/D1ccyzyrlQlkk4XNwYhpVv1inK3DjgqfMyiOMVIuYHfvWWMUVYR6Sc4EMe+67oDetFSkv95jqf7X2ReB2mtza3376W1w0lUovQeva9p6E5FaEJSkwpAo638ySMVuUfdi+uyIskyiI/YaNqKKletgwOqjpY9nPSEmsCvaiTwknS5OJkOzXGYsR10G33dCVB/i+LZBWYMN+CG6nnQAcExOEfJYhI2346evDnDRsEDFeFV58dopWs+ulOmjXCGZ0qX0Unw/eRroOo0vkynlo9tF9QI8tVFopZ/lNH4wwRLW8neUKrZSoCfrMVGvqYWCkE0YLzcAD+6QiwtnHlNxQjBF7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?se9aqfXmZJFRY/uPuMdyc6X0Wmi3A2YEvNsoE0hqQ2b25B+bVyycM0jFKfIa?=
 =?us-ascii?Q?ymnEWl47LnhEMXFgNyFEB/NNiC7inmwQgiUmjHvKbA/+3coQXdKVanDI7zEH?=
 =?us-ascii?Q?mUEkopRjyDkhN6UGi6DUoeMaRKoHhk/xfLHLZiF/9xOmpo6NrjE02bMgbbyw?=
 =?us-ascii?Q?LvcT9t0XAalj7hJb3dbbBAW+U/WmtWRMJP7Gio+PI3Uye/R72dnMaRjmtSDq?=
 =?us-ascii?Q?T4w44d7E6cuGWbys+NbrToKWwwPWdQgnJndaeNd2s6E1dirC6ZsI9SWA+arJ?=
 =?us-ascii?Q?YzQoRjNod+zG7Q1l97xJF+Qvr3n1sonra5fxxtZkwlyaWaC1aMLOIUB+iPso?=
 =?us-ascii?Q?m3I4twtKt4QgctA5Y8hnBR7mbc8l0BO09+e1r+ooL528pHJZi2ducDZy/gLh?=
 =?us-ascii?Q?IT5t6ko94CZaZRkJKBrp8Bsamli5SFLAiOgXcwhcfg30VB1tsa3PKceDtD1z?=
 =?us-ascii?Q?EfxXHFv8CPsmWceiiYFDsYMxk2v6s/gRBng1/jtxwfrAETS05UvzWw/y4Otn?=
 =?us-ascii?Q?fsLROPqasxmbViMmrpKXlsKj9HqUJc6avqp4fgctHSzi54TcQBpqZeYQyh/G?=
 =?us-ascii?Q?rjp6FX0d9GQPDJYXXOaXrQB19u+kzoAUHj/lm85K/8nPqboQAPYGE3N/58nr?=
 =?us-ascii?Q?Nm4vXHTw4ZoPha0jgpGrTcUTJ/fi/Xk5MoT9BLXuRtdRojmog6inOXfpuV8z?=
 =?us-ascii?Q?o/vk07PwMJmwLmKYxQJovX0THgqmK/cP4A7xVhE+1l0YjDya1zIkO7e7uyk1?=
 =?us-ascii?Q?UTIs4IKxX6Pfi9/yXgWGcoCxNlB+mVpcYiLBbR4xthc4VeCx55dJC2P3GtBC?=
 =?us-ascii?Q?wREAItHYs5o3Hr/g+tN9CWku1GA8wX5nXUQnFDSUQkM5HGO8YAdz/1xXT1gN?=
 =?us-ascii?Q?Gudx+R1KrySx1FaKStAC2Elc4wC5coDA5Pe1XKWDqtgIPqwNVCoVYyclpNww?=
 =?us-ascii?Q?IrZ55SHNn+PJxcVr3xssIoWwvqjCF3+u8qBuHpFpcEVeAbwj+Y/tuWypA6Qa?=
 =?us-ascii?Q?pghMnLx1pXc6dHEsS3XFFQ1s3sax3N3CIbNCcyrXxrcogN7ingpHtAERJo37?=
 =?us-ascii?Q?Xwj80OAwOsTkKwM0u/dEx/8g7EyDdEMbEK/YC/4wZe5/g/487jxyKG7Dyh8d?=
 =?us-ascii?Q?PVAhLIeIw3PX+T9oLdtd0N/CeMPpDQhiWAAcKE1FJkryt/ToUuTlzdAGo09+?=
 =?us-ascii?Q?OnrdGw7SpHefPNE36B3rQXYE+J1O/SViK91EV08drmzqhnbiqYol+FaEzI6g?=
 =?us-ascii?Q?ksHQoNC8u3vdy0VXut31aDrG0FRNGsc9Eit8Y0Ro90LzX4zErAjl+ze7apGP?=
 =?us-ascii?Q?GfPTDaHlZSX1l6lPB2I5KRpHfLRFPIwscB5XAhM5n5/FyZVz4guBNKUGWgjW?=
 =?us-ascii?Q?/35OtCUdarCw/5Iq3aGOhuqt8A5AgIUNo8BczaMjqi8nPB7rMwE+L76DfE/g?=
 =?us-ascii?Q?vokDymRzzOjEjc4r4yyfBLrKzHoin7xPJ7E11DZu93gNk5l1AKg8SV0s/4Y9?=
 =?us-ascii?Q?t9Kj4mPEovv9xd5xDOfHv0S3FqGPBIXWMC3Tx5jdhf4+F7I1ezcx7s3IvFDM?=
 =?us-ascii?Q?k4yuZmKbpLqNASEAHblFc2W+QXS9v5ybaLQVxQDcwTYIf7D1PxA1peMhLKgw?=
 =?us-ascii?Q?szFt7edxhfVtQyEMOzui6PQgz0hKsRI3PMmV+m0p9U6IYoMI4vcLe0/YV5zg?=
 =?us-ascii?Q?dkzKEif32mcsDeT7Kl4iuCP8G26TDlAhR9ruZpqLamhGhsdfr2fkYVyH+FVY?=
 =?us-ascii?Q?DusxSaUVbQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c6cb0c-5f1c-4e47-c011-08df1f9d99b3
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:23:05.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xZsGawNkQ0QUYck1SewjuPwLvx7PiIunx+zvxzwHpWz5VUiL7hrECcYK4DxEXI3+YJHy5S/UMpDXRMfkoieCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

Refuse reset unless enabled system-physical HDM ranges can be reserved
exclusively and CPU-cache invalidation is available. Invalidate before
reset and again before ending IOMMU exclusion, holding range reservations
until the second invalidation completes. A later patch places state
restoration before the second invalidation.

Reject normalized-addressing decoders because their cached ranges are not
system physical addresses. Ignore zero-size decoders because they map no
address range.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 248 +++++++++++++++++++++++++++++++++++-
 1 file changed, 241 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 94f854520a1c..584b51cd9e28 100644
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
 
@@ -462,6 +464,205 @@ static const u32 cxl_reset_timeout_ms[] = {
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
+	struct cxl_hdm_range *range, *next, *new_range;
+	int rc;
+
+	rc = cxl_hdm_range_validate(pdev, hpa_range);
+	if (rc)
+		return rc;
+
+	list_for_each_entry(range, &ctx->ranges, list)
+		if (range_contains(&range->hpa_range, hpa_range))
+			return 0;
+
+	new_range = kzalloc_obj(*new_range);
+	if (!new_range)
+		return -ENOMEM;
+
+	new_range->pdev = pdev;
+	new_range->hpa_range = *hpa_range;
+	new_range->len = range_len(hpa_range);
+
+	list_for_each_entry_safe(range, next, &ctx->ranges, list) {
+		if (range_contains(hpa_range, &range->hpa_range)) {
+			list_del(&range->list);
+			kfree(range);
+		}
+	}
+	list_add_tail(&new_range->list, &ctx->ranges);
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
+		/* A committed zero-size decoder maps no HPA. */
+		if (!(config->flags & CXL_DECODER_F_ENABLE) ||
+		    !range_len(&config->hpa_range))
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
+	lockdep_assert_held_write(&cxl_rwsem.region);
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
 #define CXL_RESET_CTRL2_CMD_MASK \
 	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
 
@@ -612,7 +813,8 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
 					      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
 }
 
-static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
+			      struct cxl_hdm_range_context *range_ctx)
 {
 	int rc, rc2;
 
@@ -637,31 +839,42 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
 	rc = rc ?: rc2;
 
+	/* Evict lines fetched during reset before ending DMA exclusion. */
+	rc2 = cxl_hdm_ranges_invalidate(range_ctx);
+	rc = rc ?: rc2;
+
 	pci_dev_reset_iommu_done(pdev);
 	return rc;
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
+			     struct cxl_hdm_range_context *range_ctx)
 {
 	u16 saved_ctrl2;
 	int rc, rc2;
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
 	if (rc)
-		return pcibios_err_to_errno(rc);
-	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
-		return -ENODEV;
+		rc = pcibios_err_to_errno(rc);
+	else if (PCI_POSSIBLE_ERROR(saved_ctrl2))
+		rc = -ENODEV;
+	if (rc) {
+		cxl_hdm_range_context_destroy(range_ctx);
+		return rc;
+	}
 
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (!rc)
-		rc = __cxl_reset_execute(pdev, dvsec, cap);
+		rc = __cxl_reset_execute(pdev, dvsec, cap, range_ctx);
 	/* Restore cache policy after any attempt to disable caching. */
 	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
+	cxl_hdm_range_context_destroy(range_ctx);
 	return rc ?: rc2;
 }
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
+	struct cxl_hdm_range_context range_ctx;
 	int dvsec, rc;
 	u16 cap, ctrl;
 
@@ -693,5 +906,26 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
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
+		if (rc) {
+			cxl_hdm_range_context_destroy(&range_ctx);
+			return rc;
+		}
+
+		/* cxl_reset_execute() releases the ranges on success and failure. */
+		rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
+	}
+
+	return rc;
 }
-- 
2.43.0

