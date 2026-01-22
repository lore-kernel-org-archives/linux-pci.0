Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6377392C2A;
	Thu, 22 Jan 2026 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115623; cv=fail; b=fRoEZLVzdQdyKKgfv1HZlZ0rvSyCRRHhMEHgvHH7GvgS+IAlbb7uL+mD1I5L6K4NvRFoLNToWylOi5NDGmy6Y6WxUaGNw3NYjFu/t1qJALcEp7PEWPrSY7Ud5dv1tw6msaDj6s/7uCVaKhbZnf3TFeE2HLF1uVioK7cJ6ePFZWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115623; c=relaxed/simple;
	bh=38IuTkEPXPuOy7xAfjGfGmEoZ7L7OoUt2O5K2aXks54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4GcaDmHy16FH8YqRjMmHWmOTFiF6U7NwTsdDdTDPXJ3nJCsejgNTG3QCsNBolcwszvm3Hww7B4VosfJsi8J0kq+dj1iBLFTgSPX3ztqNGL0AABV3mxrOFDWwmuUnUkA4AjIA+7lM5zb9Ub+aFhiL/dDEXQrbzW+5PvQX9vxteM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jYmr3Bu+; arc=fail smtp.client-ip=52.101.52.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jYmr3Bu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpCv9B0QrryOqU1TlRTihqbxd7ROYgHLf5ZBrMMFrGtBBF+OModSM02AyF84zDJO8fHUqY5JMQriQ5JDnbLFDnGtekSYQjCmDJSf+kgZgsrg+szcq4lkwmvsFd/xkCBH9QURPAjBAzWuJEq8oamo0zv4IJafB7fK4fTbMCNRv92+JB/HjKfeHfLoJvMxsmVnakqocw3fgcBbuan60DfLM16Ne6sve6H0NoZ6E2zUB6kE52Ne+ewqeosMW+xNzUncWJh2SLeTPoBkHTgKQuDdgX+h3nuyiK1R9vc5kDG5h/lB8sUCgsmgj9MCx8QtfMns9XmJ1dg/Wqsk+KMgDwM8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsIK77hQFJrLddVsg0DgyO0xQICSpWSe1A5LCoCvd7I=;
 b=AOm4C11Lf7oQX43Ybnb8gdGhbWp9Thqit7hud7a8rzOSefNszqslkIRq+UHwX18pUMGifcTn6//cTGY0Ouolt8TKeXlVrMP8Y4Ad8bIvn4hItiKUGoDU1LIsmxgkP8uxUFKW1FbPddWjqVSt8oSUMY6lckd8/poKRowEUg0cdjtTxadB66UJFCLYCo5sgRoFtHaVQscQt7HYXYz1UJ1DKyQjl60yCSx1JHczktuDq5ALn6hd058CgCsK/tJ2RuRZveOJOcjvQ70vsBCcZA8WgXlOK+baUfYdx+1WyMrOxP2ABmlKMy/PeQs9lXfFWsbRcWl1x2oarPHFJVL0ebChFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsIK77hQFJrLddVsg0DgyO0xQICSpWSe1A5LCoCvd7I=;
 b=jYmr3Bu+RBvVskQ759SKYkhk8OFEHtn8dNG6P2Jqns6lSWHhbhX/Tx6enf54nZKqIwhd8+XfieqI02uYsVqiZUP0/pRF7ART8i2DyJ+/1iPW81iMd4SoFx7JXmmRsPxRt1c6rSG+nvYO/ZPMbzrd+/yqUDEWQLZiEwhN/sbJPNfXLVK+ejxvwyimqM7y1YNGUxz7bEDEEXCd6D20JKR8y43Yo+ndmTP7+TcsBB+I76+gzbnHnc5I6EF0M/3RQul9riWbLcmAO8novhV32spZ9dROUmgjng8CNVH6nxZ2hvHCBsvg/5f3cU0uARFQDc3mCBqNQLKaOtJqMht1L6kaEw==
Received: from BY3PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:217::15)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 21:00:13 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::9f) by BY3PR04CA0010.outlook.office365.com
 (2603:10b6:a03:217::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 21:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 21:00:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 12:42:54 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 12:42:54 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 22
 Jan 2026 12:42:47 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v2 2/2] samples: rust: fwctl: add sample code for fwctl
Date: Thu, 22 Jan 2026 22:42:31 +0200
Message-ID: <20260122204232.15988-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122204232.15988-1-zhiw@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c008297-4ead-4391-11c4-08de59f93c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/AiToN5WXUoUjU5y4C/FZvAtAYnssCZ3IAFcr5xCSRMSGCr+ySutaF7pCYq2?=
 =?us-ascii?Q?JMo0RFlDlO+kHanf01HWtie/vGcKt3uESY6Wa6x2B+GlkP9VQMBFEyTbh3qr?=
 =?us-ascii?Q?RFt5gLeXmFHU+4H0YRNvCVD3XvC758mQIbjCxfGZRD/snzNyUicnFXWPzUSf?=
 =?us-ascii?Q?7duVQiVEDcPB9L18yNh9GbUNKy0DB17rAC3S91iNkNnywodQdtvlHqMbE0N1?=
 =?us-ascii?Q?F6yvx8S68LRigqIxjtn4Ev6tKPCvZSJKYl2d2yPBVsG72NS1+8fKxNmskJ79?=
 =?us-ascii?Q?FW2Nqf8XX8jJMx4H0NbusHYBgfTEkGE3Y5PvHPrN7btYTBMZUKrwvxFmPJt3?=
 =?us-ascii?Q?HVUycqxpUl9NNThCGnLu1Bd1hRm154t1bmBiVTa1kNKtwJC5T+HH3mGPf9nM?=
 =?us-ascii?Q?wAwoBAp1s810tvRB5sBC+uUhg1Vnk48OfqtX6aD0nyW1Lb6sNvILUnGeP3RW?=
 =?us-ascii?Q?ZIArG7kVrrRgapqZ9mkoBwY/uCeKHL7oA5DdumM7F/vLTev0ZjPH6zU4e0cv?=
 =?us-ascii?Q?B7cT2BVb7AdRtY2HJwuM82ORgH7tzCq6WkVecO5Q4OyYwBZUaj2GoodhjGI5?=
 =?us-ascii?Q?MgwSG106hcjj8Gqd580z4qPjxFI9p8/jLAxZ2lHgBIB8TRGaHvwqKReKBNPW?=
 =?us-ascii?Q?PJ9KnqY4J7HnMQKeGlRmW+3vMz05pJ+ZMA+pbymIE4o0MRlOFU+j9WPd85bi?=
 =?us-ascii?Q?Lk4BqVfA4TOIJ3hWW6ZuEiXmmvyUD+RPq7Zu5SVSkM0lJ4gmtZqqSkm0vhdo?=
 =?us-ascii?Q?HGb1/uOfqoOcWuEuTmFIultQvj4dt/ort4+ArANXzyavK2Rxtxsi0YX8EI95?=
 =?us-ascii?Q?TDXEq3LwdVE/IRWibF9FQmpnlKO1qilhern9QDa0XOh67l8M6ebu8Rk+HFhJ?=
 =?us-ascii?Q?IEz1A6Rz57PfgUzrIpENFS+WY2UlHC4HS++e10/k90t0G+b0C79V2bOQHJ0h?=
 =?us-ascii?Q?u5nfAwwzyl1TbFVB8mTEdlwVxjUhsEzdEVeRQCXhDr4mcE61qxhkQ9x3f0C4?=
 =?us-ascii?Q?kOOqhp/r5VtsjUxdtLSUyEJYKwTykfrfdpAanttx62bUnhm/mZbc4IeiouJa?=
 =?us-ascii?Q?sr1QsFg0O23k+QMvO/zsClLg+ZY+Hdi7NBRnfTmDiipnm/VHLIfdHCgG9qn0?=
 =?us-ascii?Q?YkP06foCdqm83xEFWL0+GQnswGZxI6Oh+lJRnbKfbngRW/mjvnCyVeOl4gjP?=
 =?us-ascii?Q?kGwQk4YMxpj4ar94wnWjZ07uctub14WEyreN13OsHYEL2Pp9wn+sNTW6afc3?=
 =?us-ascii?Q?gUGgtW9j7eRn9B6WtdAej5bH12ZxnulctU0UMplALobUYf7KERNEvXIykM0r?=
 =?us-ascii?Q?Q9Z49iaotwQrDQmLGNpetnT+gQc8N1IEeLa02mkhcHJ+Bsay9BfTAH2MqpHS?=
 =?us-ascii?Q?Yn5smXELXO1tnf3blJBAbd6NY+rh6Ea13Rylsr5TXKSll3sFwielTYo3gTvx?=
 =?us-ascii?Q?580Fi5Sr1LOPHyEzeCQruTl4ohT/eIAfRLDQIws4v76FUsTZwfqdJUmJcw6a?=
 =?us-ascii?Q?OEyd5gZhViLtZVWoaveQDDgovKIlIydNg7ZP0w0U3k0V9WYnW9Lk8FkCma2m?=
 =?us-ascii?Q?mRFw1fNrN4tryxnI64Ke73vID8bxQaMCccc8sf64CNZxtUWgLLFSUPrvlfWE?=
 =?us-ascii?Q?1R2BmI+QdT9kqS65eSKEis/Faw7XJHa1UCHDLn4VjuKck78pLHyQxzjdvQSp?=
 =?us-ascii?Q?i3KWrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 21:00:13.0348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c008297-4ead-4391-11c4-08de59f93c9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471

This patch adds a sample Rust driver demonstrating the usage of the fwctl
Rust abstractions. Add sample code for creating a FwCtl device, getting
device info and issuing an RPC.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/Kconfig              |  11 +++
 samples/rust/Makefile             |   1 +
 samples/rust/rust_driver_fwctl.rs | 136 ++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 samples/rust/rust_driver_fwctl.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index c49ab9106345..3d0b223caa89 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -172,6 +172,17 @@ config SAMPLE_RUST_SOC
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_FWCTL
+	tristate "Fwctl Driver"
+	depends on FWCTL
+	help
+	  This option builds the Rust Fwctl driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_fwctl.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 6c0aaa58cccc..6f6030e64727 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_FWCTL)		+= rust_driver_fwctl.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 obj-$(CONFIG_SAMPLE_RUST_SOC)			+= rust_soc.o
 
diff --git a/samples/rust/rust_driver_fwctl.rs b/samples/rust/rust_driver_fwctl.rs
new file mode 100644
index 000000000000..ac5f979fd73b
--- /dev/null
+++ b/samples/rust/rust_driver_fwctl.rs
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust fwctl API test (based on QEMU's `pci-testdev`).
+//!
+//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
+
+use kernel::{
+    bindings,
+    device,
+    device::Core,
+    devres::Devres,
+    fwctl,
+    pci,
+    prelude::*,
+    sync::aref::ARef,
+    types,
+};
+
+struct FwctlSampleUserCtx {
+    _drvdata: u32,
+}
+
+struct FwctlSampleOps;
+
+impl fwctl::Operations for FwctlSampleOps {
+    type UserCtx = FwctlSampleUserCtx;
+
+    const DEVICE_TYPE: fwctl::DeviceType = fwctl::DeviceType::RustFwctlTest;
+
+    fn open(
+        fwctl_uctx: &types::Opaque<bindings::fwctl_uctx>
+    ) -> Result<impl PinInit<Self::UserCtx, Error>, Error> {
+        let dev = fwctl::UserCtx::<Self::UserCtx>::parent_device_from_raw(fwctl_uctx);
+
+        dev_info!(dev, "fwctl test driver: open_uctx()");
+
+        // Return an initializer for the user context.
+        // The framework will initialize this in-place in the C-allocated memory.
+        Ok(try_init!(FwctlSampleUserCtx {
+            _drvdata: 0,
+        }))
+    }
+
+    fn close(uctx: &mut fwctl::UserCtx<FwctlSampleUserCtx>) {
+        let dev = uctx.get_parent_device();
+
+        dev_info!(dev, "fwctl test driver: close_uctx()");
+    }
+
+    fn info(uctx: &mut fwctl::UserCtx<FwctlSampleUserCtx>) -> Result<KVec<u8>, Error> {
+        let dev = uctx.get_parent_device();
+
+        dev_info!(dev, "fwctl test driver: info()");
+
+        let mut infobuf = KVec::<u8>::new();
+        infobuf.push(0xef, GFP_KERNEL)?;
+        infobuf.push(0xbe, GFP_KERNEL)?;
+        infobuf.push(0xad, GFP_KERNEL)?;
+        infobuf.push(0xde, GFP_KERNEL)?;
+
+        Ok(infobuf)
+    }
+
+    fn fw_rpc(
+        uctx: &mut fwctl::UserCtx<FwctlSampleUserCtx>,
+        scope: u32,
+        rpc_in: &mut [u8],
+        _out_len: *mut usize,
+    ) -> Result<Option<KVec<u8>>, Error> {
+        let dev = uctx.get_parent_device();
+
+        dev_info!(dev, "fwctl test driver: fw_rpc() scope {}", scope);
+
+        if rpc_in.len() != 4 {
+            return Err(EINVAL);
+        }
+
+        dev_info!(
+            dev,
+            "fwctl test driver: inbuf len{} bytes[0-3] {:x} {:x} {:x} {:x}",
+            rpc_in.len(),
+            rpc_in[0],
+            rpc_in[1],
+            rpc_in[2],
+            rpc_in[3]
+        );
+
+        let mut outbuf = KVec::<u8>::new();
+        outbuf.push(0xef, GFP_KERNEL)?;
+        outbuf.push(0xbe, GFP_KERNEL)?;
+        outbuf.push(0xad, GFP_KERNEL)?;
+        outbuf.push(0xde, GFP_KERNEL)?;
+
+        Ok(Some(outbuf))
+    }
+}
+
+#[pin_data]
+struct FwctlSampleDriver {
+    pdev: ARef<pci::Device>,
+    #[pin]
+    fwctl: Devres<fwctl::Registration<FwctlSampleOps>>,
+}
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    MODULE_PCI_TABLE,
+    <FwctlSampleDriver as pci::Driver>::IdInfo,
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
+);
+
+impl pci::Driver for FwctlSampleDriver {
+    type IdInfo = ();
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+        dev_info!(pdev.as_ref(), "Probe fwctl test driver");
+
+        // `pdev` is `Device<Core>`, which derefs to `Device<Bound>` during probe.
+        let pdev_bound: &pci::Device<device::Bound> = pdev;
+
+        try_pin_init!(Self {
+            pdev: pdev.into(),
+            fwctl <- fwctl::Registration::<FwctlSampleOps>::new(pdev_bound.as_ref()),
+        })
+    }
+}
+
+kernel::module_pci_driver! {
+    type: FwctlSampleDriver,
+    name: "rust_driver_fwctl",
+    authors: ["Zhi Wang"],
+    description: "Rust fwctl test",
+    license: "GPL v2",
+    imports_ns: ["FWCTL"],
+}
-- 
2.51.0

