Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943957;
	b=433YHGE712CT5aYcbyzep5QzGdlzE9OoG27s0UiWNabWtxQRyPrtLC0x+SuB2jbymWl1
	 KiMhs4SUAK7ewd8eNfxqMhlRmXQH/ifR0qQ71aJ2ueK5B4fCPYXNf33Y5xZcTJkIZjdx3
	 pXUcLGaSIHK/OclsgdiYANtda6kqhkss62w4x4QF4dNe2FP64hdpt1nbK/NsoIocyOrKD
	 o6ZHtkjj4/dVeLILTfnU0jxYpOON+CxkNSZDXuCvlWIY6zKfh9sq/JhPpxpmtI3tPAuwt
	 il51M9whakmnH3BlvyTADsj5cYQdGb3+Eyll4Glt5jwVvYjwa30LlRGlpAtAYEopHxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943957;
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
	bh=vPYM1T6goIVDlqPEqZhKTULmYmiXOcDZ/kyvo981XMY=;
	b=ZcNJpraMfLDdXVSX9pi4QjX8TA8cRWOEbV1OksVmZe2XIkd4HC2jJdyI003RqzUMwWUu
	 4APguwpnP8iR9Xt2r3PIZKd73YvqSJDSPZkpDTl3bcGDQL/NTiK9I3C10QhUxsJnOQxoq
	 8ua8SSzs4KhjbTC+AfWCZhvqy5xiN4V4rKx5Og0EC++K1nx21t2EilSxaOAMuQP4u8yIh
	 E5f4QFmZYZnPMaml/TlAhSwjr80MxSsVWugvcFTNRDg6Z13beH/o/06+VNR6+Kng6JIKL
	 kkgca+CBl4LaO5t92RxKgmrZyOYrxUsuXKnIa0ZbxszBKujly38ewXrE03drdP+dQ+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lRROjye9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.59
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9E606A32D;
	Fri,  6 Nov 2026 05:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5E9E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lRROjye9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfmyv0DdEcKK7vBHsA9+ewEwiLYu16nyHdXeI/qttg4v1C+yXuWZ2xKa/QCFsxenFrI7OAt1KshhUOHrr12T+UhAgMin3Ku4hTOsQKNDooUiez+JeL4OXtZ6P+MAMEkAKp6kaRp69s4jZ25xB4pqcmnYA4XsIIfjoEhjelZhZSI34PnA+vO/kZ1ujJCjIUT/KMdeIR1nwIoq7TEKBsLi3oFDoo1FvTx7Ek6+pmLqr6j6YMIFtIOi1nIRMMC7dygxBw9TZhU7Ft1VtKHy9aKWsenV3TJA2oEGWI5YZOPhH4eMz223v1eoOVrOpAOVmR7jlIti4aXmlCsjzrfBztbnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPYM1T6goIVDlqPEqZhKTULmYmiXOcDZ/kyvo981XMY=;
 b=bQxwYJ/vgx5HMOzoFN5nSqDG9ZKIsOztDD+VdSPGRu2GvqUqtxdRRArP1LtddUW8iphOIZz7opH+oIIpc9fXOJwhYjnvlJuoDk6q5C60ac9nkijOKuLeaJgnkD8xmusdjmpdcNf4LjVDyrfd0TxynCihLsJYJE8sDd/3sSY4cpnm8crk57UVKSg0xYETLLazg6hG/KIkRcDPeL0oMhbSXOmX9EtmsGqDlf/50uE1nyfdxszkyydkNuQrB6LQA2scVBQG2AI0cbLAJiFPTICE3Gj2/hYTytaCJ7C/o1gxyvjF6mnic/b6WH8Z2o18C31+TJ4R1p2YFaxlNEa3VZuhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPYM1T6goIVDlqPEqZhKTULmYmiXOcDZ/kyvo981XMY=;
 b=lRROjye9NPEJdTJlpYMrcppp8YazkCJ8Z9d6r6/eIHQ6TnQgXXKaDp/zGiaNCMZ+KLp1hJEDGoGd7m6UIxor4ePw/xKxDCd+sNIK0enuneDotqEemhp1G80wCg7EAHcmR5Epffawt2BOJMytSehYkHc4O+82d0kvkyml1iv+j2D64DLtda3T96V/d3VaLyRs3JPDgljsLDBA6LpPRfuCb+/ej5yMVnggXyoW/2/wixtoK6lCLnBkNzOMzwdaahsB9rMw0hAyL/XUwOfSkK14KArcdypQljh4advUlD93xksjo2kuZGG+sbWRiPaYeJ6+wFIOHYuSVE+Mng6kahmA4w==
Received: from PH7PR17CA0037.namprd17.prod.outlook.com (2603:10b6:510:323::28)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:45:47 +0000
Received: from CY4PEPF000392DB.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::72) by PH7PR17CA0037.outlook.office365.com
 (2603:10b6:510:323::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:45:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392DB.mail.protection.outlook.com (10.167.247.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:45:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:45:25 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:45:12 -0800
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
Subject: [PATCH v4 20/32] gpu: nova-core: vgpu: encode vGPU boot requests
Date: Fri, 6 Nov 2026 11:09:53 +0530
Message-ID: <ee73ba913c15d9cdeca02da9258088333d6a2217.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DB:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b61ee0a-1b50-4caf-50b9-08df3bc934e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/jDaOhvhxiqBuqtqTQaOix4b6L4y9PCtVp4V+ABvS3kUZSvTeSymupk5yyEMQjQP28EunWewbQv6Geg03b6pRv8nC+qQUVwwZIbplIDOZM78f9CZWxtPOzIdZsCfURos+oDzgsltTKZcuOoj6KI0a/4e/hphqFmFtjr5JMNYVWmsEr2E9l9OsnJGUZ4t/K+LkG9yByaMTa4uXyXvAYOfGIUd1WOn1mGUjI7At5KjHN4AxO7Z63tBWwKFGSTt8VQ72lruEqjDHGSaeAooWcJ6IGYYYvJCcYv0ojWJq+0c9J4EuMrr2NDvJ8T7qUnW8yVfMoCRTcUxFfmNDedSxqq1Fvf94Pn0tqkVF2gRqHiLa+4REKMvDLoWhb1Es70yyQd7hjdfWxbR3I/uB+5j8rQOccJNA3LnqgEQvT1RzZ3YVALCdI1kjagGXXFj9GWecc8yffwfrG4or36kx4aZ7wb4mCLWGRoTT9ZBHLl0KG2Tur+9Elw3sLCSBNB0M35ngihavOJ6pge8vMe6ZaiShIeYcIuBZB4BHpAoBthBXgEHG8kr7YXhKbMHwF9XzYWMAAicnh5wGB/nO76lHVsEes2ZQ8borNxx7lMtxfPk3RQMcARQzQQOTPYnlQUyEpZqIVBytIKgetTJQDGb1IfpvbCDYb3yhuOxitKmUs5frZhU1IitA/rUlie+botSNfFr11xK7n5SrO6rGQ2gP3yTb7qqrg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GXf1gnURZCL5tAs6uZxXIdhI2gTsFHMg2P24Gc87IBj+rNzmi+GTjHM8tbB5hYGKeHV03iora+gJz0U11FSKp8qWIQF+Db+jo7ZCCrlR4H/sWL2VEClauIzGHUzPMfES+aI/vkO8IJgcdjXi1sE1AQsSk8wPP2pcDLHXsfrXR+/KoHOT+0RdWIlx6zDCVHWRDLcShRLvY71zPnKgp1JBwz4nolCdqZSF3Bth6dZdwqSSDHtKF2WKHQOjeROmqQzispIbZATxIgQA+YFjtGOcg98vF76jZxa0G63ONBKqBaIRhbjep0Z8SWWJLskIlm4hLkPwvCoHCJRLD6L20tEkEycO2IUw9Slw5W26RMWrWOtSxG8IFMrAm6Q4iHm2pwc4RR1H+z+/mXEY/qxO2Oletml6g9J5XycevbyQX8xKdpgLpJ6GC1JO+G1knEIVEnzI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:45:47.1290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b61ee0a-1b50-4caf-50b9-08df3bc934e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

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
 drivers/gpu/nova-core/vgpu/fw/commands.rs | 168 +++++++++++++++++++++-
 3 files changed, 188 insertions(+), 3 deletions(-)

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
index efab30287f05..b8007c3e4a71 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -8,17 +8,23 @@
 
 use kernel::{
     alloc::ArrayVec,
-    bitfield, //
+    bitfield,
+    prelude::*, //
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
         KeyId,
-        Required, //
-    }, //
+        Required,
+    },
+    mm::vram::VramRegion, //
 };
 
 bitfield! {
@@ -30,6 +36,162 @@ pub(crate) struct Dbdf(u32) {
     }
 }
 
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
+        dbdf: Key<Dbdf, { Self::DBDF_KEY }, u32>,
+        gfid: Key<u32, { Self::GFID_KEY }>,
+        vgpu_type: Key<u32, { Self::VGPU_TYPE_KEY }>,
+        vm_pid: Key<u32, { Self::VM_PID_KEY }>,
+        swizz_id: Key<SwizzId, { Self::SWIZZ_ID_KEY }, u32>,
+        num_channels: Key<u32, { Self::NUM_CHANNELS_KEY }>,
+        num_plugin_channels: Key<u32, { Self::NUM_PLUGIN_CHANNELS_KEY }>,
+        guest_fb_segment_count: Key<u32, { Self::GUEST_FB_SEGMENT_COUNT_KEY }>,
+        options: Key<VgpuBootloadOptions, { Self::OPTIONS_KEY }, u64>,
+        channel_mapping: KVVec<ChannelMapEntry>,
+        guest_fb_segment_phys_addr: Array<u64, 8, { Self::GUEST_FB_SEGMENT_PHYS_ADDR_KEY }>,
+        guest_fb_segment_length: Array<u64, 8, { Self::GUEST_FB_SEGMENT_LENGTH_KEY }>,
+        plugin_heap_phys_addr: Key<u64, { Self::PLUGIN_HEAP_PHYS_ADDR_KEY }>,
+        plugin_heap_length: Key<u64, { Self::PLUGIN_HEAP_LENGTH_KEY }>,
+        ctrl_buff_offset: Key<u64, { Self::CTRL_BUFF_OFFSET_KEY }>,
+        init_task_log_offset: Key<u64, { Self::INIT_TASK_LOG_OFFSET_KEY }>,
+        init_task_log_size: Key<u64, { Self::INIT_TASK_LOG_SIZE_KEY }>,
+        vgpu_task_log_offset: Key<u64, { Self::VGPU_TASK_LOG_OFFSET_KEY }>,
+        vgpu_task_log_size: Key<u64, { Self::VGPU_TASK_LOG_SIZE_KEY }>,
+        kernel_log_offset: Key<u64, { Self::KERNEL_LOG_OFFSET_KEY }>,
+        kernel_log_size: Key<u64, { Self::KERNEL_LOG_SIZE_KEY }>,
+        mig_rm_heap_phys_addr: Key<u64, { Self::MIG_RM_HEAP_PHYS_ADDR_KEY }>,
+        mig_rm_heap_length: Key<u64, { Self::MIG_RM_HEAP_LENGTH_KEY }>,
+    }
+}
+
+impl VgpuBootloadRequest {
+    const DBDF_KEY: KeyId = 0x0001;
+    const GFID_KEY: KeyId = 0x0002;
+    const VGPU_TYPE_KEY: KeyId = 0x0003;
+    const VM_PID_KEY: KeyId = 0x0004;
+    const SWIZZ_ID_KEY: KeyId = 0x0005;
+    const NUM_CHANNELS_KEY: KeyId = 0x0006;
+    const NUM_PLUGIN_CHANNELS_KEY: KeyId = 0x0007;
+    const GUEST_FB_SEGMENT_COUNT_KEY: KeyId = 0x0008;
+    const OPTIONS_KEY: KeyId = 0x1000;
+    const GUEST_FB_SEGMENT_PHYS_ADDR_KEY: KeyId = 0x1002;
+    const GUEST_FB_SEGMENT_LENGTH_KEY: KeyId = 0x1003;
+    const PLUGIN_HEAP_PHYS_ADDR_KEY: KeyId = 0x1004;
+    const PLUGIN_HEAP_LENGTH_KEY: KeyId = 0x1005;
+    const CTRL_BUFF_OFFSET_KEY: KeyId = 0x1006;
+    const INIT_TASK_LOG_OFFSET_KEY: KeyId = 0x1007;
+    const INIT_TASK_LOG_SIZE_KEY: KeyId = 0x1008;
+    const VGPU_TASK_LOG_OFFSET_KEY: KeyId = 0x1009;
+    const VGPU_TASK_LOG_SIZE_KEY: KeyId = 0x100A;
+    const KERNEL_LOG_OFFSET_KEY: KeyId = 0x100B;
+    const KERNEL_LOG_SIZE_KEY: KeyId = 0x100C;
+    const MIG_RM_HEAP_PHYS_ADDR_KEY: KeyId = 0x100D;
+    const MIG_RM_HEAP_LENGTH_KEY: KeyId = 0x100E;
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
+        guest_fb_segment_phys_addr: Array::new(&[info.guest_fb.address()])?,
+        guest_fb_segment_length: Array::new(&[info.guest_fb.size()])?,
+        plugin_heap_phys_addr: info.plugin_heap.address().into(),
+        plugin_heap_length: info.plugin_heap.size().into(),
+        ctrl_buff_offset: info.ctrl_buffer_offset.into(),
+        init_task_log_offset: info.init_log.address().into(),
+        init_task_log_size: info.init_log.size().into(),
+        vgpu_task_log_offset: info.vgpu_log.address().into(),
+        vgpu_task_log_size: info.vgpu_log.size().into(),
+        kernel_log_offset: info.kernel_log.address().into(),
+        kernel_log_size: info.kernel_log.size().into(),
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

