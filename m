Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529145;
	b=iuB3vwuznSC+1JJAuuqsa9Wa549CpfGsG0yj2T1z4O57h1RqImspZpnUPmmxnyRcVHlr
	 qoxf9WuE7y5lTwuQ4cHM9OYVI593wV4+tljf8PdKhOF5Do8j/Vo2cYwVpSvDB7JuLGp1f
	 eg81P/ufrJmeNLvy1ctv7zgBIG21Mp2ArpyiOSP92rm1TCSTz4tWmaFfKydwD72762zSD
	 VFIKhrJ33I+iaLAhIPdFftsZkDU2muaPkPBTqBi8wz+GM7i8oAKUolitkGd65FN66SeHR
	 8XocR9UibYRRySuHjNTNhXE2ORS/zu4tAMDVxy86Ivwkd+mwE2ExdKtRH4GauMIPA7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529145;
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
	bh=02+8TjMeBsrSZC+RJ5GI47PXsrzK9mynlBdWaTKd5Lc=;
	b=Yoow1sk1cXbzA8fJwlHNzFL897fqH9U1kbiJj5OPIR9eKE9UYji4KqMP7hX1aThw7U5r
	 YhiOCMM/MWpHA/x/xw+Dpq4oNO/kdvKgCd+88sVQu9pYs07JOuBtg+ECoUG1YzQi2oFlF
	 tp4IVVrI+2BqacEmSzBP6ITgPnbsZ51lI62jCSJag5NFlOytPL8DxU4SQQLC72CR+J+7t
	 jyXB3itqsmRkTBPsHBAwc83GES1d6elWTohrcX19iRZo2BYCdmUs7BRukXUj3YeB5jEqJ
	 HOHkq88ABocDTfgLdFT3kqFxlDdFFTELG+EgRtx8wcVf6ERJzDQ19VocQy5Mpq203+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VkIWLOU9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.26
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108B606A69B;
	Tue, 24 Nov 2026 14:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7108B606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VkIWLOU9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkmvyj6pYDBbssfrTj2UrSWVEalPt0zbdTZ1KKqrqjFzHf808u0OVErN2EaWNODx8bzuRPiSk83b/7KmymLLP0I75IpWmH3e78e4fACH3HtKLoGZwUCHPZnzt2fk/8kQovVQnNP6Fa1m2eQmE8MA22pncJFmw6Y76V5jVIjzED7ToP9klnXB6f8eTXh2lOmpZnUpJqEGsv1vugHdrLETrKPrK6coyU7LgUjCdQoMRh7sfLQW8nTBCMNHX3y2aAP8M4Q9aoRHEZf7PUtiqHkCf3ne0QNUsaJSP8EB0f96LIZL5Y1j0QAOvL2A0VIDBq1HjV72K5dVqGNckQRpGovfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02+8TjMeBsrSZC+RJ5GI47PXsrzK9mynlBdWaTKd5Lc=;
 b=bCx5rsr7YQNFVZfl5FiZbxSaFwOYhr2yIKDWD37U6uXFdBS4ya/HD6cjG1E+dWysxjLNjKwergHbDSYsxhVnW9SZY43F1WD13fCgYI6TfVgTIXOET/9c4QxrLAm2e28FnYDBPG4g3ZhOzHIZAip6JCqR5+sjz3QV8/X0PXvd/Edn0wsKNAo2oAAE51J1GglvbQmAdTvH1c+Z11t9xsgIo9mBEESVVkhpkzYiAeJqgu/bWs0tk5v3boZTQ5/lyEb3KcEQ/B69W0F9wftJgFuyrMRcAuWOhO6U7Qw23rVmx58NCVm3MSAiXREdd8wy4QaRyroEu1ml2X6xKaYk7E5Qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02+8TjMeBsrSZC+RJ5GI47PXsrzK9mynlBdWaTKd5Lc=;
 b=VkIWLOU9JonawnhFY4g45xPbJZ2ZKqvTikRw/jVQG1MiHrGPPiz+az1a+u+zGs+JcrNPkEnAF1M0bvjeB3bM4LvehpFMdrngkfFAE/YmtPSzpXfOIO/on30sn6iVj/RNp4SmgwtxqImiKVuM+dDgU8eJvEkjcT/7ITSiMdNuaPzx7glu1Vt1Dc9D5UBaZPpFTrmIzPO1RM+nSrx+EznQQ8ar7AV2JuMjTiYp52tkrRfud+SapCDIQbaLDJzylbJ37UPQ0ql0qGnuG7+RJZoDaZd2FnGlu0nw5F6yb0WX6VZ+2nt6yqCJ7WZBBSoIrPZfyfabdHdveZRQEoXWO2Lo2g==
Received: from BN3PR12CA0007.namprd12.prod.outlook.com (2603:10b6:408:2af::32)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:05:36 +0000
Received: from LV8PEPF00000065.namprd03.prod.outlook.com
 (2603:10b6:408:2af:cafe::57) by BN3PR12CA0007.outlook.office365.com
 (2603:10b6:408:2af::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:05:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF00000065.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:05:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:05:10 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:04:57 -0800
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
Subject: [PATCH v5 23/35] gpu: nova-core: vgpu: add instance create/destroy
Date: Tue, 24 Nov 2026 19:29:19 +0530
Message-ID: <20261124135937.18583-24-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000065:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: c3698f25-7d36-44f7-6f4b-08df4a340300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|23010399003|82310400026|10067099003|11063799006|261022113327099003|56012099006|261026121527099003|261022075727099003|261021123027099003|261026140227099003|261022105027099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	heMaVN1E5JW1VEu7c/+irDOMl3AJ22u1A7EaXIeuMD0p03SV51lZoyYfG4z+Szw/lGbICY5Fdjz2lsH0mPUu/3K+48MpZ0iFh6CEosH6gfWc3xi5q/ytZbfHDJXEIbKNkqOa2DvSaRqdkcd9/gSKPk8HyMuIvhNXfh/qtuClF1YiUER6TDva0f7I6D9UW+cV7Fp7Qc7/zep1ZuR2DhoSgTmdvc1C+4yzDWbK0l4f0dJMu7EAxMx8f32wft9P0ZVH7E+av8fgaEu7QJZUuXIJJ2N1teT0454RsfwcugmBV0b3veYoATR0zWM5PbL3zUuQn4fdjj1SRzoCHKzIRiwcahlGGBOFZCI5P8bFQ9FnxoqA8QYLudbgRgOz0uIng4+wFv8eqsJjLoGv9+ne4oqHDT+wP5Bsv4fY1FJmfGazG5GRqrFn8ob7GmNeGDAdLdNQXfhQZZ34UEeYwdCF04LuS63+Gypx98JVenyWs2Ff2ziZOmFi7grQ8ccAHHY01HkH0xp0KQqWWn2ORBC279KdpoVzlOarjt0/jjk4BjRads1tehYlSr/YhQcmuaP0eu6DQ4jbjkYMuizhTlqD6b3xczXw8QJ9ahEj5uQ2NJ6LfWnlrQ6m+LzSCCNTrCgtiQIklvqqoNmZTA49RaJJEZM/JbCxTDZdaYR7fied12nhJ7b5uP4epdNkD2nLJOx3NF+4OBBggHLPJaCVK1g2kF01ag==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(23010399003)(82310400026)(10067099003)(11063799006)(261022113327099003)(56012099006)(261026121527099003)(261022075727099003)(261021123027099003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Je/8tiUEzXMiaj5ZjDm0op3yfNvgmXSQeNmPOSiHnMvm2QV3Y5Es5Yh+Yor53qkTvEaNWkcdFOQnXiWBc2zozhOM1ebD+207bjYGb0N6BTzvR2WLOITK9No97bthaBjUwETan1F5796gFitcJMaecXSR+/AOHJP1Jkj+xk57Ia2DJRgph0KkP7/0G8feaL1NGC8aPlrtCNPXduLWWEbkchZcmpRqUQWfVqwTxi1rqvENIC0luhQwBlupl2Rib/lAurbYHyIacCZGkrb2g6hZldvdCpJKdoBu1CEphe112jmod0lOCnBPoOfLpUhu8VrV5/kSi8Qrzdi0bkHX6skJmAL+Hw/szwKUCXS+1t3ThUJs3mWUIq3Jg+g2rKjX5o7Ys+LrVD6JWHQmciP46IKAVn02+7u7Kaq8Qj+NherJuMa8Igj4zMMd63lgEapIYi5f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:05:35.7644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3698f25-7d36-44f7-6f4b-08df4a340300
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000065.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581

From: Zhi Wang <zhiw@nvidia.com>

A vGPU instance owns the host resources reserved for a VF. Its assigned
type determines the channel range and VRAM and management-heap
reservation.

Add a manager-owned instance registry, reject duplicate GFID or DBDF
entries and enforce the profile's instance limit. Reserve registry
capacity before acquiring resources, then move the channel and VRAM
reservations into the instance. Removing an instance or dropping the
registry releases these host reservations through their owners.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs           |  55 +++---
 drivers/gpu/nova-core/mm.rs            |   1 -
 drivers/gpu/nova-core/vgpu.rs          |  56 ++++--
 drivers/gpu/nova-core/vgpu/instance.rs | 245 +++++++++++++++++++++++++
 drivers/gpu/nova-core/vgpu/vram.rs     |   1 -
 5 files changed, 321 insertions(+), 37 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/instance.rs

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 03d0411008c9..962a6a3f4d29 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -47,6 +47,7 @@
         bar_user::BarUser,
         pagetable::MmuVersion,
         GpuMm,
+        SharedGpuMm,
         VramAddress, //
     },
     num,
@@ -60,14 +61,16 @@
     },
 };
 
-#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
 mod channel;
 mod hal;
 mod regs;
 
 use self::channel::TOTAL_CHANNELS;
 
-pub(crate) use self::channel::ChannelIdPool;
+pub(crate) use self::channel::{
+    ChannelIdPool,
+    ChannelIdReservation, //
+};
 
 macro_rules! define_chipset {
     ({ $($variant:ident),* $(,)* }) =>
@@ -398,7 +401,9 @@ unsafe fn new(
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
-    vgpu: Option<VgpuManager<'chid_pool>>,
+    /// Drops before the MM and BAR1 mappings needed for instance teardown.
+    #[uses('bar_user, 'chid_pool)]
+    vgpu: Option<Pin<KBox<VgpuManager<'mm>>>>,
     /// GSP event interrupt registration, and the enable of its subtree.
     ///
     /// Must be kept declared *before* `gsp_resources`, so that the handler is unregistered, and
@@ -411,7 +416,8 @@ pub(crate) struct Gpu<'gpu> {
     ///
     /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
     /// the GSP is still operational.
-    mm: GpuMm<'gpu>,
+    #[pin]
+    mm: SharedGpuMm<'gpu>,
     /// BAR1 user interface for CPU access to GPU virtual memory.
     #[pin]
     bar_user: BarUser<'gpu>,
@@ -576,7 +582,7 @@ pub(crate) fn new<'a>(
             },
 
             // Create GPU memory manager owning memory management resources.
-            mm: {
+            mm <- {
                 let info = gsp_resources.static_info();
                 let usable_vram = info.usable_fb_regions.first().ok_or(ENODEV)?;
                 let buddy_params = GpuBuddyParams {
@@ -585,12 +591,12 @@ pub(crate) fn new<'a>(
                     chunk_size: Alignment::SZ_4K,
                 };
 
-                GpuMm::new(
+                SharedGpuMm::new(GpuMm::new(
                     bar,
                     gsp_resources.spec.chipset,
                     buddy_params,
                     VramAddress::from_raw(info.total_fb_end),
-                )?
+                )?)
             },
 
             // Create BAR1 user interface for CPU access to GPU virtual memory.
@@ -611,15 +617,18 @@ pub(crate) fn new<'a>(
                 let info = &gsp_resources.boot_result.static_info;
                 match gsp_resources.vgpu_state {
                     VgpuState::Disabled => None,
-                    VgpuState::Enabled { .. } => Some(VgpuManager::new(
-                        chid_pool.get_ref(),
-                        &info.fifo_engine_list(),
-                        info.vmmu_segment_size,
-                        TOTAL_CHANNELS,
-                    )),
+                    VgpuState::Enabled { .. } => Some(KBox::pin_init(
+                        VgpuManager::new(
+                            mm.get_ref(),
+                            chid_pool.get_ref(),
+                            &info.fifo_engine_list(),
+                            info.vmmu_segment_size,
+                            TOTAL_CHANNELS,
+                        ),
+                        GFP_KERNEL,
+                    )?),
                 }
             },
-
         })
     }
 
@@ -652,14 +661,16 @@ pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bou
         let dev = pdev.as_ref();
         let info = this.gsp_resources.static_info();
 
-        if let Err(err) = crate::mm::selftest::run(
-            dev,
-            this.mm,
-            &info.usable_fb_regions,
-            this.bar_user.as_ref().get_ref(),
-            info.bar1_pde_base,
-            this.spec.chipset,
-        ) {
+        if let Err(err) = this.mm.with_locked(|mm| {
+            crate::mm::selftest::run(
+                dev,
+                mm,
+                &info.usable_fb_regions,
+                this.bar_user.get_ref(),
+                info.bar1_pde_base,
+                this.spec.chipset,
+            )
+        }) {
             dev_err!(dev, "self-tests failed: {:?}\n", err);
         }
     }
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index d4cba022ccad..f1f86931928c 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -133,7 +133,6 @@ pub(crate) struct SharedGpuMm<'gpu>
 
 impl<'gpu> SharedGpuMm<'gpu> {
     /// Creates a pin-initializer sharing `mm`.
-    #[expect(dead_code)]
     pub(crate) fn new(mm: GpuMm<'gpu>) -> impl PinInit<Self> + 'gpu {
         pin_init!(Self {
             inner <- new_mutex!(mm, "nova-core::gpu-mm"),
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 0934932e051d..65362ca31ba3 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -6,8 +6,10 @@
 use kernel::{
     bitfield,
     device,
+    new_mutex,
     pci,
-    prelude::*, //
+    prelude::*,
+    sync::Mutex, //
 };
 
 use crate::{
@@ -20,11 +22,15 @@
         Chipset, //
     },
     gsp::commands::FifoEngineList, //
+    mm::{
+        SharedGpuMm, //
+    }, //
 };
 
 mod commands;
 mod fw;
 mod hal;
+mod instance;
 mod vram;
 
 bitfield! {
@@ -99,32 +105,56 @@ fn query_state(
     }
 }
 
+use self::instance::VgpuInstances;
+
 /// Runtime resources for an enabled vGPU boot.
-pub(crate) struct VgpuManager<'gpu> {
-    #[expect(dead_code)]
+#[pin_data]
+pub(crate) struct VgpuManager<'gpu>
+where
+    // Hide the invariant resource lifetime of the instance registry so `VgpuManager` remains
+    // covariant.
+    exists<'res>: 'gpu,
+{
+    #[pin]
+    #[uses('res: invariant)]
+    inner: VgpuManagerInner<'res>,
+}
+
+/// Inner state of [`VgpuManager`].
+///
+/// The instances kept in the registry borrow the GPU resources below, which makes this type
+/// invariant over `'gpu`.
+#[pin_data]
+struct VgpuManagerInner<'gpu> {
+    #[pin]
+    instances: Mutex<VgpuInstances<'gpu>>,
+    mm: &'gpu SharedGpuMm<'gpu>,
     chid_pool: &'gpu ChannelIdPool,
     /// VMMU segment size in bytes, or zero if GSP-RM omitted it.
-    #[expect(dead_code)]
     vmmu_segment_size: u64,
-    #[expect(dead_code)]
     total_channels: u32,
-    #[expect(dead_code)]
     fifo_engine_list: FifoEngineList,
 }
 
 impl<'gpu> VgpuManager<'gpu> {
     /// Retains runtime parameters from a completed vGPU-enabled GSP boot.
     pub(crate) fn new(
+        mm: &'gpu SharedGpuMm<'gpu>,
         chid_pool: &'gpu ChannelIdPool,
         fifo_engine_list: &FifoEngineList,
         vmmu_segment_size: u64,
         total_channels: u32,
-    ) -> Self {
-        Self {
-            chid_pool,
-            vmmu_segment_size,
-            total_channels,
-            fifo_engine_list: *fifo_engine_list,
-        }
+    ) -> impl PinInit<Self> + use<'gpu> {
+        let fifo_engine_list = *fifo_engine_list;
+        pin_init!(Self {
+            inner <- pin_init!(VgpuManagerInner {
+                instances <- new_mutex!(VgpuInstances::new(), "nova-core::vgpu-instances"),
+                mm,
+                chid_pool,
+                vmmu_segment_size,
+                total_channels,
+                fifo_engine_list,
+            }),
+        })
     }
 }
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
new file mode 100644
index 000000000000..68c93418cc26
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+use core::num::{
+    NonZero,
+    NonZeroUsize, //
+};
+
+use kernel::{
+    prelude::*,
+    ptr::Alignment,
+    sizes::SizeConstants, //
+};
+
+use crate::{
+    gpu::ChannelIdReservation,
+    mm::GpuMm, //
+    num::FromSafeCast,
+};
+
+use super::{
+    fw::commands::VgpuProperties,
+    vram::{
+        VgpuVramLayout,
+        VgpuVramSlot,
+        VgpuVramSlotPool, //
+    },
+    Dbdf,
+    VgpuManagerInner, //
+};
+
+/// Guest Function ID validated against one device's total number of VFs.
+///
+/// GFID 0 is reserved for the PF; VFs start at 1. Keeping the nonzero `u16`
+/// preserves the PCI SR-IOV range when forming a plugin doorbell handle.
+#[repr(transparent)]
+#[derive(Clone, Copy, PartialEq, Eq)]
+pub(super) struct Gfid(NonZero<u16>);
+
+impl Gfid {
+    /// Validates an external GFID for a device supporting `total_vfs` VFs.
+    #[expect(dead_code)]
+    pub(super) fn new(gfid: u32, total_vfs: NonZero<u16>) -> Result<Self> {
+        let gfid = u16::try_from(gfid).map_err(|_| EINVAL)?;
+        let gfid = NonZero::new(gfid).ok_or(EINVAL)?;
+
+        if gfid > total_vfs {
+            Err(EINVAL)
+        } else {
+            Ok(Self(gfid))
+        }
+    }
+
+    #[expect(dead_code)]
+    pub(super) const fn get(self) -> u16 {
+        self.0.get()
+    }
+}
+
+/// Resource requirements for one vGPU type.
+struct VgpuType {
+    vgpu_type_id: u32,
+    max_instance: u32,
+    fb_length: u64,
+    gsp_heap_size: u64,
+}
+
+impl From<&VgpuProperties> for VgpuType {
+    fn from(properties: &VgpuProperties) -> Self {
+        Self {
+            vgpu_type_id: properties.type_id,
+            max_instance: properties.max_instance,
+            fb_length: properties.fb_length,
+            gsp_heap_size: properties.gsp_heap_size,
+        }
+    }
+}
+
+/// A vGPU instance and the resources reserved for it.
+#[expect(dead_code)]
+struct VgpuInstance<'gpu> {
+    gfid: Gfid,
+    dbdf: Dbdf,
+    vgpu_type: VgpuType,
+    vm_pid: u32,
+    chids: ChannelIdReservation<'gpu>,
+    vram_slot: VgpuVramSlot,
+}
+
+/// Identity and firmware profile used to allocate an instance.
+pub(super) struct InstanceInfo {
+    gfid: Gfid,
+    dbdf: Dbdf,
+    vgpu_type: VgpuType,
+    vm_pid: u32,
+}
+
+#[expect(dead_code)]
+impl InstanceInfo {
+    pub(super) fn new(gfid: Gfid, dbdf: Dbdf, properties: &VgpuProperties, vm_pid: u32) -> Self {
+        Self {
+            gfid,
+            dbdf,
+            vgpu_type: VgpuType::from(properties),
+            vm_pid,
+        }
+    }
+}
+
+/// Registry of live vGPU instances.
+pub(super) struct VgpuInstances<'gpu> {
+    instances: KVec<VgpuInstance<'gpu>>,
+    vram_slots: Option<VgpuVramSlotPool>,
+}
+
+#[expect(dead_code)]
+impl<'gpu> VgpuInstances<'gpu> {
+    pub(super) const fn new() -> Self {
+        Self {
+            instances: KVec::new(),
+            vram_slots: None,
+        }
+    }
+
+    fn alloc_vram_slot(&mut self, mm: &GpuMm<'_>, layout: VgpuVramLayout) -> Result<VgpuVramSlot> {
+        let allocator = match self.vram_slots.as_mut() {
+            // Don't replace the allocator if the current one already matches the requested layout.
+            Some(allocator) if allocator.matches_layout(layout) => allocator,
+            // The allocator cannot be replaced if there already are instances.
+            Some(_) if !self.instances.is_empty() => return Err(EBUSY),
+            _ => {
+                // Release the previous pool's VRAM so the new one can reuse it.
+                self.vram_slots = None;
+                self.vram_slots.insert(VgpuVramSlotPool::new(mm, layout)?)
+            }
+        };
+
+        // Find the lowest slot index not used by any instance.
+        let index = (0..layout.max_slots())
+            .find(|i| !self.instances.iter().any(|inst| inst.vram_slot.index == *i))
+            .ok_or(ENOSPC)?;
+
+        allocator.slot(index)
+    }
+
+    /// Creates and returns a [`VgpuInstance`].
+    fn allocate_instance(
+        &mut self,
+        vgpu: &VgpuManagerInner<'gpu>,
+        info: InstanceInfo,
+    ) -> Result<VgpuInstance<'gpu>> {
+        let InstanceInfo {
+            gfid,
+            dbdf,
+            vgpu_type,
+            vm_pid,
+        } = info;
+
+        let instance_exists = self
+            .instances
+            .iter()
+            .any(|instance| instance.gfid == gfid || instance.dbdf == dbdf);
+        if instance_exists {
+            return Err(EEXIST);
+        }
+
+        let type_id = vgpu_type.vgpu_type_id;
+        let num_type_instances = self
+            .instances
+            .iter()
+            .filter(|instance| instance.vgpu_type.vgpu_type_id == type_id)
+            .count();
+        if num_type_instances >= usize::from_safe_cast(vgpu_type.max_instance) {
+            return Err(ENOSPC);
+        }
+
+        let channels_per_instance = vgpu
+            .total_channels
+            .checked_div(vgpu_type.max_instance)
+            .map(usize::from_safe_cast)
+            .and_then(NonZeroUsize::new)
+            .ok_or(EINVAL)?;
+        let chids = vgpu
+            .chid_pool
+            .reserve_ids(channels_per_instance, Alignment::SZ_1)?;
+
+        let vram_layout = VgpuVramLayout::new(
+            type_id,
+            vgpu_type.max_instance,
+            vgpu_type.fb_length,
+            vgpu_type.gsp_heap_size,
+            vgpu.vmmu_segment_size,
+        )?;
+
+        let vram_slot = vgpu
+            .mm
+            .with_locked(|mm| self.alloc_vram_slot(mm, vram_layout))?;
+
+        Ok(VgpuInstance {
+            gfid,
+            dbdf,
+            vgpu_type,
+            vm_pid,
+            chids,
+            vram_slot,
+        })
+    }
+
+    /// Remove an instance and release its channel and VRAM reservations.
+    fn destroy_instance(&mut self, gfid: Gfid) -> Result {
+        let instance_index = self
+            .instances
+            .iter()
+            .position(|instance| instance.gfid == gfid)
+            .ok_or(ENOENT)?;
+        let instance = self.instances.remove(instance_index).map_err(|_| EIO)?;
+        drop(instance);
+        Ok(())
+    }
+}
+
+impl VgpuManagerInner<'_> {
+    /// Allocate, register, and activate a vGPU instance.
+    ///
+    /// Keep the registry locked through creation or rollback so duplicate checks and
+    /// type limits remain stable. MM and BAR-user locks are acquired only within
+    /// individual memory operations, in that order.
+    #[expect(dead_code)]
+    fn create_instance(&self, info: InstanceInfo) -> Result {
+        let mut instances = self.instances.lock();
+
+        // Reserve capacity before acquiring resources so registration cannot allocate.
+        instances.instances.reserve(1, GFP_KERNEL)?;
+
+        let instance = instances.allocate_instance(self, info)?;
+
+        // Register live instances, and failed ones whose resources firmware may still own.
+        instances
+            .instances
+            .push_within_capacity(instance)
+            .map_err(|_| EIO)?;
+
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/nova-core/vgpu/vram.rs b/drivers/gpu/nova-core/vgpu/vram.rs
index 0c840c03f988..77446b2bdceb 100644
--- a/drivers/gpu/nova-core/vgpu/vram.rs
+++ b/drivers/gpu/nova-core/vgpu/vram.rs
@@ -93,7 +93,6 @@ pub(super) struct VgpuVramSlotPool {
     fb_region_size: u64,
 }
 
-#[expect(dead_code)]
 impl VgpuVramSlotPool {
     /// Reserve the VRAM for all possible slots of `layout`, and returns a [`VgpuVramSlotPool`] that
     /// can provide these slots.
-- 
2.53.0

