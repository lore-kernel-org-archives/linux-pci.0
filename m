Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529227;
	b=Jdma6UFY/Jrp6aPT8FPyy5JbdmhhxkQMhIoAZ4GI3GX+tAnv9wlYHXc9eFjOHM9uV7Lf
	 2MC0VAhv57AnOSmbCwFIebXFcTsM0nmeB8QbBe5kbqO+TCRVAHPoxBGpzrizC+1g6w/j9
	 fjm+HQ9uJq3Km800aiVGeApbP4QWKQFHu3judWnS0T4ovwDqLbVfB0a0FOs81Sky+oGqZ
	 o8JQQgS2L3b/7t0SzzkgSPLaJZjABaisE8bjamCZ9oQA3YRadGBKfQTHxHI/X/3LkLZIs
	 lGtE+BK6H9fTbUg/I1IhThcDSu0ViAbEgqveip7z2UhTIV2cMD0OKbsnLcupM1o8/XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529227;
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
	bh=rT5r6aEut33UpqRGFUWiwDye1DT3GgpLp1MmuDvoU2A=;
	b=niGkuqXGLMDSHZsgDU5rG/YSs0slYtfr1+lChfk9IRSCOBh8dU2cIiBbJanuUDJ3xH/E
	 ufUcOqskvJq9cOJPzrmHxNucRgmsp/A5VrrW+7PDhe9q8BxbSlndXC0YHSuGr2iOxSQKH
	 EEqhv8wyL2xL5BBhlfjy+khq/KvkCtb6lDD9y2fYZLPaoEhMDpbmPicHVeg3jqyvsCOi8
	 M3pRPG7mJcdDNjDzDez3CqsbN8HbMD85pAKzYi4Cz09xe1pfQ1u4P6ZQalnrPiS9thehy
	 1I5wDizevL20C61moFS7k8jYyP9Zb6o1xiwVs4GjjP9Lw5aNaAVvoYsmQ+0mV/rxwrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y0JlVhcU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.22
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5886606B753;
	Tue, 24 Nov 2026 14:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5886606B753
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y0JlVhcU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTQwwgg5gzO95Yj3DXJYW6q87m28/rTCSpGuRYe7721ZyVw3rbSMYwbF7WGszKSUNeyAVBdb4XI8Q2TOTKQVggQsheSskmM7aTOJyZeQPycFnjdo9FY3LDqarfQZVa2PXyliaOK6Q4g23kx0nl2tjxRz3D3vxD4+5oSfYwLFSLklbVPd5ynvdfsyA3+qzBAhcgHYYEv/B+lquBdeods3GhpAX1HzVFpyZQm21GP4vVDPLI5AW7LAbF0t+mKcvpSYXyHdotaoF+gaLD1KIV4bz88bf9T9fWG32NOiMv4nd6g2eGyRAmoXM/IqZnfLQQ1YEtlGvn4pv7gqQn/X3buG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rT5r6aEut33UpqRGFUWiwDye1DT3GgpLp1MmuDvoU2A=;
 b=mfU5SBoiBpy4y/4VDmNyAWHzUDf2eOvruSNJNOAjirJeEXv3b0wb13+W9cpiv391Ykpgw/wyLQCulb8iOb9T+CH5d8kUnXZIVtsQfugsJwrX+Sx4IkEd0dO4Y1iv1+8LnYKBO62IPY3b/U7+A/qY8WChAvLqEgGuThOL0gGlFQxnrHPthwp195Sn8Q+D51grKcuIMERlBaa99GVcTT9C0OKtO07n+crn345YT66KwDIjOkOtcZ/3trjLkmIM5kIjxo11BkCgTLrsWD1K21nNNgPQRRL8+iuy01MFpWyuACBPo6LcQVk8MePi3df9+mkGJwE45E/K6eLBTQp4BGaNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT5r6aEut33UpqRGFUWiwDye1DT3GgpLp1MmuDvoU2A=;
 b=Y0JlVhcUdoMP90/D+rEt6axgSR7XGF+BpXegyinu+XtdjpdIs+7rxO1hpCVKx/kGkLanOIs5eSrCYdHWkdlGUSZMR7nEDmRKnRezSR/S9BvRd9xEZoWHUeKAtzWhCsH2XX2j4hQ2uOSSF8f6BfiYNtJR0cSgmOJHiQAlZ8UEXvA65MqazmYCR4tpCzEwrTgAEFLWlpzxzvIX4/ceQ/6kaPiQ6oC7txHKiYlkrWs1RhblwnTKfdp8Z7D8IHhyWo4QGlXc4UGx6AUCodA4E+tP7pUBnYJJc6duVHt+9RIiUwxxq0tzq6C89r4jF2+pquKlUANZWFFcinTbk0VJh/+nIQ==
Received: from SJ0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:a03:333::25)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 14:06:57 +0000
Received: from BY1PEPF00026959.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::10) by SJ0PR03CA0110.outlook.office365.com
 (2603:10b6:a03:333::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 24
 Nov 2026 14:06:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF00026959.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:06:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:06:41 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:06:28 -0800
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
Subject: [PATCH v5 30/35] gpu: nova-core: vgpu: send GSP plugin configuration parameters
Date: Tue, 24 Nov 2026 19:29:26 +0530
Message-ID: <20261124135937.18583-31-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026959:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: a06223c5-12c9-476f-9969-08df4a343331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|10067099003|261022075727099003|11063799006|261028144727099003|56012099006|261021121427099003|261102123227099003|261021135927099003|261009223027099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OKVDpSW1aPhctCcYuqaoB5ay/D4H+ffvwgR5oQPcuBV7uXJoeXesNTXuMt07ECUjUXuhaNoCA54f7eMB+FAeFHQ8OM1+daBeqpbv/5JGaHK6pLEVxIMOjwApf6GWVsWAYHr/VxTUJ4ogEp1zt0gByj8kZNoGbEQR/Fgd5OSg27cVjHE88LJYvzUjWxEx0rOm+pYeV4mr5c93QrXiimbiVIVzD2jkIj3yRWDy1C1BoNE6cEJLOYwnGrpjhUgXNWXk0tVMF6vsTCxD4WMZnswnAxwQiIGxBJ71snuVUlTveujSssdtYV4Kdodakcxviwa6JdRGPcoWWH72s7nIuDLXGr1ltmo57UdgfYfGyWPASgvw36b0gQw6DrMF23At7Ly6C/uqRppKpO+uwrq6rJwbxHpm0adzVWM0DhhU5QtwfP5mGEbwSje8213e3IAvizB7nuXMP2/k1UiJna4/Vtcy7MXwJGPAmBW7mWwqVuM1NqAuqN1SjNsV81ykfpfGy87exv5xH2QKBL9hEQb/2KfDnFbJipOygqqUqkopVdcVu0EOg8IyDml7QrDq/UNcHX9MBEkIN3P6IFWK1UJwbbC9ZrAxcN7Jyku9LlGnisUm6nsgOiB2vEGoIn3pA4I3OUvPB/uPJamT47PcJoM17uCwsYq4cDmeScNu7AkNeGJBNr955dERAox2CtGu4xEd9pn2QsOAt9vJtWWzcEqpbxJojQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(261022075727099003)(11063799006)(261028144727099003)(56012099006)(261021121427099003)(261102123227099003)(261021135927099003)(261009223027099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rWoN8DMX79vl27GrYh9Thac4hjP+JjyjstsvA/gBhp3s4SncOpJmBQcQMhikz0Wn/wLe6Hi1usnXq8mXgIPir6odrh7VAI2PtFfJcXLnnkvpnQIaQPUFKG3s1+mhvRMVcWz+LTiA4TTJkVfkEy9l3m7/2SeKy8QrW0V07XW8MKXRliRxp+olaPnTHtQldznfqipb+RZgTOImN3v2o/hvxmBsVf3VWeWpPNVgAxaBxT+ZuYLcm+wirZlR06hJyF3il/3WVBEk9SyFt/A/9mAli+ULb+1vffrrIBYLo+KzxhZWu+6bw7ooW+ZgEOtYl4kyUf+eL85ACVmPbjkhhm3yBp4qcxKFrGCrS/Dy+Xx0p/ThPklvCZhS1ulSQvIeeM544CBJo0xWW/8zeBlhYlp9LnsGXemLp0fxeV7ArEvllv07Ck2hKyRNE/ASg770LQkP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:06:56.7290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06223c5-12c9-476f-9969-08df4a343331
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026959.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F

From: Zhi Wang <zhiw@nvidia.com>

The GSP plugin needs instance identity, channel allocation and host
parameters before it can serve guest requests.

Encode the configuration as an NVKV stream, prefix it with its word
count and send SETUP_CONFIG_PARAMS_AND_INIT after protocol negotiation
through the instance's PluginRpc channel.

Derive the host's opaque device identity from the VF DBDF within the
supported 16-bit PCI segment namespace. This identifies the local device
without imposing a migration-persistent identity.

Describe the supported whole-GPU configuration and distinguish the
optional VMM capability bitmap from the separately reported migration
features. Encode the host page size with the kernel's infallible
conversion.

Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/vgpu/commands.rs       |   9 ++
 drivers/gpu/nova-core/vgpu/fw/commands.rs    | 118 +++++++++++++++++++
 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs |  17 +++
 drivers/gpu/nova-core/vgpu/instance.rs       |  16 +++
 4 files changed, 160 insertions(+)

diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index c1783ace8b3f..70fd35566822 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -235,3 +235,12 @@ pub(super) fn negotiate_plugin_version(
 ) -> Result {
     rpc.rpc_call(dev, RpcMessage::VersionNegotiation, &[])
 }
+
+/// Send an instance's encoded configuration to the GSP plugin.
+pub(super) fn send_plugin_config(
+    dev: &device::Device,
+    rpc: &mut PluginRpc<'_, '_>,
+    config: &[u64],
+) -> Result {
+    rpc.rpc_call_nvkv(dev, RpcMessage::SetupConfigParamsAndInit, config)
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index 168a2447b67c..c7ff27fcf6d7 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -9,6 +9,7 @@
 use kernel::{
     alloc::ArrayVec,
     bitfield,
+    num::casts::usize_as_u64,
     prelude::*, //
 };
 
@@ -35,6 +36,7 @@
 #[repr(u32)]
 pub(crate) enum RpcMessage {
     VersionNegotiation = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_VERSION_NEGOTIATION,
+    SetupConfigParamsAndInit = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_SETUP_CONFIG_PARAMS_AND_INIT,
 }
 
 #[derive(Clone, Copy)]
@@ -211,6 +213,122 @@ impl VgpuProperties {
     const STRING_LEN: usize = 64;
 }
 
+#[derive(Clone, Copy)]
+#[repr(u32)]
+enum HypervisorType {
+    Unknown = 4,
+}
+
+impl From<HypervisorType> for u32 {
+    fn from(value: HypervisorType) -> Self {
+        // CAST: `HypervisorType` uses the wire field's `u32` representation.
+        value as u32
+    }
+}
+
+#[derive(Clone, Copy)]
+#[repr(u32)]
+enum CpuArch {
+    Aarch64 = 1,
+    X86_64 = 2,
+}
+
+impl CpuArch {
+    fn host() -> Result<Self> {
+        if cfg!(target_arch = "x86_64") {
+            Ok(Self::X86_64)
+        } else if cfg!(target_arch = "aarch64") {
+            Ok(Self::Aarch64)
+        } else {
+            Err(EOPNOTSUPP)
+        }
+    }
+}
+
+impl From<CpuArch> for u32 {
+    fn from(value: CpuArch) -> Self {
+        // CAST: `CpuArch` uses the wire field's `u32` representation.
+        value as u32
+    }
+}
+
+#[derive(Clone, Copy)]
+struct MigrationFeature(u32);
+
+impl MigrationFeature {
+    const PRESERVE_CTX_BUF: Self = Self(0x4000);
+}
+
+impl From<MigrationFeature> for u32 {
+    fn from(value: MigrationFeature) -> Self {
+        value.0
+    }
+}
+
+bitfield! {
+    struct FeatureFlags(u64) {
+        3:3 enable_uvm => bool;
+        5:5 vmm_migration => bool;
+    }
+}
+
+nvkv_encode! {
+    struct PluginConfigParamsRequest {
+        uuid: Key<[u8; 16], 0x0001>,
+        dbdf: Key<Dbdf, 0x0002, u32>,
+        device_instance_id: Key<u32, 0x0004>,
+        vgpu_type: Key<u32, 0x0005>,
+        vm_pid: Key<u32, 0x0006>,
+        swizz_id: Key<SwizzId, 0x0010, u32>,
+        num_channels: Key<u32, 0x0011>,
+        num_plugin_channels: Key<u32, 0x0012>,
+        vmm_cap: Key<u32, 0x0020>,
+        migration_feature: Key<MigrationFeature, 0x0021, u32>,
+        hypervisor_type: Key<HypervisorType, 0x0022, u32>,
+        cpu_arch: Key<CpuArch, 0x0023, u32>,
+        page_size: Key<u64, 0x0024>,
+        feature_flags: Key<FeatureFlags, 0x0030, u64>,
+    }
+}
+
+/// Encodes plugin configuration parameters using the typed NVKV schema.
+pub(crate) fn encode_plugin_config_params(
+    uuid: [u8; 16],
+    dbdf: Dbdf,
+    vgpu_type: u32,
+    vm_pid: u32,
+    num_channels: u32,
+    num_plugin_channels: u32,
+) -> Result<KVVec<u64>> {
+    let request = PluginConfigParamsRequest {
+        uuid: uuid.into(),
+        dbdf: dbdf.into(),
+        // The full host PCI address distinguishes VFs within a VM, including VFs
+        // from different PFs. This opaque identity lasts for the host device lifetime.
+        device_instance_id: dbdf.into_raw().into(),
+        vgpu_type: vgpu_type.into(),
+        vm_pid: vm_pid.into(),
+        swizz_id: SwizzId::WHOLE_GPU.into(),
+        num_channels: num_channels.into(),
+        num_plugin_channels: num_plugin_channels.into(),
+        // Advertise no optional VMM capabilities (vmioplugin.h VMM_CAP_*),
+        // independently of the plugin feature_flags and migration_feature below.
+        vmm_cap: 0.into(),
+        migration_feature: MigrationFeature::PRESERVE_CTX_BUF.into(),
+        hypervisor_type: HypervisorType::Unknown.into(),
+        cpu_arch: CpuArch::host()?.into(),
+        page_size: usize_as_u64(kernel::page::PAGE_SIZE).into(),
+        feature_flags: FeatureFlags::zeroed()
+            .with_enable_uvm(false)
+            .with_vmm_migration(true)
+            .into(),
+    };
+
+    let mut encoder = Encoder::new();
+    request.encode(&mut encoder)?;
+    Ok(encoder.finish())
+}
+
 // TODO: extract from bindings
 #[repr(C)]
 #[derive(FromBytes, IntoBytes)]
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
index c68681d8d08b..1197c427312a 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
@@ -19,6 +19,7 @@
 
 use kernel::{
     device,
+    num::casts::usize_as_u64,
     prelude::*,
     time::{
         delay::fsleep,
@@ -26,6 +27,7 @@
         Instant,
         Monotonic, //
     },
+    transmute::AsBytes, //
 };
 
 use crate::{
@@ -105,6 +107,21 @@ pub(super) fn rpc_call(
         self.wait_response(dev, sequence)
     }
 
+    /// Send an NVKV stream prefixed by its word count.
+    pub(super) fn rpc_call_nvkv(
+        &mut self,
+        dev: &device::Device,
+        message_type: RpcMessage,
+        encoded: &[u64],
+    ) -> Result {
+        let word_count = usize_as_u64(encoded.len());
+        let mut payload = KVec::new();
+        payload.extend_from_slice(&word_count.to_le_bytes(), GFP_KERNEL)?;
+        payload.extend_from_slice(AsBytes::as_bytes(encoded), GFP_KERNEL)?;
+
+        self.rpc_call(dev, message_type, &payload)
+    }
+
     fn wait_response(&self, dev: &device::Device, expected_sequence: u32) -> Result {
         let start = Instant::<Monotonic>::now();
         let timeout = Delta::from_secs(120);
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 2c8542a45643..af1b43533a77 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -34,9 +34,11 @@
         negotiate_plugin_version,
         send_bootload,
         send_cleanup,
+        send_plugin_config,
         send_shutdown, //
     },
     fw::commands::{
+        encode_plugin_config_params,
         encode_vgpu_bootload,
         BootloadInfo,
         ChannelMapEntry,
@@ -164,6 +166,7 @@ fn activate(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
         self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
         self.plugin_rpc.init_rpc()?;
         negotiate_plugin_version(dev, &mut self.plugin_rpc)?;
+        self.configure_plugin(dev)?;
 
         Ok(())
     }
@@ -235,6 +238,19 @@ fn bootload(
         Ok(())
     }
 
+    fn configure_plugin(&mut self, dev: &device::Device) -> Result {
+        let config = encode_plugin_config_params(
+            [0; 16],
+            self.dbdf,
+            self.vgpu_type.vgpu_type_id,
+            self.vm_pid,
+            u32::try_from(self.chids.len()).map_err(|_| EOVERFLOW)?,
+            self.num_plugin_channels,
+        )?;
+
+        send_plugin_config(dev, &mut self.plugin_rpc, &config)
+    }
+
     /// Stop the plugin when firmware may own instance resources.
     fn shutdown(&mut self, dev: &device::Device, cmdq: &Cmdq<'_>) -> Result {
         if self.needs_teardown {
-- 
2.53.0

