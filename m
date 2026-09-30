Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37D4BF952;
	Wed, 30 Sep 2026 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765984; cv=fail; b=AlFkPeQMr+GF3Szu18BuGE/8gHxJa0aLPd3ylY5cIWIB0pg0/8lTN2ec6CH2Gc5959hytGkSLwPh2C8i/3vsCXzrjwzNNH1xdzv763gwc3hsaUF6ysbKhqUTHqyT/p2YbPDnwWa69kg6WZysC38awF0IkdnGehAVhxKRDfM12qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765984; c=relaxed/simple;
	bh=h5HrdqdlPxmcY40ThXlkyCC69L4HQ/pvGka4igVvT6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bthRAqnUOVy8ASkDBgEDuiQp1Y4sa8qDc9HyMcUnqCARvE9LcKdezuBQ238rb4dq24UGTyajWWdaHWd1JAfixXalW4HtC3uPCbJEs9FmVz9wQOWY8f4nri5yQhgnh0XIMSHPxs22ZW+WFf/wHRMcLNl7SD3g/z3fVvQeMovj+RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J6+R8AP6; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J6+R8AP6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNnzrazV2n0TQHbZLisN50uQ29JsM+VJRoDIAM/SwYJcpxvWwGZo17O1Iq1BGcEvLzJZrBRu2mBkMNfIi3gOprClM3/ZFVX+YkdO37FdX3EqRXmABtpCJhps0ynyid2XjwJXS25ghj/g6pOudL5FKMk1KlhUmgUEZy1/Z2wyvaYJjcZNMHNCcOqToRQ0etfgeQ8Yw4sf/tlnl7oiSU7z7sOWW0ZL16jE9M608wp39h+2nZ9n/10CPJczh6HaLI31B51CREbus03yI3KxiNy+wEirTqh1CaQIOz6LejFws/A9ptrvUEqvKekq3wZ6F7BwF6F3li1VKrO+j/J3M7o8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9OzgAdHUs5nFisi3TjEhlG0hma8m4SD+moId2NUiEw=;
 b=Mj/4c8521dxQg4WVUzLRzVUj6sPbPZwo+XFDLhnYh8caf5EV+F5tJ3v/SyV0AV1i9qouA27H5ndL5/G+QOYeQnSKic2NJxdTPH5d+LgVKdQCfX1ioBkE7KqEF/avoyw1IDX4O2Db1cW+26ysOxC2aYBFY8NPrA74kIDZ4aIsjPDhHXD12PCZ4gROeqYhCTfw5iIhaVidKks+w1vLHvJr/77SAhOAVntbRNnLLMimBklVOgFrmTntGJf64+M9NA7ZgAHDkCAZWxsNzjp/9mmQfYIbV6SjEdromeN1sywa/2FLVmFRvgLjAXoYI7agdlDZqDcm/0GJtjX0/8adp0xHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9OzgAdHUs5nFisi3TjEhlG0hma8m4SD+moId2NUiEw=;
 b=J6+R8AP6GD42PalAI//8Xzc0Nz8ebmBRoA3T4CMSA1hK6TGirY5+55d//ifMUcp2Q4kjir/Li0zeZmjAvI3r6altrdo2f64cnvJhZ0sG86i5PlUEZhktFNRxSE0FXKQFg9YTBS17laaUNL0pYrcnCPJk/OtNal583ZepsOaO4XFtXiVvwxTaU7CS4ppczIC5rGUzM3jyDtxO9SqD3q4ieS6RUfjUPDa2q9guA3H8hKXz06LnKiAMblbo11UxyWDrIVWUhL9wT3Q8pB0moyTS0pamQqSMCNZ7RhMAGAZ+iTn8X2plCZmwyNOePqN0+mkRjr+KtHi28ZFFhHy+KVS0GQ==
Received: from CYZPR10CA0022.namprd10.prod.outlook.com (2603:10b6:930:8a::26)
 by LVUPR12MB999160.namprd12.prod.outlook.com (2603:10b6:408:3a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 10:59:28 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:930:8a:cafe::6f) by CYZPR10CA0022.outlook.office365.com
 (2603:10b6:930:8a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 10:59:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:59:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:59:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:59:08 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:58:58 -0700
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
Subject: [PATCH 6/7] gpu: nova-core: publish typed SR-IOV PF APIs
Date: Wed, 30 Sep 2026 13:57:48 +0300
Message-ID: <9babc6d915ed154e90b25de79b02bb74cd1fa971.1790764573.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|LVUPR12MB999160:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1eede2-2f8e-4c86-3c7f-08df1ee1e590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|23010399003|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yrZRSNQ+elJnD0ffeEytNDuS2FpcMrwgAwYjm9fqsv/wk1SbVVVREcc+AQTmCbi0vGXtVW7ecNPc+qbL77Vy7egzNINuFBQDsyaKuOtq0NDIzdpbZD+tlq3M4H7EKT1dlCpQf+hTPSMOnSTWGFgCpyMnbL/OM8NSRb4sToRhgtSxWemB+gP+8TkLkv5w946UBaq+OHH4vlTXoQ256bj6VU6Pz7vGQqazJYnFPYzqnewJHrYHIO2hEhncEOSbts0qZlcArQNBzUUSfVb9HwNdGfNZRPrMEd2J9bjobqebhp4giHMdxw/XXXwjd0dZansv7u6c5G0oXrCSLXOrdItP056Fl5S5ebJ8M/YASPXrYOvQfkcba/8g8eqYazDioYtiN2ot7e3vxsPXTEnj3LK+GFC8M965lceZnLeZo9Hnx0uJmkVJSM6iI45FZGKeEXuwIJ+aunk2ocFAlojFAqHoJ9inhi3ecK90/43vKJzEfNX0uqb9KkJRl+slYtmmjzt1Tkkjd/4ST5o7ZX9PmFSKqyZ3Cw6qoZMU/sfYnIvUF1ix+OMjs1wcXlLzkwoqJPwiCX+wkzSr+j9lbb4mTLXfkJgC7FjpnILB+Z5fm031MEebhQIQnVKe7GuZelHCJTM2CyWPsOGmSz+MgPBwoAG+qznRbL3usTI+6hp+KTwCTY5f0tIiXIrd/8c+v52B1X6RKvJm2vpgw84t5E3OOMxKdg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BIJJyuMGdgH+dTUI+geD0+Deh7p1Za6yRTZY0GDlaOlQHBLuPO3fWOanmH5yqWa7/Wj0rTROr7hD27VNApqqyVqzoim27OZO5MAebMor54unWmUp8UJGmAhNfFZ/pCnzuGd6bnMTH7Oon3NC52RzQsJZ2kBngqPU0aNdfwIwubKtuW2IwWjSTJRXuKBZIYDHXH3C4SMRh08K9PvFw4sWX5XcBodahi97+rdkyuGiifC+dw1MIe5KG0e97OpAabTfaTcloKSfzqbYVe7uJbGj1PHHCRw3SY1e8q+aA8BJlDyi451sFWMRbXhYmmST9UzgcYw4II5wwOaYYxuM08z8Uq9puBa/Gee1Z9PUNuInaPt6Jb2XYxnxy0yT/40bQDZq5gMycP59lQUUz5fmnQ2lb32w6QGDFuXozHhN65PFhZISYARqcve/AB7K2Yu1zuQr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:59:27.6677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1eede2-2f8e-4c86-3c7f-08df1ee1e590
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999160

Register NovaCoreVfApi as typed SR-IOV PF data once the GPU is initialized.

Enable and disable VFs through sriov_configure(). The Rust PCI adapter
removes VFs before dropping PF driver data. Declare the registration
before the GPU so its borrowed services remain valid through VF teardown.

Expose a VF-side handle that borrows these services for each operation.
Return an owned instance on open and close it on drop while the VF
remains bound.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs        | 47 +++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     |  2 +
 drivers/gpu/nova-core/vgpu/vgpu_api.rs | 82 +++++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index dc6febeee656..99beab189879 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -35,6 +35,12 @@
     }, //
 };
 
+#[cfg(CONFIG_PCI_IOV)]
+use kernel::types::ForLt;
+
+#[cfg(CONFIG_PCI_IOV)]
+use crate::vgpu::vgpu_api::NovaCoreVfApi;
+
 /// Counter for generating unique auxiliary device IDs.
 static AUXILIARY_ID_COUNTER: Atomic<u32> = Atomic::new(0);
 
@@ -42,6 +48,10 @@
 pub(crate) struct NovaCore<'bound> {
     /// Firmware-control registration.
     _fwctl: fwctl::Registration<'bound, NovaCoreFwCtl>,
+    #[cfg(CONFIG_PCI_IOV)]
+    #[allow(clippy::type_complexity)]
+    #[pin]
+    _vf_registration: pci::VfRegistration<'bound, ForLt!(NovaCoreVfApi<'_>)>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
@@ -114,6 +124,11 @@ fn probe<'bound>(
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
+            #[cfg(CONFIG_PCI_IOV)]
+            if pdev.is_virtfn() {
+                return Err(ENODEV);
+            }
+
             pdev.enable_device_mem()?;
             pdev.set_master();
 
@@ -144,6 +159,18 @@ fn probe<'bound>(
                 // Run optional GPU selftests.
                 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
                 _: { gpu.run_selftests(pdev) },
+                #[cfg(CONFIG_PCI_IOV)]
+                _vf_registration <- {
+                    // SAFETY: `gpu` is initialized at its pinned address and
+                    // outlives the registration and its borrowed API data.
+                    let gpu = unsafe { &(*this.as_ptr()).gpu };
+                    let api = NovaCoreVfApi::new(gpu, pdev);
+                    // SAFETY: Probe has exclusive access to the registration
+                    // slot and no VFs are enabled before successful probe. The
+                    // registration keeps PF services available until VF removal
+                    // completes and is dropped before its borrowed GPU resources.
+                    unsafe { pci::VfRegistration::new(pdev, Ok(api)) }
+                },
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
@@ -176,4 +203,24 @@ fn probe<'bound>(
             }))
         })
     }
+
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_enable<'bound, 'callback>(
+        _dev: &'bound pci::Device<Core<'_>>,
+        _this: Pin<&Self::Data<'bound>>,
+        token: pci::SriovEnable<'callback>,
+    ) -> Result<pci::SriovEnabled<'callback>> {
+        let num_vfs = token.num_vfs();
+        token.enable(num_vfs)
+    }
+
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_disable<'bound>(
+        _dev: &'bound pci::Device<Core<'_>>,
+        _this: Pin<&Self::Data<'bound>>,
+        token: pci::SriovDisable<'_>,
+    ) -> Result {
+        token.disable();
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 619f32c79415..ee511bdf3544 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -33,6 +33,8 @@
 #[cfg(CONFIG_PCI_IOV)]
 pub use vgpu::vgpu_api::{
     NovaCoreVfApi,
+    NovaCoreVfApiHandle,
+    VgpuInstance,
     VgpuTypeInfo, //
 };
 
diff --git a/drivers/gpu/nova-core/vgpu/vgpu_api.rs b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
index f9f3e527bdc0..a440108d2c26 100644
--- a/drivers/gpu/nova-core/vgpu/vgpu_api.rs
+++ b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
@@ -11,6 +11,9 @@
     prelude::*, //
 };
 
+#[cfg(CONFIG_PCI_IOV)]
+use kernel::types::ForLt;
+
 use crate::{
     driver::Bar0,
     gpu::Gpu,
@@ -61,7 +64,6 @@ pub struct NovaCoreVfApi<'gpu> {
 }
 
 impl<'gpu> NovaCoreVfApi<'gpu> {
-    #[expect(dead_code)]
     pub(crate) fn new(gpu: &'gpu Gpu<'gpu>, pdev: &'gpu pci::Device<device::Bound>) -> Self {
         Self {
             pdev,
@@ -84,6 +86,20 @@ fn gfid(&self, gfid: u32) -> Result<Gfid> {
 }
 
 impl NovaCoreVfApi<'_> {
+    /// Obtains the enabled PF services for a bound VF.
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn handle(vf: &pci::Device<device::Bound>) -> Result<NovaCoreVfApiHandle<'_>> {
+        let handle = NovaCoreVfApiHandle { vf };
+        handle.with(|api| {
+            if api.is_available() {
+                Ok(())
+            } else {
+                Err(ENODEV)
+            }
+        })?;
+        Ok(handle)
+    }
+
     /// Creates and boots an instance for a one-based VF ID.
     ///
     /// `sbdf` encodes the VF address as `(segment << 16) | (bus << 8) | devfn`.
@@ -156,3 +172,67 @@ pub fn reset_instance(&self, gfid: u32) -> Result {
         Ok(())
     }
 }
+
+/// Access to PF services for the lifetime of a VF driver binding.
+///
+/// The PF's registration keeps these services available until VF removal
+/// completes and is dropped before the GPU resources they borrow.
+#[cfg(CONFIG_PCI_IOV)]
+pub struct NovaCoreVfApiHandle<'vf> {
+    vf: &'vf pci::Device<device::Bound>,
+}
+
+#[cfg(CONFIG_PCI_IOV)]
+impl<'vf> NovaCoreVfApiHandle<'vf> {
+    /// Borrows the typed PF services for a single operation.
+    fn with<R>(
+        &self,
+        f: impl for<'borrow, 'data> FnOnce(Pin<&'borrow NovaCoreVfApi<'data>>) -> Result<R>,
+    ) -> Result<R> {
+        self.vf
+            .vf_registration_data_with::<ForLt!(NovaCoreVfApi<'_>), _>(f)?
+    }
+
+    /// Creates and boots an instance that closes when dropped.
+    ///
+    /// The arguments have the same meaning as in [`NovaCoreVfApi::open_instance`].
+    pub fn open(&self, gfid: u32, dbdf: u32, vm_pid: u32) -> Result<VgpuInstance<'vf>> {
+        let type_info = self.with(|api| api.open_instance(gfid, dbdf, vm_pid))?;
+        Ok(VgpuInstance {
+            api: Self { vf: self.vf },
+            gfid,
+            type_info,
+        })
+    }
+
+    /// Resets an active instance and scrubs its guest VRAM.
+    pub fn reset(&self, gfid: u32) -> Result {
+        self.with(|api| api.reset_instance(gfid))
+    }
+}
+
+/// An active instance whose teardown runs while its VF driver remains bound.
+///
+/// Dropping this guard may sleep while firmware teardown completes.
+#[cfg(CONFIG_PCI_IOV)]
+pub struct VgpuInstance<'vf> {
+    api: NovaCoreVfApiHandle<'vf>,
+    gfid: u32,
+    type_info: VgpuTypeInfo,
+}
+
+#[cfg(CONFIG_PCI_IOV)]
+impl VgpuInstance<'_> {
+    /// Returns the assigned PCI IDs and BAR1 aperture size.
+    #[inline]
+    pub fn type_info(&self) -> &VgpuTypeInfo {
+        &self.type_info
+    }
+}
+
+#[cfg(CONFIG_PCI_IOV)]
+impl Drop for VgpuInstance<'_> {
+    fn drop(&mut self) {
+        let _ = self.api.with(|api| api.close_instance(self.gfid));
+    }
+}
-- 
2.53.0

