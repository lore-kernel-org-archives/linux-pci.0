Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08734D4C9;
	Wed, 21 Jan 2026 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026990; cv=fail; b=UBAtJZz+7dhI6BM20A33PnREUWn9hiGbz9VDUnZT63n8CDKuvLxoulHxlBTyMYFWTrqbcR1N3/+GwKwcEmlouLf3hCt3d6NuFgKxfUyRH3O7p6wVEtiHa0oG0MtUAoi9N8SoQ5FyrkbPoWv9uuY9rMP0neipV0LA/qsRg2/2BAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026990; c=relaxed/simple;
	bh=O4UnCzw9aRMVAK5u/xbAiPRlcYT9upcD8IcgZ8QQgk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5glev916Ky//GmmxnBFjjYEWrRPObyLgpmqeREUdJspnYNvAGIdS6A1p8Ok1PmrhJaWg86APNdoVznBDuSAwnQstR0xQDQgsd4nRe0fSNo0tgo1fx+ftkP0WXbd7XFEcGjslldJuaqz48OvbkGB/tx54awvbZpKbRcrDIqa0ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oPlIxM/x; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oPlIxM/x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdGD3aN+BT5jhbXRODgXP07twc1ru89hBUHlaLZ/giJyU30SBqMVQW1P/m152WxbZiXi1OJt3+cDIhiT0mlU/obCP/hvOW3ma/RHRKA2hC7YP7iHaDDH81ARSmoJIchAoeyB4RdtNscWF/2n2VS11NwPgyaC/TFSvKjbXG8AFjo0+YOEV/stmBQk0rKK04zKXCjQ7AvFwuhdpkttAr+i3+II4s1f0AduPIOMWjKAgbN7oVqpGk/1/TYMDHpheLQruGNpQeyxDzaxfijSkAKBP7zQe03aWqkkdOQp7FpVa9GwhUodCLLwxV1V7La07DisJ8mnXxZOL11HdXjf7F3c0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb34WNm+DsHC3D5kTOV0NXYIhWJiB2hX8SHLExAI85A=;
 b=CUhTNeYLaFqiYU/2PYpHyBFzEFQSS5g4vmFABgjUwBrlsWMx6YlsQbISIeXJxMalTq+mfQ7EYDS5XmYGRmNoOW6+E7qZJLad+Iaw5spKm5i4/l2uY6I5uKCLnWU06QSyat75eM7CMRDkqs0vi8x3wlcDnNUlM4kedWbJnskWPahsB+iargL0sN7drBM+fcMJiF3UDTED4Jx2k5lZyExSPsCrmNOElH/oXl/OphGQ+yV12FM6ypSqTKYIlLK8HGFxhtVW/wgWkj2g7203+G8IHwddDj9W9QAIPAU5Xp9iqExCC/xPXV1hddXdozXoSATK4O3uwmrZwET9So2mM9JmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb34WNm+DsHC3D5kTOV0NXYIhWJiB2hX8SHLExAI85A=;
 b=oPlIxM/xnFvl9xrKm8G9FmpiC/tc0+6Vzz909d0KSttUOfDVOC4dvFnRXQaGnKU2ojPX2jbi8UnpWkQgy6VcezjyPwQbfxYJ3ttRiinIpasfzBp2k8XCZREyNArZ1Mj2DAvwDFFihEvlhafn4lrD62jP5+438begTyD1PNyTE9h81PI2b8dUww3Hb5cZR50oxl7POQRth1dTh+ojJJGe4p2P16lfweEK+xXg4RJN87yB3ckgenU9xsssq9jlGLtS7R3qlu/p6O3gX+8tZ8YPo53pIVeo/s0zenLpU819U7V0eqzKpXZvB95BMQQKZBmJM75ovhFk2QYEeGnwy+074w==
Received: from SJ0PR03CA0170.namprd03.prod.outlook.com (2603:10b6:a03:338::25)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 20:22:55 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::9a) by SJ0PR03CA0170.outlook.office365.com
 (2603:10b6:a03:338::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Wed,
 21 Jan 2026 20:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 20:22:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 12:22:33 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 12:22:32 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 12:22:26 -0800
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
Subject: [PATCH v12 2/5] rust: io: separate generic I/O helpers from MMIO implementation
Date: Wed, 21 Jan 2026 22:22:08 +0200
Message-ID: <20260121202212.4438-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121202212.4438-1-zhiw@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db11e06-ce0c-4ddc-fa15-08de592adbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vX4nnrXx9iBJ/f2Mr3NzdhyazS9iWqbRBja7hWusVVKfYZ1vo+Z3iShFOsha?=
 =?us-ascii?Q?0ZRzZ2amE5E9lwFbJiHRoHwNhVlS3aox5o0ovjgZm7pPiXaihURq2Hl+Yjpd?=
 =?us-ascii?Q?BUKFq1u6CxJ1XLKIVFgvUW3sVjI52juXMQpA1NQZ4TF2LKh+cGtur+xP6q65?=
 =?us-ascii?Q?KpW7IAjDPyQ79eW1Kej0/CbxRZMRyC8EtRuXIIHKo5ws37bYRQMc9Zqedm3x?=
 =?us-ascii?Q?gnWjg0DOTULP4COaMw7cy2Qp7iLCdvTNU3zsmnlXHmOk7XAaIqW8eDBlAVwg?=
 =?us-ascii?Q?L/ToSf5wsvqwqNFcpZspi8p2Fo++BS9xJM11BnqFSbzdG0oO/z+2yD8oBd+M?=
 =?us-ascii?Q?Y0EgVpq/AIv6ZP+k15J2W5Q4Hbv3Bm5JJXPfEG9rrEo0pDArEOUXTwpC6dA1?=
 =?us-ascii?Q?GsOiZYEslayFK092EElhRPaI6DLrkRQLtm6d3fYgoWxIicq66tD6yLs5OcAO?=
 =?us-ascii?Q?j1YZRlVGI+hqVTe0yhK9Klcb7bCrG2MOk8W9sminZIsZcooZgEJCz9rnthj9?=
 =?us-ascii?Q?A8jzBQvL9kKeKHaWqxAiV4C0dA/FCTiBkwpknFyjoLgIFWSmMX5iaGeR6M6H?=
 =?us-ascii?Q?9iNrOVo3WQ6fGcCI1YBCs7D9tdcKI/iVYCh81SUYgoEB3skglBLggyy6TuXu?=
 =?us-ascii?Q?3UV/wrJGDr7VZCKDCf0aj9XAFjJXJTxGASY50HOekgcr988U//aaqm1GjH4r?=
 =?us-ascii?Q?ltG6FQUhgQzNat16uRRx26tGquIPOsd3gHKaNviwOSDdcDCUVlL5t0HuNaQ9?=
 =?us-ascii?Q?BPEegwLBHE35IabopFUav94Vv39YyqMUe+iR9LYPv2kXUddcK/4bu6iCAcAN?=
 =?us-ascii?Q?Oe0DLj/J1YTrfAUiE8+PEAJp/ePZpCRUfXr5jVS1VxX+OIKWHsaklm4NnxCa?=
 =?us-ascii?Q?V+yRB0rUq5LgR7wAj9yFDEYSfiNjTlYpB4FG83nweM1eiPpmsD6bv/dv79vk?=
 =?us-ascii?Q?VG2+kd6dyjY4zGJefapvf215au2uQuiFtSbcgmQQc+kkN8byoZLK+Q1k5AP9?=
 =?us-ascii?Q?C1Sqojd750cMseyp0yMq0Tzz1Ygujvnhjy34GF3F/ztiWSVO8Fh1bY5Kx/ht?=
 =?us-ascii?Q?qf0icKu7iHu2y/yP4oCddFARGYY2HU4o2FZVj+DuBS6XAucwTvsbdaUL1HL+?=
 =?us-ascii?Q?ViZjiwFatGjsI7gv7jMhZ+3YM2Ru9BVvVbkqsI/jN7XCLZTeCrbA9W/Ti/wK?=
 =?us-ascii?Q?0zGaCURF/rtG6RzaJgX7CQh+UlAHYBF9zKSVHTsmXZbCJZgHo688ycQIGjsA?=
 =?us-ascii?Q?in0PxP75zszF5JmHpXC782Hdu55metQs1oSW6dPIGlRYSrKrAJwURrpicB0S?=
 =?us-ascii?Q?lVhbSAKLZIb6zcTSIzELIcpDOLwv20WtijOYcWRVNHTH769CREO8g0K64HYp?=
 =?us-ascii?Q?IxP6zsBEPepXNdz1+Y2U+rZEADind+wQCBTlozWPV00DG1m8B0PrVf4N0VcO?=
 =?us-ascii?Q?tzyeUQzdudVH/uo32lEmG775n9DclLcn+e3EWGsBRxDGG9qi8CR85il4PEqj?=
 =?us-ascii?Q?aitlqLQScki+6XkXpmYCBldIm7rcNGHx6Zp5N5OG2hJLdCiBhxuoZXwdcgZ/?=
 =?us-ascii?Q?IyD0IUoMllQC3rM9Brv0TQtq/aJHDkYtUfVzWRGJNRWNtDJ5sEYB2lPt7UFW?=
 =?us-ascii?Q?X4dMRul5ARqI2z2wXNKBFklcR87+C9vOpfl2mlDGcvBOR8bqlKYbLT3+TODl?=
 =?us-ascii?Q?dj97eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:22:54.2190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db11e06-ce0c-4ddc-fa15-08de592adbb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

The previous Io<SIZE> type combined both the generic I/O access helpers
and MMIO implementation details in a single struct. This coupling prevented
reusing the I/O helpers for other backends, such as PCI configuration
space.

Establish a clean separation between the I/O interface and concrete
backends by separating generic I/O helpers from MMIO implementation.

Introduce a new trait hierarchy to handle different access capabilities:

- IoCapable<T>: A marker trait indicating that a backend supports I/O
  operations of a certain type (u8, u16, u32, or u64).

- Io trait: Defines fallible (try_read8, try_write8, etc.) and infallibile
  (read8, write8, etc.) I/O methods with runtime bounds checking and
  compile-time bounds checking.

- IoKnownSize trait: The marker trait for types support infallible I/O
  methods.

Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
implements the Io traits. Rename IoRaw to MmioRaw and update consumers to
use the new types.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/drm/tyr/regs.rs            |   1 +
 drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
 drivers/gpu/nova-core/regs/macros.rs   |  90 +++---
 drivers/gpu/nova-core/vbios.rs         |   1 +
 drivers/pwm/pwm_th1520.rs              |   5 +-
 rust/kernel/devres.rs                  |  19 +-
 rust/kernel/io.rs                      | 398 ++++++++++++++++++++-----
 rust/kernel/io/mem.rs                  |  16 +-
 rust/kernel/io/poll.rs                 |  16 +-
 rust/kernel/pci/io.rs                  |  12 +-
 samples/rust/rust_driver_pci.rs        |   1 +
 11 files changed, 433 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index f46933aaa221..d3a541cb37c6 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -11,6 +11,7 @@
 use kernel::device::Bound;
 use kernel::device::Device;
 use kernel::devres::Devres;
+use kernel::io::Io;
 use kernel::prelude::*;
 
 use crate::driver::IoMem;
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 2d0369c49092..862cf7f27143 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -12,7 +12,10 @@
 
 use kernel::{
     device,
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     time::{
         delay::fsleep,
diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index fd1a815fa57d..ed624be1f39b 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -369,16 +369,18 @@ impl $name {
 
             /// Read the register from its address in `io`.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn read<T, I>(io: &T) -> Self where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
             {
                 Self(io.read32($offset))
             }
 
             /// Write the value contained in `self` to the register address in `io`.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn write<T, I>(self, io: &T) where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
             {
                 io.write32(self.0, $offset)
             }
@@ -386,11 +388,12 @@ pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
             /// Read the register from its address in `io` and run `f` on its value to obtain a new
             /// value to write back.
             #[inline(always)]
-            pub(crate) fn update<const SIZE: usize, T, F>(
+            pub(crate) fn update<T, I, F>(
                 io: &T,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 let reg = f(Self::read(io));
@@ -408,12 +411,13 @@ impl $name {
             /// Read the register from `io`, using the base address provided by `base` and adding
             /// the register's offset to it.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T, B>(
+            pub(crate) fn read<T, I, B>(
                 io: &T,
                 #[allow(unused_variables)]
                 base: &B,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 const OFFSET: usize = $name::OFFSET;
@@ -428,13 +432,14 @@ pub(crate) fn read<const SIZE: usize, T, B>(
             /// Write the value contained in `self` to `io`, using the base address provided by
             /// `base` and adding the register's offset to it.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T, B>(
+            pub(crate) fn write<T, I, B>(
                 self,
                 io: &T,
                 #[allow(unused_variables)]
                 base: &B,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 const OFFSET: usize = $name::OFFSET;
@@ -449,12 +454,13 @@ pub(crate) fn write<const SIZE: usize, T, B>(
             /// the register's offset to it, then run `f` on its value to obtain a new value to
             /// write back.
             #[inline(always)]
-            pub(crate) fn update<const SIZE: usize, T, B, F>(
+            pub(crate) fn update<T, I, B, F>(
                 io: &T,
                 base: &B,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
@@ -474,11 +480,12 @@ impl $name {
 
             /// Read the array register at index `idx` from its address in `io`.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T>(
+            pub(crate) fn read<T, I>(
                 io: &T,
                 idx: usize,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
             {
                 build_assert!(idx < Self::SIZE);
 
@@ -490,12 +497,13 @@ pub(crate) fn read<const SIZE: usize, T>(
 
             /// Write the value contained in `self` to the array register with index `idx` in `io`.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T>(
+            pub(crate) fn write<T, I>(
                 self,
                 io: &T,
                 idx: usize
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
             {
                 build_assert!(idx < Self::SIZE);
 
@@ -507,12 +515,13 @@ pub(crate) fn write<const SIZE: usize, T>(
             /// Read the array register at index `idx` in `io` and run `f` on its value to obtain a
             /// new value to write back.
             #[inline(always)]
-            pub(crate) fn update<const SIZE: usize, T, F>(
+            pub(crate) fn update<T, I, F>(
                 io: &T,
                 idx: usize,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 let reg = f(Self::read(io, idx));
@@ -524,11 +533,12 @@ pub(crate) fn update<const SIZE: usize, T, F>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_read<const SIZE: usize, T>(
+            pub(crate) fn try_read<T, I>(
                 io: &T,
                 idx: usize,
             ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
             {
                 if idx < Self::SIZE {
                     Ok(Self::read(io, idx))
@@ -542,12 +552,13 @@ pub(crate) fn try_read<const SIZE: usize, T>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_write<const SIZE: usize, T>(
+            pub(crate) fn try_write<T, I>(
                 self,
                 io: &T,
                 idx: usize,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
             {
                 if idx < Self::SIZE {
                     Ok(self.write(io, idx))
@@ -562,12 +573,13 @@ pub(crate) fn try_write<const SIZE: usize, T>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_update<const SIZE: usize, T, F>(
+            pub(crate) fn try_update<T, I, F>(
                 io: &T,
                 idx: usize,
                 f: F,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 if idx < Self::SIZE {
@@ -593,13 +605,14 @@ impl $name {
             /// Read the array register at index `idx` from `io`, using the base address provided
             /// by `base` and adding the register's offset to it.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T, B>(
+            pub(crate) fn read<T, I, B>(
                 io: &T,
                 #[allow(unused_variables)]
                 base: &B,
                 idx: usize,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 build_assert!(idx < Self::SIZE);
@@ -614,14 +627,15 @@ pub(crate) fn read<const SIZE: usize, T, B>(
             /// Write the value contained in `self` to `io`, using the base address provided by
             /// `base` and adding the offset of array register `idx` to it.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T, B>(
+            pub(crate) fn write<T, I, B>(
                 self,
                 io: &T,
                 #[allow(unused_variables)]
                 base: &B,
                 idx: usize
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 build_assert!(idx < Self::SIZE);
@@ -636,13 +650,14 @@ pub(crate) fn write<const SIZE: usize, T, B>(
             /// by `base` and adding the register's offset to it, then run `f` on its value to
             /// obtain a new value to write back.
             #[inline(always)]
-            pub(crate) fn update<const SIZE: usize, T, B, F>(
+            pub(crate) fn update<T, I, B, F>(
                 io: &T,
                 base: &B,
                 idx: usize,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
@@ -656,12 +671,13 @@ pub(crate) fn update<const SIZE: usize, T, B, F>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_read<const SIZE: usize, T, B>(
+            pub(crate) fn try_read<T, I, B>(
                 io: &T,
                 base: &B,
                 idx: usize,
             ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 if idx < Self::SIZE {
@@ -677,13 +693,14 @@ pub(crate) fn try_read<const SIZE: usize, T, B>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_write<const SIZE: usize, T, B>(
+            pub(crate) fn try_write<T, I, B>(
                 self,
                 io: &T,
                 base: &B,
                 idx: usize,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 if idx < Self::SIZE {
@@ -700,13 +717,14 @@ pub(crate) fn try_write<const SIZE: usize, T, B>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_update<const SIZE: usize, T, B, F>(
+            pub(crate) fn try_update<T, I, B, F>(
                 io: &T,
                 base: &B,
                 idx: usize,
                 f: F,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index abf423560ff4..fe33b519e4d8 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -6,6 +6,7 @@
 
 use kernel::{
     device,
+    io::Io,
     prelude::*,
     ptr::{
         Alignable,
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index e3b7e77356fc..616ca398b2c5 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -26,7 +26,10 @@
     clk::Clk,
     device::{Bound, Core, Device},
     devres,
-    io::mem::IoMem,
+    io::{
+        mem::IoMem,
+        Io, //
+    },
     of, platform,
     prelude::*,
     pwm, time,
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 43089511bf76..cdc49677022a 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -74,14 +74,17 @@ struct Inner<T: Send> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         IoRaw,
-///         PhysAddr,
+///         IoKnownSize,
+///         Mmio,
+///         MmioRaw,
+///         PhysAddr, //
 ///     },
+///     prelude::*,
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -96,7 +99,7 @@ struct Inner<T: Send> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -108,11 +111,11 @@ struct Inner<T: Send> {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Io<SIZE>;
+///    type Target = Mmio<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Io::from_raw(&self.0) }
+///         unsafe { Mmio::from_raw(&self.0) }
 ///    }
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
@@ -258,6 +261,10 @@ pub fn device(&self) -> &Device {
     /// use kernel::{
     ///     device::Core,
     ///     devres::Devres,
+    ///     io::{
+    ///         Io,
+    ///         IoKnownSize, //
+    ///     },
     ///     pci, //
     /// };
     ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index a97eb44a9a87..687d32572d6b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -32,16 +32,16 @@
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
 /// the represented MMIO region does exist or is properly mapped.
 ///
-/// Instead, the bus specific MMIO implementation must convert this raw representation into an `Io`
-/// instance providing the actual memory accessors. Only by the conversion into an `Io` structure
-/// any guarantees are given.
-pub struct IoRaw<const SIZE: usize = 0> {
+/// Instead, the bus specific MMIO implementation must convert this raw representation into an
+/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
+/// structure any guarantees are given.
+pub struct MmioRaw<const SIZE: usize = 0> {
     addr: usize,
     maxsize: usize,
 }
 
-impl<const SIZE: usize> IoRaw<SIZE> {
-    /// Returns a new `IoRaw` instance on success, an error otherwise.
+impl<const SIZE: usize> MmioRaw<SIZE> {
+    /// Returns a new `MmioRaw` instance on success, an error otherwise.
     pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
         if maxsize < SIZE {
             return Err(EINVAL);
@@ -81,14 +81,16 @@ pub fn maxsize(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         IoRaw,
+///         IoKnownSize,
+///         Mmio,
+///         MmioRaw,
 ///         PhysAddr,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -103,7 +105,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -115,11 +117,11 @@ pub fn maxsize(&self) -> usize {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Io<SIZE>;
+///    type Target = Mmio<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Io::from_raw(&self.0) }
+///         unsafe { Mmio::from_raw(&self.0) }
 ///    }
 /// }
 ///
@@ -133,29 +135,31 @@ pub fn maxsize(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
+pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
 macro_rules! define_read {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident -> $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident -> $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
         #[inline]
-        pub fn $name(&self, offset: usize) -> $type_name {
+        $vis fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
             unsafe { bindings::$c_fn(addr as *const c_void) }
         }
+    };
 
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident -> $type_name:ty) => {
         /// Read IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
         /// out of bounds.
         $(#[$attr])*
-        pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
+        $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
@@ -163,74 +167,95 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
         }
     };
 }
+pub(crate) use define_read;
 
 macro_rules! define_write {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident <- $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident <- $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
         #[inline]
-        pub fn $name(&self, value: $type_name, offset: usize) {
+        $vis fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
             unsafe { bindings::$c_fn(value, addr as *mut c_void) }
         }
+    };
 
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident <- $type_name:ty) => {
         /// Write IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
         /// out of bounds.
         $(#[$attr])*
-        pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
+        $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            unsafe { bindings::$c_fn(value, addr as *mut c_void) };
             Ok(())
         }
     };
 }
-
-impl<const SIZE: usize> Io<SIZE> {
-    /// Converts an `IoRaw` into an `Io` instance, providing the accessors to the MMIO mapping.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
-    /// `maxsize`.
-    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
-        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
-        unsafe { &*core::ptr::from_ref(raw).cast() }
+pub(crate) use define_write;
+
+/// Checks whether an access of type `U` at the given `offset`
+/// is valid within this region.
+#[inline]
+const fn offset_valid<U>(offset: usize, size: usize) -> bool {
+    let type_size = core::mem::size_of::<U>();
+    if let Some(end) = offset.checked_add(type_size) {
+        end <= size && offset % type_size == 0
+    } else {
+        false
     }
+}
+
+/// Marker trait indicating that an I/O backend supports operations of a certain type.
+///
+/// Different I/O backends can implement this trait to expose only the operations they support.
+///
+/// For example, a PCI configuration space may implement `IoCapable<u8>`, `IoCapable<u16>`,
+/// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region on a 64-bit
+/// system might implement all four.
+pub trait IoCapable<T> {}
+
+/// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
+/// can perform I/O operations on regions of memory.
+///
+/// This is an abstract representation to be implemented by arbitrary I/O
+/// backends (e.g. MMIO, PCI config space, etc.).
+///
+/// The [`Io`] trait provides:
+/// - Base address and size information
+/// - Helper methods for offset validation and address calculation
+/// - Fallible (runtime checked) accessors for different data widths
+///
+/// Which I/O methods are available depends on which [`IoCapable<T>`] traits
+/// are implemented for the type.
+///
+/// # Examples
+///
+/// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
+/// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
+pub trait Io {
+    /// Minimum usable size of this region.
+    const MIN_SIZE: usize;
 
     /// Returns the base address of this mapping.
-    #[inline]
-    pub fn addr(&self) -> usize {
-        self.0.addr()
-    }
+    fn addr(&self) -> usize;
 
     /// Returns the maximum size of this mapping.
-    #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.0.maxsize()
-    }
-
-    #[inline]
-    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
-        let type_size = core::mem::size_of::<U>();
-        if let Some(end) = offset.checked_add(type_size) {
-            end <= size && offset % type_size == 0
-        } else {
-            false
-        }
-    }
+    fn maxsize(&self) -> usize;
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing runtime bound checks.
     #[inline]
     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
-        if !Self::offset_valid::<U>(offset, self.maxsize()) {
+        if !offset_valid::<U>(offset, self.maxsize()) {
             return Err(EINVAL);
         }
 
@@ -239,50 +264,285 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
         self.addr().checked_add(offset).ok_or(EINVAL)
     }
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
     #[inline]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(Self::offset_valid::<U>(offset, SIZE));
+        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
 
         self.addr() + offset
     }
 
-    define_read!(read8, try_read8, readb -> u8);
-    define_read!(read16, try_read16, readw -> u16);
-    define_read!(read32, try_read32, readl -> u32);
+    /// Fallible 8-bit read with runtime bounds check.
+    #[inline(always)]
+    fn try_read8(&self, _offset: usize) -> Result<u8>
+    where
+        Self: IoCapable<u8>,
+    {
+        build_error!("Backend does not support fallible 8-bit read")
+    }
+
+    /// Fallible 16-bit read with runtime bounds check.
+    #[inline(always)]
+    fn try_read16(&self, _offset: usize) -> Result<u16>
+    where
+        Self: IoCapable<u16>,
+    {
+        build_error!("Backend does not support fallible 16-bit read")
+    }
+
+    /// Fallible 32-bit read with runtime bounds check.
+    #[inline(always)]
+    fn try_read32(&self, _offset: usize) -> Result<u32>
+    where
+        Self: IoCapable<u32>,
+    {
+        build_error!("Backend does not support fallible 32-bit read")
+    }
+
+    /// Fallible 64-bit read with runtime bounds check.
+    #[inline(always)]
+    fn try_read64(&self, _offset: usize) -> Result<u64>
+    where
+        Self: IoCapable<u64>,
+    {
+        build_error!("Backend does not support fallible 64-bit read")
+    }
+
+    /// Fallible 8-bit write with runtime bounds check.
+    #[inline(always)]
+    fn try_write8(&self, _value: u8, _offset: usize) -> Result
+    where
+        Self: IoCapable<u8>,
+    {
+        build_error!("Backend does not support fallible 8-bit write")
+    }
+
+    /// Fallible 16-bit write with runtime bounds check.
+    #[inline(always)]
+    fn try_write16(&self, _value: u16, _offset: usize) -> Result
+    where
+        Self: IoCapable<u16>,
+    {
+        build_error!("Backend does not support fallible 16-bit write")
+    }
+
+    /// Fallible 32-bit write with runtime bounds check.
+    #[inline(always)]
+    fn try_write32(&self, _value: u32, _offset: usize) -> Result
+    where
+        Self: IoCapable<u32>,
+    {
+        build_error!("Backend does not support fallible 32-bit write")
+    }
+
+    /// Fallible 64-bit write with runtime bounds check.
+    #[inline(always)]
+    fn try_write64(&self, _value: u64, _offset: usize) -> Result
+    where
+        Self: IoCapable<u64>,
+    {
+        build_error!("Backend does not support fallible 64-bit write")
+    }
+
+    /// Infallible 8-bit read with compile-time bounds check.
+    #[inline(always)]
+    fn read8(&self, _offset: usize) -> u8
+    where
+        Self: IoKnownSize + IoCapable<u8>,
+    {
+        build_error!("Backend does not support infallible 8-bit read")
+    }
+
+    /// Infallible 16-bit read with compile-time bounds check.
+    #[inline(always)]
+    fn read16(&self, _offset: usize) -> u16
+    where
+        Self: IoKnownSize + IoCapable<u16>,
+    {
+        build_error!("Backend does not support infallible 16-bit read")
+    }
+
+    /// Infallible 32-bit read with compile-time bounds check.
+    #[inline(always)]
+    fn read32(&self, _offset: usize) -> u32
+    where
+        Self: IoKnownSize + IoCapable<u32>,
+    {
+        build_error!("Backend does not support infallible 32-bit read")
+    }
+
+    /// Infallible 64-bit read with compile-time bounds check.
+    #[inline(always)]
+    fn read64(&self, _offset: usize) -> u64
+    where
+        Self: IoKnownSize + IoCapable<u64>,
+    {
+        build_error!("Backend does not support infallible 64-bit read")
+    }
+
+    /// Infallible 8-bit write with compile-time bounds check.
+    #[inline(always)]
+    fn write8(&self, _value: u8, _offset: usize)
+    where
+        Self: IoKnownSize + IoCapable<u8>,
+    {
+        build_error!("Backend does not support infallible 8-bit write")
+    }
+
+    /// Infallible 16-bit write with compile-time bounds check.
+    #[inline(always)]
+    fn write16(&self, _value: u16, _offset: usize)
+    where
+        Self: IoKnownSize + IoCapable<u16>,
+    {
+        build_error!("Backend does not support infallible 16-bit write")
+    }
+
+    /// Infallible 32-bit write with compile-time bounds check.
+    #[inline(always)]
+    fn write32(&self, _value: u32, _offset: usize)
+    where
+        Self: IoKnownSize + IoCapable<u32>,
+    {
+        build_error!("Backend does not support infallible 32-bit write")
+    }
+
+    /// Infallible 64-bit write with compile-time bounds check.
+    #[inline(always)]
+    fn write64(&self, _value: u64, _offset: usize)
+    where
+        Self: IoKnownSize + IoCapable<u64>,
+    {
+        build_error!("Backend does not support infallible 64-bit write")
+    }
+}
+
+/// Marker trait for types with a known size at compile time.
+///
+/// This trait is implemented by I/O backends that have a compile-time known size,
+/// enabling the use of infallible I/O accessors with compile-time bounds checking.
+///
+/// Types implementing this trait can use the infallible methods in [`Io`] trait
+/// (e.g., `read8`, `write32`), which require `Self: IoKnownSize` bound.
+pub trait IoKnownSize: Io {}
+
+// MMIO regions support 8, 16, and 32-bit accesses.
+impl<const SIZE: usize> IoCapable<u8> for Mmio<SIZE> {}
+impl<const SIZE: usize> IoCapable<u16> for Mmio<SIZE> {}
+impl<const SIZE: usize> IoCapable<u32> for Mmio<SIZE> {}
+
+// MMIO regions on 64-bit systems also support 64-bit accesses.
+#[cfg(CONFIG_64BIT)]
+impl<const SIZE: usize> IoCapable<u64> for Mmio<SIZE> {}
+
+impl<const SIZE: usize> Io for Mmio<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+
+    /// Returns the base address of this mapping.
+    #[inline]
+    fn addr(&self) -> usize {
+        self.0.addr()
+    }
+
+    /// Returns the maximum size of this mapping.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.0.maxsize()
+    }
+
+    define_read!(fallible, try_read8, readb -> u8);
+    define_read!(fallible, try_read16, readw -> u16);
+    define_read!(fallible, try_read32, readl -> u32);
     define_read!(
+        fallible,
         #[cfg(CONFIG_64BIT)]
-        read64,
         try_read64,
         readq -> u64
     );
 
-    define_read!(read8_relaxed, try_read8_relaxed, readb_relaxed -> u8);
-    define_read!(read16_relaxed, try_read16_relaxed, readw_relaxed -> u16);
-    define_read!(read32_relaxed, try_read32_relaxed, readl_relaxed -> u32);
+    define_write!(fallible, try_write8, writeb <- u8);
+    define_write!(fallible, try_write16, writew <- u16);
+    define_write!(fallible, try_write32, writel <- u32);
+    define_write!(
+        fallible,
+        #[cfg(CONFIG_64BIT)]
+        try_write64,
+        writeq <- u64
+    );
+
+    define_read!(infallible, read8, readb -> u8);
+    define_read!(infallible, read16, readw -> u16);
+    define_read!(infallible, read32, readl -> u32);
     define_read!(
+        infallible,
         #[cfg(CONFIG_64BIT)]
-        read64_relaxed,
-        try_read64_relaxed,
-        readq_relaxed -> u64
+        read64,
+        readq -> u64
     );
 
-    define_write!(write8, try_write8, writeb <- u8);
-    define_write!(write16, try_write16, writew <- u16);
-    define_write!(write32, try_write32, writel <- u32);
+    define_write!(infallible, write8, writeb <- u8);
+    define_write!(infallible, write16, writew <- u16);
+    define_write!(infallible, write32, writel <- u32);
     define_write!(
+        infallible,
         #[cfg(CONFIG_64BIT)]
         write64,
-        try_write64,
         writeq <- u64
     );
+}
+
+impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {}
+
+impl<const SIZE: usize> Mmio<SIZE> {
+    /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
+    /// `maxsize`.
+    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
+        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
+        unsafe { &*core::ptr::from_ref(raw).cast() }
+    }
+
+    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
+    define_read!(infallible, pub read16_relaxed, readw_relaxed -> u16);
+    define_read!(infallible, pub read32_relaxed, readl_relaxed -> u32);
+    define_read!(
+        infallible,
+        #[cfg(CONFIG_64BIT)]
+        pub read64_relaxed,
+        readq_relaxed -> u64
+    );
+
+    define_read!(fallible, pub try_read8_relaxed, readb_relaxed -> u8);
+    define_read!(fallible, pub try_read16_relaxed, readw_relaxed -> u16);
+    define_read!(fallible, pub try_read32_relaxed, readl_relaxed -> u32);
+    define_read!(
+        fallible,
+        #[cfg(CONFIG_64BIT)]
+        pub try_read64_relaxed,
+        readq_relaxed -> u64
+    );
+
+    define_write!(infallible, pub write8_relaxed, writeb_relaxed <- u8);
+    define_write!(infallible, pub write16_relaxed, writew_relaxed <- u16);
+    define_write!(infallible, pub write32_relaxed, writel_relaxed <- u32);
+    define_write!(
+        infallible,
+        #[cfg(CONFIG_64BIT)]
+        pub write64_relaxed,
+        writeq_relaxed <- u64
+    );
 
-    define_write!(write8_relaxed, try_write8_relaxed, writeb_relaxed <- u8);
-    define_write!(write16_relaxed, try_write16_relaxed, writew_relaxed <- u16);
-    define_write!(write32_relaxed, try_write32_relaxed, writel_relaxed <- u32);
+    define_write!(fallible, pub try_write8_relaxed, writeb_relaxed <- u8);
+    define_write!(fallible, pub try_write16_relaxed, writew_relaxed <- u16);
+    define_write!(fallible, pub try_write32_relaxed, writel_relaxed <- u32);
     define_write!(
+        fallible,
         #[cfg(CONFIG_64BIT)]
-        write64_relaxed,
-        try_write64_relaxed,
+        pub try_write64_relaxed,
         writeq_relaxed <- u64
     );
 }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index e4878c131c6d..620022cff401 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -16,8 +16,8 @@
             Region,
             Resource, //
         },
-        Io,
-        IoRaw, //
+        Mmio,
+        MmioRaw, //
     },
     prelude::*,
 };
@@ -212,7 +212,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -226,10 +226,10 @@ fn deref(&self) -> &Self::Target {
 ///
 /// # Invariants
 ///
-/// [`IoMem`] always holds an [`IoRaw`] instance that holds a valid pointer to the
+/// [`IoMem`] always holds an [`MmioRaw`] instance that holds a valid pointer to the
 /// start of the I/O memory mapped region.
 pub struct IoMem<const SIZE: usize = 0> {
-    io: IoRaw<SIZE>,
+    io: MmioRaw<SIZE>,
 }
 
 impl<const SIZE: usize> IoMem<SIZE> {
@@ -264,7 +264,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = IoRaw::new(addr as usize, size)?;
+        let io = MmioRaw::new(addr as usize, size)?;
         let io = IoMem { io };
 
         Ok(io)
@@ -287,10 +287,10 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for IoMem<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: Safe as by the invariant of `IoMem`.
-        unsafe { Io::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(&self.io) }
     }
 }
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index b1a2570364f4..75d1b3e8596c 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -45,12 +45,16 @@
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::io::{Io, poll::read_poll_timeout};
+/// use kernel::io::{
+///     Io,
+///     Mmio,
+///     poll::read_poll_timeout, //
+/// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -128,12 +132,16 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::io::{poll::read_poll_timeout_atomic, Io};
+/// use kernel::io::{
+///     Io,
+///     Mmio,
+///     poll::read_poll_timeout_atomic, //
+/// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 70e3854e7d8d..e3377397666e 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,8 +8,8 @@
     device,
     devres::Devres,
     io::{
-        Io,
-        IoRaw, //
+        Mmio,
+        MmioRaw, //
     },
     prelude::*,
     sync::aref::ARef, //
@@ -27,7 +27,7 @@
 /// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
-    io: IoRaw<SIZE>,
+    io: MmioRaw<SIZE>,
     num: i32,
 }
 
@@ -63,7 +63,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = match IoRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:
@@ -117,11 +117,11 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for Bar<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { Io::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(&self.io) }
     }
 }
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index ef04c6401e6a..38c949efce38 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -7,6 +7,7 @@
 use kernel::{
     device::Core,
     devres::Devres,
+    io::Io,
     pci,
     prelude::*,
     sync::aref::ARef, //
-- 
2.51.0

