Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787612D1F77;
	Wed, 30 Sep 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763847; cv=fail; b=BX9EbH+JYkKsei3JxYTQZIKjpLXr+bHYn+SNQuYA3nq3v6xPtOMNda2cDBQ4aMADfhRx4X5DlU3/9pVqx4U6qGqGVfMR1Q4LPoZ0tdD666wAvkq/2QL4TTXmsv7TVPZNODKcaf7p9+/gdWGnJ9TONlb2aeYqJb2Kt+NrIsdP1Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763847; c=relaxed/simple;
	bh=+5tf3oZTGbGwfxDTLLoP7lP/89qvlef8oRm7HWtNhmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrvpC/PW1lj7xCDA4c9+iz14hwaRk/QvfUCg7leqldPHD5aGgUMx5/OUqpdlIStEqhOWvd5TLl7KffI67PKphGdaZuVeE1zGGyocLjCaQeY03eHHmxrH4dHwMvlrSI4sNg5Z9k0QtM4yHWcj3MLHL/6lMLTC6NwzuX1fwvCSgJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=USQpwutI; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="USQpwutI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxbTSP4Px24qJqhZX8e95lQh8EEleeDQL0NXfW9bQirZ23FffVI9E3aH+cvB6tt1jLkNO2Hhnm4/6fPY/MfYCIyDhKYPRVgxcRfz09F3IJ4HgXdUNl42ChBC7+K+q8PaQU7aBPzjrhXfEwWLPg8QNKNtojzdmeMh0D9zmBGk30X9YjvjBys3qDw2CpdyCPy2ycDnF6ZZQFopOJw67BIrCtvqiRcplTARq6rgbwfFRIywhW9/SYpkkF4FkH4JxXEb+So3ChCw1+06ZlFnKZ4LocIagV1HTcZnVSjeeM4r/jvsZSalMQX7fXOrQNtYFSFgnOp99a//RKfApHagk62y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mQhWkhIxYl5tAqc5KYXhodaL8r6D7bI6qNUp36s1Sc=;
 b=iPKC5IW+GJuOgfE4BmmcfdKxA0AN2Xk0FtJvSD5OXZf9XgpET1R9IaaaOn0Q56Dpqm7IykmeC6swEeA4p8BzP4G43XqRT9ch2uN15sIC/YtLnJetbODZyGr8C6mBM2pAU1WmQ8IFV7wvDZc1bsj0aCLyKtE8amqqeNZo2kFv3notsL9AvooTWfcaKu6HCfmtkPmcS0w8MOxE5EK0eWQhKEYge43Wbi9o7y4WmMrzG0LuMybyoGYbstheeguvzPuIaPJdCKHYf6NbGNewH0WNc0jwcCRzvkJWReUszT7MYw2nIoG46H3Th9SfrMew+BMKbeDxhOjlxHIUw1UIXvfQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mQhWkhIxYl5tAqc5KYXhodaL8r6D7bI6qNUp36s1Sc=;
 b=USQpwutIJWGgpaam25B5x/R17Qy0SfP9Jj4ZWcIW61y4qk76lEaDaMsf0IjkzfccQUHEEO21CAzq1XLLfxRos5JOI6CnZraCCpN7EyIDxQ/ib/QLcnj1IXk/tqmaY6BI4PSekV3b/89F5eOTfXWpo4MkgL07hQIgYtTk9WAx7PvdQYUUG7zLnmot/H/TRHwouoM/SUFHtbD4hLAhGFyEaGzyanRtqpTIXmbnArmWNOY4yw5TKoqYqZKW6MAbxOPiRANq/rtX28/0GWj/Iufz4Ei9XMGHa3KHXc7yDneF+ManNxl+eynM06mI0YWkDHeaK5L97Sa5IfNzLSSy6H9lIA==
Received: from SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::34)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 10:23:53 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:41b:cafe::9e) by SJ0P220CA0003.outlook.office365.com
 (2603:10b6:a03:41b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 10:23:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 10:23:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:23:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:23:36 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:23:29 -0700
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
Subject: [PATCH v3 10/10] samples: rust: add Rust SR-IOV VF driver sample
Date: Wed, 30 Sep 2026 13:18:51 +0300
Message-ID: <a50d3eba8fca1ecf094da263a749fa012a512b7f.1790759932.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790705494.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6e07c3-22ea-44fa-bb58-08df1edced78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	szk2eAbhWQNuN4gdekAO1yMOOg8BRIsX62Fszb9nUiknVHOyR4dC0P0vKpNX1TIiXOWxSgMoLeyRhpxerRCW0l/ZuynOHhYWtekY6zKDt04lG+/sHGJWlbEmffidPH25h0B2yQLKBJkyp4wzss/M+Z3VpuijQmry604VESMVTB+DMwFlYRgr03GT0TMfbqZXTFWeCryCmqiJhsm8KbfYaZxMc9kd9LRB5e26VEeWKYMc9CkmZmsCQwKY5IHYiVsqooDpF5s5Ohe5XHE2uLj9IONHgwlPLLXKILmyGgsaamMwMYOy9wm6uvpsKSwHKKt16q2idGkfCkPYQmm7HGQE81nKdFI9Mtp81Z3Jcn0XvVpBatU46fN5oRVZY1aqWF0tqWomJVWi686RwXfQKz9RolViEYFbTNBVRG0BpiQ0cOeFG+BcwzLSUkoFyTIUWzqEGr28R08Wauwklo3KITK5m+DFvn7JtgGPjBcsb46c7qLYykrO6cfDrQkMcEPIWO/T4sdNlspeolAjtNXUv6E9N9J6+NgWmAQGknC6wGItbmCNngS1q2vrc9Cfczo9C+XzkoxiSbvOXClEB+6ZJ2ogPrRsuHcuShXMcQq/wM0w9PYeOgKs9hNvWYZGvPyzWqJ/EmdlK678p6sRNSplVPUuy/xtlksrpNRdEcvUEaxcC+oiDATEh/QvHgg3KQcR6eC3D98ZDx5XdEHJMtuLIsLXdg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PYa4Y/IYjoFzy1AwfgJTYi6ex273d8Tn91yyJHB+XMNqPhN7lIt1TQhhvKGuSvl5r2i/olFNErsyfyJfuwjQ7KVeqbpTNTMmS1Pkc2wzSZP5MstJ0w/FNk+uQ1lqlhMLc0XinVwpW7TI+8RTCTUlX35gVte9nB4ER5rrOJSiQRaAfxOGHxKMVhkavugsv7BoS+tX7rgGG8ROB0K99NCorOhR/gLmn9RNl+O2ZKVHsDRhz6BAA4e7M+CN93ZgefZbU7N7yKSlIO7SrYXiACB2foq7NxSp1niilqYZWpLl0XJbJLAeLzRRobTT4Hv7EtHi/+Dp1pt+joYp0MPYbRQSK8EllEC3QHdD+W9Yv0a5hgDoM+5yA4VMOIfKBi8VwAW/Cgd9/jQmjRZQY0ek59OGVN6vKZ5YgKDRkvnsJYJ/cF0fSAzTuVv5DNcnPW06Zzy+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:23:53.5376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6e07c3-22ea-44fa-bb58-08df1edced78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975

From: Peter Colberg <peter@colberg.org>

Add a new SR-IOV driver sample that demonstrates how to enable and
disable the Single Root I/O Virtualization capability for a PCI device.

The sample may be exercised using QEMU's 82576 (igb) emulation.

Implement the PF and VF as ordinary PCI drivers. Publish pinned PF data
with a mutex-protected counter inline in the PF driver data, then borrow
and invoke it explicitly from VF probe. Register the VF driver first so
it is ready before the PF can enable VFs.

Link: https://www.qemu.org/docs/master/system/devices/igb.html
Signed-off-by: Peter Colberg <peter@colberg.org>
Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 MAINTAINERS                       |   1 +
 samples/rust/Kconfig              |  11 ++
 samples/rust/Makefile             |   1 +
 samples/rust/rust_driver_sriov.rs | 249 ++++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+)
 create mode 100644 samples/rust/rust_driver_sriov.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index f7a513c4ba24..da6c34bc3dcd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21129,6 +21129,7 @@ F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	rust/kernel/pci/
 F:	samples/rust/rust_driver_pci.rs
+F:	samples/rust/rust_driver_sriov.rs
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 31d62533ef25..737670fd68f8 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -128,6 +128,17 @@ config SAMPLE_RUST_DRIVER_PLATFORM
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_SRIOV
+	tristate "SR-IOV Driver"
+	depends on PCI_IOV
+	help
+	  This option builds the Rust SR-IOV driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_sriov.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_USB
 	tristate "USB Driver"
 	depends on USB = y
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b986b681cde5..238a11d5ec39 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
 obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_SRIOV)		+= rust_driver_sriov.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
diff --git a/samples/rust/rust_driver_sriov.rs b/samples/rust/rust_driver_sriov.rs
new file mode 100644
index 000000000000..3f1809d7bc7b
--- /dev/null
+++ b/samples/rust/rust_driver_sriov.rs
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust SR-IOV driver sample based on QEMU's 82576 ([igb]) emulation.
+//!
+//! To make this driver probe, QEMU must be run with `-device igb`.
+//!
+//! Further, enable [vIOMMU] with interrupt remapping using, e.g.,
+//!
+//! `-M q35,accel=kvm,kernel-irqchip=split -device intel-iommu,intremap=on,caching-mode=on`
+//!
+//! and append `intel_iommu=on` to the guest kernel arguments.
+//!
+//! [igb]: https://www.qemu.org/docs/master/system/devices/igb.html
+//! [vIOMMU]: https://wiki.qemu.org/Features/VT-d
+
+use kernel::{
+    device::{
+        Bound,
+        Core, //
+    },
+    driver,
+    new_mutex,
+    pci,
+    prelude::*,
+    sync::{
+        aref::ARef,
+        Mutex, //
+    },
+    types::CovariantForLt,
+    InPlaceModule, //
+};
+
+const PF_DRIVER_NAME: &CStr = c"rust_driver_sriov_pf";
+const VF_DRIVER_NAME: &CStr = c"rust_driver_sriov_vf";
+
+struct SamplePfDriver;
+struct SampleVfDriver;
+
+#[pin_data]
+struct PfApi<'bound> {
+    pdev: &'bound pci::Device<Bound>,
+    #[pin]
+    requests: Mutex<u64>,
+}
+
+type PfApiForLt = CovariantForLt!(PfApi<'_>);
+
+impl PfApi<'_> {
+    fn submit(self: Pin<&Self>, vf: &pci::Device<Bound>) -> Result<u64> {
+        let mut requests = self.requests.lock();
+        let request = (*requests).checked_add(1).ok_or(EOVERFLOW)?;
+        *requests = request;
+        drop(requests);
+
+        dev_info!(
+            self.pdev,
+            "Handle PF request {} from VF devfn {:#x}.\n",
+            request,
+            vf.dev_id()
+        );
+
+        Ok(request)
+    }
+}
+
+#[pin_data(PinnedDrop)]
+struct PfDriverData<'bound> {
+    // Keep the device alive until the registration stops exposing `PfApi::pdev`.
+    #[pin]
+    _registration: pci::VfRegistration<'bound, PfApiForLt>,
+    pdev: ARef<pci::Device>,
+}
+
+#[pin_data(PinnedDrop)]
+struct VfDriverData {
+    pdev: ARef<pci::Device>,
+}
+
+kernel::pci_device_table!(
+    PF_TABLE,
+    <SamplePfDriver as pci::Driver>::IdInfo,
+    [(
+        // E1000_DEV_ID_82576
+        pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10c9),
+        ()
+    )]
+);
+
+kernel::pci_device_table!(
+    VF_TABLE,
+    <SampleVfDriver as pci::Driver>::IdInfo,
+    [(
+        // E1000_DEV_ID_82576_VF
+        pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10ca),
+        ()
+    )]
+);
+
+#[vtable]
+impl pci::Driver for SamplePfDriver {
+    type IdInfo = ();
+    type Data<'bound> = PfDriverData<'bound>;
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PF_TABLE;
+
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        pin_init::pin_init_scope(move || {
+            dev_info!(
+                pdev,
+                "Probe Rust SR-IOV PF sample (PCI ID: {}, 0x{:x}).\n",
+                pdev.vendor_id(),
+                pdev.device_id()
+            );
+
+            pdev.enable_device_mem()?;
+            pdev.set_master();
+
+            Ok(try_pin_init!(PfDriverData {
+                // SAFETY:
+                // - probe has exclusive access to this PF before SR-IOV is enabled;
+                // - the registration is pinned in the PF driver data and dropped before `pdev`;
+                // - no other registration is created for this PF; and
+                // - VFs are enabled only after probe by `sriov_enable`.
+                _registration <- unsafe {
+                    pci::VfRegistration::new(
+                        pdev,
+                        try_pin_init!(PfApi {
+                            pdev,
+                            requests <- new_mutex!(0),
+                        }),
+                    )
+                },
+                pdev: pdev.into(),
+            }))
+        })
+    }
+
+    fn sriov_enable<'bound, 'callback>(
+        dev: &'bound pci::Device<Core<'_>>,
+        this: Pin<&Self::Data<'bound>>,
+        token: pci::SriovEnable<'callback>,
+    ) -> Result<pci::SriovEnabled<'callback>> {
+        dev_info!(
+            this.pdev,
+            "Enable SR-IOV (PCI ID: {}, 0x{:x}).\n",
+            this.pdev.vendor_id(),
+            this.pdev.device_id()
+        );
+
+        let num_vfs = token.num_vfs();
+        let enabled = token.enable(num_vfs)?;
+        assert_eq!(dev.num_vf() as u32, num_vfs);
+        Ok(enabled)
+    }
+
+    fn sriov_disable<'bound>(
+        dev: &'bound pci::Device<Core<'_>>,
+        this: Pin<&Self::Data<'bound>>,
+        token: pci::SriovDisable<'_>,
+    ) -> Result {
+        dev_info!(
+            this.pdev,
+            "Disable SR-IOV (PCI ID: {}, 0x{:x}).\n",
+            this.pdev.vendor_id(),
+            this.pdev.device_id()
+        );
+
+        token.disable();
+        assert_eq!(dev.num_vf(), 0);
+        Ok(())
+    }
+}
+
+#[vtable]
+impl pci::Driver for SampleVfDriver {
+    type IdInfo = ();
+    type Data<'bound> = VfDriverData;
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &VF_TABLE;
+
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        pin_init::pin_init_scope(move || {
+            dev_info!(
+                pdev,
+                "Probe Rust SR-IOV VF sample (PCI ID: {}, 0x{:x}).\n",
+                pdev.vendor_id(),
+                pdev.device_id()
+            );
+
+            let pdev_bound: &'bound pci::Device<Bound> = pdev;
+            let pf_api = pdev_bound.vf_registration_data::<PfApiForLt>()?;
+
+            pdev.enable_device_mem()?;
+            pdev.set_master();
+
+            let request = pf_api.submit(pdev)?;
+            dev_info!(pdev, "Submitted request {} through PF data.\n", request);
+
+            Ok(try_pin_init!(VfDriverData { pdev: pdev.into() }))
+        })
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for PfDriverData<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        dev_info!(self.pdev, "Remove Rust SR-IOV PF sample.\n");
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for VfDriverData {
+    fn drop(self: Pin<&mut Self>) {
+        dev_info!(self.pdev, "Remove Rust SR-IOV VF sample.\n");
+    }
+}
+
+#[pin_data]
+struct SampleModule {
+    // Keep the VF driver registered while PF removal tears down its VFs.
+    #[pin]
+    _pf: driver::Registration<pci::Adapter<SamplePfDriver>>,
+    #[pin]
+    _vf: driver::Registration<pci::Adapter<SampleVfDriver>>,
+}
+
+impl InPlaceModule for SampleModule {
+    fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            // The VF driver must be ready before the PF can enable VFs.
+            _vf <- driver::Registration::new(VF_DRIVER_NAME, module),
+            _pf <- driver::Registration::new(PF_DRIVER_NAME, module),
+        })
+    }
+}
+
+module! {
+    type: SampleModule,
+    name: "rust_driver_sriov",
+    authors: ["Peter Colberg"],
+    description: "Rust SR-IOV driver",
+    license: "GPL v2",
+}
-- 
2.53.0

