Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380544;
	b=tVrr2uNFGGvlg6CPbkFf54L6dezY5J8sNMY6WQ/aRq4QxPo80EF1A8n1QFN1T0CceWEg
	 jbLUAV/+iBcDWypQdRD713DVZkDG+FNI0Q+OcEEJhVhTZvkjFx9Xj4zFOffBgs442u3nN
	 Sb6HG3jtQY0Vr+Csqh09EMVJvdQs02fYK2f/4VmPCv/kGZd37xT9mf9inwrGlaslfMJxV
	 4+jbcnAhS/DRgkIRgjISPeGfojqso8dOo61fRMJOU9tY1qglfbF2CbKHwI9FC+StkyATc
	 cCPeWjFx5qxuGRvK8S60KNLbTp9RzLI+v01+7cck9HvAHwCkGHsTfM8DK5mjNvqW+uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380544;
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
	bh=Hxr9OtDTaR7N43G3V9vzGZ3Op3q+AGkrqE05PDmE40Q=;
	b=rhiRvZhqtsy2AQ2YdNBR+EAt5BOfRLNTqmbZuhIa16XpP9riL0OWLCI7yiec8jdkHG1u
	 XT9puWdvVTNqtDjhukKXqQ0maOlRhyJIunuHWExDL7+7eRzAPrpAfZLB8SzHHUtjXJMh8
	 rs5lBhO+nvsyVv30cSNcZpz0uxMa2KbHSZH+SpSbNZcXFLSxXcHdwFwQh3LK5Cq2sOPNs
	 r8zG7Zs0ZD+e7sG6AzwzBZGYYkKKYKb6iVkAdgpkdXNv7CRKjaWEoxnUyI3S+s6KeCdvY
	 WcDTLaC2B45jKjE9oX+qG8y75bMTO040okOl8LQpOPN5BhswKGGFHupx1h+YJPDqW7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sznPELMH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.69
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17224606A31A;
	Fri, 30 Oct 2026 17:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17224606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sznPELMH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoA/+cAHwIaIL928Mt9RM4dKh8cab80eCkPvUu0bpfzkHxEPi9fJyvx2RwkOU0C50vcnRVyZCvUwsj/4YBYc2APiP8sTgaKFEHZlyfpl0cl38CloHZGfiTuPHyXWP6LrIeef/5c/cackqpKnYCFYFiVMPNUTECHow/7fYvarALM11/yUU18cFZ8opuhc8Vu7RUtSOxasv6NXg3XtBMGUg+s0aD+k992Y/wOcxk9ZbL2S5VWIi9L1FEaVzprDWu8KbWba5oDy+VsqlFtGpEbsVNtDA0Xnlr71mXt69hCMHCDX9z+nF4UY8Tn7ae4Y1wh0awuyyB/5DR6XFpxBkeFrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxr9OtDTaR7N43G3V9vzGZ3Op3q+AGkrqE05PDmE40Q=;
 b=IdSgGb7FDgT8rx1bFltrmMh0uQ1lXn5gEoHE10i1ScVsuff+kJ9n/lTiHhAPlCCf8ph39uwvCfZE4MrfDItwDN+nEHCGPPGJ4VhF05vyXtP/cZ06pzFiIyAABfir17xnaMEoV1IVYjf9RANJLzAVuRaWyLleDitafr4Bz7rLSQ8qNQLDO43U38THtcMHomRIFqDEMGeY6XRg7itKgFDUirWAU84uhduxMRqQ5GJ6JRKdZmeB/2e41RxO+/dRMFcpmAvsis5T4MZB3njRdtwqcxCq/P+DWH8QcRHEet3t3Ok+YHeAZPM4E3zR98L5OJ4auLnLfjAKtOlpk7ZlM6nDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxr9OtDTaR7N43G3V9vzGZ3Op3q+AGkrqE05PDmE40Q=;
 b=sznPELMHH24bMkjT1bSImFES0/axMAhIRMqDsDqNF6nZ7LVHa0JnwWUmkGWdhUeLYVGMy5qEaUNP9B04ZwlHUeUCjIABSvPGx0EAEhGo2iDYP+1CommmITwMjymVfumJQf56BmOZ4u/u0QY6YHbIvb/S4V+FH25rzNKeiZSw/SN2PrNS0vXnHHZ2Ap4A22pSg4FGQKygjX2xzAM4b+VMpLmUsijvfYAjRQL/x1abHgwsJQ5VESn66plTt9oVfRgtrY6YPLZcZ/+2+w+vUlM/Stv8F8Nef0bC640VYBe6RXv0c2X4g0KZlTsooPiAWdGZ0PHSvZ1Slb4oQhXN830HkA==
Received: from DS7P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::10) by
 SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:13:39 +0000
Received: from DS2PEPF00006E1F.namprd05.prod.outlook.com
 (2603:10b6:8:25c:cafe::1) by DS7P221CA0022.outlook.office365.com
 (2603:10b6:8:25c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 17:13:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00006E1F.mail.protection.outlook.com (10.167.23.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:13:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:13:14 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:13:11 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
	<apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v5 7/9] rust: pci: add SR-IOV enable and disable tokens
Date: Fri, 30 Oct 2026 10:12:25 -0700
Message-ID: <20261030171230.196717-8-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261030171230.196717-1-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E1F:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e9bdb0-9a38-448a-666a-08df36a9240f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026121527099003|261021123027099003|261009223027099003|261026140227099003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s40bZ/lXbVh7LssN3m4zTwBFTgNhi4MnpoqNBWi5PQYYgF2gq483qdWA6v93oSpyy4YPgZmG1vhXHvyWoFauVkRU3m5tgKAt6U2cskX8QYFEb3f72DLJ9I08R/a3dzewAH2KWB5Bc05cf9oGUyZZ7RloSRU1ZL8AFSeJRYq024HQYSRvAKIg0KQ4gdpE61PGUkDo/DsUhtCnKQoEuzGCgS/CC8KYMfuqRWhv9SKVslvTvHGP27bp1BVirLpWXP3L6FK+ZEGrc37FGbVaKgJ3+d6jjXzPxdYXlhWJ80722do+zzk3tmvNfbBeyXJaGML3Qo/9jBl/qbp2ZU8oaC/6/URQIlueGNtGjWrVU59LIENBxavXmPvkMKtAhOtNhRmxcz62y1UD/owNJs2+F8XaUWnbpwtgiBu8g2qc9QkJOEoSB+Qg+OJZuM8ycr0iYAPI7x+w3djchzYiA7bQyJ6TCuKdK8iMax177CV8cYc6r7pGmtEHoPb5+xcxAq76HikoBDRMVr9mIeviwhPToh65edOjD0hbWaOAn8c4olkMlHJmL8/bTQ3syDRwYiX2hI95WCVhD3L+z3yLIaHF8uKlrOptcN0olbPJDvouZbaoZkUpy8y11+h4vEsEGSv6caq/LOAz7bGfZbRlG5A4mDXUaZ4DsXY/aI9L4SyLH5wCwr29GWV2WTwmwawBGjeXvgBkbWD35+WU8F7pSby62bTD2A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026121527099003)(261021123027099003)(261009223027099003)(261026140227099003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m2NyNGJNmNXAetMf48gMf/OexoF1zSPj1K3wq+voy44kmSlIg867x8a0/JGvQllWoh5K/joqIcwyfOhPpIMOoNrJHsQx/VGFOzqsSrgQE4/kgsV3+EbifQzVM32wUE9ny5drGkBUqq4fR1fjEpAU52B/J51Q9hPxI+RP2wRfV086vHu5uxzV4HGZRPfrXiEikKFNT2Jljy2k/6Y2pH+cxNbg8DaDqi09M0RiJTsFM21llCmA0hnpRCEO4ogwPdupXOSXyIKSghrlF7qHgN4gHLVKSur24bs1kL5RocaiPrpWfOahBuLVv7nnsCeaUktbDjd9rC79a+YmLRsZvSfjL6ZvGcQqspRmR0YV5NOZKaPweVjExR6MSqNzuP2QlO/HKu/cvEMFSTQZjXxoHLIAAnxqj7tjDJRkO2l79SmJxJN6lBbZAqkTLbUKSn4EXzXV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:13:39.1319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e9bdb0-9a38-448a-666a-08df36a9240f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E1F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299

From: Zhi Wang <zhiw@nvidia.com>

Enabling VFs can succeed before the driver's remaining setup fails.
Use a callback-scoped token to return an enabled guard that disables
SR-IOV when dropped, rolling back those VFs on a later error.

Add SriovEnable, SriovEnabled and SriovDisable for the split callbacks
introduced next. Tie each token to its PF and callback lifetime, and
limit the enabled count to the user's request. The PCI adapter disarms
the guard when accepting a successful enable callback.

Require a VfRegistration to own final VF teardown after that handoff.
Drivers that do not share data with VFs can register (). A disable
token permits explicit shutdown without forcing it on a rejected
request.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs     |  7 +++-
 rust/kernel/pci/iov.rs | 94 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 83d62f95b7e..3a768477014 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -61,7 +61,12 @@
     Normal, //
 };
 #[cfg(CONFIG_PCI_IOV)]
-pub use self::iov::VfRegistration;
+pub use self::iov::{
+    SriovDisable,
+    SriovEnable,
+    SriovEnabled,
+    VfRegistration, //
+};
 pub use self::irq::{
     IrqType,
     IrqTypes,
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 83fa1ecfa50..197b0c2bb0f 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -16,7 +16,8 @@
 };
 use core::{
     any::TypeId,
-    marker::PhantomPinned, //
+    marker::PhantomPinned,
+    mem::ManuallyDrop, //
 };
 
 impl Device<device::Core<'_>> {
@@ -34,7 +35,6 @@ impl Device<device::CoreInternal<'_>> {
     /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
     /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
     #[inline]
-    #[expect(dead_code)]
     pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {
         // SAFETY:
         // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
@@ -51,7 +51,6 @@ pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {
 
     /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
     #[inline]
-    #[expect(dead_code)]
     pub(crate) fn disable_sriov(&self) {
         // SAFETY:
         // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
@@ -66,6 +65,95 @@ pub(crate) fn disable_sriov(&self) {
     }
 }
 
+/// Permission to enable VFs during a driver's `sriov_enable()` callback.
+///
+/// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
+/// to another thread, and its lifetime is restricted to the callback. Enabling VFs consumes it.
+///
+/// The callback lifetime cannot be extended:
+///
+/// ```ignore,compile_fail
+/// use kernel::pci::SriovEnable;
+///
+/// fn escape(token: SriovEnable<'_>) -> SriovEnable<'static> {
+///     token
+/// }
+/// ```
+pub struct SriovEnable<'a> {
+    pdev: &'a Device<device::CoreInternal<'a>>,
+    num_vfs: u16,
+}
+
+impl<'a> SriovEnable<'a> {
+    /// Returns the number of VFs requested for this callback.
+    #[inline]
+    pub fn num_vfs(&self) -> u16 {
+        self.num_vfs
+    }
+
+    /// Enables between one and the requested number of VFs.
+    ///
+    /// VF drivers can probe before this method returns, so the PF resources they access must
+    /// already be initialized. The returned guard disables the VFs if subsequent setup fails.
+    /// Return it from `sriov_enable()` to leave the VFs enabled on callback success.
+    pub fn enable(self, num_vfs: u16) -> Result<SriovEnabled<'a>> {
+        if num_vfs == 0 || num_vfs > self.num_vfs {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The PF's driver data and registration remain installed throughout this callback.
+        // The registration owns final VF teardown after the enable guard is disarmed.
+        if unsafe { (*self.pdev.as_raw()).vf_registration_data_rust }.is_null() {
+            return Err(ENODEV);
+        }
+
+        self.pdev.enable_sriov(num_vfs)?;
+        Ok(SriovEnabled {
+            pdev: self.pdev,
+            num_vfs,
+        })
+    }
+}
+
+/// Enabled VFs awaiting successful completion of `sriov_enable()`.
+pub struct SriovEnabled<'a> {
+    pdev: &'a Device<device::CoreInternal<'a>>,
+    num_vfs: u16,
+}
+
+impl SriovEnabled<'_> {
+    #[inline]
+    #[expect(dead_code)]
+    fn disarm(self) -> u16 {
+        ManuallyDrop::new(self).num_vfs
+    }
+}
+
+impl Drop for SriovEnabled<'_> {
+    fn drop(&mut self) {
+        self.pdev.disable_sriov();
+    }
+}
+
+/// Permission to disable VFs during a driver's `sriov_disable()` callback.
+///
+/// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
+/// to another thread, and its lifetime is restricted to the callback. Dropping the token does
+/// not disable VFs, allowing the callback to reject a disable request.
+pub struct SriovDisable<'a> {
+    pdev: &'a Device<device::CoreInternal<'a>>,
+}
+
+impl SriovDisable<'_> {
+    /// Disables all VFs and waits for their drivers to unbind.
+    ///
+    /// The PF resources used by VF drivers must remain available until this method returns.
+    #[inline]
+    pub fn disable(self) {
+        self.pdev.disable_sriov();
+    }
+}
+
 /// Wrapper for VF registration data stored inside a [`VfRegistration`].
 ///
 /// Stores a [`TypeId`] header (derived from `F`) followed by the pinned data,
-- 
2.43.7

