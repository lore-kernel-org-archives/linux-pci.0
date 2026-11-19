Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125112;
	b=v77mAaLJiUlvGEreQKPXS2+qrDubcO/B5Oaal3OZHGxCsAp6vkSbKHcsnyo/qn4akC3I
	 e5/5bT40VLuZ4gWduvAWSVgYzNkhqOIoknkm9+SnW0+6vMUDzRdqb2KBWmckJ/y1Ab9aO
	 ifgj2g9kg9EN0DovCYlkW6ybc0w9YmMAd1GSWUKasttcPjI/SBVjHXrfWfR3abszTeT3J
	 /HAmYaNrkXWEA6/QEDzxpJDBZfNi1lm934+7Unj09aFiAXVkrru8FvUGe8Y1ZtaH/9fRw
	 QyqgfgjAeEFws9sgG3m3L+Z/wie6PS2/sGCjo8fvUaxADDexClAK6SinjaTLDsSK9lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125112;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=najjPJf+4WYpzecQ3Zz6cYoTGcIC86x65JuNKj0B3dk=;
	b=xFmS/AeM/PM5Ck0twAC+aQOZ3kqI3NkhqXX79L36eDthEp+CZ+gAibK31umbDZoxC+PL
	 k/NtWqcMXOP3YhopV/kSrDsW6X2xugOVGw/GcbmAdQWkwn1gI8tkRVdzVVpdKNIUOF7LO
	 d/wixhwJbnrn76RE8+j18E7LCjVgmgGppkGe7yTGfZpyz02/C89flPqU1dLPMVTu4MPlK
	 ygNL739q2UlugPwUDpvq9f5yXsfVRQ7j34DqCoX2AQBOFP/WIiJf0ocJlRCrvJOaNcXBk
	 zjkRgbzjQUUwheFVsQ2hN0E4NRpr2F/y8ADpaqQ3NGUkJtT+8PdRULqA+jeO50Gzvtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="KlTdYj/4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F0606A332;
	Thu, 19 Nov 2026 21:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 002F0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KlTdYj/4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF2PS8pPGo0DVkhJTEskOP8yWVTtCgfvXTfPBPHpATkYH4UDtQoj3Sxur1XSJEG22G0xklmOgxJai7MNmodlp+3KzISPjEKQ75wC7P2G7tP6m0MFHpWzpK6UTOAkPhvIf5BeJ2NXB5Qg5ijGDYBjfp0wtUafORcmfNcwRLRCLuIC2zI4BxMm1fAmli1zTcf5Dlp2FYLGhWR2RRH17p8FK1+A8hyOGgy+AFQf2Kl7Dl9WtwtnihQlBGBwigBIV0A05mLw3g2udzW6VuwudawM5FR01+AraVtj434Wjv2QZz5yO3yTADqpy48/nHIV0wO+j6cfvy2XH59rEoNs6095NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=najjPJf+4WYpzecQ3Zz6cYoTGcIC86x65JuNKj0B3dk=;
 b=HvKX+ZJlS+vVdUV1qFCjyo7RyU6/+2fq9mcRMuudN9TnFu2MPD9S9wGm921L7am86m2vH7+Xwq3RhUFS5/QWbvU/Hn7NaHtOy2BI8rS8pAxwnzDZ46KNxDVKvtpwzzaOeaDD1zuWAihRao0dbqdtdxrhWeV00BXhjUqwCthzekZqYyB/pSjj+492qaoARjPiweOxFVVwDJBrotT6MfoTQGxqJpVTh8F6DO1SYVVi5GvIB9LCmIRDWCksSdOfvosemD9DQAlQ07qT99tpioSspzlq9TwgBGPhGU2FSlSrNEahS1+JER0EB4UdhJSlK+eOzJXu7jgrIis8HfzEyfxytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=najjPJf+4WYpzecQ3Zz6cYoTGcIC86x65JuNKj0B3dk=;
 b=KlTdYj/4iKdAyJZuv21UgVM5y9gr+U8nDw9kCCkmOGqwaDFdaJAyl8ENAVhLc6cNkkWTh1NJWA9JFBW387/slOSh7AcI7freQpCN7Rb7HdDqLpgeHx9RqIc3zD+xJwX42DrWzPGFsZuRtp7XK0NFcn3n6+369ZllCwg99s4gKYrnY3jUVzsfRQt/mV+/QrqLQUBB4wFTVRHgcYQDy5Hf15NLFAWE4aAqYlelQb8ZkGXzf3pYlJm2e713xAW0W7io6SK2zeNXDGrExazmlm1GvHGv5N58tGf7daAG/0tpCOTjUHE1WCKz4WAz73HJEBCQMvnowaRNsVILWKD8ujGT5Q==
Received: from SJ0PR03CA0266.namprd03.prod.outlook.com (2603:10b6:a03:3a0::31)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 21:51:45 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::42) by SJ0PR03CA0266.outlook.office365.com
 (2603:10b6:a03:3a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 21:51:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:18 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:15 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: Zhi Wang <zhiw@nvidia.com>, <alex@shazbot.org>, <jgg@nvidia.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <boqun@kernel.org>,
	<daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>,
	<jgg@ziepe.ca>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v3 6/9] rust: vfio: add common VFIO device handling
Date: Thu, 19 Nov 2026 13:50:41 -0800
Message-ID: <20261119215046.2892839-7-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119215046.2892839-1-xinmengs@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: a01ddfce-5025-4db4-bda8-08df46874dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|1800799024|376014|261026121527099003|18002099003|22082099003|6133799003|5023799004|261022105027099003|56012099006|11063799006|261028144727099003|261022075727099003|261102123227099003|10067099003|261021121427099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	CN9xq+044e+GgQ3eG5FjiM4mj28sIDVLX6lYtYS0ENjnpnBNySdsETXOTp3uaj71OmYviLxe+BEP5YEqM1W4jDolt4EQdavCQJI1RMq3+Sc53BqMfMOC01jLpCb1yHTTpV1j4gGh2FyL/5qymhDHBXC/FKowemdXWpd3KrPlx5zqMF0Y1yQ7nksJsHm29nSx/DWtHyhgouWV6UGxQj4az3dMyu8sePDoipR/L80qGLXsPeZNgx6RYPhG9iC7wDp4Nopwg5Lfqe8ngyVdF6SIk/iKNZLg6x1EmMdsdERZITHwOh/70c5JU2/6KJ5jx27HiDjekpWjTDPTEFBmtrIzUK64RZNWPbj80qIc3QjruXrSDlC8hwAmgXDhZZ5OTlwN4vUEllh1/lhbfeh43XGDLxbUn1KF7u8pF0rxpEfwFjXCz6Z5vhypGLBJqdGvrOkReEebzHofj2JS6fc1x9ohMIc81Lyo4XyhzzO0g3DVTxgwZXTm1ffcoJyY9oPXlBXMO4sODACA5ia7gLjwsX1u9/JO7qgGp/xLJRb2Z2pMsavIXv0livKn4Pu6xSsm5jL1QG5x4qWlAR292HjyGGDp6Kx1bgsndJ5+G9/mUNacLe9/f3bYJDaDcvcPnqswDwELpgJuUIq4MlsxcDtKIc3WSR9pgKXZdq8L954XYbrwxhX62bE9JFa5FhM82wQJDpAxhZOWKK9sRvFY1HrEW1N5EA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(1800799024)(376014)(261026121527099003)(18002099003)(22082099003)(6133799003)(5023799004)(261022105027099003)(56012099006)(11063799006)(261028144727099003)(261022075727099003)(261102123227099003)(10067099003)(261021121427099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uoFSJX4zJEC4jLlDdpkrbxIeb0stx8/dK/7P5H8cFB2YS58oIa1BVtdshmIw/ZUIqO8vpgoHKLQcWY52M1CXSs1KYSUDdLgATM+SJJPVdaBnIyyIKAsxI7smMvHcEoNgw1+MtPO4s83ixCnKpnabUliEXvWCd88mYHaW2gsiE6toZPqaf6bOjDZsw1Zjcv0c1Wp2e5CB1l68DK+h56NO1eA9CycmgCCDGf4ullvfXjvAqk77vosp4lNjOT71JwcFp+ezbGEIYi74o9pONMjx0/wbwDDcL3a70Zvyc2YYOxt8e89PbajdZZTOngLdY/jm9C+KHRzluAh1u9lg3esWZqpbzUtub+tI3g9eheMGKRy4kb42SNkSf6/Jjes4caVaCf2sf4F4zkpMDheqxyYkVDbLhtN7wwVc3A0MCeiabuBwx/A7i8T07HtpZcUxqMgg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:45.2202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01ddfce-5025-4db4-bda8-08df46874dfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

From: Zhi Wang <zhiw@nvidia.com>

A VFIO PCI device contains a VFIO device. Expose that relationship in
Rust so common device handling is independent of PCI resources.

Add vfio::DeviceBase, a C VFIO device structure followed by pointers to
callback data, and vfio::Device, its alias for struct vfio_device. The
data is registration data and data kept from the first successful open
until the last close, which can borrow the former. Share reference
counting and callback-data lifetime handling in vfio.

The helpers are unused until the next patch adds the PCI abstraction.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/vfio.rs             | 430 ++++++++++++++++++++++++++++++++
 3 files changed, 434 insertions(+)
 create mode 100644 rust/kernel/vfio.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..a5781bc1ea85 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -93,6 +93,7 @@
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
 #include <linux/usb.h>
+#include <linux/vfio.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
@@ -115,6 +116,7 @@
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
+const unsigned int RUST_CONST_HELPER_VFIO_DEVICE_RESET = VFIO_DEVICE_RESET;
 const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE = GENLMSG_DEFAULT_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557..10a8e7de0d9c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -147,6 +147,8 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+#[cfg(CONFIG_VFIO)]
+pub mod vfio;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/vfio.rs b/rust/kernel/vfio.rs
new file mode 100644
index 000000000000..bc50647a2437
--- /dev/null
+++ b/rust/kernel/vfio.rs
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Virtual Function I/O (VFIO) devices and callback data.
+//!
+//! [`DeviceBase`] combines a C VFIO device structure with the data its callbacks use.
+//! [`Device`] is an alias of it for `struct vfio_device`.
+//!
+//! C header: [`include/linux/vfio.h`](srctree/include/linux/vfio.h)
+
+use crate::{
+    bindings,
+    prelude::*,
+    sync::aref::AlwaysRefCounted,
+    types::{
+        NotThreadSafe,
+        Opaque, //
+    },
+    uaccess::{
+        UserPtr,
+        UserSlice, //
+    }, //
+};
+use core::{
+    cell::UnsafeCell,
+    marker::PhantomData,
+    ptr::NonNull, //
+};
+
+/// Reset the VFIO device.
+pub const DEVICE_RESET: u32 = bindings::VFIO_DEVICE_RESET;
+
+/// The context in which a VFIO device reference is valid.
+///
+/// Callback views can only be borrowed from the corresponding VFIO trampoline.
+/// They cannot be refcounted or shared across threads.
+pub trait DeviceContext: private::Sealed {}
+
+/// A callback context in which VFIO keeps the device open.
+///
+/// Registration data and open data are available throughout such a callback.
+pub trait IoContext: DeviceContext {}
+
+/// An ordinary device reference, without callback-specific operations.
+pub struct Normal;
+
+/// The device is undergoing its exclusive first-open callback.
+pub struct Open;
+
+/// The device is borrowed for a VFIO ioctl callback on the current thread.
+pub struct Ioctl;
+
+/// The device is borrowed for a VFIO read callback on the current thread.
+pub struct Read;
+
+/// The device is borrowed for a VFIO write callback on the current thread.
+pub struct Write;
+
+/// The device is borrowed for a VFIO mmap callback on the current thread.
+pub struct Mmap;
+
+/// The device is borrowed for a VFIO region-info callback on the current thread.
+pub struct GetRegionInfo;
+
+mod private {
+    pub trait Sealed {}
+
+    impl Sealed for super::Normal {}
+    impl Sealed for super::Open {}
+    impl Sealed for super::Write {}
+    impl Sealed for super::Mmap {}
+    impl Sealed for super::Ioctl {}
+    impl Sealed for super::Read {}
+    impl Sealed for super::GetRegionInfo {}
+}
+
+impl DeviceContext for Normal {}
+impl DeviceContext for Open {}
+impl DeviceContext for Write {}
+impl DeviceContext for Mmap {}
+impl DeviceContext for Ioctl {}
+impl DeviceContext for Read {}
+impl DeviceContext for GetRegionInfo {}
+
+impl IoContext for Write {}
+impl IoContext for Mmap {}
+impl IoContext for Ioctl {}
+impl IoContext for Read {}
+impl IoContext for GetRegionInfo {}
+
+/// The data the driver of a [`Device`] shares with its callbacks.
+///
+/// Bus-specific devices take the data types from their own trait.
+pub trait Operations: Sized + Send + Sync + 'static {
+    /// Data owned by the registration and passed to VFIO callbacks.
+    ///
+    /// It can borrow resources of the driver's binding for `'a`. Per-device state lives here.
+    type RegistrationData<'a>: Send + Sync + 'a;
+
+    /// Data shared by callbacks from the first successful open until the last close.
+    ///
+    /// It can borrow the registration data, of lifetime `'data`, for `'a`.
+    type OpenData<'a, 'data: 'a>: Send + Sync + 'a;
+}
+
+/// Maps a C device structure to its embedded VFIO device.
+///
+/// # Safety
+///
+/// Implementations must return the address of the `vfio_device` at the beginning of `Self`,
+/// preserving the input pointer's provenance.
+pub unsafe trait RawDevice {
+    /// Returns the `vfio_device` embedded in `raw`.
+    ///
+    /// # Safety
+    ///
+    /// `raw` must point to an initialized, live `Self`.
+    unsafe fn raw_vfio_device(raw: *mut Self) -> *mut bindings::vfio_device;
+}
+
+// SAFETY: A `vfio_device` is its own VFIO device.
+unsafe impl RawDevice for bindings::vfio_device {
+    unsafe fn raw_vfio_device(raw: *mut Self) -> *mut bindings::vfio_device {
+        raw
+    }
+}
+
+/// Callback data stored after the C device structure.
+///
+/// `R` is the type of the registration data and `O` the type of the open data, both written
+/// with the placeholder lifetime `'static`, because the device has no lifetime to name.
+///
+/// # Invariants
+///
+/// `reg_data` is `None` until a registration publishes its data, and is not changed again. The
+/// data is pinned and remains valid while the device is registered. After unregistration or a
+/// failed registration attempt, the pointer may dangle; its pointee must never again be
+/// accessed through this device.
+/// `open_data` is null outside a successful first open, otherwise it owns a pinned allocation
+/// until the last close. The bus-specific layer drains callbacks before either is released.
+struct CallbackData<R, O> {
+    reg_data: UnsafeCell<Option<NonNull<R>>>,
+    open_data: UnsafeCell<*mut O>,
+}
+
+/// A C VFIO device structure `Raw`, followed by the callback data of the driver `T`.
+///
+/// `raw` is the first field, so the `vfio_device` at the beginning of `Raw` is also at the
+/// beginning of `Self`, as `vfio_alloc_device()` requires.
+///
+/// `R` and `O` are the types of the registration data and the open data of `T`, written with
+/// the placeholder lifetime `'static`. Use the alias [`Device`], which takes both from the
+/// operations trait of `T`.
+///
+/// # Invariants
+///
+/// - `R` and `O` are the registration data and open data types of `T` with all lifetimes
+///   replaced by `'static`. The data stored is only valid as described for `CallbackData`.
+/// - `raw` is initialized and remains alive while borrowed. The reference count of its embedded
+///   `vfio_device` owns the allocation.
+/// - The device is registered with VFIO only after its registration data has been published.
+/// - Callback contexts are borrowed only for the corresponding callback and thread; only
+///   [`Normal`] references can be reference-counted.
+#[repr(C)]
+pub struct DeviceBase<Raw, R, O, T, Ctx: DeviceContext = Normal> {
+    raw: Opaque<Raw>,
+    data: CallbackData<R, O>,
+    _context: PhantomData<(T, Ctx, NotThreadSafe)>,
+}
+
+/// A VFIO device, wrapping `struct vfio_device`.
+pub type Device<T, Ctx = Normal> = DeviceBase<
+    bindings::vfio_device,
+    <T as Operations>::RegistrationData<'static>,
+    <T as Operations>::OpenData<'static, 'static>,
+    T,
+    Ctx,
+>;
+
+#[expect(dead_code)]
+impl<Raw: RawDevice, R, O, T, Ctx: DeviceContext> DeviceBase<Raw, R, O, T, Ctx> {
+    /// Initializes the Rust fields of a newly allocated device.
+    ///
+    /// # Safety
+    ///
+    /// `this` must point to an allocation with the size and alignment of `Self`, whose `raw`
+    /// has been initialized. Nothing else may access the allocation during this call.
+    unsafe fn init(this: *mut Self) {
+        // SAFETY: The caller provides exclusive access to a suitable allocation.
+        unsafe {
+            (&raw mut (*this).data).write(CallbackData {
+                reg_data: UnsafeCell::new(None),
+                open_data: UnsafeCell::new(core::ptr::null_mut()),
+            });
+            (&raw mut (*this)._context).write(PhantomData);
+        }
+    }
+
+    /// Recovers `&Self` from the `vfio_device` VFIO passes to a callback.
+    ///
+    /// # Safety
+    ///
+    /// `vdev` must point to the `vfio_device` at the beginning of a `Self` that remains alive
+    /// for `'a`. The caller must provide the guarantees of `Ctx` throughout the borrow.
+    unsafe fn from_raw_vfio<'a>(vdev: *mut bindings::vfio_device) -> &'a Self {
+        // SAFETY: `Raw` begins with its `vfio_device` and is the first field of `Self`. The
+        // caller guarantees validity and the context.
+        unsafe { &*vdev.cast() }
+    }
+
+    fn as_raw(&self) -> *mut Raw {
+        self.raw.get()
+    }
+
+    fn as_raw_vfio(&self) -> *mut bindings::vfio_device {
+        // SAFETY: By the type invariants, `raw` is initialized and alive.
+        unsafe { Raw::raw_vfio_device(self.as_raw()) }
+    }
+}
+
+#[expect(dead_code)]
+impl<Raw: RawDevice, R, O, T> DeviceBase<Raw, R, O, T> {
+    /// Publishes the registration data passed to callbacks.
+    ///
+    /// Returns [`EBUSY`] if registration data has been published before, so that a device can
+    /// be registered at most once.
+    ///
+    /// # Safety
+    ///
+    /// The caller must serialize calls for this device. `data` must point to pinned data that
+    /// remains valid until the device has been unregistered or, if registration fails, is not
+    /// accessed through this device.
+    unsafe fn publish_registration_data(&self, data: NonNull<R>) -> Result {
+        // SAFETY: The caller serializes publication, and callbacks only read the slot.
+        if unsafe { (*self.data.reg_data.get()).is_some() } {
+            return Err(EBUSY);
+        }
+        // SAFETY: The slot is unpublished, so the device has not been registered and no
+        // callback can read the slot.
+        // INVARIANT: The slot is written once; the caller keeps `data` valid.
+        unsafe { *self.data.reg_data.get() = Some(data) };
+        Ok(())
+    }
+
+    /// Destroys the open data.
+    ///
+    /// # Safety
+    ///
+    /// Call once after a successful [`DeviceBase::open`], with all I/O callbacks drained and
+    /// the next first open excluded. Registration data and the resources the open data borrows
+    /// must remain alive.
+    unsafe fn close(&self) {
+        // SAFETY: The last close exclusively takes the allocation published by `open()`.
+        let raw =
+            unsafe { core::mem::replace(&mut *self.data.open_data.get(), core::ptr::null_mut()) };
+        // SAFETY: The allocation came from `KBox::into_raw()` and is destroyed without moving
+        // it. Lifetimes do not affect its layout.
+        unsafe { drop(KBox::from_raw(raw)) };
+    }
+}
+
+#[expect(dead_code)]
+impl<Raw: RawDevice, R, O, T> DeviceBase<Raw, R, O, T, Open> {
+    /// Creates the open data from the registration data.
+    ///
+    /// The [`Open`] context guarantees an exclusive first open of a registered device, whose
+    /// registration data remains valid until the last close.
+    ///
+    /// # Safety
+    ///
+    /// - No open data may exist.
+    /// - `OD` must be `O`, except for lifetimes.
+    /// - `R` names the registration data with the placeholder lifetime `'static`, and the
+    ///   caller chooses the lifetimes of `OD`; this function cannot tie either to the time the
+    ///   data is valid. `init` must therefore use the registration data parametrically, as a
+    ///   function generic over its lifetimes does: nothing borrowed from it may escape, other
+    ///   than into the returned open data.
+    /// - `init` must not capture references that are only valid for the callback and store
+    ///   them in the open data, which outlives the callback.
+    /// - The open data must be destroyed with [`DeviceBase::close`] at the last close.
+    unsafe fn open<'a, OD, I>(&'a self, init: impl FnOnce(&'a R) -> I) -> Result
+    where
+        I: PinInit<OD, Error>,
+    {
+        // SAFETY: By the type invariants, an `Open` reference only exists for a registered
+        // device, which has published registration data that nothing changes anymore. The
+        // data remains valid until the last close.
+        let reg_data = unsafe { (*self.data.reg_data.get()).unwrap_unchecked().as_ref() };
+
+        // Allocate before calling the driver so allocation failure cannot follow open.
+        let data = KBox::<OD>::new_uninit(GFP_KERNEL)?;
+        let data = data.write_pin_init(init(reg_data))?;
+
+        // SAFETY: Only the owning pointer moves; `close()` drops the allocation in place.
+        let raw = KBox::into_raw(unsafe { Pin::into_inner_unchecked(data) });
+        // SAFETY: The first open is exclusive, and no I/O callback runs before it returns.
+        // The caller guarantees that `OD` and `O` only differ in lifetimes, which do not
+        // affect the layout.
+        // INVARIANT: The allocation is pinned and owned by the slot until `close()`.
+        unsafe { *self.data.open_data.get() = raw.cast::<O>() };
+        Ok(())
+    }
+}
+
+#[expect(dead_code)]
+impl<Raw: RawDevice, R, O, T, Ctx: IoContext> DeviceBase<Raw, R, O, T, Ctx> {
+    /// Returns the registration data and the open data, for an I/O callback.
+    ///
+    /// # Safety
+    ///
+    /// `R` and `O` name the data with the placeholder lifetime `'static`, which is not the time
+    /// the data is valid. The caller must use both parametrically, as a function generic over
+    /// their lifetimes does: nothing borrowed from them may outlive the callback, and nothing
+    /// borrowed for the callback may be stored in them.
+    unsafe fn callback_data(&self) -> (&R, Pin<&O>) {
+        // SAFETY: By the type invariants, an `IoContext` reference only exists during an I/O
+        // callback on an open, registered device. VFIO excludes the last close and
+        // unregistration for its duration, so by the type invariants of `CallbackData` both
+        // slots hold valid data that nothing changes, and the open data is pinned.
+        unsafe {
+            let reg_data = (*self.data.reg_data.get()).unwrap_unchecked();
+            let open_data = *self.data.open_data.get();
+            (reg_data.as_ref(), Pin::new_unchecked(&*open_data))
+        }
+    }
+}
+
+// SAFETY: VFIO uses the embedded class device's refcount to own the full allocation.
+unsafe impl<Raw: RawDevice, R, O, T> AlwaysRefCounted for DeviceBase<Raw, R, O, T> {
+    fn inc_ref(&self) {
+        // SAFETY: A shared reference keeps the initialized VFIO device alive.
+        unsafe { bindings::get_device(&raw mut (*self.as_raw_vfio()).device) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The caller owns a reference, so `obj` points to a live device.
+        let raw = Opaque::cast_into(unsafe { &raw const (*obj.as_ptr()).raw });
+        // SAFETY: `raw` is initialized and alive, as above.
+        let vdev = unsafe { Raw::raw_vfio_device(raw) };
+        // SAFETY: The caller owns the VFIO reference being released.
+        unsafe { bindings::put_device(&raw mut (*vdev).device) };
+    }
+}
+
+// SAFETY: VFIO serializes open/close transitions, and callback data is `Send + Sync`.
+unsafe impl<Raw: RawDevice, R: Send + Sync, O: Send + Sync, T> Send for DeviceBase<Raw, R, O, T> {}
+
+// SAFETY: Shared access only changes the embedded class device's reference count. I/O callbacks
+// share `Sync` data; VFIO excludes them from mutations of `open_data` during first open and
+// last close, and registration data follows the registration lifetime. Mutable C state is
+// managed by the VFIO core.
+unsafe impl<Raw: RawDevice, R: Send + Sync, O: Send + Sync, T> Sync for DeviceBase<Raw, R, O, T> {}
+
+/// Capability buffer supplied by VFIO for a region-info callback.
+pub struct InfoCap<'a> {
+    #[expect(dead_code)]
+    raw: &'a mut bindings::vfio_info_cap,
+}
+
+/// Opaque wrapper around a `char __user *` buffer from a VFIO read or write callback.
+///
+/// Provides bounds-checked copying of kernel data into the user-space buffer.
+///
+/// This type cannot be constructed by driver code — it is only created by the
+/// callback trampoline.
+pub struct UserBuf {
+    ptr: UserPtr,
+    count: usize,
+}
+
+impl UserBuf {
+    /// Returns the buffer length in bytes.
+    pub fn len(&self) -> usize {
+        self.count
+    }
+
+    /// Returns `true` when the buffer is empty.
+    pub fn is_empty(&self) -> bool {
+        self.count == 0
+    }
+
+    /// Limit this callback's transfer to at most `count` bytes.
+    pub fn truncate(&mut self, count: usize) {
+        self.count = self.count.min(count);
+    }
+
+    /// Overwrite the part of `data` that overlaps a completed region read.
+    ///
+    /// `read_offset` is the starting region offset and `read_len` is the number of
+    /// bytes returned by the read. `data_offset` locates `data` within the same region.
+    pub fn write_overlapping(
+        &self,
+        read_offset: u64,
+        read_len: usize,
+        data_offset: u64,
+        data: &[u8],
+    ) -> Result {
+        if read_len > self.len() {
+            return Err(EINVAL);
+        }
+        let read_end = read_offset.checked_add(read_len as u64).ok_or(EOVERFLOW)?;
+        let data_end = data_offset
+            .checked_add(data.len() as u64)
+            .ok_or(EOVERFLOW)?;
+        let start = read_offset.max(data_offset);
+        let end = read_end.min(data_end);
+        if start >= end {
+            return Ok(());
+        }
+
+        // These differences are bounded by `read_len` and `data.len()`.
+        let buf_offset = (start - read_offset) as usize;
+        let data_start = (start - data_offset) as usize;
+        let data_end = (end - data_offset) as usize;
+        self.write_at(buf_offset, &data[data_start..data_end])
+    }
+
+    /// Copy `data` to the user buffer at byte offset `offset`.
+    ///
+    /// Returns [`EFAULT`] if the copy fails, [`EINVAL`] if the write would
+    /// exceed the buffer bounds.
+    fn write_at(&self, offset: usize, data: &[u8]) -> Result {
+        let end = offset.checked_add(data.len()).ok_or(EOVERFLOW)?;
+        if end > self.count {
+            return Err(EINVAL);
+        }
+        let dest = self.ptr.wrapping_byte_add(offset);
+        let mut writer = UserSlice::new(dest, data.len()).writer();
+        writer.write_slice(data)
+    }
+}
-- 
2.43.7

