Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2643CE47;
	Tue, 18 Aug 2026 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042847; cv=fail; b=SHJxHvVtxNswjvZJM6U6haLi5rbFGgSyRAcWnJJEDRIPitMjHEi5p+0UW3aCK4tGIEdFUZkO6fDvopX8E42KiFdRK/rszaiex+1vS7QGKm5KTOw71qsoKSzoAurlSaCduip5S5ndYIcFdkUzXjDkMaiz5tk9sdASeGQ7b6OlaqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042847; c=relaxed/simple;
	bh=Wie6t9iu3tlHjFLx7IycGc70YJjFVoV9Et68bOHtsFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrJHDpAF7YXShcI/FB8t4y7wbIQitWulnqKxq/IY2o3bzmZuwqsFnSrxlS+9dauUFEoJy54QePeXZStu9MN5Stqu/17deiFwM4dWoR1hEegDkM1G1kDhqX7xm2DCCyllMeOihCNy1mZqEGiIViAsIgE3YelNt/eEQ1C6TLs+hEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T6NlH4W6; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T6NlH4W6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAhX0zKUoQ4buu3GicAxAmDYjI6luMOWnyLHNI5P743mKgMcrjyTS09t5bTSUWoiKtZgxljGcZUDDfM1bwJgcK7IGIgRuLwtRKUbywnUkHRwmoaXh4Ld10n4P71TKOUaGrBFhcMiH/37WJWP02N5WAHYOLMBBVorSY4EBVorSctFcWtblKH7JjT8cimhZR2dgeaK2XRjGLMtk55gdweRO5bdONHN8YtJ483lfG4ocOAwtMmtM0jKCv26E0t3r+ZehTg/jfFQuOrI/CbgCSDFiv3u/WMqYJW4KbewC1mT/CeB1i/Wsi/ehPQHT8XhQRV3lgwmo1w+zJBISyRvYz/8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyMKc5WbCgCs+mFtF0uX59cf/6yFRrueIwmckxC4pSI=;
 b=utFGJ8vm18XnuQx2NZaoVEzMb0OVama64HDgT6cufleP2gaJAM0zmxobpT3Haml4k7c3ESHJi45ImVd10slkmijXGmNYPF48QI/vbPhfRBt3k88zDZPfI+2bNJexFtTLAXfu+u2OJXnfoiI2TmIL3X3CE0bFm9WVOutHn4CPxuiT7tW/gadzT7+pWAKFPZ+40FL1530ylGRDkyXTYtkvd7P8nxVNPEBD9Aacr/kBmgAMzoYA3kYUogmjzzzTsvwXWtw53x+2Qi0SInzpREqRlPANhMJGWBUbALguvMFMFUHFOPQQUhfC1BwmVjENq2E/h73sk6pbJuKk8dpokLw9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyMKc5WbCgCs+mFtF0uX59cf/6yFRrueIwmckxC4pSI=;
 b=T6NlH4W6hIgdADPBoA8PShdTCYauyLn0B5AK0aPer6CCvAX6NTYcxvqzRPeoNFDgvqaQ1fsXVadXL0F7YzzqrymCxUyeDhYVygE8vYS34tWXoBJvvtIXa6AnMsI4lUrvogn446QdjZVLCdM+DraW/Nb6TEbZ5FBnumU/mRbsz2DOTuHoDir/aaEI35Av3FjS2uHFevbiIXlkVlpgy0gqTd11m7HjjLQjkDzNwbXnKlUPZ0fa8X4fWsSFySTxHjvJfk7e8sThELv7NmsjdVkWgF3MKCCK+jDowy5W9moK7jEAzXwFlxfcn5YrJutmCmt6bR4isRuDLsXxoGTGohRh0A==
Received: from CH0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:610:32::30)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 08:47:08 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::1) by CH0PR07CA0025.outlook.office365.com
 (2603:10b6:610:32::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 08:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 08:47:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 18 Aug
 2026 01:46:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Aug
 2026 01:46:49 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 18 Aug 2026 01:46:42 -0700
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
 Wang" <zhiw@nvidia.com>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>
Subject: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV support
Date: Tue, 18 Aug 2026 11:46:33 +0300
Message-ID: <20260818084633.1673214-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818084633.1673214-1-zhiw@nvidia.com>
References: <20260818084633.1673214-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc4dc6d-6ca1-441c-eb59-08defd054962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0QIca6L16JA6A5rf3EppuqNg9IpCEWzAUon1pqU82Sy5WrCODdgWQii+ojqMD1QdhbjiM/hnxNZdKp18OLGuRbTX+S5P/Xr5hZcEasbkKLAMaSXuIvWo9aeSpPmSZP6keeUGKie+AFhMBKixMF6A+ELPB0LLuVp7ciCmEaeKfEac0RK6rS9TUaobsEO+a6NX4fvQYCLD7KYEh+/ZUOMz932zEwhDNS7TCD3aUc4ev+jxrv8Y191DgLPDvMSTb7JM7k+Utddpb34lP5IzbLVArATHP3fd2346ljI2fJ+MkuJksmGcnzqCYO7TU1Za/0TnFN6b+87uBO9Qxda+1tL27ijfqQAT6KvBKJwiDBeyWvgXfiv1Ks3qtm/cJHy2GcSx4OCjCl54D9wQeyPcRAqHuF12RG+6rtmoayQPWwTi444aX9jhwBbssJ7GffKFPABBWzz8tjnaZ1GSsA8qP/IpGMK6DB2kQUHI0TzdhQezfro/0mjvJbh3Z7pq/a7/c+ZmDzeofAP60k6GCwZqc50WskYTsS/En8MmOTJuyPUBEUgXTEJLAxH++HHrn+/37UGjFS4ko0+YPHOLRwqTZDXuQJyad/pmLqtO9UBGd3IPs/Sk3MJzc0S0ZGmbjAezFWaPgWPMSpR0e6o9/YnTMdJAJTDdUGMYxpyR9b4cxWbKqnQQj3EuBAq3Swz4PJCXaZoqPCXWCBfjMs8EqD9DTLGN7g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8lVP2l+Sjuc+RbOlUjnf0X/5vUO9N+rq/lmF4XA4hi6Og+ATfOlPiW1NmGeBmLrLIhDuNRaVOylZGAYSCWSXJigr4UWBkSsCNpqgj817OYeKZIPNWYRdZZZsxGjdRFsTlg7ybBZqh8EcDTzNdL+fOOtCAI91jQgZEPeT+JTl6xa1drXne1+DhZ/IKMBSHYOutT99YNcGT4tfYnETW1TO8WdUoT6mCDkaGv5nR5SE8jSTMB/AmqlLnv2sGjlfhpsHWYyKmAM8IAo6PJ9Z3ZCxAeugv00J39Io1ACJ1mAJk6EFkEpQQue6jeaL7kC76dCx5lTzV+Og1/dOoNcXcdNeHWeogD3NATZ4LWnKqmoTaf2akQZVensqyUdSU1qKAibL2jY5V7Tnkw7IN08oB0fyl5KKKCKieaI2al04b8qdwuD7vltFLv6RyQfQpaXbEvqR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 08:47:07.9382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc4dc6d-6ca1-441c-eb59-08defd054962
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963

Rust PCI drivers have no typed interface for locating and accessing PCIe
extended capabilities.

The SR-IOV extended capability describes VF topology and VF BARs. Expose
this information through the Rust PCI abstraction so drivers can use the
existing typed configuration-space accessors instead of raw bindings.

Define ExtCapability to associate a capability ID with a register layout,
and add ConfigSpace::find_ext_capability() to locate and project that
layout. Bound the view at the next capability or the end of extended
configuration space. Add ExtSriovRegs and a decoded VF BAR iterator that
reads and validates all six VF BAR register slots up front, yields decoded
BAR addresses and widths in logical order, and keeps the raw
configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT() is
a function-like macro, expose it through a Rust helper.

Link: https://lore.kernel.org/rust-for-linux/20260804161612.776752-1-zhiw@nvidia.com/
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 +
 rust/kernel/pci/cap.rs | 329 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+)
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
index 000000000000..ddb3fd73e195
--- /dev/null
+++ b/rust/kernel/pci/cap.rs
@@ -0,0 +1,329 @@
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
+    num::Bounded,
+    prelude::*,
+};
+
+/// Number of VF BAR register slots in an SR-IOV capability.
+// CAST: `PCI_SRIOV_NUM_BARS` is the PCIe-specified number of VF BAR register slots and fits in
+// `usize`.
+const NUM_VF_BARS: usize = bindings::PCI_SRIOV_NUM_BARS as usize;
+
+/// PCI extended capability IDs.
+#[repr(transparent)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub struct ExtCapId(u16);
+
+impl ExtCapId {
+    /// Single Root I/O Virtualization.
+    // CAST: PCI extended capability IDs are 16-bit values defined by the PCIe specification.
+    pub const SRIOV: Self = Self(bindings::PCI_EXT_CAP_ID_SRIOV as u16);
+
+    /// Creates an extended capability ID from its raw PCIe value.
+    #[inline]
+    pub const fn new(id: u16) -> Self {
+        Self(id)
+    }
+
+    /// Returns the raw PCIe extended capability ID.
+    #[inline]
+    const fn as_raw(self) -> u16 {
+        self.0
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
+    /// Returns [`None`] if the device does not implement the capability.
+    ///
+    /// Returns an error if the capability is present but its register span is too small or
+    /// insufficiently aligned for `C`.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::{
+    ///     device::Bound,
+    ///     io::io_read,
+    ///     pci,
+    ///     prelude::*,
+    /// };
+    ///
+    /// fn probe_sriov(pdev: &pci::Device<Bound>) -> Result {
+    ///     let Some(sriov) = pdev
+    ///         .config_space_extended()?
+    ///         .find_ext_capability::<pci::ExtSriovRegs>()?
+    ///     else {
+    ///         return Ok(());
+    ///     };
+    ///
+    ///     let total_vfs = io_read!(sriov, .total_vfs);
+    ///     let vf_offset = io_read!(sriov, .vf_offset);
+    ///     let mut vf_bars = sriov.vf_bars()?;
+    ///     let bar0 = vf_bars.next().ok_or(EINVAL)?;
+    ///     let bar1 = vf_bars.next().ok_or(EINVAL)?;
+    ///     let bar2 = vf_bars.next().ok_or(EINVAL)?;
+    ///
+    ///     Ok(())
+    /// }
+    /// ```
+    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Option<ConfigSpace<'a, C>>> {
+        let offset = usize::from(
+            // SAFETY: `self.pdev` is valid by the type invariant of `ConfigSpace`.
+            unsafe {
+                bindings::pci_find_ext_capability(self.pdev.as_raw(), i32::from(C::ID.as_raw()))
+            },
+        );
+
+        if offset == 0 {
+            return Ok(None);
+        }
+
+        let size = self.calculate_ext_cap_size(offset)?;
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
+        capability.try_cast::<C>().map(Some)
+    }
+
+    /// Calculates the size of the extended capability at `offset`.
+    ///
+    /// The capability extends to the next extended capability, or to the end of the extended
+    /// configuration space if it is the last one. `offset` must be a DWORD-aligned offset within
+    /// the extended configuration space returned by `pci_find_ext_capability`. Returns an error if
+    /// the capability header is outside the extended configuration space.
+    fn calculate_ext_cap_size(&self, offset: usize) -> Result<usize> {
+        let header = self.try_read32(offset)?;
+        // SAFETY: Pure bit manipulation, no preconditions.
+        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), always fits in `usize`.
+        let next = unsafe { bindings::pci_ext_cap_next(header) } as usize;
+
+        Ok(if next > offset {
+            next - offset
+        } else {
+            self.size() - offset
+        })
+    }
+}
+
+/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offset).
+#[repr(C)]
+#[derive(FromBytes, IntoBytes)]
+pub struct ExtSriovRegs {
+    /// Extended capability header.
+    _header: u32,
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
+    const ID: ExtCapId = ExtCapId::SRIOV;
+}
+
+/// A typed view of an SR-IOV extended capability.
+pub type ExtSriovCapability<'a> = ConfigSpace<'a, ExtSriovRegs>;
+
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+enum VfBarMemoryType {
+    Bits32,
+    Bits64,
+}
+
+impl TryFrom<Bounded<u32, 2>> for VfBarMemoryType {
+    type Error = Error;
+
+    fn try_from(value: Bounded<u32, 2>) -> Result<Self> {
+        match value.get() {
+            0b00 => Ok(Self::Bits32),
+            0b10 => Ok(Self::Bits64),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<VfBarMemoryType> for Bounded<u32, 2> {
+    fn from(value: VfBarMemoryType) -> Self {
+        match value {
+            VfBarMemoryType::Bits32 => Self::new::<0b00>(),
+            VfBarMemoryType::Bits64 => Self::new::<0b10>(),
+        }
+    }
+}
+
+crate::bitfield! {
+    /// Low DWORD of an SR-IOV VF BAR.
+    struct VfBarLow(u32) {
+        /// Base address bits 31:4.
+        31:4 address;
+        /// Whether the address range is prefetchable.
+        3:3 prefetchable => bool;
+        /// Memory BAR type.
+        2:1 memory_type ?=> VfBarMemoryType;
+        /// Whether this is an I/O-space BAR.
+        0:0 io_space => bool;
+    }
+}
+
+/// A decoded VF BAR register encoding.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub struct ExtSriovVfBar {
+    /// The BAR address without PCI attribute bits.
+    pub address: u64,
+
+    /// Whether the BAR is 64-bit.
+    pub is_64bit: bool,
+}
+
+/// Iterator over decoded VF BAR register encodings.
+///
+/// A 32-bit memory BAR encoding uses one register. A 64-bit memory BAR encoding uses that register
+/// for bits 31:0 and the immediately following register for bits 63:32.
+///
+/// # Invariants
+///
+/// - `next_bar <= bar_count <= NUM_VF_BARS`.
+/// - Entries before `bar_count` contain decoded VF BARs in logical order.
+struct ExtSriovVfBars {
+    bars: [ExtSriovVfBar; NUM_VF_BARS],
+    bar_count: usize,
+    next_bar: usize,
+}
+
+impl ExtSriovVfBars {
+    fn new(slots: [u32; NUM_VF_BARS]) -> Result<Self> {
+        let mut bars = [ExtSriovVfBar {
+            address: 0,
+            is_64bit: false,
+        }; NUM_VF_BARS];
+        let mut bar_count = 0;
+        let mut config_slot = 0;
+
+        while config_slot < NUM_VF_BARS {
+            let low = VfBarLow::from(slots[config_slot]);
+
+            if low.io_space() {
+                return Err(EINVAL);
+            }
+
+            let is_64bit = low.memory_type()? == VfBarMemoryType::Bits64;
+            let low_address = u64::from(low.address()) << VfBarLow::ADDRESS_SHIFT;
+
+            let address = if is_64bit {
+                if config_slot + 1 >= NUM_VF_BARS {
+                    return Err(EINVAL);
+                }
+
+                let high = slots[config_slot + 1];
+                config_slot += 2;
+                (u64::from(high) << 32) | low_address
+            } else {
+                config_slot += 1;
+                low_address
+            };
+
+            bars[bar_count] = ExtSriovVfBar { address, is_64bit };
+            bar_count += 1;
+        }
+
+        Ok(Self {
+            bars,
+            bar_count,
+            next_bar: 0,
+        })
+    }
+}
+
+impl Iterator for ExtSriovVfBars {
+    type Item = ExtSriovVfBar;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next_bar >= self.bar_count {
+            return None;
+        }
+
+        let bar = self.bars[self.next_bar];
+        self.next_bar += 1;
+        Some(bar)
+    }
+}
+
+impl ExtSriovCapability<'_> {
+    /// Returns an iterator over decoded VF BAR register encodings.
+    ///
+    /// All six raw VF BAR register slots are read and decoded up front. A 32-bit encoding yields
+    /// one entry; a 64-bit encoding combines two slots into one entry.
+    ///
+    /// A zero-valued low DWORD is yielded as a 32-bit BAR at address zero; this method does not
+    /// probe whether a BAR is implemented.
+    ///
+    /// Returns [`EINVAL`] and logs an error if a BAR low DWORD does not encode a 32-bit or 64-bit
+    /// memory BAR, or if a 64-bit encoding has no upper DWORD.
+    pub fn vf_bars(&self) -> Result<impl Iterator<Item = ExtSriovVfBar>> {
+        let slots: [u32; NUM_VF_BARS] =
+            core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[panic: slot]));
+
+        ExtSriovVfBars::new(slots).inspect_err(|_| {
+            dev_err!(self.pdev, "invalid VF BAR encoding in SR-IOV capability\n");
+        })
+    }
+}
-- 
2.53.0

