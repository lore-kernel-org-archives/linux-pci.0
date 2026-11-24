Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529177;
	b=jBbnZqDcKhbvDcdilPt/69nc1u/wB+MwqNm5TselEoUqcRS9EbhFvKXwUvYkmVZWeOeI
	 9l+evEXLqfpl/CfwcB0Kw+P2tLsvM+YmLt6ERQw2uDBa0vA3kFqqm3gUafMB/aUbDY57Y
	 vgwfLCYsTAfJt/EdJKjdIku7ul2KldgCjjzhxLaxuqzsJRFG53c9GQX/j932Lm8HjxBpg
	 gK5KT7dhMG9L9/w+2KeWg9GOBT8fIY1hDB+lIqt4Xmgq2zPhYLYd1G4kuwbBaX1UFmj4j
	 uNH3QUdsujZVKQIOhLYR5AdXASqwBsp+unbDcZODjFozv/ssBmMFBPlughNNTLwe+Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529177;
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
	bh=4vcdHZaR8ikLqznehXNQCTCp7bZwJpJoYdTFFz9GCvg=;
	b=thxE3XEZvjqwlcsbbXrP70N21bRVWIHc3hUBod+aAQ0m/jniIg+GvREO71ck7PFB+1gg
	 BalRWx6FJb4uTFYu3VSGPqWqVcd4PPsrlgIFywo5h9OVyOrKHEV/1Dbom7T8+RJpoTpOC
	 9v9sY/DHtL6z/yhDEh3RYysmnRfyuXVyjcUdSfFACAC9jyV7Q8NtvLQQTClK5FkGCxzoB
	 SpuWKIyrXDKnFxdXFf/X9OvpWdpNxro1FynStOsocYJwckefUn96CmMaJka7yGe4FmZpR
	 lGfB2NCcoaRqste87mGCgODlvV7/TWXwxVBXNk/i3nzKpFfA5KM1j5zBuzUWxIPJASQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="GrG2Ztr/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.32
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A095606A332;
	Tue, 24 Nov 2026 14:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A095606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GrG2Ztr/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUrd4/AeVOkjoi6n7o0ntJOTil9SHur6Dq6P0vDPWJW3ZHBDObyvJzgYPToY+pErS7zvcZY4Bt1Is0s+pnvkNNghQi0i/hK6Xm/3S1wPqRYNimgCjW0992iSeccf+PHquyocFNsHGtYzRND5E1IjM3Nw0xZKmWhxcsIElLGNrHixF3e+sYHCxHelQI8mdML2EFF9qDRN/HUabyJLziE2yG6dIQuxulGcKIX2yl2Dg4zYC5SWCB9P0sI3/ut62opM8dlf/Fc0iAt+KjmUMqSAlFyBtPHgxAfH3Fy6F7nWg4ry4KFF3lGxrPWC1SQ49iI/1lmqvHun4UrdxE1kvzKqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vcdHZaR8ikLqznehXNQCTCp7bZwJpJoYdTFFz9GCvg=;
 b=s0/LT6ogEVGTUsrOKzt1ZP/nrBg1QCt6cDMep+Pznj/nwTYHwuM62ujC7OWjn0F7yWePzIcEnzD5Njsr09Xby5KQp79hFbVM2zGcukBs7gS+MKzVQaSmDQ/OYG8/NuCczyoNYjnySdkEqqRrLwk8Q+ZWcZTCMbIX75u9S/D7W+hC5qd/Mb/nwZTcrNzeAmAst18FCvF66YmmMemxbLouTZWNkXf6oOicbZLfi/r7+B/K4pXdZXKSNAzZEl/qAVUobxQx0lP9+3JCfGT/Jr8qVZn99eiC4nqZoXZ2euMrE9M4rcBKChcwlXf9fdapIURcIOwFK/YMvi2v+JxlHu2QJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vcdHZaR8ikLqznehXNQCTCp7bZwJpJoYdTFFz9GCvg=;
 b=GrG2Ztr/e/IJsYrRSZo3zz5dFU9MLzBmLsasi4UHEsRfUmtbqUJOWzM3+0DkmmsGH2bLYW44IZSorpSjox9m3AaNrcn5EDBJbWSgdvdeHqf3xPeSCl7VBzHAh2Suta5fkbf3KIPhzKb9TC2jruHBFyTQWi1rh4Pd3s3y3jjuWFgHv2HV/pYHjt0jQnIDcfnGhN0jitOjPbUjVNtx62JhbdtYNObfLyklSFv0JXHkBEjUun6C+amzgLqVmQNotcX1Np8eO2SzTdEAfa/d+qDHeuJpKBGy3O6Q0Fxk7ygV0Qr0FIT6GzKoeDS+UcliYuOunPBJnoeJr7ZkFYVmv++t1A==
Received: from CY5PR19CA0041.namprd19.prod.outlook.com (2603:10b6:930:1a::8)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:06:09 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::84) by CY5PR19CA0041.outlook.office365.com
 (2603:10b6:930:1a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:05:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:05:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:04:44 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:04:31 -0800
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
Subject: [PATCH v5 21/35] gpu: nova-core: vgpu: add VRAM slot pool
Date: Tue, 24 Nov 2026 19:29:17 +0530
Message-ID: <20261124135937.18583-22-alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124135937.18583-1-alkumar@nvidia.com>
References: <20261124135937.18583-1-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 097dbfdc-3064-4e18-5147-08df4a33f2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|261102123227099003|10067099003|11063799006|56012099006|261009223027099003|261022075727099003|261022113327099003|261026121527099003|261021121427099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	spdT/aptN+HYEzH6rE6oGA0LCMthw2Txoka3hts/4CywukyTOUApWvLgGYX17N1WEPp7p80dg6cGWBqTzbDQmYcSDeWQkVoEeYAq6DjWFlgl2dgPV8YRGTL0ui5VDjJ4nIMKny4cQjXAD3iclL88aACmU/6wgSXDUE5AMCI9DMjIqlBALN5jCqk9MpDeu8pt4K2dvJJz3hn18wA28Kyio0oqblaIT1gUCTE2uKSsrY94P5CTpfLHDyoDvVU7zwmABlsGB0ZtyW5+2PHsBU7TV6ezNICNugeSa8iImbf0ICUQw4s8HgMD64qn3UY8Gzb5BZdBYraEyzYdfX6EZyeZMbpPzoU4UwGKkwDn4To2rsaHdnfjq/suFK9UOgAVw497xOTiqdYhpsus4VFwA+kSw41p2H1wnf98x+ixIVIDr5tDW3f/J7bakFBg0UsFdBgJ/cYuXnzCYY8Ka2DKzA1oicRFQPVwn/e6NNmhQX46+G6a2Lt30TQ10aMFTHGhVUI9XNm47P26UutX+Wshz0vhdAR7nPZIpNV5WggKWlfI+t7mwzkADHUEy8azM0Gb4cQuS17Pan+oqBXzOPqZ3sPplS3u6iT/lPjZRdsKtlF56BnjEDrcOzNpekLn0MwaoiAqEV3KfYnlNqHnRZr1I1qSJqNAjklEpglfWEwqQTJjElO7VBpMc4mT6dPlt32jNJwziBI79EN60qW1sxKPkRXY/A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(261102123227099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261022113327099003)(261026121527099003)(261021121427099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b6Y+d/JnIm/sz6Wxin2RhoG1BNqUxWOoTasHf73rXYL93r0AM/ZfE0N67545YXBp+uPfWfMr+uSVxj6WEFcuczIJ4zLQ0Mv4sxcZzZcyVvqIAwb8VgjzmGghMg+CMoWWH7iAbv01dmYKvkNjQxPXMwaNFh4WD86pMaqFJqPXdXvUXQVk49s2Gp7dCnNLRMe94yPoSBM3GGMsYoRAnsnVDGR7SJ46pPuL5B2Xsw87WCMuwMdi+i3qHGVo1xr17kC4ByCfBcgrWxcwXTQ74cMmmtB2k9e9vVY/GGoKyZXHDK4KBj8DrT6id4UH70cz7Aagq909MJjCid3HjmaLqvQgqoXQodAGC+QxPIFXlARKtLG4l0CA3pf+RWjP+/HkvtwKTHgVRCZq0Y2kbUZ8ykqtRmPdAEQb9PyV68AQWkSMFXwcK/W8zIYH0I7we8EbpjUs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:05:08.7134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097dbfdc-3064-4e18-5147-08df4a33f2d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

A vGPU type specifies the guest VRAM and GSP plugin management-heap
sizes for each instance. Allocating these regions independently
fragments VRAM and does not preserve a stable layout for the vGPU type.

Add a standalone slot pool that reserves one exact VRAM range and
provides the memory ranges corresponding to a given slot.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/vgpu.rs      |   1 +
 drivers/gpu/nova-core/vgpu/vram.rs | 153 +++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 drivers/gpu/nova-core/vgpu/vram.rs

diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index ea4bb5915879..5fd9641db579 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -23,6 +23,7 @@
 
 mod fw;
 mod hal;
+mod vram;
 
 /// vGPU state detected during GPU construction.
 #[derive(Debug, Clone, Copy)]
diff --git a/drivers/gpu/nova-core/vgpu/vram.rs b/drivers/gpu/nova-core/vgpu/vram.rs
new file mode 100644
index 000000000000..0c840c03f988
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/vram.rs
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! VRAM slot allocation for vGPU instances.
+
+use kernel::{
+    prelude::*,
+    sizes::SizeConstants,
+    sync::Arc, //
+};
+
+use crate::mm::{
+    vram::{
+        VramBlock,
+        VramRegion, //
+    },
+    GpuMm, //
+};
+
+const VRAM_SLOT_MIN_ALIGN: u64 = u64::SZ_4K;
+// `VRAM_SLOT_MIN_ALIGN` is used for alignment.
+static_assert!(VRAM_SLOT_MIN_ALIGN.is_power_of_two());
+
+/// Describes the VRAM layout used by vGPU instances.
+#[derive(Clone, Copy, PartialEq)]
+pub(super) struct VgpuVramLayout {
+    // Firmware ID of the vGPU type this layout was built for.
+    type_id: u32,
+    // Maximum number of slots with this layout.
+    max_slots: u32,
+    // Size of the framebuffer for a vGPU instance.
+    fb_size: u64,
+    // Size of heap for a vGPU instance.
+    heap_size: u64,
+    // Alignment of the framebuffer for vGPU instances.
+    fb_align: u64,
+}
+
+#[expect(dead_code)]
+impl VgpuVramLayout {
+    pub(super) fn new(
+        type_id: u32,
+        max_slots: u32,
+        fb_size: u64,
+        heap_size: u64,
+        fb_align: u64,
+    ) -> Result<Self> {
+        if max_slots == 0 || fb_size == 0 || heap_size == 0 {
+            return Err(EINVAL);
+        }
+
+        let fb_align = core::cmp::max(fb_align, VRAM_SLOT_MIN_ALIGN);
+
+        if !fb_align.is_power_of_two()
+            || !fb_size.is_multiple_of(fb_align)
+            || !heap_size.is_multiple_of(VRAM_SLOT_MIN_ALIGN)
+        {
+            return Err(EINVAL);
+        }
+
+        Ok(Self {
+            type_id,
+            max_slots,
+            fb_size,
+            heap_size,
+            fb_align,
+        })
+    }
+
+    pub(super) fn max_slots(&self) -> u32 {
+        self.max_slots
+    }
+}
+
+/// A description of a VRAM slot.
+///
+/// All device accesses and mappings of its regions must end before dropping the slot.
+#[must_use]
+#[expect(dead_code)]
+pub(super) struct VgpuVramSlot {
+    /// Framebuffer VRAM region.
+    pub(super) fbmem: VramRegion,
+    /// Management heap VRAM region.
+    pub(super) mgmt_heap: VramRegion,
+    /// Index of this slot.
+    pub(super) index: u32,
+}
+
+/// A pool of VRAM slots, split according to a [`VgpuVramLayout`].
+pub(super) struct VgpuVramSlotPool {
+    backing: Arc<VramBlock>,
+    layout: VgpuVramLayout,
+    fb_region_size: u64,
+}
+
+#[expect(dead_code)]
+impl VgpuVramSlotPool {
+    /// Reserve the VRAM for all possible slots of `layout`, and returns a [`VgpuVramSlotPool`] that
+    /// can provide these slots.
+    pub(super) fn new(mm: &GpuMm<'_>, layout: VgpuVramLayout) -> Result<Self> {
+        let max_slots = u64::from(layout.max_slots);
+        // Keep guest VRAM slots contiguous so each starts at `fb_align`;
+        // interleaving page-aligned heaps could misalign later slots.
+        let fb_region_size = layout.fb_size.checked_mul(max_slots).ok_or(EINVAL)?;
+        let heap_region_size = layout.heap_size.checked_mul(max_slots).ok_or(EINVAL)?;
+        let pool_size = fb_region_size.checked_add(heap_region_size).ok_or(EINVAL)?;
+
+        let backing = mm.alloc_vram_range(0..pool_size, cv!(VRAM_SLOT_MIN_ALIGN))?;
+        if !backing.range().start.is_multiple_of(layout.fb_align) {
+            return Err(EINVAL);
+        }
+
+        Ok(Self {
+            backing,
+            layout,
+            fb_region_size,
+        })
+    }
+
+    /// Returns `true` if `layout` is identical to the layout used by this pool.
+    pub(super) fn matches_layout(&self, layout: VgpuVramLayout) -> bool {
+        self.layout == layout
+    }
+
+    /// Returns the VRAM slot corresponding to `index`, or `EINVAL` if `index` is not a valid slot
+    /// index for the pool's layout.
+    pub(super) fn slot(&self, index: u32) -> Result<VgpuVramSlot> {
+        if index >= self.layout.max_slots {
+            return Err(EINVAL);
+        }
+
+        let fb_size = self.layout.fb_size;
+        let fb_offset = fb_size.checked_mul(index.into()).ok_or(EINVAL)?;
+        let fb_end = fb_offset.checked_add(fb_size).ok_or(EINVAL)?;
+
+        let heap_size = self.layout.heap_size;
+        let heap_slot_offset = heap_size.checked_mul(index.into()).ok_or(EINVAL)?;
+        let heap_offset = self
+            .fb_region_size
+            .checked_add(heap_slot_offset)
+            .ok_or(EINVAL)?;
+        let heap_end = heap_offset.checked_add(heap_size).ok_or(EINVAL)?;
+
+        let fbmem = self.backing.region(fb_offset..fb_end)?;
+        let mgmt_heap = self.backing.region(heap_offset..heap_end)?;
+
+        Ok(VgpuVramSlot {
+            fbmem,
+            mgmt_heap,
+            index,
+        })
+    }
+}
-- 
2.53.0

