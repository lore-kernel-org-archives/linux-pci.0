Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D235E952;
	Wed, 20 May 2026 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306417; cv=fail; b=s1DmZP1Kj4+ymxc10y7viqe7f6Af1H8GHAQ5V3OP6E4aWyC4UIZYkjdriU6bMJtIB4VsDJXkViu7GuwkPEkxWjGdfaO1zRwmPwVMgAaqRCkcCDpz9suzP5VbOLfXPX2I8JplkNUOEBBT0fLTNO9ZdGh8SsShsPtswVUu4bNkKwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306417; c=relaxed/simple;
	bh=ovR18ks/GdvvHh1N3ShhjxSvRldtJvMjcUx/h+QZews=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/4Oz0ba+1a1p5tRwk/n/ALC+ZIsV+xCrXn/4u0C//jjkAyJIXsXGVJEPMOf8i5Awn7g/s/SxXwn9JNS7RA4iIYL4Lz9z5uxoZ5rBVR042g4UF+Rlq3ZcoCYfMPqL1BsLvZ6L0hCvYgL3rAsK1WIhpcaVqfqp2jJAUz5JUHX240=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g6IUpUdt; arc=fail smtp.client-ip=40.107.208.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g6IUpUdt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buprNaJWM7KbOG3SeEhfpT7Hcmch2ttmP9kJKJSm1ORh3Xhc1v3fOOFbnAbTDAvVEFlTLv41Cbwxw3KbLdm98VQrACE4H4CXf7vh1kfnBWxj2q9ZT3hV16RwJRbpqK5KT4FOLxVheuhN1Ir6qgC+q1z4Ry2PM5dXNa05jbA/hnRFkkGZBryXFhbCuIJwkzrrxO0lbO7Zkz9n0kUgAnWNPm48wqXaKNsQNsYjMf+uoDn6wQKIpigxDuo3vEetqlVtUfq8uOptqV7pPKuhSEqPYVI388aR90V/M2qiFKxV3bWSAGEYkXrLYK+F1pEIX7s/yrv48rdkWxn4JUcMH8JPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfIF4w8GC+r+Epup0nTeG37KPilOK7+R6/+ivq5REdc=;
 b=JGD/qHkHdfTh5G6vNMJaTgy9hIUpNChd4eQrfxtC4xEpOUEXT2tlQfPF3bb3ioseHQr3wPaXfnJVkLFv5c78SzNwtrMQvsA2/qSFwD15Q2rCPwNdGCJRvjxgo5bq6ECEvzVbg6V5MVjdwZatCghGOXUHuyNwakalBYU+NcmwS4yzmyTfGiAexZmBaI+x6UPeFNeHPDTa0kA6oVOHRR4xAQ8VExbUVtuvh6jwDqMCiOTNorerjMKvNGjIedpYt+9Z4MXrua/NMChD+imY20wA2CE40agyJI/NZOYtAzdagBV8i+jih3Jzz6Cj145jxxPNWszE3IE3nb90QeCnHXLNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfIF4w8GC+r+Epup0nTeG37KPilOK7+R6/+ivq5REdc=;
 b=g6IUpUdtqNoLe6gopfmm13hD2KAZ/ZQwbSCXZzx9/Cz+KzyUIHfYs9bn33jp9xi6vMXzHeiXjQP9mkDU6CBTzYE5h1IaCQ+QLPO4tRzdMBW4a3wOzhUetF8N8rUMrf9owOU7kgqITyLVDpDnYNrm6hNwM5jwiLtHddJQ9GDhpfq0MfpjnxvpefWalzhbH0L5VZ/EdXDnJu5L+gxBNew+qj48x8ccQJlYvghf+4pFs1otlVWNmvNSLCtPLZUvymGYStK7/LDsec+LZ5dms7y/sap2S/tloIulCiolvJlVp4ufiKLe+f8YeE7t5IamCPW/2IcWR/HqLCe2SlXngXYMqw==
Received: from PH7P220CA0171.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::32)
 by CH8PR12MB9743.namprd12.prod.outlook.com (2603:10b6:610:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 19:46:48 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::6b) by PH7P220CA0171.outlook.office365.com
 (2603:10b6:510:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 19:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 19:46:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:46:24 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 12:46:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 12:46:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <joro@8bytes.org>,
	<bhelgaas@google.com>
CC: <robin.murphy@arm.com>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v5 1/3] PCI: Add pci_ats_required() for CXL.cache capable devices
Date: Wed, 20 May 2026 12:46:08 -0700
Message-ID: <9e01e6d39deff2bf751da3e1abb43f35a9169194.1779304390.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779304390.git.nicolinc@nvidia.com>
References: <cover.1779304390.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CH8PR12MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: d78930dd-1ed0-4764-805d-08deb6a88456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|376014|1800799024|22082099003|11063799006|56012099003|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	HHQQpoUnVGEq3oFKV1msyRUHCCXS0DpTCPJaE4BdTmNzOOPGgr0BjX0H6OoQtBe6jqFp2y9PikFJoIdSr0iobPPSwAMRrPgxDXmFxWgti0woLjicuZNXqvH+K3aT2TVr6XtimDgQSFJSzQ/XiKkqGTn33JO30O8Eagt6p+IVZm9t9NuQX80UBaR/QgvfHjL06pEY/pMwqT1lyIBWNf4YqD/DH3g8pQiQs2ITmdVqK4leXR1D32scva5qXwHVgKgVOGCjLGxM5/2Sn9RWdxki/faOC/SJsDMEHtmfPZ+ea3SYKQmgJ4w+KJ8PsaIQUreCd8ytkrRs24trurhLeY9i6X5ftcJTIoHVHFTOvB7D3O0Rv3usk16ELNp4Xvd3kSXz5i6QIhhsJ1k4EjwQzceTvJwH9Wk+FAzemFwHUcTBHlp2XFIqSBP1j6Nzr26lu41uFhLI9ioTLDrsiFmxIZW/citzD1MpEiO9uaa//K19c0yqumQk9cb22aJuW5uUO192sxWQqs/ViYjh4yT0QheR2zwJuRH36NY1nJZdpvhVH7VwWpinnuE1SMt7Y/18prjbJkP5/JQ6s1rujIbsCZ/7sgtMaUcFfD/LrAyxdBP7lB+tGb7byf+VNqEfDJ9G8vItK33OUBowutzmcV1anBv3YH9vc/OLfVb0sSceIM6LIpSsjUR11MqadT4KmBxWfK0X7cz0mNvCwTD7z/aIqpzDUji0zos8rjhsP91slcGsdRs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(1800799024)(22082099003)(11063799006)(56012099003)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nbgOOoMmcr9fUeo0AlWV3nRm87UTkb5dqQ6WMHljULBRuvTREm8ceW4QGMoPajmGpnY53XxlLP8i4tWWVDllSN6/LBc6cZ7lY54bxTMs0HTtFyvYQn9W65eEq3R4jhj4iHT/0VU0vVNmK+sTE8/p8L60Lq/0OynEmJpevYkkXsRDdxatz5t8yBCsIIREX0TodMMuJcydf/HBonL0Z8P5YfdMJs4i1z4tFQFz0Dd9fRcAzqP3hcGLw/e0TQ+R6I/UDsBG1qswRJVhGT3Mdjq7EW12/p9R5siybfiyrPY5s64exC91uaNjs8KUSjKMvFq1ooRBO8OhWhXMpOSsDhdTl0Wip5YgluNius/StqeC/AArBvtOzXbIJZyHuaU/WO+fqpSXpBO8yvc2t6orHUI/drdmx+nDCT2Plyu0wxH5rZltqpjZNb3gNSI7vQK0jai2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:46:42.2901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78930dd-1ed0-4764-805d-08deb6a88456
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9743

Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
given PASID on a device is attached to an I/O page table. This is working
even when a device has no translation on its RID (i.e., the RID is IOMMU
bypassed).

However, certain PCIe devices require non-PASID ATS on their RID even when
the RID is IOMMU bypassed. Call this "ATS always on" in IOMMU term.

For example, CXL spec r4.0 notes in sec 3.2.5.13 Memory Type on CXL.cache:
 "To source requests on CXL.cache, devices need to get the Host Physical
  Address (HPA) from the Host by means of an ATS request on CXL.io."

In other words, the CXL.cache capability requires ATS; otherwise, it can't
access host physical memory.

Introduce a new pci_ats_required() helper for the IOMMU driver to scan a
PCI device and shift ATS policies between "on demand" and "always on".

Add the support for CXL.cache devices first. Pre-CXL devices will be added
in quirks.c file.

Note that pci_ats_required() validates against pci_ats_supported(), so we
ensure that untrusted devices (e.g. external ports) will not be always on.
This maintains the existing ATS security policy regarding potential side-
channel attacks via ATS.

Cc: linux-cxl@vger.kernel.org
Suggested-by: Vikram Sethi <vsethi@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/pci-ats.h       |  3 +++
 include/uapi/linux/pci_regs.h |  1 +
 drivers/pci/ats.c             | 46 +++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 75c6c86cf09dc..f3723b6861294 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
+bool pci_ats_required(struct pci_dev *dev);
 #else /* CONFIG_PCI_ATS */
 static inline bool pci_ats_supported(struct pci_dev *d)
 { return false; }
@@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct pci_dev *d)
 { return -ENODEV; }
 static inline int pci_ats_page_aligned(struct pci_dev *dev)
 { return 0; }
+static inline bool pci_ats_required(struct pci_dev *dev)
+{ return false; }
 #endif /* CONFIG_PCI_ATS */
 
 #ifdef CONFIG_PCI_PRI
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350d..6ac45be1008b8 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1349,6 +1349,7 @@
 /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
 #define PCI_DVSEC_CXL_DEVICE				0
 #define  PCI_DVSEC_CXL_CAP				0xA
+#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
 #define  PCI_DVSEC_CXL_CTRL				0xC
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9c..ebdf761843867 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -205,6 +205,52 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
+ * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
+ * by means of an ATS request on CXL.io.
+ *
+ * In other words, CXL.cache devices cannot access host physical memory without
+ * ATS.
+ *
+ * Check Cache_Capable instead of Cache_Enable because CXL.cache may be enabled
+ * after the caller uses this to make its ATS decision.
+ */
+static bool pci_cxl_ats_required(struct pci_dev *pdev)
+{
+	int offset;
+	u16 cap;
+
+	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   PCI_DVSEC_CXL_DEVICE);
+	if (!offset)
+		return false;
+
+	if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
+		return false;
+
+	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
+}
+
+/**
+ * pci_ats_required - Whether the PCI device requires ATS
+ * @pdev: the PCI device
+ *
+ * Returns true, if the PCI device requires ATS for basic functional operation.
+ */
+bool pci_ats_required(struct pci_dev *pdev)
+{
+	if (pci_ats_disabled() || !pci_ats_supported(pdev))
+		return false;
+
+	/* A VF inherits its PF's requirement for ATS function */
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
+	return pci_cxl_ats_required(pdev);
+}
+EXPORT_SYMBOL_GPL(pci_ats_required);
+
 #ifdef CONFIG_PCI_PRI
 void pci_pri_init(struct pci_dev *pdev)
 {
-- 
2.43.0

