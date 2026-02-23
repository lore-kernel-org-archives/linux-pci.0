Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D0D37C0FD;
	Mon, 23 Feb 2026 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887178; cv=fail; b=gHSP5/3Cbf4NDc+BM7g+69ypEjBm136rHpGlhOfOgWsBptjK5Xq9Td4ldjsT0fRYmV7TWZZCbMG0JbPtTANsE+zY3+CN3CqKs7xlswZj1jLt1/fdFDtcc3VMqS9xxCfJg2IUXg6iqKJ2czTzMlIVCN8yR06HHmxQSZJaLrgA8JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887178; c=relaxed/simple;
	bh=kpyZQI+JlBYhyZlwWloJ4rT5wpS8Rj1gPYFTLOtvqGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVQnJD/WpaaPZMRxOe4yIRp9iGdXOZ5Iq+Bkujya9q9f7eWwI7Cl2JEsfxP+cynVUtKgGY4lXs9azFF3ZJv+c5L3JNpSZhe1Scv8Hns5PUAgG0Zrv2aA7HvHrzJl13mXkFejdmz/uI22lgeW8rArFHLFpc/XHYw1pbZur/5IZpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hMcSQZpV; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hMcSQZpV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4EJKH4U+t8i94ghQ9cS9mGBuFzLNG813G73meHnIiCzImk6IBV3YUw7ExW4Zq1LyHibuWGUKobgU9wxXFwElrmfG24J1XrPNvzj+ltTfpf/jvz1r4JtsYnp451ngzsTeoN4k7OFdDYsHIA6lOFF3gidxAWec1poVuGOPfW22bs1/ke5JUlIrtffRs910xhUqdC/0EMFpuHF6iXJmIYek+1lWX+Jbo2N1zig91lFaD7sKy07wUZ7bH8XfxFsyXvmSOGoh+83aywSaYQjnvFw+dOBoZrFlUdmdzrTxuZC7FvOrJN1k4pgifc60SDuFj5rrLp+klFTQDsRhQCIQANfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM4Frsuy4gguoA23vhkJu1f3NVTIVsRcAV2LqYT16mo=;
 b=Vbb5fu49xxPXytT/6sDMtY1j3/wGYmF1T8iPyBn56lgV17Q6XoX7MFEith0w1JA4ZjwzmpspvsjP9yjqW3sjqiXnd/VO9q1f3c5lIuKF66IqaBcoKhv2aVSrdCdns0d6HLsqcqMRZB99X+6JxARyavGU12E1qQxUXv3gp/ZDowJi1+zT/9pfEDAMF58p/fgdWEr8SnA9/+x5FJWFZSGYLqkP0e1dLg3TBILAfg2Xn21zzUvbdUlJDzTlgU27JIlspijlpPXBdE8tx+uV35lyUckR/QtIyBqL6mRqQxhFHWGGDKEK2N3g95x7U3l9rvEc519LUradMfG3UDpiN891Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM4Frsuy4gguoA23vhkJu1f3NVTIVsRcAV2LqYT16mo=;
 b=hMcSQZpVG9S9zM95iVc+t+Qb+b3yQmzNzIbwkzVRd7uG4pHcXaoGhp5tRyCn5tOqd7TLykzHrHW4LAM6hSUvoFnKp8lGuCSuO+1RIEB2c7v+IXMHNTxhjepKEeHEIJHTMvlpIYFjxxP6EQtDPy2/6FEvKRajIsJShuYIhCqHUAN5M+GgVzZQkCutInP/z43VRWO88DaCRtiwjxYZLQvTyuEJmkB8GMxhZ/zmvTO0obchrLGyuUOhKCNF4i06q1t8EAtkBJY3aW/bfmYGB14l3TQ/JPMQ/c+Zl/lPNzJiXOZZMZTO8xZ0URd56MQRBWhvLXHSQPdjzy4VmtwrUezlZA==
Received: from MN2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:208:239::18)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 22:52:49 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::f7) by MN2PR08CA0013.outlook.office365.com
 (2603:10b6:208:239::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 22:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 22:52:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 14:52:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 14:52:29 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 14:52:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 1/3] PCI: Allow ATS to be always on for CXL.cache capable devices
Date: Mon, 23 Feb 2026 14:52:20 -0800
Message-ID: <ad4efe2f85958ee1ab0673a1ceb0db5141852732.1771886695.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771886695.git.nicolinc@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: febd17d4-f2b6-4e91-a4e6-08de732e44ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v3TpMRRm+LQPYnJYt62XcoBR0V3qGjp/grnZHPh/MiqTZpIqwZRC4/Q8dhGa?=
 =?us-ascii?Q?PS1dKttSr9QyxMZdxSNH4+T33iwHrNryWKDIH0XEAwAYRrGSezx6nvoqBYnJ?=
 =?us-ascii?Q?af3kEFftcRmRklZnLX+Wlb8Mwdvph2s4sGB2033Ff1Q1zqFCf0/yhfmGEquy?=
 =?us-ascii?Q?9Pn+FO2B1JskCI4sxsQpl99rDTQrYwinAO2Kkf1PETrMH73jt5VQP5ArDruz?=
 =?us-ascii?Q?mnH7FdUOqhnV48oifR5gP5/khSkU6TZoJcL8mw3AlnoHPuAcY6zLXZWp5X2U?=
 =?us-ascii?Q?fzSc1F2Y0l/VeGdcn8Pm5xa64QtM3vAo+cJ1oReZ6d1/LAzBnu6rdoH+nrpV?=
 =?us-ascii?Q?KT0tOt5tPV8LMmpmjqKfv21qiydYfl1WMTJi7lU0ZMxfrRX0o8NP7vMwvfs6?=
 =?us-ascii?Q?ERDAr4AAyDqGudxTB8VORX0AuVYk3mWrs5yJJrn8htWx35bRYy9s2SAx7JE1?=
 =?us-ascii?Q?6NhHM199NGIxdnBPkdLY1opiqHEFLaFpwodiQS4c09NTBHlMPk1CpBnTKzOk?=
 =?us-ascii?Q?DdRUv27Mirr8242KJ1Kk+64dnX97aZNuFy0XCgQ31HSgPNgr6Gxzwq179hOb?=
 =?us-ascii?Q?OVsIR2xiRuveEgrAIVEkS++ljbyjF42URperg3mmnZfgwEshEh4EuPoisb6h?=
 =?us-ascii?Q?vw3xJErcgd+WYIY/yhZ6OburNZLIFV1YHy114UbMbT5dumRo6SZ6xTOiS+/8?=
 =?us-ascii?Q?9zVzun4CmYfMb2FC2WTmhtQRSya5b+mLA59Z3eroDrqwaHu4u3mn2bKf8iIZ?=
 =?us-ascii?Q?qha5ykZYW3Z+y/Hs7L19KSUyzlIwPbb8fV1c/hN9p1nCfG4ISN2+gO2T4xoU?=
 =?us-ascii?Q?dish0xJ6FZf2bZJjRLCucPPEGbrstPYXFJ52Ysmkuek/bkvraOUta+L3HFW3?=
 =?us-ascii?Q?YCnno5pTJGE7kVM74ukVI9rLLwLahXUXgDIGkt+R/MKgeebY0qPF2Z5m+E/N?=
 =?us-ascii?Q?4vM9gmCTZY4QNNtA8dYHNmxW6n1I7aJGonVuWTb7ne4YU8xXzMoialbJwrsC?=
 =?us-ascii?Q?8gb1A4nzEDA4+54fMW51W43Xpls9uCquPRErocabyfH4YbL2nRruKm3GOr5n?=
 =?us-ascii?Q?ulZpwGSfNLh2/cQuR05Lsi2VgsbOTi+By91nd5IlQkKsvZnW9d1Q7GqNtSQ/?=
 =?us-ascii?Q?SyuI9TqfNHovxRLaZpw6SH0I8X4pOptWe3uVJUyuc2jmvKyTjaxPpyb07dJK?=
 =?us-ascii?Q?QRpWQkVMLZNYG0RJuTBF1ppwHJRysqqGMin/syl20bZpJCBX6xeMTc9pYyyR?=
 =?us-ascii?Q?tGK8s6wkJj4a79KxtuCghl04j2Y5qK8eohuOOTumgX093talP9G+hUhvZBiC?=
 =?us-ascii?Q?+pzgOV79VVXeSz6fjoePPeU12QXPF4R2Cr5iXYHY1iuVbOKTFY/mvZygC9Ha?=
 =?us-ascii?Q?ypyWuno24qqA02YoNJ4YPWbPNC6MsGKlsBhokrIAeRDwSxW1nNbXxsjUvXxa?=
 =?us-ascii?Q?ce9+ojVK1HWXR3P+JGEvgiL2kXhewF1SV0W34fevqN7KBO5G9dA4OIh9H4/J?=
 =?us-ascii?Q?9ph7esfTpqrO+kHmkJv5JrlvKNhVlAwapGA7a89AZzawbsJ98jgeFX0SaKBu?=
 =?us-ascii?Q?GUfTuRMFgH0x6/aSIpAA7NdhyWHAGK1M5ocuRbPGi++URxbecuttfCVVctrs?=
 =?us-ascii?Q?PrJyWjfksXwoAEiDpvtaLKKLJaMW5iilD35PLQ/e0BmZT8qgRklSPZwU+Pgl?=
 =?us-ascii?Q?CfNyJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UJoOAcpa6cjxsly64wz2MezFGduScojRR2kgPwe7pJ7GdjJWNOc5zWALFy91BS/cTWGFempasIBxHePdOgl79yZ9Xlp0uBzccUG3vNQKjGw0Ny9mZPlJtCHJNMXS13Z9NfqfZ1qdGss2lK9rJeNSkDowVOju7aoJ+jLiZpl/qx4lW4Q2WLM1/OkDCZ+pXDcG882n83lOYIGozoPwnFEgAzgTEM2SoWn69qOIm/Ey/MoDqlUOI7vl6QAeAd8ayF9kW7FtF+H3yPa8HQBqdos3/bsJo1dtsvJWzZdrXPglW1D5hz52DZyBpwPLCnVCXocNjdFjDQdXfsurAjfnTnIZxX5WuaSk3YpqwK5CK9Eoqy3WcVeAOfDNUABqe9SwuGPPwoe+2lfPrBERrLkAU+P5/yRIEEqfTvtoao+6ewV1tYVyOlYDRCPkovBP+ASWEyjf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 22:52:49.1111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febd17d4-f2b6-4e91-a4e6-08de732e44ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
device requests a translation service from its associated IOMMU HW running
on the channel of a given PASID. This is working even when a device has no
translation on its RID (i.e., the RID is IOMMU bypassed).

However, certain PCIe devices require non-PASID ATS on their RID even when
the RID is IOMMU bypassed. Call this "always on".

For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
"To source requests on CXL.cache, devices need to get the Host Physical
Address (HPA) from the Host by means of an ATS request on CXL.io."

In other words, the CXL.cache capability requires ATS; otherwise, it can't
access host physical memory.

Introduce a new pci_ats_always_on() helper for the IOMMU driver to scan a
PCI device and shift ATS policies between "on demand" and "always on".

Add the support for CXL.cache devices first. Pre-CXL devices will be added
in quirks.c file.

Note that pci_ats_always_on() validates against pci_ats_supported(), so we
ensure that untrusted devices (e.g. external ports) will not be always on.
This maintains the existing ATS security policy regarding potential side-
channel attacks via ATS.

Suggested-by: Vikram Sethi <vsethi@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/pci-ats.h       |  3 +++
 include/uapi/linux/pci_regs.h |  1 +
 drivers/pci/ats.c             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 75c6c86cf09dc..d14ba727d38b3 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
+bool pci_ats_always_on(struct pci_dev *dev);
 #else /* CONFIG_PCI_ATS */
 static inline bool pci_ats_supported(struct pci_dev *d)
 { return false; }
@@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct pci_dev *d)
 { return -ENODEV; }
 static inline int pci_ats_page_aligned(struct pci_dev *dev)
 { return 0; }
+static inline bool pci_ats_always_on(struct pci_dev *dev)
+{ return false; }
 #endif /* CONFIG_PCI_ATS */
 
 #ifdef CONFIG_PCI_PRI
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ec1c54b5a3101..ef061c0313ce6 100644
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
index ec6c8dbdc5e9c..93060fdc0d3c0 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -205,6 +205,50 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
+ * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
+ * by means of an ATS request on CXL.io.
+ *
+ * In other world, CXL.cache devices cannot access physical memory without ATS.
+ */
+static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
+{
+	int offset;
+	u16 cap;
+
+	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   PCI_DVSEC_CXL_DEVICE);
+	if (!offset)
+		return false;
+
+	pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap);
+	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE)
+		return true;
+
+	return false;
+}
+
+/**
+ * pci_ats_always_on - Whether the PCI device requires ATS to be always enabled
+ * @pdev: the PCI device
+ *
+ * Returns true, if the PCI device requires non-PASID ATS function on an IOMMU
+ * bypassed configuration.
+ */
+bool pci_ats_always_on(struct pci_dev *pdev)
+{
+	if (pci_ats_disabled() || !pci_ats_supported(pdev))
+		return false;
+
+	/* A VF inherits its PF's requirement for ATS function */
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
+	return pci_cxl_ats_always_on(pdev);
+}
+EXPORT_SYMBOL_GPL(pci_ats_always_on);
+
 #ifdef CONFIG_PCI_PRI
 void pci_pri_init(struct pci_dev *pdev)
 {
-- 
2.43.0

