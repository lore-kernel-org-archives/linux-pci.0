Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770090;
	b=xnvgUbHUckm3w9PdaGlOERNzpZadB8lqBYlPg9An6TM1efGyEj8UnFIyDQW9Pfdtu8N1
	 R4VH++yxKfvHXSCOAMAssnXAg7VW+uIYdjTtuvPKQskdrfmDZzqVsiWiLtdMLONse0gkq
	 FzwbIf+MOv5LxTkOMn0hfTSWrAieleFcVVrHWXSPvGa4OyTseqeZU8Tt2RukEz1h4p98m
	 p5rQYl8hSg2ezqEE0EIrk8cGVGpfN2nL/6svYX/RIDKlHDHI2vQt2rjXoblB9YR5mYZEs
	 MIRGOc02t3LjmC4hPKC/3y4IjZ8T9llh47YNQ5a0CERnixF7wrVVSSJKy+9WJeAGdmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770090;
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
	bh=YofhPltgVP+OiGlkHx0znbMPx9OWlqge5VudApLeNug=;
	b=fM8q+of9jKfIyeXPBt5hSFib8LOjWqgmfAJtV1PBYlJco5lKVkPM1Q2j1srhYG5bpJBj
	 caBpgIdhWVI1iUMUorySewhXklIYBRgL0BZp++Mp+bB0lDpZkoVFCS6KXLpWKQ5OQw8oh
	 cw4hzpkc72F7Q5jKcS0JMtmHHNRLvFpbS4XTFAp8AlaJ8ak/0S2aRJgO8wd97A0xAkwRB
	 RPpIz5UDGtloFikTW7SVs8xkiMbSAH4MOhzxX2GfUk0Ez49R+WitAmRRQIHjkh1F58zru
	 rseJ2z4ID9YFAKoQB9m07L6Nu7WYIJ96YorffkIiAsUjQ6L8snpB+6fjqipAR3qjcOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="hih+ev8/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.2
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2160A2602;
	Fri, 23 Oct 2026 15:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E2160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hih+ev8/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJIIEu0glrr6B+xnqfO/FlxsNXsIjyvmwcCUSAspDWvAXLzJfWv5iqfZxQkV77d5SAABDSH4b7r6CL/seF9DsikK8D8M4g77E95H6/r5h7Qb24OkmwD7XX2SHntJ2LK7+GoHvWhO5/F4d0ymJ2xZQLbY4qFeYMp82C0kU3jCJTo2zU+m3K5BUK5ivFWHdaAvqlzQ49UqBeY9c1JOWYPb/OxvewNdLHyf7fWU0AYcVJh3/Q3SNPueu8S3mlWZboOPvwVcPIwfU2Ll2UStUOD0bp1skWWfrPMt3mHjIBhrMNmx8idyGYyBEuIKFfe0NBRuGXw56jjHg5OBZpG4dFrawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YofhPltgVP+OiGlkHx0znbMPx9OWlqge5VudApLeNug=;
 b=y88FM4V1i+FSyjfDUX9R+hF0wHbVpO6xY+yglXkFLlOyZt4ptTqJ2tIQHkFdTHnyR/ruPAHBqxQjHfxNgLHRmYrUJ6T7R/GVss8ZnyA52MxQBbsl1uBuU9VwDhm0zGywJPz6mxUo/zltbTDzDy5JFA16VAN1SgdSFfYWQjUvf5AokNFnw+HGJjGGL/YMnJpXD/WEABvhPZQs3PDmDn5odSbeP7ADa2xQWIh+9URuSKpOD8LemPIPZO7M6vCEoBOpyeyqfSO6zLDYS6BqBz7HueuOXQmHIgpMAH9TCoRVF3vuAbUD+bxkWa0LMVveoTMEBQLcWrlaXRgj/qtJselItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YofhPltgVP+OiGlkHx0znbMPx9OWlqge5VudApLeNug=;
 b=hih+ev8/3qtQAOYLgMXXUVxwEfrxLYvi27krtUIOgckCvUjkPcY0C4JOsaPPe4imX1C1BOzedY/iiqYSwN19IHWUrKCfFLBaiFJ3g3G9UO1huSzc4BpzLgsTSNM2r0z9b43TRE903nnlBHlgKCJEL6jrECw8umw3Bm5w/AZTh9bMa8ZhC2Stmgp7N/JBoiux587hhtGQM9PKj8RHxdk0KF/E0D1VtIN809/HKgJFHUGkfW4VwBWgCoTlHPeqv0Dl+x+p/6z9K2Zgwe05De8WMOleseqABjq/k/mS7dRvcfD6Rdm8rBukq6yd2TmvhxqHvkWLvtUk+J2Xp5mYPEQsQA==
Received: from CH0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:610:e7::23)
 by IA4PR12MB604997.namprd12.prod.outlook.com (2603:10b6:207:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:41:08 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::a1) by CH0PR03CA0228.outlook.office365.com
 (2603:10b6:610:e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 15:41:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 15:41:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:39 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:37 -0700
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
Subject: [PATCH v2 04/12] rust: vfio: add PCI variant driver abstractions
Date: Fri, 23 Oct 2026 08:39:59 -0700
Message-ID: <20261023154009.2246627-5-xinmengs@nvidia.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA4PR12MB604997:EE_
X-MS-Office365-Filtering-Correlation-Id: 79eead3c-d83a-4920-3bd7-08df311c0e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|36860700016|82310400026|5023799004|56012099006|11063799006|261021123027099003|261021121427099003|261022105027099003|261022113327099003|261022075727099003|261009223027099003|10067099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	pNU0iwipuEaSwiuTyxtRjh2oBOLqCkFxlN66sVpupKnZ8Y8KOOOlNZwja6elZP5Q1YgBv0SSMZU3WbEkzeJvj6VT+mvHXLqUH571jZcyFVrHiyVLH/DJckYJEhYGsWUecqouxy/KGj7eaxO5itzNw9hYNlHEZa7uB06Yg5M8C2eJ0YAEx9tCQxl63Z36iCKWVJEL1xlrL8JzgBKsTG57R+F6Vk5Jgq82pOwkIkzTRVp9qJ0Km1b2t8oF0SARScMWmPXYkvAl6cMmlB6fuz0EYhhwiPtAPdxzeXvKh4q8Io12IDsxd04O9dVrXiiP3s+5yKK+Zq+upyaYsQoEK2kONC2NjTXlmdvbgDufq11h3Y2SoV7rCo+BrbVw84TEfMMdYV9LJsEZB7GMSCCCzPcSf0HvyEn8moAuoiDiqdmTUWOtHMgDTWsP/c1pELfR4a7VIc69js6lvz7qdrXTP4R8S97qitK1WySI2VN4To1Qiwg003DY5azr3WJab53lG3al02AQL9lSdBTV89Ef1/r47zLpgpv5N8xn3wZuQpI/dQvyUxUfrjm2xmZzqwZZMFOXHx7C8PymrQYuIYmUMjlIbX85vo4uupp8esyfEnMAdBsLyB+oOiesz8b/u4b8JtjoqkGgvMOhXfgdBNVDijYFNdIKlzFfkUVLPeSpWlw5Fo7vhbJkJcBKDJ7He/ELW9MROExNvmQfIR8sRDcbzGiDrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(36860700016)(82310400026)(5023799004)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261022113327099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gYSS1Q1kwSKrJIIVE1s7XcNAuH8nE2b9vJgtRPbcZZqtIN21Hp+DedyGebE1TsyOat70wX856/gX7sdvHZd0VVZHo/01J193QICntOfaPUwuEDeM+1q3ZM9QOQTpFmUqnD+wbrSDqCqQWp/CDE+bDZwthYA58UhpMxEkKLKdjeEjYLwVeITIXbuTTCibNOz8vFv25kUyGS1R3SC+2X0S+cEvpdywc1ZqGdTHP5pljgxbwFKKh5mrZaCsWgWSte1jMTk0fmh4HLUWYRhcf8tyHEas4nQMu5kXfOauaSo/yX4XbzgcZe7kem5l/5/jKz9bdSjEFBvb+v5B9ICq1dV/LjLwl9JYL70pzqFjP+lY4a5vyvHFA9JaoeLTMt23DT9NBkQnBo5KHeLiYBJnKcvKHvOijcrJz1ZujGlBl6SBGGoXGbg46jK09Tkn3yINDp4N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:07.5298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79eead3c-d83a-4920-3bd7-08df311c0e32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB604997

From: Danilo Krummrich <dakr@kernel.org>

Add Rust abstractions for PCI drivers that extend vfio-pci-core with
device-specific operations.

Provide Operations, Device and Registration with separate registration
and first-open/last-close data. Allow open data to borrow registration
data, undo PCI enablement if open fails, and drop open data before
closing the core device.

Use a PCI adapter to register VFIO after publishing initialized driver
data and unregister it before unbind and data destruction. Route runtime
PM, AER and reset callbacks through the driver's typed registration.
Let vfio-pci-core select its VGA arbitration callbacks.

Restrict core I/O helpers to their corresponding callback contexts.
Require covariant registration data so callback borrows can safely
shorten its erased binding lifetime. Add bounded user-buffer and region
mapping helpers, and wire up VFIO core support for device features,
matching, IOMMUFD and PASID. Allow passthrough devices to export physical
BARs as DMA buffers.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/bindings/bindings_helper.h |    4 +
 rust/kernel/lib.rs              |    2 +
 rust/kernel/vfio.rs             |  100 +++
 rust/kernel/vfio/pci.rs         | 1095 +++++++++++++++++++++++++++++++
 4 files changed, 1201 insertions(+)
 create mode 100644 rust/kernel/vfio.rs
 create mode 100644 rust/kernel/vfio/pci.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 930e63290cd..25ae5d30a93 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -93,6 +93,8 @@
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
 #include <linux/usb.h>
+#include <linux/vfio.h>
+#include <linux/vfio_pci_core.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
@@ -115,6 +117,8 @@
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
+const unsigned int RUST_CONST_HELPER_VFIO_DEVICE_RESET = VFIO_DEVICE_RESET;
+const unsigned int RUST_CONST_HELPER_VFIO_DEVICE_PCI_HOT_RESET = VFIO_DEVICE_PCI_HOT_RESET;
 const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE = GENLMSG_DEFAULT_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f9ef36217bb..261a411ab50 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -146,6 +146,8 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+#[cfg(CONFIG_VFIO)]
+pub mod vfio;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/vfio.rs b/rust/kernel/vfio.rs
new file mode 100644
index 00000000000..ed93066e2da
--- /dev/null
+++ b/rust/kernel/vfio.rs
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Virtual Function I/O (VFIO) abstractions.
+
+use crate::{
+    bindings,
+    prelude::*,
+    uaccess::{
+        UserPtr,
+        UserSlice, //
+    },
+};
+
+#[cfg(CONFIG_VFIO_PCI_CORE)]
+pub mod pci;
+
+/// Reset the VFIO device.
+pub const DEVICE_RESET: u32 = bindings::VFIO_DEVICE_RESET;
+
+/// Reset the PCI slot or bus containing a VFIO device.
+pub const DEVICE_PCI_HOT_RESET: u32 = bindings::VFIO_DEVICE_PCI_HOT_RESET;
+
+/// Capability buffer supplied by VFIO for a region-info callback.
+#[cfg(CONFIG_VFIO_PCI_CORE)]
+pub struct InfoCap<'a> {
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
diff --git a/rust/kernel/vfio/pci.rs b/rust/kernel/vfio/pci.rs
new file mode 100644
index 00000000000..43c14b4e3a1
--- /dev/null
+++ b/rust/kernel/vfio/pci.rs
@@ -0,0 +1,1095 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! VFIO PCI variant driver abstractions.
+//!
+//! Provides Rust abstractions for writing VFIO PCI variant drivers (also known
+//! as "VFIO PCI core" drivers). A [`Registration`] struct owns the VFIO device
+//! and its associated registration data, tying resource lifetimes to the PCI
+//! driver's binding scope.
+//!
+//! C header: [`include/linux/vfio_pci_core.h`](srctree/include/linux/vfio_pci_core.h)
+
+use super::{
+    InfoCap,
+    UserBuf, //
+};
+
+use crate::{
+    alloc::allocator::Kmalloc,
+    bindings,
+    device,
+    device_id::RawDeviceIdIndex,
+    driver,
+    error::{
+        from_err_ptr,
+        from_result,
+        to_result, //
+    },
+    mm::virt::VmaRef,
+    pci,
+    prelude::*,
+    sync::aref::{
+        ARef,
+        AlwaysRefCounted, //
+    },
+    types::{
+        CovariantForLt,
+        ForLt,
+        NotThreadSafe,
+        Opaque, //
+    },
+    uaccess::UserPtr,
+    ThisModule, //
+};
+use core::{
+    alloc::Layout,
+    cell::UnsafeCell,
+    marker::PhantomData,
+    ptr::NonNull, //
+};
+
+/// Index of the PCI configuration-space region.
+pub const CONFIG_REGION_INDEX: u32 = bindings::VFIO_PCI_CONFIG_REGION_INDEX;
+
+/// The context in which a VFIO PCI device reference is valid.
+///
+/// Callback views can only be borrowed from the corresponding VFIO trampoline.
+/// They cannot be refcounted or shared across threads.
+pub trait DeviceContext: private::Sealed {}
+
+/// An ordinary device reference, without callback-specific operations.
+pub struct Normal;
+
+/// The device is enabled but has not yet completed its first-open callback.
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
+/// Connect a PCI driver's private data to its VFIO registration.
+///
+/// # Safety
+///
+/// `registration` must always select this PCI device's sole registration and must not sleep.
+/// The driver must use [`Adapter`], and its `probe` and `unbind` callbacks must not enable SR-IOV.
+pub unsafe trait Driver: for<'a> pci::Driver<Data<'a>: Sync> + Sized {
+    /// The VFIO operations implemented by this driver.
+    type Operations: Operations;
+
+    /// Select the registration without blocking or changing its identity.
+    fn registration<'a, 'bound>(
+        data: Pin<&'a Self::Data<'bound>>,
+    ) -> &'a Registration<'bound, Self::Operations>;
+}
+
+/// Register a VFIO PCI variant driver and coordinate its callback lifetimes.
+///
+/// The adapter publishes complete private data before registering VFIO, and unregisters VFIO
+/// before calling the driver's optional `unbind` callback or removing private data. SR-IOV
+/// enable and disable callbacks are not supported by this adapter.
+pub struct Adapter<D: Driver>(D);
+
+// SAFETY: The C PCI driver embeds `device_driver` at the stated offset; its private data is
+// the pinned `D::Data` installed by this adapter's probe callback.
+unsafe impl<D: Driver> driver::DriverLayout for Adapter<D> {
+    type DriverType = bindings::pci_driver;
+    type DriverData<'bound> = D::Data<'bound>;
+    const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
+}
+
+// SAFETY: The driver core unregisters only a successfully registered, still-live PCI driver.
+unsafe impl<D: Driver> driver::RegistrationOps for Adapter<D> {
+    unsafe fn register(
+        pdrv: &Opaque<Self::DriverType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        build_assert!(
+            D::DRIVER_MANAGED_DMA,
+            "VFIO drivers must manage DMA ownership"
+        );
+        #[cfg(CONFIG_PCI_IOV)]
+        build_assert!(
+            !D::HAS_SRIOV_ENABLE && !D::HAS_SRIOV_DISABLE,
+            "VFIO PCI variant drivers do not support SR-IOV configuration"
+        );
+
+        // SAFETY: The driver is being initialized and is not yet visible to the PCI core.
+        unsafe {
+            (*pdrv.get()).name = name.as_char_ptr();
+            (*pdrv.get()).probe = Some(Self::probe_callback);
+            (*pdrv.get()).remove = Some(Self::remove_callback);
+            (*pdrv.get()).id_table = D::ID_TABLE.as_ptr();
+            (*pdrv.get()).driver_managed_dma = D::DRIVER_MANAGED_DMA;
+            (*pdrv.get()).err_handler = &PciCallbacks::<D>::ERROR_HANDLERS;
+            (*pdrv.get()).driver.pm = &PciCallbacks::<D>::PM_OPS;
+        }
+
+        // SAFETY: The caller keeps this initialized driver pinned until unregistration.
+        to_result(unsafe {
+            bindings::__pci_register_driver(pdrv.get(), module.as_ptr(), name.as_char_ptr())
+        })
+    }
+
+    unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
+        // SAFETY: The registration contract guarantees a live, registered PCI driver.
+        unsafe { bindings::pci_unregister_driver(pdrv.get()) };
+    }
+}
+
+impl<D: Driver> Adapter<D> {
+    extern "C" fn probe_callback(
+        pdev: *mut bindings::pci_dev,
+        id: *const bindings::pci_device_id,
+    ) -> c_int {
+        // SAFETY: PCI supplies a live device and holds its lock throughout probe.
+        let pdev = unsafe { &*pdev.cast::<pci::Device<device::CoreInternal<'_>>>() };
+        // SAFETY: `DeviceId` is a transparent wrapper with no additional invariants.
+        let id = unsafe { &*id.cast::<pci::DeviceId>() };
+        // SAFETY: The ID comes from `D::ID_TABLE`, a dynamic ID with matching driver_data,
+        // or the wildcard ID whose driver_data is zero.
+        let info = unsafe { id.info_unchecked_opt::<D::IdInfo>() };
+
+        from_result(|| {
+            pdev.as_ref().set_drvdata(D::probe(pdev, info))?;
+            // SAFETY: The fully initialized, pinned `D::Data` was just installed above.
+            let data = unsafe { pdev.as_ref().drvdata_borrow::<D::Data<'_>>() };
+            // SAFETY: `D` selects this device's sole registration. Private data is installed
+            // before VFIO can enable runtime PM.
+            if let Err(error) = unsafe { D::registration(data).register() } {
+                // SAFETY: Failed VFIO registration has unwound its callbacks. In particular,
+                // rejecting a PF with enabled VFs must not disable those VFs during rollback.
+                drop(unsafe { pdev.as_ref().drvdata_obtain::<D::Data<'_>>() });
+                return Err(error);
+            }
+            Ok(0)
+        })
+    }
+
+    extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
+        // SAFETY: PCI supplies a live device under its lock, after quiescing runtime PM.
+        let pdev = unsafe { &*pdev.cast::<pci::Device<device::CoreInternal<'_>>>() };
+        // SAFETY: A successful probe installed this device's complete private data.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<D::Data<'_>>() };
+        // SAFETY: Probe registered this object. Private data and all its fields remain live
+        // while VFIO unregister drains VFIO, VGA and PM callbacks.
+        unsafe { D::registration(data).unregister() };
+        D::unbind(pdev, data);
+        // SAFETY: Callbacks have drained, so private data can now be removed and destroyed.
+        drop(unsafe { pdev.as_ref().drvdata_obtain::<D::Data<'_>>() });
+    }
+}
+
+/// The trait for VFIO PCI variant driver implementations.
+///
+/// Unoverridden callbacks delegate to the corresponding PCI core operation.
+///
+/// # Lifetime of `RegistrationData`
+///
+/// `RegistrationData` describes a covariant type family borrowing from the PCI
+/// binding scope. [`Registration`] owns the data, and each callback borrows it.
+/// Covariance permits shortening the binding lifetime to the callback's borrow
+/// without allowing callback-local references to be stored in registration data.
+pub trait Operations: Sized + Send + Sync + 'static {
+    /// The name of the VFIO driver.
+    const NAME: &'static CStr;
+
+    /// Data owned by the [`Registration`] and passed to VFIO callbacks.
+    ///
+    /// Per-device state (e.g. the GFID, cached type info) lives here.
+    type RegistrationData: for<'a> CovariantForLt<Of<'a>: Send + Sync> + 'static;
+
+    /// Data shared by callbacks from the first successful open until the last close.
+    /// May borrow registration data; dropped before PCI core close on the last close.
+    type OpenData<'a>: Send + Sync + 'a;
+
+    /// Called when the first file descriptor is opened for this device.
+    ///
+    /// `vfio_pci_core_enable()` has already succeeded; if this returns an
+    /// error, `vfio_pci_core_disable()` is called automatically.
+    fn open_device<'a>(
+        dev: &'a Device<Self, Open>,
+        reg_data: &'a <Self::RegistrationData as ForLt>::Of<'a>,
+    ) -> impl PinInit<Self::OpenData<'a>, Error> + 'a;
+
+    /// Handle a VFIO ioctl.
+    ///
+    /// The default `vfio_pci_core_ioctl()` is available via
+    /// [`Device::core_ioctl()`] for delegation.
+    fn ioctl<'a>(
+        dev: &Device<Self, Ioctl>,
+        reg_data: &<Self::RegistrationData as ForLt>::Of<'a>,
+        open_data: Pin<&Self::OpenData<'a>>,
+        cmd: u32,
+        arg: usize,
+    ) -> Result<isize>;
+
+    /// Read from the device.
+    ///
+    /// `buf` is a user-space buffer provided by the VFIO core. Use
+    /// [`Device::core_read()`] to delegate the default read, and
+    /// [`UserBuf::write_overlapping()`] to override specific bytes afterwards.
+    fn read<'a>(
+        dev: &Device<Self, Read>,
+        reg_data: &<Self::RegistrationData as ForLt>::Of<'a>,
+        open_data: Pin<&Self::OpenData<'a>>,
+        buf: &mut UserBuf,
+        ppos: &mut Position<'_>,
+    ) -> Result<isize>;
+
+    /// Write to the device, delegating to [`Device::core_write()`] if appropriate.
+    fn write<'a>(
+        dev: &Device<Self, Write>,
+        _reg_data: &<Self::RegistrationData as ForLt>::Of<'a>,
+        _open_data: Pin<&Self::OpenData<'a>>,
+        buf: &mut UserBuf,
+        ppos: &mut Position<'_>,
+    ) -> Result<isize> {
+        dev.core_write(buf, ppos)
+    }
+
+    /// Map a device region, delegating to [`Device::core_mmap()`] if appropriate.
+    fn mmap<'a>(
+        dev: &Device<Self, Mmap>,
+        _reg_data: &<Self::RegistrationData as ForLt>::Of<'a>,
+        _open_data: Pin<&Self::OpenData<'a>>,
+        mapping: &mut Mapping<'_>,
+    ) -> Result {
+        dev.core_mmap(mapping)
+    }
+
+    /// Prepare for PCI reset, including resets initiated during enable or close.
+    fn reset_prepare(_reg_data: &<Self::RegistrationData as ForLt>::Of<'_>) {}
+
+    /// Finish PCI reset; errors are reported through the VFIO error interrupt.
+    fn reset_done(_reg_data: &<Self::RegistrationData as ForLt>::Of<'_>) -> Result {
+        Ok(())
+    }
+
+    /// Fill in region info capabilities.
+    ///
+    /// The default `vfio_pci_ioctl_get_region_info()` is available via
+    /// [`Device::core_get_region_info()`] for delegation.
+    fn get_region_info<'a>(
+        dev: &Device<Self, GetRegionInfo>,
+        reg_data: &<Self::RegistrationData as ForLt>::Of<'a>,
+        open_data: Pin<&Self::OpenData<'a>>,
+        info: &mut bindings::vfio_region_info,
+        caps: &mut InfoCap<'_>,
+    ) -> Result;
+}
+
+/// A VFIO PCI file position, encoding a region index and an offset within that region.
+pub struct Position<'a> {
+    raw: &'a mut i64,
+}
+
+impl Position<'_> {
+    /// Commit a temporary position only after the operation succeeds.
+    ///
+    /// This preserves the original position if a read succeeds but a subsequent
+    /// user copy fails.
+    pub fn with_temporary<R>(
+        &mut self,
+        operation: impl FnOnce(&mut Position<'_>) -> Result<R>,
+    ) -> Result<R> {
+        let mut next = *self.raw;
+        let result = operation(&mut Position { raw: &mut next })?;
+        *self.raw = next;
+        Ok(result)
+    }
+
+    /// Returns the PCI region index.
+    pub fn region_index(&self) -> u32 {
+        ((*self.raw as u64) >> bindings::VFIO_PCI_OFFSET_SHIFT) as u32
+    }
+
+    /// Returns the byte offset within the current region.
+    pub fn region_offset(&self) -> u64 {
+        (*self.raw as u64) & ((1u64 << bindings::VFIO_PCI_OFFSET_SHIFT) - 1)
+    }
+}
+
+/// Mapping metadata supplied by VFIO while the current thread holds the mmap lock.
+///
+/// The underlying VMA can only be passed back to the core mmap operation.
+pub struct Mapping<'a> {
+    vma: &'a VmaRef,
+    _not_thread_safe: NotThreadSafe,
+}
+
+impl Mapping<'_> {
+    fn page_offset(&self) -> u64 {
+        // SAFETY: The mmap callback holds the mmap lock for this VMA.
+        unsafe { (*self.vma.as_ptr()).vm_pgoff as u64 }
+    }
+
+    /// Returns the PCI region index encoded in the mapping offset.
+    pub fn region_index(&self) -> u32 {
+        (self.page_offset() >> (bindings::VFIO_PCI_OFFSET_SHIFT as usize - crate::page::PAGE_SHIFT))
+            as u32
+    }
+
+    /// Returns the byte offset within the PCI region.
+    fn region_offset(&self) -> u64 {
+        let mask = ((1u64 << bindings::VFIO_PCI_OFFSET_SHIFT) - 1) >> crate::page::PAGE_SHIFT;
+        (self.page_offset() & mask) << crate::page::PAGE_SHIFT
+    }
+
+    /// Returns the requested mapping length in bytes.
+    fn size(&self) -> Result<u64> {
+        self.vma
+            .end()
+            .checked_sub(self.vma.start())
+            .map(|size| size as u64)
+            .ok_or(EOVERFLOW)
+    }
+
+    /// Returns the exclusive end of the requested mapping within the PCI region.
+    pub fn region_end(&self) -> Result<u64> {
+        self.region_offset()
+            .checked_add(self.size()?)
+            .ok_or(EOVERFLOW)
+    }
+}
+
+/// A VFIO PCI variant device, wrapping `struct vfio_pci_core_device`.
+///
+/// The layout is `#[repr(C)]` with `core_device` first, so the
+/// `vfio_device` embedded at offset 0 of `vfio_pci_core_device` is also at
+/// offset 0 of `Self`, matching the `vfio_alloc_device` requirement.
+/// Callback contexts expose only their matching core helper and cannot be
+/// refcounted or shared across threads.
+///
+/// # Invariants
+///
+/// - Callback contexts are only borrowed for the corresponding callback and thread.
+/// - `core_device` was initialized by `vfio_pci_core_init_dev()`.
+/// - The VFIO device refcount owns the allocation lifetime.
+/// - `reg_data` is dangling without an owner or points to a valid
+///   `<T::RegistrationData as ForLt>::Of<'_>` owned by the enclosing [`Registration`].
+/// - `open_data` is null outside a successful open, otherwise it owns a pinned
+///   `KBox<T::OpenData<'_>>` until last close. Only open/close mutate it; VFIO
+///   prevents I/O callbacks from racing those transitions. The data is dropped
+///   before PCI core close and before registration data is freed.
+#[repr(C)]
+pub struct Device<T: Operations, Ctx: DeviceContext = Normal> {
+    core_device: Opaque<bindings::vfio_pci_core_device>,
+    reg_data: UnsafeCell<NonNull<<T::RegistrationData as ForLt>::Of<'static>>>,
+    open_data: UnsafeCell<*mut T::OpenData<'static>>,
+    _context: PhantomData<(Ctx, NotThreadSafe)>,
+}
+
+impl<T: Operations> Device<T> {
+    /// Allocate a VFIO PCI device for subsequent registration.
+    pub fn new(pdev: &pci::Device<device::Core<'_>>) -> Result<ARef<Self>> {
+        Self::allocate(pdev, false)
+    }
+
+    /// Allocate a device whose physical BARs may also be exported as DMA buffers.
+    pub fn new_passthrough(pdev: &pci::Device<device::Core<'_>>) -> Result<ARef<Self>> {
+        Self::allocate(pdev, true)
+    }
+
+    fn allocate(pdev: &pci::Device<device::Core<'_>>, passthrough: bool) -> Result<ARef<Self>> {
+        const_assert!(core::mem::offset_of!(Self, core_device) == 0);
+        let size = Kmalloc::aligned_layout(Layout::new::<Self>()).size();
+
+        // SAFETY: The bound PCI device and static ops are valid. The allocation
+        // includes the full Rust wrapper with kmalloc-compatible size and alignment.
+        let raw = from_err_ptr(unsafe {
+            bindings::_vfio_alloc_device(size, pdev.as_ref().as_raw(), &Self::OPS)
+        })?;
+        let this = NonNull::new(raw.cast::<Self>()).ok_or(ENOMEM)?;
+
+        // SAFETY: Initialise the Rust field in the newly allocated device.
+        unsafe {
+            (&raw mut (*this.as_ptr()).reg_data).write(UnsafeCell::new(NonNull::dangling()));
+            (&raw mut (*this.as_ptr()).open_data).write(UnsafeCell::new(core::ptr::null_mut()));
+            (&raw mut (*this.as_ptr())._context).write(PhantomData);
+        }
+
+        if passthrough {
+            // SAFETY: No registration or callbacks can observe this allocation yet.
+            unsafe { (*this.as_ref().core_device()).pci_ops = &Self::PASSTHROUGH_OPS };
+        }
+
+        // SAFETY: `this` owns the initial VFIO device reference.
+        Ok(unsafe { ARef::from_raw(this) })
+    }
+
+    /// Access the registration data through a closure with an HRTB lifetime.
+    ///
+    /// The closure's `for<'a>` bound prevents the caller from smuggling
+    /// references with a concrete short lifetime out of the closure.
+    ///
+    /// # Safety
+    ///
+    /// Registration data must be published and remain valid through this call.
+    unsafe fn registration_data_with<R>(
+        &self,
+        f: impl for<'a> FnOnce(&'a <T::RegistrationData as ForLt>::Of<'a>) -> R,
+    ) -> R {
+        // SAFETY: Registration keeps the allocation and its borrowed resources
+        // alive until unregistration completes. Covariance permits shortening
+        // the erased binding lifetime to this callback's borrow.
+        let reg_data: &<T::RegistrationData as ForLt>::Of<'_> = unsafe {
+            (*self.reg_data.get())
+                .cast::<<T::RegistrationData as ForLt>::Of<'_>>()
+                .as_ref()
+        };
+        f(reg_data)
+    }
+
+    /// # Safety
+    ///
+    /// The caller must be an I/O callback while VFIO keeps the device open.
+    unsafe fn callback_data_with<R>(
+        &self,
+        f: impl for<'borrow, 'data> FnOnce(
+            &'borrow <T::RegistrationData as ForLt>::Of<'data>,
+            Pin<&'borrow T::OpenData<'data>>,
+        ) -> R,
+    ) -> R {
+        // SAFETY: VFIO excludes open/close and unregister while this callback runs.
+        unsafe {
+            self.registration_data_with(|reg_data| {
+                let ptr = (*self.open_data.get()).cast::<T::OpenData<'_>>();
+                // The data lifetime stays independent of the callback borrow,
+                // so borrowed OpenData fields cannot be stored back into OpenData.
+                f(reg_data, Pin::new_unchecked(&*ptr))
+            })
+        }
+    }
+
+    /// # Safety
+    /// The returned view must only be used during the callback represented by `Ctx`.
+    unsafe fn with_context<Ctx: DeviceContext>(&self) -> &Device<T, Ctx> {
+        // SAFETY: All contexts have the same layout; the caller guarantees the context.
+        unsafe { &*core::ptr::from_ref(self).cast() }
+    }
+
+    /// Recover `&Self` from a raw `*mut vfio_device` in a callback.
+    ///
+    /// # Safety
+    ///
+    /// `vdev` must point to the `vfio_device` at the start of a
+    /// `Device<T>` allocated by `_vfio_alloc_device()` and remain valid for `'a`.
+    unsafe fn from_vfio_device<'a>(vdev: *mut bindings::vfio_device) -> &'a Self {
+        // SAFETY: `vfio_device` is at offset 0 of `vfio_pci_core_device`,
+        // which is at offset 0 of `Device<T>`, so the pointer cast is
+        // valid.
+        unsafe { &*(vdev.cast()) }
+    }
+}
+
+impl<T: Operations, Ctx: DeviceContext> Device<T, Ctx> {
+    fn core_device(&self) -> *mut bindings::vfio_pci_core_device {
+        self.core_device.get()
+    }
+
+    fn vfio_device(&self) -> *mut bindings::vfio_device {
+        self.core_device.get().cast()
+    }
+}
+
+impl<T: Operations> Device<T, Open> {
+    /// Set the device ID exposed through VFIO's virtual PCI configuration space.
+    pub fn set_device_id(&self, device_id: u16) {
+        // SAFETY: core_enable allocated vconfig; the exclusive first-open callback
+        // runs before finish_enable publishes the configuration to userspace.
+        unsafe {
+            (*self.core_device())
+                .vconfig
+                .add(bindings::PCI_DEVICE_ID as usize)
+                .cast::<u16>()
+                .write_unaligned(device_id.to_le());
+        }
+    }
+}
+
+impl<T: Operations> Device<T, Ioctl> {
+    /// Delegate to `vfio_pci_core_ioctl()`.
+    pub fn core_ioctl(&self, cmd: u32, arg: usize) -> Result<isize> {
+        // SAFETY: The Ioctl context keeps this device open on the callback thread.
+        let ret = unsafe { bindings::vfio_pci_core_ioctl(self.vfio_device(), cmd, arg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret as i32))
+        } else {
+            Ok(ret)
+        }
+    }
+}
+
+impl<T: Operations> Device<T, Read> {
+    /// Delegate to `vfio_pci_core_read()`.
+    ///
+    /// The VFIO core fills the user-space buffer with the default PCI data
+    /// for the region identified by `ppos` and advances the position by the bytes read.
+    pub fn core_read(&self, buf: &UserBuf, ppos: &mut Position<'_>) -> Result<isize> {
+        // SAFETY: The Read context keeps this device open on the callback thread;
+        // `buf.ptr` is a user-space pointer supplied by VFIO.
+        let ret = unsafe {
+            bindings::vfio_pci_core_read(
+                self.vfio_device(),
+                buf.ptr.as_mut_ptr().cast(),
+                buf.count,
+                ppos.raw,
+            )
+        };
+        if ret < 0 {
+            Err(Error::from_errno(ret as i32))
+        } else {
+            Ok(ret)
+        }
+    }
+}
+
+impl<T: Operations> Device<T, Write> {
+    /// Delegate to `vfio_pci_core_write()` for this callback's bounded buffer.
+    pub fn core_write(&self, buf: &UserBuf, ppos: &mut Position<'_>) -> Result<isize> {
+        // SAFETY: The Write context keeps the device open on the callback thread;
+        // the buffer is a userspace pointer supplied by VFIO.
+        let ret = unsafe {
+            bindings::vfio_pci_core_write(
+                self.vfio_device(),
+                buf.ptr.as_const_ptr().cast(),
+                buf.count,
+                ppos.raw,
+            )
+        };
+        if ret < 0 {
+            Err(Error::from_errno(ret as i32))
+        } else {
+            Ok(ret)
+        }
+    }
+}
+
+impl<T: Operations> Device<T, Mmap> {
+    /// Delegate to `vfio_pci_core_mmap()` for the current callback's VMA.
+    pub fn core_mmap(&self, mapping: &mut Mapping<'_>) -> Result {
+        // SAFETY: The Mmap context and Mapping keep the open device and locked VMA
+        // on the callback thread. The VMA cannot be replaced by driver code.
+        to_result(unsafe { bindings::vfio_pci_core_mmap(self.vfio_device(), mapping.vma.as_ptr()) })
+    }
+}
+
+impl<T: Operations> Device<T, GetRegionInfo> {
+    /// Delegate to `vfio_pci_ioctl_get_region_info()`.
+    pub fn core_get_region_info(
+        &self,
+        info: &mut bindings::vfio_region_info,
+        caps: &mut InfoCap<'_>,
+    ) -> Result {
+        // SAFETY: GetRegionInfo keeps the device open on the callback thread;
+        // `InfoCap` preserves the validity of VFIO's capability buffer.
+        to_result(unsafe {
+            bindings::vfio_pci_ioctl_get_region_info(self.vfio_device(), info, caps.raw)
+        })
+    }
+}
+
+// SAFETY: The embedded device reference count owns the VFIO allocation.
+unsafe impl<T: Operations> AlwaysRefCounted for Device<T> {
+    fn inc_ref(&self) {
+        // SAFETY: `self` holds a live VFIO device reference.
+        unsafe { bindings::get_device(&raw mut (*self.vfio_device()).device) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The caller owns the reference being released.
+        unsafe { bindings::put_device(&raw mut (*obj.as_ref().vfio_device()).device) };
+    }
+}
+
+// SAFETY: VFIO serializes open/close transitions, and callback data is Send + Sync.
+unsafe impl<T: Operations> Send for Device<T> {}
+
+// SAFETY: I/O callbacks share Sync data. VFIO excludes them from mutations of
+// `open_data` during first open and last close; registration data follows the
+// registration lifetime. Mutable C state is managed by the VFIO core.
+unsafe impl<T: Operations> Sync for Device<T> {}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered `Device<T>` in VFIO's first-open context.
+/// VFIO must exclude other opens, closes and I/O callbacks for this call.
+unsafe extern "C" fn open_device_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+) -> core::ffi::c_int {
+    // SAFETY: `vdev` is valid; set by vfio_alloc_device.
+    let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
+
+    // SAFETY: Enable the PCI-core side first.
+    let ret = unsafe { bindings::vfio_pci_core_enable(dev.core_device()) };
+    if ret != 0 {
+        return ret;
+    }
+
+    // SAFETY: Registration data is initialized before the VFIO device is published.
+    let result = unsafe {
+        dev.registration_data_with(|rd| {
+            // Allocate before calling the driver so allocation failure cannot follow open.
+            let data = KBox::<T::OpenData<'_>>::new_uninit(GFP_KERNEL)?;
+            let data = data.write_pin_init(T::open_device(dev.with_context::<Open>(), rd))?;
+
+            // SAFETY: Only the owning pointer is moved; the allocation remains pinned.
+            let raw =
+                KBox::into_raw(Pin::into_inner_unchecked(data)).cast::<T::OpenData<'static>>();
+            // SAFETY: First open is exclusive with I/O callbacks and last close.
+            // Lifetimes do not affect layout; the device owns the allocation until close.
+            *dev.open_data.get() = raw;
+            Ok::<(), Error>(())
+        })
+    };
+    match result {
+        Ok(()) => {
+            // SAFETY: open succeeded.
+            unsafe { bindings::vfio_pci_core_finish_enable(dev.core_device()) };
+            0
+        }
+        Err(e) => {
+            // SAFETY: Undo the enable on failure.
+            unsafe { bindings::vfio_pci_core_disable(dev.core_device()) };
+            e.to_errno()
+        }
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered `Device<T>` whose first open succeeded.
+/// Call exactly once for the last close, after draining I/O callbacks and while
+/// excluding the next first open.
+unsafe extern "C" fn close_device_cb<T: Operations>(vdev: *mut bindings::vfio_device) {
+    // SAFETY: `vdev` is valid.
+    let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
+    // SAFETY: Last close is exclusive with I/O callbacks and the next first open.
+    let raw = unsafe { core::mem::replace(&mut *dev.open_data.get(), core::ptr::null_mut()) };
+    // Run the driver's destructor while registration data and PCI resources are valid.
+    // SAFETY: Successful open transferred this allocation with `KBox::into_raw`.
+    // Last close takes ownership exactly once and drops it without moving the pointee.
+    unsafe { drop(KBox::from_raw(raw)) };
+    // SAFETY: Matches the enable in open_device_cb.
+    unsafe { bindings::vfio_pci_core_close_device(vdev) };
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's ioctl callback
+/// context. Registration and open data must remain alive until the call returns.
+unsafe extern "C" fn ioctl_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    cmd: core::ffi::c_uint,
+    arg: usize,
+) -> isize {
+    // SAFETY: `vdev` is valid.
+    let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
+    // SAFETY: VFIO invokes this callback for an open device with valid arguments.
+    match unsafe {
+        dev.callback_data_with(|rd, od| T::ioctl(dev.with_context::<Ioctl>(), rd, od, cmd, arg))
+    } {
+        Ok(v) => v,
+        Err(e) => e.to_errno() as isize,
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's read context.
+/// `buf` must be a userspace address and `ppos` must be exclusively accessible
+/// for this call. Registration and open data must remain alive until it returns.
+unsafe extern "C" fn read_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    buf: *mut u8,
+    count: usize,
+    ppos: *mut i64,
+) -> isize {
+    // SAFETY: `vdev` is valid. `buf` is a valid user-space pointer provided by
+    // the VFIO core. `ppos` is a valid kernel pointer.
+    let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
+    let mut ubuf = UserBuf {
+        ptr: UserPtr::from_ptr(buf.cast()),
+        count,
+    };
+    let mut pos = Position {
+        // SAFETY: `ppos` is a valid kernel pointer provided by the VFIO core.
+        raw: unsafe { &mut *ppos },
+    };
+    // SAFETY: VFIO invokes this callback for an open device with valid arguments.
+    match unsafe {
+        dev.callback_data_with(|rd, od| {
+            T::read(dev.with_context::<Read>(), rd, od, &mut ubuf, &mut pos)
+        })
+    } {
+        Ok(n) => n,
+        Err(e) => e.to_errno() as isize,
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's region-info
+/// context. `info` and `caps` must be valid, disjoint, exclusively accessible
+/// objects; the capability buffer must satisfy the VFIO core's invariants.
+/// Registration and open data must remain alive until the call returns.
+unsafe extern "C" fn get_region_info_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    info: *mut bindings::vfio_region_info,
+    caps: *mut bindings::vfio_info_cap,
+) -> core::ffi::c_int {
+    // SAFETY: `vdev`, `info`, and `caps` are valid kernel pointers provided
+    // by the VFIO core.
+    let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
+    // SAFETY: `info` is a valid pointer provided by the VFIO core.
+    let info = unsafe { &mut *info };
+    let mut caps = InfoCap {
+        // SAFETY: `caps` is a valid pointer provided by the VFIO core.
+        raw: unsafe { &mut *caps },
+    };
+    // SAFETY: VFIO invokes this callback for an open device with valid arguments.
+    match unsafe {
+        dev.callback_data_with(|rd, od| {
+            T::get_region_info(dev.with_context::<GetRegionInfo>(), rd, od, info, &mut caps)
+        })
+    } {
+        Ok(()) => 0,
+        Err(e) => e.to_errno(),
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's write context.
+/// `buf` must be a userspace address and `ppos` must be exclusively accessible
+/// for this call. Registration and open data must remain alive until it returns.
+unsafe extern "C" fn write_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    buf: *const u8,
+    count: usize,
+    ppos: *mut i64,
+) -> isize {
+    // SAFETY: VFIO supplies an open device and a valid file position pointer.
+    let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
+    let mut ubuf = UserBuf {
+        ptr: UserPtr::from_ptr(buf.cast_mut().cast()),
+        count,
+    };
+    let mut pos = Position {
+        // SAFETY: VFIO holds the file-position lock when required.
+        raw: unsafe { &mut *ppos },
+    };
+    // SAFETY: This callback runs while VFIO keeps both callback data allocations alive.
+    match unsafe {
+        dev.callback_data_with(|rd, od| {
+            T::write(dev.with_context::<Write>(), rd, od, &mut ubuf, &mut pos)
+        })
+    } {
+        Ok(n) => n,
+        Err(e) => e.to_errno() as isize,
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's mmap context.
+/// `vma` must be the valid VMA being mapped, with the mmap write lock held on
+/// this thread. Registration and open data must remain alive until return.
+unsafe extern "C" fn mmap_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    vma: *mut bindings::vm_area_struct,
+) -> core::ffi::c_int {
+    // SAFETY: VFIO supplies an open device for this mmap callback.
+    let dev = unsafe { Device::<T>::from_vfio_device(vdev) };
+    let mut mapping = Mapping {
+        // SAFETY: The mmap callback holds the mmap lock for this VMA.
+        vma: unsafe { VmaRef::from_raw(vma) },
+        _not_thread_safe: NotThreadSafe,
+    };
+    // SAFETY: This callback runs while VFIO keeps both callback data allocations alive.
+    match unsafe {
+        dev.callback_data_with(|rd, od| T::mmap(dev.with_context::<Mmap>(), rd, od, &mut mapping))
+    } {
+        Ok(()) => 0,
+        Err(e) => e.to_errno(),
+    }
+}
+
+/// Callbacks that recover the VFIO device through its PCI driver's private data.
+struct PciCallbacks<D>(PhantomData<D>);
+
+impl<D: Driver> PciCallbacks<D> {
+    /// # Safety
+    ///
+    /// `dev` must belong to `D`. Its private data must remain installed and valid for `'a`,
+    /// or not yet be installed. The caller must exclude its removal; runtime PM callbacks
+    /// use their own synchronization rather than the PCI device lock.
+    unsafe fn registration<'a>(
+        dev: *mut bindings::device,
+    ) -> Option<&'a Registration<'a, D::Operations>> {
+        // SAFETY: The callback supplies a live device bound to `D`.
+        let data = unsafe { bindings::dev_get_drvdata(dev) };
+        if data.is_null() {
+            return None;
+        }
+        // SAFETY: PCI published a fully initialized, pinned `D::Data`. The caller prevents
+        // its removal, and `D::Data: Sync` permits shared runtime PM callback borrows.
+        let data = unsafe { Pin::new_unchecked(&*data.cast::<D::Data<'_>>()) };
+        Some(D::registration(data))
+    }
+
+    unsafe extern "C" fn reset_prepare(pdev: *mut bindings::pci_dev) {
+        // SAFETY: PCI holds the device lock across reset and registration teardown.
+        let Some(reg) = (unsafe { Self::registration(&raw mut (*pdev).dev) }) else {
+            return;
+        };
+        // SAFETY: The registration owns callback data throughout bind and unbind.
+        unsafe { reg.dev.registration_data_with(D::Operations::reset_prepare) };
+    }
+
+    unsafe extern "C" fn reset_done(pdev: *mut bindings::pci_dev) {
+        // SAFETY: PCI holds the device lock across reset and registration teardown.
+        let Some(reg) = (unsafe { Self::registration(&raw mut (*pdev).dev) }) else {
+            return;
+        };
+        // SAFETY: The registration owns callback data throughout bind and unbind.
+        let result = unsafe { reg.dev.registration_data_with(D::Operations::reset_done) };
+        if let Err(error) = result {
+            // SAFETY: The PCI callback keeps its embedded device alive.
+            let dev = unsafe { device::Device::<device::Normal>::from_raw(&raw mut (*pdev).dev) };
+            dev_err!(dev, "VFIO device reset failed: {:?}\n", error);
+            // SAFETY: The initialized VFIO device remains alive for this callback.
+            unsafe {
+                bindings::vfio_pci_core_aer_err_detected(reg.dev.core_device());
+            }
+        }
+    }
+
+    unsafe extern "C" fn error_detected(
+        pdev: *mut bindings::pci_dev,
+        _state: bindings::pci_channel_state_t,
+    ) -> bindings::pci_ers_result_t {
+        // SAFETY: PCI serializes error callbacks with binding and unbinding.
+        let Some(reg) = (unsafe { Self::registration(&raw mut (*pdev).dev) }) else {
+            return bindings::pci_ers_result_PCI_ERS_RESULT_CAN_RECOVER;
+        };
+        // SAFETY: The registered device owns its error notification state.
+        unsafe { bindings::vfio_pci_core_aer_err_detected(reg.dev.core_device()) }
+    }
+
+    #[cfg(CONFIG_PM)]
+    unsafe extern "C" fn runtime_suspend(dev: *mut bindings::device) -> c_int {
+        // SAFETY: Registration enables PM only after private data is installed. PCI remove
+        // and VFIO unregister quiesce runtime PM before private data can be removed.
+        let Some(reg) = (unsafe { Self::registration(dev) }) else {
+            return EBUSY.to_errno();
+        };
+        // SAFETY: This is the runtime-suspend callback for the initialized core device.
+        unsafe { bindings::vfio_pci_core_runtime_suspend(reg.dev.core_device()) }
+    }
+
+    #[cfg(CONFIG_PM)]
+    unsafe extern "C" fn runtime_resume(dev: *mut bindings::device) -> c_int {
+        // SAFETY: Private data remains installed until VFIO unregister has resumed the
+        // device and quiesced PM, including registration failure.
+        let Some(reg) = (unsafe { Self::registration(dev) }) else {
+            return ENODEV.to_errno();
+        };
+        // SAFETY: This is the runtime-resume callback for the initialized core device.
+        unsafe { bindings::vfio_pci_core_runtime_resume(reg.dev.core_device()) }
+    }
+
+    const ERROR_HANDLERS: bindings::pci_error_handlers = bindings::pci_error_handlers {
+        error_detected: Some(Self::error_detected),
+        mmio_enabled: None,
+        slot_reset: None,
+        reset_prepare: Some(Self::reset_prepare),
+        reset_done: Some(Self::reset_done),
+        resume: None,
+        cor_error_detected: None,
+    };
+
+    const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
+        #[cfg(CONFIG_PM)]
+        runtime_suspend: Some(Self::runtime_suspend),
+        #[cfg(CONFIG_PM)]
+        runtime_resume: Some(Self::runtime_resume),
+        ..pin_init::zeroed()
+    };
+}
+
+/// Build the `vfio_device_ops` vtable for a variant driver `T`.
+///
+/// Open and I/O callbacks dispatch to `T`'s trait implementation.
+/// All other callbacks use the `vfio_pci_core_*` defaults.
+macro_rules! build_ops {
+    ($T:ty) => {
+        bindings::vfio_device_ops {
+            #[allow(clippy::disallowed_methods)]
+            name: <$T>::NAME.as_ptr().cast_mut().cast(),
+            init: Some(bindings::vfio_pci_core_init_dev),
+            release: Some(bindings::vfio_pci_core_release_dev),
+            open_device: Some(open_device_cb::<$T>),
+            close_device: Some(close_device_cb::<$T>),
+            ioctl: Some(ioctl_cb::<$T>),
+            read: Some(read_cb::<$T>),
+            write: Some(write_cb::<$T>),
+            mmap: Some(mmap_cb::<$T>),
+            request: Some(bindings::vfio_pci_core_request),
+            get_region_info_caps: Some(get_region_info_cb::<$T>),
+            match_: Some(bindings::vfio_pci_core_match),
+            match_token_uuid: Some(bindings::vfio_pci_core_match_token_uuid),
+            device_feature: Some(bindings::vfio_pci_core_ioctl_feature),
+            #[cfg(CONFIG_IOMMUFD)]
+            bind_iommufd: Some(bindings::vfio_iommufd_physical_bind),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            bind_iommufd: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            unbind_iommufd: Some(bindings::vfio_iommufd_physical_unbind),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            unbind_iommufd: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            attach_ioas: Some(bindings::vfio_iommufd_physical_attach_ioas),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            attach_ioas: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            detach_ioas: Some(bindings::vfio_iommufd_physical_detach_ioas),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            detach_ioas: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            pasid_attach_ioas: Some(bindings::vfio_iommufd_physical_pasid_attach_ioas),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            pasid_attach_ioas: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            pasid_detach_ioas: Some(bindings::vfio_iommufd_physical_pasid_detach_ioas),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            pasid_detach_ioas: None,
+            dma_unmap: None,
+        }
+    };
+}
+
+/// The registration of a VFIO PCI variant device.
+///
+/// Owns both the VFIO device reference and the registration data, tying
+/// resource lifetimes to the PCI binding scope `'a`.
+///
+/// Prepare this owner during probe. [`Adapter`] registers it after private data is installed
+/// and unregisters it before private data is removed. Dropping the owner releases the VFIO
+/// allocation and registration data after callbacks have drained.
+pub struct Registration<'a, T: Operations> {
+    dev: ARef<Device<T>>,
+    _reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>>,
+}
+
+impl<T: Operations> Device<T> {
+    const OPS: bindings::vfio_device_ops = build_ops!(T);
+
+    const PASSTHROUGH_OPS: bindings::vfio_pci_device_ops = bindings::vfio_pci_device_ops {
+        #[cfg(CONFIG_VFIO_PCI_DMABUF)]
+        get_dmabuf_phys: Some(bindings::vfio_pci_core_get_dmabuf_phys),
+        #[cfg(not(CONFIG_VFIO_PCI_DMABUF))]
+        get_dmabuf_phys: None,
+    };
+}
+
+impl<'a, T: Operations> Registration<'a, T> {
+    /// Prepare a previously allocated VFIO PCI device and its callback data.
+    ///
+    /// # Safety
+    ///
+    /// The device must have been allocated during this parent binding and never registered.
+    /// No other `Registration` may own or publish callback data for this device until this
+    /// owner is dropped.
+    /// The caller must hold the PCI device lock. The owner must be stored in the private data
+    /// of a driver registered through [`Adapter`] and selected by [`Driver::registration`].
+    pub unsafe fn new(
+        pdev: &'a pci::Device<device::Core<'_>>,
+        dev: &Device<T>,
+        reg_data: impl PinInit<<T::RegistrationData as ForLt>::Of<'a>, Error>,
+    ) -> Result<Self> {
+        // SAFETY: `dev` holds a live VFIO allocation; only compare its parent pointer.
+        if unsafe { (*dev.vfio_device()).dev } != pdev.as_ref().as_raw() {
+            return Err(EINVAL);
+        }
+
+        let reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>> =
+            KBox::pin_init(reg_data, GFP_KERNEL)?;
+        let ptr: NonNull<<T::RegistrationData as ForLt>::Of<'static>> =
+            NonNull::from(Pin::get_ref(reg_data.as_ref())).cast();
+
+        // SAFETY: No concurrent registration or callbacks; publish before registering.
+        unsafe { *dev.reg_data.get() = ptr };
+
+        Ok(Self {
+            dev: dev.into(),
+            _reg_data: reg_data,
+        })
+    }
+
+    /// Register after the PCI adapter has installed the driver's private data.
+    ///
+    /// # Safety
+    ///
+    /// Call once under the PCI device lock, after installing complete driver data whose
+    /// [`Driver::registration`] selector returns `self`. On success, unregister before
+    /// private data is removed or destroyed.
+    unsafe fn register(&self) -> Result {
+        // SAFETY: The caller has published complete private data under the PCI device lock;
+        // it remains accessible during runtime PM setup.
+        to_result(unsafe { bindings::vfio_pci_core_register_device(self.dev.core_device()) })
+    }
+
+    /// Unregister while callbacks can still recover the PCI driver's private data.
+    ///
+    /// # Safety
+    ///
+    /// Call once after successful registration, with the PCI device lock held and private
+    /// data still installed. No private-data fields may have been destroyed.
+    unsafe fn unregister(&self) {
+        // SAFETY: The caller keeps private data installed while unregistration drains VFIO,
+        // VGA and runtime PM callbacks. No field of the enclosing data is being destroyed.
+        unsafe { bindings::vfio_pci_core_unregister_device(self.dev.core_device()) };
+    }
+}
+
+impl<T: Operations> Drop for Registration<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY: The adapter unregisters before removing private data. Failed or unattempted
+        // registration also leaves no callbacks behind.
+        unsafe { *self.dev.reg_data.get() = NonNull::dangling() };
+    }
+}
-- 
2.43.7

