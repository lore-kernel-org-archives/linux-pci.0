Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0484B487D;
	Thu, 24 Sep 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276877; cv=fail; b=Td7p5aY+D/swf3kug3XAwFsO+EeOahI3q2REOKxxKnlpxWign6Xe5ryF0u5Z3dseexueEmur7LsaLgkw8zma2kf8mTcHRgZjEtbD4KeGLrE0Sa03n1lSw38SQAu6FuecpE/umbLDIGZftqrhX1u2bmJNQScoiIKBSzPOuOyN/wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276877; c=relaxed/simple;
	bh=iyNvbW89tvWNs4m3UxJ3EMLsZ2Wt0PkyjzOIw8iSHpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O485Jw3ev8iUSoGZFMs3PRbh2X3+3THH0iRe9m64ZpzyU9kcjYLyTZ8GT23Ad77rHDUG0/2UmUebw2T+s7w9+f6D3eQXzZEZCdwIGOWVGm49rUMLJN1qqkOqg8lbMr03gByKlUisx1jIGGZVcagGQHiLpyw0uRaAeTs8PmScMf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oOEbfTP+; arc=fail smtp.client-ip=40.107.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oOEbfTP+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmYxQ2P2DLoeINKWJlPZDKIVwiCekEBLMUbU3bKdBceVlA1xSTPJcVHYNOxO6ULUTieela51QTsVKuyIzmGZ/rdjQ67K9AxsXkMpcYUL6hZgJbGHhgkxgIOIrx/fTHM9gqLk81G4eI/Nw7XpoOs/8B169WtS+2CBZ+YfnnSmmelQniI0aJLQXRI6EHjWv0GbdJ5mU89F71MP//bt5ACIY2k8vUCgBFJHJC6Z89ZTJ1UM/L2FrHGlzbINMvAhFiKmQJt0/ymbLlu/02OfhZdK/dtBMyiR/MEB8sL6hKQpW2jM37TyoAh1uWHc1c0WwKFPUHNPvMmurUl+/YVg621J0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5LKA1KDw2zuiiTgzTZYZztwAheOENhlkciplxAfIDk=;
 b=gKW5SmQ6GoyPG3jcof4o2ih3LdWu7uEHf4FjMmZbRbVQw4Q09LZkEsknjei42+27q09MMwe4TCn0oYQ3tnNHLaTyCB9fBTm7MK0f5l+fvgAoCelsrbf81WleBN1uh6yO+/8mnpkAMNjtTNbCIWrVmy6uUuPNILhqtgaDe1eJlkLztm1NCRyhHF38J9IIcTxjN6KWuT3gaxFiGiYsm+xCShSmpELQxOFtBIKhijpKSV10aLdb2ZAMhGqFIQ54P1zd9JJ3qnQ03fguXoeSJaZs5QocmKW7kfiL/AfCZ8QeyxT5uW3SU5UZ3KqRGxR+2JanQZJRNGMokJcO5HawS3ApBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5LKA1KDw2zuiiTgzTZYZztwAheOENhlkciplxAfIDk=;
 b=oOEbfTP+Vs0lTW491MZrCSixDsNifkKusqoy/v6te/Jeq9LqknY7PGKBQJvzWpKl9c2NATG5GcNj9k+tCHoK2LeoInzQD81ItttAyZOa/Q0/mndp+UNyZfnnDLz28UU9kJH6n+AjjYy7P9JCjdj/JvWA0zwwTfw6Tur1cgVG9xa2KSd0wp7AhSKJm0pOXnZgDNyh/Zh33xbnh+16L+aFSAL2zqRcYkqgoQvcYsiraoTJDVsnUDUZS5H+GOqtV0Z4cK7prA+0zB2/QPzw78ekJkGWsjMGomH53XXP/NEmftWHwQIkfabr+z5oF0qVh9YAzokHKIxvNb+7U7AAsssBEA==
Received: from CH2PR19CA0005.namprd19.prod.outlook.com (2603:10b6:610:4d::15)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:07:44 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::8c) by CH2PR19CA0005.outlook.office365.com
 (2603:10b6:610:4d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 19:07:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:07:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:07:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:07:20 -0700
Received: from inno-dell.home (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Thu, 24
 Sep 2026 12:07:12 -0700
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
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <jgg@nvidia.com>,
	<alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v2 7/8] rust: pci: add typed SR-IOV PF registration data
Date: Thu, 24 Sep 2026 22:05:54 +0300
Message-ID: <20260924190556.1620886-8-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924190556.1620886-1-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9a7c1e-fcc0-4a19-655e-08df1a6f1d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|23010399003|10067099003|56012099006|5023799004|11063799006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I8ZvptI9VvS7Ssc3E5wcrVEZTGGlnCa/rLbh2TzOyh2s0PEBT6Pm07buIyE8bRMG4s07nWqxHvbFX8JnlHN2vJlTiuML1vhK5jEZ+4Nnk4d4apefMF8ow+4AT8NjtFajcLJNVH0U5D5LANT+UneHALjZCJYlmjN9Tp/pNl5YuQXxEhkKFar3VnZx8nTSE5Pe01CZcv9TzbngrAEBuL4SEJdXKYrx2o1DlHs/TFSyDY2K/AHEQuw4N1wLWkpBMkSeYHRGeOh1zwKDVe0wnCJFCoS5pKIHyGD2/6J1YvSQ6OqvHorxsV8sMauaNjI5g2f8CzF2/A14jQK3OJsOQmwJ8k15CVjGf6nS6S0AA4RVqdAfi83vDdPmU6JHnJMjUhAwpSxPNJGQHC5GCWUWv/NTXyAW3WlZL3RdcFZ8eUhvRfGNvKtoci8UhzWm/JiIzGLf7d2YWZ/9d+DKQhZm5eKiT/hBKMXFj96kbRCdep/+U+WyHGJm/ib+7P+y/8/pVIlpzWWKKC5fzhwgaH1zWSH4Yn5H7f1K3zPsO1y7kNh1+SF24yCJ+yyAdQvYj8DbIuELno9FE/66aQW8G8Ow9U+gYkz9WjapiY+lf/JpLdH8Jmg4Gta9vCffvW91e6trdZoA2KHwWQGGk85EtSIdyPjSfU73JabGtTh8gKlnR1Y6iVT1EdBO+Okb22XUFKFxy6ZwiQ2ZbYdKsXLHfDLnKzCNtw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AgLYnWA/vmtePdx+6CLOaz+lBbkKXzYQmbd6ce1Vw84vj+kCgPCFmD6X8xYdIZfbHPgcaKuhffcfS7ZOLPD4G8J4tkXHsgjqjh2N2hLapZzJTpQDC4mVW8bk/kFCN9DNOTLl28Olx0hNtDqh2wUfqbTU4/PxMp69amjHTgT922J17FUiI+IBd+XIBVePJm4YovcfcW1IM0zeikkI1rp0gO+2M2zZTP9VQ+kZM7QZfbP5ryuFV3e3XJLfs12/B9jHOXKIegtIib+DYT69HTFGtwN2UmOvKdVjpbhE07IfLU1JkspJaNl42ziEm/qwX/90CqyvBIiopTrMPwEJ6tM9oyxBr6KVM4BwxRbG0yapQFpYOumrEx05i7yNIClx95/Q4ZffVh8UMAMdBFS9UiV8XiNjSkz73fKJNov+C8lYmYC9xvUDE0UlPEsqkwyNhcG+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:07:43.9569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9a7c1e-fcc0-4a19-655e-08df1a6f1d13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197

Rust PF and VF drivers bind to separate PCI devices and may reside
in different modules. A VF driver that calls PF operations needs
typed access to the data exposed by the PF driver. This data must
remain valid until VF driver removal completes.

Add `VfRegistration` to register a pinned Rust object in the PF's
driver data. Add accessors for VF drivers to borrow this object after
checking the requested Rust type. During registration teardown,
disable SR-IOV and wait for VF remove callbacks to finish before
dropping the object.

Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 include/linux/pci.h      |   7 ++
 rust/kernel/pci.rs       |  38 ++++--
 rust/kernel/pci/sriov.rs | 253 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+), 8 deletions(-)
 create mode 100644 rust/kernel/pci/sriov.rs

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..9b6ae544469e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -551,6 +551,13 @@ struct pci_dev {
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
 #endif
+#if defined(CONFIG_PCI_IOV) && defined(CONFIG_RUST)
+	/*
+	 * Private data owned by the PF's Rust driver, readable by VF drivers
+	 * through the PCI VF registration data Rust abstraction.
+	 */
+	void		*vf_registration_data_rust;
+#endif
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index cb3ed2207075..831b76744a30 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -35,6 +35,8 @@
 mod id;
 mod io;
 mod irq;
+#[cfg(CONFIG_PCI_IOV)]
+pub mod sriov;
 
 pub use self::id::{
     Class,
@@ -55,6 +57,8 @@
     IrqVector,
     IrqVectorRegistration, //
 };
+#[cfg(CONFIG_PCI_IOV)]
+pub use self::sriov::VfRegistration;
 
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
@@ -166,7 +170,16 @@ extern "C" fn sriov_configure_callback(
         // INVARIANT: `pdev` is valid for the duration of `sriov_configure_callback()`.
         let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
 
-        from_result(|| T::sriov_configure(pdev, nr_virtfn))
+        // SAFETY: `sriov_configure` is called only after a successful probe and before unbind, so
+        // the stored pointer has type `T::Data<'_>` and remains valid throughout this callback.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+
+        from_result(|| {
+            if !pdev.is_physfn() {
+                return Err(ENODEV);
+            }
+            T::sriov_configure(pdev, data, nr_virtfn)
+        })
     }
 }
 
@@ -377,8 +390,13 @@ fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'
     ///
     /// ```
     /// # use kernel::{device::Core, pci, prelude::*};
+    /// # struct Data;
     /// #[cfg(CONFIG_PCI_IOV)]
-    /// fn sriov_configure(dev: &pci::Device<Core<'_>>, nr_virtfn: i32) -> Result<i32> {
+    /// fn sriov_configure(
+    ///     dev: &pci::Device<Core<'_>>,
+    ///     _this: Pin<&Data>,
+    ///     nr_virtfn: i32,
+    /// ) -> Result<i32> {
     ///     if nr_virtfn == 0 {
     ///         dev.disable_sriov();
     ///     } else {
@@ -388,8 +406,12 @@ fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'
     /// }
     /// ```
     #[cfg(CONFIG_PCI_IOV)]
-    fn sriov_configure(dev: &Device<device::Core<'_>>, nr_virtfn: i32) -> Result<i32> {
-        let _ = (dev, nr_virtfn);
+    fn sriov_configure<'bound>(
+        dev: &'bound Device<device::Core<'_>>,
+        this: Pin<&Self::Data<'bound>>,
+        nr_virtfn: i32,
+    ) -> Result<i32> {
+        let _ = (dev, this, nr_virtfn);
         build_error!(crate::error::VTABLE_DEFAULT_ERROR)
     }
 }
@@ -496,24 +518,24 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
     }
 
     /// Returns `true` if this device is a Physical Function (PF).
+    #[cfg(CONFIG_PCI_IOV)]
     #[inline]
-    #[expect(dead_code)]
     pub(crate) fn is_physfn(&self) -> bool {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         unsafe { (*self.as_raw()).is_physfn() != 0 }
     }
 
     /// Returns `true` if this device is a Virtual Function (VF).
+    #[cfg(CONFIG_PCI_IOV)]
     #[inline]
-    #[expect(dead_code)]
-    pub(crate) fn is_virtfn(&self) -> bool {
+    pub fn is_virtfn(&self) -> bool {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         unsafe { (*self.as_raw()).is_virtfn() != 0 }
     }
 
     /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
     #[cfg(CONFIG_PCI_IOV)]
-    pub(crate) fn num_vf(&self) -> i32 {
+    pub fn num_vf(&self) -> i32 {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         unsafe { bindings::pci_num_vf(self.as_raw()) }
     }
diff --git a/rust/kernel/pci/sriov.rs b/rust/kernel/pci/sriov.rs
new file mode 100644
index 000000000000..90abe878f67c
--- /dev/null
+++ b/rust/kernel/pci/sriov.rs
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for PCI Single Root I/O Virtualization (SR-IOV) drivers.
+
+use super::Device as PciDevice;
+use crate::{
+    bindings,
+    device, //
+    prelude::*,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    },
+};
+use core::{
+    any::TypeId,
+    marker::PhantomPinned, //
+};
+
+/// Wrapper for VF registration data stored inside a [`VfRegistration`].
+///
+/// Stores a [`TypeId`] header (derived from `F`) followed by the pinned data,
+/// so that [`PciDevice::vf_registration_data_with()`] can verify the type at
+/// runtime.
+#[repr(C)]
+#[pin_data]
+struct VfRegistrationData<'a, F: ForLt + 'static> {
+    type_id: TypeId,
+    #[pin]
+    data: F::Of<'a>,
+}
+
+static_assert!(
+    core::mem::offset_of!(VfRegistrationData<'static, CovariantForLt!(())>, type_id) == 0
+);
+
+impl<'a, F: ForLt + 'static> VfRegistrationData<'a, F> {
+    /// Pin-initializer for the registration data.
+    fn new<D>(data: D) -> impl PinInit<Self, Error> + use<'a, D, F>
+    where
+        D: PinInit<F::Of<'a>, Error> + 'a,
+    {
+        try_pin_init!(Self {
+            type_id: TypeId::of::<F>(),
+            data <- data,
+        })
+    }
+}
+
+/// SR-IOV VF registration on a PF device.
+///
+/// Owns the registration data that VF drivers access via
+/// [`PciDevice::vf_registration_data_with()`] and [`PciDevice::vf_registration_data()`].
+///
+/// The Rust PCI adapter removes all VFs before invoking the PF driver's unbind callback or
+/// dropping its data. Drop of a published registration calls `pci_disable_sriov()` before
+/// clearing the pointer and letting the data fields drop.
+#[pin_data(PinnedDrop)]
+pub struct VfRegistration<'a, F: ForLt + 'static> {
+    pdev: &'a PciDevice<device::Bound>,
+    #[pin]
+    inner: VfRegistrationData<'a, F>,
+    published: bool,
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+impl<'a, F: ForLt + 'static> VfRegistration<'a, F>
+where
+    for<'b> F::Of<'b>: Send + Sync,
+{
+    /// Create a new VF registration.
+    ///
+    /// Returns a pin-initializer so the registration can be embedded directly
+    /// in the PF driver's bus device private data.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the containing struct's field ordering drops
+    /// this `VfRegistration` before any resources that the registration data
+    /// borrows.
+    ///
+    /// The caller must invoke this during the PCI driver's probe and embed the result in the driver
+    /// data. On an SR-IOV PF, no VF may be enabled before probe successfully installs the complete
+    /// driver data.
+    pub unsafe fn new<'core, D>(
+        pdev: &'a PciDevice<device::Core<'core>>,
+        data: D,
+    ) -> impl PinInit<Self, Error> + use<'a, 'core, D, F>
+    where
+        D: PinInit<F::Of<'a>, Error> + 'a,
+    {
+        pin_init::pin_init_scope(move || {
+            if pdev.is_virtfn() {
+                return Err(ENODEV);
+            }
+
+            let published = pdev.is_physfn();
+            if published {
+                if pdev.num_vf() != 0 {
+                    return Err(EBUSY);
+                }
+
+                if !pdev.vf_registration_data_rust().is_null() {
+                    return Err(EBUSY);
+                }
+            }
+
+            Ok(try_pin_init!(Self {
+                pdev,
+                inner <- VfRegistrationData::new(data),
+                published,
+                _pin: PhantomPinned,
+                _: {
+                    if *published {
+                        // Store the pointer to the pinned `VfRegistrationData`
+                        // on the PCI device so VF drivers can find it.
+                        pdev.set_vf_registration_data_rust(
+                            core::ptr::from_ref(inner.as_ref().get_ref()).cast_mut().cast(),
+                        );
+                    }
+                },
+            }))
+        })
+    }
+}
+
+#[pinned_drop]
+impl<F: ForLt + 'static> PinnedDrop for VfRegistration<'_, F> {
+    fn drop(self: Pin<&mut Self>) {
+        if !self.published {
+            return;
+        }
+
+        // SAFETY: `pci_disable_sriov()` is safe to call on any `pci_dev`; it
+        // is a no-op if the device has no VFs enabled. When VFs are enabled,
+        // this blocks until all VF `remove()` callbacks complete.
+        unsafe { bindings::pci_disable_sriov(self.pdev.as_raw()) };
+
+        // After `pci_disable_sriov()` all VFs are gone, so no one can read
+        // the pointer anymore.
+        self.pdev
+            .set_vf_registration_data_rust(core::ptr::null_mut());
+
+        // The pinned `inner` field is dropped automatically after this returns.
+    }
+}
+
+// SAFETY: The inner data is `Send` (enforced by the bound), and `&PciDevice` is `Send + Sync`.
+unsafe impl<F: ForLt> Send for VfRegistration<'_, F> where for<'a> F::Of<'a>: Send {}
+
+// SAFETY: The inner data is `Send + Sync`. `VfRegistration` doesn't expose mutable access;
+// VF drivers only read the data through an immutable pinned reference.
+unsafe impl<F: ForLt> Sync for VfRegistration<'_, F> where for<'a> F::Of<'a>: Send + Sync {}
+
+impl<Ctx: device::DeviceContext> PciDevice<Ctx> {
+    /// Returns the raw `vf_registration_data_rust` pointer from this device.
+    fn vf_registration_data_rust(&self) -> *mut core::ffi::c_void {
+        // SAFETY: `self.as_raw()` is valid.
+        unsafe { (*self.as_raw()).vf_registration_data_rust }
+    }
+
+    /// Sets the `vf_registration_data_rust` pointer on this device.
+    fn set_vf_registration_data_rust(&self, ptr: *mut core::ffi::c_void) {
+        // SAFETY: `self.as_raw()` is valid. PCI probe publishes the data before enabling VFs;
+        // teardown removes all VFs before withdrawing it.
+        unsafe { (*self.as_raw()).vf_registration_data_rust = ptr };
+    }
+}
+
+impl PciDevice<device::Bound> {
+    /// Returns the PF for this VF, or [`ENODEV`] if this is not a VF.
+    fn physfn(&self) -> Result<&PciDevice> {
+        if !self.is_virtfn() {
+            return Err(ENODEV);
+        }
+
+        // SAFETY: `self.as_raw()` is valid and this VF uses the `physfn` union field.
+        let pf = unsafe { (*self.as_raw()).__bindgen_anon_1.physfn };
+        if pf.is_null() {
+            return Err(ENODEV);
+        }
+
+        // SAFETY: PCI holds a PF reference until VF removal completes. The returned borrow
+        // cannot outlive this bound VF, and `PciDevice` is a transparent wrapper of `pci_dev`.
+        Ok(unsafe { &*pf.cast() })
+    }
+
+    /// Internal helper: reads the `vf_registration_data_rust` pointer from the
+    /// PF, checks the `TypeId`, and returns a pinned reference.
+    ///
+    /// # Safety
+    ///
+    /// The returned borrow must be confined by a closure higher-ranked independently over its
+    /// borrow and data lifetimes, or `F` must be covariant in its encoded lifetime.
+    unsafe fn vf_registration_data_pinned<F: ForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        let pf = self.physfn()?;
+
+        let ptr = pf.vf_registration_data_rust();
+        if ptr.is_null() {
+            return Err(ENOENT);
+        }
+
+        // SAFETY: The Rust PCI adapter keeps the PF data installed until VF removal completes.
+        // `ptr` points to a `VfRegistrationData` whose first field is a `TypeId`.
+        let type_id = unsafe { ptr.cast::<TypeId>().read() };
+        if type_id != TypeId::of::<F>() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: TypeId check confirms the stored type matches `F`. The data
+        // is pinned inside the PF's driver data struct. Lifetime shortening
+        // from the PF's binding scope to `'_` is layout-compatible.
+        let data_ptr = unsafe {
+            let vfrd = ptr.cast::<VfRegistrationData<'_, F>>();
+            &raw const (*vfrd).data
+        };
+
+        // SAFETY: `data` is structurally pinned inside `VfRegistrationData`.
+        Ok(unsafe { Pin::new_unchecked(&*data_ptr) })
+    }
+
+    /// Access the VF registration data through a closure with an HRTB lifetime.
+    ///
+    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. Returns
+    /// [`ENODEV`] if this is not a VF, [`ENOENT`] if no data was registered,
+    /// or [`EINVAL`] if `F` does not match the type registered by the PF.
+    ///
+    /// The closure's borrow and the registration data's lifetime are independent, so a borrow of
+    /// the context cannot be stored in invariant registration data.
+    pub fn vf_registration_data_with<F: ForLt + 'static, R>(
+        &self,
+        f: impl for<'borrow, 'data> FnOnce(Pin<&'borrow F::Of<'data>>) -> R,
+    ) -> Result<R> {
+        // SAFETY: The higher-ranked closure prevents the borrow from escaping or being stored in
+        // invariant data by keeping its lifetime independent of the erased data lifetime.
+        let pinned = unsafe { self.vf_registration_data_pinned::<F>()? };
+        Ok(f(pinned))
+    }
+
+    /// Returns a pinned reference to the VF registration data.
+    ///
+    /// Available only when `F` implements [`CovariantForLt`](trait@crate::types::CovariantForLt),
+    /// guaranteeing that shortening the PF data lifetime is sound.
+    ///
+    /// For non-covariant types, use [`Self::vf_registration_data_with()`].
+    ///
+    /// It returns the same errors as [`Self::vf_registration_data_with()`].
+    pub fn vf_registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        // SAFETY: `CovariantForLt` permits shortening the encoded lifetime to this borrow.
+        unsafe { self.vf_registration_data_pinned::<F>() }
+    }
+}
-- 
2.53.0

