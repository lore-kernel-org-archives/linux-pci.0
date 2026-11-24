Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529208;
	b=sV4HgEAwMziJSsLVFq2fcRVa8QukcSJ0uXRJQnlrPfykJq/NlVM4yy5fFuwOPKTHlWWP
	 WV8VKV4LHff5aWa1quQXLpSlxBwF36KSqZhbTa3RtcHx9029KspF+HMxL8qPeahzo7Rcp
	 GE6NJBuFPgaO7sgOlTP4UqvAZrUdPSgIsHoHAjGPlmynDxNXR8oLaBT5sJ9HbsA5hKp9a
	 r30VbnV5GyN33fEgEVRtUCYTfOz138rjEnASw1RDythfPkH7/hwYApFaLBA8ABygqrWik
	 t9und5QGwjBoNFHs34t/JjMCvF/lb45ozZdWt2sYsMCuIusXeWLZL0Ez/iUsIulVVKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529208;
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
	bh=ApEQ/n2uOi48dzwcFfLszqHZVJHfLLuDSrqgWmQajaU=;
	b=mLw0L8vxTSI/9CunlPTPjMM+fR3GpkeU5ves2vqoF+qWaNVEUZOJsVh2h3NYvyogy8Ue
	 3ctcQyZnKEhz8Fh9TT3V9xWr4l9oqIFlZh23t2VqForeeprIx8R/U/AN47JYUL8n+Fj1h
	 36v+zRPTIObQsxpwszWKiSGOHbm4jvJSyU6Mdwzurq8OL9itFKrWs8m/cWIAdwiZoWtWJ
	 vpdpuwRsInUohcmFfMebSr6tTFRHDPSA3AZ9bUmGJNV2h4tbw4FvcGNh8FlYoXBSX8sKH
	 NQG0Mn7+A2eiIGen2SX2XuJout09ldz0DoQSszGwKc2iDdRrJJIhxDB+GtuHCrVSlXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=slFLMGqA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.8
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A993606A33B;
	Tue, 24 Nov 2026 14:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A993606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=slFLMGqA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJHWY1nUyXr41yV8xrS/hAttTvFTIIYas7JBIkbwofjQFJaWiCSgRQDQfNxGKgKicLDf2YLhpwF6urxxnJS3dw/Dpfz8iUra3n22BeR/hGnLKOgvB+wkFhQidF6lqSm+fZtIXZS0FbxuBO3rOl9IPLFC5uVU1eTJ07Mddpcr5CqnRjEofXi5UVj/617oIvWgY1RsYYWAdKBZiKGwh9WfDTKpMwph7vLT+Xah9jNEge7RqdMxZMI+KF0UjilVDHOuo2KWAh3FJZ/sdtoiz+rMG30VdoGKCPaVMccYssCNvLhw6b9b/TqG8e0MD+FV1sYZKFN+OC7UhVoZsc8q+FFwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApEQ/n2uOi48dzwcFfLszqHZVJHfLLuDSrqgWmQajaU=;
 b=CwnSj7bS7rc8uh5cYL0XDIyZmRAJrpg/yrbdIBJ4hSeb+z9GoV/hDKVggAdRTzAn5Od3lMJt6zfxPyUJS6fhErKt/xXZkjy4kz+/ofI+ceSceeYo1cmPOlXu8ZQr6beQ22udFtIi0veWGsAGH+zCGt3xzsvy1FqYuDYuyrSmDJfHdaET0JE/xoaIq+xoK3ohrPw9+aPGJ4XhVSRV2Oa1O5IBMiuYlQAf9cP7pJPOMeaIo9b/baLIdp072NpH7GyxW9t7qcPIWcpPZ1fzEH6kBPf1tST1m0i3Rrzq/TM5NVZiMVdbgBHn/STYhBvpWUDzuP/KKvEsCjUno/meUTcnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApEQ/n2uOi48dzwcFfLszqHZVJHfLLuDSrqgWmQajaU=;
 b=slFLMGqAtXuT+74Rv3yrAPQ8RQ+r7kDOyf+sVkgRzHPCgWjJBIzEZQ5jilyO9OaqsF8jlwqwj2A75hLW+0jpeiTcIppKgDfRRnzf2W6YFnzGS/PGVbLCiEpS1c1MFMvfdeocitItJOHxIdzMBdeYAPXsoExCKNJ4sxEBlcm00q6XRCX+RZgVAtcy7kUwzyXcJh8sohDMReNcsNDQgB5mGmPTsUBy7TGKhECjkcrsfaE4Te3ler250NCWX+zOgnImWWBn5emhpWWnSxkzKi02uSaeDx1VFR4OMOmUoEWBXaUKMxzLG4dhQpImART2k3Wwa7NRGTFUXKviWMxwW0xvFQ==
Received: from CY5PR22CA0075.namprd22.prod.outlook.com (2603:10b6:930:80::18)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:06:43 +0000
Received: from CY6PEPF00000049.namprd03.prod.outlook.com
 (2603:10b6:930:80:cafe::6f) by CY5PR22CA0075.outlook.office365.com
 (2603:10b6:930:80::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:06:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF00000049.mail.protection.outlook.com (10.167.247.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:06:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:06:15 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:06:02 -0800
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
Subject: [PATCH v5 28/35] gpu: nova-core: vgpu: add GSP plugin RPC transactions
Date: Tue, 24 Nov 2026 19:29:24 +0530
Message-ID: <20261124135937.18583-29-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF00000049:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: af07c68e-1c45-44ea-f30a-08df4a342b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|261021121427099003|261028144727099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261022113327099003|261021135927099003|261102123227099003|261009223027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	28ajL6AJaReNe6FX4s58sTeoHgDB/LG3QrM28KL3jHp0NYd4hC6z25Su2ttt+/50NLl7xOF8sg5DB/eRcD0Ly9he8TGfXdmDdyk+lg9kwN1AlxIDiyOpG8J1nRArNCvl5HqXhTOsqAtJZoq7RelD0HaadNR3cpcwzM8veiBM5CYNIBzxTYcO2KT06YeK93VyxhlGFFcflkXlc8wRdPKPHkbpR4GQxi82XZnkq0IObAovmx90JeHEfN6a8F/fqhHYO776nI1pqK+uDFCSFhfaZxVNMbIcYMJ5Ip3zRZ4OSDgdNeoViAcOTAVgs0UUm/EClc0i4Kzgon4EwMFayOq5ghpQ99fwOugqKRZ+4iqC/eMEvDHIlzd5yiZbqdItjyU0hXTBimSERKKRP3lj2nyFg9yhUbhYjSB111VNVp4e0wq6oR6pHyT4OHUopX3S22jOWQk4oMBayw6XZPpr9PPfGDTz9Q+Xc9TO2JvoLmFSowyMgQIEoeIy8u8s+Boi1PAD36sUjdHTKJL38o7AlYJMRIUcJEV7RHlyoW7lu8RfMpCJ4LRId0dm4QhomaX3tmhPuSQqUY40QacaeQVel0U5w9ctVDG37t+LZ8Rtluf0dGRvJmH+ygx02g33s97rF2LEbg4hZsYYA3U3mbPB8p89P4THlOFPsz9kVQvPHfMKTl70HFPyMbNWic9ltlOuS9NkcuK1K9AY+QRMXZJwp+c8hg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(261021121427099003)(261028144727099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261022113327099003)(261021135927099003)(261102123227099003)(261009223027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bJdHQN9ktQIFw8bwUlxxdk2jq0v0/4HkWFtn70ekCHPSh3R7W78s09+dV5R2kaenKq9E3y5vWmZiq4NmxcGb/+GwyjMBUoLVXy1CjWMP1OLh9lFGgZcd894sIw/BOHw6WNHFfgimijj54SMpXUy1+FUjEocJ/I0Q8u567y8+72SU5Fvnw2BXlFKKDtIwyThYfBzTYuMD0zj1RKm7wqAkVSFyZyJQq9hR5BmkSHZfMmBYor9l04ZeACIyif1itd1HV0gYa3sQDZzF2uhpe0QCVLMhWuLVI7cnLkPjRX3aErPMcLnBMpGUYsxRkQMHFeoWeRNta6M8gDdFsCvuoyn6ru59/YDCDpYWcU0VzTDRvLkRZeqx3Jq763llww7h4S3JOmpeWs18RhpMb1DEFf2tT4Tpe5BKoZXLBU15j2UabLDQ3EiENrLFwDu9Nii3HWwT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:06:43.4048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af07c68e-1c45-44ea-f30a-08df4a342b46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000049.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

From: Zhi Wang <zhiw@nvidia.com>

A GSP plugin consumes a shared-buffer request after its VF doorbell is
rung and publishes completion in the response region.

Add PluginRpc to own the communication mapping together with the
instance's stable BAR0 and validated GFID. Accept typed RPC message IDs,
copy the payload before publishing its sequence, advance the local
sequence, ring and read back the doorbell, then wait for a matching
completion and check its firmware status.

Keep one sequence identity for each published request, including a
request whose doorbell or wait later fails, and bound completion polling
with the RPC timeout. Delegate explicit unmap to the owned communication
region so teardown errors retain its owner; ordinary drop releases the
mapping through BarMapping.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs                  |   1 +
 drivers/gpu/nova-core/regs.rs                 |  31 +++-
 drivers/gpu/nova-core/vgpu.rs                 |   6 +
 drivers/gpu/nova-core/vgpu/fw.rs              |  13 ++
 drivers/gpu/nova-core/vgpu/fw/commands.rs     |  10 ++
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs |  37 ++++-
 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs  | 155 ++++++++++++++++++
 drivers/gpu/nova-core/vgpu/instance.rs        |  13 +-
 8 files changed, 257 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 031878cdb626..0de451fc3d7b 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -619,6 +619,7 @@ pub(crate) fn new<'a>(
                     VgpuState::Enabled { .. } => Some(KBox::pin_init(
                         VgpuManager::new(
                             dev,
+                            bar,
                             &gsp_resources.get_ref().gsp.cmdq,
                             bar_user.get_ref(),
                             mm.get_ref(),
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 050054a2b23d..867fc591b43d 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -7,13 +7,17 @@
         Io,
         Mmio, //
     },
+    prelude::*,
     sizes::SizeConstants,
     time, //
 };
 use pin_init::Zeroable;
 
 use crate::{
-    driver::NovaRegisters,
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     falcon::{
         DmaTrfCmdSize,
         FalconCoreRev,
@@ -39,6 +43,31 @@
     pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 }
 
+// VIRTUAL_FUNCTION
+
+register! {
+    base: NovaRegisters;
+
+    // PF BAR0 exposes the virtual-function register window at 0x00b8_0000.
+    pub(crate) NV_VIRTUAL_FUNCTION_PRIV_DOORBELL(u32) @ 0x00b8_2200 {
+        31:0 handle;
+    }
+}
+
+impl NV_VIRTUAL_FUNCTION_PRIV_DOORBELL {
+    const DOORBELL_STRIDE: u32 = 32;
+    const DOORBELL_VECTOR: u32 = 17;
+
+    /// Notify the GSP plugin for the given guest function and read back the doorbell.
+    pub(crate) fn ring_gsp_plugin(bar0: Bar0<'_>, gfid: u16) -> Result {
+        // A `u16` GFID produces a handle of at most 0x1f_fff1, which fits in `u32`.
+        let value = u32::from(gfid) * Self::DOORBELL_STRIDE + Self::DOORBELL_VECTOR;
+        bar0.try_write_reg(Self::zeroed().with_handle(value))?;
+        bar0.try_read(NV_VIRTUAL_FUNCTION_PRIV_DOORBELL)?;
+        Ok(())
+    }
+}
+
 // PGC6 register space.
 //
 // `GC6` is a GPU low-power state where VRAM is in self-refresh and the GPU is powered down (except
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index fbaaf8e1d6fa..bdb4821751e7 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -13,6 +13,7 @@
 };
 
 use crate::{
+    driver::Bar0,
     fsp::{
         Fsp,
         VgpuMode, //
@@ -37,6 +38,7 @@
 mod commands;
 mod fw;
 mod gsp_plugin_comm;
+mod gsp_plugin_rpc;
 mod hal;
 mod instance;
 mod vram;
@@ -137,6 +139,7 @@ struct VgpuManagerInner<'gpu> {
     #[pin]
     instances: Mutex<VgpuInstances<'gpu>>,
     dev: &'gpu device::Device<device::Bound>,
+    bar: Bar0<'gpu>,
     cmdq: &'gpu Cmdq<'gpu>,
     bar_user: &'gpu BarUser<'gpu>,
     mm: &'gpu SharedGpuMm<'gpu>,
@@ -149,8 +152,10 @@ struct VgpuManagerInner<'gpu> {
 
 impl<'gpu> VgpuManager<'gpu> {
     /// Retains runtime parameters from a completed vGPU-enabled GSP boot.
+    #[expect(clippy::too_many_arguments)]
     pub(crate) fn new(
         dev: &'gpu device::Device<device::Bound>,
+        bar: Bar0<'gpu>,
         cmdq: &'gpu Cmdq<'gpu>,
         bar_user: &'gpu BarUser<'gpu>,
         mm: &'gpu SharedGpuMm<'gpu>,
@@ -164,6 +169,7 @@ pub(crate) fn new(
             inner <- pin_init!(VgpuManagerInner {
                 instances <- new_mutex!(VgpuInstances::new(), "nova-core::vgpu-instances"),
                 dev,
+                bar,
                 cmdq,
                 bar_user,
                 mm,
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index 84a89c32a77b..76bd2b7e4e52 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -12,6 +12,8 @@
 // Alias to avoid repeating the version number with every use.
 use r000_00 as bindings;
 
+pub(super) use commands::RpcMessage;
+
 pub(super) use bindings::{
     GSP_PLUGIN_BOOTLOADED,
     VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE,
@@ -28,3 +30,14 @@
     VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE,
     VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE, //
 };
+
+/// State observed in the response buffer for an expected RPC sequence.
+pub(super) enum RpcResponse {
+    Pending {
+        /// Last sequence completed by firmware.
+        sequence: u32,
+    },
+    Complete {
+        status: u32,
+    },
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index a8b80bd6d33b..a8f6f0316d25 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -28,6 +28,16 @@
     vgpu::Dbdf, //
 };
 
+use super::bindings;
+
+/// Message types supported by the nova-core plugin RPC channel.
+#[expect(dead_code)]
+#[derive(Clone, Copy)]
+#[repr(u32)]
+pub(crate) enum RpcMessage {
+    VersionNegotiation = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_VERSION_NEGOTIATION,
+}
+
 #[derive(Clone, Copy)]
 struct SwizzId(u32);
 
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
index e4ce82c6b2d7..49d85df70018 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -29,7 +29,9 @@
 use super::fw::{
     self,
     RawControlRegion,
-    RawResponseRegion, //
+    RawResponseRegion,
+    RpcMessage,
+    RpcResponse, //
 };
 
 /// Layout of the plugin communication region, located at the start of the management heap.
@@ -157,7 +159,6 @@ pub(super) fn is_plugin_ready(&self) -> Result<bool> {
     }
 
     /// Initialize the shared control and response buffers for plugin RPC.
-    #[expect(dead_code)]
     pub(super) fn initialize(&self) -> Result {
         let comm = self.view()?;
         let control = io_project!(comm, .control.__bindgen_anon_1);
@@ -205,6 +206,38 @@ pub(super) fn initialize(&self) -> Result {
         Ok(())
     }
 
+    /// Copy and publish one RPC request to firmware.
+    pub(super) fn submit(&self, message: RpcMessage, sequence: u32, data: &[u8]) -> Result {
+        let comm = self.view()?;
+        let control = io_project!(comm, .control.__bindgen_anon_1);
+        let buffer = io_project!(comm, .message);
+
+        if data.len() > buffer.size() {
+            return Err(E2BIG);
+        }
+        io_project!(buffer, [try: ..data.len()]).copy_from_slice(data);
+
+        // CAST: `RpcMessage` has a `u32` representation.
+        io_write!(control, .message_type, message as u32);
+        io_write!(control, .message_seq_num, sequence);
+
+        Ok(())
+    }
+
+    /// Read firmware's response for an expected RPC sequence.
+    pub(super) fn response(&self, expected_sequence: u32) -> Result<RpcResponse> {
+        let response = io_project!(self.view()?, .response.__bindgen_anon_1);
+
+        let sequence = io_read!(response, .message_seq_num_processed);
+        if sequence != expected_sequence {
+            return Ok(RpcResponse::Pending { sequence });
+        }
+
+        Ok(RpcResponse::Complete {
+            status: io_read!(response, .result_code),
+        })
+    }
+
     /// Invalidate the PTEs and release the communication mapping.
     pub(super) fn unmap(&mut self) -> Result {
         self.map.unmap()
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
new file mode 100644
index 000000000000..d96f6072a941
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! GSP plugin RPC.
+//!
+//! ```text
+//! Host (PluginRpc)       Shared RPC buffer (VRAM)       GSP plugin
+//!       |                           |                       |
+//!       |-- BAR1: payload --------->| Message               |
+//!       |-- BAR1: type, sequence -->| Control               |
+//!       |                           |                       |
+//!       |-- BAR0: VF doorbell ----------------------------->|
+//!       |                           |<-- read request ------|
+//!       |                           |                       | process RPC
+//!       |                           |<-- completion --------|
+//!       |-- poll processed seq ---->| Response              |
+//!       |<-- matching seq, status --|                       |
+//! ```
+
+use kernel::{
+    device,
+    prelude::*,
+    time::{
+        delay::fsleep,
+        Delta,
+        Instant,
+        Monotonic, //
+    },
+};
+
+use crate::{
+    driver::Bar0,
+    regs::NV_VIRTUAL_FUNCTION_PRIV_DOORBELL, //
+};
+
+use super::{
+    fw::{
+        RpcMessage,
+        RpcResponse, //
+    },
+    gsp_plugin_comm::CommBufferRegion,
+    instance::Gfid, //
+};
+
+/// BAR1-backed channel used to communicate with one GSP plugin.
+pub(super) struct PluginRpc<'map, 'gpu> {
+    comm: CommBufferRegion<'map, 'gpu>,
+    bar0: Bar0<'gpu>,
+    gfid: Gfid,
+    message_sequence: u32,
+}
+
+impl<'map, 'gpu> PluginRpc<'map, 'gpu> {
+    pub(super) fn new(comm: CommBufferRegion<'map, 'gpu>, bar0: Bar0<'gpu>, gfid: Gfid) -> Self {
+        Self {
+            comm,
+            bar0,
+            gfid,
+            message_sequence: 0,
+        }
+    }
+
+    pub(super) fn comm(&self) -> &CommBufferRegion<'map, 'gpu> {
+        &self.comm
+    }
+
+    /// Initialize the control and response buffers for the first RPC.
+    #[expect(dead_code)]
+    pub(super) fn init_rpc(&mut self) -> Result {
+        self.comm.initialize()?;
+        self.message_sequence = 0;
+        Ok(())
+    }
+
+    fn next_sequence(&self) -> u32 {
+        let sequence = self.message_sequence.wrapping_add(1);
+        if sequence == 0 {
+            1
+        } else {
+            sequence
+        }
+    }
+
+    /// Write one RPC message, ring the VF doorbell, and wait for its response.
+    #[expect(dead_code)]
+    pub(super) fn rpc_call(
+        &mut self,
+        dev: &device::Device,
+        message_type: RpcMessage,
+        data: &[u8],
+    ) -> Result {
+        let sequence = self.next_sequence();
+        self.comm.submit(message_type, sequence, data)?;
+        self.message_sequence = sequence;
+
+        dev_dbg!(
+            dev,
+            "vGPU RPC: gfid={} type={} bytes={} sequence={}\n",
+            self.gfid.get(),
+            // CAST: `RpcMessage` has a `u32` representation.
+            message_type as u32,
+            data.len(),
+            sequence,
+        );
+
+        NV_VIRTUAL_FUNCTION_PRIV_DOORBELL::ring_gsp_plugin(self.bar0, self.gfid.get())?;
+        self.wait_response(dev, sequence)
+    }
+
+    fn wait_response(&self, dev: &device::Device, expected_sequence: u32) -> Result {
+        let start = Instant::<Monotonic>::now();
+        let timeout = Delta::from_secs(120);
+
+        loop {
+            match self.comm.response(expected_sequence)? {
+                RpcResponse::Complete { status } => {
+                    if status != 0 {
+                        dev_dbg!(
+                            dev,
+                            "vGPU RPC: sequence {} failed with status {}\n",
+                            expected_sequence,
+                            status,
+                        );
+                        return Err(EIO);
+                    }
+
+                    dev_dbg!(
+                        dev,
+                        "vGPU RPC: sequence {} completed after {:?}\n",
+                        expected_sequence,
+                        start.elapsed(),
+                    );
+                    return Ok(());
+                }
+                RpcResponse::Pending { sequence } => {
+                    if start.elapsed() >= timeout {
+                        dev_dbg!(
+                            dev,
+                            "vGPU RPC: sequence {} timed out; last response was {}\n",
+                            expected_sequence,
+                            sequence,
+                        );
+                        return Err(ETIMEDOUT);
+                    }
+                }
+            }
+            fsleep(Delta::from_millis(1));
+        }
+    }
+
+    /// Release the BAR1 mapping.
+    pub(super) fn unmap(&mut self) -> Result {
+        self.comm.unmap()
+    }
+}
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 2d045ebcd9cd..94735df79e1a 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -42,6 +42,7 @@
         VgpuProperties, //
     },
     gsp_plugin_comm::CommBufferRegion,
+    gsp_plugin_rpc::PluginRpc,
     vram::{
         VgpuVramLayout,
         VgpuVramSlot,
@@ -147,7 +148,7 @@ struct VgpuInstance<'gpu> {
     vgpu_type: VgpuType,
     vm_pid: u32,
     num_plugin_channels: u32,
-    comm: CommBufferRegion<'gpu, 'gpu>,
+    plugin_rpc: PluginRpc<'gpu, 'gpu>,
     // Unmap the communication region before returning its slot and channel IDs.
     vram_slot: VgpuVramSlot,
     chids: ChannelIdReservation<'gpu>,
@@ -176,7 +177,7 @@ fn teardown(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
                 send_cleanup(vgpu.dev, vgpu.cmdq, self.gfid)?;
                 self.needs_teardown = false;
             }
-            self.comm.unmap()
+            self.plugin_rpc.unmap()
         })();
         if let Err(error) = result {
             self.failure = Some(error);
@@ -193,7 +194,7 @@ fn bootload(
     ) -> Result {
         let fb = &self.vram_slot.fbmem;
         let mgmt = &self.vram_slot.mgmt_heap;
-        let logs = self.comm.plugin_logs()?;
+        let logs = self.plugin_rpc.comm().plugin_logs()?;
 
         let payload = encode_vgpu_bootload(BootloadInfo {
             dbdf: self.dbdf,
@@ -221,11 +222,11 @@ fn bootload(
             payload.len() * size_of::<u64>(),
         );
 
-        self.comm.clear_plugin_ready()?;
+        self.plugin_rpc.comm().clear_plugin_ready()?;
         self.needs_teardown = true;
         send_bootload(dev, cmdq, &payload)?;
 
-        wait_plugin_ready(dev, &self.comm)?;
+        wait_plugin_ready(dev, self.plugin_rpc.comm())?;
 
         dev_dbg!(dev, "bootload: gfid={} plugin ready\n", self.gfid.get());
         Ok(())
@@ -357,7 +358,7 @@ fn allocate_instance(
             vgpu_type,
             vm_pid,
             num_plugin_channels: PLUGIN_CHANNELS_PER_ENGINE,
-            comm,
+            plugin_rpc: PluginRpc::new(comm, vgpu.bar, gfid),
             vram_slot,
             chids,
             needs_teardown: false,
-- 
2.53.0

