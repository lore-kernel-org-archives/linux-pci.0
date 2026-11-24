Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529109;
	b=HzmYmC4n6fRQ/TFsyCXvCVn3q7Z5ldIvyXreYZBy25fI4Ec4PRtkNf1HdVNMIlc0y5kg
	 mHdgYmuSaW8fUMzsPB6SCScBcsrMx/hZvZzqAOwuZGt3nEspkr4671muiPRQ5WjaAMd2g
	 sDyvzww4/MrchPcmTEkC6L8NwcWq8B1SlmfKsoOlKykDVt9G+oJnqDD8qd7r9ZigAWq41
	 COEhEmwWwWMtaMXrWyfhB5+ud7GxilmwbBhnwubMC7CveejbirdoZgtv0jqmKdLMiHlfO
	 gp7HwMzlVTHeFLyyBqJwyG8/X2kZDUny9XKGpDplfYHdhYbgoPR/+ejwvKYWmAtAFfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529109;
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
	bh=0HM2Iu2ctqUbbADP3XlxOA6ED6IyPisUJlgAwQ0Yp4c=;
	b=OsSr6Yi/yHGHzoXdydYEJ//j6nF7eShN0oljI4aok2Y+0rXygEc4dP9VXOEDACAm4pOM
	 ZaeLX5oYXpMBneMxoGvHoLfGGgtTJZIifnlVolAYBWEoQrIYip4WzCHGZZYdew8DCXbKn
	 fXPmj9rEfyUdUfLmuyHzIQy5VoFbQHJQYUh32Bco8WQHyEnfw7A7cEZPqpaP50Pq5kmvv
	 4guT3cGsLNBdCXgDLOzgzwheyzjZRhXUbQAHYVXQUkUKTKlAPIv7qFSabieZ4CaXJPxN+
	 8Bd5yJ1PlrOzQOgvhtu7FYrPAE4X7wIjRMZiqozJqmG67+T4TQBn4tLWGu+1g6A85nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=caIlie93;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.58
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006C606A6BD;
	Tue, 24 Nov 2026 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C006C606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=caIlie93
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn3BX3RnZ/RbkMjojYtP3ZlmC/771IgN96ET7h+ucBZzfFDF0IDDmrWQCTSqB24iGpC8po/j/GQrJOCNdCNlZSFLlXM7NKhlRT1eZjjU+m5Bfea3PNmneU9eL7W+xEjkkdFPEYJKHHOIeak5/glo/UMG0bLPz1LzuwD4xu+MiUO6vMcyWZtiw9Wvag3bLVGAn4POMF9rs1PhUddEKpN5ejU96B7GXRIqvgKLYpOHKec9ChpiQmlK9UFy/Szfk1rpd9603zS/cfzSEqDPdMyUHIX3H8R17c4hL1zkINyK7vcWMEch/lzbkPwZa6n0NwuYV1F7ikTVz4ztOtgXowmKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HM2Iu2ctqUbbADP3XlxOA6ED6IyPisUJlgAwQ0Yp4c=;
 b=EzNkNeDHpaUlDV+N/hLesG4Mcr5rmtahMsjNdeLTjKbrpnZmMr5lAq4j1mdwXllJ2nOGeajh+d5LlPuv/s/AlcQTl0t6iw24yLj7CDP3n9k4KmiDWyp8jtM1uqRWz4ToF+g8kSz0iPSpAlQBLd+GCaKwGNBwT26kkFkoRgUXWMFU1lyz8YvI7yHiW0oCGKbWwqFIFRviU/OHxU0ahgroQZYaNyu6ymlUfmChvqzJGoc/o/v0Xr82PlovvUNRqZbBXivO03PaMAUcI+mfT1GKGEFN7pZC6wKZYff2HMU14tPhejNtMfV2fzqJUfvouaAg6ApgIpEejYctdeRJRTzbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HM2Iu2ctqUbbADP3XlxOA6ED6IyPisUJlgAwQ0Yp4c=;
 b=caIlie93JSl2ZeqADs8wdL0f5A8Ht0KG5StlYws7PrGXS6zollwXh/BHjahOwCpda0bgSKP1wUcza5PInTbsSqGEBfU5ikve8eDxslrNxhLl84J7g9talAlhomNhliy708PeSO4zlLF+SGjAONI4yT3tYnjx03yEUTvpCWLAKhMmaxnxV7aqYlPa/EmEuW5WFMaPvfgehgTqbOc0HCCFRkZddr/9USUjpxxz/FImEDNE435D6MbYie3fiz3QmU3dXPETjIvmTuVxh2dDolhc1NodjA86n22EIvecr1KcWs4kZsY3cojMTtoqqvFnh6uUrrO5cio8LC1osa0oXj0Wdw==
Received: from PH0PR07CA0047.namprd07.prod.outlook.com (2603:10b6:510:e::22)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:04:59 +0000
Received: from CY6PEPF0000004E.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::a1) by PH0PR07CA0047.outlook.office365.com
 (2603:10b6:510:e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 14:04:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004E.mail.protection.outlook.com (10.167.247.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:04:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:04:31 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:04:18 -0800
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
Subject: [PATCH v5 20/35] gpu: nova-core: gsp: factor out NVKV payload conversion
Date: Tue, 24 Nov 2026 19:29:16 +0530
Message-ID: <20261124135937.18583-21-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004E:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: d94ceb3a-7131-4bd6-bdb7-08df4a33ed48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|1800799024|36860700016|6133799003|22082099003|18002099003|3023799007|56012099006|261021123027099003|11063799006|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	7M6Rt2AEjPEhaFAIUncyTp+CYhzdytoo7eicrxuX72lF2/nlea+4nc90LZn6p2PKYS4ppfeY/2uJ3fP9d0ZkgKxjoJKNXsDMYFEzzvzc8JidmIDNXSwDJgZ1eVmR4tJs4I7QEGVrzOTIt+j8cWWRW6qfR3tsmX0w792LaSAa6P+fQAAT/a0Ip/6KVwTDtlLNC7P0gS9fU/5xS9xqHRyLzVL7ZdAcXn8La+pUvbZssNnqqEkiB1D4cuWhU5AT6+u25ElwHfNDI68ub0+sh+KQgKPJEUKn84BQEuhf35MFqao5UnCgcJcyKAAdtIu8AoOLR+0LVXYXk7fkdSdMcXBzmM2oG8SG8CzivIMEI0JNwJQz4rGJhe8KS/k2vFSiev83859CbjunjiKY+QDt85Yw2XXhZ82Z9YScXM7UbJ99mE4Gm1pKPwOFJYLErVz2Fo6nkOrH4Zfr1FkscsWFei2+Ea772rdmOSCofiw5MiP7omjWj6h6RwAS6OVuad16MK9yddnBHTW09OB80RLEYRue0A7bA5Cu+WsZDtIuHXZDVBD92oSJ2Ooh5K7u8jRiQsnm4uFbBQ64HRx/vN8H0vDVuYJrXZu5hwyPiBsusWlL3BjxakHUexFfWrA8zoUXauXuORURvvSAdy4hnDYFV26cegj9rffMY3NsieSCbY1Vj2vQaDxD0+jUqtS4cIMrWX7DibRT4Hwo6iXU4w7aIaSWHQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(261021123027099003)(11063799006)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RA+aV4Xr8S4cP/1sUeVIVoTe2ksz0YUqoT1oLa4UIEwvsNLmt/nrXtrjSREcop83UZFC5YuAkV1srQ1XsRfn114c63mvjfRefTykS1HH4lbGhkgHxB3LEUv1hIYFiPfxHhHevS+498D4nchhu7PrU61Wc63c8Scy0IlyPp89/9GqGPrbfokcKRhpywHPqmBwI5HNKyOiE2SODHorGBFxlt27F73sY2jhm9swCIQCq+vo09UU/IUjo+RzxQMyYkDtJpBYpYfJsohJ9vnyjwOJHkbrBPX6oiDtcz7IF2XJOuXQmDzIS4lEt++jnAIajzx9UmuOR0iMpLXb21syYKdGv4DcYUIgd04cpWgH2G6QggxRujAZRjY2kJ87MkQR9W0IBwCMTiDr9NqxXcGyI6/JqWN8bgVK5vieEJBJtrEt7z3oBV+yEoxcHdWnIH9mIMKT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:04:59.4030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94ceb3a-7131-4bd6-bdb7-08df4a33ed48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E

From: Zhi Wang <zhiw@nvidia.com>

Both GSP initialization and vGPU property queries decode their replies as
NVKV streams.

Move the byte-to-word conversion helper into the NVKV module and make
that module accessible to the vGPU firmware interface.

No functional change is intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs              |  2 +-
 drivers/gpu/nova-core/gsp/commands/gmc.rs | 12 ++-------
 drivers/gpu/nova-core/gsp/nvkv.rs         | 31 ++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index efb94aad417a..4bce365c96e5 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -22,7 +22,7 @@
 mod fw;
 mod load_exec;
 mod logbuffer;
-mod nvkv;
+pub(crate) mod nvkv;
 mod regs;
 
 use logbuffer::LogBuffers;
diff --git a/drivers/gpu/nova-core/gsp/commands/gmc.rs b/drivers/gpu/nova-core/gsp/commands/gmc.rs
index e1d47e86c82e..81abeb3264ce 100644
--- a/drivers/gpu/nova-core/gsp/commands/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/gmc.rs
@@ -31,6 +31,7 @@
         GmcCommandId,
     },
     nvkv::{
+        nvkv_words,
         Decoder,
         Encodable,
         Encoder,
@@ -146,16 +147,7 @@ impl MessageFromGsp for GspStaticInfo {
     fn read(payload: &mut MessagePayload<'_>) -> Result<Self> {
         let bytes = payload.flush_into_kvec(GFP_KERNEL)?;
 
-        let chunks = bytes.chunks_exact(size_of::<u64>());
-        if !chunks.remainder().is_empty() {
-            return Err(EINVAL);
-        }
-        let mut words = KVVec::with_capacity(chunks.len(), GFP_KERNEL)?;
-        for chunk in chunks {
-            // `chunks_exact` yields slices of exactly `size_of::<u64>()` bytes.
-            let word = chunk.try_into().map_err(|_| EINVAL)?;
-            words.push(u64::from_le_bytes(word), GFP_KERNEL)?;
-        }
+        let words = nvkv_words(&bytes, &[])?;
 
         let decoder = Decoder::new(&words, UnknownKeyPolicy::Ignore);
         let mut schema = KBox::init(GspInitResponseSchema::init(), GFP_KERNEL)?;
diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index f81a9e60d89c..5887a61af02a 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -20,11 +20,40 @@
 use kernel::{
     alloc::ArrayVec,
     bitfield,
-    num::Bounded, //
+    num::Bounded,
+    prelude::*, //
 };
 
 use crate::bounded_enum;
 
+use crate::sbuffer::SBufferIter;
+
+/// Joins the two halves of a wrapped payload into the `u64` words an NVKV stream is made of.
+///
+/// # Errors
+///
+/// - `EINVAL` if the combined length is not a whole number of words.
+/// - `ENOMEM` if the buffer cannot be allocated.
+pub(crate) fn nvkv_words(payload_0: &[u8], payload_1: &[u8]) -> Result<KVVec<u64>> {
+    const WORD_SIZE: usize = size_of::<u64>();
+
+    // Each byte slice is at most `isize::MAX` bytes, so their sum fits in `usize`.
+    let len = payload_0.len() + payload_1.len();
+    if len % WORD_SIZE != 0 {
+        return Err(EINVAL);
+    }
+
+    let mut words = KVVec::with_capacity(len / WORD_SIZE, GFP_KERNEL)?;
+    let mut bytes = SBufferIter::new_reader([payload_0, payload_1]);
+    for _ in 0..len / WORD_SIZE {
+        let mut word = [0u8; WORD_SIZE];
+        bytes.read_exact(&mut word)?;
+        words.push(u64::from_le_bytes(word), GFP_KERNEL)?;
+    }
+
+    Ok(words)
+}
+
 mod encode;
 pub(crate) use encode::*;
 
-- 
2.53.0

