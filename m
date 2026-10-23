Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770093;
	b=U/6F4+DmXWQzdbFY0uNgU1RAJuDofkc5BWrX/oaPbG67uUkZKgtQ2Ijjw2dQuKRBRu55
	 MDPH6ziWZsPNP1Va4JtGfo5mv/ZKFKc88mo5LVKy68b507XRAwiHzTE8/68+d2hEt/1rj
	 6ecdQJnvq9VkfhCKB4Mu6+VnC8Y9JDOjQ1XajEQRsrgRMuKpKxHjyeagvpgP8PbS3zoBr
	 Lp7wXlP8OQ9s2YrnM+sbQeJUm3A5yYSobcHb5vlVNDoeqw7lZM8Bv+iDIUxWma+Pc1I4f
	 pt+frMdw5tqZR4mnwvQi3uc6ksnZ8HzhaMGO1cbtT4ScR6p5qC7WdfYnh2NQzR42ZUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770093;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	bh=C4zbaE/e+GmDcND1huMmVFuYUtPI97y8FYfbdlJVD3Y=;
	b=OBM3IrIrBygjSaqxwyOxD3yaUdshgaMe3eGd4EYyg9g96LbYIRSrKO5bkSCJ3dHV8Dz/
	 6Z28M7GStGBaCNypgtazarvVI7zKxHTA/lsMcdCdO+OWwdIjHftpJ6i87WywdYSAO5nzb
	 S49ZP6l/U8AXElXQ1wghvaPFSfqrtKGLroxRtgj+VgTNZGcf5VoV/60S+U0kiwuBSOJ2z
	 /Nvi4jZYTbGKp7pDZHoB+7Ui0GNScV1UZtw+4muiH/v9AWTJKMkbYDGHh0uT5Vuhh5QQV
	 8sASvOzu71KVjH7H/orSHI9qsNSb6zRHWA2h36oxYFvgW1caooTHqDiqCowvurfwERA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JaVMTmOb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.28
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCFD60A6F77;
	Fri, 23 Oct 2026 15:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDCFD60A6F77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JaVMTmOb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNkc3tJxOSnhC63fmbedk+DFKi7egSIM21mRSHvEWgoc6qd+9dh+v8uP/6yVCkTKsvbywd2qEoOgL2PZJqGLWygeDI1wAdT03oj67Knsc/Hmj9wg8QebvhjbE85BIbdPDciXHd4yFjXRv91N4B2pkjlCllX+KigHQmZ/FW5WXJx0XTyAbRLDyJjVBbJ2vPIlXi2RSsojNgnmN1uxEazUHdsVIJAy1+WwK8rT54SOFX0efO3uF2twFCn2gdmvtYUCao5GQN9Lmq7FtmE9q4yFekVJBG2p95KgOchX0asKr1Kos+uQAXHw9LMegyyfkBAGZbUYMXuMtUk+cETxKdyzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4zbaE/e+GmDcND1huMmVFuYUtPI97y8FYfbdlJVD3Y=;
 b=e6AgKux/Xpq/AJUoXINSV+HH1e/4GGMPlpAwfZlD2+33r/kFRXdZc5fTo6Kxtf5qG391qvIPdSQnhGuOSOboanMlNui/Bic6iB9Xj89vFWrA1mQNor6ezSDLKCGuYFiG5dNlPPyUUzhAdobTVSZHhnpBxE5oOBhNtyJAUx4p0psBD7VonSysJspxdDuIuOex2DhMSeJoMpOSYHGcRs9mm++xWKtRa/pTIJSKpNmkW4P2a70neEAvwKDxYdMR9EOqPupRqS8Dlvj/S51iDnIB+1xwjNxsIyaDqh6Ug5krenmzG7Coi8Bc64sLAUXdDpDFoguqI+WWgI6yoTuEWcsHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4zbaE/e+GmDcND1huMmVFuYUtPI97y8FYfbdlJVD3Y=;
 b=JaVMTmObNoHjLyrW3sUDxIAakAWOIBHHS6QTLCHjpvYfXuBzOcpM4wM1AHsNRd+12Mpkat2m7VajpeUyVV61xUGp8BPBl+tz5Cn04RxFKA7y6I7cpJiHI99gbSPO3vpbXGQS7gH9Ey9bGsp03+aev8d053KQ0hmymQAVrxm7w0wiVCcuG/xKlOPWmYpSHI1XkpfthlOr0M4pBCO2hPfGY+F1Ww0tH62l7201B+kyA0+D3/6l8cWRN+EIpBzHUXtPo/t3It9YY0gcBbMeHHnnZKfCsF5a+d+KPQvjcjLnlre2pdktFqVuTpjr4HZTI3h0FTVePL341avhqeZ6bqTJZA==
Received: from BLAPR03CA0108.namprd03.prod.outlook.com (2603:10b6:208:32a::23)
 by DS5PPF5FAA0E762.namprd12.prod.outlook.com (2603:10b6:f:fc00::651) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 15:41:17 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::80) by BLAPR03CA0108.outlook.office365.com
 (2603:10b6:208:32a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 23 Oct 2026 15:41:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 15:41:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:51 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:50 -0700
From: Simon Song <xinmengs@nvidia.com>
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
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v2 10/12] rust: vfio: separate common device handling from PCI
Date: Fri, 23 Oct 2026 08:40:05 -0700
Message-ID: <20261023154009.2246627-11-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023154009.2246627-1-xinmengs@nvidia.com>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DS5PPF5FAA0E762:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7e5700-9c5c-450f-5011-08df311c13e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|23010399003|10067099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|3023799007|261009223027099003|5023799004|11063799006|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/WueU1G2aHb0sis3Jb16vI0CZ9WQq9ppykHKqFGwJhRtnCEgAUyXG30BKif2VhssIFao5eW+iJdZD5kI/um7V+W5fkVuQ6rWBlSd3Fi+bOX7nIVQt1Mw8I6C2C2l13RPjwgClwJTLT8zrUHmGRVWPS3pBMmLs1y9z5XokqrNNQxuU36N0sDoHWZyWuSw78HmU/jYr/UbzRsqz6MWiPvUPHfVJCWudTKuXPS6rj4BPemLSosMn0MzsyFag+WVoE0ben84GBFuB7bu4ZNBdOPTYa7IN5YZAHzvxYvAsOk3Pf3dBZbhSA7qUpz4/1gxXc2Y8F5wqm1NVeiluJfdVDCtE0akbIcim3Ga+aI2EL0MhYdNcoDaxWoX0hlOzxkz3YbBMmKEb1Zo2dslTXE5J+7Ku9NEa5vvQKlTS2zSkX8co1XOsLrtwANRtQVuQeqiGw7rBk+ytVIrQQBl1bVLbElPHjQpS5vRH7wRNJD1wKJLbjxJejdU7lYRY4yh4hdnAFjpvDCL9tdZkyPwliVSRX+EZZqLWRHX6iP2AuUOuobiiL0PiIiDcL2j6TLobeU2rDYKEFi4/t2SoPQYfkWI4O0De8PLD2mYHf8eKmCg123towYMZJPRybM4Q4wUQwCUVFswVIUYOFIGjmAX7uWWc7aLEC6Nul+vE7Ahp9C8QxgyqO3qOARfdA5MvIavhiHUhi0fed9DZYPhjKtT4SpmXq0bGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(23010399003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(3023799007)(261009223027099003)(5023799004)(11063799006)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HjIEUoYkuFlEbv2SjOW4Bb2HYnjpILQUTBirtTOOKRV4mritu6ktEAvAj51Xi/Fx/vBF2d9Tbbq4Ytt9Kmem0WaWjC9P/jdnoxNnbagVYMPeqq96MpYTJcu6t+3f4qH1oYXOGuKAtL0PZgYteV1KfsaUFCPqP+wXfncYGVdPceCvEaaJxKsjQb6FeUob86g6uTNVzBrKjHUt+JKd6s83e0wLe682JR//2NLrg4JeFVkQbJ0AmNsf0GP/nGaJ6+fU4OdbqOqYFG/AxA2/hYZACsbPu3uJu/SC18aWH3uHFwszDxHEbUC65aCDAlFUxAzZ6cs/gHzisndTxle0Lk9/R7fTBNmBKLHE4H1s0EiiXYfzt6oUlIsCW/RPwEgjB3hgFCrx3FxShbpEYwvR30CJbrl1VX+dMln0ko5bN5qSp6zIoW6A4f7M5P6/OgvwdZsw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:17.1139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7e5700-9c5c-450f-5011-08df311c13e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762

From: Zhi Wang <zhiw@nvidia.com>

A VFIO PCI device contains a VFIO device. Expose that relationship in
Rust so common device handling is independent of PCI resources.

Add vfio::Device and have vfio::pci::Device borrow its embedded device
through AsRef, preserving the callback context. Share reference counting
and callback-data lifetime handling in vfio. Keep driver operations,
allocation, registration and the PCI enable/close sequence in vfio::pci.

No functional change is intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/vfio.rs     | 200 +++++++++++++++++++++++++++++++++++++++-
 rust/kernel/vfio/pci.rs | 199 ++++++++++++---------------------------
 2 files changed, 255 insertions(+), 144 deletions(-)

diff --git a/rust/kernel/vfio.rs b/rust/kernel/vfio.rs
index ed93066e2da..a0bfbc7c59a 100644
--- a/rust/kernel/vfio.rs
+++ b/rust/kernel/vfio.rs
@@ -1,14 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! Virtual Function I/O (VFIO) abstractions.
+//! Virtual Function I/O (VFIO) devices and callback data.
+//!
+//! Bus-specific device types borrow their embedded VFIO device through [`AsRef`].
+//! C header: [`include/linux/vfio.h`](srctree/include/linux/vfio.h)
 
 use crate::{
     bindings,
     prelude::*,
+    sync::aref::AlwaysRefCounted,
+    types::{
+        CovariantForLt,
+        ForLt,
+        NotThreadSafe,
+        Opaque, //
+    },
     uaccess::{
         UserPtr,
         UserSlice, //
-    },
+    }, //
+};
+use core::{
+    cell::UnsafeCell,
+    marker::PhantomData,
+    ptr::NonNull, //
 };
 
 #[cfg(CONFIG_VFIO_PCI_CORE)]
@@ -17,12 +32,187 @@
 /// Reset the VFIO device.
 pub const DEVICE_RESET: u32 = bindings::VFIO_DEVICE_RESET;
 
-/// Reset the PCI slot or bus containing a VFIO device.
-pub const DEVICE_PCI_HOT_RESET: u32 = bindings::VFIO_DEVICE_PCI_HOT_RESET;
+/// The context in which a VFIO device reference is valid.
+///
+/// Callback views can only be borrowed from the corresponding VFIO trampoline.
+/// They cannot be refcounted or shared across threads.
+pub trait DeviceContext: private::Sealed {}
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
+/// A VFIO device, independent of its bus-specific wrapper.
+///
+/// # Invariants
+///
+/// The underlying `vfio_device` is initialized and remains alive while borrowed.
+/// Callback contexts are borrowed only for the corresponding callback and thread;
+/// only [`Normal`] references can be reference-counted.
+#[repr(transparent)]
+pub struct Device<Ctx: DeviceContext = Normal> {
+    raw: Opaque<bindings::vfio_device>,
+    _context: PhantomData<(Ctx, NotThreadSafe)>,
+}
+
+impl<Ctx: DeviceContext> Device<Ctx> {
+    /// # Safety
+    ///
+    /// `raw` must point to an initialized `vfio_device` that remains alive for
+    /// `'a`. The caller must provide the guarantees of `Ctx` throughout the borrow.
+    #[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
+    unsafe fn from_raw<'a>(raw: *mut bindings::vfio_device) -> &'a Self {
+        // SAFETY: Self is a transparent wrapper; the caller guarantees validity and context.
+        unsafe { &*raw.cast() }
+    }
+
+    fn as_raw(&self) -> *mut bindings::vfio_device {
+        self.raw.get()
+    }
+}
+
+// SAFETY: VFIO uses the embedded class device's refcount to own the full allocation.
+unsafe impl AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: A shared reference keeps the initialized VFIO device alive.
+        unsafe { bindings::get_device(&raw mut (*self.as_raw()).device) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The caller owns the VFIO reference being released.
+        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).device) };
+    }
+}
+
+// SAFETY: Ordinary VFIO references expose no unsynchronized callback operations.
+unsafe impl Send for Device {}
+// SAFETY: Shared access only changes the embedded class device's reference count.
+unsafe impl Sync for Device {}
+
+/// Callback data stored after the bus-specific C device structure.
+///
+/// # Invariants
+///
+/// `reg_data` is dangling when unpublished; otherwise it borrows pinned data kept
+/// alive until callback access has ended. `open_data` is null outside a successful
+/// first open, otherwise owns a pinned allocation until the last close.
+/// The bus-specific layer drains callbacks before releasing either allocation.
+struct CallbackData<R: CovariantForLt, O: ForLt> {
+    reg_data: UnsafeCell<NonNull<R::Of<'static>>>,
+    open_data: UnsafeCell<*mut O::Of<'static>>,
+}
+
+#[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
+impl<R: CovariantForLt, O: ForLt> CallbackData<R, O> {
+    fn new() -> Self {
+        Self {
+            reg_data: UnsafeCell::new(NonNull::dangling()),
+            open_data: UnsafeCell::new(core::ptr::null_mut()),
+        }
+    }
+
+    /// Access registration data without allowing its erased lifetime to escape.
+    ///
+    /// # Safety
+    ///
+    /// Registration data must be published and remain valid through this call.
+    /// The caller must exclude concurrent changes to `reg_data`.
+    unsafe fn registration_data_with<V>(&self, f: impl for<'a> FnOnce(&'a R::Of<'a>) -> V) -> V {
+        // SAFETY: The caller keeps registration data alive and excludes mutation.
+        // Covariance permits shortening its erased lifetime to this borrow.
+        let reg_data = unsafe { (*self.reg_data.get()).cast::<R::Of<'_>>().as_ref() };
+        f(reg_data)
+    }
+
+    /// # Safety
+    ///
+    /// The caller must be an I/O callback while VFIO keeps the device open.
+    /// Registration and open data must remain valid, with their pointer slots
+    /// unchanged throughout the call.
+    unsafe fn callback_data_with<V>(
+        &self,
+        f: impl for<'borrow, 'data> FnOnce(&'borrow R::Of<'data>, Pin<&'borrow O::Of<'data>>) -> V,
+    ) -> V {
+        // SAFETY: The caller excludes open/close and unregister while borrowing the data.
+        unsafe {
+            self.registration_data_with(|reg_data| {
+                let ptr = (*self.open_data.get()).cast::<O::Of<'_>>();
+                // The data lifetime stays independent of the callback borrow,
+                // so borrowed OpenData fields cannot be stored back into OpenData.
+                f(reg_data, Pin::new_unchecked(&*ptr))
+            })
+        }
+    }
+
+    /// # Safety
+    ///
+    /// Call only during exclusive first open, with no existing open data.
+    /// All resources borrowed for `'a` must remain valid until `close()` returns.
+    unsafe fn open<'a, I: PinInit<O::Of<'a>, Error>>(&self, init: impl FnOnce() -> I) -> Result {
+        // Allocate before calling the driver so allocation failure cannot follow open.
+        let data = KBox::<O::Of<'a>>::new_uninit(GFP_KERNEL)?;
+        let data = data.write_pin_init(init())?;
+
+        // SAFETY: Only the owning pointer moves; close drops the allocation in place.
+        let raw = KBox::into_raw(unsafe { Pin::into_inner_unchecked(data) });
+        // SAFETY: First open is exclusive; the caller keeps borrowed resources alive
+        // through close. Lifetimes do not affect the allocation's layout.
+        unsafe { *self.open_data.get() = raw.cast::<O::Of<'static>>() };
+        Ok(())
+    }
+
+    /// # Safety
+    ///
+    /// Call once after a successful open, with all callbacks drained and the next
+    /// open excluded. Registration data and borrowed resources must remain alive.
+    unsafe fn close(&self) {
+        // SAFETY: Last close exclusively takes the allocation published by open.
+        let raw = unsafe { core::mem::replace(&mut *self.open_data.get(), core::ptr::null_mut()) };
+        // SAFETY: The allocation came from KBox::into_raw and is destroyed without moving it.
+        unsafe { drop(KBox::from_raw(raw)) };
+    }
+}
 
 /// Capability buffer supplied by VFIO for a region-info callback.
-#[cfg(CONFIG_VFIO_PCI_CORE)]
 pub struct InfoCap<'a> {
+    #[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
     raw: &'a mut bindings::vfio_info_cap,
 }
 
diff --git a/rust/kernel/vfio/pci.rs b/rust/kernel/vfio/pci.rs
index f3e68a3d18c..a27b1a1774c 100644
--- a/rust/kernel/vfio/pci.rs
+++ b/rust/kernel/vfio/pci.rs
@@ -10,9 +10,20 @@
 //! C header: [`include/linux/vfio_pci_core.h`](srctree/include/linux/vfio_pci_core.h)
 
 use super::{
+    CallbackData,
     InfoCap,
     UserBuf, //
 };
+pub use super::{
+    DeviceContext,
+    GetRegionInfo,
+    Ioctl,
+    Mmap,
+    Normal,
+    Open,
+    Read,
+    Write, //
+};
 
 use crate::{
     alloc::allocator::Kmalloc,
@@ -39,61 +50,16 @@
 };
 use core::{
     alloc::Layout,
-    cell::UnsafeCell,
     marker::PhantomData,
     ptr::NonNull, //
 };
 
+/// Reset the PCI slot or bus containing a VFIO device.
+pub const DEVICE_PCI_HOT_RESET: u32 = bindings::VFIO_DEVICE_PCI_HOT_RESET;
+
 /// Index of the PCI configuration-space region.
 pub const CONFIG_REGION_INDEX: u32 = bindings::VFIO_PCI_CONFIG_REGION_INDEX;
 
-/// The context in which a VFIO PCI device reference is valid.
-///
-/// Callback views can only be borrowed from the corresponding VFIO trampoline.
-/// They cannot be refcounted or shared across threads.
-pub trait DeviceContext: private::Sealed {}
-
-/// An ordinary device reference, without callback-specific operations.
-pub struct Normal;
-
-/// The device is enabled but has not yet completed its first-open callback.
-pub struct Open;
-
-/// The device is borrowed for a VFIO ioctl callback on the current thread.
-pub struct Ioctl;
-
-/// The device is borrowed for a VFIO read callback on the current thread.
-pub struct Read;
-
-/// The device is borrowed for a VFIO write callback on the current thread.
-pub struct Write;
-
-/// The device is borrowed for a VFIO mmap callback on the current thread.
-pub struct Mmap;
-
-/// The device is borrowed for a VFIO region-info callback on the current thread.
-pub struct GetRegionInfo;
-
-mod private {
-    pub trait Sealed {}
-
-    impl Sealed for super::Normal {}
-    impl Sealed for super::Open {}
-    impl Sealed for super::Write {}
-    impl Sealed for super::Mmap {}
-    impl Sealed for super::Ioctl {}
-    impl Sealed for super::Read {}
-    impl Sealed for super::GetRegionInfo {}
-}
-
-impl DeviceContext for Normal {}
-impl DeviceContext for Open {}
-impl DeviceContext for Write {}
-impl DeviceContext for Mmap {}
-impl DeviceContext for Ioctl {}
-impl DeviceContext for Read {}
-impl DeviceContext for GetRegionInfo {}
-
 /// The trait for VFIO PCI variant driver implementations.
 ///
 /// Unoverridden callbacks delegate to the corresponding PCI core operation.
@@ -280,20 +246,22 @@ pub fn region_end(&self) -> Result<u64> {
 /// - Callback contexts are only borrowed for the corresponding callback and thread.
 /// - `core_device` was initialized by `vfio_pci_core_init_dev()`.
 /// - The VFIO device refcount owns the allocation lifetime.
-/// - `reg_data` is dangling without an owner or points to a valid
-///   `<T::RegistrationData as ForLt>::Of<'_>` owned by the enclosing [`Registration`].
-/// - `open_data` is null outside a successful open, otherwise it owns a pinned
-///   `KBox<T::OpenData<'_>>` until last close. Only open/close mutate it; VFIO
-///   prevents I/O callbacks from racing those transitions. The data is dropped
-///   before PCI core close and before registration data is freed.
+/// - `data` follows the VFIO registration and first-open/last-close lifetimes.
+///   Open data is destroyed before PCI core close, and registration data is
+///   released after PCI core unregistration has drained callbacks.
 #[repr(C)]
 pub struct Device<T: Operations, Ctx: DeviceContext = Normal> {
     core_device: Opaque<bindings::vfio_pci_core_device>,
-    reg_data: UnsafeCell<NonNull<<T::RegistrationData as ForLt>::Of<'static>>>,
-    open_data: UnsafeCell<*mut T::OpenData<'static>>,
+    data: CallbackData<T::RegistrationData, OpenDataFamily<T>>,
     _context: PhantomData<(Ctx, NotThreadSafe)>,
 }
 
+struct OpenDataFamily<T>(PhantomData<T>);
+
+impl<T: Operations> ForLt for OpenDataFamily<T> {
+    type Of<'a> = T::OpenData<'a>;
+}
+
 impl<T: Operations> Device<T> {
     /// Allocate a VFIO PCI device for subsequent registration.
     pub fn new(pdev: &pci::Device<device::Core<'_>>) -> Result<ARef<Self>> {
@@ -307,6 +275,7 @@ pub fn new_passthrough(pdev: &pci::Device<device::Core<'_>>) -> Result<ARef<Self
 
     fn allocate(pdev: &pci::Device<device::Core<'_>>, passthrough: bool) -> Result<ARef<Self>> {
         const_assert!(core::mem::offset_of!(Self, core_device) == 0);
+        const_assert!(core::mem::offset_of!(bindings::vfio_pci_core_device, vdev) == 0);
         let size = Kmalloc::aligned_layout(Layout::new::<Self>()).size();
 
         // SAFETY: The bound PCI device and static ops are valid. The allocation
@@ -318,8 +287,7 @@ fn allocate(pdev: &pci::Device<device::Core<'_>>, passthrough: bool) -> Result<A
 
         // SAFETY: Initialise the Rust field in the newly allocated device.
         unsafe {
-            (&raw mut (*this.as_ptr()).reg_data).write(UnsafeCell::new(NonNull::dangling()));
-            (&raw mut (*this.as_ptr()).open_data).write(UnsafeCell::new(core::ptr::null_mut()));
+            (&raw mut (*this.as_ptr()).data).write(CallbackData::new());
             (&raw mut (*this.as_ptr())._context).write(PhantomData);
         }
 
@@ -332,50 +300,6 @@ fn allocate(pdev: &pci::Device<device::Core<'_>>, passthrough: bool) -> Result<A
         Ok(unsafe { ARef::from_raw(this) })
     }
 
-    /// Access the registration data through a closure with an HRTB lifetime.
-    ///
-    /// The closure's `for<'a>` bound prevents the caller from smuggling
-    /// references with a concrete short lifetime out of the closure.
-    ///
-    /// # Safety
-    ///
-    /// Registration data must be published and remain valid through this call.
-    unsafe fn registration_data_with<R>(
-        &self,
-        f: impl for<'a> FnOnce(&'a <T::RegistrationData as ForLt>::Of<'a>) -> R,
-    ) -> R {
-        // SAFETY: Registration keeps the allocation and its borrowed resources
-        // alive until unregistration completes. Covariance permits shortening
-        // the erased binding lifetime to this callback's borrow.
-        let reg_data: &<T::RegistrationData as ForLt>::Of<'_> = unsafe {
-            (*self.reg_data.get())
-                .cast::<<T::RegistrationData as ForLt>::Of<'_>>()
-                .as_ref()
-        };
-        f(reg_data)
-    }
-
-    /// # Safety
-    ///
-    /// The caller must be an I/O callback while VFIO keeps the device open.
-    unsafe fn callback_data_with<R>(
-        &self,
-        f: impl for<'borrow, 'data> FnOnce(
-            &'borrow <T::RegistrationData as ForLt>::Of<'data>,
-            Pin<&'borrow T::OpenData<'data>>,
-        ) -> R,
-    ) -> R {
-        // SAFETY: VFIO excludes open/close and unregister while this callback runs.
-        unsafe {
-            self.registration_data_with(|reg_data| {
-                let ptr = (*self.open_data.get()).cast::<T::OpenData<'_>>();
-                // The data lifetime stays independent of the callback borrow,
-                // so borrowed OpenData fields cannot be stored back into OpenData.
-                f(reg_data, Pin::new_unchecked(&*ptr))
-            })
-        }
-    }
-
     /// # Safety
     /// The returned view must only be used during the callback represented by `Ctx`.
     unsafe fn with_context<Ctx: DeviceContext>(&self) -> &Device<T, Ctx> {
@@ -403,7 +327,15 @@ fn core_device(&self) -> *mut bindings::vfio_pci_core_device {
     }
 
     fn vfio_device(&self) -> *mut bindings::vfio_device {
-        self.core_device.get().cast()
+        self.as_ref().as_raw()
+    }
+}
+
+impl<T: Operations, Ctx: DeviceContext> AsRef<super::Device<Ctx>> for Device<T, Ctx> {
+    fn as_ref(&self) -> &super::Device<Ctx> {
+        // SAFETY: The PCI core device embeds an initialized vfio_device. The borrow
+        // covers the same object and preserves the callback context and its lifetime.
+        unsafe { super::Device::from_raw(&raw mut (*self.core_device()).vdev) }
     }
 }
 
@@ -507,13 +439,14 @@ pub fn core_get_region_info(
 // SAFETY: The embedded device reference count owns the VFIO allocation.
 unsafe impl<T: Operations> AlwaysRefCounted for Device<T> {
     fn inc_ref(&self) {
-        // SAFETY: `self` holds a live VFIO device reference.
-        unsafe { bindings::get_device(&raw mut (*self.vfio_device()).device) };
+        self.as_ref().inc_ref();
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
-        // SAFETY: The caller owns the reference being released.
-        unsafe { bindings::put_device(&raw mut (*obj.as_ref().vfio_device()).device) };
+        // SAFETY: The caller owns a reference to this live PCI wrapper.
+        let dev = unsafe { obj.as_ref() }.as_ref();
+        // SAFETY: The embedded VFIO device owns the same allocation and reference.
+        unsafe { super::Device::dec_ref(NonNull::from(dev)) };
     }
 }
 
@@ -529,9 +462,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
 ///
 /// `vdev` must belong to a registered `Device<T>` in VFIO's first-open context.
 /// VFIO must exclude other opens, closes and I/O callbacks for this call.
-unsafe extern "C" fn open_device_cb<T: Operations>(
-    vdev: *mut bindings::vfio_device,
-) -> core::ffi::c_int {
+unsafe extern "C" fn open_device_cb<T: Operations>(vdev: *mut bindings::vfio_device) -> c_int {
     // SAFETY: `vdev` is valid; set by vfio_alloc_device.
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
 
@@ -543,18 +474,9 @@ unsafe impl<T: Operations> Sync for Device<T> {}
 
     // SAFETY: Registration data is initialized before the VFIO device is published.
     let result = unsafe {
-        dev.registration_data_with(|rd| {
-            // Allocate before calling the driver so allocation failure cannot follow open.
-            let data = KBox::<T::OpenData<'_>>::new_uninit(GFP_KERNEL)?;
-            let data = data.write_pin_init(T::open_device(dev.with_context::<Open>(), rd))?;
-
-            // SAFETY: Only the owning pointer is moved; the allocation remains pinned.
-            let raw =
-                KBox::into_raw(Pin::into_inner_unchecked(data)).cast::<T::OpenData<'static>>();
-            // SAFETY: First open is exclusive with I/O callbacks and last close.
-            // Lifetimes do not affect layout; the device owns the allocation until close.
-            *dev.open_data.get() = raw;
-            Ok::<(), Error>(())
+        dev.data.registration_data_with(|rd| {
+            dev.data
+                .open(|| T::open_device(dev.with_context::<Open>(), rd))
         })
     };
     match result {
@@ -579,12 +501,9 @@ unsafe impl<T: Operations> Sync for Device<T> {}
 unsafe extern "C" fn close_device_cb<T: Operations>(vdev: *mut bindings::vfio_device) {
     // SAFETY: `vdev` is valid.
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
-    // SAFETY: Last close is exclusive with I/O callbacks and the next first open.
-    let raw = unsafe { core::mem::replace(&mut *dev.open_data.get(), core::ptr::null_mut()) };
-    // Run the driver's destructor while registration data and PCI resources are valid.
-    // SAFETY: Successful open transferred this allocation with `KBox::into_raw`.
-    // Last close takes ownership exactly once and drops it without moving the pointee.
-    unsafe { drop(KBox::from_raw(raw)) };
+    // SAFETY: Last close drains I/O callbacks and excludes the next first open.
+    // Registration data and PCI resources remain valid while open data is destroyed.
+    unsafe { dev.data.close() };
     // SAFETY: Matches the enable in open_device_cb.
     unsafe { bindings::vfio_pci_core_close_device(vdev) };
 }
@@ -602,7 +521,8 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
     // SAFETY: VFIO invokes this callback for an open device with valid arguments.
     match unsafe {
-        dev.callback_data_with(|rd, od| T::ioctl(dev.with_context::<Ioctl>(), rd, od, cmd, arg))
+        dev.data
+            .callback_data_with(|rd, od| T::ioctl(dev.with_context::<Ioctl>(), rd, od, cmd, arg))
     } {
         Ok(v) => v,
         Err(e) => e.to_errno() as isize,
@@ -633,7 +553,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     };
     // SAFETY: VFIO invokes this callback for an open device with valid arguments.
     match unsafe {
-        dev.callback_data_with(|rd, od| {
+        dev.data.callback_data_with(|rd, od| {
             T::read(dev.with_context::<Read>(), rd, od, &mut ubuf, &mut pos)
         })
     } {
@@ -652,7 +572,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     vdev: *mut bindings::vfio_device,
     info: *mut bindings::vfio_region_info,
     caps: *mut bindings::vfio_info_cap,
-) -> core::ffi::c_int {
+) -> c_int {
     // SAFETY: `vdev`, `info`, and `caps` are valid kernel pointers provided
     // by the VFIO core.
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
@@ -664,7 +584,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     };
     // SAFETY: VFIO invokes this callback for an open device with valid arguments.
     match unsafe {
-        dev.callback_data_with(|rd, od| {
+        dev.data.callback_data_with(|rd, od| {
             T::get_region_info(dev.with_context::<GetRegionInfo>(), rd, od, info, &mut caps)
         })
     } {
@@ -696,7 +616,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     };
     // SAFETY: This callback runs while VFIO keeps both callback data allocations alive.
     match unsafe {
-        dev.callback_data_with(|rd, od| {
+        dev.data.callback_data_with(|rd, od| {
             T::write(dev.with_context::<Write>(), rd, od, &mut ubuf, &mut pos)
         })
     } {
@@ -713,7 +633,7 @@ unsafe impl<T: Operations> Sync for Device<T> {}
 unsafe extern "C" fn mmap_cb<T: Operations>(
     vdev: *mut bindings::vfio_device,
     vma: *mut bindings::vm_area_struct,
-) -> core::ffi::c_int {
+) -> c_int {
     // SAFETY: VFIO supplies an open device for this mmap callback.
     let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
     let mut mapping = Mapping {
@@ -723,7 +643,8 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     };
     // SAFETY: This callback runs while VFIO keeps both callback data allocations alive.
     match unsafe {
-        dev.callback_data_with(|rd, od| T::mmap(dev.with_context::<Mmap>(), rd, od, &mut mapping))
+        dev.data
+            .callback_data_with(|rd, od| T::mmap(dev.with_context::<Mmap>(), rd, od, &mut mapping))
     } {
         Ok(()) => 0,
         Err(e) => e.to_errno(),
@@ -830,7 +751,7 @@ pub unsafe fn new(
             NonNull::from(Pin::get_ref(reg_data.as_ref())).cast();
 
         // SAFETY: No concurrent registration or callbacks; publish before registering.
-        unsafe { *dev.reg_data.get() = ptr };
+        unsafe { *dev.data.reg_data.get() = ptr };
 
         Ok(Self {
             dev: dev.into(),
@@ -882,13 +803,13 @@ pub unsafe fn unregister(&self) {
     /// Prepare the variant driver's state for a PCI reset.
     pub fn reset_prepare(&self) {
         // SAFETY: This owner keeps the pinned registration data alive.
-        unsafe { self.dev.registration_data_with(T::reset_prepare) };
+        unsafe { self.dev.data.registration_data_with(T::reset_prepare) };
     }
 
     /// Complete the variant driver's state update after a PCI reset.
     pub fn reset_done(&self) -> Result {
         // SAFETY: This owner keeps the pinned registration data alive.
-        unsafe { self.dev.registration_data_with(T::reset_done) }
+        unsafe { self.dev.data.registration_data_with(T::reset_done) }
     }
 
     /// Signal the VFIO error interrupt and return the PCI recovery result.
@@ -923,6 +844,6 @@ pub unsafe fn runtime_resume(&self) -> Result {
 impl<T: Operations> Drop for Registration<'_, T> {
     fn drop(&mut self) {
         // SAFETY: The driver unregistered in `unbind`, or registration did not succeed.
-        unsafe { *self.dev.reg_data.get() = NonNull::dangling() };
+        unsafe { *self.dev.data.reg_data.get() = NonNull::dangling() };
     }
 }
-- 
2.43.7

