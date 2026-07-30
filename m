Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE03395266;
	Thu, 30 Jul 2026 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434673; cv=fail; b=fozqCwNVqRRgpM2XkmHlddjkCX4phR32k86LILCLYxZSeSI6ZYUXHHHjlS1K3ZkYCVLEaZZcdbS/aimaDuGR75lS5b2U75ftWMXpyEbI1Yv6GhHMhw+e3XxsT3zSzumjdJZbZ09Kz0Pm3KbnnKoYlj20WhnfmxRRXAkgt2ClO1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434673; c=relaxed/simple;
	bh=0kSY0vy1xfbcNjmWprkWhdmsxf39jblRHBio636ufgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oEZ5BzWHBuMmR3qB2ieNvr/Lbd+flW2SaaqwnaBpDkup0lAHbf6ezp2kXvbEeXOKKZH9MSvyhO+yMUlrpudnQqmQ5mM6sj7dg8NeR9lkjYO3gihlxGnCtywSWPncuBQKy5DLVv06zJRNEATSCrc4frQhZpI4kwVLfZEDvPsaaKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oUJyimEK; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUJyimEK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+FP7rBjbwYmOjr/8HTv3fae/MKzqjY0Rmx158dZzKU+3u/RJck0Lozio8n/NMIqhG4Gtzh4fkFOk90vqWrV/Y+JzMRlOyqvZgkrqqMSY9tSIwDuM5Ri850gUqKDrHVZ2eNzikv/0VZQrRUt9cJy1PBQlsQx/yvenGGscSuG1cFwiqIv3/a4ZOkrw7ezY59nG8lUxjNTz/RKyFyq5y9UcEB15bkDnHa862/rZc0DPBy/O4asXXJqNU+USpA5leAy0s1UsmlE2Gx6bwlLyqxjphBpRuRgIj60k0F9f5oSFNiCmPDlj6PCHE7Cmz6jMl+1OExD5hthkvd8rZl+Vswccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l22qprJ5TPuo5+9IwfvA61QUWhD7tAvrNO5BR1pLmZY=;
 b=Cp9P4PY6ZyD4GXZPwTgxZdCgn9sqRl386I337xVBIYfAM1Wg7T0SyaszXXBnRuyGOw8yEtjtVvrp/hfpE19YR9PHFvEwUB3VW/sglXRhP9gqsdZL04t4KePu7oX8GQjc6hPicOrgjkLoytCw/R/atePyZnLYdSgi4HX9L6wREFhvEwJelFWHgg2wjOvpxFWkBr7eijhUAjNRLhkf3t6kZuBqzXdEfmlICCH6ve0/pUI8BllBTF0fSzYSuAz0klio+i4V9XfMnUEVAg3tKV+mgrcAX2nguJPdpxaL6kti2hU0Ih6Ws9yfWBwTn/mxIa9PIUwcXr5gSRTgjLfbWeS9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l22qprJ5TPuo5+9IwfvA61QUWhD7tAvrNO5BR1pLmZY=;
 b=oUJyimEKWaVGwouB4n9a3ose80+6Ivcc6V+ljsfFXFiuLntJ3ei3gdEGfBvCEL8KB2lTn7JianTz05VcnZYnt0Pz/OkWpF1JY0QnIlyDILiWXtwUs5TqJctb6ES+Lqz7SyXUrMhhA6iEYseylZySPKgvdV8C45HQdbUlkOPR38pu5nhUffG3e2GHFsgwV90IMRL1HOsLhAOBm+PW8BaHRV/ISsqlZeygQ2Dm5a8POP/DW7pMJrLXe54rGBPOKacL4D1H4HxkkS8H8dGZgapG5RF5seVhxGBiAeP44odbYHpOvEbArzkY5BUGxM8YuSQHbTV/dzLlMxqOOQuyieQhaA==
Received: from CH0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:610:cc::13)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:04:27 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::9a) by CH0PR03CA0068.outlook.office365.com
 (2603:10b6:610:cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 18:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 18:04:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Jul
 2026 11:04:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 30 Jul 2026 11:04:07 -0700
Received: from inno-dell.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Jul 2026 11:04:00 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [PATCH v5 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Thu, 30 Jul 2026 21:03:46 +0300
Message-ID: <20260730180349.771719-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ba3e5f-15e9-4afc-9e6d-08deee64fef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|13003099007|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	+kRKrwEikhU/J07EjJITRLnkss1t8gatSk/B78dA38s5smPz6Va9gSOSm1OHfcH0svEaDMsNAPC79i76KmGZpjXsuQsoqhOLSR3FJbrvWjvqlVWb9Wl7s8gSExgwg/V39ujSt+PmetdSTM1zg8MAD4pRZ0aQl9ApUe9bF0aInD3R/5YlzocZSiPi7vXRIOJzOKCzHW9FhFJAtEOaUapLip70o8LiEujUPONvnSGMCQSRHNjz23toT5ICzOByZqOYJ5FBIPfoVYtOO6LTLM7JnGQxLeLRixUOHxixugpqDE6pj6lYsOfo72UPZD8yNnmJzBAbXkAJ9D2hV1CDHRWsbePspqHkL459v4iqF77vctCzFDMQ+e1i7/Nx+KudkXv7z8PNKpkU6K0TD8HsMmulUPgdhD8ZH0zKdJRdLgeCxFBzlagzHva/z2E1Qlpokc1DnWrE8RZGLmtB1jBK6ZRJgV5SL1EsBXbWHeiTJZeJp9J6Di/+oCw3XF8kkY7ncCyVCLpJrwSIwJI8XTYBSpeJT32mngQaiocsbJBOSAm/WH4ZaQVP1N4S19xeolrsCCuQdUVl7l6lfr8RM9GxeI1/uVZvlCZQel69n4ZZXuC3thDSYkS3zxZZdGCYXy++wIJmsjEdHNR8nt+5+mJUVjAsbpw+QRRjouLT0xFPQOEgCiA5jTr3aAAstdEI6WBWb87FQ5MJto3wCNnnhOluJWxf7g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nS28NR2gb3mJcLh1y3viWss8UgB053g1faY/2b/47jV0+xTAjThmW/TX5GO5BUWm5g8iJXJvs9GmGxL8p81K+7lle7uSwG3o0DmSqiGM4lwPIrFvvDJtuJPC5aKl0NoSJbHwmpGqnYxe+HHS2SVodM7OMC67FoRlubUjgR3yHCCs+Dwdu6T9wEl4vDcVfCChYafh0x0QL/f8e0aFpUjq6oUHHOEZXeMVH8FLxNoWL8yIsZIFiIFUJkD4dO+Cfpwprhb/h6kMq0K/m+U7YYAEgDyF47DISpeZ4SBlwI3lhbK2BkAG8V5UmymqmZ3Ox3N4PhIcplp5CSLdJzC2kprR41NvEPIFUwx3NX51uIqzjY0n2eYIttHi02DsQOlvGVtrET54YA5SKH07S4DX4jJSJcYPRVHAL1gdy3lL1I0cvWFoPM3FdSwbkL2FHyHWORf4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:04:27.3040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ba3e5f-15e9-4afc-9e6d-08deee64fef1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5

This is a follow-up to v4 [7]. This version extends the VF BAR API so
callers can consume decoded BAR information and walk logical BARs without
open-coding BAR attribute masks or configuration-space slot arithmetic.
This version is based on drm-rust-next.

This patch has been used in the Boot GSP with vGPU enabled series [6].

The patch defines an ExtCapability trait that associates an extended
capability ID with its register layout. The generic
ConfigSpace::find_ext_capability() finder locates the capability, bounds
it at the next capability or the end of extended configuration space,
and projects the ConfigSpace view to the requested layout. This lets the
existing I/O projection and access macros operate on capability registers.

ExtSriovRegs provides the SR-IOV register layout.
ConfigSpace::read_vf_bar() decodes a VF memory BAR into ExtSriovVfBar,
which exposes its address and 64-bit status, plus the configuration-space
slot of the next logical BAR. ExtSriovCapability remains as a convenience
alias.

Changes since v4:
- Replaced the separate is_vf_bar_64bit() and read_vf_bar64() helpers
  with read_vf_bar(), returning a decoded ExtSriovVfBar. (Zhi)
- Moved memory BAR attribute stripping into the PCI abstraction and used
  named PCI attribute definitions rather than an open-coded mask. (Zhi)
- Exposed the next logical BAR slot so callers can walk mixed 32-bit and
  64-bit VF BAR layouts without duplicating slot arithmetic. (Zhi)
- Updated the doctest and PCI exports for the decoded BAR API. (Zhi)

Changes since v3:
- Replaced the custom ExtCapability<T> I/O wrapper with the existing
  ConfigSpace view infrastructure. (Alex)
- Reused ExtCapability as a trait carrying the capability ID, and made
  ConfigSpace::find_ext_capability() generic over register layouts.
  (Alex)
- Removed public cast_sized() and unused find_next_ext_capability().
  (Alex)
- Kept capability construction in the generic finder and documented
  calculate_ext_cap_size(). (Alex)
- Used PCI_SRIOV_NUM_BARS rather than a literal VF BAR count.
  (Alex, Zhi)
- Added is_vf_bar_64bit() and made read_vf_bar64() reject BARs that are
  not 64-bit memory BARs. (Alex, Zhi)
- Kept indexed VF BAR helpers because the Nova user accesses fixed BAR
  slots rather than iterating over them. (Alex)
- Adapted the implementation and doctest to the current ConfigSpace I/O
  APIs. (Zhi)

Changes since RFC v2:
- Hardened calculate_ext_cap_size() against corrupt capability lists.
  (Zhi)
- Added // INVARIANT: comments at all ExtCapability construction sites
  (make_ext_capability and cast_sized). (Zhi)
- Added #[inline] to small forwarding methods (find, read_vf_bar64).
  (Zhi)

Changes since RFC:
- Rebased on io_projection branch, using Gary's Io/IoCapable traits.
  (Gary)
- ExtCapability implements Io and delegates IoCapable to ConfigSpace
  instead of duplicating config read/write logic. (Gary)
- Dropped the fallible I/O patch (now upstream in this tree). (Zhi)
- Added Rust helper for PCI_EXT_CAP_NEXT() macro. (Zhi)
- Replaced raw `as` casts with From conversions where possible. (Zhi)
- Renamed SriovRegs/SriovCapability to ExtSriovRegs/ExtSriovCapability.
  (Zhi)

[1] https://lore.kernel.org/rust-for-linux/20260409185254.3869808-1-zhiw@nvidia.com/
[2] https://lore.kernel.org/rust-for-linux/DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com/
[3] https://lore.kernel.org/rust-for-linux/DI2SL4G5INLY.2W1IFTR081ID3@nvidia.com/
[4] https://lore.kernel.org/rust-for-linux/20260225180449.1813833-1-zhiw@nvidia.com/
[5] https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel.org/
[6] https://lore.kernel.org/rust-for-linux/20260313165336.935771-1-zhiw@nvidia.com/
[7] https://lore.kernel.org/rust-for-linux/20260714165827.2937960-1-zhiw@nvidia.com/

Zhi Wang (1):
  rust: pci: add extended capability and SR-IOV support

 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 ++
 rust/kernel/pci/cap.rs | 251 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs


base-commit: 93b9511a3bba7f31d95502e5f912f0a476b0cf4a
-- 
2.53.0

