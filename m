Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0864BE454;
	Wed, 30 Sep 2026 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765988; cv=fail; b=JL3IvxAhgRLLm/b9Tm5twnxoH0Y70qFU8pM+NZXwH8xx4jl4L3lZXe41DjsTom8eug1piPDkb4YVLCk7RwyxlA81Cs6lAuZE2qTJmcw4sJxkQbYpEHp/0cEkeF0G92wVj8FN6F8+I9ozzbwHiPSq4czX5fpObVYTHylRZhXldX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765988; c=relaxed/simple;
	bh=BwTXxcBZ9ZMsGDnKmilG7k7vi5BpJihtPv57vkfGo7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcTmTrcaCmwAYisOncbF8Vg9bsNuv7WeZqX3PSzA88EAUUiHPiYkxWIh3bvjqQOY1PuL4C4AujP7pgBYULwOZ9ZTtjMa9w28zThcOKfyrqv6agDpgHG4kP33vWlpmQUaw6B+PP3LDFFqQAApdMoOO7oSfU2gcY+Om2pK1769ykc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JXHBNN9+; arc=fail smtp.client-ip=52.101.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JXHBNN9+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yL7cVvsv8qErmJrGTg89PnlaeWr5PLbxXZ8mpcNUE+vwM45o3IQWY47c7m3NrFiR4CzwlNq3fZvon6ewKcug+lvE3VDgxWk7kuNIQ7EGJ2q/n0sQmLXUX4OWUMz+fY3a4bqq81C1t+93dV8WsJTnsOJ7RbE/iGv1g1KuShpyclbaz5+6n+/4sDFQE4xxHYS0u3uqgsEM2G6/3NR5bOJvhHbj8FlzUo6TEZDVcgV7cThvMOzNsWRjHRQexfOPABdFDVV8Zw6DvIDLgrHrnNYizu3PuMT2WqmXLe6IoqsxTN4hf4F3ako3wgSNn0ozt1ePdVtNE6WiAjaJb+hCKenP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2zz21qEODtNkPIBuRUpH9hGxE4nIBDkbTTatptjAvQ=;
 b=eyi8s+ne2PLEwHk0a/FhvniMUDkI0JwKKXVhtgrHvp9kTR3Wg36tO9uctmCnwdhHTCovSLEGqdcBPv1p8C9McCY6T2NIq+v/OrNwFv2vFLfpCU09hNe6NReXW3eiW55BFzxHlJzyi0Cy4b5kJjE27GtMJDOdtrFBeh2iRkOHgtUYR+RlQ8+jcePbbHzAwfPSjXLhsjJ/L5n+34P04rOUtqp6g6HF+rU3Zx8CpZGHXULSnA5MRWNdViKE/CLXIhF4o4zx4ijJsSDSxL5zpqcMdr7/Vw/ptRZ3VIWx55Wu7TacQjtkcevF3tB0Ech/eGBQQa8fxp/wsFnxK/QivgRGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2zz21qEODtNkPIBuRUpH9hGxE4nIBDkbTTatptjAvQ=;
 b=JXHBNN9+BxVG3ZWREeCBIamOoQuw4tzPhAaHxkgHhwOSbsIhGkDR4nX01hIT3I0KF9jY8cujlWJqLwYvm+driiHVvBP8ih43CDoBSeLn7qMA4UG8V3Nl0IquLK+WEPTVq4yUuvO1MPCv8+HW3idqC/tj3FnSQ4sogkmQeajIw7yylcIEv1iCWJYHL8nFMrSWQ6C3W5INz/nGavpPbsL+VjFN1pNELmqswT/2wfKY6In5gfmdg/70XJeeRYe8rJnwV41FIsvxbn2bsOHriyFffmT7Cx6znZioiYvC4/p83EEwSXDZLAb4qTQfOEn6Cafn0yQVbPFcOQRxmz+kXU9A1A==
Received: from CH0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:610:11a::24)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:59:20 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::89) by CH0PR03CA0350.outlook.office365.com
 (2603:10b6:610:11a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 10:59:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:59:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:57 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:58:46 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, Boqun Feng <boqun@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>, Jason Gunthorpe
	<jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	<dri-devel@lists.freedesktop.org>, Peter Colberg <peter@colberg.org>, "Simon
 Song" <xinmengs@nvidia.com>
Subject: [PATCH 5/7] rust: vfio: separate common device handling from PCI
Date: Wed, 30 Sep 2026 13:57:47 +0300
Message-ID: <551d6c8d67f7b331be3d893cff08993bb207369b.1790764573.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790764573.git.zhiw@nvidia.com>
References: <cover.1790764573.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 12619199-8c5d-43aa-e2b9-08df1ee1e0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|22082099003|18002099003|6133799003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	V1HiOcpSfSKN1+BwfyAR2sSa2D1NsvL2kuBz6EKUAKF61ugHuok8xaFiY2RTgmal7anBS8+mrKA7qZxq2zcTtntDmDGy7zRvFvpeYhRvPu1sxu285DPVvCmRSVT1lMsQ6FoA4iVFuFtByGmYklnReSYQxZq3XSC3k63b+WWhSCXw9g539ESjCqSWkrsnJPZN9mBtKoP66SkZfITxTAyJD/uAPOa1Zf7unMxRyvE2HkyEKh0DJWb4m6+LqaB+OKans7cdWCe9S57wUtsoTYa06kq7qMnv/32rNbLuy42UgfMSb/MxfuSmAtMiWxZS3WfyYancQuXFY7ESHk5lHaDqShaBE2ViU7wB+Hs28vioz2+TSqT2Z4Vo9ZJ1Qn4qKOMSQR6Xh8dl3MX57HXDyPvoSX/CZ+2Eo85RrlBkQWD+un22dABZm5UJAJQGS3+JcpivsUxTOzyxo3itn/Wgks0/iHkNlMCwFS54jGIxhGc1u3Ay6jM//VeyQxqtCI3eZDOkwjFYsGywXAvr/2bal2jsQeIzZ6Rl4M/ifqgVVicCwqIFIkNM7eM4+e0UOkZAul2WBJFJ4iyY/c0iYuUcnB4+ey2p7h6GNCrZwZccWmYkA3mgWrNAV5X8rXuTJ5+ztk21SgeT/7bqNJ/8dQRN6XXL+x4tQffCEXxiUP+wwCYtwRXqsfi0K8a1Ka5xPjQTkefJfy0TcnB3c4oaOzVLx2m6gg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1g0rvkqcsMSDFyapInDwW3742+I01Q24PoRoIQdqCKV9tMa/Qxy4MWGUWfnuHg1urc49sM9t497ktuGHJkIoCy8mwFKmj7K5cQvuJTauobbL0wlZS3BGlCW/mLxkolCz0EqvlYEsWGgJ5e2CFOV4tMZPGgOcHjDliLnroW5ArvY0FjqnrpSus4nogNbR43eS92cQFWtDYLSC+JPMyG3bppZW68pX4ZugWg4i57nBPyr9JggppyPgN/rhfengBYtv4QCrJ5mBg3hIFkh/Tum6DhlBDqcH5HoYljK3XQuiwjfUefsQDwyGwSImFskBQC/SWTyVSSEIVlNnxcaSz4y/DvUjgqPiZ3GuoraC0dCkFImBA7AJq/r5FyGD2busHdAbijoHqOLSITOzc/TLS19+tvaGSQMxt9rS9J9n/1LT3O9F4nyIUUvc9eidmnI8Wced
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:59:19.8320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12619199-8c5d-43aa-e2b9-08df1ee1e0ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306

A VFIO PCI device contains a VFIO device. Expose that relationship in
Rust so common device handling is independent of PCI resources.

Add vfio::Device and have vfio::pci::Device borrow its embedded device
through AsRef, preserving the callback context. Share reference counting
and callback-data lifetime handling in vfio. Keep driver operations,
allocation, registration and the PCI enable/close sequence in vfio::pci.

No functional change is intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/vfio.rs     | 200 +++++++++++++++++++++++++++++++++++++-
 rust/kernel/vfio/pci.rs | 207 +++++++++++++---------------------------
 2 files changed, 263 insertions(+), 144 deletions(-)

diff --git a/rust/kernel/vfio.rs b/rust/kernel/vfio.rs
index ed93066e2da5..a0bfbc7c59a0 100644
--- a/rust/kernel/vfio.rs
+++ b/rust/kernel/vfio.rs
@@ -1,14 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! Virtual Function I/O (VFIO) abstractions.
+//! Virtual Function I/O (VFIO) devices and callback data.
+//!
+//! Bus-specific device types borrow their embedded VFIO device through [`AsRef`].
+//! C header: [`include/linux/vfio.h`](srctree/include/linux/vfio.h)
 
 use crate::{
     bindings,
     prelude::*,
+    sync::aref::AlwaysRefCounted,
+    types::{
+        CovariantForLt,
+        ForLt,
+        NotThreadSafe,
+        Opaque, //
+    },
     uaccess::{
         UserPtr,
         UserSlice, //
-    },
+    }, //
+};
+use core::{
+    cell::UnsafeCell,
+    marker::PhantomData,
+    ptr::NonNull, //
 };
 
 #[cfg(CONFIG_VFIO_PCI_CORE)]
@@ -17,12 +32,187 @@
 /// Reset the VFIO device.
 pub const DEVICE_RESET: u32 = bindings::VFIO_DEVICE_RESET;
 
-/// Reset the PCI slot or bus containing a VFIO device.
-pub const DEVICE_PCI_HOT_RESET: u32 = bindings::VFIO_DEVICE_PCI_HOT_RESET;
+/// The context in which a VFIO device reference is valid.
+///
+/// Callback views can only be borrowed from the corresponding VFIO trampoline.
+/// They cannot be refcounted or shared across threads.
+pub trait DeviceContext: private::Sealed {}
+
+/// An ordinary device reference, without callback-specific operations.
+pub struct Normal;
+
+/// The device is undergoing its exclusive first-open callback.
+pub struct Open;
+
+/// The device is borrowed for a VFIO ioctl callback on the current thread.
+pub struct Ioctl;
+
+/// The device is borrowed for a VFIO read callback on the current thread.
+pub struct Read;
+
+/// The device is borrowed for a VFIO write callback on the current thread.
+pub struct Write;
+
+/// The device is borrowed for a VFIO mmap callback on the current thread.
+pub struct Mmap;
+
+/// The device is borrowed for a VFIO region-info callback on the current thread.
+pub struct GetRegionInfo;
+
+mod private {
+    pub trait Sealed {}
+
+    impl Sealed for super::Normal {}
+    impl Sealed for super::Open {}
+    impl Sealed for super::Write {}
+    impl Sealed for super::Mmap {}
+    impl Sealed for super::Ioctl {}
+    impl Sealed for super::Read {}
+    impl Sealed for super::GetRegionInfo {}
+}
+
+impl DeviceContext for Normal {}
+impl DeviceContext for Open {}
+impl DeviceContext for Write {}
+impl DeviceContext for Mmap {}
+impl DeviceContext for Ioctl {}
+impl DeviceContext for Read {}
+impl DeviceContext for GetRegionInfo {}
+
+/// A VFIO device, independent of its bus-specific wrapper.
+///
+/// # Invariants
+///
+/// The underlying `vfio_device` is initialized and remains alive while borrowed.
+/// Callback contexts are borrowed only for the corresponding callback and thread;
+/// only [`Normal`] references can be reference-counted.
+#[repr(transparent)]
+pub struct Device<Ctx: DeviceContext = Normal> {
+    raw: Opaque<bindings::vfio_device>,
+    _context: PhantomData<(Ctx, NotThreadSafe)>,
+}
+
+impl<Ctx: DeviceContext> Device<Ctx> {
+    /// # Safety
+    ///
+    /// `raw` must point to an initialized `vfio_device` that remains alive for
+    /// `'a`. The caller must provide the guarantees of `Ctx` throughout the borrow.
+    #[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
+    unsafe fn from_raw<'a>(raw: *mut bindings::vfio_device) -> &'a Self {
+        // SAFETY: Self is a transparent wrapper; the caller guarantees validity and context.
+        unsafe { &*raw.cast() }
+    }
+
+    fn as_raw(&self) -> *mut bindings::vfio_device {
+        self.raw.get()
+    }
+}
+
+// SAFETY: VFIO uses the embedded class device's refcount to own the full allocation.
+unsafe impl AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: A shared reference keeps the initialized VFIO device alive.
+        unsafe { bindings::get_device(&raw mut (*self.as_raw()).device) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The caller owns the VFIO reference being released.
+        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).device) };
+    }
+}
+
+// SAFETY: Ordinary VFIO references expose no unsynchronized callback operations.
+unsafe impl Send for Device {}
+// SAFETY: Shared access only changes the embedded class device's reference count.
+unsafe impl Sync for Device {}
+
+/// Callback data stored after the bus-specific C device structure.
+///
+/// # Invariants
+///
+/// `reg_data` is dangling when unpublished; otherwise it borrows pinned data kept
+/// alive until callback access has ended. `open_data` is null outside a successful
+/// first open, otherwise owns a pinned allocation until the last close.
+/// The bus-specific layer drains callbacks before releasing either allocation.
+struct CallbackData<R: CovariantForLt, O: ForLt> {
+    reg_data: UnsafeCell<NonNull<R::Of<'static>>>,
+    open_data: UnsafeCell<*mut O::Of<'static>>,
+}
+
+#[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
+impl<R: CovariantForLt, O: ForLt> CallbackData<R, O> {
+    fn new() -> Self {
+        Self {
+            reg_data: UnsafeCell::new(NonNull::dangling()),
+            open_data: UnsafeCell::new(core::ptr::null_mut()),
+        }
+    }
+
+    /// Access registration data without allowing its erased lifetime to escape.
+    ///
+    /// # Safety
+    ///
+    /// Registration data must be published and remain valid through this call.
+    /// The caller must exclude concurrent changes to `reg_data`.
+    unsafe fn registration_data_with<V>(&self, f: impl for<'a> FnOnce(&'a R::Of<'a>) -> V) -> V {
+        // SAFETY: The caller keeps registration data alive and excludes mutation.
+        // Covariance permits shortening its erased lifetime to this borrow.
+        let reg_data = unsafe { (*self.reg_data.get()).cast::<R::Of<'_>>().as_ref() };
+        f(reg_data)
+    }
+
+    /// # Safety
+    ///
+    /// The caller must be an I/O callback while VFIO keeps the device open.
+    /// Registration and open data must remain valid, with their pointer slots
+    /// unchanged throughout the call.
+    unsafe fn callback_data_with<V>(
+        &self,
+        f: impl for<'borrow, 'data> FnOnce(&'borrow R::Of<'data>, Pin<&'borrow O::Of<'data>>) -> V,
+    ) -> V {
+        // SAFETY: The caller excludes open/close and unregister while borrowing the data.
+        unsafe {
+            self.registration_data_with(|reg_data| {
+                let ptr = (*self.open_data.get()).cast::<O::Of<'_>>();
+                // The data lifetime stays independent of the callback borrow,
+                // so borrowed OpenData fields cannot be stored back into OpenData.
+                f(reg_data, Pin::new_unchecked(&*ptr))
+            })
+        }
+    }
+
+    /// # Safety
+    ///
+    /// Call only during exclusive first open, with no existing open data.
+    /// All resources borrowed for `'a` must remain valid until `close()` returns.
+    unsafe fn open<'a, I: PinInit<O::Of<'a>, Error>>(&self, init: impl FnOnce() -> I) -> Result {
+        // Allocate before calling the driver so allocation failure cannot follow open.
+        let data = KBox::<O::Of<'a>>::new_uninit(GFP_KERNEL)?;
+        let data = data.write_pin_init(init())?;
+
+        // SAFETY: Only the owning pointer moves; close drops the allocation in place.
+        let raw = KBox::into_raw(unsafe { Pin::into_inner_unchecked(data) });
+        // SAFETY: First open is exclusive; the caller keeps borrowed resources alive
+        // through close. Lifetimes do not affect the allocation's layout.
+        unsafe { *self.open_data.get() = raw.cast::<O::Of<'static>>() };
+        Ok(())
+    }
+
+    /// # Safety
+    ///
+    /// Call once after a successful open, with all callbacks drained and the next
+    /// open excluded. Registration data and borrowed resources must remain alive.
+    unsafe fn close(&self) {
+        // SAFETY: Last close exclusively takes the allocation published by open.
+        let raw = unsafe { core::mem::replace(&mut *self.open_data.get(), core::ptr::null_mut()) };
+        // SAFETY: The allocation came from KBox::into_raw and is destroyed without moving it.
+        unsafe { drop(KBox::from_raw(raw)) };
+    }
+}
 
 /// Capability buffer supplied by VFIO for a region-info callback.
-#[cfg(CONFIG_VFIO_PCI_CORE)]
 pub struct InfoCap<'a> {
+    #[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
     raw: &'a mut bindings::vfio_info_cap,
 }
 
diff --git a/rust/kernel/vfio/pci.rs b/rust/kernel/vfio/pci.rs
index 0fca288fe6ae..20a89a113751 100644
--- a/rust/kernel/vfio/pci.rs
+++ b/rust/kernel/vfio/pci.rs
@@ -10,9 +10,20 @@
 //! C header: [`include/linux/vfio_pci_core.h`](srctree/include/linux/vfio_pci_core.h)
 
 use super::{
+    CallbackData,
     InfoCap,
     UserBuf, //
 };
+pub use super::{
+    DeviceContext,
+    GetRegionInfo,
+    Ioctl,
+    Mmap,
+    Normal,
+    Open,
+    Read,
+    Write, //
+};
 
 use crate::{
     alloc::allocator::Kmalloc,
@@ -43,61 +54,16 @@
 };
 use core::{
     alloc::Layout,
-    cell::UnsafeCell,
     marker::PhantomData,
     ptr::NonNull, //
 };
 
+/// Reset the PCI slot or bus containing a VFIO device.
+pub const DEVICE_PCI_HOT_RESET: u32 = bindings::VFIO_DEVICE_PCI_HOT_RESET;
+
 /// Index of the PCI configuration-space region.
 pub const CONFIG_REGION_INDEX: u32 = bindings::VFIO_PCI_CONFIG_REGION_INDEX;
 
-/// The context in which a VFIO PCI device reference is valid.
-///
-/// Callback views can only be borrowed from the corresponding VFIO trampoline.
-/// They cannot be refcounted or shared across threads.
-pub trait DeviceContext: private::Sealed {}
-
-/// An ordinary device reference, without callback-specific operations.
-pub struct Normal;
-
-/// The device is enabled but has not yet completed its first-open callback.
-pub struct Open;
-
-/// The device is borrowed for a VFIO ioctl callback on the current thread.
-pub struct Ioctl;
-
-/// The device is borrowed for a VFIO read callback on the current thread.
-pub struct Read;
-
-/// The device is borrowed for a VFIO write callback on the current thread.
-pub struct Write;
-
-/// The device is borrowed for a VFIO mmap callback on the current thread.
-pub struct Mmap;
-
-/// The device is borrowed for a VFIO region-info callback on the current thread.
-pub struct GetRegionInfo;
-
-mod private {
-    pub trait Sealed {}
-
-    impl Sealed for super::Normal {}
-    impl Sealed for super::Open {}
-    impl Sealed for super::Write {}
-    impl Sealed for super::Mmap {}
-    impl Sealed for super::Ioctl {}
-    impl Sealed for super::Read {}
-    impl Sealed for super::GetRegionInfo {}
-}
-
-impl DeviceContext for Normal {}
-impl DeviceContext for Open {}
-impl DeviceContext for Write {}
-impl DeviceContext for Mmap {}
-impl DeviceContext for Ioctl {}
-impl DeviceContext for Read {}
-impl DeviceContext for GetRegionInfo {}
-
 /// Connect a PCI driver's private data to its VFIO registration.
 ///
 /// # Safety
@@ -399,20 +365,22 @@ pub fn region_end(&self) -> Result<u64> {
 /// - Callback contexts are only borrowed for the corresponding callback and thread.
 /// - `core_device` was initialized by `vfio_pci_core_init_dev()`.
 /// - The VFIO device refcount owns the allocation lifetime.
-/// - `reg_data` is dangling without an owner or points to a valid
-///   `<T::RegistrationData as ForLt>::Of<'_>` owned by the enclosing [`Registration`].
-/// - `open_data` is null outside a successful open, otherwise it owns a pinned
-///   `KBox<T::OpenData<'_>>` until last close. Only open/close mutate it; VFIO
-///   prevents I/O callbacks from racing those transitions. The data is dropped
-///   before PCI core close and before registration data is freed.
+/// - `data` follows the VFIO registration and first-open/last-close lifetimes.
+///   Open data is destroyed before PCI core close, and registration data is
+///   released after PCI core unregistration has drained callbacks.
 #[repr(C)]
 pub struct Device<T: Operations, Ctx: DeviceContext = Normal> {
     core_device: Opaque<bindings::vfio_pci_core_device>,
-    reg_data: UnsafeCell<NonNull<<T::RegistrationData as ForLt>::Of<'static>>>,
-    open_data: UnsafeCell<*mut T::OpenData<'static>>,
+    data: CallbackData<T::RegistrationData, OpenDataFamily<T>>,
     _context: PhantomData<(Ctx, NotThreadSafe)>,
 }
 
+struct OpenDataFamily<T>(PhantomData<T>);
+
+impl<T: Operations> ForLt for OpenDataFamily<T> {
+    type Of<'a> = T::OpenData<'a>;
+}
+
 impl<T: Operations> Device<T> {
     /// Allocate a VFIO PCI device for subsequent registration.
     pub fn new(pdev: &pci::Device<device::Core<'_>>) -> Result<ARef<Self>> {
@@ -426,6 +394,7 @@ pub fn new_passthrough(pdev: &pci::Device<device::Core<'_>>) -> Result<ARef<Self
 
     fn allocate(pdev: &pci::Device<device::Core<'_>>, passthrough: bool) -> Result<ARef<Self>> {
         const_assert!(core::mem::offset_of!(Self, core_device) == 0);
+        const_assert!(core::mem::offset_of!(bindings::vfio_pci_core_device, vdev) == 0);
         let size = Kmalloc::aligned_layout(Layout::new::<Self>()).size();
 
         // SAFETY: The bound PCI device and static ops are valid. The allocation
@@ -437,8 +406,7 @@ fn allocate(pdev: &pci::Device<device::Core<'_>>, passthrough: bool) -> Result<A
 
         // SAFETY: Initialise the Rust field in the newly allocated device.
         unsafe {
-            (&raw mut (*this.as_ptr()).reg_data).write(UnsafeCell::new(NonNull::dangling()));
-            (&raw mut (*this.as_ptr()).open_data).write(UnsafeCell::new(core::ptr::null_mut()));
+            (&raw mut (*this.as_ptr()).data).write(CallbackData::new());
             (&raw mut (*this.as_ptr())._context).write(PhantomData);
         }
 
@@ -451,50 +419,6 @@ fn allocate(pdev: &pci::Device<device::Core<'_>>, passthrough: bool) -> Result<A
         Ok(unsafe { ARef::from_raw(this) })
     }
 
-    /// Access the registration data through a closure with an HRTB lifetime.
-    ///
-    /// The closure's `for<'a>` bound prevents the caller from smuggling
-    /// references with a concrete short lifetime out of the closure.
-    ///
-    /// # Safety
-    ///
-    /// Registration data must be published and remain valid through this call.
-    unsafe fn registration_data_with<R>(
-        &self,
-        f: impl for<'a> FnOnce(&'a <T::RegistrationData as ForLt>::Of<'a>) -> R,
-    ) -> R {
-        // SAFETY: Registration keeps the allocation and its borrowed resources
-        // alive until unregistration completes. Covariance permits shortening
-        // the erased binding lifetime to this callback's borrow.
-        let reg_data: &<T::RegistrationData as ForLt>::Of<'_> = unsafe {
-            (*self.reg_data.get())
-                .cast::<<T::RegistrationData as ForLt>::Of<'_>>()
-                .as_ref()
-        };
-        f(reg_data)
-    }
-
-    /// # Safety
-    ///
-    /// The caller must be an I/O callback while VFIO keeps the device open.
-    unsafe fn callback_data_with<R>(
-        &self,
-        f: impl for<'borrow, 'data> FnOnce(
-            &'borrow <T::RegistrationData as ForLt>::Of<'data>,
-            Pin<&'borrow T::OpenData<'data>>,
-        ) -> R,
-    ) -> R {
-        // SAFETY: VFIO excludes open/close and unregister while this callback runs.
-        unsafe {
-            self.registration_data_with(|reg_data| {
-                let ptr = (*self.open_data.get()).cast::<T::OpenData<'_>>();
-                // The data lifetime stays independent of the callback borrow,
-                // so borrowed OpenData fields cannot be stored back into OpenData.
-                f(reg_data, Pin::new_unchecked(&*ptr))
-            })
-        }
-    }
-
     /// # Safety
     /// The returned view must only be used during the callback represented by `Ctx`.
     unsafe fn with_context<Ctx: DeviceContext>(&self) -> &Device<T, Ctx> {
@@ -522,7 +446,15 @@ fn core_device(&self) -> *mut bindings::vfio_pci_core_device {
     }
 
     fn vfio_device(&self) -> *mut bindings::vfio_device {
-        self.core_device.get().cast()
+        self.as_ref().as_raw()
+    }
+}
+
+impl<T: Operations, Ctx: DeviceContext> AsRef<super::Device<Ctx>> for Device<T, Ctx> {
+    fn as_ref(&self) -> &super::Device<Ctx> {
+        // SAFETY: The PCI core device embeds an initialized vfio_device. The borrow
+        // covers the same object and preserves the callback context and its lifetime.
+        unsafe { super::Device::from_raw(&raw mut (*self.core_device()).vdev) }
     }
 }
 
@@ -626,13 +558,14 @@ pub fn core_get_region_info(
 // SAFETY: The embedded device reference count owns the VFIO allocation.
 unsafe impl<T: Operations> AlwaysRefCounted for Device<T> {
     fn inc_ref(&self) {
-        // SAFETY: `self` holds a live VFIO device reference.
-        unsafe { bindings::get_device(&raw mut (*self.vfio_device()).device) };
+        self.as_ref().inc_ref();
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
-        // SAFETY: The caller owns the reference being released.
-        unsafe { bindings::put_device(&raw mut (*obj.as_ref().vfio_device()).device) };
+        // SAFETY: The caller owns a reference to this live PCI wrapper.
+        let dev = unsafe { obj.as_ref() }.as_ref();
+        // SAFETY: The embedded VFIO device owns the same allocation and reference.
+        unsafe { super::Device::dec_ref(NonNull::from(dev)) };
     }
 }
 
@@ -648,9 +581,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
 ///
 /// `vdev` must belong to a registered `Device<T>` in VFIO's first-open context.
 /// VFIO must exclude other opens, closes and I/O callbacks for this call.
-unsafe extern "C" fn open_device_cb<T: Operations>(
-    vdev: *mut bindings::vfio_device,
-) -> core::ffi::c_int {
+unsafe extern "C" fn open_device_cb<T: Operations>(vdev: *mut bindings::vfio_device) -> c_int {
     // SAFETY: `vdev` is valid; set by vfio_alloc_device.
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
 
@@ -662,18 +593,9 @@ unsafe impl<T: Operations> Sync for Device<T> {}
 
     // SAFETY: Registration data is initialized before the VFIO device is published.
     let result = unsafe {
-        dev.registration_data_with(|rd| {
-            // Allocate before calling the driver so allocation failure cannot follow open.
-            let data = KBox::<T::OpenData<'_>>::new_uninit(GFP_KERNEL)?;
-            let data = data.write_pin_init(T::open_device(dev.with_context::<Open>(), rd))?;
-
-            // SAFETY: Only the owning pointer is moved; the allocation remains pinned.
-            let raw =
-                KBox::into_raw(Pin::into_inner_unchecked(data)).cast::<T::OpenData<'static>>();
-            // SAFETY: First open is exclusive with I/O callbacks and last close.
-            // Lifetimes do not affect layout; the device owns the allocation until close.
-            *dev.open_data.get() = raw;
-            Ok::<(), Error>(())
+        dev.data.registration_data_with(|rd| {
+            dev.data
+                .open(|| T::open_device(dev.with_context::<Open>(), rd))
         })
     };
     match result {
@@ -698,12 +620,9 @@ unsafe impl<T: Operations> Sync for Device<T> {}
 unsafe extern "C" fn close_device_cb<T: Operations>(vdev: *mut bindings::vfio_device) {
     // SAFETY: `vdev` is valid.
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
-    // SAFETY: Last close is exclusive with I/O callbacks and the next first open.
-    let raw = unsafe { core::mem::replace(&mut *dev.open_data.get(), core::ptr::null_mut()) };
-    // Run the driver's destructor while registration data and PCI resources are valid.
-    // SAFETY: Successful open transferred this allocation with `KBox::into_raw`.
-    // Last close takes ownership exactly once and drops it without moving the pointee.
-    unsafe { drop(KBox::from_raw(raw)) };
+    // SAFETY: Last close drains I/O callbacks and excludes the next first open.
+    // Registration data and PCI resources remain valid while open data is destroyed.
+    unsafe { dev.data.close() };
     // SAFETY: Matches the enable in open_device_cb.
     unsafe { bindings::vfio_pci_core_close_device(vdev) };
 }
@@ -721,7 +640,8 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
     // SAFETY: VFIO invokes this callback for an open device with valid arguments.
     match unsafe {
-        dev.callback_data_with(|rd, od| T::ioctl(dev.with_context::<Ioctl>(), rd, od, cmd, arg))
+        dev.data
+            .callback_data_with(|rd, od| T::ioctl(dev.with_context::<Ioctl>(), rd, od, cmd, arg))
     } {
         Ok(v) => v,
         Err(e) => e.to_errno() as isize,
@@ -752,7 +672,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     };
     // SAFETY: VFIO invokes this callback for an open device with valid arguments.
     match unsafe {
-        dev.callback_data_with(|rd, od| {
+        dev.data.callback_data_with(|rd, od| {
             T::read(dev.with_context::<Read>(), rd, od, &mut ubuf, &mut pos)
         })
     } {
@@ -771,7 +691,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     vdev: *mut bindings::vfio_device,
     info: *mut bindings::vfio_region_info,
     caps: *mut bindings::vfio_info_cap,
-) -> core::ffi::c_int {
+) -> c_int {
     // SAFETY: `vdev`, `info`, and `caps` are valid kernel pointers provided
     // by the VFIO core.
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
@@ -783,7 +703,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     };
     // SAFETY: VFIO invokes this callback for an open device with valid arguments.
     match unsafe {
-        dev.callback_data_with(|rd, od| {
+        dev.data.callback_data_with(|rd, od| {
             T::get_region_info(dev.with_context::<GetRegionInfo>(), rd, od, info, &mut caps)
         })
     } {
@@ -815,7 +735,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     };
     // SAFETY: This callback runs while VFIO keeps both callback data allocations alive.
     match unsafe {
-        dev.callback_data_with(|rd, od| {
+        dev.data.callback_data_with(|rd, od| {
             T::write(dev.with_context::<Write>(), rd, od, &mut ubuf, &mut pos)
         })
     } {
@@ -832,7 +752,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
 unsafe extern "C" fn mmap_cb<T: Operations>(
     vdev: *mut bindings::vfio_device,
     vma: *mut bindings::vm_area_struct,
-) -> core::ffi::c_int {
+) -> c_int {
     // SAFETY: VFIO supplies an open device for this mmap callback.
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
     let mut mapping = Mapping {
@@ -842,7 +762,8 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     };
     // SAFETY: This callback runs while VFIO keeps both callback data allocations alive.
     match unsafe {
-        dev.callback_data_with(|rd, od| T::mmap(dev.with_context::<Mmap>(), rd, od, &mut mapping))
+        dev.data
+            .callback_data_with(|rd, od| T::mmap(dev.with_context::<Mmap>(), rd, od, &mut mapping))
     } {
         Ok(()) => 0,
         Err(e) => e.to_errno(),
@@ -878,7 +799,11 @@ unsafe fn registration<'a>(
             return;
         };
         // SAFETY: The registration owns callback data throughout bind and unbind.
-        unsafe { reg.dev.registration_data_with(D::Operations::reset_prepare) };
+        unsafe {
+            reg.dev
+                .data
+                .registration_data_with(D::Operations::reset_prepare)
+        };
     }
 
     unsafe extern "C" fn reset_done(pdev: *mut bindings::pci_dev) {
@@ -887,7 +812,11 @@ unsafe fn registration<'a>(
             return;
         };
         // SAFETY: The registration owns callback data throughout bind and unbind.
-        let result = unsafe { reg.dev.registration_data_with(D::Operations::reset_done) };
+        let result = unsafe {
+            reg.dev
+                .data
+                .registration_data_with(D::Operations::reset_done)
+        };
         if let Err(error) = result {
             // SAFETY: The PCI callback keeps its embedded device alive.
             let dev = unsafe { device::Device::<device::Normal>::from_raw(&raw mut (*pdev).dev) };
@@ -1062,7 +991,7 @@ pub unsafe fn new(
             NonNull::from(Pin::get_ref(reg_data.as_ref())).cast();
 
         // SAFETY: No concurrent registration or callbacks; publish before registering.
-        unsafe { *dev.reg_data.get() = ptr };
+        unsafe { *dev.data.reg_data.get() = ptr };
 
         Ok(Self {
             dev: dev.into(),
@@ -1104,6 +1033,6 @@ impl<T: Operations> Drop for Registration<'_, T> {
     fn drop(&mut self) {
         // SAFETY: The adapter unregisters before removing private data. Failed or unattempted
         // registration also leaves no callbacks behind.
-        unsafe { *self.dev.reg_data.get() = NonNull::dangling() };
+        unsafe { *self.dev.data.reg_data.get() = NonNull::dangling() };
     }
 }
-- 
2.53.0

