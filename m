Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943936;
	b=kdzT6Em2iJnYSwYdjjRP3Mr610Lt+lgOdgsS7363W425LUWvFOJojQ0Rt2UDXT11Miew
	 3NL/O2r+5PMTJ+wh6cn9qelkufApDM52XVhWDlhq7IzVAfU/u8QcGshGuuxbzvrVPpNHW
	 1gnXE8/QyEIZCX0ADan5ekFBeCSnyHyghTWRCrn6+fZ5ib75fXvxelVGvEl3wePnQF8hd
	 dY0iCLQbVrz91gmlycjlfkwTJuw6zZbwWm3dJ+1SZxVUNG1U6GdVUR86kIFY++8dN3tdU
	 J7xf6QDpcQO8R9jAjueQTW09C4kvep6R/k2A5UgOqstpiLDN1tbXa9gaAruKSzfQh4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943936;
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
	bh=wurpE03Vk3yppA86PIXTuj1GMEnoJIms7mHUdeL70Q8=;
	b=Dj1geKSrgFsy8HCWr2CQlrCflgvGaR3rD52evwQV3L4nAYt0LRjmJd4+bf0r8wQ0Wp0i
	 m/Q+SOf8gIQcC5zDDDY6FBmV1d1f4di0IHEMYSa4vOPDbCYeJDGicyJZaS6vs67mRYfyN
	 kkRE/oKyptnz5/zBcC1VyGfsnpAd3eHC6ILDiObVy7eik0Er1AL7ZCrmhyN19Q437V1Nz
	 jhppAw+jPRdBdc3WT/D5iY1htr5FuWQgKyur43H3CIxWw5Shki8xKSAgnPdk5DQc7ZCBq
	 q6KEUEnrns2vrfiOgu2mt6YnTAWlR9y2w8PbjH8ji8XgnLmNKkL5vi61t00dZgScfpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="LPiw2h/E";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.17
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1E606A331;
	Fri,  6 Nov 2026 05:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D1E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LPiw2h/E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfCMvQHDFcovYpCihwLUO91G5HeuSmcYNi65X8InHddNDOTzpNa7C1qt2/8U7JEN2Kg+DLtzuvQW5f9mAiSNDiBZocCErfCN7yioNGENmkCw470wQNq+NPuD7YXekuFStFhzCKoiNvmTrOgbkww/19efCOW48R8XfV12WoOQPR9Vmrh1LY1ReSNdXoLks/ihjnQ7Egj/P+mHyGfedPmhxd7gvhKb3d1bKqk4w3Tx39eMwC5SBOqthQJeQn3qOmP4XW8srWpvP+TB/acSPNxB4D9McIe8SJ5rXt/5QiKjHHeVwjYjfeksLwEk+2ZqqFF0s4tdyvjbKYgm5D5olo0vKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wurpE03Vk3yppA86PIXTuj1GMEnoJIms7mHUdeL70Q8=;
 b=cZga1qccS2DxpHh5RuhquwaNExSDvqB1ppF3C5TRkElLi6FH6w4xV7JH2+2kxrr97uFSHFqTSGT4IQvsOzgLBX/FpS64mWkcM7MAHXkCrCttlgbZLXu/VD6QTSCFu5l+UJglCTfibT9PIlzTlSw/876rCUeLTgk9tsteSyRuacfXjHfCzDIdUskIlhv1F2d0HktPPLWtTC761DkoJh5Q0zhWjpKyWZoTfci7Ger6F0hhTDZCOAcCsaEwXdj7OBkQ1Nt4zFvnYqv144I//RVrtC69N5JP4XT4qrXvqgZOXG/Fcr5VUwL0tG8NGNcn4IvGFB+6KohUkA3hSEi+/Wvo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wurpE03Vk3yppA86PIXTuj1GMEnoJIms7mHUdeL70Q8=;
 b=LPiw2h/ExVMnscIP3KRCpGNVtW9fYSCizg6S53CbbvEWf1oQIfiFcErB9NwxW7iquy9I8GUHz9VyALZ2br3+xGb4hqW1BbHilQXBDTsEAmPiqndKa4KwYFuSFqJEz/VyPPzSfrihbK5OoSij/fO69SlruBJ7m62+zkx2xNpiGxqeE8iy29BuW1cJsaqzBuRLWkQZqPMBU+98d6s3uGOrg1zMYoPid5vBF+x7OzZdONI2v3Cyk8zQnyZ0uRYO4Y2Xkk+lLySPbT0/I+LJ8bjkF/I54clPJLxv92yqdocOO+uSutWG0XVpzzTkyj1j/92hQCLr1bV9ECBpRtscKhJksw==
Received: from DS1PR05CA0018.namprd05.prod.outlook.com (2603:10b6:8:23f::14)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:45:30 +0000
Received: from CY4PEPF000392DC.namprd03.prod.outlook.com
 (2603:10b6:8:23f:cafe::3e) by DS1PR05CA0018.outlook.office365.com
 (2603:10b6:8:23f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 6
 Nov 2026 05:45:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392DC.mail.protection.outlook.com (10.167.247.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:45:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:45:12 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:44:59 -0800
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
Subject: [PATCH v4 19/32] gpu: nova-core: vgpu: add instance create/destroy
Date: Fri, 6 Nov 2026 11:09:52 +0530
Message-ID: <a7c243c7494e8e705bde2030b6e4870b466a6bfa.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DC:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 353bf9e0-4146-45a8-f5bb-08df3bc92aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|11063799006|5023799004|261026140227099003|261026121527099003|261022075727099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261022113327099003|261009223027099003|261102123227099003|261028144727099003|10067099003|22082099003|11062099010|18002099003|7136999003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NJc61XcZN0TFsEONolp2dCKsgB5DffNAXxjOF+KbKpcmUs8FZGGZVWUaJfs9Nas2Xfr2zGODSvbD/daOzAZgsGsg3D7lW2mIMTeRRGCMR3qQJGl4cvmu2Yp1ay/8EWnfnImCUtu/CwKUltVFuKhEyu8eLQc0nXECpFB32Nt306R1xzRbchOMmb/FXqX5feLLSNgeNiYyiwUyfpj5V0t4gbqmsLu1N54y1RoD2lzOZSO6KaifszahZ9/ATMR/Tl/5+He4LeVsEWVWykTsljSiqOZPLCXL6tCKN+ork0cyLD+Y+kBsyS4FwxgQaLaauro8pR4Jt5l3Yn1c+udrz0rqgyLChgaKmUISXZg2jRwWkcA0KjcO70OyvzyphRgTVhIBu2Blb6+t6YmtLFEos03RbH87+9KZkF2xC9KcAkfpZihz7oCJgXxkQT4vzLzVljtnHu5+cgTviFVc+Q0E36bc8rPKfL/402hbZZZ9MI/o/NF9j+7j5P9Gg6b/lzfcvbI4wff4yk36I41aZOoIgYgwQzxGBGwo3/y6YPPZ8Iy7rEGsULgQqlljFQj2/A7+WLV3XKggBsmkyvVL+wLz4JNQEQ0KasWkycFuZAuKFFwzFSiwTYmQiU0lU6qwKb3h5x4Xh6V54kJM9yvhuu2pe7nVooB8xyUGDVURtk33z1UnqVJSR+nmpNdE/5JjTu5mRuqB5m+vkLLAsxuxKvUfpt5HuQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(5023799004)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261022113327099003)(261009223027099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(11062099010)(18002099003)(7136999003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XEER/gI1SYHkoc/ienxZJFnlQ7poUotJFrmAAVb98eYVYrVClwxgqCtlyKqOHL2eWFikbSf3n8923gC/hmZvL4Gy0sjDMJx+xxUfzJkHEwB2EgwDJzMW5kZYu3xsGY0L5j+WF4x/XAED4Kr0drxEiq5qnq+FYfZY08Ni2wXAgD1BBwie46eTaczO8U0dFUBURjg3g0IRuXQCn0FJ0LmM3+PxYhEsxEq58OYTUhBKJZYJHMVmbpYxJTCvX69PaF7wuHTTJSBmHx59KFJyN25cQFvsZakVtTMVfDNFe9dOFRQi5rdtp10TGBfpWFDKhMFNIjKPTK5jcLU/3Q3+4FMsH4r/9xr9/e4AsLO9FoGfgCgRpz/oQrGdLmNXttL+cwwMycVpVh6t1+WPySy+mW55+alpMRvNj6sy8SiM5AkjQnsSFfJkhIWKhv9eBWxyxRK6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:45:29.9038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353bf9e0-4146-45a8-f5bb-08df3bc92aa2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301

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
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs           |  12 +-
 drivers/gpu/nova-core/vgpu.rs          |  24 ++-
 drivers/gpu/nova-core/vgpu/instance.rs | 218 +++++++++++++++++++++++++
 drivers/gpu/nova-core/vgpu/vram.rs     |   1 -
 4 files changed, 240 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/instance.rs

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 98772868979d..04cdffc3de2b 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -59,14 +59,16 @@
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
@@ -400,7 +402,7 @@ unsafe fn new(
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
-    vgpu: Option<VgpuManager<'gpu>>,
+    vgpu: Option<Pin<KBox<VgpuManager<'gpu>>>>,
     /// GSP event interrupt registration, and the enable of its subtree.
     ///
     /// Must be kept declared *before* `gsp_resources`, so that the handler is unregistered, and
@@ -542,7 +544,7 @@ pub(crate) fn new<'a>(
                 let info = &gsp_resources.boot_result.static_info;
                 match gsp_resources.vgpu_state {
                     VgpuState::Disabled => None,
-                    VgpuState::Enabled { .. } => Some(VgpuManager::new(
+                    VgpuState::Enabled { .. } => Some(KBox::pin_init(VgpuManager::new(
                         // SAFETY: `chid_pool` is initialized above at its final pinned address.
                         // The private manager and its pool borrow cannot escape this `Gpu`.
                         // Completed field drop order drops the manager before the pool; on failure,
@@ -551,7 +553,7 @@ pub(crate) fn new<'a>(
                         &info.fifo_engine_list(),
                         info.vmmu_segment_size,
                         TOTAL_CHANNELS,
-                    )),
+                    ), GFP_KERNEL)?),
                 }
             },
 
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index d910445dd2b0..fb4f1b5f7754 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -4,8 +4,10 @@
 
 use kernel::{
     device,
+    new_mutex,
     pci,
-    prelude::*, //
+    prelude::*,
+    sync::Mutex, //
 };
 
 use crate::{
@@ -23,6 +25,7 @@
 mod commands;
 mod fw;
 mod hal;
+mod instance;
 mod vram;
 
 /// vGPU state detected during GPU construction.
@@ -88,16 +91,17 @@ fn query_state(
     }
 }
 
+use self::instance::VgpuInstances;
+
 /// Runtime resources for an enabled vGPU boot.
+#[pin_data]
 pub(crate) struct VgpuManager<'gpu> {
-    #[expect(dead_code)]
+    #[pin]
+    instances: Mutex<VgpuInstances<'gpu>>,
     chid_pool: &'gpu ChannelIdPool,
     /// VMMU segment size in bytes, or zero if GSP-RM omitted it.
-    #[expect(dead_code)]
     vmmu_segment_size: u64,
-    #[expect(dead_code)]
     total_channels: u32,
-    #[expect(dead_code)]
     fifo_engine_list: FifoEngineList,
 }
 
@@ -108,12 +112,14 @@ pub(crate) fn new(
         fifo_engine_list: &FifoEngineList,
         vmmu_segment_size: u64,
         total_channels: u32,
-    ) -> Self {
-        Self {
+    ) -> impl PinInit<Self> + use<'gpu> {
+        let fifo_engine_list = *fifo_engine_list;
+        pin_init!(Self {
+            instances <- new_mutex!(VgpuInstances::new(), "nova-core::vgpu-instances"),
             chid_pool,
             vmmu_segment_size,
             total_channels,
-            fifo_engine_list: *fifo_engine_list,
-        }
+            fifo_engine_list,
+        })
     }
 }
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
new file mode 100644
index 000000000000..a90aaef28b35
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -0,0 +1,218 @@
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
+};
+
+use super::{
+    commands::Dbdf,
+    vram::{
+        VgpuVramLayout,
+        VgpuVramSlot,
+        VgpuVramSlotAllocator, //
+    },
+    VgpuManager, //
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
+/// Resource requirements and device identity for one vGPU type.
+#[expect(dead_code)]
+pub(super) struct VgpuType {
+    vgpu_type_id: u32,
+    bar1_length: u64,
+    max_instance: u32,
+    pci_dev_id: u32,
+    pci_subsys_id: u32,
+    fb_length: u64,
+    gsp_heap_size: u64,
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
+    pub(super) const fn new(gfid: Gfid, dbdf: Dbdf, vgpu_type: VgpuType, vm_pid: u32) -> Self {
+        Self {
+            gfid,
+            dbdf,
+            vgpu_type,
+            vm_pid,
+        }
+    }
+}
+
+/// Registry of live vGPU instances.
+pub(super) struct VgpuInstances<'gpu> {
+    instances: KVec<VgpuInstance<'gpu>>,
+    vram_slots: Option<VgpuVramSlotAllocator>,
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
+        let replace_empty_pool = match self.vram_slots.as_ref() {
+            Some(allocator) if allocator.is_empty() => !allocator.matches_layout(layout)?,
+            _ => false,
+        };
+        if replace_empty_pool {
+            self.vram_slots = None;
+        }
+
+        if let Some(allocator) = self.vram_slots.as_mut() {
+            return allocator.alloc(layout);
+        }
+
+        let mut allocator = VgpuVramSlotAllocator::new(mm, layout)?;
+        let slot = allocator.alloc(layout)?;
+        self.vram_slots = Some(allocator);
+        Ok(slot)
+    }
+
+    /// Allocate resources and register a new inactive vGPU instance.
+    fn allocate_instance(
+        &mut self,
+        mm: &GpuMm<'_>,
+        vgpu: &VgpuManager<'gpu>,
+        info: InstanceInfo,
+    ) -> Result<Gfid> {
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
+        let max_instances = usize::try_from(vgpu_type.max_instance).map_err(|_| EOVERFLOW)?;
+        if max_instances == 0 || num_type_instances >= max_instances {
+            return Err(ENOSPC);
+        }
+
+        // Reserve registry capacity before acquiring resources so publishing
+        // the completed instance cannot fail due to memory pressure.
+        self.instances.reserve(1, GFP_KERNEL)?;
+
+        let channels_per_instance = vgpu
+            .total_channels
+            .checked_div(vgpu_type.max_instance)
+            .ok_or(EINVAL)?;
+        let channels_per_instance =
+            usize::try_from(channels_per_instance).map_err(|_| EOVERFLOW)?;
+        let channels_per_instance = NonZeroUsize::new(channels_per_instance).ok_or(EINVAL)?;
+        let chids = vgpu
+            .chid_pool
+            .reserve_ids(channels_per_instance, Alignment::SZ_1)?;
+
+        let vram_layout = VgpuVramLayout {
+            type_id,
+            max_slots: vgpu_type.max_instance,
+            fb_size: vgpu_type.fb_length,
+            heap_size: vgpu_type.gsp_heap_size,
+            fb_align: vgpu.vmmu_segment_size,
+        };
+        let vram_slot = self.alloc_vram_slot(mm, vram_layout)?;
+
+        let instance = VgpuInstance {
+            gfid,
+            dbdf,
+            vgpu_type,
+            vm_pid,
+            chids,
+            vram_slot,
+        };
+        self.instances
+            .push_within_capacity(instance)
+            .map_err(|_| EIO)?;
+
+        Ok(gfid)
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
diff --git a/drivers/gpu/nova-core/vgpu/vram.rs b/drivers/gpu/nova-core/vgpu/vram.rs
index 65e6a945ea6f..faaeea106009 100644
--- a/drivers/gpu/nova-core/vgpu/vram.rs
+++ b/drivers/gpu/nova-core/vgpu/vram.rs
@@ -116,7 +116,6 @@ pub(super) struct VgpuVramSlotAllocator {
     slot_bitmap: Arc<SlotBitmap>,
 }
 
-#[expect(dead_code)]
 impl VgpuVramSlotAllocator {
     pub(super) fn new(mm: &GpuMm<'_>, layout: VgpuVramLayout) -> Result<Self> {
         let layout = layout.validated()?;
-- 
2.53.0

