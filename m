Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40E31F9B9;
	Fri,  3 Jul 2026 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051687; cv=fail; b=F3efNjMCv28IYB4Fe9gRvi3HGN1lO94XVhrGsEKA9Lai66WPvm4GWLopQsMdiSkzRxZE+KOWSA8iF5NyJCz1FL0ZMTHD6tQ9NrXp9zCYFDZsNdAAoqglqIQWi4rxytLpRJgZN40nVGabVmFTZzlK4yU8UpA2GFGcruvml/aUIfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051687; c=relaxed/simple;
	bh=PXdgqe7lUe5s6bmFxLN2eyrPBVpT4HPJWVndN2qjM9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REVDO4E9uNoYvL01pBnKQQJRMgMBbzQ3WpsGkk6iLfRtfM8vtSo3ZGbzZVTFs50mx1He+sfdS4Bv7wli84qGiY7uBNyGStHpDIULaf7W0UfDRKD0khNw+Xyh0uDgKCubP//K4ojDEiJtSPH87a0fFUDUx2IIWipQNxmMwOwVgec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iLAmmjpF; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iLAmmjpF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgEkTFxCza89hQHkaB/94Nl9A6HleTepZX0p1yrJ8dVVxWGh2h9TQXu1XzORLuOqBWuk12K33kh/zGiP1DznAgW1w6eM5Lyb/hPLbKfJBKKg3QofsKBKhJRZZ83HeumBZZ+2DBHie47BIQEHesjQA5Dq8vJMSH7pkm8hB33ezzzkwgCqXbJWMoUtm7cxK86GpfLCRF7+pE7JMX7LdLDnp+XPQJ2IX7Jo8Tr5+dFSs1ZRnR8nJu4tTAT5McP7WDCU+qdCtLVJlvo8Hdv2+cWteNhLqVJDwIGthcaMS71wqnm1VgWcZ1TdTVseCg2zOmh4oTp0qhplX8Oje3wgbfH/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRkP4e414I4FGUmiVvOyY6Z6jKFs7pRN9QPoWhHYXOo=;
 b=SMhQfaSn1AQrwbpb47AVgWfysC7TptJp3L+smC3M1e6PcPMsTrYDSaYwzLfH943OY0raur7lTfgeg4dyOvnzMFqoJzNRrsS1piYKc8x5BVtVQgCseWhAsk7kxvEZskTLrYQ6LHOynFfP1+5p5XUPuVOaoznvc7L9ubGkXqdQKC+qMes8bnAvZHblbSc8YXhxHC1Oy6XUVDKBIpesiQQGFGrx1ha68hn1cK2kbZoDEIbBvW1NDHvW55ZkvR5kssk8sP/XFqhhxPjN2U4uhqLQWEMK/HvTDs5Xh6PDJn2wn0i7mgpJ/EGbFGWPc+XtMYKUFNZgxznzZHndDMYutMuWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRkP4e414I4FGUmiVvOyY6Z6jKFs7pRN9QPoWhHYXOo=;
 b=iLAmmjpFPGgYpg6iiUJ4d1IZS9eD99l9kkQxC5aKGjc/CHCS/U+NPBVGPTtdJ6no7TiVcDD6FNWAPNeh1sNSe5Kd7sZU7QICv9Ef2CSxUd5HqCcfVNepakHGIJ7VNmk4785lOnU8qVa3lY94uRNjK1WzhEoiARLatEnaEsDbkMi7bvPF6jACbjTNgB3wTSAXvHKzxI+/NBS03RMk3hclye9wgaHWVoepVvAzc2Xr6djqSMpw3RH/Sr1Kn61K0tvfqHd9ef4mVnFfALM/ZEG+rrdfJaQGrjrjzwdjqrfbUWL9DPeWY7DXlq5HUHAD17TRNEIFZOHGi3RXJ1f5eHMRMg==
Received: from CY5PR22CA0025.namprd22.prod.outlook.com (2603:10b6:930:16::13)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 04:07:49 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::41) by CY5PR22CA0025.outlook.office365.com
 (2603:10b6:930:16::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v5 01/18] PCI: Don't suspend IOMMU when probing reset capability
Date: Thu, 2 Jul 2026 21:06:26 -0700
Message-ID: <6dbbbbe30cdc08a467de893fb9ecdc07d9cc1fec.1783044582.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 785a5d5d-cb04-4f93-3769-08ded8b8a559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rInYY9ReW1MmsrzpUDuFPJdt5aDjmQGEgQOJCyXyxVlLT5n7vCPxbpb3E3qdmOwTSx3uPCLovBTXpuIV1fzBiLM61awHdfiJBtCPAJSSjUItceXlG/OF82vx0ev9rZX5J4sBCSNpJC5JUMNjogvJ4TcXMDbi3IB9XJuqpQjBfYRveFUYZwncdmU8hPUUBYYGdtRYX9bnzkUInKsAwAVKHbMI0QQsz64sd2rfCVA+kRFtpLrdq+vcc8UwI2UnMJJjNinTi7E5i8n5KTbBHNlvds5HEprsZx2SdE8rr42RcnRZAJZtkqtotckPzNeHNXBVlDLA/qqa9WvrMQxHIjEGy4chDf+hFhq6DyQp1WnOdbBoRtW5G8suluwUyCQ6Fhq1GhUJbi5Wry2sDoAeva/6LSn5iIEvRt9aH4CXXyXD/1L47WCAUBJau+Na74moESZ6eE8TJPNbs9pqMxN6aUnCDZsEwS01vpl5FKcGOBI5ocA6OQF+/z8yDExyElzmEnguRDuoiMgJ0Gxgnu8P53gfbiotJ++dDM+5k18OtiL4Ahdivt+EGsrfZTIBzLI7JyfIvdeGrhHIHhbohTR9eYMZ90yoD/24JD58BH5qgQ07alwKUtxsMPDAngK4XS7Xu5aqOxskSLZABBMQEU+4kDIorG7u7r5R+VAopgoHj29BREIzSgDortUFa2O81/REZFyl5+orrv6sP1hS9Yo0g1s65Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AX+p0x0QFSME+YkDW/91RQVXTau0PMZLuR0hzociLYbTmOBKkwJPMHGF3+HJY2GTRAg6nVP3OUaxNXYF+gENz+L15TB3/DTK4IAVZ9Bfc8MdBFEbDPZQvg+yeHVe/Sr5BuGdu4JaBwjjulDf1PfT0Bsw/p2pcLld/X4TctKGLp0zCQfhj/yv4Mwb92AzkK5KI8T1CZKuPO3IBv5A+p21te3lHdjLSq8i1vn6QzLzFWlwi0Hm33stIHCUiPkxYZUslBbS8HT7OKrjh7fGJAv7ofB0bid9NTqb5pwAyReLKJZR60+6oZEm1DJ3Bqc5FLdaNT+3+SgNiif1hGW45nQ2Dkxof/rpnRA/p82+bdA2C1K3/YyndDa9I3apIyOkSOOWJJTPtsJ8KAfsADq9LKe8hhrvzvWHJOqJRfx1g/PN8q3z0wUaqSbIYl+gcRxsBlSH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:49.1725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785a5d5d-cb04-4f93-3769-08ded8b8a559
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245

reset_method_store() in drivers/pci/pci-sysfs.c discovers supported reset
methods by calling reset_fn(pdev, PCI_RESET_PROBE, ...) without holding a
device_lock, since the probe path is expected to query the device's reset
capability without changing device state.

However, pci_reset_bus_function() and __pci_dev_specific_reset() violate
that contract after pci_dev_reset_iommu_prepare/done() were added, which
moves the device into a blocking domain and abruptly aborts any in-flight
DMA. Doing this for a probe -- a state-query call that does not even hold
device_lock -- can cause driver timeouts and data loss on a DMAing device.

The peer reset helpers all handle this correctly: they short-circuit on a
probe input before touching the IOMMU.

Skip pci_dev_reset_iommu_prepare()/_done() entirely when probe is set. The
inner reset routines already implement their own probe semantics, and they
perform the capability checks and return without changing device state.

Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.c    | 13 ++++++++-----
 drivers/pci/quirks.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee615..01cf310540561 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4946,10 +4946,12 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (bridge && pcie_is_cxl(bridge) && cxl_sbr_masked(bridge))
 		return -ENOTTY;
 
-	rc = pci_dev_reset_iommu_prepare(dev);
-	if (rc) {
-		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
-		return rc;
+	if (!probe) {
+		rc = pci_dev_reset_iommu_prepare(dev);
+		if (rc) {
+			pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
+			return rc;
+		}
 	}
 
 	rc = pci_dev_reset_slot_function(dev, probe);
@@ -4958,7 +4960,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_parent_bus_reset(dev, probe);
 done:
-	pci_dev_reset_iommu_done(dev);
+	if (!probe)
+		pci_dev_reset_iommu_done(dev);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846fc..8ecd1bc561d28 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4250,14 +4250,17 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 {
 	int ret;
 
-	ret = pci_dev_reset_iommu_prepare(dev);
-	if (ret) {
-		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
-		return ret;
+	if (!probe) {
+		ret = pci_dev_reset_iommu_prepare(dev);
+		if (ret) {
+			pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = i->reset(dev, probe);
-	pci_dev_reset_iommu_done(dev);
+	if (!probe)
+		pci_dev_reset_iommu_done(dev);
 	return ret;
 }
 
-- 
2.43.0

