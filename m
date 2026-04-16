Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0F3A1696;
	Thu, 16 Apr 2026 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382158; cv=fail; b=QACtRYvgzJgAcBoBXdPt24gNUY7aucwXPNvyC6SuxZ/cav7Sh+1WPPlpB1n5hkGXViUj4w4KP+8U9Z9NRYOMbQG+LpF2IQlksdRKeLDOHEgJVbkp0uxxnc4Rtb8yRqnGVnSuW425mhqEno9y5wGe0e6vuh65OpjhjVWMjgg/rDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382158; c=relaxed/simple;
	bh=FeTkzVqbbidFx5zDMnSp/dgLY8GM4kUuol3a2Q2UqoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXdn1ILcdP7bkNaEaLbBoihU4Gv0NJhuldLz01IGYUKyMzkC4YjW/P3KbPAwEcWwbBC9Dn9g+oH297+ANUlAHdjU1QLSr/K+ASNgkr7Mxs/sUbd9KlNxKl7Wf+g96vZodaD0V4QmT/wPXVUx2c9bBh8UJm7hI/dglnn6KDXzgbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q7kKQGWv; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7kKQGWv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdgCxzBv4b80TbzNbEHsC1H3x20YKXqj4aC4aj2jXIlPwlAzHkVP93eT8aTKooZOCiLKuuwLGLSB5GK5NmVYpFFrScGSpcUXm37XfHE2GOv7Pe7sEXoqgJzXA60y+9FZG1DUs0yRU52xWFPlWt4xfky20UNHyW2+PC7o0c7u1xHIuyGhWEmS4tvz3SsjuClsnKm+LyM5qgrfArYdmhRivivMAjQtpvllhA62l1SB7jgne+9sHVwVQIR2Xob/GwzaczDXVS15IMVs0NQtpnp4AeKp6ZW8Sz69QiZucZf0NtEPG3c9yjunoiuScz33ociMsbnFaY1RlqC69he0YkrOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xU0SF1c2aTQf9rwtoXTLq2tK3iomIN0eANWh+JD8ek=;
 b=Q3urUDCIL3ZUDSdgzrOlDfwmGveWHOIkHhFtchzYm80HrG/Qo0fgHHznRwKAm0GAClgt1PyrYZtUSE8dQVyZ1LntvMOLrxKbiq7MVSxfi/OGw9G3tLGMlXIwleb6+bBhOifU2/X75fIT2kRfTdIIhJdzRNEIo66LIuS44EEiSCQwMvGcsEqykh+10VmMFa7loND9x9sxHfINqW9JxFdZhwFJ2lBaLB/dPJVJ7Mn16Jsw3x+j4o8CX458nXskAOdGEiCg5n4TMiatRC3w4Qz3xvKCW7BMHRfXvAqHzObBXeH1gnYNrI0sjkqxGaXEM5siw6fv1cg6o9ODmONsj7UVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xU0SF1c2aTQf9rwtoXTLq2tK3iomIN0eANWh+JD8ek=;
 b=Q7kKQGWvw0ERy32AYjlBfKYffyeZdpD4/Qtp0V5lXW12jxnlRsNkfn7f+KKsuOsKgZsOUQUTPral3nMyBWN8qXYYPHpti7Vpl8gqQTtjaynZOi9GxJ7piVxNALjIBKXHg/CVVKFbEllZQG1LIvwVoZBCFxf6ypLQNdtyu8R7TuH0c/zBQyCy8BV/EDnfujiSyuVtmGFlErZVk1jBqImlu+Oas0jbzMhwSxeP/FZ2Y67M3ooYxSmxpfjk/neUD5VSFwIqIl/F6Dm4WaDNYo6XbdvCv2VcPALKammAzuYW3FAwwVKBuEBgMEXXuRbgBTVmwAGytHA+5bihkqWQDFRNGA==
Received: from SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 23:29:11 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::6b) by SJ0PR13CA0064.outlook.office365.com
 (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:29:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:28:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:28:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:28:47 -0700
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
Subject: [PATCH v3 01/11] PCI: Propagate FLR return values to callers
Date: Thu, 16 Apr 2026 16:28:30 -0700
Message-ID: <8bc784e505dc04ca81582307c4a70babbf58eca0.1776381841.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776381841.git.nicolinc@nvidia.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: cec47fd0-727d-4530-dd9a-08de9c0ff696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NwzuOyQYKmlZK6sDqo4pjxdYG0VPidOm77eQKk3Siv0pyuSSds5R9jMNAYRl2RnQGzEZYNUlU+xYxlStttR6SH4vSsTJsaZtLERecEYh5iMtD1P4P1+rxm3eLbunNNoR0JF9EGrN6ag4ypswtmUnclgey810GVbV2mF9+Ntniy+NxtEqGiHosfhV02uIaSQpIkYLYQn3YiFnT1WHU2xNe5qDj0b0UBLirzj1at/TqiDteuXXekP9drFOgtVmLz8qNRN1ZbexQvzeDnbWYxJh5BtRR4IJjT6NIkKka4FSveFTlofH++NLWDXcuDfUcg1mo07tZ59KSUrasLvIhSgv3if5mdaspx0Gy3qBYMQMyW9SJVeubvuI3xM2P+F9BwGfkWfKYLPWdEcqfZZMmTPqYKoNNfs22hVuvJT47YFwDmd7nzK/e3cz8gBZm464flAWxobubVclHoSUQ7NNbin6fr5TeShgYZybE4HL1PKBLrYxgTHw807WBXT+jWdMiMBcu93UPxD93PUPBk1X3Kf62Q91lzY01UPyrgr2QbscxYKQpXzmEe514bUdfPvaLfkfhEgLpVr4dcDSFX1Bd8Lt+khKhP0DLd+PmAi6CXgA1K+eNq1c3u+zm12t8cLnIbKU+kNmF0vUkwBGRFnr7nJYBZgN5C3YsMQ0iaHNWHut84pfS9yq4esKAjrMzoHwVSgkfZm+R1hjsXIC91QHHyfv7YIaIDwW0BIpHqLuAtSY7QtcVQ28JblgcyLXhP1ZiRONHORT0hQr7Y3QHGn25aLFPA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ofydaOflGwO+wgh2cuIdIRQIbBwYK5RgTHdGZme6pFX04Rats5l41xFxOwBAF+ncEusCLjtK5oG1YCfsZFsAusvr21k5wtksDkGQnhafdjnoj6rOx4k0DPPmPEiUV/wOuWs43rrjIecVOoU6Nao8H3YMC7yvq5rBn8q2XVRFvhjQS/62ZbUDi7I+CZCrVE8zj+vwCxvQGwakblVqigk+/LJzVtcKzmCrnX4unsw617Y25PyTlqfRlp6TobkpBOlz0gYfz6sEKEdd+g5uDPJMarEqDwoEBu+QkdTUeIyVTLPln7yIOare2jw8a1IwfJ0LYbU+ukF7kd9dY/qxKJfVE+TtPhfzLexJlszm5jFEJcrpJ5+zdN+mtDRMTyQiKjDRkn65RddgW0hH8lijtgsbFzlR52piqG422Wws8Wa2Ij58isUeEKVCyT45RD90cmR2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:29:10.7446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec47fd0-727d-4530-dd9a-08de9c0ff696
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

A reset failure implies that the device might be unreliable. E.g. its ATC
might still retain stale entries. Thus, the IOMMU layer cannot trust this
device to resume its ATS function that can lead to memory corruption. So,
the pci_dev_reset_iommu_done() won't recover the device's IOMMU pathway if
the device reset fails.

Those functions in the pci_dev_reset_methods array invoke pcie_flr(), but
do not check the return value. Propagate them correctly.

Given that these functions have been running okay, and the return values
will be only needed for an incoming work. This is not treated as bug fix.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/quirks.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be72..05ce12b6b2f76 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3957,7 +3957,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, bool probe)
 	 * supported.
 	 */
 	if (!probe)
-		pcie_flr(dev);
+		return pcie_flr(dev);
 	return 0;
 }
 
@@ -4015,6 +4015,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 {
 	u16 old_command;
 	u16 msix_flags;
+	int ret;
 
 	/*
 	 * If this isn't a Chelsio T4-based device, return -ENOTTY indicating
@@ -4060,7 +4061,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 				      PCI_MSIX_FLAGS_ENABLE |
 				      PCI_MSIX_FLAGS_MASKALL);
 
-	pcie_flr(dev);
+	ret = pcie_flr(dev);
 
 	/*
 	 * Restore the configuration information (BAR values, etc.) including
@@ -4069,7 +4070,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 	 */
 	pci_restore_state(dev);
 	pci_write_config_word(dev, PCI_COMMAND, old_command);
-	return 0;
+	return ret;
 }
 
 #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
@@ -4152,9 +4153,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 
 	pci_iounmap(dev, bar);
 
-	pcie_flr(dev);
-
-	return 0;
+	return pcie_flr(dev);
 }
 
 /*
@@ -4166,14 +4165,16 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
  */
 static int delay_250ms_after_flr(struct pci_dev *dev, bool probe)
 {
+	int ret;
+
 	if (probe)
 		return pcie_reset_flr(dev, PCI_RESET_PROBE);
 
-	pcie_reset_flr(dev, PCI_RESET_DO_RESET);
+	ret = pcie_reset_flr(dev, PCI_RESET_DO_RESET);
 
 	msleep(250);
 
-	return 0;
+	return ret;
 }
 
 #define PCI_DEVICE_ID_HINIC_VF      0x375E
@@ -4189,6 +4190,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	unsigned long timeout;
 	void __iomem *bar;
 	u32 val;
+	int ret;
 
 	if (probe)
 		return 0;
@@ -4209,7 +4211,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	val = val | HINIC_VF_FLR_PROC_BIT;
 	iowrite32be(val, bar + HINIC_VF_OP);
 
-	pcie_flr(pdev);
+	ret = pcie_flr(pdev);
 
 	/*
 	 * The device must recapture its Bus and Device Numbers after FLR
@@ -4236,7 +4238,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 reset_complete:
 	pci_iounmap(pdev, bar);
 
-	return 0;
+	return ret;
 }
 
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
-- 
2.43.0

