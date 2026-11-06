Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943725;
	b=4/VbERVUt9di1DBQk/j8p4YsFcG611Xv/z6bCqhicak06BDfqPd6KLFdQ6KCFJbTlf6I
	 HsjgUwNWLnickCUFv3dYG5PiHxT8KluKSNbfR5Zepeg/Kx4sQjtBs6nejBLmgvglqeBjj
	 n1EVWyG2v7HFWqVzqU0OfEOrQh/BejYGQ6MIViM05J9DfyMzvcSUXsQ4cGuM/ykXc5w5E
	 ubH7XHK/xG2vwV2T59KXo4+w6w8cNf16TxOj00bsisb/W/hgWGBkwS+c6T9pVwBgTKifj
	 mawx49OD1dhl1mJq4DGK1wv+FsvqYpIdut9QFw5SvBY9Js0F8hiJ8iAEOX0d5h8jPew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943725;
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
	bh=ktZnCRD+9VuM9z/5VsmOpjCVYtHuybtkI/e3m3qckY4=;
	b=QdVCat7MmLUa74JyuCDGl8fe+o0PY4l97AONp3lXdFdxZ3mpmo6dd56VRPOtKn8eSy0B
	 90dqb1zI+Rsj7J3+zVAG5p91tZlgSFRtd3hzmITdQ5cwWY+bloT9KbYAsLsqcjZ1THL49
	 FCILUEFXTy8KQofsfo3GZXW3id3UNLLuBiySTcaPO9Rzugai3bJu6gnuuH3qTE81XY5/B
	 +hp9A9ZEZ5usMai8JI/HTxviA0nBCb1+1dIRuf3/I2wKDugXkrJZpMiEHsLF1rxMTp7e+
	 CFMNZWxISx6oiD5klgw8RPOTJCw0QWa+e9aKmOhJFBswQ3krjSrMKB9YoYVNWtv7QeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XFBjmmOZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.16
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5C606A326;
	Fri,  6 Nov 2026 05:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC5C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XFBjmmOZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzwtfwdxIIfhCWil5/sZFg7qM8N/mB6Mx38z/oTmNi9xmeQD3E9KIDdK3fuxlaybQL+94WgC+2kap9BUstlkTJotZXqqW2NtQlzraDu9N/rv71H/C61/yS9I8necNhH6GdaNYtOv6pmM26Bhhz1N+wrRMYSYR7INUsGQkEs+jR4byda4QQ4WWEkm/WZjoxOot1xrQ5YKceia4PRlByBaBrxLqLnrgl20ylOeqjvvl/JVPQxSW/OD97JB67RsQspRyLl9j+WockAwxMa+py3rE0PKJ1C4PXeABChDvDnfSoWqwo1/orR8OjIpL87vWzQX6k4+5a89NLqi+TPpRl5o8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktZnCRD+9VuM9z/5VsmOpjCVYtHuybtkI/e3m3qckY4=;
 b=R6psfvasqa+hDYXBq6z71QQjpu4XlHhYzjWVMCIBOyhCHZN+kt+kLxyaxpKxr6xHR+du4u8s0tQ04rWkyxN2Fbp/v2IW2imEj1vAph39ygNJhzo88JBeVObo/zVGs1CM8el4oF4uGSahai0fPt5hyUpK7NA5k7k+CWwUkNsU11df2SMbr3PguLQCB+CQorJat9XX5hV3ITH7z0bQl6lzuvASQJ08gc/5u6hO8qOhn7oNih49sy9/nz7LXfVEuJvz1BvtRiNU/0Cxub87eknGE7YuFr/WrkbKwFXslhFMVn+GQNRMzqg6/VvixL7351Pl+sTVs7hlNn+9WfX842SPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktZnCRD+9VuM9z/5VsmOpjCVYtHuybtkI/e3m3qckY4=;
 b=XFBjmmOZ/EP/6sH/UneEAmI4yLnJi8bPDaDwXNTy6AOH+D37fj/DDdjYbx3aKuKvafv6jcal/8EOR7VlBryp0oG5fGNf5SirvJX7axD+DMV1/76eQk9rPHZd9Mw2G6THN/iX87yRG7h/a/YlsgCAJxI8fNdApLILo7SRrQ1C+4MFiDgZsA0WahsMe1w7wlcDVGfAAgJcb6vCu1ckGEsw1p0iUWLxd73wlFzGgISjwKfH9o2J1EC0bwprShmdVjwOyGGuMyVWiUgjdc+xLRtUJkvV4tjo49rUg0BSIIy/Mu/xWf/6JO91IpHprsgwpAsi9RSKFWsW0EYDcCM4iEX2rg==
Received: from CYXPR03CA0095.namprd03.prod.outlook.com (2603:10b6:930:d3::6)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:41:52 +0000
Received: from MWH0EPF000D894D.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::21) by CYXPR03CA0095.outlook.office365.com
 (2603:10b6:930:d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:41:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000D894D.mail.protection.outlook.com (10.167.249.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:41:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:41:39 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:41:27 -0800
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
Subject: [PATCH v4 02/32] gpu: nova-core: gsp: pass boot context through setup helpers
Date: Fri, 6 Nov 2026 11:09:35 +0530
Message-ID: <84b6a7a0ea19beb962aac6205c6bb03881d1eba4.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894D:EE_|MW6PR12MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: 943fc82e-7ed0-486d-3c26-08df3bc8a8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|18002099003|22082099003|6133799003|10067099003|3023799007|56012099006|11063799006|261026140227099003|261022115727099003|261102123227099003|261028144727099003|261009223027099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	sXUGVK8VW8nCT3uxrkn40OS08OP9+Efy6lapZHqaKFt/Tq+6O2/nz69yjjnh25PzqDBCHYOcf9GH4ENY0DE46V5S/vSa6YWaVEhN+ky95HX+alJvOLnX+hO/sBOQ2MpFJrV8Br0tpPY5orL4P4MWmYtQ48xIslyZOT9RwUI2nDzRUq0SwdG+bOaBYwdRBs8Q/0c1fomfw5aoETqQeGV2xe/NaZaj5A8/y0wFNgghmSkzZ3xz0oRARfPpv2ZI64TCHKlvnm9xsD6N6KGkWE/WFar9gtdRO0k6+um4PyWeQBygkovGQJjgGWWj/3OmHggHzYC3HJqVbH4E0zWw9wZ1qdsEM3pSTA+uG3+rePWWx0+YrjgHEpRaByw54nU5OXCdE3VRU8nx8RwW5O2/2r+/sFqDVwm3wo6ZE8LYgndCD8ThpQ3LIALCOi2Sk62cFP94/XJV6B6zcjUUqqWAUjCmxsdDPK0PsexT5fFrO4fDRPQlsjFFbte0qg1W2bhQbsfFhSgNna4W7cxIFIK8wzyjrbb615iGF1Aq/23jcwa5W9cXig4q2pNNm4+BtcsN8vGTcVXN9+nz5LXm1OuwmxLSafKQgwY662F6dnLK7sbAoGGhzKlLwahddwf65cAH4XNDzGXdQpfICOuUv8KQ68Sy+rbJs+jnaGYBQPOiKzCbErUh/ksdLh0NJOmnNAaJCIsVItD3VeN68/Gffuiqk8LsIQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(56012099006)(11063799006)(261026140227099003)(261022115727099003)(261102123227099003)(261028144727099003)(261009223027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0urtoRsDMO1XC5z1r3QBoL4NCenv2xyD1Rzt2UUgX4A52FGenPaXXLDV7FXmpYlO6+ZnINUrc3pN/cBWBvKEjoawh1lFjCsK2KSyxxKj5gdeIPv9qt/v9ezAAvCbLyXfFDJwrkdmUfKEZ+y02gXdCkuJTSEXNjfI99ILCLumILnaqUFyNujmVB43D/B3tMPOPtCivI4SUOgwmvIWMk3qUCmF3Pqj6zOBiRf5u3S/Ma+BxHmXyL+VOYfWHUVVBk/E1iNseFN3wdC8KR4Fk8U/Dzq/YfTkkqMzTYDeZhxBD6nboWJFhV7bfCDtv11cQBlqGWmskDcE0G1i9ViG7qcsrgx9qWRcUUQtzwtn8q9PCzNbIpNa63Z/8HACIu4r2qZ3hTZKg+XObeyPMXjPqn1LwW0Aof00/Bx0/x3IYPHexKWhYEMe1OdDW1Btq3y3ZVf2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:41:52.1399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943fc82e-7ed0-486d-3c26-08df3bc8a8d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949

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
 drivers/gpu/nova-core/gsp/boot.rs         |  8 +++---
 drivers/gpu/nova-core/gsp/commands/gmc.rs | 17 ++++---------
 drivers/gpu/nova-core/gsp/fw/commands.rs  | 30 ++++++++++-------------
 drivers/gpu/nova-core/gsp/hal/gh100.rs    |  2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs    |  2 +-
 6 files changed, 34 insertions(+), 51 deletions(-)

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
index 072b00e9c2bf..72353270fce6 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -526,11 +526,9 @@ pub(crate) fn boot(
             bootloader_app_version: gsp_fw.bootloader.app_version,
             libos_dma_handle: self.libos.dma_address(),
         };
-        let static_info = self
-            .cmdq
-            .send_gmc_command(GspInit::new(pdev, chipset, ctx.vgpu.state())?, |event| {
-                load_exec.dispatch_gmc_boot_event(event)
-            })?;
+        let static_info = self.cmdq.send_gmc_command(GspInit::new(ctx)?, |event| {
+            load_exec.dispatch_gmc_boot_event(event)
+        })?;
 
         Ok(super::BootResult {
             unload_bundle: unload_guard.dismiss().1,
diff --git a/drivers/gpu/nova-core/gsp/commands/gmc.rs b/drivers/gpu/nova-core/gsp/commands/gmc.rs
index 3ff44c867288..890462beb11f 100644
--- a/drivers/gpu/nova-core/gsp/commands/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/gmc.rs
@@ -6,14 +6,11 @@
 use core::convert::Infallible;
 
 use kernel::{
-    device,
-    pci,
     prelude::*,
     transmute::AsBytes, //
 };
 
 use crate::{
-    gpu::Chipset,
     gsp::{
         cmdq::{
             gmc::{
@@ -38,9 +35,9 @@
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
@@ -52,7 +49,7 @@ pub(crate) struct GspInit {
 }
 
 impl GspInit {
-    /// Builds the request for `pdev`.
+    /// Builds the request using the device, chipset and vGPU state from `ctx`.
     ///
     /// # Errors
     ///
@@ -60,13 +57,9 @@ impl GspInit {
     /// - `ENODEV` if vGPU mode is enabled but the SR-IOV capability is missing.
     ///
     /// Errors reading the PCI configuration or decoding the VF BAR layout are propagated as-is.
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
index f196a56dd7ee..689b7417597a 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -6,7 +6,6 @@
 use kernel::{
     alloc::ArrayVec,
     bitfield,
-    device,
     pci,
     prelude::*,
     transmute::{
@@ -16,7 +15,6 @@
 };
 
 use crate::{
-    gpu::Chipset,
     gsp::{
         commands::GspStaticInfo,
         nvkv::{
@@ -29,6 +27,7 @@
             Required,
             TruncatingArray, //
         },
+        GspBootContext, //
     },
     vgpu::VgpuState, //
 };
@@ -229,16 +228,14 @@ struct DomainBusDevice(u64) {
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
@@ -261,10 +258,10 @@ fn build_vf_info(
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
@@ -272,11 +269,10 @@ fn build_vf_info(
     /// - `ENODEV` if vGPU mode is enabled but the SR-IOV capability is missing.
     ///
     /// Errors reading the PCI configuration or decoding the VF BAR layout are propagated as-is.
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
@@ -304,7 +300,7 @@ pub(crate) fn new(
             host_arch: HostArch::host().into(),
             bus_device_func: u64::from(bus_device_func).into(),
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
index f8a7b8d9f36f..a7639a98e60a 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -260,7 +260,7 @@ fn boot<'gpu>(
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
-        let fb_ranges = FbRanges::new(chipset, bar, gsp_fw, ctx.vgpu.state())?;
+        let fb_ranges = FbRanges::new(ctx, gsp_fw)?;
         dev_dbg!(dev, "{:#x?}\n", fb_ranges);
 
         // Declared before the unload guard so that if Booter fails while running, SEC2 is reset
-- 
2.53.0

