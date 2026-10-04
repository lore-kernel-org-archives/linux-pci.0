Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6F43DEA5;
	Sun,  4 Oct 2026 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115744; cv=fail; b=hhX2gsxckKlMKTpeb85hSolU81oIIPMgqHgMw04JJg0Rybr1VAkKs5/X7Pgr+QofH7Im+vPKH8IiCrByliX2ZBlW7WLF1ofF8Gs9xrsbhjmHC2z6HO0QOuPThca0LexYZeK8JAGvtNj+cBj1PlBpnkqTz66Xz9lB+WMZQ6wQUro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115744; c=relaxed/simple;
	bh=nVFzxdDBCotK5FtA95L4O0AgNKICdDHmU1TJ0lSLapo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olxqpVJT29+tc4HaZ6bPPa30XVrCkat35ErsutNCinPKuURMGE575c8Bd+H4LxdmJA+MmiffagJrTbXgdINU96wAQRZg8/OqnRkGhiiQmw0qQXJEOeXVquBhfOOJHQZ2VqxtStUf91OVPNINTV7p04iBRzJIHWK+HcRydtHwBE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P5LSgqmN; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P5LSgqmN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TE82Mb9sYJ1E2uV3/hALXpgEWYoSAQYJaErAB+JZ022dp8Ojj27dGZvgzdbghwcneKmUHKrUMyx2VfgiTc9kzBPnkhd0DQQpGXdEQ2RJhdoarxw1XkJn/v1wGMpowWlyMEBrcvezDK/+F7O6bVJ9paVrayZAsq97r+B7R05euqb/26MIjD1woqr6EkWRZclwnnVydXFbokfzQRRxCeMZXvoNYCchOIlIPBBAwcVf3qYNUSv1PuS687vfOpy4lxMir1/VIE69/GiRe9W0kLc6wWRRAXAGMTDOsqbRR8jNxFFsMgyA4l2Hnmhdq8DHcoW7iB4MLH3ndLogY1onaVI9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cK4auv+JQ+vNWCisawUcgzSosY7BDBrkVV5WUQXSIc=;
 b=Gj+MSSdApyDdwrfoEJYIxBPfHV8InXAV7ajm2SZ46shitwX9rn58yCxJ2PMx4J91T6xCgWx31GkJHoRkndiMyPHUcuY8v0LWfW6NYZSKP5l7fY4GsE/qUIclLu8pO2uuyhUVU3DpWXbha3SO2Ui3/HU9U2bkaS0gh4ZeEc/iLOFINd6L3r7PuJTuUuYv5aYS3ChU571zlEHLN8TS37lDZbY7Y3G8QceWJ4vDkosOIq4z+oJ7rxjpNHV66/lxQ1dcG+6CgekGYJUxLlOPKoKe907qliAN2vt9bYqqrDlHUWsioQdp8tioqLpBTNm77why/g8rRR7a70gskURmKVb5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cK4auv+JQ+vNWCisawUcgzSosY7BDBrkVV5WUQXSIc=;
 b=P5LSgqmN2wQx5afSb8Nnw7mhfg0GbmW9DXjiD267q+eZyE3D90WG16lGm51YWnood0LR0vlXv2csvTvOj87R0ADw3aqTBjNAKlEaHBErorJvJMTQ8FcVnLHXeO3RWTWBe8oc6bHy0ibLdTVdOGt2lfhPDof+qNIr7fF4fYb8zvrGhDWtjwmar7mGj4ooE0/UomyZKlcXunKL6xKnCEgEnpvQ9DDtuYQu3y5tNktn51CqjrUVYGPMIkFUK3TAAf7Uf8HfBM7U3xNkKmXf7srMoWplYZEfD5FGSQWPnObsIy3KZ05IQ9Le7Ks5QS3aP/ypiN7ejfofctNa1uAgyve6lQ==
Received: from BN9PR03CA0435.namprd03.prod.outlook.com (2603:10b6:408:113::20)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Sun, 4 Oct
 2026 12:08:53 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::a4) by BN9PR03CA0435.outlook.office365.com
 (2603:10b6:408:113::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 12:08:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:37 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:08:30 -0700
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
	<alex@shazbot.org>, Peter Colberg <peter@colberg.org>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v4 8/9] rust: pci: add SR-IOV enable and disable callbacks
Date: Sun, 4 Oct 2026 15:07:29 +0300
Message-ID: <20261004120732.1045629-9-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: dae13dda-8af2-4ce5-b456-08df22104253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|18002099003|22082099003|13003099007|11063799006|10067099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	XEBaOM6EQKcVgrFoPSkeIKjhAPhoAeNTx/wYfRKXkPYKdk94gWfg72JLEpi+kwRMkIaiii8NbfIYrgzG9+7SgHzfghU7bQoCAJgoN+lCZs5YDPOsue6q+V4W6b4FMiL2EA/DTX48OLnuh1CZLQ57e/QAnu+lruQxHaq4CQDvq217tqn8QSKWXecRG0gcYP6B6OVxFLXEjDC11ge7p7q9wemOAyF/9vN4HGAvDzNHGrjF60C1M0PtIC9OkLTjE5uCZY8XF/RsMAqycx0MzimXN/c/MDHdClxnrbBx1b8Pz5+ZkZRMExIvF2ItiaOgzWn+1RhhM0uD9kntUZUeDj2YFeuoGkNCete9Cv0Ru5x/Bf9skyGMhvQCXhz5tpCHvOkqbn/2L355kgB/Wme95qEWvD7/pcc4qEn4c5tOksoyU2ajyH95YlhAhRS879IoD3JduG8ZO8btgyJE6/9mOpvumNse7XT4ZjoSw1Yf5BnFYn3czJmYVZmxtdKcqFO+zzI8qf/sM/hMA8v1pjEIPKpzVj0pinX9ht/LUWVMIEQpxBq9vKfiXwZgDrj4tjrH6v3qT6jOLn3+Zy57Cxfq40pNsSeDamAPppDcQ01u7SeIMNmKf5prQaNsUtgBC7AqTkI5RsMNi2L3d6Is53FlERsN70hsLU3WDxSMI8hA+skGWPSgUSZHHEv9hKwQVHAL0j4P7vtvH8rNAMbnK/xx+fTY2A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(13003099007)(11063799006)(10067099003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ul8AF9wbeisZFM9cXCjktg4y3+dgJ3qqanZYCF+h1zqeRCGfUhMfMm/ikLttPeg2i8txqKhDebA+27gi/i1or1xRtGyin0GlupvGkHUUoE9wyKI0UOn75CCNkyzGThbaAoWIvc+n6iiGM+jLXP02T9YV7wZsjxjTcFfyirW1QNkvDgEUrE9CHyiXYZyADtyl0D/PdBsmqLmgvtYtuGqwWuP9n+Dxfqru2rc92FZrv9gie177m4Hft3imUyugHMNJRQzeQe3UOy44c4MlX+1SoCUE0Hwi4TQVFlD2YWV3BlsGgjPtcgXy+UT9aqpHedash/zsSfjaCi/98/S3f7UgoeY3IfknHdUHmnOp3+Iv9IK3/lbXGao8U5/RN+hCbrRqa0QmdbyTphAp/Gy/BDxBuZApTIsxEfRi1VcaNeSDvVsMIcuEfw1J4SOealqIAoAd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:53.5669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae13dda-8af2-4ce5-b456-08df22104253
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523

From: Peter Colberg <peter@colberg.org>

Allow Rust PCI drivers to configure SR-IOV through sriov_numvfs.
Split the C configure callback into sriov_enable() and sriov_disable(),
passing pinned driver data and a token for the requested operation.
Require drivers to implement both callbacks together.

Return the enabled guard's VF count on success and disarm its rollback.
On a disable request, verify that the driver has removed all VFs before
reporting success. VfRegistration handles VF removal during PF teardown;
these callbacks only handle explicit configuration requests.

The PCI core invokes sriov_configure only through the PF-only
sriov_numvfs sysfs attribute, so no extra PF role check is needed.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs     | 91 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/pci/iov.rs | 51 +++++++++++++++++++----
 2 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7486c5179965..f4f92d79bac4 100644
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
@@ -341,6 +351,87 @@ fn probe<'bound>(
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
+    /// # use kernel::{
+    /// #     device::Core,
+    /// #     pci,
+    /// #     prelude::*, //
+    /// # };
+    /// # struct Data;
+    /// fn sriov_enable<'a>(
+    ///     _dev: &'a pci::Device<Core<'_>>,
+    ///     _data: Pin<&Data>,
+    ///     token: pci::SriovEnable<'a>,
+    /// ) -> Result<pci::SriovEnabled<'a>> {
+    ///     let num_vfs = token.num_vfs();
+    ///     let enabled = token.enable(num_vfs)?;
+    ///     // Complete any additional setup before returning the guard.
+    ///     Ok(enabled)
+    /// }
+    /// ```
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_enable<'a>(
+        dev: &'a Device<device::Core<'_>>,
+        data: Pin<&Self::Data<'a>>,
+        token: SriovEnable<'a>,
+    ) -> Result<SriovEnabled<'a>> {
+        let _ = (dev, data, token);
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
+    /// # use kernel::{
+    /// #     device::Core,
+    /// #     pci,
+    /// #     prelude::*, //
+    /// # };
+    /// # struct Data;
+    /// fn sriov_disable<'a>(
+    ///     _dev: &'a pci::Device<Core<'_>>,
+    ///     _data: Pin<&Data>,
+    ///     token: pci::SriovDisable<'a>,
+    /// ) -> Result {
+    ///     token.disable();
+    ///     Ok(())
+    /// }
+    /// ```
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_disable<'a>(
+        dev: &'a Device<device::Core<'_>>,
+        data: Pin<&Self::Data<'a>>,
+        token: SriovDisable<'a>,
+    ) -> Result {
+        let _ = (dev, data, token);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// The PCI device representation.
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 449f1e9b12fd..24d1770226c3 100644
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
@@ -71,7 +78,7 @@ pub(crate) fn disable_sriov(&self) {
     }
 }
 
-/// Permission to enable VFs during a driver's `sriov_enable()` callback.
+/// Permission to enable VFs during a driver's [`Driver::sriov_enable()`] callback.
 ///
 /// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
 /// to another thread, and its lifetime is restricted to the callback. Enabling VFs consumes it.
@@ -100,7 +107,7 @@ pub fn num_vfs(&self) -> u16 {
     ///
     /// VF drivers can probe before this method returns, so the PF resources they access must
     /// already be initialized. The returned guard disables the VFs if subsequent setup fails.
-    /// Return it from `sriov_enable()` to leave the VFs enabled on callback success.
+    /// Return it from [`Driver::sriov_enable()`] to leave the VFs enabled on callback success.
     pub fn enable(self, num_vfs: u16) -> Result<SriovEnabled<'a>> {
         if num_vfs == 0 || num_vfs > self.num_vfs {
             return Err(EINVAL);
@@ -120,14 +127,13 @@ pub fn enable(self, num_vfs: u16) -> Result<SriovEnabled<'a>> {
     }
 }
 
-/// Enabled VFs awaiting successful completion of `sriov_enable()`.
+/// Enabled VFs awaiting successful completion of [`Driver::sriov_enable()`].
 pub struct SriovEnabled<'a> {
     pdev: &'a Device<device::CoreInternal<'a>>,
     num_vfs: u16,
 }
 
 impl SriovEnabled<'_> {
-    #[expect(dead_code)]
     fn disarm(self) -> u16 {
         ManuallyDrop::new(self).num_vfs
     }
@@ -139,7 +145,7 @@ fn drop(&mut self) {
     }
 }
 
-/// Permission to disable VFs during a driver's `sriov_disable()` callback.
+/// Permission to disable VFs during a driver's [`Driver::sriov_disable()`] callback.
 ///
 /// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
 /// to another thread, and its lifetime is restricted to the callback. Dropping the token does
@@ -157,6 +163,37 @@ pub fn disable(self) {
     }
 }
 
+impl<T: Driver> Adapter<T> {
+    pub(super) extern "C" fn sriov_configure_callback(
+        pdev: *mut bindings::pci_dev,
+        nr_virtfn: c_int,
+    ) -> c_int {
+        // SAFETY: The PCI core calls this through the PF-only `sriov_numvfs` sysfs attribute,
+        // with a valid `struct pci_dev` and while holding the device lock.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `sriov_configure_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+
+        // SAFETY: `sriov_configure` is called only after a successful probe and before unbind, so
+        // the stored pointer has type `T::Data<'_>` and remains valid throughout this callback.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+
+        from_result(|| {
+            if nr_virtfn == 0 {
+                T::sriov_disable(pdev, data, SriovDisable { pdev })?;
+                if pdev.num_vf() != 0 {
+                    return Err(EBUSY);
+                }
+                Ok(0)
+            } else {
+                let num_vfs = u16::try_from(nr_virtfn).map_err(|_| EINVAL)?;
+                let enabled = T::sriov_enable(pdev, data, SriovEnable { pdev, num_vfs })?;
+                Ok(enabled.disarm().into())
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

