Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943820;
	b=11mN6IfS8IEQIhCD96uImnkmdTUPi1XWsJTg/GfRHlMnZEtCn46VwmfDUJ4ZqSjlpwPb
	 ZSRdWC7NwRvc6+RROAI+9uFeuHI0l+gt7T1VA2DjZFQl2jRPQtHv8600i0/C5hwknDSgE
	 0bWsXS/gAY+SDSzXRbNge6MDdTLOdlGpXNNT+oMN5QNAs64+smo0l3qDWiQNUtCb25Kmo
	 CHysL0hNu0u6LtxI5C/gRxs3YtVfzBMkG2wjElzW4oXl8WPxGpG4DhsQ8YooF5WkU7ya5
	 HZt1q7GHWbW6N6a/iuOgllX1718vk3c+c1WrJoVwtKeHmREfRNjR2yRTss6oMaPvYeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943820;
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
	bh=hXysJPsgAqMoiWCjqzmce5matu1RsLUIHZd28YG9jxA=;
	b=NqAH1SbLLRJDEFAzCu1Qcj9oTAq164Mpouo5SSlf5DELyazcFTtB9Ha3aWijSHyhzBug
	 WnFqP7SmhCU0Jz3T0NOauk4l3P5pyOB+biazpxQY7tGM91LD0iN7Q2gXtDs/4Mfkw481h
	 CvMCX4Ma4Ra+7/0NGIsMRGeiVP7c0YRdKrswg8ANFWKrWXiK3wbtbEjDKvYK8ezAHPmyo
	 /r7J2bkRVnNM7DgFppZIYG+iOChSWrFKVkMtqeanlFFgLs2nNQqiorLW90IsCUk0IQ/zL
	 pq9GMgEiuksjB0HSZkRLexJWOs3VpPw9ge58VT3hO85NA5H1vaYYvAms1wFXwrDI+qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XOFvMozq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.45
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5A606A331;
	Fri,  6 Nov 2026 05:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F5A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XOFvMozq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVZc1OMfBqqDJ8hjsIM7t/vHiDnSwDFmpgdvqDx5uiERbJlswxWzWfQx4sVGlPRGoZ/CWctFWX/9qlX+bq3UgtOT5Qfpq2S7sLxwYCkCD1HTLCrZVuVLZDRKWE36DdbgfpuDUPBtGHsBCzXdjQWWsaK25nMtCsKO7ZMtP5N/IzczIj1ZH380az0yYfBg+Nrt9IJAAZWy6f9E/KJDTWNLGb1f6/prG/6DB9DJ0zON58G16zUJ1v5FPEfeH7TurE3FSmeewIRv7lHw/gUweATh/BsO4IzVYr6JAwPfnornOYlgZv5owGYeQ4bA3R+p4dI5S5Tmkfk7p5Pi7UxXmvZsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXysJPsgAqMoiWCjqzmce5matu1RsLUIHZd28YG9jxA=;
 b=UhWojF9EGNpk/gTZbeP5e8+KAxE3k6u4fxMgYebd2jehJwfwFXws84qIvXivEfM/emniKSIPuMKkPH1ZqvfLrntPf/yM2UeB8J0UVpnwtkTVDFtvz0vwUHGj6nc5qh7WFtBGUE8OacL80RX6N0PV0vG6gj9bU8kv0K0TCo+zNI2IG+7dmxDj3AM6c5+uAMwEsuKBfvYUGrkRuARIOKolkkQbp5WkNtx8axDJIhrMEhLTd6QIX+iV8/uqUJmUgAecnkbGpFQzdg6E4CrIf4hHQLQ0rr0abkXKgFqPgpohlH7csed8ugMn03UNQuNYxT7C8HgmMsHWUuvHLhdWXmdiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXysJPsgAqMoiWCjqzmce5matu1RsLUIHZd28YG9jxA=;
 b=XOFvMozqsorxkLh/iUWkMha6nkQbRHsSfLAawzzt5QFUQDVRck1KxbIIrbt/sJcZ26SNyG2+jMtsPL1topnX3W8CVzMGhzNfh3xkcA4JTqZmr4wyElneMhQ1RCVY7pjh+6aqAgKnDtcu75zI7xnayRFPuLZN6dEw0M8EFSwt/ut63gfRcAw7ez/RIhIJyb9JToC8/etGiXaNvFBlCjDMx5wNZ4xypgJCd+vKNxlEH59NSQnmg9zH6e8MLmltHZXi6ApbKi5HkYnFLPlqhIrVKnPGcPhxteAa1pkJmj58EOBRZplh+HGdqxKh9JzgT8oB3/NKciNtKR3Fo3SN49ye5g==
Received: from PH8PR20CA0016.namprd20.prod.outlook.com (2603:10b6:510:23c::20)
 by IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:43:34 +0000
Received: from CY4PEPF000392D7.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::53) by PH8PR20CA0016.outlook.office365.com
 (2603:10b6:510:23c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:43:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392D7.mail.protection.outlook.com (10.167.247.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:43:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:43:19 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:43:07 -0800
From: Alok Kumar <alkumar@nvidia.com>
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
Subject: [PATCH v4 10/32] gpu: nova-core: mm: add VramBlock
Date: Fri, 6 Nov 2026 11:09:43 +0530
Message-ID: <9ffdf9ff0bf8e5b16cea8b610a5482693cdb2ea8.1793906667.git.alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793906667.git.alkumar@nvidia.com>
References: <cover.1793906667.git.alkumar@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D7:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d051c4-3abf-4e1a-cce7-08df3bc8e593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261022113327099003|261022105027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f3WyffvHFbZ1jQ7CeW5nWY24+FldDSs5M+Ikvf/zSt717ogq7YVadxWCOi8nGWEJ+vM3Miwb4Fno4yvDhSfqh0bj4LENFvkWX6N76PEYRJj1Im7oCvIxbp3h3ieFVTTxrabO7CHCvI3F/Vg/4Hjx+lBY4/8oVK7To4iogLKkdjEne+6GKnqpR00rvI4AmUSmZZpX5BlYSfQ0S4GuCMymDCbUmlmTFY3YIn5qg87cCI+0oXlvOqkaNfn+5U151pJoGefs2a/ToyBEp50K6T/i7N/nO9mcG9o6kQYrh0VAn0UB0JEtd929wFTRcVVcSxaMcUP8qDBbxqClaJVXPZS0U+tqthG8raOQVX03Altq7hSl24qb7ACZFH6Bajsqkf8Abu0vq6an2+SZZlXVugRXxpZbdvBAzATD2DqSGk7+vQ0DC7aDg98+sFB1ezAPg504TGbuQ3A31eghfQ2Vrarr9PrOVldhafIttdcJE0dy8AWA6cqC057rjTRST5icJejcdfINVNFVbBtYrwv8mGrbTbUi4oavG1wXkmjpCS8QUI2Ho4EngrsbgFKA3vPUKefYacu30+Ln488K1OWUe6OTvjVeh0BjD8f0W+Zlb0RhGFT6NM1Mx+Tfmul1oVnGOhmiP3YUcbsSFAE+M3Vvct8VJCXv5UZneHOIJtK7ZNyCh+1s9uUFNSItDWro8DTs8pta
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AwBoK56E8ZlM6WKBd1z568U/pGmVPLeKJyULoiMdgwJQE45R98BepoE1QYYBCTMMuLkDmCLSFONhSBHSJDGx3bEQ6kjJc+czTx3+LMdkDoGEv6tpOKmGHV4+z5bwDaoTtt2WmRt6Syyy6ECHDYYZEv3bIikADngdyUoNKqSZPQFh3ySPdBIF4CD0ph9kUX9riMI+tQHASS61tHFyUxwOHIyrca/ceVNV5ismFrR0htIGkNvttrCoYcEVvXBA0DZH/Cohll6M26M3IWIoLCY8NgSxqITHMN+U3sCemkTJHizBLAUqpIn9y/bWWhOQUYZMFnOyOI/pn6gdP/r8vaUr1IjMkN0+LnudIBtAYy6phqQ1pDw9bVLLeMSlVWK+V/1pZ+Dqhxbq4GF5a2Mjd0LfxsGH3UtmDuxjM3S86rrmaGdbH3Ct+5jULQDBf8FT7Xf1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:43:34.0396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d051c4-3abf-4e1a-cce7-08df3bc8e593
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392D7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785

From: Zhi Wang <zhiw@nvidia.com>

vGPU memory slots need allocations at fixed offsets within usable VRAM.
Add GpuMm::alloc_vram_range and VramBlock to own these exact allocations
and return their storage to the buddy allocator on drop.

Use the buddy allocator's range validation and retain the checks for
absolute physical address overflow and alignment.

Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs      |  2 +
 drivers/gpu/nova-core/mm/vram.rs | 75 ++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/vram.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 8a934c55169f..016d99608aeb 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -67,6 +67,8 @@ macro_rules! impl_pfn_bounded {
 mod regs;
 pub(super) mod tlb;
 pub(super) mod vmm;
+#[expect(dead_code)]
+pub(crate) mod vram;
 
 /// GPU Memory Manager - owns all core MM components.
 ///
diff --git a/drivers/gpu/nova-core/mm/vram.rs b/drivers/gpu/nova-core/mm/vram.rs
new file mode 100644
index 000000000000..b6cc177825d7
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/vram.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! VRAM allocation.
+
+use core::ops::Range;
+
+use kernel::{
+    gpu::buddy::{
+        AllocatedBlocks,
+        GpuBuddyAllocFlags,
+        GpuBuddyAllocMode, //
+    },
+    prelude::*,
+    ptr::Alignment,
+    sync::Arc, //
+};
+
+use crate::num::IntoSafeCast;
+
+use super::{
+    GpuMm,
+    PAGE_SIZE, //
+};
+
+/// A physically contiguous VRAM allocation.
+pub(crate) struct VramBlock {
+    _blocks: Pin<KBox<AllocatedBlocks>>,
+    address: u64,
+    size: u64,
+}
+
+impl VramBlock {
+    pub(crate) const fn address(&self) -> u64 {
+        self.address
+    }
+}
+
+impl GpuMm<'_> {
+    /// Allocates an exact byte range relative to the buddy allocator's base.
+    pub(crate) fn alloc_vram_range(&self, range: Range<u64>, align: u64) -> Result<Arc<VramBlock>> {
+        let size = range.end.checked_sub(range.start).ok_or(EINVAL)?;
+
+        let align = align.max(PAGE_SIZE.into_safe_cast());
+        let min_block_size = usize::try_from(align).map_err(|_| EOVERFLOW)?;
+        let min_block_size = Alignment::new_checked(min_block_size).ok_or(EINVAL)?;
+
+        let buddy = self.buddy();
+        let base = buddy.base_offset();
+        let address = base.checked_add(range.start).ok_or(EOVERFLOW)?;
+        base.checked_add(range.end).ok_or(EOVERFLOW)?;
+        if !address.is_multiple_of(align) {
+            return Err(EINVAL);
+        }
+
+        let blocks = KBox::pin_init(
+            buddy.alloc_blocks(
+                GpuBuddyAllocMode::Range(range),
+                size,
+                min_block_size,
+                GpuBuddyAllocFlags::default(),
+            ),
+            GFP_KERNEL,
+        )?;
+
+        Ok(Arc::new(
+            VramBlock {
+                _blocks: blocks,
+                address,
+                size,
+            },
+            GFP_KERNEL,
+        )?)
+    }
+}
-- 
2.53.0

