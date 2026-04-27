Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB7364EB2;
	Mon, 27 Apr 2026 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269281; cv=fail; b=CSgJ4ZzSSJHt9Ecdx23may2RTwlEXYzvVCOr/nQWPvuYH4eobui+I7d/szCcqjqAkOSsxAw41/EzwZqjMqfFcIidLKnL4v8qvcauVZVV/Okh6lz5gz5GcgFk5Rym1JEoQK+SUR7ZbjHL/2Jpc6teaikF5JtrvRuEYC4AOAJQSgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269281; c=relaxed/simple;
	bh=Urq6C4bx+fDV/LmZnTkTx8qf25UmD7LtnwKUvHj/JqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7JTLaB/SNOlclfEqHvG9zfdewI5iEHRYvR/alWfj8WRvW0AxJw8cg1J1moIy7OT0p4n6LSaM1zd3kRmLaTdsRtXjYjnnI0h5J2NutrMdNl+vHtTVVBSM+FpBBpQMs6RBmCzmI7GDNRMV12AVaBqqiQidUvvrZitOPzbbDexxxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BM7C+AsH; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BM7C+AsH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8Z47xkFQdzTSEgi23g10+LR4r5/Yi0iTtD2FiMnVL4UziD6T+wxvJhQSbjznDSliKQr9+5S6L3USZCq7ZUZTIKN6ArodXHXGpV9u8eicN8yGJGJ6/mHRT7owmWoY4ujGJkReFlmPJFosuBrxmSo499Zw8aMu59Adq9IZfv0nI0NggPwTEbjJEyC6tNWsb/ekWhJR8gdy8xKdK74EVjmDnwvMz/OgQenDhGYAC8jWSwJ7EQSAbHc1TQQ8hQEPYpHO6YlU1Lg6wGaVqkolVKplb06SegPbavoA+0d225nplAtzAOJvPIvVKM+vH4TLGeM5oPs9FKYhmqLXgHl1LU8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptP2ynvfS4yxKyrk1Rt4Dzmdf0lgMlFQJRpl5uEPGnc=;
 b=ycn88QG1kNbvszaY8QByJV/GsATKqOB3vwR3amZpRxcpYlkNZ9X6PGq/Ol4ku/0gswiGw+p0fasKEomFkT8YLKN8pCCjBavttakQI0stTXAtguKLcCX3pWRVI2VP8eGfsUwsz7a7wMWs55o/FndqWq58KgB1wSI78BpaUAvpSWhGgzOHEKsj4WGtiI19AqWHnHVzjaTeJ1ursT0LJf21gEhm8sgAABiLt4idDzrFQrBVs2hx5Bpq4C+KAOBB8DYoniOQItR+unF2DQIl8puQgBX7vwN5bBzev9naxnJTbXe9Wr1ZWpxWIHcEf6nxOYdid48IgUOmUObbyPCN8/MLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptP2ynvfS4yxKyrk1Rt4Dzmdf0lgMlFQJRpl5uEPGnc=;
 b=BM7C+AsHFsRVWDBxPgE6ST8CJS6lmt117Kv9mznvusD8VYqGoYDyZP3UvhwJuK2Sg3bTCDija2Dunca8RCcZ56ZaGBaKDJrvGlF0Xd+Te5mDi7fIbG1TcvUqWDSgTwDS7Br6I4PXmmyeZSgOnDDidbi6Hg3FRUxvUKadcKvSWoucCpgwQ5jdFdMbtlXkSfZU1ymkI682gLjQXWJxcL+IGEbwNHFX+AszUgU6182VB2jZQOsmXbORHMNnBu41HLd8UV9s5/uRvnFlwD1vWqfMRAbw4PbNunf9IZnV4F6WLfdB4tQQFYojPaxEzz53P0j0CGsToBvZX6C34ZwnA/hIHA==
Received: from BN9P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::28)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 05:54:35 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::45) by BN9P220CA0023.outlook.office365.com
 (2603:10b6:408:13e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:54:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 22:54:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Apr 2026 22:54:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Apr 2026 22:54:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v4 2/3] PCI: Allow ATS to be always on for pre-CXL devices
Date: Sun, 26 Apr 2026 22:54:01 -0700
Message-ID: <1a8cf5e88051ab5c10417edb94df598ecbc810cf.1777269009.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777269009.git.nicolinc@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: b27e9ad7-7561-4714-7327-08dea42174e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DG8gDeSwyS/7zOpaeCYcKImjgGz3SjjUtmc5GG+f9QeefwZp0ab/+LbtUFuiEfmYVsOVU/JDPxm1FDSYejiCoe5kvonf9ZFiO8jU9MDPpZCNtVDFX30c3BXTVJK+jl5ePycnhFLNlnpBeKyoNUTfCPk3+QAnXJBD+csrrF9xOW+0O89JAYwi05eCIoOf+tpLTewa4fzJELk3kJJFa9SUTEbR179wKWVZKMLae37LDha6uEZiQLXCM9Ftp5wZNikmImp9DjLlCV0c/7fLQjv6GqAUW70/hkeHJRl8iHUl98PqhNE9ZzWxDvB2Easj09dyQAOqtbz5xk8yjwQGCYqizjRdTlkHcvazvAVNlzLZ3UMTBmAWBtWMbnwmkOWJseI3M7sOlwke3rQQMpHUFf9j5/GDIQzy3SvLM4u8tJX4MbnWZkcRgsshfDqBNl3mlTgOna138S/nXOz6UP9vbJ1KsR17GfRdH1cKjLb2gIjRKrL4IFR9mlYF+xVNm4ioksEXheTgJHxig5qiePZVFlfD9OXSwTD8IhgTeMv7uhLeD+OJ6JtipgVHEmN/dhqmjuH4kmgVcsnhVfusQn2LqFUf0P9vbuN4WQgjY5ckjaVaJKnGVrhBWjXz/zm0JGoP7jjOpaG38jYeuOsyEM4IFU33xNiKHVAZBO7+tWvQfuNjNTMrigXDSw5o3akVHXDUWM8KOadZf0qm5ndmE4XPs1l6SpSdunsSXbT2pwt2BnNJY2VCvJB1QRdM7VsvYEAZEKv883avt+/XO6qU4n08xo8T7A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nDZJ3/ngw7brZAKdWNVrMJS4v5Uin33Yx2tTpBt0QVOpNMOpaq3Hdm23v6B9fG7/FCaI3apuFNMoCGxZ76eG6utskQRWktumhRXczeFozkKdPkePhWc/B2E73pCkB5yYgzrrl5gyexAp8iK+pk9bwr4WFD0/zrv5kyVXUDxbKqWhhBisWrjb9stxC4RuXOzdLd+D5Lx2fiN4jfbQZCAuwVoJmho5AolC1sdSzCWSQrO4SBp+1Z0cFR1dcCRcqs+Ms/c86xWEUR45i1VN/u03LLnjWpR2N5l4JDkyWub1t2V2mzxgYZAziegzVXidKOfXG/Hs5j8HcgB5W9ZEltlGc0854QJ3eLgLKgBS15i1SlEg7RvHXPqt2+avDuRyNDR6rdVR8AxyMBVdgWrqXPs1bGGCex95j9JiK8pTSBRCHcWgqhcu5fpxcQpitz/NB4oo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:54:33.2959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27e9ad7-7561-4714-7327-08dea42174e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082

Some NVIDIA GPU/NIC devices, though they don't implement CXL config space,
have many CXL-like properties. Call this kind "pre-CXL".

Similar to CXL.cache capability, these pre-CXL devices also require the ATS
function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.

Introduce pci_dev_specific_ats_always_on() quirk function to scan a list of
IDs for these devices. Then, include it in pci_ats_always_on().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nirmoy Das <nirmoyd@nvidia.com>
Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.h    |  9 +++++++++
 drivers/pci/ats.c    |  3 ++-
 drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a2..4e0077478cd7a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1155,6 +1155,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 }
 #endif
 
+#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_PCI_ATS)
+bool pci_dev_specific_ats_always_on(struct pci_dev *dev);
+#else
+static inline bool pci_dev_specific_ats_always_on(struct pci_dev *dev)
+{
+	return false;
+}
+#endif
+
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index fc871858b65bc..3846447ea322f 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -244,7 +244,8 @@ bool pci_ats_always_on(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
-	return pci_cxl_ats_always_on(pdev);
+	return pci_cxl_ats_always_on(pdev) ||
+	       pci_dev_specific_ats_always_on(pdev);
 }
 EXPORT_SYMBOL_GPL(pci_ats_always_on);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc02..887babba97cc7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5715,6 +5715,44 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
+
+static bool quirk_nvidia_gpu_ats_always_on(struct pci_dev *pdev)
+{
+	switch (pdev->device) {
+	case 0x2e00 ... 0x2e3f: /* GB20B */
+		return true;
+	}
+	return false;
+}
+
+static const struct pci_dev_ats_always_on {
+	u16 vendor;
+	u16 device;
+	bool (*ats_always_on)(struct pci_dev *dev);
+} pci_dev_ats_always_on[] = {
+	/* NVIDIA GPUs */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, quirk_nvidia_gpu_ats_always_on },
+	/* NVIDIA CX10 Family NVlink-C2C */
+	{ PCI_VENDOR_ID_MELLANOX, 0x2101, NULL },
+	{ 0 }
+};
+
+/* Some pre-CXL devices require ATS when it is IOMMU-bypassed */
+bool pci_dev_specific_ats_always_on(struct pci_dev *pdev)
+{
+	const struct pci_dev_ats_always_on *i;
+
+	for (i = pci_dev_ats_always_on; i->vendor; i++) {
+		if (i->vendor != pdev->vendor)
+			continue;
+		if (i->ats_always_on && i->ats_always_on(pdev))
+			return true;
+		if (!i->ats_always_on && i->device == pdev->device)
+			return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.43.0

