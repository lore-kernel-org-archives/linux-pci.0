Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E54192F9;
	Sun,  4 Oct 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115725; cv=fail; b=Gjzu00MmC2VTpp5Es4b954cmJltCab3mS3OMAqHr1Ow6i7WFYaUH4Qi3HtZGOgAsnSi97OuCzSRtXsuqOMUlBK9fWZi+eKMsO7dgoWIxf0+esEorfs6bDMFGbKpscUT5zyYxkEIpqFuDMZane8zywrKCFsn++zQscoMYskBXnGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115725; c=relaxed/simple;
	bh=xFZADG8XO6wpD5d3q2bYFO+jcM/8PIEXwl/FxMwn9oQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcWQZEpY+zBInb8vwSd8U0rwvZzUNCsk1ZLBsrCnSfb9S2HOmlXu6okepxLja+dLtPXqev+Rt7RPZekxeIFFU6zgtPUVswr4aMwyvWzPLi1QzgI+HJMOH4my/pcunzdavZcw7V7XpFFaWd484YxddZmR+wf1MHJjJ57k0t/SEw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BKkWsA3m; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BKkWsA3m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQEUJ9vTXpo+Fq1J5bEZ7c2U0L3sKTZVbmGCiGIBNWY+USSGW4ALXFwA0HVi3qB6jSxUX5ipVtXBwDfqflb6zSIJWFFmW029megIHjuybAzjVK3gZ6JUxUkKZx1upr6oEkgIzKvGXDeqg8Uejh5Y6LsaUjl+a1WrO3Jamo8KraWib/J1pI+LyRA4uA4HS+6J9oyi4cN7GaFbK8VfLfDDr2s+8ZMmW2dfg3MzIbOUOUU892gHG8GXW4ZbnUk85c/n9hKTzF/kiljLOQ5H+Qz2q4GuM+sgGbUKiMiqAwrXmijM7BJpNt48lK6chcYCkxH7238T3aT/jtOoogbV3kYmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfEQjShgEejnCw7AVXtJ3oASMz8e83f4ruCJQ71pk0s=;
 b=qtcxGY8CjJRNDL+2vceg9Hl1PxzgbMn7+4LvSCkWrWNdS63FH2TZLEoQV4jfB7/J7b9KwsnFcfOaNtwk9jEagAZthla6G6CjVsQKW5rFLI3/oXSNYJIpac3zg2sllN4y9fTUeJ2StKHm7sWYVdqRjRpLsqDHYg+HCp+YC3f1/r5LuSM5fHOy/A0m0lyz7T9VAqZ2It3YvdG7JAZdQUirWvS9qY4p5z9H+9b/BNfp/t1o0IL4c+nIU/RrlB4AxDdx9FrA4bZ1ESCEc4Q+VQfgD88TpCw69B1lGRI/Y+v+veRSuz/hnDtPQCPz75nwEJof6NPeTLuURYoLU3jBJhdubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfEQjShgEejnCw7AVXtJ3oASMz8e83f4ruCJQ71pk0s=;
 b=BKkWsA3m1Fb11TzYK2Hw1HPAFun6HBAIkd3KdSOzMNu4qY3cUUfg2uWGZR4AH2jyrZGM9eoD9inh/SxgauNq/alKG6GETu/0DyQYH4DaaPxJUoIfiMu6822B+kTkMbKotvSEGcltTiRE9AGflgmUcf1YpJSQtBIplP2mudiAw6+/0z+lRhuexscQGjKebHnOHfZZRpeOgEdMKu/um4REKlBJTnO3X8TVtN5gm6lKyMSy1z2pN8UMAOs79monrUvao9X6kMOGVImKZsK0LE70H22x4S98uz/k0ZYhr8WFjjZd8bFnH5yotMPviavg7YwGY+QdIQTkaUixHhuUs9A37Q==
Received: from BN9PR03CA0622.namprd03.prod.outlook.com (2603:10b6:408:106::27)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Sun, 4 Oct
 2026 12:08:38 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::e) by BN9PR03CA0622.outlook.office365.com
 (2603:10b6:408:106::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 12:08:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:23 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:08:16 -0700
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
Subject: [PATCH v4 6/9] rust: pci: add typed SR-IOV PF registration data
Date: Sun, 4 Oct 2026 15:07:27 +0300
Message-ID: <20261004120732.1045629-7-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004120732.1045629-1-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: ec35bee2-ab00-496c-53a4-08df221038e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|7416014|36860700016|10067099003|5023799004|3023799007|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3ClThqHc0RDMIf31Bpifqv5q5ftA6z7PCH4OU9EkKPo56O60ahLsiRYoQLt3PNjF1VdHanVvyMeMjx3WBfv46TKn6XqtnHV7gU4bmisE+hKeKRTRa5C+eFTKWg204MSbjwAgdnD6o3E/iuc9xrrVsTJNKNwzBHvsWAxHSf+CBA99wf8tREiZrMnbIiUDx7VDwLBVCDI8dcc5E/3oFgw5u1ns4yCl4UVSgK/8ut8eRtXSUq987FBs3jcU957SlI0BvdxUeFJmyhuF9lP6BEWKXN9fpw01ON1o0z/wCCKuznCi/FpK108uW/xuW5YdMczS0aoXeQsEbyT8pj47SM94jpKxJ8M6AIAWvTmvx6Wc5Q555RG23rrcXJOOC137f53ZsmM167vwsLX4ev0a+FZv2K+RVhsL04ngDed6/0u7vGT+mVOfW2f/fk9dOjI5SX+45nAdsF70MdMTwZLh0/hvqPsAiN+82MRtZe9UJjRnaTo/GtP5EAm6wHGEdBwTAUikH2DkTCxmDvHhwBA+n8RmLiHApaYBFBqiLNuw3c1qq6pRwVES4dJ3coJDJQplNNc+aIsnLAXj012XamPcezFv9moZ+/+N1NjNTs08ZSAnM14kuD9+iLE2cuGgC+THUE13umEfnVtBdU/q+jabnVy29aHo3tz8LORrRjf5qPRO4zTNFdWrRKnO4eYXSf/13K5GWNopJCL1a6MLikaPKBaXuw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(7416014)(36860700016)(10067099003)(5023799004)(3023799007)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oPYDg9c9QySme8O8EiJP/Oeygz+r0N1wcePe5PN+5Q6bINx3EEN1JP1sk3u+fFcP4sG0KaQtXRROJdjT8qZyM2R8eFTepnB2WbCFiyT0yWTwM2cTAEOhBctPmPY9T68T13Z4buGKtFERRFvALJlFSo2JrjJISARjGwtCj1TMsicpg8P3CX00Axw62B8s9zpDt6RsR9NfFzRHlRFN2blTqr82+aJzyH1923jiFaNIBiEADZ/SHb3RSktFyTfpaasuSV/PNB1IXvhN6POrvqYXTQ6xwkY/ul1H8Q9H34T92F4tlBYwNywHZPdEeHL8SH5D6htyDt49ZP160JcFdkWdVFggV+SAWnf4QcAoS1XLjHWk0UmcY/vI29L8+zXkWHlAWya5EjIX+casjV5VenLOp9hyZKoS2yKareFVpMlmgJrXEJwj8hNrw46K/iBlzLcf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:37.7265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec35bee2-ab00-496c-53a4-08df221038e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160

Rust PF and VF drivers bind to separate PCI devices and may reside
in different modules. A VF driver that calls PF operations needs
typed access to the data exposed by the PF driver. This data must
remain valid until VF driver removal completes.

Add VfRegistration to register a pinned object in the PF's private
data. VF drivers can borrow it after checking the requested Rust
type, using a higher-ranked closure or a covariant lifetime encoding.
The PF accesses its own object through a pinned registration borrow;
this ties the reference to the owner even during PF data teardown.

Capture the core callback context in the initializer. Reject active
VFs and an occupied registration slot before initializing the payload,
then recheck the slot before publication in case the payload initializer
created another registration. Publish only after all fallible work.

During registration teardown, disable SR-IOV and wait for VF remove
callbacks to finish before clearing the pointer and dropping the object.

Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 include/linux/pci.h    |   7 ++
 rust/kernel/pci.rs     |   2 +
 rust/kernel/pci/iov.rs | 216 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 224 insertions(+), 1 deletion(-)

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
index 1599b3a613d7..57752731793f 100644
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
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 4ed6ba658e81..c61462595141 100644
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
@@ -63,3 +71,209 @@ pub(crate) fn disable_sriov(&self) {
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
+    fn new<E>(data: impl PinInit<F::Of<'a>, E>) -> impl PinInit<Self, E> {
+        try_pin_init!(Self {
+            type_id: TypeId::of::<F>(),
+            data <- data,
+        }? E)
+    }
+}
+
+/// SR-IOV VF registration on a PF device.
+///
+/// Owns the registration data that VF drivers access via
+/// [`Device::vf_registration_data_with()`] and [`Device::vf_registration_data()`].
+/// The PF driver can access the same data through [`Self::data()`].
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
+    pub unsafe fn new<'core, I>(
+        pdev: &'a Device<device::Core<'core>>,
+        data: I,
+    ) -> impl PinInit<Self, Error> + 'a + use<'a, 'core, F, I>
+    where
+        I: PinInit<F::Of<'a>, Error> + 'a,
+    {
+        try_pin_init!(Self {
+            _: {
+                if pdev.is_virtfn() {
+                    return Err(ENODEV);
+                }
+                if pdev.num_vf() != 0 {
+                    return Err(EBUSY);
+                }
+                // SAFETY: The core callback serializes changes to this device's registration.
+                if !unsafe { (*pdev.as_raw()).vf_registration_data_rust }.is_null() {
+                    return Err(EBUSY);
+                }
+            },
+            pdev,
+            inner <- VfRegistrationData::new(data),
+            _pin: PhantomPinned,
+            _: {
+                // The data initializer may have registered another object on this device.
+                // SAFETY: The captured core context still serializes registration changes.
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
+impl<'a, F: ForLt> VfRegistration<'a, F> {
+    /// Borrows the registered data for use by the PF driver.
+    ///
+    /// The returned reference is tied to this registration, rather than the PF device: the
+    /// registration may be destroyed before the rest of the PF's private data is dropped.
+    pub fn data(self: Pin<&Self>) -> Pin<&F::Of<'a>> {
+        // SAFETY: Both `inner` and its `data` field are structurally pinned.
+        unsafe { self.map_unchecked(|registration| &registration.inner.data) }
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
+            return Err(ENODEV);
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
+    /// [`ENODEV`] if this is not a VF or no data was registered,
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
+    /// PF drivers access their own data through [`VfRegistration::data()`].
+    ///
+    /// It returns the same errors as [`Self::vf_registration_data_with()`].
+    pub fn vf_registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        // SAFETY: `CovariantForLt` permits shortening the encoded lifetime to this borrow.
+        unsafe { self.vf_registration_data_pinned::<F>() }
+    }
+}
-- 
2.53.0

