Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF663F871B;
	Sun,  4 Oct 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115739; cv=fail; b=HULKEsN8DB/x7iMWlMJX77TtuTIVqCB7gH77wfVmVjTsmhDazAkLRbp4iq1Xy3JkOIJMM/fHWsD1pZtnQTUcdwIXEQfItAY1L8Y2cpp6CLcj5qOAmYoyFIcaMD8n5gYO/NBdwOoEv3rdO1bIT3I3uVXLU4NXmAbFPNhhtFQ4Tuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115739; c=relaxed/simple;
	bh=kg6llyJfQhbpLDLah9TSUXr4Q9WXCg1A+n4M92oEKVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8ewydjFle4we+rPbrhSHDeOmKlNIKteQQv0LfApOdtSIac+mAWddh9Uz1vVLuGPqh+6aGf4pCo7uIuNQQItp5Mn3/eKl14idZMWYiuRVtYPSERUxEFZx9wxV5GC8u8jgmWW9xu9MDDza+Aui7E+USh94yNUQzVeqOkjsE/RVt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+fMEL5r; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+fMEL5r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUx9GI6hjvMsKtPtWf+ynJVpzm+D6KpWyh7lSlvVxrMHi9g6wm3SeK2YtUbcVuTe6Ru3cY038YUDCX4pGqWRl5+R6LTu2w7aqi4audSa8NwBcEZHXbXIIyiVFMuk5GiExbn78hmXivyU4TU6NwzbMGyHJ4wff0yzJ2eOORG9E7VhiQZ6LTbd+3ZpgG43VIJ5Lf/1cqpB4W4s3JDae34ncSf2co1vY0XdlVCOjknJi/q4AftTHKeELuduMzpBzZf1E4PVSE5Xc2mklFm2A5NNhwL8naVzn4kiNISgxuqo7xMXx769c3JmhbEuNgpQoUNB/zRvLk+ejTkRovK4PLJ7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bTqibpC4t0wjvJr92TM/ge7RVWMcyj+K7v8QQ74IJ8=;
 b=ixLntEIp8wHjI1asqhgB0Z3jlsJbChiZRoBM7YbDDzBDabNGMGGYUFW/2WRI1PL22npCWPePOegvdvjEzeWqDe36hSpGlVws9nRs4pJUJfUDKqj0Qxi1bWhanwD/3RUtoXHm0yLOnySfpWXVepgsbTIDP9gJ1L76kVdvbeIyAFKDGtt2Xs5iqsKW80s9VfruBAxSVAWxU0wK1Nd6vOPjM8hN4Si0ozftCDy+LFUye6iQlGJCLV2vYeU2rITDxBySMhr0BvrixkbYA4KoaZd3+UjYHHg8KWnfD6tUY4mxXpxVrByX/D2lQDeUaLEJF443MHBH1ZX1ll3Obqkf6ZHN/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bTqibpC4t0wjvJr92TM/ge7RVWMcyj+K7v8QQ74IJ8=;
 b=I+fMEL5r204X75PRhenBs89UO+RPL5T3AB/vbEl4yHmvpA9lQtZ+saoXUJ3CoUW9xBOI2+tIA+aGUONamJOdfOPlTJ8eY/RPqvF7QKpzQjWYKYGveIDXNGIs7+z3rjWgKTAOeQ0dCj0NZgfRi/kDnv2t2VhPmZJJdvRpILmlFtwmxCbtDY7UL3U5OvyXTMxOhOswpG5v0b3xkK5v2PNWzy0v2nWbZH/BFiehUKYMO06S4LMton12Am8YpioNXeWud4fChX9lLswbEeD25BLOeYH3bnzp2bu/A+QdrUiwFLEQk+BghkhKFiO29Cd71ptFj3Apvpdf58WSeo8qEeb5jA==
Received: from SJ0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:a03:39f::9)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sun, 4 Oct
 2026 12:08:49 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::93) by SJ0PR03CA0214.outlook.office365.com
 (2603:10b6:a03:39f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 12:08:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:30 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:30 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:08:23 -0700
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
Subject: [PATCH v4 7/9] rust: pci: add SR-IOV enable and disable tokens
Date: Sun, 4 Oct 2026 15:07:28 +0300
Message-ID: <20261004120732.1045629-8-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 746be93a-046d-4897-4bf4-08df22103fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|11063799006|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/kRLCg8KcwESZ2jtLoxZeNls86MQjkTqemdrb/4yJq/2PCkGZ6XGJYR9HEe88lCZ+yjHRTL+WLFtxYLuwyK2SQOejVmifFaKdSc5kMYsesy7TwdyhuNGxrT7wjSzk6JvIQ+Ww4p/NVjDuDcecG5PZOYtj2+3fwvO2iYM+CjzO4MtzDNsksVcxzVLHkPqj9D1og45DiptPuw/ek/HXRFdkeMCNeJcIMtdH+SZkwtYGfUwQT6naBositUuITzZ5GzyCIb7MynhC+SYNOs3l+4GbJgkqIVyCM2MBpZVc6steaD28gpcGAxVHuFUv5Ep872fDYe7ihwr7b3pWfdqDMnGvJmzg0Ga3wM5kDrlhd3gID5g/QLZMYK9o1SuVCdxvE5QBgL23oG0KPkwCSvn4a4S8zEW94v3Ciy7W0jVoEbIT94OQit+JWSCaQwOX9rbTTB3xgWl5OnZTRpgnNac4C4egSgjj3IFootoVomhxGWCMA8d0vQSrtNduDrBGtPTWWmxO8+nWRLNcS/V2ouwHIMQM/opXFMjfMNQTtGr+WRG+GHhoDgVLEEp+camDue+NTysugQdt09Ul2yUk6o20G3+o3lVCRV4eakUnf1J6sligb0tYl5ORg395JXh8hhucBMeOiYcQ3zl/VdUO5L9pO0qq6mMKXd9hAs7cRaAdJLxH0MX0dDjhuSUhxBrFHfFvwW//XqsnMB618kNcI+hkGY8Ig==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xrNJUC4oZtxm/eCWrf2xqZ7X0Rf4f4cQ+kR853EsjFT61KXXJRZ28JMpvQpi+trLn0/JoZ//X3u9qTI6Jxb5EHPgyV14FkXrb7UImGVjNCPX+2OJrFMAvhGAj6ve08WrxWrbeqlHUOfjuyK+lDlML+j2W0eUQuoBRnCj6XHzauTy8q3nDKaqG0LGx6s8KJoE9TR3l/419K00wmMwhymeGHypwvhaoW46UsCIjrQkTELraXjhuQF8tPGrMH62ddKz5zK268B298yhc9x6D4VDY8US0shBDrRbhIqQyaWLjuQacKNec+enMKSvGFLDhjevdCEZQcQoEwMU4tMcbqDmmCFf045SGz1hZJXuEWclWEqxtwl5T8sThn9vuOwqKpaX6WAXtd6RT1DZj6hB+vtz0q0926C8Ffa2uODUJJ46230IiFuyGsyxWfz+hgdEBsNz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:49.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746be93a-046d-4897-4bf4-08df22103fbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

Enabling VFs can succeed before the driver's remaining setup fails.
Use a callback-scoped token to return an enabled guard that disables
SR-IOV when dropped, rolling back those VFs on a later error.

Add SriovEnable, SriovEnabled and SriovDisable for the split callbacks
introduced next. Tie each token to its PF and callback lifetime, and
limit the enabled count to the user's request. The PCI adapter disarms
the guard when accepting a successful enable callback.

Require a VfRegistration to own final VF teardown after that handoff.
Drivers that do not share data with VFs can register (). A disable
token permits explicit shutdown without forcing it on a rejected
request.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs     |  7 +++-
 rust/kernel/pci/iov.rs | 91 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 57752731793f..7486c5179965 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -52,7 +52,12 @@
     Normal, //
 };
 #[cfg(CONFIG_PCI_IOV)]
-pub use self::iov::VfRegistration;
+pub use self::iov::{
+    SriovDisable,
+    SriovEnable,
+    SriovEnabled,
+    VfRegistration, //
+};
 pub use self::irq::{
     IrqType,
     IrqTypes,
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index c61462595141..449f1e9b12fd 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -16,7 +16,8 @@
 };
 use core::{
     any::TypeId,
-    marker::PhantomPinned, //
+    marker::PhantomPinned,
+    mem::ManuallyDrop, //
 };
 
 impl Device {
@@ -41,7 +42,6 @@ pub fn num_vf(&self) -> u16 {
 impl Device<device::CoreInternal<'_>> {
     /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
     /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
-    #[expect(dead_code)]
     pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {
         // SAFETY:
         // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
@@ -57,7 +57,6 @@ pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {
     }
 
     /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
-    #[expect(dead_code)]
     pub(crate) fn disable_sriov(&self) {
         // SAFETY:
         // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
@@ -72,6 +71,92 @@ pub(crate) fn disable_sriov(&self) {
     }
 }
 
+/// Permission to enable VFs during a driver's `sriov_enable()` callback.
+///
+/// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
+/// to another thread, and its lifetime is restricted to the callback. Enabling VFs consumes it.
+///
+/// The callback lifetime cannot be extended:
+///
+/// ```ignore,compile_fail
+/// use kernel::pci::SriovEnable;
+///
+/// fn escape(token: SriovEnable<'_>) -> SriovEnable<'static> {
+///     token
+/// }
+/// ```
+pub struct SriovEnable<'a> {
+    pdev: &'a Device<device::CoreInternal<'a>>,
+    num_vfs: u16,
+}
+
+impl<'a> SriovEnable<'a> {
+    /// Returns the number of VFs requested for this callback.
+    pub fn num_vfs(&self) -> u16 {
+        self.num_vfs
+    }
+
+    /// Enables between one and the requested number of VFs.
+    ///
+    /// VF drivers can probe before this method returns, so the PF resources they access must
+    /// already be initialized. The returned guard disables the VFs if subsequent setup fails.
+    /// Return it from `sriov_enable()` to leave the VFs enabled on callback success.
+    pub fn enable(self, num_vfs: u16) -> Result<SriovEnabled<'a>> {
+        if num_vfs == 0 || num_vfs > self.num_vfs {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The PF's driver data and registration remain installed throughout this callback.
+        // The registration owns final VF teardown after the enable guard is disarmed.
+        if unsafe { (*self.pdev.as_raw()).vf_registration_data_rust }.is_null() {
+            return Err(ENODEV);
+        }
+
+        self.pdev.enable_sriov(num_vfs)?;
+        Ok(SriovEnabled {
+            pdev: self.pdev,
+            num_vfs,
+        })
+    }
+}
+
+/// Enabled VFs awaiting successful completion of `sriov_enable()`.
+pub struct SriovEnabled<'a> {
+    pdev: &'a Device<device::CoreInternal<'a>>,
+    num_vfs: u16,
+}
+
+impl SriovEnabled<'_> {
+    #[expect(dead_code)]
+    fn disarm(self) -> u16 {
+        ManuallyDrop::new(self).num_vfs
+    }
+}
+
+impl Drop for SriovEnabled<'_> {
+    fn drop(&mut self) {
+        self.pdev.disable_sriov();
+    }
+}
+
+/// Permission to disable VFs during a driver's `sriov_disable()` callback.
+///
+/// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
+/// to another thread, and its lifetime is restricted to the callback. Dropping the token does
+/// not disable VFs, allowing the callback to reject a disable request.
+pub struct SriovDisable<'a> {
+    pdev: &'a Device<device::CoreInternal<'a>>,
+}
+
+impl SriovDisable<'_> {
+    /// Disables all VFs and waits for their drivers to unbind.
+    ///
+    /// The PF resources used by VF drivers must remain available until this method returns.
+    pub fn disable(self) {
+        self.pdev.disable_sriov();
+    }
+}
+
 /// Wrapper for VF registration data stored inside a [`VfRegistration`].
 ///
 /// Stores a [`TypeId`] header (derived from `F`) followed by the pinned data,
-- 
2.53.0

