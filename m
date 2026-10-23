Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770071;
	b=IhuhM28u36Kg4e7suT2BwMw5x3U0KXAQgUnRL6eh/1R6SoxKRTANwunW9Ud/5RxMqgL4
	 LK1uKsmKW1itf6bHA82cRiFyso3bIhvjJbhOk27SboqnbTDt2Ht/aw0enbvXk2AS8wsXZ
	 DTcAAUo9Q7vV8blw+ISrVqRx6kA7measrSLV4ZI+zJDw/4ILJmplIxMj1A6BiTmb5aiVf
	 gzc1fv2SQCKZ1XIF0m/y9aVKL/hj9e+HxP7SxVraybIEg8MheuhX4/Y9rkMPVqSgGdjNW
	 c/3K6iPFn5P692cLKXA1EgODGAl6g9oY25dmVxXxT3RqHghQMKoJwhvSigVoVKfCa7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770071;
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
	bh=YXWxb0Nu+7DMiplo068Wx74Y31bcVlK4KkzH7Z6kzZU=;
	b=nJvEdqvGMeygjvAFhSmiY+T8em6woXrtpdG86KXQVYWZuJF2SzYiivcMXR0nrqDYXHxD
	 T6mzYQx0uvNPF8yFaOB+H6Td5zKi5xT71OfrDqnpA8H3osG8PCxQ8Qg47ogd3cE5/hXbs
	 B0aYMbTdCWXIFcInwwLl14FSBtHDHskbuGc1G0AsK295OxYuqfm/eticiRSMDg3DyGlfq
	 OZTMtH6I2c8vFS3gRwwycaO/v353Cmhf7xxGTQ5AXaUL/NZsheD9M/BlgMy0RCoLJQxzI
	 OVeo+WHTc1FiiCxzddHNUouGep6PuZN0z0u0tNcm2AvkfPz1Iqe5vly8VGd/2WA1m0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d2BtU3km;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.28
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1E606A320;
	Fri, 23 Oct 2026 15:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B1E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d2BtU3km
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2PZUpFR7unIEXpeevC4kKP5zeD2W/m4Rz1kDG5ibpid2FRqnvYbrJIF9athxLFzIBrpfrIMSLvA/eCD4WZZfLr/fm6XBD+kr6DtjPTchzpIH7OVHPnVPfhPVNwjG2Li3wUbSuBDdQEleFq3OPFsHbl1OtOBmnzthw976oXoS7o4nvZpj3JFJBqmFf1LcXWecFpPN9irfY5YX1Ojoi/ckVo5VtJ9rYLmboRhd3eh24yG6wBQ96buBs2yjGbygS0Skk8A3L2TTzE6e90rMkT++/TwKOMS2fkTCTvUNc9inOgJoq/UfW3UL6PyeRcdIqqnThGMLvbRDbQnyu5ro2RFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXWxb0Nu+7DMiplo068Wx74Y31bcVlK4KkzH7Z6kzZU=;
 b=NizEJGn8kkJLCN3s69mvr0eWpmv1OQoNWjZAiObdDKllie5Pm42nFNaMy/8rD8kpPva1AJUBhip4/HnFQ742AbJynq/WvoOrdYOjIlQG5HZ9hIGixgI2PnNVGHISNAcMX83tCureJ3/TKS4cL6FkFjHxZjxbyr5qdosC+W13j0bE0kiI6dmksOFPjF2O/cz0l3Iu7ML39qjTGoAZ3qQl6hQzW+aYNQQbYhGpcJ0xNh91m4lMoxqFWjhIGplS6sxBNS1hRuAnAt3O60dMitHMzMHH2QmpaQ9woX6x3r24Yf3j9uHzVx2GLInQO3TeujMKtqaNx1ZR+RKoK0fzbUAIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXWxb0Nu+7DMiplo068Wx74Y31bcVlK4KkzH7Z6kzZU=;
 b=d2BtU3kmzEVds1RKNRu9Gs+QIhHsguBFc52E2VoAj8kULe0Cg4wborJd/oDuweKz5KTKINJQpIe++rNNBsCnIDIs/5rP5gNtnP4wl4AHJMX/gXak5PTWsCLue8dDgWywWKbDWPkbbPT41+S9AecTpfBgvVMiLsQjOmqRArrVvdA3BtOjBbq6L38BCPW17Az41DRYbsn9fErtpoIAwWHhent4LiYTvl/LgiH1+0KiriyAgsgfrvNg+nnYwXyAIOQoyYCXn/ruKNxzjlk+0+6BqK11KAtfyMIIHmFLiDwbXYREy4G3oQ0bXdE0EETQbe1UhIvY+F/JThOIZzU6JVIRfg==
Received: from MW4PR03CA0321.namprd03.prod.outlook.com (2603:10b6:303:dd::26)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:41:06 +0000
Received: from CO1PEPF0001885F.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::3c) by MW4PR03CA0321.outlook.office365.com
 (2603:10b6:303:dd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Fri,
 23 Oct 2026 15:41:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF0001885F.mail.protection.outlook.com (10.167.249.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 15:41:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:41 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:39 -0700
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
Subject: [PATCH v2 05/12] rust: pci: add reset callbacks
Date: Fri, 23 Oct 2026 08:40:00 -0700
Message-ID: <20261023154009.2246627-6-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885F:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaad403-f375-401a-745d-08df311c0d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|11063799006|56012099006|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	220DotB7r7HuCr5wnTGyrHcg97F885E5ia3/E2CbZbZZN5nU6tOaFpIeExBdYg9nnOQWNdHyJErvujA4X1yRp5hV0iB/1g/RXMz7GVlg96cWpu0BtOoy48MD5IffCeYe05dP6WlakMXlIXI3vVTpkRREHKQ/ez2fY2XNKI7g5IuRzlsOxqlvSQMGOfQn0AJjgl2EsndCZeDD2bc8CEXnITdpHmu7baXnLQykuJvVQ3taGoMCzsPC1Y/XsDcLX3zSA3kXzxVypWNOWRnO/oVOiF8YA4oMxl4b/z+elX/a/f3YQyMDA3n4la6nrDpnbqo6y/9G9/OvWm0WrnGUtGkNw8agAr1w2Ln0/Pw9FHbkR/D10iTQ5uaaDPWp0ah4icrINIZAP/TtcrsIohwmzPj6UFjhm3vQrGwWPY6MIRt8+dvicU9Chwylmhzr2lbYFNcdfqeINYLtO0raKUIefaq/Q2wksZBNJnaEhVAtXZS/jzCyI8fcwmNeZqSOfxBiLlKs5T5QTVo1wJbIDhGBqgWlZyTFtC1+677u5pzmNbSJXeDasK+vf1jd7XnMjSQ3ZUgibUuUdK1qUYxY2PYhouU0gmibl2DcPPYLqCM0au2yKarP8WXLR18pPKq8/ErxAvyKX7bSpVnqxCuNNmPvLHpkBjQvY4Poe7RuyOwKeHfVzMVQo/xtsoWpiGlqnORbLkhO/gZcgQqI9xwDtmIH1Cbpog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	agFOV1Algyeta/HTdWkKLWP7qYiQU2UfPze3vmnhySRCcAM7OudCbOZTqjlbizIcREPvqH+OR6uYYjKuq5+wOrX0hWDaff0YFfadfYao8Js3Sh39C7Ss1zInalN5qdzsrEp3D7CTH7NZ+eFvJl0WxQwqNsiJc4zb2EMkVytiBjiZjINZ5zge0tsPaReKmJuMtymSx8cWmYhzbQJEGmf9ShCYv3iDgu7ox7Ho6EaJmiUsMvLPBcmKMhl1SSmMVU9J0G1R1ofSgsYt25dxxC3HDD7ejWEPuqVywNJPJShcrFLGuiVj6e5R9uEQVb+zyPUwXLsRLmpPgIGlF9f9D8jksuVWi+v+jj2AAH83+Lqg4F5YakXDuc109gN4YsGcgsbOpolyjN67P6D7nGix8wroSxLsN4fnz18wd9VsbmRKlqwc+aPXqeZkvPhWRJqaOV+u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:05.7165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaad403-f375-401a-745d-08df311c0d0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702

VFIO PCI variant drivers will use reset_prepare() and reset_done() to
forward PCI reset notifications to their VFIO registration.

Adding these callbacks to pci::Driver lets VFIO variants reuse the PCI
adapter's reset callback dispatch. A following patch removes the
duplicate vfio::pci::Adapter.

Because there is no gurantee that drvdata must be valid when reset is
issued, using callback_data_with which contains the helper to null-check
drv_data, this could occur during probe if reset is called before
set_drvdata

Suggested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs      | 70 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/vfio/pci.rs | 12 +++++++
 2 files changed, 82 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index a156927e23d..adc7e92d44e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -109,6 +109,9 @@ unsafe fn register(
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
             (*pdrv.get()).driver_managed_dma = T::DRIVER_MANAGED_DMA;
+            if T::HAS_RESET_PREPARE || T::HAS_RESET_DONE {
+                (*pdrv.get()).err_handler = &Self::ERROR_HANDLERS;
+            }
             #[cfg(CONFIG_PCI_IOV)]
             if T::HAS_SRIOV_ENABLE {
                 (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
@@ -175,6 +178,61 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // Drop private data before returning to PCI core, while its removal context is valid.
         drop(data);
     }
+
+    /// # Safety
+    ///
+    /// `dev` must belong to `T`. Any installed driver data must remain installed until this
+    /// call returns. The data lifetime is independent of the callback borrow.
+    unsafe fn callback_data_with<R>(
+        dev: *mut bindings::device,
+        f: impl for<'borrow, 'data> FnOnce(Pin<&'borrow T::Data<'data>>) -> R,
+    ) -> Option<R> {
+        // SAFETY: The callback supplies a device bound to `T`.
+        let data = unsafe { bindings::dev_get_drvdata(dev) };
+        if data.is_null() {
+            return None;
+        }
+        // SAFETY: PCI installed pinned `T::Data`; the caller excludes its removal.
+        Some(f(unsafe {
+            Pin::new_unchecked(&*data.cast::<T::Data<'_>>())
+        }))
+    }
+
+    extern "C" fn reset_prepare_callback(pdev: *mut bindings::pci_dev) {
+        // SAFETY: PCI holds the device lock throughout reset.
+        let dev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+        // SAFETY: The device lock prevents removal of installed driver data.
+        let _ = unsafe {
+            Self::callback_data_with(&raw mut (*pdev).dev, |data| T::reset_prepare(dev, data))
+        };
+    }
+
+    extern "C" fn reset_done_callback(pdev: *mut bindings::pci_dev) {
+        // SAFETY: PCI holds the device lock throughout reset.
+        let dev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+        // SAFETY: The device lock prevents removal of installed driver data.
+        let _ = unsafe {
+            Self::callback_data_with(&raw mut (*pdev).dev, |data| T::reset_done(dev, data))
+        };
+    }
+
+    const ERROR_HANDLERS: bindings::pci_error_handlers = bindings::pci_error_handlers {
+        error_detected: None,
+        mmio_enabled: None,
+        slot_reset: None,
+        reset_prepare: if T::HAS_RESET_PREPARE {
+            Some(Self::reset_prepare_callback)
+        } else {
+            None
+        },
+        reset_done: if T::HAS_RESET_DONE {
+            Some(Self::reset_done_callback)
+        } else {
+            None
+        },
+        resume: None,
+        cor_error_detected: None,
+    };
 }
 
 /// Declares a kernel module that exposes a single PCI driver.
@@ -375,6 +433,18 @@ fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'
         let _ = (dev, this);
     }
 
+    /// Called before a PCI function reset, with the device lock held.
+    fn reset_prepare<'bound>(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
+        let _ = (dev, this);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Called after a PCI function reset, with the device lock held.
+    fn reset_done<'bound>(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
+        let _ = (dev, this);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
     /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
     ///
     /// Called when userspace writes a nonzero VF count to `sriov_numvfs`. The token carries the
diff --git a/rust/kernel/vfio/pci.rs b/rust/kernel/vfio/pci.rs
index 43c14b4e3a1..db30dbce6a8 100644
--- a/rust/kernel/vfio/pci.rs
+++ b/rust/kernel/vfio/pci.rs
@@ -1084,6 +1084,18 @@ unsafe fn unregister(&self) {
         // VGA and runtime PM callbacks. No field of the enclosing data is being destroyed.
         unsafe { bindings::vfio_pci_core_unregister_device(self.dev.core_device()) };
     }
+
+    /// Prepare the variant driver's state for a PCI reset.
+    pub fn reset_prepare(&self) {
+        // SAFETY: This owner keeps the pinned registration data alive.
+        unsafe { self.dev.registration_data_with(T::reset_prepare) };
+    }
+
+    /// Complete the variant driver's state update after a PCI reset.
+    pub fn reset_done(&self) -> Result {
+        // SAFETY: This owner keeps the pinned registration data alive.
+        unsafe { self.dev.registration_data_with(T::reset_done) }
+    }
 }
 
 impl<T: Operations> Drop for Registration<'_, T> {
-- 
2.43.7

