Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944032;
	b=mFKKZ7fjoCuZRDMFebtWyDuFDts2tR5Bz5aTFmOuqKdidN0L1e4Q9hWw+7pvi5IyOQUV
	 UNPrrnOPpTtkJniH7nNzuiGG+w6897iYwum3aJtQADiTp96C7dYdMH6FKDkMB+Sc8MPZq
	 XKEapfiPkNRsV4wbRj0MNzExbrIspb8ni4v3TxW/+ayEjBicY93/+NnoExyAf7NGw//rI
	 kqgov8QWXE2WDCy93S7DtlcsGho/eA7I9lKV3B0sOG0WZ51WGlAJAhKyJ0hoAaIPfqUYt
	 ACTPFPGwPuOEFskEuZKpsOxWKXWvjXUKWc6oJNwoPdQ4MwVJcnYBE8UyqcR26J8ycAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944032;
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
	bh=NwxyUNaKneeyzA8/UvfA42uI569SUTrDjt4Ny4zNkPI=;
	b=GnDNOeJOynYaNTF6MHCP0oQ+PeZKS84WJyY6lB0qclHb+p83InX2rBniEzyLfb5S5tkx
	 s/wx2nZo/Y4zV/qeVyMl1T58ryfE5Dquz/mB4PtFPtMdR0mfyGuyPkc1LOQLB7QGOymY5
	 QzTqpzzvLQiyRJhGVI5lzDaeCovdq7MA6SO6SlC+hRW51SCZ6cb2E8q2rB5QB9yAGuVZB
	 TdYWaLe0tbFLQ1DCAy3Qd8IRYOQcNyN9dEb84psj471T4Z4a9Pc7g0AhYhoO3upovYzgX
	 Z/KW4G+ZoICzGzaukKJbgk5EKWU1CC1TFG5a6Cwnkc4nYO4T74VP2SFa1hlOr5a45Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pV3f8voi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.46
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1809606D830;
	Fri,  6 Nov 2026 05:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1809606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pV3f8voi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n329gXhv5Bx473KDABN6gCwcwyBPPVn4nnAgZuACxu4QFgmPeIoE0HX3k0QE1axiS8F/QOdNkcZ1J4JlWByXmBf3T/9gxBOl0nHvr9leMlZwNT1sECh/ChW+PkMr+yU8CwJSWw4JbKztiRj/TezrwuV2UWk3pKRegZKij8OtoIf0jEpH5aOcbqvt6gALvPQHy5kGUytKL/9yRz0U8FwOkYhoTLriURQnhtd2Vp3w3X0S4oauDJQ9/v/WZV1oOOTpoADz2MQTPCpSIzCR1y3J/he9juDGna4ZOhDD1KbuFAmhGxth2LHXRGGW6P5DP2Rp/mhjQCWQE/i/X92OZ6sgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwxyUNaKneeyzA8/UvfA42uI569SUTrDjt4Ny4zNkPI=;
 b=bW+AcqBawjhA2bqMmfkrT76bmfTSZdO4B5s0wVE9cAY8mDMfbPuGPUHJCdiFHQQVorexb7XSwS2u/FumcFQQAcbU4lf1C0II+JniD/NnKpju0dC0LQbXkh7aYGD1wASymA8vq4rlCu0jnXqY6YlFuOjNcRo6N7EEUSDQq0iQ6CnxecMTK0Uz40lpTWI72DcDlFJqmtASIsj5MS2irjLbbVhyrwmnxPjYmU31cIcjvIuERugIgahS1I9dhVWf7ALgMpess+rgnwpLG8AL6QzGIh20sXOWcQLu4eLUi5cP3fij588JYN8JRAlp4lKBFj2idNUVz7SRP79jPtPZD5+sOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwxyUNaKneeyzA8/UvfA42uI569SUTrDjt4Ny4zNkPI=;
 b=pV3f8voiIHsg7qPkEYF/lWyUAumK7R72PnXeKupm0ngPOSlbzrf4sxZT3idh/15gTr/hyB5GoA0dysUVH9nDP0OsBxsK5dXFxLc4VIVxK5wwR0K8wPKGRWCKtCixGvB51Kbg7LJUEbBljlHdLCqmTlf06LT5P9A0fw3rF1z5AeUYsFsGpZq4WgfabtQTSkrduS+EKO/Gq1xD/p9pqtA0r4d7ALLc5zlMwSlAFKKGitGFxHM9Q0zPETNgXZFAMfvUPy3UPSqFRoAUoIInBIG+aAoC7Cdt38yJEFp2cPOoo50nA7WdmOOMw+UrBm81SVj2YHP5kL7/Q82Zq8QHRtdn7w==
Received: from PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::17)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:47:05 +0000
Received: from PH7PEPF00000005.namprd04.prod.outlook.com
 (2603:10b6:510:349:cafe::59) by PH8P221CA0061.outlook.office365.com
 (2603:10b6:510:349::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:47:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF00000005.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:47:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:46:52 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:46:40 -0800
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
Subject: [PATCH v4 27/32] gpu: nova-core: vgpu: send GSP plugin configuration parameters
Date: Fri, 6 Nov 2026 11:10:00 +0530
Message-ID: <29fa7d751924cd3911d8837566dd6fea7c3542b5.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000005:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b223d21-1673-4bfa-b97a-08df3bc96358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|261009223027099003|261102123227099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	LYzc5NDmUeGWnig9S2Sgew2X7D9YmYPVLlDIOk6dKD5mUExAzwv7HFWUNNLJynWAi1sq4W6a4YF2NMdeG16CVJMX7LPUUvfs16gn+G474Vwdlfck7AEPG0KhYrjfRX97ecNdKyMTxRr+rT7PjdLaL4v4cdH4q9Ml1Z56m6X3y6aBh00Ko9Bsnw3ukqukL+OFFkkHl9vs8WRQG4IvwP16Xw1aXpInrYyUy9pjMyfkXGyRw9NtQW94sUkJN3+dQ6Ld6RYMEvf14xH30cA9He0fp4GY3riM7YQw6H9bvBZ+mv0jikwl0Har6Y/KepOkTjx3oTqGsLSs7cYxQt0JBHSW/fqB9HJa3i/2R6KlD/ixaOksQn9edTJRn1p05cG8G6dUG7kgfuQU9nSMQ7qHGxaIBcjdJS0rsLZvvYJ67SkixNQh9IJjaaZByGcAlmZqo31lyOSI2JsqbTycuYLjp3BNj6RsVtlG1YZNjtidVZb3iQ6BnnLVYBnsjbGWUIdGrWzzW/+MFyOgmbghI7vsTnaE8ArXtKWP1ep/kWkUGxFim1LQ729EeMFNJgxu8COaUm9JXVOSTALuNHXE1BhhVlQmmhAtTxvh8au6uRiorP7TYnb5H5bXnOJ468BFroS+e+oT7glxZERL4m3yAWH6KjcDW4V6cFl7Vh4CKk0kd5uVU3lvgO+6n5GwdgOHn6kvKmIzdEnYocg6rGpE1894yml3kA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(261009223027099003)(261102123227099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+UzWl34eIJ98jNSIr2FHW4Ix8S5vR8DHoO238CghPGrtEk4AXSuQzxaZ+zJk9yGxm/P1g8kmF0Lvw3mFfTaVL8O6GLcnPG4eVFCWAIeFfFF1eKoVXga2DvFGQ7c3NBuhyuqDGzYDJdeX3VpQc4+irbOABMo/6B0qbHdnQpnp0phhpaImayPNuESA8+5eEVk7FKKNJmQWzyFeEWDGqhOM7GDUbvrUbXMiLiCPperX8NBroYLzbphDDLMuJkRbtarvroig+WnHznUvQ6zenx0326SefNtrh7SmE9L0d63NMcMwITVzlr46TvZJjyuywugFRAOtP1ZdgTNkJs9PLhV0KnIuQ3tCP5SwOvmni7Z+8MZM6Ncy6b5PDlugc7T/nqyhkEAA6vnjRi5NkzGYoOkJO7ZCk6yUL+R1wdncTdtkdty2ieZ1ReReqZUWjMPXxzGQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:47:05.0559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b223d21-1673-4bfa-b97a-08df3bc96358
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF00000005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

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
 drivers/gpu/nova-core/vgpu/fw/commands.rs    | 135 +++++++++++++++++++
 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs |  17 +++
 drivers/gpu/nova-core/vgpu/instance.rs       |  16 +++
 4 files changed, 177 insertions(+)

diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index a68841fe4019..968942273b9e 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -170,3 +170,12 @@ pub(super) fn negotiate_plugin_version(
 ) -> Result {
     rpc.rpc_call(dev, RpcMessage::VersionNegotiation, &[])
 }
+
+/// Send an instance's encoded configuration to the GSP plugin.
+pub(super) fn send_plugin_config(
+    dev: &device::Device<device::Bound>,
+    rpc: &mut PluginRpc<'_, '_>,
+    config: &[u64],
+) -> Result {
+    rpc.rpc_call_nvkv(dev, RpcMessage::SetupConfigParamsAndInit, config)
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index c3d0acece2eb..3f94435e7a59 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -9,6 +9,7 @@
 use kernel::{
     alloc::ArrayVec,
     bitfield,
+    num::casts::usize_as_u64,
     prelude::*, //
 };
 
@@ -34,6 +35,7 @@
 #[repr(u32)]
 pub(crate) enum RpcMessage {
     VersionNegotiation = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_VERSION_NEGOTIATION,
+    SetupConfigParamsAndInit = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_SETUP_CONFIG_PARAMS_AND_INIT,
 }
 
 bitfield! {
@@ -262,3 +264,136 @@ pub(crate) struct VgpuProperties {
 impl VgpuProperties {
     const STRING_LEN: usize = 64;
 }
+
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
+        uuid: Key<[u8; 16], { Self::UUID_KEY }>,
+        dbdf: Key<Dbdf, { Self::DBDF_KEY }, u32>,
+        device_instance_id: Key<u32, { Self::DEVICE_INSTANCE_ID_KEY }>,
+        vgpu_type: Key<u32, { Self::VGPU_TYPE_KEY }>,
+        vm_pid: Key<u32, { Self::VM_PID_KEY }>,
+        swizz_id: Key<SwizzId, { Self::SWIZZ_ID_KEY }, u32>,
+        num_channels: Key<u32, { Self::NUM_CHANNELS_KEY }>,
+        num_plugin_channels: Key<u32, { Self::NUM_PLUGIN_CHANNELS_KEY }>,
+        vmm_cap: Key<u32, { Self::VMM_CAP_KEY }>,
+        migration_feature: Key<MigrationFeature, { Self::MIGRATION_FEATURE_KEY }, u32>,
+        hypervisor_type: Key<HypervisorType, { Self::HYPERVISOR_TYPE_KEY }, u32>,
+        cpu_arch: Key<CpuArch, { Self::CPU_ARCH_KEY }, u32>,
+        page_size: Key<u64, { Self::PAGE_SIZE_KEY }>,
+        feature_flags: Key<FeatureFlags, { Self::FEATURE_FLAGS_KEY }, u64>,
+    }
+}
+
+impl PluginConfigParamsRequest {
+    const UUID_KEY: KeyId = 0x0001;
+    const DBDF_KEY: KeyId = 0x0002;
+    const DEVICE_INSTANCE_ID_KEY: KeyId = 0x0004;
+    const VGPU_TYPE_KEY: KeyId = 0x0005;
+    const VM_PID_KEY: KeyId = 0x0006;
+    const SWIZZ_ID_KEY: KeyId = 0x0010;
+    const NUM_CHANNELS_KEY: KeyId = 0x0011;
+    const NUM_PLUGIN_CHANNELS_KEY: KeyId = 0x0012;
+    const VMM_CAP_KEY: KeyId = 0x0020;
+    const MIGRATION_FEATURE_KEY: KeyId = 0x0021;
+    const HYPERVISOR_TYPE_KEY: KeyId = 0x0022;
+    const CPU_ARCH_KEY: KeyId = 0x0023;
+    const PAGE_SIZE_KEY: KeyId = 0x0024;
+    const FEATURE_FLAGS_KEY: KeyId = 0x0030;
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
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
index 696127c7169f..48977cd67792 100644
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
+        dev: &device::Device<device::Bound>,
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
     fn wait_response(&self, dev: &device::Device<device::Bound>, expected_sequence: u32) -> Result {
         let start = Instant::<Monotonic>::now();
         let timeout = Delta::from_secs(120);
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 445d7f513fdc..247e88bdc82f 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -34,10 +34,12 @@
         negotiate_plugin_version,
         send_bootload,
         send_cleanup,
+        send_plugin_config,
         send_shutdown,
         Dbdf, //
     },
     fw::commands::{
+        encode_plugin_config_params,
         encode_vgpu_bootload,
         BootloadInfo,
         ChannelMapEntry, //
@@ -159,6 +161,7 @@ fn activate(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
         self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
         self.plugin_rpc.init_rpc()?;
         negotiate_plugin_version(dev, &mut self.plugin_rpc)?;
+        self.configure_plugin(dev)?;
 
         Ok(())
     }
@@ -230,6 +233,19 @@ fn bootload(
         Ok(())
     }
 
+    fn configure_plugin(&mut self, dev: &device::Device<device::Bound>) -> Result {
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
     fn shutdown(&mut self, dev: &device::Device<device::Bound>, cmdq: &Cmdq<'_>) -> Result {
         if self.needs_teardown {
-- 
2.53.0

