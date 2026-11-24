Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528896;
	b=gqF38XDSY0xX2akUbbxDPCeaYpejpoBsKGRF/+Q5sW+fEVbSbyqJWyW9BCgnStbikV6y
	 hl8FZUtkdbUuwFwodzH4CjodfUvLcyL4FCRObMi/ENfkv64VxtT85pBO2DKPXv1KOJvnL
	 Ai1tqQ+nLj4R2s62kQtHuSyPoR+LNYQMHixIXfxi70mKQypvY4WDKDFTXptnfz0YG3s5m
	 iVSE29tKJpYzyJFD1tE0zZx4PCsXu4EInHzg/UYWKnEyeGoYLmryxLeou60Pjq0HstECo
	 TJk6Vk8GGZ18JyPUWqyO7p6KY0bNn71WgoQaoYnjG3XqJW88y1roer1rPmMtFgDTFiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528896;
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
	bh=wbug7Qw2EgWOcnjq10RWg188L8zdjfZucdk5OKMjsaA=;
	b=Vpm4zCFrc0J2VH/xzl1V0+pfv3DYx+Xkqi2IzMqvDtkWe8C3jEURaypEIPLTv2OlsL7L
	 YTaM8uR+ZOHc+8TNI8I5rxZ7O7kowsItZxNNl+OIwV7NAXuaDg1rbWiIObO59gnTvEe7D
	 guRM86fAZmUNrcUg3yGzB9RXPi1mimx824vsEMPx2ng2VvMV1xcAX23JRsTcS3JOvEsJI
	 GO3ZEKkFgNifzzq2G4Ks8wWY+3p1GK6Cx9GkYJSnte1FpDX457SzIeBQsuGxWqlS8uhii
	 PsTmkXyQ37U0lhmIpFHeRRjZrP5h+uA9ySn8OWdDvBmN1sksOF+GaWC0/ufAouRqxgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QFjoa0ye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.10
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94483606A321;
	Tue, 24 Nov 2026 14:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94483606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QFjoa0ye
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE5SK0CCtcgLMCh5OijdOqfnf/tBQ9njotMMRcIG4kvPyrdGpLtLUw3E+ySAUKAUIVuw0hZFaKb3Uei8+QPQRRRUBDNcGbSNtzRf1VDa9GQ5LwZ/3hqXl0l2Y1gQIsxPm0Joo7df48VuJDQ1+ezO7FKUEB4rjFWYHb9gNDOGr7fHO63nCU1ERr1ycowLswFH+20M1ZE7+vEVKtmZWHsn7i6poJ7L7RRTaG/lLX01jTbH3pJmRoiFh7EclADSv/ayb5K5RKqzNg1yG7gEYoHWJNJEP7LhpSesTfB/Hz96fYr2pi+Oox8sm8tfI/6YbcJmCc/UZdkZcAR0PuN1+uGYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbug7Qw2EgWOcnjq10RWg188L8zdjfZucdk5OKMjsaA=;
 b=Z1usglUbYXW3GDTi/UGjl/dFSQ7cq1Yx5VkojIAAdYRBGL0Lfa1eoDIL05h3yGRrORj6x3c25gRxEvG/R4cV/ZJOXepUcV5ycQsOxUU6Erc+clEhTK99D6FxSWtcDRdwHbSExnliv7Clo7vvFuJLSD8ndimiyDXXsYkdLQm1A6P2/QesnY7yJNio4RwzVG69Bk+7C1DOtviSaDcZXnO35B1i8yzxzHlORAvdOJdue/bnaz2kGUu0TNK+rwa/ZrDm7Jg2CR43ffdBOXhxpEVm390BKHWBOHH0fDhJsiYlW17m2CBLmZ7ERJXiUHKO3ouOR48UKMFo6CzzqJNaNdOh0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbug7Qw2EgWOcnjq10RWg188L8zdjfZucdk5OKMjsaA=;
 b=QFjoa0yeEbxQjMsI988swVlbIjt6L8T2sOngXu5iagOd6je2J4OKqJe5dWD1p02ca+tn7tqFXC/MbF/4yGK82b3DErMh4GqjtZWccd9FE1ARvbwb8Bp326nRqGxHtHnKVj+P4/UgDvmU0NuawOnH8EpYDUiUPdfwVu5hiDXTLqOphahw5LiuylahZsAUQm+BT900lqnmx/o7+862mPzJmR4Du5DfmstYVP3x1YZh6EjnQ2q8s5FirYDEigFz89/Zcl0Boa5TmL4saO7zDPvFVkK3CGDKq47JKRDaPQkJfmLK5WTLlN3ongq7dVk2NsYUQCz4gRC2HtP/sDr6MGcdhQ==
Received: from CH0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:610:cc::14)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:01:20 +0000
Received: from CH2PEPF000166C0.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::b) by CH0PR03CA0069.outlook.office365.com
 (2603:10b6:610:cc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:01:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166C0.mail.protection.outlook.com (10.167.252.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:01:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:00:50 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:00:37 -0800
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
Subject: [PATCH v5 03/35] gpu: nova-core: gsp: decouple boot context from VgpuManager
Date: Tue, 24 Nov 2026 19:28:59 +0530
Message-ID: <20261124135937.18583-4-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C0:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: b5cc805e-930f-4bf9-ef63-08df4a336ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|261102123227099003|261021121427099003|261026121527099003|261021123027099003|261022113327099003|11063799006|10067099003|56012099006|18002099003|22082099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Zi9ucnDKS7/grjpQVVx3gEo6s/D4hSAa53QSMjlIKs5ItsGLfXP927E/t2hrTeFsH2B9qu2MTuUNjBoUtGCbf+yGfgXCmHrsrg1DbRBKRnCUojVphRkyXnI4t8MWc3gHr04eXhjcW319eTsKeovnPd7akKmFyVQzOMbWJlwqSvO28UCh7lye4V8x0CfqPHFGIclTO2Z9ng7la4EUH7xsgUC/KVTny+CLWhy5K41otA8oIuagrYGFIhqsoS27pn8y0baiZiAaa0SiWICr1fdyCnRL3dDOuwS45PI76bAiPfWYaD1voa9A27tayqc8crK1jRFSQeOvZQM59HNIFXQmlBZs97cuUJZM1UNhhVMPL7mEd9DFLuhpbm3L/MbFUm9tYxsuWfcaTKqIEJ2Q9gcQsk/del5B5TwlUPj+K3Hv4l3BEJQ4RZt0Y7gXE7XZg45y63Ev9lhjll2qscylT+e8IbQecgEShx8gNCuxiUnx5rNr1S499JNqrm1qDG0o8YzHwiHBhNmWvvxesWVNr9F5j91PUN/s6poZMHZANIr/zibtvOTJqtsvwGpFWDS9537YzFTSynw3/IaIZFibf+ZgC1LsPfwb3P1Uvk4yp++wMLiRRCP0TEIrzcT+4cB9UWuGSBl1N29nQaBThXiyx1pp/SYHgQ8N2sfcKQ+3NyQIvCMTauiFMIHceVrbQ5mOeN40FTZErtosFiqc4HH0339wZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(261102123227099003)(261021121427099003)(261026121527099003)(261021123027099003)(261022113327099003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YJylNeOYt7ZSF9KOyksclVss4JvMufSb6oh4fr4cmR5S93kOORFlatdD4CpC/oGbVYcNTp2F01hsjWiQeQFdLSVxPXvM8AzBZL0itQ2QDfFigh2f7OkQdWK2TznV09FoTHnGM5HYyavKUV9PtI7VMTI9I0VBWqlAzvoj/5fdoqu2hiClBlDz0B7+SUVU9P8AVYav2w2q1vdy2bEds74CbZ/tU0YIUAKJncQivXf0nxc6b5W6biWjHR3uvhysLntt5uF3rjl4dGquI3njIayaLu6uozyr1Lo8Ef8yAITbIySOpjkXNZwhH6fV0D6OV0zCzzCdNxSTzgS8s2cuIoP5JG86qfqoz9nKydlRA8IPK5hk0ri6bEmiC7ZaWw0FrJrDvSXrVFni2Zu2QeumvuQqhU6YmhQHxOK3HaaYjwD1CUdv4jkB15UKmwQ+SzTa8CJi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:01:20.2596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cc805e-930f-4bf9-ef63-08df4a336ab0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

From: Zhi Wang <zhiw@nvidia.com>

GSP boot uses the detected vGPU mode to size firmware resources and
populate GSP_INIT. Carrying the whole manager in the boot and unload
context couples these operations to its runtime interface.

The boot code only needs read access to the mode, and unloading does
not use the manager. A short state borrow is sufficient for both
context construction sites.

Make GspBootContext borrow VgpuState directly and read it in the
VRAM and GSP_INIT helpers. Return a state reference from the
manager without changing mode detection or the values passed to firmware.

No functional change is intended.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs              | 2 +-
 drivers/gpu/nova-core/gpu.rs             | 4 ++--
 drivers/gpu/nova-core/gsp.rs             | 4 ++--
 drivers/gpu/nova-core/gsp/fw/commands.rs | 4 ++--
 drivers/gpu/nova-core/vgpu.rs            | 5 +++--
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 26e94d908b77..882827bcfd3a 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -295,7 +295,7 @@ pub(crate) fn wpr2_range(bar: Bar0<'_>) -> Option<Range<u64>> {
 
 /// Computes the number of VF partitions and the WPR2 heap size from the vGPU state.
 fn wpr2_heap_params(ctx: &gsp::GspBootContext<'_, '_>, fb_size: u64) -> Result<(u8, u64)> {
-    Ok(match ctx.vgpu.state() {
+    Ok(match *ctx.vgpu_state {
         VgpuState::Disabled => (
             0,
             gsp::LibosParams::from_chipset(ctx.chipset).wpr_heap_size(ctx.chipset, fb_size)?,
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 3d693656a5d6..ad200242f0f5 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -443,7 +443,7 @@ fn drop(self: Pin<&mut Self>) {
                     gsp_falcon: &*this.gsp_falcon,
                     sec2_falcon: &*this.sec2_falcon,
                     fsp: this.fsp.as_mut(),
-                    vgpu: &*this.vgpu,
+                    vgpu_state: this.vgpu.state(),
                 },
                 bundle,
             )
@@ -516,7 +516,7 @@ pub(crate) fn new<'a>(
                     gsp_falcon,
                     sec2_falcon,
                     fsp: fsp.as_mut(),
-                    vgpu,
+                    vgpu_state: vgpu.state(),
                 })?,
             }),
 
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index a69362138cce..efb94aad417a 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -50,7 +50,7 @@
         fw::GspArgumentsPadded, //
     },
     num,
-    vgpu::VgpuManager, //
+    vgpu::VgpuState, //
 };
 
 pub(crate) const GSP_PAGE_SHIFT: usize = 12;
@@ -69,7 +69,7 @@ pub(crate) struct GspBootContext<'ctx, 'gpu> {
     pub(crate) gsp_falcon: &'ctx Falcon<'gpu, GspFalcon>,
     pub(crate) sec2_falcon: &'ctx Falcon<'gpu, Sec2Falcon>,
     pub(crate) fsp: Option<&'ctx mut Fsp<'gpu>>,
-    pub(crate) vgpu: &'ctx VgpuManager,
+    pub(crate) vgpu_state: &'ctx VgpuState,
 }
 
 impl<'ctx, 'gpu> GspBootContext<'ctx, 'gpu> {
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 9ecab9418be4..1b2cd342c404 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -246,7 +246,7 @@ fn new(dev: &pci::Device<device::Bound>) -> Self {
 
 impl GspInitRequest {
     fn build_vf_info(ctx: &GspBootContext<'_, '_>) -> Result<Option<VfInfo>> {
-        let total_vfs = match ctx.vgpu.state() {
+        let total_vfs = match *ctx.vgpu_state {
             VgpuState::Disabled => return Ok(None),
             VgpuState::Enabled { total_vfs } => total_vfs,
         };
@@ -286,7 +286,7 @@ fn build_vf_info(ctx: &GspBootContext<'_, '_>) -> Result<Option<VfInfo>> {
     pub(crate) fn new(ctx: &GspBootContext<'_, '_>) -> Result<Self> {
         let dev = ctx.pdev;
         let chipset = ctx.chipset;
-        let vgpu_state = ctx.vgpu.state();
+        let vgpu_state = *ctx.vgpu_state;
         let mut regkeys = KVVec::new();
         for &(name, value) in REGISTRY_ENTRIES {
             regkeys.push(RegKey::new(name, value), GFP_KERNEL)?;
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 6b7e045acea8..e074a8294d36 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 use core::num::NonZero;
 
@@ -85,7 +86,7 @@ fn detect_state(
     }
 
     /// Returns the detected vGPU state for this boot.
-    pub(crate) fn state(&self) -> VgpuState {
-        self.state
+    pub(crate) fn state(&self) -> &VgpuState {
+        &self.state
     }
 }
-- 
2.53.0

