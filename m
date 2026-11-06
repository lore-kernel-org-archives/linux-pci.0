Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944079;
	b=TGbjBWi+F1Ww8ke+goTdNH1DpVHlUgb3IhujRBYcZQU25MHZzZqmwGrpN9WtsvCVa3Au
	 sTdDkHY6O+XCkDcBmt49VqwysQ0/QixZHBauiiOUisjzlID8yHSqCWHkexPlCvzCYxF/O
	 EJ886Kh5euEuq6ufY2FZq0D4YnFqeXIrLLQKzrOyjpgqh/QNp2BbhrA0tCJmkQKor+qCC
	 Ig3umxPLimSkQQJxxMojJorfdketyygOPhDS1eZvnxEbDUSUCBi1NGfEXLLjBzQnR7WW/
	 e5gorcpQ/LGhHMSQARu9lv0nu2ClnojH+xg02wpC5Sye6AyqOkkTO/mQvrf52grEs/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944079;
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
	bh=xo9uoM8g+06RL37EAe/IHcHuvDLEcXlSnLvB6vPP3Ng=;
	b=POlKyF66WUIKiRY2D3pfqskixpNgdZqKgzGQp7iKInUkFSLQH4UqDUH+8oLMI9XwaVLC
	 Jxf9levxzWLxcc1fUA741mnZ8gx2mqNJxD10ktkB9WkCdSouMXi7hgdtRgxErs40mpuF0
	 9Q8OggU6KrT0woacgbVhZVtPq4LMSoTaA+/qjnFhStXt7AXdZre9DOy/gCN0D/uzySpUs
	 kBTaPIc7dWSFedREAc27WAbOLbwXDvRvCY7YeR9TvBs6aOIKQPyOEf++Qdbhz9Un7qQQj
	 DLoCC7MctbaEAxH+yNBjZ+XtB2eDoZpl+AmF2gObjXqAMqIKi6/VwpD+KUPvdTLcjew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BhLFSEDp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.64
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3ED606A336;
	Fri,  6 Nov 2026 05:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A3ED606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BhLFSEDp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQ01dBSU50gKpy0OIM+iCrIFzdQZkXIzz8jCSOgXcey69tvTpm4m7rTTa1WhFR+hylH2h1bbWup0Mqd3a1wrojKLB+ZIwMvm/Yvkusa4bMNHXC4CqGT1Wy8jqXHXt3o+cUhvrv3AJ3uyxSAdSX8BM1meH4BoM53hrwPTBSPq2MbxwLmyWW2GwJida5SUGdTaMBNY50DrDlijyktyzyNNcicfFBfl/nRkPvACqz1umNaDRNUfAoihcgCS36eXoTRjI0+SYC8+8Veifd35oYiZou9En5VlsJ/OmoTJiyM/zLdDuykNVV5fI1d7cSdeXsuD1FsT0M72ezvR0WKxtMhDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo9uoM8g+06RL37EAe/IHcHuvDLEcXlSnLvB6vPP3Ng=;
 b=aSX1wbRz18bWubVlqgvq2oEYDDllYlCEVOduNINUIZeqZWOiO1ynOWSYAXzvDxkdy0YlcEgtANzXuC321mk42/9VjAlH2TXBET7wVZVnYrPOmp32PNJNyv1RvUc9hLwvF6LGT/VZQoq7gfqFti9K//gruOtxRBoexLXotdl7uCq5QOTtK40UxCxQX1zpgMgO9xNkFOIl3YFfyXt0N6mDIYn7enig66KkxzRwLWA2D+91xGF6IABeQIrL3O3FwZC5ERF1hLr/+atdqzwwoOa4Hl44vZazS5FRQ6dxt6CQp9fY0N8NfCGgp0V50qdvAKTkxD1zSdSkC/5acjfnod2Tyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo9uoM8g+06RL37EAe/IHcHuvDLEcXlSnLvB6vPP3Ng=;
 b=BhLFSEDpRMcpAcdZ2XJ8wruqDIVM4M9Y7hsXJgl7wDNqTUKq4O6/k0ncGvssrMZfu2QPGCecLUDsIRgY7DXQ2mbbUhWXSorVmQFh8Zv6Z/GBO7EbUIxfI1p2h/Cvzf4LXMcO3CKzH30F/iyN5NVXp5hSR4qRRvRZsBn9Jc+lV38PW8UvVg3JxUK5eVEU+6/noycORdcXPRoIpuVg8v57Wxcqg8x70UPKhkALH4fLHcR01rXYdv3y5X75FHCJRZL4KYWD3CnKyTH1LdFI11li+1mQkly7Zcw79XPro/yqSreOmiNvTGSY5AEczkU3UBGyJa62LevHm+m3D9SXUn2PaA==
Received: from PH1PEPF000132FF.namprd07.prod.outlook.com (2603:10b6:518:1::10)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 05:47:49 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2a01:111:f403:c95d::5) by PH1PEPF000132FF.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:47:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:47:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:47:30 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:47:17 -0800
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
Subject: [PATCH v4 30/32] gpu: nova-core: vgpu: scrub guest VRAM with CeUtils
Date: Fri, 6 Nov 2026 11:10:03 +0530
Message-ID: <c27ed3679ba8d9bd7cfa475f5d672e7b602cb80c.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 415452be-6c21-4872-a21b-08df3bc97c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|10067099003|22082099003|18002099003|3023799007|56012099006|261022115727099003|261022105027099003|5023799004|11063799006|261026121527099003|261028144727099003|261021135927099003|261022075727099003|261022113327099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	ccepk/VJzRUuo8iDcUw9kPO38X6PRXQiWxvIOZelLNrEozuAe18mfokKOYO1PdKjA2wP7fp12gva0Z70Wvem2tV6zQ4yw6qqFbBC5ZKQOEtWscbP+WN7/He5/jWUlMV6HNZeB2TSS8i4hxkvLXBw28wuprQ7WPxeWFoEpLDLz+cF0ocftC11xvJpP1iknFZ4QPoPnrb1h+daJ4atJ/JjVun8KSUZFwkheDkq65zbUqU0bYrrC5V1SMTZH5c1PrxLF1CTDqAL19OFOng+PeHDd4R4YwU34B5ZTAi2BjtlS7jiI5ffk0M9GJ+TN1dXIb42/f99n84QI7/r32bBbrc5eisH1PN9YIisUhfsw5HqV8jDNMuLaekQ3OAW0hA+M843qFt07IxgfQ7Q5ZrHWlxTK5i9kD6RnhnuNMxClII1wNZvAcDR5BMfpPMZ905hU4dRJGkq6S7aXteV2Sv/cIAxR3NQDI1KWCKYGy9VIyMtRbPLl/oTlZQaocJghFaUT4Oii8cquo6uzck26TmPYFq6+GTbpnPtxM9pJ47tOuvr4Ax6aiqpin8Ku7ajrolnVVZamAaeKjFsj6ju3PRMtABZZKIpA+AI5BQxVsjPHPPoq8emVviiUFdye0GNOXVOMTi6XXGOFN52qBJfnCGUYGXDiPyf46SFQDJoUjH1tr6fEbg2pjf8rbv3+76fq3glt1QfqwuEoToQP6ZT3Z2B2MFojA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(261022115727099003)(261022105027099003)(5023799004)(11063799006)(261026121527099003)(261028144727099003)(261021135927099003)(261022075727099003)(261022113327099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jbv+udKmnLY2OemuHNFN9H/NzJMrNMtXFT+Q9VE5xNyz76wn8oZLAfrO2VuOIcFYpymtupDdFlt0qT/l6z/qr62fVOu14AhR4Ur9mdwheb8l6pekcz9XhZOeli4/z+sp0eqmnsdKhLl2XVrM4mNtCISBkCjQA2zR+1v6waviYCmM6yR+5egAMuwotiPDbPk7SJAX6bzoCy/HPU62tEkgBSXMzYprToGNuCir+T5jomSl84Ts7/VwYGjTTiwGIXW0w317myihMbDIB/NGTCOEWdqA9HG6DlkieBvkRLbiAbUayWao5687OJYDrz7pWE1N+2G80mbxpBXyW5MHngwtuAbIjrs0n2SjZzE4XWjwMmQpHYh0Guuhxzvb422Zp+sjYuYYhvYQxM6kBvz+f9S6GMLgSVRDjLh8n1igc8IjeBcuRKOfyyJk38helloSiNLm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:47:47.4239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415452be-6c21-4872-a21b-08df3bc97c99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398

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
 drivers/gpu/nova-core/vgpu/instance.rs |  51 +++++++-
 drivers/gpu/nova-core/vgpu/scrubber.rs | 173 +++++++++++++++++++++++++
 4 files changed, 223 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/scrubber.rs

diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index d6bcdabafb42..f78a4621984a 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -38,6 +38,7 @@
 mod gsp_plugin_rpc;
 mod hal;
 mod instance;
+mod scrubber;
 mod vram;
 
 /// vGPU state detected during GPU construction.
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index 44ab9175313f..bb446d742e19 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -208,7 +208,6 @@ pub(super) fn set_plugin_bme(
 }
 
 /// Whether a failed allocation may still have transferred CHID ownership to firmware.
-#[expect(dead_code)]
 pub(super) enum CeUtilsAllocError {
     /// A matching firmware response explicitly rejected the allocation.
     NotOwned(Error),
@@ -217,7 +216,6 @@ pub(super) enum CeUtilsAllocError {
 }
 
 /// Allocate a CeUtils channel and validate its semaphore description.
-#[expect(dead_code)]
 pub(super) fn alloc_ceutils(
     dev: &device::Device<device::Bound>,
     cmdq: &Cmdq<'_>,
@@ -266,7 +264,6 @@ pub(super) fn alloc_ceutils(
 }
 
 /// Release a CeUtils allocation, including one whose allocation reply was lost.
-#[expect(dead_code)]
 pub(super) fn free_ceutils(
     dev: &device::Device<device::Bound>,
     cmdq: &Cmdq<'_>,
@@ -283,7 +280,6 @@ pub(super) fn free_ceutils(
 }
 
 /// Submit an asynchronous guest FB scrub and return its work identifier.
-#[expect(dead_code)]
 pub(super) fn submit_ceutils_scrub(
     dev: &device::Device<device::Bound>,
     cmdq: &Cmdq<'_>,
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 23c2b791aa25..1ccf4309f2ed 100644
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
         set_plugin_bme,
+        CeUtilsAllocError,
         Dbdf, //
     },
     fw::commands::{
@@ -47,6 +49,7 @@
     },
     gsp_plugin_comm::CommBufferRegion,
     gsp_plugin_rpc::PluginRpc,
+    scrubber::CeUtils,
     vram::{
         VgpuVramLayout,
         VgpuVramSlot,
@@ -151,12 +154,41 @@ struct VgpuInstance<'gpu> {
     // Unmap the communication region before returning its slot and channel IDs.
     vram_slot: VgpuVramSlot,
     chids: ChannelIdReservation<'gpu>,
+    ceutils: Option<CeUtils>,
     needs_teardown: bool,
     /// An uncertain or failed operation retains resources until device removal.
     failure: Option<Error>,
 }
 
 impl<'gpu> VgpuInstance<'gpu> {
+    fn initialize(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
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
     fn activate(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
         let dev = vgpu.dev;
         self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
@@ -175,7 +207,17 @@ fn teardown(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
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
@@ -241,7 +283,7 @@ fn configure_plugin(&mut self, dev: &device::Device<device::Bound>) -> Result {
             self.dbdf,
             self.vgpu_type.vgpu_type_id,
             self.vm_pid,
-            u32::try_from(self.chids.len()).map_err(|_| EOVERFLOW)?,
+            u32::try_from(self.chids.len().checked_sub(1).ok_or(EINVAL)?).map_err(|_| EOVERFLOW)?,
             self.num_plugin_channels,
         )?;
 
@@ -352,6 +394,9 @@ fn allocate_instance<'a>(
             .total_channels
             .checked_div(vgpu_type.max_instance)
             .ok_or(EINVAL)?;
+        if channels_per_instance <= 1 {
+            return Err(EINVAL);
+        }
         let channels_per_instance =
             usize::try_from(channels_per_instance).map_err(|_| EOVERFLOW)?;
         let channels_per_instance = NonZeroUsize::new(channels_per_instance).ok_or(EINVAL)?;
@@ -378,6 +423,7 @@ fn allocate_instance<'a>(
             plugin_rpc: PluginRpc::new(comm, bar0, gfid),
             vram_slot,
             chids,
+            ceutils: None,
             needs_teardown: false,
             failure: None,
         };
@@ -445,6 +491,7 @@ fn activate(mut self) -> Result {
             .iter_mut()
             .find(|instance| instance.gfid == self.gfid)
             .ok_or(EIO)?;
+        instance.initialize(self.vgpu)?;
         instance.activate(self.vgpu)?;
         self.committed = true;
         Ok(())
diff --git a/drivers/gpu/nova-core/vgpu/scrubber.rs b/drivers/gpu/nova-core/vgpu/scrubber.rs
new file mode 100644
index 000000000000..dc62ddc1ef01
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/scrubber.rs
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Per-VM CeUtils guest VRAM scrubbing.
+
+use kernel::{
+    device,
+    prelude::*,
+    sync::Mutex,
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
+        GpuMm,
+        Pfn,
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
+const SEMA_PAGE_MAGIC_OFFSET: usize = core::mem::offset_of!(CeUtilsSemaphoreHeader, magic);
+const SEMA_PAGE_PAYLOAD_OFFSET: usize = core::mem::offset_of!(CeUtilsSemaphoreHeader, payload);
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
+        mm: &Mutex<GpuMm<'_>>,
+        fb: &VramRegion,
+    ) -> Result {
+        let mut offset = fb.address();
+        let end = offset.checked_add(fb.size()).ok_or(EOVERFLOW)?;
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
+    mm: &Mutex<GpuMm<'_>>,
+    dev: &device::Device<device::Bound>,
+    semaphore_address: u64,
+    work_id: u32,
+) -> Result {
+    let pfn = Pfn::from(VramAddress::from_raw(semaphore_address));
+    let semaphore_map = bar_user.map(&mut mm.lock(), &[pfn], false)?;
+    let semaphore_map = ScopeGuard::new_with_data(semaphore_map, |mapping| {
+        if let Err(error) = mapping.release(&mut mm.lock()) {
+            dev_err!(
+                dev,
+                "failed to release semaphore BAR1 mapping: {:?}\n",
+                error
+            );
+        }
+    });
+
+    let result = (|| {
+        let magic = semaphore_map.try_read32(SEMA_PAGE_MAGIC_OFFSET)?;
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
+            let value = semaphore_map.try_read32(SEMA_PAGE_PAYLOAD_OFFSET)?;
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
+    let cleanup = semaphore_map.dismiss().release(&mut mm.lock());
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

