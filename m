Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750A4AD4CD;
	Thu, 24 Sep 2026 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276887; cv=fail; b=eFNaeBCdpbUwTkttfXZR23sfxq9v/C2bKp6ChgfY2oOgkxVPwGxXxhqB60qYXn+fPkPuCXzd0aIoMv8WyPyV2M5p14kExjpuSESOr1osyFnnC6ij3yQn7tJrGJdENBaaxladQcItHlhaGcpqt/413tY6ESRi5eRMqQuyzVBA0C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276887; c=relaxed/simple;
	bh=wjrza9kDnYzWfXeOgvf53NvPW1mE+LMIbD+2MU3SiJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiA8ifeO+6MqNnP6QeQMpA/q4UP3hkPpOXYPs+hddUyEuhzWQykULIMqzlOdu62ojoaChqgNkSASoRvog1AfH9q6yOchfu59zEVIy7NH34bIluTp3LLt6lqQt0imGBlgOEAkrLbojz5ZkNXv7bvR2Sba0XxibfCB61Uk5C97vh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRIL9shv; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kRIL9shv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP12Ig0Dv8cCOEFy3v3IAEQrz5nMNXN5rdEkBqLeVa0DXFzOENKabjRZqqNCdApLqkXB6iuaXUekiHcQw7SoMduNkuiarsbOEqfFUQFjZ1816Tu8X51mjvpQe2O8cIUrrn4W7yNJYHGZn1gY+vd4vZSvLbisdPEWYbotQtBks6DDzWYLbKVnE5Iw1OwsTvNCzyd4TFKza0LyhET5qOaXymyBg4KC05+pxDk3o5MnEkAOUHgyfjFIKI1AFW8oKPoy3QOR/aBqVyM6JWaNexy7Tt+E3BvCjPJTsD8NtAzsJxh0jnF/Z9QoqRJMeEX5suFy2pbNobntOT4XBkNC29S2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTOy9G26PSLALBjWTjYulrGvyt4/5ZIu4yE+eBaXZkU=;
 b=o7StbCvaFfojv/4Xy++OJFvrZPBmBYb2DeBtO57I3lAjOcUkiVuJCVma1TKj8zHmzb0X0pmrrkNEM0MLPjYg99UhNOvCeDjH5WGHRd+0a6j3Vk80ix7b8+mJ5yqrcBgv+PzrLAGeO6Zat3JDk+8x5KfQE8/tXcZ+WjgmT6kt/l47y5lVq0lkfANdMMeUOueDpvPUUnv75yt+jNi9jia8mCyAnKEfdDx0cKHH5+BycnF97d+M2NWg2GbWvbeaC48nzA7p3mTknHA1O714lP7mmic2MFAUwqJymSWMLhDgWPlLiqJOEC+nZBi82A039Z6XYANFPje+S7jael89zwcKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTOy9G26PSLALBjWTjYulrGvyt4/5ZIu4yE+eBaXZkU=;
 b=kRIL9shvbiXON57yQSbaLddW8R07u75kyX8yIQYI4yWfpNFs8Q53rr93eayn2/O3SDoNWTIwm2cuW0dADDnMdUhrrTEa0CoDpOucl9KQTfPcxO/1KUIUuF9Y1WU7S92Inm6btkF4noJm6GuJ3vmu8d4NbGVUv3oPLk21APY70tT8cklZ21g22BUJ/EuYyHORNBRoGI7p9YHO1UQ7GTDYHZpkUMmJO296lumPrNl25eNDRFTjvc1wZfeBpmZtOmu+Q0FpvrNowP0oTrtMN1BCXUppgiJC/40HNZcHYNxwlPoCYeP7uibTp8pOjKcwWt/sqAI2kHC8+hDuTlwpAUQ8dw==
Received: from DS3P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::18) by
 CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Thu, 24 Sep 2026 19:07:55 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:8:45e:cafe::24) by DS3P221CA0014.outlook.office365.com
 (2603:10b6:8:45e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 19:07:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:07:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:07:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:07:30 -0700
Received: from inno-dell.home (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Thu, 24
 Sep 2026 12:07:21 -0700
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
Subject: [PATCH v2 8/8] samples: rust: add Rust SR-IOV VF driver sample
Date: Thu, 24 Sep 2026 22:05:55 +0300
Message-ID: <20260924190556.1620886-9-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924190556.1620886-1-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 018a6122-499d-451f-3673-08df1a6f22fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003|5023799004|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	hsXQiQNCFBg+tJsIUTwz2qE3suF2Rd2yltTlo4He7OD4y5tYKJFMQ/L0/qtYqsKfhOk2cOXzpuvYZn7tfWzbJtngTDofuov136RvGRtJaBvKJ/6iy0E+QZtobXM+VhgyKmcqxKpasC/mZhKsChAt9Xliyrmd0sYecCgA1GUjZLIz3nPXsC4VGMwZKDWsGnSEmWODOAcJsWB8YTtvNPI69sjN54KlnPkGRbyysmrC4sTuzH23E+1v1ZyualTdlfo6PWmq8DnGV1RxAPjvsfyHEM2NgYKgrlbNTCYRrxkiy5NBbvhis8Vd6XAkFtZ1Rsx4EtYMQlP6K4ZoXJwxHrtlX9ZtwKl978RH+ML4OV28WUpKo9hoM6n0Qe/d6l58nOibwnv4jGMqUMOztKrZ5V1uRFopyTqgQfksqJ7PyQw8qpwlrgdKfwuQzpNbgHtxTfQzMQrK9Nhy5PILtMNKwBMo8Pm4GFVbIrXFkrbMhRLOG5Oc6HindyIVcFdcRClIXXqcYz4qmAGrEJ9Knywy00P7abBDUT8uYIjl9jjxrvCHlNRXDSLpaIlqjLEIvowUqBzAXwOPWFzK/CnuFnHf1v3aeipQENsWhXN6v63wL63AleDQQTRQwp8WtGdNggTYzznO3tYcgts93OSx0pbo6mcfg7kOHWf85XOjoqjVqDWoo/+7psYHuVEEinDW5bCGUvecZzGzcChaja8Wps6DOXMKUw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(5023799004)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WnEVQYsl/r0CbbaQjQPNb1sMozS1zaTMvaN7XcQ5W/y86Hg4G+Rj9O+VLFKTaOG1U/I1NI+DHLeKDnuJx98lA9UP24J/aKR4bI4NYROj5unac87CY0gMvJACglZx5wjcJnRoXYHfx78Eq1QMOc3DKXc7O/eaZF9vJlnBa7L4qMUbak9dtiBWL1mzpSaMJLYOpQZfGFIfdzL+WJqotKiHhIP/GrS2kzKjqsGpgQJIn1Dvr0B0NqGDIvog0TQnH9pjQW3zLi8L+GzVzuMA9VNk8761OpHo9bGHL6RVI1cGUVUGybIcZNdzJnN0sRWBpsCthxg7M8QCzsRqK9UcF5knlUfx4JAZt0AFYS462jsWN86QTivsA6qUw23uouJu3wpMok8MnJP5WjRAohaqqvXTOEDYai0e16EXB0Rtuk13mS/2Qx7/BJx9Y+K9U6jtkivD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:07:53.9176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 018a6122-499d-451f-3673-08df1a6f22fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150

From: Peter Colberg <pcolberg@redhat.com>

Add a new SR-IOV driver sample that demonstrates how to enable and
disable the Single Root I/O Virtualization capability for a PCI device.

The sample may be exercised using QEMU's 82576 (igb) emulation.

Implement the PF and VF as ordinary PCI drivers. Publish pinned PF data
with a mutex-protected counter inline in the PF driver data, then borrow
and invoke it explicitly from VF probe. Register the VF driver first so
it is ready before the PF can enable VFs.

Link: https://www.qemu.org/docs/master/system/devices/igb.html
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 MAINTAINERS                       |   1 +
 samples/rust/Kconfig              |  11 ++
 samples/rust/Makefile             |   1 +
 samples/rust/rust_driver_sriov.rs | 241 ++++++++++++++++++++++++++++++
 4 files changed, 254 insertions(+)
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
index 000000000000..c5fcf4a0c62e
--- /dev/null
+++ b/samples/rust/rust_driver_sriov.rs
@@ -0,0 +1,241 @@
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
+                // - VFs are enabled only after probe by `sriov_configure`.
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
+    fn sriov_configure<'bound>(
+        dev: &'bound pci::Device<Core<'_>>,
+        this: Pin<&Self::Data<'bound>>,
+        nr_virtfn: i32,
+    ) -> Result<i32> {
+        if nr_virtfn == 0 {
+            dev_info!(
+                this.pdev,
+                "Disable SR-IOV (PCI ID: {}, 0x{:x}).\n",
+                this.pdev.vendor_id(),
+                this.pdev.device_id()
+            );
+            dev.disable_sriov();
+        } else {
+            dev_info!(
+                this.pdev,
+                "Enable SR-IOV (PCI ID: {}, 0x{:x}).\n",
+                this.pdev.vendor_id(),
+                this.pdev.device_id()
+            );
+            dev.enable_sriov(nr_virtfn)?;
+        }
+
+        assert_eq!(dev.num_vf(), nr_virtfn);
+        Ok(nr_virtfn)
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

