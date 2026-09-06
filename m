Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D036A37F;
	Sun,  6 Sep 2026 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788674679; cv=fail; b=Fic9Maae2eHJuYwqTx/IICHW7c5py2xEPicoUax3OjgKolxmGp9b5KXA5AkSv8KuAVX7E0slCsgk7uPI8SRlaoqcWy8V+EuPj/prrlzWDyE3ZfcnHY7enHbZmof89jRCFJ20jFL7uOuZcS5Z47rvD/nQC3TShD9E3WvjIlS/lPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788674679; c=relaxed/simple;
	bh=B6DGEFIHrxR5dGHLyF2ZSgAk8YIEaMAH6FxnqpRlC5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjgNvSvaziculd/4ApVPaddgv5KOyo3StJGtZpum1a9/9hgRoRdauVfXNRtgwht114vlMqJVgt/wSoZM1cKTYvp34/Y3kZPe/qyOmnmHhD1DEcBMez7W6CcZSH/brGJBKUylqd+0laYuD6eQuEZZEBKkTCccDOaPdTygKiqhA2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AI4x+ZOE; arc=fail smtp.client-ip=52.101.85.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AI4x+ZOE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLeykX+wAat+7mRXGcnDXKoejkC/bPDYmN8h06itZRYX+jX9n2DGmBRBk2ern6z5/j6zOK7LiStMrAI7rpa2I9Iw/iP7lf7G1elPuGvlf1fNrHhtEE9T5dI/Y7xXAH8jThjs6CiCCmB7elh/R/D7rIOAL8QO8YxYfGOA5c5IAlSGLDmpQbLDOeb86yOr8IbP8z+o7EEa7LK7V+hboY42j1E4MizzW1DqXSPLwW9+8VNSVjbYk333oQd7lTsGVjhRfZQshOIa3VGT9i5NGAykFJwlOcQmtq3G5giVtDq5vPhtQnQaAj6vYFWpW9bH2oNRMvyW58Je5ShbFn3gAaKH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZr/vguUMoIRI7BoPLw2ZUlJBMrcM+Kr5KDMGzxXGog=;
 b=PpTiAz2k4xR9tW+jr6OLFqVXgAEld+/R+aaJNOYzkhxEOn2dQrkjAHz0jHCqU2iRVSxQ0mKA+RUZc/wnKnJ37kyrdHtk/ycxYPMIoRjl9xNzvNOxTRUTYRSFzzpVVGCe5XD9eHLvMJ4T6ioaLAlyI714Zu9qP+mKcHY9E6bzBKlnBEFr3kNqgwHoC7UV0JfCKww1R0eKVgxYhjOQwCzNBvMRwI+7Eg3gouQMLrAhEZ6gGh+TGDJUZdaAKwWhHB2lnQ2uJ/y9py0sDwTOp9FBT/J1+bsTMik4oK8neotLke3SukiaFF/mQS6+cNsxvAFKrt9jYMm4WSOCWNyg0rlQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZr/vguUMoIRI7BoPLw2ZUlJBMrcM+Kr5KDMGzxXGog=;
 b=AI4x+ZOEmzZaN/YEUCSOzGmyBOUwi48qf81ZYlstxMI/NsfEswgWKZpV2Pf+8y19JtaWwmNkWbTYTjY+Awjbd7wNY/ABUR7Jc2Xvr/ZB94AR0kJHoFMMNpAqS6w1ZpJwXMT1UPf5aO9mpCe5YdayFGPCQU1Z5Ct6i9ZyizrVkk6CPxu2I8nRhq3qc8uN1mWyleTVN5/da/Ub66G11skTPsGRuAn6FrCe0+8ayrO4e8a1izAOwI9nBKxoNj1JzX2BdOtHBGJ7KRCOw+4Xn3IdG0UIxrXQ81ogmIOASuLP3DpT9lOEGlJAa2y1NS+Qoj0PNjnk5ONENu0RiNLSK8Sgyg==
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sun, 6 Sep
 2026 06:04:30 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::60) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Sun, 6
 Sep 2026 06:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sun, 6 Sep 2026 06:04:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 23:04:21 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 23:04:21 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sat, 5 Sep 2026 23:04:14 -0700
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
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v10 1/1] rust: pci: add extended capability and SR-IOV support
Date: Sun, 6 Sep 2026 09:04:04 +0300
Message-ID: <20260906060404.3336193-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906060404.3336193-1-zhiw@nvidia.com>
References: <20260906060404.3336193-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e6ce9d-e272-4b70-5f65-08df0bdcb726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|10067099003|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LwNJae20M56R8YuWQ8eflmGI47Yp3ootMp8vMrLLCLSjwhjU7j5EcfpVvtIsyv9DaktCdl1+vFGi0D31ZEFxtuYK19im2edeLj6jz/sZC2POIUw11hMTM0abk5qAR/UgDssCav2shRILfPbhb0vOMfWABtL/gRC6cgogIUkdq8S6kSzkRzKDEhiKBMXgHfJRiX0RtuMuWO7EIdWOjjzWUilUqjDqiAv2StlRP9VLSg1BOzHNIs3R0SMYTYWLLpHd3us3hr9dylk3KZLF39v5sjtPfGrAQDhoMqvCRYW6oLEyzE0yBZmnQipuuRdZZt0SYKHzgDZiiN/rbwnmPusXxK2G360wo13d3aEVhHztWa7pMp4AqGDNP3qzC85z97o4gYIxoCkZXnvw2Oo9HO2mHEVIQBKsDI+AbbUCEN6cw/rYD2qlbIqQOf6wgfaNyjUa+crvLqIwyFFzM7C+5JKWrcayj+GKM6Rl+UNW3OiYc6YQoVsVjMPnnGG7uOhEtbC/B8BFjXlugfOzT8GIlbbTjxVtHO3Y+DLzHWCnkYK304Udsoiha8hxDex3mwMphlZkrtCWMvKCb0JRTcuDsj+a3MyJzP/5TYDis5LeTtpqLIY38SJSgCAM00BIs0GwzxN/hM0pa74mdhZZ8+xt4ywlntAOjxAOW2D/nKsdyLrM7+E1Ouee0DV0m3P+8Y7MUgXsPK9MccgvKl67D6gbkpyv6g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YN0c7GtfJXFeFXt+CZgTfJp8DsJuW53KNqsfHLXoECO8oVaccV4I1njV/g5zOdr0t/HRy+zZ7SchCcs7lB3Pzb3cr26h7NS2PuYdcScBPGRHJHbkUniqZvBAUTIkKjsKt+9bOmeBpl9Jbzh/lcwgwM7znjYFUeQskUtidaVFcext47RHgyNc+17dgMir+shjqrZ4cZW3tI6qQGENfadWmQm2RGlH7ufKA9J3orSEc48IAQr6joeicN05aZEMe872Bt3bi+NsKNLeGh8V6W+XR4w9fTDCobdHdw/fZ5FRPkzQUdJxOjVY4Qp1Ss8UK14k6K7mqgIX1y+8qjP5Aw9ZPK1Pn0UT8aJPifuIhvXCykca/tO7aJkWu6jISZPSEFvoRty1I2ePw4r2TQe0ETQySEBnvDFBs+ekynUcbXCcjvEtPN6wE3kFDKqKNN9X0kqT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 06:04:30.2308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e6ce9d-e272-4b70-5f65-08df0bdcb726
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444

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

Keep raw SR-IOV registers private because PCI core owns their state. Expose
the current First VF Offset through a read-only accessor because the Nova
GSP ABI needs the raw 16-bit First VF Offset in Routing ID space. The
pci_iov_virtfn_devfn() helper instead returns the low eight bits of a
calculated VF Routing ID.

Link: https://lore.kernel.org/rust-for-linux/2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com/
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 ++
 rust/kernel/pci/cap.rs | 292 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index a714cc2bfb7a..502f56e02fcc 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -29,6 +29,11 @@ __rust_helper unsigned int rust_helper_pci_irq_type(struct pci_dev *pdev)
 	return pci_irq_type(pdev);
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
index 3ec897709e89..77c52fe59551 100644
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
index 000000000000..62f263ada1b3
--- /dev/null
+++ b/rust/kernel/pci/cap.rs
@@ -0,0 +1,292 @@
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
+    num::{casts, Bounded},
+    prelude::*,
+};
+
+/// Number of VF BAR register slots in an SR-IOV capability.
+const NUM_VF_BARS: usize = casts::u32_as_usize(bindings::PCI_SRIOV_NUM_BARS);
+
+/// PCI extended capability IDs.
+#[repr(transparent)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub struct ExtCapId(u16);
+
+impl ExtCapId {
+    /// Single Root I/O Virtualization.
+    pub const SRIOV: Self = Self(casts::u32_into_u16::<{ bindings::PCI_EXT_CAP_ID_SRIOV }>());
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
+    ///     let first_vf_offset = sriov.first_vf_offset();
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
+        let next = casts::u32_as_usize(unsafe { bindings::pci_ext_cap_next(header) });
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
+///
+/// The raw registers are private because PCI core owns SR-IOV state management. Drivers should use
+/// PCI core APIs for operations such as enabling VFs and querying their topology.
+#[repr(C)]
+#[derive(FromBytes, IntoBytes)]
+pub struct ExtSriovRegs {
+    /// Extended capability header.
+    _header: u32,
+    /// SR-IOV capabilities.
+    _cap: u32,
+    /// SR-IOV control.
+    _ctrl: u16,
+    /// SR-IOV status.
+    _status: u16,
+    /// Initial VFs.
+    _initial_vfs: u16,
+    /// Total VFs.
+    _total_vfs: u16,
+    /// Number of VFs.
+    _num_vfs: u16,
+    /// Function dependency link.
+    _func_dep_link: u8,
+    _reserved_0: u8,
+    /// First VF offset.
+    vf_offset: u16,
+    /// VF stride.
+    _vf_stride: u16,
+    _reserved_1: u16,
+    /// VF device ID.
+    _vf_device_id: u16,
+    /// Supported page sizes.
+    _supported_page_sizes: u32,
+    /// System page size.
+    _system_page_size: u32,
+    /// VF BARs (BAR0–BAR5).
+    vf_bar: [u32; NUM_VF_BARS],
+    /// VF migration state array offset.
+    _migration_state: u32,
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
+enum BarMemoryType {
+    Bits32,
+    Bits64,
+}
+
+impl TryFrom<Bounded<u32, 2>> for BarMemoryType {
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
+impl From<BarMemoryType> for Bounded<u32, 2> {
+    fn from(value: BarMemoryType) -> Self {
+        match value {
+            BarMemoryType::Bits32 => Self::new::<0b00>(),
+            BarMemoryType::Bits64 => Self::new::<0b10>(),
+        }
+    }
+}
+
+// TODO: Move the common BAR encoding definitions into the PCI core abstraction once it provides
+// BAR register decoding.
+crate::bitfield! {
+    /// Low DWORD of an SR-IOV VF BAR.
+    struct BarLow(u32) {
+        /// Base address bits 31:4.
+        31:4 address;
+        /// Whether the address range is prefetchable.
+        3:3 prefetchable => bool;
+        /// Memory BAR type.
+        2:1 memory_type ?=> BarMemoryType;
+        /// Whether this is an I/O-space BAR.
+        0:0 io_space => bool;
+    }
+}
+
+/// A decoded VF BAR register encoding.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub struct ExtSriovVfBar {
+    /// The PCI bus address encoded by the BAR, without PCI attribute bits.
+    ///
+    /// This is not necessarily the CPU resource address.
+    pub address: u64,
+
+    /// Whether the BAR is 64-bit.
+    pub is_64bit: bool,
+}
+
+impl ExtSriovCapability<'_> {
+    /// Returns the current PCIe First VF Offset in Routing ID space.
+    ///
+    /// This value may change when NumVFs changes. Drivers should use PCI core helpers when they
+    /// need to calculate a VF BDF; this accessor is intended for interfaces that require the First
+    /// VF Offset itself.
+    #[inline]
+    pub fn first_vf_offset(&self) -> u16 {
+        crate::io_read!(*self, .vf_offset)
+    }
+
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
+        let mut slots = slots.into_iter();
+        let mut bars = [None; NUM_VF_BARS];
+        let mut count = 0;
+
+        let mut decode = || {
+            while let Some(low) = slots.next().map(BarLow::from) {
+                // SR-IOV VF BARs describe memory-space apertures; an I/O-space encoding is not
+                // valid for these registers.
+                if low.io_space() {
+                    return Err(EINVAL);
+                }
+
+                let low_address = u64::from(low.address()) << BarLow::ADDRESS_SHIFT;
+                let bar = match low.memory_type()? {
+                    BarMemoryType::Bits64 => ExtSriovVfBar {
+                        address: (u64::from(slots.next().ok_or(EINVAL)?) << 32) | low_address,
+                        is_64bit: true,
+                    },
+                    BarMemoryType::Bits32 => ExtSriovVfBar {
+                        address: low_address,
+                        is_64bit: false,
+                    },
+                };
+
+                bars[count] = Some(bar);
+                count += 1;
+            }
+
+            Ok(())
+        };
+
+        decode().inspect_err(|_| {
+            dev_err!(self.pdev, "invalid VF BAR encoding in SR-IOV capability\n");
+        })?;
+        Ok(bars.into_iter().flatten())
+    }
+}
-- 
2.53.0

