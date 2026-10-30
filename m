Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380424;
	b=KnfrkcIprkznjlxzJYe7rXy9xp6qxqCoTgoYds6u6jWnSccKYFloAALH7OCnC3VCBleA
	 oPNTEA6EVvWPSxxD72+OEQBYxsnju1xPRov9Y3f1AdxT3RMISQgx5/rcWy+DgsEniyj7b
	 rsrgpjilKA9VknWU07qzsJc9801CInDVYJ2j+ptZhhWMu+LNk21ws5PXi+WCIzYO6LOO1
	 WF2m8+orwme8aGIkj8tHewGXj95l8/nSSYTa1cxNEOWdrHZDb89TlaemuPS5v9P4QQSc0
	 L7nQODfyruZS77XND9lLP+7KoMQTbTehSikBntArBpBXWAMFOCybRYuV71sOPvSDkBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380424;
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
	bh=K2z9G3KUDjzHENYpfBwpbqIbzJwr7EbXGO9Q/HtmYAs=;
	b=EJZfsQU42LMhB69BBqqaqOn4dALPtP+p1mzOQYCUtuhwwdFiG3gluZNlyqEIEX99V8Hs
	 zINwKobp0LNDaE3Pkl3IxoGltG+ZLeEAbq5a/hb5AWsHNaa910R03WV+Uuwu053jJb/F1
	 MLYlcXMuneeO+FKCGzqNQ0Bqmmw//22fSBOXQO4StwiPpAwXHvNTY3AgtWGmBpyfoEq4X
	 Yk3EsMkTzzji+sxyekjpfBDZjuhz6h36PTcADRcqL2rjPzPgDEH2VWAxyzgWFBWRLxgXT
	 1JyR3sdjSR6kfNojtw1lKx6b/UyBe05A/9RC/WrAp5PYL7lQcBIIBp/nPhwua0k1Wzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hL0z79xv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.50
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2A606A32A;
	Fri, 30 Oct 2026 17:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC2A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hL0z79xv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSybnpRbZ40Ihkc0ecHIHm6r3evNn6lLW7yVwoyJUfo/MycCVM4ZdE5iArO8ru6sOwRfIS+LF4wurHITxYgOEM2Z+hkEjmOFFfDqEnmjNbx2L8B3Em5r7MaRt1XaDIumUImKpRQJ8at2A3WcdAoCmck3ONWRz3uRFu4c8Q7EdUvk70TULnGCUsE2cFj8xJ9z87fopyS+ND5dFHhwseeId4swxacIzeRG6uiZKQ4V0P33LRi132QS11SknwjpKOpFaDYclQ88dBeZzfZEdFoVVDivyw90aduSLT19EI6AbX7ke0bqIl9mJ5CXyuHf/FuF76f9Grn9M1rT0lMG82WXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2z9G3KUDjzHENYpfBwpbqIbzJwr7EbXGO9Q/HtmYAs=;
 b=ZhZrzq2nHh5EdeWqO7tijH2G9dW/bpU1s+qk1IBZ+gLuagcr8YcNEtKKTPi2+DJKXnCqgPFyXGr6FMicx2pJtSUiz4oVXU801XWfjnlC4oyoNcl+tEtPB/s+RqGCFBiJGHXnTbaYjIu7ycDGrq1um0TUSdimAVLUBMzpgvNKqh0KBFOvJa37B0h4xikJmoqvF3wRZwibm8L197KlkgfylpNaxDx7kkzeY1/PBfzBaENKGkPnPmG365K3WBLc+uYQb+PeIiqikyKARjCTllbtDFVQdJaqzSH/+SpQyzrh0X/MnufCJ5D/E88eT2Usoi28kukpiqrKIuwqUFQRqQRLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2z9G3KUDjzHENYpfBwpbqIbzJwr7EbXGO9Q/HtmYAs=;
 b=hL0z79xvkLwzr8Mkw1s9ygSXddOapz8TxDZUuuKc6taQP40J13ycjZy7ebEDwoxk/v74KD6vcGuvErjAxZNH6sCFP4X/BG5a8CnW4YxymP1RPXkR8XRPRR7qYm6EDYc0Ig/pgd+zYbebBRo8b92/wqqGfnXcXO9bywid8nEhBL2z2xp3WGFPdS6fKFgpeV9Qy1FheLWnQa6f6Mi/zmQX3ZZ8VYjL2RrRLbvD8sZ2eSNzCG4ZPHkcvtPZDWkNaCLVUplBNCVwmP7yIrOJcYnnJrHM1/s6rsfabGB43dI7ZPbhk5PpUqSTj2plxzDjtyNwRYVMwib7sK1nkaCHqKwLPQ==
Received: from CH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::17)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:13:34 +0000
Received: from DS2PEPF00006E25.namprd05.prod.outlook.com
 (2603:10b6:610:ef:cafe::55) by CH0P220CA0029.outlook.office365.com
 (2603:10b6:610:ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Fri, 30
 Oct 2026 17:13:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00006E25.mail.protection.outlook.com (10.167.23.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 17:13:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:13:10 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:13:07 -0700
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
Subject: [PATCH v5 6/9] rust: pci: add typed SR-IOV PF registration data
Date: Fri, 30 Oct 2026 10:12:24 -0700
Message-ID: <20261030171230.196717-7-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E25:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e45531-bf75-43d5-e94c-08df36a9216a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006|5023799004|261026121527099003|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	5kVjLOk6r1/lyhDrEqcLoACiC/WqfnKk6Qt9I7/VFC1CLHnusUKndc3I/YAJGthMN5Tmo3+yMeu9kBfijEf2aKEHhFQG/u2Iqi9cqho+Jm+wmDURdg6VXJ6He4RMLnuJsHclgKUdz4TLS9bOiQsw7RGjPn59huxfUbRNsBvNDWJIMZxvY3Ql2dwVlCT8yfn6wNd6LFfke2Ga5+D9ypFZiGQpoyNmVnR18rWOkMTIonhIZD23a0K1kWmdd/cOP0Lh3VGfovtWE+cxJXlKl1SaDHhyb97vl/0a0F+HQ2wkmZvXpAL5UqnfjJW6UtUa5EVRwfSN1ex2wJFm6/D2Yf2pDTEzX1FWiNAJAVY+Cg1uRu2RVUkYoDF9R5KyzUcgpxlezan2mSIbQwa6/VgC9FW3eP01WV748WPjFlKjnXCpuYug/Y7nmjyUcPgEnjU8HtFYrVRysX5gmnQ9UvFOWDYPCA3NC2RMVQqRxLbSRmW9nCh1GgCNQIqmYtRUjyTmG5Zch//pXGxdU/2t0lWKOif1j/Qlrwp9qpz13dI0Ot0W+7Zy1ULo0zB0aV5LfErv+doZ69VCCpLSmV78yix1v6JoPkPcVdoFlBtKHfFA1gNshG4zr+ZShx4dlH8dkRLt1Ouz3pA3kMpfCjX2Gdd09/Au7TbDG7kDH6SrLKgF5ChxEyYs8VaWwbKotkR6WM5uuoXxAol1Evm8bKfrYYu1mJUGVw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(5023799004)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T9WDD+UBOkv+KKOjOeKKQV37cX16Hwl5YpVtyZd12Lm4xMdx2/ej4W0PI+LwtFWo3tKEaRQJ8+hXJDYww4uviK4KE8SZZ/Jy5mYFQButAQkDGbEleQUG3U3jK51Io8O93CV6fiQ7MQ5qx389NqJAeZeD26r7sHmJ6z/xhvCmn/+8QaWdAdrqjMH+R4KPVT5Uq5Kc9Q73u4U6vrv1xMSxNW/7xYaSrTpMnjOHDqn1u/eItncctdJVJz1BeyIES9Xt4gveGd0TsoEX33EYUKK/UOw9k3ffK6dSoSfbZ+R/CDFOGpF6eZL1X413GIZiZRaSzL1lfpPwxtnFzRAlCdzVNaWbrS1xmeDC0LCOk0Ew9KX1CPFHdoB+J/sz6YOP+Ho7RVKXzg4NKQSZRhcfZMUycxMlHipCwZTZi4sPxh+z2YqltH67LGvpkWZZ0k5AT8qf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:13:34.6934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e45531-bf75-43d5-e94c-08df36a9216a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E25.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215

From: Zhi Wang <zhiw@nvidia.com>

Rust PF and VF drivers bind to separate PCI devices and may reside
in different modules. A VF driver that calls PF operations needs
typed access to the data exposed by the PF driver. This data must
remain valid until VF driver removal completes.

Add VfRegistration to register a pinned object in the PF's private
data. VF drivers can borrow it after checking the requested Rust
type, using a higher-ranked closure or a covariant lifetime encoding.

Capture the core callback context in the initializer. Reject active
VFs and an occupied registration slot before initializing the payload,
then recheck the slot before publication in case the payload initializer
created another registration. Publish only after all fallible work.

During registration teardown, disable SR-IOV and wait for VF remove
callbacks to finish before clearing the pointer and dropping the object.

Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 include/linux/pci.h    |   7 ++
 rust/kernel/pci.rs     |   2 +
 rust/kernel/pci/iov.rs | 205 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1..9b6ae544469 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -551,6 +551,13 @@ struct pci_dev {
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
 #endif
+#if defined(CONFIG_PCI_IOV) && defined(CONFIG_RUST)
+	/*
+	 * Private data owned by the PF's Rust driver, readable by VF drivers
+	 * through the PCI VF registration data Rust abstraction.
+	 */
+	void		*vf_registration_data_rust;
+#endif
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8092f56ee2b..83d62f95b7e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -60,6 +60,8 @@
     Extended,
     Normal, //
 };
+#[cfg(CONFIG_PCI_IOV)]
+pub use self::iov::VfRegistration;
 pub use self::irq::{
     IrqType,
     IrqTypes,
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 1ff0ce94f16..83fa1ecfa50 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -8,7 +8,15 @@
     bindings,
     device,
     error::to_result,
-    prelude::*, //
+    prelude::*,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    }, //
+};
+use core::{
+    any::TypeId,
+    marker::PhantomPinned, //
 };
 
 impl Device<device::Core<'_>> {
@@ -57,3 +65,198 @@ pub(crate) fn disable_sriov(&self) {
         unsafe { bindings::pci_disable_sriov(self.as_raw()) };
     }
 }
+
+/// Wrapper for VF registration data stored inside a [`VfRegistration`].
+///
+/// Stores a [`TypeId`] header (derived from `F`) followed by the pinned data,
+/// so that [`Device::vf_registration_data_with()`] can verify the type at
+/// runtime.
+#[repr(C)]
+#[pin_data]
+struct VfRegistrationData<'a, F: ForLt + 'static> {
+    type_id: TypeId,
+    #[pin]
+    data: F::Of<'a>,
+}
+
+static_assert!(
+    core::mem::offset_of!(VfRegistrationData<'static, CovariantForLt!(())>, type_id) == 0
+);
+
+impl<'a, F: ForLt + 'static> VfRegistrationData<'a, F> {
+    /// Pin-initializer for the registration data.
+    #[inline]
+    fn new<E>(data: impl PinInit<F::Of<'a>, E>) -> impl PinInit<Self, E> {
+        try_pin_init!(Self {
+            type_id: TypeId::of::<F>(),
+            data <- data,
+        }? E)
+    }
+}
+
+/// SR-IOV VF registration on a PF device.
+///
+/// Owns the registration data that VF drivers access via
+/// [`Device::vf_registration_data_with()`] and [`Device::vf_registration_data()`].
+///
+/// Drop disables SR-IOV before clearing the registration pointer and releasing the data.
+#[pin_data(PinnedDrop)]
+pub struct VfRegistration<'a, F: ForLt + 'static> {
+    pdev: &'a Device<device::Bound>,
+    #[pin]
+    inner: VfRegistrationData<'a, F>,
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+impl<'a, F: ForLt + 'static> VfRegistration<'a, F>
+where
+    for<'b> F::Of<'b>: Send + Sync,
+{
+    /// Create a new VF registration.
+    ///
+    /// Returns a pin-initializer so the registration can be embedded directly
+    /// in the PF driver's bus device private data.
+    ///
+    /// # Safety
+    ///
+    /// The returned registration must be embedded in the driver's bus device private data.
+    pub unsafe fn new<'core, I>(
+        pdev: &'a Device<device::Core<'core>>,
+        data: I,
+    ) -> impl PinInit<Self, Error> + 'a + use<'a, 'core, F, I>
+    where
+        I: PinInit<F::Of<'a>, Error> + 'a,
+    {
+        try_pin_init!(Self {
+            _: {
+                if pdev.is_virtfn() {
+                    return Err(ENODEV);
+                }
+                if pdev.num_vf() != 0 {
+                    return Err(EBUSY);
+                }
+                // SAFETY: The core callback serializes changes to this device's registration.
+                if !unsafe { (*pdev.as_raw()).vf_registration_data_rust }.is_null() {
+                    return Err(EBUSY);
+                }
+            },
+            pdev,
+            inner <- VfRegistrationData::new(data),
+            _pin: PhantomPinned,
+            _: {
+                // The data initializer may have registered another object on this device.
+                // SAFETY: The captured core context still serializes registration changes.
+                if !unsafe { (*pdev.as_raw()).vf_registration_data_rust }.is_null() {
+                    return Err(EBUSY);
+                }
+
+                // SAFETY: The data is initialized and pinned, the slot is unoccupied, and
+                // no VF can access it yet. No fallible work follows publication.
+                unsafe {
+                    (*pdev.as_raw()).vf_registration_data_rust =
+                        core::ptr::from_ref(inner.as_ref().get_ref()).cast_mut().cast();
+                }
+            },
+        })
+    }
+}
+
+#[pinned_drop]
+impl<F: ForLt + 'static> PinnedDrop for VfRegistration<'_, F> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: `pci_disable_sriov()` is safe to call on any `pci_dev`; it
+        // is a no-op if the device has no VFs enabled. When VFs are enabled,
+        // this blocks until all VF `remove()` callbacks complete.
+        unsafe { bindings::pci_disable_sriov(self.pdev.as_raw()) };
+
+        // SAFETY: The device is valid and all VF remove callbacks have completed, so no VF
+        // can access the registration pointer. The data remains alive until this returns.
+        unsafe { (*self.pdev.as_raw()).vf_registration_data_rust = core::ptr::null_mut() };
+    }
+}
+
+// SAFETY: The inner data is `Send` (enforced by the bound), and `&Device` is `Send + Sync`.
+unsafe impl<F: ForLt> Send for VfRegistration<'_, F> where for<'a> F::Of<'a>: Send {}
+
+// SAFETY: The inner data is `Send + Sync`. `VfRegistration` doesn't expose mutable access;
+// VF drivers only read the data through an immutable pinned reference.
+unsafe impl<F: ForLt> Sync for VfRegistration<'_, F> where for<'a> F::Of<'a>: Send + Sync {}
+
+impl Device<device::Bound> {
+    /// Internal helper: reads the `vf_registration_data_rust` pointer from the
+    /// PF, checks the `TypeId`, and returns a pinned reference.
+    ///
+    /// # Safety
+    ///
+    /// The data lifetime must be hidden behind a higher-ranked closure independently of the
+    /// reference lifetime, or `F` must be covariant in its encoded lifetime.
+    unsafe fn vf_registration_data_pinned<F: ForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        if !self.is_virtfn() {
+            return Err(ENODEV);
+        }
+
+        // SAFETY: This bound VF uses the `physfn` union field. PCI retains its PF until
+        // VF removal completes, and the PF keeps the registration installed until then.
+        let ptr = unsafe {
+            let pf = (*self.as_raw()).__bindgen_anon_1.physfn;
+            (*pf).vf_registration_data_rust
+        };
+
+        if ptr.is_null() {
+            return Err(ENODEV);
+        }
+
+        // SAFETY: The registration keeps its data installed until VF removal completes,
+        // including when probe initialization rolls back.
+        // `ptr` points to a `VfRegistrationData` whose first field is a `TypeId`.
+        let type_id = unsafe { ptr.cast::<TypeId>().read() };
+        if type_id != TypeId::of::<F>() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: TypeId check confirms the stored type matches `F`. The data
+        // is pinned inside the PF's driver data struct. Lifetime shortening
+        // from the PF's binding scope to `'_` is layout-compatible.
+        let data_ptr = unsafe {
+            let vfrd = ptr.cast::<VfRegistrationData<'_, F>>();
+            &raw const (*vfrd).data
+        };
+
+        // SAFETY: `data` is structurally pinned inside `VfRegistrationData`.
+        Ok(unsafe { Pin::new_unchecked(&*data_ptr) })
+    }
+
+    /// Access the VF registration data through a closure with an HRTB lifetime.
+    ///
+    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. Returns
+    /// [`ENODEV`] if this is not a VF or no data was registered,
+    /// or [`EINVAL`] if `F` does not match the type registered by the PF.
+    ///
+    /// The reference is borrowed from this VF, while the registration data's lifetime remains
+    /// abstract so the closure cannot store shorter-lived references in invariant data.
+    #[inline]
+    pub fn vf_registration_data_with<'this, F: ForLt + 'static, R>(
+        &'this self,
+        f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
+    ) -> Result<R> {
+        // SAFETY: The closure is higher-ranked over the data lifetime, independently of `'this`.
+        // It cannot insert shorter-lived references, and the outer borrow cannot outlive this VF.
+        let pinned = unsafe { self.vf_registration_data_pinned::<F>()? };
+        Ok(f(pinned))
+    }
+
+    /// Returns a pinned reference to the VF registration data.
+    ///
+    /// Available only when `F` implements [`CovariantForLt`](trait@crate::types::CovariantForLt),
+    /// guaranteeing that shortening the PF data lifetime is sound.
+    ///
+    /// For non-covariant types, use [`Self::vf_registration_data_with()`].
+    ///
+    /// It returns the same errors as [`Self::vf_registration_data_with()`].
+    #[inline]
+    pub fn vf_registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        // SAFETY: `CovariantForLt` permits shortening the encoded lifetime to this borrow.
+        unsafe { self.vf_registration_data_pinned::<F>() }
+    }
+}
-- 
2.43.7

