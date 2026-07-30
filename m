Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44958175A81;
	Thu, 30 Jul 2026 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436248; cv=fail; b=IJPt84bQhPZynQ2wn+u8NcD+rHbOBMuGdX9S/3k+TUokr47XOWeWYI9F92L8GrS5fw8OzEa7HZCYXLMTS7APeQX1foEmdqP01sKcivMEGB6QbT5FsZpGTVCInUrnBQTyOcVyfKL2bAmLTmj/RRDkMVRTIwV6L67BuYiBZ09xdss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436248; c=relaxed/simple;
	bh=bp/l9pTXmUcNqdX37v788Z9WbdqDj3ESWVjhjx8t5/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhdN0iRTRwKr4sUupKQtcSqYPQw5zpSxRlm+jslTj3WxhsevuVDMCwwjWks3a7klJke9X5KaXe82gLHYjV/Akj8MI2lPFu7IM2SXX703qkQqK3gmbCtxdn6H5L61kz+I/yvIs8iM6Wxf1WMOGWxW/U2LahHqNrjUPBJDjABGYas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JikTFyxJ; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JikTFyxJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPDRMXJnmpQjry+EZYcZxRkuRQtFsPyYuHzJSogtrRtFP0NSjlvA3CuaRW3r8/GJaB6I2ouN3i5/y8gZFNItWv9vEWdHTGQpKiUNA/85GtMrJO9EMk7NX5osz7c6o5WZmQhFOpqokf5N3JEgqQ3fToOu18vM9IB/Fi9ZCpxGrl3g7DWdyqTfv6RzVkEqF5iBSpE65L6zMqEvNLzh9lRplBBk7J8FK4/Rp5+QhA0vwd5IY377/wdOAA4XyXFyZAq6SFjKmjOjLc61WSeZ2DiekqWoUWFKLG+Yrej/zlzeyxmOGdpV8UehRuQUkSUTLElheoAsZN7h0O7UEdVr5fS3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMglMGfE4Usat6a/L0Hr8hP0jjIKJNN806b0YXroVyM=;
 b=xokYdZ7n4AcvcKGtd1Qeg+Maicoy4QAL1roj7UqLoyLWfrspbYH6afdM3CEXbHIOcDv/pjtIfaGRiqwyaZvMwZHEUhJDn85Co0v0GW+voVWD+X0DJ7DLsUAdToSp+JkaS5zI/4Yjrg7SSENY/WhLDjLSNTPxhWWLj5N27aGWSETptb/sLTvX8f/gITJxk7tpCwnZNIi8dx/7YsAvX/nY6iqn4zPvybcZtS1Ssd1S4cmokrVwIz0S7H5g8Pf0avFSTNtHIeWM9RX0txpvJRLrBKTZJBTKeS0L6LNaECgrxalXC/hBT9fwz0BC51SDlUPaZJ2MA7OKfj1qQTbKNMbzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMglMGfE4Usat6a/L0Hr8hP0jjIKJNN806b0YXroVyM=;
 b=JikTFyxJPMOLLook+udKoCeksyeg3IApZSoQ70bh10XJQEoLFzuCnVxlnzN5F33sDJZ4chIu0U2nyVR2hm8Pqbf8oZgGIZywddvvYc9Yj5FCeq/bxDjYPGoFp2qgSE8BaRBdRe3Kh58tIN6F9rfGwH5Tj4knqOu3QErgFP2/nAK7HXEw7NTs6HFf8FoPZYzogwADivN6ae2A+0sBjFVDVrBqYQFk7muZQBm0mpBOt/U6Y+Fj2yePzmWRsY10b3SiI0rrT5vL1Gmb4WTdjmMIX6jZxv4Ksti1MfK8y3kHfZjZ0K+7ODlCKzZD0UL1tvkd4Jn0f2mDS3iZDVNc+8BjFw==
Received: from SA1PR03CA0006.namprd03.prod.outlook.com (2603:10b6:806:2d3::19)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:30:34 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::20) by SA1PR03CA0006.outlook.office365.com
 (2603:10b6:806:2d3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 18:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 18:30:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 30 Jul
 2026 11:30:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Jul
 2026 11:30:13 -0700
Received: from inno-dell.home (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Jul 2026 11:30:05 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV support
Date: Thu, 30 Jul 2026 21:29:53 +0300
Message-ID: <20260730182954.783568-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182954.783568-1-zhiw@nvidia.com>
References: <20260730182954.783568-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: f0bb2a76-9263-4fe6-2b92-08deee68a4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|6133799003|11063799006|3023799007|13003099007|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gAW/i0w0b5uif82bdIaWW/rnJyXszniCMyquxre2E9NhX6b1VSLURfj3igMy3+Gqz33rSh+bPS82LkdTCpr6mOHTZWdzMYX0/4zd7+BtfmIYcSir4hnGBLaE15u49eBPatj/WHj9WYB4fVnOEquxzvDF//ZC0PrcUysVytyjL9pQ7P3TXHm0be3eZ6xqf0snR5HqIhA8wwIZD8ePns5WV30T2W+fMRGV27EdZEF2XRBIP0QXje5ZeWAorQZIBpd9KnvogVEGKRwMd+V516p8MG9Ho6NJPChPh8ICU0SIhjjh698t7ciGz7mWk2FXBPOFTw9YRosG0arJwjtLzcTRfKu19SG7hv7bMDD3fyj0A0gY33RgfO86nNG5XielRop/NeBsCWEo/JaeTpI26nyPW3q3S+fAJdZMEk1zAhfPiKm9V7aewle9LHpZkmuh/p33RLmghitzgygT8X0kHbgUgt/BRgpVqd+e41SgqEl2qPAo2LDtwNAWPnFfS7bQb3M/9Tpus7Y3nQxHa6Jeebzm+AZ+lw5GXmhIB1vFtkmvX6LWwTRGFaQgEu4f8iEiYJFxEAUwiP8+yJGLUc/XjAxj4zVmi6E5mADmpkE2NrYKscNJebMvxnKDUcvYBUu2/GhO7yPEo8N5ktdGfLCovyTVt1pHiGZIgZ/kj7MSWyNx2mqouVPW+kl7Wqg1yjwxJGms2ozGaSLwImhwdv6Ysc5pqg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(6133799003)(11063799006)(3023799007)(13003099007)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QyRZ/Dr+A88C9ra+/2+N/5z144w0OjJ8PKGon5iIYfFILPHnD/nffcjUY+k7DaYy9X6eI5rUM7XUHNzt0T3mE+PL097M3+cme5prQ1Z2usmed7oyqmRoTBxhLZ9QzildFTR1fnVFIXTFy4X3aHrr9cDpi3rUi8bg/fiyq4UWnlWK0xWXZa8bauCGJSvNvhodXibBRxjxEcvFb98T1YCMz2kiJUHq/yVJzQ3/R/RC2x8Uf0wbG189k3bi8/gEWEvY8mqzh0eTfLcnnaX6OfPa/NKyYz8trjvzvcv5U3JvGL/n+Ah7rWfC6a6khBEIOC9wo3DRYymi03aTUC+zJRhAv2MSP+I1T5Blzx5VQ9T0huo5OZnA3kdIFFd/yY4nue1I6Olx+5/12kqdIKnJL2OmWcl2cNAFq90cGCaDxA5aaf7IMUzPl0RnlQxvI3cIFMxR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:30:34.1147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bb2a76-9263-4fe6-2b92-08deee68a4d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

Rust PCI drivers have no typed interface for locating and accessing PCIe
extended capabilities.

The SR-IOV extended capability describes VF topology and VF BARs. Expose
this information through the Rust PCI abstraction so drivers can use the
existing typed configuration-space accessors instead of raw bindings.

Define ExtCapability to associate a capability ID with a register layout,
and add ConfigSpace::find_ext_capability() to locate and project that
layout. Bound the view at the next capability or the end of extended
configuration space. Add ExtSriovRegs and a decoded VF BAR helper that
returns the address, width, and next configuration-space slot, using
PCI_SRIOV_NUM_BARS for the number of BAR slots. Since PCI_EXT_CAP_NEXT()
is a function-like macro, expose it through a Rust helper.

Link: https://lore.kernel.org/rust-for-linux/20260730180349.771719-1-zhiw@nvidia.com/
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 ++
 rust/kernel/pci/cap.rs | 236 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index 4ebf256dff23..b946b14d79e4 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const struct device *dev)
 	return dev_is_pci(dev);
 }
 
+__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
+{
+	return PCI_EXT_CAP_NEXT(header);
+}
+
 #ifndef CONFIG_PCI_IOV
 __rust_helper unsigned int
 rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 9f19ccd5905c..008c2770a3f3 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -32,10 +32,18 @@
     },
 };
 
+mod cap;
 mod id;
 mod io;
 mod irq;
 
+pub use self::cap::{
+    ExtCapId,
+    ExtCapability,
+    ExtSriovCapability,
+    ExtSriovRegs,
+    ExtSriovVfBar, //
+};
 pub use self::id::{
     Class,
     ClassMask,
diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
new file mode 100644
index 000000000000..08c044bedb70
--- /dev/null
+++ b/rust/kernel/pci/cap.rs
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI extended capability support.
+
+use super::{
+    io::ConfigSpaceBackend,
+    ConfigSpace,
+    Extended, //
+};
+use crate::{
+    bindings,
+    io::{
+        Io,
+        IoBackend,
+        Region, //
+    },
+    prelude::*,
+};
+
+/// Number of VF BAR register slots in an SR-IOV capability.
+// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
+const NUM_VF_BARS: usize = bindings::PCI_SRIOV_NUM_BARS as usize;
+
+/// Attribute bits encoded in the low DWORD of a memory BAR.
+const VF_MEMORY_BAR_ATTRIBUTE_BITS: u32 = bindings::PCI_BASE_ADDRESS_SPACE
+    | bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
+    | bindings::PCI_BASE_ADDRESS_MEM_PREFETCH;
+
+/// PCI extended capability IDs.
+#[repr(u16)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum ExtCapId {
+    /// Single Root I/O Virtualization.
+    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
+    Sriov = bindings::PCI_EXT_CAP_ID_SRIOV as u16,
+}
+
+impl ExtCapId {
+    fn as_raw(self) -> u16 {
+        self as u16
+    }
+}
+
+/// A typed PCI extended capability register layout.
+///
+/// Implementors describe the register layout of one extended capability. The layout must start at
+/// the extended capability header, and [`Self::ID`] must identify that layout.
+pub trait ExtCapability: FromBytes + IntoBytes {
+    /// PCI extended capability ID for this register layout.
+    const ID: ExtCapId;
+}
+
+impl<'a> ConfigSpace<'a, Extended> {
+    /// Finds and projects an extended capability into its typed register layout.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::pci;
+    ///
+    /// fn probe_sriov(
+    ///     pdev: &pci::Device<kernel::device::Bound>,
+    /// ) -> Result<(), kernel::error::Error> {
+    ///     let sriov = pdev
+    ///         .config_space_extended()?
+    ///         .find_ext_capability::<pci::ExtSriovRegs>()?;
+    ///
+    ///     let total_vfs = kernel::io_read!(sriov, .total_vfs);
+    ///     let vf_offset = kernel::io_read!(sriov, .vf_offset);
+    ///     let bar0 = sriov.read_vf_bar(0)?;
+    ///     let bar1 = sriov.read_vf_bar(bar0.next_index())?;
+    ///
+    ///     Ok(())
+    /// }
+    /// ```
+    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<ConfigSpace<'a, C>> {
+        let offset = usize::from(
+            // SAFETY: `self.pdev` is valid by the type invariant of `ConfigSpace`.
+            unsafe {
+                bindings::pci_find_ext_capability(self.pdev.as_raw(), i32::from(C::ID.as_raw()))
+            },
+        );
+
+        if offset == 0 {
+            return Err(ENODEV);
+        }
+
+        let size = self.calculate_ext_cap_size(offset);
+
+        let base = ConfigSpaceBackend::as_ptr(*self)
+            .cast::<u8>()
+            .wrapping_add(offset);
+        let ptr = Region::<0>::ptr_try_from_raw_parts_mut(base, size)?;
+
+        // SAFETY: `offset` was returned by `pci_find_ext_capability`, and
+        // `calculate_ext_cap_size` bounds `ptr` at the next capability or the end of the extended
+        // configuration space. `ptr_try_from_raw_parts_mut` verified the region layout.
+        let capability = unsafe { ConfigSpaceBackend::project_view(*self, ptr) };
+
+        capability.try_cast::<C>()
+    }
+
+    /// Calculates the size of the extended capability at `offset`.
+    ///
+    /// The capability extends to the next extended capability, or to the end of the extended
+    /// configuration space if it is the last one. `offset` must be a DWORD-aligned offset within
+    /// the extended configuration space returned by `pci_find_ext_capability`. If its header
+    /// cannot be read, the capability is treated as the last one.
+    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
+        let header = self.try_read32(offset).unwrap_or(0);
+        // SAFETY: Pure bit manipulation, no preconditions.
+        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), always fits in `usize`.
+        let next = unsafe { bindings::pci_ext_cap_next(header) } as usize;
+
+        if next > offset {
+            next - offset
+        } else {
+            (*self).size() - offset
+        }
+    }
+}
+
+/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offset).
+#[repr(C)]
+#[derive(FromBytes, IntoBytes)]
+pub struct ExtSriovRegs {
+    /// Extended capability header.
+    pub header: u32,
+    /// SR-IOV capabilities.
+    pub cap: u32,
+    /// SR-IOV control.
+    pub ctrl: u16,
+    /// SR-IOV status.
+    pub status: u16,
+    /// Initial VFs.
+    pub initial_vfs: u16,
+    /// Total VFs.
+    pub total_vfs: u16,
+    /// Number of VFs.
+    pub num_vfs: u16,
+    /// Function dependency link.
+    pub func_dep_link: u8,
+    _reserved_0: u8,
+    /// First VF offset.
+    pub vf_offset: u16,
+    /// VF stride.
+    pub vf_stride: u16,
+    _reserved_1: u16,
+    /// VF device ID.
+    pub vf_device_id: u16,
+    /// Supported page sizes.
+    pub supported_page_sizes: u32,
+    /// System page size.
+    pub system_page_size: u32,
+    /// VF BARs (BAR0–BAR5).
+    pub vf_bar: [u32; NUM_VF_BARS],
+    /// VF migration state array offset.
+    pub migration_state: u32,
+}
+
+impl ExtCapability for ExtSriovRegs {
+    const ID: ExtCapId = ExtCapId::Sriov;
+}
+
+/// A typed view of an SR-IOV extended capability.
+pub type ExtSriovCapability<'a> = ConfigSpace<'a, ExtSriovRegs>;
+
+/// A decoded VF memory BAR.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub struct ExtSriovVfBar {
+    address: u64,
+    is_64bit: bool,
+    next_index: usize,
+}
+
+impl ExtSriovVfBar {
+    /// Returns the BAR address without PCI attribute bits.
+    #[inline]
+    pub fn address(&self) -> u64 {
+        self.address
+    }
+
+    /// Returns whether the BAR is 64-bit.
+    #[inline]
+    pub fn is_64bit(&self) -> bool {
+        self.is_64bit
+    }
+
+    /// Returns the configuration-space slot index of the next logical BAR.
+    #[inline]
+    pub fn next_index(&self) -> usize {
+        self.next_index
+    }
+}
+
+impl ConfigSpace<'_, ExtSriovRegs> {
+    /// Reads and decodes the VF memory BAR at configuration-space slot `bar_index`.
+    #[inline]
+    pub fn read_vf_bar(&self, bar_index: usize) -> Result<ExtSriovVfBar> {
+        if bar_index >= NUM_VF_BARS {
+            return Err(EINVAL);
+        }
+
+        let low = crate::io_read!(*self, .vf_bar[try: bar_index]);
+        if low & bindings::PCI_BASE_ADDRESS_SPACE != bindings::PCI_BASE_ADDRESS_SPACE_MEMORY {
+            return Err(EINVAL);
+        }
+
+        let is_64bit = low & bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
+            == bindings::PCI_BASE_ADDRESS_MEM_TYPE_64;
+        let following_index = bar_index.checked_add(1).ok_or(EINVAL)?;
+
+        let (address, next_index) = if is_64bit {
+            if following_index >= NUM_VF_BARS {
+                return Err(EINVAL);
+            }
+
+            let high = crate::io_read!(*self, .vf_bar[try: following_index]);
+            (
+                (u64::from(high) << 32) | u64::from(low & !VF_MEMORY_BAR_ATTRIBUTE_BITS),
+                following_index.checked_add(1).ok_or(EINVAL)?,
+            )
+        } else {
+            (
+                u64::from(low & !VF_MEMORY_BAR_ATTRIBUTE_BITS),
+                following_index,
+            )
+        };
+
+        Ok(ExtSriovVfBar {
+            address,
+            is_64bit,
+            next_index,
+        })
+    }
+}
-- 
2.53.0

