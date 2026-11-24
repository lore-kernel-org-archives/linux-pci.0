Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529196;
	b=f96JQOQpNSKgPGZdThCSPFtfY/THT28p/mBm6qmpRtsKMPrS/2Pn21W6vvZcGpvYCq7Q
	 QNOJyznDOyM4wGNoHsKwYHn6+vrf38tpjmneSxK+EL6vYT2xKf9JHVC6cYuf0tYqmmav0
	 T7mCbixOvaWH5+Ysq8V6rVM4w18L3aqmc7qMI5lx6uJathl81aUk3xTdZX1f4NpVgMMF2
	 FDFlh2O7nYfZFirAxMqD6LflnNB5mf46pl+bBMtaN+m+K5ssutCQMuFD8BEIBQ8vsoQcY
	 J5a7V6aJ/4mjV71vSNPT02pmIk6aSTqYv/AN5jmkNsAvHMLh5Stt0SDLRzzQak4NaUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529196;
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
	bh=ekP6nY6jogImSfqOpJxA+431StFhk8pgthfvcdwU4sQ=;
	b=U8GULIFVPUIryur9oZWrQqwsP8R3ZEnBBwuhIDriqSDVfvNSf8Ry1OwQFKpgioB3hWEY
	 Cu39VkXXUUECcrPSFI7dVJR09AaDiizqnZxEvTWvo57OUCbj503egBYANNmKvezBWczBL
	 yPbtEkpoQ7hGw5F69/cRQcIUAhAd2B6qYYC8dr3IG1F4t7a1uk5LGeY/CRN7WruE7VQTL
	 vU7YuPhM75NK3ua+FU+s+tVDPM3BPSQIjFMGhEMAt4a0QlPD5AJjIktEMMOUy6l7ufCAn
	 8iFI2+qcBy36Hqh1aX8J1ilJM40ZZn8NPWGarUbTVn+pPzovh/LK0w4qk2mKnX/TMog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S3usooI6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.69
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E2606A33B;
	Tue, 24 Nov 2026 14:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 571E2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S3usooI6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQIINjNJjQF1glslf4cXmebW6v1oBi1shZ5PUj7AIdD+XrRcfHFa6Na36EQa0WIRQc3HVSmI++Z664k8IWZrjIBr1FlFfDTXeJsbLT1sTyOko35iIgeG5RAyKCS1ho856PgoABov862Tr10UP8xVLyLpy8bs0cTreR4U7GFv97XNCEHzZThYJwH2gSjr4ouslVqGtKLEMqiXPMOCkRFhXHqvTfbLZUoeMytYC8UvKpSo+njRjIJ8WYnQSfYfdbUy8J/A0rGpd4NmEUjjs4N7oUXITI/bZpMURSYdCjrS+jAJfkLiJJYcC9gdbNcszGIhZKSVlYrpUmIaqOYcgzTnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekP6nY6jogImSfqOpJxA+431StFhk8pgthfvcdwU4sQ=;
 b=aEjZeY4DIyhDwXkHuFNibkziIHF8GK/LomVmswUNPZ1UitA8c8v62q0Uk9mf75Zcx1wpeYPulz5kpBnsMRvKSO3VfMtUaNKOPh4roaZFNK8oSrsipxvb1xngyC4n/5dnlc4L7Q911K+LLiDfFjQTtWLpFTCr3OaXaeXBaEnLHS1EAAIiG5kH9EmJx+WREnjr/mA6OfBCL96liLH55os/rwSVpW83cZUm3KhYW0AUWBJPhelQHfM0j2GCv3FZyjpy4IxwB3/tMUJ8K2KRRf4wdQCF5M4dyiTwD97HWnDT0KZCRlIwNIPoLywFBMyEbQSViZuJA1skWbDs1HxNIOyyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekP6nY6jogImSfqOpJxA+431StFhk8pgthfvcdwU4sQ=;
 b=S3usooI6zfH71+gb2c5aTy6s1q0bOpZiHoRn0RuGpLawc+S9hlv/4Joh5D64mrMNlNBqUI5UC1UpohPQ61siZIR88ZIumfwT5FuBdnzKwAKEzFNNMde/lmA1UuGK82bOkcQYkP1H1TXZHTCexf8tTrPEnAyVoTgbe1AKQUySWZ4VPAQ1hrCA2Xw91GG1o1FsilBJHwwVsBiQjRYutnlmuluCkMqXDStMAZ2LcCvqheVoC0tWoaqjY+Zyc6B7BKoDRuIJc8YA3bHAWBinM7wgqOC8k3vwHsBuOOp8Eaq01zlsQJSQ4McpaHr+ITpa1CGYynhSQW9pihQjMHj2TIKRTQ==
Received: from PH8PR21CA0017.namprd21.prod.outlook.com (2603:10b6:510:2ce::17)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 14:06:12 +0000
Received: from CY6PEPF0000004B.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::74) by PH8PR21CA0017.outlook.office365.com
 (2603:10b6:510:2ce::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.3 via Frontend Transport; Tue, 24
 Nov 2026 14:06:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004B.mail.protection.outlook.com (10.167.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:06:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:05:49 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:05:36 -0800
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
Subject: [PATCH v5 26/35] gpu: nova-core: vgpu: add instance boot
Date: Tue, 24 Nov 2026 19:29:22 +0530
Message-ID: <20261124135937.18583-27-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004B:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad11067-fb9a-418c-d114-08df4a34183f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|7416014|23010399003|82310400026|10067099003|261021121427099003|261028144727099003|261022105027099003|11063799006|56012099006|261102123227099003|261026140227099003|261021135927099003|261026121527099003|261021123027099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KfYB97zga6HjKyVzs/d2S6av4uY49kgZseN5hCHIzrd/oAMF7iEQSFli40y/DMhIxROLbbF30jeSUaIh1jp671T4auWWtPHYg2quiLhrvP2Vt0YOKFt0Zzk6l0JVZ9XBwN4FyTKTuWxSvglpBA9MHxFz58jMlAaEAsDVfqBOZ3EpUvBr+xASYkWbAzPNBLpNiZIBX8ajO+XHheCLs5p0S8cijMIZ18zFXFyzS0QSjTLbTO5/xKEfGIvSThr8jzpptPTdjPyi/tGOHL1Mkp3GJRiIheQ4zjMXHixeJJNed98g6qOBH+9BXAjWuerQbQDUoI5DxsL+SoIqGxwTeKMsGJAFx2EmH+yIvWhb3UEbBtygIVajz0ZvKVKRg2IVOvYxpI+fDNmn7Tvpaiuq0fr194mhJ/okcsdhGMOeFKZ98d8VBy0cpb8wLShEagw1mPvOXURgBIrEYrHYcC+m7zwyW+KZi9CZfmXsJ1maV9+QYsJlHDRabu4YdriYGWdW/wYoX5BQx5gwMFf0U4hrymVqWyP1N9RUnbVsw2bEg3cnD86oCKgPDC3TnW7nKzMvkg4JsufBRzjkg97H1gX5hRBXGWKO1ZeW/s8Lk9OUQ22XBcz1btZaXI6h7xtMvjvt0WyGrqlaCQtWXyb1CO1d9wcpTxadE7ijBYSKz6ltU+TYOlqKmErgiitde1ZxNeiYAA/zQ32/W1nTakDUSQolOfZjEw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(7416014)(23010399003)(82310400026)(10067099003)(261021121427099003)(261028144727099003)(261022105027099003)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261021135927099003)(261026121527099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MIT28/pEq+fulAOg3b8/5x10+hjN56b3s7h6pTtsowzn1RXY7zDTXRHx7+Qf/ugtHn/+U35z5L8WsGolpytlCmXRM8+iLAgn0D05kBPQRVdpPdlgycXqpHXc7Yt9IG8Q95yAD2fWTPGGNv7z/8/Am63GVyy/Uw6yVPalfTSdUgVDMGVNK3l+hiL/imfncNCwKtq5sD1KLmEX2/RHF3cdecHO6EAao5ktlSgPuKYlCJGvDzbqwNq3TJlBs7GetkdWee8nZbKZc+Fm+6Yy2z9+xdSZ6wm5zgXjplcdqrTINupN+6SoH/RWNv0YuFlapT02qITFWYA8o4KCzKb2MRmc6Wx9RVwP6Ui53eH6JDMeyaZGsfBsIA8y2xYda74H3MJW9HGabA0TzdyX3AMMomp8rE+hWFPbmJIXIxvJbijDXi9eMR5iFMHQRCtQCEk6KEk8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:06:11.4834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad11067-fb9a-418c-d114-08df4a34183f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244

From: Zhi Wang <zhiw@nvidia.com>

Start an allocated instance's GSP plugin with its channel map, VRAM,
plugin heap and log regions. Clear the old ready marker before BOOTLOAD
and wait for firmware to publish a new one.

Retain the command queue and memory dependencies needed by the instance,
and map its communication buffers before boot.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alok Kumar <alkumar@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs                  |  11 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs      |   1 -
 drivers/gpu/nova-core/vgpu.rs                 |  24 ++-
 drivers/gpu/nova-core/vgpu/commands.rs        |  35 ++++-
 drivers/gpu/nova-core/vgpu/fw/commands.rs     |   2 -
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs |  12 ++
 drivers/gpu/nova-core/vgpu/instance.rs        | 138 +++++++++++++++++-
 drivers/gpu/nova-core/vgpu/vram.rs            |   1 -
 8 files changed, 202 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 962a6a3f4d29..031878cdb626 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -401,8 +401,8 @@ unsafe fn new(
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
-    /// Drops before the MM and BAR1 mappings needed for instance teardown.
-    #[uses('bar_user, 'chid_pool)]
+    /// Drops before the MM, BAR1 mappings and GSP needed for instance teardown.
+    #[uses('bar_user, 'gsp_resources, 'chid_pool)]
     vgpu: Option<Pin<KBox<VgpuManager<'mm>>>>,
     /// GSP event interrupt registration, and the enable of its subtree.
     ///
@@ -614,15 +614,16 @@ pub(crate) fn new<'a>(
             },
 
             vgpu: {
-                let info = &gsp_resources.boot_result.static_info;
                 match gsp_resources.vgpu_state {
                     VgpuState::Disabled => None,
                     VgpuState::Enabled { .. } => Some(KBox::pin_init(
                         VgpuManager::new(
+                            dev,
+                            &gsp_resources.get_ref().gsp.cmdq,
+                            bar_user.get_ref(),
                             mm.get_ref(),
                             chid_pool.get_ref(),
-                            &info.fifo_engine_list(),
-                            info.vmmu_segment_size,
+                            gsp_resources.static_info(),
                             TOTAL_CHANNELS,
                         ),
                         GFP_KERNEL,
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index d9dd4841566f..362db885bc0c 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -335,7 +335,6 @@ pub(crate) struct FifoEngineList {
 }
 
 impl FifoEngineList {
-    #[expect(dead_code)]
     pub(crate) fn gmc_ids(&self) -> &[u32] {
         // PANIC: The type invariant bounds `count` by the array capacity.
         &self.gmc_ids[..self.count]
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index eaff5b8b318d..e1dbd46338a6 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -21,8 +21,15 @@
         ChannelIdPool,
         Chipset, //
     },
-    gsp::commands::FifoEngineList, //
+    gsp::{
+        cmdq::Cmdq,
+        commands::{
+            FifoEngineList,
+            GspStaticInfo, //
+        },
+    },
     mm::{
+        bar_user::BarUser,
         SharedGpuMm, //
     }, //
 };
@@ -129,6 +136,9 @@ pub(crate) struct VgpuManager<'gpu>
 struct VgpuManagerInner<'gpu> {
     #[pin]
     instances: Mutex<VgpuInstances<'gpu>>,
+    dev: &'gpu device::Device<device::Bound>,
+    cmdq: &'gpu Cmdq<'gpu>,
+    bar_user: &'gpu BarUser<'gpu>,
     mm: &'gpu SharedGpuMm<'gpu>,
     chid_pool: &'gpu ChannelIdPool,
     /// VMMU segment size in bytes, or zero if GSP-RM omitted it.
@@ -140,16 +150,22 @@ struct VgpuManagerInner<'gpu> {
 impl<'gpu> VgpuManager<'gpu> {
     /// Retains runtime parameters from a completed vGPU-enabled GSP boot.
     pub(crate) fn new(
+        dev: &'gpu device::Device<device::Bound>,
+        cmdq: &'gpu Cmdq<'gpu>,
+        bar_user: &'gpu BarUser<'gpu>,
         mm: &'gpu SharedGpuMm<'gpu>,
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
             inner <- pin_init!(VgpuManagerInner {
                 instances <- new_mutex!(VgpuInstances::new(), "nova-core::vgpu-instances"),
+                dev,
+                cmdq,
+                bar_user,
                 mm,
                 chid_pool,
                 vmmu_segment_size,
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index 66669948230a..b384c190a66a 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -10,13 +10,16 @@
 
 use kernel::{
     device,
-    prelude::*, //
+    prelude::*,
+    time::Delta,
+    transmute::AsBytes, //
 };
 
 use crate::{
     gsp::{
         cmdq::{
             gmc::{
+                CommandPayload,
                 CommandToGsp,
                 MessageFromGsp,
                 MessagePayload, //
@@ -124,3 +127,33 @@ pub(super) fn query_vgpu_properties(
         Ok(properties)
     }
 }
+
+/// The `BOOTLOAD_GSP_VGPU_PLUGIN_TASK` command, which carries NVKV-encoded parameters.
+struct BootloadPluginTask<'a>(&'a [u64]);
+
+impl CommandToGsp for BootloadPluginTask<'_> {
+    const COMMAND: GmcCommandId = GmcCommandId::BootloadGspVgpuPluginTask;
+    type Command = ();
+    type Reply = ();
+    const MAX_REPLY_SIZE: u32 = 0;
+    const COMPLETION_TIMEOUT: Delta = Delta::from_secs(10);
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        pin_init::init_zeroed()
+    }
+
+    fn variable_payload_len(&self) -> usize {
+        size_of_val(self.0)
+    }
+
+    fn init_variable_payload(&self, dst: &mut CommandPayload<'_>) -> Result {
+        dst.write_all(AsBytes::as_bytes(self.0))
+    }
+}
+
+/// Send BOOTLOAD and check its firmware status.
+pub(super) fn send_bootload(_dev: &device::Device, cmdq: &Cmdq<'_>, payload: &[u64]) -> Result {
+    cmdq.send_gmc_command(BootloadPluginTask(payload), |_| Ok(()))?
+        .map_err(|_| EIO)
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index 666c549e55b1..a8b80bd6d33b 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -52,7 +52,6 @@ pub(crate) struct ChannelMapEntry(u64) {
 impl ChannelMapEntry {
     const KEY: KeyId = 0x1001;
 
-    #[expect(dead_code)]
     pub(crate) fn new(engine_type: u16, index: u16, chid_offset: u32) -> Self {
         Self::zeroed()
             .with_engine_type(engine_type)
@@ -125,7 +124,6 @@ pub(crate) struct BootloadInfo<'a> {
 }
 
 /// Encodes a `VGPU_BOOTLOAD` request using the typed NVKV schema.
-#[expect(dead_code)]
 pub(crate) fn encode_vgpu_bootload(info: BootloadInfo<'_>) -> Result<KVVec<u64>> {
     let request = VgpuBootloadRequest {
         dbdf: info.dbdf.into(),
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
index 983d5002ff5b..310230702562 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -10,6 +10,7 @@
         io_project,
         io_read,
         io_write,
+        Io,
         Mmio, //
     },
     num::casts::FromSafeCast,
@@ -137,6 +138,17 @@ pub(super) fn plugin_logs(&self) -> Result<PluginLogRegions> {
         })
     }
 
+    /// Clear a previous boot marker before starting the plugin.
+    pub(super) fn clear_plugin_ready(&self) -> Result {
+        let seq_num = io_project!(self.view()?, .control.__bindgen_anon_1.message_seq_num);
+
+        seq_num.write_val(0);
+        // Complete the posted clear before firmware can publish its new marker.
+        seq_num.read_val();
+
+        Ok(())
+    }
+
     /// Return whether firmware has published the plugin boot marker.
     pub(super) fn is_plugin_ready(&self) -> Result<bool> {
         let value = io_read!(self.view()?, .control.__bindgen_anon_1.message_seq_num);
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 68c93418cc26..6df3d9ec8dde 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -7,19 +7,37 @@
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
+    gsp::{
+        cmdq::Cmdq,
+        commands::FifoEngineList, //
+    },
     mm::GpuMm, //
     num::FromSafeCast,
 };
 
 use super::{
-    fw::commands::VgpuProperties,
+    commands::send_bootload,
+    fw::commands::{
+        encode_vgpu_bootload,
+        BootloadInfo,
+        ChannelMapEntry,
+        VgpuProperties, //
+    },
+    gsp_plugin_comm::CommBufferRegion,
     vram::{
         VgpuVramLayout,
         VgpuVramSlot,
@@ -29,6 +47,49 @@
     VgpuManagerInner, //
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
+fn wait_plugin_ready(dev: &device::Device, comm: &CommBufferRegion<'_, '_>) -> Result {
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
@@ -51,7 +112,6 @@ pub(super) fn new(gfid: u32, total_vfs: NonZero<u16>) -> Result<Self> {
         }
     }
 
-    #[expect(dead_code)]
     pub(super) const fn get(self) -> u16 {
         self.0.get()
     }
@@ -77,14 +137,72 @@ fn from(properties: &VgpuProperties) -> Self {
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
+    fn activate(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
+        let dev = vgpu.dev;
+        self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
+
+        Ok(())
+    }
+
+    /// Bootload the GSP vGPU plugin and wait for its BAR1 ready indication.
+    fn bootload(
+        &mut self,
+        dev: &device::Device,
+        cmdq: &Cmdq<'_>,
+        fifo_engine_list: &FifoEngineList,
+    ) -> Result {
+        let fb = &self.vram_slot.fbmem;
+        let mgmt = &self.vram_slot.mgmt_heap;
+        let logs = self.comm.plugin_logs()?;
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
@@ -195,14 +313,17 @@ fn allocate_instance(
         let vram_slot = vgpu
             .mm
             .with_locked(|mm| self.alloc_vram_slot(mm, vram_layout))?;
+        let comm = CommBufferRegion::new(vgpu.bar_user, vgpu.mm, &vram_slot.mgmt_heap)?;
 
         Ok(VgpuInstance {
             gfid,
             dbdf,
             vgpu_type,
             vm_pid,
-            chids,
+            num_plugin_channels: PLUGIN_CHANNELS_PER_ENGINE,
+            comm,
             vram_slot,
+            chids,
         })
     }
 
@@ -232,7 +353,8 @@ fn create_instance(&self, info: InstanceInfo) -> Result {
         // Reserve capacity before acquiring resources so registration cannot allocate.
         instances.instances.reserve(1, GFP_KERNEL)?;
 
-        let instance = instances.allocate_instance(self, info)?;
+        let mut instance = instances.allocate_instance(self, info)?;
+        let result = instance.activate(self);
 
         // Register live instances, and failed ones whose resources firmware may still own.
         instances
@@ -240,6 +362,6 @@ fn create_instance(&self, info: InstanceInfo) -> Result {
             .push_within_capacity(instance)
             .map_err(|_| EIO)?;
 
-        Ok(())
+        result
     }
 }
diff --git a/drivers/gpu/nova-core/vgpu/vram.rs b/drivers/gpu/nova-core/vgpu/vram.rs
index 77446b2bdceb..fb7c460b9d97 100644
--- a/drivers/gpu/nova-core/vgpu/vram.rs
+++ b/drivers/gpu/nova-core/vgpu/vram.rs
@@ -76,7 +76,6 @@ pub(super) fn max_slots(&self) -> u32 {
 ///
 /// All device accesses and mappings of its regions must end before dropping the slot.
 #[must_use]
-#[expect(dead_code)]
 pub(super) struct VgpuVramSlot {
     /// Framebuffer VRAM region.
     pub(super) fbmem: VramRegion,
-- 
2.53.0

