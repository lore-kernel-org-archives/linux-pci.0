Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A81426EA2;
	Thu, 21 May 2026 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395695; cv=fail; b=M48kvbupa7Q/1N69IWUCiXIKlIIu2ieoBRLxPpF5/brSKcbUW5xSc67PYw3f4H25WdSnmy3ORLLEU+EZB0a4AQslxTIYFhguwd3hSTTzHdKga0cLyijVgEA5KtaY99XycZIMVkYF7sTJxqnGkODHyf18f24G7AeKWRD4NNUXQdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395695; c=relaxed/simple;
	bh=snRoL70ooWR2ZhTkTvoKCAS7KxtDTIY5Prj5eGhwy1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+k7xNtqKaM+PyXsa97bcjdC2pZQpIoY88oAbAk+3lxXIV/aFdvNo+XVlIQAhBtmCsLOn83QNjmDaL4zUX0ZljcYoVUfte1gmRnR8BrzODUX+uJkYEUBYn3vYBb8MRPUuk9X3K5XKnPYLpswhq4uUWFWFIz4k/HCWqyhJiVPnxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXnb4hZ4; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXnb4hZ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbAwJe2hi5zGeS/iddyzDjFrvl1XtFlC8bd1/sfN93cvLAPycUdY5lwLo543XtnAb0itMO0X7IJcWAZIxWyoBgRuJtRy2V0dZxNTRdGBMUsMKGUzHxFjtvxFzg254aHVnlOACICaAaC9XWKan9q1v2klqAqYmzRNrWFwecqDvKfm6BxcepNgHgtvJB+skU1acTSG/sEZXUIhfxTGwf5O+psfhaurDRx/HydDwgJDOV4u3XVea4opgyeHIPfEn9BgCRNSqefigV6PnQfisM57BPCDKCVZKwdwI1Lk0HsOaJooqb1o44PBOJVMOYj+w40aqTE//Ia/tT1J4xfTTe5Wtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz9LFpVSBDmQQM6m97pEcPTv5QBlbG4U+sjXAe9f4tQ=;
 b=hrRkiwEz6l4YbcY1uT4mxpkvmQVPZ2ye9EXcHoHcktLZp0oWuv5edefAjVUrEpMIcfsHGv4/Xw+hNGsyZ7JO3zYCsfgJFSyxaGPwz1IsljQ6K+GUsTMxDTcLuEVCnUfWJ/ImYByX9oL2h5SdTgyMyY6CNnfIcH6KgBoGuU9AZ0GyCamVoJ43HkFvhqjTN1piTtxMokyoSbEmnKKpGEmYeMJZCBN9lIXxG5SF2twpeAxWFUnEDuwJ48LnQz425be3HGGjOsAWGT/i5/32cS4wtPIppD959EYZZOLlwjhDlKcX4JlfBn87bQVp0ioB51Z6sw5a2s6/DEaAXRWq5lxlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz9LFpVSBDmQQM6m97pEcPTv5QBlbG4U+sjXAe9f4tQ=;
 b=YXnb4hZ4Cnyqoxjo5eTpNw3dVDnmWWnT8x8g8hB7jPi4XwJqWeOle8OdTyvRSC/abd1EAyayFuLsshlRz9fdcNd8rDz6iLD2aJs7Nw1BtEpQOEaim/aVrdjqFrg7rXniS2nHCtOCWZDRiw3uejI6ZN2u6BoSTByS6LgNzlyulxfJhJWUyjvFGn+irK54/m0iSZuq8ERTT4fyjOPRDpwrwKWME5VpFA0IYxitP232fercfcsXqC8OzAhyChS5AQ3XcCFxD5hOGCxz5vjU8OVOU9fabIBo5tWKJb3pEXRt4V9l0g1gnXi6TbV+zR4iYjaXFJyudcaEY7bqhVKC1+U/fQ==
Received: from SJ0PR13CA0192.namprd13.prod.outlook.com (2603:10b6:a03:2c3::17)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 20:34:48 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::85) by SJ0PR13CA0192.outlook.office365.com
 (2603:10b6:a03:2c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.6 via Frontend Transport; Thu, 21
 May 2026 20:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 20:34:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 13:34:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 13:34:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 13:34:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v6 1/3] PCI: Add pci_ats_required() for CXL.cache capable devices
Date: Thu, 21 May 2026 13:34:20 -0700
Message-ID: <05044d2113e20d81f96677ba53605311662b6b10.1779392420.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e6b24d-789e-444e-205e-08deb7786600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|18002099003|56012099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	bVdGijgXRJTcwj4E1cnyNB9O0Ast5Tt8llh5/9XelTyzEustUAqawiTcrX36UjxdGFWQdi4lK6KDaGzyOlxtA/MbBpS5uPo0dQ9XJmOclnSwDq+V8LIKHP8EZk0HpNESVjHPMiPAno6A6X0AuntYL9S13NpHe+20SCnTYVShNcTggAjuKEex94pwTcx/5Dg66i3sv6VcPBDVtOrTiKhQ9txbRV14iEhLJ2Yj02KR5eW0gnMdgEhW6aKaB3baQLNz3VU+nfOzAzyWos3FKrzIhxm+3P3s4oZ8fMxnS6/v8H0x9QPk4tgGwly26TVVxdpczucmqY1QgxVl++G2MBZJqIXKawkS79XqusSg5zpL86ePNZS3laHnigEEvfsx+z18U0Eh8EFDmAAwa09GGU8m+O6MFrup3cUgwmwAM9X9/VTnkc3w96eAmuVIl/FhOn2N9+4BBvWL2A+LJFXXjV4iKOXAxQTBIb9eKdYjkdTwmnxcnz9UlO7YfoqBNxg9GyKfAe45rWRXq2sXgqvEDbj6tarROhuk7TeeQU6lBZ3NYL7nFymjm+WX1ARd+S312R6di7lUtOmvWXQmc4awJZulBZOnhPiNxJKy+EhrDjNumyjnyMTPbccxZ0PuEZ24a3fAE4zY2QZV4hBGqHFvj2lSitAaq/m+pVjygOjkDY4Ho2UB5GkQ4e/r583x8V04qf8SX0qosGRztRNXSpXxIZtUXmOmVT1myRaHP0MXvyP4NFA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	feOjQsnWVmN4IKPAPhEMeSIPN9k/U2ePlow6qWoUzmcYI3+McC4tkUlx1onLCik98chMx3tt7dUE2EeZGBgjFrmoXmqWNrnYiG+fSknr0gQ3iVU+4cT2z2OI9hwMxZjLn3lVUfHmnOVxKedirluBwRgFT2NZVq+xWswzGrIO+m/eZOzJ5zk9YCOIBDHqCb94Nx78Y3XaHm6YPT6E+3hPncJdhxV6MVP99lm66/FiVoswZsl6Em7spnQunae57k1bXx9ZX9Ji1fHbEqELjIxjW5+Gxe9O+9eM/71fgKFoC0tksG0iLvvmy/W/y5/VAx3D/sb9dp+OA6vcED1ywLOFIyH6IDASbYOROvx8aGOiBZERBvyuPSBytVfxXT/VfBS7SK/mpfOnqLFLRwLCXBDk5oW615HNnk9d5Y8S3bkUIQ6tXiGgiR71STudwSHhiQ63
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:34:46.8275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e6b24d-789e-444e-205e-08deb7786600
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

Controlled by IOMMU drivers, ATS can be enabled "on demand", when a given
PASID on a device is attached to an I/O page table. This is working, even
when a device has no translation on its RID (i.e., RID is IOMMU bypassed).

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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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
index ec6c8dbdc5e9c..84cd06d74fc9c 100644
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
+	if (!pci_ats_supported(pdev))
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

