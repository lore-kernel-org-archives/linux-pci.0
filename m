Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ADA341AD8;
	Wed, 21 Jan 2026 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026969; cv=fail; b=jNJQZC8RFijHs+LmaReuWAaFnLxnmH8ZHI/UZLJjg+omImRggh5P4ywwHJQJQBYHOQddybKzp/tXwPfhjNL67qxFbGW7KQcblKkqtIx/VHRNeRY/D6hs1ty0Of7tXIRhdB5teyt3mPV0WG56dq1+SCvhhjv3X4PAl2b3bnxbirk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026969; c=relaxed/simple;
	bh=/yO1ugSUgzB44iHxMjMDwzbHIqyKLXl/Fh0Z7i6KMc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cxEvR8tPcc7KFxvCNW4HIf1TKrplKcF6Ul6neubHt84whBpQfoVVOmdl2sJw7h50px2FTOFCeVcG/OtJx3vm3I4VN1MVKaic/4kVu6n2jCxo3ZYGXG7ONkRNivcqbbAKlPbUw7uKvn/jTIFjCJlTfr0oYS9/mjfaT02lQJldO9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jK3OgQ4W; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jK3OgQ4W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQwmimrDNWlRtqhqIde0GEpFCgwOibOwof2qO4/Y7se79VLrlC/RxC1TX1USaL1Do2QyZ15VJ9gTFQc45p/ji09jBx0rlUlHLq2QWPDlDIBgGDO63alf6O2x5uxMrTV7MclWbUAYN3/FFiM7GiVxP15Kfxd9GlDh6y5WrbBuAAdW7UisofXm99CykioVmgZjDBrRoHqClCfonOaevtsh0ygIjbN48HEFjrEnqYfBc+kCOQUp7+O08BlRaECn8yksAP3St3wZRlaoi4Uob8GmxSHob2HC4amLlocnsnPRSMlARsjHsI19T/7zp/Zyie6aPih7Zf10zNcWk1XYGaaJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTSA5Q1V03NZEMP923p1QcDXw9G43eq2RBkV1r/1HxM=;
 b=Ed4y8uYwNqcB+nu0ckw2G2IerPF97UUz5jwwLAwQNi94ptFrAZftIqTYiCWpjS5skwj9CAZq8/r7tHobqyVtBLFZuWMowtUCT08GMDhWGzi+1uGfJpd5x7ktmWX6TXig82QvrKbfFPIkZYL5Y6Z9bppNWXeP0emfvyVYlLq7XiXZuz9M6YPGIU+oYH2PZYt4vNoseehVVX65AvwZwQmIKzXVgezPxHLxMhweY1U0j8Rlwo5n9SugZczCnaSqrdQTY0Q1424gSW5iJSHetjEwLbZWECdEVRFFZ/Nep6u+UgFwPu/1lD5OGUGKPmMFUINc2NJRbnoFk4TX+SoSVE6a+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTSA5Q1V03NZEMP923p1QcDXw9G43eq2RBkV1r/1HxM=;
 b=jK3OgQ4WuckC0f+U1yz54T7QhmcspPJFvouZBBpsvjzq+yYoXRaFufyGrUtpyvEjZ5lx17NfA+uPYm8En/5aIGRjnmyaXLqRGRR2Z/+5yO3gR7Vp+7JA8LeYicXKmLlA2yDNTFRZhyjChttXGsvHTK0TOWcYC6KQ2Qo9BPGBHv9GfcWRYBdAnzDvdNMTV56+rbV0jO9xw/w5H+CqBJ36Od2vbILTNNqLES9F0sRa6BhoDndCdSDI1LiDoUJXZ7+BOCGZ1Ui9I1eIcxcFhobgtQhnC6Qfm7traMyXqXBcNU/stA8oSQw1K8svaDjY5VPNKngMnlbvLss6SgwLcebmSA==
Received: from DM6PR03CA0074.namprd03.prod.outlook.com (2603:10b6:5:333::7) by
 CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Wed, 21 Jan 2026 20:22:39 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::8a) by DM6PR03CA0074.outlook.office365.com
 (2603:10b6:5:333::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 20:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 20:22:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 12:22:20 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 12:22:19 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 12:22:14 -0800
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
Subject: [PATCH v12 0/5] rust: pci: add config space read/write support
Date: Wed, 21 Jan 2026 22:22:06 +0200
Message-ID: <20260121202212.4438-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7fd547-3bd9-4cb7-a770-08de592ad295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqFlk06wp+bDarKCToS9yAhWiU8vtrmsKTJpWu7kdIle8WUnKbCF9E+jCavF?=
 =?us-ascii?Q?t8af6iZbcQZz/sokL71kf2UsYf/CWG1wlo57trjhSf+uAQ3SBpUz30d4fWFv?=
 =?us-ascii?Q?OpYSfexKisNxZ+03Ps4DPIci72ljwI61BOaOzXdme8Zb68ZUmYv7RHtUqFYl?=
 =?us-ascii?Q?RTso8d4m2W9LZ7zYaYmlL7o0OpoFQepYzRRWC6M9EZr/hLLMdgckFoDVp3bc?=
 =?us-ascii?Q?X3uIxkwk5jJVwWQFdAWGlx17hp5IETfYTjQq4A1vcuEsnHxwaD0YgQmL6Od7?=
 =?us-ascii?Q?pIYl01NYR+TIJqNia1+2O5e+/q49hKPzHntFSe7VKFa5MoMk/MXEwCfETGK3?=
 =?us-ascii?Q?pk+C7+gaXGhYPJ2ex9cVP2CBuabmrSzqPNhmk2mIOCUZeTZCdkYmsJVJKOtY?=
 =?us-ascii?Q?JiRp/7Epm38Pr/rea+jwHuPcpAzzMiSarIAy1wa4Egz/00Vzvy2XEf0wZvvN?=
 =?us-ascii?Q?c5BoHH5h63WYCgGg8nltObjycPVL0Amys0b62Ee0VnF9+H92+6/CGAfGxfNZ?=
 =?us-ascii?Q?UTqJTdvx684MeFOtNxOSSDYrBSScWl6/XEEM0c+QvwXn0EkD4OLprAIPYgVQ?=
 =?us-ascii?Q?l1cMlEiMxDw4gZNJl9KrxgITMiPdDzsynvlINNInL2IufExoHKwuCSeMOTLw?=
 =?us-ascii?Q?fviKoB2dGuTxlxZAQyu2NbUXbNHX0FE9541r9GuvCF8pvSw4cFJy9Wsv3TNu?=
 =?us-ascii?Q?spOH0/XwrddGMzkq/LqovSWhYcjpVRI0VYPP2npN5JXdcvpzQHxZEHMC3i2T?=
 =?us-ascii?Q?4pITx46a/1Sgx99rDQPz4pzf0byXgESEaeZDQsi9EP4QdYQMlgw5NUzB+JRj?=
 =?us-ascii?Q?U+AgmAwMgxB2OHaNjpAmpD5bLGjgPOZ3u3H1CAEh9XO/tqdcJyxkuEz0r/e+?=
 =?us-ascii?Q?QSr1FATVYNl3il2u7vEQWptb4QFRs7ZMB2g0TNROYO0JidoF6vv00AHBgb5A?=
 =?us-ascii?Q?pvxFjRp6OzGgPrQqDpAfJTHvdsbw/27UnsDZnVLBKDu4R3Iszd2b5UsjTNDl?=
 =?us-ascii?Q?D0Tg7EcpGpXs52iCwzpy/WBXSE/BJFebXEgF15E8DYNBgp1mIEyy8cYvdTpb?=
 =?us-ascii?Q?IXJJP/G95MQXUC8/9NONe3u2+W9SyOJS5RWb0JxoVpYfmMAnjdP95jz4FJpJ?=
 =?us-ascii?Q?afejLlVsCJpBgr7YhMxnFlUFoxzKz7QQ9/6PkOARzKjCTC2Lv99G1pr+BSuM?=
 =?us-ascii?Q?pBddaS9EQhohVBfibuuGSdJlv9NVSbyLcKl5Rvv4zuhCpVVgk4sCquJd0+XH?=
 =?us-ascii?Q?4hLHMzCyMki32r9MzqxUgDC3+uumKXpwm7nt8hwuQMmg62y6GDRGxmDisU55?=
 =?us-ascii?Q?Pg8NkzEQ8grbAEtBKQ9btya4tf4YEfzQ124l+Td6i8PkKr+p1VfK6yEMALvi?=
 =?us-ascii?Q?uL0MfiAcMD4AMntP4Cnn8EpxA/+0a5rZduzv1vsIp8GysoUMr7Q9KEv6y9Mo?=
 =?us-ascii?Q?QWeUSkDSTfceRK6PQ6F67kfORveV4fWZPnYZ3owPdw2/dWW/WC04dMtmHqLH?=
 =?us-ascii?Q?FLz/jT8Sg1/aFKa7ePREvaKkYNz6BlC2xJ7wdlOikOBIw4EPquq9k886t0Ol?=
 =?us-ascii?Q?FM/KxOqgQOwY04bhk6Q3Ou4kCdvbDS8MlkhLpx+nloD07JmIbjrC/xfA/JXo?=
 =?us-ascii?Q?R4z4aZmIed64xcLfc6M0V10lfNbxZSi6ZUMSe4ttzv/If+f6/RtFHw+H9ZR5?=
 =?us-ascii?Q?jgdD4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:22:38.8417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7fd547-3bd9-4cb7-a770-08de592ad295
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstractions. Alice/Alex/I had a discussion of the next steps of
this patch series in LPC 2025. We agreed that first introducing the
functionality before the BoundedInteger work and other refinement is
settled. [2]

The repo with the patches can be found at [3].

v12:

- Move accessors from IoKnownSize trait to Io trait. (Gary)
- Turn IoKnownSize into a marker trait. (Gary)
- Use build_error!() in Io trait default functions. (Gary)
- Remove extra #[(CONFIG_64BIT)] in Io trait. (Gary/Alice)
- Introduce marker types for configuration space. (Gary)

v11:

I tried to combine IoCapable and IoTryCapable. I found I have to dump
the original forwarding call scheme.

In this re-spin, I moved the accessors into the Io/IoKnownSize traits
and I have to added the default trait functions required by the
compiler. The IoCapable<T> turns into a pure marker trait. Reaching
the accessors from a driver are restricted by the where statements
marked by IoCapable<T>. A backend marks its capablities via implementing
IoCapable<T>. This is quite close to Gary's orginal suggestions.

I also left a assert in the default trait functions (accessors) to
catch the case that a backend implements IoCapable<T> to claim it
support the accessors but forgets to implement the accessors. This
should be helpful when developing a new backend.

- Combine IoCapable and IoTryCapable. (Danilo/Gary)
- Keep IoKnownSize trait. (Alice/Gary)
- Fix the compiling error in pwm_th1520 driver.

v10:

- Merge IoBase trait into Io trait to simplify trait hierarchy.
- Use IoCapable<T> and IoTryCapable<T> functional traits (not marker
  traits) to separate infallible and fallible I/O operations. (Danilo/Gary)

I tried implementing the marker traits idea, but I found that the
compiler still requires a default implementation for each function in
the main trait to avoid forcing backends to implement unsupported
methods.

However, Gary's core idea of "capabilities" is extremely valuable. So, I
adopted a dispatching pattern:

- All I/O accessors are defined in the Io trait. They use default
  implementations to dispatch calls to the underlying IoCapable and
  IoTryCapable traits.

This addresses Alice's concern about the complicated trait hierarchy.

It preserves strict compile-time static checks. The compiler can catch
the case if a driver calls an accessor not implemented by a backend.

- The actual logic resides in IoCapable<T> and IoTryCapable<T>.

Backends can selectively implement IoCapable<T> or IoTryCapable<T> based
on hardware support.

This addresses Markus's concern regarding backends with limited access
sizes (e.g., I2C).

For example, the Mmio backend implements both IoCapable and IoTryCapable
for all sizes, while the PCI config space backend only implements
IoCapable for u8/u16/u32.

v9:

- Rebase the patches to the latest driver-core-testing.
- Move ConfigSpaceSize to pci/io.rs. (Danilo)
- Refine docs. (Danilo)
- Compiling test on Tyr. (Danilo)

v8:

- Rebase to latest driver-core-testing branch.
- Refinement of traits name and hierarchy: (Alice)
  * Rename IoInfallible trait to IoKnownSize trait.
  * Keep Infallible helpers in Io trait.

v7:

- Rebase to latest driver-core-testing branch.
- Introduce Io64 trait. (Alice)
- Add docs for call_{mmio, config}_{read, write}() macros. (Alex)
- Improve the define_{read, write} macros. (Alex)
- Add SAFETY/CAST in call_config_{read, write}. (Joel)
- Fix typo of method name. (Alex/Joel)

v6:

- Implement config_space() and config_space_extended() in device::Bound
  lifecycle. (Danilo)
- Fix the "use" in the comment for generating proper rust docs, verify
  the output of rustdoc. (Miguel)
- Improve the comments of PCI configuration space when checking the
  output of rustdoc.

v5:

- Remove fallible accessors of PCI configuration space. (Danilo)
- Add #[repr(usize)] for enum ConfigSpace. (Danilo)
- Refine the handling of return value in read accessors. (Danilo)
- Add debug_assert!() in pdev::cfg_size(). (Danilo)
- Add ConfigSpace.as_raw() for extracting the raw value. (Danilo)
- Rebase the patches on top of driver-core-testing branch.
- Convert imports touched by this series to vertical style.

v4:

- Refactor the SIZE constant to be an associated constant. (Alice)
- Remove the default method implementations in the Io trait. (Alice)
- Make cfg_size() private. (Danilo/Bjorn)
- Implement the infallible accessors of ConfigSpace. (Danilo)
- Create a new Io64 trait specifically for 64-bit accessors. (Danilo)
- Provide two separate methods for driver: config_space() and
  config_space_extended(). (Danilo)
- Update the sample driver to test the infallible accessors. (Danilo)

v3:

- Turn offset_valid() into a private function of kernel::io:Io. (Alex)
- Separate try and non-try variants. (Danilo)
- Move all the {try_}{read,write}{8,16,32,64} accessors to the I/O trait.
  (Danilo)
- Replace the hardcoded MMIO type constraint with a generic trait bound
  so that register! macro can be used in other places. (Danilo)
- Fix doctest. (John)
- Add an enum for PCI configuration space size. (Danilo)
- Refine the patch comments. (Bjorn)

v2:

- Factor out common trait as 'Io' and keep the rest routines in original
  'Io' as 'Mmio'. (Danilo)
- Rename 'IoRaw' to 'MmioRaw'. Update the bus MMIO implementation to use
  'MmioRaw'.
- Introduce pci::Device<Bound>::config_space(). (Danilo)
- Implement both infallible and fallible read/write routines, the device
  driver decicdes which version should be used.

This ideas of this series are:

- Factor out common traits for other accessors to share the same
  compiling/runtime check like before.

- Introduce IoCapable<T> and IoTryCapable<T> traits to allow backends
  to selectively implement only the operations they support.

- Factor the MMIO read/write macros from the define_read! and
  define_write! macros. Thus, define_{read, write}! can be used in other
  backends.

  In detail:

  * Introduce `call_mmio_read!` and `call_mmio_write!` helper macros
    to encapsulate the unsafe FFI calls.
  * Update `define_read!` and `define_write!` macros to delegate to
    the call macros.
  * Export `define_read` and `define_write` so they can be reused
    for other I/O backends (e.g. PCI config space).

- Implement the PCI configuration space access backend in PCI
  abstractions.

- Add tests for config space routines in rust PCI sample driver.

[1] https://lore.kernel.org/all/20250903221111.3866249-1-zhiw@nvidia.com/
[2] https://lore.kernel.org/all/DEOMBKIRDXH6.2CF2MR2RB2W2C@nvidia.com/
[3] https://github.com/zhiwang-nvidia/nova-core/tree/rust-for-linux/pci-configuration-space-v12

Zhi Wang (5):
  rust: devres: style for imports
  rust: io: separate generic I/O helpers from MMIO implementation
  rust: io: factor out MMIO read/write macros
  rust: pci: add config space read/write support
  sample: rust: pci: add tests for config space routines

 drivers/gpu/drm/tyr/regs.rs            |   1 +
 drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
 drivers/gpu/nova-core/regs/macros.rs   |  90 +++--
 drivers/gpu/nova-core/vbios.rs         |   1 +
 drivers/pwm/pwm_th1520.rs              |   5 +-
 rust/kernel/devres.rs                  |  35 +-
 rust/kernel/io.rs                      | 477 ++++++++++++++++++++-----
 rust/kernel/io/mem.rs                  |  16 +-
 rust/kernel/io/poll.rs                 |  16 +-
 rust/kernel/pci.rs                     |   7 +-
 rust/kernel/pci/io.rs                  | 177 ++++++++-
 samples/rust/rust_driver_pci.rs        |  29 ++
 12 files changed, 713 insertions(+), 146 deletions(-)

-- 
2.51.0

