Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529158;
	b=N/eTXMPAcBvM7U04PvJOd4jwvSBGF3dcIeQ/AKTO/eDgXlYSLyIRgg2dtzkAAGavXk9t
	 WGhc5tDvL9LqUci/YFiRanoMLAIMLdbAbrF4PQlyxqkDZ9IDpaDeQw/1MI1KWtDngHTOR
	 cQOFIMYsfkQNcoMhKFiIc3fgWAVM75fykej8qFRJJr9J+uUUw3hbRBlC3DROssVvQNyMP
	 lCJ/4CSQB5p74XMGw5rIo/O1U4+RRWZXBje3a+C0XajwDp4PZ+jLQu0N476IHK9oxoNhu
	 f4Nf9giZLodvzkEgGbeTRTf4wdxHFqvScA226qM/ViI6jG+MA7GVMgJ8CZ38S84yeEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529158;
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
	bh=r2DFA8zAruexohQ+XKf4dLFhCyQYo2uL+jebUARKxWg=;
	b=ttJ/McEgf0zxuoDz2JCL/7sh6EtHvBZ63BPEIHX8t4oGYM9qRJCHV3T2Y8iPUFao5fzg
	 eRRuK14CN1qCtrKHMqRJjppaxp/03PY1YReau2kzGH4zljAWX2SjZjm/qIR54ugpp/mYo
	 m0fXmdsb0ly0q4SmnfKRhn0W+qgYQfEEGqQS26TGq0wURKs3y+3MEjuRz7Wy6tJbh+LJg
	 p1zxf4nCRl8DeoLmFnPznaYH06kKxqLMjpKp82bcVWxk/nnIeWeyb8YYlkjuxfSgMVPIk
	 XOP//bzdfwRbsB4+H7DpnwAXiH+aoboHJcETD+f3TiaHFWg2jqc7e9vBtrr5w0REm6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Yc5jUpT5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.3
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E9606A69E;
	Tue, 24 Nov 2026 14:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 854E9606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Yc5jUpT5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pY2RnJYnAx8x40bOgGOgtMcbwlqtveHWAgH2DuC9Vx1Hgmm61Dc7bODrwJ3xpUBGV288Z2tKrm7WeRbbZ5HyyeOt0Xw6XTTCFxNImePqvEL4jYxrhP37FRq1FC63TwiThsr9XOUGzmw+AQS0ftkQZlJN0ttF+VfMB+C7REF1+97w0YcBsC+msQ+l2wmy4aReMpOtAz85nIsk5a5j3942EZL3JKdIw0CbVGMZTGqMvElKZpy6iq4Mf4ZtXTo/+G65Pt6wLjtez/zWVWUGyrv3np5uHxlRwiuuRkjtWxVO54jdd9JqbbBSGHjdekHGmQzGgPfVliXFt+IG31fb1ILylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2DFA8zAruexohQ+XKf4dLFhCyQYo2uL+jebUARKxWg=;
 b=PqfESQJGEK0ggz/ZO2wc3am+TWl8hz6cY8CCJKH00kfrJRcCJuvUI1lOnmqLKXYXsJnQWUdZBcs9NTQ6aXb2XBHLd+wdsqhOeUFgz6D3rOoFKhLRJYGmlx/3d/QZU+dgeq6f0IMrXZz76REkaQZ8f1kQd2xDL/AxUx7qH3syF32xgqtWPN/CLwCCbV191DzxfchkoUczpsUYDdDTn20sqSMtBmEXnPG99zT01UZ79X1EU2uxTFmrZAJMiQ1u4QvRMMulOah3MONeihtv5L5n0AAa9p4r9StOD8nCsu4RpP7U/R5AGngLeQx2EF2B+kADRcJq53Gc4H30LKK6i6/27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2DFA8zAruexohQ+XKf4dLFhCyQYo2uL+jebUARKxWg=;
 b=Yc5jUpT5OaBrppWoFt4vmUuueOf991bHnacuLiUj4Mh2YqJ8ZeuwMAFNwH0ciqelzJtC8BIX9mkSKWQFP3skJLRViwvG6Pe9eVQedQ4382ovFyUVG1iwIkq/cIE8DWyh3uMhRYElgY/1axecjMqNaploMcD6DIu0lhEmL5MY0PFjZ3PtwXEoAQcReMXQ2+sZW3dfSlWSbByHPeYTTyxAHhjHy800sxFaTSkcyCHgn2x/LYiAxpYfGAj9k16+pix8EKPtLJ+yJyJiaSuJkBdfkGECCPy+xQgyIhaeLnoL3W8n2qDr1WFwobOoR5/WJVkXHpfHuV/xG3EsMlMJq9lzYg==
Received: from BN3PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:2af::38)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:05:51 +0000
Received: from LV8PEPF00000068.namprd03.prod.outlook.com
 (2603:10b6:408:2af:cafe::81) by BN3PR12CA0020.outlook.office365.com
 (2603:10b6:408:2af::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:05:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF00000068.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:05:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:05:23 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:05:10 -0800
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
Subject: [PATCH v5 24/35] gpu: nova-core: vgpu: encode vGPU boot requests
Date: Tue, 24 Nov 2026 19:29:20 +0530
Message-ID: <20261124135937.18583-25-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000068:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7f5ca7-daec-45e1-754d-08df4a340c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|10067099003|261026121527099003|11063799006|261026140227099003|56012099006|261021123027099003|261021121427099003|261009223027099003|261028144727099003|261022075727099003|261022105027099003|261102123227099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dInbozXF2r6LyYWHft8b8mqkTHQJ4MMjcvmuSO2YrqotZn1y777jqWM3vKgcWzdHQwNk2iahFAhysKd30AkdpOn1mgW3ToWfHcwDMsIDVGdcLG/WfFi2GkDh2W+BdzsUycFuk8gES1MOTSx7coZiCkkdsBV6Ywo/UhdKjCG6AELr25AVpK5O3a6kHJhEWk96u4nQZmNEV5Q7rNi3UNClJDhSfzT0ES8qU+njI1EFZ3uoh1Gs+UdaYdjD+yN+ornyL6QCqO9tlmyYIhEWztVM9NpWgihCRNHw9Fl3LfF5IqbVspNLihadZRntCTVxNMTTAr8dvagxyQ6Zill9OiXE8Tx018Nmw/OcvJWciRB/L63mteyroUlCUmmyX4dka/iJ6EvAOGGqyZmDgf2LBErmurfy0hhwcBf1/5N0w7FoP6q9oTdXU3lmp31FYyfAEjJShiAWLKki4X1nMtpcjZYN2Rl//m4OLs5qOqxcfusxTm9DODzUTePFXemAwsMcQNQkwLFpvIsPK9sNdpGyo88mXNGbRQFjNAW0jND0sq13auwcvOManjZLfMjQvk5RfLFXS+kabPy3WonGHHFPkyh7FQiLCH/Zg/MtLqTk7d83hwdKpkN9OyTe8V2S4SygamivTWFQwf3IIYrYANCR+rqxNPZmjW3UZdnPoTVroBs1BIJQwY14OJD7wuvYZIHpW2UaD+8fjMKDfDSiJK8d76l/rg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(261026121527099003)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261022075727099003)(261022105027099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BEQxunIRrIuwgcJDqDOR866ArWsUQlDHbD+R5b1bWmQH9hvzi7+WjAwGMvUF92sUCEZoBE5B65u+muy2Zx2bzRR6fYkHgaR8vhUJ7dty4c8n1cezUxGbkACy588nmelmlTiyYKjc8JrgfhPuR40FCakuE/eYb9TFAIXnu6yMl5422w9QccG6Xth172/45Qf+VXLFl+fQUST0V+qOF32efthCraxTqYT5wVYoQDPWGhabcNmmCy8FC6XO11A2uHT5XTt7WGX3C+WDLLIyFfV1nwyNtK0YSl9I+I4O+3kLQEVBIyV6/tiQCtV3wBqcTeIyGJ3tLhgSFHSgGiKa6sHJQiOuAQqSlclxlPr9ny2+oSI9RUn/eQf+oi7Wq+Ar0FO5ZDXz+Odu28A3NxuNHB50RxZlZl0fKM/3g4EmgSCuJf3QM0D+dhKQAxfstdNzec1J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:05:50.8640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7f5ca7-daec-45e1-754d-08df4a340c01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000068.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627

From: Zhi Wang <zhiw@nvidia.com>

The boot request describes a vGPU's identity, channel map, VRAM,
plugin heap and log buffers to GSP-RM.

Add the NVKV schema and encode it from a named boot description. Pass
VRAM region views so each physical address stays paired with its length
until encoding, and retain the control offset relative to the plugin
heap. Represent channel-map engine and index fields in their 16-bit wire
domains.

Describe one guest VRAM segment and the current whole-GPU,
non-SMIG resource layout. Keep separate MIG-RM heap fields zero for that
supported firmware path.

Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs         |  11 ++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs  |  12 ++
 drivers/gpu/nova-core/vgpu/fw/commands.rs | 143 +++++++++++++++++++++-
 3 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 5887a61af02a..0e8e14f98059 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -131,6 +131,17 @@ pub(crate) struct Array<T, const N: usize, const KEY_ID: KeyId> {
     vec: ArrayVec<T, N>,
 }
 
+impl<T: Default + Copy, const N: usize, const KEY_ID: KeyId> Array<T, N, KEY_ID> {
+    /// Creates an array filled from `values`.
+    ///
+    /// Fails with `EINVAL` if `values` is longer than `N`.
+    pub(crate) fn new(values: &[T]) -> Result<Self> {
+        let mut vec = ArrayVec::default();
+        vec.extend_from_slice(values)?;
+        Ok(Self { vec })
+    }
+}
+
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
index c6891c0441ff..c4578e3ecef9 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -7,6 +7,7 @@
 use zerocopy::Immutable;
 
 use super::{
+    Array,
     Index,
     IndexedKey,
     Key,
@@ -130,6 +131,17 @@ fn encode(&self, encoder: &mut Encoder) -> Result {
     }
 }
 
+impl<T, const N: usize, const KEY_ID: KeyId> Encodable for Array<T, N, KEY_ID>
+where
+    T: Default + Copy,
+    for<'a> IndexedKey<&'a [T], KEY_ID>: Encodable,
+{
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        IndexedKey::<&[T], KEY_ID>::new(Index::new::<0>(), self.vec.as_slice()).encode(encoder)
+    }
+}
+
 impl<T: Encodable> Encodable for Option<T> {
     fn encode(&self, encoder: &mut Encoder) -> Result {
         if let Some(value) = self {
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index d1864d7ab530..666c549e55b1 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -8,18 +8,157 @@
 
 use kernel::{
     alloc::ArrayVec,
+    bitfield,
     prelude::*, //
 };
 
 use crate::{
     gsp::nvkv::{
         nvkv_decode,
+        nvkv_encode,
         Array,
+        Encodable,
+        Encoder,
+        Index, //
         Key,
-        Required, //
-    }, //
+        KeyId,
+        Required,
+    },
+    mm::vram::VramRegion,
+    vgpu::Dbdf, //
 };
 
+#[derive(Clone, Copy)]
+struct SwizzId(u32);
+
+impl SwizzId {
+    const WHOLE_GPU: Self = Self(0xFFFF_FFFF);
+}
+
+impl From<SwizzId> for u32 {
+    fn from(value: SwizzId) -> Self {
+        value.0
+    }
+}
+
+bitfield! {
+    pub(crate) struct ChannelMapEntry(u64) {
+        15:0 engine_type;
+        31:16 index;
+        63:32 chid_offset;
+    }
+}
+
+impl ChannelMapEntry {
+    const KEY: KeyId = 0x1001;
+
+    #[expect(dead_code)]
+    pub(crate) fn new(engine_type: u16, index: u16, chid_offset: u32) -> Self {
+        Self::zeroed()
+            .with_engine_type(engine_type)
+            .with_index(index)
+            .with_chid_offset(chid_offset)
+    }
+}
+
+impl Encodable for KVVec<ChannelMapEntry> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        // SAFETY: `ChannelMapEntry` is a `bitfield!` over `u64`, i.e.
+        // `#[repr(transparent)]` around a `u64`, so the entries are
+        // layout-compatible with `u64` and can be viewed as a `u64` slice.
+        let slice = unsafe { core::slice::from_raw_parts(self.as_ptr().cast::<u64>(), self.len()) };
+        encoder.encode_array64(ChannelMapEntry::KEY, Index::new::<0>(), slice)
+    }
+}
+
+bitfield! {
+    struct VgpuBootloadOptions(u64) {
+    }
+}
+
+nvkv_encode! {
+    struct VgpuBootloadRequest {
+        dbdf: Key<Dbdf, 0x0001, u32>,
+        gfid: Key<u32, 0x0002>,
+        vgpu_type: Key<u32, 0x0003>,
+        vm_pid: Key<u32, 0x0004>,
+        swizz_id: Key<SwizzId, 0x0005, u32>,
+        num_channels: Key<u32, 0x0006>,
+        num_plugin_channels: Key<u32, 0x0007>,
+        guest_fb_segment_count: Key<u32, 0x0008>,
+        options: Key<VgpuBootloadOptions, 0x1000, u64>,
+        channel_mapping: KVVec<ChannelMapEntry>,
+        guest_fb_segment_phys_addr: Array<u64, 8, 0x1002>,
+        guest_fb_segment_length: Array<u64, 8, 0x1003>,
+        plugin_heap_phys_addr: Key<u64, 0x1004>,
+        plugin_heap_length: Key<u64, 0x1005>,
+        ctrl_buff_offset: Key<u64, 0x1006>,
+        init_task_log_offset: Key<u64, 0x1007>,
+        init_task_log_size: Key<u64, 0x1008>,
+        vgpu_task_log_offset: Key<u64, 0x1009>,
+        vgpu_task_log_size: Key<u64, 0x100A>,
+        kernel_log_offset: Key<u64, 0x100B>,
+        kernel_log_size: Key<u64, 0x100C>,
+        mig_rm_heap_phys_addr: Key<u64, 0x100D>,
+        mig_rm_heap_length: Key<u64, 0x100E>,
+    }
+}
+
+/// Identity, channel mapping and VRAM regions passed to a GSP plugin at boot.
+///
+/// Region addresses are physical VRAM addresses, including the log fields whose wire
+/// names contain `offset`. The control-buffer offset is relative to the plugin heap.
+pub(crate) struct BootloadInfo<'a> {
+    pub(crate) dbdf: Dbdf,
+    pub(crate) gfid: u32,
+    pub(crate) vgpu_type: u32,
+    pub(crate) vm_pid: u32,
+    pub(crate) num_channels: u32,
+    pub(crate) num_plugin_channels: u32,
+    pub(crate) channel_mapping: KVVec<ChannelMapEntry>,
+    pub(crate) guest_fb: &'a VramRegion,
+    pub(crate) plugin_heap: &'a VramRegion,
+    pub(crate) ctrl_buffer_offset: u64,
+    pub(crate) init_log: &'a VramRegion,
+    pub(crate) vgpu_log: &'a VramRegion,
+    pub(crate) kernel_log: &'a VramRegion,
+}
+
+/// Encodes a `VGPU_BOOTLOAD` request using the typed NVKV schema.
+#[expect(dead_code)]
+pub(crate) fn encode_vgpu_bootload(info: BootloadInfo<'_>) -> Result<KVVec<u64>> {
+    let request = VgpuBootloadRequest {
+        dbdf: info.dbdf.into(),
+        gfid: info.gfid.into(),
+        vgpu_type: info.vgpu_type.into(),
+        vm_pid: info.vm_pid.into(),
+        swizz_id: SwizzId::WHOLE_GPU.into(),
+        num_channels: info.num_channels.into(),
+        num_plugin_channels: info.num_plugin_channels.into(),
+        guest_fb_segment_count: 1.into(),
+        options: VgpuBootloadOptions::zeroed().into(),
+        channel_mapping: info.channel_mapping,
+        guest_fb_segment_phys_addr: Array::new(&[info.guest_fb.range().start])?,
+        guest_fb_segment_length: Array::new(&[info.guest_fb.len()])?,
+        plugin_heap_phys_addr: info.plugin_heap.range().start.into(),
+        plugin_heap_length: info.plugin_heap.len().into(),
+        ctrl_buff_offset: info.ctrl_buffer_offset.into(),
+        init_task_log_offset: info.init_log.range().start.into(),
+        init_task_log_size: info.init_log.len().into(),
+        vgpu_task_log_offset: info.vgpu_log.range().start.into(),
+        vgpu_task_log_size: info.vgpu_log.len().into(),
+        kernel_log_offset: info.kernel_log.range().start.into(),
+        kernel_log_size: info.kernel_log.len().into(),
+        // The current non-SMIG firmware path does not map a separate MIG-RM heap.
+        mig_rm_heap_phys_addr: 0.into(),
+        mig_rm_heap_length: 0.into(),
+    };
+
+    let mut encoder = Encoder::new();
+    request.encode(&mut encoder)?;
+    Ok(encoder.finish())
+}
+
 nvkv_decode! {
     pub(crate) struct VgpuPropertiesSchema => VgpuProperties {
         // TODO: `name`/`class` required?
-- 
2.53.0

