Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943968;
	b=ZdKpgEt7/SjnsmEY365oG3gcbNj3cmagyoiE68fb2EOux/byyCop4p8GQI8/8JXHLnq2
	 cSPJ0oRXjdppY79rPsFF5NvgEbktyv7ny6Wi1C8+rA6RyMJg2iTojOd9daEmjXdO/C7h4
	 v/dworqlnQ3GAg4Ouv75iqPq3euFrKbDu8fEltMonww8gYBcu1RtrP6Ud2gzUpmohCnB7
	 5KocIdQmyOvDORp6cgxgFP0DY8E/jIRvizAWFiIdzWKPrDI3tp3f1cydroHvC32U7IgpH
	 4kDEucpohD/mEIysJKUsTebzuEguLzYIbHsuM+3ueGkvm/MTZkV9x/bISMSnfKJtXdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943968;
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
	bh=oPhbmOrVgz9fzuzB1CxL0uqZ0CPpj/pdoPgrWccC5tU=;
	b=LZRbg1RF78aAu7KkEp4UBMVbuTqDuhAUC+LuFECDuWVkcq2M71cTw5cwt7abALz9FMld
	 Mm8xotqFVQiSrwUlrlFzDUauL3KrhLK6x6kY6FfTTPUFpIPxANi+N2DhYRqX9Ggd73nvc
	 OveGIJPaxXnT8T4OK2jZPKM/Zdo2sK+Ui9x23NMhrPSZBXZ1tNoZYUNFP/FyBa9bL12Av
	 3HyRXiVjq114+zBvZ9uqj5e/hLIgPbiKsXOtJIZUTxovT3B2XdYnR1tp8uHsQlbk+WIWa
	 tX4uvHA3Su/qWTd0AZRWMhDxD5IIjwJyH/J0tzhjXWyOJ+aYsH2svJ5JO4+xAQqJm3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oEuPQcOh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.42
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4AD606A328;
	Fri,  6 Nov 2026 05:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F4AD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oEuPQcOh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiN/R7lTtLPkRDgv0vr23Ymsvc3CFH7EVsoLeevfk9Kgbq8roZ4OD6VLU4+24gmiVDtugQ28h2CxrtqE0XclzqH31NDAhHu+iqt/yS2MEcuCAsql3SOMA3H6Insw3FITdD9duun72xZbLf/W4y+D8ccMTDzGQbXnz+QIz6NQ6ApkhDEdr7JtN06Hk+wuqZzTuAqAlGrKg2WhTxp2+FeJNxRct2OZYBCtK4LTeTK9uju8u2zTMjO8S+Z6A9Org4Tts7E0VqzZa4LO/aToQpMOzbcmwKImo6BY6yEr1WSjYbOsk7uHowMBXMxrhZJQjubCso02fjUeOQC+/FLmtj7m2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPhbmOrVgz9fzuzB1CxL0uqZ0CPpj/pdoPgrWccC5tU=;
 b=m+EEPiutbA91u4wPKs5gLANRmeswUr6BcNmEZBoASYuHx0Ay12JbihdOfCWW2d7/mpWK/zkkAiRdq0cxmCUMcwDZQXU1n75d6Qta4vqiUgdhIxqTv1m8RJOTdn+AwUR9cY3tkuq2GCRn8FAVoAYO09JxbgJxfT7KrfbhnPGNKGNLT5HV9VJ7+hWE3GEj7K3Ht4EBOr/RI5VlBF0ja/7YWo9z1W3X6AsrLZr0rBg4pSnlbnOIxFdzzwhffLqOTQLEKgpwclmdFp4HmY9EfteuhdcpnRuzeRJ46uH2GfKKkSEizEe5OZBmayOQxiw/tuYTeeXL/FCxc13SXFWO4C0BYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPhbmOrVgz9fzuzB1CxL0uqZ0CPpj/pdoPgrWccC5tU=;
 b=oEuPQcOhPYkv2HfXj0JuFxe2Yfd0S9YZej3/2yQGFZcHEoax+1o7l/BTxlk6tzU0PwcympKj+AOf9ut6SpQE5I64LRkRQnJhDNToWfoXtdMUKyH3u9hyhPSfnOZh2psPpPgRkxGTbFA2KWrF1ZOKoVElsr/VAH4G1taaNLD5FSES1HJ4YxlWDfwnYLX0CVHeQe1VXswJicQ/aE1Oh1vPpQktwaXDQUnPQgVjl6qzmlCC8kLd45tV3kOTrVcFcM5ARfVFUQKtIVGb700tVK2wGM3W/PK8LYgxZ0VYX2UjR59wmAEPCtO3i2cgrVv73lWNGC0v8ZK6viXUdg+QpauyIA==
Received: from PH0PR07CA0107.namprd07.prod.outlook.com (2603:10b6:510:4::22)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:45:56 +0000
Received: from PH7PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::7a) by PH0PR07CA0107.outlook.office365.com
 (2603:10b6:510:4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:45:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF0000000C.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:45:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:45:38 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:45:24 -0800
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
Subject: [PATCH v4 21/32] gpu: nova-core: vgpu: add GSP plugin communication buffers
Date: Fri, 6 Nov 2026 11:09:54 +0530
Message-ID: <3bb116e52408d051af6c009e572d2f96d66135d8.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000C:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 8471d89f-c069-47ac-7c06-08df3bc93a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|18002099003|6133799003|22082099003|3023799007|10067099003|261021123027099003|56012099006|261026140227099003|11063799006|261026121527099003|261028144727099003|261022113327099003|261022105027099003|261021135927099003|261102123227099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	91qaiZsii7gserA/MCjNGtNhaSiYGphcXdT5HSGC6FMGw/IoXxRNoJh9gFXuBBNqjraFVh1P0nPSwq1B6BntzNKdGMk7E93WW6J/C9T0qHNuaka52mrJw0bIm/xC0rKifQnoJMZLRrXnNy3/xWG0PhHVXGuZ8omC/PHXTAeGLPW+AWfjHlu15+liF/qOkzbycmzmP26omRtfrS8qSGYWzXpQAOZubtNpdkObncRTXsA0WX2zjRdObGjqY63M8P96BCn80D37CRFpTknqxPKRIQeSYc3xlEiS9tskxTLs2CBvIV+Rm8P0e7HmOKwYmoVXyIA8jsJTjbfVC1MXrsv26woHPzVM98pmmNYfj7F4xTghfCpB7U1LcDxYfCWwuQ2/gTZcExi3mFdN2PKwd+ea1JF1uXJhE4xZdq+yprwPSQHxhJjA5yZllerloURmxGMZlAE/XnG28ad1nu5sLFm6MMrUNzMfZ2Icr2wwPhlnvxUSHhlNs6Tb5MgpiNsOzJTTxP+rQLESTHM+Oj6USv8TFm2nlKslAIdQ4UtzrUlISl0aFSpcaIQgExu7Yo7QG/s+NDKa/DHhnvw1dzQbrxbCF5Wmrxr28wp9NGIRqmPssbLVh57PnvwOcSQhZ0OcljTtD6G1p9lA68Z63zoCk8l1jSO7Ni0aDYbehM/LhrflxGPI2OQZzhFn0N96XR3MOhrjU7VppEGABfEHv5mi/yf32g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(3023799007)(10067099003)(261021123027099003)(56012099006)(261026140227099003)(11063799006)(261026121527099003)(261028144727099003)(261022113327099003)(261022105027099003)(261021135927099003)(261102123227099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7kEaacT/jRXs8S0f2nk1cEKgqbOHnTkVkyMZaItGr1ElDO8/OOhg+Zas2iMyCm5dRAJje88tRFZ2SY6PwbsZo4lN5qToETjcFkZY9CETCvvKYBcXzDe7tRVRPQNJ4Hc3NPG+RRjeyr5RYx+T7t5KyDrcIUDOMSRa/BE1cr/LfU1AkppTV96amg3mRqQATvQIu4iKGgHGOf5eha4e8ehgrkuCt4betHMwc/meyuuJpB5AZ7mXkgtSjtVuQ8dqbArqNWPyOf6YnpHCpJQaGHw/AJgyQc0jxGOqi3bECVr5VYDqmGG7TyYDBWJK8z8vLmsdueSKgqTYQvQzXmQFnaY4jh9tF7pIEQOLxg2rWYTzyhHKn6zq2y1PI2InwF+hvUItl02cG/iy81LAklcqAWq6T2P/v0iNugv4vfp8WMr5bm44ziNricFeQMrQ1xDQD9jv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:45:56.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8471d89f-c069-47ac-7c06-08df3bc93a43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452

From: Zhi Wang <zhiw@nvidia.com>

The GSP plugin keeps its boot-ready marker, control data and logs in a
communication region within the instance's management heap.

Map that region through BAR1 and expose its firmware-defined subregions.
Check fixed layout totals and the control structure size at build time
while retaining runtime checks against the allocated heap and mapping
bounds.

Own the BarMapping so dropping the communication region unmaps it, and
retain its BarUser and MM borrows for that lifetime. Expose explicit
unmap to report teardown failures without consuming the owner. Provide
the ready-marker access needed to boot a reused instance slot.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs                   |   1 -
 drivers/gpu/nova-core/vgpu.rs                 |   1 +
 drivers/gpu/nova-core/vgpu/fw.rs              |  15 ++
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs | 205 ++++++++++++++++++
 4 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 016d99608aeb..d1cad5ad52fc 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -67,7 +67,6 @@ macro_rules! impl_pfn_bounded {
 mod regs;
 pub(super) mod tlb;
 pub(super) mod vmm;
-#[expect(dead_code)]
 pub(crate) mod vram;
 
 /// GPU Memory Manager - owns all core MM components.
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index fb4f1b5f7754..024cb13694f4 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -24,6 +24,7 @@
 
 mod commands;
 mod fw;
+mod gsp_plugin_comm;
 mod hal;
 mod instance;
 mod vram;
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index 23097cb13121..aabe114b55c2 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -10,6 +10,21 @@
 
 use crate::gsp::bindings;
 
+pub(super) use bindings::{
+    GSP_PLUGIN_BOOTLOADED,
+    VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE,
+    VGPU_CPU_GSP_CTRL_BUFF_REGION as RawControlRegion,
+    VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_ERROR_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_GUEST_RPC_TRACE_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_INIT_TASK_LOG_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_MESSAGE_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_MIGRATION_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE, //
+};
+
 pub(super) const GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE: u32 =
     bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE;
 
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
new file mode 100644
index 000000000000..b945e216a1d6
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! GSP plugin communication buffer mappings and access.
+
+use kernel::{
+    num::casts::u32_as_usize,
+    prelude::*,
+    sync::Mutex, //
+};
+
+use crate::mm::{
+    bar_user::{
+        BarMapping,
+        BarUser, //
+    },
+    vram::VramRegion,
+    GpuMm, //
+};
+
+use super::fw::{
+    self,
+    RawControlRegion, //
+};
+
+static_assert!(
+    fw::VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE
+        + fw::VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE
+        + fw::VGPU_CPU_GSP_MESSAGE_BUFF_REGION_SIZE
+        + fw::VGPU_CPU_GSP_MIGRATION_BUFF_REGION_SIZE
+        + fw::VGPU_CPU_GSP_ERROR_BUFF_REGION_SIZE
+        + fw::VGPU_CPU_GSP_INIT_TASK_LOG_BUFF_REGION_SIZE
+        + fw::VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE
+        + fw::VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE
+        + fw::VGPU_CPU_GSP_GUEST_RPC_TRACE_BUFF_REGION_SIZE
+        == fw::VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE
+);
+static_assert!(
+    size_of::<RawControlRegion>() == u32_as_usize(fw::VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE)
+);
+/// Physical VRAM regions containing the vGPU plugin logs.
+#[expect(dead_code)]
+pub(super) struct PluginLogRegions {
+    pub(super) init: VramRegion,
+    pub(super) vgpu: VramRegion,
+    pub(super) kernel: VramRegion,
+}
+
+fn take_region(region: &VramRegion, cursor: &mut u64, size: u32) -> Result<VramRegion> {
+    let end = cursor.checked_add(u64::from(size)).ok_or(EOVERFLOW)?;
+    let subregion = region.subregion(*cursor..end)?;
+    *cursor = end;
+    Ok(subregion)
+}
+
+/// BAR1 mapping of the plugin communication region in its management heap.
+///
+/// r000 layout, with byte offsets from the management heap (not to scale):
+///
+/// ```text
+/// 0x000000 +----------------------------------------+
+///          | Control (boot-ready marker)      4 KiB |
+/// 0x001000 +----------------------------------------+
+///          | Response                         4 KiB |
+/// 0x002000 +----------------------------------------+
+///          | Message                          4 KiB |
+/// 0x003000 +----------------------------------------+
+///          | Migration                        2 MiB |
+/// 0x203000 +----------------------------------------+
+///          | Error                            4 KiB |
+/// 0x204000 +----------------------------------------+
+///          | Init task log                  128 KiB |
+/// 0x224000 +----------------------------------------+
+///          | vGPU task log                  256 KiB |
+/// 0x264000 +----------------------------------------+
+///          | Kernel task log                 64 KiB |
+/// 0x274000 +----------------------------------------+
+///          | Guest RPC trace                 64 KiB |
+/// 0x284000 +----------------------------------------+
+/// ```
+pub(super) struct CommBufferRegion<'map, 'gpu> {
+    map: BarMapping<'map, 'gpu>,
+    control: VramRegion,
+    init_log: VramRegion,
+    vgpu_log: VramRegion,
+    kernel_log: VramRegion,
+}
+
+#[expect(dead_code)]
+impl<'map, 'gpu> CommBufferRegion<'map, 'gpu> {
+    /// Map the communication portion of a plugin management heap.
+    pub(super) fn new(
+        bar_user: &'map BarUser<'gpu>,
+        mm: &'map Mutex<GpuMm<'gpu>>,
+        management_heap: &VramRegion,
+    ) -> Result<Self> {
+        let total_size = u64::from(fw::VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE);
+        let region = management_heap.subregion(0..total_size)?;
+        let mut cursor = 0;
+
+        let control = take_region(&region, &mut cursor, fw::VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE)?;
+        take_region(
+            &region,
+            &mut cursor,
+            fw::VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE,
+        )?;
+        take_region(
+            &region,
+            &mut cursor,
+            fw::VGPU_CPU_GSP_MESSAGE_BUFF_REGION_SIZE,
+        )?;
+        take_region(
+            &region,
+            &mut cursor,
+            fw::VGPU_CPU_GSP_MIGRATION_BUFF_REGION_SIZE,
+        )?;
+        take_region(
+            &region,
+            &mut cursor,
+            fw::VGPU_CPU_GSP_ERROR_BUFF_REGION_SIZE,
+        )?;
+        let init_log = take_region(
+            &region,
+            &mut cursor,
+            fw::VGPU_CPU_GSP_INIT_TASK_LOG_BUFF_REGION_SIZE,
+        )?;
+        let vgpu_log = take_region(
+            &region,
+            &mut cursor,
+            fw::VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE,
+        )?;
+        let kernel_log = take_region(
+            &region,
+            &mut cursor,
+            fw::VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE,
+        )?;
+        take_region(
+            &region,
+            &mut cursor,
+            fw::VGPU_CPU_GSP_GUEST_RPC_TRACE_BUFF_REGION_SIZE,
+        )?;
+
+        let map = BarMapping::new(bar_user, mm, region, true)?;
+
+        Ok(Self {
+            map,
+            control,
+            init_log,
+            vgpu_log,
+            kernel_log,
+        })
+    }
+
+    fn region_offset(&self, region: &VramRegion) -> Result<usize> {
+        let offset = region
+            .address()
+            .checked_sub(self.map.region().address())
+            .ok_or(EINVAL)?;
+        if offset.checked_add(region.size()).ok_or(EOVERFLOW)? > self.map.region().size() {
+            return Err(EINVAL);
+        }
+
+        usize::try_from(offset).map_err(|_| EOVERFLOW)
+    }
+
+    fn io_offset(&self, region: &VramRegion, field: usize, width: usize) -> Result<usize> {
+        let field_end = field.checked_add(width).ok_or(EOVERFLOW)?;
+        if u64::try_from(field_end).map_err(|_| EOVERFLOW)? > region.size() {
+            return Err(EINVAL);
+        }
+
+        self.region_offset(region)?
+            .checked_add(field)
+            .ok_or(EOVERFLOW)
+    }
+
+    fn read_u32(&self, region: &VramRegion, field: usize) -> Result<u32> {
+        self.map
+            .try_read32(self.io_offset(region, field, size_of::<u32>())?)
+    }
+
+    /// Return the physical regions occupied by the three plugin logs.
+    pub(super) fn plugin_logs(&self) -> PluginLogRegions {
+        PluginLogRegions {
+            init: self.init_log.clone(),
+            vgpu: self.vgpu_log.clone(),
+            kernel: self.kernel_log.clone(),
+        }
+    }
+
+    /// Return whether firmware has published the plugin boot marker.
+    pub(super) fn is_plugin_ready(&self) -> Result<bool> {
+        let value = self.read_u32(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.message_seq_num),
+        )?;
+
+        Ok(value == fw::GSP_PLUGIN_BOOTLOADED)
+    }
+
+    /// Invalidate the PTEs and release the communication mapping.
+    pub(super) fn unmap(&mut self) -> Result {
+        self.map.unmap()
+    }
+}
-- 
2.53.0

