Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D7323D7CF;
	Wed, 28 Jan 2026 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621459; cv=fail; b=MOG6Vht8Y3gOYikQFMpiXIdatsr/uXCc3zKlesjyGkJqKI6DPgI+MMElXflKcvY+LVy2IUx07hnG8Fzqti7BPU8KoKGT7BfYty1cbNVxG5AxYrmqlt9vFbnTVwfJ6r/tH/CYgjG5zHaQO2QBsgTIRee+zkeJhmw/6ebir94CmOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621459; c=relaxed/simple;
	bh=cv6ykNq9/v3GVVxAJsl0np7yg/2AR9g8myCuTfGiY0c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PixY3kQYB81zFbZSJBUGUkSKE0RgOuFpoDhGw30tZENmF+RgpLMAqitGlDRMWUhiubx3FsIH37urVkBiTqlHYDQgUU7crCYMrnDS/QiItGwXbYKQJWNyL8FK+wtes4VUbnSFMYhrFySrMt0TTqbkF7UOBcpyc6ZHXSkm2ra2WvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oH8R7adr; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oH8R7adr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enr3WQ/Ckjuy102Um9qzHpxT8mBLuP38BYhYGmLYIs2+SinfR/wNOK8W7G4I1v/Shj6TuSu+TlU7RpSGBEPeX7Iu1SoOocZMa26eVi6cWfNh2K++fDVHXJ54RbFPzWKIAtms5ACUmawgnbpZs5wTZafT4ZWYz3/KsKoXwsZ41XMKlRK8rM1G8Q9tkEsNfoqUgfiCC44iJLwC/4CrZLpR2XiP5PG9eQdZQtZWYxIvnMLjmfGYt512M1Pd4t5p9RDDFZhAg6qO7Q4Onoa39D/4CYFBWO/+v7QnDX5KFimKQ1s1eDpJ0p+tl5FjpBnaPiNAkHgYEkR4BJDCDbDsTqKcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/I74S+6Z8dxbEGbC5Ur1W5ufVTtl/ZJAXH86g2wkY0=;
 b=TToujpNH+tq+MWgKeWzDGmOrubUHu6AA1++VwHY9Lpbrc2I6gU0Z6MVJR1M27TBPA5bJpUDm+H/ZKGA4pE5WytGtOqWpjLeS5wS3/oFfv4lSvmuiF9qZcPm45Z9CHB4KnX/6KIJrOMLgliappkp+ZWq43oPwK77dpBi31MirkjguGRj/DFJ5tUeMQdDgldc3+vMh3tbME9KrSj6jHGE0E+pag58dD8faaozkGmqPHEEPQGb8BxlhijPxWEqHU77jV2gPRTKl5jt/sh/uvO0PjAXutEYlH1LFLt5fhtBUPiE7zTDB1P2dLhWbY6XYAug1FUlixMH6v3/7o4TA6wkDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/I74S+6Z8dxbEGbC5Ur1W5ufVTtl/ZJAXH86g2wkY0=;
 b=oH8R7adrdUPO5NqQ9oZ/FWap7AXbPYeKgZSKsVkp930HvMaJg0BOtVqM8QVP/LNrkZq6bhiZf+c/ZGKGPsdwDdfALN1hJpjXfzI9vTROSZmKvYTQRK3nA2hstd5+Ld/Y3K+JeJ/Wko1Oifp18hzJ56UdYjzx7UKE3lMUgEBxY3AQ9v8n7dlq+B2kezruAREs9x0RD0RHyy8RD+TSZf95z42Azozt12El/oHxpF5MUlxAbJ9Kdnc5N17VBRNpuxvkXGCD32fVcDwuC0sit9O9iNSmViplZkjlnYmFhwTSJ31Ovv/Wj9L2Wx95Dj197g04XxfAK0UJ3jT6EMPmA8U0gg==
Received: from SJ0PR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:334::22)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 17:30:53 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::78) by SJ0PR05CA0107.outlook.office365.com
 (2603:10b6:a03:334::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 17:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 17:30:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 09:30:20 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 09:30:20 -0800
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 09:30:12 -0800
Date: Wed, 28 Jan 2026 19:30:11 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctlg
Message-ID: <20260128193011.3294f41e.zhiw@nvidia.com>
In-Reply-To: <DG0D9I9P5BO9.6Q9H2BQN5AWU@kernel.org>
References: <20260122204232.15988-2-zhiw@nvidia.com>
	<20260126181912.GA2131321@nvidia.com>
	<20260127215744.332380fe.zhiw@nvidia.com>
	<DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
	<20260128000410.GT1134360@nvidia.com>
	<DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
	<20260128132029.GX1134360@nvidia.com>
	<DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
	<20260128145906.GZ1134360@nvidia.com>
	<DG0CABK2DQE8.1TDN35GOJ0DYI@kernel.org>
	<20260128155646.GB1134360@nvidia.com>
	<DG0D9I9P5BO9.6Q9H2BQN5AWU@kernel.org>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b136a7-303a-4df9-4f8e-08de5e92fc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m8q7U1iZq6lGT4sAApvFwWqhGL90OkXVYNtqhFrTY6XljmvzgdruS3xVga7H?=
 =?us-ascii?Q?lnt6djWpYIwtqB6P9SWOiF7NgQL9j1/Brg7NxOT4kTfsD/v21kWPWIlQK0LH?=
 =?us-ascii?Q?Qd0p/LBPMDqsd3Cec3r+VJaBc3M/0KPbpBC2zY5QbpV7rUimam50PfasHFRi?=
 =?us-ascii?Q?T8KhyVMy8kKdvnICkzVh/nxfemXgETjPSg9SXYRUSPSDfEb/M8r9SOfSQFbI?=
 =?us-ascii?Q?Q6TwTfzv59W/N1RPdDJWZK/cKvkOwcll6MLGMCAOgvKcrKZtDoLo+TR3aj2R?=
 =?us-ascii?Q?TqtcU9hMavaFmECq1UaeZ/t3/kuTpx9z1M5fhw0wdEuUJ5MLbuur+D+3pRMk?=
 =?us-ascii?Q?Ot4j98zJvnXr0N7lhLalDeJQjO3RBVGNz6HL3SoeSGNEFI0E+D82OahusfrD?=
 =?us-ascii?Q?YPm1Qf1iN/+uKepqnxMDP3Vo4hekO+Ebg6mZwEjqiyOAm1jQ2bFdfaHJENrH?=
 =?us-ascii?Q?OBgxK1tMo6U6wQIxcDi8Gn4tr2rbsPRfs2NtfQt4X7oEiqh9if4cyRXM6O4K?=
 =?us-ascii?Q?CJwe74kOJfQ1Nipc0nSvv5fDW91LVfJvBH8udT7pgVQm5BJrWRymweUem8gR?=
 =?us-ascii?Q?ByV/1fEtwCD1eLbrU4dTD25kiXzWQIu12+G6SkDRJwEUwtTQlRGuDx70vEoW?=
 =?us-ascii?Q?DF5fQrcX4aQn79uJzne0Dy8cXsArf5ZUjgGTMg36zN+Ea7rSi2TVS5mK6azv?=
 =?us-ascii?Q?SCQ4SDUNWWr0KcFiKTbdwHOR495jm4rJrWGmXD6mi5mMyP77YfV/uhrYaJ9l?=
 =?us-ascii?Q?+hhX+E5Pz0TwYWhaGUUI8fekWZ6cr0KfS6NikHWcwsrkRGnrDcM4tKd83lU5?=
 =?us-ascii?Q?89LESIvSw8B0DDghhx8X/2hul5LR8Cq5LfAheHT8V9nsvGVcAdNKtQHleDJ+?=
 =?us-ascii?Q?R4Im66ZL3Q3hWk7EQioiFLmta4dbQR90wYaI5poVnxN4iqtUDcP0ndOB1yz1?=
 =?us-ascii?Q?8n8MQjLb57/ZkzlTBJ+nRr16At8yfulowfYCOgzB8ZwEclH/dzRuLk7jTJPG?=
 =?us-ascii?Q?1U/yhaJMzUIf9tvbGYXXFczueo++tCGvWBr6uhQxjj9Blmwey3+H6ZBYkLt7?=
 =?us-ascii?Q?zAha0C5psNmckiCKBZrZh5dtBMc5L2TgSB5yWqtrsuz0sfdu3kTuYG7G9OJl?=
 =?us-ascii?Q?p1/bgAjuIpNdm/5SJDXUkt77ZT3wPZv7wypI8ig6TpUElZp+71T0yEfxIJi7?=
 =?us-ascii?Q?ZkjltL1mHXEvheWwQxhJqc6arwulqfqV0PeoMBeCRzlFUXOUwwgo/eyogv5v?=
 =?us-ascii?Q?Rm4V45tXakSq8v52X2RAxo7nzwWAy/+AekkEwAniMlKp/9UabZ/X9xdxCtbu?=
 =?us-ascii?Q?Ob4C7DJJWO3zfiUgOvvnqbdWPyr4CapARMjw7hRDKzXXuC1USTfiSwfttEDT?=
 =?us-ascii?Q?+aPv9JRTHms0kFDiXw63BPTgNH/DvydvCnpvjYRls3aRMx1Xo52QBPSdw4a7?=
 =?us-ascii?Q?lYzmrq2lxt8BLTzBij2aLYXJvGTkL4RHQ2J84lWDGehl0rtBDV4hv0umQYIT?=
 =?us-ascii?Q?eDZu2xIYOjJMF6JVKwCHhGSQE9TPwR0ZjpcYbajfU7Y70jEgJviM5n4ClFKn?=
 =?us-ascii?Q?RKzIxiO6J6U83j3VMX2A6H1DUmCIxMuxeyzuTm/JBqM6FF8IR4LULLKtJzYC?=
 =?us-ascii?Q?q9oRgm5XpNb5S/WBqkNNT7flC9fYFhcOH0ie4fCK92/DgE1lx2BIHKnfof6X?=
 =?us-ascii?Q?xb47jw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 17:30:52.4362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b136a7-303a-4df9-4f8e-08de5e92fc5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154

On Wed, 28 Jan 2026 17:35:04 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Wed Jan 28, 2026 at 4:56 PM CET, Jason Gunthorpe wrote:
> > On Wed, Jan 28, 2026 at 04:49:07PM +0100, Danilo Krummrich wrote:

snip

> > Or is it needed to add the typestate?
> 
> This is something we should consider when a fwctl::Device would have
> different states it can be in, where calling certain methods of a
> fwctl::Device is only valid for a certain state and would cause
> undefined behavior if called from the wrong state.

Are you saying we should define typestate like Device<Bound/Core> also for
fwctl device? I haven't thought about this and some design consideration
would be helpful, as the rust PCI subsystem has it, while some of other
abstractions don't have it. I could start to picture about this if this
is necessary.

Z.
