Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594334E3772;
	Tue, 14 Jul 2026 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048342; cv=fail; b=M1MQjicQnGgRnSaYbg5AceEmP6LOrj1RkdHjneiO1HvXfV6bGRYFRxD30VpMAyy35FBUcMJiaa/E1WyAsZWlRpfhLRUYZKHxpOrKnpRil3L/nOgppeKqty0sqrLPnkTYeVCds/xd+bLN6UKS6UxudHeUwnaVGPjfo5VU42GNvMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048342; c=relaxed/simple;
	bh=RmCIvSEZ740WYLpsUaIDYCsTsfQLUbunCX7zm1WjbpE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m26mnOsx8CcEaa1SqQAGcTC5Yy7ZPs2dVLhqG2xonkOY6pcEuewnlViLV80r8E5Zxnhx7S1khMby2BFhrZCgX9YQBpGmnaijkGuTEP2ryHqwl+cTOvVLNaZl2FckHugr52pGUq+zsSd5On2EhFmbwcJDCWPkSIEZR1JEzDYOQP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pg+tJa9Z; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pg+tJa9Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwD9GvHm0+zX6rb7YsRywHsiRiih/ToHXHeEkXHYmpqOYYXJn3vOlW/hZhraIgC2vgR1ZbEvH1ZKjJQU5W50U1yJCPxz/S2JBcWvSUnOp5IAi0bnIxsn0dgTfz3u7avY2tj9uMYtO2ge8sBI7G+Y4s03syCkVBf0V1VXNpZvmTejBJ+6Q+z+8GDSNyLqM071/aGlNt87t46AgbqqRI503qJbWcjRItIUXT0OPf+Er9foWm98tcggNYPxHTQtwpz9LfoCqV1YeQnnycAaiMATvbdsG6yiSmQM8TxUaTrTFS86cDgwaqQ4uw78Gtq/udaxLGmqMcQNoFheRDfC/2Vp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+XLRrldJuAMSuhQoMCWyOO/s8Iu4Z/RW7HY+cb0GiM=;
 b=bAZXprsjeAmIRVU/fVkLnDPpSkyRQNQ994fmPNB+yB/VwQJVgpWQ83bnKNnEZ66vw1zfP5PXxhDxn0XydcY2YbVasBQsc74xQ6Dm3+JBgyn3vDOD9mLWFm46ciGLsbAx/9KKk8pmfu1Z/cZBS9SJAlmwoKGLHEsFP7P9mE/SfWr9BC7gCTRhWRimDfb3yabJXOf+xowI7D3kufwHSLneU/5kFA1MDEicXt1iMU0T6KWN5wZuuTUlz3CTzLtrMEBYW0gBl3cDiFlsBDFE7ZjyTCrje9aOkWd/xXyN4t0c7p9i5e9+ncmtPGR2Otztlma+VEgWoq9RwUfuBNTCm+RM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+XLRrldJuAMSuhQoMCWyOO/s8Iu4Z/RW7HY+cb0GiM=;
 b=Pg+tJa9ZpTZ2xiP3GXA+pPo8XjsXiA2iXcYAo6E3j+o8qbmOOivzuCjQi/CwsMOqdbrOUQHu4J/dEfC6AKtuefpK4+M2tgW+2P30FiqyZUUc6Nvfn9i2L2ImXFxSAQGT54ogzOdvCh7gj9rvCenekNv5itF44sxTHWjvc8H01q/9F7uMby6Jxo9OapkArUgU9b3S9j0iaWf19R9Y5MtzI0aPgYFnZujq91fEkTQEFoj+fAyl1wCyQI+UhcAvQK0PJzg2JuXBfQAh2+1P+ygrhpqOpa5rgBQkwO0fVjCRMbN8ZANXuZTD0Vr/yT+NT+eYiqI+PPan01tu8ub9sQkd4g==
Received: from PH2PEPF00003855.namprd17.prod.outlook.com (2603:10b6:518:1::75)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 16:58:52 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2a01:111:f403:c801::2) by PH2PEPF00003855.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 16:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 16:58:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 09:58:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 09:58:35 -0700
Received: from inno-dell.mtl.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 09:58:29 -0700
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
Subject: [PATCH v4 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Tue, 14 Jul 2026 19:58:25 +0300
Message-ID: <20260714165827.2937960-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6a7e4a-1728-4733-2017-08dee1c92ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|23010399003|82310400026|6133799003|5023799004|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	k1gkMn1MyQhdqfqCOl8D2AzEwXJ52apNKAybgq6LKkrHXh+ovRotiIm6+FzXJJHoy4Ga0QmQpuk4ImckVmBWvSnG97X4pROUrXIC9tVVSKFSz4PcEuz7eYnJ6U1CKoTijEDzG5F6V2iMlJ8hNhXw+89i4u1gR6wQSDQc9mBtnJQO96e7N7WXMA/Sn8Iku+60MOEumDXKqsFTydqPJ9eAalHw0EKwja3MI0vTIf2vhSt+vkt85ue4FLj2bAxbYxiYzrHXcwSTukeGwZU3msOEW1CvQfggGa2xBD57iilXRrIZFOir3vvPgD6hh2O0NTPmABLxUsfe5mxGS2DzQhFX9Z+sLcS6z0CXNCfIUQQSS0TDHAxvLMnZdS8gukZglIEmjRozhUrxnTxJfrKKHbVLcRn9XpVyD064uXS1w+wPVWRsWk4PfRIcDNdkL1Yu1yS/mf1etLCegQjbwA+WswR8o+/0aOyVhNLRf0YEPHhccD4/NELsauGSKi9kXVXRo2Tve7oVU/OPbmx0rD9e7ws2SXOShRPuGs6JVzhl3Qkos2cdekrJ+7dEqOms+HXnjmWxUand8SsM6v0cC8ZnnpvSLyreBB4uWgDrX5nOKlTcytFdgb6CH/wWZTl8tWmiUxnaLBphCuLFy17BvrZB4921BHsZffwJCT4mvWtMJXbA3okclqK1IlJrrJULLKoH+JKGf5xKMLR2mB3s6a+wSa2maw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(23010399003)(82310400026)(6133799003)(5023799004)(11063799006)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CHLFn27eyt5AlsYP235xk0i64U3FT/3/o+BSB6rDMR5DYHE76gWN/NGYk4/Uqi4fo2jwO4yJwo5azhR2Or4X/mY+SoYKPfrr7jipDAfIzrv27bhTti1N12RQKzt1JvNMha7ZNU4AZNp4TarODQcfE1+EMOIsrfi1A/6cpvY+b2YyDFy7Y473S7ysBjWHU0vHRQXNXz5/71RXRen0uinkB/iof2kxHltZXfUBrdrCXYDmpmi1kzI9blHTFVwghwKz1a+Xn0EqK0ePjf1cyayqtyzxW2Y6b91IaF5GiArGNfqvKJeJk/DsDgwIpvmWzgU9vNOl/AWt78EMPKzgNhO69tNkEoDzgA5lYQkeJW8ZgMzmZ4r8XJ3iqcVeXqwnwbJ0BJG/BnBoEtMhhDFRZuaygCslyj0vsFJtMruFbFqJcUdwLehFv67a1qVaa/DMZQSX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 16:58:52.1319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6a7e4a-1728-4733-2017-08dee1c92ec6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664

This is a follow-up to v3 [1], reworked to address Alexandre Courbot's
review [2] and the VF BAR API follow-up [3]. This version is based on
the latest driver-core-next.

This patch has been used in the Boot GSP with vGPU enabled series [6].

For context, v3 was a follow-up to the RFC v2 series [4], reworked on
top of Gary's io_projection patches [5].

The patch defines an ExtCapability trait that associates an extended
capability ID with its register layout. The generic
ConfigSpace::find_ext_capability() finder locates the capability, bounds
it at the next capability or the end of extended configuration space,
and projects the ConfigSpace view to the requested layout. This lets the
existing I/O projection and access macros operate on capability registers.

ExtSriovRegs provides the SR-IOV register layout, with helpers to identify
and read 64-bit VF BARs. ExtSriovCapability remains as a convenience alias.

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

Zhi Wang (1):
  rust: pci: add extended capability and SR-IOV support

 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   7 ++
 rust/kernel/pci/cap.rs | 209 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs


base-commit: b07fc8d60bd30caaba4d293929459780166da194
-- 
2.51.0
