Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654F343D8A;
	Fri, 23 Jan 2026 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163308; cv=fail; b=QFHVPfcCLy8G+wGFp0PRaa0O38wkqXLSRxUexQm0xqPvq4MPPu7vSOoQocd44jR0Y2uV3C3AyrG14SabPBrpqquKVgvOMjcjXtZwvuv7gMxLahlILsEvJyCts1EvzhXR11/kF+WxB3KVVh5gwJ95uuaRMfWykZRYsHJHYn7Hqdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163308; c=relaxed/simple;
	bh=sXS1GOLavsno+k0zw2goc3Ia16eno/wg0ZNQkVLvo5Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTtyW3sZoYe4YPVLzpEVgo96CyBqNiZEW8v9jhLLa4eW3Aq7LhYyzcFh0a4ZuhbCGy7C1iHYvx36JGSggdoZmVee5F5a1zSEpLok4YNJWEEsBwVhG57kNooDqFz32PHwUUPh7FVaFOeUZkZz+Wt6tmBOj1softAq7yHBJ13Avu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FslaceDw; arc=fail smtp.client-ip=40.93.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FslaceDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgMRc4aHHPTqd96pyA4fr/fgJSRklSxR8SFspDAwSrUfSJP3YvexLbLnVRBxNIMx+syIY4mJ7pVCFEZvoFgcWN7219lATXuOvMWrkQl9lw9kULqWDIbaBbwoKotln9SeLuLwCUyxzJKBffxtYkBk5mXAknn0ElCsYQXFD1pobINwIlX/knQIE1rTM/2ouXnQto/4a2zZ/sRyI2q7w1zBzJMdv930I5J1gKr27/GinEYv5/OBr/JK9inJ6QF1USU8HPXXMcgXRQk78AkY81fYF1o3Di1gQHQlH0ssy0d2Tot+aRK9fSFGsILSAR/jQ8sOl+R96G9m4Ux1Vsif8ktQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNLILcD8nZjoXPovXAgAp7i2FinyB3Bivri+oAVgAXY=;
 b=NQ5yM2D9uL284xP9hTeG/WGHr4u0CXQr8cewuWB/nejNvFm3ZMDwSXPied6THH39lwFibIQqt1+kHiJGpjfUY7vEUrGnuGyoXSS08KCEYsh7tYx/NAYyrbr1+l46SAry8wYXGsBtq6JgjJ+u/0P7zaOt9VYuX+oMCWKoHkRNezBeX7F2fPEyEWT19T4bmyh+YipcwW5ivy3B0mc46BnYAZEDFISKDPcxcmBl7k2jPRtrChUCD3Dpvcuo63bHIu8MFxAojlcU3kaRyxYT2/Y95RebM0+odynC7OGYwaNPSbYYctssvWD10u5BCDbrylT16cEzfrRroI1dqIEB7WT4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNLILcD8nZjoXPovXAgAp7i2FinyB3Bivri+oAVgAXY=;
 b=FslaceDwBf6T+3Q9ob66G5UxxdOoDijQWQJhYAPqZ//iBHvnGoQZjTwcMKT0vpQrPIeNfIVleH9U413qS95CnU6+IzxTclypVS/AGyk4dbHO+32lpltIT5b2uMfYbZMjV01yjgTdwlPPXjSWjlO6XQavmMRpjJAfENwjYf7MM2edU50Qzqkm2tMMT6fNtm8ERzKvAJWRuWb+DXJuAwfSWqT5b1EkDkCw9vbfBf1yxFPxCfi7rOHh9U2O/CSY2d0cFXFRQD4EpFjrbNTBomJ2MXjAvqIonnu/edtbggMOD8CnFdYDJUTt/Hle9nb7oMpCdXE6vDZh+bRd5OH96Af2hQ==
Received: from SJ0PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:33f::18)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:14:53 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::62) by SJ0PR05CA0043.outlook.office365.com
 (2603:10b6:a03:33f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Fri,
 23 Jan 2026 10:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:14:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 02:14:41 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 02:14:41 -0800
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 23
 Jan 2026 02:14:34 -0800
Date: Fri, 23 Jan 2026 12:14:33 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: Re: [PATCH v2 0/2] rust: introduce abstractions for fwctl
Message-ID: <20260123121433.2374df00.zhiw@nvidia.com>
In-Reply-To: <DFVFTMRD9LM8.HGKSL57RYD1D@kernel.org>
References: <20260122204232.15988-1-zhiw@nvidia.com>
	<DFVFTMRD9LM8.HGKSL57RYD1D@kernel.org>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d76266-f084-4a9e-a6af-08de5a684014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2VvNnlJVlBNZnIydlRMZkJmTGMwUy9YTHFqRVppUEdYbWJwcmZscEtSOVpQ?=
 =?utf-8?B?UVFSOUlYdlR1OTd3OUtpTzVsZng5THlGWmQwRGdUMkVRWXpVVnp5TC9YZHZw?=
 =?utf-8?B?M2hVeEtZcGw4Vm1MbVdpdjcyTU5WVDJaS1BDL1YvU29OWHpRWUFKOWtlMlc3?=
 =?utf-8?B?NGs0bnRiS29IcWJrVG8vckZtMStkQ2Q4VDJGLy9WUUo2UDR2SlMza0xEMlZS?=
 =?utf-8?B?aW03V2o5OTVISEtFTXFzN0VGNjBWbzhCK1hRUnpUWnRXeTN6c01LOWgzdHdB?=
 =?utf-8?B?ODVPazc5V3pOUXZrb0s4Y0xiQVhTbUdHdHFod3RsREVoVGNSZ3VwZ3RWRDZ5?=
 =?utf-8?B?dEZiZENKa0VkWTh3NkdpanBsTUd5OURUS3lYRHQ5SzUrR0dpRFVxbURnY0JP?=
 =?utf-8?B?MHdrQnlPOVZRK0gvSEZiUTUvWkFGZ0lvS29ueEhqOE94cVpRNXVsZ2Y5c0pU?=
 =?utf-8?B?b0JMcHhmeGowRk8xcFFMNzczaUtHMnRLMWp2c1VkZlFkeTZFTzB5MS9UdWNT?=
 =?utf-8?B?ZmpPQzZPMXR6TUZ6RWtSVGFKSXJNSjQvdWZybEVTb0YvZnZIemM0OFVUVWQy?=
 =?utf-8?B?SDc5L053ajkxeHpydjRyb2tUZjR5M2puU0lWM3ErOXpyZ2s1cXdDZ1NONU5v?=
 =?utf-8?B?cGE0QTVLQmcyY2ExZHJBeThNS0dZVDE3SUtQdjFBOHJCMmhvQmJQclNpK2ty?=
 =?utf-8?B?UXhTZm1GZnQzWCtDbEFDempYUitDRjZyaDNKQmI1bDBjZzJya3FYM0pNclFH?=
 =?utf-8?B?SDZoM3pIMk1vUGZmQXpseCszcm9hL0VCQWpucVYyVzNJNVl6cEVaS2VDS0F2?=
 =?utf-8?B?cTBnVXhBSXR5M084NDJSVUdlRUI3WERGdE0rRm02UUdGNlZmVExtakE5bTFK?=
 =?utf-8?B?OVFxaTBxSE1sTWN6clBUTUFwSmFyc3IzNlBEdGd1WFF6Q1NvbHZEQTB0TUM4?=
 =?utf-8?B?dldzN2lvWWlPdHFDdWFaZWdwalNBNzAyRFNnS2p0TUQ5cDkzZ1JyUCt5TGRN?=
 =?utf-8?B?Q3REelB4M24yWTVRcDdUSXdoQkpVemxRemRxcjlYRS9lWWpLRXpCOVFxRk0y?=
 =?utf-8?B?emwzYkIvT0dDSUNzUWxtRE1XYlRmVWw1Z3VySUJpRi9JRHFVYUtRNXpLRXJo?=
 =?utf-8?B?SHZuOTBPb1lSWUwxNmZlcFQwWjIwU3NIK21KRWJiMHR3S0paTWsvRDVhUkhk?=
 =?utf-8?B?b0pQbC9rbVhNaU5vSzhwbFNXNkx0U3lyVHVJWHpDWU9KdmFCa1V3RWhMOWdY?=
 =?utf-8?B?WkhnMi9kR0M0L2ZKeEFOcEVwYjQ3eWxnQU9CQzM1amQzWTlUdWV1MG5sSmVE?=
 =?utf-8?B?eDQ1aFkrWllocE9DRDRqVmNFQkxONUlFZTAxQ1c5SHdubHR3T2ZPWkVEdFEy?=
 =?utf-8?B?ZmlyRGlTcWFKakNyZXQxNGV0dDB5MExRazdvSCt4em9vVktqRW1ZUHVMNmQw?=
 =?utf-8?B?TDNMT1hZMnE3ZDAwdDl2NXZyMVppK25wNEswZ0MzQWpLNnltN2Y2ckZYdVZa?=
 =?utf-8?B?TlZoRkw0eXZKMUF6R0hEdVdkVUdDM3lhQWNRRk5FZC9Jcm9zU0lPQlVIWVRp?=
 =?utf-8?B?dndXdldzaEMzdE1CdWZXSWVEaWg0T3EyNDBya1pqL3YwaE56Ky9pR0dyVE5D?=
 =?utf-8?B?R2lkUkNuZFdMYmQwZWJ6Q3NMeW82VW9EakpCSHJOak9zakpVNU5USU9QaHd0?=
 =?utf-8?B?MlFWWThHSTNXMW00eVM5OHArTXROLzRrTkpqWjRBQy9hQU5lWFE5cjBlVGZS?=
 =?utf-8?B?UEdGMWJqaXZuZ21pSWhYcnJmV09mbjQ0T3lxbEExcGpSZFVCWjVwNmJmMHhF?=
 =?utf-8?B?Zi96VTZGNEQrT2ZHTlBRWW94ZWtvb0h2YUNRN0hNeE45SHZpd2dDVEpMdy9T?=
 =?utf-8?B?UDFZSXVzZGprT2duUDQxZmlhRzNEUVlnMGpTMVBqUU1LQktxUHZIc2FnSkNi?=
 =?utf-8?B?aUpvckwxbWFmbi9hWHFRS3pneTUzZDFEYmRlQTRwSzdEZ2dsY1czbEZLMHBq?=
 =?utf-8?B?RytPWUYwdWhMTFhTZTk2VEdtR1I3L0M0V0NJbkEyYnpJWGtGbG5NYUJITmtN?=
 =?utf-8?B?eUFoRzdzMHY3UjNlUWlKT09wY3h2ZFhTNXNLQlU4d0RocXk4SmF6R29zUzlN?=
 =?utf-8?B?OXhWZitjb3RYNW9RbFFMc0J5ZjE0a2tOczB1YXpDS3NKeDZtQU5BYnV4cllN?=
 =?utf-8?B?MU1MTU4xdTdNSU5iMEg1aCtoajVnMnZ3aDVjSWNUeWsySCtQcTR6RXU0Tkdv?=
 =?utf-8?Q?sZ95SljQn+d49U/QEWpp209GP5nvtE1gmxxo9VbM3U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:14:53.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d76266-f084-4a9e-a6af-08de5a684014
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455

On Thu, 22 Jan 2026 22:32:03 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> (Cc: Jason)
>=20
> Looks like you used the recipient list of another patch series by
> accident. :)
>=20

Sorry my bad. I would prepare a new script for this series.

Z.

> On Thu Jan 22, 2026 at 9:42 PM CET, Zhi Wang wrote:
> > In the NVIDIA vGPU RFC [1], the vGPU type blobs must be provided to
> > the GSP before userspace can enumerate available vGPU types and create
> > vGPU instances. The original design relied on the firmware loading
> > interface, but fwctl is a more natural fit for this use case, as it is
> > designed for uploading configuration or firmware data required before
> > the device becomes operational.
> >
> > This patch introduces a Rust abstraction over the fwctl subsystem,
> > providing safe and idiomatic bindings.
> >
> > The new `fwctl` module allows Rust drivers to integrate with the
> > existing C-side fwctl core through a typed trait interface. It
> > provides:
> >
> >   - `Operations` trait =E2=80=94 defines driver-specific operations suc=
h as
> >     `open_uctx()`, `close_uctx()`, `info()`, and `fw_rpc()`. =20
> >     Each Rust driver implements this trait to describe its own per-FD
> >     user-context behavior and RPC handling.
> >
> >   - `UserCtx<T>` =E2=80=94 a generic wrapper around `struct fwctl_uctx`
> >     embedding driver-specific context data, providing safe conversion
> >     from raw C pointers and access to the parent device.
> >
> >   - `Registration<T>` =E2=80=94 safe registration and automatic unregis=
tration
> >     of `struct fwctl_device` objects using the kernel's device model.
> >
> >   - `VTable<T>` =E2=80=94 a static vtable bridging C callbacks and Rust
> >     trait methods, ensuring type safety across the FFI boundary.
> >
> > `rust/kernel/lib.rs` is updated to conditionally include this module
> > under `CONFIG_FWCTL`.
> >
> > The repo with the patches can be found at [2].
> >
> > v2:
> >
> > - Don't open fwctl_put(). Add a rust helper. (Jason/Danilo)
> > - Wrap Registration with Devres to guarantee proper lifetime
> > management. (Jason/Danilo)
> > - Rename FwctlOps to Operations, FwctlUserCtx to UserCtx, FwctlDevice
> > to Device. (Danilo)
> > - Use fwctl::DeviceType enum instead of raw u32 for DEVICE_TYPE.
> > (Danilo)
> > - Change fwctl_uctx field in UserCtx to Opaque<bindings::fwctl_uctx>
> > and make it private. (Danilo)
> > - Provide Deref and DerefMut implementations for UserCtx::uctx.
> > (Danilo)
> > - Add UserCtx::parent_device_from_raw() to simplify parent device
> > access.
> > - Use cast() and cast_mut() instead of manual pointer casts. (Danilo)
> > - Implement AlwaysRefCounted for Device and use ARef<Device> in
> >   Registration. (Danilo)
> > - Add rust_helper_fwctl_get() for reference counting.
> > - Improve safety comments for slice::from_raw_parts_mut() in
> >   fw_rpc_callback. (Danilo)
> > - Convert imports to vertical style.
> > - Fix all clippy warnings.
> >
> > v1:
> >
> > - Initial submission introducing fwctl Rust abstractions.
> >
> > [1]
> > https://lore.kernel.org/all/20250903221111.3866249-1-zhiw@nvidia.com/
> > [2]
> > https://github.com/zhiwang-nvidia/driver-core/tree/fwctl-rust-abstracti=
on-v2
> >
> > Zhi Wang (2):
> >   rust: introduce abstractions for fwctl
> >   samples: rust: fwctl: add sample code for fwctl
> >
> >  drivers/fwctl/Kconfig             |  12 +
> >  include/uapi/fwctl/fwctl.h        |   1 +
> >  rust/bindings/bindings_helper.h   |   1 +
> >  rust/helpers/fwctl.c              |  17 ++
> >  rust/helpers/helpers.c            |   3 +-
> >  rust/kernel/fwctl.rs              | 456 ++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs                |   2 +
> >  samples/rust/Kconfig              |  11 +
> >  samples/rust/Makefile             |   1 +
> >  samples/rust/rust_driver_fwctl.rs | 136 +++++++++
> >  10 files changed, 639 insertions(+), 1 deletion(-)
> >  create mode 100644 rust/helpers/fwctl.c
> >  create mode 100644 rust/kernel/fwctl.rs
> >  create mode 100644 samples/rust/rust_driver_fwctl.rs
> >
> > --=20
> > 2.51.0
>=20

