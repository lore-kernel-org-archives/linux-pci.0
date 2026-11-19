Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125113;
	b=qQ7InJ4uxz4FnS34pWXJBPdQYtSx222sL48T2FpyuVwww1hXRMdUA/7mMmgMVAn9kW5l
	 acu3+Ywi+6PI0+WgaqLstJ1/WEmTklNTSLlvnFWUUneMhHneHsWrremGqR92/7CmYMsi6
	 /BRJlQOHpJ+jtu0p/4nlJeUWiGh/VeI4rihvMBMZTNQ1K7p66YuUsFnjVISWqQghzu30g
	 oMTaKgwWuxheud2AGA3MEnjZLUWHwfA+NVumNtr5wyeaHiTBf3kkV6nliNe6mAzOmmfHU
	 Z3y4Ljz411pY40deBxF7+G4iW3DukVFKTGB1WIuPSUTUb72vfwYdW+RaYxMdywJonHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125113;
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
	bh=7rAKTEK478OdLXsufOs1guzqR9Ei9seqEeZf2GqQE2A=;
	b=tLvw1QXdKSLM+qBxQqWsXVir/PRhvbsFyrIGr0LdEjvjY42zXxY9W3yD+Ru1i9sWiaiR
	 iqp3Hm74sp3xJrTBQLoxd/K74kSOLnqaBXfHBO7tUKPh8T9c3ukUZhdGUnRft6gJvFTC+
	 fa+nl/NM30d4iceKj8opb+nyXTsgMhj7otNSEi8YS7Vb6Z6cJBGQe4QYBqVyssLKoas86
	 qyZLsopMbe0kX/LIXsvGFgIybWkLjpMmCeYaa/U79oa76LHhY1Rl+XlJbvZJpQt+/Sk6n
	 86bUtkC4yUHqQzDDxJeJF/NoXgKTQhAai7wr4NDIm+qW5HjBydwu6JwackQaiTc1eSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RqdhlcMP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.44
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391660A2620;
	Thu, 19 Nov 2026 21:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3391660A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RqdhlcMP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu3cemCPasCuXC7rtxK01N6mXvC9lf/asibfKTYM5zlPg8XIWXuZD5uDjnQ5C4nfwcONK7x/cUXY2Pg5if7LVuo0XWLON7niydBCwXCxrgxCscsbU4J48ucoxOPTfiTwtGZEFNGBt5HZyUFFr/XGfzDgKtfjf8/gE5fObpNECKP5GdnQ/UNtaqC0vV44Db6Mvvc93G638/NKGWW5LgT/C5bZ5Fm/PIVcrjdKDQMGXBnwydcH40WlhylnYo7OpbdGUmzP9dUEuIl12MV/yEnqtMyB9M69ZoHEFE7aeaziPrTYtHxv0QP/sFXO1HbOSt61DbyFN+KaXAhe5qfCircFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rAKTEK478OdLXsufOs1guzqR9Ei9seqEeZf2GqQE2A=;
 b=f+kYkRABJJxsEtwd9ZncTCK/7EBxMh/sn93kRNSL3RHdxJuv3LBKSb7QaLDweqqDdenDXT6UjC3g2GzNXxkBt9Z9j00jEvhewK7fDZVruGu0tDoq9k4dPRE2EAr3a6fat0H7VEdhjG4McAYWKaiG1eSlTy5wwkyrfxDvEpsRp0DRdFKEHmgch/hDnDvvvGmLQq5CWwQAqsiBwXjMg5Q3mv6wiFwcmU3HseaL5daHM72vZhcbOwoakR7HUWLRcs+BYHhMiVIUp1PMbzVy1zGehSHw/sLsFXQmD/ueQMrg6TR0EGwBskfpCJa4Blb5XgoofPb1cgCwYKCZq/OzQlCkdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rAKTEK478OdLXsufOs1guzqR9Ei9seqEeZf2GqQE2A=;
 b=RqdhlcMPlCyzKfUjEyRzXgH1QI2m1AA5J96ie3LeUzbNmhdGmRlLYaEBD7cVlppdlzU9qISL0TqdX1OSTsuBwHarp7pkrFEyBVssvldAip8eRtSWPbr8G0Vs6lxPS8bLFUWiWNhjtuNOY7HOUyR3l72TIy8FkS7VFdIBIYdF68GuicxpdCWxMLJR2Pejnfw14TELIZ1Iztb5BhcYe5hwAMFFygPI7i3NXdrHtbwTV/0CMoEfQPy1cIU/otRA4Oy1pXyrMpCmcWKCmK6HL4qiNqLZ8mMPPHHdIDMWpP/GXDrVBjmfqjpN92Fq6Fk6QBdHlGYx7VyLLkGOBeSeOvaUpw==
Received: from MN0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:530::22)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 21:51:46 +0000
Received: from BL4PEPF000003F3.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::7c) by MN0PR02CA0028.outlook.office365.com
 (2603:10b6:208:530::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 21:51:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL4PEPF000003F3.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:17 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:13 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: Simon Song <xinmengs@nvidia.com>, <alex@shazbot.org>, <jgg@nvidia.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>
Subject: [PATCH v3 5/9] rust: pci: add an error_detected callback
Date: Thu, 19 Nov 2026 13:50:40 -0800
Message-ID: <20261119215046.2892839-6-xinmengs@nvidia.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PEPF000003F3:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: c58a8fb1-5bcb-4619-d3db-08df46874e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|6133799003|22082099003|18002099003|261009223027099003|56012099006|5023799004|261022075727099003|11063799006|261021121427099003|261102123227099003|10067099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	t+nmQLJd/3WXQy9Tu1WjNe6VLJ6cS/WcyT6gkTZqUTEf2HNOqoSn8EGPqD4jkjnkanNlYL//71muLNiwSOWdkzMZ3u43KBE1To2f/ZctdZhrcxIngHpAWly2lXyka+Mt0g8CguUYsrtphiBSYJQKqPi/eoCxDAS2W/xtNFAknJMykHRctENFCSPDcdzpJ3GMG3/V/SCp2j4Q0u9V1AkIFVdgJvu+ncFr2cVIc2xBMOKm8nd3TQxpM7BcNuPEk/lOWcr233v4CNcbcyWrOGni5QV4asgPFJVwm6lcbfhG2OvgHIQnn4ncTFrVJTiwmGqira5KaoEzOHzLU864Wv7AcOGT85K7d6hXx1y3p8yWlJcYdNZTD1rlS5x/rFruK+6jcc1yDT3YxAb6iFCMP57wG78Tg5ZaeMLITasf0g+TW3gsFPAVCuD8U8yha0smAjdLQIp38sbNIPGqEPc13TbCbc6qU2UK0vOjbCj8Yb53Ce4GAR23SK651vlRTIIqxw15v/fRlmdiKDIGdWpOf+OLcSvIVkwz6ksAAE1tHbur/icM30xpPVGzfSscMELMtbtilxB5TNgd4mNeFqNic0MP1hW9ltRPIf2omqd/cDouxxAGrfpUXuvAYvIBJHVwoB/Zvui8vfJ4DejBla7gQCSNTxKNrYbO6UvTjaJ87JrBl2OCpj9s9kXPAtgLddXYx4DVwuY79SBCU0gKHau+uRt5Dw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(6133799003)(22082099003)(18002099003)(261009223027099003)(56012099006)(5023799004)(261022075727099003)(11063799006)(261021121427099003)(261102123227099003)(10067099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qptru2rNul+l0/z13uRgaaZN5RwxJwtm3NjY4xoLZfQgsh4aKv0VBbSi/LokSR/cRkcBow2pn3korrWMfZN9rk4lrHHUXT26Y5P8EAp49YnzR7R3P/iM+hpn1dFDhLlTOi3DKU9ks2QfafdmbpaMwudZY/y20D2zj1WGMRbjsfzfy102heidrozt+LiXeYcBm0bUSXzb4LiGmsHBCLFNRecG/QLEvwstyQHMHjE99orrycVJ2mIsy2iwZdQkSQIoe+J6+Isur/PNKDSOcXQRCP+qeZF9WX5pULnsnxqUPKkEowr4Xag7DlVWlkRuUK5lvYCYsOlXu+9wVfqj8gDkvZkl6fi5a16TI4XH0dikwgK4GSbkr1aQwu+/ur8pRDr/3MJF4zLYdokQjEVHR0K6oz67BNgSWQWKE6+9SP9+QRpTNEKUMdJZHYFTRhCVH1LG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:45.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c58a8fb1-5bcb-4619-d3db-08df46874e42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003F3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829

VFIO PCI variant drivers will use error_detected() to notify userspace
of PCI errors through vfio-pci-core.

Adding error_detected() to pci::Driver lets VFIO variants reuse the PCI
adapter's error callback dispatch.

Suggested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 89 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8fcec16e6ccf..27ac8d8435f7 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -106,7 +106,7 @@ unsafe fn register(
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
             (*pdrv.get()).driver_managed_dma = T::DRIVER_MANAGED_DMA.is_some();
-            if T::HAS_RESET_PREPARE || T::HAS_RESET_DONE {
+            if T::HAS_ERROR_DETECTED || T::HAS_RESET_PREPARE || T::HAS_RESET_DONE {
                 (*pdrv.get()).err_handler = &Self::ERROR_HANDLERS;
             }
             if T::HAS_SRIOV_ENABLE {
@@ -212,8 +212,36 @@ extern "C" fn reset_done_callback(pdev: *mut bindings::pci_dev) {
         T::reset_done(pdev, data);
     }
 
+    extern "C" fn error_detected_callback(
+        pdev: *mut bindings::pci_dev,
+        state: bindings::pci_channel_state_t,
+    ) -> bindings::pci_ers_result_t {
+        // SAFETY: PCI error recovery only ever calls the error_detected callback with a valid
+        // pointer to a `struct pci_dev`. AER (`report_error_detected()`) and EEH hold the device
+        // lock while calling it.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `error_detected_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+
+        // SAFETY: PCI error recovery only calls this callback for a device bound to this driver.
+        // The device lock excludes `probe_callback()` and `remove_callback()`, so the stored
+        // pointer has type `T::Data<'_>` and remains valid throughout this callback.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+
+        let Some(state) = ChannelState::from_raw(state) else {
+            // PCI error recovery only reports the states `ChannelState` represents.
+            return ErsResult::None.as_raw();
+        };
+
+        T::error_detected(pdev, data, state).as_raw()
+    }
+
     const ERROR_HANDLERS: bindings::pci_error_handlers = bindings::pci_error_handlers {
-        error_detected: None,
+        error_detected: if T::HAS_ERROR_DETECTED {
+            Some(Self::error_detected_callback)
+        } else {
+            None
+        },
         mmio_enabled: None,
         slot_reset: None,
         reset_prepare: if T::HAS_RESET_PREPARE {
@@ -363,6 +391,55 @@ impl<D: ?Sized> DriverManagedDma<D> {
     }
 }
 
+/// The state of the I/O channel to a device, as reported by PCI error recovery.
+#[derive(Clone, Copy, Debug, PartialEq, Eq)]
+pub enum ChannelState {
+    /// The I/O channel remains operational.
+    Normal,
+    /// I/O to the device is blocked.
+    Frozen,
+    /// The device has permanently failed.
+    PermanentFailure,
+}
+
+impl ChannelState {
+    fn from_raw(state: bindings::pci_channel_state_t) -> Option<Self> {
+        match state {
+            bindings::pci_channel_io_normal => Some(Self::Normal),
+            bindings::pci_channel_io_frozen => Some(Self::Frozen),
+            bindings::pci_channel_io_perm_failure => Some(Self::PermanentFailure),
+            _ => None,
+        }
+    }
+}
+
+/// The result a driver reports to PCI error recovery.
+#[derive(Clone, Copy, Debug, PartialEq, Eq)]
+pub enum ErsResult {
+    /// The driver has no result to report.
+    None,
+    /// The driver can recover without a slot reset.
+    CanRecover,
+    /// The driver needs the slot to be reset.
+    NeedReset,
+    /// The device has failed completely and cannot be recovered.
+    Disconnect,
+    /// The driver has fully recovered and the device is operational.
+    Recovered,
+}
+
+impl ErsResult {
+    fn as_raw(self) -> bindings::pci_ers_result_t {
+        match self {
+            Self::None => bindings::pci_ers_result_PCI_ERS_RESULT_NONE,
+            Self::CanRecover => bindings::pci_ers_result_PCI_ERS_RESULT_CAN_RECOVER,
+            Self::NeedReset => bindings::pci_ers_result_PCI_ERS_RESULT_NEED_RESET,
+            Self::Disconnect => bindings::pci_ers_result_PCI_ERS_RESULT_DISCONNECT,
+            Self::Recovered => bindings::pci_ers_result_PCI_ERS_RESULT_RECOVERED,
+        }
+    }
+}
+
 /// `IdTable` type for PCI.
 pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
 
@@ -461,6 +538,14 @@ fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'
     #[optional]
     fn reset_done<'bound>(_dev: &Device<device::Core<'_>>, _this: Pin<&Self::Data<'bound>>);
 
+    /// Handle a PCI error and return the PCI recovery result, with the device lock held.
+    #[optional]
+    fn error_detected<'bound>(
+        _dev: &Device<device::Core<'_>>,
+        _this: Pin<&Self::Data<'bound>>,
+        _state: ChannelState,
+    ) -> ErsResult;
+
     /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
     ///
     /// This callback is only invoked when `CONFIG_PCI_IOV` is enabled.
-- 
2.43.7

