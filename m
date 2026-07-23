Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0C38A29A
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787408; cv=fail; b=jEGr8xfq///tbjqrUHrKo+chMIzxC5wVtZg2GRG/TkQmz27cs8dWS4R9obmVSMDxxJ7VyiPr0wmfF0o7FC/s1z4QE1327zIPt8T8kt9D9i8gDi1MLzFrqnpAuYkghkNAD/tsor+LE5XtCeW2ckHLIrSl17oLLBWb9E7VKCCl0qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787408; c=relaxed/simple;
	bh=0ZpYzBsVZbR8vf7yK0oDvbwVQJ4ajYq6Dqhe24scB38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qmul6w67O3MqE3lyPf9RebGJRF42Jag6RM/BX5TaZ+aQwk8elv+hucPo+0V3XkAVofPhmGH1Dqb26jxrZfWxpCSm0MVJnNTDDncxQbh6yAUBzz2F5QcXFRKLXM023PP0MOizs6UZ1j3yF2/SXfGIQ/Dh7cquMXtWxYzkcoHV/Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RdR7Yym0; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RdR7Yym0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE/yxJtgm3IpBK5LPoANpN9fNtGJ+Adao2NDX4YN7zTTr7YN2iJb5e3vGl5hLg6Jv2RjH66qCUu5InlFfvx48cpMoP6/SA/AZVNZO5qlzMc6u+D0axvIJb6zYcMFPeV+w1/vyjyaW66CZaYp5Yav0yx5LNCijafzzzSClI4tsi7LATqU8QHaHOHc3OTHghpnOeyxJll9zwWQ/jBgEpPFYw6wgPk6J2Agvt7qTLzSHNTaeaaq0SBnw4fyl69N3bxM1rqy8LAceZecXaGvSGucGbBgi9ACbc9ym1U9hvF10nDe9UKyJmtxH8PmW6m8zywStN4am5rjtYzn8xU+YJt6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy7FI4wW8MCJCntFGLpvpojzS0+j2n7yPGWymeQcndo=;
 b=uRB+o9cQNqC01sUbotMTxwbIC7WdfpMDjth9AhuOWs3Pbnqq0fun2uRGE1P/hnRqx9jOLnOCpNWYrqwWEP4eypdy16LIyTFpnDlpHgf9nIimJnRixZCfF9Xb+MqA6RUZ0btqotlf5Kqt6br+k8mmigyqNUEqfNTrstF+w9bB9LuWSuq0oyKc9SjJNnPQ1AUqepbeYy2QsZBs41ctVnYhkeFri0wFIQRLATgaI+hyDLKaFd0eD03bOVj8a1RoUIM47kd2wCLKeNGLNRxTIQjdvvVR4iisDINx0k3OGGF7PflJNbPX9DMtvcBiTX+PB5jJtdpILXuOG0hdVjq3CavmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy7FI4wW8MCJCntFGLpvpojzS0+j2n7yPGWymeQcndo=;
 b=RdR7Yym0I3jjLAHq7DdGMuToKz1AQj6BbdtVX5D1+WYIYrGV8zX4nNMGEm+T30fuunC5dedn8vPBtC4Rz7lypLlGRpK/Y2qmlP9ER68QZM0BB6cvp07FteFzjRJqEwzRCqrDnNCwaDfFtBTXu41zsRQt+cNXkH/bxvS1J0OxDpY=
Received: from BN9PR03CA0314.namprd03.prod.outlook.com (2603:10b6:408:112::19)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 06:16:41 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::85) by BN9PR03CA0314.outlook.office365.com
 (2603:10b6:408:112::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 06:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 06:16:41 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 01:16:37 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <linux-pci@vger.kernel.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <bhelgaas@google.com>,
	<alexander.deucher@amd.com>, <mario.limonciello@amd.com>, <jgg@ziepe.ca>,
	Vasant Hegde <vasant.hegde@amd.com>, Amandeep Kaur Longia
	<AmandeepKaur.Longia@amd.com>
Subject: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Date: Thu, 23 Jul 2026 06:15:48 +0000
Message-ID: <20260723061548.10187-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723061548.10187-1-vasant.hegde@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a39d995-83f8-4401-f3c1-08dee881f639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|5023799004|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FBE/ecvVymbnMlCuKPtDeLjAvdLN/cFkbBZ3c4eKwEiLH/OwTpYn500U18cMSFueRBMlAIo++VE5yt4YDyHAUvDhG9SA9nzYBD54icqUWpFiqfLot0N7c/JOJ0fqJSGV6JTlQU+iIn7UohOXgFczCo0QMoWKYCmpXqoxhJPYWT8wo7+jdMPCJ8iCmuUMHRNaSV9KLfH4Msh8jZ/i1OuC2WQTmu+vr/zz4T3Fo93fd25niG4d7LxfkVucvvexKrUwaKJl7Gm21t2Gwb+znLR6Ebi9cU913oE4BHNPL/pec2yYKathSv4181eiTrUhu35ymwZ6OHrt+KSLoaZrHKljfpy1CBCFabovZRcAXUu+uFVWcPpU7e5vAly7jNZcpjl5aimoWqMQnpUdJuHNNP6J+W0eghe0wGvL6Khecm1zczsSDlaN2IVQCxY4oyrTSyE2QDbFmPpBbnCLXU31Ngs/xVo6iY8P3oIzoRgEYBkj/x9g5CIkhz4opieyPhYG1In9m49fnGcitW7GYb9/ifCsfnlR4oyG1+mXd1PVB330djfbD4BEKVlxueNThgZhJ0IgXVsPilk2FUCmcX6cIdCQv+0rW/7ieJnd2ewgxZ4+j12mcwwhSJIbqO3DV2lnxPtd0+v2m6lPlXW3K0WUEq6n8k9Uoyj0jf1v/E9U49MhtCwOWQYMDPd7wa91MHkIX/wuFu5ur7CkeQIDRPqoQB8wNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QdPD2/7XXeEZEcCGAqSYf0u5iJ/ZxInsQlqgtqfCeLNV6L8BYo153rhxaEIz8Hp6NW1gnpQOaCgXUJKIbPHuRWWIVwjd+2TmJyOawh4SfovLjkMcGeMgaQV5CjLoMVS7zB49TLqY53QPzIGgcGR0MgP8L7i8U4G7EVb8AsnXnJBUsd4batIVTtG8NNrdXgLOsGLgLj12TyRJq6kCC/r/zGc/IbQQCHvhv6sCUcttD52URbV59/mF3Rf6Cdqs4fS2Fi3XBBTi76BBHgBfmlgZyTEdE/UUzGjqNvowV3AcKLuZoKaQ7rrmJgiZYsCXNsNolKooBnuG7s4PJwlu8FtSoQkyuEJD9Ar5QTy/E0wU4ucJyZv2Y9f5a0kzEoLVi+Dz9x/7LlZx0ytxxiQghT+kMhorW2v2nxYYJq+cuwNSL3etFUh0Kmoe3tsQx6g1QN3T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:16:41.2180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a39d995-83f8-4401-f3c1-08dee881f639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412

Certain AMD GPU's must always be in identity mode. Currently its enforced
using PASID check. It worked fine as most GPU's has PASID feature. But
this means, identity mode enforcement is done for all PASID capable devices.

Previously it made sense as domain allocation API
(iommu_ops->domain_alloc()) was just passing domain type. So it couldn't
check device capability and decide best suited page table type (v1 or
v2). With recent enhancement to driver code, it uses
domain_alloc_paging_flags() ops for all paging mode domain allocation.
This can check device/flags and allocate best suited page table (v1 or v2).
Hence fix amd_iommu_def_domain_type() to force identity mapping for selected
GPUs only.

With this change system booted with DMA translation mode will select:
 * Guest (v2) page table for PASID capable device
 * Host (v1) page table for non-PASID capable device

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
---
 drivers/iommu/amd/iommu.c | 56 +++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 563f9c2672d5..fe642e33c87d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3112,6 +3112,32 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
 	return dev_data->defer_attach;
 }
 
+static bool quirks_force_identity_mapping(struct pci_dev *pdev)
+{
+	struct pci_dev *root_port;
+	int class = pdev->class >> 8;
+
+	/* AMD GPU vendor ID */
+	if (pdev->vendor != PCI_VENDOR_ID_ATI)
+		return false;
+
+	/* GPU class */
+	if (class != PCI_CLASS_DISPLAY_VGA &&
+	    class != PCI_CLASS_DISPLAY_OTHER)
+		return false;
+
+	root_port = pcie_find_root_port(pdev);
+	if (!root_port)
+		return false;
+
+	/* If bridge vendor is not ATI then its APU and force IDENTITY mode */
+	if (root_port->vendor != PCI_VENDOR_ID_ATI)
+		return true;
+
+	/* Rest all are dGPUs and works fine with DMA mode */
+	return false;
+}
+
 static int amd_iommu_def_domain_type(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
@@ -3120,20 +3146,28 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	if (!dev_data)
 		return 0;
 
+	if (!dev_is_pci(dev))
+		return 0;
+
 	/* Always use DMA domain for untrusted device */
-	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+	if (to_pci_dev(dev)->untrusted)
 		return IOMMU_DOMAIN_DMA;
 
-	/*
-	 * Do not identity map IOMMUv2 capable devices when:
-	 *  - memory encryption is active, because some of those devices
-	 *    (AMD GPUs) don't have the encryption bit in their DMA-mask
-	 *    and require remapping.
-	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
-	 */
-	if (pdev_pasid_supported(dev_data) &&
-	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
-	    !amd_iommu_snp_en) {
+	/* Apply device specific quirks */
+	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
+
+		/*
+		 * When memory encryption is active, some of these devices
+		 * don't have the encryption bit in their DMA-mask and
+		 * require remapping.
+		 */
+		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+			return 0;
+
+		/* DTE[Mode]=0 is prohibited when SNP is enabled */
+		if (amd_iommu_snp_en)
+			return 0;
+
 		return IOMMU_DOMAIN_IDENTITY;
 	}
 
-- 
2.31.1

