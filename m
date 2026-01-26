Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F891DD0EF;
	Mon, 26 Jan 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769464835; cv=fail; b=BI5CEpMGVnrUc8LzwWBPLzBRw98YelIz6Th3WYu8CZ7d9JfguWBjUoM3M1AGEln2FipVTll9AGM9pAwndNMfWWzveUuzC5xX3PipqaTeeWQ7aE2qHX2u8dZfKy9Av9Kr9PmMsQNRhhkN22Geez0XEeDd6RZfW1/YVeiO6pz5eo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769464835; c=relaxed/simple;
	bh=oss72QEwbvYuS8aJvYoNk2wZO0ajKW6F4yqgCWFz6CM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bf8tFSPIoTa7RYcTme48SPdgiF5r/9ZtuP3FhkJ/5K6x9a9SuULcTqiCm4Jk4QWJMPgun121hg2KEm/CFC9edUGR+nKKHscAniqw1KaW2K5C4Lzjx24oBksIYUPiQRpDm04RJJwdxZ2lfbAT7msan+tqnKoq8M3G5VqeX58eBJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+xwNNNN; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+xwNNNN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdWBs0Y24/QjmWz8XHSC8dv8kIeYPcjF9cp5t0yqINId1byJjb0mgWr3wKkAvhSYoVQX/0GrU9o3CNVKNva6HRTC43LTzoZgrr5M8DVfMlFbuGMpp9rgQXjN8yKZJCNyVBJ5/q22mlmvwnZA6FiQSQPN3wx1NHTQFzBFYSIpKlb66e+ADJzenx61xaUauzY8IeAbsra2KFXbocs4wA8mLir4MG+p/kjmkuTtUCIXUBdLokN9GGkQmlqn7Sblzqt3TBdIuuRduYuZUnbqKMAx1JcyHGJdZyzbXwlEXWF5yHwhZNST4VlmazIICo8j/pYGuNiLOEmDV9Cqf4UvKK87+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKw/7O1RDq5f16ejwR7vu9Shw+WUR13+WQm9tsPV2Qg=;
 b=QnWebuVbM12YiqnY3QnHL4Pnp+nljJzjoQ0AZKWlLiHZ3shfoXZRfpiexMftPGQV30Pvp4T7zhjLU+bEKUMi2sNhwdTaZ5BNYBKx8dy8fX2dk8SUWiMU7C5X1OcU8YqHMG0HsslV8gea3F/6JuK33OHB5V/dixSstKZAScwDifzZguRHaXU4xZQ1DiUlQIrreFGQAuXq4xWmdOHnrlSoXC3R2YlMRWZod95o9LMSYFOOzCIv3JveSh4JGOdnTfKGfIfUIuhniOdm5Zyr4YjJwoqtqm/8365TnbUgEV6pyX9rbzojWNqkooX4fYtt2DDM3VGtRcLyfITfrVjXexv3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKw/7O1RDq5f16ejwR7vu9Shw+WUR13+WQm9tsPV2Qg=;
 b=a+xwNNNNqjnwmUvngsroh+Wbme7Jx/x8sDtv4iI6KHietwFXLPZa0AhHakvgtrYs1I+Mn68N0WMQ+dKPWEovnKMGxABoxOojsSCK3cxY0lIkzTm3onH4xi8RKNN6EANlvltJlwJBxg3PgeZn30stKJMYNxMwJQWZh5VB/AqMdJrKYBhW00f1v73WBwyX49QTaTozbWmJuGlA8EJOh5anMXqA3jDyMmu5bFekGwYuJ2rip4MB6P4JHyaDozOkRdz/lbhTf+sutjTZltgVphPeZULH3509vl8srKoJV1EGp7JhprasM8NWDy1wmVaAKEl2VVsSV3o9PDYhvdbFfFtfEw==
Received: from BLAPR05CA0034.namprd05.prod.outlook.com (2603:10b6:208:335::15)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 22:00:29 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::e7) by BLAPR05CA0034.outlook.office365.com
 (2603:10b6:208:335::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 22:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 22:00:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 14:00:06 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 14:00:05 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 13:59:59 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [RFC 0/2] Rust PCI capability infrastructure and SR-IOV support
Date: Mon, 26 Jan 2026 23:59:55 +0200
Message-ID: <20260126215957.541180-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecdafe5-bef0-419c-65c0-08de5d264efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vq5Wriy3hM3uZnSo7sIr6c6V0aA/Z63ciLs9PVIvgd1sBgdlV/k4gY62W//3?=
 =?us-ascii?Q?zD3yxzK9fRaEAkpnlHMThZCfP9k7S/oELEP12Gn5Aan7SkE7VuO1YRVB2zTK?=
 =?us-ascii?Q?ZztonvzOx9x9zSBxMEC7ZsK2Ik/t5hOp3Eg01xrU1zcAgo68pyZ/rMKMJEGi?=
 =?us-ascii?Q?GJb8V17j5ae64pUB3pCPFFmA83HdO6Oc1s9l5NgJqb5ufZ9s2ZKqJcPMwUIb?=
 =?us-ascii?Q?XmIYmFA6IbXsJB2Y5lHLVPNlW96fh4VgepK87zY9JzotEpkNC9TSQGe2Vfpq?=
 =?us-ascii?Q?acopt/sSp+D4un8iqRZ/NotZRla3Sn0gWdmRPhYuIjagJwV/VgwWBTVFt3sw?=
 =?us-ascii?Q?S7Dqb+Y/QvllpCkKW339lUHfcDWomizp8YYyALfUP48NC05pF3gtintJ2syt?=
 =?us-ascii?Q?9MQdvlY2+Svi/iYrFMlSkilbwuOn5ip0U1y226bmgEpA33FlWKWum5zrllG1?=
 =?us-ascii?Q?CBQtAofoEQ/9cfjfYuXexOT1mn2Z/2sQycK1JEOa2QBcBYPhhDPQNLQ6b/ll?=
 =?us-ascii?Q?67m/j0aLAX2goi79kHw68jf6yRi+eXnyLi91PwIHBKiwCEiKEsr9SLmSxYpb?=
 =?us-ascii?Q?is8dyqn+05eRNTXtAYP/+yiekd4U5Rv2scrB6kGWutAVv3lFMv2uXvWDSkTK?=
 =?us-ascii?Q?HYeiHGmHFaJLcyOY3Su8fW/ZEq2EPEr6BOtR9z908fpaZ4U8k3ntyxCRcNpX?=
 =?us-ascii?Q?UZWjjb/Yixyck0Zyq+n8xUpst0ym4jd9XUUC0KiHogt4vHVUYe/VvrTTCHOA?=
 =?us-ascii?Q?7adqFgTUXs8NixbTuEGsd/dhv0gmDYf23ivehIfDcYDkXJ+3rRT2Nof3KQIn?=
 =?us-ascii?Q?35kX1SqRWeqwug/fmlfrL2cDMq+Tw3u4vXfLzv3Wv6ojmBG8YkRZMux395cF?=
 =?us-ascii?Q?m5y+NSGrncpXC4ahQ4z3xGHwNcO3kRhWnoeEISVqIia5ThvVPgso24DOSLCu?=
 =?us-ascii?Q?LoIdSkhJwOprmvw0+6BBCgYwS6PCvKrXQAjigEHvwk6LNZqq/gK/wgKF8W2/?=
 =?us-ascii?Q?EDwfcoxBz/WDB5QXYWByIEYxT/gZUISffJDBA0oBX6bOff0LTPXKmHCh5Wqq?=
 =?us-ascii?Q?SrHUIsyLT5cCSacAtRHovkWqmjq6ow9GFCaeEdGZqsHsuFL3vEPwAHN/kOn8?=
 =?us-ascii?Q?b67wszvisVpw+oDyG2+QG3IQ7EmAzNAzP4J4Yd7rJge0J2j5p7Bt2VPi2Wyw?=
 =?us-ascii?Q?kGbmxtWcRJ1eeZHMILvqte7Um2rcqrSrdPDYawDfdFbG1+oSoUIKbTf30wTF?=
 =?us-ascii?Q?FxtutdYDZgPRPvVmK7LUhmALh8WjdUD9In5IgSJYUh2qyMAijO5OkM8nNV95?=
 =?us-ascii?Q?uEieff+UgcpAknj0HAJHiJ8atwJDXrQcy+FTSiIxcgpWEd6C2v48q4x0meWT?=
 =?us-ascii?Q?i12VVBlXpdjMzHwfDDJvIE1UAqD9neG60DxdT5/1sFFMUQL0H214iqAQRBjh?=
 =?us-ascii?Q?ysngwqTif4IwbuQzBdS6BLCUUFWME/kTWV5UkYl5K9mQfS3WxszCV9Ov0T/O?=
 =?us-ascii?Q?Yq1c2ppQJlX8DmTKg3ryXFiywNRVIT6AUkWoOKc398jZRiDfjg6iYyJ/KNNt?=
 =?us-ascii?Q?fD/K5JAvZdqwHFEMH8XGA9w39ukxuvf4j1sV9s1dwcRjV1mJsm13YORAS6P1?=
 =?us-ascii?Q?Qp2iUPyq3xScNm5qpDroEpdrb1iKut6LUbTCiXGvik9OHY//asTAPvjv0piq?=
 =?us-ascii?Q?2NT6qQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 22:00:24.6548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecdafe5-bef0-419c-65c0-08de5d264efa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

This RFC series introduces PCI capability discovery and access
infrastructure for Rust kernel drivers, with initial support for SR-IOV
(Single Root I/O Virtualization) capabilities.

Background
----------
Modern PCI devices expose advanced features through capability structures
in configuration space. Rust drivers need type-safe, ergonomic APIs to
discover and access these capabilities while maintaining the kernel's
existing safety guarantees. An example can be found in RFC patch. [1]

Overview
--------
Patch 1 extends ConfigSpace with fallible I/O methods that properly handle
PCI bus errors, providing the foundation for safe capability access with
runtime-determined offsets.

Patch 2 introduces the core capability infrastructure:
- Generic Capability<S, K> struct with Io trait implementation
- Capability size calculation using kernel's capability chaining
- SriovCapability wrapper for accessing VF configuration registers
- Support for reading VF Offset and VF BAR0/1/2 registers

Feedback Requested
------------------

1) The configuration cap doesn't have an fixed offset, thus it doesn't fit
with the infallible accessors. But to have fallible accessors, it needs the
config space backend to implement the fallible accessors as well. I tried
different approaches, this seems the most reasonable one. Any thought?

2) Capability traits hierarchy

I was thinking several solutions of arranging common functions for
Normal/Extended caps, all the extended caps. It seems a complicated traits
hierarchy again. Would like to hear more about this.

[1] https://lore.kernel.org/all/20251206124208.305963-5-zhiw@nvidia.com/

Zhi Wang (2):
  pci: Add fallible I/O methods to ConfigSpace
  pci: Add PCI capability infrastructure and SR-IOV capability support

 rust/kernel/pci.rs     |   9 ++
 rust/kernel/pci/cap.rs | 274 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/pci/io.rs  |  34 ++++-
 3 files changed, 314 insertions(+), 3 deletions(-)
 create mode 100644 rust/kernel/pci/cap.rs

-- 
2.51.0

