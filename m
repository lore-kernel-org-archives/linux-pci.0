Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF102EBBA4;
	Thu,  9 Apr 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760815; cv=fail; b=r2COoqGPCeqYPCSanbP7Ggw9ABJNJTTv/YCuofd88rWjHGiKiKICRZE9yFyDRPq0M7ELj0nH5OHjSxWVt/cjLO9OPPZXyR/bNKwueqIyrRgOsOwJnYaxm/aF6UwCWqDwG6JVPORm17y15LiXZqHLaW63i674JDbw7QdLiRzk9NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760815; c=relaxed/simple;
	bh=PJHdMOT5UL+8P+mcxAgmaTIvUaxktNQUD8wCt4gT9wY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NPXepxxBkP4v5nXPg42bCXCLq7TZyrgcstJ1BrXyjXyL+nN3A9WjzvuJtDGUGPuiiqN0r/2lEtjoykLG3iNpoXc5Yt3L7wHpP3coRmjRLdQ19XayJHP/6/leqTXdLKYJxlxpTFJ9FtqHIb/kBrhVpjE8MPI6ubqn+aYhea+4nWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=altIpzUc; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="altIpzUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eqi2qggJUDXYwhZgRErahuBDfa/AaIqC0G1ISEcXCTU52c9qAgVUfn9vE0Y40Pg5CALz65QS0/c0NSF64CX96oAnH2jTniHLZM1wGQIWrEcd0BFOT6v/UmrLEXzZoM5TLCMwzBSRdmxU67qtLl2hvYFQVZd2UOj3FCgsqoe0stAfSpwl+tVxBXn4gTF7OfKNwQjBHlNeOzOHvmEpLf4hXfAdlKJJ9J77P/ZPwio0sH5q7o4c7+kPIS5JBsVaDBLeUUH7oxEgqI6g6hCpj8ID4cEi2KpZ9ppfuzsGX2St7oJG85Xf6V+dA5o03x+s9cajAhzB6qtEwMaKVHp5tqveGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtTDlt+c5NHL8GAH0UT4l2GLtdfM2KLW6ZgPTUdyXgw=;
 b=WredB3WBCB/qbeIFD6YvyRRyto8SlJLPlyNoH4sZEl9NlX213QaANXzRmpDrJiTM/9QM1blVgS2vQe4c9cJe/5FKNhU6bAOZjSAoNGQJsXF0GW7ZzJs1FF8uc0W4ajA0NKRuFCMAzAllEahwgC+GNyKT1b8b2q1aVsNjFwMNC7zO7pUSlAdtUmS+0iuR6Rj9uVG8dRaVWv+kpWzNjz21gsQy2GcWyoMfTNOR7dawvKk40SQS8giXosxXZuSF0UkKHyqMv6V2Lf/0pcnNrZCTPefxIeVahJnhnXMnA2Fl07aK5Dt1tLX3NMmTGioOJe4eP0Fm7j3SEIjZHPezGX7GGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtTDlt+c5NHL8GAH0UT4l2GLtdfM2KLW6ZgPTUdyXgw=;
 b=altIpzUcGhrLHUW2UgfhNwpGhlhN8pA8Fjc+XUONaTVxSW6E8Qdgor231TSOSt0TrBK4eP1+qczNw2kkbSnTOlOu3tBqYG2mzWEuUSKFS5HbHTp/aq7BUPsXovx0sp3aBsd1/VT4RcjIIOQfnUBiLgYZ+hF/2J8Bq8ZuC4r51uXfTMrtiLKcWDDPXYRPmgXW1j19a7hLltTNb/AT4xZi5ktDRNrk6SVTL0vPjlRVC00NvfHjZdVjTOkQMDMq2jwcRsHNal+mKZAOBx1R+acvnfdomws8Kb7Az8msZ29jy6AEElT8k5Dt0eSPf3hpRu2oPtCbiheXxFL47/04M6OkUg==
Received: from PH8P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::32)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 18:53:22 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:2d9:cafe::26) by PH8P220CA0058.outlook.office365.com
 (2603:10b6:510:2d9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 18:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 18:53:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 11:53:01 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 11:53:00 -0700
Received: from inno-dell.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 11:52:54 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<kjaju@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Thu, 9 Apr 2026 21:52:53 +0300
Message-ID: <20260409185254.3869808-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c7b58c-3185-454c-6783-08de966945a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tjU6uacTAtfnziRV/hEFrmyYE+yaBwLIl+0sJ+8rjy3FCyJQzIock9DRu6IaJH1xbFgo+v9kqQTwqFl4JpbenNXo2Iz7lBBQa/gPYRyP5zQZ9RFaLLiY9lRmcphE/BEHjDEh3/4kEUVHz8Gtb7rIFigZhflXobyyRAx1KpZrlYWTj6YaOohFLv8pWD3GMscGB+Oy6y6RypcAqe1dALaohCGe1f1C1F4RwoynfYg066yZ4pBpQG+1x3U/niHCwgN6DaVzPD8tknZdg4FGIa1jHhLB4gFgt1pIi7lli9XoMLpJNC50pggNUl7SPsBIaC6mWEIYZ+qwzTTyV5KJd5X4EHqZxS4BudoWYvn2ST7B2fyNBEl0mQoQfkqNqzSboUzAXW0SDtMJJCMRBAueg0ogAyUY3BiHm4ZrFmuTR8qcxzfnBMAwq+L4+k2o3wh0oy3M7SiU9XDF2+VVgYNRDrEbUWXE41v4NjuVnXMdMsZbrGaeBIiLOqWpxuMQVT0kAoz5PBae0lZIL4Pa6rWP7sK4bGuG7nhYHEK8qlKgtJHx/ie3xyrOt2cQ/N9nVSGz3Ia81mTBnV4OPf+66JzSlwln5U8uKpHOjYuSsIafTVmUxzbJm4+X0pN478eSbgq7L8qOLG+5L08LPXs6GPjVurM6dnxwwOzgf7AHCBb+6Rkh8rSEBUbTZs8XyajpcRelPCJyYpcKASoK7s46VbZZyDcEPqEl+MEoXNsploquUoH6epN9GQH46RLaHX4KVxGx3/DP84NxUfnpVGTN1be/aF+rEw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700016)(376014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ifygGT+cOqZMs8iHNVfBxMq49KrbEqQ57IJ4PACnDXC1kEPpKGzs26oP/8au4MYRSe4HuGKxY26G9cd3Iq3RFOD7tevMvDFUP8N/Ev7phDe5DFenKikf246pVpp8ynImYlLQQjKFxBKvUVXSQdAR0Z1cUlCd0h1kzYpBgoBWOZoH9rIr0WaXXdl3u1QfuVjbDCTiDETDybkOzboEjFZ1GZTeNNZAB3AWPi0596Hwy0dEQGBk+Pz+zi7Y4PvmfZi0w7JyTmMzBP6YHeTDZ5ZiQQ8Sdrk/N64/plltFdwof9HyBKM05ha115in9bW80IRJO3vbR3r3UlqIQqMHuJ+KHhPYLTPTfWuXRTNmEEB18kabTYA6H9e3xXHBvzeOJcXT7w4Dokiexsi55hJvrsqjagAaZd+PI0mxZAY6i6SsXwfVxSXHPoSsGHrG2ygp/vAF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:53:21.6255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c7b58c-3185-454c-6783-08de966945a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8

This is a follow-up to the RFC v2 series [1], reworked on top of Gary's
io_projection patches [2] to use the Io/IoCapable/View infrastructure.

This patch has been used in Boot GSP with vGPU enabled series [3].

This patch introduces ExtCapability<T>, which implements the Io trait
for PCI extended capability regions. It delegates IoCapable to the
underlying ConfigSpace, so io_project!/io_read!/io_write! work directly
on capability register structs. ExtSriovRegs provides the #[repr(C)]
SR-IOV register layout, and ExtSriovCapability is a convenience alias.

Changes since RFC v2:
- Hardened calculate_ext_cap_size() against corrupt capability lists.
- Added // INVARIANT: comments at all ExtCapability construction sites
  (make_ext_capability and cast_sized).
- Added #[inline] to small forwarding methods (find, read_vf_bar64)

Changes since RFC:
- Rebased on io_projection branch, using Gary's Io/IoCapable traits
- ExtCapability implements Io and delegates IoCapable to ConfigSpace
  instead of duplicating config read/write logic
- Dropped the fallible I/O patch (now upstream in this tree)
- Added rust helper for PCI_EXT_CAP_NEXT() macro
- Replaced raw `as` casts with From conversions where possible
- Renamed SriovRegs/SriovCapability to ExtSriovRegs/ExtSriovCapability

[1] https://lore.kernel.org/rust-for-linux/20260225180449.1813833-1-zhiw@nvidia.com/
[2] https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel.org/
[3] https://lore.kernel.org/rust-for-linux/20260313165336.935771-1-zhiw@nvidia.com/

Zhi Wang (1):
  rust: pci: add extended capability and SR-IOV support

 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   7 ++
 rust/kernel/pci/cap.rs | 256 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs


base-commit: 016f794f04888a304322c746b0a7794888d86e21
-- 
2.51.0

