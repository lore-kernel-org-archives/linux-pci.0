Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A02773E4;
	Tue, 17 Feb 2026 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361398; cv=fail; b=ryyK5XE2h20hl0qppfNt1mv9XiE2lHjd2L1XVeIHF11zGqDa2AzlBdE2EUHbA4yphgtO4fPR4sXccoXpCH8qzeBXJ9OyXJmMmjZszK0nHjUmz84LEMCI7LtRDjEu3zLc1ZYkR5A4ksGNwvEM7BSozYfaxGAk6Ek+7qRB8C57Hu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361398; c=relaxed/simple;
	bh=o48Xyus27uJf9FOOH1dIW0K3bd1X20im5psRkjnH/bg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nrYBxJwQ/vm9cZ0b5J4f8LK/s8dBcWMR7UNuPwlzEdgt5JSCfnOha0ABqGvf5LcQs4s7U1OAja8LZ+91BmC6k5n6n+0kWmH0itHc/W4PPq0JDtUk4fXaE01dqp7Hre63ELdYCJwtsSZuQJR22TeGdgT/v9xGNTL9KD9gysCFHGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqWVuLvS; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqWVuLvS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luZ8tSfzb2wvqhNQs0O2DC2RM/SXry8uYnak/N4hYyPfdwPF14Ud904h3aUZPsmzWIWD0WWUaUyJOViW1rrOZ4S6OYv0ELFnojxq2qjXCJLkkPwMXo77Rw1LV44Kgt6dv2TVggtLEJWoscBfR9+fiwqD8KqDNzMDynBPZ84QVWDNnWXcNEv2t/FpHctiTWlYJW5J381DP65MRbHbfIasH2t5z7G4vpMQiLWQWyiHnfCKQbFUnqgKZgKLIs1GNUw0ZReJrGhUzZmMudRIi18plmzsj+eOSJ8lOAhAmnFfFTNRNIYZ6EKyVSPj1M2Og8tgNrWRe9B4RU/i+tIBAS9NJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYsMAXUIPyICa31jW/kFwRjzmNKfOmK9T0Lm0JvgDG4=;
 b=jmNszP76pAOzPcVldLX5dFJeG2vQgCVtE0woVDq2gJackvrUB1szTWPQlB9U/xAn7PY4OGYMPpT74sWEOb82HaysaEbvGZ1DbbNnSQ8soXLdjPhTT3WCdh+5/0sJVLEVAEPgBOUnrBgQe3tUVWMQdmakruzVD9IO0MLqoRiuzGBvLgBX2gr3bN5sGgC1xa2CuQoMi9zD3Ngk02BFjU8gN1r+bKTIP5WUXJzUQemMMIg5aBQuZ957n0PaMzLJDxNTor949UOmqZjTaAD/pwuVx39b6cvUiZhAi5EWIWWvvkYmS9Hs0ZOKfOn2C54kbRQyDLcwaOaBqkaiS69xFzAg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYsMAXUIPyICa31jW/kFwRjzmNKfOmK9T0Lm0JvgDG4=;
 b=mqWVuLvSkWDro3/k6Bxi2j0FmnP4wvjLm6EX1Lc1cDFUcWWzsgObprLUYnyBhusFuOMhhvevK1lFm/bjm3zPHSUldMGa4PiAg0i7Z3KGnTYyTv374IzNHxLDM7SZFM1doqMb95FC8E0vmete5zA9wMYhudd7y0PdogpPmquXcKsuvCf4gGIcYM/6qIeCCvln1vs5QK0/gkqdWN77In2Wh/ZSfkxJkhTz9VXAT9QWGGe4K8P8IdbwyFVHpU8YjsyAt3EiV/CDR6+Vu5WAf2vX+NOTD5h3tw8FwsovdDI4ZDzPcfTPlcPBxKK7uPr2KxR2EuKJKVnVx211R5yw4TtF9g==
Received: from PH0PR07CA0084.namprd07.prod.outlook.com (2603:10b6:510:f::29)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 20:49:41 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:510:f:cafe::b7) by PH0PR07CA0084.outlook.office365.com
 (2603:10b6:510:f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 20:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 20:49:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 12:49:20 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 12:49:19 -0800
Received: from inno-thin-ubuntu.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 12:49:11 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <jgg@nvidia.com>, <gary@garyguo.net>,
	<joelagnelf@nvidia.com>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v3 0/1] rust: introduce abstractions for fwctl
Date: Tue, 17 Feb 2026 22:49:05 +0200
Message-ID: <20260217204909.211793-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: cab2a54b-9a23-4f10-77b6-08de6e661224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1g4KyswaUtHRnUzVlBhUEN3SlBDdXlLL2lEdW5wS05nNmxvdUdDc3pqUWZv?=
 =?utf-8?B?U2I3ekRkRllTU2lkNXphUVNUbGo4VXJ2QnM2Z1Vac3VucTJscGJKYjhlSENr?=
 =?utf-8?B?dzU4d0p1UFdreTFReDZ5S2ZlRDU1dlpuUVBEdXJtNU5Bcm5mOEUyZmRrTXRi?=
 =?utf-8?B?SkVIcXV0aG10NlhQZy9ScTVBNzJNd1FRQjBjUTJjR0xTRlhOWDg0SE9LWHo0?=
 =?utf-8?B?bFUyNUswVm0xUlZVZUZyZHJ5bEFLaVlialNJZXhRbHAraHF5bVpvSHM4TVQ4?=
 =?utf-8?B?alhtODBBbDQvcWFFTnVCWHhyUTc3akM3bXBLRXdwckhUd0FKcy9lSkIzNU4r?=
 =?utf-8?B?WEFraUorcVdmYlJrMHdPOFBndEk0MGF5UHRBSktzNHBmaGFtL3F4amI2czdm?=
 =?utf-8?B?MUlNSVV3SkVxY1llQ0wwZC8vZzdQSWtNbjN6dGRjcnpvRTdPTFVWeHRCTzBu?=
 =?utf-8?B?akwzNiszazU3VHlxS2N3M0JWalNSc0NYUXdpdHA4Y1UxL3VLbkRWdndwa2xS?=
 =?utf-8?B?RlhCeVlNRXhTNHlsc0JEY1ZiREZ3SDdjK2RTcjlOSitLemorZjhKbTZNODJ1?=
 =?utf-8?B?NVRwVlMrdU1MSW42OWJZT3BZa3htTVNxejNZVTV6cVV6V1FnbHJ1ejY0aFpn?=
 =?utf-8?B?eVk0bUNQQ20yc09LbDVmZW1ZWDRiMlE0bmJDQlZpdlhsOGIrdlp0SjV6RlFZ?=
 =?utf-8?B?dUJjQTVJZnpJazREWUFUeHZpS1hZdUQrTUF4V2xLdENaUkFLenEwNlNLNHNI?=
 =?utf-8?B?MXV0bzlwZFVxQ21GcVhYMjl4QlpOS1pBOEZaSVJWdXZ2NXBJMWRRTXpGQWZM?=
 =?utf-8?B?OG9VdkMwOWdnRlhvTlcrM0k1QzlFaEIyY1I2STFha2JoNjNGckI2TmUyanMv?=
 =?utf-8?B?ejYvWU02SGRVM0Nsdi9Dc1dQSVQ0cEJrazhpcXpuUlZDb1dFbCtGZVo4Mmti?=
 =?utf-8?B?TjliYnpGM1lQcHBzc0g2Z29DQ1BXOVpmNlA2OElLYm9JTk53MnNpcUxSYTlt?=
 =?utf-8?B?UkhCbEZOMk8wMlc4QmJNaW9NL0d1Qm94R3JEb0tySTdrUTROTWRiUFdpS0hD?=
 =?utf-8?B?SThXMmZlVU93TlVPZ0lNUmpJTVNCSldxWUR0RWlIanU4bE5USzJnd2poNlln?=
 =?utf-8?B?UmVNdzNpbHNFc1VWckoyQlkvZkpCbG5CWmN1MXowaFpUUE9idHA5bEVXcG43?=
 =?utf-8?B?dnE5M3h1R2xVWFBXSjFLY1l5SWJhRm9PWjdWWkIrMnB2akJIb1N0YStqK1Nl?=
 =?utf-8?B?Vm5WQmpiSE5RSHYzdEF0ZW9qUnRJM285Z3VqS3RSN2RXZjRKYi9SWEpTekc4?=
 =?utf-8?B?UXZlWnZXLzNoSFVyU08rS1J2bTRiOXU1ZEdXUWFnVWs4bkNYZjMyNGE3YUNa?=
 =?utf-8?B?SysvYWdYQlI3d3Q1ZWttUk9HV1RKS0tzVEhsaWZWTEpGdFhYOUN6d1cxT2Zy?=
 =?utf-8?B?RDdjT3RYdXFlTW55b21pLzRhMlBsT28vaW51OGo1TWRVRXovUGFDeFZ1a2Vk?=
 =?utf-8?B?RWVvZGtVWHE4L1hSQmVtT1gyUnpRYzhReEUyYXZOU01ucCtFZW5IQkFKdkYr?=
 =?utf-8?B?N2s3OG03T3psSmR4TVozN3oxc1BDdFlkV2FydGg4bjVUVHEzUkJ4REh2K2h4?=
 =?utf-8?B?UFgzQlpLUis2ZzFxdVhhQ016TExTT2oxT3IvWnozMVY2SlgxN1JLNW9hWFBY?=
 =?utf-8?B?RHZNdUVoeGxkM25WWVUyN2l4aHFkaXJWaXFBazNQNDBnVG05bmlkUmlwd1JE?=
 =?utf-8?B?QXMxYlpBUFVNK0ZzVTJTaG11MWt0RnEyN2VqNXRvc2dEVDBKOERYS1pWYkZm?=
 =?utf-8?B?QjAySnM2SW1JTXVNTkQvOWJIaHF5ckp3bThtd2o4SXBiMG5oWVA3TkhMbXRx?=
 =?utf-8?B?bFFXYmZQeXN3TUJNZU5uVjM5VXhKQVNmbS9ZVnBtWmxDbWRucys2S2U5bFJN?=
 =?utf-8?B?UzRSYzRnUlo0bGVPa3k3WHJQUHlIaGhhRjBBRCtUbm8rSjIxUEZna1RtZlhz?=
 =?utf-8?B?bDRxOVdQRUovci93VWQzbnZqamNLK1FFLzd1bDZpa3R1U0k3MXdOeGFURkVV?=
 =?utf-8?B?S1YzMlljc3d1MVhvcUhZK0hobmhRQXVFY2RSYzNQeEFSMEtLS21LdnNGMnJr?=
 =?utf-8?B?ZlAyUnNUcEFUTmRRLzBOTjJZN29jV2VZRzRLU3ZtcWdSR2tHSjFaNUZYTE5X?=
 =?utf-8?B?UGFZMy83SHgyZjl0NGlQTmZIM0JoSnZiQ1JoOUZmN1V0aEFTdTRWalBWSmw3?=
 =?utf-8?Q?+OmtzZXgFY+TBPt5shlrHUNOmhOXBF1wS9PSSvYECY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rkQM2m1e4tVSgFx+9UhIFfbqQ90s7gE2uE9vlgLmrwTSvV3jCibwY74mGX8ezw1wxo0HnhVYO3qDcAql4k/dqJ++U+/9SgdyCIq34tIxPatfplGVneltPtIbXp4RPib/V/sCsCJXkifzZGA+OjbXde6hubErlwLIlVr4pnoFj5ASF4rqy/2xB9prdiZtS9MGXzVJV8IhI3kQBEQF4B5VisItXU0BcrJdm5Cc4qg6GbZdSGoYwfOZGru4scjq2zliEQ3VBGC/UirBNtBiDvTEIYdXXYpyWGNaEImk+rbolJ4ma+pZwjsrnQTScmtk2L4EypJI3MXAUtGdQ+bvuuFaxjwvHEBUAEZf3rj0AQMnYp9FgSUtw+veuh+2SATX4DE9vFNfzm/szKTUXDbxbx534yRdlq00g+9dgUL2f3fdayK/aT4FsOoYX/4n9QfBmrSF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 20:49:40.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab2a54b-9a23-4f10-77b6-08de6e661224
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

In the NVIDIA vGPU RFC [1], the vGPU type blobs must be provided to the GSP
before userspace can enumerate available vGPU types and create vGPU
instances. The original design relied on the firmware loading interface,
but fwctl is a more natural fit for this use case, as it is designed for
uploading configuration or firmware data required before the device becomes
operational.

This patch introduces a Rust abstraction over the fwctl subsystem,
providing safe and idiomatic bindings.

The new `fwctl` module allows Rust drivers to integrate with the existing
C-side fwctl core through a typed trait interface. It provides:

  - `Operations` trait — defines driver-specific callbacks: `open()`,
    `close()`, `info()`, and `fw_rpc()`. The implementing type itself
    serves as the per-FD user context, one instance per open().

  - `Device<T>` — wraps `struct fwctl_device` with embedded driver-
    specific data (`T::DeviceData`).

  - `Registration<T>` — safe registration and automatic unregistration
    of `struct fwctl_device` objects, living inside `Devres` to ensure
    teardown before the parent device unbinds.

  - `RpcScope` / `FwRpcResponse` — type-safe enums for RPC scope and
    response handling, keeping unsafe pointer manipulation confined to
    the abstraction layer.

`rust/kernel/lib.rs` is updated to conditionally include this module
under `CONFIG_FWCTL`.

The repo with the patches can be found at [2].

v3:

Quite some updates in this version. Here you can find the example
nova-core fwctl driver [3]. The interface is still WIP so it is just to
demonstrate the use of the rust fwctl abstractions.

Comments from folks:

- Use an enum for the return of fw_rpc. (Joel)
- Remove FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST together with the sample
  driver. (Jason)
- Remove DeviceType:Error. (Gary)
- Add __rust_helper for fwctl_get/fwctl_put. (Gary)
- Refine the design of the device private data. Now it has a similar
  device private data structure as DRM. (Danilo)
- Separate fwctl alloc and register in the abstractions. (Jason)
- Registration::new() now takes &fwctl::Device<T> and the parent
  &Device<Bound> to align with other class device abstractions. (Danilo)
- Update the Registration SAFETY comments. (Danilo & Jason)
- Take self as per-FD user context in callbacks. (Danilo)
- {open, close}_uctx -> {open, close}(). open() now takes &Device<Self>.
  (Danilo)

Updates from me:

- Introduce enums for fwctl RPC scope.
- Introduce AlwaysRefCounted to avoid hacks after introducing the
  refined flow of device private data.
- Introduce default implementation of close()/info().
- Fix a leak: Drop T::UserCtx in the close_uctx_callback explicitly.

v2:

- Don't open fwctl_put(). Add a rust helper. (Jason/Danilo)
- Wrap Registration with Devres to guarantee proper lifetime management.
  (Jason/Danilo)
- Rename FwctlOps to Operations, FwctlUserCtx to UserCtx, FwctlDevice to
  Device. (Danilo)
- Use fwctl::DeviceType enum instead of raw u32 for DEVICE_TYPE. (Danilo)
- Change fwctl_uctx field in UserCtx to Opaque<bindings::fwctl_uctx> and
  make it private. (Danilo)
- Provide Deref and DerefMut implementations for UserCtx::uctx. (Danilo)
- Add UserCtx::parent_device_from_raw() to simplify parent device access.
- Use cast() and cast_mut() instead of manual pointer casts. (Danilo)
- Implement AlwaysRefCounted for Device and use ARef<Device> in
  Registration. (Danilo)
- Add rust_helper_fwctl_get() for reference counting.
- Improve safety comments for slice::from_raw_parts_mut() in
  fw_rpc_callback. (Danilo)
- Convert imports to vertical style.
- Fix all clippy warnings.

v1:

- Initial submission introducing fwctl Rust abstractions.

[1] https://lore.kernel.org/all/20250903221111.3866249-1-zhiw@nvidia.com/
[2] https://github.com/zhiwang-nvidia/driver-core/tree/fwctl-rust-abstraction-v3
[3] https://github.com/zhiwang-nvidia/nova-core/commit/2068da7e8caf58da9584b0aa6c81fed8f547d59f

Zhi Wang (1):
  rust: introduce abstractions for fwctl

 drivers/fwctl/Kconfig           |  12 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/fwctl.c            |  17 ++
 rust/helpers/helpers.c          |   3 +-
 rust/kernel/fwctl.rs            | 449 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 483 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/fwctl.c
 create mode 100644 rust/kernel/fwctl.rs

-- 
2.43.0

