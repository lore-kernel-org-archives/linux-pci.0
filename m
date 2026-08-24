Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA433343C
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561962; cv=fail; b=CEAHn4q8PBXcZPMN8/8aFycIFnIBPIwnq/LOmtKT4/d14K5PaZyJs2hnBD8Rw8+5dHWV/ULwgaPiYbigaJ8E3heA5u/VYDszeuPbFSEVWDdshNUtOsdG7UVfYzJ7d8jNntou07DQ76dFa+c9YZ2eoXOCw11V26ILVsmWQ/RRc/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561962; c=relaxed/simple;
	bh=3t9r9ZDhFdCjhInTzLicCF0Ejir0xg1qySDqM+xjLmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/A4SjwxLesDlWYyQSvpMgA+HMMIZS7uSgYOoqi90kpHtNsN2cUrQC5H8sk1Wogf+/LZ40dPmBQdTg4+xq3Xqr80Rxlo3L0RQ43T+b8GWOupwXcB2tBIrGr4LtjlLVVHAJq16uhV2+VPVkTOapHeDZmpGS9Kix4fAAocNyIjpso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pTvGa56z; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pTvGa56z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rabuvmwYX5fiVjwafpNazydZg2GH2Z7hwJIUVtFmDoWgpHFnmTKnIF8TpXZ9J3EBRwnPkUcTjlT93Uyt6m7789/zg/C3+p/bvVFQOLR59kM0ewq73HXAIUdrpSm2SjcAHDYVbZX+Cewv/oT62ZjkHwThPxmfypv5tO2Vo8LdFWqB4kG1aZIFyv1/PRU+lGKGyfxG3BuvIMSg2ZGHkdPf+I8QrZwjZutxozqV0+YfCERS1PXBLrMA1GCbqwlxlmzcomG22jwP0g2Ad1ZceXhT0rDupWne2VzH2Uthvzdq21bgqZ5IDbsBXvFVrPgfHjXHEkQXrHeP/bKNktCn5Zb7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RJLJyeljRslrw6yZpU2FjygREnWXq+Gfv82r/0wMKY=;
 b=EicR1ug6cbQbJcmAkGbzvF4qx6yxhV4yDPH6uttRDqI9qifGfC9yk4XXcc89pANQwggK+Q9u0t3CP5AKPVvB8tuzZnPD6x+2Mx/ADh9gtbIgiKwSNbHapxqi8sFdr0VT1+B34zwhWIDI9JNElcu2aPaSh/zbyTwz4A2jrzA7+5i8HwNPPW3WUErDckRNGC3hClZtQbJ9l6chI+PE2FhzTIF65w71+zvcXg/PY/BmnhK7hFIK/r1mCEtfPBQ9x7K+olivumEaYW5QKaHiQ1UQaxEKcHK+MdPSs6tV66cXPNQOTgYV4UvG3RhQ6H7afA7T2dGXa6N5cPN+XQznpV2jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RJLJyeljRslrw6yZpU2FjygREnWXq+Gfv82r/0wMKY=;
 b=pTvGa56z+dhm0KsBL1Tz9OoDb3cJWt2H0MhQMCNhHLyXsaDVryiWlopvDchEUav8Z8lB7FsSljwWxcAOwifoAwdX8rN490JHmhK1fSLjNc8RKPPrRxhKx2clfv/QFDu9OoxFobuTGdALhrt6RfQSS/uqChBgRdkGL4AmIEYX82s=
Received: from BN9PR03CA0728.namprd03.prod.outlook.com (2603:10b6:408:110::13)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 08:59:14 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::74) by BN9PR03CA0728.outlook.office365.com
 (2603:10b6:408:110::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 08:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 08:59:14 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:59:10 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <linux-pci@vger.kernel.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <bhelgaas@google.com>,
	<alexander.deucher@amd.com>, <mario.limonciello@amd.com>,
	<felix.kuehling@amd.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2] iommu/amd: Force identity mode for selected GPUs only
Date: Mon, 24 Aug 2026 08:58:21 +0000
Message-ID: <20260824085821.5422-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc9d1aa-766e-442f-2008-08df01bdf8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|6133799003|18002099003|5023799004|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	IyVY/V7xFgdAe9uJrA+u9nVXPPtXlyEaa3uGHMQ8bQsD4zjcSvpS88OmQwDZzkSSU1af6IZew4ItjGlhSYDBbBJBfcChHJcAqeRnwNRHr4AIMMWf8gwEbt/keqy1aIZ2oDzO+mPPghugJiWlDB6eXyhkxWdk+R0QIje9npcodrVazSoAdWsY6lR8mQ1e34tQqR2DKAy/gCGQYFuwVzQPBkezPI0iHv3VGZgJwQAGu+nv6ZGE25AQNT59MeakzkziP7ltI8/1Cr14lPAImQ4NgDuS8EcOOxrgahbXNA+3cWb9AnX9trVyoHHFmu7tRs2j/7cEYF/xMv+zX+gO4A2GxvUjyqD2EcdVd/6bOcUrKAgRZUVrDGZJ4YlnDaowheGbAoyXgj5MF0jvKizmwQ0zIwYIFP1/mE/5vB9h5Xz6OK0idHQavJRvZqmMXj1U19QOqTkVRneEhQ2Uv+PuR7aq1Gbh4v4E64fqQbP9z3/I1l3KTYsP7yeqtb+C+MJoxjYpJLbHMiuTyEqobldZqYqNcQeUBvR/qA6EAqv/25ef3+E96TPqFWo/cCwwUs5oy15fkg9rAMxWFjVTugdn4WPzUWFDB3Hy94cN7OWyRvbJU6JXNboJ9hp7r+1xeswzH3bOmHsSSP9V06C2Rr1vURbNWCcZnW2vWt39lRvX1FtqILMenzEVsOVlNn/jSxjwaxqMgcM5s43fsd6NfVDNOXAmjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(5023799004)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jD+gAZ8UNWpDp/95SvaYMhHxdQjByJ3weERL1ZiTrtMhkv6SMkyUMB0tqAc/xL87T1U+87AAllykRrfz2fwJEXnKxq00xIQHoFwNJKS4yS7zb7sz27yvI4ewT7/vlFJJJLQaGNVhiDa7nNRrLl1EGoP2qxGFgPRvwnfRbU5/y2de0H3yKG8TIoqh8jkK2Lq+3lg/5qCI6pkI8Fv+X50bEpqzFITPjeLEH6JFz9/seW+DkQ7wruqScaEyxqoA6YDr7WaROiE+hjyGzAUikw/lofveaSKKbWmE2p2tNEVdRJ8EgXz5cA3hFywY90VJTR+OZnpzUF5NYUC+Q5LYcFEIHAvwvK6inzBMlt1SkaE37Cs3Qy6W8wMrDggrIHmbZuz/nlZLG2lRf2VXzz64sFe/I0DsImBh2s6NxAxyoxRvYaiBuR58nJV9WjV6f9vRe7pd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:59:14.2276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc9d1aa-766e-442f-2008-08df01bdf8b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

Certain AMD GPUs must always operate in IOMMU identity mode. This was
previously enforced using a PASID check, which happened to work because
these specific GPUs are PASID-capable. However, this approach incorrectly
applies identity mode enforcement to all PASID-capable devices, not just
the GPUs that require it.

This made sense in the past because the domain allocation API
(iommu_ops->domain_alloc()) only received the domain type, so the
driver had no way to inspect device capabilities and pick the most
suitable page table format (v1 or v2). With the recent driver
enhancement to use domain_alloc_paging_flags() for all paging
domain allocations, the driver can now inspect the device and flags
directly and choose the appropriate page table type per device.

Update amd_iommu_def_domain_type() to force identity mapping only for
the specific GPUs that require it, via a new quirks_force_identity_mapping().

With this change, a system booting in DMA translation mode will now
select:
 * Guest (v2) page table for PASID-capable devices
 * Host (v1) page table for non-PASID-capable devices

Also drop the amd_iommu_snp_en check, as SNP enforces paging domain,
which doesn't work with the identity requirement of these GPUs.

Link: https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/
Link: https://lore.kernel.org/linux-iommu/20260723061548.10187-1-vasant.hegde@amd.com/
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes in v2:
  - Dropped disabling ATS for "Radeon Pro WX 4100"
  - Addressed review comments

@Jason,
  Once this patch settles, I will send separate patch to drop
  'untrusted' check inside amd_iommu_def_domain_type().

  Regarding SME check, I have retained SME chek inside
  quirks_force_identity_mapping(). If everyone is fine to drop then I
  will do follow up patch later.

-Vasant

 drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 29dc18d3d22e..fc7819f57521 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3122,6 +3122,26 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
 	return dev_data->defer_attach;
 }
 
+static bool quirks_force_identity_mapping(struct pci_dev *pdev)
+{
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
+	if (pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_ATI)
+		return false;
+
+	/* It is the GPU in an APU, force identity domain */
+	return true;
+}
+
 static int amd_iommu_def_domain_type(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
@@ -3130,20 +3150,23 @@ static int amd_iommu_def_domain_type(struct device *dev)
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
+		/*
+		 * When memory encryption is active, some of these devices
+		 * don't have the encryption bit in their DMA-mask and
+		 * require remapping.
+		 */
+		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+			return 0;
+
 		return IOMMU_DOMAIN_IDENTITY;
 	}
 
-- 
2.31.1

