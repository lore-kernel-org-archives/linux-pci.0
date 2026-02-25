Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E7C2EA168;
	Wed, 25 Feb 2026 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042751; cv=fail; b=gSvzvnm/cGMeMCMatx2/TJAv9rrLDPuiEJax1nTOe6x5ii4ZaqWYGNA08QXxW0Cpx0mon0b5AfaqOCRHe30pAm8wbb1bVwW/ucs2TUo/GNzws93Z95FBMxp5SmH0D4nwjxkjUt2kfokGOw6EQ77Fmr7ETJsk9OYCLsZgtxWU2s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042751; c=relaxed/simple;
	bh=SHHXezGpSPG6NaU/5UKUCWwf4AzIB5X1BW97RzaCHc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0OTratAX+lbzTXmFP314hrDgFU59yEVo3MosLPIiyznzdufIVuLOnqC1SH5hdeDB294iusrBbg9PduCzt8R2afmKw6qznZN+0a77FaM5vURJIfq3pIuIgAHffCTek2cuX3wBK1cQ1Fd0Li5V07Hg7JTGprEiq6Zg59KfIP3DOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gp0oZQoe; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gp0oZQoe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3P4Yv/IzlYVyGZ8NMFytEv/unBtZ26piB1oNtNpFcqcnz2y+CpUQmZ88dM259/+xokGvpfeR/yUZus5CGhVoXbB8HqolomzPI7jg68khRIy5lRpyAZGsik4jX/vQwWcaFxjv8FN/VtO1mM7O/yHlqbu29IefFYZWahy9rOpXRgR2Ile//O82Ic2O5GiAMq8n7Zsnufh1v65wekOgE3XPC8D4CcZII6kOSyB/HNfRJ/BQAFmbmRNyoEmfYuAYWWp7TZGTD+XKD9ulnqNn8J71eSdEhsy1LhAG8J66C/KT6tmcmmD2RxymvX4+v85YJCwBDUb3VI51fAddgZi5TZZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+jqC8xc1nW03EHEOSvYeOW7W3EudF1XYGqb8VCoAWE=;
 b=g7kp4+b2mDOivR1rzmsLX64LtBExffxhDW4klv05mby9C05ESRMZBCyctIdDHG11ll/F4/qQ2TU/gYYLo7EuJSuEEyt2mCynJpkaHVFw3Jtn+w8NWcaNryXMLerWlty8Jr5Myzu4mD6/urHYVOhqftoD+dXdxRSQQZjkZ8uXplKUJvwmUURE1nvHYHbVId3tSeyREZsVCo9KL8sr0fHdsiFBBt41YPxCQ3fXoaITA4KuR/fNTTP4VzkEg7n4IkZF/a1Qer8oB2grx0BuHGtML8W2j2xb5Ns1L4Bn1k19INqyEs2xrCL7K6bk3k0LKqOQYisLP3hyGfHyAbOJ6r7v9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+jqC8xc1nW03EHEOSvYeOW7W3EudF1XYGqb8VCoAWE=;
 b=Gp0oZQoeYmOR+QMjDGouy2gJCYB2ec8FKQqNi0VwqQ1UQRAieG4FepR4c6hollwtS9yPb6EBdCKq502iIxKaOSBQNUHdxlos7+XCJubonM3glHcAyYDtHIIdds8QlB3uRC8yIyW3Stkl1sF4N8ThRTdKYhxg7jpZ3elieZY7TMcuUnB0k6/kltfngyEIcwvzLmocrQV2Kk9pIJv5yzc/9fdbS6TQAhTd3vVnUHfqWiDsZ/QLBviTuS9Dmnsty3H9hpVeOoJxeEjdk0ivFvMKjoGfIWUnFkPhb3AxlSK+Ny1num0WV7EIfNOPUmU7qbFZTSmvBPtDX4x5+iuHkNdXuw==
Received: from BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 18:05:44 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::93) by BLAPR03CA0129.outlook.office365.com
 (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 18:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 18:05:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 10:05:15 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 10:05:14 -0800
Received: from inno-dell.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 10:05:04 -0800
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
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <kjaju@nvidia.com>,
	<zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [RFC v2 1/1] rust: pci: add extended capability and SR-IOV support
Date: Wed, 25 Feb 2026 20:04:48 +0200
Message-ID: <20260225180449.1813833-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225180449.1813833-1-zhiw@nvidia.com>
References: <20260225180449.1813833-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: f58824a1-c18e-4411-8b89-08de74987dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	hv4EXY8uekXeqFzTpGTrzCYBWAa+/XTafn3r6JdCmABQtC0kFSX5FBUwZScuftz+sx8Rb9RLtr6ddi3yUUDJEWEHo8dE6vBJNIVT8l9W9yAaRH5Oh7RL/w1kSOfEZoR/556rBFhBAXVCmbASG+UvusYgwMcGQ7zNQ004nvHM0wqfDA7wP+gSWw91uJGYIHN5oVFJIp95zz/JpJu9XfILmksLJW4Ey6HmAhL56P1/k04ewJUOes0DwSy2lftVMuPgkvAxp2uj3gjPCrCHz0oeEoCFo/1J1GQ4FODs7eZ7mDCB3O+EyJvEhpwJqWEbaXhGwd3DdwCrLMJD262h+a54c4VkIulQ0kWR9TVvk1kri9VesGDTecE5cB6pmkGbEg/NgSgsshFsRqdJ07vJ3NWi4fKw/FKX5WXSI9GPjhlDOuG1A00JC4wdHBGMknv8nCvdFd2QGRfn/d1JArNfsoakzye++Ci1BROyjagTKXc4r0oMbjLDNDpd3LdXJLuL/2yHPTYD6BXTugVvoA5QkjXTWeCwd5EFW14IQQqCs0buncU5AtEWM32f2mhv5m8E6t1hIvxXzrt+lu9+rPNT6W9BzW8NB++fvExUiGGST4HPJ/G5COcU97qNLjkNMD5im1DqIT6HKyWsQlnf0GBmCxhiyTAiZW3lGeiyqyTbHtNu7T2KB0EwxkVcrYDyIJtU9zbjd4LiBhupHIvRnKRCexXGtKH5MRJNl0699ImL5U/TVnhGP/rQoLuRBwd2lynmxQIXJ3geMfCYNKi6RlW77WyIJyPJJEerC46BNppPyustCnmbssXK/Voutn9W3AdSCjrFyt+wxK4ZO47zTgojoKb3CQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9ys9lpnPtETkigU32XJvEyRcuBWDbuRwK581RrYkcZxNJgdj6pDb78uBJ51g+saLHWnxR3UwLfHMfjm+/xRhTAM8movUz+lau+jWfPqwMYNrZNc/4MTV+r8hAhai1OkpG1aIhFntnF3sCDKTkYkLv/vLWvVnV6C/HiOKK2FJdJjpHvkC6nnCHI5ptd5dNazUbzro+zHZJdQn4Nynzny42eqIntGdCEcqKuzhs9cznKtuhc/2McLFMLuzh7k7a0bzIc3+62tTCrkVsIpFA9X7m/+p7VzOwXl7aeB09ZLjlyN/eGwGpjzD0Kgy6UCv7hd68OCFOK1l1zL+vJ3fqL75PfZWKPVgA1Iq80qdZAvtx8jy7MoubBuIXhWMwtInEC2i9ztWIN45W3TZR01uvYILf66JBvIDn29IwhOQ8Xp8tdsU9B6LdtKnqKQzU7KTy7Ad
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 18:05:42.3462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58824a1-c18e-4411-8b89-08de74987dab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

Implement ExtCapability<T> as an Io implementor for PCI extended
capability regions. It delegates IoCapable to the underlying
ConfigSpace, so io_project!/io_read!/io_write! work directly on
capability register structs.

ExtCapId wraps PCI_EXT_CAP_ID_* constants for type-safe capability
discovery. ExtSriovRegs is a #[repr(C)] layout of the PCIe SR-IOV
registers, and ExtSriovCapability is a convenience alias for
ExtCapability<ExtSriovRegs>.

Also add a rust helper for the PCI_EXT_CAP_NEXT() macro.

Link: https://lore.kernel.org/rust-for-linux/20260126215957.541180-1-zhiw@nvidia.com/
Cc: Gary Guo <gary@garyguo.net>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   7 ++
 rust/kernel/pci/cap.rs | 244 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
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
index af74ddff6114..fc9c8e2077b2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -31,6 +31,7 @@
     },
 };
 
+mod cap;
 mod id;
 mod io;
 mod irq;
@@ -53,6 +54,12 @@
     IrqTypes,
     IrqVector, //
 };
+pub use self::cap::{
+    ExtCapId,
+    ExtCapability,
+    ExtSriovCapability,
+    ExtSriovRegs, //
+};
 
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
new file mode 100644
index 000000000000..d14bb7809781
--- /dev/null
+++ b/rust/kernel/pci/cap.rs
@@ -0,0 +1,244 @@
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
+        KnownSize,
+        Region, //
+    },
+    prelude::*, //
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
+            unsafe { bindings::pci_find_ext_capability(self.pdev.as_raw(), i32::from(cap.as_raw())) },
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
+                bindings::pci_find_next_ext_capability(self.pdev.as_raw(), start, i32::from(cap.as_raw()))
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
+        // CAST: `Region<0>` is a DST like `[u8]`, so this pointer cast preserves metadata.
+        ) as *mut Region<0>;
+
+        ExtCapability {
+            config: self,
+            ptr,
+        }
+    }
+
+    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
+        let header = self.try_read32(offset).unwrap_or(0);
+        // SAFETY: Pure bit manipulation, no preconditions.
+        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), always fits in `usize`.
+        let next_ptr = unsafe { bindings::pci_ext_cap_next(header) } as usize;
+
+        if next_ptr == 0 {
+            KnownSize::size(self.as_ptr()) - offset
+        } else {
+            next_ptr - offset
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
+    pub fn find<'a>(config: &'a ConfigSpace<'_, Extended>) -> Result<ExtCapability<'a, ExtSriovRegs>> {
+        config
+            .find_ext_capability(ExtCapId::Sriov)?
+            .cast_sized()
+    }
+
+    /// Reads a 64-bit VF BAR from two consecutive 32-bit slots.
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

