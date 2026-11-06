Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944014;
	b=gxGmLbldYOcaffu/JeTyU/8N3oZOTXqFbeaVSEk1Ur3U00WIht1vKSDjox8ZOA7gFQIh
	 Q7x9Lkdl0z8yNXL0Hs+8u17M5pHD25h6GyGfgr48V2j4o6oxnWGfP2M+UPB5McT0ApohY
	 qmYqzjthXeNApiz+jY/ylI7d+wxh54oq/zXwJ+2QCwhGuoQ0/Ui7NfDn3MNS20bM7wfoU
	 m7dysUc9ABtL+lgqhU638driBN3konU6/bUUMg6Eybgrz6RufegI9jMhDo7QA6NPEZCAW
	 LQZ/YZupDMr0QL7e+qKb/bh7gjNIXx/WeNJ0I7NAMfXI4YFHf3eZGFJYihORPKSXSVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944014;
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
	bh=2TTnwyx806YaOL0DnBRKoP7Hip5kOKmxvtkvYCimIyw=;
	b=4uZaDjZNa7evscPlHUePrB86AFyx7Nc8D9AIJb2kNPIPI/dAbHcYMilyEu+2+ZsHl6Bw
	 z01Gaiua4wRTTTN3W6dMU149xuCXkSxDX/3UxWs0GkPW1+gj8SI3jGxnIgFDLi8Vhdgkc
	 0kdeESTYs/E52VJK5vNaUNGfNp0p6I+ADMgrhYKxgYQp2JdZ6S3df3TqFZ6GvBjDtrXHY
	 Z6MevMaEPcegkOoem1jQCZNvSDjC8b4kHWe9LOvWLu3YqbYlO3q6Y+Vc8g4iStrGSccag
	 5Iea2sZcQpiw6ASLLkefsdZwkuVPQWgIPlAS2MTNtO5GLAPhjoNm6NKE+Zrr2QA0QcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Pd0BVptJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.70
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C1606A336;
	Fri,  6 Nov 2026 05:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B42C1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Pd0BVptJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXr9xo8Fn5MJ6mQLTclxCsQYri32YUXeHAFkbPzTjCxhTd7aHsgjZA/X+9Uv5LGTqjPyQIDbeTumXqrAiF6Oz6JY4E/9gzJnwtAhbv6rl3B8rXKXRAbjVX4yeiQYyQiDuZtIYgBpeZ+Rzy+Z0v61k+znmyjhDp6ESmlSi1G3ONJwoIkdU0rBJo08et9PUrtN3fnFBnO6Pe298YNFbNMrL3J3O6Z5CYhezjZ2wpAuf2S/+05uRcsTI+vEtj5SIg5NjLWGkgWkejHX9p0EWFKgV9Le5Rwxd3bT1YcpJGybCS9YHeTxCNodmFhee690bSD9aYccFUC3/ORsT8MqwH3Y/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TTnwyx806YaOL0DnBRKoP7Hip5kOKmxvtkvYCimIyw=;
 b=UaPXYfTwDI2f0J8Yr6fBxxEYEGVpawI7Nk3YJS+iPnhEql9a6bjEM9MggQsEyBBSgzf15JPiNMvbPqoz3T3Qo1mVqiW8/vveitMLy2Gy5f2XCKIqZ7em+uoXqkkuZcBJZPYHFNFaOYP8A24HfcFYDnJ3N/KH7umTpNk97APDzyYgq6szWillJmqCwkTNyEVJ+gdYs1kLhTrx8SKWokxQ2tkrmdNmDE7OoLkj6MR2CybI5mm5GHH9PatwuhbbEjV5cC/Ouz1zVazHK1xtbTJ90GDYVC6blekfjTxZk5amSxZXh2sbvjQx1Jpc0qTyGism1WwjuurkH0YzVMsOsIwHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TTnwyx806YaOL0DnBRKoP7Hip5kOKmxvtkvYCimIyw=;
 b=Pd0BVptJROxge8Fw8LkJR0IxAsgAz/NeuKd0ghJIXySxqiffZvXdxd3TdrSzH6w1AuWDx/Y13LskW+GW37MFoyk6Gg0p3BzotrsnLxfYKQq5xJOo+p8YS9X8bMUTKa+nTa3s9zhl/ReCZ96bpeg29fZCgrLu+S8LenlHh3YWa5nfK1yZXUTD+PsYMJmtGvlLG0lXkNYm3/a2vQ2T88lfFuw6SjKSPnYEULtIL37y6m9lJpTEfQwZumRbf06rMspeLqV84HHjTQBq5aQYS32TA0j/IqlQid6oesC6qkRYG0TUjPtN3M+BWcDQgDGFizQvGc5DVsMe/vBxMbJGhvZANQ==
Received: from PH0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::12)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:46:45 +0000
Received: from PH7PEPF00000007.namprd04.prod.outlook.com
 (2603:10b6:510:d3:cafe::3e) by PH0P220CA0003.outlook.office365.com
 (2603:10b6:510:d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:46:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF00000007.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:46:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:46:27 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:46:15 -0800
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
Subject: [PATCH v4 25/32] gpu: nova-core: vgpu: add GSP plugin RPC transactions
Date: Fri, 6 Nov 2026 11:09:58 +0530
Message-ID: <9e52dcbb580fbc68ab3920908176571c4feda1aa.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000007:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: e95fc7d3-d0d1-4c14-56e8-08df3bc95743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|18002099003|22082099003|6133799003|3023799007|10067099003|56012099006|11063799006|261028144727099003|261026121527099003|261021135927099003|261102123227099003|261026140227099003|261021123027099003|261022105027099003|261022113327099003|261022075727099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	kc5TOE94jvhC/Kax9ciH1uL4E0Bmb1wV7AYdWWbf2/Af9Bui9QGhibtWgeCaWlPbTH5kurQkeB/GPdbmZ0R3pWdJg7Aht1FybFOFrGlpMfc0iZuLi/MRKsxck/pVhjrktMPeoqRq2r9RnAwY6cM+fOk68F5R9PKNsRYXuhrryMm1YqELqxt2b33n4mGEE4ZSBWOGvVXeRAlcp2QPGOslHv0gb8hLEhQLpNlGfCyLhwXJo/Q5kR3+yI/VWW2bQi81Fo9P1qgy85VM951D6mSndmo+EHTX7erz4SQb4PeN/LbTTm3wh5CVWSi9nEcTQ7hY67o6Mzdw9nC+NzvP54d0hYv4+DyM/leTiYgoxTDsjAL3f12gX6BlsJQHnQzs4JPfha+PmqC6T38fikEOkYRNpSR/3c+WlZMmeCHc8ehnlnlEaiOretl2hm8HrNG6B2/PSS91mY+VZ5B/B+p/LlQsRL+WnHLCVpRLu1sk7+39Zc99rPmRbke5BZa8lbiSYeS+QNC+EDEBoREfpCeL1U4o2yjLz+ePQMw5eHNlUTXQr1wKEP0E3gRq2UiBob4DHEz4slob6VpZb1+NuYMNsHJVr4eKQnq8wahTViZ6DtEBDuQTY2kgW68pK987EMCGF4M5x9kstXYusls1CCk81mAE102jvdhwNqzM6b9bdobNqwKxKWMeBtSWz4G6CuPBtZE3ixEubyxlfKWgsN/IqEI93w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261021135927099003)(261102123227099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wdu/Z7NnkYLSNRxpUE+5Gj+Q4k7AJJSWjVwBM2Z3txpfDmPn2dOEDGtpgPRYsX5IN1sdgWjSuLjqjdMKpM+JUz9yHQaTWFf4BC1Vuk21Ed7o99Ffb+q0562Eb1BVtEwbe/yByzM7TQKPyZazBNIPlMukGmyKuRNEKP00Cm3dty3yppp+bfqDQinLg8/ck5MUdY42V9q5AUbQyhyB0lXhE2HcXqpptGwiX4kckX+oqtRt4s+1tXJeB6O6cLkQOvhNcG7eapphXdTMdG58QuxMlExL825P/djcpZP7BaCrtl4jwgVU1kqLwuEfgrL6wOTSrajPrpF0EnM7MhDj2198zaMYgG3zPVTG1PToocmadv7fTktyldyuYzIYNH5hboTqPe6tS9UfmgNfa1pBMgxHb2RP8n0vgBMmdwcH9wqIUu81TwntarwCDjyE02Eg0f0L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:46:44.7813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95fc7d3-d0d1-4c14-56e8-08df3bc95743
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF00000007.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

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
 drivers/gpu/nova-core/regs.rs                 |  31 +++-
 drivers/gpu/nova-core/vgpu.rs                 |   1 +
 drivers/gpu/nova-core/vgpu/fw.rs              |  13 ++
 drivers/gpu/nova-core/vgpu/fw/commands.rs     |  10 ++
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs |  51 +++++-
 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs  | 155 ++++++++++++++++++
 drivers/gpu/nova-core/vgpu/instance.rs        |  15 +-
 7 files changed, 267 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs

diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index bf9fee4393ce..aea194eb8069 100644
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
index f7184e7009a5..d6bcdabafb42 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -35,6 +35,7 @@
 mod commands;
 mod fw;
 mod gsp_plugin_comm;
+mod gsp_plugin_rpc;
 mod hal;
 mod instance;
 mod vram;
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index 03225b9833c3..d80f36465296 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -10,6 +10,8 @@
 
 use crate::gsp::bindings;
 
+pub(super) use commands::RpcMessage;
+
 pub(super) use bindings::{
     GSP_PLUGIN_BOOTLOADED,
     VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE,
@@ -44,3 +46,14 @@
 
 pub(super) const GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES: u32 =
     bindings::GMCAPI_COMMANDS_GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES;
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
index 3c4a6192d2a6..917de4d21861 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -27,6 +27,16 @@
     mm::vram::VramRegion, //
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
 bitfield! {
     pub(crate) struct Dbdf(u32) {
         2:0 function;
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
index 31da31de4fd2..3d2c69e8cd79 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -21,7 +21,9 @@
 use super::fw::{
     self,
     RawControlRegion,
-    RawResponseRegion, //
+    RawResponseRegion,
+    RpcMessage,
+    RpcResponse, //
 };
 
 static_assert!(
@@ -240,7 +242,6 @@ pub(super) fn is_plugin_ready(&self) -> Result<bool> {
     }
 
     /// Initialize the shared control and response buffers for plugin RPC.
-    #[expect(dead_code)]
     pub(super) fn initialize(&self) -> Result {
         self.write_u64(
             &self.control,
@@ -338,6 +339,52 @@ pub(super) fn initialize(&self) -> Result {
         )
     }
 
+    /// Copy and publish one RPC request to firmware.
+    pub(super) fn submit(&self, message: RpcMessage, sequence: u32, data: &[u8]) -> Result {
+        if u64::try_from(data.len()).map_err(|_| EOVERFLOW)? > self.message.size() {
+            return Err(E2BIG);
+        }
+
+        for (index, chunk) in data.chunks(size_of::<u32>()).enumerate() {
+            let mut bytes = [0u8; size_of::<u32>()];
+            bytes[..chunk.len()].copy_from_slice(chunk);
+            let field = index.checked_mul(size_of::<u32>()).ok_or(EOVERFLOW)?;
+            self.write_u32(&self.message, field, u32::from_le_bytes(bytes))?;
+        }
+
+        self.write_u32(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.message_type),
+            // CAST: `RpcMessage` has a `u32` representation.
+            message as u32,
+        )?;
+        self.write_u32(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.message_seq_num),
+            sequence,
+        )
+    }
+
+    /// Read firmware's response for an expected RPC sequence.
+    pub(super) fn response(&self, expected_sequence: u32) -> Result<RpcResponse> {
+        let sequence = self.read_u32(
+            &self.response,
+            core::mem::offset_of!(
+                RawResponseRegion,
+                __bindgen_anon_1.message_seq_num_processed
+            ),
+        )?;
+        if sequence != expected_sequence {
+            return Ok(RpcResponse::Pending { sequence });
+        }
+
+        let status = self.read_u32(
+            &self.response,
+            core::mem::offset_of!(RawResponseRegion, __bindgen_anon_1.result_code),
+        )?;
+        Ok(RpcResponse::Complete { status })
+    }
+
     /// Invalidate the PTEs and release the communication mapping.
     pub(super) fn unmap(&mut self) -> Result {
         self.map.unmap()
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
new file mode 100644
index 000000000000..0ee32f011f63
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
+        dev: &device::Device<device::Bound>,
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
+    fn wait_response(&self, dev: &device::Device<device::Bound>, expected_sequence: u32) -> Result {
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
index bf02595590e1..8a2d8e3970a3 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -20,6 +20,7 @@
 };
 
 use crate::{
+    driver::Bar0,
     gpu::ChannelIdReservation,
     gsp::{
         cmdq::Cmdq,
@@ -41,6 +42,7 @@
         ChannelMapEntry, //
     },
     gsp_plugin_comm::CommBufferRegion,
+    gsp_plugin_rpc::PluginRpc,
     vram::{
         VgpuVramLayout,
         VgpuVramSlot,
@@ -141,7 +143,7 @@ struct VgpuInstance<'gpu> {
     vgpu_type: VgpuType,
     vm_pid: u32,
     num_plugin_channels: u32,
-    comm: CommBufferRegion<'gpu, 'gpu>,
+    plugin_rpc: PluginRpc<'gpu, 'gpu>,
     // Unmap the communication region before returning its slot and channel IDs.
     vram_slot: VgpuVramSlot,
     chids: ChannelIdReservation<'gpu>,
@@ -170,7 +172,7 @@ fn teardown(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
                 send_cleanup(vgpu.dev, vgpu.cmdq, self.gfid)?;
                 self.needs_teardown = false;
             }
-            self.comm.unmap()
+            self.plugin_rpc.unmap()
         })();
         if let Err(error) = result {
             self.failure = Some(error);
@@ -187,7 +189,7 @@ fn bootload(
     ) -> Result {
         let fb = &self.vram_slot.fbmem;
         let mgmt = &self.vram_slot.mgmt_heap;
-        let logs = self.comm.plugin_logs();
+        let logs = self.plugin_rpc.comm().plugin_logs();
 
         let payload = encode_vgpu_bootload(BootloadInfo {
             dbdf: self.dbdf,
@@ -215,11 +217,11 @@ fn bootload(
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
@@ -293,6 +295,7 @@ fn alloc_vram_slot(&mut self, mm: &GpuMm<'_>, layout: VgpuVramLayout) -> Result<
     fn allocate_instance<'a>(
         &'a mut self,
         vgpu: &'a VgpuManager<'gpu>,
+        bar0: Bar0<'gpu>,
         info: InstanceInfo,
     ) -> Result<PendingInstance<'a, 'gpu>> {
         let InstanceInfo {
@@ -351,7 +354,7 @@ fn allocate_instance<'a>(
             vgpu_type,
             vm_pid,
             num_plugin_channels: PLUGIN_CHANNELS_PER_ENGINE,
-            comm,
+            plugin_rpc: PluginRpc::new(comm, bar0, gfid),
             vram_slot,
             chids,
             needs_teardown: false,
-- 
2.53.0

