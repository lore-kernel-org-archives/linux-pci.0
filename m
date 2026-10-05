Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C319374721;
	Mon,  5 Oct 2026 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183835; cv=fail; b=VgTQFAAokWR/srIweSaIS7nKbkocXZH8ag9kIQjEMI67rfY9g/GHco5WVDqwlkCHTuIdS7Yc2D64seAK30uMK1+ZzmZ9kp1LlCT9wIs5mLUL2BEzU0xENbAafTmxQYtwQmpNUmEFUW6ha/+JIi5rRwth73HhZnvwNjbrF9ZQR5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183835; c=relaxed/simple;
	bh=6YVFgDKjpB32oDKr93MuEb9P2RHrLX1NkvrowuzNQG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t60RRftWE2XOcBGiCBXpGscSC8MbuSNss8sUNciNsejelAVe1qUBPnaK8DL+B4pDQLsXaOEMOxJ2VvgMQ25a+A6msQz+Ejpv9gUo5lBSj854vGYp4ylky+g65DJXpXhtpWktiELbdI+zu4B48IjNAsnxM3YEfys0aMkgUFSkQlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=snD9H5cK; arc=fail smtp.client-ip=40.93.198.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="snD9H5cK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyTRdbgiYAawvsc4hV1u+GYtN8gWyzUjjO1oLxEpFXEpiIVspGpw6Itp2Fw2ciw1HooR07Wd5ugC6pGVxivW+/EV3N9PorfBsUaEmuQO0SR4GebIIZ5bkBr0gV4HkNZ34aiIkz55HyotM6d7aGFKWC4JdTsBv6AEy+aa6H/MOZVTEtMEfhjc6P+YsVsdCclN8HLFMRa9uPof6MjdEXxfOe1D9rN6i2vrhBguQGJgYzToxO7p9rbmhqvwP6HqGwcw7g0JvCUZE/U6M8C1/HGX8AmzOiruBl4kCCSIuiFhWF7Lz7XX7CXEV51oXbdrDaDzODVseK0scUcfpqivCllgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk4jN7DxI0XK2wRetl9w+Hjh1ExSTtRc9AuiVPSwMyk=;
 b=hwuveHl0+3yECPHwejcVmu1WoX/5Ua1sStNawXQzZ9m4+T2IKORdr0PRvGZJID05D6k/qBU9zNKJ6QJ5hdZxxnZNY7zw8XFFzAd8xpeFXouH5uWGyxFV5IHFgxWCWMn+O4PivwfKBEqZLt3BjunUYUgG11TSdO6okhiWHDw8wbxHTBplr3Z4RDi4y3hw9jkq4NvdGgU2r5uuxdHiMk8Y4X39BWczIz854LouXhTak6OOGTb16V/lvFIyAPGLNIW6CPdJQEAPlX3rzL3ur+AP8IbM+bNESiacAGTKwyvvl/4IzP5ge9D4r8Y6g3BlvDY/r+tzZ9wdjlEhuRazKVY9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk4jN7DxI0XK2wRetl9w+Hjh1ExSTtRc9AuiVPSwMyk=;
 b=snD9H5cK/AA9RtfF3wRj6fRnFlIkPKTqYJuHI4wV6IkZ6n4/REtyLqb2R2aZTanTG/y2yTebpjeGo95TCwht9M/ujEjZXPLjCP9W45uZM6f0el2pK+62rS3UTTxSJZNm6Rj7yx8aiEGnJ+NL9/2Xcmzy34ndV5TCf8ScGHDgmd5lpxNdMS4ah0SMswO0ecT+1PDfKBtkmHy4bvkGed9tw0u7VWwp8Oyx2+jLot1/0LbVH0rLfv+13zc2QMbPAPKK19LZt2/hzkghla3/YrKLwBu0fUapX9A1ZzRBBbOcT8Lw5GHoVyxFwSnLKz1qy+1tusB4NTAqjum/Tn3STYyWIQ==
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 07:03:45 +0000
Received: from LV8PEPF0000006B.namprd03.prod.outlook.com
 (2603:10b6:408:13a:cafe::3b) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 07:03:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF0000006B.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 07:03:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:03:27 -0700
Received: from NV-9TMPJL3.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:03:22 -0700
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
Subject: [RFC PATCH 4/4] PCI/TSM: Support multiple coherent ranges via coh_idx
Date: Mon, 5 Oct 2026 09:02:52 +0200
Message-ID: <20261005070252.84810-5-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006B:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fb85aa-7a46-45f4-a801-08df22aecc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	U6m3qa83G86e3jgKbKZ4xTnmRBvbiYnY1WCXliSebPb6MfHq8KkX88REx20LrFwMhotRsp4p4VwLRoz39gfgemYSbi+QarbZxaMzJ1zsnJ2a9MkM+u8xxQg7aJscK6o1QSeYgLsOVAsoqe55lx3C8y26/+ybEUivRMByzcliI+BeDG08o6eMq1YB6yD7MHKpYOgY5QYDxKTnFcwxB2AeKPvc/CHksGzegtHmjGQALhRwsF2jIhoGRcB9x3uMesymgpE4YZvwv9utIg9lCpwvMeV0wynOmVZ3VeIrY/GfOINcy6MfhbaPVM+Hez6xW+uWOh8ID59mNvxbPNHpKaFSIJepsP4HwejxX+bwgfT7R81gC7DD5zl88uTDpjmhQUJ/Jo7+D7AA1+IjBLjFNLw8sLjdA3IJiy0msbtKeYmEYy8oTd1DLm6k6cxGR1l8AtdnjXuuneOFG/sT4eh6GwZ39hMhLT6SEUfA9RlpRLSjbxoL99UrJpCl+KgK9JABVSFwXyyNaXZkoxIU3C11YLAnRWHzSyhmE2OJWEgBPpGnczNmFRbVDWppD6llYtAB1AJqpBhhSqMq0pjowWarWKoGhknM7z97jPbBln7PMeNFAZpfMGf74YQu3Iq8zYgc+5itinX/4IjCQvQgCQZNY2y2EA1F73GvAIDNaA1u/Y9MUxF/jCG0JlrP21uYx6MDSI0iB5j9zi4Z5IYPftg+CqJQOw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KiOit5pW3ywKAsIpXbXa/LR8oDfUyBrpGYZKJ7ACw2LDSDsdvVqFw6xK3wlJBOFdOUmGL2vVK8afFxNNVbVAXf3nhQmK6WDlXnSAwW7B6gE5qwbcgem+Qm640TFAz4XqoPautcynBmFEV/yIq/Z+ibiD6MvMiYIx/XbAYvzrOrxcmgyrm3FIu/JIaoTKM5ItT/t93dOR2SeT3CtsHrIdjCfZzwXJoWnrwqllcftyg7j6LsDmYXeiLT4js3bIMjY9MxT1DADkj91wcnWX3r9Abz3q/B3+7cMbZhFp1cnP/0FUrUvMzvUzHfcjojeswazFRFzoWmIk3mZYI+Ff7AZff0Lwe6qfjTs4Cagh1hGCAtGleWMIoJrirNRazMedDC9ajJ0deHKsPlBxdYOo03D+xi9T+3ZtCCIMpcA+9bzSmzBKfarsF+6fuNzlbH+7VXkT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:03:45.3606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fb85aa-7a46-45f4-a801-08df22aecc33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

Devices with multiple decoders can report more than one coherent
window in a single interface report. Generalize the single
0xffff sentinel into a small id space:
PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_TO_COH_IDX() treats any range id in
the top PCI_CXL_MAX_COHERENT_RANGES values (counting down from ~0) as
a coherent range index coh_idx. This keeps id 0xffff (~0) backward
compatible with the single-range case (coh_idx 0) while allowing ~1,
~2, and so on for additional windows.

Only id 0xffff (~0) is spec-defined: Arm RME System Architecture
(DEN0129) section B2.3.5.2 reserves range ID 0xFFFF for a device's
region range. ~1, ~2, and so on are this tree's own extension of that
idea, invented to cover multi-range reporting.

Use coh_idx through pci_tsm_coherent_range() to select the coh_idx
entry of pdev->coh_resource[], the precommitted-decoder snapshot and
relax pci_tsm_mmio_alloc() to accept more than one coherent region.
The coherent-range entries follow all BAR entries in the report
and allow multiple trailing coherent ranges.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Assisted-by: Claude:sonnet-5
---
 drivers/pci/tsm.c | 78 ++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 1d736b606a7c..b4f18a7c7187 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -1031,7 +1031,14 @@ EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
-#define PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT 0xffff
+
+/*
+ * Only id ~0 (0xffff) is spec-defined (Arm RME DEN0129 section B2.3.5.2);
+ * ~1, ~2, etc. extend it for multi-range reporting: id ~N selects coherent
+ * window N, keeping coherent ids disjoint from BAR ids
+ * (0..PCI_STD_NUM_BARS-1) without a separate flag.
+ */
+#define PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_TO_COH_IDX(id) ((u16)~(id))
 
 /* An interface report 'pfn' is 4K in size */
 struct pci_tsm_devif_mmio {
@@ -1052,37 +1059,39 @@ struct pci_tsm_devif_report {
 
 #ifdef CONFIG_CXL_RESET
 /*
- * pci_tsm_coherent_range() - resolve the device's coherent CXL window
+ * pci_tsm_coherent_range() - resolve the device coherent CXL window
  * @pdev: device owner of the reported ranges
+ * @coh_idx: which coherent range to resolve, per
+ *	     %PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_TO_COH_IDX()
  * @out_base: host physical (guest IPA) base of the coherent window
  * @out_size: size of the coherent window
  *
- * The coherent range carries no BAR number, so its address comes from
- * pdev->coh_resource[], a pre-driver-bind snapshot of committed CXL HDM
- * decoders.
+ * Each @coh_idx names one of the device coherent (CXL) windows. It carries
+ * no BAR number and so its address comes from pdev->coh_resource[@coh_idx],
+ * which is a snapshot of committed CXL HDM decoders regions.
  *
- * Return: 0 with *@out_base / *@out_size set from the first populated entry,
- * or -ENODEV if no entry is populated.
+ * Return: 0 with *@out_base / *@out_size set, or -ENODEV if @coh_idx is out
+ * of range or has no populated coh_resource[] entry.
  */
-static int pci_tsm_coherent_range(struct pci_dev *pdev, u64 *out_base,
-				  u64 *out_size)
+static int pci_tsm_coherent_range(struct pci_dev *pdev, unsigned int coh_idx,
+				  u64 *out_base, u64 *out_size)
 {
-	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
-		struct resource *res = &pdev->coh_resource[i];
+	struct resource *res;
 
-		if (!(res->flags & IORESOURCE_MEM))
-			continue;
+	if (coh_idx >= PCI_CXL_MAX_COHERENT_RANGES)
+		return -ENODEV;
 
-		*out_base = res->start;
-		*out_size = resource_size(res);
-		return 0;
-	}
+	res = &pdev->coh_resource[coh_idx];
+	if (!(res->flags & IORESOURCE_MEM))
+		return -ENODEV;
 
-	return -ENODEV;
+	*out_base = res->start;
+	*out_size = resource_size(res);
+	return 0;
 }
 #else
-static int pci_tsm_coherent_range(struct pci_dev *pdev, u64 *out_base,
-				  u64 *out_size)
+static int pci_tsm_coherent_range(struct pci_dev *pdev, unsigned int coh_idx,
+				  u64 *out_base, u64 *out_size)
 {
 	return -ENODEV;
 }
@@ -1107,6 +1116,7 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 	u64 reporting_bar_base, last_reporting_end;
 	u32 mmio_range_count;
 	int last_bar = -1;
+	bool seen_coherent = false;
 	int i;
 
 	if (report_len < sizeof(*devif_report))
@@ -1135,28 +1145,32 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 		u32 attr = __le32_to_cpu(mmio_data->attributes);
 		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
 				    attr);
-		bool coherent =
-			bar == PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT;
+		unsigned int coh_idx =
+			PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_TO_COH_IDX(bar);
+		bool coherent = coh_idx < PCI_CXL_MAX_COHERENT_RANGES;
 
 		if (coherent) {
-			if (i != mmio_range_count - 1) {
-				pci_dbg(pdev, "Coherent reporting range is not last\n");
-				return NULL;
-			}
+			seen_coherent = true;
 
 			/*
-			 * No BAR names the coherent range, so fail closed if
-			 * neither a CXL region nor a committed HDM decoder
-			 * resolves its address.
+			 * Fail closed if pdev->coh_resource[coh_idx] isn't
+			 * populated: nothing else in the report identifies
+			 * the window's address.
 			 */
-			if (pci_tsm_coherent_range(pdev, &range_base,
+			if (pci_tsm_coherent_range(pdev, coh_idx, &range_base,
 						   &range_len)) {
-				pci_dbg(pdev, "No CXL region or committed HDM decoder for coherent reporting range\n");
+				pci_dbg(pdev, "No populated coh_resource[] entry for coherent range %u\n",
+					coh_idx);
 				return NULL;
 			}
 
-			/* Coherent range is last and not part of the BAR sequence. */
+			/* Coherent ranges are not part of the BAR sequence. */
 		} else {
+			if (seen_coherent) {
+				pci_dbg(pdev, "BAR reporting range follows a coherent range\n");
+				return NULL;
+			}
+
 			if (bar >= PCI_STD_NUM_BARS ||
 			    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
 			    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
-- 
2.43.0

