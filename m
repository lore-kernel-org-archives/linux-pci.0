Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607A37FF4E;
	Fri,  6 Mar 2026 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840511; cv=fail; b=rBSrwbu5s8rGjB3QSKWWK/G4kCiT9qQe0cNGnn2lSy3kuJWdi+mKbVWLbXfTC4caXR6+5DKGsGNEBRZaGIKSteSPQCqviAlXUlIIEkYmKJ5eOKO1IJUiRu0I3TeioPpc++lcXMnugvkIFUNqVZCznigx02zgKMzp73+1hZBYTPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840511; c=relaxed/simple;
	bh=1+xrgCqNdS/m/aqeKY2wh0x+sqrQUNK/22MY9/20ZZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W3wfEPqwjToFG7fomphKWnAbS67IQ92dpzxDqZV7j9Ia0kU/bHdIlTUF0y3h0C36FQqGcyIyF2LEgHThna0SgQxOW6+3e53/5lw9zHdgNgYogLh8+OuJWIyMHN1TM6zyBaFeM5ZIba8eir9XCToBc14eeFdjCefA1at/EWXSX7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lGcQM34o; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lGcQM34o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+2U4Peg6Ca5ZLgbiAzD8J2k4YmO04WW0inscTAi3VeiD3n3pIcO9gxq/W+Oge4Jzel60yp9beCa3ZlFsZOKKZGcaKHB2XtBW8hjFnrRLsyJiggjISp+3TvPxfKaLLVlpj5TY09dPfeHo1Fs8+/FShEFFWeFs/qNnOcmSHoAX14kF2ukd8s1RCwMVuCDdmuF23rySX03cq9gCC8jsnsp+fAWMWLEC2R3yPzcgTctT0n3qI8++pCcB8nHC5yyUEzQ2NRTGWB8YgZMQ660xpKhfy0iaUyEo9TSwE5ZNT1DUCrR1rrmmm9bRao1ffT51MBblcZo5vyfZmIcpdJv7RJTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drD9iy059FvAxq2To67xM6p42IxBU+TKlcqHIps6R90=;
 b=UKFuqjYKipxwyHGlDTluZ+939AetSgbL8JyAFJ+qyMi/blETP+zJK9v/TNQdY6t7BQObpvdwdFXJC8cTitqnFIzHMEM8j2fBjQC+9hoK9G1i9+72IIZSmFoCF8yBEV3p7myfCLrHxqYPFkdH6xfTbH2VqNye/K0krynqIfWQCoDJxjJPZ6mDYAovseHfKc/yxZt2crcYiZZtTQSlxw5D0zaubNX3kqPZEHGsjS70dR6wBs/ardigVuPqS8DUR/TWyl9U2C6upwIWGhJh4j014CWxsOuHFUEkF/pwtWu3txE35UVYiS96F82hx+MHU2IQbPPNeibxHY+ERa+ZWEhQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drD9iy059FvAxq2To67xM6p42IxBU+TKlcqHIps6R90=;
 b=lGcQM34oCGeiD3lhulLmQao5nqZp8FV4zEi2ERhYpywFsy1GU8d1jmunCK8Fm+Lp7W8HI0Y0KZ/ZcwqfeIGyyHcEKmQ/vGpAgVx48hQacouqnh/m/8RM5cDovQPGXZAyqaeUxyN1TN20WwyHTZams7XBpFHSw2U0EETVNjhsLbqX5Cy0hH7U9L+lyGd0RZoh81eFUQl8s+z8sTgIinklfmTEN9kvMdormexbH9GNbgIF3aFPjhUYxWutNAztGSNH5RAftiO+P6JyPQckOl0ONlqfFiPAtbXbNbfWQvXLbfNNPslAgmMJNQwxjYfWSR05MjBoWO+Ik4MaudUKws5HcA==
Received: from SJ0PR05CA0151.namprd05.prod.outlook.com (2603:10b6:a03:339::6)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 23:41:43 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::46) by SJ0PR05CA0151.outlook.office365.com
 (2603:10b6:a03:339::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 23:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 23:41:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 15:41:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 15:41:31 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 15:41:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v3 0/3] Allow ATS to be always on for certain ATS-capable devices
Date: Fri, 6 Mar 2026 15:41:14 -0800
Message-ID: <cover.1772833963.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 311f9635-82e5-40ba-77e4-08de7bd9ebcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	/rbEydLWaJu8dORRbWBiozzwudk3MAMmicWswF6cht63Aa6yb7P3LrINfyIjgVRqN8x1/O6pdv/Vk7yv/iJMbQMzbyLB2zMg/Ge/OACRLF/RK5mAsLxoAQMysLozha5p1ZTRi6WgkzbyjRSZyvR6tGyuKsu+c5qLzHoPHWdEfg3gLtydoKS5LetRDxVBJrY0puBEL1Ze0p5IXZpsMo5cmFfFq52B/4Unso31CVgKAnFMixlrJQlcYloDN8cwu/3cyfaTL0ndDpYgnqee/Ct5Pq+n3vVBJzmxRbrt5KEh7roXmscSF032T4bRcjJAI1XPlGPFvvLXD3NQfzX/P4/wA9650Q7M5MJuIKRR6wvJ4mhKHm58T5UtXhtQxihBTA0tXGiQW2btTRzl2zGl1E1ojSlkLI8aArFPBnbUSeIlxnnECbWI3UGi4e/8e7JXokg8kkNjKZICbKHWq6IF/iPomxVxfd6NvuOGeVUjdw6MLJ1G/TeUOFjQVLrIDADPSzaX9WwVn/fKSdHM4kqGyN9xPUiV6uyIidoaq+X8yMk8QczdqDCtu/rWtskKsxnSJ3wmS/TIcSfi2nW/FnBup37Y/ONwmZK2DqXqM9r0jGpzGD6N/TwfRHTGrrrjgqJD/3AZ5aEnhwXTupfMu6fIdbPk8oj2sFLavkIa34ARAWfmVdfCIZhx4L558wjFRqe8t1fQxMR3bi1qYgtQXNrYtEPKrzL0Q36wrrBYWBPqEI8K7I1iZAEXq0NYeqIQsRVPh3OXMGFvAjPDKyhNh93sXYS++w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	37m3SD825Pc08hTfVZr2Rxuqu/8dGlapxqLUk2RX1ZfLgAkEYkcfzpe05sbDgWpbXEy2MvaHKwMaLbGOmA3nc6tLG/8ngXL3zQu6O/c/GOzX26ZU8dqOCTgb0OumFvYhFQR6j1TdzH3I+4wvZIBBSRbjmJX11SUhtzKJMNT+r2ds7OcGwl5pIa+lipzb+zvHpgd6O9KVRE0yPHnOp5GkAlwQRINVwrwf6ekJkwakS2RZowOEutKTDutwMXCcZBsOkzpU0yd2RC09SD7KTjGGZbCh/qKxPtumhAgzlnrd8THvPJZV/h/yvix9cb2A+JlznLrYHvRza7BFLcByjxDhaPlcUmo/q/N74TRpEt4KcmaLKHLY/EK/oWhkr709SXmxRVWPyR17IV4pjgWE1QOIGom+dthMoWHKPkSBBanKM/OckFZODz6FywnieS3CufyH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:41:42.7135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311f9635-82e5-40ba-77e4-08de7bd9ebcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032

PCI ATS function is controlled by IOMMU driver calling pci_enable_ats() and
pci_disable_ats() helpers. In general, IOMMU driver only enables ATS, when
a translation channel is enabled on a PASID, typically for an SVA use case.
When a device's RID is IOMMU bypassed and there is no active PASID running
SVA use case, ATS is always disabled.

However, certain PCIe devices require non-PASID ATS on its RID, even if the
RID is IOMMU bypassed. E.g. CXL.cache capability requires ATS to access the
physical memory; some pre-CXL NVIDIA GPUs also require the ATS to be always
on even when their RIDs are IOMMU bypassed.

Provide a helper function to detect CXL.cache capability and scan through a
pre-CXL device ID list.

As the initial use case, call the helper in ARM SMMUv3 driver and adapt the
driver accordingly with a per-device ats_always_on flag.

This is on Github:
https://github.com/nicolinc/iommufd/commits/pci_ats_always_on-v3/

Changelog
v3
 * Add Reviewed-by from Jonathan
 * Update function kdocs of PCI APIs
 * Simplify boolean return/variable computations
v2
 * s/non-CXL/pre-CXL
 * Rebase on v7.0-rc1
 * Update inline comments and commit message
 * Add WARN_ON back at !ptr in arm_smmu_clear_cd()
 * Add NVIDIA CX10 Family NVlink-C2C to the pre-CXL list
 * Do not add boolean parameter to arm_smmu_attach_dev_ste()
v1
 https://lore.kernel.org/all/cover.1768624180.git.nicolinc@nvidia.com/

Nicolin Chen (3):
  PCI: Allow ATS to be always on for CXL.cache capable devices
  PCI: Allow ATS to be always on for pre-CXL devices
  iommu/arm-smmu-v3: Allow ATS to be always on

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/pci/pci.h                           |  9 +++
 include/linux/pci-ats.h                     |  3 +
 include/uapi/linux/pci_regs.h               |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72 ++++++++++++++++++---
 drivers/pci/ats.c                           | 43 ++++++++++++
 drivers/pci/quirks.c                        | 26 ++++++++
 7 files changed, 147 insertions(+), 8 deletions(-)

-- 
2.43.0

