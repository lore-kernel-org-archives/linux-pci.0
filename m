Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BC481A92;
	Wed, 21 Jan 2026 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005476; cv=fail; b=P8fZorhWdXYIhNiKHR802R4S3AXIrNHBnj1pJIGeBBtHOvbMDBtO+eudG7f8rx51iD5cNiFTJhqKTIBnY7heaQno2CZms2mIWnOEiLaP+E6xUdt4Edg+hpf1aWoFdWOgV07DuKL5j5U4cdi4JmSgLIJrMv9kC2p3c3I8I1/On9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005476; c=relaxed/simple;
	bh=zC7cTfQKzCmraLmuvYabNoB19asZUFd4+RGeB36PdLc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZHD73f7bvIJ6kVCRTzbAQJb72ypcXvwwHGlU/B5bXQCKs/IOQufBZ5Xo370yVcqFjrkMuW1C7YDxtRWwbgwbYMtew7W/gaJ8yY/niIdVRjOh965423Zrj8ZHsg+paQrKmL9c3UOOUJxnsf6voK2TlGQNS9kALTGtKaQY+imCQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PgZmPmFC; arc=fail smtp.client-ip=40.93.196.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PgZmPmFC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfxCQ4sDo9D8Ydf8yHoN4NjxFYav2J40gJIEDmiYtX90T3FPucENHhIwPgrqH3jGo1AQz+UVHblTnzAWSajrWjKR+fUmhDGfm1YyCT8kfpOX1hHXgESsCsNEHZ+/1oarf5xISXeoxwYUwsTyD6GHfXoakVPZHLZhiW1KHpciZFzAUMkwVYLczOLknBwB3FJypPtgh7n7PP2ucpmw78j7DlEYnaNltAbD3c/MvMckNddaEwpzG8MlhGKgTB3YmIqGu/Otg/1gcjmJfaw0rEOLT1GVWbdg+uQFCg5uzme5yhznnH0c8zUFKn0zpKILhMnIUJp7lmfvXiKW8aDjDDHWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyiRK2KZg/tpo+P5obKFyv2sAgcvdRnqZzK7dLMkFhw=;
 b=vFLAOQnqGOy9aGFzC4IBFiOuOcVPo2DHjfG/pCR0aOc7qESfWOauD5+GJdFD3gYf5pSnuAY82oHJNmZPFgL4hzIm3kDIp7UNv+Y5vFWqAe60JPmdQJ7+Ncr84pxAmktiQz+uN2GJqA9WxkjHe0ItxHNoOCxl7JBlbZ0k8mDUZlVTbgTgzlwJOZdxmAJ+fr3uZuGUYm5cYx2CTCioPIbOoR+Ruwt4VtQyi7HM64t2/Kj0oadsImB5YA9VU+OwCZUeCNIEYyvB5IAnvB+JqEEwFyIbOeHXQZ96VrpV+Dx0fSQWEopMCepRHakkssPQTa9TGgeKh8Bsmz89gZ1hzPgSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyiRK2KZg/tpo+P5obKFyv2sAgcvdRnqZzK7dLMkFhw=;
 b=PgZmPmFC4TYv1mKEdZyOjUBJt8bq0y48GsASpxvhswpTq1Ns1+A9/IkGV/2LmrScI+CfnJd9XXp2CBeu+xWNbY0G9hyQkw7IIX8QTY9Imiehx3smTZ8uKHZOV+/R2qa+JbqFd759B3m2RzaUEn5TjG4EG2oxrmhNlowvpHewAe+EhUxzJRFGWPj82NxkS7b85J9avSzZrDaG3KT+wosRmYf3GKp8UtZm2bUtplQk9eg/rkQFg9dShur8YoubT5p0ZRQYnG1AqVLabj5uvtFmxHKLWDLRds15EECBvf517slkgMICjgzQXAfRI6m53HdaQbkdYEtIRn2BXDemA5XBEg==
Received: from BYAPR11CA0050.namprd11.prod.outlook.com (2603:10b6:a03:80::27)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:24:23 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::ed) by BYAPR11CA0050.outlook.office365.com
 (2603:10b6:a03:80::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 14:24:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 06:24:04 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 06:24:03 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 06:23:57 -0800
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
Subject: [PATCH v11 0/5] rust: pci: add config space read/write support
Date: Wed, 21 Jan 2026 16:23:49 +0200
Message-ID: <20260121142355.4761-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbf9e3b-22c2-45a3-7600-08de58f8c606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KyGwSV3AYLSJZJMYX0g329s+9jGXiHQdgz/pmwwM8CcA5dH5Ad/fShXz3h+o?=
 =?us-ascii?Q?hkBBN5W8izZtLSW0MkeIA/IaM8dvQf/OxXq1uy3FSwBYh1afgmxFCHLCCoEi?=
 =?us-ascii?Q?GgN/VYrAIz/egRTtFqmFo2ZI/INqBcb9OpN3Sp/sWINfO20dWWejGo4rfxqg?=
 =?us-ascii?Q?CaQ1Lo0Gyn0PLmILNj8wKdQ7mpg4o2W++7IMTBvshqNFYMfW0/9TKIgXJquI?=
 =?us-ascii?Q?I+u7dxPBlQvJ7TRkO4qs4atjriJ6GY9nlY4Ajb9mLABxts2sGL0bXYNWYOPN?=
 =?us-ascii?Q?Qftd3NTMlSV79koAlyBoJz4cGpOjbasLp+FQDozXNL9YR41UvZg3EimWd/Yc?=
 =?us-ascii?Q?F47wOXYs+vq6N4zkrPxlEG700U85jH1u5c5LzSAXPtguUqgta+UFd14YqORP?=
 =?us-ascii?Q?K1+OZM1q1xx7BWd+2Q36xep0ziZdOuVOEcL2V/QzUjJPWIBxzCjjdfTfXbe6?=
 =?us-ascii?Q?AfFfm8PLlJB63sSaIXB+HUGzpKjcUhuSjdFBQWV3RAGJ0MfJPhcFj9BmXSzQ?=
 =?us-ascii?Q?4UUAHw5nuMYX65prLthasJJDTauJPASUrBbT1yyQvLnEn5ErM1RPvPOxKzav?=
 =?us-ascii?Q?udWeHMuhbVwfhOB4o0I0xReDZssofLPQR0mGRYryoAZ+yWOW3W4yHF+KDZgy?=
 =?us-ascii?Q?rm9sGsOGwtSC+JCxyjZg1P6Q5FAY98qhPMc3/UmeShk4CpYeAlkS/Mwhfbcc?=
 =?us-ascii?Q?OXWmhENGuzqqakHMaaQysy8VFe3nAac+3VCpDATpM9L5RpWWsmBuxnN9og9g?=
 =?us-ascii?Q?7S0K7/myytK4mLAmLOnxt1s1gZTcno2Ww2ckTjWlsvMmEXJknqgtURx0ShSq?=
 =?us-ascii?Q?dxAD68F9k7VRMRgo9qI78xISg+Tl5XgOBbS2qJpLIAU2ilFs8lhCSTQ1I571?=
 =?us-ascii?Q?2auUjMbfqwkt+mErqqLfL/vUlZMwdlJCVOWbsg8XB/Wf/lfYBjVsgRjkMxwx?=
 =?us-ascii?Q?5LVYY1nITBy6yJa6qLrTlRHL/OcI6gDP3TKEQ3HL91nX59uZ4G5YuW5sbkrr?=
 =?us-ascii?Q?9it9XK9tud+PyRV0yxOoQ6dkyxlQcrsPXGn6RIopk5IK6OHoRivGnB99Rrgf?=
 =?us-ascii?Q?tsiY2OmC92Ks8ortlmTVIsNEQoK5WizBuuW3O/ESyhajwDd9aQTLpDzedXZE?=
 =?us-ascii?Q?ENNd9zIrJgTXMjmSG6woMVQOSBRJjImUx1XB+WuxePPqH5H/L/dLlkwlouRP?=
 =?us-ascii?Q?URvp1mmJGiCx923SehO9Ut3VAJlW7KPWci7DOsk2sCNaKlKevIM92xVbF5Up?=
 =?us-ascii?Q?mBAKQZEsOg9wrmjfUEbho/wPNQgoUQOkwKBIFK892lNX95oC6PYMdzb231pn?=
 =?us-ascii?Q?bRTkOCnftzLpMyr/baH8piyXo6z/b7pijXKBJNroz+ogFAwhp+lpRJQ9GwIS?=
 =?us-ascii?Q?VkoXy/I+/Y7YaZX9eoqvn2pdLdgL/g5QUHay5M8i/+RtPtWxKTxszjD3+Mve?=
 =?us-ascii?Q?ZUtmEfwkqROK1mPXwysCcAEnkBNdMNvx3I9AM1IirqEPU5pt3gu7O/gIWHU5?=
 =?us-ascii?Q?VF86bCdxapu/fhCzFIA92ePdBPsmdO9eWTHkiqkcwrCVKbYJFvkgGhy/bGWJ?=
 =?us-ascii?Q?2ej+NzxvhvP5eTLd5FccO0Ys4SsBEhXewTrkiAaumsqsj3d6Ckk70c3sy25w?=
 =?us-ascii?Q?taKM4HxHA97ntY/Ba4O8FM1zdXyXuqTTn7Vwv8mA25wF9Plrz9e0tr6VNuRN?=
 =?us-ascii?Q?Iq6Aj250s6E+jObfeuJfdfFg1Vs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:24:22.9784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbf9e3b-22c2-45a3-7600-08de58f8c606
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstractions. Alice/Alex/I had a discussion of the next steps of
this patch series in LPC 2025. We agreed that first introducing the
functionality before the BoundedInteger work and other refinement is
settled. [2]

The repo with the patches can be found at [3].

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
[3] https://github.com/zhiwang-nvidia/nova-core/tree/rust-for-linux/pci-configuration-space-v11

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
 rust/kernel/io.rs                      | 494 +++++++++++++++++++++----
 rust/kernel/io/mem.rs                  |  16 +-
 rust/kernel/io/poll.rs                 |  16 +-
 rust/kernel/pci/io.rs                  | 171 ++++++++-
 samples/rust/rust_driver_pci.rs        |  32 ++
 11 files changed, 722 insertions(+), 144 deletions(-)

-- 
2.51.0

