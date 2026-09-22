Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E052FE44;
	Tue, 22 Sep 2026 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066406; cv=fail; b=HEMr1wcvWnNTrgCe/+zJxAC3ZLQ955SQRHjs1oh9ijw+Ub7TmtVnJx7CUae300As0iqdDARyIjFnxDr2CIx+SLN6/Z24KNrgv/otOZx1IyC0mwwMmGAdlt2vRtHPgnwa7zZP3YWZrGpQR1gQXwbg6jSlPVZV8RfNkfjHq7GtAb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066406; c=relaxed/simple;
	bh=ucf80xANCukrfYDyVBJwcEX6su8DLLFqulqS/eUQgs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYjzm+bxIRzcQwO8iut1RQVRg2OHSSIYdfrsF7Ka3kMn7sZRpszS7uBQVTnRD6MgWIMYncy5HVmsYKIY/HCLOoGDnbpPA09JAE57yRIBRxpKdVEsVJzzXkukjqV8dPowcYI0mLUcMTb2or/deKRBEzv6NPP63K09NmcuceAKO48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WSkqMzsF; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WSkqMzsF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBZVNA+KJeivQdbI1y5zhf6SbgGSoxparebU8zk/LWd0PY2IJ3RgvWdZ6P27ykQuI9ScxcfKCYPK18slqHaIsjFGzj9D+bmTQKWwphiOs4YfuxusPeM1ClIxikUTDrevFtBlMs+bRLW2mRwj8tQJGguhi6OWfsNQtTKLLXR3d6ZHwCF6v1+Wetf8QSs5pXkwgzvkPVBKF8Y1kxN/0Q/mgafjFSIsuogxKnFrwFZapF+KNBjUxhaSRmxnobDTRwH/91GbCmulss+RzFWRkukwHLt/IUE7tJTzrr64BchI5PD398maEf1aQ1rLvb0R6LoVX7CScjRCBMZQpAEL+2b/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/mi1l9JE7hAkoC+ALvZvky48CMAbmjSMUpq+HY0K0g=;
 b=uhkRrA04oDY8ACt+BwA/S19yt56wwi+66P5uFd9Cgdh1lbBNd1uyqYqL0Ij+WexOrQKSEeqhLPW7+7Iwcgu53xuLXJrrIMjumDmuXBGE4TrBNgkRiC5d2ojdaSNgP8iUvt27muuSzJFB7IILde+2zoCehbvNGFd0O6hrd+PAyLku3rd48ycGqIT/q5bQ2dxgqL/SAvHgrnqyiCewWBVQ+YVv0b+J4mfzy7RfYg22+B0uidTyT74BqnvZaoq1M+fC4wpUPdNolmkgMR5YIYj2Caic+mte4ONRitze7sHJkgZoJWLDHXIadV2IvYSNKFMSPDGAbTVFX+Moc6c8bdWXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/mi1l9JE7hAkoC+ALvZvky48CMAbmjSMUpq+HY0K0g=;
 b=WSkqMzsFBB3PzNqevez7bNAuNcPJjAxgNJGnz4zZ2Gce7IDfeDhDRvjZm2i2LsvfNi+uRFwtoD6yuxbr74H4aiaT4/eogGKP0DPkiUkhN77kUPh6wacs7YHVqksCCATUCwkkflY8C+paROphTqVLSG3iz0tKoL6RGmus2N+8pd9zKgIkbSx5Iqp1OQOFlbaBGYrObLZv6gp+B1y9Bhu06af7IMZBntEJwCS0/kUjAkpYik0uVWNrf9MMhwlNR/KUH/kmhHIbSnlI5C/mLGC7V/Bsgy1ATjhUz6PhVhqAovbSRZlCF3gl5eC6x9UoAUrIVjv5neK9mcTTNaEAGBryww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:59 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:59 +0000
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
Subject: [PATCH v13 13/15] cxl: Restore CXL state after PCI reset
Date: Tue, 22 Sep 2026 08:39:22 +0000
Message-ID: <20260922083924.2451158-14-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::32) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad116f3-b605-4941-2c57-08df1885162d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	myeK8PfrLxGnxwmWXUHT9LQzOdgGwr0lzPA+yQPrIT1GFq/iICW9TcWY+fPdX6zkua4+15CSzY+CnJAJSPDQCPDD+E0XW1ghpw1ecv6qU8E6t0tcj+81V9oOgK8vmUnblOMWULm/UKB8To5IAyDDXMzr9N4my8IDtgdBG7q70VyxHuiiAiB3Cd8/1zc2UI8UcaOynT5YGxZBilpcoTKYhgdtnHFKKKrXZgd8pn871jOBw0JWwHYRlBIa3BMVCjkp+1fNWJo4VRUvTp0OJaOrcN1jNEiLxesdu3ODRTDHdIFNBY8mSVpedXgzCVfJYQYQacMuj7EiA+PwoQZ47Hl8i32L2sCypYiHrEW05S0CqfBl2DD06kvflnp3ISNx0j/MgEmMHqzr7nDKvMltC2x1LLTmr5QL1qChHWewzcR3E7aLx1SfZEC+060/gShRI9i/N9cKcBXp3QOZVV1uN+KlLPvZ1JM+0RdWxMRw82di+VbOKC1K9zhIy90ovrerDgPwEaivBLYZShuV0ohUHf8BfqQSeoq+bhhQSVA9Tby0o743Cb8wSW1rwOxqWu7ragys4VgHdNGqM94F7r/5KQwGJEqpIcJ53P/yaaFFIHUUHtFRGtNFPPQTfRuLtYDMX/J8fXK2xj8O2dDgJR1sZdHoSmkLJMiM6w9HyINjlyz2CptggKXiyKP4QvyCg+SDDqeQ5owdZ8pcFFZYcWdk+SiFWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8L3jd/E0p/14lTzAHqasoT6d8shp8mPuDpb6xjIhnevRr+rIVRgXFhYBSrK/?=
 =?us-ascii?Q?MMZSfFTht5raAHkZnUZqXou4Di3BlOAZjbI67arBREk4nDQkagzBaNaPa0z+?=
 =?us-ascii?Q?doqgkD8kFV44qEmcOYa01hjbkvm6fdW5u0+RfvULEYRUtxPhb9EC4zkMUapY?=
 =?us-ascii?Q?sBqA8QIw0UfIReGgZl8nZViGGTsJZe6ELj0xY1PU5EbZZx4is/NFcCw2a8S9?=
 =?us-ascii?Q?AnCZAuBMAX+2YNQUU4oTiJnsAJXa/SvFCilIomyg9DH+KQCUi0IKFoRpN/ic?=
 =?us-ascii?Q?bm5GyaWif3tyyFd/Eeq/vDCCIDrLqymMlrI8Cr8FNlQ2c2sVT+n5WSphW8pB?=
 =?us-ascii?Q?2t8a/lcUuBHiBpD4rfJNgARLc6hbOnt/TqWIbGNOBtjXrasuRKSUQVG8lh6j?=
 =?us-ascii?Q?eA58wra3nx5HMS+TSgYjsWL2pf8euU6JBcwuHzd99TU4z0v09EpcJsj420g6?=
 =?us-ascii?Q?ng8VcaFfMv++btDcXQz5UjICVphZlr2vPmZBahnQtpiNm5Af+ybDBH73QjCP?=
 =?us-ascii?Q?pw97rPzthryoYhDkUcYWQ39rCmSk3y1J6t1CrRJH2mij1FlLYQDyQnT8QknT?=
 =?us-ascii?Q?de0uheq1VbU7PlZm7jIfFecX9ZiVCbPLrDyWrQY4ydXC45VE294FyHNf44wn?=
 =?us-ascii?Q?Nz4O9ErfSD+UqQfRNOy1LYyzXRJw6TpUJyTgwoz/121Q6Vfaf5FViOCnEXqW?=
 =?us-ascii?Q?TyGV4pyfBXojdHgeWnAJLka9hzyI1NyyNoza+TyC3ruA2iDdVbcFr1XjQnTQ?=
 =?us-ascii?Q?2vTgvXIIrIY3i7xVEkyk699CuUaGKyq6HTy+XReVFB2eXkyZOlERVVs1FvY5?=
 =?us-ascii?Q?Mo9Cp/HGBd2UC1Pkl568tEl6dkL9iM69mrmdYOb4oOGniDSUiysDVoMfo9/y?=
 =?us-ascii?Q?Tsu7aiYjXn1uz1WRRIK8ekKcGcrqJ2OFHbC6/WBx3jkqZnFrp1g4p18xMMw+?=
 =?us-ascii?Q?INRUHK+hQFx5Z8HddgQRmROEKrC/J5Z8BdzoW6BQDPNzOOA8LVfbeANsPtuC?=
 =?us-ascii?Q?8fK1FBX5PKkibm9qnvzfFk8FfyzjlHLvhSeDZx/7bOZOh8dNI5EAFgteD8vW?=
 =?us-ascii?Q?91T/I1LOTm5dAQidsKBMojm7jCv8i9Saz+giQAJRLX00gkwV44/t3romgTUF?=
 =?us-ascii?Q?wzV1xQB6uW6fA+DkeLYOyNqT13Z5XXToAVIg1+bK0L0V5SMfbfXhIYQZB7U5?=
 =?us-ascii?Q?eOqHQ69Cwf70OeL9iLuEv8xUREqxrmpfvCGucW2+lYrGfTs7HyIvjCiBGK/z?=
 =?us-ascii?Q?yPA3xyX8Xd+FB9fZEEeoJ0uyznYw0ieUO6V9TAlx9pAAKS2M4mFn1g70Vi+P?=
 =?us-ascii?Q?cncE32smdd2WamkkvXRpiSyazV36hqhk+seKz5LsftIVGIuZvJq+NKOm62GD?=
 =?us-ascii?Q?MF8ETn2IYjE9rBAIDpYk1ZypDBes0ma6iHxR9+C5vclm8dRoF7fx7sv9Y0FD?=
 =?us-ascii?Q?Qo5fsFDuZQZ9z71tzCXoDuTDN9LlALFphc7NXDKBMC0TR6bpxJNXMMlXATFS?=
 =?us-ascii?Q?XPXAW9NS0pYIu/qKm9OmSFvjlmnl0KgD/kCVOIPI0gV+jfCcj4VVZT4j38h5?=
 =?us-ascii?Q?y83gIQTTofo8seLiIURh5yyih+oQvpLH90XylSyR8RrkOJh+o0RCciEmUJI+?=
 =?us-ascii?Q?io3H5rBUI9V5ir/6rJ9dHCu7US9L8Kk88wBmGyVV+8tFPN3WsyJ45sceYSk2?=
 =?us-ascii?Q?0doiIzijkJXeh5Rjkk/AmSgEAXlHiyiYoxRRE74S6YaFZW3z5ox+03M4TBio?=
 =?us-ascii?Q?U7DJzW1ctA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad116f3-b605-4941-2c57-08df1885162d
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:59.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntL2vyINAkSmkQGHyVpV+PgMmzahOHuTtsNQ3Nn3TwQLf53Xym6Fdaz5JbEpdeKGn2XuRfhNqi/590ybjOJUrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

Restore the PCI configuration needed for HDM access, followed by cached
HDM decoder and CXL Device DVSEC state. Recommit a cleared locked decoder
before restoring its lock, but leave surviving locked state unchanged.

Stop at the first restoration failure and preserve a disabled PCI command
snapshot. Keep IOMMU exclusion active through restoration and post-reset
cache invalidation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 442 +++++++++++++++++++++++++++++++++---
 1 file changed, 408 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 249b1280f3d3..79ed12ecea81 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -82,6 +83,26 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
+static int cxld_await_uncommit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static void setup_hw_decoder(void __iomem *hdm,
 			     struct cxl_decoder_settings *settings)
 {
@@ -424,6 +445,323 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	kfree(info);
 }
 
+static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
+						 int bar,
+						 resource_size_t offset,
+						 resource_size_t size)
+{
+	struct resource *res;
+	resource_size_t hdm_start;
+	void __iomem *hdm;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
+		return ERR_PTR(-EINVAL);
+
+	res = &pdev->resource[bar];
+	if (!pci_resource_len(pdev, bar) ||
+	    (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) ||
+	    resource_type(res) != IORESOURCE_MEM || !res->start || !res->end)
+		return ERR_PTR(-ENODEV);
+	if (offset > resource_size(res) || size > resource_size(res) - offset)
+		return ERR_PTR(-ENODEV);
+	if (check_add_overflow(res->start, offset, &hdm_start))
+		return ERR_PTR(-EOVERFLOW);
+
+	hdm = ioremap(hdm_start, size);
+	if (!hdm) {
+		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
+static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
+				    int id, bool *retained)
+{
+	u32 ctrl;
+	int rc;
+
+	*retained = false;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -EIO;
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) {
+		pci_err(pdev, "CXL HDM decoder %d has commit error set\n", id);
+		return -EIO;
+	}
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			*retained = true;
+			return 0;
+		}
+
+		pci_err(pdev, "CXL HDM decoder %d is locked and uncommitted\n",
+			id);
+		return -EIO;
+	}
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	rc = cxld_await_uncommit(hdm, id);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n", id,
+			rc);
+
+	return rc;
+}
+
+static bool cxl_hdm_decoder_settings_match(
+	const struct cxl_decoder_settings *saved,
+	const struct cxl_decoder_settings *active)
+{
+	const struct cxl_decoder_config *a = &saved->config;
+	const struct cxl_decoder_config *b = &active->config;
+
+	return a->id == b->id &&
+	       a->hpa_range.start == b->hpa_range.start &&
+	       a->hpa_range.end == b->hpa_range.end &&
+	       a->interleave_ways == b->interleave_ways &&
+	       a->interleave_granularity == b->interleave_granularity &&
+	       a->target_type == b->target_type &&
+	       (a->flags & CXL_DECODER_F_RESET_MASK) ==
+		(b->flags & CXL_DECODER_F_RESET_MASK) &&
+	       saved->target_or_skip_reg_val == active->target_or_skip_reg_val;
+}
+
+static int cxl_restore_hdm_decoder_commit(
+	void __iomem *hdm, struct cxl_decoder_settings *settings)
+{
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	cxl_commit_start(hdm, settings);
+	return cxl_commit_wait(hdm, settings);
+}
+
+static int cxl_restore_hdm_decoder(struct pci_dev *pdev, void __iomem *hdm,
+				   struct cxl_decoder_settings *settings)
+{
+	struct cxl_decoder_config *config = &settings->config;
+	bool retained;
+	u32 ctrl;
+	int rc;
+
+	rc = cxl_hdm_decoder_uncommit(pdev, hdm, config->id, &retained);
+	if (rc)
+		return rc;
+
+	if (retained) {
+		struct cxl_decoder_settings active;
+
+		rc = cxl_pci_hdm_read_decoder(pdev, &active, hdm,
+					      config->id);
+		if (rc)
+			return rc;
+		if (!cxl_hdm_decoder_settings_match(settings, &active)) {
+			pci_err(pdev,
+				"CXL HDM decoder %d retained unexpected locked state\n",
+				config->id);
+			return -EIO;
+		}
+		return 0;
+	}
+
+	if (!(config->flags & CXL_DECODER_F_ENABLE))
+		return 0;
+
+	rc = cxl_restore_hdm_decoder_commit(hdm, settings);
+	if (rc) {
+		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
+			config->id, rc);
+		return rc;
+	}
+
+	if (!(config->flags & CXL_DECODER_F_LOCK))
+		return 0;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -EIO;
+	ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	if (PCI_POSSIBLE_ERROR(ctrl) ||
+	    !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK)) {
+		pci_err(pdev, "CXL HDM decoder %d failed to restore lock\n",
+			config->id);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int cxl_snapshot_hdm(struct pci_dev *pdev,
+			    struct cxl_hdm_info **snapshot)
+{
+	struct cxl_hdm_info *info;
+	size_t size;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info)
+		return -ENXIO;
+	if (info->decoder_count <= 0)
+		return -EINVAL;
+
+	size = struct_size(info, settings, info->decoder_count);
+	if (size == SIZE_MAX)
+		return -EOVERFLOW;
+	*snapshot = kmemdup(info, size, GFP_KERNEL);
+	if (!*snapshot)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
+						  u16 *command)
+{
+	u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
+	u32 restore_config;
+
+	device_lock_assert(&pdev->dev);
+	*command = saved_config & 0xffff;
+
+	/*
+	 * pci_restore_state() is the available interface for restoring BARs and
+	 * related PCI state needed to reach HDM MMIO. Temporarily alter its saved
+	 * command value so that it enables MSE but cannot enable BME or INTx
+	 * before CXL state restoration completes. Preserve the original saved
+	 * value for the outer PCI reset path.
+	 */
+	restore_config = saved_config | PCI_COMMAND_MEMORY |
+			 PCI_COMMAND_INTX_DISABLE;
+	restore_config &= ~PCI_COMMAND_MASTER;
+
+	pdev->saved_config_space[PCI_COMMAND / 4] = restore_config;
+	pci_restore_state(pdev);
+	pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
+}
+
+static int cxl_restore_dvsec_ctrl(struct pci_dev *pdev, u16 saved_ctrl)
+{
+	int dvsec;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
+				   saved_ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_restore_state(struct pci_dev *pdev,
+			     struct cxl_hdm_info *snapshot)
+{
+	void __iomem *hdm;
+	int count;
+	int rc;
+
+	hdm = cxl_pci_hdm_ioremap_current(pdev, snapshot->hdm_bar,
+					  snapshot->hdm_offset,
+					  snapshot->hdm_size);
+	if (IS_ERR(hdm)) {
+		pci_err(pdev, "failed to map CXL HDM state for restore: %ld\n",
+			PTR_ERR(hdm));
+		return PTR_ERR(hdm);
+	}
+
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count != snapshot->decoder_count) {
+		pci_err(pdev, "CXL HDM decoder count changed from %d to %d\n",
+			snapshot->decoder_count, count);
+		rc = -ENXIO;
+		goto out_unmap;
+	}
+
+	/* Restore global HDM control before committing individual decoders. */
+	writel(snapshot->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (int i = 0; i < snapshot->decoder_count; i++) {
+		rc = cxl_restore_hdm_decoder(pdev, hdm,
+					     &snapshot->settings[i]);
+		if (rc)
+			goto out_unmap;
+	}
+
+	/* Flush posted HDM writes before restoring protocol enables. */
+	readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	if (!snapshot->dvsec_ctrl_valid) {
+		pci_err(pdev, "CXL DVSEC control snapshot is invalid\n");
+		rc = -ENXIO;
+		goto out_unmap;
+	}
+	rc = cxl_restore_dvsec_ctrl(pdev, snapshot->dvsec_ctrl);
+	if (rc)
+		pci_err(pdev, "failed to restore CXL DVSEC control: %d\n", rc);
+
+out_unmap:
+	iounmap(hdm);
+	return rc;
+}
+
+static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
+{
+	u32 *saved_command = &pdev->saved_config_space[PCI_COMMAND / 4];
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	if (rc)
+		pci_err(pdev,
+			"failed to disable device after CXL reset failure: %d\n",
+			pcibios_err_to_errno(rc));
+
+	rc = pci_save_state(pdev);
+	if (rc)
+		pci_err(pdev,
+			"failed to save disabled state after CXL reset failure: %d\n",
+			rc);
+
+	/* Ensure the outer PCI restore cannot re-enable MSE or BME. */
+	*saved_command &= GENMASK(31, 16);
+	*saved_command |= PCI_COMMAND_INTX_DISABLE;
+}
+
+static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_err(pdev, "failed to restore PCI command state: %d\n", rc);
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	rc = pci_save_state(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to save restored state after CXL reset: %d\n",
+			rc);
+		cxl_reset_save_disabled_state(pdev);
+	}
+
+	return rc;
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
@@ -726,6 +1064,18 @@ static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
 	return cxl_reset_wait_cache_wbi(pdev, dvsec);
 }
 
+static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec, 0,
+					      PCI_DVSEC_CXL_DISABLE_CACHING);
+	if (rc)
+		pci_err(pdev, "failed to re-enable CXL caching: %d\n", rc);
+
+	return rc;
+}
+
 static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 {
 	unsigned long deadline;
@@ -767,28 +1117,41 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 	}
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
-			     struct cxl_hdm_range_context *range_ctx)
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 {
+	struct cxl_hdm_info *snapshot = NULL;
+	struct cxl_hdm_range_context range_ctx;
+	u16 command;
 	int rc, rc2;
 
-	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	down_write(&cxl_rwsem.region);
+	INIT_LIST_HEAD(&range_ctx.ranges);
+
+	rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
+	if (rc)
+		goto out_destroy_ranges;
+
+	rc = cxl_snapshot_hdm(pdev, &snapshot);
 	if (rc)
 		goto out_destroy_ranges;
 
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (rc)
+		goto out_destroy_enable_cache;
+
 	if (!pci_wait_for_pending_transaction(pdev)) {
 		pci_err(pdev, "timed out waiting for pending transactions\n");
 		rc = -ETIMEDOUT;
-		goto out_destroy_ranges;
+		goto out_destroy_enable_cache;
 	}
 
 	rc = pci_dev_reset_iommu_prepare(pdev);
 	if (rc) {
 		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
-		goto out_destroy_ranges;
+		goto out_destroy_enable_cache;
 	}
 
-	/* Clear Memory Clear again even if this command write reports failure. */
+	/* Clear Memory Clear below even if this command write reports failure. */
 	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
 					      PCI_DVSEC_CXL_INIT_CXL_RST |
 					      PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
@@ -798,39 +1161,60 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
 	rc = cxl_reset_wait_done(pdev, dvsec, cap);
 
 out_clear_memory:
-	rc2 = cxl_reset_update_ctrl2_no_replay(
-		pdev, dvsec, 0, PCI_DVSEC_CXL_RST_MEM_CLR_EN);
+	rc2 = cxl_reset_update_ctrl2_no_replay(pdev, dvsec, 0,
+					       PCI_DVSEC_CXL_RST_MEM_CLR_EN);
 	if (rc2)
 		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n",
-			rc2);
+			 rc2);
 	rc = rc ?: rc2;
+	if (rc)
+		goto out_finish_ranges;
+
+	cxl_restore_pci_state_for_hdm_restore(pdev, &command);
+	rc = cxl_restore_state(pdev, snapshot);
 
+out_finish_ranges:
 	/* Evict lines fetched during reset before ending DMA exclusion. */
-	rc2 = cxl_hdm_ranges_finish(range_ctx);
+	rc2 = cxl_hdm_ranges_finish(&range_ctx);
 	rc = rc ?: rc2;
+	if (rc)
+		goto out_fail_closed;
+
 	pci_dev_reset_iommu_done(pdev);
-	goto out_enable_cache;
 
-out_destroy_ranges:
-	cxl_hdm_range_context_destroy(range_ctx);
+	rc = cxl_reset_restore_cache_policy(pdev, dvsec);
+	if (rc) {
+		cxl_reset_save_disabled_state(pdev);
+		goto out_unlock;
+	}
 
-out_enable_cache:
-	/*
-	 * DISABLE_CACHING was the first preparation step. Restore the original
-	 * cache policy last, after reset exclusion has ended.
-	 */
-	rc2 = cxl_reset_update_ctrl2_no_replay(
-		pdev, dvsec, 0, PCI_DVSEC_CXL_DISABLE_CACHING);
-	if (rc2)
-		pci_err(pdev, "failed to re-enable CXL caching: %d\n", rc2);
+	rc = cxl_reset_save_restored_state(pdev, command);
+	goto out_unlock;
+
+out_fail_closed:
+	cxl_reset_save_disabled_state(pdev);
+	pci_dev_reset_iommu_done(pdev);
+	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec);
 	rc = rc ?: rc2;
+	goto out_unlock;
+
+out_destroy_enable_cache:
+	cxl_hdm_range_context_destroy(&range_ctx);
+	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec);
+	rc = rc ?: rc2;
+	goto out_unlock;
+
+out_destroy_ranges:
+	cxl_hdm_range_context_destroy(&range_ctx);
 
+out_unlock:
+	kfree(snapshot);
+	up_write(&cxl_rwsem.region);
 	return rc;
 }
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
-	struct cxl_hdm_range_context range_ctx;
 	int dvsec, rc;
 	u16 cap, ctrl;
 
@@ -873,15 +1257,5 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (!cpu_cache_has_invalidate_memregion())
 		return -ENOTTY;
 
-	INIT_LIST_HEAD(&range_ctx.ranges);
-
-	scoped_guard(rwsem_write, &cxl_rwsem.region) {
-		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
-		if (!rc)
-			rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
-		else
-			cxl_hdm_range_context_destroy(&range_ctx);
-	}
-
-	return rc;
+	return cxl_reset_execute(pdev, dvsec, cap);
 }
-- 
2.43.0

