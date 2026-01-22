Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46E3A89CD;
	Thu, 22 Jan 2026 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115568; cv=fail; b=W0k40m1xfZ0VBW3n87jX9DNyqeDiivqIgH5dmlMxLYxAZXolUa18Ngjpez5oIT5OVVYItXBHRevpcfZtI8VIrMQERhFpUpexxytm1l3QNHXoFAwbuQpmzUtQe8zm1MhTJZ1YX1PNxY91Jav2bnEpWd23kfE86LCyGqhodOGNPDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115568; c=relaxed/simple;
	bh=eC6y95uz0nTdgdeAtLLZ91BqgkrFwYClBQ1CItPhpWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pi9uqEuuDOxIzvaL76tIr7zDbPyCsWr9EdwfyXUYsD5bHo9sUmQGcBNcnCYaRMw3m7iE1uNYpJmRNH0Ffzs44a6ZfS6OyEWE9Uw2gsxRKJaBGUXTs6ueCxXMfWjbOx3E6LCeBEU4x9wN7PThOx4FWBAl5HfDHpC904MPC8Ja0Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LlhmAjrz; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LlhmAjrz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmJaLVrzDn0fTIFuTyd4d7STUmywI6csYUu6UUWh+DfSB0DJ/jGQnGU972Yal5gRsKRILR4pzuL7Tl2V2o50xyItnZEv8J0wEKykX5kMTedbbHr1xe2xEY0w5EET3PfMvqk3beiFDqezajFrEkhasc0BEvugwUxF0tCuz6m6tknSXLaxniy9cyztiZRMOfi28/cG2C7RojauJI/1+9oYyxnhHXMlMqrnNPK0eHPV41l1xqg/3t+4Ag4D8dkyeGoeeymPh025V2gtaaDqBoRwZGsYoF1IJSQMS3e/Mjb7Ydnt870AFh2J8+6j7pD4NtO0dPJKXg+bwY4ky3gvdhpXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au+sNWCerbfU3uF+yDwILBID3nw3tmObPa30oZpXa/8=;
 b=w3JzyYB1ByRe1UyQN/lJsjpSILegbSC+1uUbRH4qXH0g7FjOpNkfltCjuzA2mqQPrADYfzlKiqVEMDoilgU0XMva1Fdt4adXcyJXKswj2DrBL9Uvu2Xj61Ax+vW21l6Fbibhp3DYoyEQAIvwMTCClX2pfie0e7iuknizNWeCEgiayKJ2zpv27HdNFi9FvjBlDPGJ64ExS453ECXFr2MDj/SXLbhuAOZ+e3lTxf8a+7lv8J8ZsJiaZtNqfyKzpgqXELey/hHN/RkXQDQTNIF29K4X7ZKNUrOjWRfkNhufjMH5GQI+LlO6fsJpSg61eHR3l1XQ6PW1aMMiIBtZJc4vtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au+sNWCerbfU3uF+yDwILBID3nw3tmObPa30oZpXa/8=;
 b=LlhmAjrzUwan6vvNed7gXC6/HPg/+RGKJFSbI/InesJQCbuYlbLmjqfOUI8kow6r2oGAfZIvfbEFbOi16HG7vlXJtvP6/xZUGX5ixlGuRkcTZHMacCZ67i2dPuN0+Dxdhq+rauUdJpVWRdxfP0VKsQJ7fVEs2vZIel18lTxXQhygZ8Csv765qKpmKgy7kpZcJ4CJOTY7WtpGwHyOzYFluqwB9HplVGQ+brdEYDFgTsOpsxtnDctRd9CPshPe5YXtYNE4KG9HQKE0FpTYw3i2DcCIj4tcwHdw/cceGlYPKnqolTpm+sb7Pa26oSN1+yYHi2uU1bvw3QnOFfaKIMcFRA==
Received: from BN0PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:e8::6)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 20:59:16 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::b4) by BN0PR04CA0031.outlook.office365.com
 (2603:10b6:408:e8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 20:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 20:59:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 12:42:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 12:42:40 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 22
 Jan 2026 12:42:34 -0800
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
Subject: [PATCH v2 0/2] rust: introduce abstractions for fwctl
Date: Thu, 22 Jan 2026 22:42:29 +0200
Message-ID: <20260122204232.15988-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3d75d5-188b-4c7a-bf2a-08de59f91a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2JSQWhsY0pYbEtRT3Y2d1hzWk01YkU5bStDOVlVNXJOcXh1a0FSVEVJNlhw?=
 =?utf-8?B?VzBKZmZjSm0rMnJ6RUt0MWVTT1R3aGlFQTJkWHJRYVA3V1N3SjlnekFvTUdN?=
 =?utf-8?B?UjZEbjhBQzBrOTJRdlJleEVveitjaTBremU1a0xKeVFKSE1JL2Y0MXhIODAw?=
 =?utf-8?B?cmdzQ1d0d1pGck5YS0wyajR4UnY4c2hwN0YxTVBWZEtWdDFZaTFiYk9GUUZm?=
 =?utf-8?B?akZmWHRwM3dHMTRLbU94ZFhvdllnaWxXZ2k0MlZBNFhROG1COWFmbTJ4aXNn?=
 =?utf-8?B?a2ZDQjdYNDJudStaWmVWN05xYzQ2bW4yMVh4VDBYU1NpYk10cWdpNytPNElK?=
 =?utf-8?B?dXAvNG5SWmpRRGc1eU55Z3lMODZOUDA0SG9rOW8yKzM1VDd4VW01Q0RxWnNu?=
 =?utf-8?B?Z2o3eUoveVlpZ1ljd1JlcW1IZ0Ntd1BWbkg1M044TmpPK0RYdWZKUHZrMlN2?=
 =?utf-8?B?Y0FoTjN0OHN4Vi9VRXN1OEt0OHZtU0hYS1NkWm1ueXY3dU1jQmhQVEpCRXhW?=
 =?utf-8?B?dE95TlI5WTVmdUJURjF4RnJrM1NOWmZ1c0tMMVVnRmw1dmMwd295WlREK0hL?=
 =?utf-8?B?Z3FYeUJxNmRpQ044SWVSclJ2K1hTd2F2dFovWnM0cTNZYi9CY0xCUGsxY2c5?=
 =?utf-8?B?V3QvWEZFQWFZcWlnU0RYV1htekVVLzBjUlZRMkRRMkI4UHZrcFRWKzh3VHdh?=
 =?utf-8?B?Tkw1Nm0wYm5VM3lzbzk2b2o0TkJsQ1NyRFVqMUY0aXFnMDFvRjBHeHZSazNM?=
 =?utf-8?B?eVdLWjJXOWtKYlYzb1JnL2lDemJPejQzd3NFWGZSODVWa0lyVERqN3dFaDhW?=
 =?utf-8?B?eGJiUWsvZndBaXQvZlprWnppN0tRaHc1dHRhQ2k2MTZXY0xaQU14Q2p1THBt?=
 =?utf-8?B?OCt3M3p3dVE4M29aYTJvMnhGcGY0V2h1L29ZaHVOQmNoSkFMTzBnYS9LekFD?=
 =?utf-8?B?TFRHaStRSFlXckY5SDZmSzRUMi9mRHV3ajJCcDMyeWllU3ZDUHpsK3hUcGpC?=
 =?utf-8?B?S0w3SUQyMFhOSWVNdkg0cnNnRFBNaHVYZDNOS0YvOE5WQzVtczFQcG55Snk5?=
 =?utf-8?B?b2JjNlE1N0s3SHZRck1qa1lPeWNjUGVLZzlGWExaa1p6RjFJQ3BQemE0eVRW?=
 =?utf-8?B?aDBadXIrb1FFZ2pnblp5dHVwbVJCSHYxN2kvalVyYTBzUU1kUFo5cVh4VCtO?=
 =?utf-8?B?cEE0dHk0a2F0UCs3RnB1NnVMeXoyNFZJUysyeHpjZVJUclJZbGViaEdUU0Ji?=
 =?utf-8?B?NjZXMk5pWWlUOTZteGt1Nlg1enovb1BjekpLVDhDUk9OREJGdk9sVFZVS1o1?=
 =?utf-8?B?RklaTC8wM1JKek1hajRmZmR3N3JSc2dtaHRjOHJNZTV6ZDgyeDBTbUx4QnZB?=
 =?utf-8?B?a2d5WEZKSFdUZCtydXVhcVh2U0J0dWp0Tnc4aW5aTDVUVzdUTFhpWUhHa2dH?=
 =?utf-8?B?QUdTUFRlUm1RT3kzVEZFbnZHUGk4NVRrRjhUbklqOFpJTE1ZbEgrWE05K3hL?=
 =?utf-8?B?Q1dpdGZBbGhjUkpJdzJTRk94NWdDWUxTVm1QOHUrVTlxVC96ek41QWlsTzVR?=
 =?utf-8?B?RjhFMmlXM0lYZEQ2bWZEWCtEcnVHSTFxc0x5V2hzN2JPMGxPRDlmenQ0b0tJ?=
 =?utf-8?B?b3RRYSthVDBxWGVLb1pyMjE5Q1BjV0dmRk5EMEhUZlAyTjdXT0FWcm1kWjZJ?=
 =?utf-8?B?U2NXSnYvd2prNnFqTXhITWRiRHB2UnNYTGM3SGIwaHdpTGg0djRoVW1ocXZn?=
 =?utf-8?B?Nm0xbDhEZzVzMHJGOS9JbW1iRXZRR0lRR2ZXMFpTK3dZenhxcjdyMGJ2Y2Rp?=
 =?utf-8?B?clRhcmlCWkhXVU9GMzdPbk11SWZpRTB5YVVOZlErYW5WR3RhZVBzdml6L1h5?=
 =?utf-8?B?dXVBS2dobExESTFqUStEaE81bWJnRkc2b2FFV1RnY2NMeFh1K2QvT0VadlhK?=
 =?utf-8?B?dW5qS1pWSHNVNVNIcHY0S29oWWRsMW1LRzJ4Z3pCRDAvRThyR3dVY0EyUEZK?=
 =?utf-8?B?ci9NRUpTVUNsdkVTTUhRQUovdmxlcTZZdW1CUzU3MFc2Z0E3c2dJcGM1d0NT?=
 =?utf-8?B?ZlJXUC9RZ3BGZk5YM1kzRTV1RUJJcXFWcWhWaHZzVVlGRGdrZjZHTnJKVG5Z?=
 =?utf-8?B?ZENVN25kSUppWUpCTWhSMnl6OUdnbVFhdUs2UGs0ZUM1eTlLZDZFdmEwOTRl?=
 =?utf-8?B?MDNCZGQyU3l5Y0tHb1ZSblpvVjVGTGVLb1drQ3NVa1hJQzh0cDdiZlllNUpo?=
 =?utf-8?B?bG4rS0pxUU9lUmxVS01tU2ErVkxBPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:59:15.8459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3d75d5-188b-4c7a-bf2a-08de59f91a8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988

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

  - `Operations` trait — defines driver-specific operations such as
    `open_uctx()`, `close_uctx()`, `info()`, and `fw_rpc()`.  
    Each Rust driver implements this trait to describe its own per-FD
    user-context behavior and RPC handling.

  - `UserCtx<T>` — a generic wrapper around `struct fwctl_uctx`
    embedding driver-specific context data, providing safe conversion
    from raw C pointers and access to the parent device.

  - `Registration<T>` — safe registration and automatic unregistration
    of `struct fwctl_device` objects using the kernel's device model.

  - `VTable<T>` — a static vtable bridging C callbacks and Rust
    trait methods, ensuring type safety across the FFI boundary.

`rust/kernel/lib.rs` is updated to conditionally include this module
under `CONFIG_FWCTL`.

The repo with the patches can be found at [2].

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
[2] https://github.com/zhiwang-nvidia/driver-core/tree/fwctl-rust-abstraction-v2

Zhi Wang (2):
  rust: introduce abstractions for fwctl
  samples: rust: fwctl: add sample code for fwctl

 drivers/fwctl/Kconfig             |  12 +
 include/uapi/fwctl/fwctl.h        |   1 +
 rust/bindings/bindings_helper.h   |   1 +
 rust/helpers/fwctl.c              |  17 ++
 rust/helpers/helpers.c            |   3 +-
 rust/kernel/fwctl.rs              | 456 ++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                |   2 +
 samples/rust/Kconfig              |  11 +
 samples/rust/Makefile             |   1 +
 samples/rust/rust_driver_fwctl.rs | 136 +++++++++
 10 files changed, 639 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/fwctl.c
 create mode 100644 rust/kernel/fwctl.rs
 create mode 100644 samples/rust/rust_driver_fwctl.rs

-- 
2.51.0

