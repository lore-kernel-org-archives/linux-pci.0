Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5224E3783;
	Tue, 14 Jul 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048349; cv=fail; b=pyLk996VC4rdN2dtWHwvQG6zXwz6q24CdbyP/d2aKOksM7Ygjk7aj6LoEsBbRYLKm/MILrsOZ4xHz1dul/5MhOnRErtfaHzAlbNJrbqnWXmIsWRvIEez2p5N7fpJr/FhufXUdBH3mG15a4RYceU9hEFH8bk7tBAIsY0r8XQnSNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048349; c=relaxed/simple;
	bh=CJzMqodLBu2q8CZWcIiPcev8aZdLJRQgIrsV0d175as=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQXUeYDyBPwQ1lefgpY3u3mstiutL/RtqxvCT2keqzhV0XVvHNTMgq7cJfzC4x4gMwHvw8n6gPIxYLYyaJKng4QPWBJeUtZ4EX53e+R/hZn/QBf5p1cRehd6nhil7CQMD0Iu06cRb3GWd/oG4gAwL8uAcSVrlQ+cGBkGVwhocj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nd00IMeG; arc=fail smtp.client-ip=40.107.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nd00IMeG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn2vy2W5UalH9xHing7qv7iqtXqdSzzUXNTg8sZaCQQgZ4hAIVeM3exOknEO2fTj4Y/Mp90M6RZ59iyFhS86r5/jTjNBHAwHudz5V2iXF4lsTAm0nE3cbw9PryrQZhjQ+5RRG6YGPVsbM114OYfhdSLJi3CZ5/V7VClXuLpK0yKtDkFsPazIvuE6kJEcbKMFUJQxh/mjropmxZwuDmh8HjhgCyxjgawCxmu+A4hQdO9IVvGUojD2xh+zlYMmoBQ3oIJ926M3mbxiD29O0jk5VLlWaDaMibHppAxmIIVs+fv4mI2MMJRVtiVfrNWLbue/dgo75lv5p4C/flbexyhPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFqFpsGe5XJ/AL0LAeCHT0K8VgtwVSMb4thpUG3te2A=;
 b=BxRjwsiViKWRMDwz19ZhANWY7jxQAPsssnr2cQ7DXZgxrlbricOSGbnFy6C0MF9Ez3vIS1TtYKyIA7WRlHiN8mjdcknhyaSCi65NUTZulvTICGPYSHsSZk9PVmLm+bt3DH311i7H7/1SY7CoROVnywOj23ZjSGweA8IUsFCcZ7n2Qt1mQTXPXFXdUMxs+emxLJ6CdpK/dZDswk/O8ukH3Oussq1lIHX+pRQ0rt53XSxo7txJa/5n8Pax2pFE7rgyeQuBzigQK+wj3yCDDnXhptm0I9PzLTZ3i30dQ3n5tgxB9NdsE/B9EJHRqFdZ7cgxwUjGX/w3LPwSFHzbiV3Pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFqFpsGe5XJ/AL0LAeCHT0K8VgtwVSMb4thpUG3te2A=;
 b=Nd00IMeG0Bp8bwts3fD2Q+IgzoDklpDQumcQje4ecCxKNst0vZRaYoy4TUfYH2SVONpJBSEO3vqs/IeZA0Oi1OmfFHlhItUhsEChYwpjRG8yGvXM/jxCEXPMXrCOdtDc/h64a7cHUT34VHjmkhwGJf+ZKgsKncgJfjyv3hcI0dndc8/iUw8Qt80V69NdgRWSCDThlNpvq/q3y+8CaIYCwYgcPXKxDbXblb354FS74LlXMtDNPQasKH6dq42D/qofI9Wcr1lqX6Dwutkc3CMxDTxdQADpRVYa/JnS0/T/tcXUd4LAuNkmUjwA6QAYFBogcPUgDgHV5SwBJET2IMDrAQ==
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 16:59:01 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::5f) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 16:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 16:59:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 09:58:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 09:58:41 -0700
Received: from inno-dell.mtl.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 09:58:35 -0700
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
Subject: [PATCH v4 1/1] rust: pci: add extended capability and SR-IOV support
Date: Tue, 14 Jul 2026 19:58:26 +0300
Message-ID: <20260714165827.2937960-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260714165827.2937960-1-zhiw@nvidia.com>
References: <20260714165827.2937960-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: f2551ed1-f39b-40d5-8162-08dee1c933d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|7416014|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0ciD+2qq4fpCE8fMA2oT+t5wOPyOck1sT76GOJ5B0BArU+hZb6GOpPDN3ro0MwKG1aAzS9uslNcDR5c2VXhejDEMmW1bGjkIKjZ1w4/G20T7d5x49qx4R8iszof18q6yfDBt9XwnRAE9CQ4T7yHJksOJbAu+ajE31xjdjcUcS/dcolspf4WwI21rMZ9LdeXF+SIFp7jf/mNuQ6PP++5QtITfn8FYzoZXvbJ08RjkKS1Sy+yWzBjRI4CKtjUYAh1X3t/Sow7p4EMlnC468jNICcvLsnO+rKn7GDoZpExLRyF6j2w1zdfzoDxen+4n+KVqRDXwdlzVU7Wg6Nun4xEq6Sf23GtB9nmKIXoCpDIWnDSRBzTGlIgFItOE6LwOAO99Y5hNQoaO+qkc/uKqAi4ydpf157JgOnNG6XFcQeS6pOeDPw77edLbqLVbDSrNxeIpuYtEKVF0ZnJH53le9oA5jZZe3ldmHWqS5jENcvdm79aODEIHL7wSEuld+4mYvKp4k5XlcEYu9I4UcjPyuuwjhpYKwD6nC2Ld8nbVCy+2NHXRO0NjI64tdpqaAw6r4i9rj/qmRvVVR/Ra3TguJirvqkAvepzAd0agR8iEdYHOUrauAr6bkOT/yKJAI/LWiHxWw+fvITR813GcTEfEB2koiDJETmaI/V5wX4ZqYAi76hub/RJNn/6neeNWJKbXGTDwFLj0Pc6tY1MtuwnP42PbSA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(7416014)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mL1acqDYl9YyfB1wk0G/cEJFD21g8H13FlDhbljIheie1rNgf66wKZFPKOv7AxA/dEpzThA91Xnixil92xZANZNPmaRCWTy58ez1PgfpduqvMYKNlStC6mk3ROBPARWbQ/5SC3qc+dLeefskptNYf8aH6w7xhs/asCmzhcRdnSb0+4KrikI0nrzuhuAs90eY/dDDUaV9kzcYSc23w7WbvKszXaIMfthr0T0/onxL9fUmqrSYIL8ifNxZwTi7Qk6v/W95eSQsq7y/uiEGiR9yA9o2ZHBHGsYndizuAkDyjBeayfXVHnpE66N/R1C0T4LsZ2gWo0ml+jQHiljey0yfg1AVTmKL6CyJd3lZue+Fo4w5jQWlzE85aAOsO8HSlftcYJOBDHBKEOl5mM4YT1SaLKYY67nZ1fXoDjpssWv2vaP8+l+iEuAQ5fVtZeh3L+T+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 16:59:00.6487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2551ed1-f39b-40d5-8162-08dee1c933d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470

Rust PCI drivers have no typed interface for locating and accessing PCIe
extended capabilities.

The SR-IOV extended capability describes VF topology and VF BARs. Expose
this information through the Rust PCI abstraction so drivers can use the
existing typed configuration-space accessors instead of raw bindings.

Define ExtCapability to associate a capability ID with a register layout,
and add ConfigSpace::find_ext_capability() to locate and project that
layout. Bound the view at the next capability or the end of extended
configuration space. Add the ExtSriovRegs layout and helpers to identify
and read 64-bit VF BARs, using PCI_SRIOV_NUM_BARS for the number of BAR
slots. Since PCI_EXT_CAP_NEXT() is a function-like macro, expose it through
a Rust helper.

Link: https://lore.kernel.org/rust-for-linux/20260409185254.3869808-1-zhiw@nvidia.com/
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   7 ++
 rust/kernel/pci/cap.rs | 209 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index e44905317d75..5043c9909d44 100644
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
 #ifndef CONFIG_PCI_MSI
 __rust_helper int rust_helper_pci_alloc_irq_vectors(struct pci_dev *dev,
 						    unsigned int min_vecs,
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index ee25ae56bb92..5858a7525ec1 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -31,10 +31,17 @@
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
+    ExtSriovRegs, //
+};
 pub use self::id::{
     Class,
     ClassMask,
diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
new file mode 100644
index 000000000000..a37c96d3d539
--- /dev/null
+++ b/rust/kernel/pci/cap.rs
@@ -0,0 +1,209 @@
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
+    ptr::KnownSize, //
+};
+
+/// Number of VF BAR register slots in an SR-IOV capability.
+// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
+const NUM_VF_BARS: usize = bindings::PCI_SRIOV_NUM_BARS as usize;
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
+impl ConfigSpace<'_, Region<0>> {
+    /// Base offset of this capability in configuration space.
+    #[inline]
+    pub fn offset(&self) -> usize {
+        ConfigSpaceBackend::as_ptr(*self).addr()
+    }
+
+    /// Size of this capability region in bytes.
+    #[inline]
+    pub fn size(&self) -> usize {
+        KnownSize::size(ConfigSpaceBackend::as_ptr(*self))
+    }
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
+    ///     let bar0 = kernel::io_read!(sriov, .vf_bar[build: 0]);
+    ///     kernel::io_write!(sriov, .num_vfs, 4u16);
+    ///     let bar0_64 = sriov.read_vf_bar64(0)?;
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
+    pub func_dep_link: u16,
+    /// First VF offset.
+    pub vf_offset: u16,
+    /// VF stride.
+    pub vf_stride: u16,
+    _reserved: u16,
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
+impl ConfigSpace<'_, ExtSriovRegs> {
+    /// Returns `true` if the VF BAR at `bar_index` is a 64-bit memory BAR.
+    #[inline]
+    pub fn is_vf_bar_64bit(&self, bar_index: usize) -> Result<bool> {
+        if bar_index >= NUM_VF_BARS {
+            return Err(EINVAL);
+        }
+
+        let bar = crate::io_read!(*self, .vf_bar[try: bar_index]);
+
+        Ok(bar & bindings::PCI_BASE_ADDRESS_SPACE == 0
+            && bar & bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
+                == bindings::PCI_BASE_ADDRESS_MEM_TYPE_64)
+    }
+
+    /// Reads a 64-bit VF BAR from two consecutive 32-bit slots.
+    #[inline]
+    pub fn read_vf_bar64(&self, bar_index: usize) -> Result<u64> {
+        if !self.is_vf_bar_64bit(bar_index)? {
+            return Err(EINVAL);
+        }
+
+        let high_index = bar_index.checked_add(1).ok_or(EINVAL)?;
+        if high_index >= NUM_VF_BARS {
+            return Err(EINVAL);
+        }
+
+        let low = crate::io_read!(*self, .vf_bar[try: bar_index]);
+        let high = crate::io_read!(*self, .vf_bar[try: high_index]);
+        Ok((u64::from(high) << 32) | u64::from(low))
+    }
+}
-- 
2.51.0

