Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012055.outbound.protection.outlook.com [40.93.195.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E663491C4;
	Wed, 20 May 2026 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306413; cv=fail; b=MO3na4tBCyr453P/6xLDyeBJz42ZfECCUQtiEdht5rL370woRjZoc8ey8U0YYhHhwKA2p1ebUkNmkw2AOYU0bGcacF4t9xG1KmBQ4Zfql0/3u5edc488gcLzQ8kvAOIHPLdZp+YEHCBdjJO9723fKlUKzmQ31vzRr/EOX1ppXs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306413; c=relaxed/simple;
	bh=0/PMEQWN0eLBGu61a6ZW/7XDzurB+CxrM9qEiMUwScQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CuN4qaT7nGrBpRP8ZRArm/9QFx8wxMEqjJSTz6PwIimKx1LSkV8Fn3h5OeuWKOfwXyYMhWnaEmeXLGhLMZOfo+8o07PAkaJlQeNBL4lwDlSDcN6vVyoUgy90Qf8zdKSJRqqyivupZYlZnXcM7HdhPEA8XpgwIs8v0tZ6EjZusiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p+EYhrWe; arc=fail smtp.client-ip=40.93.195.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p+EYhrWe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpHqFu5zMEdg8RY7q8l+NrYJQZG+qw7Vt/knmEZyo10bLgkYza5RAAkcgrJMrJJmbhKTXJCZ+jBbz1YeZgunuhxbNtMjfc1zrEdYJgqw3oQfPENv4/tq1YmzNWyNdY5uzR8pf7ycvdn7wK5QcBBFSuXqAb8/Tdh4nzyDnlgXb+uEps5QLALXWYa8FfcSaGI1v9yc/JUKFgnnYsqK7IsZwJQA3bLyTOUzlQszw2bRhx8Yd9v31m3YHnCqfQTDAFYQM30ACR4kuJSWJ7TdjpUcRdbaZzifKBujGZxG8UPayOaieq/06iQpvkbJMJ5AqucCw/msj9FFpe1qg/j/ahCbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU8roB9Btx1oipMfmJ5YL6GLogOdWFl9u4w/7Bbrpvk=;
 b=InzAMtlTj73GIgyM6SDIYA8+Wr3Rb5zYM4u0g78VabAqkHQeKMaJDjwdwWHxefyeyM0DUySJBI/BYYXlEbH4ZHhtkIsI1bz1/nGrNHPWYH02jByOMnTynZ/ilt7VhXJLXXA2U6dLLT/xIv6xHUZmLjvodnygr1WY45eL3+OJYcAQzIJGOqHMO1/DUP1nLcHMMgziqGdIWiKxnkVPWdp0dPAEWnFcvfio7GJpx/plkPXcKDU5ekNsfASE//EaQ03ZM5yyawNOJBrX4z6+nrXcKqc+tVBjBoeaEjD0JWYRTYOKRJUxsD66G9ei5iHt018ayjZRZ+L5k/KHxpNKJr2SVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU8roB9Btx1oipMfmJ5YL6GLogOdWFl9u4w/7Bbrpvk=;
 b=p+EYhrWelcfSf2rt533z/5gs6mICA+3z7k+SWom0ajqlRLVzZaxcZX2XmRbc619C9XL0OoJK9lW3iV3Z50IokR2j2HutD1cgngmNykw1hYTzG1E+KphHqgE3cEZow8UuuG5vD3D/VOIIF7Co5zG+bZbvWelujQlTJBfbHBcKXu2Ont2EPvhRkEr2vYl6DIUtw+EppaeKbCxxAWpEg3CB5xMukt4M/YvNUM/soKUhD0Qj14Tulc0epq3gYcqX/F28e4Eflz4S1LhdxC0QT1I4HrJOds0vQQUPZABWycOtWCcjYFP2C/a2IG5yQCl71ZUUh6vQU0MP2r1i9MWcMhDhMQ==
Received: from SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 19:46:42 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::94) by SJ0PR03CA0035.outlook.office365.com
 (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 19:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 19:46:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:46:23 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 12:46:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 12:46:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <joro@8bytes.org>,
	<bhelgaas@google.com>
CC: <robin.murphy@arm.com>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v5 0/3] Allow ATS to be always on for certain ATS-capable devices
Date: Wed, 20 May 2026 12:46:07 -0700
Message-ID: <cover.1779304390.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: a8159fcd-d566-4c2d-76cf-08deb6a883b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|6133799003|13003099007|56012099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Tdo6jbkL4+Zts4ORpV/bF/iQ0Fve1c89MdDCich6IrJ8HYFC+u3ePxWkNYy6EWYO1946mKtZ4sxjAqbv9feoEtksxPNsvaD0EshgVQJjUKfpcYouuheIhRZkWZ5i3mZbZ4+J5IXm6HiVNTeL40rORbKi+mOvqZSRXFMq1/t8oFAiSmp2yOlpqiBfAJ5eAkB+1RnvL4qxfHq/TXpubxcsZ8NAFf9WqkbwocrNKjeXMD9yKPFR5cTiExUKYffZjjQorKIm4UW/0AW7di0PpEOvu6zPyU256h7KIqRk91hgx82mhR7uLkB8nbhluHedkNLDoCTckgKYBY7uU11vJsNgpZ3/P135MbU2jeKFcMZOjOfEIstEYIK0/ZxtaikrKVZy5byXgW2S0pd6yNE/WNQ2mw3YXkfCzNi2AkfhlVCAlYaLD/TBFq86fC3+mQVPBl8XvOb+cfjBNbcIjumsvOoc5zrUOxRbzRuYDjhSjdDOhrLSVEodlSKS47uS2uANbDvDMAcmwytrhmnNr3s44qnkFAz9Oft6XXlgFKo1COJulmccv+MuMONbL+5ol8QUfjNIvXLHpEG07JTow9DmZhGpQWsmXm7kYLgPovpRGRayFwdiLY4rgboueKgYX74IQNGKxn9fzSxhU1L1khPOaNbsgr8jEWV4rgXn773ZNKc/9j6ShelAg73WDAIiwXAngLjvmPgYGgTUGwVjRFi4z5e3rxDdq+ZZf3RAntehOUzjS3M=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(13003099007)(56012099003)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lD042QoshrDXVfdwo+fJz2cXTfpZK2ZqQIwojXff9Fd+4gv055p4OJ3P2OnXw86LUk6xIylXnO1bfl78C5XqbkA3Nqo2UuLh/vz5KwDwLbU4Vhjve8rJ536e9fde1UuUPwAl7wbttyRp50kWSI/i8YjnMEOggKPuc3vrBjXMlKEpGn8OQBzXHfXi930oUMe/ONa77VfvdZNhEHpTir7YVRdlh+9pZaFv5ak6O6PdzMBJ4xj/zI388HhI2M0onzUsS23LE1EC9J6Qk44gyiyFUpBlVaCuFgSiQWSnkJCJe3Ks5CSi/GHmEqVK/apQM4aAQ45HY6nLhwhSiZYLnR5wUDAyP56LlzyecR/RiEqlK2TXBcNKsnAXo45dICUk2vvWjCUKbo2YTLlABC9+t91BTTcEFucA8yR+6zhrR3k8D/B/iRqDOVHqeKSVvLXV+Auh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:46:41.1955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8159fcd-d566-4c2d-76cf-08deb6a883b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455

PCI ATS function is controlled by the IOMMU driver calling pci_enable_ats()
and pci_disable_ats() helpers. In general, IOMMU driver only enables ATS
when a translation channel is enabled on a PASID, typically for an SVA use
case. When a device's RID is IOMMU bypassed and its PASIDs are not running
SVA use case, ATS is always disabled.

However, certain PCIe devices require non-PASID ATS on the RID, even if the
RID is IOMMU bypassed. E.g. CXL.cache capability requires ATS to access the
physical memory; some pre-CXL NVIDIA GPUs also require the ATS to be always
on even when their RIDs are IOMMU bypassed.

Provide a helper function to detect CXL.cache capability and scan through a
pre-CXL device ID list.

As the initial use case, call the helper in ARM SMMUv3 driver and adapt the
driver accordingly with a per-device ats_always_on flag.

This is on Github:
https://github.com/nicolinc/iommufd/commits/pci_ats_always_on-v5

Changelog
v5
 * Add Reviewed-by from Dave
 * Update comments in pci helpers
 * s/pci_ats_always_on/pci_ats_required
 * s/pci_cxl_ats_always_on/pci_cxl_ats_required
 * s/pci_dev_specific_ats_always_on/pci_dev_specific_ats_required
v4
 https://lore.kernel.org/all/cover.1777269009.git.nicolinc@nvidia.com/
 * Rebase on v7.1-rc1
 * Added Reviewed/Tested/Acked-by lines
 * Update commit messages and inline comments
 * [pci-quirks] Add range-based scan for NVIDIA GPUs
 * [smmu] Add missing arm_smmu_remove_master() in error path
 * [pci-ats] Don't init "cap=0"; check pci_read_config_word error
v3
 https://lore.kernel.org/all/cover.1772833963.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Jonathan
 * Update function kdocs of PCI APIs
 * Simplify boolean return/variable computations
v2
 https://lore.kernel.org/all/cover.1771886695.git.nicolinc@nvidia.com/
 * s/non-CXL/pre-CXL
 * Rebase on v7.0-rc1
 * Update inline comments and commit message
 * Add WARN_ON back at !ptr in arm_smmu_clear_cd()
 * Add NVIDIA CX10 Family NVlink-C2C to the pre-CXL list
 * Do not add boolean parameter to arm_smmu_attach_dev_ste()
v1
 https://lore.kernel.org/all/cover.1768624180.git.nicolinc@nvidia.com/

Nicolin Chen (3):
  PCI: Add pci_ats_required() for CXL.cache capable devices
  PCI: Allow ATS to be always on for pre-CXL devices
  iommu/arm-smmu-v3: Allow ATS to be always on

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/pci/pci.h                           |  9 +++
 include/linux/pci-ats.h                     |  3 +
 include/uapi/linux/pci_regs.h               |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 75 ++++++++++++++++++---
 drivers/pci/ats.c                           | 47 +++++++++++++
 drivers/pci/quirks.c                        | 42 ++++++++++++
 7 files changed, 170 insertions(+), 8 deletions(-)

-- 
2.43.0

