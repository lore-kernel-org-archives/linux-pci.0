Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944087;
	b=z/lQKjNUWIMkaJjmNf2blB/32qQmgm/oxDGzu34hqwNmsBpjaRvv/quUndgXszgzEmfW
	 WwZVZmmlK68hxb37/4zFc6RQSgCJzyi8CVPNUPOaNdnUFyBg+IDgNIrurpwYX6tqftHEH
	 6qw2mvG60Oo2w3Kn2s54wooH99LV6GVgjJ6q+anNPS8ebFMrFr295AwoooP1Di6JsKI/7
	 yxqIGGCnkFDNyZpcRuccbMfMc04w1X5npu/MBEiB8YmSrENuvLnyfENaC78o2v1/UFG0f
	 sl+yzYA0AIj/biwW7BV5S2/ARZdB5EmS8otmhiYt/SAphqsOgq6fm/HBmIq7SbuLU2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944087;
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
	bh=rf06tcm7becbsika+Ut9K6grwjaYAx6sPNa5yqWODyY=;
	b=S1oo94Uvp/M9QFYmMZcflrlE+H8SDf2h584+cUhbgQPZVEMVaGbNnaUTY4TuCig89CD8
	 4ldHLkcY4QhrWbNX0t3t0ARDaESspsgQv2Tu+eTyY8DgnQH/Tzxa/z3qYF3JruWJOY82w
	 QOqZzPR7/PPB6J+FuaIHRUx3BUZFxW5yWeJ4B2+zAqH2DXudE2iC74DYeV38SB/kHemsP
	 Oukz2xB0mS/TlLCH4yJHliXTNFUDca9jHiaZnx+sOqCh+iyMgyzQW11Kotv7hKuWuYZ7H
	 AJIEQW1WSrkmokYCt0RUbufQJHoU9Qiy9QszvMfWlvcWLSKAaAks2ikAOMHLW4U5ztA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XshvV8Ek;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.68
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36F606D833;
	Fri,  6 Nov 2026 05:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF36F606D833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XshvV8Ek
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whzsZb9RHxH6kryWI0rL2TBD4APohT2OwROjut5p3i61Na3dRwSqS/kHrTnvMYSAlQ8WdoZg6HxEJ+UqZt5kAsWV2V21y9PwZI8btwUPumBf1ja/VQCbxVppdhWjPn9W4+sqgDOAm+dLyd58KwDzsBxEiLSoW9cXjgxgep8RYVMN4w9b0PauTDftff7mNDLMkjUSgJv3IAmosv44xfT5pZEoXN5XKtAqe5PYAEdva04RxfBn/jL8vu14O77BtG+QXpU540WOaUSv+X4u43jG7MosltLFauCnkQlKX0A852ulYkVpJwTKHLsX+O3eaTE/o5NKVY363qbAWRQ5cUs9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf06tcm7becbsika+Ut9K6grwjaYAx6sPNa5yqWODyY=;
 b=BSuvjQb6+XFo5zZx3kYyDCLK+EPnTO86IAod3u7/hVLMATM3NTZcxAZT0eVVszdxUmxT4jNTPHW2dtPUE1shyjM2c6tKlfn++QzBTukHOEavv8EFIbb/CXxKvY0QngCn8OPsJTapLbRuByVhMbtBkdmTMhcWh9W6Ci0Y/D40HvbC8eomEkfMQ6J6GIZ/AhYQl5rJOAhZZmAU+YsUF0yeYl9/b0ml8cUTP0aiT+WAcrlPYXpJRgj6IbjRekEue8V+nA/LiW+n7mcU6ikX0BD/T+9uL99H8gQc72TRiQXXKcGDPtfXXZd/yxqom+jn8PusDCgliWiTrbUU8Q0nq3kGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf06tcm7becbsika+Ut9K6grwjaYAx6sPNa5yqWODyY=;
 b=XshvV8EkokGkdMxi38fqnuh/CsztKcq+lxh2UtSCbl/F9yMViGnKzB66he9ygB2X8osxz1IC/0vBKHN/SoCenOfUl8An1zfzMpag0YjNolk0O7tA6uREHXPliizXI9d9Oy8bD4/EB6wLLDE9qvjKZfvVGR0A/wZktE7vbHo2YExzISfMNqIQ0dVC9yKExJtomWhdFkMlJ/DawpBUdrEc1WwC2YqAyhZc+rECFX64r9MuFgKINUyYZC/+cMui06GX4sOnxFSWkPbfu0qGFTqNXz/rw985geaudmY3TvSKtFIbXcqTlud0wg5k2WNBWaU6795n7s20YpkwSZVBqwfq7g==
Received: from PH1PEPF00013311.namprd07.prod.outlook.com (2603:10b6:518:1::c)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:47:56 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2a01:111:f403:c95d::5) by PH1PEPF00013311.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:47:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:47:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:47:42 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:47:30 -0800
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
Subject: [PATCH v4 31/32] gpu: nova-core: vgpu: export plugin log buffers via debugfs
Date: Fri, 6 Nov 2026 11:10:04 +0530
Message-ID: <59935da9700aa41bee2ecc586dea40127b6adb4a.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cd7d57-ec39-4f45-5018-08df3bc98190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|261026140227099003|261021135927099003|11063799006|261022105027099003|261009223027099003|261026121527099003|261021121427099003|56012099006|261021123027099003|261028144727099003|261022075727099003|261022113327099003|10067099003|18002099003|261102123227099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	93Q2AWYnHPUzXwS66DB0aSr0Dg3sQlfeMJAQeHBw78jMYx0v7xIkyHQrtgEiDj65UpBzCar30yrU33TcCdd2oo6EgbO2QSxstohTssVEy0RI7j0AojuL7SGOs4EYYoG4Ql3ntl9sbJiMwTsvle4/sLrY+RC3dIKMurPsdYzMyHr+Cbf9sSK50Di2OZ5nBkgUmPRluf2abggPc3hDb1ZpcO03HG0d3B4pZvUytE2vCEJZQBNC90a70AKxcEzIl5zB7R3tvMVuuiyuQa3JOsSPBW3oxN2d26VEE/Q5ndv9Mp5U9mGTvcr8smN+VauvDuk9aqoW0aqWsBp4Vd0/2OqVo6OzVTtG95jjnPqsAL20f6xRjcXc4XsiMs8SDxG/hG3v53qIZ/6eJUjRwr0Z40mrRjnbxwNsvhRfxA+We7c/SB23ef6Uef2bf1yqwhGbj1mU28G7M8IzWJ8i29ZHxYwkqDzbcILnA0niZJdX2NtsczFCGqMQEmBYbVnKoBZCmUIWXqx1pfr37Rqsuv4sUR2yvD/fgAiU9RwE4QkdWdKRXSfCmkITGsso60LdVUuaGvLQFmtoTWyWebWlIk0OOXhJjyPbd4WWU64gF6Jdh1RKaZ6dOarVnauURXBIWGkEBGueE3jJ5rvxQy7oAUX5mL6b3yxqo66ixy9lUja8SJ6M2l7ciM2r1hEXSz0B6rH7QIhW2GSiHIptX9ljJ9HoDwfe9g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(261026140227099003)(261021135927099003)(11063799006)(261022105027099003)(261009223027099003)(261026121527099003)(261021121427099003)(56012099006)(261021123027099003)(261028144727099003)(261022075727099003)(261022113327099003)(10067099003)(18002099003)(261102123227099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	skGMGHTRd0/oBCBf+vf53t4t2EPb8aOA2tJruWFq5lcxL/WxAMm1d5jecclhbK1hZXevK7QuGVsBDmE4BMkcD8LxH7ziTuG78u6E59B1C/hHbsRh7M1HIgKGi09sQc98jJf/JutGfGEHtyGLuRgxrCPTFWrVzxzxl6DhCqglxI4mc7qn3jwqCR1eqei/c2lB1o96k/9Q9JONP60FNz0oaPcAY3ul0dHHntGYdHajiv8LM6NScVjshWZpQ9CXf3u0H3aYiaNasT6lPfCLaQ9fnP5PXRsYq2b0VT0mHsu5wk6517D7QMpsax8sydku2OiMEO+O/Z4wSLmhQptH8AzPpvGvvTZTDE/6TtYyVNnKYwXEndfbRb4hIMNzCxw3gOwOd70EFQihdvJcV8hNnpohxUu2wh4grJN8Sv78PKHd3tr73ZOgtW+/dzE4EFO27pwB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:47:55.7506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cd7d57-ec39-4f45-5018-08df3bc98190
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670

From: Zhi Wang <zhiw@nvidia.com>

Expose each instance's init, vgpu and kernel plugin logs through debugfs
for nvlog_decoder.

Read the management-heap log buffers through BAR1 and reuse the existing
GSP log header when a firmware build ID is available. Use the INIT, VGPU
and KRNL task names expected by the decoder, and derive the instance
directory name from the typed DBDF fields.
Retain the GPU identity and firmware build ID in the manager for
per-instance log headers.

Retain the mapping while the files are accessible and revoke the debugfs
scope before explicitly unmapping it. Place the scope before the RPC
mapping in the instance's field order so device removal also drains
readers before the mapping is dropped. Preserve partial-read accounting
when a user copy fails.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs                  |   9 +-
 drivers/gpu/nova-core/gsp.rs                  |  23 +++
 drivers/gpu/nova-core/mm/bar_user.rs          |   5 +-
 drivers/gpu/nova-core/vgpu.rs                 |  11 +-
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs | 116 +++++++++++-
 drivers/gpu/nova-core/vgpu/instance.rs        |  60 +++++-
 drivers/gpu/nova-core/vgpu/log.rs             | 171 ++++++++++++++++++
 7 files changed, 382 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/log.rs

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index da753bfc2df7..02145f16a2dd 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -630,9 +630,10 @@ pub(crate) fn new<'a>(
                         // SAFETY: These sibling fields are initialized at their final pinned
                         // addresses. The private manager cannot escape this `Gpu`, and is dropped
                         // before all its dependencies, both here on failure and on normal removal.
-                        let (cmdq, bar_user, mm, chid_pool) = unsafe {
+                        // The GSP build ID is not modified after initialization.
+                        let (gsp, bar_user, mm, chid_pool) = unsafe {
                             (
-                                &*core::ptr::from_ref(&gsp_resources.gsp.cmdq),
+                                &*core::ptr::from_ref(&gsp_resources.gsp),
                                 &*core::ptr::from_ref(bar_user.as_ref().get_ref()),
                                 &*core::ptr::from_ref(mm.as_ref().get_ref()),
                                 &*core::ptr::from_ref(chid_pool.as_ref().get_ref()),
@@ -640,7 +641,9 @@ pub(crate) fn new<'a>(
                         };
                         Some(KBox::pin_init(VgpuManager::new(
                             dev,
-                            cmdq,
+                            &gsp.cmdq,
+                            gsp_resources.spec,
+                            gsp.build_id(),
                             bar_user,
                             mm,
                             chid_pool,
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 7e10a1deeafe..e590fc9fbe3d 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -180,6 +180,21 @@ fn new(spec: Spec, build_id: &BuildId, task_prefix: &str) -> Self {
     }
 }
 
+/// Size of the header prepended to debugfs log buffer dumps.
+pub(crate) const LOG_BUFFER_HEADER_SIZE: usize = size_of::<LogBufferHeader>();
+
+/// Builds a log header using the GPU implementation reported by the hardware.
+pub(crate) fn build_log_buffer_header(
+    spec: Spec,
+    build_id: &BuildId,
+    task_prefix: &str,
+) -> [u8; LOG_BUFFER_HEADER_SIZE] {
+    let header = LogBufferHeader::new(spec, build_id, task_prefix);
+    let mut bytes = [0; LOG_BUFFER_HEADER_SIZE];
+    bytes.copy_from_slice(header.as_bytes());
+    bytes
+}
+
 /// The logging buffers are byte queues that contain encoded printf-like
 /// messages from GSP-RM.  They need to be decoded by a special application
 /// that can parse the buffers.
@@ -368,6 +383,8 @@ fn register_debugfs<'data>(&'data self, dir: &debugfs::ScopedDir<'data, '_>) {
 pub(crate) struct Gsp<'gsp> {
     /// The GSP firmware's TLV.
     gsp_tlv: firmware::Firmware,
+    /// Build identifier of the firmware whose log buffers are exposed.
+    build_id: Option<BuildId>,
     /// Libos arguments.
     pub(crate) libos: Coherent<'gsp, [LibosMemoryRegionInitArgument]>,
     /// Log buffers, optionally exposed via debugfs.
@@ -383,6 +400,11 @@ pub(crate) struct Gsp<'gsp> {
 }
 
 impl<'gsp> Gsp<'gsp> {
+    /// Returns the GSP firmware build identifier, when available.
+    pub(crate) fn build_id(&self) -> Option<&BuildId> {
+        self.build_id.as_ref()
+    }
+
     // Creates an in-place initializer for a `Gsp` manager for `pdev`.
     pub(crate) fn new(
         pdev: &'gsp pci::Device<device::Bound>,
@@ -405,6 +427,7 @@ pub(crate) fn new(
 
             Ok(try_pin_init!(Self {
                 gsp_tlv,
+                build_id,
                 cmdq <- Cmdq::new(dev, bar),
                 rm_state_monitor: Coherent::zeroed(dev, GFP_KERNEL)?,
                 rmargs: Coherent::init(
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 925bbefbddaf..ee718cf7668f 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -201,7 +201,6 @@ pub(crate) struct BarMapping<'map, 'gpu> {
     unmap_error: Option<Error>,
 }
 
-#[expect(dead_code)]
 impl<'map, 'gpu> BarMapping<'map, 'gpu> {
     /// Maps the containing pages while restricting CPU access to the requested byte range.
     pub(crate) fn new(
@@ -247,6 +246,10 @@ pub(crate) fn new(
         })
     }
 
+    pub(crate) fn bar1(&self) -> Bar1<'gpu> {
+        self.access.bar_user.bar1
+    }
+
     pub(crate) fn region(&self) -> &VramRegion {
         &self.region
     }
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index f78a4621984a..2dbf95222d4d 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -11,13 +11,15 @@
 };
 
 use crate::{
+    firmware::gsp::BuildId,
     fsp::{
         Fsp,
         VgpuMode, //
     },
     gpu::{
         ChannelIdPool,
-        Chipset, //
+        Chipset,
+        Spec, //
     },
     gsp::{
         cmdq::Cmdq,
@@ -38,6 +40,7 @@
 mod gsp_plugin_rpc;
 mod hal;
 mod instance;
+mod log;
 mod scrubber;
 mod vram;
 
@@ -113,6 +116,8 @@ pub(crate) struct VgpuManager<'gpu> {
     instances: Mutex<VgpuInstances<'gpu>>,
     dev: &'gpu device::Device<device::Bound>,
     cmdq: &'gpu Cmdq<'gpu>,
+    spec: Spec,
+    build_id: Option<&'gpu BuildId>,
     bar_user: &'gpu BarUser<'gpu>,
     mm: &'gpu Mutex<GpuMm<'gpu>>,
     chid_pool: &'gpu ChannelIdPool,
@@ -127,6 +132,8 @@ impl<'gpu> VgpuManager<'gpu> {
     pub(crate) fn new(
         dev: &'gpu device::Device<device::Bound>,
         cmdq: &'gpu Cmdq<'gpu>,
+        spec: Spec,
+        build_id: Option<&'gpu BuildId>,
         bar_user: &'gpu BarUser<'gpu>,
         mm: &'gpu Mutex<GpuMm<'gpu>>,
         chid_pool: &'gpu ChannelIdPool,
@@ -139,6 +146,8 @@ pub(crate) fn new(
             instances <- new_mutex!(VgpuInstances::new(), "nova-core::vgpu-instances"),
             dev,
             cmdq,
+            spec,
+            build_id,
             bar_user,
             mm,
             chid_pool,
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
index 3d2c69e8cd79..4f950020a398 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -4,18 +4,22 @@
 //! GSP plugin communication buffer mappings and access.
 
 use kernel::{
+    io::Io,
     num::casts::u32_as_usize,
     prelude::*,
     sync::Mutex, //
 };
 
-use crate::mm::{
-    bar_user::{
-        BarMapping,
-        BarUser, //
+use crate::{
+    driver::Bar1,
+    mm::{
+        bar_user::{
+            BarMapping,
+            BarUser, //
+        },
+        vram::VramRegion,
+        GpuMm, //
     },
-    vram::VramRegion,
-    GpuMm, //
 };
 
 use super::fw::{
@@ -59,6 +63,97 @@ fn take_region(region: &VramRegion, cursor: &mut u64, size: u32) -> Result<VramR
     Ok(subregion)
 }
 
+/// BAR1 view of one vGPU plugin log buffer.
+pub(super) struct MappedPluginLogBuffer<'gpu> {
+    bar1: Bar1<'gpu>,
+    gpu_va_addr: usize,
+    size: usize,
+}
+
+impl<'gpu> MappedPluginLogBuffer<'gpu> {
+    fn new(map: &BarMapping<'_, 'gpu>, region: &VramRegion) -> Result<Self> {
+        let start = region
+            .address()
+            .checked_sub(map.region().address())
+            .ok_or(EINVAL)
+            .and_then(|start| usize::try_from(start).map_err(|_| EOVERFLOW))?;
+        let size = usize::try_from(region.size()).map_err(|_| EOVERFLOW)?;
+        let end = start.checked_add(size).ok_or(EOVERFLOW)?;
+        if end > map.size() || !start.is_multiple_of(4) || !size.is_multiple_of(4) {
+            return Err(EINVAL);
+        }
+
+        let gpu_va_addr = usize::try_from(map.gpu_va_addr()?)
+            .map_err(|_| EOVERFLOW)?
+            .checked_add(start)
+            .ok_or(EOVERFLOW)?;
+        if !gpu_va_addr.is_multiple_of(4) {
+            return Err(EINVAL);
+        }
+
+        let bar1 = map.bar1();
+        if gpu_va_addr.checked_add(size).ok_or(EOVERFLOW)? > bar1.size() {
+            return Err(EINVAL);
+        }
+
+        Ok(Self {
+            bar1,
+            gpu_va_addr,
+            size,
+        })
+    }
+
+    pub(super) const fn size(&self) -> usize {
+        self.size
+    }
+
+    pub(super) fn read(&self, offset: usize, output: &mut [u8]) -> Result {
+        let end = offset.checked_add(output.len()).ok_or(EOVERFLOW)?;
+        if end > self.size {
+            return Err(EINVAL);
+        }
+
+        let mut source = offset;
+        let mut copied = 0usize;
+
+        while copied < output.len() {
+            let aligned_source = source & !3;
+            let within = source & 3;
+            let bar_offset = self
+                .gpu_va_addr
+                .checked_add(aligned_source)
+                .ok_or(EOVERFLOW)?;
+            let bytes = self.bar1.try_read32(bar_offset)?.to_le_bytes();
+            let chunk = (4 - within).min(output.len() - copied);
+
+            output[copied..copied + chunk].copy_from_slice(&bytes[within..within + chunk]);
+            source = source.checked_add(chunk).ok_or(EOVERFLOW)?;
+            copied += chunk;
+        }
+
+        Ok(())
+    }
+}
+
+/// BAR1 views of all vGPU plugin log buffers.
+pub(super) struct MappedPluginLogBuffers<'gpu> {
+    init: MappedPluginLogBuffer<'gpu>,
+    vgpu: MappedPluginLogBuffer<'gpu>,
+    kernel: MappedPluginLogBuffer<'gpu>,
+}
+
+impl<'gpu> MappedPluginLogBuffers<'gpu> {
+    pub(super) fn into_parts(
+        self,
+    ) -> (
+        MappedPluginLogBuffer<'gpu>,
+        MappedPluginLogBuffer<'gpu>,
+        MappedPluginLogBuffer<'gpu>,
+    ) {
+        (self.init, self.vgpu, self.kernel)
+    }
+}
+
 /// BAR1 mapping of the plugin communication region in its management heap.
 ///
 /// r000 layout, with byte offsets from the management heap (not to scale):
@@ -218,6 +313,15 @@ pub(super) fn plugin_logs(&self) -> PluginLogRegions {
         }
     }
 
+    /// Return BAR1 views that must stop being read before this mapping is destroyed.
+    pub(super) fn mapped_plugin_logs(&self) -> Result<MappedPluginLogBuffers<'gpu>> {
+        Ok(MappedPluginLogBuffers {
+            init: MappedPluginLogBuffer::new(&self.map, &self.init_log)?,
+            vgpu: MappedPluginLogBuffer::new(&self.map, &self.vgpu_log)?,
+            kernel: MappedPluginLogBuffer::new(&self.map, &self.kernel_log)?,
+        })
+    }
+
     /// Clear a previous boot marker before starting the plugin.
     pub(super) fn clear_plugin_ready(&self) -> Result {
         let offset = self.io_offset(
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 1ccf4309f2ed..82a568ee3779 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -7,10 +7,12 @@
 };
 
 use kernel::{
+    debugfs,
     device,
     prelude::*,
     ptr::Alignment,
     sizes::SizeConstants,
+    str::CString,
     time::{
         delay::fsleep,
         Delta,
@@ -21,7 +23,11 @@
 
 use crate::{
     driver::Bar0,
-    gpu::ChannelIdReservation,
+    firmware::gsp::BuildId,
+    gpu::{
+        ChannelIdReservation,
+        Spec, //
+    },
     gsp::{
         cmdq::Cmdq,
         commands::FifoEngineList, //
@@ -47,8 +53,12 @@
         BootloadInfo,
         ChannelMapEntry, //
     },
-    gsp_plugin_comm::CommBufferRegion,
+    gsp_plugin_comm::{
+        CommBufferRegion,
+        MappedPluginLogBuffers, //
+    },
     gsp_plugin_rpc::PluginRpc,
+    log::VgpuLogBuffers,
     scrubber::CeUtils,
     vram::{
         VgpuVramLayout,
@@ -150,6 +160,7 @@ struct VgpuInstance<'gpu> {
     vgpu_type: VgpuType,
     vm_pid: u32,
     num_plugin_channels: u32,
+    debugfs_logs: Option<Pin<KBox<debugfs::Scope<VgpuLogBuffers<'gpu>>>>>,
     plugin_rpc: PluginRpc<'gpu, 'gpu>,
     // Unmap the communication region before returning its slot and channel IDs.
     vram_slot: VgpuVramSlot,
@@ -197,6 +208,20 @@ fn activate(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
         self.configure_plugin(dev)?;
         set_plugin_bme(dev, &mut self.plugin_rpc, true)?;
 
+        match self
+            .plugin_rpc
+            .comm()
+            .mapped_plugin_logs()
+            .and_then(|buffers| create_debugfs_logs(buffers, self.dbdf, vgpu.spec, vgpu.build_id))
+        {
+            Ok(logs) => self.debugfs_logs = Some(logs),
+            Err(error) => dev_warn!(
+                dev,
+                "debugfs logs unavailable for gfid={}: {:?}\n",
+                self.gfid.get(),
+                error,
+            ),
+        }
         Ok(())
     }
 
@@ -222,6 +247,8 @@ fn teardown(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
                 send_cleanup(vgpu.dev, vgpu.cmdq, self.gfid)?;
                 self.needs_teardown = false;
             }
+            // Debugfs readers use BAR1 offsets directly and must finish before unmapping.
+            self.debugfs_logs = None;
             self.plugin_rpc.unmap()
         })();
         if let Err(error) = result {
@@ -320,6 +347,34 @@ pub(super) const fn new(gfid: Gfid, dbdf: Dbdf, vgpu_type: VgpuType, vm_pid: u32
     }
 }
 
+fn create_debugfs_logs<'gpu>(
+    buffers: MappedPluginLogBuffers<'gpu>,
+    dbdf: Dbdf,
+    spec: Spec,
+    build_id: Option<&BuildId>,
+) -> Result<Pin<KBox<debugfs::Scope<VgpuLogBuffers<'gpu>>>>> {
+    let logs = VgpuLogBuffers::new(buffers, spec, build_id);
+    let directory = CString::try_from_fmt(fmt!(
+        "{:04x}:{:02x}:{:02x}.{:x}-vgpu",
+        dbdf.domain(),
+        dbdf.bus(),
+        dbdf.device(),
+        dbdf.function(),
+    ))?;
+
+    #[allow(static_mut_refs)]
+    // SAFETY: The root is initialized before driver registration and cleared
+    // only after driver unregistration has drained all users.
+    let root = unsafe { crate::DEBUGFS_ROOT.as_ref() }.ok_or(ENODEV)?;
+
+    KBox::pin_init(
+        root.scope(logs, &directory, |logs, directory| {
+            VgpuLogBuffers::register_debugfs(logs, directory);
+        }),
+        GFP_KERNEL,
+    )
+}
+
 /// Registry of live vGPU instances.
 pub(super) struct VgpuInstances<'gpu> {
     instances: KVec<VgpuInstance<'gpu>>,
@@ -420,6 +475,7 @@ fn allocate_instance<'a>(
             vgpu_type,
             vm_pid,
             num_plugin_channels: PLUGIN_CHANNELS_PER_ENGINE,
+            debugfs_logs: None,
             plugin_rpc: PluginRpc::new(comm, bar0, gfid),
             vram_slot,
             chids,
diff --git a/drivers/gpu/nova-core/vgpu/log.rs b/drivers/gpu/nova-core/vgpu/log.rs
new file mode 100644
index 000000000000..30a33bd6723e
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/log.rs
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! GSP plugin logs exposed through debugfs.
+//!
+//! With debugfs mounted at `/sys/kernel/debug`, the directory uses the VF's
+//! PCI domain:bus:device.function address:
+//!
+//! ```text
+//! /sys/kernel/debug/nova-core/<VF-DBDF>-vgpu/
+//! |-- init_log
+//! |-- vgpu_log
+//! `-- kernel_log
+//! ```
+
+use kernel::{
+    debugfs,
+    fs::file,
+    prelude::*,
+    uaccess::UserSliceWriter, //
+};
+
+use crate::{
+    firmware::gsp::BuildId,
+    gpu::Spec,
+    gsp::{
+        build_log_buffer_header,
+        LOG_BUFFER_HEADER_SIZE, //
+    },
+    vgpu::gsp_plugin_comm::{
+        MappedPluginLogBuffer,
+        MappedPluginLogBuffers, //
+    },
+};
+
+const LOG_READ_CHUNK_SIZE: usize = 4096;
+
+/// A vGPU plugin log buffer backed by VRAM, read via BAR1 MMIO.
+///
+/// An optional header lets `nvlog_decoder` identify the GPU architecture and firmware build.
+struct VgpuLogBuffer<'gpu> {
+    buffer: MappedPluginLogBuffer<'gpu>,
+    header: [u8; LOG_BUFFER_HEADER_SIZE],
+    header_len: usize,
+}
+
+impl<'gpu> VgpuLogBuffer<'gpu> {
+    fn new(
+        buffer: MappedPluginLogBuffer<'gpu>,
+        spec: Spec,
+        build_id: Option<&BuildId>,
+        task_prefix: &str,
+    ) -> Self {
+        let (header, header_len) = match build_id {
+            Some(bid) => (
+                build_log_buffer_header(spec, bid, task_prefix),
+                LOG_BUFFER_HEADER_SIZE,
+            ),
+            None => ([0u8; LOG_BUFFER_HEADER_SIZE], 0),
+        };
+
+        Self {
+            buffer,
+            header,
+            header_len,
+        }
+    }
+}
+
+impl debugfs::BinaryWriter for VgpuLogBuffer<'_> {
+    fn write_to_slice(
+        &self,
+        writer: &mut UserSliceWriter,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        if offset.is_negative() {
+            return Err(EINVAL);
+        }
+
+        let offset_val: usize = (*offset).try_into().map_err(|_| EINVAL)?;
+        let total_len = self
+            .header_len
+            .checked_add(self.buffer.size())
+            .ok_or(EOVERFLOW)?;
+
+        if offset_val >= total_len {
+            return Ok(0);
+        }
+
+        let count = (total_len - offset_val).min(writer.len());
+        if count == 0 {
+            return Ok(0);
+        }
+
+        // Keep the staging buffer on the heap to avoid a page-sized kernel stack object.
+        let staging_size = count.min(LOG_READ_CHUNK_SIZE);
+        let mut staging = KVec::new();
+        staging.resize(staging_size, 0, GFP_KERNEL)?;
+
+        let mut written = 0usize;
+        let result: Result = (|| {
+            while written < count {
+                let chunk_len = (count - written).min(staging.len());
+                let chunk = &mut staging[..chunk_len];
+                let chunk_offset = offset_val.checked_add(written).ok_or(EOVERFLOW)?;
+                let mut filled = 0usize;
+
+                if chunk_offset < self.header_len {
+                    let header_len = (self.header_len - chunk_offset).min(chunk_len);
+                    chunk[..header_len]
+                        .copy_from_slice(&self.header[chunk_offset..chunk_offset + header_len]);
+                    filled = header_len;
+                }
+
+                if filled < chunk_len {
+                    let log_offset = chunk_offset
+                        .checked_add(filled)
+                        .ok_or(EOVERFLOW)?
+                        .checked_sub(self.header_len)
+                        .ok_or(EINVAL)?;
+
+                    self.buffer.read(log_offset, &mut chunk[filled..])?;
+                }
+
+                writer.write_slice(chunk)?;
+                written = written.checked_add(chunk_len).ok_or(EOVERFLOW)?;
+            }
+            Ok(())
+        })();
+        if written == 0 {
+            result?;
+        }
+
+        *offset = (*offset)
+            .checked_add(i64::try_from(written).map_err(|_| EOVERFLOW)?)
+            .ok_or(EOVERFLOW)?;
+        Ok(written)
+    }
+}
+
+/// The three plugin log streams for one vGPU instance.
+pub(super) struct VgpuLogBuffers<'gpu> {
+    init_log: VgpuLogBuffer<'gpu>,
+    vgpu_log: VgpuLogBuffer<'gpu>,
+    kernel_log: VgpuLogBuffer<'gpu>,
+}
+
+impl<'gpu> VgpuLogBuffers<'gpu> {
+    pub(super) fn new(
+        buffers: MappedPluginLogBuffers<'gpu>,
+        spec: Spec,
+        build_id: Option<&BuildId>,
+    ) -> Self {
+        let (init, vgpu, kernel) = buffers.into_parts();
+
+        Self {
+            init_log: VgpuLogBuffer::new(init, spec, build_id, "INIT"),
+            vgpu_log: VgpuLogBuffer::new(vgpu, spec, build_id, "VGPU"),
+            kernel_log: VgpuLogBuffer::new(kernel, spec, build_id, "KRNL"),
+        }
+    }
+
+    pub(super) fn register_debugfs<'data, 'dir>(
+        logs: &'data Self,
+        dir: &'dir debugfs::ScopedDir<'data, 'dir>,
+    ) {
+        dir.read_binary_file(c"init_log", &logs.init_log);
+        dir.read_binary_file(c"vgpu_log", &logs.vgpu_log);
+        dir.read_binary_file(c"kernel_log", &logs.kernel_log);
+    }
+}
-- 
2.53.0

