Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529263;
	b=bOnpNJV7ASt2Dyv0KhiB4PiBIRPwCLl45sKgBBSPjbFZdWGdPP+KQ9dj35TrP+ypR8jM
	 1fyn4pETltDOp+6oZp9vLPlzPrzyogQ0Lh4mWRcWOjPYPsBCoD55BU7LT/gFFMudp661y
	 /Y8sf/ZV7EkI1aPGjmRC2+1VH4Lo9ia2TODPC01OvTdH0X5g3/azW/6m8+plAkj5DsETZ
	 isEfi1YZm+GZPGLb49JvQe2rM6GhKtBZHRMgKUgStSUDucAblQVxWEnOo6TUv31IUtEFQ
	 og29lpycXtSum9gIkZ4EFf4FaMxP5v9NmIw9IHeg7qzHSL5kO4wO9VTDcYrVrhmS9mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529263;
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
	bh=TJq/LTaNbhcWjVttNVuXvW3LRDbDhSmyFTpGZHtOSfo=;
	b=Zsc9uPEQqDfOLG+cZySZwMLaXVFDd5/3DhP7cdwxJqDhbydk8FsBwMf451EgQ9xORYwN
	 EY4oYPGZCnxY43+8PHB4CmRRFKFDnoRJ00pDKvHWt1lx/MDQ7Oi9TV/pQH83UDolyfkOp
	 zwkR8zzGiL799SOybIB8/sZbX0CBVEwG5V0ZOJLLGXWcQpoYDlSVv/M0PapeVaHxCF7/B
	 YQyDo9ofBLdIiVfpSej6fBSxJZMYaWKs+cwKTFsPQtYX4VJccF3szlKj7cn3SUCvzTQVY
	 yz7x+veAtLHAel5oA7BHqidpEj2baUI7bCDRren5+94u6zQvPDX0VOFOuJ+2bvlGCTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AoZR7Dws;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.27
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9D606A6A7;
	Tue, 24 Nov 2026 14:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F9D606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AoZR7Dws
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNmy6GDUOaY7YlBSzvEey5dHPoSIwCGIqrzhayeTerS+GnfyV7Goh5+KAMWIhfdch/95BRvCDrhGjPHV/Yq1I53kAj2JTXaDqWtgb3T5Hjz2hK1CS3c0w6gpwAoKkRyip2JUd0VIVUURO51pwIJvA3JJGfu2/z03nj43zP8cgUQbIGsdjZDpU0Ve1cT4KAO7sA7N5ji6hm2w1bJf18TOY6SCDvZ0HzCK/YOTK+21KkARDUH7Pvf/gbFOG5yxCo6xwC4iRbPuSKFp8YcOkuQoh9TBJK9uXynvNorMcvbJVPXwBMd1dRg4NTZm8Sbr4DuX8t8i068+XZHwiZxPeASeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJq/LTaNbhcWjVttNVuXvW3LRDbDhSmyFTpGZHtOSfo=;
 b=F5gJD8Af9QypFNTRW2XMXlh0Q9fniDyHecqsLbw1B70KRtVjg38YA12+jzEOmtnqxz4Cipb/AU/pVdbYoRio19WHZf8/YjJ3jM+cysiZ4eYzvbSSnjaLfoen+TCLImIij92OckHbvSxtmPetBYT5gGJeNiWjp/rXojk9O66ASOE0BULcTbMxL3i9PRdLD67fteX3ZitChWctk12mNscYAfA0LPlwrZZCyPzkbjU5ha+worVyBGJ3aGT1VA4Y7ChoSBjLu+pZjHJ7YI8n+8gO9q6Hxc8VNj7qTYoslK6v860VYH7yWx3GQSP91Dxj04cElQNZ23cK/q3O3DyMGGb4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJq/LTaNbhcWjVttNVuXvW3LRDbDhSmyFTpGZHtOSfo=;
 b=AoZR7DwspsxDwyXHHkL0gWptRk1pO7a5ENGsihNh1Hj0XoER9mX34sHtSYTEJRoX4NobJO4UD2dKn7ErrPhfMzkK47VNwUjwZ2FYfdZBzLbkhu7FQ07jPuLIzrY3rp7QYNptAzN3n7PpRjcE7ch2Qs24V2CysFsxLiQ96fCh6e32jMt1whdQV9U7ZeiMXKcIf6V3YZLJ5F1yFIYpDWLXED0Muqwdl4FCK2dtE5m9br8vX9AibLlrsfA0PXTFufTMc515hC5GyAIxWoyc4KuW3kyV9h6JHEYnexfvGwRV/U1E7qAfwlFltcpsgesH/WTjjRgy7jb7eXYdQIflHQ4CBA==
Received: from PH8PR21CA0009.namprd21.prod.outlook.com (2603:10b6:510:2ce::26)
 by DS2PR12MB9614.namprd12.prod.outlook.com (2603:10b6:8:276::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:07:29 +0000
Received: from BY1PEPF0002695C.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::37) by PH8PR21CA0009.outlook.office365.com
 (2603:10b6:510:2ce::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.3 via Frontend Transport; Tue, 24
 Nov 2026 14:07:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0002695C.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:07:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:07:06 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:06:53 -0800
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
Subject: [PATCH v5 32/35] gpu: nova-core: vgpu: add CeUtils commands
Date: Tue, 24 Nov 2026 19:29:28 +0530
Message-ID: <20261124135937.18583-33-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695C:EE_|DS2PR12MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 32df3a7c-10eb-4378-db8c-08df4a344663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|7416014|82310400026|260925022911599003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261028144727099003|261022105027099003|261022075727099003|11063799006|261102123227099003|56012099006|10067099003|260925021311599003|22082099003|18002099003|260925021911599003|261009223027099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5mJ5HJ0rERxvqOaabBvwloWHBPSbpCnALQGKO4EtkoxdqgqIKlyo6QVcn1Zqbfuf0fAky1hBwA8y2lV/7JrBW3NVqy+1krj8C2EeUX/uvNizIJyMJw5NKxqqZ60n7Fua0fDMEAC3kP7yvA9hnlEC8bUmUU3vWPkCR5LzkH16CMvAQ/L9OB7umglXpQzLwsCVDt32t6pJsgWvQW2+wvYtmrbQdUMKKbWHoB9FW5c+b7JqRL7Lr/KrGo727O0YDD+3Kahjyan+ZLjcAjgLWrq3onFQIloIcP56UPiD6J3WOsLiFaV0RKOsSWRHcLTfTPiockodcwlfse9QhWVXgglSR7/3T4wu4soW0++es/ATsfNAsTPZU7x6qL7p8TpwwI2cZRLRsYVHYlwnkFdKhr4hFsZ4k2ZFE/PnhY15Og1syh7H394BHz3sIbL+sEHtSjI219GFuWGk9TNjV4svQR7WXWM0eZuhvf8oSWlghNARd+GeiCGpDRr5zc3fYDAx5mktLFGnZJlxR8lN5D4uTIMU3lcfLL4YyOe0KTb+jIb+uK656XCdBI0nr2DBJq9aOFrjlDJMuyyo+CLVF366SNahWXrxFf7lF+wczPyQKv5YLnav8LMgtOrmrIsKLhHUenXb0SwTi2NUWhG54yj8guXj88QsV41n977/aEEgPlkygNxO2X2Q7ZCLvGsX0ZwtUBFMEeuWlz5A3oidX+ewaGFaKQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(7416014)(82310400026)(260925022911599003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261028144727099003)(261022105027099003)(261022075727099003)(11063799006)(261102123227099003)(56012099006)(10067099003)(260925021311599003)(22082099003)(18002099003)(260925021911599003)(261009223027099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q4EHwlziGG2oM98zbXHOe/2Vu4s4W9puPc0KjoujZQ+oB8Wyv0zeFPuUO/4jjXFijcgJI1FShJTqw6qhey6QZ0k4SZfq9Ozp5YKpGd8fXmaDTrSYF+8Bf7nmu/5pcaawybM3HFJqPYHhlwNgYNwnjV2/cyNXpRwzI6izWAylz5+3zM42LFH5JLPCLnWO1UquxVyrXLa0NqA9rnmMGkioFQsL0tobEuq5afQOK9rU2KeAz7Z1lcbym5HVgaPmyoTZ9K2H/qx77p7X7H9xksP0mdG4vRB0YaVJUy0BItRk1sn+DN0ughcABF1b4h1A8V8IwkjSWGb1FikZVYlJ9KXNI2YXReLyOYWgt1ZjUeHPIzwVJx8rxgM7pTGxCRoNrbVsN+yiI/RdYl0t9cXC9X/qk8PWmB+oounpmI/LUVopcYuxLzPV5ZqT1Reg00/XeF5J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:07:28.9343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32df3a7c-10eb-4378-db8c-08df4a344663
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9614

From: Zhi Wang <zhiw@nvidia.com>

Add Cmdq operations to allocate and free a CeUtils channel and submit
guest VRAM scrub requests. Decode the allocation and scrub replies, and
validate the returned semaphore address and aperture.

Distinguish an explicit allocation rejection from failures that may leave
firmware owning the channel, so callers can decide whether to retain its
host resources.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/vgpu/commands.rs        | 153 ++++++++++++++++++
 drivers/gpu/nova-core/vgpu/fw.rs              |   2 +
 drivers/gpu/nova-core/vgpu/fw/commands.rs     |  48 +++++-
 .../gpu/nova-core/vgpu/fw/r000_00/bindings.rs |   1 +
 4 files changed, 202 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index d11f9af27ee0..a71379165eaf 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -10,6 +10,7 @@
 
 use kernel::{
     device,
+    num::casts::usize_as_u64,
     prelude::*,
     time::Delta,
     transmute::AsBytes, //
@@ -36,16 +37,22 @@
         GmcCommandId,
         GSP_PAGE_SIZE, //
     },
+    mm::PAGE_SIZE,
     sbuffer::SBufferIter,
     vgpu::{
         fw::{
             commands::{
                 encode_plugin_set_bme,
+                AllocCeutilsRequest,
+                AllocCeutilsResponse,
                 AssignedVfVgpuType,
+                ScrubGuestFbRequest,
+                ScrubGuestFbResponse,
                 VgpuProperties,
                 VgpuPropertiesSchema, //
             },
             RpcMessage,
+            NV_ADDR_FBMEM, //
         },
         gsp_plugin_rpc::PluginRpc,
         instance::Gfid,
@@ -255,3 +262,149 @@ pub(super) fn set_plugin_bme(
     let bme = encode_plugin_set_bme(enable)?;
     rpc.rpc_call_nvkv(dev, RpcMessage::UpdateBmeState, &bme)
 }
+
+impl CommandToGsp for AllocCeutilsRequest {
+    const COMMAND: GmcCommandId = GmcCommandId::VgpuMgrAllocGspCeutils;
+    type Command = Self;
+    type Reply = AllocCeutilsResponse;
+    const MAX_REPLY_SIZE: u32 = cv!(size_of::<AllocCeutilsResponse>());
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        *self
+    }
+}
+
+impl MessageFromGsp for AllocCeutilsResponse {
+    type InitError = Error;
+
+    fn read(payload: &mut MessagePayload<'_>) -> Result<Self, Self::InitError> {
+        payload.read()
+    }
+}
+
+/// The `VGPU_MGR_FREE_GSP_CEUTILS` command.
+struct FreeCeutils(Gfid);
+
+impl CommandToGsp for FreeCeutils {
+    const COMMAND: GmcCommandId = GmcCommandId::VgpuMgrFreeGspCeutils;
+    type Command = u32;
+    type Reply = ();
+    const MAX_REPLY_SIZE: u32 = 0;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        u32::from(self.0.get()).to_le()
+    }
+}
+
+impl CommandToGsp for ScrubGuestFbRequest {
+    const COMMAND: GmcCommandId = GmcCommandId::VgpuMgrScrubGuestFb;
+    type Command = Self;
+    type Reply = ScrubGuestFbResponse;
+    const MAX_REPLY_SIZE: u32 = cv!(size_of::<ScrubGuestFbResponse>());
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        *self
+    }
+}
+
+impl MessageFromGsp for ScrubGuestFbResponse {
+    type InitError = Error;
+
+    fn read(payload: &mut MessagePayload<'_>) -> Result<Self, Self::InitError> {
+        payload.read()
+    }
+}
+
+/// Whether a failed allocation may still have transferred CHID ownership to firmware.
+#[expect(dead_code)]
+pub(super) enum CeUtilsAllocError {
+    /// A matching firmware response explicitly rejected the allocation.
+    NotOwned(Error),
+    /// The request may have completed despite a transport or response-validation error.
+    MayOwn(Error),
+}
+
+/// Allocate a CeUtils channel and validate its semaphore description.
+#[expect(dead_code)]
+pub(super) fn alloc_ceutils(
+    dev: &device::Device,
+    cmdq: &Cmdq<'_>,
+    gfid: Gfid,
+    chid: u32,
+) -> core::result::Result<u64, CeUtilsAllocError> {
+    let request = AllocCeutilsRequest {
+        gfid: u32::from(gfid.get()).to_le(),
+        fixed_chid: chid.to_le(),
+        force_ceid: u32::MAX.to_le(),
+        swizz_id: 0,
+    };
+
+    dev_dbg!(dev, "alloc CeUtils: gfid={} chid={}\n", gfid.get(), chid,);
+
+    let response = cmdq
+        .send_gmc_command(request, |_| Ok(()))
+        .map_err(CeUtilsAllocError::MayOwn)?
+        .map_err(|_| CeUtilsAllocError::NotOwned(EIO))?;
+
+    let semaphore_address = u64::from_le(response.semaphore_address);
+    let semaphore_aperture = u32::from_le(response.semaphore_aperture);
+    let page_size = usize_as_u64(PAGE_SIZE);
+
+    if semaphore_address == 0
+        || !semaphore_address.is_multiple_of(page_size)
+        || semaphore_aperture != NV_ADDR_FBMEM
+    {
+        return Err(CeUtilsAllocError::MayOwn(EINVAL));
+    }
+
+    dev_dbg!(
+        dev,
+        "alloc CeUtils: gfid={} semaphore={:#x}\n",
+        gfid.get(),
+        semaphore_address,
+    );
+    Ok(semaphore_address)
+}
+
+/// Release a CeUtils allocation, including one whose allocation reply was lost.
+#[expect(dead_code)]
+pub(super) fn free_ceutils(dev: &device::Device, cmdq: &Cmdq<'_>, gfid: Gfid) -> Result {
+    dev_dbg!(dev, "free CeUtils: gfid={}\n", gfid.get());
+
+    cmdq.send_gmc_command(FreeCeutils(gfid), |_| Ok(()))?
+        .map_err(|_| EIO)
+}
+
+/// Submit an asynchronous guest FB scrub and return its work identifier.
+#[expect(dead_code)]
+pub(super) fn submit_ceutils_scrub(
+    dev: &device::Device,
+    cmdq: &Cmdq<'_>,
+    gfid: Gfid,
+    fb_offset: u64,
+    fb_size: u64,
+) -> Result<u32> {
+    let request = ScrubGuestFbRequest {
+        gfid: u32::from(gfid.get()).to_le(),
+        reserved: 0,
+        fb_offset: fb_offset.to_le(),
+        fb_size: fb_size.to_le(),
+    };
+
+    dev_dbg!(
+        dev,
+        "submit scrub: gfid={} offset={:#x} size={:#x}\n",
+        gfid.get(),
+        fb_offset,
+        fb_size,
+    );
+
+    let response = cmdq
+        .send_gmc_command(request, |_| Ok(()))?
+        .map_err(|_| EIO)?;
+
+    u32::try_from(u64::from_le(response.work_id)).map_err(|_| EOVERFLOW)
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index 76bd2b7e4e52..02f51bb8cf7f 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -31,6 +31,8 @@
     VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE, //
 };
 
+pub(super) use bindings::NV_ADDR_FBMEM;
+
 /// State observed in the response buffer for an expected RPC sequence.
 pub(super) enum RpcResponse {
     Pending {
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index 10f1427bf355..c2e2ffad2b2d 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -20,10 +20,10 @@
         Array,
         Encodable,
         Encoder,
-        Index, //
+        Index,
         Key,
         KeyId,
-        Required,
+        Required, //
     },
     mm::vram::VramRegion,
     vgpu::Dbdf, //
@@ -330,6 +330,50 @@ pub(crate) fn encode_plugin_config_params(
     Ok(encoder.finish())
 }
 
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct AllocCeutilsRequest {
+    pub(crate) gfid: u32,
+    pub(crate) fixed_chid: u32,
+    pub(crate) force_ceid: u32,
+    pub(crate) swizz_id: u32,
+}
+
+// SAFETY: All fields are integers, and the struct has no padding.
+unsafe impl kernel::transmute::AsBytes for AllocCeutilsRequest {}
+
+// SAFETY: All fields are integers, for which all bit patterns are valid.
+unsafe impl kernel::transmute::FromBytes for AllocCeutilsRequest {}
+
+#[repr(C)]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct AllocCeutilsResponse {
+    pub(crate) semaphore_address: u64,
+    pub(crate) semaphore_aperture: u32,
+    _reserved: u32,
+}
+
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct ScrubGuestFbRequest {
+    pub(crate) gfid: u32,
+    pub(crate) reserved: u32,
+    pub(crate) fb_offset: u64,
+    pub(crate) fb_size: u64,
+}
+
+// SAFETY: All fields are integers, and the struct has no padding.
+unsafe impl kernel::transmute::AsBytes for ScrubGuestFbRequest {}
+
+// SAFETY: All fields are integers, for which all bit patterns are valid.
+unsafe impl kernel::transmute::FromBytes for ScrubGuestFbRequest {}
+
+#[repr(C)]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct ScrubGuestFbResponse {
+    pub(crate) work_id: u64,
+}
+
 nvkv_encode! {
     struct PluginSetBmeRequest {
         bme_enable: Key<bool, 0x0100, u32>,
diff --git a/drivers/gpu/nova-core/vgpu/fw/r000_00/bindings.rs b/drivers/gpu/nova-core/vgpu/fw/r000_00/bindings.rs
index 85f965335b64..e46f7339544a 100644
--- a/drivers/gpu/nova-core/vgpu/fw/r000_00/bindings.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/r000_00/bindings.rs
@@ -8,6 +8,7 @@
 pub type u16_ = __u16;
 pub type u32_ = __u32;
 pub type u64_ = __u64;
+pub const NV_ADDR_FBMEM: u32 = 2;
 pub const GSP_PLUGIN_BOOTLOADED: u32 = 1315261039;
 pub const VGPU_CPU_GSP_CTRL_BUFF_VERSION: u32 = 2;
 pub const VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE: u32 = 4096;
-- 
2.53.0

