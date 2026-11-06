Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943800;
	b=pXimFw+jay6nqAW4km9url6BWsCZP3CJfEBGaSV5+HfC+HOR4KF7JfSeapYjssC6IMOu
	 yb69kVAIo6iEdtndLO3cttvEuhh7kWEj7d0RBTvISGpNtDEPFpItUQsHl5yo7afIQQtcS
	 xeWd5WGMwsESLoUcRffe+fPJ4tmH28kGpxzZuUQgI3LiM7YqDBG6MRNHtMaPD1V8ts5fT
	 Pyg77DwiBH0yR6vJo2AJsXKPCopEwl8gWeWtu3N+zjT2Wv0YVie1lSsMQg/KR4VRlw+0E
	 j6nzp8I7qDHnV5J6vvTRbBtgLJNFQjzTPvlNwTXhUFp5gHAVtQh5n5OgeGT3ENoKIiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943800;
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
	bh=SH80IliGuHfkwNODgWnsqyt0O2pGYkWmPKmvR7HI2vg=;
	b=h8hGo2SqR/TzvmAapeaLRR3EDtrXxYEUx+Jh+2R3o/T+STWiY0dhSZOEjOp43GXn15tQ
	 YDEaYfL8QWYA85rppGlUrOZMtVBB0n/RSs0cGwfRGOac+1sDAz/tDjyhklCYfmVv71PnL
	 A0ypOz0F5UL/pPA1O2+dfh0RMH3OhbfQJanh2G/G4TaRv+KkT0xoDg6hCOqtfHtZ6dBQ5
	 2P1ioGYt71OmuRWMb2R1jeCGiG9R5mYCzNNNRPbPxo7Py1T6AcKc8yViF6umfLIW935OP
	 ufmVH/C45fq9EN1CmWEm7Rt0HanTnotoq18AH3+cb/r/ySUqyGW1YDjWB51FjH25LcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KFAixgYq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.38
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAD606A328;
	Fri,  6 Nov 2026 05:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BCAD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KFAixgYq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7/2WLl+Iz4tHoSTUbooTBFY/PRiiqJUTghZ/k/j6bRCyJsR+HZBp2qAuFT6/APtgTkPWcCr+XacS1QctvOzvUYz5Yd4afhzopT2cFmQcZzQ8AWRWqjIjW1PH2dhbUa7VLijMFynGG5sC2nCx9GIWfwwFro20Oxmoqwvf4uXhnd7InA5aKjAzicCew5urHMDB/aaYKpcqx1oLRijI6TuRErt0Xhl8ftlX/c2jV6NbfiuhN4MsST0mAkmhTac9Tbp7jxANCIOnXs4fIXY+nleyNHDazLz/ZXnbYaFqQILwQ2jUYB8hUdTM6OH3xuRDxN/kqsZmlm50FnAiNc0KuAcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH80IliGuHfkwNODgWnsqyt0O2pGYkWmPKmvR7HI2vg=;
 b=qLgxsU9hu2Qml3yUXPq8sqejOvTY5zjpuNQcIZdjogJoDsfVz1JEtF1+yT2Mxl9prPKe//onWzOOuL6GE3UbNXngW9dkG0ru0/jp6X6nowy+jqszC+R5GTWcMrodkvr2HPxlG90WqwH3dgP0E7NgTZ5RJdLd2xdVOE315YgBOjmXRt9piXfETXcR5eK8thYDTKQ9uz2U49Hgwp/HKWXcRTlQsLVoZ8GqZCEs90RtfTnRaU5zAoWiT0Pjhm/Nq4Anb8xtmsy0IQA0fofYerUa3P5zhLxGtddJGk78p8WOXTU0PVB/UoTBFxm0hi3cT5QDoiYBGU69v41dnNJXM1ORQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH80IliGuHfkwNODgWnsqyt0O2pGYkWmPKmvR7HI2vg=;
 b=KFAixgYqVD/+Mph7jDu4/A3Y2viCqH/ASF1nQUUIZN/3JBnK9jZWBR/U4v00g2kyv9QwJNxGcYvCgVWsKqRXJcmiFPWWWuEcTVPq493g0bKjA95D1tssR8rSR6IXXBR3WZFH4bmXoj6EoYqrOrG4Elh6rJtpJkqTmT7i1qtZfqpY8GZx7CrxMTyJhvuo+v4mT5vyYqLzVY2EnEiCYiwe12bPCTNqGZL9Fgb1VgNE1UNqaJDnyLL9LY/T0yWW55Q4HfCy/bWVUDagCMn+Mh0g+OgaInM+/ywgNQe/hoIBaG9cXwJX8DPu84L1fGtMZGgkoK7KQvO37TX5zJwwHty9sA==
Received: from DS1PR03CA0007.namprd03.prod.outlook.com (2603:10b6:8:450::19)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:42:20 +0000
Received: from DM3PEPF000265C5.namprd03.prod.outlook.com
 (2603:10b6:8:450:cafe::2e) by DS1PR03CA0007.outlook.office365.com
 (2603:10b6:8:450::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:42:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM3PEPF000265C5.mail.protection.outlook.com (10.167.23.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:42:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:42:05 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:41:52 -0800
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
Subject: [PATCH v4 04/32] gpu: nova-core: vgpu: detect boot state independently
Date: Fri, 6 Nov 2026 11:09:37 +0530
Message-ID: <ec70c38e3160a75ec2727a2261b4a1d21de33c4d.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C5:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: df524648-191f-46f7-0cb8-08df3bc8b968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|36860700016|82310400026|261026140227099003|261021123027099003|261026121527099003|56012099006|261021121427099003|11063799006|261028144727099003|261009223027099003|261022105027099003|10067099003|22082099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VS6B6XP1uQkgal/xa9gPAbSUCCI9+CKc7gufDbOlORfAaVa/zdo5RozBugY9oRc1le2HSxGXI8GTyshqnsiBcBqd6ld0NlSvBQMbbrYBVGT8T1i3u9Cj3KTHyCjNt3QtTn0wcSyFXhBjGalM2bvAJ/pYOw3R5RzkD7s9njejzoMFrVXJjlVc7UIZvHGLB3RyiHAWFuIx+zL+S4qCJj1MFfYvvbn8QtYcwwIT18kN7FYlOm7xqpgACA8jJmjjEEgC9h5L3/ch+swbZgtAAWza8w45BWDw2PVPSxSH925FRk/HQfds/SLIIkDVJwqoMT2chCIaBaQL0/Cknm3eRHSNxdC7JbGie+wvxCe3X/oWK4Apu5M5oGQCiCN4gllxCDSsetwNyclER08GxpN2yB6STeDSjnAx7yydJPB/GmYJ/UKdxvp9l52AYTkS4yVh2yNHRQW9XMwU+g695EEomaeWqMH0s4z3ojYo6lTZTDzpzt7tVS7HQ4YlNqlViS59CiKqme91UbmGIEi6T1HBagnum+0Amf1Re22Ad4ji3ZKq8+l/lgM2yFnsOVaMgpDoeIgxFo4IfqstlgtqOenp4Py7KmKF7q2tY9Po+yW8/eEklGt+FmYLVB1oUUjQE7TLz1f2f8I3vsLn1X/V/oMh+v3QkUh3rvN7iiYUZQFUn5GEj/KiQo31klRHdg+mKj1jbtxaP4fll4QvCIxHd8nTT76UWQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(36860700016)(82310400026)(261026140227099003)(261021123027099003)(261026121527099003)(56012099006)(261021121427099003)(11063799006)(261028144727099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(261102123227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R2Ptc0chNvi/bmrNj51D5FDseYh5sMQmDDw7MWR1AJHKizcFIHd5WJLxCCQaKGDDrBC4FyVBO0RPUyGWTKULZE7Ikz13zst0trxj/YdA5st+KF/XvAZx1RLGDc9Cb6iBzgTatgjKJOGFM+WqoRM1n/k4CKRujpAHqlGmm+uUdb/O9SvhSaG9FqvAO/KjeKeS0WOEkyWhyZkCnyfXabDd4j22jk2jgi7kzBHbiRJJGgnZtkI0vkw14nnBLig7SeK868CTW/XkE6JSxNYUx5LyGXX7tsdPGrycbB1aSc0lw+akA0agdyq6N4XDNmg0pDcqvpts6Ecc4pZKntHHO4MBpSOl1C4fs4XmnuB//2bg9ra/r70o6O88JYAf3CxV+TLuQsc8y1sTdCb5BW9YCvbM2WAfjBCZ59qkStGDzrwqci9uQpQID74Pr0rzhsTsWbIg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:42:19.9059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df524648-191f-46f7-0cb8-08df3bc8b968
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

From: Zhi Wang <zhiw@nvidia.com>

The vGPU manager currently contains only the detected boot mode. Its
construction couples mode detection to an object with no runtime
management responsibilities.

Firmware setup needs the mode before allocating GSP resources, even
when vGPU is disabled. Keeping that value with GspResources also makes
it available throughout the firmware lifecycle without a manager.

Move detection to VgpuState and store its result in GspResources.
Borrow it directly when constructing the boot and unload contexts, and
remove the state-only manager wrapper. Preserve the FSP query order,
existing diagnostics and disabled fallback.

No functional change is intended.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs  | 11 +++++------
 drivers/gpu/nova-core/vgpu.rs | 25 ++++++++-----------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index d29e83f50137..fd0442f9a40b 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -52,7 +52,7 @@
         GpuMm,
         VramAddress, //
     },
-    vgpu::VgpuManager, //
+    vgpu::VgpuState, //
 };
 
 #[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
@@ -337,8 +337,7 @@ struct GspResources<'gpu> {
     // TODO: use different resource types for each boot method, and make the relevant Gsp methods
     // generic against them.
     fsp: Option<Fsp<'gpu>>,
-    /// vGPU state detected before GSP boot.
-    vgpu: VgpuManager,
+    vgpu_state: VgpuState,
     /// GSP runtime data.
     #[pin]
     gsp: Gsp<'gpu>,
@@ -447,7 +446,7 @@ fn drop(self: Pin<&mut Self>) {
                     gsp_falcon: &*this.gsp_falcon,
                     sec2_falcon: &*this.sec2_falcon,
                     fsp: this.fsp.as_mut(),
-                    vgpu_state: this.vgpu.state(),
+                    vgpu_state: this.vgpu_state,
                 },
                 bundle,
             )
@@ -508,7 +507,7 @@ pub(crate) fn new<'a>(
 
                 fsp: Fsp::try_new(dev, bar, spec.chipset)?,
 
-                vgpu: VgpuManager::new(pdev, spec.chipset, fsp.as_mut()),
+                vgpu_state: VgpuState::detect(pdev, spec.chipset, fsp.as_mut()),
 
                 gsp <- Gsp::new(pdev, *spec, bar),
 
@@ -522,7 +521,7 @@ pub(crate) fn new<'a>(
                     gsp_falcon,
                     sec2_falcon,
                     fsp: fsp.as_mut(),
-                    vgpu_state: vgpu.state(),
+                    vgpu_state,
                 })?,
             }),
 
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 905b3a7331fd..b405ba49c490 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -30,19 +30,16 @@ pub(crate) enum VgpuState {
     },
 }
 
-/// vGPU state manager.
-pub(crate) struct VgpuManager {
-    state: VgpuState,
-}
-
-impl VgpuManager {
-    /// Creates a vGPU manager by querying SR-IOV and the FSP PRC vGPU knob.
-    pub(crate) fn new(
+impl VgpuState {
+    /// Detects the boot mode, falling back to disabled if querying the device fails.
+    ///
+    /// Call after creating the FSP and before allocating GSP firmware resources.
+    pub(crate) fn detect(
         pdev: &pci::Device<device::Core<'_>>,
         chipset: Chipset,
         fsp: Option<&mut Fsp<'_>>,
     ) -> Self {
-        let state = Self::detect_state(pdev, chipset, fsp).unwrap_or_else(|e| {
+        let state = Self::query_state(pdev, chipset, fsp).unwrap_or_else(|e| {
             dev_warn!(
                 pdev,
                 "vGPU state detection failed: {:?}; disabling vGPU\n",
@@ -51,12 +48,11 @@ pub(crate) fn new(
             VgpuState::Disabled
         });
         dev_dbg!(pdev, "vGPU state: {:?}\n", state);
-
-        Self { state }
+        state
     }
 
     /// Detects the vGPU state from the chipset, SR-IOV capability and FSP PRC knob.
-    fn detect_state(
+    fn query_state(
         pdev: &pci::Device<device::Core<'_>>,
         chipset: Chipset,
         fsp: Option<&mut Fsp<'_>>,
@@ -83,9 +79,4 @@ fn detect_state(
             VgpuMode::Disabled => Ok(VgpuState::Disabled),
         }
     }
-
-    /// Returns the detected vGPU state for this boot.
-    pub(crate) fn state(&self) -> &VgpuState {
-        &self.state
-    }
 }
-- 
2.53.0

