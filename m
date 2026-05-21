Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9C3F54CB;
	Thu, 21 May 2026 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395696; cv=fail; b=ZnNHhdrHX0oTzBewu5/ZViBjczk9jyS2edhAH53Nnh2nRuwKNx3zxbzJ32J6zclyMrvdgtQCnKyYAjooeJ20tYUcs2v/TrnH2DzeL0zBBORt0oG5k+HTXxfkQmwvYqSdXXu+8OMu1QpaztxhyrQtDOAZLPlVtPyMy8/wATwfUxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395696; c=relaxed/simple;
	bh=gaAsxiJ564c5Hp53Ica0POGqbtpJBt5/zSrE8ni5r7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9o9R9QyMrvyhuE07I27aiYPouGcMSihLTzHCSR5gLNaLnWUXfkFmoycBiXT3JJZ+F7A60RF0V7YJW1F38MCC/pnxqLZp0iBwD3sAL2adnVWpuT3uHuTTLSpDCy5gwCrmEzP0vOqpbRZ3/fg553MXO4j6CI7EImnoa6vhwdKHJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9ENSrRG; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9ENSrRG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAERD0qRxbNjj5+hz7UU0+AO+8c9bHEiQbIGBaYqKCuYxDHL63jRtEFkCjpwXbmxaBvE72Ckf8XOzQIuXQSWzCGs2EBBlSLwTULLJUzfGjhBfCwwmh2OjW6AiAX7dwi9LRXXKS3vtirHl4/mIu8YBAp8OuOwn2vmCGCILQGAQiHKXHyk0Eon3euxN973pGDDv4LGG4Z2wohpYfj1qYmfHN33mDTzVhUXFOwM6cUzcEh7Chz1a6Tj39Sidwnv2CkYgqmPASiCnTH5HZMOdC4iv+gmlA98x8/+Khz7QsLzQpldGZsoa7TgSyocnPClNaCyGBxricQQDAHMrsc2bt8duA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgf0aEtRtFeV2l/YODfzgk7aHRNpedUPkIfnvVDlEmg=;
 b=keku6MyFyTVqszY5lwXmomjwIFjtIwwTmdtQxMNGZq/n4YVod50QubbE/lHgJTiRUQWlkB9lVhnvt7EWJybgRr99z+dFKwcQFcB+0wwJSccxj8MgX/dfEw4AC85+Er2TDrUHpq3jCKV/XA5NkD8lzAyaBbFqmBTi9LG/JZMjEzwECwmK92QUs4A9DWGpEkp46I4FDj2QXphqTq2f0OojHKCo9Xt0GQgWFRC6xPSZ6MC6y1rogpFR3gBQlau5ks3nXeAL6lMpP4k2xoo6aYAVe+sAiyYy8xVd55YKr6a2SRBpxFwpKugehaBA8JhihEYqn1yLCwbzU4OTJhHxMbwp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgf0aEtRtFeV2l/YODfzgk7aHRNpedUPkIfnvVDlEmg=;
 b=i9ENSrRGR8U/JPNVZWwPxJaPHE52A42gzAybMmZK+1EpAdbBqa40y9z4feQFMtT5f7h7DMvP6QPhTVM8UYfYkU5bhGEd0bruEHCBGe4kpOZPY5KYD4b4vV6YeriKqW/cFAxcvMq9ev37Kh4BfVERPOu93w/53aN4DmwkRVvBUKnX/C4sNdeQlnrOXC/BTAzCIu3rW/Bacb443CZDA7MP0LYx+6QgyuuaHSCHSyp7U6NiQZfKFzrDrflhcZtXHrShO+giNxxw+VWu6iSamUDc1s7pIy3Ytbipi5RywsECNF+72NstXUOBmjaVNFgewIW542NVRxB9YVRCW4pFJytyYQ==
Received: from BYAPR21CA0014.namprd21.prod.outlook.com (2603:10b6:a03:114::24)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 20:34:49 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::14) by BYAPR21CA0014.outlook.office365.com
 (2603:10b6:a03:114::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via Frontend Transport; Thu, 21
 May 2026 20:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 20:34:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 13:34:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 13:34:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 13:34:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v6 2/3] PCI: Allow ATS to be always on for pre-CXL devices
Date: Thu, 21 May 2026 13:34:21 -0700
Message-ID: <0dd7e22f44bf35a33a590e0916983f9f7fe00de3.1779392420.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779392420.git.nicolinc@nvidia.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: a68e3630-d7d5-4437-19ab-08deb7786772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zyJTvBSxcszM9kdqX6q3Yc9YPhVinx15X+SpJyK4UNHL3FlspnwhFe7bYyNtkPPPzQWMoZXQI2H7e1Kbszj0f2aPInjhgnh+tFn37Ugt88e/hjqKHlcmDWuusXtMPjUj86FrjLQLZU5KclVuuRb8nXAmS2SZlHLdagogQuXRD606OyER0ACPIWgwAbjO2lcGvvDZUELcltuvlOmRNlaX9zzwML3bRUvgRj/oRaIsfopz7S8USEujV+yWsjB7s3Q1ejH/cI1hMS9aWuLXAepcDFLcFW+PXrR4YVKxUTIv+vgVuAbtxW3lNiglKtzHrw6bScZXklQIT7kl1rrdCKTSkXVB/9eEwOCHWvBgDW6XQDimrFU9r1hrcj0Qeum0ANS2LNXY0ocyep2v08p2xvVtJJhVPGHusJuMNUiAHHTP5jj3tBObtcvgOqQo/0TEz2SHPvapprTOJx18hIXKAHQn9tlhfGuccfcivxxIyPABGHZzu4kh/Z+Z1S5M7OGlx4IaRnp8O62MsIWjMc9dErl6NdDnj63ulxpTFVE52hINU0H7wP5KlHlcUpdjEPTv7/yOZeUyPVbC+HAMO9HJD7oMu3vA3yFW0KKcwhk+fVnI+SHP7PzyliKFtWYRxCWxupYXoJwablQk6rHBlS1H7fC+cpQxDD15ZvhcCofidHR3ETmqraag0cbs8gcTzSHgSJ/0x6hU3biZal7UaEDgcPosK41V0xOr8ClhetvvxCBr6j0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9dvzMmrApIXuVpijaCnYVE4zQNEwkiYhzn0Cuuq6hF6Qw3S77g9nTeq9Ro4f4W9CaFa1uWeSTX0fvd9uvTZ5HAeVjdZknOjw1YJ5Y5oaPCis8ebP8Dsd/V0iDyBRkCv+v7841ae1AV98CxF45DTzXOAlhq7dAHj1LldP4ObSqucW0sBJfRpgCVV9praDkSkPm8d8e8+s69uuANDQdDLNTvRz1nObrq8+gr9rvTXYlx8g4Kyok3ZnFjm55b3a61XRzbGoO08TMpFCnKPaJ+2PqyLWPfqjVn6fs6vZVJP1j3awVTRRLhBkDTj6C2NpBWQ092Iba3uAhIlpwxYxPb7tFo5V0461O2gIL1czTAVIPMc7RqtUkX4xLRgHiwxMdJumhlS9lRrsTUmmklKxuN3nMOKFMAlnALrKKkhnV90vW3NLkD3P09KexB3fUPBFpg0x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:34:49.1629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a68e3630-d7d5-4437-19ab-08deb7786772
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428

Some NVIDIA GPU/NIC devices, though they don't implement CXL config space,
have many CXL-like properties. Call this kind "pre-CXL".

Similar to CXL.cache capability, these pre-CXL devices also require the ATS
function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.

Introduce pci_dev_specific_ats_required() quirk function to scan a list of
IDs for these devices. Then, include it in pci_ats_required().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nirmoy Das <nirmoyd@nvidia.com>
Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.h    |  9 +++++++++
 drivers/pci/ats.c    |  3 ++-
 drivers/pci/quirks.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a2..e8ad27abb1cfe 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1155,6 +1155,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 }
 #endif
 
+#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_PCI_ATS)
+bool pci_dev_specific_ats_required(struct pci_dev *dev);
+#else
+static inline bool pci_dev_specific_ats_required(struct pci_dev *dev)
+{
+	return false;
+}
+#endif
+
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 84cd06d74fc9c..96efa00d97433 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -247,7 +247,8 @@ bool pci_ats_required(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
-	return pci_cxl_ats_required(pdev);
+	return pci_cxl_ats_required(pdev) ||
+	       pci_dev_specific_ats_required(pdev);
 }
 EXPORT_SYMBOL_GPL(pci_ats_required);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc02..c0242f3e9f063 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5715,6 +5715,48 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
+
+static bool quirk_nvidia_gpu_ats_required(struct pci_dev *pdev)
+{
+	switch (pdev->device) {
+	case 0x2e00 ... 0x2e3f: /* GB20B */
+		return true;
+	}
+	return false;
+}
+
+static const struct pci_dev_ats_required {
+	u16 vendor;
+	u16 device;
+	bool (*ats_required)(struct pci_dev *dev);
+} pci_dev_ats_required[] = {
+	/* NVIDIA GPUs */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, quirk_nvidia_gpu_ats_required },
+	/* NVIDIA CX10 Family NVlink-C2C */
+	{ PCI_VENDOR_ID_MELLANOX, 0x2101, NULL },
+	{ 0 }
+};
+
+/*
+ * Some NVIDIA devices do not implement CXL config space, but present as PCIe
+ * devices that can issue CXL-like cache operations like CXL.cache. Thus, they
+ * require ATS to obtain host physical addresses, like pci_cxl_ats_required().
+ */
+bool pci_dev_specific_ats_required(struct pci_dev *pdev)
+{
+	const struct pci_dev_ats_required *i;
+
+	for (i = pci_dev_ats_required; i->vendor; i++) {
+		if (i->vendor != pdev->vendor)
+			continue;
+		if (i->ats_required && i->ats_required(pdev))
+			return true;
+		if (!i->ats_required && i->device == pdev->device)
+			return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.43.0

