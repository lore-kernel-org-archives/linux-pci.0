Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529173;
	b=w/5smOJk9/wbfpZYIsIHMVHSfnofLWaj8dtOa8yBRvVNURQKgsOFAspEH2zd3b5NJhXg
	 nZTw91u9AyrWk6fxchKG93fFP2utcDTAUkGUes/oTYx6NTXS0lUe50yeYFX5jqqoY+Vly
	 1YpnkwHGjKm06A5ZXKYfbtG2vLsk/xo8oblcDG+KOTNTNxOaR4Dq5Ro50c7mOu3MiOzdS
	 439wgRdgR+7biICGckA/6FKTrSkllK89ZMjoDjAppTD6gDmSlUt1tCLuJCQoadHNhHr+o
	 toBMQjS9XdeMaqATns/3fDKonjzWYTALE+al8uRObVaADnis5H+aTXbO/1KFcV9WeEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529173;
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
	bh=G8zYb7Ir5CP+KrkrV82pMI51Vs2BuNfp2NJJRV5cWT4=;
	b=sSLJRElt1JCKNUmMKjvviuf+4xuiBd3HcVH4skTfyoaHELrAVED5Q/GVuq5T6o6+hTns
	 Vz+foWzUPI8jelLJ7eEyTqYsZq9bbuZD/ujYc/zyenBJK578KkSJpzGrYUkmp4Sm76i5P
	 KduuZ/KbDtnDSTtwsCmmO8AB0im6Msl+7xTPaHvmEL5AwPtE16IHfXXL/+8/rYARmYvhH
	 ZtbdpiRm2aqDBtxBBN3PL+qzXzXbwwgB5T2gyzzHg32gnSapPY3MA4jm9Z3sTUG8kddlR
	 /hsnEvNEeaSeL32/MBVJK8mMPCmZwtnBdUsegyON+yFr5C1ayJznkZ9nIcQeA4FgQ+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="W5pl0t/s";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.25
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68876606B01E;
	Tue, 24 Nov 2026 14:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68876606B01E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W5pl0t/s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYpMTK5EF74jtFLfAit2Kc6vJOVoS4vP0hA7dBQDSMIqnKmqX/brCMvG+A3d5L96wv4dr195Hd72jknOzZs7iE9ivQrmxoSEXLPhj5aWkdcFqW2UXv9aij2bH9IsPhUIsdxqo8PlAGa7x1Rb+hOXFk9FH/jRY/ySWsBBa1g49g+b9lGktFtTbSD8B6+YUBgfV8ZBVLFHM/mmQAANQGV+rjdVHywO2UISTLxQOu30P25dFw1n3gP2GLLSjx/tDKP3hHMstcWucuU4t01vRNcMWBmfIEx9hLRLXXGzCV3Lg2of2uZhacM8e7cR6tCZF90Uuer477vC4rQsWwiaLmSAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8zYb7Ir5CP+KrkrV82pMI51Vs2BuNfp2NJJRV5cWT4=;
 b=ZmQNloozXruwz0UhvOQowsSsr+S12PT+UvXK+r0tbQPXplu7QJHnmj3cdWP0AtgexrgOlCGZGqnOdGYjGVlk6YCfbjSQBPexZtV+Gy7k66LQ8G9HoRor0hsP+bAcv4S+Ie0gZccOA9jWh/yAT+t6dsP+dsvNH1paIcI4rCgBm3fASK29VbjwE08lljUTnkC1K7a81Bv+eRrURxmtIEXvykjy7rn6otS7QzOG4UKRAl0rjEfJlU8Ta/yo4RnSrOEWpx+UxidJ2qW2MSsf4xkAfC0i3Hl0v1+aAUhfdmbVjtaG4Puw0Kv7fbEqYoaduiHd3BbqMc1VYfpt0ooWzniHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8zYb7Ir5CP+KrkrV82pMI51Vs2BuNfp2NJJRV5cWT4=;
 b=W5pl0t/sE4irYaVYyz/K3dOJzDJQgPA7kXsq0F1xCMfrMUPdZIzGAFqRT4fXdttyjPGVUFGADH88reDcEa4k3r8RPIUxrOcZGB0P0G4Sn0N/DUsiUQGukhfpcAlUjyu3frTzXBcCo0qoZOuzh7BJENsXwXrx3m9QrRiTjZUFgqlAjhyDodpSUN3Pe4a5xOhrnxJNOQuJiVM1Nq5olNb+rUcQHpQn4/lcPmXA0wPWlDx9bCSx0CxS4udh+rzCzNmfipzgwC9L8avO2fnXPmR0zu4cF8hdqFTffCS9mkhLU7cHxQ0hDi0e4L4JMESFVCX3WZikRKTmAY2VkFCYrRWaBA==
Received: from PH8PR21CA0010.namprd21.prod.outlook.com (2603:10b6:510:2ce::10)
 by EA3PR12MB178636.namprd12.prod.outlook.com (2603:10b6:303:308::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:06:04 +0000
Received: from CY6PEPF0000004B.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::5b) by PH8PR21CA0010.outlook.office365.com
 (2603:10b6:510:2ce::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.3 via Frontend Transport; Tue, 24
 Nov 2026 14:06:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004B.mail.protection.outlook.com (10.167.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:06:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:05:36 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:05:23 -0800
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
Subject: [PATCH v5 25/35] gpu: nova-core: vgpu: add GSP plugin communication buffer
Date: Tue, 24 Nov 2026 19:29:21 +0530
Message-ID: <20261124135937.18583-26-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004B:EE_|EA3PR12MB178636:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3551e6-96fd-4cfc-e5b3-08df4a341401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|23010399003|1800799024|18002099003|22082099003|3023799007|261026140227099003|11063799006|261022113327099003|56012099006|261021123027099003|261021135927099003|261028144727099003|261026121527099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	7DPIOh15RWryX93OWFPPHArprXKBO4pQwoJRV7PGOX5Ruxh9WsTKLJyjWt4987q5y3jBf8vLJTfkpO0VlxA2QtNy9Wd11MNkvzOGOCqXkk4tgCzRKid3sXdupIO9PD1jXjxyAL9TS7Ue1yyO1VdWyDOxiXHRXgSMNlI8dov81hzVfDLlwJweDXsfqo2wBhckMG5ELZpSlvWk+hQ7kDohcT3qqlqV46TgrpELw0GVagvhzTeTRcUbVoFFfYMP/kyIYqNFMD3qgU9/EOVKnVgK1ROskdQxe17ojQcdjUrlXskHaXJhfA70KKgph0ZO656dw89K3aNXnv2TVk9tS4EQkh6qhf8aRYRe7YrO280KQx2Kp8GsChBz2tbOX9CwG1UrC5MeVfxhLWjM/muK8fx9islE8Icr1MWoRaVLWjkeYKSIj42hySP5kqzxgd/HA3QOAbgfmoytvTaK1wZHAvsCY2i+6AAF1p6t96tIYxYS3FoKg8kmCuwSKsCtPdEMFvljZEQeA3ZMLt4ObnDCh7MW9RhKl6s9r/s5VTrKDVKZUnfzHfN5GWjUjYYqgb/PzAqpRsMCXUF+edDdFg1Cl45HAepN7qnUlKp1jU6bqL8WOMxMs3WEovL9qxgoRMtNrosQQmQi9ktkISB86vsLq0BkHL6tJ52e2yN0Ta75E5BGevIpHTGZ6O6jrhZkuc2q32RuOaAYu1B87wwWsPmrwRVdtA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(261026140227099003)(11063799006)(261022113327099003)(56012099006)(261021123027099003)(261021135927099003)(261028144727099003)(261026121527099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	stgEpwOjpNKP0zzqJ6x0BUkgNPn+unbBjzgwFOtxZOh8r9daL3N3pqDdkKXolITW4MJ8wVL7V7xhikC58REPQQv/ic0a4hylLD1a6RhXCtxXv7FIOXQPJ/gMySMkYixOMwebqVQ5M5isYR6YztMD5u6zUq2V/rAfGdjl/sNw7wzEya19wgXCAffAQ6/YnyJfjzm+2f+UgrpNC2FoQwOK9m6xzkU7Ta4eXyeroird8RkT2hxcEyaXm9In4PU8skq85nhkEn924MaJMF9E84eDOaL12emi4/EkgZP8rRCQySIaZ0X0BfV7cqG/iLXbWuspRTCNNJ+DKBFbTqiFIqr0Zfxyx1kX71M+mX+nd4gxaXIGl92r8BtYMkUtJY9WW9EiwB9k0RvJPB9wzYV3qLtH8Zh1W2d8FbD8cqiOA9UZzqse9OFSqnYfvQ/5ttk096qr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:06:04.3671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3551e6-96fd-4cfc-e5b3-08df4a341401
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB178636

From: Zhi Wang <zhiw@nvidia.com>

Each vGPU instance shares a communication buffer with its GSP plugin,
located at the start of the instance's management heap. It contains the
control and response regions used for plugin RPCs, the message and
migration buffers, and the plugin logs.

Describe its layout with a `CommBuffer` type, and add `CommBufferRegion`
which maps the buffer through BAR1 and provides the operations needed
before the first RPC: checking the plugin's boot-ready marker, obtaining
the VRAM regions of the logs, and initializing the control and response
regions.

The ready marker is stored in the control region's sequence number
field, so the regions must only be initialized after the plugin has
reported itself ready.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs                   |   1 -
 drivers/gpu/nova-core/mm/vram.rs              |   1 +
 drivers/gpu/nova-core/vgpu.rs                 |   1 +
 drivers/gpu/nova-core/vgpu/fw.rs              |  20 ++
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs | 201 ++++++++++++++++++
 5 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index f1f86931928c..9489502d3362 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -69,7 +69,6 @@ macro_rules! impl_pfn_bounded {
 mod regs;
 pub(super) mod tlb;
 pub(super) mod vmm;
-#[expect(dead_code)]
 pub(crate) mod vram;
 
 /// GPU Memory Manager - owns all core MM components.
diff --git a/drivers/gpu/nova-core/mm/vram.rs b/drivers/gpu/nova-core/mm/vram.rs
index 6054eed9aeb0..7774b15e4c89 100644
--- a/drivers/gpu/nova-core/mm/vram.rs
+++ b/drivers/gpu/nova-core/mm/vram.rs
@@ -74,6 +74,7 @@ pub(crate) struct VramRegion {
     range: Range<u64>,
 }
 
+#[expect(dead_code)]
 impl VramRegion {
     /// Returns the range covered by this region.
     pub(crate) const fn range(&self) -> &Range<u64> {
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 65362ca31ba3..eaff5b8b318d 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -29,6 +29,7 @@
 
 mod commands;
 mod fw;
+mod gsp_plugin_comm;
 mod hal;
 mod instance;
 mod vram;
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index 2d32e196a771..84a89c32a77b 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -8,3 +8,23 @@
 
 pub(super) mod commands;
 mod r000_00;
+
+// Alias to avoid repeating the version number with every use.
+use r000_00 as bindings;
+
+pub(super) use bindings::{
+    GSP_PLUGIN_BOOTLOADED,
+    VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE,
+    VGPU_CPU_GSP_CTRL_BUFF_REGION as RawControlRegion,
+    VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_CTRL_BUFF_VERSION,
+    VGPU_CPU_GSP_ERROR_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_GUEST_RPC_TRACE_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_INIT_TASK_LOG_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_MESSAGE_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_MIGRATION_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_RESPONSE_BUFF_REGION as RawResponseRegion,
+    VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE, //
+};
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
new file mode 100644
index 000000000000..983d5002ff5b
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! GSP plugin communication buffer mappings and access.
+
+use core::mem::offset_of;
+
+use kernel::{
+    io::{
+        io_project,
+        io_read,
+        io_write,
+        Mmio, //
+    },
+    num::casts::FromSafeCast,
+    prelude::*, //
+};
+
+use crate::mm::{
+    bar_user::{
+        BarMapping,
+        BarUser, //
+    },
+    vram::VramRegion,
+    SharedGpuMm, //
+};
+
+use super::fw::{
+    self,
+    RawControlRegion,
+    RawResponseRegion, //
+};
+
+/// Layout of the plugin communication region, located at the start of the management heap.
+///
+/// This type is never instantiated; it only describes the layout of the region for I/O
+/// projections.
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
+#[repr(C)]
+struct CommBuffer {
+    control: RawControlRegion,
+    response: RawResponseRegion,
+    message: [u8; cv!(fw::VGPU_CPU_GSP_MESSAGE_BUFF_REGION_SIZE)],
+    migration: [u8; cv!(fw::VGPU_CPU_GSP_MIGRATION_BUFF_REGION_SIZE)],
+    error: [u8; cv!(fw::VGPU_CPU_GSP_ERROR_BUFF_REGION_SIZE)],
+    init_log: [u8; cv!(fw::VGPU_CPU_GSP_INIT_TASK_LOG_BUFF_REGION_SIZE)],
+    vgpu_log: [u8; cv!(fw::VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE)],
+    kernel_log: [u8; cv!(fw::VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE)],
+    guest_trace: [u8; cv!(fw::VGPU_CPU_GSP_GUEST_RPC_TRACE_BUFF_REGION_SIZE)],
+}
+
+static_assert!(size_of::<CommBuffer>() == cv!(fw::VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE));
+static_assert!(size_of::<RawControlRegion>() == cv!(fw::VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE));
+static_assert!(size_of::<RawResponseRegion>() == cv!(fw::VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE));
+
+/// Physical VRAM regions containing the vGPU plugin logs.
+#[expect(dead_code)]
+pub(super) struct PluginLogRegions {
+    pub(super) init: VramRegion,
+    pub(super) vgpu: VramRegion,
+    pub(super) kernel: VramRegion,
+}
+
+/// BAR1 mapping of the plugin communication region in its management heap.
+///
+/// See [`CommBuffer`] for the layout of the region.
+pub(super) struct CommBufferRegion<'map, 'gpu> {
+    map: BarMapping<'map, 'gpu>,
+}
+
+#[expect(dead_code)]
+impl<'map, 'gpu> CommBufferRegion<'map, 'gpu> {
+    /// Map the communication portion of a plugin management heap.
+    pub(super) fn new(
+        bar_user: &'map BarUser<'gpu>,
+        mm: &'map SharedGpuMm<'gpu>,
+        management_heap: &VramRegion,
+    ) -> Result<Self> {
+        let region = management_heap.subregion(0..u64::from_safe_cast(size_of::<CommBuffer>()))?;
+
+        Ok(Self {
+            map: BarMapping::new(bar_user, mm, region, true)?,
+        })
+    }
+
+    /// Returns the MMIO view of the communication region.
+    ///
+    /// Fails if the region has been unmapped.
+    fn view(&self) -> Result<Mmio<'_, CommBuffer>> {
+        self.map.view()
+    }
+
+    /// Return the physical regions occupied by the three plugin logs.
+    pub(super) fn plugin_logs(&self) -> Result<PluginLogRegions> {
+        let log_region = |offset, size| {
+            let start = u64::from_safe_cast(offset);
+
+            self.map.region().subregion(start..start + u64::from(size))
+        };
+
+        Ok(PluginLogRegions {
+            init: log_region(
+                offset_of!(CommBuffer, init_log),
+                fw::VGPU_CPU_GSP_INIT_TASK_LOG_BUFF_REGION_SIZE,
+            )?,
+            vgpu: log_region(
+                offset_of!(CommBuffer, vgpu_log),
+                fw::VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE,
+            )?,
+            kernel: log_region(
+                offset_of!(CommBuffer, kernel_log),
+                fw::VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE,
+            )?,
+        })
+    }
+
+    /// Return whether firmware has published the plugin boot marker.
+    pub(super) fn is_plugin_ready(&self) -> Result<bool> {
+        let value = io_read!(self.view()?, .control.__bindgen_anon_1.message_seq_num);
+
+        Ok(value == fw::GSP_PLUGIN_BOOTLOADED)
+    }
+
+    /// Initialize the shared control and response buffers for plugin RPC.
+    #[expect(dead_code)]
+    pub(super) fn initialize(&self) -> Result {
+        let comm = self.view()?;
+        let control = io_project!(comm, .control.__bindgen_anon_1);
+        let response = io_project!(comm, .response.__bindgen_anon_1);
+
+        io_write!(
+            control,
+            .response_buff_offset,
+            u64::from_safe_cast(offset_of!(CommBuffer, response))
+        );
+        io_write!(
+            control,
+            .message_buff_offset,
+            u64::from_safe_cast(offset_of!(CommBuffer, message))
+        );
+        io_write!(
+            control,
+            .migration_buff_offset,
+            u64::from_safe_cast(offset_of!(CommBuffer, migration))
+        );
+        io_write!(
+            control,
+            .error_buff_offset,
+            u64::from_safe_cast(offset_of!(CommBuffer, error))
+        );
+        io_write!(
+            control,
+            .guest_rpc_trace_buff_offset,
+            u64::from_safe_cast(offset_of!(CommBuffer, guest_trace))
+        );
+        io_write!(control, .migration_buf_cpu_access_offset, 0);
+        io_write!(control, .is_migration_in_progress, 0);
+        io_write!(control, .error_buff_cpu_get_idx, 0);
+        io_write!(control, .guest_rpc_trace_buff_cpu_get_idx, 0);
+        io_write!(control, .attached_vgpu_count, 1);
+        io_write!(control, .is_gr_init_done, 0);
+
+        io_write!(control, .message_type, 0);
+        // Replace the boot-ready marker with the initial RPC sequence.
+        io_write!(control, .message_seq_num, 0);
+        io_write!(response, .message_seq_num_processed, 0);
+        io_write!(response, .result_code, 0);
+        io_write!(control, .version, fw::VGPU_CPU_GSP_CTRL_BUFF_VERSION);
+
+        Ok(())
+    }
+
+    /// Invalidate the PTEs and release the communication mapping.
+    #[expect(dead_code)]
+    pub(super) fn unmap(&mut self) -> Result {
+        self.map.unmap()
+    }
+}
-- 
2.53.0

