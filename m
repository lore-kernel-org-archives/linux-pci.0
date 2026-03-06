Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06413E95B5;
	Fri,  6 Mar 2026 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840520; cv=fail; b=ADZ2Xsks0iqqxZsUZBULPHO3fujzFlWAdelYh8p9DEktxIA1zQ9wNE8gvYDN8Rlibn+MOsUw85PGaw/xhksT+Ex3eaGEt5f2e+rbcer7m97g08MtppThNG/wV61YIFbdK6aeRXK/mPTH5cseeSsxXnXCPxgRTijbyDaGFsOSwxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840520; c=relaxed/simple;
	bh=YND7cI3RiKD9UMv6E3ivuGlkJJeAPZMbO+GF2n2ok8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aheizy/7TV34WB/D4af8sOBqsP7K8ejLEyN79XvqR7P6nmVVXWuf5VfJuY+/UvEToVtFXXWoMi1TLULDWu/XCYAIFZstquq2DgKTotHKK9SUaHcgmwASANgs1ALznr0OhccBQ5zg9P03JPFqfGClEdVbglbuyzj+5gGZuH+apF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BRlzg2c6; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BRlzg2c6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLD+IlU5oK4MmosZIhfuy5/LlVK04k3ZreJL/WnWd2XpaulOST3dZWg/q6dAbO6FI6yxUnlZI8XvfAdG9JRW4xxIyec/oJjxpBX6c1LSQfEQLMUBH6+nMI4ZJJNQL7XOPGCqWY4MWG+Hjz1gLuty7OxyikEivo1i82eXok9LRd4ZgKVD3M+8EAHXnxACuBW2Gw8TRZRk7gAGWnO/V/exHAJBtx+lqtKl7JMLksKFVYjuQgiNgBYx6HwFSyJp/UNX/2sZb92kpX4iyMJXCyBxHUcMYxX4bkrT4TEn2KZSMCnSYrx6lrjNpYNbIf/GFcxbWAUVyuf/Nl4k73adBsG0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIAeS2SDhDN3D2rj4M7gOIYpLMP7babZHNEGc61sqo0=;
 b=M577/lNnbthUPmh4S4EoTmH1c7x7AHFNXySwba7F2yJnraSB910Rp1Dedg2YHzKu/tl7F0FAEPqgZ1JW3mPpMUJ4m8PZjDU3Tvq8mklETAEsixI0+A3Ns9YA+QpD6qu0ePeY6vvCHpS4LDiPN4//Y0QA0QKfR0F5o7PP0Es5UxUKPolT2OVxdVOEemjPgzAzRchQeczp+Qo8alZbR3unwfmiaPEBPKgwEVLgd9Vr+XmkyLdHBj2Bax5hj+t/AMkprjPCAtIDGlHlBbxGQu2TPgyLtx8LXb9Yl1DI4PXE08ubnEGIGEkajtsa6YcTVOOB7ajkYg9dbWFP6Im9KJ+V8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIAeS2SDhDN3D2rj4M7gOIYpLMP7babZHNEGc61sqo0=;
 b=BRlzg2c6cRrw5HFbUJahl1OYRHdDVh3y5vcoHfPMYf8ilbHOfdblHaW3XIgOABjz0rUGivlvbHscJqQUL1LX3+NcIjU4HLP+gRJYMJ4Q774PUi+aXBPBqPh7G9iO+EtHvv0Uq8h6jVjWbllU0NJoWrLTKzyIfte1Z9N/n0iYQBdbNae5QjhchnSA6dcd8XT3NqtoAA2kM36zz8kiOJowIkiZbiL8HY9s78wC0Xz0Lfmo2D14vGokPCdwfPK82F9tC8bEkrDYYNZMVyvruPjCR9nQ0Gl/JviGZmb1vfkqmhidTG1uhlSG8/Dr0eneuJkFKggYJlAcQlI0cMVpbfAe3A==
Received: from SJ0PR13CA0175.namprd13.prod.outlook.com (2603:10b6:a03:2c7::30)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 23:41:51 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::b1) by SJ0PR13CA0175.outlook.office365.com
 (2603:10b6:a03:2c7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 23:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 23:41:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 15:41:34 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 15:41:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 15:41:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v3 2/3] PCI: Allow ATS to be always on for pre-CXL devices
Date: Fri, 6 Mar 2026 15:41:16 -0800
Message-ID: <c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772833963.git.nicolinc@nvidia.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: b499e92e-f763-4f9c-4a23-08de7bd9f05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	W2WV7QlWLaK/59di+i/v/PJmh1Q+J+rT8g0BDlt0pZrX1up3zPuceuGzaIJu9sRSN10nKzEEM5R5hKweMO2W/MTGxH7Tvt2b8TmFL5ww4sJ6YTriTVcV/xilyogxWi7EkjwgNqHEiTUt8dehy+qt3UZbqK8VE3YX/GwHYLCdS35z85VZwPIE0TKgZcMvNgDU5BWBpbmZakD/Nvq5nPP+m8/P/Ltg6D/3Z0X+JhFeRN6pLovSRs4c+R0m6k5JygyS5rK2INfmjGvxJ6/RPYOIIyk8c4h6XgX8xLGQJHzccHmaJ64EvFjJV8wplfl+IN2jdNbTepZ/PzGsVk+Lu9yEmsZeSkfD3DlkEFIQEGEMl5NU1l1bYTWLH2gGTbTaZllMyITq2fbp+cZcSlUWRLZ3oDdORRdUXEW5PAFUdGDcvAYzK+jcMP3Ug305q6Vs9GiCI+Nc2Xx7S0tAABbdgSldfaWIK94f0dRbyxXM9EyOA5q6BwHuoCtUO3X3TQQdZ7K9BiMDu67JhxRWLplB6Q34a2hNLDYoG8E24f/mCjsEuq5cQmgaeH5ZhDjNycA6aUuRYw13PlXI0A0+SkuobuI7T7RmxZozvSVyzyU2+lFMxaSIWwjLI2f3l6dgLZZRp5cB49owO4eiDGf2QoxxdfAZFTFbF7NxA2Z82TecIgnB+BelnnczWvpL+4eSs/6AgRmUtyHHGWsJoXunq/AonKloF4dcAx0hpuXN0N6E4wGDvM0HyJonfia0kdDX4y4YkNl3jrlqkHHZjFHyqWPbDjzzsQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QYWY1w/DklE97ybIxn+7BSms6WhUFWZUfTV0ySA54RmJDDpw69/IasVzqA2UPWC8Ggj2lGBS6HrRSeZRifOj9P3Dd/HCdFdjYjCFCv4iHRiUE3JFE0Du2HVREQ51ZktO1TbSELRiBmeQLZLLIPe0bYJubwBev0p+BBTGI5RrmY1lPL2UmS5KOj7C6Ieam0qn0jZDk9h9XxS6F+5UHDOVthO2Be7NAXMnKPuhCdXBc29n9rbEMw+teTmJAQca5ZEV6ed0YVGiTPmd42BxWCGnaVVBFNLKFOjrQiAfKsXe49DZ9jIO9PUjfy/xWUvTdvf6yV8e04I3fmdMmqYveJj8xGyYd2QDfOx8KbSiVOrDx+oAPxfs02LJMzkWDMtRcph3Yr2Qfa16y6OkeW/f/o36DOvJuwWvhdVilxDErffyckcs5i+l7SduOzMXS7hGe2+Q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:41:50.2587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b499e92e-f763-4f9c-4a23-08de7bd9f05c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

Some NVIDIA GPU/NIC devices, although don't implement the CXL config space,
they have many CXL-like properties. Call this kind "pre-CXL".

Similar to CXL.cache capaiblity, these pre-CXL devices also require the ATS
function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.

Introduce pci_dev_specific_ats_always_on() quirk function to scan a list of
IDs for these device. Then, include it pci_ats_always_on().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.h    |  9 +++++++++
 drivers/pci/ats.c    |  3 ++-
 drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce6..13fa71f965900 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1150,6 +1150,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
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
index cf262eb6e6890..e6995b536ad4c 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -243,7 +243,8 @@ bool pci_ats_always_on(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
-	return pci_cxl_ats_always_on(pdev);
+	return pci_cxl_ats_always_on(pdev) ||
+	       pci_dev_specific_ats_always_on(pdev);
 }
 EXPORT_SYMBOL_GPL(pci_ats_always_on);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be72..21451e62f284e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5714,6 +5714,32 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
+
+static const struct pci_dev_ats_always_on {
+	u16 vendor;
+	u16 device;
+} pci_dev_ats_always_on[] = {
+	/* NVIDIA GPUs */
+	{ PCI_VENDOR_ID_NVIDIA, 0x2e12, },
+	{ PCI_VENDOR_ID_NVIDIA, 0x2e2a, },
+	{ PCI_VENDOR_ID_NVIDIA, 0x2e2b, },
+	/* NVIDIA CX10 Family NVlink-C2C */
+	{ PCI_VENDOR_ID_MELLANOX, 0x2101, },
+	{ 0 }
+};
+
+/* Some pre-CXL devices require ATS on the RID when it is IOMMU-bypassed */
+bool pci_dev_specific_ats_always_on(struct pci_dev *pdev)
+{
+	const struct pci_dev_ats_always_on *i;
+
+	for (i = pci_dev_ats_always_on; i->vendor; i++) {
+		if (i->vendor == pdev->vendor && i->device == pdev->device)
+			return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.43.0

