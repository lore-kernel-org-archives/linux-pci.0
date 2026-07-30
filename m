Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744553AAF4E;
	Thu, 30 Jul 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434689; cv=fail; b=dzdCzRCM1nWLbRBMUOFj1X2XavZfZY9X2CFlmE4nc2e2wCj8NJ0xhMLmAWP67DmWPrAiPo+ztzJBM0qqgXMfF9WVYFJP8T04pIpX5ctbH6QKIvugwIdfJQQW6aSVuPt1Abv3kL7m5cfnLd1A4oUhQ0lUYmoF041jmKXeqBV6Vtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434689; c=relaxed/simple;
	bh=mG9TTVQuxe6M/ny3CrsgIZ2+iBanHvwIn5/gKKMna7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYychR8DqtyzhK2DbVpdXtUGbyBnS3wP5A8Io3RtpQDVUrnb5nNvRHMGWSPgkrmI0roPLzg7OFxxkoc24mBq6sm5EqobSbeoskBW+xXXrJMpRSbyKkjcnZJup2ipybSR9PLSJh8C2aUNuI78lxvLBBUjtu+VFsdLdbd7goHnu80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cuMOIYNz; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cuMOIYNz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWSqrQ4jkKjj0svHLj3GNg7R+HecysRXICrgHucuKp3hLrlKgzKGvrte/eP4T3g5HAij5G460eNbYJTuGxb6Ts1ap6xRcWswrTl7FxrLQVv/2LEMaXE0/JYhBNl/NZ4cX2vTcmQ1op3Tb3lghSZ7OfzDpfQoqdSgF7O2NS6F3A5To0e65JkBEpQn+TARHzsElwxakUbkjBgsYkKECYZz/nCcv7CuGn0geB9dM/RDa687Sgdq2OQWcnb5CesmPiE5I7MPSvVBI0S5lm/y6FZ9izDFN0+/mlpvW+P8LGCQ80BEAsMWICYCxD/55T2xkUvvwgo7HF7R2IVM0vsalZ2etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LrnmziKh122kuASYiH3tRdnJb79Lik4EcW9fztAD60=;
 b=eW4m606L+rmylX3ihyx667sQUEjkPrKsLCsLP9HWX8ka4uR2JSEF3c1xo6NmPpew74lzAAAzt+qyyp63pKKWQa4P2EiQzlrcRMHLa6hZ46TZBhLeCVtM2klwZ9hUQSvvt2GKZeSBNGYXotOTn/iQMJV2b9laP95Fd4SCgnRhHoGlN225KaIa8i7YF0vQboq47yBZcMeci1MRgaTbfO+WpW4+oEz2yc87vuZoFBzDmZnBYvXXr9uvfspAlh2ZsUD1MR/fAKBM2f4ri9+FEZs/fq4vd8ocMGrjpu0p3OUX479wj6ZwqWhKYooEouINRchA9ub8SpRchEpg8Rn5eDeJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LrnmziKh122kuASYiH3tRdnJb79Lik4EcW9fztAD60=;
 b=cuMOIYNzBKDiMuluxQD0rt/Eeq9e5S+kFTtETwOZ4Ugt7kPmpEbKp3iyu6mUn4Fh8YzQ6NODWAV2KjPzw/oBeFatMOiusWrDlevkQA/ZlkSOCrbyTMYkqO0RBupQ/3NyNTcdBOsZB90SaD1aOkP7LnMkiSDT759/Mcjevf93mo1LbC2gebhtEtDcgdS1fKTU2Kt6U/4PPJTta2rdlkjKV9C+ikrcwz+J3C4QzEpJ2gOD+c9ZK20ranD3HTRCnps8sOwJ9eG7q9kV/hfO7HdfmlSnLHzUqPCeH6uM/UObKRG3JkZ/sLkD5sxCHKQw6AH+62X5vPEbeLETW+HOyl+xGw==
Received: from CH0PR03CA0078.namprd03.prod.outlook.com (2603:10b6:610:cc::23)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:04:34 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::27) by CH0PR03CA0078.outlook.office365.com
 (2603:10b6:610:cc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 18:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 18:04:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 30 Jul
 2026 11:04:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 30 Jul 2026 11:04:13 -0700
Received: from inno-dell.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Jul 2026 11:04:07 -0700
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
Subject: [PATCH v5 1/1] rust: pci: add extended capability and SR-IOV support
Date: Thu, 30 Jul 2026 21:03:47 +0300
Message-ID: <20260730180349.771719-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730180349.771719-1-zhiw@nvidia.com>
References: <20260730180349.771719-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 324542bb-eca3-4972-6f6d-08deee650226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	oKV8dYqtGJ6eQoVp+Jqt2iquX7iXrx9LwidKXVBG4rzOmgF6Qq9qBFEs//ph67CmLfA7e7HBOG37A6TMi8FswFbzTsyPq60vNBg0cwr2qrN77ihicAH2Hzg02O4rvtMWVtYzTbhcBypZavTmL1qY2WmNDjD1vggy5LlR5UfO6UR9+tSuUytrVKo+4YeQrbFY73NQqBKCCzo9IBedUOnXRhIEiqnGbYbHT9uzi1BaZoUH/XqWsAaeFgGNYyz9Nv8G+6yad7amnzrFfJeJAS69Mi/JNdlVHIFKYjaudUIeBL/MIPWU02dlckrvsS7iaXGIrVgM59oOjCWPpuT6V3tFD87GTDLskVg7CM/D1CZ9MMrucFoNC/Z8UU9ub7eg/PiqKWnRqJU/b5ECxoFA2FJIoyY7Iu8vvhfLdZO0RdmsMTtMebiHCCucv7TUCDZQB2axkzzTEGldg9+TjItCdTiLAnM4d90dF22If4uGQSHEvPP9iR4CrTyGpHN/TtqZ7Hp6BBaz7wM9FRsD2OK+/Dm/5RJmNhmaeTCUImGCJDdtctphG2gq2nCn4RkYi1m5U7U5E8MkQSUukTPzrBh7cyzxyWhQPp1jecuXWSBKJdcAbEZMGSn/aiRBBf0b1oVxTXFpYwDX47Uj+oQVxhdYtpDEvdG1tJhQ97DUWgsI6M4hLxtQquHZEBwnd99yaU+OAOqD1mYKDpCeIMkk7KPd4PFfKA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YrI+rACdWUyaIZCRQoQ+CAQv8gCwvaqMZCO+lYrnStr+Qt5cOTC0A3bRVZesaz0e/flM/xAgtLIBKPHa3ynwGkB/s7iwx25PvBAuJ1LRMpg4vXxfC0vzBlIOLmDiYga66EIdwqRawWFGoYv7D8OuRVVvWEIII7jpZTnqOEjugJe0YWW5nAburlJs4gGw8NpnEzkYTS+6/KYGVbnY9r4WyV1LwZawV4uGir7zHablyoHaKwAvUKUbJkyWTwdIFMjjZVItwyW1MmkUCPRjG246e/ZqrvMgQ+k+Kb3jCQr1Pw8hkl+eiLAxvZidHzL+Bhs2Fhy/K8qGw7YcX/3nkXxZ3jjDULabn++vfWnPTJMhRuEt90jPstZg+u5jGlwOujBLPoxuD9iVFsPzOpNFbkjw/JQN0YHls0s2sn6G4Ep2GOoXfJC4FcCwCcpqSsp0+drY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:04:32.7156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 324542bb-eca3-4972-6f6d-08deee650226
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880

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

Link: https://lore.kernel.org/rust-for-linux/20260714165827.2937960-1-zhiw@nvidia.com/
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 ++
 rust/kernel/pci/cap.rs | 251 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 264 insertions(+)
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
index 000000000000..004ee62bd089
--- /dev/null
+++ b/rust/kernel/pci/cap.rs
@@ -0,0 +1,251 @@
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
+    ///     kernel::io_write!(sriov, .num_vfs, 4u16);
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

