Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8B384CE5;
	Wed, 30 Sep 2026 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763824; cv=fail; b=E7AX/ptBhujCJ4sAi5vIh98pwSSyvKnn/v+PrYb16BnrztY0qYA22oug/0q/RgzHZCg9CWN5OyL5CUw8idvRGzurLPaJ5k5fvfe0GatQg6c6PkgFdrezBg1bZtZdHdz7EBibgYN5N5i0P/6bOVvkpojgY8ejWcA/awHZ12Q+JTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763824; c=relaxed/simple;
	bh=u+OTdohmnitUq8FkbENfqQeYJyVfH7CZP2kCimHDAAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuUaO7KhgOY2UQLEcLeKVP3fdSj19HCPEQQVK0BzXoMibAl7EOMXnqLzc6FvMoT9GpqxU6mPv0Pg+2hgIOb/yVBHaOmFG/lXDtMpqUHPUixQ8QWl/IW0hcw/kim1SkoKoyO3S+IK1TqnLrjmvLhFjsXxQPf9FEQmC10kUEankdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZqVX1iCv; arc=fail smtp.client-ip=52.101.57.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZqVX1iCv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLC+NHl0vkGf0Q8xVCnnwTywl9kxwdkXRzDMWIAS0vp+tIEnmkuBfrDbFhClHKd3Bf9rZVY3hvoWIX0ZA1cy0MZHdzhmgWlLGnAQJup4ndXOj/fA1vCJV8ulxc/m0+A5iVf8cdjyuirYQ4ner2gdEmlkW4fdffKxKmrof4BK3zO3SM3Z6sgBDl/RcNybR7s3S9hpvXuBMca0BzXwYuY1gviWSrMaMtOMCxWkTUDyq3OICXc/NMyoi6XiAOZx4XEB2NAO9mvfaO8bRtXhPQfCWLJAAHPqlD/hcFWwzjRP+JdaJZwREmYhO5dyWZNjasCA4i/6230eVaSy9ydW95c/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8PmDYHi3P4SbBsu/9G2wWrxSPF2hb1gXl5ErluOgEQ=;
 b=Uw2j0ZDONA+k04EVNoAwDDTzZBfss5HIDGpPsqAAUvbLJvt4+q1UTC/cNXHZDYMiNWUY8R50MG8oAjDmmJvI02JlrNeSYAHBII0XFioNmnIqh2akgmby55qH13Lxb3oy93L7En9btvOhAaG1Vobwd0XwiddV0TQAzanHw+/BSQ17YPDzFopthNpON/T5Ru0F2B/3rUcIEg38kIRKZ2frzHUFCRgh4vmB69pse9EVx1KI6jPYaWP6BQMIBORlcJlUUJTF0O1u7Oz2AbfY+7Okg38aouk9EAa7On/YCnDhjvDcOQxNirbfIGxYzVXWT52kgljeNH1M2LoCrUcXfdnW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8PmDYHi3P4SbBsu/9G2wWrxSPF2hb1gXl5ErluOgEQ=;
 b=ZqVX1iCvxxnE/ym44nI7PWfMyAC1fHKrfYcth0101UGXX9KBpImoXHzFxYlIK5i4URh72z1LHpNwaeZ1XqvyJVWvvybV3j6lfg2wpAbdINYeMk/rhpgkUOy++Zyc65NthkoIKxS0GB2YOoJN7asW5xUnXMyyN/4tDf8cMOA/x02hw0zIhpWXyeUBUG/v47DXBo+3Z4Aiav/bwhy9s30fsOG7GmTLjPOEhLW8fpBnc9wyxQ3fQQIllmNoy3/fnBfpPM5V/MDthEDAXVIh5tzoCcoQzRWpNTjEAmgvKR9/VcTbaAzsUXLGqL07QlN/NEJ8cxwxyrX6IZPI8FCQcpeAUA==
Received: from PH7P220CA0157.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::23)
 by CH9PR12MB388294.namprd12.prod.outlook.com (2603:10b6:610:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 10:23:35 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:33b:cafe::40) by PH7P220CA0157.outlook.office365.com
 (2603:10b6:510:33b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 10:23:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 10:23:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:23:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:23:13 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:21:22 -0700
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
	<alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>, Peter Colberg
	<peter@colberg.org>
Subject: [PATCH v3 07/10] rust: pci: add typed SR-IOV PF registration data
Date: Wed, 30 Sep 2026 13:18:48 +0300
Message-ID: <9fa15232fb869a562973454d9d21a5287b3da080.1790759932.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790705494.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CH9PR12MB388294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a97112b-b559-4a4f-b622-08df1edce2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|56012099006|11063799006|5023799004|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0RPgqpMccvIYDGrt6blZQMDtOm3dQXrNjXTo+qygKYwwvyOpI99qmctAkOCI4oGBzqZrV+CK2PEr8/5fRZpoPUuwwv4Qfh+qe5AaUPuUMjHQX5dyJO5eSGcLOwqOFArB2yrxSSnsfqp6BGnRzO41ShJ7jyr0H9PE6QPKsW6+whti7DpqYr6ed2ma7i1JYpAKf6NIL8xYmFfXHAivOAaHjsVsdWCgRC9FAIMWeq4MlJlXemXVquajx1U0a0XTinK0waKuklMc1d7Zp8ngatBrL2+01/eLOYgV2tjJYFSXNoy/9DHglXrPh62T1Qr2xE/0f+ilmt48WXDzRUL9jKxCHnhszcplSzySXEhUCzcc709BHCnRCsOKbq/DkqfILwJXeihmatmtKL4eaeoQL1DlzkeAQcwY2uN98uW0HW9pmgSTtCBZAH+RQ1r7zmnqveDYuBebInFg02koYxXRjVErSm/eylhlZtO+dXYEN8xTLbN0rFmArD2OIHnVxRdgaGI/9Pukh0HLzWHOsao+1mhZvc1d/2Wt47oO3ddzJHWX6YVvVAO9gOPYtk2olxxkkuR6pJmOYouNiBiZb0T1X1CjhyWViEeFhRT8oK1z9MTJR5AWbLLNk4++vxJ/tcxCfHBNroc/KmMvXzeXOth2SzLmE851feQcYfq+ho+ZLwSJgysZL57nlDCoAWTj+NZe6fVJ/dkWUt8meauac1JvtPptAw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(56012099006)(11063799006)(5023799004)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4ruYjwR6AjfhDbVvGIHRoUQN0rnnJxlbkBcgUxqMilvSAY87S8gThYzyft0+YmFlg9EkXCkguNK+9AfK1lSCVF0ebg/uBy585F15QUcOOpILXq3bj5XHFKvZNt3mFoaTaKCMAub8Jf6Okomx0qVHW8YjkOWngIc3dI1HXRhEt4TBF+rZm+nCJX0bWrpa5FjS5simi4/XSNHtrLrtlfiP/UHDh3L2tZ3oevhyOZPqVyXlJ8l5s4b7ZkalfZ7HgTuQqy5hc5Tz1t73N1aOZfIBrmRiNLvs00nU2lAP0D1xSNTxYraCaZeocIUBIA1AvsBvG7IJBnPfzIzQzO4YOBi44P778OI9WBbu2SVblTHr+RXcLoPS3a9Fh0BuPcS7OquKxi8jYmP0gJkkS9mBQ8ny8fKEtbXA9bvs4gQeOoHBuFBlhtS6AD5EbHHPseLExQCo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:23:35.4796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a97112b-b559-4a4f-b622-08df1edce2b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB388294

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
 include/linux/pci.h    |   7 ++
 rust/kernel/pci.rs     |   5 +
 rust/kernel/pci/iov.rs | 202 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 213 insertions(+), 1 deletion(-)

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
index 1599b3a613d7..8782e9b06e64 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -51,6 +51,8 @@
     Extended,
     Normal, //
 };
+#[cfg(CONFIG_PCI_IOV)]
+pub use self::iov::VfRegistration;
 pub use self::irq::{
     IrqType,
     IrqTypes,
@@ -331,6 +333,9 @@ fn probe<'bound>(
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
+    ///
+    /// For a PF with enabled VFs, `VfRegistration` disables SR-IOV when it is dropped. This
+    /// callback must leave resources accessed by VF drivers available until then.
     fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 4f611d5d0b89..3411a9101564 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -8,7 +8,15 @@
     bindings,
     device,
     error::to_result,
-    prelude::*, //
+    prelude::*,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    }, //
+};
+use core::{
+    any::TypeId,
+    marker::PhantomPinned, //
 };
 
 impl Device {
@@ -69,3 +77,195 @@ pub(crate) fn disable_sriov(&self) {
         unsafe { bindings::pci_disable_sriov(self.as_raw()) };
     }
 }
+
+/// Wrapper for VF registration data stored inside a [`VfRegistration`].
+///
+/// Stores a [`TypeId`] header (derived from `F`) followed by the pinned data,
+/// so that [`Device::vf_registration_data_with()`] can verify the type at
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
+    fn new(data: impl PinInit<F::Of<'a>, Error>) -> impl PinInit<Self, Error> {
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
+/// [`Device::vf_registration_data_with()`] and [`Device::vf_registration_data()`].
+///
+/// Drop disables SR-IOV before clearing the registration pointer and releasing the data.
+#[pin_data(PinnedDrop)]
+pub struct VfRegistration<'a, F: ForLt + 'static> {
+    pdev: &'a Device<device::Bound>,
+    #[pin]
+    inner: VfRegistrationData<'a, F>,
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
+    /// The returned registration must be embedded in the driver's bus device private data.
+    /// The initializer must run as part of the PF driver's probe.
+    /// The driver's `unbind` callback and the enclosing data's destructor must keep resources
+    /// accessed by VF drivers available until this registration has disabled SR-IOV.
+    pub unsafe fn new(
+        pdev: &'a Device<device::Core<'_>>,
+        data: impl PinInit<F::Of<'a>, Error> + 'a,
+    ) -> impl PinInit<Self, Error> + 'a {
+        let pdev: &'a Device<device::Bound> = pdev;
+        try_pin_init!(Self {
+            _: {
+                if pdev.is_virtfn() {
+                    return Err(ENODEV);
+                }
+            },
+            pdev,
+            inner <- VfRegistrationData::new(data),
+            _pin: PhantomPinned,
+            _: {
+                // Check after initialization in case it registered another object for this PF.
+                // SAFETY: The caller runs this initializer during PF probing, before VF
+                // configuration callbacks can run.
+                if unsafe { bindings::pci_num_vf(pdev.as_raw()) } != 0 {
+                    return Err(EBUSY);
+                }
+
+                // SAFETY: This initializer runs during PF probing, and no VFs are enabled.
+                if !unsafe { (*pdev.as_raw()).vf_registration_data_rust }.is_null() {
+                    return Err(EBUSY);
+                }
+
+                // SAFETY: The data is initialized and pinned, the slot is unoccupied, and
+                // no VF can access it yet. No fallible work follows publication.
+                unsafe {
+                    (*pdev.as_raw()).vf_registration_data_rust =
+                        core::ptr::from_ref(inner.as_ref().get_ref()).cast_mut().cast();
+                }
+            },
+        })
+    }
+}
+
+#[pinned_drop]
+impl<F: ForLt + 'static> PinnedDrop for VfRegistration<'_, F> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: `pci_disable_sriov()` is safe to call on any `pci_dev`; it
+        // is a no-op if the device has no VFs enabled. When VFs are enabled,
+        // this blocks until all VF `remove()` callbacks complete.
+        unsafe { bindings::pci_disable_sriov(self.pdev.as_raw()) };
+
+        // SAFETY: The device is valid and all VF remove callbacks have completed, so no VF
+        // can access the registration pointer. The data remains alive until this returns.
+        unsafe { (*self.pdev.as_raw()).vf_registration_data_rust = core::ptr::null_mut() };
+    }
+}
+
+// SAFETY: The inner data is `Send` (enforced by the bound), and `&Device` is `Send + Sync`.
+unsafe impl<F: ForLt> Send for VfRegistration<'_, F> where for<'a> F::Of<'a>: Send {}
+
+// SAFETY: The inner data is `Send + Sync`. `VfRegistration` doesn't expose mutable access;
+// VF drivers only read the data through an immutable pinned reference.
+unsafe impl<F: ForLt> Sync for VfRegistration<'_, F> where for<'a> F::Of<'a>: Send + Sync {}
+
+impl Device<device::Bound> {
+    /// Internal helper: reads the `vf_registration_data_rust` pointer from the
+    /// PF, checks the `TypeId`, and returns a pinned reference.
+    ///
+    /// # Safety
+    ///
+    /// The data lifetime must be hidden behind a higher-ranked closure independently of the
+    /// reference lifetime, or `F` must be covariant in its encoded lifetime.
+    unsafe fn vf_registration_data_pinned<F: ForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        if !self.is_virtfn() {
+            return Err(ENODEV);
+        }
+
+        // SAFETY: This bound VF uses the `physfn` union field. PCI retains its PF until
+        // VF removal completes, and the PF keeps the registration installed until then.
+        let ptr = unsafe {
+            let pf = (*self.as_raw()).__bindgen_anon_1.physfn;
+            (*pf).vf_registration_data_rust
+        };
+
+        if ptr.is_null() {
+            return Err(ENOENT);
+        }
+
+        // SAFETY: The registration keeps its data installed until VF removal completes,
+        // including when probe initialization rolls back.
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
+    /// The reference is borrowed from this VF, while the registration data's lifetime remains
+    /// abstract so the closure cannot store shorter-lived references in invariant data.
+    pub fn vf_registration_data_with<'this, F: ForLt + 'static, R>(
+        &'this self,
+        f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
+    ) -> Result<R> {
+        // SAFETY: The closure is higher-ranked over the data lifetime, independently of `'this`.
+        // It cannot insert shorter-lived references, and the outer borrow cannot outlive this VF.
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

