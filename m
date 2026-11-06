Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943781;
	b=AeZiLnzL3dPAoxjfxBywZNRGsYk0K1vsHbVUsN0gYMGIK0cyb4BYZz/c2ybPfs6mUbEa
	 FpVxhjU8N1R0uHA4MWyxHP55ukZCetGJ+02ernSatqKx3J4M4iJ8MRrllfWFSIAEBejpd
	 aVbdaKww3ni8qLqrj0bxs6OoENqeHDdI2agpwh98NBqZDEDI4yMOY8hHGbC1VZXPgzsN9
	 R1+YmPRhPrPjcbFmnI2c3QiBXfzkCQZ0ZaqqPhlCdSk/rdEVesLhe/rB4wixk1stp39WI
	 oR6ej6P6AIiPvtbX5N3w3zXIPjLEIcC8ozh+vPBgNCDK6KGWbDn7mejCyo1Lyaiq5lQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943781;
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
	bh=zKqlBWBFoCY1gLamdXqjS22l2jEXftnIgUUZVGpEkVo=;
	b=ntuUszUDpGpRmm5yOG1GU9/alxK+Ajl8wrR6CTQd1k1Fu0x05q7IO/K42tocW5nEL9Fm
	 eyrnn9TmqTBlAK7p219Km60vFZymRevCfN2EiJ5TpN588d9Kwhu56xG6fEVJOmmsgZLmz
	 Melu+p4gLNYcJXuwBDYG+q9IYxNUnL6+zvl/HyJBz6Ljg5aesv64FTHXEMUD3kiBc2R9G
	 S4M0hd6TXpytcN5+bopoee0Tf+q1K1TXaf5B3seaBxeKR80Ze2kLWQ6fqmg+V1kj4mbYE
	 ojkpV3KgH5b4XliPOaS26p5fuJ8/rkiHElNJuM8nDqBPdjX6QW2e43DzP9izz2MStJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GUC4vgzw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.31
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EEF606A333;
	Fri,  6 Nov 2026 05:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43EEF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GUC4vgzw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl0f7dVq+BCDrWiA6fg/dHGkM3bSd49TvyiEB5ClU6/SAySi5BrgzyLKe9hyXIn8Gn1/JDU/VV0smUJyFpe8dq9mRAM/jLldd/emRVD2q/2Bzn+6ppzNSyfCJeAWb8mew1Lx7ei3htU2PkPzcjck3TNDJkFHlEcF1qy8NFTWY30re2w9CoE+c4m/o5LEalUm1+x9oGZcsyuTsCa/uI/UsppX8r3BOetXdB27oCpvtfjNOAYKrrbuqxKOJAiyb0oC7Q3jojFfOBEAqv3Ozc5JzmY67iUtxvQxmNh+dvhwmEVFW4xm7sUHSrdZ7iUbs7+x98I22JRKOpv1J0eATL/DGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKqlBWBFoCY1gLamdXqjS22l2jEXftnIgUUZVGpEkVo=;
 b=ETSXKWwEta59EOgUznA0wcfyK4LUIHd9Sj44CZXy0eAal/1ICsW0alSdS9HWiWoE1UYdreTb5lJ7VC973H2ZBuKlNa1LW8ZwouuyBaK/BWukB64a2IQKMt+Nkfnwo6zlJ1xHKOZBX6EyTJfGlQz58ydjV61yZeQQhAyrHYSzTiWa06hzOMdL2xNR0ezlFB4ycqKti8eWkWYyHb0yQCwhuUue9C68udv1SPOY3UGmY6otp3aTVys3g6iGqIXiIN1Zn496TjG66jW7QMqh8kWVKNiRQxzg/sLKujKBM9OyDjUTKm/fzXqsWOpn2KRcdog5rPPEHYgV1n0nyBW87H4Bgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKqlBWBFoCY1gLamdXqjS22l2jEXftnIgUUZVGpEkVo=;
 b=GUC4vgzwklpMsWIBJ/OZsxwdp//yg466t+Sb0XnIsMojuUO7gjNjthu7FWHuu/1xPxX8t73mcYkUhHi4DvKYcENdiC0EfXOItuLCdxcjaQsDWKpD+qz/gLQQbaMtSclyx2cgUUgEEEnVNg5DXOzpW9VX87v1ILuXKSvikDcsVa3wQ2UVfqFhuEposBX6uMoJ6G8FPvk3w4blxV2AXvLybTzoI0st7AdWpNrooZkUMOxbq1UDWlSF21VtUfkz9qgUqbklVbuKl+ghjc5BaZs4dHS3Iedf6gSwfOrX4Eug4iGgoAbFIXSGHUDPiMnGUiHiiUECaxqgLRWb6ly65XWnJA==
Received: from DS1PR03CA0004.namprd03.prod.outlook.com (2603:10b6:8:450::12)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:42:55 +0000
Received: from DM3PEPF000265C5.namprd03.prod.outlook.com
 (2603:10b6:8:450:cafe::43) by DS1PR03CA0004.outlook.office365.com
 (2603:10b6:8:450::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:42:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM3PEPF000265C5.mail.protection.outlook.com (10.167.23.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:42:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:42:42 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:42:29 -0800
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
Subject: [PATCH v4 07/32] gpu: nova-core: vgpu: initialize runtime parameters after GSP boot
Date: Fri, 6 Nov 2026 11:09:40 +0530
Message-ID: <8c43a876ee1ba459da34d0a1b291688618e1679d.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C5:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4b8cbb-8df8-4b8c-12ba-08df3bc8ceab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|10067099003|22082099003|11062099010|18002099003|7136999003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	G6tLXCHPzU3rD1PYSdayY/RBegizrwdAwicRXvdlZDYKTE8WQsJxHZH4cZaUhUN/clITM168Lzuum6reNYX+e1+gV6tWXdrzUFCF+g+uHIIQaCtqe3Bk9Cwn7EsT99alYxAo6Ny89mfqye9hVq6n/qZS8MZzYI5DKuPWuzukqnwAeQhwHQMx304zjQqemdbXwHKvW92uev+4sHUp7RHUnFK8tiFpqmhkcnNRZDVbkz6nVrmFJhsK3/17zeSnHKaNJgSyBDRTdv7W+m2/UY/dTH9crOgFJFmdPoeB8/8WP1pyPPIWg9fyaQlzAIdddIhZzijxKWQGtnQuzFbuWK2jkzWV6ma18SoR+mB8UwFhVtYSrLbj4iyFrtg/whsLdAVtGykVP1UJPfyZM2lyaZdH75SDhyIp26fVtYCfOadmHPgnVOWXwyXEGSI+ul9gnYxNREFlwPdNR6wcba1i2C9KeK4kUH/PIRXiUZPKmfqvMiSvTFYK27dbcY2/so+yO4ZnKvT29dggG1jVBL4T+WnPS9J13+PlK/fHPlAf9yJVIhT8cvq4RHFuYsqRNoDyEpB3L+yq0NNiNas6/MfNzl6Cy56Uzg38+aFpiZhN+fvstU74YclycRcrMm4c57VqaoZyvpUGu9yiY7rxGcwq+28iZOGDkAs6efyF9Bb/haTEHGtEAZ8nP+oKzcnB+vaKgwsLYaPya9SYdnzGIAv9PxmYOA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(11062099010)(18002099003)(7136999003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GIQbgF8rg7eENpLaSo/zBCIR31Vs/NnZwsFo1cJoFqc92TUVK8b9XEXsVpQ0toteUD3pCxFIHASAjSAe+IzB1VuSKPwY1SPpVtWPhbgOrxSwdDlaaPybW1J+R9zMeY22IkaQc3tXqo2NbahpFnBtdsBmtudEf1mNq/N3e8PxVzUDpa/lg/yKM75zHaTZT0oQq6aWZTsE47tYgLU2/Yv0GXaorNFQmqoeh22bnn01vPxT6G6g/unUNmvFV88Y5lo7Dx7AX0ZzrIaVQ9ekM1IGRaZXkexfUVoxCBl1bzahGTkd5Qdh2+t+Dp0GtEsdDIRw7Emy/NHJ8ezrWR4jbLoZnJkSn4uA7UETQNPeqoQ+h63ocWPl/Qe8d8y3CfKK4o2tMKu4w/viHA/vaSjvO5ISTIz1siQqp/qPOLrzFxVVvnFqr3ONC8dXBbmmGkdm2x73
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:42:55.5638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4b8cbb-8df8-4b8c-12ba-08df3bc8ceab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092

From: Zhi Wang <zhiw@nvidia.com>

The vGPU manager needs the VMMU segment size and FIFO engine topology
returned by a successful GSP boot to divide instance resources.

Construct VgpuManager only for a vGPU-enabled boot. Retain the GPU-owned
channel pool, the ordered host-driven engine
list and the VMMU segment size. Expose the existing decoded VMMU value
from GspStaticInfo at its first consumer, preserving zero when firmware
omits the key.

Keep the runtime values in the manager for its instance module, and drop
the manager before the pool and memory resources it borrows.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs              | 23 ++++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs     |  5 ++--
 drivers/gpu/nova-core/gsp/commands/gmc.rs |  1 +
 drivers/gpu/nova-core/gsp/fw/commands.rs  |  2 +-
 drivers/gpu/nova-core/vgpu.rs             | 36 ++++++++++++++++++++++-
 5 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 3f8bdbb9a5b2..002c5ba134a6 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -53,7 +53,10 @@
         VramAddress, //
     },
     num,
-    vgpu::VgpuState, //
+    vgpu::{
+        VgpuManager,
+        VgpuState, //
+    },
 };
 
 #[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
@@ -397,6 +400,7 @@ unsafe fn new(
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
+    vgpu: Option<VgpuManager<'gpu>>,
     /// GSP event interrupt registration, and the enable of its subtree.
     ///
     /// Must be kept declared *before* `gsp_resources`, so that the handler is unregistered, and
@@ -534,6 +538,23 @@ pub(crate) fn new<'a>(
                 })?,
             }),
 
+            vgpu: {
+                let info = &gsp_resources.boot_result.static_info;
+                match gsp_resources.vgpu_state {
+                    VgpuState::Disabled => None,
+                    VgpuState::Enabled { .. } => Some(VgpuManager::new(
+                        // SAFETY: `chid_pool` is initialized above at its final pinned address.
+                        // The private manager and its pool borrow cannot escape this `Gpu`.
+                        // Completed field drop order drops the manager before the pool; on failure,
+                        // pin-init drops it before the earlier-initialized pool.
+                        unsafe { &*core::ptr::from_ref(chid_pool.as_ref().get_ref()) },
+                        &info.fifo_engine_list(),
+                        info.vmmu_segment_size,
+                        TOTAL_CHANNELS,
+                    )),
+                }
+            },
+
             _: {
                 irq::gsp::quiesce(tree_ref, &gsp_resources.gsp_falcon);
             },
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index f5ec27995627..799f26e0ae74 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -11,7 +11,7 @@
 
 use kernel::prelude::*;
 
-use super::fw::commands::FifoEngineList;
+pub(crate) use super::fw::commands::FifoEngineList;
 
 /// The static GPU configuration, which GSP-RM reports in reply to [`GspInit`](gmc::GspInit).
 pub struct GspStaticInfo {
@@ -25,6 +25,8 @@ pub struct GspStaticInfo {
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
     /// Exclusive end of the FB physical address space.
     pub(crate) total_fb_end: u64,
+    /// VMMU segment size in bytes, or zero if GSP-RM omitted it.
+    pub(crate) vmmu_segment_size: u64,
     /// Host-driven engines in firmware FIFO order.
     fifo_engine_list: FifoEngineList,
 }
@@ -68,7 +70,6 @@ pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
     }
 
     /// Returns the host-driven engines in their firmware FIFO order.
-    #[expect(dead_code)]
     pub(crate) fn fifo_engine_list(&self) -> FifoEngineList {
         self.fifo_engine_list
     }
diff --git a/drivers/gpu/nova-core/gsp/commands/gmc.rs b/drivers/gpu/nova-core/gsp/commands/gmc.rs
index c9258ee9e059..6f88c99349ac 100644
--- a/drivers/gpu/nova-core/gsp/commands/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/gmc.rs
@@ -186,6 +186,7 @@ fn read(payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>) -> Result<Se
             usable_fb_regions,
             total_fb_end: reply.total_fb_end().ok_or(EINVAL)?,
             fifo_engine_list: reply.fifo_engine_list(),
+            vmmu_segment_size: reply.vmmu_segment_size,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 07115ccf3e95..bdc0764bb898 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -378,7 +378,7 @@ pub(crate) struct GspInitResponse {
     gpu_gid: ArrayVec<u8, { GspStaticInfo::GID_LEN }>,
     fb_regions: KVVec<FbRegion>,
     bar1_pde_base: u64,
-    vmmu_segment_size: u64,
+    pub(crate) vmmu_segment_size: u64,
     fifo_engine_count: FifoEngineCount,
     fifo_engine_gmc_ids: [u32; MAX_FIFO_ENGINES],
     fifo_engine_flags: [u32; MAX_FIFO_ENGINES],
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index b405ba49c490..5cd82adeb0f8 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -13,7 +13,11 @@
         Fsp,
         VgpuMode, //
     },
-    gpu::Chipset, //
+    gpu::{
+        ChannelIdPool,
+        Chipset, //
+    },
+    gsp::commands::FifoEngineList, //
 };
 
 mod hal;
@@ -80,3 +84,33 @@ fn query_state(
         }
     }
 }
+
+/// Runtime resources for an enabled vGPU boot.
+pub(crate) struct VgpuManager<'gpu> {
+    #[expect(dead_code)]
+    chid_pool: &'gpu ChannelIdPool,
+    /// VMMU segment size in bytes, or zero if GSP-RM omitted it.
+    #[expect(dead_code)]
+    vmmu_segment_size: u64,
+    #[expect(dead_code)]
+    total_channels: u32,
+    #[expect(dead_code)]
+    fifo_engine_list: FifoEngineList,
+}
+
+impl<'gpu> VgpuManager<'gpu> {
+    /// Retains runtime parameters from a completed vGPU-enabled GSP boot.
+    pub(crate) fn new(
+        chid_pool: &'gpu ChannelIdPool,
+        fifo_engine_list: &FifoEngineList,
+        vmmu_segment_size: u64,
+        total_channels: u32,
+    ) -> Self {
+        Self {
+            chid_pool,
+            vmmu_segment_size,
+            total_channels,
+            fifo_engine_list: *fifo_engine_list,
+        }
+    }
+}
-- 
2.53.0

