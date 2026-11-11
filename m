Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436477;
	b=c3OwBsq6/uqDdDXc5ucyKuahJXSCa6MG6NvjOnBa26j8XA5FgSnIuIBc61HhWLUjyTpy
	 29BWhFtXqJhMzibcSk950imkj4MURHIKHNpye0APTR0KTvMZTMs8Tt1SUjrTt+m7dpE8y
	 zBQj3fXRzz4MRy8avW2NykAmr53JQNm8IYtz7X7D6cTyZpDmYYQRQeBmI417wgRKYJiRu
	 OOOoR3Om+kexfHexc5WI1ajL/Zar9k5DF6YrnkcOBkiQo/jXGXA9gpzXLfE2UKZLcXI5X
	 6bjjBndBipzXQViT6Qp3KYnrw2CD24VNkx77HFvuI0bsQ9XYRxlJtzqJbY7gdMkdgew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436477;
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
	bh=x/6Fo0cI6HFSavEXyy11EkSOhF3m9/0xfG1iteUzLNA=;
	b=EhXWwNMEQiU9BFIofSWF4Z+PgJ6EV+NI/DBLiCkC54cYx76FdgMRs/sj1RTLPzSbcX5d
	 gUlWGkY40rjbi2kB+NNIPaUvgc8To/jWY4v30X04QIKGUSQGGS3Pup0KkYPMxNE+rAE49
	 GkWrVrrZjQ5dxR/sMpK7Y0yzrjzMG3BxyYFBI/ZIwcAP6JZHTQk25VgSwSeuezZQaGxVY
	 TdcavuQntIlNUWJjWsrnybxGg6fAR7jaeUn4C0KKwZ9lIHubr1U03MxruZuvRE57QxhTb
	 Smj1xL9zbfMLIYIdFvuGPK5DUAiVZq7qunsSa1sreQUBBPQQ+CezmpOGw0yk6HBC++g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cxhI2rpF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.25
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36C606A887;
	Wed, 11 Nov 2026 22:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E36C606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cxhI2rpF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNeIpRvZQiqLwN0KuT8n43BXLmMuZfAf22Di00XzkRRBbMgEj3xc1oHJXcCaZethw6aDAG/yJwJAJrUWtqX7EXMsbiUKy91ZmOFaD1hI05pkZNikm+keFdXCflDFUmozv2yZonCoJZWSQmVgLiubzXg2uJ8ppxyG3NRY5X/l0jomFpHRN2Of53B1OU8oIcyyVXTllzZAtstPIxA/3r0c5HCpzv7re4cUPGAW/LWbr4zj+cRbebaIdmLHwqEa1YGyCUyuSiOCoBgCpVr2qjSS7ZZHXVa/YhXiPaHUx47j+zSUDZkDu5h8MTejhsbZ19f1gl70K6Tz523ZWfk82oxQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/6Fo0cI6HFSavEXyy11EkSOhF3m9/0xfG1iteUzLNA=;
 b=d1UJW9LQhwH7rlXtlHIl4KC0T3QzIr6OyqO5OWPkGEs4wPnD5Mk2gWqfPicQWIQYDMqZGrOaW1oLio1aEYiudz0K0k7V8ZiXai5gX3ojdTTb1c0af64cJiIFMPnTaGsIKnKWOvyTjnwNreiLlABQbSlmMr7rK7Ezv8Jm2kN7LeveejI7z6y3qa1xNjDOW9hPpF2jav1WMwMsq3a6Ir1C7xdsSt0S3EKWswQheuO2WAHF+04b1foWwgJuzmYNGY9H0lhSqBKL7XhEGh6Iw0lFtRfNpUJMtyLNoF083zVJHypEgP53VkwoO5KfNtV7vykof2VRXsHLwNZhpG9EPWdfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/6Fo0cI6HFSavEXyy11EkSOhF3m9/0xfG1iteUzLNA=;
 b=cxhI2rpFJnKCZpVzyrpI0Wqy7OEhksDxw0NecpgMBxJCpmMlUGGcO03IAkhWoHZ23bj/eM+V/SVbY+uKnLqCDhAHJHXLz+W/8BCGg+EIfpJapK7U1aP8EldQzj7aAgVmOYWleVLskVctEYfHBg6mkAqV5ztTorSlqbAzFpmcz75D6AyW2r0UX3Ex386qkwgDitRZnd8PTBJxfklNa9i4Wr5+79XHRKjOeLmWqGp5l1+P/7Y9xwXCSUZN0zoM7TYhr3uKdT+5oZVHU8uLglkED6+iiy+6T/ytJXQDLl4/Id7Zi/pgb2hKv3mfqoRnifCbSQ00IT9NGDcryEj9D6y1Ag==
Received: from PH8PR20CA0006.namprd20.prod.outlook.com (2603:10b6:510:23c::11)
 by IA3PR12MB773567.namprd12.prod.outlook.com (2603:10b6:208:706::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:34:31 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:510:23c:cafe::ac) by PH8PR20CA0006.outlook.office365.com
 (2603:10b6:510:23c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 22:34:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:16 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:34:13 -0800
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
Subject: [PATCH v6 07/11] rust: pci: add typed SR-IOV PF registration data
Date: Wed, 11 Nov 2026 14:33:32 -0800
Message-ID: <20261111223337.508989-8-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|IA3PR12MB773567:EE_
X-MS-Office365-Filtering-Correlation-Id: 173a21de-7a8b-4e40-93ff-08df4043f411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|5023799004|261022105027099003|261022075727099003|261026140227099003|261021123027099003|261026121527099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	osbXbPANDgbXtVqpYeliE9wQo3HSTDdfUuxDNlw44/FEmqj7MEA8X1IaUPuPnFxS6c/RZtBuzZt/fvT6Hc3ihNW6jdzIfhgnUOiFgNNKCnAAsi0dAqpCPy/mbncZoYs+jxcIKEjohfoGgmjX+s1Dal/cCP+vNt8yXyVKlNz7wicLnnYQFz8/enApQBe/Oy98+jd0MXhQNONuYOHdf7JNx+MD8Ou85j85sgAUDrCDEXyNXurblfxixyGuZam2HJ57vZjD05V0hm6BYh/45mPh2qAVSehY85esRk3HSqEYWFwRW3REbQvW1bp9TMP6YAXjHwfAKwsJgFNKFeAOGQgkNnsByw2oX3D/o93AT57oAOf9KtY4+IMiKN8mAtH+0K+G38sGiIr4cJY5Dw0n4FeD+gb3U6fK3JfZlX6iOidVXs3nTZPZ3E35sYgxLT3IxOIt8XnckNsqv8BCrK9SNMzHMYs4OGUa6dgyFJG4X1DBk6/FzumveBg4MasOeiQiaDPqRd7HJYq+AqOMFqnQUTsJJTqrsxV2BSoKiTow0t1OUivKE9OB1Pa/o4MjHQdQOGJbUE98ytzxvVG8yj1XxlCiYy5EJBPO0IqDsVP20zcuETBG7A5SRh+X1cImYrXZYOcVdhO1iptBgEdrAK1JaB9+c4svmIb+9WLkGOXG5b/lPECYGGKCYexsbW/QXRXPPUTzd9OY8n50B6/DwIRBXsznHw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(5023799004)(261022105027099003)(261022075727099003)(261026140227099003)(261021123027099003)(261026121527099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZoOL6nftHB9bFZciJumUWW0XI66Z0te/seFQleQYDHXMjJ2bN5fATcGVpjwdeTV+f9GOP+FIG9GOkfWHKzFfiQZ8/0/9aE4PxWHwjUDAai//fuCZe54gnJfUT4eiMhazs0HBU9s3zFDIDpDnIyFJNo9k2X3yuqiTfllzT7oxx6FS+VzfZG4xs8ajOz0s3q5ljcoQe3ZOOdXrELucJZK6ZnZWNYdei7WXzL+EvvDxyG3wCgqw/uEpxmKi2Hg1qpdMMAng5YWQPwqvpj3iBoj4yDQfn2Q+VukWZl+ZxoU9TVWgg3w8E0lKs7Hk+PFKxF4/ijx2nw51XvDLxLxE1uwChUbZJmxo2JuFjKkRo0vDKgQwMghHTwOKXvW0aLPJPBK3X0W9nHleJ1CdGi1fJ8IdoraZpcUjYESgIbAx27yCAM3SqeaXEcFn/GBUppXoVvvw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:31.1378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173a21de-7a8b-4e40-93ff-08df4043f411
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB773567

From: Zhi Wang <zhiw@nvidia.com>

Rust PF and VF drivers bind to separate PCI devices and may reside
in different modules. A VF driver that calls PF operations needs
typed access to the data exposed by the PF driver. This data must
remain valid until VF driver removal completes.

Add VfRegistration to register a pinned object in the PF's private
data. VF drivers can borrow it after checking the requested Rust
type, using a higher-ranked closure or a covariant lifetime encoding.

Keep VfRegistration usable when CONFIG_PCI_IOV is disabled so PF
drivers need no configuration guards around their registration field
or its initialization.

Capture the core callback context in the initializer. Reject active
VFs and an occupied registration slot before initializing the payload,
then recheck the slot before publication in case the payload initializer
created another registration. Publish only after all fallible work.

During registration teardown, disable SR-IOV and wait for VF remove
callbacks to finish before clearing the pointer and dropping the object.

Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com> # include/linux/pci.h
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 include/linux/pci.h    |   7 ++
 rust/kernel/pci.rs     |   1 +
 rust/kernel/pci/iov.rs | 258 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 265 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..01b82f6561ce 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -552,6 +552,13 @@ struct pci_dev {
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
index 75d764975a4e..033c49363d1e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -59,6 +59,7 @@
     Extended,
     Normal, //
 };
+pub use self::iov::VfRegistration;
 pub use self::irq::{
     IrqType,
     IrqTypes,
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 78e279169be1..3f4414aa7d36 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -8,8 +8,51 @@
     bindings,
     device,
     error::to_result,
-    prelude::*, //
+    prelude::*,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    }, //
 };
+use core::{
+    any::TypeId,
+    marker::PhantomPinned, //
+};
+
+/// Returns the PF's registration pointer, or null when `CONFIG_PCI_IOV` is disabled.
+///
+/// # Safety
+///
+/// `pdev` must point to a live PCI device. The caller must exclude concurrent changes to its
+/// registration pointer.
+unsafe fn vf_registration_data_ptr(pdev: *mut bindings::pci_dev) -> *mut c_void {
+    #[cfg(CONFIG_PCI_IOV)]
+    {
+        // SAFETY: The caller guarantees the device's validity and excludes concurrent changes.
+        unsafe { (*pdev).vf_registration_data_rust }
+    }
+    #[cfg(not(CONFIG_PCI_IOV))]
+    {
+        let _ = pdev;
+        core::ptr::null_mut()
+    }
+}
+
+/// Updates the PF's registration pointer, doing nothing when `CONFIG_PCI_IOV` is disabled.
+///
+/// # Safety
+///
+/// `pdev` must point to a live PCI device. The caller must exclude concurrent access to its
+/// registration pointer and uphold the invariants of any published registration data.
+unsafe fn set_vf_registration_data_ptr(pdev: *mut bindings::pci_dev, data: *mut c_void) {
+    #[cfg(CONFIG_PCI_IOV)]
+    // SAFETY: The caller guarantees the device's validity and exclusive access to its slot.
+    unsafe {
+        (*pdev).vf_registration_data_rust = data;
+    }
+    #[cfg(not(CONFIG_PCI_IOV))]
+    let _ = (pdev, data);
+}
 
 impl Device<device::Core<'_>> {
     /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
@@ -59,3 +102,216 @@ pub(crate) fn disable_sriov(&self) {
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
+///
+/// When `CONFIG_PCI_IOV` is disabled, the registration still initializes, pins and owns its data,
+/// but does not publish it to VF drivers.
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
+                if !unsafe { vf_registration_data_ptr(pdev.as_raw()) }.is_null() {
+                    return Err(EBUSY);
+                }
+            },
+            pdev,
+            inner <- VfRegistrationData::new(data),
+            _pin: PhantomPinned,
+            _: {
+                // The data initializer may have registered another object on this device.
+                // SAFETY: The captured core context still serializes registration changes.
+                if !unsafe { vf_registration_data_ptr(pdev.as_raw()) }.is_null() {
+                    return Err(EBUSY);
+                }
+
+                // SAFETY: The data is initialized and pinned, the slot is unoccupied, and
+                // no VF can access it yet. No fallible work follows publication.
+                unsafe {
+                    set_vf_registration_data_ptr(
+                        pdev.as_raw(),
+                        core::ptr::from_ref(inner.as_ref().get_ref()).cast_mut().cast(),
+                    );
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
+        unsafe { set_vf_registration_data_ptr(self.pdev.as_raw(), core::ptr::null_mut()) };
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
+    #[cfg(CONFIG_PCI_IOV)]
+    unsafe fn vf_registration_data_pinned<F: ForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        if !self.is_virtfn() {
+            return Err(ENODEV);
+        }
+
+        // SAFETY: This bound VF uses the `physfn` union field. PCI retains its PF until
+        // VF removal completes, and the PF keeps the registration installed until then.
+        let ptr = unsafe {
+            let pf = (*self.as_raw()).__bindgen_anon_1.physfn;
+            vf_registration_data_ptr(pf)
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
+    /// Returns [`ENODEV`] because no VF registration can be published.
+    ///
+    /// # Safety
+    ///
+    /// The data lifetime must be hidden behind a higher-ranked closure independently of the
+    /// reference lifetime, or `F` must be covariant in its encoded lifetime.
+    #[cfg(not(CONFIG_PCI_IOV))]
+    unsafe fn vf_registration_data_pinned<F: ForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        Err(ENODEV)
+    }
+
+    /// Access the VF registration data through a closure with an HRTB lifetime.
+    ///
+    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. Returns
+    /// [`ENODEV`] if this is not a VF or no data was registered,
+    /// or [`EINVAL`] if `F` does not match the type registered by the PF.
+    /// Returns [`ENODEV`] when `CONFIG_PCI_IOV` is disabled.
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

