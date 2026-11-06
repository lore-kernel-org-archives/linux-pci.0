Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943737;
	b=moDVrJQhoCkD1ked1EuvrL52fwmRC02iwgnrGPRJCObe7bd/YV9g5RsdhZyBJHxukMxO
	 2INTjBW/dtU1Gs7DcsGVwgO/2l7oEqnnhopx5C2BgwVH6aUNkxE8TX+H0v/PhjCvN0JHb
	 unuhVlm7IQt3V7sfXtSF5TJPokyIurufKxBJ7O1xOJqrnymmkZpwEosINCO9+CGAcZmtE
	 eTFr1CVekcEY7z3mET11jFSC5zVDE6cH2VIniHg1Lj/58TnDOAxBgE5AVkFDtMCFmgFc8
	 21iBM1PF3f3KPANQ2l0pVKkztHT9KujFWdAKyFU58NB4pcI1jRFs7xwW3xjH8XnJzpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943737;
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
	bh=ixiAOLkJ822ycatpp052YT9uZr/H1VpyZlw+JNFk/2w=;
	b=oAuxmkFL3TB4ztoHqF2kJcsCKcWIKTlza5l8l5oTrT6zLHIOZAw/yjHmv1o9QGMxjUsS
	 o9PY49dxLHwhjRVd8C7WnwQoZTchuOoh2ADp8ZXoGVuoB8e8z1sSEhYPgKl3GMksC1DkV
	 ipy/qptHl2O9yYT4FhYCah1mO1AiNC7S7w8kl0NbVcfpjYAEVE0oxhxGJAJc6UEAx6Tn5
	 b5bpmLaJ3O6tsFb22oxn3RQhVM5Q03/ojmjSvSN3CiAskQNj/FZWvxJqUL2Kz3h7lB6EP
	 1HhU8KfT3amj71sCY6hjwA3MU4ZVPt6FHHBTaGl5AdedvCTgamNnYbYufWQkyVksHBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="V//kGQKT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.3
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF55606A328;
	Fri,  6 Nov 2026 05:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF55606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V//kGQKT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZdx/8+3lNf7lqxu+txgTlVoHShmJbKMxn/oypBfbwJ/1mbNUbl4EognFaGuhexj/iilnamSvFOIvgqhX3J+ZnkJzRYZiGbStHNnTnm3r2ypqX7w1GUhnpPOdaSp/gy3xslXNdDfqOBUaq7767Jg3mNAcVUbJQ124osWd+OaH4AW6feh74S8cA4jhzp9gbvNE1LpKMDRMRYZ4nxkvztLg6wQ660yGXYWor17rnLksa0CF5uQCkBoCrB3X/nT/fr3DEEMEGlLYyfFXPIE+dDb1Vohs2z9EqmDWRrlhnZiX+9ST7r6RO7T0jZfexLp91D2OpYgeLnQtO5KqYrlJFXczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixiAOLkJ822ycatpp052YT9uZr/H1VpyZlw+JNFk/2w=;
 b=mLiEQ2YZIG/U/RyCnEmA61rVpAE7grpIqTdPWxIPgnwW4eN9AqvDu21qTF+oAu7nV6HvgrgKwXDEJQzRKu5LheQylta6QpQ8t+1K20iGsLGFbaTaG80TnaZAVt5s4fdeueZ/i5Mq+2dVdX8KbkI9lW958TOxqDoQTPDXlSdnYOqzFjB/cKt2H9+V24ucpeUrJQzonZX9Yug/CQw4KG0MGL4IHE70owcQo09oSAphIPWV/vZuM0D/UbI3dSob3m1CbcRGT5YfyVDRDdZtlt0XLx6db/L7PE2QlAYipuJcn6DmgprQEzYm+3XwJgJVcXQN5M/fjBxMWmD71qx3R8x09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixiAOLkJ822ycatpp052YT9uZr/H1VpyZlw+JNFk/2w=;
 b=V//kGQKT2YaAX+yTXrcnR+RCWGwQsZ8kJk83EG2DFRof0iZo1cHbSlgxONbFajfLsgATbYv8gOQ28ThO581IagGgYOdeuwQcT81a/6yhAz5x4YEJhGiLWy55a9g1xPjiYDJY4uOs0971Ra8N5GGvVbyG8TunTQi6w1sNNd7n9O0gqw+fjtPoHYaByM0ALdwFk49OqKGHrQ2R0E8ZpY19kZ0hRmyo323F7+5ppynAjEWttIDpCuirw6Kvp0fV23tgpF+9jIFOYgcVh9bsSCGlpnY/MDJzL5b6RTAt9jCCTYu2bzPAAN88pNHLdZ/M6Eb6YJ293BK9CPNxA0/PXGpjPA==
Received: from CYXPR02CA0016.namprd02.prod.outlook.com (2603:10b6:930:cf::19)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:42:08 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::15) by CYXPR02CA0016.outlook.office365.com
 (2603:10b6:930:cf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:42:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:42:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:41:52 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:41:39 -0800
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
Subject: [PATCH v4 03/32] gpu: nova-core: gsp: decouple boot context from VgpuManager
Date: Fri, 6 Nov 2026 11:09:36 +0530
Message-ID: <e630595f7f1462a254950ea32dff35939deb5cd0.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 55dba5f5-a434-4ce7-b8be-08df3bc8b273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/TKb2wwJA2KJbJViPOmvl7V4E1J06/gl+LZ1iL9bDVxvBXDaf/g52rf2HqMZSOQ7e8utjQ5Z+GqfMvdovuezZ7w1EULFJJwRDgjuVv1nWj9oIHt9OF0RUhiWwQHLPYpnEzQUZCSdCe08/+QBXIw6DfDGR54ubn6itWRfu/NKJxqByms1L6FdNPDemB7jx9B0WSNhqieGs4Ax3GQ42P4OSCDXYwtaCTDh9EZG/l3N+3sKJnUGwvvv6aAZbGh15lxzJeU1KEy2ydb6Ij9h1DbKv4OglpDlZzznX3nAM1grNOEj0WZE/nXC/jbiHWyVzX2d2u3hjn9DhovTzezj9VD/BoeqF+vV1ipAFIpYidHrkGuohN1pvBh4oBuJ2D0OxhgMX4islAFzJd2g0ljCA5Iwv1QrR5bDFUKT0qvF1GAC/gD82CPcHN8Gqqw3rHr0MNfsHrVhmkF8kaE08md8mVYArMNVbgYy76IV5zQ7usQP1utRtAz8wmkI6Bx7+RDxXbs5dKvNV+5hqIHj5lI7e99KavEikG+r2ljwuJ5WlAoAhAwgRq1pb1TMxeaBNK0K7NzvSrxud9lmCfV71IlbGfId5M2j8Xv6HlbCnxtyQvXFeYCjFNtpVJ2FjD98TsUxMSOaR88A+l+t1AA9qbL1MiI7FcnMNekOpMD2Qz70OKgds4Sl948srE7N88trT7hGldxEpRXbQggbLYPY6WYPXQzKMw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e+96eyowp1s7dPguX8BLQORVjmEvBeCxQ3vrcM4ZbZMRM405lXc7VHCUwMiyqeHibYSlG4+pVAnO4+9ypJG02UrWtN3NTQ2foZcj8pjNv2KOoCW+ZdqGYhywWByDLLn/lEHqFFE7Q8DWkkRyKANj7UuI2Fk7NoR115Upn7tKxj7s1yNG6cRgrCuxIOUXXuJ8XRExea00CoYYkE94MiZJYjCnl7sDbNRb2JnclXgsuQzbNF71F40h7Yx411tFM8Y8pBvnnfH22Q8PpsGlzFVXcD4Y3Jk49cE0jCeFSwkp7t5YgqFUcPWsTWILIl7LPLk5Y/0duJqyvwvICvc5TzLr4AWaxA2PaAYpmxCZdOGoUFrXULOfklEJT8kXLKls3TNzDInqIrFEaQUi+LNoXuhMaVsSxoHK5QevO3GnLuwvOmb7ssj4o50xkNWkb4jtgp2O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:42:08.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dba5f5-a434-4ce7-b8be-08df3bc8b273
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

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
 drivers/gpu/nova-core/vgpu.rs            | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

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
index e44f8cd8bdc2..d29e83f50137 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -447,7 +447,7 @@ fn drop(self: Pin<&mut Self>) {
                     gsp_falcon: &*this.gsp_falcon,
                     sec2_falcon: &*this.sec2_falcon,
                     fsp: this.fsp.as_mut(),
-                    vgpu: &*this.vgpu,
+                    vgpu_state: this.vgpu.state(),
                 },
                 bundle,
             )
@@ -522,7 +522,7 @@ pub(crate) fn new<'a>(
                     gsp_falcon,
                     sec2_falcon,
                     fsp: fsp.as_mut(),
-                    vgpu,
+                    vgpu_state: vgpu.state(),
                 })?,
             }),
 
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 9a6065bdac96..cac123cbeac4 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -66,7 +66,7 @@
         fw::GspArgumentsPadded, //
     },
     num,
-    vgpu::VgpuManager, //
+    vgpu::VgpuState, //
 };
 
 pub(crate) const GSP_PAGE_SHIFT: usize = 12;
@@ -85,7 +85,7 @@ pub(crate) struct GspBootContext<'ctx, 'gpu> {
     pub(crate) gsp_falcon: &'ctx Falcon<'gpu, GspFalcon>,
     pub(crate) sec2_falcon: &'ctx Falcon<'gpu, Sec2Falcon>,
     pub(crate) fsp: Option<&'ctx mut Fsp<'gpu>>,
-    pub(crate) vgpu: &'ctx VgpuManager,
+    pub(crate) vgpu_state: &'ctx VgpuState,
 }
 
 impl<'ctx, 'gpu> GspBootContext<'ctx, 'gpu> {
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 689b7417597a..bda6a7ef5ef7 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -229,7 +229,7 @@ struct DomainBusDevice(u64) {
 
 impl GspInitRequest {
     fn build_vf_info(ctx: &GspBootContext<'_, '_>) -> Result<Option<VfInfo>> {
-        let total_vfs = match ctx.vgpu.state() {
+        let total_vfs = match *ctx.vgpu_state {
             VgpuState::Disabled => return Ok(None),
             VgpuState::Enabled { total_vfs } => total_vfs,
         };
@@ -272,7 +272,7 @@ fn build_vf_info(ctx: &GspBootContext<'_, '_>) -> Result<Option<VfInfo>> {
     pub(crate) fn new(ctx: &GspBootContext<'_, '_>) -> Result<Self> {
         let dev = ctx.pdev;
         let chipset = ctx.chipset;
-        let vgpu_state = ctx.vgpu.state();
+        let vgpu_state = *ctx.vgpu_state;
         let mut regkeys = KVVec::new();
         for &(name, value) in REGISTRY_ENTRIES {
             regkeys.push(RegKey::new(name, value), GFP_KERNEL)?;
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 6b7e045acea8..905b3a7331fd 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -85,7 +85,7 @@ fn detect_state(
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

