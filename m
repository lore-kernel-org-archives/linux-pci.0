Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6492F7445;
	Sun,  4 Oct 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115725; cv=fail; b=tACE0AOoqoXOkAXyl28PJuNR6mFSiMdZrM1VQnNNHaju87WOGb2qefl42AG5Fy8/IcPCq1cFykHKEGIVYzalpoQR0jcACKzuDIPPvKvHRtenLMds/7k0J4BJt4ckBcUJ76T2DJUdLgbn2+kcfUg40KssiMa4oh5UkJ+m5e/J9hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115725; c=relaxed/simple;
	bh=1UJh/D8XZ5hxu+UVW4tT/wSmwmj1qgFlLMR+uNfeGDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HirCrIt/XMPAbxMDOlPpTk1E6N5VhyLG9s8TVK6tidvD7PZAEM0nQq7zNyaV5xBqVTy/PNO64Hf6noCXgt7+l6mD4fb8ioCXIGsqftna3aRLVKEjVCbozMUDfgxx0WAz0voSlqoUFPxNqzPKjloNncsPMsNULn+H8e6cGWhOhh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MZ1gwI+G; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MZ1gwI+G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OISgSI28spUEJrgc2afukKL/goUIsv3EoRC0At+IbolISzss0OpN0alqmPDKe196v/UpT6yE9Z4EOwkpDIGUL5ebGJBUxdForg1KVQFnrS4Qv+LaHKar/s3H7NzSjGvlL2D9swlxLb71op9gqaLHu1sROPDrLjkxLs3NyYxb1uf4aw1+oSXc5kM3dmwdhGxU3aGLnL0VdxvNodFtcOSLVc/j4YyleBvrVggFteJeHoLeRpUHuDtMQfiJrhEvsSiK3tZ/SP3yXc5a0c+23eFJpLAvBKovK5GUXB2X9519VzdB24YFRM4N5japvKchVqRFKkWayvM7tf2i8WfhNcjQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eckPloW3FQ5H7hJRYXxri0WWx7tOWVVmnCRed5BE/J8=;
 b=OiTl6kHMN44c9xWCtGXnApp90WRoqregAvW7I4RU2wbGGXQrSh5/QQZ0I1MOjhH0LaGZUxXZrT0sdWjnkxeBTsFM1Oh6YN4BfzjVmmr00WkT0nEbpabaHzfqHuW4X6KCZVrU+TUv+i7VxDWOtS6MJ9VWhadOdzVW3lPh7/WrbBHE4IOEkktN9QP9JNjpXjlYphQohEK5sYdxHWdKfgC854Plipa8g4TyD2k6aiES8YjffO3dmPyB64Iic0CUDWtkFkEHNHFRaU024AbetF4YD+Pl8MOrkdSLDjc6TxeuqSBpjwzCuSrLoy+2u+Py0UTa1C5ttDyhL3S/cgK32EkqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eckPloW3FQ5H7hJRYXxri0WWx7tOWVVmnCRed5BE/J8=;
 b=MZ1gwI+GCXNyx6IPASvCORO9Po4jhAsrWPoGoWegjx9pmQMTFCoJBCfOtEn7htUEndEYVdiD84oQI6YHSDNpLglVk1RBfzr/XQlouBtH7keQkFNaT0ctm2CbJbGZz3njjiGYPmGFpBJrRPlhjjJyVsDPGywBRTSa2ZJjqqOW98aIaMlZkHExXdqJPJXSXdLNYwx93Pu2MskMmJ6hKm/iCk9GPUfhZ0kAOaxQFir9XBslR9uy22kScNII6v4R5JsZGR/qQWOrvabRuTbQP8V7+2j/2Lmzvp86eynL243kKXXH2Rqum8s9T5St9+9KDYHtpqMdP/ohFM3r6tvT7PG8ow==
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:08:39 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::48) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 12:08:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:16 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:08:09 -0700
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
	<alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v4 5/9] rust: pci: drop driver data before remove returns
Date: Sun, 4 Oct 2026 15:07:26 +0300
Message-ID: <20261004120732.1045629-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004120732.1045629-1-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: 8024361b-b6e6-4d80-cad0-08df221039bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	//Muh56s1IXGp9d2FirIik2irzfUnG7UXo7xgiRy358vsuHBbYw6cFcmGmTvfFQpPvBgQ1KXQnT/vthYN1M29ZddXcNUN5bFN3lcn6LH5w9PXCAgeRDiAEtxCFxfKCqQqvlpWjpvMVZQKABwDD8tYTgMRrbeftLdUInrmoxmjCdR3076fQcl9ixq+Yf7Dno2Wc5jXRoZMnxKefYUpuHo9zRbI1NjBeGHDzzVBdmdIaznIZi+DRjhEdKcrkXEqBnOIG7QtIwuT6sVYdQvwH/DxPHg1i93wrl25/L/vOLyHi2oYzUJh7rNb0SPeNvhP+E10I5ezUfQe7j9mTJI/6X/ukx76NESAAl397fVah8OpjDkmn66dWaXK4WgxTaLXfcsgWXRCa84GMuN6zTG8sMOAbkOpd0LEpuNLUQgQ2LIUlVNmaIo2MmtUxfrVKZOzQWRCK/ztVNBv/rTBYJdtxoZlZflfSrsn0dwCGGa5Ku3ayihKcyplM+ozBFXPpxQ7D2b237afpY1fYmY8tXTadq8uAoB+gPFE1433QGP5VyBjpn7mHvcwedqe0d9kjcmzII8ecApcWF3qGxBEYxjob/V3vvmad0T8aj4Rvkz0yQqsZ7tw+P1VtzTVGBEUX+2ZPqHT3KIBHtBhR+sjSxMRFnv2yfO4pvFgbSBK/OtOBdmxXNVm0doZ9eK0kZFF83RwLx2GXcTABOnsKPlhVhNRYB+8A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4A7RwMwQ3ZAAM4+Smw9BIRsv7gFOLAZ4GnmoMboV4mPqam0SPhbdgDF1AHP27DuAeee4jO+LumO0ieXhYNmGT6ELtdYStxLrfx81iXqZCVWcOYVqDBiljG6aoVy5NakbJJBWrDMgEYbReEeMyBfPA8EInWJ/jg7346adskqM/bGXJD6kaDFQJQWO5g5uMjPdYUAAmtdlWwhWFU1K7UiCVm7lV9pRRr6muRcAIuAxa0OtvaPxVx4O7lT+f0RJJu1T7q5bTyjpIIpq6/gTCsJc5gQxM3tALPeAreVnSL15BMA6RK/RyRTWXFnJ2DPTz0wSGZ/IjVi2X/QzyxP98vCa3kWC9ACsEEFW/KeJCnpO5ICUlkgTVVj+/o+7k88hfb5i/boafEeFb1FsWjA6/j03vEfI5KDDKsmYSU28VH6cKYiiCa0CQbd864/Eb1LgP8Oe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:39.2226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8024361b-b6e6-4d80-cad0-08df221039bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC

Drop PCI private data before the remove callback returns, so its
destructors run within PCI core's removal context.

Call unbind while private data remains installed, then take and release
the data. Taking it clears drvdata, so post_unbind does not release it
again. All borrows must end before the data is removed.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/device.rs | 4 ++--
 rust/kernel/pci.rs    | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849..1f6bb58396e2 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -243,8 +243,8 @@ impl<Ctx: InternalBoundContext> Device<Ctx> {
     ///
     /// # Safety
     ///
-    /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before the
-    ///   device is fully unbound.
+    /// - The data stored by [`Device::set_drvdata`] must still be installed and remain valid
+    ///   for the returned borrow.
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
     pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index dcb0cdd0d426..1599b3a613d7 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -141,6 +141,12 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(pdev, data);
+
+        // SAFETY: The driver's unbind callback has returned, and no callbacks retain a borrow.
+        let data = unsafe { pdev.as_ref().drvdata_obtain::<T::Data<'_>>() };
+
+        // Drop private data before returning to PCI core, while its removal context is valid.
+        drop(data);
     }
 }
 
-- 
2.53.0

