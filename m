Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528941;
	b=bPNguyd8K03IdQ7VamdZy77ys/BIF+g++yGL2d3Kts/Wm2tg1T0FOyaKuzuNyyNwEs8X
	 HwZFSS8zwIsD5zoal1WWGJCO7UgQ33odbqht6PyK+5SkeXqKXtBiunEHNENNxadrWslpn
	 5RArEPqXELFF4fCFSU9h3SEl2e/OSZ0MbRFYcQnoSU2rqJ9BI/XnONtW2NV7s795b5eP5
	 3bWSXdI2sHoCwS3fDVWEfQ1yzCtj83Ca9c7L3dwSwTCePQr8uAF2sP9P9mm/F4+L9XH6V
	 Bok2c+c/rvWITUStv7eSwf4ET48jEHfLKSGVhUMbEdo+oDvHuvNaVDDbzPDcUlIwEdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528941;
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
	bh=Fd1zPqNHgS+4Ga0VXPuo70dNx4D9OFdqAG8YSx8oBfk=;
	b=fvIYtsamlzufV+9uSLSOj4jzjhC6aVRNZAU6m0+VUFSmDDGiJFtImiNz8ZAll4mnCtJN
	 zLvindtkREldCPnGyR4YVVmdHhioxYzVysWKJZScsDzT+nQO1G6bBdjG95tObb+RoHP7o
	 ZZuVh3+jOlWuo+NmTPVeflAuD1Y/rzn5DpoSF/Uz+zPOs7tNvMBmEHgjQBqdqAMwJJx99
	 ZMwPIeKlbH+eN0fbv65cbZLCVWvEagUwcHyjMRXFj+fJQHDgoxBDJ/HHZReWp+WUkxqy0
	 +sbE0o82l292i/918C+yhU/7v0mFIHZm840zr/L4SZ2FF2JgvTN2yHsR6cGwaP5kjww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HmmbuALX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC5606A327;
	Tue, 24 Nov 2026 14:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31FC5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HmmbuALX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMdqZ8MUgvXBp7QJRHFzCgkGds5HXDjgnX/cXImMoZXjpZfuXsUdAFgXS1E7+G94fpZE5MUiAcnUyJkic/vZ24aDTBExtekERDuE8Tv1Ay4X4IF/NeUp2Ny3OhyMq+KdNkvpgL5Zr7QP+B4LxHSNkIi/krQKh59o6PfjkFmq4osyAalosGOf2Mn40IQsvuy1L3fPBzCktn6SpgjStEqMtixNan4WLhwDo3ux8QvHuesytMJvcUE/XkeMdws8jFbkRPGxkVdmAJgZ7z4XX6tou2AauVvhZV8X20SgUqYbTwhGFDZlEpp5s1E5KLys4y95jOXErQvZXTsM6VtuTvydGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd1zPqNHgS+4Ga0VXPuo70dNx4D9OFdqAG8YSx8oBfk=;
 b=YVAHiSInGrMGy1gx/PKkqXvPxmmW3evzBjgHXk/saYPkpabvpqA03S5tSR0gfg+9gLtGi8Z8NrsHmvunkEGYNaFePH6v0EKnSUZyZj7P4KEi0B3XK34G3mqisKEY/iIvW8zrbIZHiQGcoONtACzbaahhp0PTRKKh2WtRXPpxWOrz2UjPqLtSLxI8aC+ZQLQJ/n5to80h8QISx8a30vUOLXXCwUecg57O0vkxHm9O994kh9YEx4EF0ICXu2Tw/UiaC+/X7SX+2BhFLdULJq5Z80TyZZYU5A9X/qKOJIz+sLgrNAqYPwneSAeulR6vmztHflmui8v/KSaJXuIoq1wefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd1zPqNHgS+4Ga0VXPuo70dNx4D9OFdqAG8YSx8oBfk=;
 b=HmmbuALX2GA5y6CdXYz1IJVschXlo5K8klSakaDwAIph47kiNEpMEcq86FHRlh8mtiVvdhTZqab+iuNCQQ3JSorwHlXpaqE9MQGK64lsKF76h/+AVoos8XLhTqMgItpUNYS4S9tUmQwEjXpI7mVRNIMq4dohKizXCMJjoaRrB/Xs9qxf/Og7QyB29HttUA5oR2U3KIwQWtHBsI3/e4snZ6qv5brDYkrGG/WhI+riv1K54EvGTjEYi9YgzVShQlvj3ImTAbBvGPmp70Sk5sT80kLAC4oy0aqeTC32DxnDxtMxPHk+zL6lFI8nncbXn6ZWp1y2qvWMKfikzErF9RvV6g==
Received: from CH0PR03CA0412.namprd03.prod.outlook.com (2603:10b6:610:11b::24)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:01:33 +0000
Received: from CH2PEPF000166BA.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::a7) by CH0PR03CA0412.outlook.office365.com
 (2603:10b6:610:11b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:01:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166BA.mail.protection.outlook.com (10.167.252.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:01:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:01:03 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:00:50 -0800
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
Subject: [PATCH v5 04/35] gpu: nova-core: vgpu: detect boot state independently
Date: Tue, 24 Nov 2026 19:29:00 +0530
Message-ID: <20261124135937.18583-5-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BA:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5d0780-87c6-4bf5-ccfc-08df4a33721f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|261026140227099003|11063799006|261021123027099003|261009223027099003|10067099003|261021121427099003|261102123227099003|56012099006|261028144727099003|261022105027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nnro/znoPi51qtdkm3ZUFP4nb1N3iOM1S4Om1P8QTfo08zs845iu1Uy2EyorvWGcrrvOQKq4DujwYf1e9p5whbT8ZLcRHtGCL0Z8Y3vEM7qGtySm0lmVtFzA+BFLBWhpfA/mfxBcHx8y0hGKyTasd3yS0BQ+qvssjnS4H4tdYpb8GznBsQglHYYeenEVLB0nXgE9u/za0jyfhOQC7EiJ/vIATCOVr3YZ/25pTnx58YpmkDsRXjVhRMjti42S4e/8YG9ZogYPPq6L5klIps2pgrE+7moXPKCR6dly3/sP4Ii83xfEwRNAQZS+0dhD3XG19I4JaSHH3soHJqAVdcdkVrRXjIZQedN9toe2dPYO/AxuWX4XSpoTveiy+Hp2dlJOi3METcJ2t5R5I53wDtLpShQLNjBbFlR6nQg3Wjt464S96Qzi0A9N7/j62tCaRaDvnBladlYQtam6HIL7fEkqDvQsdrsPA/HcF9mAAx56wWP53IIabI2nOgwkYl67vw/fzezu4b50TsD9eSrY7GiCE6xtGMFoa372zStG23ZVCIKTJAR8Pz7Dwo7msNYjK4gn4BhNKHFqxmVH0UI17tcQExCyHuRLIk//nxyWKdMEgaWMlKkkglM730DV/tJe+6RTy/eBdz+tYmJMrcyrTfuyTV7H/4vByRYZXv/hsSSR5a7SI+99cqd0mOSYtEwhykyM2DH5fDT3u0Iqj6M3fFJEEA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(261026140227099003)(11063799006)(261021123027099003)(261009223027099003)(10067099003)(261021121427099003)(261102123227099003)(56012099006)(261028144727099003)(261022105027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OsPs5llGyQBlKY86J7U43qeShjCV66dAMqxhvlzEhfK6qZxrA3wQNoJ3EZxuISuBPB8u9QX/Uovr+ARc5m07Af8mgmcqM8dLi644/7z06I+5YtxaY9vAyMYJ4cYJs4senwbe7H54TDXwQbk7zZEyslfCh2yr0peEfMWUpI6wMHdD3v3xb8jOAyrOV2Vd9FJhPHwSR27Pfr/o4DXfBW6+XHnn86Sx9r2qw+QGMTwhUnaN8eZBBDS0hBi2W2QyP3hgFUmJm9dq96XTgtFmp5XuErnDM7HFeMIjIDOkuTn9A9jPMNQqAVv2mrDeemEjEGqsd4LBbKRxs9LOFVugyE9/az3l2lPsTELMVNTKp4OAuOsy5Wzc3jP/P8ocBA0iBPGuSRtL+1YZe5Z+GkyQ2H0N8gEcn9OMsDeOkb5jcjY8Uhnjza7BjpLpHknaHkgG+cw+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:01:32.7183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5d0780-87c6-4bf5-ccfc-08df4a33721f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163

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
index ad200242f0f5..5c304a129df2 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -53,7 +53,7 @@
         Timer,
         TimerState, //
     },
-    vgpu::VgpuManager, //
+    vgpu::VgpuState,
 };
 
 #[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
@@ -335,8 +335,7 @@ struct GspResources<'gpu> {
     fsp: Option<Fsp<'gpu>>,
     /// Timer state - contains system timer offset
     timer: TimerState,
-    /// vGPU state detected before GSP boot.
-    vgpu: VgpuManager,
+    vgpu_state: VgpuState,
     /// GSP runtime data.
     #[pin]
     gsp: Gsp<'gpu>,
@@ -443,7 +442,7 @@ fn drop(self: Pin<&mut Self>) {
                     gsp_falcon: &*this.gsp_falcon,
                     sec2_falcon: &*this.sec2_falcon,
                     fsp: this.fsp.as_mut(),
-                    vgpu_state: this.vgpu.state(),
+                    vgpu_state: this.vgpu_state,
                 },
                 bundle,
             )
@@ -502,7 +501,7 @@ pub(crate) fn new<'a>(
 
                 timer: Timer::setup(dev, bar, spec.chipset, fsp.as_ref())?,
 
-                vgpu: VgpuManager::new(pdev, spec.chipset, fsp.as_mut()),
+                vgpu_state: VgpuState::detect(pdev, spec.chipset, fsp.as_mut()),
 
                 gsp <- Gsp::new(pdev, bar),
 
@@ -516,7 +515,7 @@ pub(crate) fn new<'a>(
                     gsp_falcon,
                     sec2_falcon,
                     fsp: fsp.as_mut(),
-                    vgpu_state: vgpu.state(),
+                    vgpu_state,
                 })?,
             }),
 
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index e074a8294d36..c59e7d2f933c 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -31,19 +31,16 @@ pub(crate) enum VgpuState {
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
@@ -52,12 +49,11 @@ pub(crate) fn new(
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
@@ -84,9 +80,4 @@ fn detect_state(
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

