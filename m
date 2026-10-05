Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92BC361DBF;
	Mon,  5 Oct 2026 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183828; cv=fail; b=n5GCy+42Ffqbh0BUpZVOpWLWiEgH3Kx5O6kg53eEvTDbbFLBbEno/kG+T6rVe8tlNHc9/uIL24LQYA0o2H2WCa/BZzc9reVQBM2WGUYvOaU5xJp8NPdY1Ue9ECZwaaUS+PWcGi69gA2/D5n0u0sJlSKoC+T0DGpCbNM9Q06N77E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183828; c=relaxed/simple;
	bh=HTWHtLfg9WvDUy2V1zQWTHpXo8FLtTvGBVkePx+9sKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJTMzgjm1/mRzHRwzNVv8JDHZzbIL8QUJBugcmhpU1qOHTLZ0zxvonnDob5vzu+tm2GgY+iAHBWI7qRjwrL5waerAR+z/gEPbXMED7odwyEFtqlr42H17x4hLo9S1DvqauYEnglRw9tkDGvrxTGqBq5PZTxAuFYgdE+7GvgVLVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pXbSK4AH; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pXbSK4AH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwV1xd9GKN3wWbT6Wd53xZiFBAddCbYAvK2n3qcTWRWN+kZttbCZyiF9arS7ojRHVHBobP0j6n1/+uQglhZG6sNXzCNzC3224dfOb1SqDwlWuAb6dWroUXqDoSxCXVRAIFyuA4rYwWgPhwxYiQ8FmbUWHaOwOuPZndiTmAe+/h1eo5HwJwyvAX7YIDGoAqS25TMejeoNUln27qNgykvjsexafji/TgK631OezOHRExeHRoznbQPd0wvxChzGLzkRE8oxpxrJq85iYrEiuxbC5G8t2gn5zWtxRW1kMihAJeDsoWieOk22aq/TtckNgyEDIqvVNf9xKDydKjC6AX+A4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL8Yf0g4nj6l5kpGBPtDn0601sPiundM4TOd6xorYMY=;
 b=K2Lw6YQmG0dRAXQHy75gESyMcG59SWZNtHG5FQCR7AxiLI+o+pBeIsmciuAhacyEr7Zg0LkuW0HAtKEDjWcjPWwNqb5zc8M5s9ia5BgeaDW5QcV71E+X+gutC1zyscZe5gh7lP0PntGb+3+upeKrtHkbgbGylNa/UpIVDgNLe0Ze1SDzLjOxYLrt+YYaCcchvKKpc+KQygR6A1QtnFeW1joqArYdpzRSlmHTPQ5rad211jOJrbLkQHdnq1L7nKIv4kXcX2fG0pbYOYw+UD7vl1LuCYXiylR0pVmsRmHJ7D7PMr8sE3m5Odjw/fDYE6p/8r4DvKHJz3yoUdntyvDQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL8Yf0g4nj6l5kpGBPtDn0601sPiundM4TOd6xorYMY=;
 b=pXbSK4AHzMnt7BINk0c24BVAzUOvCqsjcIF857z0NvnQHWTc9jCujK9iasofu2pc7+zZuThWpzn/05ifu7GVPN33cBt1vpy7YbVvq+pfdmx6Eath9CNGEtd8JSOnOUhR0luz2+21K/1y2rcYDdmSoGo0cf/OD5SfVNy0tGNbOib7Tu0qZN8+MVBLOCZ4K25uMb+XjS6Kf40mZjbNJa5kfNrnTu6722vLi9mF+qWu5hWFU9istGfOvkOvrrPmKJ+t5AyUTTl2kwkaj+j31fSzKGRwwSPC0ZvLG1wp/hI+ISPIbcStYBW+Kd+HDIVAFUTxcmzI4LVUKW8gaF9kNYQtYQ==
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Mon, 5 Oct
 2026 07:03:42 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::9f) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 07:03:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 07:03:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:03:22 -0700
Received: from NV-9TMPJL3.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:03:16 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <jgg@nvidia.com>,
	<aneesh.kumar@kernel.org>, <aik@amd.com>, <yilun.xu@linux.intel.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <icheng@nvidia.com>,
	<bhelgaas@google.com>, <smadhavan@nvidia.com>, <ankita@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-coco@lists.linux.dev>
Subject: [RFC PATCH 3/4] PCI/TSM: Derive the coherent-range IPA from CXL
Date: Mon, 5 Oct 2026 09:02:51 +0200
Message-ID: <20261005070252.84810-4-ankita@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005070252.84810-1-ankita@nvidia.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: edb1929e-4cd2-4c3b-30d7-08df22aeca10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	w18SAp36tp1dV+6Vjc8sth6499wFrDAYk31svzM2+qib5uxPvrGXl1XAkhrOAoGS2jxs9y2zl/HTQMC2eSuFvXM7bvxUX9pjGZapO/bPGqZr3tYFDi0eoddSU+/8ZdzELHqfHXqs8+4Zrk2FO1dfLcta8LtXJtIEWmv2Yhx57p2ChMPKN2td/IhxE41pqtLP6ERb74YtR37HKDE02on1vMacjELWq5yyOCxRsMl3q1ZGmRZeYBANxeB/pelESC5eag4JgsbLOZVd+AMJEWJ/BCCh/rWmjE2B/l8szQ3cFccPOgemaXd2IYw4+jqWORHNJvlf9dkV+Lh7MvywwQSkjsEcr4RRjlfw2kHCTMkl1aIdGa8vzKjUkjIfd+HiEjOxuPMa7vc6kyw9gu+Omsl43yPzm+08KnWWQ9gYENhlBctLFuMhkqiPhoTl58e1AUw1mkFECSppMzzCa6VpAwkrzp74BN58vGnBJm2wTQay95nbnTUqlJfy4icX5VSsInwXGH8GM6yLJ0yvs+clHS+L75WSsm+WzMyQMx63cIxs4Qbs7qHQM/QBQaBZHNPZePWhvPJcjDaSxcPfibqjGyJ5x2hYqLLNKKxroMMzpJHhrDiKs1Z9hkzIx9cc7gUjK1WrFsyXQbwvSm0zjvVRgiicxIfknJNLWjA//1JzeeiavFGDvxOYbCtKvSwFLSBs6jn1Rh9BMFQZyMyF1PM0mzeoZw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8Ne2Jy3qXkKlOSlYUjwZk/pGBaW8CycSDi4sq4XZELRyhxmfaZdK1lagEZbfUA3DkUqSGrUvYSz8XrqrBnR2P+1aHHG3Xl88xRBYRKfmwrO7AS3vw44ztJvknoNE1YMQch/8S3I41sTaY7cBEcsXF/8C2WWpL0ic3mV4JXCwbr3RB4eawH+PtxQEaLypRhc7Vkesi2S8IzBBnQ22Q74lnl1CYWMI42Lo/u6rDdUaOANtWS8+6bK466g5HQgS2hUya9BweXA6Wng9DC4UKfMBfPGXm7ZOyuX1HkeUODt+6GMMacdn15G5wmo1V8iHnTTyJiXxBZygmHFKpkNhWXSw6DI6tBuRPjd8EShlRe1YpqFGtbLRVZ/YZDqtZ6rxxJTkdui5pqcXtMjSAoKAcfQ2GN6mnBuxhqhgN1/vdHnSaaCskNR2rc6+RD7orqCA0WMJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:03:41.8278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb1929e-4cd2-4c3b-30d7-08df22aeca10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

The DevIf report range with range ID 0xffff describes the device's
coherent (CXL) memory window and unlike every other reported range
carries no BAR number. Recognize
PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT and recover that window's
address from the CXL side of the device instead of treating it as a
BAR-relative offset.

pci_tsm_coherent_range() resolves the window from pdev->coh_resource[],
snapshotted once with the committed CXL HDM decoders range. The
range to IPA conversion is applied onto range_base/range_len using
pdev->coh_resource[]. The ascending BAR order checks stay on the BAR
path only. The coherent range is required to be the last report entry
and is not part of the BAR sequence.

An HDM decoded window lives in the CXL Fixed Memory Window and is not
part of a BAR. So by construction, no pci_dev resource contains it. So
the function pci_tsm_coh_resource_contains() validates the range against
pdev->coh_resource[] instead; the same known-good snapshot
pci_tsm_coherent_range() already trusts.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Assisted-by: Claude:sonnet-5
---
 drivers/pci/tsm.c       | 192 ++++++++++++++++++++++++++++++++--------
 include/linux/pci-tsm.h |   4 +
 2 files changed, 160 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index c8cfe89b6224..1d736b606a7c 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -904,6 +904,41 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 }
 EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
 
+#ifdef CONFIG_CXL_RESET
+/*
+ * pci_tsm_coh_resource_contains() - check a coherent range against the
+ * PCI-core coh_resource[] snapshot
+ * @pdev: device owner of @res
+ * @res: candidate coherent MMIO range to validate
+ *
+ * The coherent (CXL.mem) range isn't BAR-backed. So pci_resource_n()
+ * containment doesn't apply. Check against pdev->coh_resource[] instead.
+ *
+ * Return: true if @res falls within a populated coh_resource[] entry.
+ */
+static bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
+					  const struct resource *res)
+{
+	int i;
+
+	for (i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
+		struct resource *coh_res = &pdev->coh_resource[i];
+
+		if ((coh_res->flags & IORESOURCE_MEM) &&
+		    resource_contains(coh_res, res))
+			return true;
+	}
+
+	return false;
+}
+#else
+static bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
+					  const struct resource *res)
+{
+	return false;
+}
+#endif /* CONFIG_CXL_RESET */
+
 static void mmio_teardown(struct pci_tsm_mmio *mmio, int nr)
 {
 	while (nr--) {
@@ -936,7 +971,9 @@ int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
 		return -EBUSY;
 
 	for (i = 0; i < mmio->nr; i++) {
-		struct resource *res = pci_tsm_mmio_resource(mmio, i);
+		struct pci_tsm_mmio_entry *entry = pci_tsm_mmio_entry(mmio, i);
+		struct resource *res = &entry->res;
+		bool coherent = entry->flags & PCI_TSM_MMIO_F_COHERENT;
 		int j;
 
 		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
@@ -947,13 +984,22 @@ int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
 					     pci_name(pdev), IORESOURCE_MEM,
 					     IORES_DESC_ENCRYPTED);
 
-		for (j = 0; j < PCI_NUM_RESOURCES; j++)
-			if (resource_contains(pci_resource_n(pdev, j), res))
+		/*
+		 * The coherent (CXL.mem) range isn't BAR-backed, so check it
+		 * against pdev->coh_resource[] instead of pci_resource_n().
+		 */
+		if (coherent) {
+			if (!pci_tsm_coh_resource_contains(pdev, res))
 				break;
+		} else {
+			for (j = 0; j < PCI_NUM_RESOURCES; j++)
+				if (resource_contains(pci_resource_n(pdev, j), res))
+					break;
 
-		/* Request is outside of device MMIO */
-		if (j >= PCI_NUM_RESOURCES)
-			break;
+			/* Request is outside of device MMIO */
+			if (j >= PCI_NUM_RESOURCES)
+				break;
+		}
 
 		if (insert_resource(&encrypted_iomem_resource, res) != 0)
 			break;
@@ -985,6 +1031,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
+#define PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT 0xffff
 
 /* An interface report 'pfn' is 4K in size */
 struct pci_tsm_devif_mmio {
@@ -1003,6 +1050,44 @@ struct pci_tsm_devif_report {
 	struct pci_tsm_devif_mmio mmio[];
 };
 
+#ifdef CONFIG_CXL_RESET
+/*
+ * pci_tsm_coherent_range() - resolve the device's coherent CXL window
+ * @pdev: device owner of the reported ranges
+ * @out_base: host physical (guest IPA) base of the coherent window
+ * @out_size: size of the coherent window
+ *
+ * The coherent range carries no BAR number, so its address comes from
+ * pdev->coh_resource[], a pre-driver-bind snapshot of committed CXL HDM
+ * decoders.
+ *
+ * Return: 0 with *@out_base / *@out_size set from the first populated entry,
+ * or -ENODEV if no entry is populated.
+ */
+static int pci_tsm_coherent_range(struct pci_dev *pdev, u64 *out_base,
+				  u64 *out_size)
+{
+	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
+		struct resource *res = &pdev->coh_resource[i];
+
+		if (!(res->flags & IORESOURCE_MEM))
+			continue;
+
+		*out_base = res->start;
+		*out_size = resource_size(res);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+#else
+static int pci_tsm_coherent_range(struct pci_dev *pdev, u64 *out_base,
+				  u64 *out_size)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_CXL_RESET */
+
 /**
  * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
  * @pdev: device owner of MMIO ranges
@@ -1040,7 +1125,7 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 		return NULL;
 
 	for (i = 0; i < mmio_range_count; i++) {
-		u64 range_off;
+		u64 range_base, range_len, range_off;
 		struct range range;
 		const struct pci_tsm_devif_mmio *mmio_data = &devif_report->mmio[i];
 		struct pci_tsm_mmio_entry *entry =
@@ -1050,33 +1135,58 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 		u32 attr = __le32_to_cpu(mmio_data->attributes);
 		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
 				    attr);
+		bool coherent =
+			bar == PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT;
 
-		if (bar >= PCI_STD_NUM_BARS ||
-		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
-		    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
-			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
-			return NULL;
-		}
-
-		if (last_bar > bar) {
-			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
-			return NULL;
-		}
-
-		if (last_bar < bar) {
-			resource_size_t mask = pci_resource_len(pdev, bar) - 1;
-
-			/* Transition to a new bar */
-			last_bar = bar;
+		if (coherent) {
+			if (i != mmio_range_count - 1) {
+				pci_dbg(pdev, "Coherent reporting range is not last\n");
+				return NULL;
+			}
 
 			/*
-			 * Determine the obfuscated base of the BAR. BAR
-			 * offsets are never obfuscated.
+			 * No BAR names the coherent range, so fail closed if
+			 * neither a CXL region nor a committed HDM decoder
+			 * resolves its address.
 			 */
-			reporting_bar_base = tsm_offset & ~mask;
-		} else if (tsm_offset < last_reporting_end) {
-			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
-			return NULL;
+			if (pci_tsm_coherent_range(pdev, &range_base,
+						   &range_len)) {
+				pci_dbg(pdev, "No CXL region or committed HDM decoder for coherent reporting range\n");
+				return NULL;
+			}
+
+			/* Coherent range is last and not part of the BAR sequence. */
+		} else {
+			if (bar >= PCI_STD_NUM_BARS ||
+			    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
+			    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
+				pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
+				return NULL;
+			}
+
+			if (last_bar > bar) {
+				pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
+				return NULL;
+			}
+
+			if (last_bar < bar) {
+				resource_size_t mask = pci_resource_len(pdev, bar) - 1;
+
+				/* Transition to a new bar */
+				last_bar = bar;
+
+				/*
+				 * Determine the obfuscated base of the BAR. BAR
+				 * offsets are never obfuscated.
+				 */
+				reporting_bar_base = tsm_offset & ~mask;
+			} else if (tsm_offset < last_reporting_end) {
+				pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
+				return NULL;
+			}
+
+			range_base = pci_resource_start(pdev, bar);
+			range_len = pci_resource_len(pdev, bar);
 		}
 
 		/* Per spec the tsm_offset never results in overflow / underflow */
@@ -1086,20 +1196,28 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 			return NULL;
 		}
 
-		range_off = tsm_offset - reporting_bar_base;
-		if (pci_resource_len(pdev, bar) < range_off + size) {
-			pci_dbg(pdev, "Reporting range larger than BAR size\n");
+		/*
+		 * Use tsm_offset directly for the coherent range instead of
+		 * masking: an HDM decoder's size - unlike a BAR's - need not be
+		 * a power of two. So masking could wrap an out-of-range
+		 * offset back in-bounds. The bounds check below still catches it.
+		 */
+		range_off = coherent ? tsm_offset :
+					tsm_offset - reporting_bar_base;
+		if (range_len < range_off + size) {
+			pci_dbg(pdev, "Reporting range larger than %s size\n",
+				coherent ? "coherent range" : "BAR");
 			return NULL;
 		}
 
-		range.start = pci_resource_start(pdev, bar) + range_off;
+		range.start = range_base + range_off;
 		range.end = range.start + size - 1;
 
 		/* Only record the TEE ranges for later consideration by ioremap() */
 		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
 			      attr)) {
-			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
-				bar, &range);
+			pci_dbg(pdev, "Skipping non-TEE range, %s %pra\n",
+				coherent ? "coherent range" : "BAR", &range);
 			continue;
 		}
 
@@ -1107,6 +1225,8 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 		entry->res.end = range.end;
 		entry->res.flags = IORESOURCE_MEM;
 		entry->tsm_offset = tsm_offset;
+		if (coherent)
+			entry->flags |= PCI_TSM_MMIO_F_COHERENT;
 		mmio->nr++;
 	}
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index e54ad057fa8e..90bd8d1dd729 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PCI_TSM_H
 #define __PCI_TSM_H
+#include <linux/bits.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/sockptr.h>
@@ -204,10 +205,13 @@ enum pci_tsm_req_scope {
  * @res: MMIO address range (typically Guest Physical Address, GPA)
  * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
  *		Translates report addresses to GPA.
+ * @flags: PCI_TSM_MMIO_F_* attributes for the range
  */
+#define PCI_TSM_MMIO_F_COHERENT BIT(0)
 struct pci_tsm_mmio_entry {
 	struct resource res;
 	u64 tsm_offset;
+	u32 flags;
 };
 
 struct pci_tsm_mmio {
-- 
2.43.0

