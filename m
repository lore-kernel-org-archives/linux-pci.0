Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529290;
	b=PuwP4Hip6lWrjSJSF9e9XrZJO7Mu7pdqlVOml0ESzWfJXAV4toLSEEv73CsyEE8O5XZC
	 JaMAIyd9l5YDguu7vFzSNaVSjBGY4CkGiMnjLjOtj06fDp4cXcYiDKnGT0enyuoqun4B1
	 QnfT6TUocZ1hv/HGOHDbhxgbELf3jOjJ6GhaTfGL8km52baCPWQowSHeoLLtz5ER/prJX
	 MHiRUTumOA/y95oBe2tJH3hLlIU8z5tsqZ1BFFDU8px6nP7Gnb9QdDBak5upXOeenC84m
	 A9x7hZzNZJYTL6fNLBeM9n5tHniJ9UMRgKR4Hxvy2QPSfnhwTuTS9KyLEIsvi8L1MbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529290;
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
	bh=v8MtKMCsvBsN/HXOCKRbAMPEpNotgopOGsyWK61OL3E=;
	b=L42V9WD5FqpfvnfmOgg5lCx7DDAKpvaPo1EmEM9ZTGCOrwYFbYMtUvaJTByrw5CQOmQS
	 pf2j1uq/c+Pr4NuGar6g7VacibF5yknP2UxIzRYST32Qa5kYzYDxHC7yO1DgXBo4l5DRh
	 otjauh3/bzhlYLSVjYilEYXiRCoC7BIi2hxUu0wq5peXQeJqJ5mlBAbnIx3+MQ7vh4FdT
	 31zgdUp7XH/zb6JERXYFOvdtmRAt/d65RWvgxSB4RKU1rqJ/XEtJawtlbc1nTFeUcev1e
	 mfjrOtrleNrLLrWBpcBpT5admJx90qMVARK4qDohEDetstdqaR8+qhg6ovp/+UAyyog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="r9fpcm/D";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.59
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF839606B03D;
	Tue, 24 Nov 2026 14:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF839606B03D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r9fpcm/D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlT57UR8Q192xuME6AVrPqlFfmQAEzzPOki/KS3BifBdIHiVhaBgM1+TtaHIh5X3L2kQ1xFDjPJDAJZD6U1uTvwb3/EPfbrcZHyHPlikNvrJiyDuPL4YcPq4aHWE+Co+vLpFsbOxrNOHNpW3uG/v1CTG5d2dEG0/sQd5/U3NBiCpF9gicEJxvg0On/TwyEklEQzzI6CUnL0+3i5AmhKhD1uUqTwepZUxGFVVyizw4i+AAk/eIWHNBX/WOY8K8CXYfTKCOByrx5OSCnuvrI+YFVGrDP0JFvjEQ0m1cVfiRw14yHFGA3NI0l2kUsv9wuviddaOFVQNRAFezyfSA9R0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8MtKMCsvBsN/HXOCKRbAMPEpNotgopOGsyWK61OL3E=;
 b=lN8s+xq9iL6qHUITCuAZyZrb9Zoi02g19w0pRLgXYYYxWp+vM1eg5OpUM40OVjYmuRHTRX4qd+dcIBFfLoncSMZGbLPCmp/xc/GnK66hN+RZkOYfXmVrKieTCd7GAFJ66m7N9rAnKpe/JNuJ389oswPHzX4XW7HWskHUiOlJVLC9iZFVyFzbejyZiI3pmal2dHvTe0LgyycDCNrkODoRL9r+DJBWKndmSlGXylJoEA9e3QOphSkT88Tz7xuvsNWOutWyjCREdFg/LTElL+NMYY/YyiyuaHaTuGEnMDCny/k8GvF9pleQKnV0HZcNWX5KQLx/+XtWaYTd9ptSkjHT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8MtKMCsvBsN/HXOCKRbAMPEpNotgopOGsyWK61OL3E=;
 b=r9fpcm/Dmm+jp2OgF61b7WNVuFErG9nOGpcm7/iW2kpGilDpapukaM9CgPyAuN3vQLiLDB57U91R3WFvkihj1UFgj5gOQ3dxZjZIRg9dyTR4of7K5Azs2H5LHjQQo8TOsM6aKPc22paJOviCug1UBuDJ0i1NpGoB26ySHUXXlHfJKK8pqeFsbVLXPpiMQ/PkXpMOE/0LYTttffn4Q2h0z6iudD31r/PH5L1TIp5xGyJ+c5EwcSW6smm+yxe+XCNMm1XX8bBYxb61zCGBFib0ralsyPFaht6t7aBbFT8vVN9lv7ObRNgeKHQ8Pexim8SmQwy/Fx47HD8sCjVJ05igRA==
Received: from PH7P221CA0089.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::7)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:07:54 +0000
Received: from CY6PEPF00000048.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::ae) by PH7P221CA0089.outlook.office365.com
 (2603:10b6:510:328::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:07:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF00000048.mail.protection.outlook.com (10.167.247.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:07:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:07:33 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:07:19 -0800
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
Subject: [PATCH v5 34/35] gpu: nova-core: vgpu: introduce SR-IOV PF APIs
Date: Tue, 24 Nov 2026 19:29:30 +0530
Message-ID: <20261124135937.18583-35-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF00000048:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: dda4570a-cc84-4c48-5993-08df4a34557f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|7416014|376014|6133799003|22082099003|18002099003|3023799007|56012099006|261021135927099003|11063799006|261028144727099003|261102123227099003|261026140227099003|261022075727099003|261022113327099003|261021123027099003|261026121527099003|261021121427099003|261009223027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	APUQWrEmvp2n8YuH6I2PpuCuyShBn5S8u0x92BONCX0sC1mkixjMRGTKkfeqeHOpQ+2QlbvsyT3cN44dMsI4x49FiX6azTXu00kvjmh+66rMr8x8pBZ/PQVPPA1XjmNxEJcG/r3r3xSM+5uQ+PqS8BttsupV5yN0cXh87XRZWdHZ4ufz+LN86xHZ0q5LChZWfYDQ9DRVBWR0iaHM4aSLvJ08678A+Rfl/Qhp1KiAJPKSj91sh/zlHULqw6yOgdD9Qn1/G0QdxMWS09x0u2TC9DuKqcHIkGBvXieHKm/p4Dtl2HXlYBpCQ+ToQGV24G+ttpXbgAkSh8y9CRCtCo2KZLIFQHvUjChQTHFUiOAtyWDrJlY5wl1QiZ+F470Mf8lrS4B8WNUVkS4b5Ge2NcTQ03h4IryvrmbuKGj3vQg89fkzsAjo3uGHOjSK5wbyFEGh+LhWdTM1nIy+6PCS1W17Mh0bGJL47m8qqwU3pEWeZP4dSAsiDTa4VbL1eoGirLcdIpZgWfo7SFt9RwtLLsuMl4d4Af1OhBUgLKi4gQ5tzjyoby8VqPY7iLVixgxdelx/+Hlmvr9ZK6LYAhgIfa3HwcUFVxV420BmFfpQUiQ6rxHQHUVxCpb5e89lFriLDRURGkNrUNX9ayf1ZVgIgRd7h5mOCkhNjjZ8kpqdpQwBTOfO4dEwg+ZKmcb3Zi19i6HWonF6jiN7VAebKEfBom3gKw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(261021135927099003)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022113327099003)(261021123027099003)(261026121527099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RpGhpDJe9WRMXVp/gIVeRm6QxazeGPR5pRBmthRM97y8qyu+3BZbaY4hvYQ5WD1OyIhBIotFE6NNL0hJnI9Yf12shLUkz6ImpD7HeQgAazZNsBhehU/vN+yKeP78FQZEFl5vs1or8xJ38L85fDGpVLSyKVnLuXdNC8UNmgup8Az4mLaJb+JP5BaycJ6pch6EgX2e8zyoJtVUumy9AM451PcK2hal7ZRrzn5WIZ4GzNPVA7WxCkeARgOspy0enEVXXHisweKU1rdkZ+HqrkPIcGOKSLeP3OA4oy18oQOLXUxk8z0VAU5j2ySEEiAVSJ1ecYPhfM/Q8Fga4U/m9Ymz5ZuJpcG6forlJLijFaii/TdyFjiXQjiXSc/zHNJ7yjAhmfuR9nZz38v4gKB50Gm9r1nQXLKDPlY61F4Ittqp1c//2+5hWV65v7qn8VYA+5eV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:07:54.2414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda4570a-cc84-4c48-5993-08df4a34557f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000048.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493

From: Zhi Wang <zhiw@nvidia.com>

Provide PF operations for querying vGPU availability and creating,
closing and resetting VF instances.

Validate VF identifiers against the PF's VF count and route lifecycle
operations through the manager. Retain the GPU context needed to create
plugin RPC channels and return guest PCI properties after activation.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs                  |  20 ++-
 drivers/gpu/nova-core/mm/bar_user.rs          |   1 -
 drivers/gpu/nova-core/mm/vram.rs              |   1 -
 drivers/gpu/nova-core/nova_core.rs            |   6 +
 drivers/gpu/nova-core/vgpu.rs                 |   2 +
 drivers/gpu/nova-core/vgpu/commands.rs        |  10 +-
 drivers/gpu/nova-core/vgpu/fw/commands.rs     |   1 +
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs |   2 -
 drivers/gpu/nova-core/vgpu/instance.rs        |  57 ++++++-
 drivers/gpu/nova-core/vgpu/vgpu_api.rs        | 153 ++++++++++++++++++
 drivers/gpu/nova-core/vgpu/vram.rs            |   1 -
 11 files changed, 242 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/vgpu_api.rs

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0de451fc3d7b..a2f78dfb1121 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use core::ops::Range;
+use core::{
+    num::NonZero,
+    ops::Range, //
+};
 
 use kernel::{
     device,
@@ -468,6 +471,21 @@ fn drop(self: Pin<&mut Self>) {
 }
 
 impl<'gpu> Gpu<'gpu> {
+    pub(crate) fn cmdq(&self) -> &Cmdq<'gpu> {
+        &self.gsp_resources.gsp.cmdq
+    }
+
+    pub(crate) fn vgpu_manager(&self) -> Option<&VgpuManager<'_>> {
+        self.vgpu().as_ref().map(|vgpu| vgpu.as_ref().get_ref())
+    }
+
+    pub(crate) fn vgpu_total_vfs(&self) -> Option<NonZero<u16>> {
+        match self.gsp_resources.vgpu_state {
+            VgpuState::Disabled => None,
+            VgpuState::Enabled { total_vfs } => Some(total_vfs),
+        }
+    }
+
     pub(crate) fn new<'a>(
         pdev: &'gpu pci::Device<device::Core<'a>>,
         bar: Bar0<'gpu>,
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 75970cb0b5cb..e0fc62630fbe 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -185,7 +185,6 @@ pub(crate) struct BarMapping<'map, 'gpu> {
     unmap_error: Option<Error>,
 }
 
-#[expect(dead_code)]
 impl<'map, 'gpu> BarMapping<'map, 'gpu> {
     /// Maps `region`, which must start and end on a page boundary.
     pub(crate) fn new(
diff --git a/drivers/gpu/nova-core/mm/vram.rs b/drivers/gpu/nova-core/mm/vram.rs
index 7774b15e4c89..6054eed9aeb0 100644
--- a/drivers/gpu/nova-core/mm/vram.rs
+++ b/drivers/gpu/nova-core/mm/vram.rs
@@ -74,7 +74,6 @@ pub(crate) struct VramRegion {
     range: Range<u64>,
 }
 
-#[expect(dead_code)]
 impl VramRegion {
     /// Returns the range covered by this region.
     pub(crate) const fn range(&self) -> &Range<u64> {
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 84f777844592..418571724543 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -34,6 +34,12 @@
 
 use debugfs::DebugfsData;
 
+#[cfg(CONFIG_PCI_IOV)]
+pub use vgpu::vgpu_api::{
+    NovaCoreVfApi,
+    VgpuTypeInfo, //
+};
+
 pub(crate) const MODULE_NAME: &core::ffi::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
 /// Pointer to the [`DebugfsData`] of the module.
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index e1e2d6bcfd31..1aee21dbe740 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -42,6 +42,8 @@
 mod hal;
 mod instance;
 mod scrubber;
+#[cfg_attr(not(CONFIG_PCI_IOV), expect(dead_code, unreachable_pub))]
+pub(crate) mod vgpu_api;
 mod vram;
 
 bitfield! {
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index 07a8e071d34d..ae2ae3b69a1c 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -83,7 +83,6 @@ fn read(payload: &mut MessagePayload<'_>) -> Result<Self, Self::InitError> {
 }
 
 /// Query the vGPU type assigned to a VF by its DBDF.
-#[expect(dead_code)]
 pub(super) fn query_assigned_vf_type(
     _dev: &device::Device,
     cmdq: &Cmdq<'_>,
@@ -126,7 +125,6 @@ fn read(payload: &mut MessagePayload<'_>) -> Result<Self, Self::InitError> {
 }
 
 /// Query and decode the firmware properties of one vGPU type.
-#[expect(dead_code)]
 pub(super) fn query_vgpu_properties(
     _dev: &device::Device,
     cmdq: &Cmdq<'_>,
@@ -263,6 +261,14 @@ pub(super) fn set_plugin_bme(
     rpc.rpc_call_nvkv(dev, RpcMessage::UpdateBmeState, &bme)
 }
 
+/// Reset an active GSP plugin.
+pub(super) fn reset_plugin(
+    dev: &device::Device<device::Bound>,
+    rpc: &mut PluginRpc<'_, '_>,
+) -> Result {
+    rpc.rpc_call(dev, RpcMessage::Reset, &[])
+}
+
 impl CommandToGsp for AllocCeutilsRequest {
     const COMMAND: GmcCommandId = GmcCommandId::VgpuMgrAllocGspCeutils;
     type Command = Self;
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index c2e2ffad2b2d..7cb2db63c3a0 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -37,6 +37,7 @@
 pub(crate) enum RpcMessage {
     VersionNegotiation = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_VERSION_NEGOTIATION,
     SetupConfigParamsAndInit = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_SETUP_CONFIG_PARAMS_AND_INIT,
+    Reset = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_RESET,
     UpdateBmeState = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_UPDATE_BME_STATE,
 }
 
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
index 49d85df70018..f9fd8c2a5da0 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -80,7 +80,6 @@ struct CommBuffer {
 static_assert!(size_of::<RawResponseRegion>() == cv!(fw::VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE));
 
 /// Physical VRAM regions containing the vGPU plugin logs.
-#[expect(dead_code)]
 pub(super) struct PluginLogRegions {
     pub(super) init: VramRegion,
     pub(super) vgpu: VramRegion,
@@ -94,7 +93,6 @@ pub(super) struct CommBufferRegion<'map, 'gpu> {
     map: BarMapping<'map, 'gpu>,
 }
 
-#[expect(dead_code)]
 impl<'map, 'gpu> CommBufferRegion<'map, 'gpu> {
     /// Map the communication portion of a plugin management heap.
     pub(super) fn new(
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 2f6c2a8f3a02..5c6353f8c09a 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -33,6 +33,7 @@
     commands::{
         free_ceutils,
         negotiate_plugin_version,
+        reset_plugin,
         send_bootload,
         send_cleanup,
         send_plugin_config,
@@ -56,6 +57,7 @@
         VgpuVramSlotPool, //
     },
     Dbdf,
+    VgpuManager,
     VgpuManagerInner, //
 };
 
@@ -112,7 +114,6 @@ fn wait_plugin_ready(dev: &device::Device, comm: &CommBufferRegion<'_, '_>) -> R
 
 impl Gfid {
     /// Validates an external GFID for a device supporting `total_vfs` VFs.
-    #[expect(dead_code)]
     pub(super) fn new(gfid: u32, total_vfs: NonZero<u16>) -> Result<Self> {
         let gfid = u16::try_from(gfid).map_err(|_| EINVAL)?;
         let gfid = NonZero::new(gfid).ok_or(EINVAL)?;
@@ -160,6 +161,7 @@ struct VgpuInstance<'gpu> {
     vram_slot: VgpuVramSlot,
     chids: ChannelIdReservation<'gpu>,
     ceutils: Option<CeUtils>,
+    active: bool,
     needs_teardown: bool,
     /// An uncertain or failed operation retains resources until device removal.
     failure: Option<Error>,
@@ -202,6 +204,7 @@ fn activate(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
         self.configure_plugin(dev)?;
         set_plugin_bme(dev, &mut self.plugin_rpc, true)?;
 
+        self.active = true;
         Ok(())
     }
 
@@ -301,6 +304,7 @@ fn shutdown(&mut self, dev: &device::Device, cmdq: &Cmdq<'_>) -> Result {
             send_shutdown(dev, cmdq, self.gfid)?;
             dev_dbg!(dev, "shutdown: gfid={} stopped\n", self.gfid.get());
         }
+        self.active = false;
         Ok(())
     }
 }
@@ -313,7 +317,6 @@ pub(super) struct InstanceInfo {
     vm_pid: u32,
 }
 
-#[expect(dead_code)]
 impl InstanceInfo {
     pub(super) fn new(gfid: Gfid, dbdf: Dbdf, properties: &VgpuProperties, vm_pid: u32) -> Self {
         Self {
@@ -331,7 +334,6 @@ pub(super) struct VgpuInstances<'gpu> {
     vram_slots: Option<VgpuVramSlotPool>,
 }
 
-#[expect(dead_code)]
 impl<'gpu> VgpuInstances<'gpu> {
     pub(super) const fn new() -> Self {
         Self {
@@ -428,6 +430,7 @@ fn allocate_instance(
             vram_slot,
             chids,
             ceutils: None,
+            active: false,
             needs_teardown: false,
             failure: None,
         })
@@ -468,13 +471,27 @@ pub(super) fn release_all(&mut self, vgpu: &VgpuManagerInner<'gpu>) {
     }
 }
 
+impl VgpuManager<'_> {
+    /// Allocate, register, and activate a vGPU instance.
+    pub(super) fn create_instance(&self, info: InstanceInfo) -> Result {
+        self.with_inner(|inner| inner.create_instance(info))
+    }
+
+    pub(super) fn close_instance(&self, gfid: Gfid) -> Result {
+        self.with_inner(|inner| inner.close_instance(gfid))
+    }
+
+    pub(super) fn reset_instance(&self, gfid: Gfid) -> Result {
+        self.with_inner(|inner| inner.reset_instance(gfid))
+    }
+}
+
 impl VgpuManagerInner<'_> {
     /// Allocate, register, and activate a vGPU instance.
     ///
     /// Keep the registry locked through creation or rollback so duplicate checks and
     /// type limits remain stable. MM and BAR-user locks are acquired only within
     /// individual memory operations, in that order.
-    #[expect(dead_code)]
     fn create_instance(&self, info: InstanceInfo) -> Result {
         let mut instances = self.instances.lock();
 
@@ -507,4 +524,36 @@ fn create_instance(&self, info: InstanceInfo) -> Result {
 
         result
     }
+
+    fn close_instance(&self, gfid: Gfid) -> Result {
+        self.instances.lock().destroy_instance(self, gfid)
+    }
+
+    fn reset_instance(&self, gfid: Gfid) -> Result {
+        let mut instances = self.instances.lock();
+        let instance = instances
+            .instances
+            .iter_mut()
+            .find(|instance| instance.gfid == gfid)
+            .ok_or(ENOENT)?;
+        if instance.failure.is_some() || !instance.active {
+            return Err(EBUSY);
+        }
+
+        let result = (|| {
+            reset_plugin(self.dev, &mut instance.plugin_rpc)?;
+            instance.ceutils.as_ref().ok_or(EINVAL)?.scrub_guest_fb(
+                self.dev,
+                self.cmdq,
+                self.bar_user,
+                self.mm,
+                &instance.vram_slot.fbmem,
+            )
+        })();
+        if let Err(error) = result {
+            instance.failure = Some(error);
+            instance.active = false;
+        }
+        result
+    }
 }
diff --git a/drivers/gpu/nova-core/vgpu/vgpu_api.rs b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
new file mode 100644
index 000000000000..b263e96098a8
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! PF-owned lifecycle operations for Nova VF drivers.
+
+use core::num::NonZero;
+
+use kernel::{
+    device,
+    pci,
+    prelude::*, //
+};
+
+use crate::{
+    gpu::Gpu,
+    gsp::cmdq::Cmdq,
+    vgpu::{
+        commands::query_vgpu_properties,
+        fw::commands::VgpuProperties,
+        instance::{
+            Gfid,
+            InstanceInfo, //
+        },
+    },
+};
+
+use super::{
+    commands::query_assigned_vf_type,
+    Dbdf,
+    VgpuManager, //
+};
+
+/// Guest PCI properties of an activated vGPU instance.
+pub struct VgpuTypeInfo {
+    /// PCI device ID to present to the guest.
+    pub pci_dev_id: u32,
+    /// PCI subsystem ID to present to the guest.
+    pub pci_subsys_id: u32,
+    /// BAR1 aperture size in MiB.
+    pub bar1_length: u64,
+}
+
+impl From<&VgpuProperties> for VgpuTypeInfo {
+    fn from(vgpu_properties: &VgpuProperties) -> Self {
+        Self {
+            pci_dev_id: vgpu_properties.dev_id,
+            pci_subsys_id: vgpu_properties.subsystem_id,
+            bar1_length: vgpu_properties.bar1_length,
+        }
+    }
+}
+
+/// PF-owned operations available while a VF driver is bound.
+pub struct NovaCoreVfApi<'gpu> {
+    pdev: &'gpu pci::Device<device::Bound>,
+    cmdq: &'gpu Cmdq<'gpu>,
+    vgpu: Option<&'gpu VgpuManager<'gpu>>,
+    total_vfs: Option<NonZero<u16>>,
+}
+
+impl<'gpu> NovaCoreVfApi<'gpu> {
+    #[expect(dead_code)]
+    pub(crate) fn new(gpu: &'gpu Gpu<'gpu>, pdev: &'gpu pci::Device<device::Bound>) -> Self {
+        Self {
+            pdev,
+            cmdq: gpu.cmdq(),
+            vgpu: gpu.vgpu_manager(),
+            total_vfs: gpu.vgpu_total_vfs(),
+        }
+    }
+
+    /// Returns whether the PF booted with vGPU support enabled.
+    pub fn is_available(&self) -> bool {
+        self.vgpu.is_some()
+    }
+
+    fn gfid(&self, gfid: u32) -> Result<Gfid> {
+        let total_vfs = self.total_vfs.ok_or(ENODEV)?;
+        Gfid::new(gfid, total_vfs)
+    }
+}
+
+impl NovaCoreVfApi<'_> {
+    /// Creates and boots an instance for a one-based VF ID.
+    ///
+    /// `sbdf` encodes the VF address as `(segment << 16) | (bus << 8) | devfn`.
+    /// `vm_pid` identifies the VM process's thread group. This call may sleep.
+    pub fn open_instance(&self, gfid: u32, sbdf: u32, vm_pid: u32) -> Result<VgpuTypeInfo> {
+        let dev = self.pdev.as_ref();
+        let gfid = self.gfid(gfid)?;
+        let dbdf = Dbdf::from_raw(sbdf);
+
+        dev_dbg!(
+            dev,
+            "vgpu_open: gfid={} sbdf={:#x}\n",
+            gfid.get(),
+            dbdf.into_raw()
+        );
+
+        let cmdq = self.cmdq;
+        let vgpu = self.vgpu.ok_or(ENODEV)?;
+
+        let type_id = query_assigned_vf_type(dev, cmdq, dbdf)?;
+        dev_dbg!(
+            dev,
+            "vgpu_open: gfid={} assigned type_id={}\n",
+            gfid.get(),
+            type_id
+        );
+
+        let vgpu_properties = query_vgpu_properties(dev, cmdq, type_id)?;
+        dev_dbg!(
+            dev,
+            "vgpu_open: gfid={} vgpu_type={} fb_length={:#x}\n",
+            gfid.get(),
+            vgpu_properties.type_id,
+            vgpu_properties.fb_length
+        );
+
+        vgpu.create_instance(InstanceInfo::new(gfid, dbdf, &vgpu_properties, vm_pid))?;
+
+        Ok(VgpuTypeInfo::from(&*vgpu_properties))
+    }
+
+    /// Tears down an instance, retaining resources if firmware cleanup fails.
+    ///
+    /// This call may sleep.
+    pub fn close_instance(&self, gfid: u32) -> Result {
+        let dev = self.pdev.as_ref();
+        let gfid = self.gfid(gfid)?;
+
+        dev_dbg!(dev, "vgpu_close: gfid={}\n", gfid.get());
+
+        let result = self.vgpu.ok_or(ENODEV)?.close_instance(gfid);
+        if let Err(error) = result {
+            dev_err!(dev, "vgpu_close: gfid={} failed: {:?}\n", gfid.get(), error);
+        }
+        result
+    }
+
+    /// Resets an instance and scrubs its guest VRAM. This call may sleep.
+    pub fn reset_instance(&self, gfid: u32) -> Result {
+        let dev = self.pdev.as_ref();
+        let gfid = self.gfid(gfid)?;
+
+        dev_dbg!(dev, "vgpu_reset: gfid={}\n", gfid.get());
+
+        self.vgpu.ok_or(ENODEV)?.reset_instance(gfid)?;
+
+        dev_dbg!(dev, "vgpu_reset: gfid={} done\n", gfid.get());
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/nova-core/vgpu/vram.rs b/drivers/gpu/nova-core/vgpu/vram.rs
index fb7c460b9d97..e3edf25549af 100644
--- a/drivers/gpu/nova-core/vgpu/vram.rs
+++ b/drivers/gpu/nova-core/vgpu/vram.rs
@@ -36,7 +36,6 @@ pub(super) struct VgpuVramLayout {
     fb_align: u64,
 }
 
-#[expect(dead_code)]
 impl VgpuVramLayout {
     pub(super) fn new(
         type_id: u32,
-- 
2.53.0

