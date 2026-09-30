Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B33D669A;
	Wed, 30 Sep 2026 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763995; cv=fail; b=iGUZXbUrNbFnC7TN4yjD8Sd8QGz5Us4qGfA1M+cgGTQiFRVGWNPRGlYp8s/IXMmclQVo2Gnkk3BsjnrbFJxzqbmCYrFf3x9xhAbqAwPr9qBMH8uDQcR6Tujbt4XyIqjoz/POw+C0svoliuX3KdXpH3ukzvGhiiahsol3KVzn8eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763995; c=relaxed/simple;
	bh=MU5VcI2pEbdtboJXAPu9Y0jkuo46N+0c48Q82YkyPpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfMaMldB/9lH4nMBhsorOKbLgICk/Ccx70nN5IjFLAY6qLQsHjaJzn3CJUd7MsAWy3quErlw8FwNgIi5bs/tjbwJ0TcBsOtJHTYVoV4Zhf9ap77Q4wCkE9WhNzFta8hysXWa4T1l/nOKB4ebr7Aw2xSf7BulVJ8UwfxIRoqXO1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RIHENLGc; arc=fail smtp.client-ip=52.101.61.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RIHENLGc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wC53/OeRVCAL1iPwdG+qDa/an1X0hPR09P9svg6yYmoiXQX2Hb/kfVK4WCE1g/y0uQEMO9Id2Bi1RPFa+ZWD5qAAua4HISMjutZTDorW7ZBaA5p20G/+qm0ZB7cow4dXkQUrHSCZZQApiXHgi+v1AIjDBztn6aXrE2IvlF+fXtnv8wSq/kNE9kCDfh7yipVXW+tnPgapxOOChNYgJevURT4KyTX355twxSthFq8nsEzjwmsMyV2YNFHvWaLc8OyfZZMvaXwZDWb91OBfGmmtyCE4TmgzZHasGDeDsuJWSPJ97C1Acr0gkc1LZE/h+FzPPlzqOSdVOZN2Pvm0wJeR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97Ankq2cVftSuKmffOUB4GjDyODdd5rw3qK372P1Hi0=;
 b=VJYh1nwHW8gkmzcryVx8tBoMwh9Ni4l32gpEX5SRWfHnj9gTQSdj/Qg9k+G2BrQ3UT+kXLc5C21v1VM5qYw6jOA7TEOsC8usus9DELiScKku059mWBFaWu+RiTnJGj/Hjn8hJH6r+ITBgIixlFF4mmnOm5M9/HKhVXC3peQ3W0kfmnFXiskOjDcsTCUDp4sEysPCoXKNnWAvGLn8gbzGPOUerIPcOi6Gesum2A421//3i1plZ2nyYBF2o+6zYBnpN/bV54tqK5k8x82rTgKFFgBn7Dz4D7b+fA8pkuczkCIEBP7jCPTILKcgyE6Y8pkM78VjZ2Go7s6YrD404G1xaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97Ankq2cVftSuKmffOUB4GjDyODdd5rw3qK372P1Hi0=;
 b=RIHENLGcgdlnHnlLVDagtEptdSM7r8hRoJPGH/kL5bKBpSI0lugGwa/Km2BAzNIkCtVNSI/SAcxJtrRPT1WMu5MyoPbg6fdiVrTHuSKE41KlBrPBU+b/65tGTrf8ewGx5wiNpxSXkuhhYD0F8BboE8rxpQt6MVvSsNPseTpgEHytdh/QCXVYwPgCz/SwvKXF5tNOuXjBssSB7kTXRjvfDg6IH93WvwetSpj5Q/ayQ51o5X15+rWji1kEUqxotHLGc9UCBfAXEsfJFJ/q+0UmtLOYQy0uK8+Q3GtGkfii7kYMKEgNF7BLK6VSp6kXIvIum2RysBb1CGD1/H2tgJgj9A==
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:23:44 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::af) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Wed,
 30 Sep 2026 10:23:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:23:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:23:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:23:20 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:23:13 -0700
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
Subject: [PATCH v3 08/10] rust: pci: add SR-IOV enable and disable tokens
Date: Wed, 30 Sep 2026 13:18:49 +0300
Message-ID: <9b092d339961f744c7ded1e4f21911b66c80ecb4.1790759932.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ebd397-cc5e-4083-b467-08df1edce7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6lMV0Kzvzd60jyMH2wgATnDG+L+pdQTH2//aGjZ8w1p0sgp0QbilV3zAp74Vz0+ylEs9v0wGHOQecVGeZV714xb/JodbPW9DVUJ6aAWb6QXbH7eYeZcuVZezcQfXAvoGYPLN5rFFxbPQXHEwPhMgLh+o4kTlTe9ITu0CsJU7mVrn8dsqYwcfq32BaO0AIQydSszjp7a83R7twavXmbNbYgUZQkqh0iNcCHx7g0IW51Cv57HgXDJFQbUn8sZKdgkX+tdcv0UmaFbkit4+p3AYQc/A7S2l8ibHncQJc10pkT199T/ewa0KKjrbPv+s1VIJAp2gINKoHzNLnTnas2jvKKNH4xOVk3ZYRfvcuFjvUsH4N90Yi9nAqzAoiLz4aW7Wrz4N965ctG2BGwDKUO3kgeN1baAGT8yT2PF2d+t5zrPNy0BZLPaXKxASksWVt1VeILX106EtucL/p1of9gcCdPFYY1bnYc5SGRGM6aH239PtVDVfa0naW0RtfBYV6IcFxMW9pPoj/3m/NawDN165cAkYRne3SVdbWeROsjvOXWism4NuU+dC++to1kdCCmtVBtXt3FaxP67uO7sbmFdZOyYNCBGo7GM1IEfHaSLD46LQsnaRl9tm+uVu1ymeOuOvG2u+NwZzHKUb1KFzp1D41ahi5w0BjE34PHveni8q6LrKspq3gZxC+c5WPFvrKEbr97CmfshSLveZ78EKKNq8lA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	29vBkRnwTJTrlZ6wxR8DYSke62Ymf5H2DEb7DoxZ5KoWcPQ6DJQyF91JVmKr7f1mnJzMs7i0WnW/Y1DH5cQR1Z/GmvDb1UHMolG7Pk17NFi4LTK0YSVV7PHrIuOBrvl5hJWanP5/Z9Iv1bulAS/Yl4VLURnS0tsj/50GwgYixNrkhmUdNIATckv/Kzg9Owkj8BjOIALj011vTBCLz4F56m4tPTqLvbJOqWm/qL6eNllWcZEfQNHfNSkG9o5FZPqpcwYXDnYdJBjajc3uyM0kBE3cuwzYgV0Xn+WX92QdDwqoD0UVr17i4aDGSsAL7rFhfAErjPLCKopDAA9kZKiZDReK/i0fMLVsJt0LyBpCh3mP2J2Tpg4R4vbBd2GKHU9sqqWpwDj5jBdOMPqg6yJjc2VVeJzJ7w1vqRY6+H6ktoEjeFkgdlgPMGONf4AxPvQP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:23:44.1802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ebd397-cc5e-4083-b467-08df1edce7ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236

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
 rust/kernel/pci/iov.rs | 92 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8782e9b06e64..8a87e2202a2c 100644
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
index 3411a9101564..e608b2f1e70c 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -47,7 +47,6 @@ pub fn num_vf(&self) -> i32 {
 impl Device<device::CoreInternal<'_>> {
     /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
     /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
-    #[expect(dead_code)]
     pub(crate) fn enable_sriov(&self, nr_virtfn: c_int) -> Result {
         // SAFETY:
         // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
@@ -63,7 +62,6 @@ pub(crate) fn enable_sriov(&self, nr_virtfn: c_int) -> Result {
     }
 
     /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
-    #[expect(dead_code)]
     pub(crate) fn disable_sriov(&self) {
         // SAFETY:
         // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
@@ -78,6 +76,96 @@ pub(crate) fn disable_sriov(&self) {
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
+pub struct SriovEnable<'callback> {
+    pdev: &'callback Device<device::CoreInternal<'callback>>,
+    num_vfs: u32,
+}
+
+impl<'callback> SriovEnable<'callback> {
+    /// Returns the number of VFs requested for this callback.
+    pub fn num_vfs(&self) -> u32 {
+        self.num_vfs
+    }
+
+    /// Enables between one and the requested number of VFs.
+    ///
+    /// VF drivers can probe before this method returns, so the PF resources they access must
+    /// already be initialized. The returned guard disables the VFs if subsequent setup fails.
+    /// Return it from `sriov_enable()` to leave the VFs enabled on callback success.
+    pub fn enable(self, num_vfs: u32) -> Result<SriovEnabled<'callback>> {
+        if num_vfs == 0 || num_vfs > self.num_vfs {
+            return Err(EINVAL);
+        }
+        let num_vfs = c_int::try_from(num_vfs).map_err(|_| EOVERFLOW)?;
+
+        // SAFETY: The PF's driver data and registration remain installed throughout this callback.
+        // The registration owns final VF teardown after the enable guard is disarmed.
+        if unsafe { (*self.pdev.as_raw()).vf_registration_data_rust }.is_null() {
+            return Err(ENODEV);
+        }
+
+        self.pdev.enable_sriov(num_vfs)?;
+        Ok(SriovEnabled {
+            pdev: Some(self.pdev),
+            num_vfs,
+        })
+    }
+}
+
+/// Enabled VFs awaiting successful completion of `sriov_enable()`.
+pub struct SriovEnabled<'callback> {
+    pdev: Option<&'callback Device<device::CoreInternal<'callback>>>,
+    num_vfs: c_int,
+}
+
+impl SriovEnabled<'_> {
+    #[expect(dead_code)]
+    fn disarm(mut self) -> c_int {
+        self.pdev = None;
+        self.num_vfs
+    }
+}
+
+impl Drop for SriovEnabled<'_> {
+    fn drop(&mut self) {
+        if let Some(pdev) = self.pdev.take() {
+            pdev.disable_sriov();
+        }
+    }
+}
+
+/// Permission to disable VFs during a driver's `sriov_disable()` callback.
+///
+/// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
+/// to another thread, and its lifetime is restricted to the callback. Dropping the token does
+/// not disable VFs, allowing the callback to reject a disable request.
+pub struct SriovDisable<'callback> {
+    pdev: &'callback Device<device::CoreInternal<'callback>>,
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

