Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943976;
	b=Z4NbpCXdSiYzYsbol4jzikycapTTFwcM+TqdGgGTKRZDn4troBnjkZRdS418obBQOHJS
	 8PBboPZ86QIMRaVP8oOyeAaelzQcuOhoKI7vMeKmJAklqcMwnAsjm1PU/GQlI2+Gc2Sv0
	 x5cYTyzSqUIjT4uHJlwEZVByeRHWe8F2OaBkuln6DgdQinhoZO3/R5ZcL+8rJYudGGdJp
	 3bT4HlbVd/pUGU3NH2sNrNI/+J4H/ya+GHnM0t6sMooT/ZoquWaDj+Rw1cyLOnGTAdRH1
	 6DBSO95vJUtE8NHqECTsmJzI214OscfFH+J3SLpf9mpI4+zw8KA7kMByTFVzeOOgS3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943976;
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
	bh=wrGdQ/f++/KkmWpaFdp+hXVAHbAoj6mf0dPXleo+SSI=;
	b=FekMKALBPk76+tFrqZtGtf0mC83if/iz6nFzlFxGhAi7fKtIALDjrAaPgsJoMm5FLfZe
	 GKGJprYFHsKF8uc4Q1V3uxNWTyXixVjgoFHMw4WJabF3YEg4Tz7ogy7Au1KRjUPZRZzAn
	 DoBHYL71/l7WOIlwF3WB2+EhKEjOAQcqkx7Go8+Qq852FS4JPAyhvkHemyGM78RJdNdys
	 /+Sy2ThaZW0xg5VR7gRzrs6tWnxQ2JFEV/cAa/VUTb0LgveH/ZE/50qQ50An+wigPA1tm
	 djqymbSY293cNBui2v8JJemhwcWXUNunxFoyis0DR7mHq9V9eyhMkgNsoJ0RYsyCdmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ki7jUNmz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.10
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B8606A32D;
	Fri,  6 Nov 2026 05:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 659B8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ki7jUNmz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPB36iZtD9XULcCLuUv7QUZErQiPKn0j77fnWjvX9y3SOw5YoppB6jHCwJeznKRTpxqd8RisUsRoI/ubeZ6gTW4hhWhbQ5sFfz4CzsfJ1L2Dzu51wuagWefQmtMvMUVwqFkzsFfMVrLU56wHBFMqKTcY5kPOLi5a3gkjP4VaXeOFqxLsOS4mFdd30yJLOvps6vYjORfaIUFQfcn7QeAjUW6dnSD1W4Wr/wdBv/qi0JTtbRXL5QvMKukecHBYW0a8KVvf9aH7GWgN72ynCHfCDOSEg15By4XUfcrywtVJy9G5ftVwKPyw0E7lhgb7XttUD/409k02IZxfzw7cP7MCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrGdQ/f++/KkmWpaFdp+hXVAHbAoj6mf0dPXleo+SSI=;
 b=g6SE9bPIFlHM6MnH7i7Ehw02PBYLHeGQ+n3Df1bzZb3Q2vwBvFEunhps02zADZiZ26+7lsFpFfgIuJ39HDsQj24dm7em3lhennJ7UO3Yr+jwI12vfjsDnQx99eJbDPQLLRJfDb3y737jgxGOTlHHi/KdFqatviikY6hgSuloexl27/imyr3/+jFCq9ZlBgx2IO+bwSmL67hY25JvuxJv55ozoXxZy0e+xG9mizAe/UUDjYEkEU87yD7R2swn+4mz9DZtimeGx8g5tmh1c8rKCsCwtJD5tAcC7nROUV9APnRUPChGhPHm5i1CyzwIio/aICe7GkwRDh6Tjpl4Zja3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrGdQ/f++/KkmWpaFdp+hXVAHbAoj6mf0dPXleo+SSI=;
 b=ki7jUNmzQC9cOtbPmzghvVe9aGQGLE+Siw3XoSySzFFwKv5PdaC2dSB9hb2Vd3ij3TT/H5X7E5cJUJIjzcsxf9+Ofxr0+mm/g0xNlLRCFAMvUUVoIYs5UYNOO7OyWAmUuTxOYeOOhgcKc/3xyJALSlhbipb23BsOfiCy9DgKcVHwg1194u6OylPsrYL6sL25AMLGsJi80+EeYkV2Neo1ILLEHqcnparESDS1nytXDxE1Ua5qMGvf406XxtJDdXiV7+WQ8S22DMgDf+YikX21ezYEXNGK1UkrbMYbovUz6PGLsRb88teWDogxTKs6q7wJZj3QcBy42Lq4tdAU7qOK+Q==
Received: from PH8PR05CA0005.namprd05.prod.outlook.com (2603:10b6:510:2cc::14)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:46:06 +0000
Received: from PH7PEPF00000008.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::50) by PH8PR05CA0005.outlook.office365.com
 (2603:10b6:510:2cc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Fri, 6
 Nov 2026 05:46:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF00000008.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:46:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:45:50 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:45:37 -0800
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
Subject: [PATCH v4 22/32] gpu: nova-core: vgpu: add instance boot
Date: Fri, 6 Nov 2026 11:09:55 +0530
Message-ID: <7e166d92ddd55d1473ffec9d38b08fe1b4728298.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000008:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 6169edab-fbe3-4cbe-95ad-08df3bc9400e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|82310400026|36860700016|5023799004|11063799006|56012099006|261022105027099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003|11062099010|7136999003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hHSYS0reFcPsQTpixDCQLrTzIv0Esc4LwDeyHWMwyK/AUdgErAR512pIV2ooyxp1LUYviTk8sLaJ3aDqi8viFvaY8oVw/vAZFrK4givExh9EdrZLsNI1CA6KX7Sqj4akOXs/4gydbQgCN0n1rj3ROjulIFONecagXmWVRfWgn9LxF5UlVyJqjN+U1xJJrIsYXwbiixN5xiyvZ6MlXLVvNHwvQaGhctJG+bm8LG4nzNCRgANqCVqfl/PYKs3vz35VImRqKGHe+3qSwGcouOgZ3og9OJz9+KxeQ0Nxapo3QWe1M8lvrLgJvDfBitDH/Q4U8LqrQjg10AefcpAdi1k3MBl04j8UxqCayLYTLbC6CVp0CFUB0/fzlC3e5ccb9Zq5ye7qG5iodBZhihTRmg/8noY1OuvLXhScfLapCxj2iHoYjzmUtt+AT8wkiP62zGVf4bt4wuXPMgNHUU9lPyOuJv9t7ju2JNpO++5OtG4LG6NS6VlIb3AhTK/9zuoO0g3xT09ilunNzcq8PhJx2PLr5SQaGzmZkQyVA9pyL7WB3SjMMMQQYnwRabV3YncGQO5YDfEK14OQIeYOdvDxyBjAbncdSGIMZsrYjaZKDkWjWnW2rJtfsn0/wq4/uVeWyOoW+9tYFc4w0TYAkv1VkZNQ9V08rl/WCaQLwHq1pYjZx2lzrMf1eA9MzipmC3SsMZtwx7lVLwA+k0whpnAh8pkb/Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(82310400026)(36860700016)(5023799004)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(11062099010)(7136999003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jUsQV7sipBdLbxSEzus50R0LyzL1iepLcOOyzUncGA8bDAo5l8wupzuohSuWN1TRE4C4Z70ycS6B3VOxl2iGbIXbDF/pFXOMdAQnpIwax7h29v5C6vOonUzbMo2UMGJBa11nXKsmkdjJWANjkx8ezneBKIue/Ll2+EC6pBHYkk7Tmv4QQtQBp4iGwFCQ5Saaqwf1sfOsMrMmtzxKShXmR47vfQ9pVNH0p6mSb0gP8mlpvNNXhH43QNJaigcjoOL3Xe1dlYd1wmy6JaAdAlKjsiAigZIMqttwnFMH85rlBcoxmuh3J7xZzMNnew0+dOgHTYDJQhy6gEO3m/4kC8HKfAhRWQAByy7c48JNLT7JGg9s0eY9ERz7GT6kC6NEwq/UeYZ209uv2le6CApMQlGdag+UFjQp2skJl26p+YZsX77/Qgg01axGb6F/pOQ2r2qB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:46:05.8491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6169edab-fbe3-4cbe-95ad-08df3bc9400e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF00000008.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840

From: Zhi Wang <zhiw@nvidia.com>

Start an allocated instance's GSP plugin with its channel map, VRAM,
plugin heap and log regions. Clear the old ready marker before BOOTLOAD
and wait for firmware to publish a new one.

Retain the command queue and memory dependencies needed by the instance,
and map its communication buffers before boot.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alok Kumar <alkumar@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs                  |  71 +++++---
 drivers/gpu/nova-core/gsp/fw/commands.rs      |   1 -
 drivers/gpu/nova-core/vgpu.rs                 |  30 +++-
 drivers/gpu/nova-core/vgpu/commands.rs        |  21 ++-
 drivers/gpu/nova-core/vgpu/fw.rs              |   3 +
 drivers/gpu/nova-core/vgpu/fw/commands.rs     |   2 -
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs |  16 +-
 drivers/gpu/nova-core/vgpu/instance.rs        | 152 ++++++++++++++++--
 drivers/gpu/nova-core/vgpu/vram.rs            |   1 -
 9 files changed, 244 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 04cdffc3de2b..da753bfc2df7 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -8,6 +8,7 @@
     fmt,
     gpu::buddy::GpuBuddyParams,
     io::Io,
+    new_mutex,
     num::Bounded,
     pci,
     prelude::*,
@@ -16,6 +17,7 @@
         SizeConstants,
         SZ_4K, //
     },
+    sync::Mutex,
     uapi, //
 };
 
@@ -402,6 +404,7 @@ unsafe fn new(
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
+    /// Drops before the MM, BAR1 mappings and GSP needed for instance teardown.
     vgpu: Option<Pin<KBox<VgpuManager<'gpu>>>>,
     /// GSP event interrupt registration, and the enable of its subtree.
     ///
@@ -414,7 +417,8 @@ pub(crate) struct Gpu<'gpu> {
     ///
     /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
     /// the GSP is still operational.
-    mm: GpuMm<'gpu>,
+    #[pin]
+    mm: Mutex<GpuMm<'gpu>>,
     /// BAR1 user interface for CPU access to GPU virtual memory.
     #[pin]
     bar_user: BarUser<'gpu>,
@@ -540,23 +544,6 @@ pub(crate) fn new<'a>(
                 })?,
             }),
 
-            vgpu: {
-                let info = &gsp_resources.boot_result.static_info;
-                match gsp_resources.vgpu_state {
-                    VgpuState::Disabled => None,
-                    VgpuState::Enabled { .. } => Some(KBox::pin_init(VgpuManager::new(
-                        // SAFETY: `chid_pool` is initialized above at its final pinned address.
-                        // The private manager and its pool borrow cannot escape this `Gpu`.
-                        // Completed field drop order drops the manager before the pool; on failure,
-                        // pin-init drops it before the earlier-initialized pool.
-                        unsafe { &*core::ptr::from_ref(chid_pool.as_ref().get_ref()) },
-                        &info.fifo_engine_list(),
-                        info.vmmu_segment_size,
-                        TOTAL_CHANNELS,
-                    ), GFP_KERNEL)?),
-                }
-            },
-
             _: {
                 irq::gsp::quiesce(tree_ref, &gsp_resources.gsp_falcon);
             },
@@ -602,7 +589,7 @@ pub(crate) fn new<'a>(
             },
 
             // Create GPU memory manager owning memory management resources.
-            mm: {
+            mm <- {
                 let info = gsp_resources.static_info();
                 let usable_vram = info.usable_fb_regions.first().ok_or(ENODEV)?;
                 let buddy_params = GpuBuddyParams {
@@ -611,12 +598,15 @@ pub(crate) fn new<'a>(
                     chunk_size: Alignment::new::<SZ_4K>(),
                 };
 
-                GpuMm::new(
-                    bar,
-                    gsp_resources.spec.chipset,
-                    buddy_params,
-                    VramAddress::from_raw(info.total_fb_end),
-                )?
+                new_mutex!(
+                    GpuMm::new(
+                        bar,
+                        gsp_resources.spec.chipset,
+                        buddy_params,
+                        VramAddress::from_raw(info.total_fb_end),
+                    )?,
+                    "nova-core::gpu-mm",
+                )
             },
 
             // Create BAR1 user interface for CPU access to GPU virtual memory.
@@ -632,6 +622,34 @@ pub(crate) fn new<'a>(
                     bar1,
                 )
             },
+
+            vgpu: {
+                match gsp_resources.vgpu_state {
+                    VgpuState::Disabled => None,
+                    VgpuState::Enabled { .. } => {
+                        // SAFETY: These sibling fields are initialized at their final pinned
+                        // addresses. The private manager cannot escape this `Gpu`, and is dropped
+                        // before all its dependencies, both here on failure and on normal removal.
+                        let (cmdq, bar_user, mm, chid_pool) = unsafe {
+                            (
+                                &*core::ptr::from_ref(&gsp_resources.gsp.cmdq),
+                                &*core::ptr::from_ref(bar_user.as_ref().get_ref()),
+                                &*core::ptr::from_ref(mm.as_ref().get_ref()),
+                                &*core::ptr::from_ref(chid_pool.as_ref().get_ref()),
+                            )
+                        };
+                        Some(KBox::pin_init(VgpuManager::new(
+                            dev,
+                            cmdq,
+                            bar_user,
+                            mm,
+                            chid_pool,
+                            gsp_resources.static_info(),
+                            TOTAL_CHANNELS,
+                        ), GFP_KERNEL)?)
+                    }
+                }
+            },
         })
     }
 
@@ -663,10 +681,11 @@ pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bou
         let this = self.project();
         let dev = pdev.as_ref();
         let info = this.gsp_resources.static_info();
+        let mut mm = this.mm.lock();
 
         if let Err(err) = crate::mm::selftest::run(
             dev,
-            this.mm,
+            &mut mm,
             &info.usable_fb_regions,
             this.bar_user.as_ref().get_ref(),
             info.bar1_pde_base,
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index bdc0764bb898..08798f150ad7 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -326,7 +326,6 @@ pub(crate) struct FifoEngineList {
 }
 
 impl FifoEngineList {
-    #[expect(dead_code)]
     pub(crate) fn gmc_ids(&self) -> &[u32] {
         // PANIC: The type invariant bounds `count` by the array capacity.
         &self.gmc_ids[..self.count]
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 024cb13694f4..84c4d0b3839d 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -19,7 +19,17 @@
         ChannelIdPool,
         Chipset, //
     },
-    gsp::commands::FifoEngineList, //
+    gsp::{
+        cmdq::Cmdq,
+        commands::{
+            FifoEngineList,
+            GspStaticInfo, //
+        }, //
+    },
+    mm::{
+        bar_user::BarUser,
+        GpuMm, //
+    }, //
 };
 
 mod commands;
@@ -99,6 +109,10 @@ fn query_state(
 pub(crate) struct VgpuManager<'gpu> {
     #[pin]
     instances: Mutex<VgpuInstances<'gpu>>,
+    dev: &'gpu device::Device<device::Bound>,
+    cmdq: &'gpu Cmdq<'gpu>,
+    bar_user: &'gpu BarUser<'gpu>,
+    mm: &'gpu Mutex<GpuMm<'gpu>>,
     chid_pool: &'gpu ChannelIdPool,
     /// VMMU segment size in bytes, or zero if GSP-RM omitted it.
     vmmu_segment_size: u64,
@@ -109,14 +123,22 @@ pub(crate) struct VgpuManager<'gpu> {
 impl<'gpu> VgpuManager<'gpu> {
     /// Retains runtime parameters from a completed vGPU-enabled GSP boot.
     pub(crate) fn new(
+        dev: &'gpu device::Device<device::Bound>,
+        cmdq: &'gpu Cmdq<'gpu>,
+        bar_user: &'gpu BarUser<'gpu>,
+        mm: &'gpu Mutex<GpuMm<'gpu>>,
         chid_pool: &'gpu ChannelIdPool,
-        fifo_engine_list: &FifoEngineList,
-        vmmu_segment_size: u64,
+        info: &GspStaticInfo,
         total_channels: u32,
     ) -> impl PinInit<Self> + use<'gpu> {
-        let fifo_engine_list = *fifo_engine_list;
+        let fifo_engine_list = info.fifo_engine_list();
+        let vmmu_segment_size = info.vmmu_segment_size;
         pin_init!(Self {
             instances <- new_mutex!(VgpuInstances::new(), "nova-core::vgpu-instances"),
+            dev,
+            cmdq,
+            bar_user,
+            mm,
             chid_pool,
             vmmu_segment_size,
             total_channels,
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index dc2534175e11..6207211d7f9d 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -8,7 +8,9 @@
 
 use kernel::{
     device,
-    prelude::*, //
+    prelude::*,
+    time::Delta,
+    transmute::AsBytes, //
 };
 
 use crate::gsp::{
@@ -26,6 +28,7 @@
         commands::{
             VgpuPropertiesSchema, //
         },
+        GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK,
         GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE,
         GMCAPI_CMD_QUERY_VGPU_PROPERTIES, //
     }, //
@@ -90,3 +93,19 @@ pub(super) fn query_vgpu_properties(
         Ok(properties)
     }
 }
+
+/// Send BOOTLOAD and check its firmware status.
+pub(super) fn send_bootload(
+    dev: &device::Device<device::Bound>,
+    cmdq: &Cmdq<'_>,
+    payload: &[u64],
+) -> Result {
+    let command_id = GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK;
+    let response = cmdq.send_gmc_and_receive_timeout(
+        command_id,
+        AsBytes::as_bytes(payload),
+        0,
+        Delta::from_secs(10),
+    )?;
+    check_status(dev, command_id, response.status)
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index aabe114b55c2..82c29dfb467a 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -30,3 +30,6 @@
 
 pub(super) const GMCAPI_CMD_QUERY_VGPU_PROPERTIES: u32 =
     bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_VGPU_PROPERTIES;
+
+pub(super) const GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK;
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index b8007c3e4a71..3c4a6192d2a6 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -60,7 +60,6 @@ pub(crate) struct ChannelMapEntry(u64) {
 impl ChannelMapEntry {
     const KEY: KeyId = 0x1001;
 
-    #[expect(dead_code)]
     pub(crate) fn new(engine_type: u16, index: u16, chid_offset: u32) -> Self {
         Self::zeroed()
             .with_engine_type(engine_type)
@@ -158,7 +157,6 @@ pub(crate) struct BootloadInfo<'a> {
 }
 
 /// Encodes a `VGPU_BOOTLOAD` request using the typed NVKV schema.
-#[expect(dead_code)]
 pub(crate) fn encode_vgpu_bootload(info: BootloadInfo<'_>) -> Result<KVVec<u64>> {
     let request = VgpuBootloadRequest {
         dbdf: info.dbdf.into(),
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
index b945e216a1d6..0b4d03c5f0fc 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -39,7 +39,6 @@
     size_of::<RawControlRegion>() == u32_as_usize(fw::VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE)
 );
 /// Physical VRAM regions containing the vGPU plugin logs.
-#[expect(dead_code)]
 pub(super) struct PluginLogRegions {
     pub(super) init: VramRegion,
     pub(super) vgpu: VramRegion,
@@ -86,7 +85,6 @@ pub(super) struct CommBufferRegion<'map, 'gpu> {
     kernel_log: VramRegion,
 }
 
-#[expect(dead_code)]
 impl<'map, 'gpu> CommBufferRegion<'map, 'gpu> {
     /// Map the communication portion of a plugin management heap.
     pub(super) fn new(
@@ -188,6 +186,19 @@ pub(super) fn plugin_logs(&self) -> PluginLogRegions {
         }
     }
 
+    /// Clear a previous boot marker before starting the plugin.
+    pub(super) fn clear_plugin_ready(&self) -> Result {
+        let offset = self.io_offset(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.message_seq_num),
+            size_of::<u32>(),
+        )?;
+        self.map.try_write32(0, offset)?;
+        // Complete the posted clear before firmware can publish its new marker.
+        self.map.try_read32(offset)?;
+        Ok(())
+    }
+
     /// Return whether firmware has published the plugin boot marker.
     pub(super) fn is_plugin_ready(&self) -> Result<bool> {
         let value = self.read_u32(
@@ -199,6 +210,7 @@ pub(super) fn is_plugin_ready(&self) -> Result<bool> {
     }
 
     /// Invalidate the PTEs and release the communication mapping.
+    #[expect(dead_code)]
     pub(super) fn unmap(&mut self) -> Result {
         self.map.unmap()
     }
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index a90aaef28b35..b2a0b25c0e15 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -7,18 +7,38 @@
 };
 
 use kernel::{
+    device,
     prelude::*,
     ptr::Alignment,
-    sizes::SizeConstants, //
+    sizes::SizeConstants,
+    time::{
+        delay::fsleep,
+        Delta,
+        Instant,
+        Monotonic, //
+    }, //
 };
 
 use crate::{
     gpu::ChannelIdReservation,
-    mm::GpuMm, //
+    gsp::{
+        cmdq::Cmdq,
+        commands::FifoEngineList, //
+    },
+    mm::GpuMm,
 };
 
 use super::{
-    commands::Dbdf,
+    commands::{
+        send_bootload,
+        Dbdf, //
+    },
+    fw::commands::{
+        encode_vgpu_bootload,
+        BootloadInfo,
+        ChannelMapEntry, //
+    },
+    gsp_plugin_comm::CommBufferRegion,
     vram::{
         VgpuVramLayout,
         VgpuVramSlot,
@@ -27,6 +47,52 @@
     VgpuManager, //
 };
 
+/// Ready limit used by `vmiopd_negotiate_cpu_gsp_version()` for the same marker.
+const PLUGIN_READY_TIMEOUT: Delta = Delta::from_secs(10);
+
+/// Per-engine channel budget reserved by the full SR-IOV plugin.
+///
+/// The supported GB20x path keeps firmware's non-heavy default, which uses
+/// `PLUGIN_ALLOCATED_CHANNELS_PER_ENGINE` rather than the heavy-mode budget.
+const PLUGIN_CHANNELS_PER_ENGINE: u32 = 3;
+
+/// Build the typed channel mapping from the GSP FIFO engine list.
+fn channel_mapping(
+    fifo_engine_list: &FifoEngineList,
+    chid_offset: u32,
+) -> Result<KVVec<ChannelMapEntry>> {
+    let mut mapping = KVVec::new();
+    for &gmc_id in fifo_engine_list.gmc_ids() {
+        // CAST: The mask leaves only the low 16 bits of the GMC engine ID.
+        let engine_type = (gmc_id & u32::from(u16::MAX)) as u16;
+        // CAST: Shifting a `u32` by 16 leaves at most 16 bits.
+        let index = (gmc_id >> u16::BITS) as u16;
+        mapping.push(
+            ChannelMapEntry::new(engine_type, index, chid_offset),
+            GFP_KERNEL,
+        )?;
+    }
+    Ok(mapping)
+}
+
+fn wait_plugin_ready(
+    dev: &device::Device<device::Bound>,
+    comm: &CommBufferRegion<'_, '_>,
+) -> Result {
+    let start = Instant::<Monotonic>::now();
+
+    loop {
+        if comm.is_plugin_ready()? {
+            dev_dbg!(dev, "vGPU plugin ready after {:?}\n", start.elapsed());
+            return Ok(());
+        }
+        if start.elapsed() >= PLUGIN_READY_TIMEOUT {
+            return Err(ETIMEDOUT);
+        }
+        fsleep(Delta::from_millis(1));
+    }
+}
+
 /// Guest Function ID validated against one device's total number of VFs.
 ///
 /// GFID 0 is reserved for the PF; VFs start at 1. Keeping the nonzero `u16`
@@ -49,7 +115,6 @@ pub(super) fn new(gfid: u32, total_vfs: NonZero<u16>) -> Result<Self> {
         }
     }
 
-    #[expect(dead_code)]
     pub(super) const fn get(self) -> u16 {
         self.0.get()
     }
@@ -68,14 +133,72 @@ pub(super) struct VgpuType {
 }
 
 /// A vGPU instance and the resources reserved for it.
-#[expect(dead_code)]
 struct VgpuInstance<'gpu> {
     gfid: Gfid,
     dbdf: Dbdf,
     vgpu_type: VgpuType,
     vm_pid: u32,
-    chids: ChannelIdReservation<'gpu>,
+    num_plugin_channels: u32,
+    comm: CommBufferRegion<'gpu, 'gpu>,
+    // Unmap the communication region before returning its slot and channel IDs.
     vram_slot: VgpuVramSlot,
+    chids: ChannelIdReservation<'gpu>,
+}
+
+impl<'gpu> VgpuInstance<'gpu> {
+    #[expect(dead_code)]
+    fn activate(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
+        let dev = vgpu.dev;
+        self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
+
+        Ok(())
+    }
+
+    /// Bootload the GSP vGPU plugin and wait for its BAR1 ready indication.
+    fn bootload(
+        &mut self,
+        dev: &device::Device<device::Bound>,
+        cmdq: &Cmdq<'_>,
+        fifo_engine_list: &FifoEngineList,
+    ) -> Result {
+        let fb = &self.vram_slot.fbmem;
+        let mgmt = &self.vram_slot.mgmt_heap;
+        let logs = self.comm.plugin_logs();
+
+        let payload = encode_vgpu_bootload(BootloadInfo {
+            dbdf: self.dbdf,
+            gfid: u32::from(self.gfid.get()),
+            vgpu_type: self.vgpu_type.vgpu_type_id,
+            vm_pid: self.vm_pid,
+            num_channels: u32::try_from(self.chids.len()).map_err(|_| EOVERFLOW)?,
+            num_plugin_channels: self.num_plugin_channels,
+            channel_mapping: channel_mapping(
+                fifo_engine_list,
+                u32::try_from(self.chids.start).map_err(|_| EOVERFLOW)?,
+            )?,
+            guest_fb: fb,
+            plugin_heap: mgmt,
+            ctrl_buffer_offset: 0,
+            init_log: &logs.init,
+            vgpu_log: &logs.vgpu,
+            kernel_log: &logs.kernel,
+        })?;
+
+        dev_dbg!(
+            dev,
+            "bootload: gfid={} sending {} typed NVKV bytes\n",
+            self.gfid.get(),
+            payload.len() * size_of::<u64>(),
+        );
+
+        self.comm.clear_plugin_ready()?;
+        send_bootload(dev, cmdq, &payload)?;
+
+        wait_plugin_ready(dev, &self.comm)?;
+
+        dev_dbg!(dev, "bootload: gfid={} plugin ready\n", self.gfid.get());
+        Ok(())
+    }
 }
 
 /// Identity and firmware profile used to allocate an instance.
@@ -133,12 +256,7 @@ fn alloc_vram_slot(&mut self, mm: &GpuMm<'_>, layout: VgpuVramLayout) -> Result<
     }
 
     /// Allocate resources and register a new inactive vGPU instance.
-    fn allocate_instance(
-        &mut self,
-        mm: &GpuMm<'_>,
-        vgpu: &VgpuManager<'gpu>,
-        info: InstanceInfo,
-    ) -> Result<Gfid> {
+    fn allocate_instance(&mut self, vgpu: &VgpuManager<'gpu>, info: InstanceInfo) -> Result<Gfid> {
         let InstanceInfo {
             gfid,
             dbdf,
@@ -165,8 +283,7 @@ fn allocate_instance(
             return Err(ENOSPC);
         }
 
-        // Reserve registry capacity before acquiring resources so publishing
-        // the completed instance cannot fail due to memory pressure.
+        // Reserve capacity before acquiring resources so registration cannot allocate.
         self.instances.reserve(1, GFP_KERNEL)?;
 
         let channels_per_instance = vgpu
@@ -187,15 +304,18 @@ fn allocate_instance(
             heap_size: vgpu_type.gsp_heap_size,
             fb_align: vgpu.vmmu_segment_size,
         };
-        let vram_slot = self.alloc_vram_slot(mm, vram_layout)?;
+        let vram_slot = self.alloc_vram_slot(&vgpu.mm.lock(), vram_layout)?;
+        let comm = CommBufferRegion::new(vgpu.bar_user, vgpu.mm, &vram_slot.mgmt_heap)?;
 
         let instance = VgpuInstance {
             gfid,
             dbdf,
             vgpu_type,
             vm_pid,
-            chids,
+            num_plugin_channels: PLUGIN_CHANNELS_PER_ENGINE,
+            comm,
             vram_slot,
+            chids,
         };
         self.instances
             .push_within_capacity(instance)
diff --git a/drivers/gpu/nova-core/vgpu/vram.rs b/drivers/gpu/nova-core/vgpu/vram.rs
index faaeea106009..bd7d1b4bf039 100644
--- a/drivers/gpu/nova-core/vgpu/vram.rs
+++ b/drivers/gpu/nova-core/vgpu/vram.rs
@@ -102,7 +102,6 @@ fn drop(&mut self) {
 /// All device accesses and mappings of its regions must end before dropping the slot.
 /// Clearing the entry locks a sleeping mutex, so dropping the slot may sleep.
 #[must_use]
-#[expect(dead_code)]
 pub(super) struct VgpuVramSlot {
     pub(super) fbmem: VramRegion,
     pub(super) mgmt_heap: VramRegion,
-- 
2.53.0

