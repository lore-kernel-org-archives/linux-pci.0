Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CE2F6184;
	Thu,  9 Apr 2026 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760815; cv=fail; b=i1nLpvm8ucDGeK3X5DV6VxLaQHHY+IyQkzu4JyEz848ohXs47VrtUAD8bp9M/tQUsCUs/AffYrP40t3mDGNgdu8gWkcr7xhaIzCoCpSoQ2K/jhfJQE0B/SZbmWBaTuBQcnxmYgDDVFbQ1Gl2MEjbzGPe5CjR5jF8684jbA/KVw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760815; c=relaxed/simple;
	bh=m9bvymGeZ/YmQirzz+TJtjFlkq8zjLPK10lqbA1YkXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeqqvtNXkTXqzyP+fx7LIs+rFJyIJ1IsDLVK9s5rEytKv5JOwByvKJu31QL4/w3wopuQc65Lafe0aNP2eZXpJkFIslbkhBVoPOzSUs+Nh/JQzPW7zoAyA+zcMrqSd2dOw3gz9ZC+PYEzvRze2/cnTFLmPFoHjcMxpa0WdMN1jRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hpGya+Uw; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hpGya+Uw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN6NlYN0TVJExF2MzM8EzENkjvXf9o7O/3cS8LAaSN1D1wNocOJTubD4PODfE+GCtf5fVAygVVcedRskhaxufRYLrFJpPLfUBYSatYmcMDfSrBK53Irmhg41761wmSsTkPEkYnaNPs5CSH3a23JkIULmHBdnPMNiCa6kQH5qHgietHSPsQSL61siiodFvCq77ZxZXdTouQYCueWNJMlV0HUbAdBVzAGFGYLOHNTw0Iz+IwYuOEzOenbYoYB3GBbbIMYNQIY9BY5rXsf/qmcyWH9nW6GWOpBxsIfU+GQMrBp49e8n5FKJmo10RaOO8Yg35jxa/X3Ke23q7viImm/tUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRAnjWbbYyB5fbyY/BLNK8QZUiDXrJ92IVIETenff4E=;
 b=FRwyp3a6G6e5ly2um7Up2emu0ZWlPz0guB6UWRhRHFg9g9xzXsBoCx3g24am0DlS1mat7U+ilR65xg29bOJmdmJElqGMU1EJYbGyGCLfwMfj+ufrg5hSGP+zWC5fBhm2I5Gh1V/v31bpaw9QMCdetEbopjBQWGpZqcTh42p0DtrFHgNowUDQi0mOIC9x280HcuU6W71Gc9qa26yjhKf6ZOLG3Q1kHUYTDGn+HJ4tdyz1sA8ChnuRM67Qm8lISFPL1ztVxA0T/y3ClTJQiggx8rr5AgH8HzleVzxCfIgewGuXGz4hImZbBHG7WGAmMJszV5gMyMFJfaQAgg3JVeOlKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRAnjWbbYyB5fbyY/BLNK8QZUiDXrJ92IVIETenff4E=;
 b=hpGya+UwQQJJ35Ye0w207Q+prYVzNekHicw3awRB+R8PpvUM0YWc9S3vbC/x8N95nQvzu7/uUZw3KTQjAABLHY2uhfPJWodXxz2iz3q8xAfawh5H0EM6vBxW1EbVMwDW0SZDY9u5CrlIXouKI7zrOdjJlHQKeJqQ2bZoJE0rsRdkeZV/o9BZ942qCErBfUWCZeK/jqLrrJ4DFd2lDkLd6Nltfo/XPotruOuQbH0hu3Q9uyeRye9ao2tLzUCMX5u+pfrqUAkk8pbP1qV7IjprC51QqgdShHDEXyr8hh7yqbpSWSGwFe4gnuKroEhQSHTXvEofQfbOb5BlD5Cq2H4baQ==
Received: from PH7P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::6)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 18:53:25 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::c) by PH7P221CA0020.outlook.office365.com
 (2603:10b6:510:32a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 18:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 18:53:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 11:53:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 11:53:06 -0700
Received: from inno-dell.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 11:53:01 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<kjaju@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v3 1/1] rust: pci: add extended capability and SR-IOV support
Date: Thu, 9 Apr 2026 21:52:54 +0300
Message-ID: <20260409185254.3869808-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260409185254.3869808-1-zhiw@nvidia.com>
References: <20260409185254.3869808-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 03252093-9cb0-4a32-aaa7-08de96694772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CehHGg0uhKnvqNFN9C55UnSIx1CAOIIABvXIV01qKYnq7mqeySRiBhvOGNmcLJmViz7EHTSnEFsHFlA2rkqD4gsTY7PHH1Z0j/t9ToSI4NeMK5M8hje13R5npa1WZWr63Tt6wDk8VFE1sF0il2dXKJdt8lbEyW233q4yfFBkeg4I6kOpp7jSSNXQOW4Id37RruQ6XUXo9/huZcUCybT6v+IYGVHKFIdnWn7KcFORnWfTi9BLou9yEjrMICR2soFqZuZRut8yR2by1pRuS1CslmwAhuTFyGyjeSrKX0ByCXkUxelp8/ZyiqBWt/SMWfaAPplbQDGoMcgapaR5eck3zCfoSsxvYQgzCslnWwlz9mi89i+bHl9d2qlYPWZxE8LVs0k1cA8QQwaP3g2FDSm7watcm2oeBiKTHF43MdrDyDHDWuMQmojYTE6w1XPLiTBwuKg0URRbnSbIFncO+fuK8keA6MkCsmbpL1wKN54C2W0VfXAk4X6wM5Nm6QdtHTRoV7c3utQAU/G76TaY3uopLAqCuA5MiQKB1yXGGJmQClhBUk5N6W1KsaR5XK204L5DJH4HvPV9SJh09upqlHn9tPv6Zz+FJkzzuxcC9iGMImcihrWmb5mJieYxa9wEa4zoZDkSM9MwH76hvU0V7NMFLC6aiiddzQO1heUsE2jjAxM3vyRZZp3t+plLcC3dpq6FqRKgxQ8mZdaO1xH6Ef8v0lfn6PKVytwZv57Gd9wI9VRHPhrMPD5+t0rsLasjph8G/Ye02l7fa610DqdJXBLLkw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9GNY1YQ7RbScTU+mGZfx67+Q7LcbmzJNbDtCrombaA9VVDx6fTK+feKOSuJ4YiJdjwle32F8XmWARBYJcBiTgZZ2cqntSD6miFbGQQ+f8Ta/FyiTYbF8z7A8lqxF1mym5/0GT2skfYOpsAY+57skiAhlNDVnTFSMPfz1U9xs5yf1HaXFPD6SiVMKK0hlMBzQqY2AyMu4iH9MncpVcBpqkqTpkZ+1BOTbd78thx3FYfP3Hxz6MiKL22ZD0xdjuWZRj2x0R5Jy1fzHQ60LcxAIW3pscvuwp4dun7tKiO6MqZzvT0/6eJrjZXoKhGxHSrE5c+zZQdmGscksJvLQ9LVIMu2H83Vhm1Cmkv4lxiWr0xTv8LI2lmQsRDG5j+YTi3NFLCSU6RMBPNE/+QtqOUes/O4VDBKYqTVPyVNm2ly3DiOpUUdf+g+qF9hJHuUcmTgr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:53:24.6335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03252093-9cb0-4a32-aaa7-08de96694772
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240

Introduce extended PCI capability support in rust PCI abstraction.

Implement ExtCapability<T> for PCI extended capability regions. It
delegates IoCapable to the underlying ConfigSpace, so io_project!/io_read!
/io_write! work directly on capability register structs.

Also add a rust helper for the PCI_EXT_CAP_NEXT() macro.

Link: https://lore.kernel.org/rust-for-linux/20260126215957.541180-1-zhiw@nvidia.com/
Cc: Gary Guo <gary@garyguo.net>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   7 ++
 rust/kernel/pci/cap.rs | 256 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
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
index af74ddff6114..962c6656dc96 100644
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
index 000000000000..1a25ef4cc633
--- /dev/null
+++ b/rust/kernel/pci/cap.rs
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI extended capability support.
+
+use super::{
+    ConfigSpace,
+    Extended, //
+};
+use crate::{
+    bindings,
+    io::{
+        Io,
+        IoCapable,
+        Region, //
+    },
+    prelude::*,
+    ptr::KnownSize, //
+};
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
+/// An extended PCI capability that implements [`Io`].
+///
+/// # Examples
+///
+/// ```no_run
+/// use kernel::pci::{
+///     self,
+///     ExtSriovCapability, //
+/// };
+/// use kernel::io::Io;
+///
+/// fn probe_sriov(pdev: &pci::Device<kernel::device::Core>) -> Result<(), kernel::error::Error> {
+///     let config = pdev.config_space_extended()?;
+///     let sriov = ExtSriovCapability::find(&config)?;
+///
+///     let total_vfs = kernel::io_read!(&sriov, .total_vfs);
+///     let vf_offset = kernel::io_read!(&sriov, .vf_offset);
+///     let bar0 = kernel::io_read!(&sriov, .vf_bar[0]);
+///     kernel::io_write!(&sriov, .num_vfs, 4u16);
+///     let bar0_64 = sriov.read_vf_bar64(0)?;
+///
+///     Ok(())
+/// }
+/// ```
+///
+/// # Invariants
+///
+/// `ptr` is within the device's extended configuration space at a valid
+/// capability. For sized `T`, the region is at least `size_of::<T>()` bytes.
+pub struct ExtCapability<'a, T: ?Sized + KnownSize = Region<0>> {
+    config: &'a ConfigSpace<'a, Extended>,
+    ptr: *mut T,
+}
+
+impl<T: ?Sized + KnownSize> Io for ExtCapability<'_, T> {
+    type Type = T;
+
+    #[inline]
+    fn as_ptr(&self) -> *mut T {
+        self.ptr
+    }
+}
+
+macro_rules! impl_ext_cap_io_capable {
+    ($ty:ty) => {
+        impl<T: ?Sized + KnownSize> IoCapable<$ty> for ExtCapability<'_, T> {
+            #[inline]
+            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
+                // SAFETY: The caller guarantees `address` is within bounds of
+                // this capability, which is within the config space.
+                unsafe { self.config.io_read(address) }
+            }
+
+            #[inline]
+            unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
+                // SAFETY: The caller guarantees `address` is within bounds of
+                // this capability, which is within the config space.
+                unsafe { self.config.io_write(value, address) }
+            }
+        }
+    };
+}
+
+impl_ext_cap_io_capable!(u8);
+impl_ext_cap_io_capable!(u16);
+impl_ext_cap_io_capable!(u32);
+
+impl<'a> ExtCapability<'a> {
+    /// Base offset of this capability in configuration space.
+    #[inline]
+    pub fn offset(&self) -> usize {
+        self.ptr.addr()
+    }
+
+    /// Size of this capability region in bytes.
+    #[inline]
+    pub fn size(&self) -> usize {
+        KnownSize::size(self.ptr)
+    }
+
+    /// Cast to a typed capability, checking that the region is large enough.
+    pub fn cast_sized<U>(self) -> Result<ExtCapability<'a, U>> {
+        if self.size() < core::mem::size_of::<U>() {
+            return Err(EINVAL);
+        }
+
+        // INVARIANT: `self` already satisfies the invariant (ptr is within extended config
+        // space at a valid capability), and the size check above guarantees the region is at
+        // least `size_of::<U>()` bytes.
+        Ok(ExtCapability {
+            config: self.config,
+            ptr: core::ptr::without_provenance_mut(self.offset()),
+        })
+    }
+}
+
+impl ConfigSpace<'_, Extended> {
+    /// Finds an extended capability by ID, returning an untyped [`ExtCapability`].
+    pub fn find_ext_capability(&self, cap: ExtCapId) -> Result<ExtCapability<'_>> {
+        let offset = usize::from(
+            // SAFETY: `self.pdev` is valid by the type invariant of `ConfigSpace`.
+            unsafe {
+                bindings::pci_find_ext_capability(self.pdev.as_raw(), i32::from(cap.as_raw()))
+            },
+        );
+
+        if offset == 0 {
+            return Err(ENODEV);
+        }
+
+        Ok(self.make_ext_capability(offset))
+    }
+
+    /// Finds the next extended capability with `cap` after `start`.
+    pub fn find_next_ext_capability(&self, start: u16, cap: ExtCapId) -> Result<ExtCapability<'_>> {
+        let offset = usize::from(
+            // SAFETY: `self.pdev` is valid by the type invariant of `ConfigSpace`.
+            unsafe {
+                bindings::pci_find_next_ext_capability(
+                    self.pdev.as_raw(),
+                    start,
+                    i32::from(cap.as_raw()),
+                )
+            },
+        );
+
+        if offset == 0 {
+            return Err(ENODEV);
+        }
+
+        Ok(self.make_ext_capability(offset))
+    }
+
+    fn make_ext_capability(&self, offset: usize) -> ExtCapability<'_> {
+        let size = self.calculate_ext_cap_size(offset);
+
+        let ptr = core::ptr::slice_from_raw_parts_mut::<u8>(
+            core::ptr::without_provenance_mut(offset),
+            size,
+            // CAST: `Region<0>` is a DST like `[u8]`, so this pointer cast preserves metadata.
+        ) as *mut Region<0>;
+
+        // INVARIANT: `offset` was returned by `pci_find_ext_capability` /
+        // `pci_find_next_ext_capability`, which guarantees it points to a valid capability
+        // within the extended configuration space. `size` is bounded by the next capability
+        // offset or the end of the configuration space.
+        ExtCapability { config: self, ptr }
+    }
+
+    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
+        let header = self.try_read32(offset).unwrap_or(0);
+        // SAFETY: Pure bit manipulation, no preconditions.
+        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), always fits in `usize`.
+        let next_ptr = unsafe { bindings::pci_ext_cap_next(header) } as usize;
+
+        if next_ptr > offset {
+            next_ptr - offset
+        } else {
+            KnownSize::size(self.as_ptr()) - offset
+        }
+    }
+}
+
+/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offset).
+#[repr(C)]
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
+    pub vf_bar: [u32; 6],
+    /// VF migration state array offset.
+    pub migration_state: u32,
+}
+
+/// SR-IOV capability. See [`ExtCapability`] for usage.
+pub type ExtSriovCapability<'a> = ExtCapability<'a, ExtSriovRegs>;
+
+impl ExtCapability<'_, ExtSriovRegs> {
+    /// Find the SR-IOV capability, or `ENODEV` if not present.
+    #[inline]
+    pub fn find<'a>(
+        config: &'a ConfigSpace<'_, Extended>,
+    ) -> Result<ExtCapability<'a, ExtSriovRegs>> {
+        config.find_ext_capability(ExtCapId::Sriov)?.cast_sized()
+    }
+
+    /// Reads a 64-bit VF BAR from two consecutive 32-bit slots.
+    #[inline]
+    pub fn read_vf_bar64(&self, bar_index: usize) -> Result<u64> {
+        if bar_index >= 5 {
+            return Err(EINVAL);
+        }
+        let low = crate::io_read!(self, .vf_bar[bar_index]?);
+        let high = crate::io_read!(self, .vf_bar[bar_index + 1]?);
+        Ok((u64::from(high) << 32) | u64::from(low))
+    }
+}
-- 
2.51.0

