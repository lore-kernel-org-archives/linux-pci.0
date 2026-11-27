Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795819808;
	b=T8vR6J+QzaqYU/3MKvpPRBhyJD3OQqxSrp1fmLH5o8/TYS4ONYqOaHv1Qd/0bnsBY8S6
	 3FyjdyVPsJLgHW3AZSQpXr493+JYp/3muMdXYqN2xBnGKBZLOJPgHQ+hRlLyYtwKXa5s2
	 MnvOtiBcuYXHsJZBC7tYrvMOgzMWKmAEHo14qzn944iEGTsQz9ChbXUElxhp35r5g5BvX
	 NCPm24q2OWCR5m5SIM3vN2q+0YYHECxYwaL6qXW0rA3+YjjOMJWBvwTNrLmTNyBmIgZfW
	 i+rhN0eUGIAoq/U3CP7eqjYCDUpNAuZpMWTogUmxVyCecZ4w9BNMizRJIGoXvpH5i4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819808;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EkzZBW8NCYV5+Fkff5Sd6e6XoFoE2qC/1bNAaz8mr3w=;
	b=FmNVO5BgufYqN+K3UnTI5cWaAcXEYo5gUbHTwUXn4E9oGcQyAiwn2rycSNP5NZ8fhShU
	 /GIBMkJkh6B1CySzlNwQBnPdj1jaNZzsfX3UcK+oHJCbwROw3FWvKcnCvA5z4Ytp02VEa
	 vkTpUEyUVtODBngxtoFsPdDW2xp0XO4WlvaGsfDKFnjShRJZmgJLJumSzJu/Wp5iddAqv
	 2cXTdp2YFMPznOrotsCr1IRAZbXeEC/KWsQNqaOhzmRQ7QL0ANZbOVSa+y4/A8/qZ5V5i
	 WaxupcH8d/StXEmlPS89ftOMnC/euwb0KyNU15EUg8F3/e1FTVNv2og1BqIvqGfNfpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qZ+xl9lW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.28
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CB606A31F;
	Fri, 27 Nov 2026 22:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B0CB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qZ+xl9lW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMAXdpgQrGkTk4HBAvMMnD+/xESe9LCA5fnEzAac87Nma2lOItu3O+tMNg7DI/BOqPKE1/hKwZhyE8WBqtL+XhpZ6kog1z6hvskIn4BSoC3P/U6k3LXHTx5pD0qvc1oDwAAPZowQ/2d/eKyh7MYkV152qg5wNNVUyAcdflYLlEtIHHVQT9sAUK6ZlXwsmT3NPV2gD9+3HfpjTywwxXRTgSHboDcPVPxxBf31r8J7QyvjWVv0EJeUXTu9EjsYEGk5VdvfRElKbN5AAb8aarGJD10cFDFk4Jrk1PRKtg1dT3Pa9GJVZ+nvfAwwSXHQdjXNjKyW3BzcgfIZYaBwjteqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkzZBW8NCYV5+Fkff5Sd6e6XoFoE2qC/1bNAaz8mr3w=;
 b=C9HvUqRd5xsH4Fg9DxaVtZVT7MWOXLyRu+1zTHBVYnFluQNUgrmos+JKp1BfEO58foONZGgP4CmShfEHsNcHTWyVD6qalosvQi5FgFXat/6Ou1qsWn7u76BYMzWpABE9s3Fd2YElpkZ+LCQLc3Li5tMGUppD9rpgQuCg+7T9lWl/YOVQgb2+mahaWozOsnLzqWpE2tFpwRQkvCNKEJjkI6YFsLlkM9bdyrtbGGz8n6+Axili6HOyCkxfhxwDUFYLE0g1bq9GqbZqUs4GghOafiDIO8g4odmUEO4U766gRZIdHc5ab4rmIQGiFEpKXt7yA6QVtDYapsqHCiCuNQnalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkzZBW8NCYV5+Fkff5Sd6e6XoFoE2qC/1bNAaz8mr3w=;
 b=qZ+xl9lWVpgrmg8VfTeD1kfB/noq33z3nl6Ho/q4FXPAhxmwEGiyYSjLQGtr/RWm+DetptUuwCEbTvHNGxyLvXSAHifVsZlKKfWpuk7mpl3YTnsj+yDQJjrqTlovSrMogpxrVI9Lj1xbPKIxvOdqGe97hKiG+C13Dw8NXp7MtD+KtfEd0cg8LOcGJIYFXwRg7bFODwbE42Opo1IrLBDABNnX/R3aAG8tU8Ph62L3Ggc/r81Il5sPJJ8qI/+Linnh3lRnEPpZ/BzXrgIGm/07fC3dvSUjasKnJrAEemqHj/RG8urjbWsvdT6xgtjGe7MAAdEHh6CR1DrTUa9zPKyTeQ==
Received: from BN9PR03CA0478.namprd03.prod.outlook.com (2603:10b6:408:139::33)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 22:50:00 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::85) by BN9PR03CA0478.outlook.office365.com
 (2603:10b6:408:139::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 22:49:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 22:49:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 14:49:49 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 14:49:47 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: Simon Song <xinmengs@nvidia.com>, <alex@shazbot.org>, <jgg@nvidia.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, "Liam R. Howlett" <liam@infradead.org>,
	<linux-mm@kvack.org>, Lorenzo Stoakes <ljs@kernel.org>
Subject: [PATCH v4 0/5] Rust VFIO PCI support and NVIDIA vGPU driver
Date: Fri, 27 Nov 2026 14:49:12 -0800
Message-ID: <20261127224928.1511382-1-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 480e2d1b-e352-4823-d87d-08df4cd8c442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|23010399003|1800799024|11063799006|6133799003|5023799004|261009223027099003|18002099003|3023799007|13003099007|10067099003|56012099006|261102130727099003|261026140227099003|261102123227099003|261021135927099003|261022115727099003|261022105027099003|261028144727099003|261022113327099003|261022075727099003|261026121527099003|261026130827099003|261021123027099003|261021121427099003|261021130227099003;
X-Microsoft-Antispam-Message-Info:
	EG6S/P8ZU2ToHLcsBgpAYmRoKjYi1Bw6xzHix/WTU0X7xD3Sa15C3FDang+HTfo1C6q/WtdqJ3cVyqjdqs8HS2YP8jvxhtmbE8syLRwLLooiHRofE9e+s/kBMimOSZOmesssiZvF9CtnHJqBQ9xyHc6pPIUV0whM0rF/UdtVTM/W+2Eg1nyX2aUa0QZ6vNPm1/KYCwnNwyznPmg9GYxV03uCvcYm7YNsrqClRNwNrC6pWfjhLnUaRZCtZJBpmgY5e/lSjHe1E3/uXgPeWaUIK6XPF2VRW+IlOOhmMvQgwVSOmgpSA+jbrszXlzxWu0wrtisP5engVBB8QxdMdQxqciDWFul+7hNF7P0OoXleDACGrAD8+SdUVSCHwRdRqsm1naOJuP4wfpKf3N173Qo5uhrlWcpfmvFx6Mb/OpVkbwtD4FEpUVHE0vIhEKep+tnLj4xlxicrsKbmNlD7eK8KIVqRHv5V08eaSc1Q9GGjc2SRCKE+mr5AyxrqcvmDhYuauLoUvDfRUG9qErrEApZCEIuyEUB/vaYXepdXn4FwBzL9HB/RWtbFzvZwsHFpcK8bzCiUaHOGZtcENLnH2cUfN2UnYm9gYMzrgSYUmIFu8aUV4kcKqJHUm067S61xC7GxPiShXycLIb1MvW9KmeQQllJJRW16/XOscwOlVzhIPwXHlpkcvSTDaXYE4GmW/sQqkfiiaUNF7XgT3QVbaY0jTg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(23010399003)(1800799024)(11063799006)(6133799003)(5023799004)(261009223027099003)(18002099003)(3023799007)(13003099007)(10067099003)(56012099006)(261102130727099003)(261026140227099003)(261102123227099003)(261021135927099003)(261022115727099003)(261022105027099003)(261028144727099003)(261022113327099003)(261022075727099003)(261026121527099003)(261026130827099003)(261021123027099003)(261021121427099003)(261021130227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wNa4NidzxyLdQmG8sfJIqO0Fjw1ErSQivSu22d+nU9sYXZsa2npMWY5T6W3j0xPNHy2qB0NPTdgBVtwjgEzBDV+tSuCOokvpFc0ozZwpiTiI+L5Rs2hKegwvTKCjmaarXO/tKXALBf9FjmEfcr5CF1ujX/J7yi/VQS8NWZHaF7qREcU2/qZFUafm/H/lSBbLtZScflQkC3K5Visd6+EqaF7i8SPCDJQ8Rbkny3varQi1O4WXqnVpYOgM3PRqjPbINqXMT7PQySZyDQwKJckmRMZHHXeelORAp8p5h4ixXPo+D8vqTygc+BzYx+cgqh3JvWDuiKP2IUPoarShlZO+EXb/hVmPuVM276e+lNJ0H1CJLcFyrpgPixjGFKx/cCkINW/hd/LlJkpGhIq3U5LLQlgXheCTTLjrisloJ7ycJdP3444fxH0SVsW0Hi+GKasM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 22:49:59.7899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480e2d1b-e352-4823-d87d-08df4cd8c442
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504

This is v4 of the Rust VFIO PCI abstractions and the NVIDIA VFIO variant
driver [1]. The driver uses nova-core's typed SR-IOV PF interface to
create, reset and release vGPU instances while VFIO provides userspace
access to the PCI device.

Patches 1-5 of v3 were applied to driver-core-next, so this version
carries the remaining patches. Patch 1 adds the VFIO device handling
common to all buses. Patch 2 adds two VmaRef accessors for patch 3, the
VFIO PCI abstractions. Patch 4 publishes the typed Nova PF interface,
and patch 5 adds the NVIDIA VFIO variant driver.

This series is based on driver-core-next. Patches 1-3 need nothing else.
Patches 4 and 5 also depend on v5 of Alok's vGPU manager series [2] and
can follow once it has landed.

Runtime PM is still not part of this series. It will follow once the
generic Rust runtime PM support [3] and the PCI bus handling for it are
available. Until then, vfio::pci::Registration keeps the device runtime
active while it is registered.

Changes since v3:
- Drop v3 patches 1-5, which were applied (Danilo).
- New patch 2: add VmaRef::size() and VmaRef::pgoff(), split out of the
  VFIO PCI abstractions (Danilo).
- Patches 1 and 3: build the abstractions only if VFIO and the VFIO PCI
  core are built in, until the new build system is available (Danilo).
- Patch 1 (v3 patch 6):
  - Remove RawDevice and make the layout a type invariant of DeviceBase
    (Danilo).
  - Add vfio::Operations with the RegistrationData and OpenData types,
    and drop the R and O parameters of DeviceBase (Danilo).
  - Use Option<NonNull<_>> for the open data, expect() instead of
    unwrap_unchecked(), KBox::pin_init(), and one unsafe block per
    operation (Danilo).
  - Reword the type invariants, justify them with INVARIANT comments,
    and hide DeviceBase from the documentation (Danilo).
- Patch 3 (v3 patch 7):
  - Let vfio::pci::Operations extend vfio::Operations, and name the
    lifetimes 'reg and 'open (Danilo).
  - Make the I/O callbacks optional with #[vtable]. An unimplemented
    callback leaves the VFIO hook unset (Danilo).
  - Use the VmaRef accessors of patch 2 (Danilo), and let Mapping wrap a
    VmaNew (Alice).
  - Use from_result() in the callbacks and const_assert!() in
    Registration::new() (Danilo).
  - Remove RuntimeActive and call the runtime PM functions from
    Registration (Danilo).
  - Add the optional dmabuf_len() callback, which lets a driver limit
    how much of a region can be exported as a DMA buffer, and remove
    Device::new_passthrough() (Alex).
- Patch 4 (v3 patch 8): rebase onto v5 of the vGPU manager series [2].
- Patch 5 (v3 patch 9):
  - Match the two supported device IDs instead of every NVIDIA device
    (Alex).
  - Reject a BAR1 size that is not a power of two, and report the
    virtual BAR1 size when the BAR is sized through config space
    (Alex).
  - Clear a reset error at the next reset, and do not treat hot reset
    specially (Alex).
  - Reset the vGPU instance in reset_done(), after the PCI reset,
    instead of in reset_prepare() (Alex).
  - Support DMA buffer export, limited to the BAR1 aperture of the vGPU.
    The VFIO PCI core revokes the exports at the last close, after the
    driver has destroyed the instance (Alex).
  - Do no vGPU setup for a passthrough device, do not signal the VFIO
    error eventfd from reset_done(), and name the module authors
    (Alex).
  - Depend on VFIO_PCI_CORE=y, following patch 3.

v3 patches 6, 7, 8 and 9 are now patches 1, 3, 4 and 5.

Link: https://lore.kernel.org/nova-gpu/20261119215046.2892839-1-xinmengs@nvidia.com/ [1]
Link: https://lore.kernel.org/nova-gpu/20261124135937.18583-1-alkumar@nvidia.com/ [2]
Link: https://lore.kernel.org/all/20261124113555.2480381-1-beata.michalska@arm.com/ [3]

Danilo Krummrich (2):
  rust: vfio: add PCI variant driver abstractions
  vfio/nova-vgpu: add the Rust VFIO variant driver

Simon Song (1):
  rust: mm: add VmaRef::size() and VmaRef::pgoff()

Zhi Wang (2):
  rust: vfio: add common VFIO device handling
  gpu: nova-core: publish typed SR-IOV PF APIs

 drivers/gpu/Makefile                    |  15 +-
 drivers/gpu/nova-core/driver.rs         |  34 +-
 drivers/gpu/nova-core/nova_core.rs      |   3 +-
 drivers/gpu/nova-core/vgpu.rs           |   1 -
 drivers/gpu/nova-core/vgpu/vgpu_api.rs  | 171 +++--
 drivers/vfio/pci/Kconfig                |   2 +
 drivers/vfio/pci/Makefile               |   2 +
 drivers/vfio/pci/nova-vgpu/Kconfig      |  20 +
 drivers/vfio/pci/nova-vgpu/Makefile     |   3 +
 drivers/vfio/pci/nova-vgpu/nova_vgpu.rs | 418 ++++++++++++
 rust/bindings/bindings_helper.h         |   4 +
 rust/kernel/lib.rs                      |   2 +
 rust/kernel/mm/virt.rs                  |  14 +
 rust/kernel/pci.rs                      |  12 +
 rust/kernel/vfio.rs                     | 462 ++++++++++++++
 rust/kernel/vfio/pci.rs                 | 812 ++++++++++++++++++++++++
 16 files changed, 1930 insertions(+), 45 deletions(-)
 create mode 100644 drivers/vfio/pci/nova-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nova-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
 create mode 100644 rust/kernel/vfio.rs
 create mode 100644 rust/kernel/vfio/pci.rs

-- 
2.43.7

