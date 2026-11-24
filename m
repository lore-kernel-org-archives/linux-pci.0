Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528876;
	b=WASk7nAsB4UG86rPwMVO/UMjU6wRMiofKnl37ywoZtTJ3KSawMyqk9KMH4Fjyf5Z6mCd
	 LWJ5Jn0GfgLGDjOMWFxu0Exhpb/0Zj+ueYn/JDkk8T1CH79xr36tKhI+2PadBH2LQSWut
	 7igc/eUYq37FC7HLQLuZ9SBLzSM3cgX+SDHaT8TsKkY47lGDf8ID3IgvGzD+QBJh6npfn
	 lFloTKN+pSLj6T3/9Q5cQeFcQ9eca5mEwvti63lOGsHMAJBE3PxtosDQ0hGunRkbrLXW9
	 mCZS1BMQY96HWwY9ce4hGtKDqvSPj/uyZS98wHzCJfgl7ibx9/poE6ELp+pbGit206A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528876;
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
	bh=CKj2BSaqmpQACWLpS+LLKIVibv3t1DLxijzOi9MVTgg=;
	b=3axyO//BTy/a6rnzrPHacHJMDozOoNp1Vb17PrYKTwpbY+XTfL5Z0ThbyYSC22dukj4q
	 8nbYMdct3VlBKs86B2rWxUCp1Uo4OoCzsQNSqqPjIv0DOoi0Hy0gdBKJ4zOc6OI1gT50t
	 AIoaBmtwVW6/pHJEtunWCn2LAq3lyKO6OlpbR/K6uZg2tDHOSUEZPFszXY2NvQRn721iN
	 y9GEordUuvmbTqm3Qp4c8PeYdfwX6cH7Hxiv+yKx00Ye9eXVED37cbIHJx+hcsLdvRlkO
	 zzAGDgXFO3HLo0WzWth6wsk/nfVWAME1r5cRfoeEXyeniCAdk2QoXvtvQ6vQQQnS4iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XX9k3prf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0B606A31E;
	Tue, 24 Nov 2026 14:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25B0B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XX9k3prf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj/t+I8pjqyIaoKzV9Ye/uaRLrOVXeMvlClDRhlHWSRnMmmoeHLmkgB6Q12a8PR27LxEht8rt9U/yOnNMESIBILjK4ShdMmvl75bW3IpQy1g+R/027SIsTlk1Rd4bQBUa/JNZR4fhTrNq1JS6cj/tv6drSMlPPgGxcCnC4ctaqLq/TFix9kIpNgTG9y6Wvgy7iMFLz4Q0B9KTXj65jzUAB8pmM5dM0Cs5UIRjrfQfmKhTww7MAmUK/4Pfqy6aNjOoOdj5oeN2MaxVZnX6aAtb6Pl2fJbb5a133mKjM3rzzqAA34hQTh9CmjVbf4kGrGHg4C7VrR3+nWnKM/KqSmfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKj2BSaqmpQACWLpS+LLKIVibv3t1DLxijzOi9MVTgg=;
 b=ECrf1KEutsl6pMqqAriSvEHjRt1UQe+6iCjJ3cp6ljtZ8mr/doqPqDeaM2DZsGh/s1b3qPCasGNyJkRoz5aacgV/+YFHqxExx7S6z917z8lNbRwWkKWqDeWnVLKYhP4QycRfQSFwNyz4aBj+ImkXgo7S/kUYx2iZdZcZr3pHrTvTvvim80HDXmiihDxqzmoBB4pB6GzNhk9B/FkNcQpSsf+NvKcetF1DkcbMnosOXbo4YrEhbEJYDYBKETYaEl/9SU4ZQCxCa9pm1v4NmkVv3fCubqv1UWscMkpqaNReJodinCaAJITyfh1NGER/eAnFgXeN0E+nEGPHurDyOspRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKj2BSaqmpQACWLpS+LLKIVibv3t1DLxijzOi9MVTgg=;
 b=XX9k3prfG7akshKlkVIaGaey/xneY+hSGPM3SFIZA/h4tSN5c31DVC0lEioBPj+PHV3oqA8Ousy8tweKyI0NMASPvUIZzGxCFrtni3s/Sotgh89RvHyUflAppDxGIUCk7xPD3oaIa/Oj1wJVUqczg1WQJN7IsMXPT0OdUyhjhtTKquL9C46HT0mqtOFiPOZUbCcslfY/xi55hrw7p3JdKul/a+PjoddNffgJZ6S7nfVWrHaKGGiAqCAGZTdMsHJGzhRn1wbvQOgLOvBAvIuhDSkS1ixMqOWSwaqhXYaXzHvp64DrI9eyqSsyBdvAHDXGaLU4gChsRIFghYYlaFzANQ==
Received: from BN9PR03CA0688.namprd03.prod.outlook.com (2603:10b6:408:10e::33)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 14:01:10 +0000
Received: from LV8PEPF00000068.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::34) by BN9PR03CA0688.outlook.office365.com
 (2603:10b6:408:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:01:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF00000068.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:01:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:00:37 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:00:24 -0800
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
Subject: [PATCH v5 02/35] gpu: nova-core: gsp: pass boot context through setup helpers
Date: Tue, 24 Nov 2026 19:28:58 +0530
Message-ID: <20261124135937.18583-3-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000068:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5562e2-b156-4132-30cc-08df4a336297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|261026121527099003|10067099003|261022105027099003|261102123227099003|261026140227099003|11063799006|261021123027099003|56012099006|261022115727099003|261022075727099003|261021121427099003|261028144727099003|22082099003|18002099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+1Ig5K7Sbo1ycsJO6Gkc2pOtSjftBiDzxwgqMQK10m8LbSCwo8qXJyhtduOdP11yOFEL84uogwMGSc3oC18F1Y57Ulehu1v5V6ACEl92EV1nwnMQCfCeoFdFExzd4JICeAg96tGCP7j78NOQ1HBy4LmRaB7ezaWiY4B5RaDnT/skL+3xnwYfvUZRoPzrD2PrGt+iTocEPtyPj8mw5gPowGe30SrJV899A7n/jbS+2lOXFQEhrqIM2lzzaPhgC1ySF8Hq10iWVCx2Jmz+aYqtwHB0vO7e2IqpZ0Vqd1qb38yhrzRE9jH00wEQe3mBLfOZZjlxEpmN1PsnQAUK4BbrOOe8DtP5xDo+uz/O4LZPrShw7MaPNlo36OQC/UYIMi77gUGJx7q6DaDzX/DMTDPH3x5R1jn8tBSq02lxb2OcvsXvYk5ySuHwtaS3XjWv5yc4Dgzme+0yV+AUJ8/Ryjg8eLIEgPieOIAcQaf/YcOqz8cdMpuCChYAGvfvB7T1nvkKS2qGQSMvxFXRFYk03Kyij2z8tt6Mi6ev7rC8x6Js5KLwFFWGaI5X1O6x3poqvaYILwqFQdlDsipeCZfNH+XG2IG1oJJ6ZaaA9Rx1skXtlK/TwhDHOvcZhpkEuPQu1uZQGBCnsqn7wFX9LSs/8cKxV3+8a2cjg98tzNfp6Xw5HAJdoXWW7M+FbQ+748eRwjxOKpQhNlRwjWk16DL1PuE/2A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(261026121527099003)(10067099003)(261022105027099003)(261102123227099003)(261026140227099003)(11063799006)(261021123027099003)(56012099006)(261022115727099003)(261022075727099003)(261021121427099003)(261028144727099003)(22082099003)(18002099003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	grokKufTwo/TjMuRaMmwfkDDKOTJjPxTeHSq+HMowypFIx+R6OmSduSMQerUab5Ur7tWexu12FNK1azlgtCzNT913GV52I0iWykEdhZI22mtrAtQA7WJPLQVXXWVgeMQHY/j6Bq3uVUpYKVQpFNUEZMPTN3lZRTtJE7gen7FaO6WtE+9HRXLHlJg7Dz3BRHxbZP2eTFyirnuMU1g8qz/onyAhIOi6QfqYrDVxl+RqRG7odg8uACDYfq16vzXBS86/Jw7iJMzJdpDpzggIYdbkU/0w7czadirXtKS8E0KK+inKBbXfHvC0oN0rR/fJz378GUtetyujN4WwBmbulp1Ktu0+qr1TNcCugdBu3IqVg7UVQfFJJeFfTsI9DfvrUvF12hB2USxVL29hbFs5dT1iqeQYRbm3bv011TaeRbce7LeDE5XlHnUJ0rXUaMWJ58L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:01:06.6211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5562e2-b156-4132-30cc-08df4a336297
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000068.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

From: Zhi Wang <zhiw@nvidia.com>

The GSP boot paths pass the device, chipset, BAR and vGPU state to the
VRAM layout and GSP_INIT helpers as separate arguments. These values
are already available in GspBootContext, and some are forwarded again
to the WPR2 heap and VF topology helpers.

Pass the boot context through these helpers so each can read the fields
it needs. This simplifies the helper signatures and their call sites.

No functional change is intended.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs               | 26 +++++++++-----------
 drivers/gpu/nova-core/gsp/boot.rs         |  2 +-
 drivers/gpu/nova-core/gsp/commands/gmc.rs | 17 ++++---------
 drivers/gpu/nova-core/gsp/fw/commands.rs  | 29 ++++++++++-------------
 drivers/gpu/nova-core/gsp/hal/gh100.rs    |  2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs    |  2 +-
 6 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 5ceb7760c78e..26e94d908b77 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -174,13 +174,9 @@ pub(crate) struct FbRanges {
 
 impl FbRanges {
     /// Computes concrete framebuffer ranges required on non-FSP booting architectures.
-    pub(crate) fn new(
-        chipset: Chipset,
-        bar: Bar0<'_>,
-        gsp_fw: &GspFirmware<'_>,
-        vgpu_state: VgpuState,
-    ) -> Result<Self> {
-        let hal = hal::fb_hal(chipset);
+    pub(crate) fn new(ctx: &gsp::GspBootContext<'_, '_>, gsp_fw: &GspFirmware<'_>) -> Result<Self> {
+        let bar = ctx.bar;
+        let hal = hal::fb_hal(ctx.chipset);
 
         let fb = {
             let fb_size = hal.vidmem_size(bar);
@@ -242,7 +238,7 @@ pub(crate) fn new(
             FbRange(fw_image_addr..fw_image_addr + fw_image_size)
         };
 
-        let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb.end)?;
+        let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(ctx, fb.end)?;
 
         let wpr2_heap = {
             const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
@@ -298,11 +294,11 @@ pub(crate) fn wpr2_range(bar: Bar0<'_>) -> Option<Range<u64>> {
 }
 
 /// Computes the number of VF partitions and the WPR2 heap size from the vGPU state.
-fn wpr2_heap_params(chipset: Chipset, vgpu_state: VgpuState, fb_size: u64) -> Result<(u8, u64)> {
-    Ok(match vgpu_state {
+fn wpr2_heap_params(ctx: &gsp::GspBootContext<'_, '_>, fb_size: u64) -> Result<(u8, u64)> {
+    Ok(match ctx.vgpu.state() {
         VgpuState::Disabled => (
             0,
-            gsp::LibosParams::from_chipset(chipset).wpr_heap_size(chipset, fb_size)?,
+            gsp::LibosParams::from_chipset(ctx.chipset).wpr_heap_size(ctx.chipset, fb_size)?,
         ),
         VgpuState::Enabled { total_vfs } => (
             u8::try_from(total_vfs.get()).map_err(|_| EINVAL)?,
@@ -328,10 +324,10 @@ pub(crate) struct FbSizes {
 
 impl FbSizes {
     /// Computes the framebuffer region sizes for GSP-FMC boot.
-    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, vgpu_state: VgpuState) -> Result<Self> {
-        let hal = hal::fb_hal(chipset);
-        let fb_size = hal.vidmem_size(bar);
-        let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb_size)?;
+    pub(crate) fn new(ctx: &gsp::GspBootContext<'_, '_>) -> Result<Self> {
+        let hal = hal::fb_hal(ctx.chipset);
+        let fb_size = hal.vidmem_size(ctx.bar);
+        let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(ctx, fb_size)?;
 
         Ok(Self {
             frts_size: hal.frts_size(),
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 1924f759171b..43a2bbb9de98 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -97,7 +97,7 @@ pub(crate) fn boot(
         let bootloader_app_version = gsp_fw.bootloader.app_version;
         let static_info = self
             .cmdq
-            .send_gmc_command(GspInit::new(pdev, chipset, ctx.vgpu.state())?, |event| {
+            .send_gmc_command(GspInit::new(ctx)?, |event| {
                 load_exec::handle_event(
                     ctx,
                     generic_bootloader.as_ref(),
diff --git a/drivers/gpu/nova-core/gsp/commands/gmc.rs b/drivers/gpu/nova-core/gsp/commands/gmc.rs
index a6cc5759c2a2..27bd67fbe93e 100644
--- a/drivers/gpu/nova-core/gsp/commands/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/gmc.rs
@@ -6,15 +6,12 @@
 use core::convert::Infallible;
 
 use kernel::{
-    device,
-    pci,
     prelude::*,
     time::Delta,
     transmute::AsBytes, //
 };
 
 use crate::{
-    gpu::Chipset,
     gsp::{
         cmdq::{
             gmc::{
@@ -39,9 +36,9 @@
             Schema,
             UnknownKeyPolicy, //
         },
+        GspBootContext, //
     },
-    sbuffer::SBufferIter,
-    vgpu::VgpuState, //
+    sbuffer::SBufferIter, //
 };
 
 /// The `GSP_INIT` command, which carries the system information and registry keys to GSP-RM.
@@ -53,18 +50,14 @@ pub(crate) struct GspInit {
 }
 
 impl GspInit {
-    /// Builds the request for `pdev`.
+    /// Builds the request using the device, chipset and vGPU state from `ctx`.
     ///
     /// # Errors
     ///
     /// - `ENOMEM` if the request or the encoder buffer cannot be allocated.
-    pub(crate) fn new(
-        pdev: &pci::Device<device::Bound>,
-        chipset: Chipset,
-        vgpu_state: VgpuState,
-    ) -> Result<Self> {
+    pub(crate) fn new(ctx: &GspBootContext<'_, '_>) -> Result<Self> {
         let mut encoder = Encoder::new();
-        GspInitRequest::new(pdev, chipset, vgpu_state)?.encode(&mut encoder)?;
+        GspInitRequest::new(ctx)?.encode(&mut encoder)?;
 
         Ok(Self {
             payload: encoder.finish(),
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 4cc4b086c1d7..9ecab9418be4 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -16,7 +16,6 @@
 };
 
 use crate::{
-    gpu::Chipset,
     gsp::{
         commands::GspStaticInfo,
         nvkv::{
@@ -29,6 +28,7 @@
             Required,
             TruncatingArray, //
         },
+        GspBootContext, //
     },
     vgpu::VgpuState, //
 };
@@ -245,16 +245,14 @@ fn new(dev: &pci::Device<device::Bound>) -> Self {
 ];
 
 impl GspInitRequest {
-    fn build_vf_info(
-        dev: &pci::Device<device::Bound>,
-        vgpu_state: VgpuState,
-    ) -> Result<Option<VfInfo>> {
-        let total_vfs = match vgpu_state {
+    fn build_vf_info(ctx: &GspBootContext<'_, '_>) -> Result<Option<VfInfo>> {
+        let total_vfs = match ctx.vgpu.state() {
             VgpuState::Disabled => return Ok(None),
             VgpuState::Enabled { total_vfs } => total_vfs,
         };
 
-        let sriov = dev
+        let sriov = ctx
+            .pdev
             .config_space_extended()?
             .find_ext_capability::<pci::ExtSriovRegs>()?
             .ok_or(ENODEV)?;
@@ -277,19 +275,18 @@ fn build_vf_info(
         }))
     }
 
-    /// Creates the request for `dev`.
+    /// Creates the request using the device, chipset and vGPU state from `ctx`.
     ///
-    /// The registry keys are [`REGISTRY_ENTRIES`], plus `RMSetSriovMode` when `vgpu_state` reports
-    /// that vGPU is enabled.
+    /// The registry keys are [`REGISTRY_ENTRIES`], plus `RMSetSriovMode` when the boot context
+    /// reports that vGPU is enabled.
     ///
     /// # Errors
     ///
     /// - `ENOMEM` if the registry list cannot be allocated.
-    pub(crate) fn new(
-        dev: &pci::Device<device::Bound>,
-        chipset: Chipset,
-        vgpu_state: VgpuState,
-    ) -> Result<Self> {
+    pub(crate) fn new(ctx: &GspBootContext<'_, '_>) -> Result<Self> {
+        let dev = ctx.pdev;
+        let chipset = ctx.chipset;
+        let vgpu_state = ctx.vgpu.state();
         let mut regkeys = KVVec::new();
         for &(name, value) in REGISTRY_ENTRIES {
             regkeys.push(RegKey::new(name, value), GFP_KERNEL)?;
@@ -312,7 +309,7 @@ pub(crate) fn new(
             host_arch: HostArch::host().into(),
             bus_device_func: u64::from(DomainBusDevice::new(dev)).into(),
             regkeys,
-            vf_info: Self::build_vf_info(dev, vgpu_state)?,
+            vf_info: Self::build_vf_info(ctx)?,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 91201b51030e..f91cdd061706 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -151,7 +151,7 @@ fn boot<'gpu>(
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
 
-        let fb_sizes = FbSizes::new(chipset, ctx.bar, ctx.vgpu.state())?;
+        let fb_sizes = FbSizes::new(ctx)?;
         dev_dbg!(dev, "{:#x?}\n", fb_sizes);
 
         let wpr_meta =
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 244c7f3ae89e..d866bd6037a2 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -258,7 +258,7 @@ fn boot<'gpu>(
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
-        let fb_ranges = FbRanges::new(chipset, bar, gsp_fw, ctx.vgpu.state())?;
+        let fb_ranges = FbRanges::new(ctx, gsp_fw)?;
         dev_dbg!(dev, "{:#x?}\n", fb_ranges);
 
         // Declared before the unload guard so that if Booter fails while running, SEC2 is reset
-- 
2.53.0

