Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529274;
	b=4CLdNvrNWc9gkal3YP/HrrHxDkmdYfcZD7WrjbjCH9eG3+VRomaPc2yQawI4/x1ww76N
	 ZB9WOrHmGYD+qcMyvZYJuA+s4TNy3iWC5IPWsVVIvs9hK4fUSYSsUAsOTqfHWPnuVyWX7
	 iKJlwtvSVIT5DmHha7VuDWB4D1upoawe5x2IrJ1Q2z017leVtSZrNWZybaU1XKaJDUw2l
	 Ca1gIDwoZCwzjSCDbrmNip86H8ntlnQ0RplYfyluojWrAfO7G9dS7oPnjFUDSyrKfPGIe
	 drQL6kfnVR1o9/2AqoHEbrO3zJdw8bXl/LnL2bqK+owwaKR12O5NxL8thB54tpVCk0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529274;
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
	bh=OspNSa1nXuhxVJ3ldxi09Ns9/YWOmnE/UfDinlpJFew=;
	b=2WTWcRT8K86QXeZBL77M0EUkhBMbp+qOQffoacWRqmeJ1yYDw/RLWgEf6l8mP0zVrU9x
	 lPX+AOIX5M3Ee3m+QGRYW12cks6WZTV5w4cR0TqQX4ZyXLmnaGHP5h7djdm/O13uKvNhc
	 Ckqvy84IpQtb8orzPHzmLut6L1AsdUDM9+A4pYyR5Toq80Z59A8EFpdhE4XG5KjSIelYb
	 8mt2tygnz3HVnCdh1EutxRRyEnRq+LriLprOlCM7DVxzplu0+9+ziQvXL34bWzrXN7Fds
	 J0iZRskBkgKvJgWDVqD72g0y1XUFrSZMYiKtizbCCS/n5ypv/Ei/2ubG1u2d5uhXaJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rtyqJgat;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.38
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64A606B020;
	Tue, 24 Nov 2026 14:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B64A606B020
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rtyqJgat
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sR/u6kJObhKQFhfZHWB6y4kee+HLql2UP5irv/zH7SErC7F1EONfF80Cjxf8QnCwzBym27h7ZJ0lItlUs6ZIsVDrardigmA6cEfSiapTUQ8Sp86x1LWK37/qxiIRVqQ1aymE9QVMoex9hyx2H1ja3dkVF1CqxoKr2qzGd5q2pvXEuaSNB2ikyX9GoCYSPPGa64ecGAFtF+6vWJ1o9k8qaB4lrdvyMmubz7k5nuVg3ePBtMliRMO9YANRsi0YLxyQfpwboH16lGlIMw7KEdppKTeLv7sD1t4FEggPYm1ifbBctpX27XOmjWBZgn8vhWV+Z3EcDlbOY7ocJxQIf4qCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OspNSa1nXuhxVJ3ldxi09Ns9/YWOmnE/UfDinlpJFew=;
 b=YyTweokJKCYYy5uSx+pi0aXhbpT3hLnyvG6QFAss1pflPE0S3LWcgRV1k6BBS1Y+3H308HWU9dXYSLjBMIGHzy4icHDFKE263grh1xDAPMqi6Uc8R2LQy20kVcpyu58z35XwTA72O87Nm9gOZGLRUivt3BDRdU7mfXrJSbo/iLqXLAVJKBvy/pyANdV4YfxHTfkpT6urtFBnJIklC3IH3FIh+wsuaccsj1u8Ua7EeymhEsgKzorj+8+7bk8H/qMaiO4npPChlEWLrIuXUKyo0FZAPQFHyTKZKK6/38feKG4rHbaEM692e47E3rrR+AOxVUYsFRpZsh03r44Vgd40Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OspNSa1nXuhxVJ3ldxi09Ns9/YWOmnE/UfDinlpJFew=;
 b=rtyqJgatTw5Jm2O46ABnZBdDd2hm570EfLSO7ETS42eSgcq5nvC5glSLnRm6Gb+cXukkNdvIS+p9maTzbZA6/PDjLdh1tqje64bwfWboIJW6dxlj6VrYQMRYEVMBimqwUxNmSlgI3EnMSsb0H5KmTZgXgY1E0rA/q/u0hRQW9vQSrY9MPHrSwkwvALHpNBeA66An6mpW/1bbtCcFPmT1RdCtlsVm6NvseoK9YMdKuTVosEbtAizzVPVMbaNwC0H5FHyMYCv99ci+aze+Y73znoWqMxjQDHIcSSzYAi034QAvp+kWRlbBmYvg2u5BFW0amgYRZwxROjxICSUKq1TNbw==
Received: from PH7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:510:339::11)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 14:07:44 +0000
Received: from CY6PEPF00000047.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::5f) by PH7PR03CA0026.outlook.office365.com
 (2603:10b6:510:339::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:07:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF00000047.mail.protection.outlook.com (10.167.247.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:07:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:07:19 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:07:06 -0800
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
Subject: [PATCH v5 33/35] gpu: nova-core: vgpu: scrub guest VRAM with CeUtils
Date: Tue, 24 Nov 2026 19:29:29 +0530
Message-ID: <20261124135937.18583-34-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF00000047:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cd7601-d2ca-4060-111d-08df4a344f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|261021135927099003|261021123027099003|261102123227099003|11063799006|261026121527099003|261022113327099003|261022115727099003|5023799004|261026140227099003|261021121427099003|261028144727099003|56012099006|261022105027099003|10067099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	03FW716LCOMf3MmnrT8C0E8fXhSz/q/+DOoIMNmKHAYruCqOb0KBE3tYlFfuY5DAd7bUPS8IWk+SNUVPmo6bf8FXtbUkiyjfN4rngOiXnhlSwxhaQ1HVH3rYaWhtXa3q3RvU73fUpVl0H7xYrEQStlkNttbDhFw4JXZaKdabjNKJdHSlXWs4peD3tMMFQ+A8ySVFPtjOu2w1ez2POF6b/UEyuSU5KX7WYiBoZRuEiiYfgmVDyU34l3x+GDwJIrC3ajHO7OGLcOm/Cl597mBp0ajMvOyzXRuZlGjkBF7pJbeiYeDWmNfPi32+M2V2A1Utr8bFTKHHpNxxyjOtnpU/EaT0EEKCihuJoAsHyEFybNVfpGjKdV/DWEJAairSS71lMcNjfk3C09eymvLFHellIQdyLbrwYalqPpx6pJCZrlmjTh43uKc4aN48R1byTe9PPwwGrZuMp8y2omcJ/YwzlaiQiYsJoU4gGIaXQrIGw0s5n5k/VoTRDj8ZpwrCLLoBYyhqYH/zMz5bcy7EZ2laDP3Bbjo5Vg7ouSk2f3taQ5s33zg0XN8TabztL5wPApyyBm8FcOGfakp+IhAcyr/03P/V4dmJ8WzZy9YvNrvmR2EDgdDclwSgZ2BETSEokFKq26z0pQOIuSmaJKdc+xV6pzTBqJmkKwxnvf75Ek4AB2Bi9/bECqcg37fpAK6juzumISDvf+n3twv6q8E/7RNP/g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(261021135927099003)(261021123027099003)(261102123227099003)(11063799006)(261026121527099003)(261022113327099003)(261022115727099003)(5023799004)(261026140227099003)(261021121427099003)(261028144727099003)(56012099006)(261022105027099003)(10067099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mdjiT261SnsQJjD3r/rnWi6gV2w+8QXl9Lj2dqHrUyMJTPTpxIaRDLhVOU1LVBfQh1KWIikgTYYv57mnqCnXI2LTpMa6UjOLO87TXGK1e8rlQJU1HpNQkRBGOLC43KSDF9IcpbbT4Ng3c4MmV+YBlwuNS8NFkqs4idR6EqRSItnL3JTl8RdKygrEFcFVMz4l8jTVO8PefmYblCdCNQtf8TmLmxTaaxFXND1rmjPt9BEc4cecVdVROnH0w+CZt+SHbWMQ5rsqXlzRKdq/LBSgHFClDgPg5qsl/Sl/EKTvOD7WjGHn2uTyhdF6dFEN/fgiXrgerfgJAheQIm9igknVwW5e91WElBJfXvWMZNf+1+MfN0AYgADp8+eWz04SV3IZdG0XSsLYnAmLqYT6PXeGbxFSJvtJN/ByEyx9DrwFpXUoCtAlPikVP62kX/wtla9D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:07:44.1198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cd7601-d2ca-4060-111d-08df4a344f77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000047.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846

From: Zhi Wang <zhiw@nvidia.com>

Scrub guest VRAM before plugin boot and after plugin shutdown, before its
slot can be reused. Reserve the last channel ID in each instance range
for CeUtils and give the remaining channels to the plugin.

Submit scrubs in chunks and wait for completion through a temporary BAR1
mapping of the CeUtils semaphore. Release the mapping on both success and
failure, preserving a polling error if unmapping also fails.

Keep allocation, scrubbing and release within the instance lifecycle.
Retain host resources until device removal when firmware ownership is
uncertain or a scrub fails, and do not retry a recorded teardown failure.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/vgpu.rs          |   1 +
 drivers/gpu/nova-core/vgpu/commands.rs |   4 -
 drivers/gpu/nova-core/vgpu/instance.rs |  56 +++++++-
 drivers/gpu/nova-core/vgpu/scrubber.rs | 172 +++++++++++++++++++++++++
 4 files changed, 225 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/scrubber.rs

diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index bdb4821751e7..e1e2d6bcfd31 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -41,6 +41,7 @@
 mod gsp_plugin_rpc;
 mod hal;
 mod instance;
+mod scrubber;
 mod vram;
 
 bitfield! {
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index a71379165eaf..07a8e071d34d 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -319,7 +319,6 @@ fn read(payload: &mut MessagePayload<'_>) -> Result<Self, Self::InitError> {
 }
 
 /// Whether a failed allocation may still have transferred CHID ownership to firmware.
-#[expect(dead_code)]
 pub(super) enum CeUtilsAllocError {
     /// A matching firmware response explicitly rejected the allocation.
     NotOwned(Error),
@@ -328,7 +327,6 @@ pub(super) enum CeUtilsAllocError {
 }
 
 /// Allocate a CeUtils channel and validate its semaphore description.
-#[expect(dead_code)]
 pub(super) fn alloc_ceutils(
     dev: &device::Device,
     cmdq: &Cmdq<'_>,
@@ -370,7 +368,6 @@ pub(super) fn alloc_ceutils(
 }
 
 /// Release a CeUtils allocation, including one whose allocation reply was lost.
-#[expect(dead_code)]
 pub(super) fn free_ceutils(dev: &device::Device, cmdq: &Cmdq<'_>, gfid: Gfid) -> Result {
     dev_dbg!(dev, "free CeUtils: gfid={}\n", gfid.get());
 
@@ -379,7 +376,6 @@ pub(super) fn free_ceutils(dev: &device::Device, cmdq: &Cmdq<'_>, gfid: Gfid) ->
 }
 
 /// Submit an asynchronous guest FB scrub and return its work identifier.
-#[expect(dead_code)]
 pub(super) fn submit_ceutils_scrub(
     dev: &device::Device,
     cmdq: &Cmdq<'_>,
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 59d7014d7f69..2f6c2a8f3a02 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -31,12 +31,14 @@
 
 use super::{
     commands::{
+        free_ceutils,
         negotiate_plugin_version,
         send_bootload,
         send_cleanup,
         send_plugin_config,
         send_shutdown,
-        set_plugin_bme, //
+        set_plugin_bme,
+        CeUtilsAllocError, //
     },
     fw::commands::{
         encode_plugin_config_params,
@@ -47,6 +49,7 @@
     },
     gsp_plugin_comm::CommBufferRegion,
     gsp_plugin_rpc::PluginRpc,
+    scrubber::CeUtils,
     vram::{
         VgpuVramLayout,
         VgpuVramSlot,
@@ -156,12 +159,41 @@ struct VgpuInstance<'gpu> {
     // Unmap the communication region before returning its slot and channel IDs.
     vram_slot: VgpuVramSlot,
     chids: ChannelIdReservation<'gpu>,
+    ceutils: Option<CeUtils>,
     needs_teardown: bool,
     /// An uncertain or failed operation retains resources until device removal.
     failure: Option<Error>,
 }
 
 impl<'gpu> VgpuInstance<'gpu> {
+    fn initialize(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
+        let ceutils_chid =
+            u32::try_from(self.chids.end.checked_sub(1).ok_or(EINVAL)?).map_err(|_| EOVERFLOW)?;
+        let ceutils = match CeUtils::allocate(vgpu.dev, vgpu.cmdq, self.gfid, ceutils_chid) {
+            Ok(ceutils) => ceutils,
+            Err(CeUtilsAllocError::NotOwned(error)) => return Err(error),
+            Err(CeUtilsAllocError::MayOwn(error)) => {
+                self.failure = Some(error);
+                dev_err!(vgpu.dev, "CeUtils allocation failed: {:?}\n", error);
+                return Err(error);
+            }
+        };
+
+        let result = ceutils.scrub_guest_fb(
+            vgpu.dev,
+            vgpu.cmdq,
+            vgpu.bar_user,
+            vgpu.mm,
+            &self.vram_slot.fbmem,
+        );
+        self.ceutils = Some(ceutils);
+        if let Err(error) = result {
+            // A failed wait does not establish that the submitted scrub has stopped.
+            self.failure = Some(error);
+        }
+        result
+    }
+
     fn activate(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
         let dev = vgpu.dev;
         self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
@@ -180,7 +212,17 @@ fn teardown(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
         }
         let result = (|| {
             self.shutdown(vgpu.dev, vgpu.cmdq)?;
-
+            if let Some(ceutils) = self.ceutils.as_ref() {
+                ceutils.scrub_guest_fb(
+                    vgpu.dev,
+                    vgpu.cmdq,
+                    vgpu.bar_user,
+                    vgpu.mm,
+                    &self.vram_slot.fbmem,
+                )?;
+                free_ceutils(vgpu.dev, vgpu.cmdq, self.gfid)?;
+                self.ceutils = None;
+            }
             if self.needs_teardown {
                 send_cleanup(vgpu.dev, vgpu.cmdq, self.gfid)?;
                 self.needs_teardown = false;
@@ -246,7 +288,7 @@ fn configure_plugin(&mut self, dev: &device::Device) -> Result {
             self.dbdf,
             self.vgpu_type.vgpu_type_id,
             self.vm_pid,
-            u32::try_from(self.chids.len()).map_err(|_| EOVERFLOW)?,
+            u32::try_from(self.chids.len().checked_sub(1).ok_or(EINVAL)?).map_err(|_| EOVERFLOW)?,
             self.num_plugin_channels,
         )?;
 
@@ -356,6 +398,9 @@ fn allocate_instance(
             .map(usize::from_safe_cast)
             .and_then(NonZeroUsize::new)
             .ok_or(EINVAL)?;
+        if channels_per_instance <= cv!(1) {
+            return Err(EINVAL);
+        }
         let chids = vgpu
             .chid_pool
             .reserve_ids(channels_per_instance, Alignment::SZ_1)?;
@@ -382,6 +427,7 @@ fn allocate_instance(
             plugin_rpc: PluginRpc::new(comm, vgpu.bar, gfid),
             vram_slot,
             chids,
+            ceutils: None,
             needs_teardown: false,
             failure: None,
         })
@@ -436,7 +482,9 @@ fn create_instance(&self, info: InstanceInfo) -> Result {
         instances.instances.reserve(1, GFP_KERNEL)?;
 
         let mut instance = instances.allocate_instance(self, info)?;
-        let result = instance.activate(self);
+        let result = instance
+            .initialize(self)
+            .and_then(|()| instance.activate(self));
 
         if result.is_err() {
             match instance.teardown(self) {
diff --git a/drivers/gpu/nova-core/vgpu/scrubber.rs b/drivers/gpu/nova-core/vgpu/scrubber.rs
new file mode 100644
index 000000000000..00daa11b8653
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/scrubber.rs
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Per-VM CeUtils guest VRAM scrubbing.
+
+use kernel::{
+    device,
+    io::io_read,
+    prelude::*,
+    time::{
+        delay::fsleep,
+        Delta,
+        Instant,
+        Monotonic, //
+    },
+    types::ScopeGuard, //
+};
+
+use crate::{
+    gsp::cmdq::Cmdq,
+    mm::{
+        bar_user::BarUser,
+        vram::VramRegion,
+        Pfn,
+        SharedGpuMm,
+        VramAddress, //
+    },
+    vgpu::instance::Gfid, //
+};
+
+use super::commands::{
+    self,
+    CeUtilsAllocError, //
+};
+
+// Semaphore layout from OpenRM `channel_utils.h`.
+const NV_CEUTILS_SEMA_PAGE_MAGIC: u32 = 0xce5e_5ea0;
+
+#[repr(C)]
+struct CeUtilsSemaphoreHeader {
+    magic: u32,
+    payload: u32,
+}
+
+static_assert!(size_of::<CeUtilsSemaphoreHeader>() == 8);
+
+const SCRUB_REQUEST_SIZE: u64 = 4 * 1024 * 1024 * 1024;
+
+// Host timeout policy; not a firmware ABI value.
+const SCRUB_TIMEOUT: Delta = Delta::from_secs(5);
+
+/// A firmware-owned per-VM CeUtils allocation.
+///
+/// Submitted scrubs must complete before releasing this allocation or its VRAM.
+pub(super) struct CeUtils {
+    gfid: Gfid,
+    semaphore_address: u64,
+}
+
+impl CeUtils {
+    pub(super) fn allocate(
+        dev: &device::Device<device::Bound>,
+        cmdq: &Cmdq<'_>,
+        gfid: Gfid,
+        chid: u32,
+    ) -> core::result::Result<Self, CeUtilsAllocError> {
+        let semaphore_address = commands::alloc_ceutils(dev, cmdq, gfid, chid)?;
+        Ok(Self {
+            gfid,
+            semaphore_address,
+        })
+    }
+
+    /// Scrub the complete guest VRAM and wait for semaphore completion.
+    pub(super) fn scrub_guest_fb(
+        &self,
+        dev: &device::Device<device::Bound>,
+        cmdq: &Cmdq<'_>,
+        bar_user: &BarUser<'_>,
+        mm: &SharedGpuMm<'_>,
+        fb: &VramRegion,
+    ) -> Result {
+        let mut offset = fb.range().start;
+        let end = fb.range().end;
+        while offset < end {
+            let size = core::cmp::min(SCRUB_REQUEST_SIZE, end - offset);
+            let work_id = commands::submit_ceutils_scrub(dev, cmdq, self.gfid, offset, size)?;
+            wait_scrub_complete(bar_user, mm, dev, self.semaphore_address, work_id)?;
+            offset = offset.checked_add(size).ok_or(EOVERFLOW)?;
+        }
+
+        Ok(())
+    }
+}
+
+/// Poll the GSP-owned CeUtils semaphore page through a temporary BAR1 map.
+fn wait_scrub_complete(
+    bar_user: &BarUser<'_>,
+    mm: &SharedGpuMm<'_>,
+    dev: &device::Device<device::Bound>,
+    semaphore_address: u64,
+    work_id: u32,
+) -> Result {
+    let pfn = Pfn::from(VramAddress::from_raw(semaphore_address));
+    let semaphore_map = mm.with_locked(|mm| bar_user.map(mm, &[pfn], false))?;
+    let semaphore_map = ScopeGuard::new_with_data(semaphore_map, |mapping| {
+        if let Err(error) = mm.with_locked(|mm| mapping.release(mm)) {
+            dev_err!(
+                dev,
+                "failed to release semaphore BAR1 mapping: {:?}\n",
+                error
+            );
+        }
+    });
+
+    let result = (|| {
+        let semaphore = semaphore_map.view::<CeUtilsSemaphoreHeader>(0)?;
+
+        let magic = io_read!(semaphore, .magic);
+        if magic != NV_CEUTILS_SEMA_PAGE_MAGIC {
+            dev_warn!(
+                dev,
+                "bad CeUtils semaphore magic {:#x}, expected {:#x}\n",
+                magic,
+                NV_CEUTILS_SEMA_PAGE_MAGIC,
+            );
+            return Err(EIO);
+        }
+
+        let start = Instant::<Monotonic>::now();
+        loop {
+            let value = io_read!(semaphore, .payload);
+            if value.wrapping_sub(work_id) < 0x8000_0000 {
+                dev_dbg!(
+                    dev,
+                    "scrub completed after {:?}: semaphore={:#x}, target={:#x}\n",
+                    start.elapsed(),
+                    value,
+                    work_id,
+                );
+                return Ok(());
+            }
+
+            if start.elapsed() >= SCRUB_TIMEOUT {
+                dev_warn!(
+                    dev,
+                    "scrub timed out: semaphore={:#x}, target={:#x}\n",
+                    value,
+                    work_id,
+                );
+                return Err(ETIMEDOUT);
+            }
+            fsleep(Delta::from_millis(1));
+        }
+    })();
+
+    let cleanup = mm.with_locked(|mm| semaphore_map.dismiss().release(mm));
+    match result {
+        Ok(()) => cleanup,
+        Err(error) => {
+            if let Err(cleanup_error) = cleanup {
+                dev_err!(
+                    dev,
+                    "failed to release semaphore BAR1 mapping after error {:?}: {:?}\n",
+                    error,
+                    cleanup_error,
+                );
+            }
+            Err(error)
+        }
+    }
+}
-- 
2.53.0

