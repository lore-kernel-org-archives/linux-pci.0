Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A43F9F50;
	Thu, 24 Sep 2026 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276870; cv=fail; b=oN6I6Rvu+JDYBwm5z1LpzKm8Od59DIXgo++ybPSQvtr2JqjSoQp01FgTVdPTUx2vPr0GQ+fWsD6zN6yw0TSBm0oG92MAGVVPWKwu8+QmgnqpMxrgH8lYugvhHwMFFlnQnSRGzmtKSFWlvLYwfTHnQGYWxH1640zXlf5Vrp5VO0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276870; c=relaxed/simple;
	bh=f+ZHcGAe3RPREUx4I86MnJT9JN9iBSYp+SMbF8TPrhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEhQr2JtT4mJXZRoYf1waSyh5i9bDv2cMWEJXzyRwvGBiuhIAyz26vectmaR2QY2vJz5rzTwPsX69N5qYLChQDmxz9UISeEbhvCFuY2UuIBk5E0VGiWvZ8twWEOnMZC1Rc6jmFvgkX2qxULxtlN7BST98u7D8Hffta92DUxYU7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JHKjKwQF; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JHKjKwQF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6pKeYxdN01ql0ETYI5y8eqaeOHJgVPVsAqBgLTM92EJ0e/CBPfG/wcIP2+QS0X33fH1mpZKOS2clSNMzNfUGqbQ2RHs9h1beePThHduEwMilaC6yRI8N/19r4vWApaP/4Y5xrclq9918FAK6ha9IgPjPip1xRWC+MmRbL+j6lpKECuMtHLUsE32ZGlR0iOvAQAieFCIPd32YafvO2R75V5vqf8rGHxrj6PJxvNtxkOu1p8ZLYGU/fNleeNPkKwHe9mTYlxAKuR5D5HMQPgRHHrRIb9WZ/60Bm59kInsX+b10NzpC3M9jZ01HpgBvH5bKMYq5udbas/3ljy8NDJuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEmOlZloYa0Suoqd/BzIhj/o30FzOMwZu17xGA2Hs3o=;
 b=ywLc/CNFOZWzNuce/b2rGwCjKSHrt4lXl+oADn3Dz3sXvdcOBGdS/8KmthULfS4b/a0TobSi+rsQJ/mgMQh/7tBpWe5LU6UmOsTxZVUNsWcrDCjPMwIVTWTvPUUTMTpmNZKt4fsXggFszYfqhu0OBi8zr88Dp8HqoFq+ndRqAYmC+o05yf6+AReBMwVL4q/5nSDqUQXX9asA5Z333Y5aEPPIU7oYN2buNQ4yqbl0PEYzJLbfh7SR+FqPV9o3QSVOZUtc7tSqcwcVffFIcL07T4mMf7nns2FIxXIp9bRWjr8u4qKKKx8+bHTrgYYJ2D/DExdfSnJgX5xgXHRj+e6Pmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEmOlZloYa0Suoqd/BzIhj/o30FzOMwZu17xGA2Hs3o=;
 b=JHKjKwQFAF80WYo9wUdfRcOLMJTqZzFWSCeqZV4sCp+Q9tpg+ACTNVFtqL4BK8y6jsR9ycwaXyaFjMSRrUaekgo1fNkzY+steZeAh6SqDnpDwPM5/TqPnXvZzQNIVVUIqnXYx4EwGeeEyqBWr/OriwVCKaajYBMA0QwXGHsr3d7BBLmPMwaet8fPf08EqNwpOEChxYqIbttekffReJUgC5CVI4p22WqlwbDeMAhF+qO224I7QfNx731wsHDvZic+PD9IFCUpd/5O+n+bzX3lW+NPkUlc/ZnSaPYSNe3KF8SqZ7R1I6LLXLLK4y9qzugI1MRga0qu4jQT2mqUX+JqHw==
Received: from YT3PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::19)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:07:36 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:b01:85:cafe::4) by YT3PR01CA0099.outlook.office365.com
 (2603:10b6:b01:85::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Thu,
 24 Sep 2026 19:07:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:07:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:07:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:07:11 -0700
Received: from inno-dell.home (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Thu, 24
 Sep 2026 12:07:02 -0700
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
	<alex@shazbot.org>, Peter Colberg <pcolberg@redhat.com>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v2 6/8] rust: pci: add bus callback sriov_configure(), to control SR-IOV from sysfs
Date: Thu, 24 Sep 2026 22:05:53 +0300
Message-ID: <20260924190556.1620886-7-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed124f5-a84f-4a27-39a6-08df1a6f1857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|13003099007|6133799003|56012099006|10067099003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	j0gzwaje9MJMbLaaXFzbytc8yJHshTdRSKa52pA5/vv7zkbkAQ08qI60Nqe0VW8wsxbZ910ru+Xmf3JnQrviJXrmWGnmDLCzTmRggDski/3V/6GqoRLPvIA4Et0Yrw5E8q4KcFY4mMOQApXYham9XcNZzE8twUs76xduulnj1T1VOUxJbJsYoYUxHKxESAKvVpzoMlp18HBf/e4p0396QMaT0CtqtaQOj4xDgKmi1L1ln8f43/bTng6dL5bCPcT6EDRJW3zQYEi0fC8SUBI8yXBRoCyz6nri4qnbtGEwjg7a2MiwTPddCsDpCUfJfWBv6kxDgKbG7hQDemYTRpMnB3YGXODhiDhyzoxcqLq36EN8z31XHINRv/1itV6wjuGekezGbpdJTzbCz3B3hPei8UEbu3RJF/wB0BtA8OOsweebWPiqAbjZjnftNzhc65EnJRNelNRwsrJ0V/gUEY85aVQT/npeyJOHXvKeNLRBhXMhXQW3ONP5kH0oML/3LCKIjoHLwQi0sl2NwYV6TVvKVNPIkMvYVUnXMxZ5iOWL2sIfQZkBXYDibMxsS23Ks+fsCyeO3HPaiz2wuLdBLbILLNODq5Dq/jzHGTj7NQyu9kfMV0pWH+f0wxJFbngETbwMIIC4SBT0bWyG6WrTofoh3Y0WkJVx+dULpBrf2Q2ki1Hfqe9j/kHDYSmW2szPNBZgUEg4Fv8yyeTCGCwiY587AQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(13003099007)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pgdKM3lqohMPlJFU5fDX53TQhOlHBi4aRzN5bZTHqHgxhq02h2/vexfojo0+51jv96Vc4/VDg0rFSPXaxFw/Jlw1ketIYiJGadEwIg/dLVg38QYjpYOfk8Msr8wWBXBFNe/ShWF/yUFVbqruzGglxS8NxJApg+hfLGf5KMbpCls7Z0ObHOmuRWZXr5AbMKmnXM+TLd+qOc4/nv6Dc055tvlKzN00pMglOY+daU4zeB7pBq2VVimV0wO9/Rgr+J1zkX6q81rCUqXsV0aosih8fWiOlhjsrL+u0yKBLK0W0jHtAMFOkQrf/XCgzZ8icq8ICAiP0aKAXSFaEUOpMEdJyaXB4NTaAyA7pvZXf2hrZ7tKh71hLrdHlr3ROOyNhm6vqGCP46AHNX6ckLSWy+Ha13jkbmbda/lT5aiMeIevFUc7ooR6tIbDeU38dldu5By3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:07:36.0183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed124f5-a84f-4a27-39a6-08df1a6f1857
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253

From: Peter Colberg <pcolberg@redhat.com>

Add an optional bus callback sriov_configure() to pci::Driver trait,
using the vtable attribute to query if the driver implements the
callback. The callback is invoked when a user-space application
writes the number of VFs to the sysfs file `sriov_numvfs` to
enable SR-IOV, or zero to disable SR-IOV for a PCI device.

Invoke the callback with zero before PF unbind so drivers can release
their SR-IOV resources, including runtime-PM references. Disable any
remaining VFs before releasing the PF driver data.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 65 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index db0554f14afc..cb3ed2207075 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -84,6 +84,10 @@ unsafe fn register(
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            #[cfg(CONFIG_PCI_IOV)]
+            if T::HAS_SRIOV_CONFIGURE {
+                (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
+            }
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -135,7 +139,13 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 
         // Keep PF data installed until all VF remove callbacks have completed.
         #[cfg(CONFIG_PCI_IOV)]
-        pdev.disable_sriov();
+        if pdev.num_vf() != 0 {
+            if T::HAS_SRIOV_CONFIGURE {
+                Self::sriov_configure_callback(pdev.as_raw(), 0);
+                crate::warn_on!(pdev.num_vf() != 0);
+            }
+            pdev.disable_sriov();
+        }
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
@@ -144,6 +154,20 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 
         T::unbind(pdev, data);
     }
+
+    #[cfg(CONFIG_PCI_IOV)]
+    extern "C" fn sriov_configure_callback(
+        pdev: *mut bindings::pci_dev,
+        nr_virtfn: c_int,
+    ) -> c_int {
+        // SAFETY: The PCI bus only ever calls the sriov_configure callback with a valid pointer to
+        // a `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `sriov_configure_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+
+        from_result(|| T::sriov_configure(pdev, nr_virtfn))
+    }
 }
 
 /// Declares a kernel module that exposes a single PCI driver.
@@ -330,6 +354,44 @@ fn probe<'bound>(
     fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
+
+    /// Single Root I/O Virtualization (SR-IOV) configure.
+    ///
+    /// Called when a user-space application enables or disables the SR-IOV capability for a
+    /// [`Device`] by writing the number of Virtual Functions (VF), `nr_virtfn` or zero to the
+    /// sysfs file `sriov_numvfs` for this device. Implementing this callback is optional.
+    ///
+    /// Further, and unlike for a PCI driver written in C, when a PF device with enabled VFs is
+    /// unbound from its bound [`Driver`], the `sriov_configure()` callback is invoked to disable
+    /// SR-IOV before the `unbind()` callback. This guarantees that when a VF device is bound to a
+    /// driver, the underlying PF device is bound to a driver, too.
+    ///
+    /// Upon success, this callback must return the number of VFs that were enabled, or zero if
+    /// SR-IOV was disabled.
+    ///
+    /// See [PCI Express I/O Virtualization].
+    ///
+    /// [PCI Express I/O Virtualization]: https://docs.kernel.org/PCI/pci-iov-howto.html
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{device::Core, pci, prelude::*};
+    /// #[cfg(CONFIG_PCI_IOV)]
+    /// fn sriov_configure(dev: &pci::Device<Core<'_>>, nr_virtfn: i32) -> Result<i32> {
+    ///     if nr_virtfn == 0 {
+    ///         dev.disable_sriov();
+    ///     } else {
+    ///         dev.enable_sriov(nr_virtfn)?;
+    ///     }
+    ///     Ok(nr_virtfn)
+    /// }
+    /// ```
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_configure(dev: &Device<device::Core<'_>>, nr_virtfn: i32) -> Result<i32> {
+        let _ = (dev, nr_virtfn);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// The PCI device representation.
@@ -451,7 +513,6 @@ pub(crate) fn is_virtfn(&self) -> bool {
 
     /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
     #[cfg(CONFIG_PCI_IOV)]
-    #[expect(dead_code)]
     pub(crate) fn num_vf(&self) -> i32 {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         unsafe { bindings::pci_num_vf(self.as_raw()) }
-- 
2.53.0

