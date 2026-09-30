Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6336B91A;
	Wed, 30 Sep 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763837; cv=fail; b=gJRC/wQACY5b5DEY2ynBV6uvNieBFOlq375NsqfknyenMuOUvXSqiku+wmf1Mqj/qmdI0ccXAqLD/xU2gtT+SL/WkMzUgnjtJicnHjoGzTATei8w5HTMo4xetzU5Hex+dJowM2ID7dzfwS42u011WgOcLdyYfd14bmGdFBG6ng4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763837; c=relaxed/simple;
	bh=jx/d1AgXWkyxID6XhK/DTZZPeUEFC1z0OP5eOq1qOJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tADbEBdbIugij9VS7P9XvRF+5O8oVuaTteU7e4Ft7tzWcikP7TJXrLw1Fj5VeRjP3f4C87fTJ79nZJiTfPfwUPJP4qAvllr/Xz+zMJx1ri/YvRRrRXqEpr+JO0PgemN73Itms5dQ3zqDGnJbjnuFnuM9Xt0I0PvoAKISuBkrHfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzZeLG6D; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzZeLG6D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgszIWUR0/Ggz6PdgBwvyjTzGMbjCzj4L7rQk3BLZVuqY/EDeY/ECqZHzTMaFkovUNVlWcfxVenE+CdIOWlXnQ7btI47Kzbl42WHuRvX06JLcZ+0+INKfL9CSE/e4kzE49X0/XZE8Vmf93+NQij1TsLQeyJ7t7drPprGEJSwyT+1qb8R6pCqkXsmvKptwipG5LfRvJMOhqwLQLvaOwqLMeiZ8iUf3ZM6U0LwhQvrbJa7FGtItHztRAUT6DxSnLfpL8bnEzgdCiIYABa1QR7PCDnRQbjVkhHUhw5/USDGtQsV0oZbvFqk4i5r/OvfMdY/fDvOfhx0fY0Bb5GNR9lEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v60UsJTtNf43jU1F9yTFGdkmBdAM9f3rd9bfl7yaJvA=;
 b=iC9PnYoP6VHuwcf3o75sIFUuJPIsChxXnBlaeh23po6i3cVQGxRILn5BRUbInVFdgDgfPTV2INSpYO2ff61OAnDm4CQVN6o7b14wsQLu15yMrpmWpIdj7lrD++ZgcN5QRAm1sst8lsT5tWNdaLCMmWp69qsjktA6iajJEXOYrSWUh9F3IRZ28zvxYGuO69VEvtzqQH9wGPAGhL7GcvHC0FGTNBklMyhiF79sQpm+9NyIHbO92a83RfRFODvc+4/QEWl1Lc8B2Ga8YayR4qGWWhUbavax+CA7/kPlICPONjMz9iOi1AsIqV9bZMEORkCOwgvHdnVBya0m8OPfzoadUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v60UsJTtNf43jU1F9yTFGdkmBdAM9f3rd9bfl7yaJvA=;
 b=lzZeLG6Dq+343+zWzSBfCXzDkGYaaKS33jWaK2iCnlbqZBG1a6l5N6AcSyQZ8ZIB2q/BbfEMENZFvS7rf+4f1IoZXmTsvumzpBDCakg+oGXsXKkXsWxIwC2k75CYlLqyI9hcmISyHnTy5TSIcZVK3VzDhbnMZboofMROYTiiPis7AHp5lIxMn23ihgTmQM4PMVkedGlKXtGEdgG5+Weu8R9PTPOdfvvsOWn3ziEWFrjog1doYRuEmwcywkyudpFgvse7zerVW+2Hgn27yG6d99q4kTm3gU9ULVTPZm4zAbcbN7GR19cwtK6f6/hejM6QDQwjHvy1cZwToygdTSYTKg==
Received: from PH7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:510:339::10)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 10:23:47 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:339:cafe::1a) by PH7PR03CA0014.outlook.office365.com
 (2603:10b6:510:339::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 10:23:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 10:23:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:23:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:23:28 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:23:21 -0700
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
Subject: [PATCH v3 09/10] rust: pci: add SR-IOV enable and disable callbacks
Date: Wed, 30 Sep 2026 13:18:50 +0300
Message-ID: <d3eb461be2a07e82ae69dac8855b687a2094c20e.1790759932.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dd7282-5e7e-4af8-4a67-08df1edce9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|10067099003|5023799004|56012099006|11063799006|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	DUmRL0BTmWjNIbr/XXzjAq/JybaegKzCS9l1r8O+dxh2ke1dhRddqsQxRSU0RfXez4aWe4q4UMVsNpoJLscPvAPt/I5wql66L8ui4UeyeRNbf3KaU8WFNOyTRhki7Sk7Q1u/qr2i0mnbBJEAUN+fnLQCecIP+vbZFcDAp0KCWQPUXwrvZ2lQ36bpv3GksEpwn5LJgQQHvuzKFdY54yp+RDQFlqj8Xh6oOj8mHgXuGxU6+ZwimnvhQsz2QEHi1n4bxG7DOpSNDRPbCiB74L5q+Y31QHkH+8OT4D2DeyTkIVpyWWwX2xpW8m5EsDN55LneuA9teTtddiANtk8VMmNYmohApSfXRDnOL7+twbK6uxT/miz05k8PVmgvp35eUT98Egls7kkZhN2q6lkTMgLpr+ar+H2jsnMIODQXdTQVR2cp8KtmcWpdFzsbIOgNRxXCbBF+Ja4Yzijfcm5vd8XB7XgzEjhPfpA4aNEvbp2LXSm6M4d0F9rd7F6s80X5Pq3dkLUKjj9zrucy/HVtLZwi9wlWIHX8gGfsTzmEyoIp3Y7JJ0ZyPiYpPMLh/uoGMLeVwVWL/7okuW2Soe99VOvZWRMLd07TrLG3icHIDW/x4Ezce+xUW9fszLMxFGtANNLY1w7m45DumhbO8TASZvSb2jSNqCuSEmqiODYKDRFEiT8WbEn8JrcibLlywz4+7z2aC1BHmPWNfYZUiBM+I9noWw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UqUb8M6n3U4vcvgxY2Qq2BSs8JH4Bz4PjyIm0lfHlFLuVMhBhkXbAviUuJhG3L2Fbpth4vmIVQn5mZo+l/vwpwBwGEXUBH9UzAKTLdP0+Fs03dzDrybar5jnGRxoAG74464fRVCV89Fr8YzxwBY+zmZ5xQr4pGamme9cZXqmlX7fUL9yU+C96KOZT2PHN2eV8RznhFieZ8NWfPw/u+0Ch1b11xbcm1qpZmBItH3O/YlbVTfXQqw5GxauJ8bR3S2iaacFhxwNfs3NYcPu7t1rJMMNIIZ7/zyXyMXMQ7813aNGm6YCHhUXqstOrXtO3F7RgObw+7m1KMKkvaO1lJqgbY/W3Q5Hf7p5TXM0f2TkIufd2+EAhGtERO9l6luoEzLhaIy7pr4+a5GP6Mg5+bcgD+kx41iW9tpeWOtVYikKh+SxewArBvz4bkfAquLvpdvw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:23:47.1347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dd7282-5e7e-4af8-4a67-08df1edce9aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

From: Peter Colberg <peter@colberg.org>

Allow Rust PCI drivers to configure SR-IOV through sriov_numvfs.
Split the C configure callback into sriov_enable() and sriov_disable(),
passing pinned driver data and a token for the requested operation.
Require drivers to implement both callbacks together.

Return the enabled guard's VF count on success and disarm its rollback.
On a disable request, verify that the driver has removed all VFs before
reporting success. VfRegistration handles VF removal during PF teardown;
these callbacks only handle explicit configuration requests.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs     | 83 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/pci/iov.rs | 62 +++++++++++++++++++++++++++----
 2 files changed, 137 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8a87e2202a2c..87d2e637d902 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -87,12 +87,22 @@ unsafe fn register(
         name: &'static CStr,
         module: &'static ThisModule,
     ) -> Result {
+        #[cfg(CONFIG_PCI_IOV)]
+        build_assert!(
+            T::HAS_SRIOV_ENABLE == T::HAS_SRIOV_DISABLE,
+            "PCI drivers must implement both sriov_enable and sriov_disable"
+        );
+
         // SAFETY: It's safe to set the fields of `struct pci_driver` on initialization.
         unsafe {
             (*pdrv.get()).name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            #[cfg(CONFIG_PCI_IOV)]
+            if T::HAS_SRIOV_ENABLE {
+                (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
+            }
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -344,6 +354,79 @@ fn probe<'bound>(
     fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
+
+    /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
+    ///
+    /// Called when userspace writes a nonzero VF count to `sriov_numvfs`. The token carries the
+    /// requested count and permission to enable VFs on this PF. Return the guard obtained from
+    /// [`SriovEnable::enable()`] after completing setup; dropping it rolls back the enable.
+    ///
+    /// The PF must own a [`VfRegistration`] before enabling VFs. That registration disables
+    /// SR-IOV when the driver data is destroyed, while resources needed by VF drivers remain live.
+    /// Implement this callback and [`Self::sriov_disable()`] together, or implement neither.
+    ///
+    /// See [PCI Express I/O Virtualization].
+    ///
+    /// [PCI Express I/O Virtualization]: https://docs.kernel.org/PCI/pci-iov-howto.html
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{device::Core, pci, prelude::*};
+    /// # struct Data;
+    /// fn sriov_enable<'callback>(
+    ///     _dev: &pci::Device<Core<'_>>,
+    ///     _this: Pin<&Data>,
+    ///     token: pci::SriovEnable<'callback>,
+    /// ) -> Result<pci::SriovEnabled<'callback>> {
+    ///     let num_vfs = token.num_vfs();
+    ///     let enabled = token.enable(num_vfs)?;
+    ///     // Complete any additional setup before returning the guard.
+    ///     Ok(enabled)
+    /// }
+    /// ```
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_enable<'bound, 'callback>(
+        dev: &'bound Device<device::Core<'_>>,
+        this: Pin<&Self::Data<'bound>>,
+        token: SriovEnable<'callback>,
+    ) -> Result<SriovEnabled<'callback>> {
+        let _ = (dev, this, token);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Disables all VFs of a PF in response to a userspace request.
+    ///
+    /// Called when userspace writes zero to `sriov_numvfs`. Call [`SriovDisable::disable()`]
+    /// while resources used by VF drivers are still available. Returning an error before calling
+    /// it leaves the VFs enabled. Returning success requires that all VFs have been disabled.
+    ///
+    /// This callback is not invoked during PF unbind; [`VfRegistration`] owns that teardown.
+    /// Implement this callback and [`Self::sriov_enable()`] together, or implement neither.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{device::Core, pci, prelude::*};
+    /// # struct Data;
+    /// fn sriov_disable(
+    ///     _dev: &pci::Device<Core<'_>>,
+    ///     _this: Pin<&Data>,
+    ///     token: pci::SriovDisable<'_>,
+    /// ) -> Result {
+    ///     token.disable();
+    ///     Ok(())
+    /// }
+    /// ```
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_disable<'bound>(
+        dev: &'bound Device<device::Core<'_>>,
+        this: Pin<&Self::Data<'bound>>,
+        token: SriovDisable<'_>,
+    ) -> Result {
+        let _ = (dev, this, token);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// The PCI device representation.
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index e608b2f1e70c..9d9bd3ac7025 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -2,12 +2,19 @@
 
 //! Abstractions for PCI Single Root I/O Virtualization (SR-IOV) drivers.
 
-use super::Device;
+use super::{
+    Adapter,
+    Device,
+    Driver, //
+};
 
 use crate::{
     bindings,
     device,
-    error::to_result,
+    error::{
+        from_result,
+        to_result, //
+    },
     prelude::*,
     types::{
         CovariantForLt,
@@ -22,7 +29,6 @@
 impl Device {
     /// Returns `true` if this device is a Physical Function (PF).
     #[inline]
-    #[expect(dead_code)]
     pub(crate) fn is_physfn(&self) -> bool {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         unsafe { (*self.as_raw()).is_physfn() != 0 }
@@ -76,7 +82,7 @@ pub(crate) fn disable_sriov(&self) {
     }
 }
 
-/// Permission to enable VFs during a driver's `sriov_enable()` callback.
+/// Permission to enable VFs during a driver's [`Driver::sriov_enable()`] callback.
 ///
 /// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
 /// to another thread, and its lifetime is restricted to the callback. Enabling VFs consumes it.
@@ -105,7 +111,7 @@ pub fn num_vfs(&self) -> u32 {
     ///
     /// VF drivers can probe before this method returns, so the PF resources they access must
     /// already be initialized. The returned guard disables the VFs if subsequent setup fails.
-    /// Return it from `sriov_enable()` to leave the VFs enabled on callback success.
+    /// Return it from [`Driver::sriov_enable()`] to leave the VFs enabled on callback success.
     pub fn enable(self, num_vfs: u32) -> Result<SriovEnabled<'callback>> {
         if num_vfs == 0 || num_vfs > self.num_vfs {
             return Err(EINVAL);
@@ -126,14 +132,13 @@ pub fn enable(self, num_vfs: u32) -> Result<SriovEnabled<'callback>> {
     }
 }
 
-/// Enabled VFs awaiting successful completion of `sriov_enable()`.
+/// Enabled VFs awaiting successful completion of [`Driver::sriov_enable()`].
 pub struct SriovEnabled<'callback> {
     pdev: Option<&'callback Device<device::CoreInternal<'callback>>>,
     num_vfs: c_int,
 }
 
 impl SriovEnabled<'_> {
-    #[expect(dead_code)]
     fn disarm(mut self) -> c_int {
         self.pdev = None;
         self.num_vfs
@@ -148,7 +153,7 @@ fn drop(&mut self) {
     }
 }
 
-/// Permission to disable VFs during a driver's `sriov_disable()` callback.
+/// Permission to disable VFs during a driver's [`Driver::sriov_disable()`] callback.
 ///
 /// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
 /// to another thread, and its lifetime is restricted to the callback. Dropping the token does
@@ -166,6 +171,47 @@ pub fn disable(self) {
     }
 }
 
+impl<T: Driver> Adapter<T> {
+    pub(super) extern "C" fn sriov_configure_callback(
+        pdev: *mut bindings::pci_dev,
+        nr_virtfn: c_int,
+    ) -> c_int {
+        // SAFETY: The PCI bus only ever calls the sriov_configure callback with a valid pointer to
+        // a `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `sriov_configure_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+
+        // SAFETY: `sriov_configure` is called only after a successful probe and before unbind, so
+        // the stored pointer has type `T::Data<'_>` and remains valid throughout this callback.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+
+        from_result(|| {
+            if !pdev.is_physfn() {
+                return Err(ENODEV);
+            }
+            if nr_virtfn == 0 {
+                T::sriov_disable(pdev, data, SriovDisable { pdev })?;
+                if pdev.num_vf() != 0 {
+                    return Err(EBUSY);
+                }
+                Ok(0)
+            } else {
+                let num_vfs = u16::try_from(nr_virtfn).map_err(|_| EINVAL)?;
+                let enabled = T::sriov_enable(
+                    pdev,
+                    data,
+                    SriovEnable {
+                        pdev,
+                        num_vfs: u32::from(num_vfs),
+                    },
+                )?;
+                Ok(enabled.disarm())
+            }
+        })
+    }
+}
+
 /// Wrapper for VF registration data stored inside a [`VfRegistration`].
 ///
 /// Stores a [`TypeId`] header (derived from `F`) followed by the pinned data,
-- 
2.53.0

