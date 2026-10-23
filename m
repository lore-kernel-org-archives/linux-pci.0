Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770083;
	b=OuK1ZygHsn4hCtA8StE4qQNY4WchFSJi3VVS5/o6l1OvN99VCliABSrx/wS7crBfFX6I
	 KKfYKdbWNZk2L7QG7CXNIGVpyHxaLssNmKJ38I+ARgPdUryiGs3BpMP9lznnaeZWt3dPz
	 Aa4uEAz2F0+RwqYx6ws9DwQJiEkIulEgn7Bb/oKZp3woTnRd3v6TsXzu2tenkHiHGiE2P
	 4xK4mp5OKTLw5j6V4xu+rTP87dqRE8EQOS4fBDk3UzRCuVoEjNG+bfa+WsEbrgls8vVik
	 jfFtxLk5hHjvbBonDDIRbWu43a/UKNfyz7bFonwJIAFsLCsQmzR8FyQVheIcBeE/3bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770083;
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
	bh=f9tYoQPde2XpzGkJCNNpvvE/ULkBIr76CoC93vLsNVw=;
	b=gm9g6cF3zB8HrrhnyQKh2p0sLlzpBnXNFgJVtA4FRHjeaXLCq3xRnLLxalaoupmWcB4r
	 Dk3NO/csrXnD0kX5DYmCUgBVrMmaVwWQYaMAsP9h5+Zq5u6mUQDNNEbQV7xvF0MRWrwjU
	 Z0O0itznmA44O9XHYhel8hd0JHS+eSjTUSIkbf8IliNmBoKsnHaeM0EN0YKIzLbELCrBd
	 3T1yvgqyN0x5wTDtipdSvs+FZccIsU7w9tMDlyrhjroFr3JK4s9q+rPwALUPBDmh/2UMe
	 eJsFDJvJsqiJYEi3ugKMeIE2YL+ihbmmoPpnr1zWucbmeguK/A5NHKZoaEaJizXHY9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kOKpQvd7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.4
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43160A260D;
	Fri, 23 Oct 2026 15:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC43160A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kOKpQvd7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvcCzSxB6jtd1hUroL53n4R5q2FJsqxoH0luLUOmmNTNbWOIlFL3y5ErBUs/GTkalronfbalsXPQ+vyVyZ3ZHtH/EZlfDzDa5OXAb02CLPlChqt2PhtYAwTfCHzj3WDCV4inrMT9mHS5/gP1ftMePULhfdZE3kWpkGL5Ti7NYPBHQaIluF5R5m/jY47H06jDvCx7RQhQS/Hi9dG+cphHE2HnpY4Z/CEyBXCr7hHGHHcLAxHo+HEY6cJKi6dYwSddK//0LP8nR6c681pOXSOJGntSY8j3cBgXpNnKow9Kl8/CJmQVClsFZqKNOCjePLViqhl36GLSbEQmdGF2M7yw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9tYoQPde2XpzGkJCNNpvvE/ULkBIr76CoC93vLsNVw=;
 b=r3GUTcEUp1gjiljsJ+6ko3rWH1n+F66PFmwbIWY0eENdOC4LUHITh/6puJQ8U4BdQCYfWmp0FthmFI4D9sjVqkl7JV2Dmn0PAXOEtq5ZLMiU+T0FEXwIrDZoCogG42G238TOAiUDgHVFWS6/cOOaodm+4x3vtJiWisONgoKDYYdIJ6jzZlBSJK2KHpH6Ur/LaK1q615WkaX84PVRGlDf+lTbVDwgijOVUfoM4dOy3l7DqMe/e2WOWK8pYaj1JUIHiilfzbxCYpCmCbcBhFgcmBwU7cSKrGTQSzvQzHvAfJzf2GUCU7GttvSPy1x/TiYX1benGMTJb1FUpwBQjYDnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9tYoQPde2XpzGkJCNNpvvE/ULkBIr76CoC93vLsNVw=;
 b=kOKpQvd7HhBgDp13G6+DJM+BPsaYQTGR7LE0HJYYwQU2mYROZHLwosw4fZed6Z5tiDoxI5r00PY17SZfmXvp4uDUpmbGyGgBR12VXDL9jHJYLNd0xAuGidgeMa7Wo8KZp3d/4auL+nZBxftOo/PXUBGaUBifZT/7JnJaBjxNznthHhHQtVC0NLQ7EVLEuQwRTsam/O+dwtJ5ddhuibnVOKmKbvicCBxpZ03K/VM6PEUiZVhK+wNvDYDjEhmKp/moxg43RQdT+g0KSTCYxXWHrnPEhkXELud9hJlUW/+3pRNeaSNaBMyOI4f7TQjiG9PN6p2+Ceh0r6ng4eEPBXpb6A==
Received: from MN0P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::22)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 15:41:14 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::2) by MN0P222CA0017.outlook.office365.com
 (2603:10b6:208:531::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 15:41:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 15:41:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:45 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:43 -0700
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
Subject: [PATCH v2 07/12] rust: pci: add an error_detected callback
Date: Fri, 23 Oct 2026 08:40:02 -0700
Message-ID: <20261023154009.2246627-8-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2403b7-62a7-4045-c858-08df311c10ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|7416014|82310400026|56012099006|261022113327099003|11063799006|261021123027099003|10067099003|261009223027099003|261021121427099003|18002099003|22082099003|6133799003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	svQqGGfD0b6c3E3CTYEFapFmSCOqOajJXYzQ80ZnhOf/pWKegqdzaAOGsN2JQs+oHUJBrqmK7oDePXt77ewyIF5xSGBq8FZqETtBWhBfAsKGLlVOW9mQXWizHA792+DX3o/CRsNKKx4D3TEFP5c/FQ9akjm4BMQKqBKDMcG78zx63JQHk8LhVXRySTSLXvHeAr3CGX57l9v2jRGRTMM3kOyxb95qfVgZtDjM7m4OJquZnPll/PsOFSSUqnmemd5ENxbasFBTO9op6fFsBAn5wIZzH2Y6k+qcN/BDACfWpFL2KoffpYBbbPFROpjKoLo73Euh9uNl0l49bL1Jvr9Io/UYfufYM+GSykRvCOMYgY7y9UIozBMi2OVEI9ncYU0uWxO2BkEWHr9nEUyoMLP5Ns2UOzSPMQmBbdUBj9mmo8d4gpnn67TuMJXfiG6tHgA4XAlBbeI0g1JVjou+1RQ8MhyNwATHdiim90tv+s5IqYPI/mFcuwpz+iLE0lmXnFsw3EdI0VWksrb4QO5tJHSt+fG+5yPdrAPq7R8HmeJWIBBjNvflfYEKsgtrSvJkD6x3zfXNi9WsHqO0HrAPFTHbo6ysXndWyaxSBC2dlQ6gEHtSuht0K3n/fUzrPSVQmIHMJMwOxsAZDKx9/C4hP6YbSa54ihomEYE+xrEOMOKzurGCxf+YpNgJDLBxk8vJEgDx6igS+9kx/230Dk9ATmYbCw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099006)(261022113327099003)(11063799006)(261021123027099003)(10067099003)(261009223027099003)(261021121427099003)(18002099003)(22082099003)(6133799003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q3PMJwonjs5XwZWCIeNnFGQi5Tf3XZ0GLSr0fFw8C82Wgv5Utap1IAFnXocwdKRRDTQU+S+hvyRwwxvaE3OEIXr9UIcjVqr1punBY+Q1DNPyLh+RnYf6q6/K5/sfur/hphg/NL5HzeUCvl8NbKemBkafh1jKxBQxFSXPdo6kPLxcfWCdHoTgJ7tJI3xbIc4dN6dB0JZyiWQqvkVrg7cjLBRhezNXHG18DRW3ZqHRHRcD5V0PcBIIXsesiGxD4vzgJ02MgWrME/8/CMO+K+BkrVCklvTRnWSvMew4Ehcxy7MnPdtfPvAPHRQ13L/aQDxEpZiDfqXAmbxFSKuJsMR+z6awZnKO6Io0mUYcUX3hJDv0LaTleXrIrlycEJMZmc6uP+wrDKIbQXUWZydSdu/E9672VXOb3N2pHNeL7UXrRKjFHVmgSuwn9Vlc426joTsI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:12.0923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2403b7-62a7-4045-c858-08df311c10ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215

VFIO PCI variant drivers will use error_detected() to notify userspace
of PCI errors through vfio-pci-core.

Adding error_detected() to pci::Driver lets VFIO variants reuse the PCI
adapter's error callback dispatch. A following patch removes the
duplicate vfio::pci::Adapter.

Suggested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs      | 33 +++++++++++++++++++++++++++++++--
 rust/kernel/vfio/pci.rs |  6 ++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 1951b3c8a5c..ddc28099087 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -109,7 +109,7 @@ unsafe fn register(
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
             (*pdrv.get()).driver_managed_dma = T::DRIVER_MANAGED_DMA;
-            if T::HAS_RESET_PREPARE || T::HAS_RESET_DONE {
+            if T::HAS_ERROR_DETECTED || T::HAS_RESET_PREPARE || T::HAS_RESET_DONE {
                 (*pdrv.get()).err_handler = &Self::ERROR_HANDLERS;
             }
             #[cfg(CONFIG_PCI_IOV)]
@@ -223,8 +223,27 @@ extern "C" fn reset_done_callback(pdev: *mut bindings::pci_dev) {
         };
     }
 
+    extern "C" fn error_detected_callback(
+        pdev: *mut bindings::pci_dev,
+        state: bindings::pci_channel_state_t,
+    ) -> bindings::pci_ers_result_t {
+        // SAFETY: PCI error recovery holds the device lock.
+        let dev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+        // SAFETY: The device lock prevents removal of installed driver data.
+        unsafe {
+            Self::callback_data_with(&raw mut (*pdev).dev, |data| {
+                T::error_detected(dev, data, state)
+            })
+        }
+        .unwrap_or(bindings::pci_ers_result_PCI_ERS_RESULT_CAN_RECOVER)
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
@@ -461,6 +480,16 @@ fn reset_done<'bound>(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data<'bou
         build_error!(crate::error::VTABLE_DEFAULT_ERROR)
     }
 
+    /// Handle a PCI error and return the PCI recovery result, with the device lock held.
+    fn error_detected<'bound>(
+        dev: &Device<device::Core<'_>>,
+        this: Pin<&Self::Data<'bound>>,
+        state: bindings::pci_channel_state_t,
+    ) -> bindings::pci_ers_result_t {
+        let _ = (dev, this, state);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
     /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
     ///
     /// Called when userspace writes a nonzero VF count to `sriov_numvfs`. The token carries the
diff --git a/rust/kernel/vfio/pci.rs b/rust/kernel/vfio/pci.rs
index db30dbce6a8..0fbc6a920dc 100644
--- a/rust/kernel/vfio/pci.rs
+++ b/rust/kernel/vfio/pci.rs
@@ -1096,6 +1096,12 @@ pub fn reset_done(&self) -> Result {
         // SAFETY: This owner keeps the pinned registration data alive.
         unsafe { self.dev.registration_data_with(T::reset_done) }
     }
+
+    /// Signal the VFIO error interrupt and return the PCI recovery result.
+    pub fn error_detected(&self) -> bindings::pci_ers_result_t {
+        // SAFETY: This owner keeps the initialized VFIO core device alive.
+        unsafe { bindings::vfio_pci_core_aer_err_detected(self.dev.core_device()) }
+    }
 }
 
 impl<T: Operations> Drop for Registration<'_, T> {
-- 
2.43.7

